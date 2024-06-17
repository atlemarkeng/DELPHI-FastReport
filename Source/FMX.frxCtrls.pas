{***************************************************}
{                                                   }
{             FastReport v4.0                       }
{              Tool controls                        }
{                                                   }
{         Copyright (c) 1998-2008                   }
{         by Alexander Tzyganenko,                  }
{            Fast Reports Inc.                      }
{                                                   }
{***************************************************}

unit FMX.frxCtrls;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.Classes, System.Types, System.UITypes, FMX.Types, FMX.Controls, FMX.ListBox,
  FMX.Forms, FMX.Edit, System.UIConsts, FMX.Objects, FMX.Layouts
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF}
{$IFDEF DELPHI21}
  , FMX.Controls.Presentation
{$ENDIF};

type
  TfrxScrollWin = class(TStyledControl)
  private
    FHScrollBar: TScrollBar;
    FVScrollBar: TScrollBar;
    FContent: TContent;
    procedure SetHorzRange(Value: Single);
    procedure SetHorzPosition(Value: Single);
    procedure SetVertRange(Value: Single);
    procedure SetVertPosition(Value: Single);
    procedure CheckScrollBars;
    procedure UpdateScrollBars;
    function HScrollBar: TScrollBar;
    function VScrollBar: TScrollBar;
    function GetHorzPosition: Single;
    function GetVertPosition: Single;
    function GetHorzRange: Single;
    function GetVertRange: Single;
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    procedure OnHScrollChange(Sender: TObject); virtual;
    procedure OnVScrollChange(Sender: TObject); virtual;
    procedure DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF); virtual;
    function GetContentCanvas: TCanvas;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Resize; override;
    function GetClientRect: TRectF;
    property HorzRange: Single read GetHorzRange write SetHorzRange;
    property HorzPosition: Single read GetHorzPosition write SetHorzPosition;
    property VertRange: Single read GetVertRange write SetVertRange;
    property VertPosition: Single read GetVertPosition write SetVertPosition;
  end;


  TfrxSplitter = class(TSplitter)
  private
    FOnMove: TNotifyEvent;
  public
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    property OnMove: TNotifyEvent read FOnMove write FOnMove;
  end;

  TfrxEditWithButton = class(TEdit)
  private
{$IFDEF DELPHI21}
    FButton: TEditButton;
{$ELSE}
    FButton: TSpeedButton;
{$ENDIF}
    FOnButtonClick: TNotifyEvent;
    procedure DoButtonClick(Sender: TObject);
  protected
{$IFDEF DELPHI21}
    function DefinePresentationName: string; override;
{$ENDIF}
    procedure ApplyStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
  end;

  TfrxEditButton = class(TSpeedButton)
  private
    procedure DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
  protected
    procedure ApplyStyle; override;
  end;


implementation

function Min(A, B: Single): Single;
begin
  if A < B then Result := A
  else Result := B;
end;

constructor TfrxScrollWin.Create(AOwner: TComponent);
begin
  inherited;
  CanFocus := True;
{$IFDEF Delphi18}
  StyleLookup := 'scrollboxstyle';
{$ELSE}
  FStyleLookup := 'scrollboxstyle';
{$ENDIF}
  ClipChildren := True;
{$IFNDEF Delphi17}
  CanClip := True;
{$ENDIF}
  ClipParent := True;
end;

procedure TfrxScrollWin.ApplyStyle;
var
  B: TFmxObject;
begin
  inherited;
  if (FVScrollBar = nil) or (FHScrollBar = nil) then
  begin
    B := FindStyleResource('vscrollbar');
    if (B <> nil) and (B is TScrollBar) then
    begin
      FVScrollBar := TScrollBar(B);
      FVScrollBar.OnChange := OnVScrollChange;
    end;
    B := FindStyleResource('hscrollbar');
    if (B <> nil) and (B is TScrollBar) then
    begin
      FHScrollBar := TScrollBar(B);
      FHScrollBar.OnChange := OnHScrollChange;
    end;
    B := FindStyleResource('sizegrip');
    if (B <> nil) and (B is TControl) then
      (B as TControl).Visible := False;
  end;
  B := FindStyleResource('content');
  if (B <> nil) and (B is TControl) then
  begin
    FContent := TContent(B);
    FContent.OnPaint := DoContentPaint;
    FContent.BringToFront;
    FContent.ClipChildren := True;
    FContent.ClipParent := True;
{$IFNDEF Delphi17}
    FContent.CanClip := True;
{$ENDIF}
  end;
end;

procedure TfrxScrollWin.CheckScrollBars;
begin
  if (FHScrollBar = nil) or (FVScrollBar = nil) then
    ApplyStyleLookup;
end;

function TfrxScrollWin.GetClientRect: TRectF;
begin
  if FContent <> nil then
    Result := FContent.ClipRect
  else
    Result := RectF(0, 0, 0, 0);
end;

function TfrxScrollWin.GetContentCanvas: TCanvas;
begin
  Result := nil;
  if (FContent <> nil) and (FContent.Canvas <> nil) then
    Result := FContent.Canvas;
end;

function TfrxScrollWin.GetHorzPosition: Single;
begin
  Result := HScrollBar.Value;
end;

function TfrxScrollWin.GetHorzRange: Single;
begin
  Result := HScrollBar.Max;
end;

function TfrxScrollWin.GetVertPosition: Single;
begin
  Result := VScrollBar.Value;
end;

function TfrxScrollWin.GetVertRange: Single;
begin
  Result := VScrollBar.Max;
end;

function TfrxScrollWin.HScrollBar: TScrollBar;
begin
  CheckScrollBars;
  Result := FHScrollBar;
end;

function TfrxScrollWin.VScrollBar: TScrollBar;
begin
  CheckScrollBars;
  Result := FVScrollBar;
end;

procedure TfrxScrollWin.SetHorzPosition(Value: Single);
begin
  HScrollBar.Value := Value;
end;

procedure TfrxScrollWin.SetHorzRange(Value: Single);
begin
  HScrollBar.Max := Value;
  UpdateScrollBars;
end;

procedure TfrxScrollWin.SetVertPosition(Value: Single);
begin
  VScrollBar.Value := Value;
end;

procedure TfrxScrollWin.SetVertRange(Value: Single);
begin
  VScrollBar.Max := Value;
  UpdateScrollBars;
end;

procedure TfrxScrollWin.UpdateScrollbars;
begin
  if HorzRange > BoundsRect.Width then
  begin
    HScrollBar.Visible := True;
    HScrollBar.SmallChange := BoundsRect.Width / 5;
    HorzPosition := HorzPosition;
    HScrollBar.ViewportSize := BoundsRect.Width;
  end
  else
  begin
    HScrollBar.Visible := False;
  end;

  if VertRange > BoundsRect.Height then
  begin
    VScrollBar.Visible := True;
    VScrollBar.SmallChange := BoundsRect.Height / 5;
    VertPosition := VertPosition;
    VScrollBar.ViewportSize := BoundsRect.Height;
  end
  else
  begin
    VScrollBar.Visible := False;
  end;

  if HScrollBar.Visible and VScrollBar.Visible then
    HScrollBar.Padding.Right := VScrollBar.Width
  else
    HScrollBar.Padding.Right := 0;
end;

procedure TfrxScrollWin.Resize;
begin
  if FContent <> nil then
  begin
    //FContent.SetBounds(Left, Top, Width, Height);
{$IFNDEF Delphi17}
    FContent.Realign;
{$ENDIF}
  end;
// XE3 bug?
//  UpdateScrollBars;
  inherited;
end;

procedure TfrxScrollWin.MouseWheel(Shift: TShiftState; WheelDelta: Integer;
  var Handled: Boolean);
begin
  inherited;
  VertPosition := VertPosition - WheelDelta;
  Handled := True;
end;

procedure TfrxScrollWin.KeyDown(var Key: Word; var KeyChar: System.WideChar;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    vkHome:
      VertPosition := 0;
    vkEnd:
      VertPosition := VertRange;
    vkUp:
      VertPosition := VertPosition - VScrollBar.SmallChange;
    vkDown:
      VertPosition := VertPosition + VScrollBar.SmallChange;
    vkLeft:
      HorzPosition := HorzPosition - HScrollBar.SmallChange;
    vkRight:
      HorzPosition := HorzPosition + HScrollBar.SmallChange;
    vkPrior:
      VertPosition := VertPosition - VScrollBar.ViewportSize;
    vkNext:
      VertPosition := VertPosition + VScrollBar.ViewportSize;
  end;
end;

procedure TfrxScrollWin.DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
begin
end;

procedure TfrxScrollWin.FreeStyle;
begin
  inherited;
  { Need to clear style objects }
  FVScrollBar := nil;
  FHScrollBar := nil;
end;

procedure TfrxScrollWin.OnHScrollChange(Sender: TObject);
begin
end;

procedure TfrxScrollWin.OnVScrollChange(Sender: TObject);
begin
end;

{ TfrxSplitter }

procedure TfrxSplitter.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
{$IFDEF DELPHI21}
  if Pressed and Assigned(FOnMove) then
{$ELSE}
  if FPressed and Assigned(FOnMove) then
{$ENDIF}
    FOnMove(Self);
end;


{ TfrxEditWithButton }

procedure TfrxEditButton.ApplyStyle;
var
  C: TFmxObject;
begin
  inherited;
  C := FindStyleResource('text');
  if Assigned(C) and (C is TText) then
  begin
    TText(C).OnPaint := DoContentPaint;
  end;
end;

procedure TfrxEditButton.DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
var
  i, dx, dy: Integer;
begin
  Canvas.Fill.Kind := TBrushKind.bkSolid;
  Canvas.Fill.Color := claGray;
  dx := Round(ARect.Width / 2) - 6;
  dy := Round(ARect.Height / 2) - 1;
  for i := 0 to 2 do
    Canvas.FillRect(RectF(ARect.Left + dx + i * 5, ARect.Top + dy, ARect.Left + 2 + dx + i * 5, ARect.Top + 2 + dy), 0, 0, allCorners, 1);
end;

constructor TfrxEditWithButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF DELPHI21}
  FButton := TEditButton.Create(Self);
  FButton.Text := '..';
  ButtonsContent.AddObject(FButton);
{$ELSE}
  FButton := TfrxEditButton.Create(Self);
  FButton.Parent := Self;
{$ENDIF}
  FButton.Width := 22;
  FButton.Height := 22;
  FButton.Align := TAlignLayout.alFitRight;
  FButton.OnClick := DoButtonClick;
end;

procedure TfrxEditWithButton.ApplyStyle;
var
  C: TFmxObject;
begin
  inherited;
  C := FindStyleResource('content');
  if Assigned(C) and (C is TLayout) then
  begin
    TLayout(C).Padding.Right := FButton.Width + 2;
  end;
end;

procedure TfrxEditWithButton.DoButtonClick(Sender: TObject);
begin
  if Assigned(FOnButtonClick) then
    FOnButtonClick(Self);
end;

{$IFDEF DELPHI21}
function TfrxEditWithButton.DefinePresentationName: String;
begin
  Result := TEDIT.ClassName;
  if (Length(Result) > 1) and (Result[1] = 'T') then
    Delete(Result, 1, 1);
  Result :=  Result + '-' + GetPresentationSuffix;
end;
{$ENDIF}

initialization
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TfrxSplitter, TFmxObject);
  GroupDescendentsWith(TfrxEditWithButton, TFmxObject);
  RegisterFmxClasses([TfrxSplitter, TfrxEditWithButton]);

end.
