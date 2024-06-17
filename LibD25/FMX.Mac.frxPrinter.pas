
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

unit FMX.Mac.frxPrinter;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.Classes, System.SysUtils, System.Types, System.UITypes, System.Variants,
  FMX.Types, FMX.frxPrinter, FMX.Printer.Mac, FMX.Printer
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};


type
  THackCanvas = class(TCanvas);
  THackPrinter = class(TPrinter);


  TfrxPrinter = class(TfrxCustomPrinter)
  private
    FDriver: String;
    //FPrintDLG: TPrintDialog;
    FOnChangedFont: TNotifyEvent;
    FIsFirst: Boolean;
    procedure FontChanged(Sender: TObject);
  public
    constructor Create(const AName, APort: String); override;
    destructor Destroy; override;
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
    function ShowPrintDialog: Boolean; override;
    function UpdateDeviceCaps: Boolean;
  end;


  TfrxPrinters = class(TfrxCustomPrinters)
  protected
    function GetDefaultPrinter: String; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure FillPrinters; override;
  end;



function frxGetPaperDimensions(PaperSize: Integer; var Width, Height: Extended): Boolean;
function ActualfrxPrinterClass : TfrxCustomPrintersClass;


implementation

uses
  FMX.frxUtils, FMX.frxRes, FMX.frxFMX, FMX.Forms, Macapi.CoreServices, Macapi.CoreFoundation, Macapi.Foundation,
  Macapi.CocoaTypes, Macapi.AppKit;


const
  libPrintCore = '/System/Library/Frameworks/ApplicationServices.framework/Frameworks/PrintCore.framework/PrintCore';
  kPMCancel = 128;

function PMGetCopies(printSettings: PMPrintSettings; copies: PUInt32): OSStatus; cdecl; external libPrintCore name '_PMGetCopies';
function PMSetCopies(printSettings: PMPrintSettings; copies: UInt32; lock: Boolean): OSStatus; cdecl; external libPrintCore name '_PMSetCopies';
function PMGetAdjustedPageRect(pageFormat: PMPageFormat; pageRect: PPMRect): OSStatus; cdecl; external libPrintCore name '_PMGetAdjustedPageRect';
function PMGetAdjustedPaperRect(pageFormat: PMPageFormat; paperRect: PPMRect): OSStatus; cdecl; external libPrintCore name '_PMGetAdjustedPaperRect';
function PMGetPageFormatPaper(format: PMPageFormat; paper: PPMPaper): OSStatus; cdecl; external libPrintCore name '_PMGetPageFormatPaper';
function PMPaperGetHeight(paper: PMPaper; paperHeight: PDouble): OSStatus; cdecl; external libPrintCore name '_PMPaperGetHeight';
function PMPaperGetWidth(paper: PMPaper; paperWidth: PDouble): OSStatus; cdecl; external libPrintCore name '_PMPaperGetWidth';
function PMPaperGetMargins(paper: PMPaper; paperMargins: PPMPaperMargins): OSStatus; cdecl; external libPrintCore name '_PMPaperGetMargins';
function PMPrinterGetDriverCreator(printer: PMPrinter; creator: POSType): OSStatus; cdecl; external libPrintCore name '_PMPrinterGetDriverCreator';
function PMPrinterGetDriverReleaseInfo(printer: PMPrinter; release: VersRecPtr): OSStatus; cdecl; external libPrintCore name '_PMPrinterGetDriverReleaseInfo';
function PMPrinterGetID(printer: PMPrinter): CFStringRef; cdecl; external libPrintCore name '_PMPrinterGetID';
function PMPrinterGetMakeAndModelName(printer: PMPrinter; makeAndModel: PCFStringRef): OSStatus; cdecl; external libPrintCore name '_PMPrinterGetMakeAndModelName';
function PMPrinterGetName(printer: PMPrinter): CFStringRef; cdecl; external libPrintCore name '_PMPrinterGetName';
function PMPrinterIsDefault(printer: PMPrinter): Boolean; cdecl; external libPrintCore name '_PMPrinterIsDefault';
function PMPrinterSetOutputResolution(printer: PMPrinter; printSettings: PMPrintSettings; resolutionP: PPMResolution): OSStatus; cdecl; external libPrintCore name '_PMPrinterSetOutputResolution';
function PMPrinterGetPrinterResolutionCount(printer: PMPrinter; countP: PUInt32): OSStatus; cdecl; external libPrintCore name '_PMPrinterGetPrinterResolutionCount';
function PMPrinterGetIndexedPrinterResolution(printer: PMPrinter; index: UInt32; resolutionP: PPMResolution): OSStatus; cdecl; external libPrintCore name '_PMPrinterGetIndexedPrinterResolution';
function PMPrinterGetOutputResolution(printer: PMPrinter; printSettings: PMPrintSettings; resolutionP: PPMResolution): OSStatus; cdecl; external libPrintCore name '_PMPrinterGetOutputResolution';
function PMServerCreatePrinterList(server: PMServer; printerList: PCFArrayRef): OSStatus; cdecl; external libPrintCore name '_PMServerCreatePrinterList';
function PMSessionBeginCGDocumentNoDialog(printSession: PMPrintSession; printSettings: PMPrintSettings; pageFormat: PMPageFormat): OSStatus; cdecl; external libPrintCore name '_PMSessionBeginCGDocumentNoDialog';
function PMSessionBeginPageNoDialog(printSession: PMPrintSession; pageFormat: PMPageFormat; pageFrame: PPMRect): OSStatus; cdecl; external libPrintCore name '_PMSessionBeginPageNoDialog';
function PMSessionDefaultPageFormat(printSession: PMPrintSession; pageFormat: PMPageFormat): OSStatus; cdecl; external libPrintCore name '_PMSessionDefaultPageFormat';
function PMSessionDefaultPrintSettings(printSession: PMPrintSession; printSettings: PMPrintSettings): OSStatus; cdecl; external libPrintCore name '_PMSessionDefaultPrintSettings';
function PMSessionEndDocumentNoDialog(printSession: PMPrintSession): OSStatus; cdecl; external libPrintCore name '_PMSessionEndDocumentNoDialog';
function PMSessionEndPageNoDialog(printSession: PMPrintSession): OSStatus; cdecl; external libPrintCore name '_PMSessionEndPageNoDialog';
function PMSessionSetCurrentPMPrinter(session: PMPrintSession; printer: PMPrinter): OSStatus; cdecl; external libPrintCore name '_PMSessionSetCurrentPMPrinter';
function PMSessionSetError(printSession: PMPrintSession; printError: OSStatus): OSStatus; cdecl; external libPrintCore name '_PMSessionSetError';
function PMSessionValidatePageFormat(printSession: PMPrintSession; pageFormat: PMPageFormat; result: PBoolean): OSStatus; cdecl; external libPrintCore name '_PMSessionValidatePageFormat';
function PMSessionValidatePrintSettings(printSession: PMPrintSession; printSettings: PMPrintSettings; result: PBoolean): OSStatus; cdecl; external libPrintCore name '_PMSessionValidatePrintSettings';
function PMSessionSetDestination(printSession: PMPrintSession; printSettings: PMPrintSettings; destType: PMDestinationType; destFormat: CFStringRef; destLocation: CFURLRef): OSStatus; cdecl; external libPrintCore name '_PMSessionSetDestination';
function PMSetOrientation(pageFormat: PMPageFormat; orientation: PMOrientation; lock: Boolean): OSStatus; cdecl; external libPrintCore name '_PMSetOrientation';

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
    (Typ:20; Name: ''; X:1048; Y:2413),
    (Typ:21; Name: ''; X:1143; Y:2635),
    (Typ:22; Name: ''; X:1207; Y:2794),
    (Typ:23; Name: ''; X:1270; Y:2921),
    (Typ:24; Name: ''; X:4318; Y:5588),
    (Typ:25; Name: ''; X:5588; Y:8636),
    (Typ:26; Name: ''; X:8636; Y:11176),
    (Typ:27; Name: ''; X:1100; Y:2200),
    (Typ:28; Name: ''; X:1620; Y:2290),
    (Typ:29; Name: ''; X:3240; Y:4580),
    (Typ:30; Name: ''; X:2290; Y:3240),
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





function frxGetPaperDimensions(PaperSize: Integer; var Width, Height: Extended): Boolean;
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



destructor TfrxPrinter.Destroy;
begin
  inherited;
  //FPrintDLG.Free;
end;

procedure TfrxPrinter.Init;
begin
  if FInitialized then Exit;
  UpdateDeviceCaps;
  FDefOrientation := TPrinterMac(FMX.Printer.Printer).Orientation;
  FOrientation := FDefOrientation;
  FPaperHeight := TPrinterMac(FMX.Printer.Printer).PrintInfo.paperSize.height;
  FPaperWidth := TPrinterMac(FMX.Printer.Printer).PrintInfo.paperSize.width;


  FDefPaper := 256;
  FDefBin := 0;
  FDefDuplex := 0;
  FPaper := FDefPaper;
  FDefPaperWidth := FPaperWidth;
  FDefPaperHeight := FPaperHeight;
  FOrientation := FDefOrientation;
  FBin := -1;
  FDuplex := -1;

  FInitialized := True;

  FBin := -1;
  FDuplex := -1;

  FInitialized := True;
end;

procedure TfrxPrinter.Abort;
begin
  FMX.Printer.Printer.EndDoc;
end;

procedure TfrxPrinter.BeginDoc;
begin
  FPrinting := True;
  FCanvas := FMX.Printer.Printer.Canvas;

  //FCanvas := FMX.Printer.Printer.Canvas;
  FIsFirst := True;

  UpdateDeviceCaps;
  FMX.Printer.Printer.BeginDoc;
  FCanvas := TPrinterMac(FMX.Printer.Printer).Canvas;
end;

procedure TfrxPrinter.BeginPage;
var
  Err: OSStatus;
begin
  inherited;

  if not (FIsFirst) then
  begin


  with TPrinterMac(FMX.Printer.Printer).PrintInfo do
  begin
    Err := PMSessionBeginPageNoDialog(PMPrintSession, PMPageFormat, nil);
  end;
  TPrinterMac(FMX.Printer.Printer).Canvas.BeginScene;
  end;
  FIsFirst := False;

end;

procedure TfrxPrinter.EndDoc;
var
  Err: OSStatus;
begin

  FPaperHeight := FMX.Printer.Printer.PageHeight;
  FPaperWidth := FMX.Printer.Printer.PageWidth;
  //FMX.Printer.Printer.EndDoc;

  Err := PMSessionEndDocumentNoDialog(TPrinterMac(FMX.Printer.Printer).PrintInfo.PMPrintSession);
{$IFDEF DELPHI25}
  try
    if TPrinterMac(FMX.Printer.Printer).Canvas.BeginSceneCount > 0 then
      TPrinterMac(FMX.Printer.Printer).Canvas.EndScene;
  except
  end;
{$ELSE}
  TPrinterMac(FMX.Printer.Printer).Canvas.EndScene;
{$ENDIF}
  FPrinting := False;
  THackPrinter(FMX.Printer.Printer).FPrinting := False;
  FBin := -1;
  FDuplex := -1;

end;

procedure TfrxPrinter.EndPage;
var
  Err: OSStatus;
begin
  TPrinterMac(FMX.Printer.Printer).Canvas.EndScene;
  with TPrinterMac(FMX.Printer.Printer).PrintInfo do
  begin
    Err := PMSessionEndPageNoDialog(PMPrintSession);
  end;

end;

procedure TfrxPrinter.BeginRAWDoc;
begin
//todo
end;

procedure TfrxPrinter.EndRAWDoc;
begin
//todo
end;

procedure TfrxPrinter.WriteRAWDoc(const buf: AnsiString);
begin
  //todo
end;

constructor TfrxPrinter.Create(const AName, APort: String);
begin
  inherited Create(AName, APort);

  //FPrintDLG := TPrintDialog.Create(nil);
  //FPrintDLG.
end;


procedure TfrxPrinter.FontChanged(Sender: TObject);
var
  FontSize: Integer;
begin
  if Assigned(FOnChangedFont) then
    FOnChangedFont(Sender);
  //if FDPI.Y <> FCanvas.Font.PixelsPerInch then
  begin
    //FontSize := Round(FCanvas.Font.Size);
    ///Font.PixelsPerInch := FPrinter.DPI.Y;
    //FCanvas.Font.Size := MulDiv(FontSize, DPI.Y, 72)
  end;
end;

procedure TfrxPrinter.SetViewParams(APaperSize: Integer;
  APaperWidth, APaperHeight: Extended; AOrientation: TPrinterOrientation);
begin
  {if APaperSize <> 256 then
  begin

    if not UpdateDeviceCaps then Exit;
  end
  else
  begin
    // copy the margins from A4 paper
    SetViewParams(DMPAPER_A4, 0, 0, AOrientation);
    FPaperHeight := APaperHeight;
    FPaperWidth := APaperWidth;
  end; }

  FPaper := APaperSize;
  FOrientation := AOrientation;
end;

function TfrxPrinter.ShowPrintDialog: Boolean;
begin
//  Result := FPrintDLG.Execute;
end;

procedure TfrxPrinter.SetPrintParams(APaperSize: Integer;
  APaperWidth, APaperHeight: Extended; AOrientation: TPrinterOrientation;
  ABin, ADuplex, ACopies: Integer);
var
  sSize: NSSize;
  Changed: Boolean;
  lOrientation: NSPrintingOrientation;
begin

  { later fix these values }
  FPaper := APaperSize;
  sSize.Height := APaperHeight * 2.835;
  sSize.Width := APaperWidth * 2.835;

  if AOrientation = TPrinterOrientation.poPortrait then
    lOrientation := NSPortraitOrientation
  else
    lOrientation := NSLandscapeOrientation;

  TPrinterMac(FMX.Printer.Printer).PrintInfo.setPaperSize(sSize);

  with TPrinterMac(FMX.Printer.Printer) do
  begin
    //kPMPortrait = 1
    //kPMLandscape = 2
    //PMSetOrientation(PrintInfo.PMPageFormat, lOrientation + 1, false);
    PMSessionValidatePageFormat(PrintInfo.PMPrintSession, PrintInfo.PMPageFormat, @Changed);
  end;
  TPrinterMac(FMX.Printer.Printer).PrintInfo.setOrientation(lOrientation);
  TPrinterMac(FMX.Printer.Printer).PrintInfo.updateFromPMPageFormat;
  FPaperHeight := TPrinterMac(FMX.Printer.Printer).PrintInfo.paperSize.height;
  FPaperWidth := TPrinterMac(FMX.Printer.Printer).PrintInfo.paperSize.width;
{$IFDEF DELPHI18}
  TPrinterMac(FMX.Printer.Printer).Canvas.SetSize(Round(FPaperWidth), Round(FPaperHeight));
{$ELSE}
  TPrinterMac(FMX.Printer.Printer).Canvas.ResizeBuffer(Round(FPaperWidth), Round(FPaperHeight));
{$ENDIF}
  FOrientation := AOrientation;
  UpdateDeviceCaps;
end;

function TfrxPrinter.UpdateDeviceCaps: Boolean;
var
  Res: PMResolution;
  Idx: Integer;
begin
  FCanvas := TPrinterMac(FMX.Printer.Printer).Canvas;
  FPaperHeight := TPrinterMac(FMX.Printer.Printer).PrintInfo.paperSize.height;
  FPaperWidth := TPrinterMac(FMX.Printer.Printer).PrintInfo.paperSize.width;
  Idx := FMX.Printer.Printer.ActivePrinter.ActiveDPIIndex;

  if Idx <> -1 then
  begin
    FDPI.X := FMX.Printer.Printer.ActivePrinter.DPI[Idx].X;
    FDPI.y := FMX.Printer.Printer.ActivePrinter.DPI[Idx].Y;
  end
  else if FMX.Printer.Printer.ActivePrinter.DPICount > 0 then
  begin
    FDPI.X := FMX.Printer.Printer.ActivePrinter.DPI[0].X;
    FDPI.y := FMX.Printer.Printer.ActivePrinter.DPI[0].Y;
  end
  else
  begin
    FDPI := System.Classes.Point(72, 72);
  end;


  FLeftMargin :=  TPrinterMac(FMX.Printer.Printer).PrintInfo.imageablePageBounds.origin.x / 3;
  FTopMargin := TPrinterMac(FMX.Printer.Printer).PrintInfo.imageablePageBounds.origin.y / 3;
  FBottomMargin := FPaperHeight - TPrinterMac(FMX.Printer.Printer).PrintInfo.imageablePageBounds.size.height / 3 - FTopMargin;
  FRightMargin := FPaperWidth - TPrinterMac(FMX.Printer.Printer).PrintInfo.imageablePageBounds.size.width / 3 - FLeftMargin;

 { Result := True;
  if FDC = 0 then GetDC;

  FDPI := Point(GetDeviceCaps(FDC, LOGPIXELSX), GetDeviceCaps(FDC, LOGPIXELSY));
  if (FDPI.X = 0) or (FDPI.Y = 0) then
  begin
    Result := False;
    frxErrorMsg('Printer selected is not valid');
    Exit;
  end;
  FPaperHeight := Round(GetDeviceCaps(FDC, PHYSICALHEIGHT) / FDPI.Y * 25.4);
  FPaperWidth := Round(GetDeviceCaps(FDC, PHYSICALWIDTH) / FDPI.X * 25.4);
  FLeftMargin := Round(GetDeviceCaps(FDC, PHYSICALOFFSETX) / FDPI.X * 25.4);
  FTopMargin := Round(GetDeviceCaps(FDC, PHYSICALOFFSETY) / FDPI.Y * 25.4);
  FRightMargin := FPaperWidth - Round(GetDeviceCaps(FDC, HORZRES) / FDPI.X * 25.4) - FLeftMargin;
  FBottomMargin := FPaperHeight - Round(GetDeviceCaps(FDC, VERTRES) / FDPI.Y * 25.4) - FTopMargin;}
end;

procedure TfrxPrinter.PropertiesDlg;
begin
  //todo
end;

{ TfrxPrinters }

constructor TfrxPrinters.Create;
begin
  Inherited;
end;

destructor TfrxPrinters.Destroy;
begin
  inherited;
end;



function TfrxPrinters.GetDefaultPrinter: String;
begin
  Result := FMX.Printer.Printer.ActivePrinter.Device;
end;


procedure TfrxPrinters.FillPrinters;
var
  i, j: Integer;

  procedure AddPrinter(ADevice, APort: String);
  begin
    FPrinterList.Add(TfrxPrinter.Create(ADevice, APort));
    FPrinters.Add(ADevice);
  end;

begin
  Clear;
  for i := 0 to FMX.Printer.Printer.Count - 1 do
    AddPrinter(FMX.Printer.Printer.Printers[i].Device, FMX.Printer.Printer.Printers[i].Port);
end;


function ActualfrxPrinterClass : TfrxCustomPrintersClass;
begin
  Result := TfrxPrinters;
end;

initialization

finalization

end.

