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


unit FMX.frxBarcode2DView;

interface

{$I frx.inc}

uses
    System.SysUtils, System.Classes, System.UITypes, System.UIConsts,
    System.Types, FMX.Controls, FMX.Types, FMX.Objects, FMX.Forms, FMX.Dialogs,
    FMX.Menus, FMX.frxClass, FMX.frxdesgn, FMX.frxBarcodePDF417, FMX.frxBarcodeQR,
    FMX.frxBarcodeDataMatrix, FMX.frxBarcode2DBase, FMX.frxBarcodeProperties,
    System.Variants
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF}
{$IFDEF DELPHI20}
  , System.Math.Vectors
{$ENDIF};
type

  TfrxBarcodeType =
  (
      bc_datamatrix,
      bc_PDF417,
	  bcCodeQR
  );

[ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  Tfrx2DBarCodeObject = class(TComponent); // fake component

  TfrxBarcode2DView = class(TfrxView)
  private
    FBarCode: TfrxBarcode2DBase;
    FBarType: TfrxBarcodeType;
    FHAlign: TfrxHAlign;
    FProp : TUniqueProp;
	FExpression: String;
    procedure SetZoom(z: Double);
    function GetZoom : Double;
    procedure SetRotation(Value : Integer);
    function GetRotation: Integer;
    procedure SetShowText(Value: Boolean);
    function GetShowText: Boolean;
    procedure SetText(Value: String);
    function GetText: String;
    procedure SetFontScaled(Value: Boolean);
    function GetFontScaled: Boolean;
    procedure SetErrorText(Value: String);
    function GetErrorText: String;
    procedure SetQuiteZone(Value: Integer);
    function GetQuiteZone: Integer;
    procedure SetProp (Value: TUniqueProp);
    procedure SetBarType(Value: TfrxBarcodeType);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY : Extended); override;
    class function GetDescription: String; override;
	procedure GetData; override;
  published
	property Expression: String read FExpression write FExpression;
    property BarType: TfrxBarcodeType read FBarType write SetBarType;
    property BarProperties : TUniqueProp read FProp write SetProp;
    property BrushStyle;
    property Color;
    property Cursor;
    property DataField;
    property DataSet;
    property DataSetName;
    property Frame;
    property HAlign: TfrxHAlign read FHAlign write FHAlign default haLeft;
    property Rotation: Integer read GetRotation write SetRotation;
    property ShowText: Boolean read GetShowText write SetShowText;
    property TagStr;
    property Text: String read GetText write SetText;
    property URL;
    property Zoom: Double read GetZoom write SetZoom;
    property Font;
    property FontScaled: Boolean read GetFontScaled write SetFontScaled;
    property ErrorText: String read GetErrorText write SetErrorText;
    property QuiteZone: Integer read GetQuiteZone write SetQuiteZone;
  end;

implementation

uses
{$IFNDEF NO_EDITORS}
//    frxBarcodeEditor,
{$ENDIF}
    FMX.frxBarcode2DRTTI, FMX.frxDsgnIntf, FMX.frxRes, FMX.frxUtils;

{ TfrxBarcode2DView }

constructor TfrxBarcode2DView.Create(AOwner: TComponent);
begin
  inherited;
  FBarCode := TfrxBarcodePDF417.Create;
  FBarType := bc_PDF417;
  Font.AssignToFont(FBarCode.Font);
  Width := 0;
  Height := 0;
  FProp := TPDF417UniqueProperties.Create;
  FProp.SetWhose(FBarcode);
end;

destructor TfrxBarcode2DView.Destroy;
begin
  FBarCode.Free;
  FProp.free;
  inherited Destroy;
end;

procedure TfrxBarcode2DView.SetProp (Value: TUniqueProp);
begin
  FProp.Assign(Value);
end;

procedure TfrxBarcode2DView.SetBarType(Value: TfrxBarcodeType);
var
  tmp: TfrxBarcode2DBase;
  aReport: TfrxReport;
begin
  if FBarType = Value then exit;
  tmp := TfrxBarcode2DBase.Create;
  tmp.Assign(FBarcode);
  try
    if Value = bc_PDF417 then
    begin
      FBarType := Value;
      FBarCode.Free;
      FBarCode := TfrxBarcodePDF417.Create;
      FBarcode.Assign(tmp);
      FBarcode.PixelWidth := FBarcode.PixelHeight div 4;
      if FBarcode.PixelWidth < 1 then FBarcode.PixelWidth := 1;
      FProp.Free;
      FProp := TPDF417UniqueProperties.create;
      FProp.SetWhose(FBarCode);
    end
    else if Value = bc_datamatrix then
    begin
      FBarType := Value;
      FBarCode.Free;
      FBarCode := TfrxBarcodeDataMatrix.Create;
      FBarCode.Assign(tmp);
      FBarCode.PixelWidth := FBarCode.PixelHeight;
      FProp.Free;
      FProp := TDataMatrixUniqueProperties.Create;
      FProp.SetWhose(FBarCode);
    end
    else if Value = bcCodeQR then
    begin
      FBarType := Value;
      FBarCode.Free;
      FBarCode := TfrxBarcodeQR.Create;
      FProp.Free;
      FProp := TfrxQRProperties.Create;
      FProp.SetWhose(FBarCode);
    end;
    aReport := Self.Report;
    if (aReport <> nil) and (aReport.Designer <> nil) then
      aReport.Designer.UpdateInspector;
  finally
    tmp.Free;
  end;
end;

procedure TfrxBarcode2DView.SetZoom(z: Double);
begin
  FBarcode.Zoom := z;
end;

function TfrxBarcode2DView.GetZoom: Double;
begin
  Result := FBarcode.Zoom;
end;

procedure TfrxBarcode2DView.SetRotation(Value: Integer);
begin
  FBarcode.Rotation := Value;
end;

function TfrxBarcode2DView.GetRotation: Integer;
begin
  Result := FBarcode.Rotation;
end;

procedure TfrxBarcode2DView.SetShowText(Value : Boolean);
begin
  FBarcode.ShowText := Value;
end;

function TfrxBarcode2DView.GetShowText : Boolean;
begin
  Result := FBarcode.ShowText;
end;

procedure TfrxBarcode2DView.SetText(Value: String);
begin
  FBarcode.Text := Value;
end;

function TfrxBarcode2DView.GetText: String;
begin
  Result := FBarcode.Text;
end;

procedure TfrxBarcode2DView.SetFontScaled(Value: Boolean);
begin
  FBarcode.FontScaled := Value;
end;

function TfrxBarcode2DView.GetFontScaled: Boolean;
begin
  Result := FBarcode.FontScaled;
end;

procedure TfrxBarcode2DView.SetErrorText(Value: String);
begin
  FBarcode.ErrorText := Value;
end;

function TfrxBarcode2DView.GetErrorText: String;
begin
  Result := FBarcode.ErrorText;
end;

procedure TfrxBarcode2DView.SetQuiteZone(Value : Integer);
begin
  FBarcode.QuiteZone := Value;
end;

function TfrxBarcode2DView.GetQuiteZone: Integer;
begin
  Result := FBarcode.QuiteZone;
end;

procedure TfrxBarcode2DView.GetData;
begin
  inherited;
  if IsDataField then
    FBarcode.Text := VarToStr(DataSet.Value[DataField])
  else if FExpression <> '' then
    FBarcode.Text := VarToStr(Report.Calc(FExpression));
end;

class function TfrxBarcode2DView.GetDescription: String;
begin
  Result := frxResources.Get('2D Barcode');
end;

procedure TfrxBarcode2DView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  w, h, tmp: Extended;
  scaledFontCorrX, scaledFontCorrY: Integer;
  DrawRectA: TRectF;
begin
  case Round(Rotation) of
    0 .. 44:    Rotation := 0;
    45 .. 135:  Rotation := 90;
    136 .. 224: Rotation := 180;
    225 .. 315: Rotation := 270;
  else
    Rotation := 0;
  end;

  Font.AssignToFont(FBarCode.Font);
  FBarCode.FontColor := Font.Color;

  if Color = claNull then
    FBarCode.Color := claWhite
  else
    FBarCode.Color := Color;

  w := FBarCode.Width;
  h := FBarCode.Height;



  if FontScaled or (not ShowText) then
  begin
    scaledFontCorrX := 0;
    scaledFontCorrY := 0;
  end
  else
  begin
    scaledFontCorrY := FBarCode.GetFooterHeight;
    scaledFontCorrX := 0;
    if (Rotation = 90) or (Rotation = 270) then
    begin
      scaledFontCorrX := FBarCode.GetFooterHeight;
      scaledFontCorrY := 0;
    end;
  end;

  if (Rotation = 90) or (Rotation = 270) then
  begin
    tmp := w;
    w := h;
    h := tmp;
  end;

  Height := (h - scaledFontCorrY) * Zoom + scaledFontCorrY;
  Width := (w - scaledFontCorrX)  * Zoom + scaledFontCorrX;
  if Frame.DropShadow then
  begin
    Height := Height + round(Frame.ShadowWidth);
    Width := Width +  round(Frame.ShadowWidth);
  end;

  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);

  if FBarcode.ErrorText <> '' then
  begin
    with Canvas do
    begin
      Font.Family := 'Arial';
      Font.Size := Round(8 * ScaleY);
      Fill.Color := claRed;
      Stroke.Color := claBlack;
      DrawRectA := RectF(FX + 2, FY + 2, FX1, FY1);
      FillText(DrawRectA, ErrorText, True, 1, [], TTextAlign.taLeading, TTextAlign.taLeading);
      Exit;
    end;
  end;

  DrawBackground;
  FBarCode.Draw2DBarcode(Canvas, FScaleX, FScaleY, FX, FY, IsPrinting);
  DrawFrame;
end;

initialization
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TfrxBarcode2DView, TFmxObject);
  GroupDescendentsWith(Tfrx2DBarCodeObject, TFmxObject);
  frxObjects.RegisterObject1(TfrxBarcode2DView, nil, '', '', 0, 123);

finalization
  frxObjects.Unregister(TfrxBarcode2DView);


end.
