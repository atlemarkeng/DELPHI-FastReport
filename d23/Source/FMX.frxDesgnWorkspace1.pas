
{******************************************}
{                                          }
{             FastReport v4.0              }
{           Designer workspace             }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxDesgnWorkspace1;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, System.Types, FMX.Types,
  FMX.Objects, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.frxClass,
  FMX.frxDesgn, FMX.frxDesgnWorkspace, FMX.frxPopupForm,
  System.Variants, System.UIConsts, FMX.ListBox
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF}
{$IFDEF DELPHI20}
  , System.Math.Vectors
{$ENDIF};


type
  TfrxGuideItem = class(TCollectionItem)
  public
    Left, Top, Right, Bottom: Extended;
  end;

  TfrxVirtualGuides = class(TCollection)
  private
    function GetGuides(Index: Integer): TfrxGuideItem;
  public
    constructor Create;
    procedure Add(Left, Top, Right, Bottom: Extended);
    property Items[Index: Integer]: TfrxGuideItem read GetGuides; default;
  end;

  TDesignerWorkspace = class(TfrxDesignerWorkspace)
  private
    FDesigner: TfrxDesignerForm;
    FGuide: Integer;
    FListBox: TListBox;
    FMemo: TfrxMemoView;
    FPopupForm: TfrxPopupForm;
    FPopupFormVisible: Boolean;
    FShowGuides: Boolean;
    FSimulateMove: Boolean;
    FVirtualGuides: TfrxVirtualGuides;
    FVirtualGuideObjects: TList;
    procedure DoLBClick(Sender: TObject);
    procedure DoPopupHide(Sender: TObject);
    procedure CreateVirtualGuides;
    //procedure LBDrawItem(Control: TWinControl; Index: Integer;
    //  ARect: TRect; State: TOwnerDrawState);
    procedure SetShowGuides(const Value: Boolean);
    procedure SetHGuides(const Value: TStrings);
    procedure SetVGuides(const Value: TStrings);
    function GetHGuides: TStrings;
    function GetVGuides: TStrings;
    property HGuides: TStrings read GetHGuides write SetHGuides;
    property VGuides: TStrings read GetVGuides write SetVGuides;
  protected
    procedure CheckGuides(var kx, ky: Extended; var Result: Boolean); override;
    procedure DragOver(const Data: TDragObject; const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF}); override;
    procedure DrawObjects; override;
    procedure KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Single); override;
  public
    constructor Create(AOwner: TComponent); overload; override;
    destructor Destroy; override;
    procedure DeleteObjects; override;
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); override;
    procedure SimulateMove;
    procedure SetInsertion(AClass: TfrxComponentClass;
      AWidth, AHeight: Extended; AFlag: Word); override;
    property ShowGuides: Boolean read FShowGuides write SetShowGuides;
  end;

implementation

uses
  FMX.frxFMX, FMX.frxDesgnCtrls, FMX.frxUtils, FMX.frxDataTree, FMX.frxDMPClass, FMX.frxRes, FMX.TreeView, FMX.Platform, FMX.Layouts;

type
  THackMemo = class(TfrxCustomMemoView);

function Round8(e: Extended): Extended;
begin
  Result := Round(e * 100000000) / 100000000;
end;

function ToIdent(const s: String): String;
var
  I: Integer;
begin
  Result := '';
  for i := 1 to Length(s) do
    if i = 1 then
    begin
      if CharInSet(s[i], ['A'..'Z','a'..'z','_']) then
        Result := Result + s[i]
    end
    else if CharInSet(s[i], ['A'..'Z','a'..'z','_','0'..'9']) then
      Result := Result + s[i];
  if Length(Result) < Length(s) * 2 div 3 then
    Result := 'Memo';
end;


{ TfrxVirtualGuides }

constructor TfrxVirtualGuides.Create;
begin
  inherited Create(TfrxGuideItem);
end;

procedure TfrxVirtualGuides.Add(Left, Top, Right, Bottom: Extended);
var
  Item: TfrxGuideItem;
begin
  Item := TfrxGuideItem(inherited Add);
  Item.Left := Left;
  Item.Top := Top;
  Item.Right := Right;
  Item.Bottom := Bottom;
end;

function TfrxVirtualGuides.GetGuides(Index: Integer): TfrxGuideItem;
begin
  Result := TfrxGuideItem(inherited Items[Index]);
end;


{ TDesignerWorkspace }

constructor TDesignerWorkspace.Create(AOwner: TComponent);
begin
  inherited;
  FDesigner := TfrxDesignerForm(AOwner);
  FVirtualGuides := TfrxVirtualGuides.Create;
  FVirtualGuideObjects := TList.Create;
end;

destructor TDesignerWorkspace.Destroy;
begin
  FVirtualGuides.Free;
  FVirtualGuideObjects.Free;
  inherited;
end;

procedure TDesignerWorkspace.DeleteObjects;
var
  i: Integer;
  NeedReload: Boolean;
begin
  NeedReload := False;
  for i := 0 to FSelectedObjects.Count - 1 do
    if TObject(FSelectedObjects[i]) is TfrxSubreport then
      NeedReload := True;

  FMemo := nil;
  inherited;

  if NeedReload then
    FDesigner.ReloadPages(FDesigner.Report.Objects.IndexOf(Page));
end;

procedure TDesignerWorkspace.SetInsertion(AClass: TfrxComponentClass;
  AWidth, AHeight: Extended; AFlag: Word);
begin
  inherited;
  CreateVirtualGuides;
end;

procedure TDesignerWorkspace.DrawObjects;
var
  r: TRect;
  i, d: Integer;
  poly: TPolygon;
begin
  if FDesigner.Page is TfrxReportPage then
    with TfrxReportPage(FDesigner.Page) do
      if Columns > 1 then
        for i := 0 to Columns - 1 do
        begin
          d := Round(frxStrToFloat(ColumnPositions[i]) * fr01cm * FScale);
          if d = 0 then continue;
          FCanvas.Stroke.Color := claSilver;
          FCanvas.DrawLine(PointF(d, 0), PointF(d, Self.Height), 1);
        end;

  if FShowGuides and (FPage is TfrxReportPage) then
  begin
    with FCanvas do
    begin
      StrokeThickness := 1;
      Stroke.Kind := TBrushKind.bkSolid;
      Stroke.Color := $FFFFCC00;
      //Pen.Mode := pmCopy;
    end;

    for i := 0 to HGuides.Count - 1 do
    begin
      d := Round(frxStrToFloat(HGuides[i]) * Scale);
      FCanvas.DrawLine(PointF(0, d), PointF(Width, d), 1);
    end;

    for i := 0 to VGuides.Count - 1 do
    begin
      d := Round(frxStrToFloat(VGuides[i]) * Scale);
      FCanvas.DrawLine(PointF(d, 0), PointF(d, Height), 1);
    end;
  end;

  inherited;

  if (FMemo <> nil) and FDesigner.DropFields then
    with FCanvas do
    begin
      r.TopLeft := Point(Round((FMemo.Left + FMemo.Width) * FScale) - 16,
                         Round((FMemo.AbsTop) * FScale) + 2);
      r.BottomRight := Point(r.Left + 16, r.Top + 16);
      //DrawButtonFace(FCanvas, r, 1, bsNew, False, False, False);
      //todo
      Fill.Color := claBlack;
      Fill.Kind := TBrushKind.bkSolid;
      Stroke.Color := claBlack;
      Stroke.Kind := TBrushKind.bkSolid;
      SetLength(poly, 4);
      poly[0] := PointF(r.Left + 4, r.Top + 6);
      poly[1] := PointF(r.Left + 7, r.Top + 9);
      poly[2] := PointF(r.Left + 10, r.Top + 6);
      poly[3] := PointF(r.Left + 4, r.Top + 6);
      FCanvas.DrawPolygon(poly, 1);
    end;


  if FVirtualGuides.Count > 0 then
  begin
    if FMouseDown or (FMode1 = dmInsertObject) or (FMode1 = dmInsertLine) then
      with FCanvas do
      begin
        StrokeThickness := 1;
        Stroke.Kind := TBrushKind.bkSolid;
        Stroke.Color := $FFFFCC00;
        for i := 0 to FVirtualGuides.Count - 1 do
        begin
          FCanvas.DrawLine(
            PointF(Round(FVirtualGuides[i].Left * Scale) + 0.5, Round(FVirtualGuides[i].Top * Scale) + 0.5),
            PointF(Round(FVirtualGuides[i].Right * Scale) + 0.5, Round(FVirtualGuides[i].Bottom * Scale) + 0.5), 1);
        end;
      end;
    FVirtualGuides.Clear;
  end;
end;

procedure TDesignerWorkspace.DragOver(const Data: TDragObject; const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF});
var
  ds: TfrxDataset;
  s, fld: String;
  w: Integer;
  X, Y: Single;
{$IFDEF DELPHI20}
  Accept: Boolean;
{$ENDIF}
begin
  Accept := ((FDesigner.CheckOp(drDontInsertObject) and
    (Data.Source is TTreeView) and
    (TTreeView(Data.Source).Owner = FDesigner.DataTree) and
    (FDesigner.DataTree.GetFieldName <> '')) or
    ((Data.Source is TfrxRuler) and FDesigner.ShowGuides)) and (FDesigner.Page is TfrxReportPage);
  if not Accept then Exit;
{$IFDEF DELPHI20}
  Operation := TDragOperation.Copy;
{$ENDIF}  
  FMode := dmDrag;
  if Data.Source is TfrxRuler then
    with Canvas do
    begin
      StrokeThickness := 1;
      Stroke.Kind := TBrushKind.bkSolid;
      Stroke.Color := claBlack;
      Repaint;

      if GridAlign then
      begin
        X := Round(Trunc(Point.X / (GridX * Scale)) * GridX * Scale);
        Y := Round(Trunc(Point.Y / (GridY * Scale)) * GridY * Scale);
      end
      else
      begin
        X := Point.X;
        Y := Point.Y;
      end;

      if TfrxRuler(Data.Source).Align = TAlignLayout.alLeft then
        DrawLine(PointF(X, 0), PointF(X, Self.Height), 1)
      else
        DrawLine(PointF(0, Y), PointF(Self.Width, Y), 1);

      MouseMove([], X, Y);
    end
  else
  begin
    if (FInsertion.ComponentClass = nil) and
      (FDesigner.DataTree.InsFieldCB.IsChecked or
      FDesigner.DataTree.InsCaptionCB.IsChecked or
      not FDesigner.DataTree.IsDataField) then
    begin
      s := FDesigner.DataTree.GetFieldName;
      s := Copy(s, 2, Length(s) - 2);
      FDesigner.Report.GetDatasetAndField(s, ds, fld);
      try
        if (ds <> nil) and (fld <> '') then
          w := ds.DisplayWidth[fld] else
          w := 10;
      except
        w := 10;
      end;

      if w > 50 then
        w := 50;

      SetInsertion(TfrxMemoView, Round(w * 8 / GridX) * GridX,
        FDesigner.GetDefaultObjectSize.Y, 0);
    end;
    MouseMove([], Point.X,  Point.Y);
  end;
end;

procedure TDesignerWorkspace.DragDrop(const Data: TDragObject; const Point: TPointF);
var
  eX, eY: Extended;
  m: TfrxCustomMemoView;
  ds: TfrxDataset;
  s, fld: String;
begin
  if (Data.Source is TfrxRuler) and (FPage is TfrxReportPage) then
  begin
    if GridAlign then
    begin
      eX := Trunc(Point.X / Scale / GridX) * GridX;
      eY := Trunc(Point.Y / Scale / GridY) * GridY;
    end
    else
    begin
      eX := Point.X / Scale;
      eY := Point.Y / Scale;
    end;

    eX := Round8(eX);
    eY := Round8(eY);

    if TfrxRuler(Data.Source).Align = TAlignLayout.alLeft then
      VGuides.Add(FloatToStr(eX)) else
      HGuides.Add(FloatToStr(eY));
    FMode := dmSelect;
  end
  else if (FDesigner.DataTree.InsFieldCB.IsChecked or
    FDesigner.DataTree.InsCaptionCB.IsChecked or
    not FDesigner.DataTree.IsDataField) then
  begin
    FSelectedObjects.Clear;

    if Page is TfrxDMPPage then
      m := TfrxDMPMemoView.Create(Page)
    else
      m := TfrxMemoView.Create(Page);
    s := ToIdent(FDesigner.DataTree.GetFieldName);
    if (s <> 'Memo') and (FDesigner.Report.FindObject(s) = nil) then
      m.Name := s
    else
    begin
      THackMemo(m).FBaseName := s;
      m.CreateUniqueName;
    end;
    m.IsDesigning := True;
    s := FDesigner.DataTree.GetFieldName;
    s := Copy(s, 2, Length(s) - 2);
    FDesigner.Report.GetDataSetAndField(s, ds, fld);

    if not FDesigner.DataTree.IsDataField or FDesigner.DataTree.InsFieldCB.IsChecked then
    begin
      m.DataSet := ds;
      m.DataField := fld;
      if (ds = nil) and (fld = '') then
      begin
        if Pos('<', FDesigner.DataTree.GetFieldName) = 1 then
          m.Text := '[' + s + ']' else
          m.Text := '[' + FDesigner.DataTree.GetFieldName + ']';
      end;
      m.SetBounds(Round8(FInsertion.Left), Round8(FInsertion.Top),
        Round8(FInsertion.Width), Round8(FInsertion.Height));
      FDesigner.SampleFormat.ApplySample(m);
      FObjects.Add(m);
      FSelectedObjects.Add(m);
      FInsertion.Top := FInsertion.Top - FInsertion.Height;
    end
    else
      m.Free;
    if FDesigner.DataTree.IsDataField and FDesigner.DataTree.InsCaptionCB.IsChecked then
    begin
      if Page is TfrxDMPPage then
        m := TfrxDMPMemoView.Create(Page) else
        m := TfrxMemoView.Create(Page);
      m.CreateUniqueName;
      m.IsDesigning := True;
      m.Text := fld;
      m.SetBounds(Round8(FInsertion.Left), Round8(FInsertion.Top),
        Round8(FInsertion.Width), Round8(FInsertion.Height));
      FDesigner.SampleFormat.ApplySample(m);
      FObjects.Add(m);
      FSelectedObjects.Add(m);
    end;

    if (frxDesignerComp <> nil) and Assigned(frxDesignerComp.OnInsertObject) then
      frxDesignerComp.OnInsertObject(m);
    SetInsertion(nil, 0, 0, 0);
  end;

  FModifyFlag := True;
  MouseUp(TMouseButton.mbLeft, [], Point.X,  Point.Y);
  SelectionChanged;
end;

procedure TDesignerWorkspace.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
var
  ds: TfrxDataset;
  r: TRectF;
  p: TPointF;

  function Contain(c: TfrxComponent): Boolean;
  begin
    Result := (X / FScale >= c.Left + c.Width - 16) and (X / FScale <= c.Left + c.Width) and
      (Y / FScale >= c.AbsTop) and (Y / FScale <= c.AbsTop + 16);
  end;

begin
  if FDisableUpdate then Exit;

  if (FMode = dmSelect) and (FMemo <> nil) and Contain(FMemo) and FDesigner.DropFields then
  begin
    FPopupForm := TfrxPopupForm.Create(Self);
    FPopupForm.OnDestroy := DoPopupHide;
    FListBox := TListBox.Create(FPopupForm);
    with FListBox do
    begin
      Parent := FPopupForm;
      //Ctl3D := False;
      Align := TAlignLayout.alClient;
      //Style := lbOwnerDrawFixed;
      ItemHeight := 16;
      OnClick := DoLBClick;
      //OnDrawItem := LBDrawItem;
      r.Top := Round(FMemo.AbsTop * FScale) + 18;
      r.Right := Round((FMemo.Left + FMemo.Width) * FScale);
      r.Left := r.Right - 140;
      r.Bottom := r.Top + 162;

      if r.Left < 0 then
      begin
        r.Right := r.Right - r.Left;
        r.Left := 0;
      end;

      p := GetComponentForm(Self).ClientToScreen(r.TopLeft);
      FPopupForm.SetBounds(p.Round.X, p.Round.Y, r.Round.Right - r.Round.Left, r.Round.Bottom - r.Round.Top);

      ds := TfrxDataBand(FMemo.Parent).Dataset;
      if ds <> nil then
      begin
        ds.GetFieldList(Items);
        ItemIndex := Items.IndexOf(FMemo.DataField);
        FPopupForm.Show;
        FPopupFormVisible := True;
      end;
    end;

    FMode1 := dmNone;
    FMouseDown := False;
    Exit;
  end;

  inherited;

  CreateVirtualGuides;
end;

procedure TDesignerWorkspace.MouseMove(Shift: TShiftState; X, Y: Single);
var
  i, px, py: Integer;
  c, cOver: TfrxComponent;
  ds: TfrxDataset;
  e, kx, ky: Extended;

  function Contain(c: TfrxComponent): Boolean;
  begin
    Result := (X / FScale >= c.Left) and (X / FScale <= c.Left + c.Width - 4) and
      (Y / FScale >= c.AbsTop) and (Y / FScale <= c.AbsTop + c.Height);
  end;

  function GridCheck: Boolean;
  begin
    Result := (kx >= GridX) or (kx <= -GridX) or
              (ky >= GridY) or (ky <= -GridY);
    if Result then
    begin
      kx := Trunc(kx / GridX) * GridX;
      ky := Trunc(ky / GridY) * GridY;
    end;
  end;

begin
  if FDisableUpdate then Exit;
  inherited;

  if not FMouseDown and (FMode = dmSelect) and
    ((FMode1 = dmNone) or (FMode1 = dmMoveGuide)) and not FPopupFormVisible then
  begin
    if FPage is TfrxReportPage then
    begin
      for i := 0 to HGuides.Count - 1 do
      begin
        e := frxStrToFloat(HGuides[i]);
        if (Y / Scale > e - 5) and (Y / Scale < e + 5) then
        begin
          FMode1 := dmMoveGuide;
          Cursor := crVSplit;
          FGuide := i;
        end;
      end;

      for i := 0 to VGuides.Count - 1 do
      begin
        e := frxStrToFloat(VGuides[i]);
        if (X / Scale > e - 5) and (X / Scale < e + 5) then
        begin
          FMode1 := dmMoveGuide;
          Cursor := crHSplit;
          FGuide := i;
        end;
      end;
    end;

    if FMode1 = dmNone then
    begin
      cOver := nil;
      for i := FObjects.Count - 1 downto 0 do
      begin
        c := FObjects[i];
        if (c is TfrxMemoView) and Contain(c) and
           (c.Parent is TfrxDataBand) and
           (TfrxDataBand(c.Parent).Dataset <> nil) and
           (TfrxDataBand(c.Parent).Dataset.FieldsCount > 0) then
        begin
          ds := TfrxDataBand(c.Parent).Dataset;
          if ds <> nil then
            cOver := c;
          break;
        end;
      end;

      if FMemo <> cOver then
      begin
        FMemo := TfrxMemoView(cOver);
        Repaint;
      end;
    end;
  end;

// moving the guideline
  if FMouseDown and (FMode1 = dmMoveGuide) then
  begin
    if Cursor = crHSplit then
    begin
      e := frxStrToFloat(VGuides[FGuide]);
      kx := X / Scale - FLastMousePointX;
      ky := 0;

      if not (GridAlign and not GridCheck) then
      begin
        FModifyFlag := True;
        e := Round((e + kx) * 100000000) / 100000000;
        FLastMousePointX := FLastMousePointX + kx;
      end;

      VGuides[FGuide] := FloatToStr(e);
    end
    else
    begin
      e := frxStrToFloat(HGuides[FGuide]);
      kx := 0;
      ky := Y / Scale - FLastMousePointY;

      if not (GridAlign and not GridCheck) then
      begin
        FModifyFlag := True;
        e := Round((e + ky) * 100000000) / 100000000;
        FLastMousePointY := FLastMousePointY + ky;
      end;

      HGuides[FGuide] := FloatToStr(e);
    end;

    Repaint;
  end;
end;

procedure TDesignerWorkspace.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  e: Extended;
begin
  if FDisableUpdate then Exit;
  FSimulateMove := False;
  FVirtualGuideObjects.Clear;

  if FMode1 = dmMoveGuide then
  begin
    if Cursor = crHSplit then
    begin
      e := frxStrToFloat(VGuides[FGuide]);
      if (e < 3) or (e > (Width / Scale) - 3) then
        VGuides.Delete(FGuide);
    end
    else
    begin
      e := frxStrToFloat(HGuides[FGuide]);
      if (e < 3) or (e > (Height / Scale) - 3) then
        HGuides.Delete(FGuide);
    end;

    Repaint;
  end;

  inherited;
end;

procedure TDesignerWorkspace.KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if (Key = VKESCAPE) and FSimulateMove then
  begin
    Key := VKDELETE;
    MouseUp(TMouseButton.mbLeft, [], 0, 0);
  end;
  inherited;
end;

procedure TDesignerWorkspace.SimulateMove;
var
  r: TfrxRect;
begin
  FMode1 := dmMove;
  r := GetSelectionBounds;
  MouseDown(TMouseButton.mbLeft, [], Round(r.Left / Scale) + 20, Round(r.Top / Scale) + 20);
  FSimulateMove := True;
end;

procedure TDesignerWorkspace.CreateVirtualGuides;
var
  i: Integer;
begin
  FVirtualGuideObjects.Clear;
  for i := 0 to Objects.Count - 1 do
    FVirtualGuideObjects.Add(Objects[i]);
end;

procedure TDesignerWorkspace.DoLBClick(Sender: TObject);
begin
  if FMemo <> nil then
  begin
    FMemo.DataSet := TfrxDataBand(FMemo.Parent).Dataset;
    FMemo.DataField := FListBox.Items[FListBox.ItemIndex];
  end;
  FPopupForm.Hide;

  FModifyFlag := True;
  DoModify;
end;

procedure TDesignerWorkspace.DoPopupHide(Sender: TObject);
begin
  FPopupFormVisible := False;
end;

//procedure TDesignerWorkspace.LBDrawItem(Control: TWinControl; Index: Integer;
//  ARect: TRect; State: TOwnerDrawState);
//begin
//  with FListBox do
//  begin
//    Canvas.FillRect(ARect);
//    frxResources.MainButtonImages.Draw(Canvas, ARect.Left, ARect.Top, 54);
//    Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
//  end;
//end;

procedure TDesignerWorkspace.CheckGuides(var kx, ky: Extended;
  var Result: Boolean);
var
  i: Integer;
  c: TfrxComponent;

  procedure CheckH(coord: Extended);
  var
    i: Integer;
    e: Extended;
  begin
    if FPage is TfrxReportPage then
      for i := 0 to HGuides.Count - 1 do
      begin
        e := frxStrToFloat(HGuides[i]);
        if Abs(coord + ky - e) < 6 then
        begin
          ky := e - coord;
          break;
        end;
      end;
  end;

  procedure CheckV(coord: Extended);
  var
    i: Integer;
    e: Extended;
  begin
    if FPage is TfrxReportPage then
      for i := 0 to VGuides.Count - 1 do
      begin
        e := frxStrToFloat(VGuides[i]);
        if Abs(coord + kx - e) < 6 then
        begin
          kx := e - coord;
          break;
        end;
      end;
  end;

  procedure CheckHH(Left, Top: Extended; Obj: TfrxComponent);
  var
    i: Integer;
    c: TfrxComponent;
    e: Extended;
  begin
    for i := 0 to FVirtualGuideObjects.Count - 1 do
    begin
      c := FVirtualGuideObjects[i];
      if c = Obj then continue;
      e := c.AbsTop;
      if Abs(Top + ky - e) < 0.001 then
        FVirtualGuides.Add(Left, e, c.AbsLeft, e);
      e := c.AbsTop + c.Height;
      if Abs(Top + ky - e) < 0.001 then
        FVirtualGuides.Add(Left, e, c.AbsLeft, e);
    end;
  end;

  procedure CheckVV(Left, Top: Extended; Obj: TfrxComponent);
  var
    i: Integer;
    c: TfrxComponent;
    e: Extended;
  begin
    for i := 0 to FVirtualGuideObjects.Count - 1 do
    begin
      c := FVirtualGuideObjects[i];
      if c = Obj then continue;
      e := c.AbsLeft;
      if Abs(Left + kx - e) < 0.001 then
        FVirtualGuides.Add(e, c.AbsTop, e, Top);
      e := c.AbsLeft + c.Width;
      if Abs(Left + kx - e) < 0.001 then
        FVirtualGuides.Add(e, c.AbsTop, e, Top);
    end;
  end;

begin
  if not FShowGuides then Exit;

  FVirtualGuides.Clear;

  if FMouseDown and (FMode1 = dmSizeBand) then
    CheckH(FSizedBand.Top + FSizedBand.Height);

  if not FMouseDown and ((FMode1 = dmInsertObject) or (FMode1 = dmInsertLine)) then
  begin
    CheckV(FInsertion.Left);
    CheckH(FInsertion.Top);
    CheckVV(FInsertion.Left, FInsertion.Top, nil);
    CheckHH(FInsertion.Left, FInsertion.Top, nil);
    CheckV(FInsertion.Left + FInsertion.Width);
    CheckH(FInsertion.Top + FInsertion.Height);
    CheckVV(FInsertion.Left + FInsertion.Width, FInsertion.Top, nil);
    CheckHH(FInsertion.Left, FInsertion.Top + FInsertion.Height, nil);
  end;

  if FMouseDown and ((FMode1 = dmInsertObject) or (FMode1 = dmInsertLine)) then
  begin
    CheckV(FInsertion.Left);
    CheckH(FInsertion.Top);
    CheckVV(FInsertion.Left, FInsertion.Top, nil);
    CheckHH(FInsertion.Left, FInsertion.Top, nil);
  end;

  if FMouseDown and (FMode1 = dmMove) then
    for i := 0 to SelectedCount - 1 do
    begin
      c := FSelectedObjects[i];
      CheckV(c.Left);
      CheckVV(c.AbsLeft, c.AbsTop, c);
      CheckHH(c.AbsLeft, c.AbsTop, c);
      CheckH(c.AbsTop);
      CheckH(c.Top);
      CheckV(c.Left + c.Width);
      CheckVV(c.AbsLeft + c.Width, c.AbsTop, c);
      CheckHH(c.AbsLeft, c.AbsTop + c.Height, c);
      CheckH(c.AbsTop + c.Height);
    end;

  if FMouseDown and (FMode1 = dmSize) then
  begin
    c := FSelectedObjects[0];
    if FCT in [ct1, ct6, ct4] then
    begin
      CheckV(c.Left);
      CheckVV(c.AbsLeft, c.AbsTop, c);
    end;
    if FCT in [ct1, ct7, ct3] then
    begin
      CheckH(c.AbsTop);
      CheckHH(c.AbsLeft, c.AbsTop, c);
    end;
    if FCT in [ct3, ct5, ct2] then
    begin
      CheckV(c.Left + c.Width);
      CheckVV(c.AbsLeft + c.Width, c.AbsTop, c);
    end;
    if FCT in [ct4, ct8, ct2] then
    begin
      CheckH(c.AbsTop + c.Height);
      CheckHH(c.AbsLeft, c.AbsTop + c.Height, c);
    end;
  end;
end;

procedure TDesignerWorkspace.SetShowGuides(const Value: Boolean);
begin
  FShowGuides := Value;
  Repaint;
  //Invalidate;
end;

function TDesignerWorkspace.GetHGuides: TStrings;
begin
  Result := TfrxReportPage(FPage).HGuides;
end;

function TDesignerWorkspace.GetVGuides: TStrings;
begin
  Result := TfrxReportPage(FPage).VGuides;
end;

procedure TDesignerWorkspace.SetHGuides(const Value: TStrings);
begin
  TfrxReportPage(FPage).HGuides := Value;
end;

procedure TDesignerWorkspace.SetVGuides(const Value: TStrings);
begin
  TfrxReportPage(FPage).VGuides := Value;
end;

end.


//56db3b0f55102b9488a240d37950543f