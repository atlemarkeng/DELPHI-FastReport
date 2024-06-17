{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{          Barcode Add-in object           }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxBarcode;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.Types, System.UIConsts, FMX.Types,
  FMX.Objects, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Menus, FMX.frxBarcod,
  FMX.frxClass, System.Variants
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF}
{$IFDEF DELPHI20}
  , System.Math.Vectors
{$ENDIF};


type
[ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxBarCodeObject = class(TComponent);  // fake component


  TfrxBarCodeView = class(TfrxView)
  private
    FBarCode: TfrxBarCode;
    FBarType: TfrxBarcodeType;
    FCalcCheckSum: Boolean;
    FExpression: String;
    FHAlign: TfrxHAlign;
    FRotation: Integer;
    FShowText: Boolean;
    FText: String;
    FWideBarRatio: Double;
    FZoom: Double;
    procedure BcFontChanged(Sender: TObject);
    procedure SetRotation(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure GetData; override;
    class function GetDescription: String; override;
    function GetRealBounds: TfrxRect; override;
    property BarCode: TfrxBarCode read FBarCode;
  published
    property BarType: TfrxBarcodeType read FBarType write FBarType;
    property BrushStyle;
    property CalcCheckSum: Boolean read FCalcCheckSum write FCalcCheckSum default False;
    property Color;
    property Cursor;
    property DataField;
    property DataSet;
    property DataSetName;
    property Expression: String read FExpression write FExpression;
    property Frame;
    property HAlign: TfrxHAlign read FHAlign write FHAlign default haLeft;
    property Rotation: Integer read FRotation write SetRotation;
    property ShowText: Boolean read FShowText write FShowText default True;
    property TagStr;
    property Text: String read FText write FText;
    property URL;
    property WideBarRatio: Double read FWideBarRatio write FWideBarRatio;
    property Zoom: Double read FZoom write FZoom;
    property Font;
  end;


implementation

uses
{$IFNDEF NO_EDITORS}
  FMX.frxBarcodeEditor,
{$ENDIF}
  FMX.frxBarcodeRTTI, FMX.frxDsgnIntf, FMX.frxRes, FMX.frxUtils, FMX.frxPrinter;

const
  cbDefaultText = '12345678';


{ TfrxBarCodeView }

constructor TfrxBarCodeView.Create(AOwner: TComponent);
begin
  inherited;
  FBarCode := TfrxBarCode.Create(nil);
  FBarType := bcCode39;
  FShowText := True;
  FZoom := 1;
  FText := cbDefaultText;
  FWideBarRatio := 2;
  Font.Name := 'Arial';
  Font.Size := 9;
  Font.OnChange := BcFontChanged;
end;

destructor TfrxBarCodeView.Destroy;
begin
  FBarCode.Free;
  inherited Destroy;
end;

class function TfrxBarCodeView.GetDescription: String;
begin
  Result := frxResources.Get('obBarC');
end;

procedure TfrxBarCodeView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  SaveWidth: Extended;
  ErrorText: String;
  DrawRectA: TRectF;
  CorrL, CorrR: Integer;
  OutRect: TRect;
begin
  FBarCode.Angle := FRotation;
  Font.AssignToFont(FBarCode.Font);
  FBarCode.Font.Size := FBarCode.Font.Size * FZoom;
  FBarCode.FontColor := Font.Color;
  FBarCode.Checksum := FCalcCheckSum;
  FBarCode.Typ := FBarType;
  FBarCode.Ratio := FWideBarRatio;
  if Color = claNull then
    FBarCode.Color := claWhite else
    FBarCode.Color := Color;

  SaveWidth := Width;

  FBarCode.Text := AnsiString(FText);
  ErrorText := '';
  if FZoom < 0.0001 then
    FZoom := 1;

  { frame correction for some bacrode types }
  if FBarCode.Typ in [bcCodeUPC_E0, bcCodeUPC_E1, bcCodeUPC_A] then
    CorrR := 9
  else
    CorrR := 0;
  if FBarCode.Typ in [bcCodeEAN13, bcCodeUPC_A] then
    CorrL := 8
  else
    CorrL := 0;

  try
    if (FRotation = 0) or (FRotation = 180) then
      Width := (FBarCode.Width + CorrL + CorrR) * FZoom
    else
      Height := (FBarCode.Width + CorrL + CorrR) * FZoom;
  except
    on e: Exception do
    begin
      FBarCode.Text := '12345678';
      ErrorText := e.Message;
    end;
  end;

  if FHAlign = haRight then
    Left := Left + SaveWidth - Width
  else if FHAlign = haCenter then
    Left := Left + (SaveWidth - Width) / 2;

  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);

  DrawBackground;
   if (FRotation = 0) or (FRotation = 180) then
      OutRect := Rect(FX + Round(CorrL * ScaleX) , FY, FX1 - Round(CorrR * ScaleX), FY1)
    else
      OutRect := Rect(FX, FY + Round(CorrL * ScaleX) , FX1, FY1 - Round(CorrR * ScaleX));
  if ErrorText = '' then
    FBarCode.DrawBarcode(Canvas, OutRect, FShowText, ScaleY, IsPrinting)
  else
    with Canvas do
    begin
      Font.Family := 'Arial';
      Font.Size := Round(8 * ScaleY);
      Fill.Color := claRed;
      DrawRectA := RectF(FX + 2, FY + 2, FX1, FY1);
      FillText(DrawRectA, ErrorText, True, 1, [], TTextAlign.taLeading, TTextAlign.taLeading);
    end;
  DrawFrame;
end;

procedure TfrxBarCodeView.GetData;
begin
  inherited;
  if IsDataField then
    FText := VarToStr(DataSet.Value[DataField])
  else if FExpression <> '' then
    FText := VarToStr(Report.Calc(FExpression));
end;

function TfrxBarCodeView.GetRealBounds: TfrxRect;
var
  extra1, extra2, txtWidth: Single;
  bmp: TBitmap;
begin
  bmp := TBitmap.Create(1,1);
  Draw(bmp.Canvas, 1, 1, 0, 0);

  Result := inherited GetRealBounds;
  extra1 := 0;
  extra2 := 0;

  if (FRotation = 0) or (FRotation = 180) then
  begin
    Font.AssignToCanvas(bmp.Canvas);
    with bmp.Canvas do
    begin
      {Font.Name := 'Arial';
      Font.Size := 9;
      Font.Style := []; }
      //Font.Assign(Self.Font);
      txtWidth := TextWidth(String(FBarcode.Text));
      if Width < txtWidth then
      begin
        extra1 := Round((txtWidth - Width) / 2) + 2;
        extra2 := extra1;
      end;
    end;
  end;

  if FBarType in [bcCodeEAN13, bcCodeUPC_A] then
    extra1 := 8;
  if FBarType in [bcCodeUPC_A, bcCodeUPC_E0, bcCodeUPC_E1] then
    extra2 := 8;
  case FRotation of
    0:
      begin
        Result.Left := Result.Left - extra1;
        Result.Right := Result.Right + extra2;
      end;
    90:
      begin
        Result.Bottom := Result.Bottom + extra1;
        Result.Top := Result.Top - extra2;
      end;
    180:
      begin
        Result.Left := Result.Left - extra2;
        Result.Right := Result.Right + extra1;
      end;
    270:
      begin
        Result.Bottom := Result.Bottom + extra2;
        Result.Top := Result.Top - extra1;
      end;
  end;

  bmp.Free;
end;

procedure TfrxBarCodeView.SetRotation(const Value: Integer);
begin
  case Round(Value) of
    0 .. 44:    FRotation := 0;
    45 .. 135:  FRotation := 90;
    136 .. 224: FRotation := 180;
    225 .. 315: FRotation := 270;
  else
    FRotation := 0;
  end;
end;

procedure TfrxBarCodeView.BcFontChanged(Sender: TObject);
begin
  if Font.Size > 9 then Font.Size := 9;
end;

initialization
  StartClassGroup(TfmxObject);
  ActivateClassGroup(TfmxObject);
  //GroupDescendentsWith(TfrxBarCodeView, TfmxObject);
  GroupDescendentsWith(TfrxBarCodeObject, TfmxObject);
  RegisterFmxClasses([TfrxBarCodeObject]);
  frxObjects.RegisterObject1(TfrxBarCodeView, nil, '', '', 0, 123);

finalization
  frxObjects.UnRegister(TfrxBarCodeView);

end.


//56db3b0f55102b9488a240d37950543f