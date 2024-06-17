
{******************************************}
{                                          }
{             FastReport v4.0              }
{             Gradient object              }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxGradient;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.UIConsts, FMX.Types, FMX.frxClass
, System.Variants
{$IFDEF DELPHI18}
  ,FMX.Controls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};

type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxGradientObject = class(TComponent);  // fake component

  TfrxGradientStyle = (gsHorizontal, gsVertical, gsElliptic, gsRectangle,
    gsVertCenter, gsHorizCenter);

  TfrxGradientView = class(TfrxView)
  private
    FBeginColor: TAlphaColor;
    FEndColor: TAlphaColor;
    FStyle: TfrxGradientStyle;
    procedure DrawGradient(X, Y, X1, Y1: Integer);
    function GetColor: TAlphaColor;
    procedure SetColor(const Value: TAlphaColor);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    class function GetDescription: String; override;
  published
    property BeginColor: TAlphaColor read FBeginColor write FBeginColor default claWhite;
    property EndColor: TAlphaColor read FEndColor write FEndColor default claGray;
    property Style: TfrxGradientStyle read FStyle write FStyle;
    property Frame;
    property Color: TAlphaColor read GetColor write SetColor;
  end;


implementation

uses System.Math, FMX.frxGradientRTTI, FMX.frxDsgnIntf, FMX.frxRes;


constructor TfrxGradientView.Create(AOwner: TComponent);
begin
  inherited;
  FBeginColor := claWhite;
  FEndColor := claGray;
end;

class function TfrxGradientView.GetDescription: String;
begin
  Result := frxResources.Get('obGrad');
end;

function MulDiv(nNumber, nNumerator, nDenominator: Single): Single; overload; inline;
begin
  Result := (nNumber * nNumerator) / nDenominator;
end;

function MulDiv(nNumber, nNumerator, nDenominator: Double): Double; overload; inline;
begin
  Result := (nNumber * nNumerator) / nDenominator;
end;

function MulDiv(nNumber, nNumerator, nDenominator: Integer): Integer; overload; inline;
begin
  Result := (nNumber * nNumerator) div nDenominator;
end;

function RGB(r, g, b: Byte): TAlphaColor;
begin
  Result := (r or (g shl 8) or (b shl 16)) or $FF000000;
end;


procedure TfrxGradientView.DrawGradient(X, Y, X1, Y1: Integer);
var
  FromR, FromG, FromB: Cardinal;
  DiffR, DiffG, DiffB: Integer;
  ox, oy, dx, dy: Integer;

  procedure DoHorizontal(fr, fg, fb, dr, dg, db: Integer);
  var
    ColorRect: TRectF;
    I: Integer;
    R, G, B: Byte;
  begin
    ColorRect.Top := oy;
    ColorRect.Bottom := oy + dy;
    for I := 0 to 255 do
    begin
      ColorRect.Left := MulDiv (I, dx, 256) + ox;
      ColorRect.Right := MulDiv (I + 1, dx, 256) + ox;
      R := fr + MulDiv(I, dr, 255);
      G := fg + MulDiv(I, dg, 255);
      B := fb + MulDiv(I, db, 255);
      FCanvas.Fill.Color := RGB(R, G, B);
      FCanvas.FillRect(ColorRect, 0, 0, AllCorners, 1, TCornerType.ctBevel);
    end;
  end;

  procedure DoVertical(fr, fg, fb, dr, dg, db: Integer);
  var
    ColorRect: TRectF;
    I: Integer;
    R, G, B: Byte;
  begin
    ColorRect.Left := ox;
    ColorRect.Right := ox + dx;
    for I := 0 to 255 do
    begin
      ColorRect.Top := MulDiv (I, dy, 256) + oy;
      ColorRect.Bottom := MulDiv (I + 1, dy, 256) + oy;
      R := fr + MulDiv(I, dr, 255);
      G := fg + MulDiv(I, dg, 255);
      B := fb + MulDiv(I, db, 255);
      FCanvas.Fill.Color := RGB(R, G, B);
      FCanvas.FillRect(ColorRect, 0, 0, AllCorners, 1, TCornerType.ctBevel);
    end;
  end;

  procedure DoElliptic(fr, fg, fb, dr, dg, db: Integer);
  var
    I: Integer;
    R, G, B: Byte;
    Pw, Ph: Double;
    x1, y1, x2, y2: Double;
    bmp: TBitmap;
  begin
    bmp := TBitmap.Create(dx, dy);
    //bmp.Width := dx;
    //bmp.Height := dy;
//    bmp.Canvas.Stroke.Kind  := TBrushKind.;

    x1 := 0 - (dx / 4);
    x2 := dx + (dx / 4);
    y1 := 0 - (dy / 4);
    y2 := dy + (dy / 4);
    Pw := ((dx / 4) + (dx / 2)) / 155;
    Ph := ((dy / 4) + (dy / 2)) / 155;
    for I := 0 to 155 do
    begin
      x1 := x1 + Pw;
      x2 := X2 - Pw;
      y1 := y1 + Ph;
      y2 := y2 - Ph;
      R := fr + MulDiv(I, dr, 155);
      G := fg + MulDiv(I, dg, 155);
      B := fb + MulDiv(I, db, 155);
      bmp.Canvas.Fill.Color := R or (G shl 8) or (b shl 16);
      bmp.Canvas.FillEllipse(RectF(Trunc(x1), Trunc(y1), Trunc(x2), Trunc(y2)), 1);
    end;

//    FCanvas.DrawBitmap(ox, oy, bmp);
    FCanvas.DrawBitmap(bmp, RectF(0, 0, dx, dy), RectF(ox, oy, ox + dx, oy + dy), 1);
    bmp.Free;
  end;

  procedure DoRectangle(fr, fg, fb, dr, dg, db: Integer);
  var
    I: Integer;
    R, G, B: Byte;
    Pw, Ph: Real;
    x1, y1, x2, y2: Double;
  begin
    //FCanvas.Pen.Style := psClear;
    //FCanvas.Pen.Mode := pmCopy;
    x1 := 0 + ox;
    x2 := ox + dx;
    y1 := 0 + oy;
    y2 := oy + dy;
    Pw := (dx / 2) / 255;
    Ph := (dy / 2) / 255;
    for I := 0 to 255 do
    begin
      x1 := x1 + Pw;
      x2 := X2 - Pw;
      y1 := y1 + Ph;
      y2 := y2 - Ph;
      R := fr + MulDiv(I, dr, 255);
      G := fg + MulDiv(I, dg, 255);
      B := fb + MulDiv(I, db, 255);
      FCanvas.Fill.Color := RGB(R, G, B);

      FCanvas.FillRect(RectF(Integer(Trunc(x1)), Integer(Trunc(y1)), Integer(Trunc(x2)), Integer(Trunc(y2))), 0, 0, AllCorners, 1, TCornerType.ctBevel);
    end;
    //FCanvas.Pen.Style := psSolid;
  end;

  procedure DoVertCenter(fr, fg, fb, dr, dg, db: Integer);
  var
    ColorRect: TRectF;
    I: Integer;
    R, G, B: Byte;
    Haf: Integer;
  begin
    Haf := dy Div 2;
    ColorRect.Left := 0 + ox;
    ColorRect.Right := ox + dx;
    for I := 0 to Haf do
    begin
      ColorRect.Top := MulDiv(I, Haf, Haf) + oy;
      ColorRect.Bottom := MulDiv(I + 1, Haf, Haf) + oy;
      R := fr + MulDiv(I, dr, Haf);
      G := fg + MulDiv(I, dg, Haf);
      B := fb + MulDiv(I, db, Haf);
      FCanvas.Fill.Color := RGB(R, G, B);
      FCanvas.FillRect(ColorRect, 0, 0, AllCorners, 1, TCornerType.ctBevel);
      ColorRect.Top := dy - (MulDiv (I, Haf, Haf)) + oy;
      ColorRect.Bottom := dy - (MulDiv (I + 1, Haf, Haf)) + oy;
      FCanvas.FillRect(ColorRect, 0, 0, AllCorners, 1, TCornerType.ctBevel);
    end;
  end;

  procedure DoHorizCenter(fr, fg, fb, dr, dg, db: Integer);
  var
    ColorRect: TRectF;
    I: Integer;
    R, G, B: Byte;
    Haf: Integer;
  begin
    Haf := dx Div 2;
    ColorRect.Top := 0 + oy;
    ColorRect.Bottom := oy + dy;
    for I := 0 to Haf do
    begin
      ColorRect.Left := MulDiv(I, Haf, Haf) + ox;
      ColorRect.Right := MulDiv(I + 1, Haf, Haf) + ox;
      R := fr + MulDiv(I, dr, Haf);
      G := fg + MulDiv(I, dg, Haf);
      B := fb + MulDiv(I, db, Haf);
      FCanvas.Fill.Color := RGB(R, G, B);
      FCanvas.FillRect(ColorRect, 0, 0, AllCorners, 1, TCornerType.ctBevel);
      ColorRect.Left := dx - (MulDiv (I, Haf, Haf)) + ox;
      ColorRect.Right := dx - (MulDiv (I + 1, Haf, Haf)) + ox;
      FCanvas.FillRect(ColorRect, 0, 0, AllCorners, 1, TCornerType.ctBevel);
    end;
  end;

begin
  ox := X;
  oy := Y;
  dx := X1 - X;
  dy := Y1 - Y;
  FromR := FBeginColor and $000000ff;
  FromG := (FBeginColor shr 8) and $000000ff;
  FromB := (FBeginColor shr 16) and $000000ff;
  DiffR := (FEndColor and $000000ff) - FromR;
  DiffG := ((FEndColor shr 8) and $000000ff) - FromG;
  DiffB := ((FEndColor shr 16) and $000000ff) - FromB;

  case FStyle of
    gsHorizontal:
      DoHorizontal(FromR, FromG, FromB, DiffR, DiffG, DiffB);
    gsVertical:
      DoVertical(FromR, FromG, FromB, DiffR, DiffG, DiffB);
    gsElliptic:
      DoElliptic(FromR, FromG, FromB, DiffR, DiffG, DiffB);
    gsRectangle:
      DoRectangle(FromR, FromG, FromB, DiffR, DiffG, DiffB);
    gsVertCenter:
      DoVertCenter(FromR, FromG, FromB, DiffR, DiffG, DiffB);
    gsHorizCenter:
      DoHorizCenter(FromR, FromG, FromB, DiffR, DiffG, DiffB);
  end;
end;

procedure TfrxGradientView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  DrawGradient(FX, FY, FX1, FY1);
  DrawFrame;
end;

function TfrxGradientView.GetColor: TAlphaColor;
var
  R, G, B: Byte;
  FromR, FromG, FromB: Cardinal;
  DiffR, DiffG, DiffB: Integer;
begin
  FromR := FBeginColor and $000000ff;
  FromG := (FBeginColor shr 8) and $000000ff;
  FromB := (FBeginColor shr 16) and $000000ff;
  DiffR := (FEndColor and $000000ff) - FromR;
  DiffG := ((FEndColor shr 8) and $000000ff) - FromG;
  DiffB := ((FEndColor shr 16) and $000000ff) - FromB;
  R := FromR + Cardinal(MulDiv(127, DiffR, 255));
  G := FromG + Cardinal(MulDiv(127, DiffG, 255));
  B := FromB + Cardinal(MulDiv(127, DiffB, 255));
  result := RGB(R, G, B);
end;

procedure TfrxGradientView.SetColor(const Value: TAlphaColor);
begin
  inherited Color := value;
end;

initialization
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TfrxGradientObject, TFmxObject);
  frxObjects.RegisterObject1(TfrxGradientView, nil, '', '', 0, 141);

finalization
  frxObjects.UnRegister(TfrxGradientView);


end.
