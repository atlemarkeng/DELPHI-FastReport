
{******************************************}
{                                          }
{             FastReport v4.0              }
{            Designer controls             }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxDesgnCtrls;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.Types, System.UITypes, FMX.Objects, FMX.Types,
  FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts, FMX.frxClass, FMX.frxPictureCache,
  System.Variants, FMX.TabControl, System.UIConsts
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF}
{$IFDEF DELPHI20}
  , System.Math.Vectors
{$ENDIF};


type
  TfrxRulerUnits = (ruCM, ruInches, ruPixels, ruChars);
[ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxRuler = class(TPanel)
  private
    FOffset: Integer;
    FScale: Double;
    FStart: Integer;
    FUnits: TfrxRulerUnits;
    FPosition: Double;
    FRulerSize: Integer;
    FBitmap: TBitmap;
    FNeedRedraw: Boolean;
    procedure SetOffset(const Value: Integer);
    procedure SetScale(const Value: Double);
    procedure SetStart(const Value: Integer);
    procedure SetUnits(const Value: TfrxRulerUnits);
    procedure SetPosition(const Value: Double);
    procedure SetRulerSize(const Value: Integer);
  protected
    procedure DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF); virtual;
    procedure DrawRuler;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Offset: Integer read FOffset write SetOffset;
    property Scale: Double read FScale write SetScale;
    property Start: Integer read FStart write SetStart;
    property Units: TfrxRulerUnits read FUnits write SetUnits default ruPixels;
    property RulePosition: Double read FPosition write SetPosition;
    property RulerSize: Integer read FRulerSize write SetRulerSize;
  end;

  TfrxScrollBox = class(TScrollBox)
  private
    FContent: TContent;
    FOnPositionChanged: TNotifyEvent;
  protected
    procedure ApplyStyle; override;
    procedure DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF); virtual;
    procedure DialogKey(var Key: Word; Shift: TShiftState); override;
    procedure KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; var KeyChar: WideChar; Shift: TShiftState); override;
{$IFDEF DELPHI18}
    procedure HScrollChange; override;
    procedure VScrollChange; override;
{$ELSE}
    procedure HScrollChange(Sender: TObject); override;
    procedure VScrollChange(Sender: TObject); override;
{$ENDIF}
{$IFDEF DELPHI18}
//  public
//    property HScrollBar;
//    property VScrollBar;
{$ENDIF}
  published
    property OnPositionChanged: TNotifyEvent read FOnPositionChanged write FOnPositionChanged;
  end;

  TfrxTabControl = class(TTabControl)
  protected
    procedure ApplyStyle; override;
  end;

  TfrxCustomSelector = class(TPopup)
  protected
    FMouseOver: Boolean;
    FX, FY: Single;
    procedure DrawEdge(X, Y: Single); virtual; abstract;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure DoMouseEnter; override;
    procedure DoMouseLeave; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Popup(AControl: TControl); reintroduce; overload;
  end;

  TfrxColorSelector = class(TfrxCustomSelector)
  private
    FColor: TColor;
    FOnColorChanged: TNotifyEvent;
    FBtnCaption: String;
  protected
    procedure DrawEdge(X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Single); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoPaint; override;
    property Color: TColor read FColor write FColor;
    property OnColorChanged: TNotifyEvent read FOnColorChanged write FOnColorChanged;
    property BtnCaption: String read FBtnCaption write FBtnCaption;
  end;

  TfrxLineSelector = class(TfrxCustomSelector)
  private
    FStyle: Byte;
    FOnStyleChanged: TNotifyEvent;
  protected
    procedure DrawEdge(X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Single); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoPaint; override;
    property Style: Byte read FStyle;
    property OnStyleChanged: TNotifyEvent read FOnStyleChanged write FOnStyleChanged;
  end;

  TfrxUndoBuffer = class(TObject)
  private
    FPictureCache: TfrxPictureCache;
    FRedo: TList;
    FUndo: TList;
    function GetRedoCount: Integer;
    function GetUndoCount: Integer;
    procedure SetPictureFlag(ReportComponent: TfrxComponent; Flag: Boolean);
    procedure SetPictures(ReportComponent: TfrxComponent);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddUndo(ReportComponent: TfrxComponent);
    procedure AddRedo(ReportComponent: TfrxComponent);
    procedure GetUndo(ReportComponent: TfrxComponent);
    procedure GetRedo(ReportComponent: TfrxComponent);
    procedure ClearUndo;
    procedure ClearRedo;
    property UndoCount: Integer read GetUndoCount;
    property RedoCount: Integer read GetRedoCount;
    property PictureCache: TfrxPictureCache read FPictureCache write FPictureCache;
  end;

  TfrxClipboard = class(TObject)
  private
    FDesigner: TfrxCustomDesigner;
    FPictureCache: TfrxPictureCache;
    function GetPasteAvailable: Boolean;
  public
    constructor Create(ADesigner: TfrxCustomDesigner);
    procedure Copy;
    procedure Paste;
    property PasteAvailable: Boolean read GetPasteAvailable;
    property PictureCache: TfrxPictureCache read FPictureCache write FPictureCache;
  end;

implementation

uses
  System.Math, FMX.frxDMPClass, FMX.frxDsgnIntf, FMX.frxCtrls, FMX.frxXMLSerializer, FMX.Platform,
  FMX.frxUtils, FMX.frxXML, FMX.frxFMX;

const
  Colors: array[0..47] of TAlphaColor =
    (claNull, claWhite, claBlack, claMaroon, claGreen, claOlive, claNavy, claPurple,
     claGray, claSilver, claTeal, claRed, claLime, claYellow, claBlue, claFuchsia,
     $FFCCCCCC, $FFE4E4E4, claAqua, $FF00CCFF, $FF00CC98, $FF98FFFF, $FFFFCC00, $FFFF98CC,
     $FFD8D8D8, $FFF0F0F0, $FFFFFFDC, $FFCAE4FF, $FFCCFFCC, $FFCCFFFF, $FFFFF4CC, $FFCC98FF,
     claGray, $FF46DAFF, $FF9BEBFF, $FF00A47B, $FFFDBD97, $FFFED3BA, $FF6ACFFF, $FFFFF4CC,
     claGray, claGray, claGray, claGray, claGray, claGray, claGray, claGray);



{ TfrxRuler }

constructor TfrxRuler.Create(AOwner: TComponent);
begin
  inherited;
  FScale := 1;
  OnPaint := DoContentPaint;
  StyleLookup := 'backgroundstyle';
  FBitmap := TBitmap.Create(1, 1);
  FNeedRedraw := True;
end;


destructor TfrxRuler.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TfrxRuler.DoContentPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  SaveState: TCanvasSaveState;

  procedure Line(x, y, dx, dy: Integer);
  begin
    Canvas.DrawLine(PointF(x + 0.5, y + 0.5), PointF(x + dx + 0.5, y + dy + 0.5), 1);
  end;

  procedure DrawLines;
  var
    i, dx: Single;
    ofs: Integer;
  begin
    with Canvas do
    begin
      Stroke.Color := claBlack;
      Stroke.Kind := TBrushKind.bkSolid;
      Fill.Kind := TBrushKind.bkNone;

      if FUnits = ruCM then
        dx := fr01cm * FScale
      else if FUnits = ruInches then
        dx := fr01in * FScale
      else if FUnits = ruChars then
      begin
        if Align = TAlignLayout.alLeft then
          dx := fr1CharY * FScale / 10 else
          dx := fr1CharX * FScale / 10
      end
      else
        dx := FScale;

      ofs := FOffset - FStart;
      if FUnits = ruChars then
      begin
        if Align = TAlignLayout.alLeft then
          Inc(ofs, Round(fr1CharY * FScale / 2)) else
          Inc(ofs, Round(fr1CharX * FScale / 2))
      end;
      i := FPosition * dx;
      if FUnits <> ruPixels then
        i := i * 10;
      if ofs + i >= FOffset then
        if Align = TAlignLayout.alLeft then
          Line(3, ofs + Round(i), 13, 0) else
          Line(ofs + Round(i), 3, 0, 13);
    end;
  end;

begin
  if FNeedRedraw then
  begin
    FNeedRedraw := False;
    DrawRuler;
  end;

    SaveState := Canvas.SaveState;
  try
    Canvas.IntersectClipRect(ARect);
    Canvas.DrawBitmap(FBitmap, RectF(0, 0, FBitmap.Width, FBitmap.Height), ARect, 1);
    DrawLines;
  finally
    Canvas.RestoreState(SaveState);
  end;
end;

procedure TfrxRuler.DrawRuler;
var
  sz: Single;
  SaveStateA, SaveStateB: TCanvasSaveState;
  RMatrix, OldM: TMatrix;


  procedure Line(x, y, dx, dy: Integer);
  begin
    FBitmap.Canvas.DrawLine(PointF(x + 0.5, y + 0.5), PointF(x + dx + 0.5, y + dy + 0.5), 1);
  end;

  procedure DrawLines;
  var
    i, dx, maxi, maxw, tx, ty: Single;
    i1, h, w, w5, w10, ofs: Integer;
    s: String;
  begin
    with FBitmap.Canvas do
    begin
      Stroke.Color := claBlack;
      Stroke.Kind := TBrushKind.bkSolid;
      Fill.Kind := TBrushKind.bkNone;
      w5 := 5;
      w10 := 10;
      if FUnits = ruCM then
        dx := fr01cm * FScale
      else if FUnits = ruInches then
        dx := fr01in * FScale
      else if FUnits = ruChars then
      begin
        if Align = TAlignLayout.alLeft then
          dx := fr1CharY * FScale / 10 else
          dx := fr1CharX * FScale / 10
      end
      else
      begin
        dx := FScale;
        w5 := 50;
        w10 := 100;
      end;

      if FRulerSize = 0 then
      begin
        if Align = TAlignLayout.alLeft then
          maxi := Height + FStart else
          maxi := Self.Width + FStart;
      end
      else
        maxi := FRulerSize;

      if FUnits = ruPixels then
        s := IntToStr(FStart + Round(maxi / dx)) else
        s := IntToStr((FStart + Round(maxi / dx)) div 10);

      maxw := TextWidth(s);
      ofs := FOffset - FStart;
      if FUnits = ruChars then
      begin
        if Align = TAlignLayout.alLeft then
          Inc(ofs, Round(fr1CharY * FScale / 2)) else
          Inc(ofs, Round(fr1CharX * FScale / 2))
      end;

      i := 0;
      i1 := 0;
      while i < maxi do
      begin
        h := 0;
        if i1 = 0 then
          h := 0
        else if i1 mod w10 = 0 then
          h := 6
        else if i1 mod w5 = 0 then
          h := 4
        else if FUnits <> ruPixels then
          h := 2;

        if (h = 2) and (dx * w10 < 41) then
          h := 0;
        if (h = 4) and (dx * w10 < 21) then
          h := 0;

        w := 0;
        if h = 6 then
        begin
          if maxw > dx * w10 * 1.5 then
            w := w10 * 4
          else if maxw > dx * w10 * 0.7 then
            w := w10 * 2
          else
            w := w10;
        end;

        if FUnits = ruPixels then
          s := IntToStr(i1) else
          s := IntToStr(i1 div 10);
        Fill.Color := claBlack;
        Fill.Kind := TBrushKind.bkSolid;
        if (w <> 0) and (i1 mod w = 0) and (ofs + i >= FOffset) then
        begin
          if Align = TAlignLayout.alLeft then
          begin
            tx :=  -(ofs + i - TextWidth(s) / 2 + 6);
            ty := Self.Width - FBitmap.Canvas.TextHeight(s) - 8;
            SaveStateB := SaveState;

            SetMatrix(RMatrix);
          end
          else
          begin
            tx := ofs + Round(i) - TextWidth(s) / 2 + 1;
            ty := 5;
          end;

          FillText(RectF(tx, ty, tx + 100, ty + 100), s, False, 1, [], TTextAlign.taLeading, TTextAlign.taLeading);
          if Align = TAlignLayout.alLeft then
            RestoreState(SaveStateB);
        end
        else if (h <> 0) and (ofs + i >= FOffset) then
          if Align = TAlignLayout.alLeft then
            Line(3 + (13 - h) div 2, ofs + Round(i), h, 0) else
            Line(ofs + Round(i), 3 + (13 - h) div 2, 0, h);

        i := i + dx;
        Inc(i1);
      end;
    end;
  end;

begin
  FBitmap.SetSize(Round(Self.Width), Round(Self.Height));
  FBitmap.Canvas.BeginScene();
  SaveStateA := FBitmap.Canvas.SaveState;
  try
    with FBitmap.Canvas do
    begin
      Fill.Kind := TBrushKind.bkSolid;
      Fill.Color := claWhite;
      Font.Family := 'Arial';
      Font.Size := 8;
      if Align = TAlignLayout.alLeft then
      begin
        if FRulerSize = 0 then
          sz := Self.Height
        else
          sz := FRulerSize + FOffset;
        FillRect(RectF(3, FOffset, Self.Width - 5, sz), 1, 1, AllCorners, 1);
        RMatrix := CreateRotationMatrix(-DegToRad(90));

        RMatrix.m31 := Self.GetAbsoluteRect.Left;
        RMatrix.m32 := Self.GetAbsoluteRect.Top;
        OldM := Matrix;
      end
      else
      begin
        if FRulerSize = 0 then
          sz := Self.Width
        else
          sz := FRulerSize + FOffset;
        FillRect(RectF(FOffset, 3, sz, Self.Height - 5), 1, 1, AllCorners, 1);
      end;
    end;
    DrawLines;
  finally
    FBitmap.Canvas.RestoreState(SaveStateA);
    FBitmap.Canvas.EndScene;
  end;
end;

procedure TfrxRuler.SetOffset(const Value: Integer);
begin
  FOffset := Value;
  FNeedRedraw := True;
  Repaint;
end;

procedure TfrxRuler.SetPosition(const Value: Double);
begin
  FPosition := Value;
  Repaint;
end;

procedure TfrxRuler.SetScale(const Value: Double);
begin
  FScale := Value;
  FNeedRedraw := True;
  Repaint;
end;

procedure TfrxRuler.SetStart(const Value: Integer);
begin
  FStart := Value;
  FNeedRedraw := True;
  Repaint;
end;

procedure TfrxRuler.SetUnits(const Value: TfrxRulerUnits);
begin
  FUnits := Value;
  FNeedRedraw := True;
  Repaint;
end;

procedure TfrxRuler.SetRulerSize(const Value: Integer);
begin
  FRulerSize := Value;
  FNeedRedraw := True;
  Repaint;
end;


{ TfrxScrollBox }

procedure TfrxScrollBox.ApplyStyle;
var
  B: TFmxObject;
begin
  inherited;
  B := FindStyleResource('content');
  if (B <> nil) and (B is TControl) then
  begin
    FContent := TContent(B);
    FContent.OnPaint := DoContentPaint;
  end;
end;

procedure TfrxScrollBox.DialogKey(var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

procedure TfrxScrollBox.DoContentPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  Canvas.Fill.Kind := TBrushKind.bkSolid;
  Canvas.Fill.Color := $FFE0E0E0;
  Canvas.FillRect(ARect, 1, 1, AllCorners, 1, TCornerType.ctBevel);
end;

procedure TfrxScrollBox.KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
//var
//  i: Integer;
begin
  inherited;
  {for i := 0 to ControlCount - 1 do
    if Controls[i] is TWinControl then
      THackControl(Controls[i]).KeyDown(Key, Shift);}
end;

//procedure TfrxScrollBox.KeyPress(var Key: Char);
//var
//  i: Integer;
//begin
//  inherited;
//  for i := 0 to ControlCount - 1 do
//    if Controls[i] is TWinControl then
//      THackControl(Controls[i]).KeyPress(Key);
//end;

procedure TfrxScrollBox.KeyUp(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
//var
//  i: Integer;
begin
  inherited;
  {for i := 0 to ControlCount - 1 do
    if Controls[i] is TWinControl then
      THackControl(Controls[i]).KeyUp(Key, Shift);}
end;

{$IFDEF DELPHI18}
procedure TfrxScrollBox.HScrollChange;
{$ELSE}
procedure TfrxScrollBox.HScrollChange(Sender: TObject);
{$ENDIF}
begin
  inherited;
  if Assigned(FOnPositionChanged) then
    FOnPositionChanged(Self);
end;

{$IFDEF DELPHI18}
procedure TfrxScrollBox.VScrollChange;
{$ELSE}
procedure TfrxScrollBox.VScrollChange(Sender: TObject);
{$ENDIF}
begin
  inherited;
  if Assigned(FOnPositionChanged) then
    FOnPositionChanged(Self);
end;



{ TfrxCustomSelector }

constructor TfrxCustomSelector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  StyleLookup := 'panelstyle';
end;

procedure TfrxCustomSelector.Popup(AControl: TControl);
begin
  Tag := AControl.Tag;
  PlacementTarget := AControl;
  Popup;
end;

procedure TfrxCustomSelector.DoMouseEnter;
begin
  FMouseOver := True;
  Repaint;
end;

procedure TfrxCustomSelector.DoMouseLeave;
begin
  FMouseOver := False;
  Repaint;
end;

procedure TfrxCustomSelector.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  FX := X;
  FY := Y;
  Repaint;
end;



{ TfrxColorSelector }

constructor TfrxColorSelector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 155;
  Height := 143;
  FBtnCaption := 'Other...';
end;

procedure TfrxColorSelector.DrawEdge(X, Y: Single);
var
  r: TRectF;
begin
  X := Trunc((X - 5) / 18);
  if X >= 8 then
    X := 7;
  Y := Trunc((Y - 5) / 18);

  if Y < 6 then
    r := RectF(X * 18 + 5.5, Y * 18 + 5.5, X * 18 + 23.5, Y * 18 + 23.5) else
    r := RectF(5.5, 113.5, Width - 5.5, Height - 5.5);

  with Canvas do
  begin
    Stroke.Kind := TBrushKind.bkSolid;
    Stroke.Color := $FFC56A31;

    DrawRect(r, 0, 0, AllCorners, 1);
    InflateRect(r, -1, -1);
    Stroke.Color := $FFE8E6E2;

    DrawRect(r, 0, 0, AllCorners, 1);
    InflateRect(r, -1, -1);

    DrawRect(r, 0, 0, AllCorners, 1);
  end;
end;

procedure TfrxColorSelector.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
//var
  //cd: TColorDialog;

  procedure AddCustomColor;
  var
    i: Integer;
    Found: Boolean;
    Empty: Integer;
  begin
    Found := False;
    Empty := 0;
    for i := 0 to 47 do
    begin
      if Colors[i] = Cardinal(FColor) then
        Found := True;
      if (i > 37) and (Colors[i] = claGray) and (Empty = 0) then
        Empty := i;
    end;

    if Found then exit;

    if Empty = 0 then
    begin
      for i := 40 to 46 do
        Colors[i] := Colors[i + 1];
      Empty := 47;
    end;
    Colors[Empty] := FColor
  end;

begin
  X := Trunc((X - 5) / 18);
  if X >= 8 then
    X := 7;
  Y := Trunc((Y - 5) / 18);

  if Y < 6 then
    FColor := Colors[Round(X + Y * 8)]
  else
  begin
    //TForm(Parent).AutoSize := False;
    //Parent.Height := 0;
    //cd := TColorDialog.Create(Self);
    //cd.Options := [cdFullOpen];
    //cd.Color := FColor;
    //if cd.Execute then
    //  FColor := cd.Color else
    //  Exit;
    // todo color selector form
    AddCustomColor;
  end;

  ClosePopup;
  if Assigned(FOnColorChanged) then
    FOnColorChanged(Self);
end;

procedure TfrxColorSelector.DoPaint;
var
  i, j: Integer;
  s: String;
  r: TRectF;
begin
  inherited;

  with Canvas do
  begin
    Fill.Kind := TBrushKind.bkSolid;
    Stroke.Kind := TBrushKind.bkSolid;
    for j := 0 to 5 do
      for i := 0 to 7 do
      begin
        if (i = 0) and (j = 0) then
          Fill.Color := claWhite else
          Fill.Color := Colors[i + j * 8];
        Stroke.Color := claGray;
        r := RectF(i * 18 + 8.5, j * 18 + 8.5, i * 18 + 20.5, j * 18 + 20.5);
        FillRect(r, 0, 0, AllCorners, 1);
        DrawRect(r, 0, 0, AllCorners, 1);
        if (i = 0) and (j = 0) then
        begin
          DrawLine(PointF(i * 18 + 10.5, j * 18 + 10.5), PointF(i * 18 + 18.5, j * 18 + 18.5), 1);
          DrawLine(PointF(i * 18 + 18.5, j * 18 + 10.5), PointF(i * 18 + 10.5, j * 18 + 18.5), 1);
        end;
      end;

    Stroke.Color := claGray;
    Fill.Color := claGray;
    DrawRect(RectF(8.5, 116.5, Width - 8.5, Height - 8.5), 0, 0, AllCorners, 1);
    s := FBtnCaption;
    FillText(RectF(10, 116, Width - 10, Height - 8), s, False, 1, [], TTextAlign.taCenter, TTextAlign.taCenter)
  end;

  if FMouseOver then
    DrawEdge(FX, FY);
end;


{ TfrxLineSelector }

constructor TfrxLineSelector.Create(AOwner: TComponent);
begin
  inherited;
  Width := 98;
  Height := 106;
end;

procedure TfrxLineSelector.DrawEdge(X, Y: Single);
var
  r: TRectF;
begin
  Y := Trunc((Y - 5) / 16);
  if Y > 5 then
    Y := 5;

  r := RectF(5.5, Y * 16 + 5.5, Width - 6.5, Y * 16 + 19.5);
  with Canvas do
  begin
    Stroke.Kind := TBrushKind.bkSolid;
    Stroke.Color := claGray;
{$IFDEF Delphi25}
    Stroke.Thickness := 1;
{$ELSE}
    StrokeThickness := 1;
{$ENDIF}
    DrawRect(r, 0, 0, AllCorners, 1);
  end;
end;

procedure TfrxLineSelector.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
begin
  Y := Trunc((Y - 5) / 16);
  if Y > 5 then
    Y := 5;

  FStyle := Round(Y);

  ClosePopup;
  if Assigned(FOnStyleChanged) then
    FOnStyleChanged(Self);
end;

procedure TfrxLineSelector.DoPaint;
var
  i: Integer;

  procedure DrawLine(Y, Style: Integer);
  begin
    if Style = 5 then
    begin
      Style := 0;
      DrawLine(Y - 2, Style);
      Inc(Y, 2);
    end;

    with Canvas do
    begin
      Stroke.Color := claBlack;
{$IFDEF Delphi25}
      Stroke.Thickness := 2;
	  Stroke.Dash := TStrokeDash(Style);
{$ELSE}
      StrokeDash := TStrokeDash(Style);
      StrokeThickness := 2;
{$ENDIF}
      DrawLine(PointF(7, Y), PointF(Self.Width - 8, Y), 1);
    end;
  end;

begin
  inherited;
  for i := 0 to 5 do
    DrawLine(12 + i * 16, i);
  if FMouseOver then
    DrawEdge(FX, FY);
end;


{ TfrxUndoBuffer }

constructor TfrxUndoBuffer.Create;
begin
  FRedo := TList.Create;
  FUndo := TList.Create;
end;

destructor TfrxUndoBuffer.Destroy;
begin
  ClearUndo;
  ClearRedo;
  FUndo.Free;
  FRedo.Free;
  inherited;
end;

procedure TfrxUndoBuffer.AddUndo(ReportComponent: TfrxComponent);
var
  m: TMemoryStream;
begin
  m := TMemoryStream.Create;
  FUndo.Add(m);
  SetPictureFlag(ReportComponent, False);
  try
    ReportComponent.SaveToStream(m);
  finally
    SetPictureFlag(ReportComponent, True);
  end;
end;

procedure TfrxUndoBuffer.AddRedo(ReportComponent: TfrxComponent);
var
  m: TMemoryStream;
begin
  m := TMemoryStream.Create;
  FRedo.Add(m);
  SetPictureFlag(ReportComponent, False);
  try
    ReportComponent.SaveToStream(m);
  finally
    SetPictureFlag(ReportComponent, True);
  end;
end;

procedure TfrxUndoBuffer.GetUndo(ReportComponent: TfrxComponent);
var
  m: TMemoryStream;
  IsReport: Boolean;
begin
  IsReport := False;
  if ReportComponent is TfrxReport then
    isReport := True;
  m := FUndo[FUndo.Count - 2];
  m.Position := 0;
  if IsReport then
    TfrxReport(ReportComponent).Reloading := True;
  try
    ReportComponent.LoadFromStream(m);
  finally
  if IsReport then
    TfrxReport(ReportComponent).Reloading := False;
  end;
  SetPictures(ReportComponent);

  m := FUndo[FUndo.Count - 1];
  m.Free;
  FUndo.Delete(FUndo.Count - 1);
end;

procedure TfrxUndoBuffer.GetRedo(ReportComponent: TfrxComponent);
var
  m: TMemoryStream;
  IsReport: Boolean;
begin
  IsReport := False;
  if ReportComponent is TfrxReport then
    isReport := True;
  m := FRedo[FRedo.Count - 1];
  m.Position := 0;
  if IsReport then
    TfrxReport(ReportComponent).Reloading := True;
  try
    ReportComponent.LoadFromStream(m);
  finally
    if IsReport then
      TfrxReport(ReportComponent).Reloading := False;
  end;
  SetPictures(ReportComponent);

  m.Free;
  FRedo.Delete(FRedo.Count - 1);
end;

procedure TfrxUndoBuffer.ClearUndo;
begin
  while FUndo.Count > 0 do
  begin
    TMemoryStream(FUndo[0]).Free;
    FUndo.Delete(0);
  end;
end;

procedure TfrxUndoBuffer.ClearRedo;
begin
  while FRedo.Count > 0 do
  begin
    TMemoryStream(FRedo[0]).Free;
    FRedo.Delete(0);
  end;
end;

function TfrxUndoBuffer.GetRedoCount: Integer;
begin
  Result := FRedo.Count;
end;

function TfrxUndoBuffer.GetUndoCount: Integer;
begin
  Result := FUndo.Count;
end;

procedure TfrxUndoBuffer.SetPictureFlag(ReportComponent: TfrxComponent; Flag: Boolean);
var
  i: Integer;
  l: TList;
  c: TfrxComponent;
begin
  l := ReportComponent.AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if c is TfrxPictureView then
    begin
      TfrxPictureView(c).IsPictureStored := Flag;
      TfrxPictureView(c).IsImageIndexStored := not Flag;
    end;
  end;
end;

procedure TfrxUndoBuffer.SetPictures(ReportComponent: TfrxComponent);
var
  i: Integer;
  l: TList;
  c: TfrxComponent;
begin
  l := ReportComponent.AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if c is TfrxPictureView then
      FPictureCache.GetPicture(TfrxPictureView(c));
  end;
end;


{ TfrxClipboard }

constructor TfrxClipboard.Create(ADesigner: TfrxCustomDesigner);
begin
  FDesigner := ADesigner;
end;

procedure TfrxClipboard.Copy;
var
  c, c1: TfrxComponent;
  i, j: Integer;
  text: String;
  minX, minY: Extended;
  List: TList;
  Flag: Boolean;

  procedure Write(c: TfrxComponent);
  var
    c1: TfrxComponent;
    Writer: TfrxXMLSerializer;
  begin
    c1 := TfrxComponent(c.NewInstance);
    c1.Create(FDesigner.Page);

    if c is TfrxPictureView then
    begin
      TfrxPictureView(c).IsPictureStored := False;
      TfrxPictureView(c).IsImageIndexStored := True;
    end;

    try
      c1.Assign(c);
    finally
      if c is TfrxPictureView then
      begin
        TfrxPictureView(c).IsPictureStored := True;
        TfrxPictureView(c).IsImageIndexStored := False;
        TfrxPictureView(c1).IsImageIndexStored := True;
      end;
    end;

    c1.Left := c1.Left - minX;
    c1.Top := c.AbsTop - minY;

    Writer := TfrxXMLSerializer.Create(nil);
    Writer.Owner := c1.Report;
    text := text + '<' + c1.ClassName + ' Name="' + c.Name + '"' + Writer.ObjToXML(c1) + '/>';
    Writer.Free;

    c1.Free;
  end;

begin
  text := '#FR3 clipboard#' + #10#13;

  minX := 100000;
  minY := 100000;
  for i := 0 to FDesigner.SelectedObjects.Count - 1 do
  begin
    c := FDesigner.SelectedObjects[i];
    if c.AbsLeft < minX then
      minX := c.AbsLeft;
    if c.AbsTop < minY then
      minY := c.AbsTop;
  end;

  List := FDesigner.Page.AllObjects;
  for i := 0 to List.Count - 1 do
  begin
    c := List[i];
    if FDesigner.SelectedObjects.IndexOf(c) <> -1 then
    begin
      Write(c);
      if c is TfrxBand then
      begin
        Flag := False;
        for j := 0 to c.Objects.Count - 1 do
        begin
          c1 := c.Objects[j];
          if FDesigner.SelectedObjects.IndexOf(c1) <> -1 then
            Flag := True;
        end;

        if not Flag then
          for j := 0 to c.Objects.Count - 1 do
            Write(c.Objects[j]);
      end;
    end;
  end;

  SetClipboard(text);
end;

function TfrxClipboard.GetPasteAvailable: Boolean;
var
  cb: Variant;
begin
  Result := False;
  try
    cb := GetClipboard;
    if cb <> null then
      Result := (Pos('#FR3 clipboard#', cb) = 1);
  except
    Result := False;
  end;
end;

procedure TfrxClipboard.Paste;
var
  c: TfrxComponent;
  sl: TStrings;
  s: TStream;
  List: TList;
  NewCompName: string;
  NewComp: TfrxComponent;

  function ReadComponent_(AReader: TfrxXMLSerializer; Root: TfrxComponent): TfrxComponent;
  var
    rd: TfrxXMLReader;
    RootItem: TfrxXMLItem;
  begin
    rd := TfrxXMLReader.Create(AReader.Stream);
    RootItem := TfrxXMLItem.Create;

    try
      rd.ReadRootItem(RootItem, False);
      Result := AReader.ReadComponentStr(Root, RootItem.Name + ' ' + RootItem.Text);

      NewCompName := RootItem.Prop['Name'];
    finally
      rd.Free;
      RootItem.Free;
    end;
  end;

  function ReadComponent: TfrxComponent;
  var
    Reader: TfrxXMLSerializer;
  begin
    Reader := TfrxXMLSerializer.Create(s);
    Result := ReadComponent_(Reader, FDesigner.Report);
    Reader.Free;
  end;

  function FindBand(Band: TfrxComponent): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to FDesigner.Page.Objects.Count - 1 do
      if (FDesigner.Page.Objects[i] <> Band) and
        (TObject(FDesigner.Page.Objects[i]) is Band.ClassType) then
        Result := True;
  end;

  function CanInsert(c: TfrxComponent): Boolean;
  begin
    Result := True;
    if (c is TfrxDialogControl) and (FDesigner.Page is TfrxReportPage) then
      Result := False;
    if not (c is TfrxDialogComponent) and not (c is TfrxDialogControl) and
      (FDesigner.Page is TfrxDialogPage) then
      Result := False;
    if ((c is TfrxDMPMemoView) or (c is TfrxDMPLineView) or (c is TfrxDMPCommand)) and
      not (FDesigner.Page is TfrxDMPPage) then
      Result := False;
    if not ((c is TfrxBand) or (c is TfrxDMPMemoView) or (c is TfrxDMPLineView) or
      (c is TfrxDMPCommand)) and (FDesigner.Page is TfrxDMPPage) then
      Result := False;
    if not ((c is TfrxCustomLineView) or (c is TfrxCustomMemoView) or
      (c is TfrxShapeView) or (c is TfrxDialogComponent)) and
      (FDesigner.Page is TfrxDataPage) then
      Result := False;
  end;

  procedure FindParent(c: TfrxComponent);
  var
    i: Integer;
    Found: Boolean;
    c1: TfrxComponent;
  begin
    Found := False;
    if not (c is TfrxBand) then
      for i := List.Count - 1 downto 0 do
      begin
        c1 := List[i];
        if c1 is TfrxBand then
          if (c.Top >= c1.Top) and (c.Top < c1.Top + c1.Height) then
          begin
            c.Parent := c1;
            c.Top := c.Top - c1.Top;
            Found := True;
            break;
          end;
      end;
    if not Found then
      c.Parent := FDesigner.Page;
  end;

begin
  FDesigner.SelectedObjects.Clear;

  sl := TStringList.Create;
  sl.Text := GetClipboard;
  sl.Delete(0);

  s := TMemoryStream.Create;
  sl.SaveToStream(s, TEncoding.UTF8);
  sl.Free;
  s.Position := 0;

  List := TList.Create;

  while s.Position < s.Size do
  begin
    c := ReadComponent;
    if c = nil then break;

    if (((c is TfrxReportTitle) or (c is TfrxReportSummary) or
       (c is TfrxPageHeader) or (c is TfrxPageFooter) or
       (c is TfrxColumnHeader) or (c is TfrxColumnFooter)) and FindBand(c)) or
       not CanInsert(c) then
      c.Free
    else
    begin
      if c is TfrxPictureView then
        FPictureCache.GetPicture(TfrxPictureView(c));
      List.Add(c);
      FindParent(c);
      if FDesigner.IsPreviewDesigner then
        NewComp := FDesigner.Report.FindObject(NewCompName) as TfrxComponent
      else
        NewComp := FDesigner.Report.FindComponent(NewCompName) as TfrxComponent;
      if ((NewComp <> nil) and (NewComp <> c)) or (NewCompName = '') then
        c.CreateUniqueName
      else
        c.Name := NewCompName;
      c.GroupIndex := 0;
      FDesigner.Objects.Add(c);
      if c.Parent = FDesigner.Page then
        FDesigner.SelectedObjects.Add(c);
      c.OnPaste;
    end;
  end;

  if FDesigner.SelectedObjects.Count = 0 then
    FDesigner.SelectedObjects.Add(FDesigner.Page);

  List.Free;
  s.Free;
end;


{ TfrxTabControl }

procedure TfrxTabControl.ApplyStyle;
var
  B: TFmxObject;
begin
  inherited;
  B := FindStyleResource('rectangle');
  if (B <> nil) and (B is TRectangle) then
    TRectangle(B).Sides := [];
end;


initialization
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TfrxRuler, TFmxObject);
  GroupDescendentsWith(TfrxScrollBox, TFmxObject);
  RegisterFmxClasses([TfrxRuler, TfrxScrollBox]);

end.
