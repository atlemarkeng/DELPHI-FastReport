
{******************************************}
{                                          }
{             FastReport v4.0              }
{             Object Inspector             }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxInsp;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Controls, FMX.Forms,
  FMX.Dialogs, FMX.ExtCtrls, FMX.frxDsgnIntf, System.Types, System.UIConsts,
  FMX.frxClass, FMX.Menus, FMX.Types, FMX.Edit, FMX.Objects, FMX.Layouts,
  FMX.ListBox, FMX.TabControl, FMX.Platform, System.Variants, FMX.TreeView
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};


type
  TfrxObjectInspector = class(TForm)
    PopupMenu1: TPopupMenu;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    N51: TMenuItem;
    N61: TMenuItem;
    MainPanel: TPanel;
    BackPanel: TPanel;
    Splitter1: TSplitter;
    Box: TFramedScrollBox;
    PB: TPaintBox;
    Edit1: TEdit;
    EditPanel: TPanel;
    EditBtn: TSpeedButton;
    ComboPanel: TPanel;
    ComboBtn: TSpeedButton;
    HintPanel: TPanel;
    PropL: TLabel;
    DescrL: TLabel;
    ObjectsCB: TComboBox;
    Label1: TLabel;
    Rectangle1: TRectangle;
    StyleBook1: TStyleBook;
    procedure FormResize(Sender: TObject);
    procedure PBPaint(Sender: TObject; Canvas: TCanvas);
    procedure PBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure PBMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure PBMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Single);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
    procedure EditBtnClick(Sender: TObject);
    procedure ComboBtnClick(Sender: TObject);
    procedure ObjectsCBClick(Sender: TObject);
    procedure PBDblClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure TabChange(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
  private
    { Private declarations }
    FDesigner: TfrxCustomDesigner;
    FDisableDblClick: Boolean;
    FDisableUpdate: Boolean;
    FDown: Boolean;
    FEventList: TfrxPropertyList;
    //FHintWindow: THintWindow; todo
    FItemIndex: Integer;
    FLastPosition: String;
    FList: TfrxPropertyList;
    FPopupForm: TPopup;
    FPopupLB: TListBox;
//    FPopupLBVisible: Boolean;
    FPropertyList: TfrxPropertyList;
    FPanel: TPanel;
    FRowHeight: Single;
    FSelectedObjects: TList;
    FSplitterPos: Single;
    FTabs: TTabControl;
    FTempList: TList;
    FUpdatingObjectsCB: Boolean;
    FUpdatingPB: Boolean;
    FOnSelectionChanged: TNotifyEvent;
    FOnModify: TNotifyEvent;
//    FPopupCloseTime: Extended;
    FFastCanvas: TCanvas;
    function Count: Integer;
    function GetItem(Index: Integer): TfrxPropertyItem;
    function GetName(Index: Integer): String;
    function GetOffset(Index: Integer): Integer;
    function GetType(Index: Integer): TfrxPropertyAttributes;
    function GetValue(Index: Integer): String;
    procedure AdjustControls;
    procedure DrawOneLine(Canvas: TCanvas; i: Integer; Selected: Boolean);
    procedure DoModify;
    procedure SetObjects(Value: TList);
    procedure SetItemIndex(Value: Integer);
    procedure SetSelectedObjects(Value: TList);
    procedure SetValue(Index: Integer; Value: String);
    procedure LBClick(Sender: TObject);
    procedure ClosePopup(Sender: TObject);
    function GetSplitter1Pos: Integer;
    procedure SetSplitter1Pos(const Value: Integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DisableUpdate;
    procedure EnableUpdate;
    procedure Inspect(AObjects: array of TPersistent);
    procedure UpdateProperties;
    procedure DoResize;
    property Objects: TList write SetObjects;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property SelectedObjects: TList read FSelectedObjects write SetSelectedObjects;
    property SplitterPos: Single read FSplitterPos write FSplitterPos;
    property Splitter1Pos: Integer read GetSplitter1Pos write SetSplitter1Pos;
    property OnModify: TNotifyEvent read FOnModify write FOnModify;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
    property FastCanvas: TCanvas read FFastCanvas write FFastCanvas;
  end;


implementation
{$IFDEF DELPHI23}
{$R FMX.frxInsp_D23.FMX}
{$ELSE}
{$R *.FMX}
{$ENDIF}

uses FMX.frxFMX, FMX.frxUtils, FMX.frxRes, FMX.frxrcInsp;
{ TfrxObjectInspector }

constructor TfrxObjectInspector.Create(AOwner: TComponent);
var
  aTab: TTabItem;
begin
  inherited Create(AOwner);
  FItemIndex := -1;
  FTempList := TList.Create;
  FDesigner := TfrxCustomDesigner(AOwner);
  Box.ShowScrollBars := True;
{$IFNDEF MSWINDOWS}
 {$IFDEF DELPHI18}
  Box.AutoHide := false;
 {$ENDIF}
{$ENDIF}
{$IFDEF DELPHI19}
  Box.AniCalculations.AutoShowing := false;
{$ENDIF}
  FPanel := TPanel.Create(Self);
  FPanel.StyleLookup := 'backgroundstyle';
  FPanel.Parent := Box;
  PB.Parent := FPanel;
  ComboPanel.Parent := FPanel;
  EditPanel.Parent := FPanel;
  Edit1.Parent := FPanel;
  Edit1.Font.Size := 11;

  FRowHeight := Round(Canvas.TextHeight('Wg') + 3);

  MainPanel.StyleLookup := 'backgroundstyle';
  BackPanel.StyleLookup := 'backgroundstyle';
  FTabs := TTabControl.Create(Self);
  FTabs.OnChange := TabChange;
  FTabs.Parent := MainPanel;
{$IFDEF Delphi17}
  FTabs.TabHeight := 21;
{$ENDIF}

  aTab := TTabItem.Create(Self);
  aTab.Text := frxResources.Get('oiProp');
  FTabs.AddObject(aTab);
  aTab := TTabItem.Create(Self);
  aTab.Text := frxResources.Get('oiEvent');
  FTabs.AddObject(aTab);
  FTabs.TabIndex := 0;

  FSplitterPos := Round(PB.Width) div 2;

  FPopupForm := TPopup.Create(Self);
  FPopupForm.Placement := TPlacement.plAbsolute;
  FPopupForm.Parent := Self;
  FPopupForm.OnClosePopup := ClosePopup;

  FPopupLB := TListBox.Create(FPopupForm);
  with FPopupLB do
  begin
    Parent := FPopupForm;
    Align := TAlignLayout.alClient;
    ItemHeight := FRowHeight;
    OnClick := LBClick;
  end;
  FormResize(nil);

  Label1.Text := frxGet(2000);
end;

destructor TfrxObjectInspector.Destroy;
begin
  FTempList.Free;
  if FPropertyList <> nil then
    FPropertyList.Free;
  if FEventList <> nil then
    FEventList.Free;
  inherited;
end;

procedure TfrxObjectInspector.UpdateProperties;
begin
  SetSelectedObjects(FSelectedObjects);
end;

procedure TfrxObjectInspector.Inspect(AObjects: array of TPersistent);
var
  i: Integer;
begin
  FTempList.Clear;
  for i := Low(AObjects) to High(AObjects) do
    FTempList.Add(AObjects[i]);
  Objects := FTempList;
  SelectedObjects := FTempList;
end;

function TfrxObjectInspector.GetSplitter1Pos: Integer;
begin
  Result := Round(HintPanel.Height);
end;

procedure TfrxObjectInspector.SetSplitter1Pos(const Value: Integer);
begin
  HintPanel.Height := Value;
end;

procedure TfrxObjectInspector.DisableUpdate;
begin
  FDisableUpdate := True;
end;

procedure TfrxObjectInspector.EnableUpdate;
begin
  FDisableUpdate := False;
end;

procedure TfrxObjectInspector.SetObjects(Value: TList);
var
  i: Integer;
  s: String;
begin
  ObjectsCB.BeginUpdate;
{$IFDEF DELPHI23}
  ObjectsCB.Clear;
{$ELSE}
  ObjectsCB.Items.Clear;
{$ENDIF}
  for i := 0 to Value.Count - 1 do
  begin
    if TObject(Value[i]) is TComponent then
      s := TComponent(Value[i]).Name + ': ' + TComponent(Value[i]).ClassName else
      s := '';
    ObjectsCB.Items.AddObject(s, Value[i]);
  end;
  ObjectsCB.EndUpdate;
end;

procedure TfrxObjectInspector.SetSelectedObjects(Value: TList);
var
  i: Integer;
  s: String;

  procedure CreateLists;
  var
    i: Integer;
    p: TfrxPropertyItem;
    s: String;
  begin
    if FPropertyList <> nil then
      FPropertyList.Free;
    if FEventList <> nil then
      FEventList.Free;
    FEventList := nil;

    FPropertyList := frxCreatePropertyList(Value, FDesigner);
    if FPropertyList <> nil then
    begin
      FEventList := TfrxPropertyList.Create(FDesigner);

      i := 0;
      while i < FPropertyList.Count do
      begin
        p := FPropertyList[i];
        s := String(p.Editor.PropInfo.PropType^.Name);
        if (Pos('Tfrx', s) = 1) and (Pos('Event', s) = Length(s) - 4) then
          p.Collection := FEventList else
          Inc(i);
      end;
    end;

    if FTabs.TabIndex = 0 then
      FList := FPropertyList else
      FList := FEventList;
  end;

begin
  FSelectedObjects := Value;
  CreateLists;

  FUpdatingObjectsCB := True;
  if FSelectedObjects.Count = 1 then
  begin
    ObjectsCB.ItemIndex := ObjectsCB.Items.IndexOfObject(FSelectedObjects[0]);
    if ObjectsCB.ItemIndex = -1 then
    begin
      s := TComponent(FSelectedObjects[0]).Name  + ': ' +
        TComponent(FSelectedObjects[0]).ClassName;
      ObjectsCB.BeginUpdate;
      ObjectsCB.Items.AddObject(s, FSelectedObjects[0]);
      ObjectsCB.EndUpdate;
      ObjectsCB.ItemIndex := ObjectsCB.Items.IndexOfObject(FSelectedObjects[0]);
    end;
  end
  else
    ObjectsCB.ItemIndex := -1;
  FUpdatingObjectsCB := False;

  FItemIndex := -1;
  FormResize(nil);
  if Count > 0 then
  begin
    for i := 0 to Count - 1 do
      if GetName(i) = FLastPosition then
      begin
        ItemIndex := i;
        Exit;
      end;
    s := FLastPosition;
    ItemIndex := 0;
    FLastPosition := s;
  end;
end;

function TfrxObjectInspector.Count: Integer;

  function EnumProperties(p: TfrxPropertyList): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 0 to p.Count - 1 do
    begin
      Inc(Result);
      if (p[i].SubProperty <> nil) and p[i].Expanded then
        Inc(Result, EnumProperties(p[i].SubProperty));
    end;
  end;

begin
  if FList <> nil then
    Result := EnumProperties(FList) else
    Result := 0;
end;

function TfrxObjectInspector.GetItem(Index: Integer): TfrxPropertyItem;

  function EnumProperties(p: TfrxPropertyList; var Index: Integer): TfrxPropertyItem;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to p.Count - 1 do
    begin
      Dec(Index);
      if Index < 0 then
      begin
        Result := p[i];
        break;
      end;
      if (p[i].SubProperty <> nil) and p[i].Expanded then
        Result := EnumProperties(p[i].SubProperty, Index);
      if Index < 0 then
        break;
    end;
  end;

begin
  if (Index >= 0) and (Index < Count) then
    Result := EnumProperties(FList, Index) else
    Result := nil;
end;

function TfrxObjectInspector.GetOffset(Index: Integer): Integer;
var
  p: TfrxPropertyList;
begin
  Result := 0;
  p := TfrxPropertyList(GetItem(Index).Collection);
  while p.Parent <> nil do
  begin
    Inc(Result);
    p := p.Parent;
  end;
end;

function TfrxObjectInspector.GetName(Index: Integer): String;
begin
  Result := GetItem(Index).Editor.GetName;
end;

function TfrxObjectInspector.GetType(Index: Integer): TfrxPropertyAttributes;
begin
  Result := GetItem(Index).Editor.GetAttributes;
end;

function TfrxObjectInspector.GetValue(Index: Integer): String;
begin
  Result := GetItem(Index).Editor.Value;
end;

procedure TfrxObjectInspector.DoModify;
var
  i: Integer;
begin
  if FSelectedObjects.Count = 1 then
  begin
    i := ObjectsCB.Items.IndexOfObject(FSelectedObjects[0]);
    if TObject(FSelectedObjects[0]) is TComponent then
      ObjectsCB.Items.Strings[i] := TComponent(FSelectedObjects[0]).Name + ': ' +
        TComponent(FSelectedObjects[0]).ClassName;
    ObjectsCB.ItemIndex := ObjectsCB.Items.IndexOfObject(FSelectedObjects[0]);
  end;

  if Assigned(FOnModify) then
    FOnModify(Self);
end;

procedure TfrxObjectInspector.DoResize;
begin
  FormResize(Self);
end;

procedure TfrxObjectInspector.SetItemIndex(Value: Integer);
var
  p: TfrxPropertyItem;
  s: String;
begin
  PropL.Text := '';
  DescrL.Text := '';
  if Value > Count - 1 then
    Value := Count - 1;
  if Value < 0 then
    Value := -1;

  Edit1.Visible := Count > 0;
  if Count = 0 then Exit;

  if FItemIndex <> -1 then
    if Edit1.Typing then
    begin
      Edit1.Typing := False;
      SetValue(FItemIndex, Edit1.Text);
    end;
  FItemIndex := Value;

  if FItemIndex <> -1 then
  begin
    FLastPosition := GetName(FItemIndex);
    p := GetItem(FItemIndex);
    s := GetName(FItemIndex);
    PropL.Text := s;
    if TfrxPropertyList(p.Collection).Component <> nil then
    begin
      s := 'prop' + s + '.' + TfrxPropertyList(p.Collection).Component.ClassName;
      if frxResources.Get(s) = s then
        s := frxResources.Get('prop' + GetName(FItemIndex)) else
        s := frxResources.Get(s);
      DescrL.Text := s;
    end;
  end;

  AdjustControls;
end;

procedure TfrxObjectInspector.SetValue(Index: Integer; Value: String);
var
  pItem: TfrxPropertyItem;
  vIdx: Integer;
begin
  pItem := GetItem(Index);
  try
    if True then
    begin
      if paValueList in pItem.Editor.GetAttributes then
      begin
        pItem.Editor.GetValues;
        vIdx := pItem.Editor.Values.IndexOf(Value);
        if vIdx <> -1 then
          Value := pItem.Editor.Values[vIdx];
      end;
      pItem.Editor.Value := Value;
    end;
    DoModify;
    PB.Repaint;
///    PBPaint(nil, nil);

  except
    on E: Exception do
    begin
      frxErrorMsg(E.Message);
      Edit1.Text := GetItem(Index).Editor.Value;
    end;
  end;
end;

procedure TfrxObjectInspector.AdjustControls;
var
  PropType: TfrxPropertyAttributes;
  y, ww: Integer;
begin
  if FDisableUpdate then Exit;
  if FItemIndex = -1 then
  begin
    EditPanel.Visible := False;
    ComboPanel.Visible := False;
    Edit1.Visible := False;
    FUpdatingPB := False;
    BackPanel.Repaint;
    Exit;
  end;

  FUpdatingPB := True;
  PropType := GetType(FItemIndex);

  EditPanel.Visible := paDialog in PropType;
  ComboPanel.Visible := paValueList in PropType;
  Edit1.ReadOnly := paReadOnly in PropType;

  ww := Round(PB.Width - FSplitterPos - 2);
  y := Round(FItemIndex * FRowHeight + 1);
  if EditPanel.Visible then
  begin
    EditPanel.SetBounds(PB.Width - 15, y - 1, 15, Round(FRowHeight) - 1);
    EditBtn.SetBounds(0, 0, EditPanel.Width, EditPanel.Height);
    Dec(ww, 15);
  end;
  if ComboPanel.Visible then
  begin
    ComboPanel.SetBounds(PB.Width - 15, y - 1, 15, Round(FRowHeight) - 1);
    ComboBtn.SetBounds(0, 0, ComboPanel.Width, ComboPanel.Height);
    Dec(ww, 15);
  end;

  Edit1.Text := GetValue(FItemIndex);
  Edit1.Typing := False;
  Edit1.SetBounds(FSplitterPos + 2, y, ww, FRowHeight - 2);
  Edit1.SelectAll;
{$IFDEF DELPHI18}
  if y + FRowHeight > Box.ViewportPosition.Y  + Box.ClientHeight then
    Box.ViewportPosition := PointF(Box.ViewportPosition.X, y - Box.ClientHeight + FRowHeight);
  if y < Box.ViewportPosition.Y then
    Box.ViewportPosition := PointF(Box.ViewportPosition.X, y - 1);
{$ELSE}
  if y + FRowHeight > Box.VScrollBar.Value  + Box.ClientHeight then
    Box.VScrollBar.Value := y - Box.ClientHeight + FRowHeight;
  if y < Box.VScrollBar.Value then
    Box.VScrollBar.Value := y - 1;
{$ENDIF}
  FUpdatingPB := False;
  BackPanel.Repaint;
end;

procedure TfrxObjectInspector.DrawOneLine(Canvas: TCanvas; i: Integer; Selected: Boolean);
var
  s: String;
  p: TfrxPropertyItem;
  offs, add: Integer;

  procedure Line(x, y, dx, dy: Single);
  begin
    Canvas.DrawLine(PointF(Round(x) + 0.5, Round(y) + 0.5),
      PointF(Round(x + dx) + 0.5, Round(y + dy) + 0.5), 1);
  end;

  procedure DrawProperty;
  var
    x, y: Single;
  begin
    x := offs + GetOffset(i) * (12 + add);
    y := 1 + i * FRowHeight;

    with Canvas do
    begin
      Stroke.Color := claGray;

      if offs < 12 then
      begin
        DrawRect(RectF(Round(x) + 1.5, Round(y) + 2.5 + add, Round(x) + 9.5, Round(y) + 10.5 + add), 1, 1, AllCorners, 1);
        Line(x + 3, y + 6 + add, 4, 0);
        if s[1] = '+' then
          Line(x + 5, y + 4 + add, 0, 4);

        s := Copy(s, 2, 255);
        x := x + 12 + add;
      end;

      Fill.Color := claBlack;
      Font.Style := [];
      if ((s = 'Name') or (s = 'Width') or (s = 'Height') or (s = 'Left') or (s = 'Top'))
        and (GetOffset(i) = 0) then
        Font.Style := [TFontStyle.fsBold];
      FFastCanvas.FillText(RectF(x, y, FSplitterPos - 1, y + FRowHeight), s, False, 1, [], TTextAlign.taLeading, TTextAlign.taLeading);
    end;
  end;

begin
  if Count > 0 then
  with Canvas do
  begin
    Stroke.Color := claLightGray;
    Stroke.Kind := TBrushKind.bkSolid;
    Font.Family := 'Segoe UI';
    Font.Size := 8 * 96 / 72;
    Font.Style := [];

    //if Screen.PixelsPerInch > 96 then
    //  add := 2
    //else
    add := 0;
    p := GetItem(i);
    s := GetName(i);
    if p.SubProperty <> nil then
    begin
      offs := 1 + add;
      if p.Expanded then
        s := '-' + s else
        s := '+' + s;
    end
    else
      offs := 13 + add;

    p.Editor.ItemHeight := Round(FRowHeight);

    if Selected then
    begin
      Line(0, FRowHeight + -1 + i * FRowHeight, PB.Width, 0);
      Fill.Color := claLightGray;
      FillRect(RectF(0, Round(i * FRowHeight), FSplitterPos, Round(i * FRowHeight + FRowHeight - 1)), 1, 1, AllCorners, 1);
      DrawProperty;
    end
    else
    begin

      Line(0, FRowHeight + -1 + i * FRowHeight, PB.Width, 0);
      Line(FSplitterPos - 1, 0 + i * FRowHeight, 0, FRowHeight);
      DrawProperty;
      Fill.Color := claNavy;
      Font.Style := [];
      if paOwnerDraw in p.Editor.GetAttributes then
        p.Editor.OnDrawItem(Canvas, RectF(FSplitterPos + 2, 1 + i * FRowHeight, PB.Width, 1 + (i + 1) * FRowHeight))
      else
        FFastCanvas.FillText(RectF(FSplitterPos + 2, 1 + i * FRowHeight, PB.Width + 2, 1 + i * FRowHeight + FRowHeight), GetValue(i), False, 1, [], TTextAlign.taLeading, TTextAlign.taLeading);
    end;
  end;
end;


{ Form events }

procedure TfrxObjectInspector.FormShow(Sender: TObject);
begin
  AdjustControls;
end;

procedure TfrxObjectInspector.FormResize(Sender: TObject);
var
  h: Integer;
begin
  if FTabs = nil then Exit;
  //if Screen.PixelsPerInch > 96 then
  //  h := 26
  //else
  h := 21;
  FTabs.SetBounds(0, ObjectsCB.Position.Y + ObjectsCB.Height + 4, MainPanel.Width, h);

  BackPanel.Position.Y := FTabs.Position.Y + FTabs.Height;

  BackPanel.Width := MainPanel.Width;
  BackPanel.Height := MainPanel.Height - BackPanel.Position.Y + 1;
  ObjectsCB.Width := MainPanel.Width;

  FPanel.Height := Count * FRowHeight;
  FPanel.Width := Box.ClientWidth;
  AdjustControls;
end;

procedure TfrxObjectInspector.TabChange(Sender: TObject);
begin
  if FDesigner.IsPreviewDesigner then
  begin
    FTabs.TabIndex := 0;
    Exit;
  end;
  if FTabs.TabIndex = 0 then
    FList := FPropertyList else
{$IFNDEF FR_VER_BASIC}
    FList := FEventList;
{$ELSE}
    FTabs.TabIndex := 0;
{$ENDIF}
  FItemIndex := -1;
  FormResize(nil);
end;

procedure TfrxObjectInspector.N11Click(Sender: TObject);
begin
  if Edit1.Visible then
    Edit1.CutToClipboard;
end;

procedure TfrxObjectInspector.N21Click(Sender: TObject);
begin
  if Edit1.Visible then
    Edit1.PasteFromClipboard;
end;

procedure TfrxObjectInspector.N31Click(Sender: TObject);
begin
  if Edit1.Visible then
    Edit1.CopyToClipboard;
end;

procedure TfrxObjectInspector.FormDeactivate(Sender: TObject);
begin
  if FDisableUpdate then Exit;
  SetItemIndex(FItemIndex);
end;


{ PB events }


procedure TfrxObjectInspector.PBPaint(Sender: TObject; Canvas: TCanvas);
var
  i: Integer;
  r: TRectF;
begin
  if FUpdatingPB then Exit;
  if Canvas = nil then Exit;
  if Assigned(FFastCanvas) and (FFastCanvas is TfrxFastCanvasLayer) then
    TfrxFastCanvasLayer(FFastCanvas).Canvas := Canvas
  else
    FFastCanvas := Canvas;
  r := PB.BoundsRect;
  with Canvas do
  begin
    Fill.Color := claWhite;
    Fill.Kind := TBrushKind.bkSolid;
    FillRect(RectF(1, 1, r.Right, r.Bottom), 1, 1, AllCorners, 1);
  end;

  if not FDisableUpdate then
  begin
    for i := 0 to Count - 1 do
    begin
    { do not draw outbound items }
{$IFDEF DELPHI18}
      if (Box.ViewportPosition.Y > (FRowHeight * i) + FRowHeight) then
        Continue;
      if (Box.ViewportPosition.Y + Box.Height < (FRowHeight * i) + FRowHeight) then
        break;
{$ELSE}
      if (Box.VScrollBar.Value > (FRowHeight * i) + FRowHeight) then
        Continue;
      if (Box.VScrollBar.Value + Box.Height < (FRowHeight * i) + FRowHeight) then
        break;
{$ENDIF}
      if i <> ItemIndex then
        DrawOneLine(Canvas, i, False);
      if FItemIndex <> -1 then
        DrawOneLine(Canvas, ItemIndex, True);
    end;
  end;
end;

procedure TfrxObjectInspector.PBMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  p: TfrxPropertyItem;
  n, x1: Integer;
begin
  FDisableDblClick := False;
  if Count = 0 then Exit;
  if PB.Cursor = crHSplit then
    FDown := True
  else
  begin
    n := Trunc(Y / FRowHeight);

    if (X > FSplitterPos) and (X < FSplitterPos + 15) and
       (n >= 0) and (n < Count) then
    begin
      p := GetItem(n);
      if p.Editor.ClassName = 'TfrxBooleanProperty' then
      begin
        p.Editor.Edit;
        DoModify;
        PB.Repaint;
        Exit;
      end;
    end;

    ItemIndex := n;
    Edit1.SetFocus;
    SetFocused(Edit1);

    p := GetItem(ItemIndex);
    x1 := GetOffset(ItemIndex) * 12;
    if (X > x1) and (X < x1 + 13) and (p.SubProperty <> nil) then
    begin
      p.Expanded := not p.Expanded;
      FormResize(nil);
      FDisableDblClick := True;
    end;
  end;
end;

procedure TfrxObjectInspector.PBMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FDown := False;
end;

procedure TfrxObjectInspector.PBMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
  n: Integer;
//  OffsetX: Single;
  s: String;
begin
  if not FDown then
  begin
    if (X > FSplitterPos - 4) and (X < FSplitterPos + 2) then
      PB.Cursor := crHSplit
    else
    begin
      PB.Cursor := crDefault;

      { hint window }
      n := Round(Y / FRowHeight);
      if (X > 12) and (n >= 0) and (n < Count) then
      begin
        if X <= FSplitterPos - 4 then
        begin
//          OffsetX := (GetOffset(n) + 1) * 12;
          s := GetName(n);
          //MaxWidth := FSplitterPos - OffsetX;
        end
        else
        begin
//          OffsetX := FSplitterPos + 1;
          s := GetValue(n);
//          MaxWidth := PB.Width - FSplitterPos;
//          if n = ItemIndex then
//            MaxWidth := 1000;
        end;
      end;
    end;
  end
  else
  begin
    if (x > 30) and (x < PB.Width - 30) then
      FSplitterPos := X;
    AdjustControls;
  end;
end;

procedure TfrxObjectInspector.PBDblClick(Sender: TObject);
var
  p: TfrxPropertyItem;
begin
  if (Count = 0) or FDisableDblClick then Exit;

  p := GetItem(ItemIndex);
  if (p <> nil) and (p.SubProperty <> nil) then
  begin
    p.Expanded := not p.Expanded;
    FormResize(nil);
  end;
end;


{ Edit1 events }

procedure TfrxObjectInspector.Edit1KeyDown(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
var
  i: Integer;
begin
  if Count = 0 then Exit;
  if Key = vkReturn then
  begin
    if paDialog in GetType(ItemIndex) then
      EditBtnClick(nil)
    else
      if Edit1.Typing then
      begin
        Edit1.Typing := False;
        SetValue(ItemIndex, Edit1.Text);
      end;
    Edit1.SelectAll;
    Key := 0;
    Exit;
  end;

  if Key = vkEscape then
  begin
    Edit1.Typing := False;
    ItemIndex := ItemIndex;
    Key := 0;
  end;
  if (Key = vkDelete) or (Key = vkBack) then
  begin
    Edit1.Typing := True;
  end;

  if Key = vkUp then
  begin
    if ItemIndex > 0 then
      ItemIndex := ItemIndex - 1;
    Key := 0;
  end
  else if Key = vkDown then
  begin
    if ItemIndex < Count - 1 then
      ItemIndex := ItemIndex + 1;
    Key := 0;
  end
  else if Key = vkPrior then
  begin
    i := Round(Box.Height / FRowHeight);
    i := ItemIndex - i;
    if i < 0 then
      i := 0;
    ItemIndex := i;
    Key := 0;
  end
  else if Key = vkNext then
  begin
    i := Round(Box.Height / FRowHeight);
    i := ItemIndex + i;
    ItemIndex := i;
    Key := 0;
  end;
end;


{ EditBtn and ComboBtn events }

procedure TfrxObjectInspector.EditBtnClick(Sender: TObject);
begin
  if GetItem(ItemIndex).Editor.Edit then
  begin
    ItemIndex := FItemIndex;
    DoModify;
  end;
end;

procedure TfrxObjectInspector.ClosePopup(Sender: TObject);
begin
  ComboBtn.Enabled := True;
end;

procedure TfrxObjectInspector.ComboBtnClick(Sender: TObject);
var
  i, wItems, nItems, wItem: Integer;
  p: TPoint;
  f: TCommonCustomForm;
begin
  ComboBtn.Enabled := False;
  with FPopupLB do
  begin
    GetItem(FItemIndex).Editor.GetValues;
    Items.Assign(GetItem(FItemIndex).Editor.Values);

    if Items.Count > 0 then
    begin
      ItemIndex := Items.IndexOf(GetValue(FItemIndex));
      wItems := 0;
      for i := 0 to Items.Count - 1 do
      begin
        if paOwnerDraw in GetItem(FItemIndex).Editor.GetAttributes then
          ListItems[i].OnPaint := GetItem(FItemIndex).Editor.OnDrawLBItem;
        wItem := Round(FFastCanvas.TextWidth(Items[i]));
        if wItem > wItems then
          wItems := wItem;
      end;

      Inc(wItems, 8);
      if paOwnerDraw in GetItem(FItemIndex).Editor.GetAttributes then
        Inc(wItems, GetItem(FItemIndex).Editor.GetExtraLBSize);
      nItems := Items.Count;
      if nItems > 8 then
      begin
        nItems := 8;
        Inc(wItems,  8);
      end;
      f := GetComponentForm(MainPanel);
      if f = nil then f := Self;

      p := f.ClientToScreen(PointF(Edit1.AbsoluteRect.Left, Edit1.AbsoluteRect.Top + Position.Y + Edit1.Height)).Round;

      if wItems < PB.Width - FSplitterPos then
      begin
        FPopupForm.Width := Round(PB.Width - FSplitterPos) + 1;
        FPopupForm.Height := Round(nItems * ItemHeight) + 2;
        with FPopupForm.PlacementRectangle do
        begin
          Left := p.X - 3;
          Top := p.Y;
        end;
      end
      else
      begin
        FPopupForm.Width := wItems;
        FPopupForm.Height := Round(nItems * ItemHeight) + 2;
        with FPopupForm.PlacementRectangle do
        begin
          Left := p.X + Round(PB.Width - FSplitterPos - wItems) - 2;
          Top := p.Y;
        end;
      end;
      if FPopupForm.PlacementRectangle.Left < 0 then
        FPopupForm.PlacementRectangle.Left := 0;

      FDisableUpdate := True;
      // Popup doesnt work in many cases ?!
      //FPopupForm.Popup;
{$IFDEF DELPHI25}
      FPopupLB.RecalcSize;
{$ENDIF}
      FPopupForm.PopupModal;
      FDisableUpdate := False;
    end;
  end;
end;

procedure TfrxObjectInspector.LBClick(Sender: TObject);
var
  S: String;
begin
  s := Edit1.Text;
  if FPopupLB.Selected <> nil then
    s := FPopupLB.Selected.Text;
  FPopupForm.IsOpen := False;
  Edit1.Text := s;

  Edit1.SetFocus;
  SetFocused(Edit1);
  Edit1.SelectAll;
  SetValue(ItemIndex, Edit1.Text);
end;


{ ObjectsCB events }

procedure TfrxObjectInspector.ObjectsCBClick(Sender: TObject);
begin
  if FUpdatingObjectsCB then Exit;

  FSelectedObjects.Clear;
  if ObjectsCB.ItemIndex <> -1 then
    FSelectedObjects.Add(ObjectsCB.Items.Objects[ObjectsCB.ItemIndex]);
  SetSelectedObjects(FSelectedObjects);
  Edit1.SetFocus;
  SetFocused(Edit1);
  if Assigned(FOnSelectionChanged) then
    FOnSelectionChanged(Self);
end;


{ Mouse wheel }

procedure TfrxObjectInspector.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
{$IFDEF DELPHI18}
  with Box.ViewportPosition do
    Box.ViewportPosition := PointF(X, Y  + FRowHeight);
{$ELSE}
  with Box.VScrollBar do
    Value := Value  + FRowHeight;
{$ENDIF}
end;

procedure TfrxObjectInspector.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
{$IFDEF DELPHI18}
  with Box.ViewportPosition do
    Box.ViewportPosition := PointF(X, Y - FRowHeight);
{$ELSE}
  with Box.VScrollBar do
    Value := Value - FRowHeight;
{$ENDIF}
end;

procedure TfrxObjectInspector.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
 if Assigned(FDesigner.OnKeyDown) then
   FDesigner.OnKeyDown(Sender, Key, KeyChar, Shift);
end;

end.
