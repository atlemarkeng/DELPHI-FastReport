
{******************************************}
{                                          }
{             FastReport v4.0              }
{                 Printer                  }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxPrinter;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.Classes, System.SysUtils, System.Types, System.UITypes, System.Variants,
  FMX.Types
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};


type

  TfrxCustomPrinter = class(TObject)
  protected
    FBin: Integer;
    FDuplex: Integer;
    FBins: TStrings;
    FCanvas: TCanvas;
    FDefOrientation: TPrinterOrientation;
    FDefPaper: Integer;
    FDefPaperHeight: Double;
    FDefPaperWidth: Double;
    FDefDuplex: Integer;
    FDefBin: Integer;
    FDPI: TPoint;
    FFileName: String;
    FHandle: THandle;
    FInitialized: Boolean;
    FName: String;
    FPaper: Integer;
    FPapers: TStrings;
    FPaperHeight: Double;
    FPaperWidth: Double;
    FLeftMargin: Double;
    FTopMargin: Double;
    FRightMargin: Double;
    FBottomMargin: Double;
    FOrientation: TPrinterOrientation;
    FPort: String;
    FPrinting: Boolean;
    FTitle: String;
  public
    constructor Create(const AName, APort: String); virtual;
    destructor Destroy; override;
    procedure Init; virtual; abstract;
    procedure Abort; virtual; abstract;
    procedure BeginDoc; virtual; abstract;
    procedure BeginPage; virtual; abstract;
    procedure BeginRAWDoc; virtual; abstract;
    procedure EndDoc; virtual; abstract;
    procedure EndPage; virtual; abstract;
    procedure EndRAWDoc; virtual; abstract;
    procedure WriteRAWDoc(const buf: AnsiString); virtual; abstract;

    function BinIndex(ABin: Integer): Integer;
    function PaperIndex(APaper: Integer): Integer;
    function BinNameToNumber(const ABin: String): Integer;
    function PaperNameToNumber(const APaper: String): Integer;
    procedure SetViewParams(APaperSize: Integer;
      APaperWidth, APaperHeight: Extended;
      AOrientation: TPrinterOrientation); virtual; abstract;
    procedure SetPrintParams(APaperSize: Integer;
      APaperWidth, APaperHeight: Extended; AOrientation: TPrinterOrientation;
      ABin, ADuplex, ACopies: Integer); virtual; abstract;
    procedure PropertiesDlg; virtual; abstract;
    function ShowPrintDialog: Boolean; virtual; abstract;

    property Bin: Integer read FBin;
    property Duplex: Integer read FDuplex;
    property Bins: TStrings read FBins;
    property Canvas: TCanvas read FCanvas;
    property DefOrientation: TPrinterOrientation read FDefOrientation;
    property DefPaper: Integer read FDefPaper;
    property DefPaperHeight: Double read FDefPaperHeight;
    property DefPaperWidth: Double read FDefPaperWidth;
    property DefBin: Integer read FDefBin;
    property DefDuplex: Integer read FDefDuplex;
    property DPI: TPoint read FDPI;
    property FileName: String read FFileName write FFileName;
    property Handle: THandle read FHandle;
    property Name: String read FName;
    property Paper: Integer read FPaper;
    property Papers: TStrings read FPapers;
    property PaperHeight: Double read FPaperHeight;
    property PaperWidth: Double read FPaperWidth;
    property LeftMargin: Double read FLeftMargin;
    property TopMargin: Double read FTopMargin;
    property RightMargin: Double read FRightMargin;
    property BottomMargin: Double read FBottomMargin;
    property Orientation: TPrinterOrientation read FOrientation;
    property Port: String read FPort;
    property Title: String read FTitle write FTitle;
    property Initialized: Boolean read FInitialized;
  end;

  TfrxVirtualPrinter = class(TfrxCustomPrinter)
  public
    procedure Init; override;
    procedure Abort; override;
    procedure BeginDoc; override;
    procedure BeginPage; override;
    procedure BeginRAWDoc; override;
    procedure EndDoc; override;
    procedure EndPage; override;
    procedure EndRAWDoc; override;
    procedure WriteRAWDoc(const buf: AnsiString); override;
    procedure SetViewParams(APaperSize: Integer;
      APaperWidth, APaperHeight: Extended;
      AOrientation: TPrinterOrientation); override;
    procedure SetPrintParams(APaperSize: Integer;
      APaperWidth, APaperHeight: Extended; AOrientation: TPrinterOrientation;
      ABin, ADuplex, ACopies: Integer); override;
    procedure PropertiesDlg; override;
  end;


  TfrxCustomPrinters = class(TObject)
  protected
    FHasPhysicalPrinters: Boolean;
    FPrinters: TStrings;
    FPrinterIndex: Integer;
    FPrinterList: TList;
    function GetItem(Index: Integer): TfrxCustomPrinter;
    function GetCurrentPrinter: TfrxCustomPrinter;
    procedure SetPrinterIndex(Value: Integer);
    function GetDefaultPrinter: String; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function IndexOf(AName: String): Integer;
    procedure Clear;
    procedure FillPrinters; virtual;
    property Items[Index: Integer]: TfrxCustomPrinter read GetItem; default;
    property HasPhysicalPrinters: Boolean read FHasPhysicalPrinters;
    property Printer: TfrxCustomPrinter read GetCurrentPrinter;
    property PrinterIndex: Integer read FPrinterIndex write SetPrinterIndex;
    property Printers: TStrings read FPrinters;
  end;

  TfrxCustomPrintersClass = class of TfrxCustomPrinters;


function frxGetPaperDimensions(PaperSize: Integer; var Width, Height: Double): Boolean;
function frxPrinters: TfrxCustomPrinters;

implementation

uses
  FMX.frxUtils, FMX.frxRes, FMX.frxFMX,
{$IFDEF MSWINDOWS}
  FMX.Win.frxPrinter
{$ELSE}
  FMX.Mac.frxPrinter
{$ENDIF};



type
  TPaperInfo = {packed} record
    Typ: Integer;
    Name: String;
    X, Y: Integer;
  end;


const
  PAPERCOUNT = 66;
  PaperInfo: array[0..PAPERCOUNT - 1] of TPaperInfo = (
    (Typ:1;  Name: ''; X:2159; Y:2794),
    (Typ:2;  Name: ''; X:2159; Y:2794),
    (Typ:3;  Name: ''; X:2794; Y:4318),
    (Typ:4;  Name: ''; X:4318; Y:2794),
    (Typ:5;  Name: ''; X:2159; Y:3556),
    (Typ:6;  Name: ''; X:1397; Y:2159),
    (Typ:7;  Name: ''; X:1842; Y:2667),
    (Typ:8;  Name: ''; X:2970; Y:4200),
    (Typ:9;  Name: ''; X:2100; Y:2970),
    (Typ:10; Name: ''; X:2100; Y:2970),
    (Typ:11; Name: ''; X:1480; Y:2100),
    (Typ:12; Name: ''; X:2500; Y:3540),
    (Typ:13; Name: ''; X:1820; Y:2570),
    (Typ:14; Name: ''; X:2159; Y:3302),
    (Typ:15; Name: ''; X:2150; Y:2750),
    (Typ:16; Name: ''; X:2540; Y:3556),
    (Typ:17; Name: ''; X:2794; Y:4318),
    (Typ:18; Name: ''; X:2159; Y:2794),
    (Typ:19; Name: ''; X:984;  Y:2254),
    (Typ:20; Name: ''; X:1048; Y:2513),
    (Typ:21; Name: ''; X:1143; Y:2635),
    (Typ:22; Name: ''; X:1207; Y:2794),
    (Typ:23; Name: ''; X:1270; Y:2921),
    (Typ:25; Name: ''; X:4318; Y:5588),
    (Typ:25; Name: ''; X:5588; Y:8636),
    (Typ:26; Name: ''; X:8636; Y:11176),
    (Typ:27; Name: ''; X:1100; Y:2200),
    (Typ:28; Name: ''; X:1620; Y:2290),
    (Typ:29; Name: ''; X:3250; Y:4580),
    (Typ:30; Name: ''; X:2290; Y:3250),
    (Typ:31; Name: ''; X:1140; Y:1620),
    (Typ:32; Name: ''; X:1140; Y:2290),
    (Typ:33; Name: ''; X:2500; Y:3530),
    (Typ:34; Name: ''; X:1760; Y:2500),
    (Typ:35; Name: ''; X:1760; Y:1250),
    (Typ:36; Name: ''; X:1100; Y:2300),
    (Typ:37; Name: ''; X:984;  Y:1905),
    (Typ:38; Name: ''; X:920;  Y:1651),
    (Typ:39; Name: ''; X:3778; Y:2794),
    (Typ:40; Name: ''; X:2159; Y:3048),
    (Typ:41; Name: ''; X:2159; Y:3302),
    (Typ:42; Name: ''; X:2500; Y:3530),
    (Typ:43; Name: ''; X:1000; Y:1480),
    (Typ:44; Name: ''; X:2286; Y:2794),
    (Typ:45; Name: ''; X:2540; Y:2794),
    (Typ:46; Name: ''; X:3810; Y:2794),
    (Typ:47; Name: ''; X:2200; Y:2200),
    (Typ:50; Name: ''; X:2355; Y:3048),
    (Typ:51; Name: ''; X:2355; Y:3810),
    (Typ:52; Name: ''; X:2969; Y:4572),
    (Typ:53; Name: ''; X:2354; Y:3223),
    (Typ:54; Name: ''; X:2101; Y:2794),
    (Typ:55; Name: ''; X:2100; Y:2970),
    (Typ:56; Name: ''; X:2355; Y:3048),
    (Typ:57; Name: ''; X:2270; Y:3560),
    (Typ:58; Name: ''; X:3050; Y:4870),
    (Typ:59; Name: ''; X:2159; Y:3223),
    (Typ:60; Name: ''; X:2100; Y:3300),
    (Typ:61; Name: ''; X:1480; Y:2100),
    (Typ:62; Name: ''; X:1820; Y:2570),
    (Typ:63; Name: ''; X:3220; Y:4450),
    (Typ:64; Name: ''; X:1740; Y:2350),
    (Typ:65; Name: ''; X:2010; Y:2760),
    (Typ:66; Name: ''; X:4200; Y:5940),
    (Typ:67; Name: ''; X:2970; Y:4200),
    (Typ:68; Name: ''; X:3220; Y:4450));

var
  FPrinters: TfrxCustomPrinters = nil;

function frxGetPaperDimensions(PaperSize: Integer; var Width, Height: Double): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to PAPERCOUNT - 1 do
    if PaperInfo[i].Typ = PaperSize then
    begin
      Width := PaperInfo[i].X / 10;
      Height := PaperInfo[i].Y / 10;
      Result := True;
      break;
    end;
end;




{ TfrxCustomPrinter }

constructor TfrxCustomPrinter.Create(const AName, APort: String);
begin
  FName := AName;
  FPort := APort;

  FBins := TStringList.Create;
  FBins.AddObject(frxResources.Get('prDefault'), Pointer(DMBIN_AUTO));

  FPapers := TStringList.Create;
  FPapers.AddObject(frxResources.Get('prCustom'), Pointer(256));

  //FCanvas := TfrxPrinterCanvas.Create;
  //FCanvas.FPrinter := Self;
end;

destructor TfrxCustomPrinter.Destroy;
begin
  FBins.Free;
  FPapers.Free;
  //FCanvas.Free;
  inherited;
end;

function TfrxCustomPrinter.BinIndex(ABin: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FBins.Count - 1 do
    if Integer(FBins.Objects[i]) = ABin then
    begin
      Result := i;
      break;
    end;
end;

function TfrxCustomPrinter.PaperIndex(APaper: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FPapers.Count - 1 do
    if Integer(FPapers.Objects[i]) = APaper then
    begin
      Result := i;
      break;
    end;
end;

function TfrxCustomPrinter.BinNameToNumber(const ABin: String): Integer;
var
  i: Integer;
begin
  i := FBins.IndexOf(ABin);
  if i = -1 then
    i := 0;
  Result := Integer(FBins.Objects[i]);
end;

function TfrxCustomPrinter.PaperNameToNumber(const APaper: String): Integer;
var
  i: Integer;
begin
  i := FPapers.IndexOf(APaper);
  if i = -1 then
    i := 0;
  Result := Integer(FPapers.Objects[i]);
end;


{ TfrxVirtualPrinter }

procedure TfrxVirtualPrinter.Init;
var
  i: Integer;
begin
  if FInitialized then Exit;

  FDPI := Point(600, 600);
  FDefPaper := DMPAPER_A4;
  FDefOrientation := poPortrait;
  FDefPaperWidth := 210;
  FDefPaperHeight := 297;

  for i := 0 to PAPERCOUNT - 1 do
    FPapers.AddObject(PaperInfo[i].Name, Pointer(PaperInfo[i].Typ));

  FBin := -1;
  FDuplex := -1;
  FInitialized := True;
end;

procedure TfrxVirtualPrinter.Abort;
begin
end;

procedure TfrxVirtualPrinter.BeginDoc;
begin
end;

procedure TfrxVirtualPrinter.BeginPage;
begin
end;

procedure TfrxVirtualPrinter.EndDoc;
begin
end;

procedure TfrxVirtualPrinter.EndPage;
begin
end;

procedure TfrxVirtualPrinter.BeginRAWDoc;
begin
end;

procedure TfrxVirtualPrinter.EndRAWDoc;
begin
end;

procedure TfrxVirtualPrinter.WriteRAWDoc(const buf: AnsiString);
begin
end;

procedure TfrxVirtualPrinter.SetViewParams(APaperSize: Integer;
  APaperWidth, APaperHeight: Extended; AOrientation: TPrinterOrientation);
var
  i: Integer;
  Found: Boolean;
begin
  Found := False;
  if APaperSize <> 256 then
    for i := 0 to PAPERCOUNT - 1 do
      if PaperInfo[i].Typ = APaperSize then
      begin
        if AOrientation = poPortrait then
        begin
          APaperWidth := PaperInfo[i].X / 10;
          APaperHeight := PaperInfo[i].Y / 10;
        end
        else
        begin
          APaperWidth := PaperInfo[i].Y / 10;
          APaperHeight := PaperInfo[i].X / 10;
        end;
        Found := True;
        break;
      end;

  if not Found then
    APaperSize := 256;

  FOrientation := AOrientation;
  FPaper := APaperSize;
  FPaperWidth := APaperWidth;
  FPaperHeight := APaperHeight;
  FLeftMargin := 5;
  FTopMargin := 5;
  FRightMargin := 5;
  FBottomMargin := 5;
end;

procedure TfrxVirtualPrinter.SetPrintParams(APaperSize: Integer;
  APaperWidth, APaperHeight: Extended; AOrientation: TPrinterOrientation;
  ABin, ADuplex, ACopies: Integer);
begin
  SetViewParams(APaperSize, APaperWidth, APaperHeight, AOrientation);
  FBin := ABin;
end;

procedure TfrxVirtualPrinter.PropertiesDlg;
begin
end;


{ TfrxCustomPrinters }

constructor TfrxCustomPrinters.Create;
begin
  FPrinterList := TList.Create;
  FPrinters := TStringList.Create;

  try
    FillPrinters;
  except
  end;
  if FPrinterList.Count = 0 then
  begin
    FPrinterList.Add(TfrxVirtualPrinter.Create(frxResources.Get('prVirtual'), ''));
    FHasPhysicalPrinters := False;
    PrinterIndex := 0;
  end
  else
  begin
    FHasPhysicalPrinters := True;
    PrinterIndex := IndexOf(GetDefaultPrinter);
    if PrinterIndex = -1 then  // important 
      PrinterIndex := 0;
  end;
end;

destructor TfrxCustomPrinters.Destroy;
begin
  Clear;
  FPrinterList.Free;
  FPrinters.Free;
  inherited;
end;

procedure TfrxCustomPrinters.Clear;
begin
  while FPrinterList.Count > 0 do
  begin
    TObject(FPrinterList[0]).Free;
    FPrinterList.Delete(0);
  end;
  FPrinters.Clear;
end;

function TfrxCustomPrinters.GetItem(Index: Integer): TfrxCustomPrinter;
begin
  if Index >= 0 then
    Result := FPrinterList[Index]
  else
    Result := nil
end;

function TfrxCustomPrinters.IndexOf(AName: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FPrinterList.Count - 1 do
    if AnsiCompareText(Items[i].Name, AName) = 0 then
    begin
      Result := i;
      break;
    end;
end;

procedure TfrxCustomPrinters.SetPrinterIndex(Value: Integer);
begin
  if Value <> -1 then
    FPrinterIndex := Value
  else
    FPrinterIndex := IndexOf(GetDefaultPrinter);
  if FPrinterIndex <> -1 then
    Items[FPrinterIndex].Init;
end;

function TfrxCustomPrinters.GetCurrentPrinter: TfrxCustomPrinter;
begin
  Result := Items[PrinterIndex];
end;

function TfrxCustomPrinters.GetDefaultPrinter: String;
begin
  Result := '';
end;


procedure TfrxCustomPrinters.FillPrinters;
begin
 // do nothing
end;


function frxPrinters: TfrxCustomPrinters;
begin
  if FPrinters = nil then
    FPrinters := ActualfrxPrinterClass.Create;
  Result := FPrinters;
end;

initialization

finalization
  if FPrinters <> nil then
    FPrinters.Free;

end.

