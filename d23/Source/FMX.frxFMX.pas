{***************************************************}
{                                                   }
{             FastReport v4.0                       }
{          Things missing in FMX                    }
{                                                   }
{         Copyright (c) 1998-2011                   }
{         by Alexander Tzyganenko,                  }
{            Fast Reports Inc.                      }
{                                                   }
{***************************************************}

unit FMX.frxFMX;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Types, FMX.Controls,
  System.Types, System.UIConsts, FMX.ListBox, FMX.Objects, System.Math,
  FMX.TreeView, FMX.Edit, FMX.Forms, FMX.Platform, System.Variants
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF}
{$IFDEF DELPHI20}
  , System.Math.Vectors
{$ENDIF};

const
  DMBIN_AUTO = 7;
{$EXTERNALSYM DMBIN_AUTO}
  DMPAPER_A4 = 9;
{$EXTERNALSYM DMPAPER_A4}
  DMPAPER_USER = 256;
{$EXTERNALSYM DMPAPER_USER}
  VK_F1 = vkF1;
{$EXTERNALSYM VK_F1}
  poPortrait = TPrinterOrientation.poPortrait;
  poLandscape = TPrinterOrientation.poLandscape;
  fsBold = TFontStyle.fsBold;
  fsItalic = TFontStyle.fsItalic;
  fsUnderline = TFontStyle.fsUnderline;
  fsStrikeout = TFontStyle.fsStrikeout;
  mbLeft = TMouseButton.mbLeft;
  mbRight = TMouseButton.mbRight;
  alLeft = TAlignLayout.alLeft;
  alClient = TAlignLayout.alClient;
  taCenter = TTextAlign.taCenter;
  wsMaximized = TWindowState.wsMaximized;
  DefFontName = 'Arial';
  DefFontSize = 10;


type
  { VCL TFont compatibility }
  TfrxFont = class(TPersistent)
  private
    FName: String;
    FSize: Single;
    FPixelsPerInch: Single;
    FStyle: TFontStyles;
    FColor: TAlphaColor;
    FOnChange: TNotifyEvent;
    function GetHeight: Single; overload;
    procedure SetName(const Value: string);
    procedure SetSize(Value: Single);
    procedure SetStyle(Value: TFontStyles);
    procedure SetColor(Value: TAlphaColor);
    procedure SetHeight(Value: Single);
    procedure DoChange;
  public
    constructor Create;
    procedure Assign(Value: TfrxFont);
    procedure AssignToFont(Value: TFont);
    procedure AssignToCanvas(Canvas: TCanvas);
    function GetHeight(Canvas: TCanvas): Single; overload;
  published
    property Name: String read FName write SetName;
    property Size: Single read FSize write SetSize stored False;
    property PixelsPerInch: Single read FPixelsPerInch write FPixelsPerInch;
    property Style: TFontStyles read FStyle write SetStyle;
    property Color: TAlphaColor read FColor write SetColor;
    property Height: Single read GetHeight write SetHeight;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TfrxImageList = class(TComponent)
  private
    FImages: TList;
    FWidth: Integer;
    FHeight: Integer;
    function GetCount: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
{$IFDEF DELPHI19}
    procedure AddMasked(Bmp: FMX.Graphics.TBitmap; Color: TAlphaColor);
 {$ELSE}
    procedure AddMasked(Bmp: FMX.Types.TBitmap; Color: TAlphaColor);
{$ENDIF}
    procedure Draw(Canvas: TCanvas; x, y: Single; Index: Integer);
    function Get(Index: Integer): TBitmap;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property Count: Integer read GetCount;
  end;

[ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxToolButton = class(TSpeedButton)
  private
{$IFDEF DELPHI19}
	FBitmap: FMX.Graphics.TBitmap;
 {$ELSE}
    FBitmap: FMX.Types.TBitmap;
{$ENDIF}
    FDown: Boolean;
    FHint: String;
{$IFDEF DELPHI19}
	procedure SetBitmap(const Value: FMX.Graphics.TBitmap);
 {$ELSE}
    procedure SetBitmap(const Value: FMX.Types.TBitmap);
{$ENDIF}
  protected
    procedure DoMouseEnter; override;
    procedure DoMouseLeave; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoPaint; override;
    property Down: Boolean read FDown write FDown;
  published
{$IFDEF DELPHI19}
	property Bitmap: FMX.Graphics.TBitmap read FBitmap write SetBitmap;
 {$ELSE}
    property Bitmap: FMX.Types.TBitmap read FBitmap write SetBitmap;
{$ENDIF}
    property Hint: String read FHint write FHint;
{$IFDEF Delphi17}
    property TabOrder;
{$ENDIF}
  end;

  TfrxToolSeparator = class(TControl)
  public
    procedure Paint; override;
{$IFDEF Delphi17}
  published
    property Position;
    property Width;
    property Height;
{$ENDIF}
  end;

  TfrxToolGrip = class(TControl)
  public
    procedure Paint; override;
{$IFDEF Delphi17}
  published
    property Position;
    property Width;
    property Height;
{$ENDIF}
  end;

  TfrxTreeViewItem = class(TTreeViewItem)
  private
    FButton: TCustomButton;
    FCloseImageIndex: Integer;
    FOpenImageIndex: Integer;
    FImgPos: Single;
    FData: TObject;
    function GetBitmap():TBitmap;
  protected
    procedure ApplyStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
    property CloseImageIndex: Integer read FCloseImageIndex write FCloseImageIndex;
    property OpenImageIndex: Integer read FOpenImageIndex write FOpenImageIndex;
    property Data: TObject read FData write FData;
  end;

  TfrxOnEditedEvent = procedure(Sender: TObject; Node: TfrxTreeViewItem; var S: String) of Object;
  TfrxOnBeforeChangeEvent = procedure(Sender: TObject; OldNode: TfrxTreeViewItem; NewNode: TfrxTreeViewItem) of Object;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxTreeView = class(TTreeView)
  private
{$IFDEF DELPHI19}
	FPicBitmap: FMX.Graphics.TBitmap;
{$ELSE}
    FPicBitmap: FMX.Types.TBitmap;
{$ENDIF}
    FIconWidth: Integer;
    FIconHeight: Integer;
    FEditBox: TEdit;
    FIsEditing: Boolean;
    FEditable: Boolean;
    FFreePicOnDelete: Boolean;
    FOnEdited: TfrxOnEditedEvent;
    FOnBeforeChange: TfrxOnBeforeChangeEvent;
    FManualDragAndDrop: Boolean;
  protected
    procedure DoEditKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure DoExit; override;
    procedure SetSelected(const Value: TTreeViewItem); override;
    procedure DblClick; override;
    procedure DoExitEdit (Sender: TObject);
    procedure BeginAutoDrag; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoEdit();
    procedure EndEdit(Accept: Boolean);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState); override;
    procedure LoadResouces(Stream: TStream; IconWidth, IconHeight: Integer);
    property PicPitmap: TBitmap read FPicBitmap write FPicBitmap;
    property IconWidth: Integer read FIconWidth write FIconWidth;
    property IconHeight: Integer read FIconHeight write FIconHeight;
    function GetBitmapRect(Index: Integer): TRectF;
    procedure DragOver(const Data: TDragObject; const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF}); override;
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); override;
    function AddItem(Root: TFmxObject; Text: String): TfrxTreeViewItem;
{$IFDEF DELPHI19}
	procedure SetImages(Bmp: FMX.Graphics.TBitmap);
{$ELSE}
    procedure SetImages(Bmp: FMX.Types.TBitmap);
{$ENDIF}
    property IsEditing: Boolean read FIsEditing;
    property ManualDragAndDrop: Boolean read FManualDragAndDrop write FManualDragAndDrop;
  published
    property StyleLookup;
    property CanFocus default True;
    property DisableFocusEffect;
    property TabOrder;
    property AllowDrag default False;
    property AlternatingRowBackground default False;
    property ItemHeight;
{$IFNDEF Delphi17}
    property HideSelectionUnfocused default False;
{$ENDIF}
    property MultiSelect default False;
    property ShowCheckboxes default False;
    property Sorted default False;
    property OnChange;
    property OnChangeCheck;
    property OnCompare;
    property OnDragChange;
    property OnEdited: TfrxOnEditedEvent read FOnEdited write FOnEdited;
    property OnBeforeChange: TfrxOnBeforeChangeEvent read FOnBeforeChange write FOnBeforeChange;
    property Editable: Boolean read FEditable write FEditable;
  end;

  TfrxListBoxItem = class(TListBoxItem)
  private
    FButton: TButton;
    FCheck: TCheckBox;
    FCheckVisible : Boolean;
    function GetCheckVisible: Boolean;
    procedure SetCheckVisible(const Value: Boolean);
    procedure OnBtnClick(Sender: TObject);
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property CheckVisible: Boolean read GetCheckVisible write SetCheckVisible;
  end;

  TfrxOnButtonClick = procedure (Sender: TObject; aButton: TObject; aItem: TfrxListBoxItem) of Object;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxListBox = class(TListBox)
  private type
    TfrxListBoxStrings = class(TStrings)
    private
      [Weak] FListBox: TCustomListBox;
      procedure ReadData(Reader: TReader);
      procedure WriteData(Writer: TWriter);
    protected
      procedure Put(Index: Integer; const S: string); override;
      function Get(Index: Integer): string; override;
      function GetCount: Integer; override;
      function GetObject(Index: Integer): TObject; override;
      procedure PutObject(Index: Integer; AObject: TObject); override;
      procedure SetUpdateState(Updating: Boolean); override;
      procedure DefineProperties(Filer: TFiler); override;
    public
      function Add(const S: string): Integer; override;
      procedure Clear; override;
      procedure Delete(Index: Integer); override;
      procedure Exchange(Index1, Index2: Integer); override;
      function IndexOf(const S: string): Integer; override;
      procedure Insert(Index: Integer; const S: string); override;
    end;
  private
    FManualDragAndDrop: Boolean;
    FOnButtonClickEvnt: TfrxOnButtonClick;
    FItems: TStrings;
    FCheckBoxText: String;
    FButtonText: String;
    FShowButtons: Boolean;
    function ItemsStored: Boolean;
    procedure SetItems(const Value: TStrings);
  protected
    procedure BeginAutoDrag; override;
    procedure DragEnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DragOver(const Data: TDragObject; const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF}); override;
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); override;
    procedure DoButtonClick(aButton: TObject; aItem: TfrxListBoxItem);
    procedure Assign(Source: TPersistent); override;
    property ManualDragAndDrop: Boolean read FManualDragAndDrop write FManualDragAndDrop;
    property Items: TStrings read FItems write SetItems stored ItemsStored;
  published
    property StyleLookup;
    property CanFocus default True;
    property DisableFocusEffect;
    property TabOrder;
    property AllowDrag default False;
    property AlternatingRowBackground default False;
    property ItemHeight;
    property MultiSelect default False;
    property ShowCheckboxes default False;
    property Sorted default False;
    property OnChange;
    property OnChangeCheck;
    property OnCompare;
    property OnDragChange;
    property ShowButtons: Boolean read FShowButtons write FShowButtons;
    property CheckBoxText: String read FCheckBoxText write FCheckBoxText;
    property ButtonText: String read FButtonText write FButtonText;
    property OnButtonClick: TfrxOnButtonClick read FOnButtonClickEvnt write FOnButtonClickEvnt;
  end;



function GetLongHint(const Hint: string): string;
function GetShortHint(const Hint: string): string;

procedure FillFontsList(List: TStrings);
function GetComponentForm(Comp: TFmxObject): TCommonCustomForm;
procedure SetClipboard(const Value: String);
function GetClipboard: String;
{$IFDEF DELPHI19}
function CreateRotationMatrix(const Angle: Single): TMatrix;
function CreateScaleMatrix(const ScaleX, ScaleY: Single): TMatrix;
function CreateTranslateMatrix(const DX, DY: Single): TMatrix;
function MatrixMultiply(const M1, M2: TMatrix): TMatrix;
{$ENDIF}
implementation

uses FMX.frxClass
{$IFDEF MSWINDOWS}
, Winapi.Windows, Winapi.WinSpool, Winapi.Messages
{$ELSE}
, Macapi.CoreText, Macapi.CoreFoundation, MacApi.CocoaTypes, Macapi.Foundation
{$ENDIF};

{$IFDEF DELPHI19}

const
  IdentityMatrix: TMatrix = (m11: 1.0; m12: 0.0; m13: 0.0; m21: 0.0; m22: 1.0; m23: 0.0; m31: 0.0; m32: 0.0; m33: 1.0);

type
  THackCustomListBox = class(TCustomListBox);
function CreateScaleMatrix(const ScaleX, ScaleY: Single): TMatrix;
begin
  Result := IdentityMatrix;
  Result.m11 := ScaleX;
  Result.m22 := ScaleY;
end;

function CreateTranslateMatrix(const DX, DY: Single): TMatrix;
begin
  Result := IdentityMatrix;
  Result.m31 := DX;
  Result.m32 := DY;
end;

function CreateRotationMatrix(const Angle: Single): TMatrix;
var
  cosine, sine: Extended;
begin
  SinCos(Angle, sine, cosine);

  Result.m11 := cosine;
  Result.m12 := sine;
  Result.m13 := 0;
  Result.m21 := -sine;
  Result.m22 := cosine;
  Result.m23 := 0;

  Result.m31 := 0;
  Result.m32 := 0;
  Result.m33 := 1;
end;

function MatrixMultiply(const M1, M2: TMatrix): TMatrix;
begin
  Result.m11 := M1.m11 * M2.m11 + M1.m12 * M2.m21 + M1.m13 * M2.m31;
  Result.m12 := M1.m11 * M2.m12 + M1.m12 * M2.m22 + M1.m13 * M2.m32;
  Result.m13 := M1.m11 * M2.m13 + M1.m12 * M2.m23 + M1.m13 * M2.m33;
  Result.m21 := M1.m21 * M2.m11 + M1.m22 * M2.m21 + M1.m23 * M2.m31;
  Result.m22 := M1.m21 * M2.m12 + M1.m22 * M2.m22 + M1.m23 * M2.m32;
  Result.m23 := M1.m21 * M2.m13 + M1.m22 * M2.m23 + M1.m23 * M2.m33;
  Result.m31 := M1.m31 * M2.m11 + M1.m32 * M2.m21 + M1.m33 * M2.m31;
  Result.m32 := M1.m31 * M2.m12 + M1.m32 * M2.m22 + M1.m33 * M2.m32;
  Result.m33 := M1.m31 * M2.m13 + M1.m32 * M2.m23 + M1.m33 * M2.m33;
end;
{$ENDIF}

function GetLongHint(const Hint: string): string;
var
  I: Integer;
begin
  I := Pos('|', Hint);
  if I = 0 then
    Result := Hint else
    Result := Copy(Hint, I + 1, Maxint);
end;

function GetShortHint(const Hint: string): string;
var
  I: Integer;
begin
  I := Pos('|', Hint);
  if I = 0 then
    Result := Hint else
    Result := Copy(Hint, 1, I - 1);
end;

procedure SetClipboard(const Value: String);
{$IFDEF Delphi17}
var
  ClipService: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(ClipService)) then
    ClipService.SetClipboard(Value);
end;
{$ELSE}
begin
  Platform.SetClipboard(Value);
end;
{$ENDIF}

function GetClipboard: String;
{$IFDEF Delphi17}
var
  ClipService: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(ClipService)) then
    Result := ClipService.GetClipboard.ToString
  else
    Result := '';
end;
{$ELSE}
begin
  Result := VarToStr(Platform.GetClipboard);
end;
{$ENDIF}


{$IFDEF MSWINDOWS}
function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
    FontType: DWORD; Data: LPARAM): Integer; stdcall;
begin
  if(Data <> 0) then
    if (TStrings(Data).IndexOf(LogFont.lfFaceName) < 0) then
      TStringList(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

procedure FillFontsList(List: TStrings);
var
  dc: HDC;
  sortedList: TStringList;
  LFont: TLogFont;

begin
  sortedList := TStringList.Create;
  dc := GetDC(0);
  try
    FillChar(LFont, sizeof(LFont), 0);
    LFont.lfCharset := DEFAULT_CHARSET;
    EnumFontFamiliesEx(dc, LFont, @EnumFontsProc, LPARAM(sortedList), 0);
  finally
    ReleaseDC(0, dc);
  end;
  sortedList.Sort;

  List.BeginUpdate;
  List.Clear;
  List.AddStrings(sortedList);
  List.EndUpdate;
  sortedList.Free;
end;
{$ELSE}
var
  kCTFontFamilyNameAttribute_: Pointer = nil;

function kCTFontFamilyNameAttribute: Pointer;
var
  CTLib: HMODULE;
begin
  if kCTFontFamilyNameAttribute_ = nil then
  begin
    CTLib := LoadLibrary(libCoreText);
    kCTFontFamilyNameAttribute_ := Pointer(GetProcAddress(CTLib, PWideChar('kCTFontFamilyNameAttribute'))^);
    FreeLibrary(CTLib);
  end;
  Result := kCTFontFamilyNameAttribute_;
end;

function ConvCFString(const Value: CFStringRef): String;
begin
  if Assigned(Value) then
    Result := string(TNSString.Wrap(Value).UTF8String)
  else
    Result := '';
end;

procedure FillFontsList(List: TStrings);
var
  collection: CTFontCollectionRef;
  arr: CFArrayRef;
  fontDescr: CTFontDescriptorRef;
  fontName: String;
  i, arrnum: Integer;
  sortedList: TStringList;
begin
  sortedList := TStringList.Create;
  sortedList.Sorted := True;
  try
    collection := CTFontCollectionCreateFromAvailableFonts(nil);
    arr := CTFontCollectionCreateMatchingFontDescriptors(collection);
    try
      arrnum := CFArrayGetCount(arr);
      for i := 0 to arrnum - 1 do
      begin
        fontDescr := CFArrayGetValueAtIndex(arr, i);
        fontName := ConvCFString(CTFontDescriptorCopyAttribute(fontDescr, kCTFontFamilyNameAttribute));
        if sortedList.IndexOf(fontName) = -1 then
          sortedList.Add(fontName);
      end;
    finally
      CFRelease(arr);
      CFRelease(collection);
    end;
  except
    sortedList.Add('Unable to retrieve fonts');
  end;

  List.BeginUpdate;
  List.Clear;
  List.AddStrings(sortedList);
  List.EndUpdate;
  sortedList.Free;
end;
{$ENDIF}

function GetComponentForm(Comp: TFmxObject): TCommonCustomForm;
begin
  Result := nil;
  while (Comp.Parent <> nil) do
  begin
    if (Comp.Parent is TCommonCustomForm) then
    begin
      Result := Comp.Parent as TCommonCustomForm;
      Exit;
    end;
    Comp := Comp.Parent;
  end;
end;

{ TfrxFont }

constructor TfrxFont.Create;
begin
  FName := DefFontName;
  FSize := DefFontSize;
  FColor := claBlack;
  FPixelsPerInch := frxDefPPI;
end;

procedure TfrxFont.Assign(Value: TfrxFont);
begin
  FName := Value.Name;
  FSize := Value.Size;
  FStyle := Value.Style;
  FColor := Value.Color;
  DoChange;
end;

procedure TfrxFont.AssignToFont(Value: TFont);
begin
  Value.Family := FName;
  Value.Size := FSize;
  Value.Style := FStyle;
end;

procedure TfrxFont.AssignToCanvas(Canvas: TCanvas);
begin
  Canvas.Font.Family := Name;
  Canvas.Font.Size := Size * FPixelsPerInch / 72;
  Canvas.Font.Style := Style;
  Canvas.Fill.Color := Color;
end;

procedure TfrxFont.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TfrxFont.GetHeight(Canvas: TCanvas): Single;
begin
// todo
  Result := Size * FPixelsPerInch / 72;
end;

procedure TfrxFont.SetName(const Value: string);
begin
  if FName <> Value then
  begin
    FName := Value;
    DoChange;
  end;
end;

procedure TfrxFont.SetSize(Value: Single);
begin
  if FSize <> Value then
  begin
    FSize := Value;
    DoChange;
  end;
end;

procedure TfrxFont.SetStyle(Value: TFontStyles);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    DoChange;
  end;
end;

procedure TfrxFont.SetColor(Value: TAlphaColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    DoChange;
  end;
end;

procedure TfrxFont.SetHeight(Value: Single);
begin
  Size := - Value * 72 / FPixelsPerInch;
end;

function TfrxFont.GetHeight: Single;
begin
  Result := - Size * FPixelsPerInch / 72;
end;


{ TfrxImageList }

constructor TfrxImageList.Create(AOwner: TComponent);
begin
  inherited;
  FImages := TList.Create;
end;

destructor TfrxImageList.Destroy;
begin
  FImages.Destroy;
  inherited;
end;


procedure TfrxImageList.Clear;
begin
  FImages.Clear;
end;

{$IFDEF DELPHI19}
	procedure TfrxImageList.AddMasked(Bmp: FMX.Graphics.TBitmap; Color: TAlphaColor);
{$ELSE}
    procedure TfrxImageList.AddMasked(Bmp: FMX.Types.TBitmap; Color: TAlphaColor);
{$ENDIF}
begin
  FImages.Add(Bmp);
end;

procedure TfrxImageList.Draw(Canvas: TCanvas; x, y: Single; Index: Integer);
begin
end;

function TfrxImageList.GetCount: Integer;
begin
  Result := FImages.Count;
end;

{$IFDEF DELPHI19}
function TfrxImageList.Get(Index: Integer): FMX.Graphics.TBitmap;
begin
  Result := FMX.Graphics.TBitmap(FImages[Index]);
end;
{$ELSE}
function TfrxImageList.Get(Index: Integer): FMX.Types.TBitmap;
begin
  Result := FMX.Types.TBitmap(FImages[Index]);
end;
{$ENDIF}

{ TfrxToolButton }

constructor TfrxToolButton.Create(AOwner: TComponent);
begin
{$IFDEF DELPHI19}
  FBitmap := FMX.Graphics.TBitmap.Create(0,0);
{$ELSE}
  FBitmap := FMX.Types.TBitmap.Create(0,0);
{$ENDIF}
  inherited;
end;

destructor TfrxToolButton.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TfrxToolButton.DoMouseEnter;
begin
  inherited;
  Repaint;
end;

procedure TfrxToolButton.DoMouseLeave;
begin
  inherited;
  Repaint;
end;

procedure TfrxToolButton.DoPaint;
var
  rect: TRectF;
  bmpRect: TRectF;
  m, oldM: TMatrix;
  state: TCanvasSaveState;
begin
  OldM := Canvas.Matrix;
  State := Canvas.SaveState;

  try
    Canvas.SetMatrix(CreateTranslateMatrix(AbsoluteRect.Left, AbsoluteRect.Top));
    rect := RectF(0.5, 0.5, Width - 0.5, Height - 0.5);

    bmpRect.Top := Round((Self.Height - FBitmap.Height)/ 2);
    bmpRect.Left := Round((Self.Width - FBitmap.Width) / 2);
    bmpRect.Bottom := bmpRect.Top + FBitmap.Height;
    bmpRect.Right := bmpRect.Left + FBitmap.Width;

    if csDesigning in ComponentState then
    begin
      Canvas.Stroke.Color := claBlack;
      Canvas.Stroke.Kind := TBrushKind.bkSolid;
      Canvas.StrokeThickness := 2;
      Canvas.DrawRect(RectF(0, 0, Width, Height), 1, 1, AllCorners, 1, TCornerType.ctBevel);
    end;

    if Enabled then
      Canvas.DrawBitmap(FBitmap, RectF(0, 0, FBitmap.Width, FBitmap.Height), bmpRect, 1 )
    else
      Canvas.DrawBitmap(FBitmap, RectF(0, 0, FBitmap.Width, FBitmap.Height), bmpRect, 0.2 );

    if IsMouseOver or IsPressed then
    begin
      Canvas.Stroke.Color := claBlack;
      Canvas.Stroke.Kind := TBrushKind.bkSolid;
      Canvas.StrokeThickness := 1;
      Canvas.Fill.Color := claBlack;
      Canvas.Fill.Kind := TBrushKind.bkSolid;
      Canvas.FillRect(rect, 1, 1, AllCorners, 0.1, TCornerType.ctInnerRound);
      Canvas.DrawRect(rect, 1, 1, AllCorners, 0.3, TCornerType.ctInnerRound);
    end;
{$IFNDEF DELPHI18}
    if Text <> '' then
      Canvas.FillText(RectF(0, 0, Width, Height), Text, False, 1, [], TTextAlign.taCenter);
{$ENDIF}
  finally
    Canvas.RestoreState(state);
    Canvas.SetMatrix(OldM);
  end;
end;

procedure TfrxToolSeparator.Paint;
begin
  with Canvas do
  begin
    Stroke.Color := claGray;
    Stroke.Kind := TBrushKind.bkSolid;
    StrokeThickness := 1;

    if Self.Width > Self.Height then
    begin
      DrawLine(PointF(0, 0.5), PointF(Self.Width, 0.5), 1);
      Stroke.Color := claWhite;
      DrawLine(PointF(0, 1.5), PointF(Self.Width, 1.5), 1);
    end
    else
    begin
      DrawLine(PointF(0.5, 0), PointF(0.5, Self.Height), 1);
      Stroke.Color := claWhite;
      DrawLine(PointF(1.5, 0), PointF(1.5, Self.Height), 1);
    end;
  end;
end;

procedure TfrxToolGrip.Paint;
var
  i: Integer;
begin
  with Canvas do
  begin
    Fill.Kind := TBrushKind.bkSolid;

    for i := 0 to 3 do
      if Self.Width > Self.Height then
      begin
        Fill.Color := claGray;
        FillRect(RectF(i * 4, 0, i * 4 + 2, 2), 0, 0, allCorners, 1);
      end
      else
      begin
        Fill.Color := claGray;
        FillRect(RectF(0, i * 4, 2, i * 4 + 2), 0, 0, allCorners, 1);
      end;
  end;
end;

{ TfrxTreeViewItem }

procedure TfrxTreeViewItem.ApplyStyle;
var
  B: TFmxObject;
  Offset: Single;
begin
  inherited;
  B := FindStyleResource('button');
  if (B <> nil) and (B is TCustomButton) then
  begin
    FButton := TCustomButton(B);
    B := FindStyleResource('text');
    Offset := 0;
    if Self.TreeView is TfrxTreeView then
      Offset := TfrxTreeView(Self.TreeView).IconWidth;

    if (B <> nil) and (B is TText) then
{$IFDEF DELPHI18}
      TText(B).Margins.Left := Offset;
{$ELSE}
      TText(B).Padding.Left :=  Offset;
{$ENDIF}
      FImgPos := FButton.Position.X + FButton.Width - 2;
  end;
end;


constructor TfrxTreeViewItem.Create(AOwner: TComponent);
begin
  inherited;
  FImgPos := 0;
  FCloseImageIndex := -1;
  FOpenImageIndex := -1;
end;

{$IFDEF DELPHI19}
function TfrxTreeViewItem.GetBitmap: FMX.Graphics.TBitmap;
{$ELSE}
function TfrxTreeViewItem.GetBitmap: FMX.Types.TBitmap;
{$ENDIF}
begin
  Result := nil;
  if TreeView is TfrxTreeView then
  begin
    Result := TfrxTreeView(TreeView).FPicBitmap;
  end;
end;

procedure TfrxTreeViewItem.Paint;
var
{$IFDEF DELPHI19}
  Bmp: FMX.Graphics.TBitmap;
{$ELSE}
  Bmp: FMX.Types.TBitmap;
{$ENDIF}
  IconRect: TRectF;
  Index: Integer;
begin
  inherited Paint;
  if IsExpanded then
    Index := FOpenImageIndex
  else
    Index := FCloseImageIndex;

  if Index = -1 then Exit;


  Bmp := GetBitmap;
  if TreeView is TfrxTreeView then
  begin
    IconRect := TfrxTreeView(TreeView).GetBitmapRect(Index);
  end;
  if (Bmp <> nil) and (FImgPos > 0)then
    Canvas.DrawBitmap(Bmp, IconRect, RectF(16, 0, 32, 16), 1 );
end;

{ TfrxTreeView }

function TfrxTreeView.AddItem(Root: TFmxObject; Text: String): TfrxTreeViewItem;
begin
  Result := TfrxTreeViewItem.Create(Root);
  Result.Text := Text;
  Root.AddObject(Result);
end;

constructor TfrxTreeView.Create(AOwner: TComponent);
begin
  inherited;
  FPicBitmap := nil;
  FIconWidth := 16;
  FIconHeight := 16;
  FEditBox := TEdit.Create(Self);
  FEditBox.Parent := Self;
  FEditBox.Visible := False;
  FEditBox.OnKeyDown := DoEditKeyDown;
  FEditBox.OnEnter := DoExitEdit;
  FIsEditing := False;
  FEditable := False;
  FFreePicOnDelete := False;
  FManualDragAndDrop := False;
end;

procedure TfrxTreeView.DblClick;
begin
  inherited;
  DoEdit;
end;

destructor TfrxTreeView.Destroy;
begin
  if (FPicBitmap <> nil) and FFreePicOnDelete then
    FPicBitmap.Free;

  inherited;
end;

procedure TfrxTreeView.DoEdit;
var
  r: TRectF;
begin
  if (Selected = nil) or (not FEditable) then exit;

  FEditBox.Text := Selected.Text;
  r := Self.GetItemRect(Selected);
  //p := Selected.LocalToAbsolute(PointF(Selected.Position.X, Selected.Position.Y));
  FEditBox.SetBounds(r.Left, r.Top, r.Width, r.Height);
  Selected.Visible := False;
  FEditBox.Visible := True;
  FEditBox.SetFocus;
  FIsEditing := True;
end;

procedure TfrxTreeView.DoEditKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkReturn then
    EndEdit(True)
  else if Key = vkEscape then
    EndEdit(False);
end;

procedure TfrxTreeView.DoExit;
begin
  inherited;
  EndEdit(False);
end;

procedure TfrxTreeView.DoExitEdit(Sender: TObject);
begin
  EndEdit(False);
end;

procedure TfrxTreeView.BeginAutoDrag;
var
{$IFDEF DELPHI19}
  S: FMX.Graphics.TBitmap;
{$ELSE}
  S: FMX.Types.TBitmap;
{$ENDIF}

begin
  if (Selected = nil) or (Root = nil) then
    Exit;
  S := Selected.MakeScreenshot;
  try
{$IFNDEF DELPHI20}
    FRoot.BeginInternalDrag(Self, S);
{$ELSE}
    Root.BeginInternalDrag(Self, S);
{$ENDIF}
  finally
    S.Free;
  end;
end;

procedure TfrxTreeView.DragDrop(const Data: TDragObject; const Point: TPointF);
begin
  //inherited;
  // don't use TTreeView handlers
end;

procedure TfrxTreeView.DragOver(const Data: TDragObject; const Point: TPointF;
  {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF});
begin
  //inherited;
  //don't use TTreeView handlers
end;

procedure TfrxTreeView.EndEdit(Accept: Boolean);
var
  S: String;
begin
  if (Selected = nil) or (FEditBox.Text = '') or not FIsEditing then exit;
  FEditBox.Parent := Self;
  if Accept then
  begin
    Selected.Text := FEditBox.Text;
    S := Selected.Text;
   if Assigned(FOnEdited) then
   begin
    FOnEdited(Self, TfrxTreeViewItem(Selected), S);
    Selected.Text := S;
   end;
  end;
  FEditBox.Visible := False;
  Selected.Visible := True;
  Self.SetFocus;
  FIsEditing := False;
end;

function TfrxTreeView.GetBitmapRect(Index: Integer): TRectF;
var
  ColCount, ColId, RowId: Integer;
begin
  Result := RectF(0, 0, 0, 0);
  if FPicBitmap = nil then Exit;

  ColCount := FPicBitmap.Width div FIconWidth;
  RowId := Index div ColCount;
  ColId := Index mod ColCount;
  Result := RectF(FIconWidth * ColId, FIconHeight * RowId, FIconWidth * ColId + FIconWidth, FIconHeight * RowId + FIconHeight);
end;

procedure TfrxTreeView.KeyDown(var Key: Word; var KeyChar: WideChar;
  Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
    DoEdit;
end;

procedure TfrxTreeView.LoadResouces(Stream: TStream; IconWidth,
  IconHeight: Integer);
begin
  FIconWidth := IconWidth;
  FIconHeight := IconHeight;
  FFreePicOnDelete := True;
  if FPicBitmap = nil then
{$IFDEF DELPHI19}
	FPicBitmap := FMX.Graphics.TBitmap.CreateFromStream(Stream)
{$ELSE}
	FPicBitmap := FMX.Types.TBitmap.CreateFromStream(Stream)
{$ENDIF}
  else
    FPicBitmap.LoadFromStream(Stream);
end;



procedure TfrxTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Single);
begin
  EndEdit(True);
  inherited;
{$IFDEF DELPHI18}
  if (DragMode = TDragMode.dmManual) and FManualDragAndDrop then
    BeginAutoDrag;
{$ENDIF}
end;

{$IFDEF DELPHI19}
procedure TfrxTreeView.SetImages(Bmp: FMX.Graphics.TBitmap);
{$ELSE}
procedure TfrxTreeView.SetImages(Bmp: FMX.Types.TBitmap);
{$ENDIF}
begin
  if (FPicBitmap <> nil) and FFreePicOnDelete then
    FPicBitmap.Free;
  FFreePicOnDelete := False;
  FPicBitmap := Bmp;
end;

procedure TfrxTreeView.SetSelected(const Value: TTreeViewItem);
begin
  if Assigned(FOnBeforeChange) then
    FOnBeforeChange(Self, TfrxTreeViewItem(Selected), TfrxTreeViewItem(Value));
  EndEdit(True);
  inherited;
end;

{$IFDEF DELPHI19}
procedure TfrxToolButton.SetBitmap(const Value: FMX.Graphics.TBitmap);
{$ELSE}
procedure TfrxToolButton.SetBitmap(const Value: FMX.Types.TBitmap);
{$ENDIF}
begin
  FBitmap.Assign(Value);
end;


{ TfrxListBox }

procedure TfrxListBox.Assign(Source: TPersistent);
var
  i: Integer;
  Item: TListBoxItem;
begin
  if Source is TStrings then
  begin
    BeginUpdate;
    try
      Clear;
      for i := 0 to TStrings(Source).Count - 1 do
      begin
        Item := TfrxListBoxItem.Create(Owner);
        if i <> TStrings(Source).Count - 1 then
          TfrxListBoxItem(Item).CheckVisible := True;
        Item.Parent := Self;
        Item.Text := TStrings(Source)[i];
      end;
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;

procedure TfrxListBox.BeginAutoDrag;
var
{$IFDEF DELPHI19}
  S: FMX.Graphics.TBitmap;
{$ELSE}
  S: FMX.Types.TBitmap;
{$ENDIF}

begin
  if (Selected = nil) or (Root = nil) then
    Exit;
  S := Selected.MakeScreenshot;
  try
{$IFNDEF DELPHI20}
    FRoot.BeginInternalDrag(Self, S);
{$ELSE}
    Root.BeginInternalDrag(Self, S);
{$ENDIF}
  finally
    S.Free;
  end;
end;

constructor TfrxListBox.Create(AOwner: TComponent);
begin
  inherited;
  FManualDragAndDrop := False;
  FShowButtons := False;
  FItems := TfrxListBoxStrings.Create;
  TfrxListBoxStrings(FItems).FListBox := Self;
end;

destructor TfrxListBox.Destroy;
begin
  inherited;
  FreeAndNil(FItems);
end;

procedure TfrxListBox.DoButtonClick(aButton: TObject; aItem: TfrxListBoxItem);
begin
  if Assigned(OnButtonClick) then
    OnButtonClick(Self, aButton, aItem);
end;

procedure TfrxListBox.DragDrop(const Data: TDragObject; const Point: TPointF);
begin
  inherited;
end;

procedure TfrxListBox.DragEnd;
begin
  inherited;
  DragLeave;
end;

procedure TfrxListBox.DragOver(const Data: TDragObject; const Point: TPointF;
  {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF});
begin
    if Assigned(OnDragOver) then
      OnDragOver(Self, Data, Point, {$IFNDEF DELPHI20}Accept{$ELSE}Operation{$ENDIF});
  //don't use TListBox handlers
end;

function TfrxListBox.ItemsStored: Boolean;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if ListItems[I].Stored then
      Exit(False);
  Result := True;
end;

procedure TfrxListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Single);
begin
  inherited;
{$IFDEF DELPHI18}
  if (DragMode = TDragMode.dmManual) and FManualDragAndDrop then
    BeginAutoDrag;
{$ENDIF}
end;

procedure TfrxListBox.SetItems(const Value: TStrings);
begin
  Items.Assign(Value);
end;

{ TfrxListBox.TfrxListBoxStrings }

function TfrxListBox.TfrxListBoxStrings.Add(const S: string): Integer;
var
  Item: TListBoxItem;
begin
  Item := TfrxListBoxItem.Create(FListBox);
  try
    Item.Text := S;
    Item.Stored := False;
    FListBox.AddObject(Item);
{$IFDEF DELPHI19}
    Item.StyleLookup := FListBox.DefaultItemStyles.ItemStyle;
    THackCustomListBox(FListBox).DispatchStringsChangeEvent(S, TCustomListBox.TStringsChangeOp.tsoAdded);
{$ENDIF}
    Result := Item.Index;
  except
    Item.Free;
    raise;
  end;
end;

procedure TfrxListBox.TfrxListBoxStrings.Clear;
begin
  if not (csDestroying in FListBox.ComponentState) then
    FListBox.Clear;
end;

procedure TfrxListBox.TfrxListBoxStrings.DefineProperties(Filer: TFiler);
  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then
    begin
      Result := True;
      if Filer.Ancestor is TStrings then
        Result := not Equals(TStrings(Filer.Ancestor))
    end
    else
      Result := Count > 0;
  end;
begin
  Filer.DefineProperty('Strings', ReadData, WriteData, DoWrite);
end;

procedure TfrxListBox.TfrxListBoxStrings.Delete(Index: Integer);
var
  Item: TListBoxItem;
begin
  Item := FListBox.ListItems[Index];
  if Assigned(Item) then
  begin
{$IFDEF DELPHI19}
    if Item = FListBox.ItemDown then
      FListBox.ItemDown := nil;
{$ENDIF}
    FListBox.RemoveObject(Item);
    Item.Free;
  end;
end;

procedure TfrxListBox.TfrxListBoxStrings.Exchange(Index1, Index2: Integer);
begin
  FListBox.Exchange(FListBox.ItemByIndex(Index1), FListBox.ItemByIndex(Index2));

end;

function TfrxListBox.TfrxListBoxStrings.Get(Index: Integer): string;
begin
  Result := FListBox.ListItems[Index].Text;
end;

function TfrxListBox.TfrxListBoxStrings.GetCount: Integer;
begin
   Result := FListBox.Count;
end;

function TfrxListBox.TfrxListBoxStrings.GetObject(Index: Integer): TObject;
begin
  Result := FListBox.ListItems[Index].Data;
end;

function TfrxListBox.TfrxListBoxStrings.IndexOf(const S: string): Integer;
var
  I: Integer;
begin
  for I := 0 to FListBox.Count - 1 do
    if SameText(FListBox.ListItems[I].Text, S) then
      Exit(I);
  Result := -1;

end;

procedure TfrxListBox.TfrxListBoxStrings.Insert(Index: Integer;
  const S: string);
var
  Item: TListBoxItem;
begin
  Item := TfrxListBoxItem.Create(FListBox);
  try
    if Index <> Count - 1 then
      TfrxListBoxItem(Item).CheckVisible := True;
    Item.Text := S;
    Item.Stored := False;
    FListBox.InsertObject(Index, Item);
  except
    Item.Free;
    raise;
  end;

end;

procedure TfrxListBox.TfrxListBoxStrings.Put(Index: Integer; const S: string);
begin
  FListBox.ListItems[Index].Text := S;

end;

procedure TfrxListBox.TfrxListBoxStrings.PutObject(Index: Integer;
  AObject: TObject);
begin
  FListBox.ListItems[Index].Data := AObject;

end;

procedure TfrxListBox.TfrxListBoxStrings.ReadData(Reader: TReader);
begin
  Reader.ReadListBegin;
  BeginUpdate;
  try
    if TfrxListBox(FListBox).ItemsStored then
    begin
      Clear;
      while not Reader.EndOfList do
        Add(Reader.ReadString);
    end
    else
    begin
      while not Reader.EndOfList do
        Reader.ReadString;
    end;
  finally
    EndUpdate;
  end;
  Reader.ReadListEnd;
end;

procedure TfrxListBox.TfrxListBoxStrings.SetUpdateState(Updating: Boolean);
begin
  if Updating then
    FListBox.BeginUpdate
  else
    FListBox.EndUpdate;
end;

procedure TfrxListBox.TfrxListBoxStrings.WriteData(Writer: TWriter);
var
  I: Integer;
begin
  Writer.WriteListBegin;
  for I := 0 to Count - 1 do
    Writer.WriteString(Get(I));
  Writer.WriteListEnd;
end;

{ TfrxListBoxItem }

procedure TfrxListBoxItem.ApplyStyle;
var
  B: TFmxObject;
begin
  inherited;
  B := FindStyleResource('check');
  if Assigned(B) and (B is TCheckBox) then
  begin
    FCheck := TCheckBox(B);
    FCheck.Align := TAlignLayout.alRight;
    if ListBox is TfrxListBox then
    begin
      if TfrxListBox(ListBox).ShowButtons then
      begin
        FButton.Parent := FCheck.Parent;
        FButton.Visible := True;
        FButton.Align := TAlignLayout.alMostRight;
        FButton.Position.X := Width;
        FButton.Width := 40;
        FButton.Height := FCheck.Height;
        FButton.Text := TfrxListBox(ListBox).ButtonText;
        FButton.OnClick := OnBtnClick;
      end;
      FCheck.Text := TfrxListBox(ListBox).CheckBoxText;
    end;

    FCheck.Width := 90;
    FCheck.Visible := FCheckVisible;
  end;
end;

constructor TfrxListBoxItem.Create(AOwner: TComponent);
begin
  inherited;
  FButton := TButton.Create(Self);
  FCheck := nil;
  FCheckVisible := False;
end;

destructor TfrxListBoxItem.Destroy;
begin
  inherited;
end;

procedure TfrxListBoxItem.FreeStyle;
begin
  inherited;
  FCheck := nil;
end;

function TfrxListBoxItem.GetCheckVisible: Boolean;
begin
  Result := FCheckVisible;
  if FCheck <> nil then
  begin
    Result := FCheck.Visible;
  end;
end;

procedure TfrxListBoxItem.OnBtnClick(Sender: TObject);
begin
  if ListBox is TfrxListBox then
  begin
    TfrxListBox(ListBox).DoButtonClick(Sender, Self);
  end;
end;

procedure TfrxListBoxItem.SetCheckVisible(const Value: Boolean);
begin
  if FCheck <> nil then
  begin
    FCheck.Visible := Value;
  end;
  FCheckVisible := Value;
end;

initialization
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TfrxToolButton, TFmxObject);
  GroupDescendentsWith(TfrxToolSeparator, TFmxObject);
  GroupDescendentsWith(TfrxToolGrip, TFmxObject);
  GroupDescendentsWith(TfrxFont, TFmxObject);
  GroupDescendentsWith(TfrxTreeView, TFmxObject);
  GroupDescendentsWith(TfrxTreeViewItem, TFmxObject);
  GroupDescendentsWith(TfrxImageList, TFmxObject);
  GroupDescendentsWith(TfrxListBoxItem, TFmxObject);
  GroupDescendentsWith(TfrxListBox, TFmxObject);
  RegisterFmxClasses([TfrxToolButton, TfrxTreeViewItem, TfrxTreeView, TfrxListBoxItem, TfrxListBox, TfrxToolSeparator, TfrxToolGrip, TfrxFont]);
end.


//56db3b0f55102b9488a240d37950543f