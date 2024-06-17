{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{        2D Barcode Add-in object          }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxBarcode2DBase;
{$I frx.inc}

interface

uses
  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.UIConsts,
  System.Math,
  FMX.Types,
  FMX.Objects,
  FMX.frxPrinter
{$IFDEF DELPHI19}
    , FMX.Graphics, FMX.frxFMX
{$ENDIF}
{$IFDEF DELPHI20}
    , System.Math.Vectors
{$ENDIF};

type

  TfrxBarcode2DBase = class(TComponent)
  protected
    FImage: TBytes;
    FHeight: Integer;
    FWidth: Integer;
    FPixelWidth: Integer;
    FPixelHeight: Integer;
    FShowText: boolean;
    FRotation: Integer;
    FText: String;
    FZoom: Double;
    FFontScaled: boolean;
    FFont: TFont;
    FColor: TAlphaColor;
    FColorBar: TAlphaColor;
    FFontColor: TAlphaColor;
    FErrorText: String;
    FQuiteZone: Integer;

    procedure SetShowText(Value: boolean); virtual;
    procedure SetRotation(Value: Integer); virtual;
    procedure SetText(Value: String); virtual;
    procedure SetZoom(Value: Double); virtual;
    procedure SetFontScaled(Value: boolean); virtual;
    procedure SetFont(Value: TFont); virtual;
    procedure SetColor(Value: TAlphaColor); virtual;
    procedure SetColorBar(Value: TAlphaColor); virtual;
    procedure SetErrorText(Value: String); virtual;
    function GetWidth: Integer; virtual;
    function GetHeight: Integer; virtual;
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TfrxBarcode2DBase); reintroduce; virtual;
    function GetFooterHeight: Integer; virtual;
    procedure Draw2DBarcode(var Canvas: TCanvas; scalex, scaley: extended;
      x, y: Integer; IsPrinting: boolean = False); virtual;

    property ShowText: boolean read FShowText write SetShowText;
    property Rotation: Integer read FRotation write SetRotation;
    property Text: String read FText write SetText;
    property Zoom: Double read FZoom write SetZoom;
    property FontScaled: boolean read FFontScaled write SetFontScaled;
    property Font: TFont read FFont write SetFont;
    property Color: TAlphaColor read FColor write SetColor;
    property FontColor: TAlphaColor read FFontColor write FFontColor;
    property ColorBar: TAlphaColor read FColorBar write SetColorBar;
    property ErrorText: String read FErrorText write SetErrorText;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
    property PixelWidth: Integer read FPixelWidth write FPixelWidth;
    property PixelHeight: Integer read FPixelHeight write FPixelHeight;
    property QuiteZone: Integer read FQuiteZone write FQuiteZone;
  end;

const
  cbDefaultText = '12345678';

implementation

constructor TfrxBarcode2DBase.Create;
begin
  FWidth := 0;
  FHeight := 0;
  FImage := nil;
  FPixelWidth := 2;
  FPixelHeight := 2;
  FShowText := true;
  FRotation := 0;
  FText := cbDefaultText;
  FZoom := 1;
  FFontScaled := true;
  FColor := claWhite;
  FColorBar := claBlack;
  FFontColor := claBlack;
  FFont := TFont.Create;
  FFont.Family := 'Arial';
  FFont.Size := 9;
  FQuiteZone := 3;
end;

procedure TfrxBarcode2DBase.Assign(Source: TfrxBarcode2DBase);
begin
  FShowText := Source.FShowText;
  FRotation := Source.FRotation;
  FText := Source.FText;
  FZoom := Source.FZoom;
  FPixelWidth := Source.FPixelWidth;
  FPixelHeight := Source.FPixelHeight;
  FFontScaled := Source.FFontScaled;
  FFont.Assign(Source.FFont);
  FColor := Source.FColor;
  FColorBar := Source.FColorBar;
  FErrorText := Source.FErrorText;
  FQuiteZone := Source.FQuiteZone;
end;

procedure TfrxBarcode2DBase.SetShowText(Value: boolean);
begin
  FShowText := Value;
end;

procedure TfrxBarcode2DBase.SetRotation(Value: Integer);
begin
  FRotation := Value;
end;

procedure TfrxBarcode2DBase.SetText(Value: String);
begin
  if (FText <> Value) then
    FText := Value;
end;

procedure TfrxBarcode2DBase.SetZoom(Value: Double);
begin
  FZoom := Value;
end;

procedure TfrxBarcode2DBase.SetFontScaled(Value: boolean);
begin
  FFontScaled := Value;
end;

procedure TfrxBarcode2DBase.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TfrxBarcode2DBase.SetColor(Value: TAlphaColor);
begin
  FColor := Value;
end;

procedure TfrxBarcode2DBase.SetColorBar(Value: TAlphaColor);
begin
  FColorBar := Value;
end;

procedure TfrxBarcode2DBase.SetErrorText(Value: String);
begin
  FErrorText := Value;
end;

function TfrxBarcode2DBase.GetFooterHeight: Integer;
begin
  result := Round(Font.Size * 96 / 72) * 2 div 4;
end;

function TfrxBarcode2DBase.GetWidth: Integer;
begin
  result := Round(FWidth * FPixelWidth + FQuiteZone * 2);
end;

function TfrxBarcode2DBase.GetHeight: Integer;
begin
  if FShowText then
    result := Round(FHeight * FPixelHeight + Round(Font.Size * 96 / 72 * 2) / 4
      + FQuiteZone * 2)
  else
    result := Round(FHeight * FPixelHeight + FQuiteZone * 2);
end;

destructor TfrxBarcode2DBase.Destroy;
begin
  FreeAndNil(FFont);
  SetLength(FImage, 0);
  inherited;
end;

procedure TfrxBarcode2DBase.Draw2DBarcode(var Canvas: TCanvas;
  scalex, scaley: extended; x, y: Integer; IsPrinting: boolean = False);
var
  stride, p, k, j, b: Integer;
  dx, dy, textLeftOffset, textSemiLength, footerHeight, saveFooter, paddingX,
    paddingY, x1, y1, x2, y2, txtX, txtY, e: Single;
  kx, ky, saveKX, saveKY: extended;
  flag: boolean;
  bmp: TBitmap;
  r, TextRect: TRectF;
  state: TCanvasSaveState;
  m, OldM: TMatrix;

begin
  kx := scalex * Zoom;
  ky := scaley * Zoom;
  x1 := 0;
  x2 := 0;
  y1 := 0;
  y2 := 0;
  footerHeight := 0;
  dy := Round(FHeight * PixelHeight * ky);
  dx := Round(FWidth * PixelWidth * kx);
  paddingX := Round(FQuiteZone * kx);
  paddingY := Round(FQuiteZone * ky);

  if ShowText then
  begin
    Canvas.Font.Assign(FFont);


    // Canvas.Font.Size := Canvas.Font.Size * ScaleY;

    textSemiLength := Canvas.TextWidth(Text) / 2;
    footerHeight := (Round(Font.Size * 96 / 72) + 4) * Zoom * scaley;
    // + Round(Font.Size * 96 / 72);
    if not IsPrinting then
      Canvas.Font.Size := (FFont.Size * Zoom * scaley);

    case Round(Rotation) of
      0:
        begin
          x1 := x;
          y1 := y + dy;
          x2 := x + dx;
          y2 := y + dy + footerHeight;
          textLeftOffset := dx / 2 - textSemiLength;
          if textLeftOffset < 0 then
            textLeftOffset := 0;
          txtX := x + textLeftOffset;
          txtY := y + dy
        end;
      90:
        begin
          x1 := x + dy;
          x2 := x + dy + footerHeight;
          y1 := y;
          y2 := y + dx;
          textLeftOffset := dx / 2 - textSemiLength;
          if textLeftOffset < 0 then
            textLeftOffset := 0;
          txtX := x1;
          txtY := y2 - textLeftOffset;
        end;
      180:
        begin
          x1 := x;
          x2 := x + dx;
          y1 := y;
          y2 := y + footerHeight;
          textLeftOffset := dx / 2 - textSemiLength;
          if textLeftOffset < 0 then
            textLeftOffset := 0;
          txtX := x + dx - textLeftOffset;
          txtY := y + footerHeight;
        end;
      270:
        begin
          x1 := x;
          x2 := x + footerHeight;
          y1 := y;
          y2 := y + dx;
          textLeftOffset := dx / 2 - textSemiLength;
          if textLeftOffset < 0 then
            textLeftOffset := 0;
          txtX := x1 + footerHeight;
          txtY := y1 + textLeftOffset;
        end;

    end;

    OldM := Canvas.Matrix;
    state := Canvas.SaveState;
    try
      TextRect := RectF(x1 + paddingX, y1 + paddingY, x2 + paddingX,
        y2 + paddingY);
      if FRotation > 0 then
      begin
        m := CreateRotationMatrix(-DegToRad(FRotation));
        m.m31 := OldM.m31 + TextRect.Left + TextRect.Width / 2;
        m.m32 := OldM.m32 + TextRect.Top + TextRect.Height / 2;
        Canvas.SetMatrix(m);

        e := TextRect.Width;
        TextRect.Left := -TextRect.Width / 2;
        TextRect.Right := TextRect.Left + e;
        e := TextRect.Height;
        TextRect.Top := -TextRect.Height / 2;
        TextRect.Bottom := TextRect.Top + e;

        if ((FRotation >= 90) and (FRotation < 180)) or
          ((FRotation >= 270) and (FRotation < 360)) then
          TextRect := RectF(TextRect.Top, TextRect.Left, TextRect.Bottom,
            TextRect.Right);
      end;
      Canvas.Fill.Color := FFontColor;
      Canvas.FillText(TextRect, Text, False, 1, [], TTextAlign.taCenter,
        TTextAlign.taLeading);

    finally
      Canvas.RestoreState(state);
      Canvas.SetMatrix(OldM);
    end;

  end;

  stride := (FWidth + 7) div 8;

  saveKX := 0;
  bmp := nil;
  if (kx < 1) or (ky < 1) then
  begin
    saveKX := kx;
    saveKY := ky;
    saveFooter := footerHeight;
    kx := 1;
    ky := 1;
    footerHeight := 0;
    bmp := TBitmap.Create(FWidth * PixelWidth, FHeight * PixelHeight);
    if (Rotation = 90) or (Rotation = 270) then
    begin
      bmp.Height := FWidth * PixelWidth;
      bmp.Width := FHeight * PixelHeight;
    end;
    dy := Round(FHeight * PixelHeight);
    dx := Round(FWidth * PixelWidth);
    bmp.Canvas.BeginScene();
  end;
  try

  for k := 0 to FHeight - 1 do
  begin
    p := k * stride;
    for j := 0 to FWidth - 1 do
    begin
      b := FImage[p + (j div 8)] and $FF;
      b := b shl (j mod 8);

      if (b and $80) = 0 then
      begin
        if (saveKX <> 0) then
          bmp.Canvas.Fill.Color := claWhite
        else
          Canvas.Fill.Color := claWhite;
      end
      else
      begin
        if (saveKX <> 0) then
          bmp.Canvas.Fill.Color := claBlack
        else
          Canvas.Fill.Color := claBlack;
      end;

      case Round(Rotation) of
        0:
          begin
            x1 := Round(x + j * PixelWidth * kx);
            y1 := Round(y + k * PixelHeight * ky);
            x2 := Round(x + j * PixelWidth * kx + PixelWidth * kx);
            y2 := Round(y + k * PixelHeight * ky + PixelHeight * ky);
          end;
        90:
          begin
            x1 := Round(x + k * PixelHeight * kx);
            x2 := Round(x + k * PixelHeight * kx + PixelHeight * kx);
            y1 := Round(y + dx - j * PixelWidth * ky);
            y2 := Round(y + dx - j * PixelWidth * ky - PixelWidth * ky);
          end;
        180:
          begin
            x1 := Round(x + dx - j * PixelWidth * kx);
            x2 := Round(x + dx - j * PixelWidth * kx - PixelWidth * kx);
            y1 := Round(y + footerHeight + dy - k * PixelHeight * ky);
            y2 := Round(y + footerHeight + dy - k * PixelHeight * ky -
              PixelHeight * ky);
          end;
        270:
          begin
            x1 := Round(x + footerHeight + dy - k * PixelHeight * kx);
            x2 := Round(x + footerHeight + dy - k * PixelHeight * kx -
              PixelHeight * kx);
            y1 := Round(y + j * PixelWidth * ky);
            y2 := Round(y + j * PixelWidth * ky + PixelWidth * ky);
          end;

      end;

      if (saveKX = 0) then
        Canvas.FillRect(RectF(x1 + paddingX, y1 + paddingY, x2 + paddingX,
          y2 + paddingY), 0, 0, allCorners, 1)
      else
        bmp.Canvas.FillRect(RectF(x1 - x + paddingX, y1 - y + paddingY,
          x2 - x + paddingX, y2 - y + paddingY), 0, 0, allCorners, 1);

    end
  end;

    if (saveKX <> 0) then
    begin
      bmp.Canvas.EndScene;
      case Round(Rotation) of
        0:
          begin
            x1 := 0;
            y1 := 0;
            x2 := Round(FWidth * PixelWidth * saveKX);
            y2 := Round(FHeight * PixelHeight * saveKY);
          end;
        90:
          begin
            x1 := 0;
            y1 := 0;
            x2 := Round(FHeight * PixelHeight * saveKY);
            y2 := Round(FWidth * PixelWidth * saveKX);
          end;
        180:
          begin
            x1 := 0;
            y1 := saveFooter;
            x2 := Round(FWidth * PixelWidth * saveKX);
            y2 := Round(FHeight * PixelHeight * saveKY);
          end;
        270:
          begin
            x1 := saveFooter;
            y1 := 0;
            x2 := Round(FHeight * PixelHeight * saveKY);
            y2 := Round(FWidth * PixelWidth * saveKX);
          end;
      end;
      r := RectF(x, y, x + x1 + x2 + paddingX, y + y1 + y2 + paddingY);
      Canvas.DrawBitmap(bmp, RectF(0, 0, bmp.Width, bmp.Height), r, 1, False);
    end;
  finally
    if Assigned(bmp) then
      FreeAndNil(bmp);
  end;

end;

end.
