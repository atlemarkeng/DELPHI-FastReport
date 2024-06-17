unit FMX.frxBarcodeProperties;

interface

uses
    System.SysUtils, System.Classes, System.UITypes, FMX.Types, FMX.Objects,
    System.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Menus,
    FMX.frxClass, FMX.frxdesgn, FMX.frxBarcodePDF417, FMX.frxBarcodeDataMatrix,
    FMX.frxBarcode2DBase, FMX.DelphiZXingQRCode, FMX.frxBarcodeQR;

type

{$M+}
    TUniqueProp = class (TPersistent)

    private

      FOnChange: TNotifyEvent;

    public
      FWhose : TObject;
      procedure Changed;
      procedure Assign(Source: TPersistent); override; abstract;
      procedure SetWhose( w : TObject);

    end;


    TPDF417UniqueProperties = class( TUniqueProp )

    private


        function GetAspectRatio : Double;
        function GetColumns : integer;
        function GetRows : integer;
        function GetErrorCorrection : PDF417ErrorCorrection;
        function GetCodePage : integer;
        function GetCompactionMode : PDF417CompactionMode;
        function GetPixelWidth : integer;
        function GetPixelHeight : integer;

        procedure SetAspectRatio(v : Double);
        procedure SetColumns(v : integer);
        procedure SetRows(v : integer);
        procedure SetErrorCorrection(v : PDF417ErrorCorrection);
        procedure SetCodePage(v : integer);
        procedure SetCompactionMode(v : PDF417CompactionMode);
        procedure SetPixelWidth(v : integer);
        procedure SetPixelHeight(v : integer);


    public

      procedure Assign(Source: TPersistent); override;

    published

        property AspectRatio : Double read GetAspectRatio write SetAspectRatio;
        property Columns : integer read GetColumns write SetColumns;
        property Rows : integer read GetRows write SetRows;
        property ErrorCorrection : PDF417ErrorCorrection read GetErrorCorrection write SetErrorCorrection;
        property CodePage : integer read GetCodePage write SetCodePage;
        property CompactionMode : PDF417CompactionMode read GetCompactionMode write SetCompactionMode;
        property PixelWidth : integer read GetPixelWidth write SetPixelWidth;
        property PixelHeight : integer read GetPixelHeight write SetPixelHeight;

    end;

  TDataMatrixUniqueProperties = class( TUniqueProp )

    private


        function GetCodePage    : integer;
        function GetPixelSize   : integer;
        function GetSymbolSize  : DatamatrixSymbolSize;
        function GetEncoding    : DatamatrixEncoding;

        procedure SetCodePage(v : integer);
        procedure SetPixelSize(v : integer);
        procedure SetSymbolSize(v : DatamatrixSymbolSize);
        procedure SetEncoding(v : DatamatrixEncoding);


    public

      procedure Assign(Source: TPersistent); override;

    published

        property CodePage : integer read GetCodePage write SetCodePage;
        property PixelSize : integer read GetPixelSize write SetPixelSize;
        property SymbolSize : DatamatrixSymbolSize read GetSymbolSize write SetSymbolSize;
        property Encoding : DatamatrixEncoding read GetEncoding write SetEncoding;

    end;

  TfrxQRProperties = class( TUniqueProp )
  private
    function GetEncoding: TQRCodeEncoding;
    function GetQuietZone: Integer;
    function GetPixelSize   : integer;
    procedure SetPixelSize(v : integer);
    procedure SetEncoding(const Value: TQRCodeEncoding);
    procedure SetQuietZone(const Value: Integer);
    function GetErrorLevels: TQRErrorLevels;
    procedure SetErrorLevels(const Value: TQRErrorLevels);
    function GetCodePage: Longint;
    procedure SetCodePage(const Value: Longint);

    public

      procedure Assign(Source: TPersistent); override;

    published

      property Encoding: TQRCodeEncoding read GetEncoding write SetEncoding;
      property QuietZone: Integer read GetQuietZone write SetQuietZone;
      property ErrorLevels: TQRErrorLevels read GetErrorLevels write SetErrorLevels;
      property PixelSize : integer read GetPixelSize write SetPixelSize;
      property CodePage : Longint read GetCodePage write SetCodePage;

    end;

implementation

procedure TUniqueProp.SetWhose( w : TObject);
begin
    FWhose := w;
end;

procedure TUniqueProp.Changed;
begin
  if @FOnChange <> nil then FOnChange(Self);
end;

procedure TPDF417UniqueProperties.Assign(Source: TPersistent);
var
  src : TPDF417UniqueProperties;
begin
    if Source is TPDF417UniqueProperties then
    begin
        src := TPDF417UniqueProperties(Source);
        SetAspectRatio(src.AspectRatio);
        SetColumns(src.Columns);
        SetRows(src.Rows);
        SetErrorCorrection(src.ErrorCorrection);
        SetCodePage(src.Codepage);
        SetCompactionMode(src.CompactionMode);
        SetPixelWidth(src.PixelWidth);
        SetPixelHeight(src.PixelHeight);
        SetWhose(src.FWhose);
    end
    else
       inherited;
end;

function TPDF417UniqueProperties.GetAspectRatio : Double;
begin
    result := TfrxBarcodePDF417(FWhose).AspectRatio;
end;
function TPDF417UniqueProperties.GetColumns : integer;
begin
    result := TfrxBarcodePDF417(FWhose).Columns;
end;
function TPDF417UniqueProperties.GetRows : integer;
begin
    result := TfrxBarcodePDF417(FWhose).Rows;
end;
function TPDF417UniqueProperties.GetErrorCorrection : PDF417ErrorCorrection;
begin
    result := TfrxBarcodePDF417(FWhose).ErrorCorrection;
end;
function TPDF417UniqueProperties.GetCodePage : integer;
begin
    result := TfrxBarcodePDF417(FWhose).CodePage;
end;
function TPDF417UniqueProperties.GetCompactionMode : PDF417CompactionMode;
begin
    result := TfrxBarcodePDF417(FWhose).CompactionMode;
end;
function TPDF417UniqueProperties.GetPixelHeight : integer;
begin
    result := TfrxBarcodePDF417(FWhose).PixelHeight;
end;
function TPDF417UniqueProperties.GetPixelWidth : integer;
begin
    result := TfrxBarcodePDF417(FWhose).PixelWidth;
end;
procedure TPDF417UniqueProperties.SetAspectRatio(v : Double);
begin
    TfrxBarcodePDF417(FWhose).AspectRatio := v;
end;
procedure TPDF417UniqueProperties.SetColumns(v : integer);
begin
    TfrxBarcodePDF417(FWhose).Columns := v;
end;
procedure TPDF417UniqueProperties.SetRows(v : integer);
begin
    TfrxBarcodePDF417(FWhose).Rows := v;
end;
procedure TPDF417UniqueProperties.SetErrorCorrection(v : PDF417ErrorCorrection);
begin
    TfrxBarcodePDF417(FWhose).ErrorCorrection := v;
end;
procedure TPDF417UniqueProperties.SetCodePage(v : integer);
begin
    TfrxBarcodePDF417(FWhose).CodePage := v;
end;
procedure TPDF417UniqueProperties.SetCompactionMode(v : PDF417CompactionMode);
begin
    TfrxBarcodePDF417(FWhose).CompactionMode := v;
end;
procedure TPDF417UniqueProperties.SetPixelWidth(v : integer);
begin
    TfrxBarcodePDF417(FWhose).PixelWidth := v;
end;
procedure TPDF417UniqueProperties.SetPixelHeight(v : integer);
begin
    TfrxBarcodePDF417(FWhose).PixelHeight := v;
end;

////////////////////////////////////////////////////////////////////////////////////////

function TDataMatrixUniqueProperties.GetCodePage    : integer;begin result := TfrxBarcodeDataMatrix(FWhose).CodePage; end;
function TDataMatrixUniqueProperties.GetPixelSize   : integer;begin result := TfrxBarcodeDataMatrix(FWhose).PixelSize; end;
function TDataMatrixUniqueProperties.GetSymbolSize  : DatamatrixSymbolSize;begin result := TfrxBarcodeDataMatrix(FWhose).SymbolSize; end;
function TDataMatrixUniqueProperties.GetEncoding    : DatamatrixEncoding;begin result := TfrxBarcodeDataMatrix(FWhose).Encoding; end;

procedure TDataMatrixUniqueProperties.SetCodePage(v : integer);begin TfrxBarcodeDataMatrix(FWhose).CodePage := v;end;
procedure TDataMatrixUniqueProperties.SetPixelSize(v : integer);
begin
    if v < 2 then v := 2;  TfrxBarcodeDataMatrix(FWhose).PixelSize := v;end;
procedure TDataMatrixUniqueProperties.SetSymbolSize(v : DatamatrixSymbolSize);begin TfrxBarcodeDataMatrix(FWhose).SymbolSize := v;end;
procedure TDataMatrixUniqueProperties.SetEncoding(v : DatamatrixEncoding);begin TfrxBarcodeDataMatrix(FWhose).Encoding := v;end;

procedure TDataMatrixUniqueProperties.Assign(Source: TPersistent);
var
  src : TDataMatrixUniqueProperties;
begin
    if Source is TDataMatrixUniqueProperties then
    begin
        src := TDataMatrixUniqueProperties(Source);
        SetCodePage(src.CodePage);
        SetPixelSize(src.PixelSize);
        SetSymbolSize(src.SymbolSize);
        SetEncoding(src.Encoding);
    end
    else
       inherited;
end;



{ TfrxQRProperties }

procedure TfrxQRProperties.Assign(Source: TPersistent);
var
  src : TfrxQRProperties;
begin
    if Source is TfrxQRProperties then
    begin
        src := TfrxQRProperties(Source);
        SetEncoding(src.Encoding);
        SetQuietZone(src.QuietZone);
        SetErrorLevels(src.ErrorLevels);
        SetCodePage(src.CodePage);
    end
    else
       inherited;
end;

function TfrxQRProperties.GetCodePage: Longint;
begin
  Result := TfrxBarcodeQR(FWhose).Codepage;
end;

function TfrxQRProperties.GetEncoding: TQRCodeEncoding;
begin
  Result := TfrxBarcodeQR(FWhose).Encoding;
end;

function TfrxQRProperties.GetErrorLevels: TQRErrorLevels;
begin
  Result := TfrxBarcodeQR(FWhose).ErrorLevels;
end;

function TfrxQRProperties.GetQuietZone: Integer;
begin
  Result := TfrxBarcodeQR(FWhose).QuietZone;
end;

procedure TfrxQRProperties.SetCodePage(const Value: Longint);
begin
  TfrxBarcodeQR(FWhose).Codepage := Value;
end;

procedure TfrxQRProperties.SetEncoding(const Value: TQRCodeEncoding);
begin
  TfrxBarcodeQR(FWhose).Encoding := Value;
end;

procedure TfrxQRProperties.SetErrorLevels(const Value: TQRErrorLevels);
begin
  TfrxBarcodeQR(FWhose).ErrorLevels := Value;
end;

procedure TfrxQRProperties.SetQuietZone(const Value: Integer);
begin
  TfrxBarcodeQR(FWhose).QuietZone := Value;
end;

function TfrxQRProperties.GetPixelSize: integer;
begin
  result := TfrxBarcodeQR(FWhose).PixelSize;
end;

procedure TfrxQRProperties.SetPixelSize(v : integer);
begin
  if v < 2 then v := 2;
  TfrxBarcodeQR(FWhose).PixelSize := v;
end;

end.


//56db3b0f55102b9488a240d37950543f