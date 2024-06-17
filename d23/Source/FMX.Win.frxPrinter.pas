
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

unit FMX.Win.frxPrinter;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.Classes, System.SysUtils, Winapi.Windows, Winapi.WinSpool, System.Types, System.UITypes, System.Variants,
  FMX.Types, FMX.frxPrinter, FMX.Printer.Win, FMX.Printer, FMX.Canvas.GDIP, FMX.frxClass
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};


type
  THackCanvas = class(TCanvas);
// Fake printer used only for canvas creation
  TFakePrinterWin = class(TPrinterWin)
  protected
    FPageHeight: Integer;
    FPageWidth: Integer;
    procedure ActivePrinterChanged; override;
    procedure DoAbortDoc; override;
    procedure DoBeginDoc; override;
    procedure DoEndDoc; override;
    procedure DoNewPage; override;
    function GetCanvas: TCanvas; override;
    function GetNumCopies: Integer; override;
    function GetOrientation: TPrinterOrientation; override;
    function GetPageHeight: Integer; override;
    function GetPageWidth: Integer; override;
    procedure RefreshFonts; override;
    procedure RefreshPrinterDevices; override;
    procedure SetOrientation(Value: TPrinterOrientation); override;
    procedure SetNumCopies(Value: Integer); override;
    procedure SetDefaultPrinter; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TfrxPrinter = class(TfrxCustomPrinter)
  private
    FDeviceMode: THandle;
    FDC: HDC;
    FDriver: String;
    FMode: PDeviceMode;
    FWinPrinter: TFakePrinterWin;
    FOnChangedFont: TNotifyEvent;
    procedure CreateDevMode;
    procedure FreeDevMode;
    procedure GetDC;
    procedure FontChanged(Sender: TObject);
  public
    constructor Create(const AName, APort: String); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure RecreateDC;
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
    property DeviceMode: PDeviceMode read FMode;
  end;


  TfrxPrinters = class(TfrxCustomPrinters)
  protected
    function GetDefaultPrinter: String; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure FillPrinters; override;
  end;

  TfrxPrinterCanvas = class(TCanvas)
  private
    FPrinter: TfrxCustomPrinter;
{$IFNDEF FMX}
    procedure UpdateFont;
  public
    procedure Changing; override;
{$ENDIF}
  end;



function frxGetPaperDimensions(PaperSize: Integer; var Width, Height: Extended): Boolean;
function ActualfrxPrinterClass : TfrxCustomPrintersClass;


implementation

uses
  FMX.frxUtils, FMX.frxRes, FMX.frxFMX;


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


{$IFNDEF FMX}
{ TfrxPrinterCanvas }

procedure TfrxPrinterCanvas.Changing;
begin
  inherited;
  UpdateFont;
end;

procedure TfrxPrinterCanvas.UpdateFont;
var
  FontSize: Integer;
begin
  if FPrinter.DPI.Y <> Font.PixelsPerInch then
  begin
    FontSize := Font.Size;
    Font.PixelsPerInch := FPrinter.DPI.Y;
    Font.Size := FontSize;
  end;
end;
{$ENDIF}



destructor TfrxPrinter.Destroy;
begin
  FreeDevMode;
  FWinPrinter.Free;
  inherited;
end;

procedure TfrxPrinter.Init;

  procedure FillPapers;
  var
    i, PaperSizesCount: Integer;
    PaperSizes: array[0..255] of Word;
    PaperNames: PChar;
  begin
    FillChar(PaperSizes, SizeOf(PaperSizes), 0);
    PaperSizesCount := DeviceCapabilities(PChar(FName), PChar(FPort), DC_PAPERS, @PaperSizes, FMode);
    GetMem(PaperNames, PaperSizesCount * 64 * sizeof(char));
    DeviceCapabilities(PChar(FName), PChar(FPort), DC_PAPERNAMES, PaperNames, FMode);
    for i := 0 to PaperSizesCount - 1 do
      if PaperSizes[i] <> 256 then
        FPapers.AddObject(StrPas(PWideChar(PaperNames + i * 64)), Pointer(PaperSizes[i]));

    FreeMem(PaperNames, PaperSizesCount * 64 * sizeof(char));
  end;

  procedure FillBins;
  var
    i, BinsCount: Integer;
    BinNumbers: array[0..255] of Word;
    BinNames: PChar;
  begin
    FillChar(BinNumbers, SizeOf(BinNumbers), 0);
    BinsCount := DeviceCapabilities(PChar(FName), PChar(FPort), DC_BINS, @BinNumbers[0], FMode);
    GetMem(BinNames, BinsCount * 24 * sizeof(char));
    try
      DeviceCapabilities(PChar(FName), PChar(FPort), DC_BINNAMES, BinNames, FMode);
    except
    end;

    for i := 0 to BinsCount - 1 do
      if BinNumbers[i] <> DMBIN_AUTO then
        FBins.AddObject(StrPas(PwideChar(BinNames + i * 24)), Pointer(BinNumbers[i]));

    FreeMem(BinNames, BinsCount * 24 * sizeof(char));
  end;

begin
  if FInitialized then Exit;
  CreateDevMode;
  if FDeviceMode = 0 then Exit;
  RecreateDC;

  if not UpdateDeviceCaps then
  begin
    FreeDevMode;
    Exit;
  end;

  FDefPaper := FMode.dmPaperSize;
  FDefBin := FMode.dmDefaultSource;
  FDefDuplex := FMode.dmDuplex;
  FPaper := FDefPaper;
  FDefPaperWidth := FPaperWidth;
  FDefPaperHeight := FPaperHeight;
  if FMode.dmOrientation = DMORIENT_PORTRAIT then
    FDefOrientation := poPortrait else
    FDefOrientation := poLandscape;
  FOrientation := FDefOrientation;
  FillPapers;
  FillBins;
  FBin := -1;
  FDuplex := -1;

  FInitialized := True;
end;

procedure TfrxPrinter.Abort;
begin
  AbortDoc(FDC);
  EndDoc;
end;

procedure TfrxPrinter.BeginDoc;
var
  DocInfo: TDocInfo;
begin
  FPrinting := True;

  FillChar(DocInfo, SizeOf(DocInfo), 0);
  DocInfo.cbSize := SizeOf(DocInfo);
  if FTitle <> '' then
    DocInfo.lpszDocName := PChar(FTitle)
  else DocInfo.lpszDocName := PChar('Fast Report Document');

  if FFileName <> '' then
    DocInfo.lpszOutput := PChar(FFileName);

  RecreateDC;
  StartDoc(FDC, DocInfo);
end;

procedure TfrxPrinter.BeginPage;
begin
  StartPage(FDC);
end;

procedure TfrxPrinter.EndDoc;
var
  Saved8087CW: Word;
begin
  Saved8087CW := Default8087CW;
  Set8087CW($133F);
  try
    Winapi.Windows.EndDoc(FDC);
  except
  end;
  Set8087CW(Saved8087CW);

  FPrinting := False;
  RecreateDC;
  FBin := -1;
  FDuplex := -1;

  FMode.dmFields := FMode.dmFields or DM_DEFAULTSOURCE or DM_DUPLEX;
  FMode.dmDefaultSource := FDefBin;
  FMode.dmDuplex := FDefDuplex;
  if FCanvas <> nil then
    FCanvas.Free;

  FDC := ResetDC(FDC, FMode^);
  TFakePrinterWin(FWinPrinter).FDC := FDC;
{$IFNDEF Delphi17}
  FCanvas := DefaultCanvasClass.CreateFromPrinter(FWinPrinter);
{$ELSE}
  FCanvas := TCanvasManager.CreateFromPrinter(FWinPrinter);
{$ENDIF}
  FOnChangedFont := THackCanvas(FCanvas).FFont.OnChanged;
  THackCanvas(FCanvas).FFont.OnChanged := FontChanged;
end;

procedure TfrxPrinter.EndPage;
begin
  Winapi.Windows.EndPage(FDC);
end;

procedure TfrxPrinter.BeginRAWDoc;
var
  DocInfo1: TDocInfo1;
begin
  RecreateDC;
  DocInfo1.pDocName := PChar(FTitle);
  DocInfo1.pOutputFile := nil;
  DocInfo1.pDataType := 'RAW';
  StartDocPrinter(FHandle, 1, @DocInfo1);
  StartPagePrinter(FHandle);
end;

procedure TfrxPrinter.EndRAWDoc;
begin
  EndPagePrinter(FHandle);
  EndDocPrinter(FHandle);
end;

procedure TfrxPrinter.WriteRAWDoc(const buf: AnsiString);
var
  N: DWORD;
begin
  WritePrinter(FHandle, PAnsiChar(buf), Length(buf), N);
end;

constructor TfrxPrinter.Create(const AName, APort: String);
begin
  inherited Create(AName, APort);
  FWinPrinter := TFakePrinterWin.Create;
end;

procedure TfrxPrinter.CreateDevMode;
var
  bufSize: Integer;
begin
  if OpenPrinter(PChar(FName), FHandle, nil) then
  begin
    bufSize := DocumentProperties(0, FHandle, PChar(FName), nil, nil, 0);
    if bufSize > 0 then
    begin
      FDeviceMode := GlobalAlloc(GHND, bufSize);
      if FDeviceMode <> 0 then
      begin
        FMode := GlobalLock(FDeviceMode);
        if DocumentProperties(0, FHandle, PChar(FName), FMode^, FMode^,
          DM_OUT_BUFFER) < 0 then
        begin
          GlobalUnlock(FDeviceMode);
          GlobalFree(FDeviceMode);
          FDeviceMode := 0;
          FMode := nil;
        end
      end;
    end;
  end;
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

procedure TfrxPrinter.FreeDevMode;
begin
  //FCanvas.Handle := 0;
  if FDC <> 0 then
    DeleteDC(FDC);
  if FHandle <> 0 then
    ClosePrinter(FHandle);
  if FDeviceMode <> 0 then
  begin
    GlobalUnlock(FDeviceMode);
    GlobalFree(FDeviceMode);
  end;
  FDeviceMode := 0;
  FDC := 0;
  FHandle := 0;
  if FCanvas <> nil then
    FCanvas.Free;
end;

procedure TfrxPrinter.RecreateDC;
begin
  if FDC <> 0 then
    try
      DeleteDC(FDC);
    except
    end;
  FDC := 0;
  GetDC;
end;

procedure TfrxPrinter.GetDC;
begin
  if FDC = 0 then
  begin
    if FPrinting then
      FDC := CreateDC(PChar(FDriver), PChar(FName), nil, FMode) else
      FDC := CreateIC(PChar(FDriver), PChar(FName), nil, FMode);

      TFakePrinterWin(FWinPrinter).FDC := FDC;
      //FWinPrinter.PageHeight
       TFakePrinterWin(FWinPrinter).FState := TPrinterState.psHandleDC;
{$IFNDEF Delphi17}
      if FCanvas <> nil then
         FCanvas.CreateFromPrinter(FWinPrinter)
      else
        FCanvas := DefaultCanvasClass.CreateFromPrinter(FWinPrinter);
{$ELSE}
      if FCanvas <> nil then
        FreeAndNil(FCanvas);

      FCanvas := TCanvasManager.CreateFromPrinter(FWinPrinter);
{$ENDIF}
      FOnChangedFont := THackCanvas(FCanvas).FFont.OnChanged;
      THackCanvas(FCanvas).FFont.OnChanged := FontChanged;


//      FDC := THackPrinterWin(FWinPrinter).FDC;
//
//        THackPrinterWin(FWinPrinter).SetState(TPrinterState.psNoHandle);
//  THackPrinterWin(FWinPrinter).SetState(TPrinterState.psHandleDC);
//  // on a second document printing process, the canvas must reconnect its
//  // underlying objects to the new DC
//  THackPrinterWin(FWinPrinter).Canvas.CreateFromPrinter(FWinPrinter);
//  THackPrinterWin(FWinPrinter).SetCanvasDefaultSettings;
//  FCanvas := THackPrinterWin(FWinPrinter).Canvas;
//  FDC := THackPrinterWin(FWinPrinter).FDC;
//        FHandle := THackPrinterWin(FWinPrinter).FPrinterHandle;
//      FMode := THackPrinterWin(FWinPrinter).FDevMode;
//      FDeviceMode := THackPrinterWin(FWinPrinter).FDeviceMode;

    //FCanvas.Handle := FDC;
    //FCanvas.Refresh;
    //FCanvas.UpdateFont;
  end;
end;

procedure TfrxPrinter.SetViewParams(APaperSize: Integer;
  APaperWidth, APaperHeight: Extended; AOrientation: TPrinterOrientation);
begin
  if APaperSize <> 256 then
  begin
    FMode.dmFields := DM_PAPERSIZE or DM_ORIENTATION;
    FMode.dmPaperSize := APaperSize;
    if AOrientation = poPortrait then
      FMode.dmOrientation := DMORIENT_PORTRAIT else
      FMode.dmOrientation := DMORIENT_LANDSCAPE;
    RecreateDC;
    if not UpdateDeviceCaps then Exit;
  end
  else
  begin
    // copy the margins from A4 paper
    SetViewParams(DMPAPER_A4, 0, 0, AOrientation);
    FPaperHeight := APaperHeight;
    FPaperWidth := APaperWidth;
  end;

  FPaper := APaperSize;
  FOrientation := AOrientation;
end;

function TfrxPrinter.ShowPrintDialog: Boolean;
begin

end;

procedure TfrxPrinter.SetPrintParams(APaperSize: Integer;
  APaperWidth, APaperHeight: Extended; AOrientation: TPrinterOrientation;
  ABin, ADuplex, ACopies: Integer);
begin
  FMode.dmFields := FMode.dmFields or DM_PAPERSIZE or DM_ORIENTATION or DM_COPIES
    or DM_DEFAULTSOURCE;


  if APaperSize = 256 then
  begin
    FMode.dmFields := FMode.dmFields or DM_PAPERLENGTH or DM_PAPERWIDTH;
    if AOrientation = poLandscape then
    begin
      FMode.dmPaperLength := Round(APaperWidth * 10);
      FMode.dmPaperWidth := Round(APaperHeight * 10);
    end
    else
    begin
      FMode.dmPaperLength := Round(APaperHeight * 10);
      FMode.dmPaperWidth := Round(APaperWidth * 10);
    end;
  end
  else
  begin
    FMode.dmPaperLength := 0;
    FMode.dmPaperWidth := 0;
  end;

  FMode.dmPaperSize := APaperSize;
  if AOrientation = poPortrait then
    FMode.dmOrientation := DMORIENT_PORTRAIT else
    FMode.dmOrientation := DMORIENT_LANDSCAPE;

  FMode.dmCopies := ACopies;
  if ABin = DMBIN_AUTO then
    if FBin <> -1 then
      ABin := FBin
    else
      ABin := DefBin;
  FMode.dmDefaultSource := ABin;

  if ADuplex = 0 then
    ADuplex := FDefDuplex
  else Inc(ADuplex);
  if ADuplex = 4 then
    ADuplex := DMDUP_SIMPLEX;
  if FDuplex <> -1 then
    ADuplex := FDuplex;
  if ADuplex <> 1 then
    FMode.dmFields := FMode.dmFields  or DM_DUPLEX;
  FMode.dmDuplex := ADuplex;


  { strange behaviour with GDI+ canvas
    need to release canvas and all gdi+ objects before call ResetDC
    otherwise it return error  }
  if FCanvas <> nil then
    FCanvas.Free;

  FDC := ResetDC(FDC, FMode^);
  FDC := ResetDC(FDC, FMode^);  // needed for some printers
  TFakePrinterWin(FWinPrinter).FDC := FDC;
{$IFNDEF Delphi17}
  FCanvas := DefaultCanvasClass.CreateFromPrinter(FWinPrinter);
{$ELSE}
  FCanvas := TCanvasManager.CreateFromPrinter(FWinPrinter);
{$ENDIF}
  FOnChangedFont := THackCanvas(FCanvas).FFont.OnChanged;
  THackCanvas(FCanvas).FFont.OnChanged := FontChanged;


  //FCanvas.Refresh;
  if not UpdateDeviceCaps then Exit;
  FPaper := APaperSize;
  FOrientation := AOrientation;
end;

function TfrxPrinter.UpdateDeviceCaps: Boolean;
begin
  Result := True;
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
  FBottomMargin := FPaperHeight - Round(GetDeviceCaps(FDC, VERTRES) / FDPI.Y * 25.4) - FTopMargin;
end;

procedure TfrxPrinter.PropertiesDlg;
var
  h: THandle;
  PrevDuplex: Integer;
begin
  PrevDuplex := FMode.dmDuplex;
  //if Screen.ActiveForm <> nil then
  //  h := Screen.ActiveForm.Handle else
    h := 0;
  if DocumentProperties(h, FHandle, PChar(FName), FMode^,
    FMode^, DM_IN_BUFFER or DM_OUT_BUFFER or DM_IN_PROMPT) > 0 then
  begin
    FBin := FMode.dmDefaultSource;
    if PrevDuplex <> FMode.dmDuplex then
      FDuplex := FMode.dmDuplex;
    RecreateDC;
  end;
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
var
  prnName: array[0..255] of Char;
begin
  GetProfileString('windows', 'device', '', prnName,  255);
  Result := Copy(prnName, 1, Pos(',', prnName) - 1);
end;


procedure TfrxPrinters.FillPrinters;
var
  i, j: Integer;
  Buf, prnInfo: PByte;
  Flags, bufSize, prnCount: DWORD;
  Level: Byte;
  sl: TStringList;

  procedure AddPrinter(ADevice, APort: String);
  begin
    FPrinterList.Add(TfrxPrinter.Create(ADevice, APort));
    FPrinters.Add(ADevice);
  end;

begin
  Clear;
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    Flags := PRINTER_ENUM_CONNECTIONS or PRINTER_ENUM_LOCAL;
    Level := 4;
  end
  else
  begin
    Flags := PRINTER_ENUM_LOCAL;
    Level := 5;
  end;

  bufSize := 0;
  EnumPrinters(Flags, nil, Level, nil, 0, bufSize, prnCount);
  if bufSize = 0 then Exit;

  GetMem(Buf, bufSize);
  try

    if not EnumPrinters(Flags, nil, Level, PByte(Buf), bufSize, bufSize, prnCount) then
      Exit;
    prnInfo := Buf;
    for i := 0 to prnCount - 1 do
      if Level = 4 then
        with PPrinterInfo4(prnInfo)^ do
        begin
          AddPrinter(pPrinterName, '');
          Inc(prnInfo, SizeOf(TPrinterInfo4));
        end
      else
        with PPrinterInfo5(prnInfo)^ do
        begin
          sl := TStringList.Create;
          frxSetCommaText(pPortName, sl, ',');

          for j := 0 to sl.Count - 1 do
           AddPrinter(pPrinterName, sl[j]);

          sl.Free;
          Inc(prnInfo, SizeOf(TPrinterInfo5));
        end;

  finally
    FreeMem(Buf, bufSize);
  end;
end;




{ THackPrinterWin }

procedure TFakePrinterWin.ActivePrinterChanged;
begin
//do nothing
end;

constructor TFakePrinterWin.Create;
begin
  //inherited;
inherited;
end;

destructor TFakePrinterWin.Destroy;
begin
inherited;
  //inherited;
end;

procedure TFakePrinterWin.DoAbortDoc;
begin
  //do nothing
end;

procedure TFakePrinterWin.DoBeginDoc;
begin
  //do nothing
end;

procedure TFakePrinterWin.DoEndDoc;
begin
  //do nothing
end;

procedure TFakePrinterWin.DoNewPage;
begin
  //do nothing

end;

function TFakePrinterWin.GetCanvas: TCanvas;
begin

end;

function TFakePrinterWin.GetNumCopies: Integer;
begin
  //do nothing
end;

function TFakePrinterWin.GetOrientation: TPrinterOrientation;
begin
  //do nothing
end;

function TFakePrinterWin.GetPageHeight: Integer;
begin
  Result := FPageHeight;
end;

function TFakePrinterWin.GetPageWidth: Integer;
begin
  Result := FPageWidth;
end;

procedure TFakePrinterWin.RefreshFonts;
begin
  //do nothing
end;

procedure TFakePrinterWin.RefreshPrinterDevices;
begin
  //do nothing
end;

procedure TFakePrinterWin.SetDefaultPrinter;
begin
  //do nothing
end;

procedure TFakePrinterWin.SetNumCopies(Value: Integer);
begin
  //do nothing
end;

procedure TFakePrinterWin.SetOrientation(Value: TPrinterOrientation);
begin
 //do nothing
end;

function ActualfrxPrinterClass : TfrxCustomPrintersClass;
begin
  Result := TfrxPrinters;
end;

initialization

finalization

end.



//56db3b0f55102b9488a240d37950543f