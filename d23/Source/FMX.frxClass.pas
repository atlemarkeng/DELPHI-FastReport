      {******************************************}
{                                          }
{           FastReport FMX v1.0            }
{             Report classes               }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxClass;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, System.WideStrings,
  System.Types, System.SyncObjs, System.IniFiles, System.Variants, FMX.Platform,
  FMX.Types, FMX.Printer, FMX.Forms, System.StrUtils, System.UIConsts,
  FMX.frxVariables, FMX.frxXML, FMX.frxProgress,
  FMX.fs_iinterpreter, FMX.frxUnicodeUtils, FMX.frxFMX
{$IFDEF DELPHI18}
  ,FMX.Controls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF}
{$IFDEF DELPHI20}
  , System.Math.Vectors
{$ENDIF}
{$IFDEF DELPHI22}
  , FMX.ActnList
{$ENDIF};


const
  fr01cm: Double = 3.77953;
  fr1cm: Double = 37.7953;
  fr01in: Double = 9.6;
  fr1in: Integer = 96;
  fr1CharX: Double = 9.6;
  fr1CharY: Integer = 17;
  frxDefPPI: Integer = 96;

type
  TfrxReport = class;
  TfrxPage = class;
  TfrxReportPage = class;
  TfrxDialogPage = class;
  TfrxCustomEngine = class;
  TfrxCustomDesigner = class;
  TfrxCustomPreview = class;
  TfrxCustomPreviewPages = class;
  TfrxComponent = class;
  TfrxReportComponent = class;
  TfrxView = class;
  TfrxStyleItem = class;
  TfrxCustomExportFilter = class;
  TfrxCustomCompressor = class;
  TfrxCustomDatabase = class;
  TfrxFrame = class;
  TfrxDataSet = class;

  TfrxNotifyEvent = type String;
  TfrxCloseQueryEvent = type String;
  TfrxKeyEvent = type String;
  TfrxKeyPressEvent = type String;
  TfrxMouseEvent = type String;
  TfrxMouseMoveEvent = type String;
  TfrxPreviewClickEvent = type String;
  TfrxRunDialogsEvent = type String;

  EDuplicateName = class(Exception);
  EExportTerminated = class(TObject);

  SYSINT = Integer;

  TfrxComponentStyle = set of (csContainer, csPreviewVisible, csDefaultDiff);
  TfrxStretchMode = (smDontStretch, smActualHeight, smMaxHeight);
  TfrxShiftMode = (smDontShift, smAlways, smWhenOverlapped);
  TfrxDuplexMode = (dmNone, dmVertical, dmHorizontal, dmSimplex);

  TfrxAlign = (baNone, baLeft, baRight, baCenter, baWidth, baBottom, baClient);

  TfrxFrameStyle = (fsSolid, fsDash, fsDot, fsDashDot, fsDashDotDot, fsDouble, fsAltDot, fsSquare);

  TfrxFrameType = (ftLeft, ftRight, ftTop, ftBottom);
  TfrxFrameTypes = set of TfrxFrameType;

  TfrxFormatKind = (fkText, fkNumeric, fkDateTime, fkBoolean);

  TfrxHAlign = (haLeft, haRight, haCenter, haBlock);
  TfrxVAlign = (vaTop, vaBottom, vaCenter);

  TfrxSilentMode = (simMessageBoxes, simSilent, simReThrow);
  TfrxRestriction = (rfDontModify, rfDontSize, rfDontMove, rfDontDelete, rfDontEdit);
  TfrxRestrictions = set of TfrxRestriction;

  TfrxShapeKind = (skRectangle, skRoundRectangle, skEllipse, skTriangle,
    skDiamond, skDiagonal1, skDiagonal2);

  TfrxPreviewButton = (pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFullScreen,
    pbOutline, pbThumbnails, pbPageSetup, pbEdit, pbNavigator, pbClose);
  TfrxPreviewButtons = set of TfrxPreviewButton;
  TfrxZoomMode = (zmDefault, zmWholePage, zmPageWidth, zmManyPages);
  TfrxPrintPages = (ppAll, ppOdd, ppEven);
  TfrxAddPageAction = (apWriteOver, apAdd);
  TfrxRangeBegin = (rbFirst, rbCurrent);
  TfrxRangeEnd = (reLast, reCurrent, reCount);
  TfrxFieldType = (fftNumeric, fftString, fftBoolean);
  TfrxProgressType = (ptRunning, ptExporting, ptPrinting);
  TfrxPrintMode = (pmDefault, pmSplit, pmJoin, pmScale);
  TfrxInheriteMode = (imDefault, imDelete, imRename);

  frxInteger = NativeInt;

  TfrxRect = packed record
    Left, Top, Right, Bottom: Double;
  end;

  TfrxPoint = packed record
    X, Y: Double;
  end;

  TfrxProgressEvent = procedure(Sender: TfrxReport;
    ProgressType: TfrxProgressType; Progress: Integer) of object;
  TfrxBeforePrintEvent = procedure(Sender: TfrxReportComponent) of object;
  TfrxGetValueEvent = procedure(const VarName: String; var Value: Variant) of object;
  TfrxNewGetValueEvent = procedure(Sender: TObject; const VarName: String; var Value: Variant) of object;
  TfrxUserFunctionEvent = function(const MethodName: String;
    var Params: Variant): Variant of object;
  TfrxManualBuildEvent = procedure(Page: TfrxPage) of object;
  TfrxClickObjectEvent = procedure(Sender: TfrxView;
    Button: TMouseButton; Shift: TShiftState; var Modified: Boolean) of object;
  TfrxMouseOverObjectEvent = procedure(Sender: TfrxView) of object;
  TfrxCheckEOFEvent = procedure(Sender: TObject; var Eof: Boolean) of object;
  TfrxRunDialogEvent = procedure(Page: TfrxDialogPage) of object;
  TfrxEditConnectionEvent = function(const ConnString: String): String of object;
  TfrxSetConnectionEvent = procedure(const ConnString: String) of object;
  TfrxBeforeConnectEvent = procedure(Sender: TfrxCustomDatabase; var Connected: Boolean) of object;
  TfrxAfterDisconnectEvent = procedure(Sender: TfrxCustomDatabase) of object;
  TfrxPrintPageEvent = procedure(Page: TfrxReportPage; CopyNo: Integer) of object;
  TfrxLoadTemplateEvent = procedure(Report: TfrxReport; const TemplateName: String) of object;

{ Root classes }

  TfrxComponent = class(TComponent)
  private
    FFont: TfrxFont;
    FObjects: TList;
    FAllObjects: TList;
    FParent: TfrxComponent;
    FLeft: Double;
    FTop: Double;
    FWidth: Double;
    FHeight: Double;
    FParentFont: Boolean;
    FGroupIndex: Integer;
    FIsDesigning: Boolean;
    FIsLoading: Boolean;
    FIsPrinting: Boolean;
    FIsWriting: Boolean;
    FRestrictions: TfrxRestrictions;
    FVisible: Boolean;
    FDescription: String;
    FAncestor: Boolean;
    FComponentStyle: TfrxComponentStyle;
    function GetAbsTop: Double;
    function GetPage: TfrxPage;
    function GetReport: TfrxReport;
    function IsFontStored: Boolean;
    function GetAllObjects: TList;
    function GetAbsLeft: Double;
    function GetIsLoading: Boolean;
    function GetIsAncestor: Boolean;
  protected
    FAliasName: String;
    FBaseName: String;
    FOriginalComponent: TfrxComponent;
    FOriginalRect: TfrxRect;
    FOriginalBand: TfrxComponent;
    procedure SetParent(AParent: TfrxComponent); virtual;
    procedure SetLeft(Value: Double); virtual;
    procedure SetTop(Value: Double); virtual;
    procedure SetWidth(Value: Double); virtual;
    procedure SetHeight(Value: Double); virtual;
    procedure SetName(const AName: TComponentName); override;
    procedure SetFont(Value: TfrxFont); virtual;
    procedure SetParentFont(const Value: Boolean); virtual;
    procedure SetVisible(Value: Boolean); virtual;
    procedure FontChanged(Sender: TObject); virtual;
    function DiffFont(f1, f2: TfrxFont; const Add: String): String;
    function InternalDiff(AComponent: TfrxComponent): String;
    function GetContainerObjects: TList; virtual;

    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetChildOwner: TComponent; override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; Flags: Word); virtual;
    destructor Destroy; override;
    class function GetDescription: String; virtual;
    procedure AlignChildren; virtual;
    procedure Assign(Source: TPersistent); override;
    procedure AssignAll(Source: TfrxComponent; Streaming: Boolean = False);
    procedure AddSourceObjects; virtual;
    procedure BeforeStartReport; virtual;
    procedure Clear; virtual;
    procedure CreateUniqueName;
    procedure LoadFromStream(Stream: TStream); virtual;
    procedure SaveToStream(Stream: TStream; SaveChildren: Boolean = True;
      SaveDefaultValues: Boolean = False; Streaming: Boolean = False); virtual;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Double);
    procedure OnNotify(Sender: TObject); virtual;
    procedure OnPaste; virtual;
    function AllDiff(AComponent: TfrxComponent): String;
    function Diff(AComponent: TfrxComponent): String; virtual;
    function FindObject(const AName: String): TfrxComponent;
    function ContainerAdd(Obj: TfrxComponent): Boolean; virtual;
    function ContainerMouseDown(Sender: TObject; X, Y: Integer): Boolean; virtual;
    procedure ContainerMouseMove(Sender: TObject; X, Y: Integer); virtual;
    procedure ContainerMouseUp(Sender: TObject; X, Y: Integer); virtual;
    function FindDataSet(DataSet: TfrxDataSet; const DSName: String): TfrxDataSet;

    property Objects: TList read FObjects;
    property AllObjects: TList read GetAllObjects;
    property ContainerObjects: TList read GetContainerObjects;
    property Parent: TfrxComponent read FParent write SetParent;
    property Page: TfrxPage read GetPage;
    property Report: TfrxReport read GetReport;
    property IsAncestor: Boolean read GetIsAncestor;
    property IsDesigning: Boolean read FIsDesigning write FIsDesigning;
    property IsLoading: Boolean read GetIsLoading write FIsLoading;
    property IsPrinting: Boolean read FIsPrinting write FIsPrinting;
    property IsWriting: Boolean read FIsWriting write FIsWriting;
    property BaseName: String read FBaseName;
    property GroupIndex: Integer read FGroupIndex write FGroupIndex default 0;
    property frComponentStyle: TfrxComponentStyle read FComponentStyle write FComponentStyle;

    property Left: Double read FLeft write SetLeft;
    property Top: Double read FTop write SetTop;
    property Width: Double read FWidth write SetWidth;
    property Height: Double read FHeight write SetHeight;
    property AbsLeft: Double read GetAbsLeft;
    property AbsTop: Double read GetAbsTop;

    property Description: String read FDescription write FDescription;
    property ParentFont: Boolean read FParentFont write SetParentFont default True;
    property Restrictions: TfrxRestrictions read FRestrictions write FRestrictions default [];
    property Visible: Boolean read FVisible write SetVisible default True;
    property Font: TfrxFont read FFont write SetFont stored IsFontStored;
  end;

  TfrxReportComponent = class(TfrxComponent)
  private
    FOnAfterData: TfrxNotifyEvent;
    FOnAfterPrint: TfrxNotifyEvent;
    FOnBeforePrint: TfrxNotifyEvent;
    FOnPreviewClick: TfrxPreviewClickEvent;
    FOnPreviewDblClick: TfrxPreviewClickEvent;
  public
    FShiftAmount: Double;
    FShiftChildren: TList;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
      virtual; abstract;
    procedure BeforePrint; virtual;
    procedure GetData; virtual;
    procedure AfterPrint; virtual;
    function GetComponentText: String; virtual;
    function GetRealBounds: TfrxRect; virtual;
    property OnAfterData: TfrxNotifyEvent read FOnAfterData write FOnAfterData;
    property OnAfterPrint: TfrxNotifyEvent read FOnAfterPrint write FOnAfterPrint;
    property OnBeforePrint: TfrxNotifyEvent read FOnBeforePrint write FOnBeforePrint;
    property OnPreviewClick: TfrxPreviewClickEvent read FOnPreviewClick write FOnPreviewClick;
    property OnPreviewDblClick: TfrxPreviewClickEvent read FOnPreviewDblClick write FOnPreviewDblClick;
  published
    property Description;
  end;

  TfrxDialogComponent = class(TfrxReportComponent)
  private
    FComponent: TComponent;
    FImage : TBitmap;
    FImageIsLoaded: Boolean;
    procedure ReadLeft(Reader: TReader);
    procedure ReadTop(Reader: TReader);
    procedure WriteLeft(Writer: TWriter);
    procedure WriteTop(Writer: TWriter);
  protected
    FImageIndex: Integer;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    property Component: TComponent read FComponent write FComponent;
  end;

  TfrxDialogControl = class(TfrxReportComponent)
  private
    FControl: TControl;
    FOnClick: TfrxNotifyEvent;
    FOnDblClick: TfrxNotifyEvent;
    FOnEnter: TfrxNotifyEvent;
    FOnExit: TfrxNotifyEvent;
    FOnKeyDown: TfrxKeyEvent;
    FOnKeyPress: TfrxKeyPressEvent;
    FOnKeyUp: TfrxKeyEvent;
    FOnMouseDown: TfrxMouseEvent;
    FOnMouseMove: TfrxMouseMoveEvent;
    FOnMouseUp: TfrxMouseEvent;
    FOnActivate: TNotifyEvent;
    function GetEnabled: Boolean;
    procedure DoOnClick(Sender: TObject);
    procedure DoOnDblClick(Sender: TObject);
    procedure DoOnEnter(Sender: TObject);
    procedure DoOnExit(Sender: TObject);
    procedure DoOnKeyDown(Sender: TObject; var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
    procedure DoOnKeyUp(Sender: TObject; var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
    procedure DoOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure DoOnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure DoOnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure SetEnabled(const Value: Boolean);
    function GetCaption: String;
    procedure SetCaption(const Value: String);
    function GetHint: String;
    procedure SetHint(const Value: String);
    function GetShowHint: Boolean;
    procedure SetShowHint(const Value: Boolean);
    function GetTabStop: Boolean;
    procedure SetTabStop(const Value: Boolean);
  protected
    procedure SetLeft(Value: Double); override;
    procedure SetTop(Value: Double); override;
    procedure SetWidth(Value: Double); override;
    procedure SetHeight(Value: Double); override;
    procedure SetParentFont(const Value: Boolean); override;
    procedure SetVisible(Value: Boolean); override;
    procedure SetParent(AParent: TfrxComponent); override;
    procedure FontChanged(Sender: TObject); override;
    procedure InitControl(AControl: TControl);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;

    property Caption: String read GetCaption write SetCaption;
    property Control: TControl read FControl write FControl;
    property TabStop: Boolean read GetTabStop write SetTabStop default True;
    property OnClick: TfrxNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TfrxNotifyEvent read FOnDblClick write FOnDblClick;
    property OnEnter: TfrxNotifyEvent read FOnEnter write FOnEnter;
    property OnExit: TfrxNotifyEvent read FOnExit write FOnExit;
    property OnKeyDown: TfrxKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TfrxKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TfrxKeyEvent read FOnKeyUp write FOnKeyUp;
    property OnMouseDown: TfrxMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TfrxMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TfrxMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
  published
    property Left;
    property Top;
    property Width;
    property Height;
    property Font;
    property GroupIndex;
    property ParentFont;
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    property Hint: String read GetHint write SetHint;
    property ShowHint: Boolean read GetShowHint write SetShowHint;
    property Visible;
  end;

  TfrxDataSet = class(TfrxDialogComponent)
  private
    FCloseDataSource: Boolean;
    FEnabled: Boolean;
    FEof: Boolean;
    FOpenDataSource: Boolean;
    FRangeBegin: TfrxRangeBegin;
    FRangeEnd: TfrxRangeEnd;
    FRangeEndCount: Integer;
    FReportRef: TfrxReport;
    FUserName: String;
    FOnCheckEOF: TfrxCheckEOFEvent;
    FOnFirst: TNotifyEvent;
    FOnNext: TNotifyEvent;
    FOnPrior: TNotifyEvent;
    FOnOpen: TNotifyEvent;
    FOnClose: TNotifyEvent;
  protected
    FInitialized: Boolean;
    FRecNo: Integer;
    function GetDisplayText(Index: String): WideString; virtual;
    function GetDisplayWidth(Index: String): Integer; virtual;
    function GetFieldType(Index: String): TfrxFieldType; virtual;
    function GetValue(Index: String): Variant; virtual;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetUserName(const Value: String); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    { Navigation methods }
    procedure Initialize; virtual;
    procedure Finalize; virtual;
    procedure Open; virtual;
    procedure Close; virtual;
    procedure First; virtual;
    procedure Next; virtual;
    procedure Prior; virtual;
    function Eof: Boolean; virtual;

    { Data access }
    function FieldsCount: Integer; virtual;
    function HasField(const fName: String): Boolean;
    function IsBlobField(const fName: String): Boolean; virtual;
    function RecordCount: Integer; virtual;
    procedure AssignBlobTo(const fName: String; Obj: TObject); virtual;
    procedure GetFieldList(List: TStrings); virtual;
    property DisplayText[Index: String]: WideString read GetDisplayText;
    property DisplayWidth[Index: String]: Integer read GetDisplayWidth;
    property FieldType[Index: String]: TfrxFieldType read GetFieldType;
    property Value[Index: String]: Variant read GetValue;

    property CloseDataSource: Boolean read FCloseDataSource write FCloseDataSource;
    { OpenDataSource is kept for backward compatibility only }
    property OpenDataSource: Boolean read FOpenDataSource write FOpenDataSource default True;
    property RecNo: Integer read FRecNo;
    property ReportRef: TfrxReport read FReportRef write FReportRef;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
  published
    property Enabled: Boolean read FEnabled write FEnabled default True;
    property RangeBegin: TfrxRangeBegin read FRangeBegin write FRangeBegin default rbFirst;
    property RangeEnd: TfrxRangeEnd read FRangeEnd write FRangeEnd default reLast;
    property RangeEndCount: Integer read FRangeEndCount write FRangeEndCount default 0;
    property UserName: String read FUserName write SetUserName;
    property OnCheckEOF: TfrxCheckEOFEvent read FOnCheckEOF write FOnCheckEOF;
    property OnFirst: TNotifyEvent read FOnFirst write FOnFirst;
    property OnNext: TNotifyEvent read FOnNext write FOnNext;
    property OnPrior: TNotifyEvent read FOnPrior write FOnPrior;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxUserDataSet = class(TfrxDataset)
  private
    FFields: TStrings;
    FOnGetValue: TfrxGetValueEvent;
    FOnNewGetValue: TfrxNewGetValueEvent;
    procedure SetFields(const Value: TStrings);
  protected
    function GetDisplayText(Index: String): WideString; override;
    function GetValue(Index: String): Variant; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FieldsCount: Integer; override;
    procedure GetFieldList(List: TStrings); override;
  published
    property Fields: TStrings read FFields write SetFields;
    property OnGetValue: TfrxGetValueEvent read FOnGetValue write FOnGetValue;
    property OnNewGetValue: TfrxNewGetValueEvent read FOnNewGetValue write FOnNewGetValue;
  end;

  TfrxCustomDBDataSet = class(TfrxDataSet)
  private
    FAliases: TStrings;
    FFields: TStringList;
    procedure SetFieldAliases(const Value: TStrings);
  protected
    property Fields: TStringList read FFields;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ConvertAlias(const fName: String): String;
    function GetAlias(const fName: String): String;
    function FieldsCount: Integer; override;
  published
    property CloseDataSource;
    property FieldAliases: TStrings read FAliases write SetFieldAliases;
    property OpenDataSource;
    property OnClose;
    property OnOpen;
  end;

  TfrxDBComponents = class(TComponent)
  public
    function GetDescription: String; virtual;
  end;

  TfrxCustomDatabase = class(TfrxDialogComponent)
  protected
    procedure BeforeConnect(var Value: Boolean);
    procedure AfterDisconnect;
    procedure SetConnected(Value: Boolean); virtual;
    procedure SetDatabaseName(const Value: String); virtual;
    procedure SetLoginPrompt(Value: Boolean); virtual;
    procedure SetParams(Value: TStrings); virtual;
    function GetConnected: Boolean; virtual;
    function GetDatabaseName: String; virtual;
    function GetLoginPrompt: Boolean; virtual;
    function GetParams: TStrings; virtual;
  public
    function ToString: WideString; reintroduce; virtual;
    procedure FromString(const Connection: WideString); virtual;
    procedure SetLogin(const Login, Password: String); virtual;
    property Connected: Boolean read GetConnected write SetConnected default False;
    property DatabaseName: String read GetDatabaseName write SetDatabaseName;
    property LoginPrompt: Boolean read GetLoginPrompt write SetLoginPrompt default True;
    property Params: TStrings read GetParams write SetParams;
  end;


  TfrxComponentClass = class of TfrxComponent;

{ Report Objects }

  TfrxFrameLine = class(TPersistent)
  private
    FFrame: TfrxFrame;
    FColor: TAlphaColor;
    FStyle: TfrxFrameStyle;
    FWidth: Double;
    function IsColorStored: Boolean;
    function IsStyleStored: Boolean;
    function IsWidthStored: Boolean;
  public
    constructor Create(AFrame: TfrxFrame);
    procedure Assign(Source: TPersistent); override;
    function Diff(ALine: TfrxFrameLine; const LineName: String;
      ColorChanged, StyleChanged, WidthChanged: Boolean): String;
  published
    property Color: TAlphaColor read FColor write FColor stored IsColorStored;
    property Style: TfrxFrameStyle read FStyle write FStyle stored IsStyleStored;
    property Width: Double read FWidth write FWidth stored IsWidthStored;
  end;

  TfrxFrame = class(TPersistent)
  private
    FLeftLine: TfrxFrameLine;
    FTopLine: TfrxFrameLine;
    FRightLine: TfrxFrameLine;
    FBottomLine: TfrxFrameLine;
    FColor: TAlphaColor;
    FDropShadow: Boolean;
    FShadowWidth: Double;
    FShadowColor: TAlphaColor;
    FStyle: TfrxFrameStyle;
    FTyp: TfrxFrameTypes;
    FWidth: Double;
    function IsShadowWidthStored: Boolean;
    function IsTypStored: Boolean;
    function IsWidthStored: Boolean;
    procedure SetBottomLine(const Value: TfrxFrameLine);
    procedure SetLeftLine(const Value: TfrxFrameLine);
    procedure SetRightLine(const Value: TfrxFrameLine);
    procedure SetTopLine(const Value: TfrxFrameLine);
    procedure SetColor(const Value: TAlphaColor);
    procedure SetStyle(const Value: TfrxFrameStyle);
    procedure SetWidth(const Value: Double);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Diff(AFrame: TfrxFrame): String;
  published
    property Color: TAlphaColor read FColor write SetColor default claBlack;
    property DropShadow: Boolean read FDropShadow write FDropShadow default False;
    property ShadowColor: TAlphaColor read FShadowColor write FShadowColor default claBlack;
    property ShadowWidth: Double read FShadowWidth write FShadowWidth stored IsShadowWidthStored;
    property Style: TfrxFrameStyle read FStyle write SetStyle default fsSolid;
    property Typ: TfrxFrameTypes read FTyp write FTyp stored IsTypStored;
    property Width: Double read FWidth write SetWidth stored IsWidthStored;
    property LeftLine: TfrxFrameLine read FLeftLine write SetLeftLine;
    property TopLine: TfrxFrameLine read FTopLine write SetTopLine;
    property RightLine: TfrxFrameLine read FRightLine write SetRightLine;
    property BottomLine: TfrxFrameLine read FBottomLine write SetBottomLine;
  end;

  TfrxView = class(TfrxReportComponent)
  private
    FAlign: TfrxAlign;
    FColor: TAlphaColor;
    FCursor: TCursor;
    FDataField: String;
    FDataSet: TfrxDataSet;
    FDataSetName: String;
    FFrame: TfrxFrame;
    FPrintable: Boolean;
    FShiftMode: TfrxShiftMode;
    FTagStr: String;
    FTempTag: String;
    FTempURL: String;
    FHint: String;
    FHintIsActive: Boolean;
    FShowHint: Boolean;
    FURL: String;
    FPlainText: Boolean;
    FBrushStyle: TBrushKind;
    procedure SetFrame(const Value: TfrxFrame);
    procedure SetDataSet(const Value: TfrxDataSet);
    procedure SetDataSetName(const Value: String);
    function GetDataSetName: String;
  protected
    FX: Integer;
    FY: Integer;
    FX1: Integer;
    FY1: Integer;
    FDX: Integer;
    FDY: Integer;
    FFrameWidth: Double;
    FScaleX: Double;
    FScaleY: Double;
    FOffsetX: Double;
    FOffsetY: Double;
    FCanvas: TCanvas;
    procedure BeginDraw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); virtual;
    procedure DrawBackground; virtual;
    procedure DrawFrame; virtual;
    procedure ExpandVariables(var Expr: String);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Diff(AComponent: TfrxComponent): String; override;
    function IsDataField: Boolean;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure BeforePrint; override;
    procedure GetData; override;
    procedure AfterPrint; override;
    property Color: TAlphaColor read FColor write FColor default claNull;
    property DataField: String read FDataField write FDataField;
    property DataSet: TfrxDataSet read FDataSet write SetDataSet;
    property DataSetName: String read GetDataSetName write SetDataSetName;
    property Frame: TfrxFrame read FFrame write SetFrame;
    property PlainText: Boolean read FPlainText write FPlainText;
    property Cursor: TCursor read FCursor write FCursor default crDefault;
    property TagStr: String read FTagStr write FTagStr;
    property URL: String read FURL write FURL;
    property HintIsActive: Boolean read FHintIsActive write FHintIsActive;
    property BrushStyle: TBrushKind read FBrushStyle write FBrushStyle;
  published
    property Align: TfrxAlign read FAlign write FAlign default baNone;
    property Printable: Boolean read FPrintable write FPrintable default True;
    property ShiftMode: TfrxShiftMode read FShiftMode write FShiftMode default smAlways;
    property Left;
    property Top;
    property Width;
    property Height;
    property GroupIndex;
    property Restrictions;
    property Visible;
    property OnAfterData;
    property OnAfterPrint;
    property OnBeforePrint;
    property OnPreviewClick;
    property OnPreviewDblClick;
    property Hint: String read FHint write FHint;
    property ShowHint: Boolean read FShowHint write FShowHint; 
  end;

  TfrxStretcheable = class(TfrxView)
  private
    FStretchMode: TfrxStretchMode;
  public
    FSaveHeight: Double;
    FSavedTop: Double;
    constructor Create(AOwner: TComponent); override;
    function CalcHeight: Double; virtual;
    function DrawPart: Double; virtual;
    procedure InitPart; virtual;
    function HasNextDataPart: Boolean; virtual;
  published
    property StretchMode: TfrxStretchMode read FStretchMode write FStretchMode
      default smDontStretch;
  end;

  TfrxHighlight = class(TPersistent)
  private
    FActive: Boolean;
    FColor: TAlphaColor;
    FCondition: String;
    FFont: TfrxFont;
    procedure SetFont(const Value: TfrxFont);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Active: Boolean read FActive write FActive default False;
    property Font: TfrxFont read FFont write SetFont;
    property Color: TAlphaColor read FColor write FColor default claNull;
    property Condition: String read FCondition write FCondition;
  end;

  TfrxFormat = class(TPersistent)
  private
    FDecimalSeparator: String;
    FThousandSeparator: String;
    FFormatStr: String;
    FKind: TfrxFormatKind;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property DecimalSeparator: String read FDecimalSeparator write FDecimalSeparator;
    property ThousandSeparator: String read FThousandSeparator write FThousandSeparator;
    property FormatStr: String read FFormatStr write FFormatStr;
    property Kind: TfrxFormatKind read FKind write FKind default fkText;
  end;

  TfrxCustomMemoView = class(TfrxStretcheable)
  private
    FAllowExpressions: Boolean;
    FAllowHTMLTags: Boolean;
    FAutoWidth: Boolean;
    FCharSpacing: Double;
    FClipped: Boolean;
    FDisplayFormat: TfrxFormat;
    FExpressionDelimiters: String;
    FFlowTo: TfrxCustomMemoView;
    FFirstParaBreak: Boolean;
    FGapX: Double;
    FGapY: Double;
    FHAlign: TfrxHAlign;
    FHideZeros: Boolean;
    FHighlight: TfrxHighlight;
    FLastParaBreak: Boolean;
    FLineSpacing: Double;
    FMemo: TWideStrings;
    FParagraphGap: Double;
    FPartMemo: WideString;
    FRotation: Integer;
    FRTLReading: Boolean;
    FStyle: String;
    FSuppressRepeated: Boolean;
    FTempMemo: WideString;
    FUnderlines: Boolean;
    FVAlign: TfrxVAlign;
    FValue: Variant;
    FWordBreak: Boolean;
    FWordWrap: Boolean;
    FWysiwyg: Boolean;
    FBmpCanvas: TBitmap;
    FTextRenderer: TObject;
    procedure SetMemo(const Value: TWideStrings);
    procedure SetRotation(Value: Integer);
    procedure SetText(const Value: WideString);
    function AdjustCalcHeight: Double;
    function AdjustCalcWidth: Double;
    function GetText: WideString;
    function IsExprDelimitersStored: Boolean;
    function IsLineSpacingStored: Boolean;
    function IsGapXStored: Boolean;
    function IsGapYStored: Boolean;
    function IsHighlightStored: Boolean;
    function IsParagraphGapStored: Boolean;
    procedure SetHighlight(const Value: TfrxHighlight);
    procedure SetDisplayFormat(const Value: TfrxFormat);
    procedure SetStyle(const Value: String);
    function IsCharSpacingStored: Boolean;
    procedure SetAllowHTMLTags(const Value: Boolean);
  protected
    FLastValue: Variant;
    FTotalPages: Integer;
    FCopyNo: Integer;
    FTextRect: TRectF;
    FPrintScale: Double;
    function CalcAndFormat(const Expr: WideString): WideString;
    procedure BeginDraw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function IsAdvancedRendererNeeded: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    function Diff(AComponent: TfrxComponent): String; override;
    function CalcHeight: Double; override;
    function CalcWidth: Double; virtual;
    function DrawPart: Double; override;
    function GetComponentText: String; override;
    function FormatData(const Value: Variant; AFormat: TfrxFormat = nil): WideString;
    function WrapText(WrapWords: Boolean): WideString;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure BeforePrint; override;
    procedure GetData; override;
    procedure AfterPrint; override;
    procedure InitPart; override;
    procedure ApplyStyle(Style: TfrxStyleItem);
    procedure ExtractMacros;
    procedure ResetSuppress;
    property Text: WideString read GetText write SetText;
    property Value: Variant read FValue write FValue;
    // analogue of Memo property
    property Lines: TWideStrings read FMemo write SetMemo;

    property AllowExpressions: Boolean read FAllowExpressions write FAllowExpressions default True;
    property AllowHTMLTags: Boolean read FAllowHTMLTags write SetAllowHTMLTags default False;
    property AutoWidth: Boolean read FAutoWidth write FAutoWidth default False;
    property CharSpacing: Double read FCharSpacing write FCharSpacing stored IsCharSpacingStored;
    property Clipped: Boolean read FClipped write FClipped default True;
    property DisplayFormat: TfrxFormat read FDisplayFormat write SetDisplayFormat;
    property ExpressionDelimiters: String read FExpressionDelimiters
      write FExpressionDelimiters stored IsExprDelimitersStored;
    property FlowTo: TfrxCustomMemoView read FFlowTo write FFlowTo;
    property GapX: Double read FGapX write FGapX stored IsGapXStored;
    property GapY: Double read FGapY write FGapY stored IsGapYStored;
    property HAlign: TfrxHAlign read FHAlign write FHAlign default haLeft;
    property HideZeros: Boolean read FHideZeros write FHideZeros default False;
    property Highlight: TfrxHighlight read FHighlight write SetHighlight
      stored IsHighlightStored;
    property LineSpacing: Double read FLineSpacing write FLineSpacing stored IsLineSpacingStored;
    property Memo: TWideStrings read FMemo write SetMemo;
    property ParagraphGap: Double read FParagraphGap write FParagraphGap stored IsParagraphGapStored;
    property Rotation: Integer read FRotation write SetRotation default 0;
    property RTLReading: Boolean read FRTLReading write FRTLReading default False;
    property Style: String read FStyle write SetStyle;
    property SuppressRepeated: Boolean read FSuppressRepeated write FSuppressRepeated default False;
    property Underlines: Boolean read FUnderlines write FUnderlines default False;
    property WordBreak: Boolean read FWordBreak write FWordBreak default False;
    property WordWrap: Boolean read FWordWrap write FWordWrap default True;
    property Wysiwyg: Boolean read FWysiwyg write FWysiwyg default True;
    property VAlign: TfrxVAlign read FVAlign write FVAlign default vaTop;
  published
    property FirstParaBreak: Boolean read FFirstParaBreak write FFirstParaBreak default False;
    property LastParaBreak: Boolean read FLastParaBreak write FLastParaBreak default False;
    property Cursor;
    property TagStr;
    property URL;
  end;

  TfrxMemoView = class(TfrxCustomMemoView)
  published
    property AutoWidth;
    property AllowExpressions;
    property AllowHTMLTags;
    property CharSpacing;
    property Clipped;
    property Color;
    property DataField;
    property DataSet;
    property DataSetName;
    property DisplayFormat;
    property ExpressionDelimiters;
    property FlowTo;
    property Font;
    property Frame;
    property GapX;
    property GapY;
    property HAlign;
    property HideZeros;
    property Highlight;
    property LineSpacing;
    property Memo;
    property ParagraphGap;
    property ParentFont;
    property Rotation;
    property RTLReading;
    property Style;
    property SuppressRepeated;
    property Underlines;
    property WordBreak;
    property WordWrap;
    property Wysiwyg;
    property VAlign;
  end;

  TfrxSysMemoView = class(TfrxCustomMemoView)
  public
    class function GetDescription: String; override;
  published
    property AutoWidth;
    property CharSpacing;
    property Color;
    property DisplayFormat;
    property Font;
    property Frame;
    property GapX;
    property GapY;
    property HAlign;
    property HideZeros;
    property Highlight;
    property Memo;
    property ParentFont;
    property Rotation;
    property RTLReading;
    property Style;
    property SuppressRepeated;
    property VAlign;
    property WordWrap;
  end;

  TfrxCustomLineView = class(TfrxStretcheable)
  private
    FDiagonal: Boolean;
    FArrowEnd: Boolean;
    FArrowLength: Integer;
    FArrowSolid: Boolean;
    FArrowStart: Boolean;
    FArrowWidth: Integer;
    procedure DrawArrow(x1, y1, x2, y2: Extended);
    procedure DrawDiagonalLine;
  public
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; Flags: Word); override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    property ArrowEnd: Boolean read FArrowEnd write FArrowEnd default False;
    property ArrowLength: Integer read FArrowLength write FArrowLength default 20;
    property ArrowSolid: Boolean read FArrowSolid write FArrowSolid default False;
    property ArrowStart: Boolean read FArrowStart write FArrowStart default False;
    property ArrowWidth: Integer read FArrowWidth write FArrowWidth default 5;
    property Diagonal: Boolean read FDiagonal write FDiagonal default False;
  published
    property TagStr;
  end;

  TfrxLineView = class(TfrxCustomLineView)
  public
    class function GetDescription: String; override;
  published
    property ArrowEnd;
    property ArrowLength;
    property ArrowSolid;
    property ArrowStart;
    property ArrowWidth;
    property Frame;
    property Diagonal;
  end;

  TfrxPictureView = class(TfrxView)
  protected
    procedure ReadVCLPicture(Stream: TStream);
  private
    FAutoSize: Boolean;
    FCenter: Boolean;
    FFileLink: String;
    FImageIndex: Integer;
    FIsImageIndexStored: Boolean;
    FIsPictureStored: Boolean;
    FKeepAspectRatio: Boolean;
    FPicture: TBitmap;
    FPictureChanged: Boolean;
    FStretched: Boolean;
    FHightQuality: Boolean;
    FTransparent: Boolean;
    FTransparentColor: TAlphaColor;
    procedure SetPicture(const Value: TBitmap);
    procedure PictureChanged(Sender: TObject);
    procedure SetAutoSize(const Value: Boolean);
    procedure SetTransparent(const Value: Boolean);
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    function Diff(AComponent: TfrxComponent):String; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure GetData; override;
    property IsImageIndexStored: Boolean read FIsImageIndexStored write FIsImageIndexStored;
    property IsPictureStored: Boolean read FIsPictureStored write FIsPictureStored;
  published
    property Cursor;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    property Center: Boolean read FCenter write FCenter default False;
    property DataField;
    property DataSet;
    property DataSetName;
    property Frame;
    property FileLink: String read FFileLink write FFileLink;
    property ImageIndex: Integer read FImageIndex write FImageIndex stored FIsImageIndexStored;
    property KeepAspectRatio: Boolean read FKeepAspectRatio write FKeepAspectRatio default True;
    property Picture: TBitmap read FPicture write SetPicture stored FIsPictureStored;
    property Stretched: Boolean read FStretched write FStretched default True;
    property TagStr;
    property URL;
    property HightQuality: Boolean read FHightQuality write FHightQuality;
    property Transparent: Boolean read FTransparent write SetTransparent;
    property TransparentColor: TAlphaColor read FTransparentColor write FTransparentColor;
  end;

  TfrxShapeView = class(TfrxView)
  private
    FCurve: Integer;
    FShape: TfrxShapeKind;
  public
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; Flags: Word); override;
    function Diff(AComponent: TfrxComponent): String; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    class function GetDescription: String; override;
  published
    property Color;
    property Cursor;
    property Curve: Integer read FCurve write FCurve default 0;
    property Frame;
    property Shape: TfrxShapeKind read FShape write FShape default skRectangle;
    property TagStr;
    property URL;
  end;

  TfrxSubreport = class(TfrxView)
  private
    FPage: TfrxReportPage;
    FPrintOnParent: Boolean;
    procedure SetPage(const Value: TfrxReportPage);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    class function GetDescription: String; override;
  published
    property Page: TfrxReportPage read FPage write SetPage;
    property PrintOnParent: Boolean read FPrintOnParent write FPrintOnParent
      default False;
  end;


{ Bands }
  TfrxChild = class;

  TfrxBand = class(TfrxReportComponent)
  private
    FAllowSplit: Boolean;
    FChild: TfrxChild;
    FKeepChild: Boolean;
    FOnAfterCalcHeight: TfrxNotifyEvent;
    FOutlineText: String;
    FOverflow: Boolean;
    FStartNewPage: Boolean;
    FStretched: Boolean;
    FPrintChildIfInvisible: Boolean;
    FVertical: Boolean;
    function GetBandName: String;
    procedure SetChild(Value: TfrxChild);
    procedure SetVertical(const Value: Boolean);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetLeft(Value: Double); override;
    procedure SetTop(Value: Double); override;
    procedure SetHeight(Value: Double); override;
  public
    FSubBands: TList;                    { list of subbands }
    FHeader, FFooter, FGroup: TfrxBand;  { h./f./g. bands   }
    FLineN: Integer;                     { used for Line#   }
    FLineThrough: Integer;               { used for LineThrough#   }
    FOriginalObjectsCount: Integer;      { used for TfrxSubReport.PrintOnParent }
    FHasVBands: Boolean;                 { whether the band should show vbands }
    FStretchedHeight: Double;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function BandNumber: Integer;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    class function GetDescription: String; override;
    property AllowSplit: Boolean read FAllowSplit write FAllowSplit default False;
    property BandName: String read GetBandName;
    property Child: TfrxChild read FChild write SetChild;
    property KeepChild: Boolean read FKeepChild write FKeepChild default False;
    property OutlineText: String read FOutlineText write FOutlineText;
    property Overflow: Boolean read FOverflow write FOverflow;
    property PrintChildIfInvisible: Boolean read FPrintChildIfInvisible
      write FPrintChildIfInvisible default False;
    property StartNewPage: Boolean read FStartNewPage write FStartNewPage default False;
    property Stretched: Boolean read FStretched write FStretched default False;
  published
    property Font;
    property Height;
    property Left;
    property ParentFont;
    property Restrictions;
    property Top;
    property Vertical: Boolean read FVertical write SetVertical default False;
    property Visible;
    property Width;
    property OnAfterCalcHeight: TfrxNotifyEvent read FOnAfterCalcHeight
      write FOnAfterCalcHeight;
    property OnAfterPrint;
    property OnBeforePrint;
  end;

  TfrxBandClass = class of TfrxBand;

  TfrxDataBand = class(TfrxBand)
  private
    FColumnGap: Double;
    FColumnWidth: Double;
    FColumns: Integer;
    FCurColumn: Integer;
    FDataSet: TfrxDataSet;
    FDataSetName: String;
    FFooterAfterEach: Boolean;
    FKeepFooter: Boolean;
    FKeepHeader: Boolean;
    FKeepTogether: Boolean;
    FPrintIfDetailEmpty: Boolean;
    FRowCount: Integer;
    FOnMasterDetail: TfrxNotifyEvent;
    FVirtualDataSet: TfrxUserDataSet;
    procedure SetCurColumn(Value: Integer);
    procedure SetRowCount(const Value: Integer);
    procedure SetDataSet(const Value: TfrxDataSet);
    procedure SetDataSetName(const Value: String);
    function GetDataSetName: String;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    FMaxY: Double;                             { used for columns }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    property CurColumn: Integer read FCurColumn write SetCurColumn;
    property VirtualDataSet: TfrxUserDataSet read FVirtualDataSet;
  published
    property AllowSplit;
    property Child;
    property Columns: Integer read FColumns write FColumns default 0;
    property ColumnWidth: Double read FColumnWidth write FColumnWidth;
    property ColumnGap: Double read FColumnGap write FColumnGap;
    property DataSet: TfrxDataSet read FDataSet write SetDataSet;
    property DataSetName: String read GetDataSetName write SetDataSetName;
    property FooterAfterEach: Boolean read FFooterAfterEach write FFooterAfterEach default False;
    property KeepChild;
    property KeepFooter: Boolean read FKeepFooter write FKeepFooter default False;
    property KeepHeader: Boolean read FKeepHeader write FKeepHeader default False;
    property KeepTogether: Boolean read FKeepTogether write FKeepTogether default False;
    property OutlineText;
    property PrintChildIfInvisible;
    property PrintIfDetailEmpty: Boolean read FPrintIfDetailEmpty
      write FPrintIfDetailEmpty default False;
    property RowCount: Integer read FRowCount write SetRowCount;
    property StartNewPage;
    property Stretched;
    property OnMasterDetail: TfrxNotifyEvent read FOnMasterDetail write FOnMasterDetail;
  end;

  TfrxHeader = class(TfrxBand)
  private
    FReprintOnNewPage: Boolean;
  published
    property AllowSplit;
    property Child;
    property KeepChild;
    property PrintChildIfInvisible;
    property ReprintOnNewPage: Boolean read FReprintOnNewPage write FReprintOnNewPage default False;
    property StartNewPage;
    property Stretched;
  end;

  TfrxFooter = class(TfrxBand)
  private
  public
  published
    property AllowSplit;
    property Child;
    property KeepChild;
    property PrintChildIfInvisible;
    property Stretched;
  end;

  TfrxMasterData = class(TfrxDataBand)
  private
  public
  published
  end;

  TfrxDetailData = class(TfrxDataBand)
  private
  public
  published
  end;

  TfrxSubdetailData = class(TfrxDataBand)
  private
  public
  published
  end;

  TfrxDataBand4 = class(TfrxDataBand)
  private
  public
  published
  end;

  TfrxDataBand5 = class(TfrxDataBand)
  private
  public
  published
  end;

  TfrxDataBand6 = class(TfrxDataBand)
  private
  public
  published
  end;

  TfrxPageHeader = class(TfrxBand)
  private
    FPrintOnFirstPage: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Child;
    property PrintChildIfInvisible;
    property PrintOnFirstPage: Boolean read FPrintOnFirstPage write FPrintOnFirstPage default True;
    property Stretched;
  end;

  TfrxPageFooter = class(TfrxBand)
  private
    FPrintOnFirstPage: Boolean;
    FPrintOnLastPage: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property PrintOnFirstPage: Boolean read FPrintOnFirstPage write FPrintOnFirstPage default True;
    property PrintOnLastPage: Boolean read FPrintOnLastPage write FPrintOnLastPage default True;
  end;

  TfrxColumnHeader = class(TfrxBand)
  private
  public
  published
    property Child;
    property Stretched;
  end;

  TfrxColumnFooter = class(TfrxBand)
  private
  public
  published
  end;

  TfrxGroupHeader = class(TfrxBand)
  private
    FCondition: String;
    FDrillName: String;               { used instead Tag property in drill down }
    FDrillDown: Boolean;
    FExpandDrillDown: Boolean;
    FShowFooterIfDrillDown: Boolean;
    FShowChildIfDrillDown: Boolean;
    FKeepTogether: Boolean;
    FReprintOnNewPage: Boolean;
    FResetPageNumbers: Boolean;
  public
    FLastValue: Variant;
    function Diff(AComponent: TfrxComponent): String; override;
  published
    property AllowSplit;
    property Child;
    property Condition: String read FCondition write FCondition;
    property DrillDown: Boolean read FDrillDown write FDrillDown default False;
    property ExpandDrillDown: Boolean read FExpandDrillDown write FExpandDrillDown default False;
    property KeepChild;
    property KeepTogether: Boolean read FKeepTogether write FKeepTogether default False;
    property ReprintOnNewPage: Boolean read FReprintOnNewPage write FReprintOnNewPage default False;
    property OutlineText;
    property PrintChildIfInvisible;
    property ResetPageNumbers: Boolean read FResetPageNumbers write FResetPageNumbers default False;
    property ShowFooterIfDrillDown: Boolean read FShowFooterIfDrillDown
      write FShowFooterIfDrillDown default False;
    property ShowChildIfDrillDown: Boolean read FShowChildIfDrillDown
      write FShowChildIfDrillDown default False;
    property StartNewPage;
    property Stretched;
    property DrillName: String read FDrillName write FDrillName;
  end;

  TfrxGroupFooter = class(TfrxBand)
  private
    FHideIfSingleDataRecord: Boolean;
  public
  published
    property AllowSplit;
    property Child;
    property HideIfSingleDataRecord: Boolean read FHideIfSingleDataRecord
      write FHideIfSingleDataRecord default False;
    property KeepChild;
    property PrintChildIfInvisible;
    property Stretched;
  end;

  TfrxReportTitle = class(TfrxBand)
  private
  public
  published
    property AllowSplit;
    property Child;
    property KeepChild;
    property PrintChildIfInvisible;
    property StartNewPage;
    property Stretched;
  end;

  TfrxReportSummary = class(TfrxBand)
  private
  public
  published
    property AllowSplit;
    property Child;
    property KeepChild;
    property PrintChildIfInvisible;
    property StartNewPage;
    property Stretched;
  end;

  TfrxChild = class(TfrxBand)
  private
  public
  published
    property AllowSplit;
    property Child;
    property KeepChild;
    property PrintChildIfInvisible;
    property StartNewPage;
    property Stretched;
  end;

  TfrxOverlay = class(TfrxBand)
  private
    FPrintOnTop: Boolean;
  public
  published
    property PrintOnTop: Boolean read FPrintOnTop write FPrintOnTop default False;
  end;

  TfrxNullBand = class(TfrxBand);


{ Pages }

  TfrxPage = class(TfrxComponent)
  private
  protected
  public
  published
    property Font;
    property Visible;
  end;

  TfrxReportPage = class(TfrxPage)
  private
    FBackPicture: TfrxPictureView;
    FBin: Integer;
    FBinOtherPages: Integer;
    FBottomMargin: Double;
    FColumns: Integer;
    FColumnWidth: Double;
    FColumnPositions: TStrings;
    FDataSet: TfrxDataSet;
    FDuplex: TfrxDuplexMode;
    FEndlessHeight: Boolean;
    FEndlessWidth: Boolean;
    FHGuides: TStrings;
    FLargeDesignHeight: Boolean;
    FLeftMargin: Double;
    FMirrorMargins: Boolean;
    FOrientation: TPrinterOrientation;
    FOutlineText: String;
    FPrintIfEmpty: Boolean;
    FPrintOnPreviousPage: Boolean;
    FResetPageNumbers: Boolean;
    FRightMargin: Double;
    FSubReport: TfrxSubreport;
    FTitleBeforeHeader: Boolean;
    FTopMargin: Double;
    FVGuides: TStrings;
    FOnAfterPrint: TfrxNotifyEvent;
    FOnBeforePrint: TfrxNotifyEvent;
    FOnManualBuild: TfrxNotifyEvent;
    FDataSetName: String;
    FBackPictureVisible: Boolean;
    FBackPicturePrintable: Boolean;
    FPageCount: Integer;
    procedure SetPageCount(const Value: Integer);
    procedure SetColumns(const Value: Integer);
    procedure SetOrientation(Value: TPrinterOrientation);
    procedure SetHGuides(const Value: TStrings);
    procedure SetVGuides(const Value: TStrings);
    procedure SetColumnPositions(const Value: TStrings);
    procedure SetFrame(const Value: TfrxFrame);
    function GetFrame: TfrxFrame;
    function GetColor: TAlphaColor;
    procedure SetColor(const Value: TAlphaColor);
    function GetBackPicture: TBitmap;
    procedure SetBackPicture(const Value: TBitmap);
    procedure SetDataSet(const Value: TfrxDataSet);
    procedure SetDataSetName(const Value: String);
    function GetDataSetName: String;
  protected
    FPaperHeight: Double;
    FPaperSize: Integer;
    FPaperWidth: Double;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetPaperHeight(const Value: Double); virtual;
    procedure SetPaperWidth(const Value: Double); virtual;
    procedure SetPaperSize(const Value: Integer); virtual;
    procedure UpdateDimensions;
  public
    FSubBands: TList;   { list of master bands }
    FVSubBands: TList;  { list of vertical master bands }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    function FindBand(Band: TfrxBandClass): TfrxBand;
    function IsSubReport: Boolean;
    procedure AlignChildren; override;
    procedure ClearGuides;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
    procedure SetDefaults; virtual;
    procedure SetSizeAndDimensions(ASize: Integer; AWidth, AHeight: Double);
    property SubReport: TfrxSubreport read FSubReport;
  published
    { paper }
    property Orientation: TPrinterOrientation read FOrientation
      write SetOrientation default poPortrait;
    property PaperWidth: Double read FPaperWidth write SetPaperWidth;
    property PaperHeight: Double read FPaperHeight write SetPaperHeight;
    property PaperSize: Integer read FPaperSize write SetPaperSize;
    { margins }
    property LeftMargin: Double read FLeftMargin write FLeftMargin;
    property RightMargin: Double read FRightMargin write FRightMargin;
    property TopMargin: Double read FTopMargin write FTopMargin;
    property BottomMargin: Double read FBottomMargin write FBottomMargin;
    property MirrorMargins: Boolean read FMirrorMargins write FMirrorMargins
      default False;
    { columns }
    property Columns: Integer read FColumns write SetColumns default 0;
    property ColumnWidth: Double read FColumnWidth write FColumnWidth;
    property ColumnPositions: TStrings read FColumnPositions write SetColumnPositions;
    { bins }
    property Bin: Integer read FBin write FBin default DMBIN_AUTO;
    property BinOtherPages: Integer read FBinOtherPages write FBinOtherPages
      default DMBIN_AUTO;
    { other }
    property BackPicture: TBitmap read GetBackPicture write SetBackPicture;
    property BackPictureVisible: Boolean read FBackPictureVisible write FBackPictureVisible default True;
    property BackPicturePrintable: Boolean read FBackPicturePrintable write FBackPicturePrintable default True;
    property PageCount: Integer read FPageCount write SetPageCount default 1;
    property Color: TAlphaColor read GetColor write SetColor default claNull;
    property DataSet: TfrxDataSet read FDataSet write SetDataSet;
    property DataSetName: String read GetDataSetName write SetDataSetName;
    property Duplex: TfrxDuplexMode read FDuplex write FDuplex default dmNone;
    property Frame: TfrxFrame read GetFrame write SetFrame;
    property EndlessHeight: Boolean read FEndlessHeight write FEndlessHeight default False;
    property EndlessWidth: Boolean read FEndlessWidth write FEndlessWidth default False;
    property LargeDesignHeight: Boolean read FLargeDesignHeight
      write FLargeDesignHeight default False;
    property OutlineText: String read FOutlineText write FOutlineText;
    property PrintIfEmpty: Boolean read FPrintIfEmpty write FPrintIfEmpty default True;
    property PrintOnPreviousPage: Boolean read FPrintOnPreviousPage
      write FPrintOnPreviousPage default False;
    property ResetPageNumbers: Boolean read FResetPageNumbers
      write FResetPageNumbers default False;
    property TitleBeforeHeader: Boolean read FTitleBeforeHeader
      write FTitleBeforeHeader default True;
    property HGuides: TStrings read FHGuides write SetHGuides;
    property VGuides: TStrings read FVGuides write SetVGuides;
    property OnAfterPrint: TfrxNotifyEvent read FOnAfterPrint write FOnAfterPrint;
    property OnBeforePrint: TfrxNotifyEvent read FOnBeforePrint write FOnBeforePrint;
    property OnManualBuild: TfrxNotifyEvent read FOnManualBuild write FOnManualBuild;
  end;

  TfrxDialogPage = class(TfrxPage)
  private
    FBorderStyle: TfmxFormBorderStyle;
    FCaption: String;
    FColor: TAlphaColor;
    FForm: TForm;
    FOnActivate: TfrxNotifyEvent;
    FOnClick: TfrxNotifyEvent;
    FOnDeactivate: TfrxNotifyEvent;
    FOnHide: TfrxNotifyEvent;
    FOnKeyDown: TfrxKeyEvent;
    FOnKeyPress: TfrxKeyPressEvent;
    FOnKeyUp: TfrxKeyEvent;
    FOnResize: TfrxNotifyEvent;
    FOnShow: TfrxNotifyEvent;
    FOnCloseQuery: TfrxCloseQueryEvent;
    FPosition: TFormPosition;
    FWindowState: TWindowState;
    FClientWidth: Double;
    FClientHeight: Double;
    procedure DoInitialize;
    procedure DoOnActivate(Sender: TObject);
    procedure DoOnCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DoOnDeactivate(Sender: TObject);
    procedure DoOnResize(Sender: TObject);
    procedure DoModify(Sender: TObject);
    procedure SetBorderStyle(const Value: TfmxFormBorderStyle);
    procedure SetCaption(const Value: String);
    procedure SetColor(const Value: TAlphaColor);
    function GetModalResult: TModalResult;
    procedure SetModalResult(const Value: TModalResult);
  protected
    procedure SetLeft(Value: Double); override;
    procedure SetTop(Value: Double); override;
    procedure SetWidth(Value: Double); override;
    procedure SetHeight(Value: Double); override;
    procedure SetClientWidth(Value: Double);
    procedure SetClientHeight(Value: Double);
    function GetClientWidth: Double;
    function GetClientHeight: Double;
    procedure FontChanged(Sender: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    procedure Initialize;
    function ShowModal: TModalResult;
    property DialogForm: TForm read FForm;
    property ModalResult: TModalResult read GetModalResult write SetModalResult;
  published
    property BorderStyle: TfmxFormBorderStyle read FBorderStyle write SetBorderStyle default TfmxFormBorderStyle.bsSizeable;
    property Caption: String read FCaption write SetCaption;
    property Color: TAlphaColor read FColor write SetColor default claWhiteSmoke;
    property Height;
    property ClientHeight: Double read GetClientHeight write SetClientHeight;
    property Left;
    property Position: TFormPosition read FPosition write FPosition default TFormPosition.poScreenCenter;
    property Top;
    property Width;
    property ClientWidth: Double read GetClientWidth write SetClientWidth;
    property WindowState: TWindowState read FWindowState write FWindowState default TWindowState.wsNormal;
    property OnActivate: TfrxNotifyEvent read FOnActivate write FOnActivate;
    property OnClick: TfrxNotifyEvent read FOnClick write FOnClick;
    property OnCloseQuery: TfrxCloseQueryEvent read FOnCloseQuery write FOnCloseQuery;
    property OnDeactivate: TfrxNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnHide: TfrxNotifyEvent read FOnHide write FOnHide;
    property OnKeyDown: TfrxKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TfrxKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TfrxKeyEvent read FOnKeyUp write FOnKeyUp;
    property OnShow: TfrxNotifyEvent read FOnShow write FOnShow;
    property OnResize: TfrxNotifyEvent read FOnResize write FOnResize;
  end;

  TfrxDataPage = class(TfrxPage)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
  published
    property Height;
    property Left;
    property Top;
    property Width;
  end;


{ Report }

  TfrxEngineOptions = class(TPersistent)
  private
    FConvertNulls: Boolean;
    FDestroyForms: Boolean;
    FDoublePass: Boolean;
    FMaxMemSize: Integer;
    FPrintIfEmpty: Boolean;
    FReportThread: TThread;
    FEnableThreadSafe: Boolean;
    FSilentMode: TfrxSilentMode;
    FTempDir: String;
    FUseFileCache: Boolean;
    FUseGlobalDataSetList: Boolean;
    FIgnoreDevByZero: Boolean;

    procedure SetSilentMode(Mode: Boolean);
    function GetSilentMode: Boolean;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property ReportThread: TThread read FReportThread write FReportThread;
    property DestroyForms: Boolean read FDestroyForms write FDestroyForms;
    property EnableThreadSafe: Boolean read FEnableThreadSafe write FEnableThreadSafe;
    property UseGlobalDataSetList: Boolean read FUseGlobalDataSetList write FUseGlobalDataSetList;
  published
    property ConvertNulls: Boolean read FConvertNulls write FConvertNulls default True;
    property DoublePass: Boolean read FDoublePass write FDoublePass default False;
    property MaxMemSize: Integer read FMaxMemSize write FMaxMemSize default 10;
    property PrintIfEmpty: Boolean read FPrintIfEmpty write FPrintIfEmpty default True;
    property SilentMode: Boolean read GetSilentMode write SetSilentMode default False;
    property NewSilentMode: TfrxSilentMode read FSilentMode write FSilentMode default simMessageBoxes;
    property TempDir: String read FTempDir write FTempDir;
    property UseFileCache: Boolean read FUseFileCache write FUseFileCache default False;
    property IgnoreDevByZero: Boolean read FIgnoreDevByZero write FIgnoreDevByZero default False;
  end;

  TfrxPrintOptions = class(TPersistent)
  private
    FCopies: Integer;
    FCollate: Boolean;
    FPageNumbers: String;
    FPagesOnSheet: Integer;
    FPrinter: String;
    FPrintMode: TfrxPrintMode;
    FPrintOnSheet: Integer;
    FPrintPages: TfrxPrintPages;
    FReverse: Boolean;
    FShowDialog: Boolean;
    FSwapPageSize: Boolean;
    FPrnOutFileName: String;
    FDuplex: TfrxDuplexMode;
    FSplicingLine: Integer;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property PrnOutFileName: String read FPrnOutFileName write FPrnOutFileName;
    property Duplex: TfrxDuplexMode read FDuplex write FDuplex;// set only after prepare report, need to store global duplex
    property SplicingLine: Integer read FSplicingLine write FSplicingLine default 3;
  published
    property Copies: Integer read FCopies write FCopies default 1;
    property Collate: Boolean read FCollate write FCollate default True;
    property PageNumbers: String read FPageNumbers write FPageNumbers;
    property Printer: String read FPrinter write FPrinter;
    property PrintMode: TfrxPrintMode read FPrintMode write FPrintMode default pmDefault;
    property PrintOnSheet: Integer read FPrintOnSheet write FPrintOnSheet;
    property PrintPages: TfrxPrintPages read FPrintPages write FPrintPages default ppAll;
    property Reverse: Boolean read FReverse write FReverse default False;
    property ShowDialog: Boolean read FShowDialog write FShowDialog default True;
    property SwapPageSize: Boolean read FSwapPageSize write FSwapPageSize stored False;// remove it
  end;

  TfrxPreviewOptions = class(TPersistent)
  private
    FAllowEdit: Boolean;
    FButtons: TfrxPreviewButtons;
    FDoubleBuffered: Boolean;
    FMaximized: Boolean;
    FMDIChild: Boolean;
    FModal: Boolean;
    FOutlineExpand: Boolean;
    FOutlineVisible: Boolean;
    FOutlineWidth: Integer;
    FPagesInCache: Integer;
    FShowCaptions: Boolean;
    FThumbnailVisible: Boolean;
    FZoom: Double;
    FZoomMode: TfrxZoomMode;
    FPictureCacheInFile: Boolean;
    FRTLPreview: Boolean;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property RTLPreview: Boolean read FRTLPreview write FRTLPreview;
  published
    property AllowEdit: Boolean read FAllowEdit write FAllowEdit default True;
    property Buttons: TfrxPreviewButtons read FButtons write FButtons;
    property DoubleBuffered: Boolean read FDoubleBuffered write FDoubleBuffered default True;
    property Maximized: Boolean read FMaximized write FMaximized default True;
    property MDIChild: Boolean read FMDIChild write FMDIChild default False;
    property Modal: Boolean read FModal write FModal default True;
    property OutlineExpand: Boolean read FOutlineExpand write FOutlineExpand default True;
    property OutlineVisible: Boolean read FOutlineVisible write FOutlineVisible default False;
    property OutlineWidth: Integer read FOutlineWidth write FOutlineWidth default 120;
    property PagesInCache: Integer read FPagesInCache write FPagesInCache default 50;
    property ThumbnailVisible: Boolean read FThumbnailVisible write FThumbnailVisible default False;
    property ShowCaptions: Boolean read FShowCaptions write FShowCaptions default False;
    property Zoom: Double read FZoom write FZoom;
    property ZoomMode: TfrxZoomMode read FZoomMode write FZoomMode default zmDefault;
    property PictureCacheInFile: Boolean read FPictureCacheInFile write FPictureCacheInFile default False;
  end;

  TfrxReportOptions = class(TPersistent)
  private
    FAuthor: String;
    FCompressed: Boolean;
    FConnectionName: String;
    FCreateDate: TDateTime;
    FDescription: TStrings;
    FInitString: String;
    FName: String;
    FLastChange: TDateTime;
    FPassword: String;
    FPicture: TBitmap;
    FReport: TfrxReport;
    FVersionBuild: String;
    FVersionMajor: String;
    FVersionMinor: String;
    FVersionRelease: String;
    FPrevPassword: String;
    FHiddenPassword: String;
    FInfo: Boolean;
    FIsFMXReport: Boolean;
    procedure SetDescription(const Value: TStrings);
    procedure SetPicture(const Value: TBitmap);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function CheckPassword: Boolean;
    property PrevPassword: String write FPrevPassword;
    property Info: Boolean read FInfo write FInfo;
    property HiddenPassword: String read FHiddenPassword write FHiddenPassword;
  published
    property Author: String read FAuthor write FAuthor;
    property Compressed: Boolean read FCompressed write FCompressed default False;
    property CreateDate: TDateTime read FCreateDate write FCreateDate;
    property Description: TStrings read FDescription write SetDescription;
    property InitString: String read FInitString write FInitString;
    property Name: String read FName write FName;
    property LastChange: TDateTime read FLastChange write FLastChange;
    property Password: String read FPassword write FPassword;
    property Picture: TBitmap read FPicture write SetPicture;
    property VersionBuild: String read FVersionBuild write FVersionBuild;
    property VersionMajor: String read FVersionMajor write FVersionMajor;
    property VersionMinor: String read FVersionMinor write FVersionMinor;
    property VersionRelease: String read FVersionRelease write FVersionRelease;
    property IsFMXReport: Boolean read FIsFMXReport write FIsFMXReport;
  end;


  TfrxExpressionCache = class(TObject)
  private
    FExpressions: TStringList;
    FMainScript: TfsScript;
    FScript: TfsScript;
    FScriptLanguage: String;
    procedure SetCaseSensitive(const Value: Boolean);
    function GetCaseSensitive: Boolean;
  public
    constructor Create(AScript: TfsScript);
    destructor Destroy; override;
    procedure Clear;
    function Calc(const Expression: String; var ErrorMsg: String;
      AScript: TfsScript): Variant;
    property CaseSensitive: Boolean read GetCaseSensitive write SetCaseSensitive;
  end;

  TfrxDataSetItem = class(TCollectionItem)
  private
    FDataSet: TfrxDataSet;
    FDataSetName: String;
    procedure SetDataSet(const Value: TfrxDataSet);
    procedure SetDataSetName(const Value: String);
    function GetDataSetName: String;
  published
    property DataSet: TfrxDataSet read FDataSet write SetDataSet;
    property DataSetName: String read GetDataSetName write SetDataSetName;
  end;

  TfrxReportDataSets = class(TCollection)
  private
    FReport: TfrxReport;
    function GetItem(Index: Integer): TfrxDataSetItem;
  public
    constructor Create(AReport: TfrxReport);
    procedure Initialize;
    procedure Finalize;
    procedure Add(ds: TfrxDataSet);
    function Find(ds: TfrxDataSet): TfrxDataSetItem; overload;
    function Find(const Name: String): TfrxDataSetItem; overload;
    procedure Delete(const Name: String); overload;
    property Items[Index: Integer]: TfrxDataSetItem read GetItem; default;
  end;

  TfrxStyleItem = class(TCollectionItem)
  private
    FName: String;
    FColor: TAlphaColor;
    FFont: TfrxFont;
    FFrame: TfrxFrame;
    procedure SetFont(const Value: TfrxFont);
    procedure SetFrame(const Value: TfrxFrame);
    procedure SetName(const Value: String);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure CreateUniqueName;
  published
    property Name: String read FName write SetName;
    property Color: TAlphaColor read FColor write FColor;
    property Font: TfrxFont read FFont write SetFont;
    property Frame: TfrxFrame read FFrame write SetFrame;
  end;

  TfrxStyles = class(TCollection)
  private
    FName: String;
    FReport: TfrxReport;
    function GetItem(Index: Integer): TfrxStyleItem;
  public
    constructor Create(AReport: TfrxReport);
    function Add: TfrxStyleItem;
    function Find(const Name: String): TfrxStyleItem;
    procedure Apply;
    procedure GetList(List: TStrings);
    procedure LoadFromFile(const FileName: String);
    procedure LoadFromStream(Stream: TStream);
    procedure LoadFromXMLItem(Item: TfrxXMLItem; OldXMLFormat: Boolean = True);
    procedure SaveToFile(const FileName: String);
    procedure SaveToStream(Stream: TStream);
    procedure SaveToXMLItem(Item: TfrxXMLItem);
    property Items[Index: Integer]: TfrxStyleItem read GetItem; default;
    property Name: String read FName write FName;
  end;

  TfrxStyleSheet = class(TObject)
  private
    FItems: TList;
    function GetItems(Index: Integer): TfrxStyles;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure GetList(List: TStrings);
    procedure LoadFromFile(const FileName: String);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToFile(const FileName: String);
    procedure SaveToStream(Stream: TStream);
    function Add: TfrxStyles;
    function Count: Integer;
    function Find(const Name: String): TfrxStyles;
    function IndexOf(const Name: String): Integer;
    property Items[Index: Integer]: TfrxStyles read GetItems; default;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxReport = class(TfrxComponent)
  private
{$IFNDEF MSWINDOWS}
{$IFDEF DELPHI17}
    FRAppService: IFMXApplicationService;
{$ENDIF}
{$ENDIF}
    FCurObject: String;
    FDataSet: TfrxDataSet;
    FDataSetName: String;
    FDataSets: TfrxReportDatasets;
    FDesigner: TfrxCustomDesigner;
    FDotMatrixReport: Boolean;
    FDrawText: Pointer;
    FDrillState: TStrings;
    FEnabledDataSets: TfrxReportDataSets;
    FEngine: TfrxCustomEngine;
    FEngineOptions: TfrxEngineOptions;
    FErrors: TStrings;
    FExpressionCache: TfrxExpressionCache;
    FFileName: String;
    FIniFile: String;
    FLoadStream: TStream;
    FLocalValue: TfsCustomVariable;
    FSelfValue: TfsCustomVariable;
    FModified: Boolean;
    FOldStyleProgress: Boolean;
    FParentForm: TForm;
    FParentReport: String;
    FParentReportObject: TfrxReport;
    FPreviewPages: TfrxCustomPreviewPages;
    FPreview: TfrxCustomPreview;
    FPreviewForm: TForm;
    FPreviewOptions: TfrxPreviewOptions;
    FPrintOptions: TfrxPrintOptions;
    FProgress: TfrxProgress;
    FReloading: Boolean;
    FReportOptions: TfrxReportOptions;
    FScript: TfsScript;
    FScriptLanguage: String;
    FScriptText: TStrings;
    FFakeScriptText: TStrings; {fake object}
    FShowProgress: Boolean;
    FStoreInDFM: Boolean;
    FStyles: TfrxStyles;
    FSysVariables: TStrings;
    FTerminated: Boolean;
    FTimer: TTimer;
    FVariables: TfrxVariables;
    FVersion: String;
    FXMLSerializer: TObject;
    FStreamLoaded: Boolean;

    FOnAfterPrint: TfrxBeforePrintEvent;
    FOnAfterPrintReport: TNotifyEvent;
    FOnBeforeConnect: TfrxBeforeConnectEvent;
    FOnAfterDisconnect: TfrxAfterDisconnectEvent;
    FOnBeforePrint: TfrxBeforePrintEvent;
    FOnBeginDoc: TNotifyEvent;
    FOnClickObject: TfrxClickObjectEvent;
    FOnDblClickObject: TfrxClickObjectEvent;
    FOnEditConnection: TfrxEditConnectionEvent;
    FOnEndDoc: TNotifyEvent;
    FOnGetValue: TfrxGetValueEvent;
    FOnNewGetValue: TfrxNewGetValueEvent;
    FOnLoadTemplate: TfrxLoadTemplateEvent;
    FOnManualBuild: TfrxManualBuildEvent;
    FOnMouseOverObject: TfrxMouseOverObjectEvent;
    FOnPreview: TNotifyEvent;
    FOnPrintPage: TfrxPrintPageEvent;
    FOnPrintReport: TNotifyEvent;
    FOnProgressStart: TfrxProgressEvent;
    FOnProgress: TfrxProgressEvent;
    FOnProgressStop: TfrxProgressEvent;
    FOnRunDialogs: TfrxRunDialogsEvent;
    FOnSetConnection: TfrxSetConnectionEvent;
    FOnStartReport: TfrxNotifyEvent;
    FOnStopReport: TfrxNotifyEvent;
    FOnUserFunction: TfrxUserFunctionEvent;
    FOnClosePreview: TNotifyEvent;
    FOnReportPrint: TfrxNotifyEvent;
    FOnAfterScriptCompile: TNotifyEvent;

    function CallMethod(Instance: TObject; ClassType: TClass;
      const MethodName: String; var Params: Variant): Variant;
    function DoGetValue(const Expr: String; var Value: Variant): Boolean;
    function GetScriptValue(Instance: TObject; ClassType: TClass;
      const MethodName: String; var Params: Variant): Variant;
    function SetScriptValue(Instance: TObject; ClassType: TClass;
      const MethodName: String; var Params: Variant): Variant;
    function DoUserFunction(Instance: TObject; ClassType: TClass;
      const MethodName: String; var Params: Variant): Variant;
    function GetDataSetName: String;
    function GetLocalValue: Variant;
    function GetSelfValue: TfrxView;
    function GetPages(Index: Integer): TfrxPage;
    function GetPagesCount: Integer;
    function GetCaseSensitive: Boolean;
    function GetScriptText: TStrings;
    procedure AncestorNotFound(Reader: TReader; const ComponentName: string;
      ComponentClass: TPersistentClass; var Component: TComponent);
    procedure DoClear;
    procedure DoGetAncestor(const Name: String; var Ancestor: TPersistent);
    procedure DoLoadFromStream;
    procedure OnTimer(Sender: TObject);
    procedure ReadDatasets(Reader: TReader);
    procedure ReadStyle(Reader: TReader);
    procedure ReadVariables(Reader: TReader);
    procedure SetDataSet(const Value: TfrxDataSet);
    procedure SetDataSetName(const Value: String);
    procedure SetEngineOptions(const Value: TfrxEngineOptions);
    procedure SetSelfValue(const Value: TfrxView);
    procedure SetLocalValue(const Value: Variant);
    procedure SetParentReport(const Value: String);
    procedure SetPreviewOptions(const Value: TfrxPreviewOptions);
    procedure SetPrintOptions(const Value: TfrxPrintOptions);
    procedure SetReportOptions(const Value: TfrxReportOptions);
    procedure SetScriptText(const Value: TStrings);
    procedure SetStyles(const Value: TfrxStyles);
    procedure SetTerminated(const Value: Boolean);
    procedure SetCaseSensitive(const Value: Boolean);
    procedure WriteDatasets(Writer: TWriter);
    procedure WriteStyle(Writer: TWriter);
    procedure WriteVariables(Writer: TWriter);
    procedure SetPreview(const Value: TfrxCustomPreview);
    procedure SetVersion(const Value: String);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; override;
    class function GetDescription: String; override;

    { internal methods }
    function Calc(const Expr: String; AScript: TfsScript = nil): Variant;
    function DesignPreviewPage: Boolean;
    function GetAlias(DataSet: TfrxDataSet): String;
    function GetDataset(const Alias: String): TfrxDataset;
    function GetIniFile: TCustomIniFile;
    function GetApplicationFolder: String;
    function PrepareScript: Boolean;
    function InheritFromTemplate(const templName: String; InheriteMode: TfrxInheriteMode = imDefault): Boolean;
    procedure DesignReport(IDesigner: IUnknown; Editor: TObject); overload;
    procedure DoNotifyEvent(Obj: TObject; const EventName: String;
      RunAlways: Boolean = False);
    procedure DoParamEvent(const EventName: String; var Params: Variant;
      RunAlways: Boolean = False);
    procedure DoAfterPrint(c: TfrxReportComponent);
    procedure DoBeforePrint(c: TfrxReportComponent);
    procedure DoPreviewClick(v: TfrxView; Button: TMouseButton;
      Shift: TShiftState; var Modified: Boolean; DblClick: Boolean = False);
    procedure GetDatasetAndField(const ComplexName: String;
      var Dataset: TfrxDataset; var Field: String);
    procedure GetDataSetList(List: TStrings; OnlyDB: Boolean = False);
    procedure GetActiveDataSetList(List: TStrings);
    procedure InternalOnProgressStart(ProgressType: TfrxProgressType); virtual;
    procedure InternalOnProgress(ProgressType: TfrxProgressType; Progress: Integer); virtual;
    procedure InternalOnProgressStop(ProgressType: TfrxProgressType); virtual;
    procedure SelectPrinter;
    procedure SetProgressMessage(const Value: String; Ishint: Boolean = False);
    procedure CheckDataPage;
    procedure AppHandleMessage;

    { public methods }
    function LoadFromFile(const FileName: String;
      ExceptionIfNotFound: Boolean = False): Boolean;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToFile(const FileName: String);
    procedure SaveToStream(Stream: TStream; SaveChildren: Boolean = True;
      SaveDefaultValues: Boolean = False; UseGetAncestor: Boolean = False); override;
    procedure DesignReport(Modal: Boolean = True; MDIChild: Boolean = False); overload; stdcall;
    function PrepareReport(ClearLastReport: Boolean = True): Boolean;
    procedure ShowPreparedReport; stdcall;
    procedure ShowReport(ClearLastReport: Boolean = True); stdcall;
    procedure AddFunction(const FuncName: String; const Category: String = '';
      const Description: String = '');
    function Print: Boolean; stdcall;
    function Export(Filter: TfrxCustomExportFilter): Boolean;

    { internals }
    property CurObject: String read FCurObject write FCurObject;
    property DrillState: TStrings read FDrillState;
    property LocalValue: Variant read GetLocalValue write SetLocalValue;
    property SelfValue: TfrxView read GetSelfValue write SetSelfValue;
    property PreviewForm: TForm read FPreviewForm;
    property XMLSerializer: TObject read FXMLSerializer;
    property Reloading: Boolean read FReloading write FReloading;

    { public }
    property DataSets: TfrxReportDataSets read FDataSets;
    property Designer: TfrxCustomDesigner read FDesigner write FDesigner;
    property EnabledDataSets: TfrxReportDataSets read FEnabledDataSets;
    property Engine: TfrxCustomEngine read FEngine;
    property Errors: TStrings read FErrors;
    property FileName: String read FFileName write FFileName;
    property Modified: Boolean read FModified write FModified;
    property PreviewPages: TfrxCustomPreviewPages read FPreviewPages;
    property Pages[Index: Integer]: TfrxPage read GetPages;
    property PagesCount: Integer read GetPagesCount;
    property Script: TfsScript read FScript;
    property Styles: TfrxStyles read FStyles write SetStyles;
    property Terminated: Boolean read FTerminated write SetTerminated;
    property Variables: TfrxVariables read FVariables;
    property CaseSensitiveExpressions: Boolean read GetCaseSensitive write SetCaseSensitive;

    property OnEditConnection: TfrxEditConnectionEvent read FOnEditConnection write FOnEditConnection;
    property OnSetConnection: TfrxSetConnectionEvent read FOnSetConnection write FOnSetConnection;
  published
    property Version: String read FVersion write SetVersion;
    property ParentReport: String read FParentReport write SetParentReport;
    property DataSet: TfrxDataSet read FDataSet write SetDataSet;
    property DataSetName: String read GetDataSetName write SetDataSetName;
    property DotMatrixReport: Boolean read FDotMatrixReport write FDotMatrixReport;
    property EngineOptions: TfrxEngineOptions read FEngineOptions write SetEngineOptions;
    property IniFile: String read FIniFile write FIniFile;
    property OldStyleProgress: Boolean read FOldStyleProgress write FOldStyleProgress default True;
    property Preview: TfrxCustomPreview read FPreview write SetPreview;
    property PreviewOptions: TfrxPreviewOptions read FPreviewOptions write SetPreviewOptions;
    property PrintOptions: TfrxPrintOptions read FPrintOptions write SetPrintOptions;
    property ReportOptions: TfrxReportOptions read FReportOptions write SetReportOptions;
    property ScriptLanguage: String read FScriptLanguage write FScriptLanguage;
    property ScriptText: TStrings read GetScriptText write SetScriptText;
    property ShowProgress: Boolean read FShowProgress write FShowProgress default True;
    property StoreInDFM: Boolean read FStoreInDFM write FStoreInDFM default True;

    property OnAfterPrint: TfrxBeforePrintEvent read FOnAfterPrint write FOnAfterPrint;
    property OnBeforeConnect: TfrxBeforeConnectEvent read FOnBeforeConnect write FOnBeforeConnect;
    property OnAfterDisconnect: TfrxAfterDisconnectEvent read FOnAfterDisconnect write FOnAfterDisconnect;
    property OnBeforePrint: TfrxBeforePrintEvent read FOnBeforePrint write FOnBeforePrint;
    property OnBeginDoc: TNotifyEvent read FOnBeginDoc write FOnBeginDoc;
    property OnClickObject: TfrxClickObjectEvent read FOnClickObject write FOnClickObject;
    property OnDblClickObject: TfrxClickObjectEvent read FOnDblClickObject write FOnDblClickObject;
    property OnEndDoc: TNotifyEvent read FOnEndDoc write FOnEndDoc;
    property OnGetValue: TfrxGetValueEvent read FOnGetValue write FOnGetValue;
    property OnNewGetValue: TfrxNewGetValueEvent read FOnNewGetValue write FOnNewGetValue;
    property OnManualBuild: TfrxManualBuildEvent read FOnManualBuild write FOnManualBuild;
    property OnMouseOverObject: TfrxMouseOverObjectEvent read FOnMouseOverObject
      write FOnMouseOverObject;
    property OnPreview: TNotifyEvent read FOnPreview write FOnPreview;
    property OnPrintPage: TfrxPrintPageEvent read FOnPrintPage write FOnPrintPage;
    property OnPrintReport: TNotifyEvent read FOnPrintReport write FOnPrintReport;
    property OnAfterPrintReport: TNotifyEvent read FOnAfterPrintReport write FOnAfterPrintReport;
    property OnProgressStart: TfrxProgressEvent read FOnProgressStart write FOnProgressStart;
    property OnProgress: TfrxProgressEvent read FOnProgress write FOnProgress;
    property OnProgressStop: TfrxProgressEvent read FOnProgressStop write FOnProgressStop;
    property OnRunDialogs: TfrxRunDialogsEvent read FOnRunDialogs write FOnRunDialogs;
    property OnStartReport: TfrxNotifyEvent read FOnStartReport write FOnStartReport;
    property OnStopReport: TfrxNotifyEvent read FOnStopReport write FOnStopReport;
    property OnUserFunction: TfrxUserFunctionEvent read FOnUserFunction write FOnUserFunction;
    property OnLoadTemplate: TfrxLoadTemplateEvent read FOnLoadTemplate write FOnLoadTemplate;
    property OnClosePreview: TNotifyEvent read FOnClosePreview write FOnClosePreview;
    property OnReportPrint: TfrxNotifyEvent read FOnReportPrint write FOnReportPrint;
    property OnAfterScriptCompile: TNotifyEvent read FOnAfterScriptCompile write FOnAfterScriptCompile;
  end;

  TfrxCustomDesigner = class(TForm)
  private
    FReport: TfrxReport;
    FIsPreviewDesigner: Boolean;
    FMemoFontName: String;
    FMemoFontSize: Integer;
    FUseObjectFont: Boolean;
    FParentForm: TForm;
  protected
    FModified: Boolean;
    FObjects: TList;
    FPage: TfrxPage;
    FSelectedObjects: TList;
    procedure SetModified(const Value: Boolean); virtual;
    procedure SetPage(const Value: TfrxPage); virtual;
    function GetCode: TStrings; virtual; abstract;
  public
    constructor CreateDesigner(AOwner: TComponent; AReport: TfrxReport;
      APreviewDesigner: Boolean = False);
    destructor Destroy; override;
    procedure FormShow(Sender: TObject); virtual; abstract;
    function InsertExpression(const Expr: String): String; virtual; abstract;
    procedure Lock; virtual; abstract;
    procedure ReloadPages(Index: Integer); virtual; abstract;
    procedure ReloadReport; virtual; abstract;
    procedure UpdateDataTree; virtual; abstract;
    procedure UpdatePage; virtual; abstract;
    procedure UpdateInspector; virtual; abstract;
    procedure Done; virtual; abstract;
    procedure Init; virtual; abstract;
    property IsPreviewDesigner: Boolean read FIsPreviewDesigner;
    property Modified: Boolean read FModified write SetModified;
    property Objects: TList read FObjects;
    property Report: TfrxReport read FReport;
    property SelectedObjects: TList read FSelectedObjects;
    property Page: TfrxPage read FPage write SetPage;
    property Code: TStrings read GetCode;
    property UseObjectFont: Boolean read FUseObjectFont write FUseObjectFont;
    property MemoFontName: String read FMemoFontName write FMemoFontName;
    property MemoFontSize: Integer read FMemoFontSize write FMemoFontSize;
    property ParentForm: TForm read FParentForm write FParentForm;
  end;

  TfrxDesignerClass = class of TfrxCustomDesigner;

  TfrxCustomExportFilter = class(TComponent)
  private
    FCurPage: Boolean;
    FExportNotPrintable: Boolean;
    FName: String;
    FNoRegister: Boolean;
    FPageNumbers: String;
    FReport: TfrxReport;
    FShowDialog: Boolean;
    FStream: TStream;
    FUseFileCache: Boolean;
    FDefaultPath: String;
    FSlaveExport: Boolean;
    FShowProgress: Boolean;
    FDefaultExt: String;
    FFilterDesc: String;
    FSuppressPageHeadersFooters: Boolean;
    FTitle: String;
    FOverwritePrompt: Boolean;
    FFIles: TStrings;
    FOnBeginExport: TNotifyEvent;
    FCreationTime: TDateTime;
    FDataOnly: Boolean;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNoRegister;
    destructor Destroy; override;
    class function GetDescription: String; virtual;
    function ShowModal: TModalResult; virtual;
    function Start: Boolean; virtual;
    procedure ExportObject(Obj: TfrxComponent); virtual; abstract;
    procedure Finish; virtual;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); virtual;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); virtual;

    property CurPage: Boolean read FCurPage write FCurPage;
    property PageNumbers: String read FPageNumbers write FPageNumbers;
    property Report: TfrxReport read FReport write FReport;
    property Stream: TStream read FStream write FStream;
    property SlaveExport: Boolean read FSlaveExport write FSlaveExport;
    property DefaultExt: String read FDefaultExt write FDefaultExt;
    property FilterDesc: String read FFilterDesc write FFilterDesc;
    property SuppressPageHeadersFooters: Boolean read FSuppressPageHeadersFooters
      write FSuppressPageHeadersFooters;
    property ExportTitle: String read FTitle write FTitle;
    property Files: TStrings read FFiles write FFiles;
  published
    property ShowDialog: Boolean read FShowDialog write FShowDialog default True;
    property FileName: String read FName write FName;
    property ExportNotPrintable: Boolean read FExportNotPrintable write FExportNotPrintable default False;
    property UseFileCache: Boolean read FUseFileCache write FUseFileCache;
    property DefaultPath: String read FDefaultPath write FDefaultPath;
    property ShowProgress: Boolean read FShowProgress write FShowProgress;
    property OverwritePrompt: Boolean read FOverwritePrompt write FOverwritePrompt;
    property CreationTime: TDateTime read FCreationTime write FCreationTime;
    property DataOnly: Boolean read FDataOnly write FDataOnly;

    property OnBeginExport: TNotifyEvent read FOnBeginExport write FOnBeginExport;
  end;

  TfrxCustomWizard = class(TComponent)
  private
    FDesigner: TfrxCustomDesigner;
    FReport: TfrxReport;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; virtual;
    function Execute: Boolean; virtual; abstract;
    property Designer: TfrxCustomDesigner read FDesigner;
    property Report: TfrxReport read FReport;
  end;

  TfrxWizardClass = class of TfrxCustomWizard;

  TfrxCustomEngine = class(TPersistent)
  private
    FCurColumn: Integer;
    FCurVColumn: Integer;
    FCurLine: Integer;
    FCurLineThrough: Integer;
    FCurX: Double;
    FCurY: Double;
    FFinalPass: Boolean;
    FNotifyList: TList;
    FPageHeight: Double;
    FPageWidth: Double;
    FPreviewPages: TfrxCustomPreviewPages;
    FReport: TfrxReport;
    FRunning: Boolean;
    FStartDate: TDateTime;
    FStartTime: TDateTime;
    FTotalPages: Integer;
    FOnRunDialog: TfrxRunDialogEvent;
    FSecondScriptCall: Boolean;
    function GetDoublePass: Boolean;
  protected
    function GetPageHeight: Double; virtual;
  public
    constructor Create(AReport: TfrxReport); virtual;
    destructor Destroy; override;
    procedure EndPage; virtual; abstract;
    procedure BreakAllKeep; virtual;
    procedure NewColumn; virtual; abstract;
    procedure NewPage; virtual; abstract;
    procedure ShowBand(Band: TfrxBand); overload; virtual; abstract;
    procedure ShowBand(Band: TfrxBandClass); overload; virtual; abstract;
    procedure ShowBandByName(const BandName: String);
    procedure StopReport;
    function HeaderHeight: Double; virtual; abstract;
    function FooterHeight: Double; virtual; abstract;
    function FreeSpace: Double; virtual; abstract;
    function GetAggregateValue(const Name, Expression: String;
      Band: TfrxBand;  Flags: Integer): Variant; virtual; abstract;
    function Run: Boolean; virtual; abstract;

    property CurLine: Integer read FCurLine write FCurLine;
    property CurLineThrough: Integer read FCurLineThrough write FCurLineThrough;
    property NotifyList: TList read FNotifyList;
    property PreviewPages: TfrxCustomPreviewPages read FPreviewPages;
    property Report: TfrxReport read FReport;
    property Running: Boolean read FRunning write FRunning;
    property OnRunDialog: TfrxRunDialogEvent read FOnRunDialog write FOnRunDialog;
  published
    property CurColumn: Integer read FCurColumn write FCurColumn;
    property CurVColumn: Integer read FCurVColumn write FCurVColumn;
    property CurX: Double read FCurX write FCurX;
    property CurY: Double read FCurY write FCurY;
    property DoublePass: Boolean read GetDoublePass;
    property FinalPass: Boolean read FFinalPass write FFinalPass;
    property PageHeight: Double read GetPageHeight write FPageHeight;
    property PageWidth: Double read FPageWidth write FPageWidth;
    property StartDate: TDateTime read FStartDate write FStartDate;
    property StartTime: TDateTime read FStartTime write FStartTime;
    property TotalPages: Integer read FTotalPages write FTotalPages;
    property SecondScriptCall: Boolean read FSecondScriptCall write FSecondScriptCall;
  end;

  TfrxCustomOutline = class(TPersistent)
  private
    FCurItem: TfrxXMLItem;
    FPreviewPages: TfrxCustomPreviewPages;
  protected
    function GetCount: Integer; virtual; abstract;
  public
    constructor Create(APreviewPages: TfrxCustomPreviewPages); virtual;
    procedure AddItem(const Text: String; Top: Integer); virtual; abstract;
    procedure LevelDown(Index: Integer); virtual; abstract;
    procedure LevelRoot; virtual; abstract;
    procedure LevelUp; virtual; abstract;
    procedure GetItem(Index: Integer; var Text: String;
      var Page, Top: Integer); virtual; abstract;
    procedure ShiftItems(From: TfrxXMLItem; NewTop: Integer); virtual; abstract;
    function Engine: TfrxCustomEngine;
    function GetCurPosition: TfrxXMLItem; virtual; abstract;
    property Count: Integer read GetCount;
    property CurItem: TfrxXMLItem read FCurItem write FCurItem;
    property PreviewPages: TfrxCustomPreviewPages read FPreviewPages;
  end;

  TfrxCustomPreviewPages = class(TObject)
  private
    FAddPageAction: TfrxAddPageAction; { used in the cross-tab renderer }
    FCurPage: Integer;
    FCurPreviewPage: Integer;
    FEngine: TfrxCustomEngine;
    FFirstPage: Integer;               {  used in the composite reports }
    FOutline: TfrxCustomOutline;
    FReport: TfrxReport;
  protected
    function GetCount: Integer; virtual; abstract;
    function GetPage(Index: Integer): TfrxReportPage; virtual; abstract;
    function GetPageSize(Index: Integer): TPoint; virtual; abstract;
  public
    constructor Create(AReport: TfrxReport); virtual;
    destructor Destroy; override;
    procedure Clear; virtual; abstract;
    procedure Initialize; virtual; abstract;

    procedure AddObject(Obj: TfrxComponent); virtual; abstract;
    procedure AddPage(Page: TfrxReportPage); virtual; abstract;
    procedure AddSourcePage(Page: TfrxReportPage); virtual; abstract;
    procedure AddToSourcePage(Obj: TfrxComponent); virtual; abstract;
    procedure BeginPass; virtual; abstract;
    procedure ClearFirstPassPages; virtual; abstract;
    procedure CutObjects(APosition: Integer); virtual; abstract;
    procedure Finish; virtual; abstract;
    procedure IncLogicalPageNumber; virtual; abstract;
    procedure ResetLogicalPageNumber; virtual; abstract;
    procedure PasteObjects(X, Y: Extended); virtual; abstract;
    procedure ShiftAnchors(From, NewTop: Integer); virtual; abstract;
    procedure AddPicture(Picture: TfrxPictureView); virtual; abstract;
    function BandExists(Band: TfrxBand): Boolean; virtual; abstract;
    function GetCurPosition: Integer; virtual; abstract;
    function GetAnchorCurPosition: Integer; virtual; abstract;
    function GetLastY(ColumnPosition: Extended = 0): Extended; virtual; abstract;
    function GetLogicalPageNo: Integer; virtual; abstract;
    function GetLogicalTotalPages: Integer; virtual; abstract;

    procedure AddEmptyPage(Index: Integer); virtual; abstract;
    procedure DeletePage(Index: Integer); virtual; abstract;
    procedure ModifyPage(Index: Integer; Page: TfrxReportPage); virtual; abstract;
    procedure DrawPage(Index: Integer; Canvas: TCanvas; ScaleX, ScaleY,
      OffsetX, OffsetY: Extended); virtual; abstract;
    procedure ObjectOver(Index: Integer; X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; Scale, OffsetX, OffsetY: Extended;
      Click: Boolean; var Cursor: TCursor; DBClick: Boolean = False); virtual; abstract;
    procedure AddFrom(Report: TfrxReport); virtual; abstract;

    procedure LoadFromStream(Stream: TStream;
      AllowPartialLoading: Boolean = False); virtual; abstract;
    procedure SaveToStream(Stream: TStream); virtual; abstract;
    function LoadFromFile(const FileName: String;
      ExceptionIfNotFound: Boolean = False): Boolean; virtual; abstract;
    procedure SaveToFile(const FileName: String); virtual; abstract;
    function Print: Boolean; virtual; abstract;
    function Export(Filter: TfrxCustomExportFilter): Boolean; virtual; abstract;

    property AddPageAction: TfrxAddPageAction read FAddPageAction write FAddPageAction;
    property Count: Integer read GetCount;
    property CurPage: Integer read FCurPage write FCurPage;
    property CurPreviewPage: Integer read FCurPreviewPage write FCurPreviewPage;
    property Engine: TfrxCustomEngine read FEngine;
    property FirstPage: Integer read FFirstPage write FFirstPage;
    property Outline: TfrxCustomOutline read FOutline;
    property Page[Index: Integer]: TfrxReportPage read GetPage;
    property PageSize[Index: Integer]: TPoint read GetPageSize;
    property Report: TfrxReport read FReport;
  end;

  TfrxCustomPreview = class(TControl)
  private
    FPreviewPages: TfrxCustomPreviewPages;
    FReport: TfrxReport;
    FUseReportHints: Boolean;
  public
    procedure Init; virtual; abstract;
    procedure ShowHint(aRect: TRectF; Text: String); virtual; abstract;
    procedure HideHint; virtual; abstract;
    procedure Lock; virtual; abstract;
    procedure Unlock; virtual; abstract;
    procedure RefreshReport; virtual; abstract;
    procedure InternalOnProgressStart(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer); virtual; abstract;
    procedure InternalOnProgress(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer); virtual; abstract;
    procedure InternalOnProgressStop(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer); virtual; abstract;

    property PreviewPages: TfrxCustomPreviewPages read FPreviewPages write FPreviewPages;
    property Report: TfrxReport read FReport write FReport;
    property UseReportHints: Boolean read FUseReportHints write FUseReportHints;
  end;

  TfrxCompressorClass = class of TfrxCustomCompressor;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxCustomCompressor = class(TComponent)
  private
    FIsFR3File: Boolean;
    FOldCompressor: TfrxCompressorClass;
    FReport: TfrxReport;
    FStream: TStream;
    FTempFile: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Decompress(Source: TStream): Boolean; virtual; abstract;
    procedure Compress(Dest: TStream); virtual; abstract;
    procedure CreateStream;
    property IsFR3File: Boolean read FIsFR3File write FIsFR3File;
    property Report: TfrxReport read FReport write FReport;
    property Stream: TStream read FStream write FStream;
  end;

  TfrxCrypterClass = class of TfrxCustomCrypter;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxCustomCrypter = class(TComponent)
  private
    FStream: TStream;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Decrypt(Source: TStream; const Key: AnsiString): Boolean; virtual; abstract;
    procedure Crypt(Dest: TStream; const Key: AnsiString); virtual; abstract;
    procedure CreateStream;
    property Stream: TStream read FStream write FStream;
  end;

  TfrxLoadEvent = function(Sender: TfrxReport; Stream: TStream): Boolean of object;
  TfrxAfterLoadEvent = procedure(Sender: TfrxReport) of object;
  TfrxGetScriptValueEvent = function(var Params: Variant): Variant of object;

  TfrxConverterEvents = class(TObject)
  private
    FOnGetValue: TfrxGetValueEvent;
    FOnPrepareScript: TNotifyEvent;
    FOnLoad: TfrxLoadEvent;
    FOnAfterLoad: TfrxAfterLoadEvent;
    FOnGetScriptValue: TfrxGetScriptValueEvent;
    FFilter: String;
  public
    property OnGetValue: TfrxGetValueEvent read FOnGetValue write FOnGetValue;
    property OnPrepareScript: TNotifyEvent read FOnPrepareScript write FOnPrepareScript;
    property OnLoad: TfrxLoadEvent read FOnLoad write FOnLoad;
    property OnAfterLoad: TfrxAfterLoadEvent read FOnAfterLoad write FOnAfterLoad;
    property OnGetScriptValue: TfrxGetScriptValueEvent read FOnGetScriptValue write FOnGetScriptValue;
    property Filter: String read FFilter write FFilter;
  end;

  TfrxGlobalDataSetList = class(TList)
{$IFNDEF NO_CRITICAL_SECTION}
    FCriticalSection: TCriticalSection;
{$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
  end;


function frxFindDataSet(DataSet: TfrxDataSet; const Name: String;
  Owner: TComponent): TfrxDataSet;
procedure frxGetDataSetList(List: TStrings);

var
  frxDesignerClass: TfrxDesignerClass;
  frxDotMatrixExport: TfrxCustomExportFilter;
  frxCompressorClass: TfrxCompressorClass;
  frxCrypterClass: TfrxCrypterClass;
  frxConverter: TfrxConverterEvents;
{$IFNDEF NO_CRITICAL_SECTION}
  frxCS: TCriticalSection;
{$ENDIF}
  frxGlobalVariables: TfrxVariables;
const
  FR_VERSION = {$I frxVersion.inc};
  BND_COUNT = 18;
  frxBands: array[0..BND_COUNT - 1] of TfrxComponentClass =
    (TfrxReportTitle, TfrxReportSummary, TfrxPageHeader, TfrxPageFooter,
     TfrxHeader, TfrxFooter, TfrxMasterData, TfrxDetailData, TfrxSubdetailData,
     TfrxDataBand4, TfrxDataBand5, TfrxDataBand6, TfrxGroupHeader, TfrxGroupFooter,
     TfrxChild, TfrxColumnHeader, TfrxColumnFooter, TfrxOverlay);

implementation

{$R *.RES}

uses
  System.TypInfo, System.SysConst, System.Math,
  FMX.frxEngine, FMX.frxPreviewPages, FMX.frxPreview, FMX.frxPrinter,
  FMX.frxUtils, FMX.frxPassw, FMX.frxDialogForm,
  FMX.frxXMLSerializer, FMX.frxAggregate, FMX.frxGraphicUtils, FMX.frxRes, FMX.frxDsgnIntf,
  FMX.frxrcClass, FMX.frxClassRTTI, FMX.frxInheritError,
  FMX.fs_ipascal, FMX.fs_icpp, FMX.fs_ibasic, FMX.fs_ijs, FMX.fs_iclassesrtti,
  FMX.fs_igraphicsrtti, FMX.fs_iformsrtti, FMX.fs_idialogsrtti, FMX.fs_iinirtti,
  FMX.frxDMPClass
{$IFDEF DELPHI17}
{$IFNDEF MSWINDOWS}
  , Macapi.Foundation, Macapi.AppKit
{$ENDIF}
{$ENDIF};


var
  DatasetList: TfrxGlobalDataSetList;

type
  TByteSet = set of 0..7;
  PByteSet = ^TByteSet;

  THackControl = class(TControl);
  THackPersistent = class(TPersistent);
  THackThread = class(TThread);
  TParentForm = class(TForm);

function Round8(e: Extended): Extended;
begin
  Result := Round(e * 100000000) / 100000000;
end;

function frxFindDataSet(DataSet: TfrxDataSet; const Name: String;
  Owner: TComponent): TfrxDataSet;
var
  i: Integer;
  ds: TfrxDataSet;
begin
  Result := DataSet;
  if Name = '' then
  begin
    Result := nil;
    Exit;
  end;
  if Owner = nil then Exit;
  DatasetList.Lock;
  for i := 0 to DatasetList.Count - 1 do
  begin
    ds := DatasetList[i];
    if AnsiCompareText(ds.UserName, Name) = 0 then
      if not ((Owner is TfrxReport) and (ds.Owner is TfrxReport) and
        (ds.Owner <> Owner)) then
      begin
        Result := DatasetList[i];
        break;
      end;
  end;
  DatasetList.Unlock;
end;

procedure frxGetDataSetList(List: TStrings);
var
  i: Integer;
  ds: TfrxDataSet;
begin
  DatasetList.Lock;
  List.Clear;
  for i := 0 to DatasetList.Count - 1 do
  begin
    ds := DatasetList[i];
    if (ds <> nil) and (ds.UserName <> '') and ds.Enabled then
      List.AddObject(ds.UserName, ds);
  end;
  DatasetList.Unlock;
end;

function FloatDiff(const Val1, Val2: Double): Boolean;
begin
  Result := Abs(Val1 - Val2) > 1e-4;
end;

function ShiftToByte(Value: TShiftState): Byte;
begin
  Result := Byte(PByteSet(@Value)^);
end;


{ TfrxDataset }

constructor TfrxDataSet.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := True;
  FOpenDataSource := True;
  FRangeBegin := rbFirst;
  FRangeEnd := reLast;
  DatasetList.Lock;
  DatasetList.Add(Self);
  DatasetList.Unlock;
end;

destructor TfrxDataSet.Destroy;
begin
  DatasetList.Lock;
  DatasetList.Remove(Self);
  inherited;
  DatasetList.Unlock;
end;

procedure TfrxDataSet.SetName(const NewName: TComponentName);
begin
  inherited;
  if NewName <> '' then
    if (FUserName = '') or (FUserName = Name) then
      UserName := NewName
end;

procedure TfrxDataSet.SetUserName(const Value: String);
begin
  if Trim(Value) = '' then
    raise Exception.Create(frxResources.Get('prInvProp'));
  FUserName := Value;
end;

procedure TfrxDataSet.Initialize;
begin
end;

procedure TfrxDataSet.Finalize;
begin
end;

procedure TfrxDataSet.Close;
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

procedure TfrxDataSet.Open;
begin
  if Assigned(FOnOpen) then FOnOpen(Self);
end;

procedure TfrxDataSet.First;
begin
  FRecNo := 0;
  FEof := False;
  if Assigned(FOnFirst) then
    FOnFirst(Self);
end;

procedure TfrxDataSet.Next;
begin
  FEof := False;
  Inc(FRecNo);
  if not ((FRangeEnd = reCount) and (FRecNo >= FRangeEndCount)) then
  begin
    if Assigned(FOnNext) then
      FOnNext(Self);
  end
  else
  begin
    FRecNo := FRangeEndCount - 1;
    FEof := True;
  end;
end;

procedure TfrxDataSet.Prior;
begin
  Dec(FRecNo);
  if Assigned(FOnPrior) then
    FOnPrior(Self);
end;

function TfrxDataSet.Eof: Boolean;
begin
  Result := False;
  if FRangeEnd = reCount then
    if (FRecNo >= FRangeEndCount) or FEof then
      Result := True;
  if Assigned(FOnCheckEOF) then
    FOnCheckEOF(Self, Result);
end;

function TfrxDataSet.GetDisplayText(Index: String): WideString;
begin
  Result := '';
end;

function TfrxDataSet.GetDisplayWidth(Index: String): Integer;
begin
  Result := 10;
end;

procedure TfrxDataSet.GetFieldList(List: TStrings);
begin
  List.Clear;
end;

function TfrxDataSet.GetValue(Index: String): Variant;
begin
  Result := Null;
end;

function TfrxDataSet.HasField(const fName: String): Boolean;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  GetFieldList(sl);
  Result := sl.IndexOf(fName) <> -1;
  sl.Free;
end;

procedure TfrxDataSet.AssignBlobTo(const fName: String; Obj: TObject);
begin
// empty method
end;

function TfrxDataSet.IsBlobField(const fName: String): Boolean;
begin
  Result := False;
end;

function TfrxDataSet.FieldsCount: Integer;
begin
  Result := 0;
end;

function TfrxDataSet.GetFieldType(Index: String): TfrxFieldType;
begin
  Result := fftNumeric;
end;

function TfrxDataSet.RecordCount: Integer;
begin
  if (RangeBegin = rbFirst) and (RangeEnd = reCount) then
    Result := RangeEndCount
  else
    Result := 0;
end;


{ TfrxUserDataSet }

constructor TfrxUserDataSet.Create(AOwner: TComponent);
begin
  inherited;
  FFields := TStringList.Create;
end;

destructor TfrxUserDataSet.Destroy;
begin
  FFields.Free;
  inherited;
end;

procedure TfrxUserDataSet.SetFields(const Value: TStrings);
begin
  FFields.Assign(Value);
end;

procedure TfrxUserDataSet.GetFieldList(List: TStrings);
begin
  List.Assign(FFields);
end;

function TfrxUserDataSet.FieldsCount: Integer;
begin
  Result := FFields.Count;
end;

function TfrxUserDataSet.GetDisplayText(Index: String): WideString;
var
  v: Variant;
begin
  Result := '';
  if Assigned(FOnGetValue) then
  begin
    v := Null;
    FOnGetValue(Index, v);
    Result := VarToWideStr(v);
  end;

  if Assigned(FOnNewGetValue) then
  begin
    v := Null;
    FOnNewGetValue(Self, Index, v);
    Result := VarToWideStr(v);
  end;
end;

function TfrxUserDataSet.GetValue(Index: String): Variant;
begin
  Result := Null;
  if Assigned(FOnGetValue) then
    FOnGetValue(Index, Result);
  if Assigned(FOnNewGetValue) then
    FOnNewGetValue(Self, Index, Result);
end;


{ TfrxCustomDBDataSet }

constructor TfrxCustomDBDataset.Create(AOwner: TComponent);
begin
  FFields := TStringList.Create;
  FFields.Sorted := True;
  FFields.Duplicates := dupIgnore;
  FAliases := TStringList.Create;
  inherited;
end;

destructor TfrxCustomDBDataset.Destroy;
begin
  FFields.Free;
  FAliases.Free;
  inherited;
end;

procedure TfrxCustomDBDataset.SetFieldAliases(const Value: TStrings);
begin
  FAliases.Assign(Value);
end;

function TfrxCustomDBDataset.ConvertAlias(const fName: String): String;
var
  i: Integer;
  s: String;
begin
  Result := fName;
  for i := 0 to FAliases.Count - 1 do
  begin
    s := FAliases[i];
    if AnsiCompareText(Copy(s, Pos('=', s) + 1, MaxInt), fName) = 0 then
    begin
      Result := FAliases.Names[i];
      break;
    end;
  end;
end;

function TfrxCustomDBDataset.GetAlias(const fName: String): String;
var
  i: Integer;
begin
  Result := fName;
  for i := 0 to FAliases.Count - 1 do
    if AnsiCompareText(FAliases.Names[i], fName) = 0 then
    begin
      Result := FAliases[i];
      Result := Copy(Result, Pos('=', Result) + 1, MaxInt);
      break;
    end;
end;

function TfrxCustomDBDataset.FieldsCount: Integer;
var
  sl: TStrings;
begin
  sl := TStringList.Create;
  try
    GetFieldList(sl);
  finally
    Result := sl.Count;
    sl.Free;
  end;
end;

{ TfrxDBComponents }

function TfrxDBComponents.GetDescription: String;
begin
  Result := '';
end;

{ TfrxCustomDatabase }

procedure TfrxCustomDatabase.BeforeConnect(var Value: Boolean);
begin
  if (Report <> nil) and Assigned(Report.OnBeforeConnect) then
    Report.OnBeforeConnect(Self, Value);
end;

procedure TfrxCustomDatabase.AfterDisconnect;
begin
  if (Report <> nil) and Assigned(Report.OnAfterDisconnect) then
    Report.OnAfterDisconnect(Self);
end;

function TfrxCustomDatabase.GetConnected: Boolean;
begin
  Result := False;
end;

function TfrxCustomDatabase.GetDatabaseName: String;
begin
  Result := '';
end;

function TfrxCustomDatabase.GetLoginPrompt: Boolean;
begin
  Result := False;
end;

function TfrxCustomDatabase.GetParams: TStrings;
begin
  Result := nil;
end;

procedure TfrxCustomDatabase.SetConnected(Value: Boolean);
begin
// empty
end;

procedure TfrxCustomDatabase.SetDatabaseName(const Value: String);
begin
// empty
end;

procedure TfrxCustomDatabase.FromString(const Connection: WideString);
begin
// empty
end;

function TfrxCustomDatabase.ToString: WideString;
begin
// empty
  Result := '';
end;


procedure TfrxCustomDatabase.SetLogin(const Login, Password: String);
begin
// empty
end;

procedure TfrxCustomDatabase.SetLoginPrompt(Value: Boolean);
begin
// empty
end;

procedure TfrxCustomDatabase.SetParams(Value: TStrings);
begin
// empty
end;


{ TfrxComponent }

constructor TfrxComponent.Create(AOwner: TComponent);
begin
  if AOwner is TfrxComponent then
    inherited Create(TfrxComponent(AOwner).Report)
  else
    inherited Create(AOwner);

  FComponentStyle := [csPreviewVisible];
  FBaseName := ClassName;
  Delete(FBaseName, Pos('Tfrx', FBaseName), 4);
  Delete(FBaseName, Pos('View', FBaseName), 4);
  FObjects := TList.Create;
  FAllObjects := TList.Create;

  FFont := TfrxFont.Create;
  with FFont do
  begin
    Name := DefFontName;
    Size := DefFontSize;
    Color := claBlack;
    OnChange := FontChanged;
  end;

  FVisible := True;
  ParentFont := True;
  if AOwner is TfrxComponent then
    SetParent(TfrxComponent(AOwner));
end;

constructor TfrxComponent.DesignCreate(AOwner: TComponent; Flags: Word);
begin
  FIsDesigning := True;
  Create(AOwner);
end;

destructor TfrxComponent.Destroy;
begin
  SetParent(nil);
  Clear;
  FFont.Free;
  FObjects.Free;
  FAllObjects.Free;
  inherited;
end;

procedure TfrxComponent.Assign(Source: TPersistent);
var
  s: TMemoryStream;
begin
  if Source is TfrxComponent then
  begin
    s := TMemoryStream.Create;
    try
      TfrxComponent(Source).SaveToStream(s, False, True);
      s.Position := 0;
      LoadFromStream(s);
    finally
      s.Free;
    end;
  end;
end;

procedure TfrxComponent.AssignAll(Source: TfrxComponent; Streaming: Boolean = False);
var
  s: TMemoryStream;
begin
  s := TMemoryStream.Create;
  try
    Source.SaveToStream(s, True, True, Streaming);
    s.Position := 0;
    LoadFromStream(s);
  finally
    s.Free;
  end;
end;

procedure TfrxComponent.LoadFromStream(Stream: TStream);
var
  Reader: TfrxXMLSerializer;
begin
  Clear;
  Reader := TfrxXMLSerializer.Create(Stream);
  if Report <> nil then
    Report.FXMLSerializer := Reader;

  try
    Reader.Owner := Report;
    if (Report <> nil) and Report.EngineOptions.EnableThreadSafe then
    begin
{$IFNDEF NO_CRITICAL_SECTION}
      frxCS.Enter;
{$ENDIF}
      try
        Reader.ReadRootComponent(Self, nil);
      finally
{$IFNDEF NO_CRITICAL_SECTION}
        frxCS.Leave;
{$ENDIF}
      end;
    end
    else
      Reader.ReadRootComponent(Self, nil);

    if Report <> nil then
      Report.Errors.AddStrings(Reader.Errors);

  finally
    Reader.Free;
    if Report <> nil then
      Report.FXMLSerializer := nil;
  end;
end;

procedure TfrxComponent.SaveToStream(Stream: TStream; SaveChildren: Boolean = True;
  SaveDefaultValues: Boolean = False; Streaming: Boolean = False);
var
  Writer: TfrxXMLSerializer;
begin
  Writer := TfrxXMLSerializer.Create(Stream);

  try
    Writer.Owner := Report;
    Writer.SerializeDefaultValues := SaveDefaultValues;
    if Self is TfrxReport then
      Writer.OnGetAncestor := Report.DoGetAncestor;
    Writer.WriteRootComponent(Self, SaveChildren, nil, Streaming);
  finally
    Writer.Free;
  end;
end;

procedure TfrxComponent.Clear;
var
  i: Integer;
  c: TfrxComponent;
begin
  i := 0;
  while i < FObjects.Count do
  begin
    c := FObjects[i];
    if (csAncestor in c.ComponentState) then
    begin
      c.Clear;
      Inc(i);
    end
    else
      c.Free;
  end;
end;

procedure TfrxComponent.SetParent(AParent: TfrxComponent);
begin
  if FParent <> AParent then
  begin
    if FParent <> nil then
      FParent.FObjects.Remove(Self);
    if AParent <> nil then
      AParent.FObjects.Add(Self);
  end;

  FParent := AParent;
  if FParent <> nil then
    SetParentFont(FParentFont);
end;

procedure TfrxComponent.SetBounds(ALeft, ATop, AWidth, AHeight: Double);
begin
  Left := ALeft;
  Top := ATop;
  Width := AWidth;
  Height := AHeight;
end;

function TfrxComponent.GetPage: TfrxPage;
var
  p: TfrxComponent;
begin
  if Self is TfrxPage then
  begin
    Result := TfrxPage(Self);
    Exit;
  end;

  Result := nil;
  p := Parent;
  while p <> nil do
  begin
    if p is TfrxPage then
    begin
      Result := TfrxPage(p);
      Exit;
    end;
    p := p.Parent;
  end;
end;

function TfrxComponent.GetReport: TfrxReport;
var
  p: TfrxComponent;
begin
  if Self is TfrxReport then
  begin
    Result := TfrxReport(Self);
    Exit;
  end;

  Result := nil;
  p := Parent;
  while p <> nil do
  begin
    if p is TfrxReport then
    begin
      Result := TfrxReport(p);
      Exit;
    end;
    p := p.Parent;
  end;
end;

function TfrxComponent.GetIsLoading: Boolean;
begin
  Result := FIsLoading or (csLoading in ComponentState);
end;

function TfrxComponent.GetAbsTop: Double;
begin
  if (Parent <> nil) and not (Parent is TfrxDialogPage) then
    Result := Parent.AbsTop + Top else
    Result := Top;
end;

function TfrxComponent.GetAbsLeft: Double;
begin
  if (Parent <> nil) and not (Parent is TfrxDialogPage) then
    Result := Parent.AbsLeft + Left else
    Result := Left;
end;

procedure TfrxComponent.SetLeft(Value: Double);
begin
  if not IsDesigning or not (rfDontMove in FRestrictions) then
    FLeft := Value;
end;

procedure TfrxComponent.SetTop(Value: Double);
begin
  if not IsDesigning or not (rfDontMove in FRestrictions) then
    FTop := Value;
end;

procedure TfrxComponent.SetWidth(Value: Double);
begin
  if not IsDesigning or not (rfDontSize in FRestrictions) then
    FWidth := Value;
end;

procedure TfrxComponent.SetHeight(Value: Double);
begin
  if not IsDesigning or not (rfDontSize in FRestrictions) then
    FHeight := Value;
end;

function TfrxComponent.IsFontStored: Boolean;
begin
  Result := not FParentFont;
end;

procedure TfrxComponent.SetFont(Value: TfrxFont);
begin
  FFont.Assign(Value);
  FParentFont := False;
end;

procedure TfrxComponent.SetParentFont(const Value: Boolean);
begin
  if Value then
    if Parent <> nil then
      Font := Parent.Font;
  FParentFont := Value;
end;

procedure TfrxComponent.SetVisible(Value: Boolean);
begin
  FVisible := Value;
end;

procedure TfrxComponent.FontChanged(Sender: TObject);
var
  i: Integer;
  c: TfrxComponent;
begin
  FParentFont := False;
  for i := 0 to FObjects.Count - 1 do
  begin
    c := FObjects[i];
    if c.ParentFont then
      c.ParentFont := True;
  end;
end;

function TfrxComponent.GetAllObjects: TList;

  procedure EnumObjects(c: TfrxComponent);
  var
    i: Integer;
  begin
    if c <> Self then
      FAllObjects.Add(c);
    for i := 0 to c.FObjects.Count - 1 do
      EnumObjects(c.FObjects[i]);
  end;

begin
  FAllObjects.Clear;
  EnumObjects(Self);
  Result := FAllObjects;
end;

procedure TfrxComponent.SetName(const AName: TComponentName);
var
  c: TfrxComponent;
begin
  if CompareText(AName, Name) = 0 then Exit;

  if (AName <> '') and (Report <> nil) then
  begin
    c := Report.FindObject(AName);
    if (c <> nil) and (c <> Self) then
      raise EDuplicateName.Create(frxResources.Get('prDupl'));
    if IsAncestor then
      raise Exception.CreateFmt(frxResources.Get('clCantRen'), [Name])
  end;
  inherited;
end;

procedure TfrxComponent.CreateUniqueName;
var
  i: Integer;
  l: TList;
  sl: TStringList;
begin
  sl := TStringList.Create;
  sl.Sorted := True;
  sl.Duplicates := dupIgnore;

  if Report <> nil then
    l := Report.AllObjects else
    l := Parent.AllObjects;
  for i := 0 to l.Count - 1 do
    sl.Add(TfrxComponent(l[i]).Name);

  i := 1;
  while sl.IndexOf(String(FBaseName) + IntToStr(i)) <> -1 do
    Inc(i);

  Name := String(FBaseName) + IntToStr(i);
  sl.Free;
end;

function TfrxComponent.Diff(AComponent: TfrxComponent): String;
begin
  Result := InternalDiff(AComponent);
end;

function TfrxComponent.DiffFont(f1, f2: TfrxFont; const Add: String): String;
var
  fs: Integer;
begin
  Result := '';

  if f1.Name <> f2.Name then
    Result := Result + Add + 'Font.Name="' + frxStrToXML(f1.Name) + '"';
  if f1.Size <> f2.Size then
    Result := Result + Add + 'Font.Size="' + FloatToStr(f1.Size) + '"';
  if f1.Color <> f2.Color then
    Result := Result + Add + 'Font.Color="' + IntToStr(Integer(f1.Color)) + '"';
  if f1.Style <> f2.Style then
  begin
    fs := 0;
    if fsBold in f1.Style then fs := 1;
    if fsItalic in f1.Style then fs := fs or 2;
    if fsUnderline in f1.Style then fs := fs or 4;
    if fsStrikeout in f1.Style then fs := fs or 8;
    Result := Result + Add + 'Font.Style="' + IntToStr(fs) + '"';
  end;
end;

function TfrxComponent.InternalDiff(AComponent: TfrxComponent): String;
begin
  Result := '';

  if FloatDiff(FLeft, AComponent.FLeft) then
    Result := Result + ' l="' + FloatToStr(FLeft) + '"';
  if (Self is TfrxBand) or FloatDiff(FTop, AComponent.FTop) then
    Result := Result + ' t="' + FloatToStr(FTop) + '"';
  if not ((Self is TfrxCustomMemoView) and TfrxCustomMemoView(Self).FAutoWidth) then
    if FloatDiff(FWidth, AComponent.FWidth) then
      Result := Result + ' w="' + FloatToStr(FWidth) + '"';
  if FloatDiff(FHeight, AComponent.FHeight) then
    Result := Result + ' h="' + FloatToStr(FHeight) + '"';
  if FVisible <> AComponent.FVisible then
    Result := Result + ' Visible="' + frxValueToXML(FVisible) + '"';
  if not FParentFont then
    Result := Result + DiffFont(FFont, AComponent.FFont, ' ');
  if FParentFont <> AComponent.FParentFont then
    Result := Result + ' ParentFont="' + frxValueToXML(FParentFont) + '"';
  if Tag <> AComponent.Tag then
    Result := Result + ' Tag="' + IntToStr(Tag) + '"';
end;

function TfrxComponent.AllDiff(AComponent: TfrxComponent): String;
var
  s: TStringStream;
  Writer: TfrxXMLSerializer;
  i: Integer;
begin
  s := TStringStream.Create('', TEncoding.UTF8);
  Writer := TfrxXMLSerializer.Create(s);
  Writer.Owner := Report;
  Writer.WriteComponent(Self);
  Writer.Free;

  Result := s.DataString;
  i := Pos(' ', Result);
  if i <> 0 then
  begin
    Delete(Result, 1, i);
    Delete(Result, Length(Result) - 1, 2);
  end
  else
    Result := '';
  if AComponent <> nil then
    Result := Result + ' ' + InternalDiff(AComponent);
  { cross bands and Keep mechanism fix }
  if (Self is TfrxNullBand) then
  begin
    Result := Result + ' l="' + FloatToStr(FLeft) + '"';
    Result := Result + ' t="' + FloatToStr(FTop) + '"';
  end;

  s.Free;
end;

procedure TfrxComponent.AddSourceObjects;
begin
// do nothing
end;
procedure TfrxComponent.AlignChildren;
var
  i: Integer;
  c: TfrxComponent;
  sl: TStringList;

  procedure DoAlign(v: TfrxView; n, dir: Integer);
  var
    i: Integer;
    c, c0: TfrxComponent;
  begin
    c0 := nil;
    i := n;
    while (i >= 0) and (i < sl.Count) do
    begin
      c := TfrxComponent(sl.Objects[i]);
      if c <> v then
        if (c.AbsTop < v.AbsTop + v.Height - 1e-4) and
          (v.AbsTop < c.AbsTop + c.Height - 1e-4) then
        begin
          { special case for baWidth }
          if (v.Align = baWidth) and
            (((dir = 1) and (c.Left > v.Left)) or
            ((dir = -1) and (c.Left + c.Width < v.Left + v.Width))) then
          begin
            Dec(i, dir);
            continue;
          end;
          c0 := c;
          break;
        end;
      Dec(i, dir);
    end;

    if (dir = 1) and (v.Align in [baLeft, baWidth]) then
      if c0 = nil then
        v.Left := 0 else
        v.Left := c0.Left + c0.Width;

    if v.Align = baRight then
      if c0 = nil then
        v.Left := Width - v.Width else
        v.Left := c0.Left - v.Width;

    if (dir = -1) and (v.Align = baWidth) then
      if c0 = nil then
        v.Width := Width - v.Left else
        v.Width := c0.Left - v.Left;
  end;

begin
  sl := TStringList.Create;
  sl.Sorted := True;
  sl.Duplicates := dupAccept;

  for i := 0 to FObjects.Count - 1 do
  begin
    c := FObjects[i];
    if c is TfrxView then
      if c.Left >= 0 then
        sl.AddObject('1' + Format('%9.2f', [c.Left]), c)
      else
        sl.AddObject('0' + Format('%9.2f', [-c.Left]), c);
  end;

  { process baLeft }

  for i := 0 to sl.Count - 1 do
  begin
    c := TfrxComponent(sl.Objects[i]);
    if c is TfrxView then
      if TfrxView(c).Align in [baLeft, baWidth] then
        DoAlign(TfrxView(c), i, 1);
  end;

  { process baRight }

  for i := sl.Count - 1 downto 0 do
  begin
    c := TfrxComponent(sl.Objects[i]);
    if c is TfrxView then
      if TfrxView(c).Align in [baRight, baWidth] then
        DoAlign(TfrxView(c), i, -1);
  end;

  { process others }

  for i := 0 to FObjects.Count - 1 do
  begin
    c := FObjects[i];
    if c is TfrxView then
      case TfrxView(c).Align of
        baCenter:
          c.Left := (Width - c.Width) / 2;

        baBottom:
          c.Top := Height - c.Height;

        baClient:
          begin
            c.Left := 0;
            c.Top := 0;
            c.Width := Width;
            c.Height := Height;
          end;
      end;
  end;

  sl.Free;
end;

function TfrxComponent.FindObject(const AName: String): TfrxComponent;
var
  i: Integer;
  l: TList;
begin
  Result := nil;
  l := AllObjects;
  for i := 0 to l.Count - 1 do
    if CompareText(AName, TfrxComponent(l[i]).Name) = 0 then
    begin
      Result := l[i];
      break;
    end;
end;

class function TfrxComponent.GetDescription: String;
begin
  Result := ClassName;
end;

function TfrxComponent.GetChildOwner: TComponent;
begin
  Result := Self;
end;

procedure TfrxComponent.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i: Integer;
begin
  if (Self is TfrxReport) and not TfrxReport(Self).StoreInDFM then
    Exit;
  for i := 0 to FObjects.Count - 1 do
    Proc(FObjects[i]);
end;

procedure TfrxComponent.BeforeStartReport;
begin
// do nothing
end;

procedure TfrxComponent.OnNotify(Sender: TObject);
begin
// do nothing
end;

procedure TfrxComponent.OnPaste;
begin
//
end;

function TfrxComponent.GetIsAncestor: Boolean;
begin
  Result := (csAncestor in ComponentState) or FAncestor;
end;

function TfrxComponent.FindDataSet(DataSet: TfrxDataSet; const DSName: String): TfrxDataSet;
var
  DSItem:TfrxDataSetItem;
  AReport: TfrxReport;
begin
  Result := nil;
  if Self is TfrxReport then
    AReport := TfrxReport(Self)
  else AReport := Report;
  if (AReport <> nil) and not AReport.EngineOptions.UseGlobalDataSetList then
  begin
    DSItem := AReport.EnabledDataSets.Find(DSName);
    if DSItem <> nil then Result := DSItem.FDataSet;
  end
  else
    Result := frxFindDataSet(DataSet, DSName, AReport);
end;

function TfrxComponent.GetContainerObjects: TList;
begin
  Result := FObjects;
end;

function TfrxComponent.ContainerAdd(Obj: TfrxComponent): Boolean;
begin
  Result := False;
end;

function TfrxComponent.ContainerMouseDown(Sender: TObject; X, Y: Integer): Boolean;
begin
  Result := False;
end;

procedure TfrxComponent.ContainerMouseMove(Sender: TObject; X, Y: Integer);
begin
end;

procedure TfrxComponent.ContainerMouseUp(Sender: TObject; X, Y: Integer);
begin
end;


{ TfrxReportComponent }

constructor TfrxReportComponent.Create(AOwner: TComponent);
begin
  inherited;
  FShiftChildren := TList.Create;
end;

destructor TfrxReportComponent.Destroy;
begin
  FShiftChildren.Free;
  inherited;
end;

procedure TfrxReportComponent.GetData;
begin
// do nothing
end;

procedure TfrxReportComponent.BeforePrint;
begin
  FOriginalRect := frxRect(Left, Top, Width, Height);
end;

procedure TfrxReportComponent.AfterPrint;
begin
  with FOriginalRect do
    SetBounds(Left, Top, Right, Bottom);
end;

function TfrxReportComponent.GetComponentText: String;
begin
  Result := '';
end;

function TfrxReportComponent.GetRealBounds: TfrxRect;
begin
  Result := frxRect(AbsLeft, AbsTop, AbsLeft + Width, AbsTop + Height);
end;


{ TfrxDialogComponent }

constructor TfrxDialogComponent.Create(AOwner: TComponent);
begin
  inherited;
  frComponentStyle := frComponentStyle - [csPreviewVisible];
  Width := 28;
  Height := 28;
  FImageIsLoaded := False;
  FImage  := TBitmap.Create(28, 28);
end;

destructor TfrxDialogComponent.Destroy;
begin
  if FComponent <> nil then
    FComponent.Free;
  FComponent := nil;
  FImage.Free;
  inherited;
end;

procedure TfrxDialogComponent.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('pLeft', ReadLeft, WriteLeft, Report <> nil);
  Filer.DefineProperty('pTop', ReadTop, WriteTop, Report <> nil);
end;

procedure TfrxDialogComponent.ReadLeft(Reader: TReader);
begin
  Left := Reader.ReadInteger;
end;

procedure TfrxDialogComponent.ReadTop(Reader: TReader);
begin
  Top := Reader.ReadInteger;
end;

procedure TfrxDialogComponent.WriteLeft(Writer: TWriter);
begin
  Writer.WriteInteger(Round(Left));
end;

procedure TfrxDialogComponent.WriteTop(Writer: TWriter);
begin
  Writer.WriteInteger(Round(Top));
end;

procedure TfrxDialogComponent.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  r: TRectF;
  i: Integer;
  w: Single;
  Item: TfrxObjectItem;
begin
  Width := 28;
  Height := 28;

  r := RectF(Round(Left), Round(Top), Round(Left + 28), Round(Top + 28));
  Canvas.Fill.Color := claWhitesmoke;
  Canvas.FillRect(r, 0, 0, allCorners, 1);
  Canvas.StrokeThickness := 1;
  Canvas.Stroke.Color := claBlack;
  Canvas.DrawRect(r, 0, 0, allCorners, 1);
  Canvas.StrokeThickness := 1;
  Canvas.Stroke.Color := claSilver;
  Canvas.DrawRect(RectF(Round(Left + 1), Round(Top + 1), Round(Left + 27), Round(Top + 27)), 0, 0, allCorners, 1);

  if not FImageIsLoaded then
    for i := 0 to frxObjects.Count - 1 do
    begin
      Item := frxObjects[i];
      if Item.ClassRef = ClassType then
      begin
        frxResources.LoadImageFromResouce(FImage, Item.ButtonImageIndex);
        FImageIsLoaded := True;
        break;
      end;
    end;

  Canvas.DrawBitmap(FImage, RectF(0, 0, FImage.Width, FImage.Height), RectF(Round(Left + 4), Round(Top + 4), Round(Left + 24), Round(Top + 24)), 1, false);
  Canvas.Font.Family := 'Tahoma';
  Canvas.Font.Size := 10;
  Canvas.Fill.Color := claBlack;
  Canvas.Font.Style := [];
  w := Canvas.TextWidth(Name);
//  Canvas.Brush.Color := clWindow;
  Canvas.FillText(RectF(r.Left - (w - 28) / 2, r.Bottom + 4, r.Left - (w - 28) / 2 + w, r.Bottom + 20), Name, false, 1, [], TTextAlign.taCenter, TTextAlign.taLeading);
end;


{ TfrxDialogControl }

constructor TfrxDialogControl.Create(AOwner: TComponent);
begin
  inherited;
  FBaseName := ClassName;
  Delete(FBaseName, Pos('Tfrx', FBaseName), 4);
  Delete(FBaseName, Pos('Control', FBaseName), 7);
end;

destructor TfrxDialogControl.Destroy;
begin
  inherited;
  if FControl <> nil then
    FControl.Free;
  FControl := nil;
end;

procedure TfrxDialogControl.InitControl(AControl: TControl);
begin
  FControl := AControl;
  with FControl do
  begin
    OnClick := DoOnClick;
    OnDblClick := DoOnDblClick;
    OnMouseDown := DoOnMouseDown;
    OnMouseMove := DoOnMouseMove;
    OnMouseUp := DoOnMouseUp;
    OnEnter := DoOnEnter;
    OnExit := DoOnExit;
    OnKeyDown := DoOnKeyDown;
    OnKeyUp := DoOnKeyUp;
  end;
  SetParent(Parent);
end;

procedure TfrxDialogControl.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  Sstate: TCanvasSaveState;
  oldM: TMatrix;
  p: TPointF;
begin
  try
    Sstate := Canvas.SaveState;
    oldM := Canvas.Matrix;
{$IFDEF DELPHI22}
    FControl.PrepareForPaint;
{$ENDIF}
    FControl.PaintTo(Canvas, RectF(oldM.m31 + AbsLeft, oldM.m32 + AbsTop, oldM.m31 + AbsLeft + Width, oldM.m32 + AbsTop + Height), nil);
  finally
    Canvas.SetMatrix(oldM);
    Canvas.RestoreState(Sstate);
  end;
end;

function TfrxDialogControl.GetCaption: String;
{$IFDEF DELPHI22}
var
  aICaption: ICaption;
{$ENDIF}
begin
{$IFDEF DELPHI22}
  aICaption := FControl as ICaption;
  if aICaption <> nil then
    Result := aICaption.Text;
{$ELSE}
  if FControl is TTextControl then
    Result := TTextControl(FControl).Text
  else
    Result := '';
{$ENDIF}
end;

function TfrxDialogControl.GetEnabled: Boolean;
begin
  Result := FControl.Enabled;
end;

procedure TfrxDialogControl.SetLeft(Value: Double);
begin
  inherited;
  FControl.Position.X := Round(Left);
end;

procedure TfrxDialogControl.SetTop(Value: Double);
begin
  inherited;
  FControl.Position.Y := Round(Top);
end;

procedure TfrxDialogControl.SetWidth(Value: Double);
begin
  inherited;
  FControl.Width := Round(Width);
end;

procedure TfrxDialogControl.SetHeight(Value: Double);
begin
  inherited;
  FControl.Height := Round(Height);
end;

procedure TfrxDialogControl.SetVisible(Value: Boolean);
begin
  inherited;
  FControl.Visible := Visible;
end;

procedure TfrxDialogControl.SetCaption(const Value: String);
{$IFDEF DELPHI22}
var
  aICaption: ICaption;
{$ENDIF}
begin
{$IFDEF DELPHI22}
  aICaption := FControl as ICaption;
  if aICaption <> nil then
    aICaption.Text := Value;
{$ELSE}
  if FControl is TTextControl then
    TTextControl(FControl).Text := Value;
{$ENDIF}
end;

procedure TfrxDialogControl.SetEnabled(const Value: Boolean);
begin
  FControl.Enabled := Value;
end;

function TfrxDialogControl.GetHint: String;
begin
// todo
  Result := '';//FControl.Hint;
end;

procedure TfrxDialogControl.SetHint(const Value: String);
begin
//  FControl.Hint := Value;
end;

function TfrxDialogControl.GetShowHint: Boolean;
begin
  Result := False;//FControl.ShowHint;
end;

procedure TfrxDialogControl.SetShowHint(const Value: Boolean);
begin
//  FControl.ShowHint := Value;
end;

function TfrxDialogControl.GetTabStop: Boolean;
begin
  Result := FControl.CanFocus;
end;

procedure TfrxDialogControl.SetTabStop(const Value: Boolean);
begin
  FControl.CanFocus := Value;
end;

procedure TfrxDialogControl.FontChanged(Sender: TObject);
begin
  inherited;
  if FControl is TTextControl then
    Font.AssignToFont(TTextControl(FControl).Font);
end;

procedure TfrxDialogControl.SetParentFont(const Value: Boolean);
begin
  inherited;
// todo
//  if FControl <> nil then
//    THackControl(FControl).ParentFont := Value;
end;

procedure TfrxDialogControl.SetParent(AParent: TfrxComponent);
begin
  inherited;
  if FControl <> nil then
    if AParent is TfrxDialogControl then
      FControl.Parent := TfrxDialogControl(AParent).Control
    else if AParent is TfrxDialogPage then
      FControl.Parent := TfrxDialogPage(AParent).DialogForm
end;

procedure TfrxDialogControl.DoOnClick(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnClick, True);
end;

procedure TfrxDialogControl.DoOnDblClick(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnDblClick, True);
end;

procedure TfrxDialogControl.DoOnEnter(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnEnter, True);
end;

procedure TfrxDialogControl.DoOnExit(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnExit, True);
end;

procedure TfrxDialogControl.DoOnKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: System.WideChar; Shift: TShiftState);
var
  v: Variant;
begin
  v := VarArrayOf([frxInteger(Self), Key, ShiftToByte(Shift)]);
  if (Report <> nil) and (FOnKeyDown <> '') then
  begin
    Report.DoParamEvent(FOnKeyDown, v, True);
    Key := v[1];
  end;
end;

procedure TfrxDialogControl.DoOnKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: System.WideChar; Shift: TShiftState);
var
  v: Variant;
begin
  v := VarArrayOf([frxInteger(Self), Key, ShiftToByte(Shift)]);
  if (Report <> nil) and (FOnKeyUp <> '') then
  begin
    Report.DoParamEvent(FOnKeyUp, v, True);
    Key := v[1];
  end;
end;

procedure TfrxDialogControl.DoOnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  v: Variant;
begin
  v := VarArrayOf([frxInteger(Self), Button, ShiftToByte(Shift), X, Y]);
  if Report <> nil then
    Report.DoParamEvent(FOnMouseDown, v, True);
end;

procedure TfrxDialogControl.DoOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
var
  v: Variant;
begin
  if (Report <> nil) and (Hint <> '') and ShowHint then
  begin
    Report.SetProgressMessage(GetLongHint(Self.Hint), True);
  end;
  v := VarArrayOf([frxInteger(Self), ShiftToByte(Shift), X, Y]);
  if Report <> nil then
    Report.DoParamEvent(FOnMouseMove, v, True);
end;

procedure TfrxDialogControl.DoOnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  v: Variant;
begin
  v := VarArrayOf([frxInteger(Self), Button, ShiftToByte(Shift), X, Y]);
  if Report <> nil then
    Report.DoParamEvent(FOnMouseUp, v, True);
end;


{ TfrxFrameLine }

constructor TfrxFrameLine.Create(AFrame: TfrxFrame);
begin
  FColor := claBlack;
  FStyle := fsSolid;
  FWidth := 1;
  FFrame := AFrame;
end;

procedure TfrxFrameLine.Assign(Source: TPersistent);
begin
  if Source is TfrxFrameLine then
  begin
    FColor := TfrxFrameLine(Source).Color;
    FStyle := TfrxFrameLine(Source).Style;
    FWidth := TfrxFrameLine(Source).Width;
  end;
end;

function TfrxFrameLine.IsColorStored: Boolean;
begin
  Result := FColor <> FFrame.Color;
end;

function TfrxFrameLine.IsStyleStored: Boolean;
begin
  Result := FStyle <> FFrame.Style;
end;

function TfrxFrameLine.IsWidthStored: Boolean;
begin
  Result := FWidth <> FFrame.Width;
end;

function TfrxFrameLine.Diff(ALine: TfrxFrameLine; const LineName: String;
  ColorChanged, StyleChanged, WidthChanged: Boolean): String;
begin
  Result := '';

  if (ColorChanged and IsColorStored) or (not ColorChanged and (FColor <> ALine.Color)) then
    Result := Result + ' ' + LineName + '.Color="' + IntToStr(Integer(FColor)) + '"';
  if (StyleChanged and IsStyleStored) or (not StyleChanged and (FStyle <> ALine.Style)) then
    Result := Result + ' ' + LineName + '.Style="' + frxValueToXML(FStyle) + '"';
  if (WidthChanged and IsWidthStored) or (not WidthChanged and FloatDiff(FWidth, ALine.Width)) then
    Result := Result + ' ' + LineName + '.Width="' + FloatToStr(FWidth) + '"';
end;


{ TfrxFrame }

constructor TfrxFrame.Create;
begin
  FColor := claBlack;
  FShadowColor := claBlack;
  FShadowWidth := 4;
  FStyle := fsSolid;
  FTyp := [];
  FWidth := 1;

  FLeftLine := TfrxFrameLine.Create(Self);
  FTopLine := TfrxFrameLine.Create(Self);
  FRightLine := TfrxFrameLine.Create(Self);
  FBottomLine := TfrxFrameLine.Create(Self);
end;

destructor TfrxFrame.Destroy;
begin
  FLeftLine.Free;
  FTopLine.Free;
  FRightLine.Free;
  FBottomLine.Free;
  inherited;
end;

procedure TfrxFrame.Assign(Source: TPersistent);
begin
  if Source is TfrxFrame then
  begin
    FColor := TfrxFrame(Source).Color;
    FDropShadow := TfrxFrame(Source).DropShadow;
    FShadowColor := TfrxFrame(Source).ShadowColor;
    FShadowWidth := TfrxFrame(Source).ShadowWidth;
    FStyle := TfrxFrame(Source).Style;
    FTyp := TfrxFrame(Source).Typ;
    FWidth := TfrxFrame(Source).Width;

    FLeftLine.Assign(TfrxFrame(Source).LeftLine);
    FTopLine.Assign(TfrxFrame(Source).TopLine);
    FRightLine.Assign(TfrxFrame(Source).RightLine);
    FBottomLine.Assign(TfrxFrame(Source).BottomLine);
  end;
end;

function TfrxFrame.IsShadowWidthStored: Boolean;
begin
  Result := FShadowWidth <> 4;
end;

function TfrxFrame.IsTypStored: Boolean;
begin
  Result := FTyp <> [];
end;

function TfrxFrame.IsWidthStored: Boolean;
begin
  Result := FWidth <> 1;
end;

procedure TfrxFrame.SetBottomLine(const Value: TfrxFrameLine);
begin
  FBottomLine.Assign(Value);
end;

procedure TfrxFrame.SetLeftLine(const Value: TfrxFrameLine);
begin
  FLeftLine.Assign(Value);
end;

procedure TfrxFrame.SetRightLine(const Value: TfrxFrameLine);
begin
  FRightLine.Assign(Value);
end;

procedure TfrxFrame.SetTopLine(const Value: TfrxFrameLine);
begin
  FTopLine.Assign(Value);
end;

procedure TfrxFrame.SetColor(const Value: TAlphaColor);
begin
  FColor := Value;
  FLeftLine.Color := Value;
  FTopLine.Color := Value;
  FRightLine.Color := Value;
  FBottomLine.Color := Value;
end;

procedure TfrxFrame.SetStyle(const Value: TfrxFrameStyle);
begin
  FStyle := Value;
  FLeftLine.Style := Value;
  FTopLine.Style := Value;
  FRightLine.Style := Value;
  FBottomLine.Style := Value;
end;

procedure TfrxFrame.SetWidth(const Value: Double);
begin
  FWidth := Value;
  FLeftLine.Width := Value;
  FTopLine.Width := Value;
  FRightLine.Width := Value;
  FBottomLine.Width := Value;
end;

function TfrxFrame.Diff(AFrame: TfrxFrame): String;
var
  i: Integer;
  ColorChanged, StyleChanged, WidthChanged: Boolean;
begin
  Result := '';

  ColorChanged := FColor <> AFrame.Color;
  if ColorChanged then
    Result := Result + ' Frame.Color="' + IntToStr(Integer(FColor)) + '"';
  if FDropShadow <> AFrame.DropShadow then
    Result := Result + ' Frame.DropShadow="' + frxValueToXML(FDropShadow) + '"';
  if FShadowColor <> AFrame.ShadowColor then
    Result := Result + ' Frame.ShadowColor="' + IntToStr(Integer(FShadowColor)) + '"';
  if FloatDiff(FShadowWidth, AFrame.ShadowWidth) then
    Result := Result + ' Frame.ShadowWidth="' + FloatToStr(FShadowWidth) + '"';
  StyleChanged := FStyle <> AFrame.Style;
  if StyleChanged then
    Result := Result + ' Frame.Style="' + frxValueToXML(FStyle) + '"';
  if FTyp <> AFrame.Typ then
  begin
    i := 0;
    if ftLeft in FTyp then i := i or 1;
    if ftRight in FTyp then i := i or 2;
    if ftTop in FTyp then i := i or 4;
    if ftBottom in FTyp then i := i or 8;
    Result := Result + ' Frame.Typ="' + IntToStr(i) + '"';
  end;
  WidthChanged := FloatDiff(FWidth, AFrame.Width);
  if WidthChanged then
    Result := Result + ' Frame.Width="' + FloatToStr(FWidth) + '"';

  Result := Result + FLeftLine.Diff(AFrame.LeftLine, 'Frame.LeftLine',
    ColorChanged, StyleChanged, WidthChanged);
  Result := Result + FTopLine.Diff(AFrame.TopLine, 'Frame.TopLine',
    ColorChanged, StyleChanged, WidthChanged);
  Result := Result + FRightLine.Diff(AFrame.RightLine, 'Frame.RightLine',
    ColorChanged, StyleChanged, WidthChanged);
  Result := Result + FBottomLine.Diff(AFrame.BottomLine, 'Frame.BottomLine',
    ColorChanged, StyleChanged, WidthChanged);
end;


{ TfrxView }

constructor TfrxView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  frComponentStyle := frComponentStyle + [csDefaultDiff];
  FAlign := baNone;
  FColor := claNull;
  FFrame := TfrxFrame.Create;
  FShiftMode := smAlways;
  FPrintable := True;
  FPlainText := False;
end;

destructor TfrxView.Destroy;
begin
  FFrame.Free;
  inherited;
end;

procedure TfrxView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FDataSet) then
    FDataSet := nil;
end;

procedure TfrxView.SetDataSet(const Value: TfrxDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
end;

procedure TfrxView.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  FDataSet := FindDataSet(FDataSet, FDataSetName);
end;

function TfrxView.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;

procedure TfrxView.SetFrame(const Value: TfrxFrame);
begin
  FFrame.Assign(Value);
end;

procedure TfrxView.BeginDraw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
  FCanvas := Canvas;
  FScaleX := ScaleX;
  FScaleY := ScaleY;
  FOffsetX := OffsetX;
  FOffsetY := OffsetY;
  FX := Round(AbsLeft * ScaleX + OffsetX);
  FY := Round(AbsTop * ScaleY + OffsetY);
  FX1 := Round((AbsLeft + Width) * ScaleX + OffsetX);
  FY1 := Round((AbsTop + Height) * ScaleY + OffsetY);

  if Frame.DropShadow then
  begin
    FX1 := FX1 - Round(Frame.ShadowWidth * ScaleX);
    FY1 := FY1 - Round(Frame.ShadowWidth * ScaleY);
  end;

  FDX := FX1 - FX;
  FDY := FY1 - FY;
  FFrameWidth := Frame.Width * ScaleX;
end;

procedure TfrxView.DrawBackground;
begin
  with FCanvas do
  begin
    if FColor <> claNull then
    begin
      Fill.Color := FColor;
      Fill.Kind := TBrushKind.bkSolid;
      FillRect(RectF(FX, FY, FX1, FY1), 0, 0, allCorners, 1);
    end;
  end;
end;

procedure TfrxView.DrawFrame;
var
  d: Integer;
  add, add1: Extended;

  procedure Line(x, y, x1, y1: Extended; Line: TfrxFrameLine; Typ: TfrxFrameType; gap1, gap2: Boolean);
  var
    g1, g2, g3, g4, fw: Integer;

    procedure Line1(x, y, x1, y1: Extended);
    begin
      FCanvas.DrawLine(PointF(x, y), PointF(x1, y1), 1);
    end;

  begin
    if Frame.Style <> fsDouble then
      Line1(x, y, x1, y1)
    else //if Frame.Style = fsDouble then
    begin
      fw := Round(Line.Width * FScaleX);
      if gap1 then g1 := 0 else g1 := 1;
      if gap2 then g2 := 0 else g2 := 1;

      if Typ in [ftTop, ftBottom] then
      begin
        x := x + (fw * g1 div 2);
        x1 := x1 - (fw * g2 div 2);
      end
      else
      begin
        y := y + (fw * g1 div 2);
        y1 := y1 - (fw * g2 div 2);
      end;

      if gap1 then
        g1 := fw else
        g1 := 0;
      if gap2 then
        g2 := fw else
        g2 := 0;
      g3 := -g1;
      g4 := -g2;

      if Typ in [ftLeft, ftTop] then
      begin
        g1 := -g1;
        g2 := -g2;
        g3 := -g3;
        g4 := -g4;
      end;

      if x = x1 then
        Line1(x - fw, y + g1, x1 - fw, y1 - g2) else
        Line1(x + g1, y - fw, x1 - g2, y1 - fw);
      if Color <> claNull then
      begin
        FCanvas.Stroke.Color := Color;
        Line1(x, y, x1, y1);
      end;
      FCanvas.Stroke.Color := Line.Color;
      if x = x1 then
        Line1(x + fw, y + g3, x1 + fw, y1 - g4) else
        Line1(x + g3, y + fw, x1 - g4, y1 + fw);
    end
  end;

  procedure SetPen(Line: TfrxFrameLine);
  begin
    with FCanvas do
    begin
      Stroke.Color := Line.Color;
      if Line.Style in [fsSolid, fsDouble] then
      begin
        StrokeThickness := Round(Line.Width * FScaleX);
        StrokeDash := TStrokeDash.sdSolid
      end
      else
      begin
        StrokeThickness := 1;
        StrokeDash := TStrokeDash(Frame.Style);
      end;
    end;
  end;

begin
  with FCanvas do
  begin
    Stroke.Kind := TBrushKind.bkSolid;

    if Frame.DropShadow then
    begin
      Stroke.Color := Frame.ShadowColor;
      StrokeDash := TStrokeDash.sdSolid;
      d := Round(Frame.ShadowWidth * FScaleX);
      StrokeThickness := d;
      DrawLine(PointF(FX1 + d div 2, FY + d), PointF(FX1 + d div 2, FY1), 1);
      d := Round(Frame.ShadowWidth * FScaleY);
      StrokeThickness := d;
      DrawLine(PointF(FX + d, FY1 + d div 2), PointF(FX1 + d, FY1 + d div 2), 1);
    end;

    if (Frame.Typ <> []) and (Frame.Color <> claNull) and (Frame.Width <> 0) then
    begin
      if ftLeft in Frame.Typ then
      begin
        SetPen(FFrame.LeftLine);
        add := Trunc(StrokeThickness / 2);
        add1 := 0;
        if (Trunc(StrokeThickness) mod 2) = 1 then
          add1 := 0.5;
        Line(FX + add1, FY + add1 - add, FX + add1, FY1 + add1 + add, FFrame.LeftLine, ftLeft, ftTop in Frame.Typ, ftBottom in Frame.Typ);
      end;
      if ftRight in Frame.Typ then
      begin
        SetPen(FFrame.RightLine);
        add := Trunc(StrokeThickness / 2);
        add1 := 0;
        if (Trunc(StrokeThickness) mod 2) = 1 then
          add1 := 0.5;
        Line(FX1 + add1, FY + add1 - add, FX1 + add1, FY1 + add1 + add, FFrame.RightLine, ftRight, ftTop in Frame.Typ, ftBottom in Frame.Typ);
      end;
      if ftTop in Frame.Typ then
      begin
        SetPen(FFrame.TopLine);
        add := Trunc(StrokeThickness / 2);
        add1 := 0;
        if (Trunc(StrokeThickness) mod 2) = 1 then
          add1 := 0.5;
        Line(FX + add1 - add, FY + add1, FX1 + add1 + add, FY + add1, FFrame.TopLine, ftTop, ftLeft in Frame.Typ, ftRight in Frame.Typ);
      end;
      if ftBottom in Frame.Typ then
      begin
        SetPen(FFrame.BottomLine);
        add := Trunc(StrokeThickness / 2);
        add1 := 0;
        if (Trunc(StrokeThickness) mod 2) = 1 then
          add1 := 0.5;
        Line(FX + add1 - add, FY1 + add1, FX1 + add1 + add, FY1 + add1, FFrame.BottomLine, ftBottom, ftLeft in Frame.Typ, ftRight in Frame.Typ);
      end;
    end;
  end;
end;

procedure TfrxView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  DrawBackground;
  DrawFrame;
end;

function TfrxView.Diff(AComponent: TfrxComponent): String;
var
  v: TfrxView;
begin
  Result := inherited Diff(AComponent);
  v := TfrxView(AComponent);

  if FAlign <> v.FAlign then
    Result := Result + ' Align="' + frxValueToXML(FAlign) + '"';
  if FColor <> v.FColor then
    Result := Result + ' Color="' + IntToStr(Integer(FColor)) + '"';
  Result := Result + FFrame.Diff(v.FFrame);
  if Cursor <> v.Cursor then
    Result := Result + ' Cursor="' + frxValueToXML(Cursor) + '"';
  if FPrintable <> v.FPrintable then
    Result := Result + ' Printable="' + frxValueToXML(FPrintable) + '"';
  if TagStr <> v.TagStr then
    Result := Result + ' TagStr="' + frxStrToXML(TagStr) + '"';
  if URL <> v.URL then
    Result := Result + ' URL="' + frxStrToXML(URL) + '"';
  if FHint <> v.Hint then
    Result := Result + ' Hint="' + frxStrToXML(FHint) + '"';
end;

function TfrxView.IsDataField: Boolean;
begin
  Result := (DataSet <> nil) and (Length(DataField) <> 0);
end;

procedure TfrxView.BeforePrint;
begin
  inherited;
  FTempTag := FTagStr;
  FTempURL := FURL;
  if Report <> nil then
  begin
    Report.SelfValue := Self;
  end;
end;

procedure TfrxView.ExpandVariables(var Expr: String);
var
  i, j: Integer;
  s: String;
begin
  i := 1;
  repeat
    while i < Length(Expr) do
{      if isDBCSLeadByte(Byte(Expr[i])) then  // if DBCS then skip 2 bytes
        Inc(i, 2)
      else }
      if (Expr[i] <> '[') then
        Inc(i)
      else
        break;
    s := frxGetBrackedVariableW(Expr, '[', ']', i, j);
    if i <> j then
    begin
      Delete(Expr, i, j - i + 1);
      s := VarToStr(Report.Calc(s));
      Insert(s, Expr, i);
      Inc(i, Length(s));
      j := 0;
    end;
  until i = j;
end;

procedure TfrxView.GetData;
begin
  if (FTagStr <> '') and (Pos('[', FTagStr) <> 0) then
    ExpandVariables(FTagStr);
  if (FURL <> '') and (Pos('[', FURL) <> 0) then
    ExpandVariables(FURL);
end;

procedure TfrxView.AfterPrint;
begin
  inherited;
  FTagStr := FTempTag;
  FURL := FTempURL;
end;


{ TfrxShapeView }

constructor TfrxShapeView.Create(AOwner: TComponent);
begin
  inherited;
  frComponentStyle := frComponentStyle - [csDefaultDiff];
end;

constructor TfrxShapeView.DesignCreate(AOwner: TComponent; Flags: Word);
begin
  inherited;
  FShape := TfrxShapeKind(Flags);
end;

procedure TfrxShapeView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  min: Integer;
  poly: TPolygon;
begin
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);

  with Canvas do
  begin
    Stroke.Kind := TBrushKind.bkSolid;
    Stroke.Color := Frame.Color;
    StrokeThickness := FFrameWidth;
    StrokeDash := TStrokeDash(Frame.Style);

    Fill.Kind := TBrushKind.bkSolid;
    Fill.Color := FColor;

    case FShape of
      skRectangle:
        begin
          FillRect(RectF(FX, FY, FX1 + 1, FY1 + 1), 0, 0, allCorners, 1);
          DrawRect(RectF(FX, FY, FX1 + 1, FY1 + 1), 0, 0, allCorners, 1);
        end;

      skRoundRectangle:
        begin
          if FDY < FDX then
            min := FDY else
            min := FDX;
          if FCurve = 0 then
            min := min div 4
          else
            min := Round(FCurve * FScaleX * 10);
          FillRect(RectF(FX, FY, FX1 + 1, FY1 + 1), min, min, allCorners, 1);
          DrawRect(RectF(FX, FY, FX1 + 1, FY1 + 1), min, min, allCorners, 1);
        end;

      skEllipse:
        begin
          FillEllipse(RectF(FX, FY, FX1 + 1, FY1 + 1), 1);
          DrawEllipse(RectF(FX, FY, FX1 + 1, FY1 + 1), 1);
        end;

      skTriangle:
        begin
          SetLength(poly, 4);
          poly[0] := PointF(FX1, FY1);
          poly[1] := PointF(FX, FY1);
          poly[2] := PointF(FX + FDX div 2, FY);
          poly[3] := PointF(FX1, FY1);
          FillPolygon(poly, 1);
          DrawPolygon(poly, 1);
        end;

      skDiamond:
        begin
          SetLength(poly, 4);
          poly[0] := PointF(FX + FDX div 2, FY);
          poly[1] := PointF(FX1, FY + FDY div 2);
          poly[2] := PointF(FX + FDX div 2, FY1);
          poly[3] := PointF(FX, FY + FDY div 2);
          FillPolygon(poly, 1);
          DrawPolygon(poly, 1);
        end;

      skDiagonal1:
        DrawLine(PointF(FX, FY1), PointF(FX1, FY), 1);

      skDiagonal2:
        DrawLine(PointF(FX, FY), PointF(FX1, FY1), 1);
    end;
  end;
end;

function TfrxShapeView.Diff(AComponent: TfrxComponent): String;
begin
  Result := inherited Diff(AComponent);

  if FShape <> TfrxShapeView(AComponent).FShape then
    Result := Result + ' Shape="' + frxValueToXML(FShape) + '"';
end;

class function TfrxShapeView.GetDescription: String;
begin
  Result := frxResources.Get('obShape');
end;


{ TfrxHighlight }

constructor TfrxHighlight.Create;
begin
  FColor := claNull;
  FFont := TfrxFont.Create;
  with FFont do
  begin
    Name := DefFontName;
    Size := DefFontSize;
    Color := claRed;
  end;
end;

destructor TfrxHighlight.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TfrxHighlight.Assign(Source: TPersistent);
begin
  if Source is TfrxHighlight then
  begin
    FFont.Assign(TfrxHighlight(Source).Font);
    FColor := TfrxHighlight(Source).Color;
    FCondition := TfrxHighlight(Source).Condition;
  end;
end;

procedure TfrxHighlight.SetFont(const Value: TfrxFont);
begin
  FFont.Assign(Value);
end;


{ TfrxFormat }

procedure TfrxFormat.Assign(Source: TPersistent);
begin
  if Source is TfrxFormat then
  begin
    FDecimalSeparator := TfrxFormat(Source).DecimalSeparator;
    FThousandSeparator := TfrxFormat(Source).ThousandSeparator;
    FFormatStr := TfrxFormat(Source).FormatStr;
    FKind := TfrxFormat(Source).Kind;
  end;
end;


{ TfrxStretcheable }

constructor TfrxStretcheable.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStretchMode := smDontStretch;
end;

function TfrxStretcheable.CalcHeight: Double;
begin
  Result := Height;
end;

function TfrxStretcheable.DrawPart: Double;
begin
  Result := 0;
end;

procedure TfrxStretcheable.InitPart;
begin
//
end;

function TfrxStretcheable.HasNextDataPart: Boolean;
begin
  Result := False;
end;


{ TfrxCustomMemoView }

constructor TfrxCustomMemoView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  frComponentStyle := frComponentStyle - [csDefaultDiff];
  FHighlight := TfrxHighlight.Create;
  FDisplayFormat := TfrxFormat.Create;
  FMemo := TfrxWideStrings.Create;
  FBmpCanvas := TBitmap.Create(1,1);
  FAllowExpressions := True;
  FClipped := True;
  FExpressionDelimiters := '[,]';
  FGapX := 2;
  FGapY := 1;
  FHAlign := haLeft;
  FVAlign := vaTop;
  FLineSpacing := 2;
  ParentFont := True;
  FWordWrap := True;
  FWysiwyg := True;
  FLastValue := Null;
  FTextRenderer := nil;
end;

destructor TfrxCustomMemoView.Destroy;
begin
  FHighlight.Free;
  FDisplayFormat.Free;
  FMemo.Free;
  FBmpCanvas.Free;
  inherited;
end;

class function TfrxCustomMemoView.GetDescription: String;
begin
  Result := frxResources.Get('obText');
end;

procedure TfrxCustomMemoView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FFlowTo) then
    FFlowTo := nil;
end;

function TfrxCustomMemoView.IsExprDelimitersStored: Boolean;
begin
  Result := FExpressionDelimiters <> '[,]';
end;

function TfrxCustomMemoView.IsLineSpacingStored: Boolean;
begin
  Result := FLineSpacing <> 2;
end;

function TfrxCustomMemoView.IsGapXStored: Boolean;
begin
  Result := FGapX <> 2;
end;

function TfrxCustomMemoView.IsGapYStored: Boolean;
begin
  Result := FGapY <> 1;
end;

function TfrxCustomMemoView.IsParagraphGapStored: Boolean;
begin
  Result := FParagraphGap <> 0;
end;

function TfrxCustomMemoView.IsAdvancedRendererNeeded: Boolean;
begin
  Result := (FHAlign = haBlock) or FAllowHTMLTags or (FLineSpacing <> 2);// or FWysiwyg;
end;

function TfrxCustomMemoView.IsCharSpacingStored: Boolean;
begin
  Result := FCharSpacing <> 0;
end;

function TfrxCustomMemoView.IsHighlightStored: Boolean;
begin
  Result := Trim(FHighlight.Condition) <> '';
end;

procedure TfrxCustomMemoView.SetRotation(Value: Integer);
begin
  FRotation := Value mod 360;
end;

procedure TfrxCustomMemoView.SetText(const Value: WideString);
begin
  FMemo.Text := Value;
end;

function TfrxCustomMemoView.GetText: WideString;
begin
  Result := FMemo.Text;
end;

procedure TfrxCustomMemoView.SetMemo(const Value: TWideStrings);
begin
  FMemo.Assign(Value);
end;

procedure TfrxCustomMemoView.SetHighlight(const Value: TfrxHighlight);
begin
  FHighlight.Assign(Value);
end;

procedure TfrxCustomMemoView.SetAllowHTMLTags(const Value: Boolean);
begin
  FAllowHTMLTags := Value;
end;

procedure TfrxCustomMemoView.SetDisplayFormat(const Value: TfrxFormat);
begin
  FDisplayFormat.Assign(Value);
end;

procedure TfrxCustomMemoView.SetStyle(const Value: String);
begin
  FStyle := Value;
  if Report <> nil then
    ApplyStyle(Report.Styles.Find(FStyle));
end;

function TfrxCustomMemoView.AdjustCalcHeight: Double;
begin
  Result := GapY * 2;
  if ftTop in Frame.Typ then
    Result := Result + (Frame.Width - 1) / 2;
  if ftBottom in Frame.Typ then
    Result := Result + Frame.Width / 2;
  if Frame.DropShadow then
    Result := Result + Frame.ShadowWidth;
end;

function TfrxCustomMemoView.AdjustCalcWidth: Double;
begin
  Result := GapX * 2;
  if ftLeft in Frame.Typ then
    Result := Result + (Frame.Width) / 2;
  if ftRight in Frame.Typ then
    Result := Result + Frame.Width / 2;
  if Frame.DropShadow then
    Result := Result + Frame.ShadowWidth;
end;

procedure TfrxCustomMemoView.BeginDraw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  bx, by, bx1, by1, wx1, wx2, wy1, wy2, gx1, gy1: Single;
begin
  inherited BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);

  wx1 := (Frame.Width * ScaleX - 1) / 2;
  wx2 := Frame.Width * ScaleX / 2;
  wy1 := (Frame.Width * ScaleY - 1) / 2;
  wy2 := Frame.Width * ScaleY / 2;

  bx := FX;
  by := FY;
  bx1 := FX1;
  by1 := FY1;
  if ftLeft in Frame.Typ then
    bx := bx + wx1;
  if ftRight in Frame.Typ then
    bx1 := bx1 + wx2;
  if ftTop in Frame.Typ then
    by := by + wy1;
  if ftBottom in Frame.Typ then
    by1 := by1 + wy2;
  gx1 := GapX * ScaleX;
  gy1 := GapY * ScaleY;

  FTextRect := RectF(bx + gx1, by + gy1, bx1 - gx1 + 1, by1 - gy1 + 1);
end;

function NormalizeText(const aText: String): String;
begin
  Result := ReplaceStr(aText, #13#10, System.sLineBreak);
  if EndsText(sLineBreak, aText) then
    Delete(Result, Length(Result) - Length(sLineBreak) + 1, Length(sLineBreak));
end;

procedure TfrxCustomMemoView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  TextRenderer: TAdvancedTextRenderer;
  SaveColor: TAlphaColor;
  aFont: TfrxFont;
  aText: String;
  h, oldh, Sh, ALineHeight: Single;
  state: TCanvasSaveState;
  m, OldM: TMatrix;
  e: Single;

  procedure DrawUnderlines;
  var
    dy: Extended;
  begin
    with Canvas do
    begin
      Stroke.Color := Frame.Color;
      Stroke.Kind := TBrushKind.bkSolid;
    end;

    //h := TextRenderer.LineHeight;
    dy := FY + ALineHeight + (GapY - LineSpacing + 1) * ScaleY;
    while dy < FY1 do
    begin
    Canvas.DrawLine(PointF(FX, Round(dy)), PointF(FX1, Round(dy)), 1);
      dy := dy + ALineHeight;
    end;
  end;

begin
  SaveColor := FColor;
  ALineHeight := 0;
  if FHighlight.Active then
  begin
    aFont := FHighlight.Font;
    FColor := FHighlight.Color;
  end
  else
  begin
    aFont := FFont;
  end;

  inherited Draw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  if not IsDesigning then
    ExtractMacros
  else if IsDataField then
    FMemo.Text := '[' + DataSet.UserName + '."' + DataField + '"]';
{$IFNDEF MSWINDOWS}
  //if IsPrinting then
   // FFont.PixelsPerInch := 96 * 1.5;
{$ENDIF}

  aText := NormalizeText(FMemo.Text);
  sh := aFont.Height;
  h := aFont.Height * FScaleY;
  oldh := aFont.Height;
{$IFNDEF DELPHI17}
{$IFDEF MSWINDOWS}
  if not IsPrinting then
{$ENDIF}
{$ENDIF}
  aFont.Height := h;
  ALineHeight := -h + FLineSpacing * FScaleY;
  if IsAdvancedRendererNeeded then
  begin
    TextRenderer := TAdvancedTextRenderer.Create(Canvas, aText, aFont, FTextRect, FHAlign, FVAlign, ALineHeight, FRotation, FWordWrap, false, FAllowHTMLTags, false);
    try
      if FUnderlines and (FRotation = 0) then
        DrawUnderlines;
{$IFDEF DELPHI17}
{$IFDEF MSWINDOWS}
      if IsPrinting then
          aFont.Height := oldh;
{$ENDIF}
{$ENDIF}
      TextRenderer.Draw();
    finally
      TextRenderer.Free;
    end;
  end
  else
  begin
    OldM := Canvas.Matrix;
    State := Canvas.SaveState;

    try
      if FUnderlines and (FRotation = 0) then
        DrawUnderlines;
      Canvas.IntersectClipRect(FTextRect);

      if FRotation <> 0 then
      begin
        m := CreateRotationMatrix(-DegToRad(FRotation));
        m.m31 := OldM.m31 + FTextRect.Left + FTextRect.Width / 2;
        m.m32 := OldM.m32 + FTextRect.Top + FTextRect.Height / 2;
        Canvas.SetMatrix(m);

        e := FTextRect.Width;
        FTextRect.Left := -FTextRect.Width / 2;
        FTextRect.Right := FTextRect.Left + e;
        e := FTextRect.Height;
        FTextRect.Top := -FTextRect.Height / 2;
        FTextRect.Bottom := FTextRect.Top + e;

        // rotate rect if angle is 90 or 270
        if ((FRotation >= 90) and (FRotation < 180)) or ((FRotation >= 270) and (FRotation < 360)) then
          FTextRect := RectF(FTextRect.Top, FTextRect.Left, FTextRect.Bottom, FTextRect.Right);
      end;
{$IFNDEF DELPHI24}
{$IFDEF DELPHI17}
{$IFDEF MSWINDOWS}
  if IsPrinting then
    aFont.Height := oldh;
{$ENDIF}
{$ENDIF}
{$ENDIF}
      aFont.AssignToCanvas(Canvas);
      Canvas.FillText(FTextRect, aText, FWordWrap, 1, [], frxHAlignToTextAlign(FHAlign), frxVAlignToTextAlign(FVAlign));
    finally
      Canvas.RestoreState(state);
      Canvas.SetMatrix(OldM);
    end;
  end;
{$IFNDEF MSWINDOWS}
  if IsPrinting then
    aFont.PixelsPerInch := 96;
{$ENDIF}
  aFont.Height := sh;
  FColor := SaveColor;
end;

function TfrxCustomMemoView.CalcHeight: Double;
var
  TextRenderer: TAdvancedTextRenderer;
  r: TRectF;
  aText: String;
  aFont: TfrxFont;
  ALineHeight: Single;
begin
  Result := 0;
  aText := NormalizeText(FMemo.Text);
  if aText = '' then
    Exit;

  if FHighlight.Active then
    aFont := FHighlight.Font
  else
    aFont := FFont;

  BeginDraw(FBmpCanvas.Canvas, 1, 1, 0, 0);
  r := RectF(0, 0, FTextRect.Width, 10000);
  if IsAdvancedRendererNeeded then
  begin
    ALineHeight := -aFont.Height + FLineSpacing;
    TextRenderer := TAdvancedTextRenderer.Create(FBmpCanvas.Canvas, aText, aFont, r, FHAlign, FVAlign, ALineHeight, FRotation, FWordWrap, false, FAllowHTMLTags, false);
    try
      Result := TextRenderer.CalcHeight() + 4 + AdjustCalcHeight;
    finally
      TextRenderer.Free;
    end;
  end
  else
  begin
    aFont.AssignToCanvas(FBmpCanvas.Canvas);
    FBmpCanvas.Canvas.MeasureText(r, aText, FWordWrap, [], frxHAlignToTextAlign(FHAlign), frxVAlignToTextAlign(FVAlign));
    Result := r.Height + 4 + AdjustCalcHeight;
  end;
end;

function TfrxCustomMemoView.CalcWidth: Double;
var
  TextRenderer: TAdvancedTextRenderer;
  r: TRectF;
  aFont: TfrxFont;
  aText: String;
begin
  Result := 0;
  aText := NormalizeText(FMemo.Text);
  if aText = '' then
    Exit;

  if FHighlight.Active then
    aFont := FHighlight.Font
  else
    aFont := FFont;

  BeginDraw(FBmpCanvas.Canvas, 1, 1, 0, 0);
  r := RectF(0, 0, 10000, 10000);
  if IsAdvancedRendererNeeded then
  begin
    TextRenderer := TAdvancedTextRenderer.Create(FBmpCanvas.Canvas, aText, aFont, r, FHAlign, FVAlign, 0, FRotation, FWordWrap, false, FAllowHTMLTags, false);
    try
      Result := TextRenderer.CalcWidth() + 4 + AdjustCalcWidth;
    finally
      TextRenderer.Free;
    end;
  end
  else
  begin
    aFont.AssignToCanvas(FBmpCanvas.Canvas);
    FBmpCanvas.Canvas.MeasureText(r, aText, FWordWrap, [], frxHAlignToTextAlign(FHAlign), frxVAlignToTextAlign(FVAlign));
    Result := r.Width + 12 + AdjustCalcWidth;
  end;
end;

procedure TfrxCustomMemoView.InitPart;
begin
  FPartMemo := FMemo.Text;
  FFirstParaBreak := False;
  FLastParaBreak := False;
end;

function TfrxCustomMemoView.DrawPart: Double;
var
  TextRenderer: TAdvancedTextRenderer;
  charsFit: Integer;
  style: TStyleDescriptor;
  aFont: TfrxFont;
begin
  Result := 0;
  if FHighlight.Active then
    aFont := FHighlight.Font
  else
    aFont := FFont;

  BeginDraw(FBmpCanvas.Canvas, 1, 1, 0, 0);
  TextRenderer := TAdvancedTextRenderer.Create(FBmpCanvas.Canvas, FPartMemo, aFont, FTextRect, FHAlign, FVAlign, -aFont.Height + FLineSpacing, FRotation, FWordWrap, false, FAllowHTMLTags, false);
   try
    Result := TextRenderer.CalcHeight(charsFit, style);
    if charsFit > 0 then
      if(FPartMemo[charsFit]) <> #$0A then
        charsFit :=  charsFit - 1;
    FMemo.Text := Copy(FPartMemo, 1, charsFit);
    Delete(FPartMemo, 1, charsFit);
    if Result = 0 then
      Result := Height
    else
      Result := Result + GapY *2;
  finally
    TextRenderer.Free;
  end;
end;

function TfrxCustomMemoView.Diff(AComponent: TfrxComponent): String;
var
  m: TfrxCustomMemoView;
  s: WideString;
  c: Integer;
begin
  Result := inherited Diff(AComponent);
  m := TfrxCustomMemoView(AComponent);

  if FAutoWidth <> m.FAutoWidth then
    Result := Result + ' AutoWidth="' + frxValueToXML(FAutoWidth) + '"';
  if FloatDiff(FCharSpacing, m.FCharSpacing) then
    Result := Result + ' CharSpacing="' + FloatToStr(FCharSpacing) + '"';
  if FloatDiff(FGapX, m.FGapX) then
    Result := Result + ' GapX="' + FloatToStr(FGapX) + '"';
  if FloatDiff(FGapY, m.FGapY) then
    Result := Result + ' GapY="' + FloatToStr(FGapY) + '"';
  if FHAlign <> m.FHAlign then
    Result := Result + ' HAlign="' + frxValueToXML(FHAlign) + '"';
  if FHighlight.Active <> m.FHighlight.Active then
    Result := Result + ' Highlight.Active="' + frxValueToXML(FHighlight.Active) + '"';
  if FloatDiff(FLineSpacing, m.FLineSpacing) then
    Result := Result + ' LineSpacing="' + FloatToStr(FLineSpacing) + '"';

  c := FMemo.Count;
  if c = 0 then
    Result := Result + ' u=""'
  else
  begin
    if c = 1 then
      Result := Result + ' u="' + frxStrToXML(FMemo[0]) + '"'
    else
    begin
      s := Text;
      SetLength(s, Length(s) - 2);
      Result := Result + ' u="' + frxStrToXML(s) + '"';
    end;
  end;

  if FloatDiff(FParagraphGap, m.FParagraphGap) then
    Result := Result + ' ParagraphGap="' + FloatToStr(FParagraphGap) + '"';
  if FRotation <> m.FRotation then
    Result := Result + ' Rotation="' + IntToStr(FRotation) + '"';
  if FRTLReading <> m.FRTLReading then
    Result := Result + ' RTLReading="' + frxValueToXML(FRTLReading) + '"';
  if FUnderlines <> m.FUnderlines then
    Result := Result + ' Underlines="' + frxValueToXML(FUnderlines) + '"';
  if FVAlign <> m.FVAlign then
    Result := Result + ' VAlign="' + frxValueToXML(FVAlign) + '"';
  if FWordWrap <> m.FWordWrap then
    Result := Result + ' WordWrap="' + frxValueToXML(FWordWrap) + '"';

  { formatting }
  if FDisplayFormat.FKind <> m.FDisplayFormat.FKind then
    Result := Result + ' DisplayFormat.Kind="' + frxValueToXML(FDisplayFormat.FKind) + '"';
  if FDisplayFormat.FDecimalSeparator <> m.FDisplayFormat.FDecimalSeparator then
    Result := Result + ' DisplayFormat.DecimalSeparator="' + frxStrToXML(FDisplayFormat.FDecimalSeparator) + '"';
  if FDisplayFormat.FThousandSeparator <> m.FDisplayFormat.FThousandSeparator then
    Result := Result + ' DisplayFormat.ThousandSeparator="' + frxStrToXML(FDisplayFormat.FThousandSeparator) + '"';
  if FDisplayFormat.FFormatStr <> m.FDisplayFormat.FFormatStr then
    Result := Result + ' DisplayFormat.FormatStr="' + frxStrToXML(FDisplayFormat.FFormatStr) + '"';

  if FFirstParaBreak then
    Result := Result + ' FirstParaBreak="1"';
  if FLastParaBreak then
    Result := Result + ' LastParaBreak="1"';

  FFirstParaBreak := FLastParaBreak;
  FLastParaBreak := False;
end;

procedure TfrxCustomMemoView.BeforePrint;
begin
  inherited;
  if not IsDataField then
    FTempMemo := FMemo.Text;
end;

procedure TfrxCustomMemoView.AfterPrint;
begin
  if not IsDataField then
    FMemo.Text := FTempMemo;
  inherited;
end;

procedure TfrxCustomMemoView.GetData;
var
  i, j: Integer;
  s, s1, s2, dc1, dc2: WideString;
begin
  inherited;
  if IsDataField then
  begin
    if DataSet.IsBlobField(DataField) then
    begin
      DataSet.AssignBlobTo(DataField, FMemo);
    end
    else
    begin
      FValue := DataSet.Value[DataField];
      if FDisplayFormat.Kind = fkText then
        FMemo.Text := DataSet.DisplayText[DataField]
      else
        FMemo.Text := FormatData(FValue);
      if FHideZeros and (TVarData(FValue).VType <> varString) and
        (TVarData(FValue).VType <> varUString) and
        (TVarData(FValue).VType <> varOleStr) and (FValue = 0) then
        FMemo.Text := '';
    end;
  end
  else if AllowExpressions then
  begin
    s := FMemo.Text;
    i := 1;
    dc1 := FExpressionDelimiters;
    dc2 := Copy(dc1, Pos(',', dc1) + 1, 255);
    dc1 := Copy(dc1, 1, Pos(',', dc1) - 1);

    if Pos(dc1, s) <> 0 then
    begin
      repeat
        while (i < Length(s)) and (Copy(s, i, Length(dc1)) <> dc1) do Inc(i);

        s1 := frxGetBrackedVariableW(s, dc1, dc2, i, j);
        if i <> j then
        begin
          Delete(s, i, j - i + 1);
          s2 := CalcAndFormat(s1);
          Insert(s2, s, i);
          Inc(i, Length(s2));
          j := 0;
        end;
      until i = j;

      FMemo.Text := s;
    end;
  end;

  Report.LocalValue := FValue;
  FHighlight.Active := False;
  if FHighlight.Condition <> '' then
    FHighlight.Active := Report.Calc(FHighlight.Condition);

  if FSuppressRepeated then
  begin
    if FLastValue = FMemo.Text then
      FMemo.Text := '' else
      FLastValue := FMemo.Text;
  end;

  if FFlowTo <> nil then
  begin
    InitPart;
    DrawPart;
    FFlowTo.Text := FPartMemo;
    FFlowTo.AllowExpressions := False;
  end;
end;

procedure TfrxCustomMemoView.ResetSuppress;
begin
  FLastValue := '';
end;

function TfrxCustomMemoView.CalcAndFormat(const Expr: WideString): WideString;
var
  i: Integer;
  ExprStr, FormatStr: WideString;
  Format: TfrxFormat;
begin
  Result := '';
  Format := nil;
  i := Pos(WideString(' #'), Expr);
  if i <> 0 then
  begin
    ExprStr := Copy(Expr, 1, i - 1);
    FormatStr := Copy(Expr, i + 2, Length(Expr) - i - 1);
    if Pos(')', FormatStr) = 0 then
    begin
      Format := TfrxFormat.Create;

      if CharInSet(FormatStr[1], [WideChar('N'), WideChar('n')]) then
      begin
        Format.Kind := fkNumeric;
        for i := 1 to Length(FormatStr) do
          if CharInSet(FormatStr[i], [WideChar(','), WideChar('.'), WideChar('-')]) then
          begin
            Format.DecimalSeparator := FormatStr[i];
            FormatStr[i] := '.';
          end;
      end
      else if  CharInSet(FormatStr[1], [WideChar('D'), WideChar('T'), WideChar('d'), WideChar('t')]) then
        Format.Kind := fkDateTime
      else if CharInSet(FormatStr[1], [WideChar('B'), WideChar('b')]) then
        Format.Kind := fkBoolean;

      Format.FormatStr := Copy(FormatStr, 2, 255);
    end
    else
      ExprStr := Expr;
  end
  else
    ExprStr := Expr;

  try
    if CompareText(ExprStr, 'TOTALPAGES#') = 0 then
      FValue := '[TotalPages#]'
    else if CompareText(ExprStr, 'COPYNAME#') = 0 then
      FValue := '[CopyName#]'
    else
      FValue := Report.Calc(ExprStr);
    if FHideZeros and (TVarData(FValue).VType <> varString) and
      (TVarData(FValue).VType <> varOleStr) and 
      (TVarData(FValue).VType <> varUString) and 
      (FValue = 0) then
      Result := '' 
    else
      Result := FormatData(FValue, Format);
  finally
    if Format <> nil then
      Format.Free;
  end;
end;

function TfrxCustomMemoView.FormatData(const Value: Variant;
  AFormat: TfrxFormat = nil): WideString;
var
  i, DecSepPos: Integer;
begin
  DecSepPos := 0;
  if AFormat = nil then
    AFormat := FDisplayFormat;
  if VarIsNull(Value) then
    Result := ''
  else if AFormat.Kind = fkText then
    Result := VarToWideStr(Value)
  else
  try
    case AFormat.Kind of
      fkNumeric:
        begin
          if (Pos('#', AFormat.FormatStr) <> 0) or (Pos('0', AFormat.FormatStr) = 1) then
            Result := FormatFloat(AFormat.FormatStr, Extended(Value))
          else if (Pos('d', AFormat.FormatStr) <> 0) or (Pos('u', AFormat.FormatStr) <> 0) then
            Result := Format(AFormat.FormatStr, [Integer(Value)])
          else
            Result := Format(AFormat.FormatStr, [Extended(Value)]);
          if (Length(AFormat.DecimalSeparator) = 1) and
            (FormatSettings.DecimalSeparator <> AFormat.DecimalSeparator[1]) then
            for i := Length(Result) downto 1 do
              if Result[i] = WideChar(FormatSettings.DecimalSeparator) then
              begin
                DecSepPos := i; // save dec seporator pos
                break;
              end;

          if (Length(AFormat.ThousandSeparator) = 1) and
            (FormatSettings.ThousandSeparator <> AFormat.ThousandSeparator[1]) then
            for i := 1 to Length(Result) do
              if Result[i] = WideChar(FormatSettings.ThousandSeparator) then
                Result[i] := WideChar(AFormat.ThousandSeparator[1]);

          if DecSepPos > 0 then // replace dec seporator
            Result[DecSepPos] := WideChar(AFormat.DecimalSeparator[1]);
        end;

      fkDateTime:
        Result := FormatDateTime(AFormat.FormatStr, Value);

      fkBoolean:
        if Value = True then
           Result := Copy(AFormat.FormatStr, Pos(',', AFormat.FormatStr) + 1, 255) else
           Result := Copy(AFormat.FormatStr, 1, Pos(',', AFormat.FormatStr) - 1);
      else
        Result := VarToWideStr(Value)
    end;
  except
    Result := VarToWideStr(Value)
  end;
end;

function TfrxCustomMemoView.GetComponentText: String;
var
  i: Integer;
begin
  Result := FMemo.Text;
  if FAllowExpressions then   { extract TOTALPAGES macro if any }
  begin
    i := Pos('[TOTALPAGES]', UpperCase(Result));
    if i <> 0 then
    begin
      Delete(Result, i, 12);
      Insert(IntToStr(FTotalPages), Result, i);
    end;
  end;
end;

procedure TfrxCustomMemoView.ApplyStyle(Style: TfrxStyleItem);
begin
  if Style <> nil then
  begin
    Color := Style.Color;
    Font := Style.Font;
    Frame := Style.Frame;
  end;
end;

function TfrxCustomMemoView.WrapText(WrapWords: Boolean): WideString;
var
    TextRenderer: TAdvancedTextRenderer;
    line: TLine;
    paragraph: TParagraph;
    sWord: TWord;
    Run: TRun;
    s, s1: String;
    nLen, nIndex, idx, idy: Integer;
begin
  Result := '';
  BeginDraw(FBmpCanvas.Canvas, 1, 1, 0, 0);
  TextRenderer := TAdvancedTextRenderer.Create(FBmpCanvas.Canvas, FMemo.Text, FFont, FTextRect, FHAlign, FVAlign, 0, FRotation, FWordWrap, false, FAllowHTMLTags, false);
  try
    s1 := Memo.Text;
    Result := '';
    nLen := 0;
    for idx := 0 to TextRenderer.Paragraphs.Count - 1 do
    begin
      paragraph := TextRenderer.Paragraphs[idx];
      for idy := 0 to paragraph.Lines.Count - 1 do
      begin
        line := paragraph.Lines[idy];
        nIndex := line.OriginalCharIndex;
        if line.IsLast then break;
        nLen := paragraph.Lines[idy + 1].OriginalCharIndex - nIndex - 1;
        Result := Result + Copy(s1, nIndex, nLen) + #13#10;
      end;
      if paragraph.IsLast then
      begin
        nLen := Length(s1) - line.OriginalCharIndex;
      end
      else
      begin
        paragraph := TextRenderer.Paragraphs[idx + 1];
        if (s1[nIndex] = #10) then
          Dec(nIndex);
        nLen := paragraph.Lines[0].OriginalCharIndex - nIndex - 1;
        if idx = 0 then Dec(nLen);
      end;
      Result := Result + Copy(s1, nIndex, nLen);
      end;
  finally
     TextRenderer.Free;
  end;
end;

procedure TfrxCustomMemoView.ExtractMacros;
var
  s, s1: WideString;
  i, j: Integer;
begin
  if FAllowExpressions then
  begin
    s := FMemo.Text;
    i := Pos('[TOTALPAGES#]', UpperCase(s));
    if i <> 0 then
    begin
      Delete(s, i, 13);
      Insert(IntToStr(FTotalPages), s, i);
      FMemo.Text := s;
    end;
    i := Pos('[COPYNAME#]', UpperCase(s));
    if i <> 0 then
    begin
      j := frxGlobalVariables.IndexOf('CopyName' + IntToStr(FCopyNo));
      if j <> -1 then
        s1 := VarToStr(frxGlobalVariables.Items[j].Value)
      else
        s1 := '';
      Delete(s, i, 11);
      Insert(s1, s, i);
      FMemo.Text := s;
    end;
  end;
end;


{ TfrxSysMemoView }

class function TfrxSysMemoView.GetDescription: String;
begin
  Result := frxResources.Get('obSysText');
end;


{ TfrxCustomLineView }

constructor TfrxCustomLineView.Create(AOwner: TComponent);
begin
  inherited;
  frComponentStyle := frComponentStyle - [csDefaultDiff];
  FArrowWidth := 5;
  FArrowLength := 20;
end;

constructor TfrxCustomLineView.DesignCreate(AOwner: TComponent; Flags: Word);
begin
  inherited;
  FDiagonal := Flags <> 0;
  FArrowEnd := Flags in [2, 4];
  FArrowStart := Flags in [3, 4];
end;

procedure TfrxCustomLineView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  if not FDiagonal then
  begin
    if Width > Height then
    begin
      Height := 0;
      Frame.Typ := [ftTop];
    end
    else
    begin
      Width := 0;
      Frame.Typ := [ftLeft];
    end;
  end;

  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  if not FDiagonal then
  begin
    DrawFrame;
    if FArrowStart then
      DrawArrow(FX1, FY1, FX, FY);
    if FArrowEnd then
      DrawArrow(FX, FY, FX1, FY1);
  end
  else
    DrawDiagonalLine;
end;

procedure TfrxCustomLineView.DrawArrow(x1, y1, x2, y2: Extended);
var
  k1, a, b, c, D: Double;
  xp, yp, x3, y3, x4, y4, wd, ld: Extended;
  poly: TPolygon;
begin
  wd := FArrowWidth * FScaleX;
  ld := FArrowLength * FScaleX;
  if abs(x2 - x1) > 8 then
  begin
    k1 := (y2 - y1) / (x2 - x1);
    a := Sqr(k1) + 1;
    b := 2 * (k1 * ((x2 * y1 - x1 * y2) / (x2 - x1) - y2) - x2);
    c := Sqr(x2) + Sqr(y2) - Sqr(ld) + Sqr((x2 * y1 - x1 * y2) / (x2 - x1)) -
      2 * y2 * (x2 * y1 - x1 * y2) / (x2 - x1);
    D := Sqr(b) - 4 * a * c;
    xp := (-b + Sqrt(D)) / (2 * a);
    if (xp > x1) and (xp > x2) or (xp < x1) and (xp < x2) then
      xp := (-b - Sqrt(D)) / (2 * a);
    yp := xp * k1 + (x2 * y1 - x1 * y2) / (x2 - x1);
    if y2 <> y1 then
    begin
      x3 := xp + wd * sin(ArcTan(k1));
      y3 := yp - wd * cos(ArcTan(k1));
      x4 := xp - wd * sin(ArcTan(k1));
      y4 := yp + wd * cos(ArcTan(k1));
    end
    else
    begin
      x3 := xp;
      y3 := yp - wd;
      x4 := xp;
      y4 := yp + wd;
    end;
  end
  else
  begin
    xp := x2;
    yp := y2 - ld;
    if (yp > y1) and (yp > y2) or (yp < y1) and (yp < y2) then
      yp := y2 + ld;
    x3 := xp - wd;
    y3 := yp;
    x4 := xp + wd;
    y4 := yp;
  end;

  SetLength(poly, 4);
  poly[0] := PointF(Round(x2), Round(y2));
  poly[1] := PointF(Round(x3), Round(y3));
  poly[2] := PointF(Round(x4), Round(y4));
  poly[3] := PointF(Round(x2), Round(y2));

  if FArrowSolid then
  begin
    FCanvas.Fill.Kind := TBrushKind.bkSolid;
    FCanvas.Fill.Color := Frame.Color;
    FCanvas.FillPolygon(poly, 1);
  end
  else
  begin
    FCanvas.DrawPolygon(poly, 1);
  end;
end;

procedure TfrxCustomLineView.DrawDiagonalLine;
begin
  if (Frame.Color = claNull) or (Frame.Width = 0) then exit;

  with FCanvas do
  begin
    Stroke.Kind := TBrushKind.bkSolid;
    Stroke.Color := Frame.Color;
    StrokeThickness := Round(FFrame.Width * FScaleX);
    if Frame.Style <> fsDouble then
      StrokeDash := TStrokeDash(Frame.Style) else
      StrokeDash := TStrokeDash.sdSolid;

    DrawLine(PointF(FX, FY), PointF(FX1, FY1), 1);

    if FArrowStart then
      DrawArrow(FX1, FY1, FX, FY);
    if FArrowEnd then
      DrawArrow(FX, FY, FX1, FY1);
  end;
end;


{ TfrxLineView }

class function TfrxLineView.GetDescription: String;
begin
  Result := frxResources.Get('obLine');
end;


{ TfrxPictureView }

constructor TfrxPictureView.Create(AOwner: TComponent);
begin
  inherited;
  frComponentStyle := frComponentStyle - [csDefaultDiff];
  FPicture := TBitmap.Create(0, 0);
  FPicture.OnChange := PictureChanged;
  FKeepAspectRatio := True;
  FStretched := True;
  FColor := claWhite;
  FTransparentColor := claWhite;
  FIsPictureStored := True;
end;

procedure TfrxPictureView.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('Data', ReadVCLPicture, nil, false);
end;

destructor TfrxPictureView.Destroy;
begin
  FPicture.Free;
  inherited;
end;

class function TfrxPictureView.GetDescription: String;
begin
  Result := frxResources.Get('obPicture');
end;

procedure TfrxPictureView.SetPicture(const Value: TBitmap);
begin
  FPicture.Assign(Value);
end;

procedure TfrxPictureView.SetTransparent(const Value: Boolean);
begin
  FTransparent := Value;
  if FTransparent then
    FColor := claNull
  else FColor := claWhite;
end;

procedure TfrxPictureView.SetAutoSize(const Value: Boolean);
begin
  FAutoSize := Value;
  if FAutoSize and not (FPicture = nil) then
  begin
    FWidth := FPicture.Width;
    FHeight := FPicture.Height;
  end;
end;

procedure TfrxPictureView.PictureChanged(Sender: TObject);
begin
  AutoSize := FAutoSize;
  FPictureChanged := True;
end;

procedure TfrxPictureView.ReadVCLPicture(Stream: TStream);
var
  LenName: Byte;
begin
  { skip VCL Image format }
  Stream.Read(LenName, 1);
  Stream.Position := 5 + LenName;
  FPicture.LoadFromStream(Stream);
end;

procedure TfrxPictureView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  r: TRectF;
  kx, ky: Extended;
  state: TCanvasSaveState;
  m, OldM: TMatrix;
{  rgn: HRGN;

  procedure PrintGraphic(Canvas: TCanvas; DestRect: TRect; aGraph: TGraphic);
  begin
    frxDrawGraphic(Canvas, DestRect, aGraph, IsPrinting, HightQuality, FTransparent, FTransparentColor);
  end;
}
begin
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);

  with Canvas do
  begin

    DrawBackground;

    r := RectF(FX, FY, FX1, FY1);

    if FPicture.IsEmpty then
    begin
{      if IsDesigning then
        frxResources.ObjectImages.Draw(Canvas, FX + 1, FY + 2, 3);}
    end
    else
    begin
      if FStretched then
      begin
        if FKeepAspectRatio then
        begin
          kx := FDX / FPicture.Width;
          ky := FDY / FPicture.Height;
          if kx < ky then
            r.Bottom := r.Top + Round(FPicture.Height * kx) else
            r.Right := r.Left + Round(FPicture.Width * ky);

          if FCenter then
            OffsetRect(r, (FDX - (r.Right - r.Left)) / 2,
                          (FDY - (r.Bottom - r.Top)) / 2);
        end;

        Canvas.DrawBitmap(FPicture, RectF(0, 0, FPicture.Width, FPicture.Height), r, 1, not FHightQuality);

      end
      else
      begin
        if FCenter then
          OffsetRect(r, (FDX - Round(ScaleX * FPicture.Width)) div 2,
                        (FDY - Round(ScaleY * FPicture.Height)) div 2);
        r.Right := r.Left + Round(FPicture.Width * ScaleX);
        r.Bottom := r.Top + Round(FPicture.Height * ScaleY);
        OldM := Canvas.Matrix;
        State := Canvas.SaveState;
        try
          Canvas.IntersectClipRect(REctF(FX, FY, FX1, FY1));
          Canvas.DrawBitmap(FPicture, RectF(0, 0, FPicture.Width, FPicture.Height), r, 1, not FHightQuality);
        finally
          Canvas.RestoreState(state);
          Canvas.SetMatrix(OldM);
        end;
      end;
    end;
    DrawFrame;
  end;
end;

function TfrxPictureView.Diff(AComponent: TfrxComponent): String;
begin
  if FPictureChanged then
  begin
    Report.PreviewPages.AddPicture(Self);
    FPictureChanged := False;
  end;

  Result := ' ' + inherited Diff(AComponent) + ' ImageIndex="' +
    IntToStr(FImageIndex) + '"';
  if Transparent then
    Result := Result + ' Transparent="' + frxValueToXML(FTransparent) + '"';
  if TransparentColor <> claWhite then
    Result := Result + ' TransparentColor="' + intToStr(Integer(FTransparentColor)) + '"';
end;

 type
  TGraphicHeader = record
    Count: Word;
    HType: Word;
    Size: Longint;
  end;
procedure TfrxPictureView.GetData;


var
  m: TMemoryStream;
  s: String;
  ipos: Integer;
  Header: TGraphicHeader;
begin
  inherited;
  if FFileLink <> '' then
  begin
    s := FFileLink;
    if Pos('[', s) <> 0 then
      ExpandVariables(s);
    if FileExists(s) then
      FPicture.LoadFromFile(s)
    else
      FPicture.SetSize(0,0);
  end
  else if IsDataField and DataSet.IsBlobField(DataField) then
  begin
    m := TMemoryStream.Create;
    try
      DataSet.AssignBlobTo(DataField, m);
      if m.Size >= SizeOf(TGraphicHeader) then
      begin
        ipos := m.Position;
        m.Read(Header, SizeOf(Header));
        if (Header.Count <> 1) or (Header.HType <> $0100) or
          (Header.Size <> m.Size - SizeOf(Header)) then
            m.Position := ipos;
      end;
      Picture.LoadFromStream(m);
    finally
      m.Free;
    end;
  end;
end;


{ TfrxBand }

constructor TfrxBand.Create(AOwner: TComponent);
begin
  inherited;
  FSubBands := TList.Create;
  FOriginalObjectsCount := -1;
end;

destructor TfrxBand.Destroy;
begin
  FSubBands.Free;
  inherited;
end;

procedure TfrxBand.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FChild) then
    FChild := nil;
end;

procedure TfrxBand.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
end;

function TfrxBand.GetBandName: String;
begin
  Result := ClassName;
  Delete(Result, Pos('Tfrx', Result), 4);
  Delete(Result, Pos('Band', Result), 4);
end;

function TfrxBand.BandNumber: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to BND_COUNT - 1 do
    if Self is frxBands[i] then
      Result := i;
end;

class function TfrxBand.GetDescription: String;
begin
  Result := frxResources.Get('obBand');
end;

procedure TfrxBand.SetLeft(Value: Double);
begin
  if Parent is TfrxDMPPage then
    Value := Round(Value / fr1CharX) * fr1CharX;
  inherited;
end;

procedure TfrxBand.SetTop(Value: Double);
begin
  if Parent is TfrxDMPPage then
    Value := Round(Value / fr1CharY) * fr1CharY;
  inherited;
end;

procedure TfrxBand.SetVertical(const Value: Boolean);
begin
{$IFDEF RAD_ED}
  FVertical := False;
{$ELSE}
  FVertical := Value;
{$ENDIF}
end;

procedure TfrxBand.SetHeight(Value: Double);
begin
  if Parent is TfrxDMPPage then
    Value := Round(Value / fr1CharY) * fr1CharY;
  inherited;
end;

procedure TfrxBand.SetChild(Value: TfrxChild);
var
  b: TfrxBand;
begin
  b := Value;
  while b <> nil do
  begin
    b := b.Child;
    if b = Self then
      raise Exception.Create(frxResources.Get('clCirRefNotAllow'));
  end;
  FChild := Value;
end;


{ TfrxDataBand }

constructor TfrxDataBand.Create(AOwner: TComponent);
begin
  inherited;
  FVirtualDataSet := TfrxUserDataSet.Create(nil);
  FVirtualDataSet.RangeEnd := reCount;
end;

destructor TfrxDataBand.Destroy;
begin
  FVirtualDataSet.Free;
  inherited;
end;

class function TfrxDataBand.GetDescription: String;
begin
  Result := frxResources.Get('obDataBand');
end;

procedure TfrxDataBand.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FDataSet) then
    FDataSet := nil;
end;

procedure TfrxDataBand.SetCurColumn(Value: Integer);
begin
  if Value > FColumns then
    Value := 1;
  FCurColumn := Value;
  if FCurColumn = 1 then
    FMaxY := 0;
  FLeft := (FCurColumn - 1) * (FColumnWidth + FColumnGap);
end;

procedure TfrxDataBand.SetDataSet(const Value: TfrxDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
end;

procedure TfrxDataBand.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  FDataSet := FindDataSet(FDataSet, FDataSetName);
end;

function TfrxDataBand.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;

procedure TfrxDataBand.SetRowCount(const Value: Integer);
begin
  FRowCount := Value;
  FVirtualDataSet.RangeEndCount := Value;
end;


{ TfrxPageHeader }

constructor TfrxPageHeader.Create(AOwner: TComponent);
begin
  inherited;
  FPrintOnFirstPage := True;
end;


{ TfrxPageFooter }

constructor TfrxPageFooter.Create(AOwner: TComponent);
begin
  inherited;
  FPrintOnFirstPage := True;
  FPrintOnLastPage := True;
end;


{ TfrxGroupHeader }

function TfrxGroupHeader.Diff(AComponent: TfrxComponent): String;
begin
  Result := inherited Diff(AComponent);
 if FDrillDown then
  Result := Result + ' DrillName="' + FDrillName + '"';
end;


{ TfrxSubreport }

constructor TfrxSubreport.Create(AOwner: TComponent);
begin
  inherited;
  frComponentStyle := frComponentStyle - [csPreviewVisible];
  FFrame.Typ := [ftLeft, ftRight, ftTop, ftBottom];
  FFont.Name := 'Tahoma';
  FFont.Size := 8;
  FColor := claSilver;
end;

destructor TfrxSubreport.Destroy;
begin
  if FPage <> nil then
    FPage.FSubReport := nil;
  inherited;
end;

procedure TfrxSubreport.SetPage(const Value: TfrxReportPage);
begin
  FPage := Value;
  if FPage <> nil then
    FPage.FSubReport := Self;
end;

procedure TfrxSubreport.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  inherited;

{  with Canvas do
  begin
    Font.Assign(FFont);
    FillText(FX + 2, FY + 2, Name);
  end;}
end;

class function TfrxSubreport.GetDescription: String;
begin
  Result := frxResources.Get('obSubRep');
end;


{ TfrxDialogPage }

constructor TfrxDialogPage.Create(AOwner: TComponent);
var
  FSaveTag: Integer;
begin
  inherited;
  FSaveTag := Tag;
  if (Report <> nil) and Report.EngineOptions.EnableThreadSafe then
    Tag := 318
  else
    Tag := 0;
  FForm := TfrxDialogForm.Create(Self);
  Tag := FSaveTag;
  Font.Name := 'Tahoma';
  Font.Size := 8;
  BorderStyle := TfmxFormBorderStyle.bsSizeable;
  Position := TFormPosition.poScreenCenter;
  WindowState := TWindowState.wsNormal;
  Color := claWhiteSmoke;
  FClientWidth := 0;
  FClientHeight := 0;
end;

destructor TfrxDialogPage.Destroy;
begin
{$IFNDEF NO_CRITICAL_SECTION}
  frxCS.Enter;
{$ENDIF}
  try
    inherited;
    FForm.Free;
  finally
{$IFNDEF NO_CRITICAL_SECTION}
    frxCS.Leave;
{$ENDIF}
  end;
end;

class function TfrxDialogPage.GetDescription: String;
begin
  Result := frxResources.Get('obDlgPage');
end;

procedure TfrxDialogPage.SetLeft(Value: Double);
begin
  inherited;
  FForm.Left := Round(Value);
end;

procedure TfrxDialogPage.SetTop(Value: Double);
begin
  inherited;
  FForm.Top := Round(Value);
end;

procedure TfrxDialogPage.SetWidth(Value: Double);
begin
  inherited;
  if IsLoading and (FClientWidth <> 0) then Exit;
  FForm.Width := Round(Value);
end;

procedure TfrxDialogPage.SetHeight(Value: Double);
begin
  inherited;
  if IsLoading and (FClientHeight <> 0) then Exit;
  FForm.Height := Round(Value);
end;

procedure TfrxDialogPage.SetClientWidth(Value: Double);
begin
  FForm.ClientWidth := Round(Value);
  FClientWidth := Value;
  inherited SetWidth(FForm.Width);
end;

procedure TfrxDialogPage.SetClientHeight(Value: Double);
begin
  FForm.ClientHeight := Round(Value);
  FClientHeight := Value;
  inherited SetHeight(FForm.Height);
end;

function TfrxDialogPage.GetClientWidth: Double;
begin
  Result := FForm.ClientWidth;
end;

function TfrxDialogPage.GetClientHeight: Double;
begin
  Result := FForm.ClientHeight;
end;

procedure TfrxDialogPage.SetBorderStyle(const Value: TfmxFormBorderStyle);
begin
  FBorderStyle := Value;
end;

procedure TfrxDialogPage.SetCaption(const Value: String);
begin
  FCaption := Value;
  FForm.Caption := Value;
end;

procedure TfrxDialogPage.SetColor(const Value: TAlphaColor);
begin
  FColor := Value;
  FForm.Fill.Color := Value;
end;

function TfrxDialogPage.GetModalResult: TModalResult;
begin
  Result := FForm.ModalResult;
end;

procedure TfrxDialogPage.SetModalResult(const Value: TModalResult);
begin
  FForm.ModalResult := Value;
end;

procedure TfrxDialogPage.FontChanged(Sender: TObject);
begin
  inherited;
//  FForm.Font := Font;
end;

procedure TfrxDialogPage.DoInitialize;
begin
  if FForm.Visible then
    FForm.Hide;
  FForm.Position := FPosition;
  FForm.WindowState := FWindowState;
  FForm.OnActivate := DoOnActivate;
  FForm.OnCloseQuery := DoOnCloseQuery;
  FForm.OnDeactivate := DoOnDeactivate;
  FForm.OnResize := DoOnResize;
end;

procedure TfrxDialogPage.Initialize;
begin
  DoInitialize;
end;

function TfrxDialogPage.ShowModal: TModalResult;
begin
  Initialize;
  FForm.BorderStyle := FBorderStyle;
{$IFNDEF DELPHI19}
  FForm.TopMost := False;
 {$ENDIF}
  try
    TfrxDialogForm(FForm).OnModify := DoModify;
    Result := FForm.ShowModal;
  finally
{$IFNDEF DELPHI19}
    FForm.TopMost := True;
{$ENDIF}
  end;
end;

procedure TfrxDialogPage.DoModify(Sender: TObject);
begin
  FLeft := FForm.Left;
  FTop := FForm.Top;
  FWidth := FForm.Width;
  FHeight := FForm.Height;
end;

procedure TfrxDialogPage.DoOnActivate(Sender: TObject);
var
  i: Integer;
begin
  DoModify(nil);
  if Report <> nil then
    Report.DoNotifyEvent(Sender, FOnActivate, True);
  for i := 0 to AllObjects.Count - 1 do
  begin
    if (TObject(AllObjects[i]) is TfrxDialogControl) and
    Assigned(TfrxDialogControl(AllObjects[i]).OnActivate) then
      TfrxDialogControl(AllObjects[i]).OnActivate(Self);
  end;
end;

procedure TfrxDialogPage.DoOnCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  v: Variant;
begin
  v := VarArrayOf([frxInteger(Sender), CanClose]);
  Report.DoParamEvent(FOnCloseQuery, v, True);
  CanClose := v[1];
end;

procedure TfrxDialogPage.DoOnDeactivate(Sender: TObject);
begin
  Report.DoNotifyEvent(Sender, FOnDeactivate, True);
end;

procedure TfrxDialogPage.DoOnResize(Sender: TObject);
begin
  Report.DoNotifyEvent(Sender, FOnResize, True);
end;


{ TfrxReportPage }

constructor TfrxReportPage.Create(AOwner: TComponent);
begin
  inherited;
  FBackPicture := TfrxPictureView.Create(nil);
  FBackPicture.Color := claNull;
  FBackPicture.KeepAspectRatio := False;
  FColumnPositions := TStringList.Create;
  FOrientation := poPortrait;
  PaperSize := DMPAPER_A4;
  FBin := DMBIN_AUTO;
  FBinOtherPages := DMBIN_AUTO;
  FBaseName := 'Page';
  FSubBands := TList.Create;
  FVSubBands := TList.Create;
  FHGuides := TStringList.Create;
  FVGuides := TStringList.Create;
  FPrintIfEmpty := True;
  FTitleBeforeHeader := True;
  FBackPictureVisible := True;
  FBackPicturePrintable := True;
  FPageCount := 1;
end;

destructor TfrxReportPage.Destroy;
begin
  FColumnPositions.Free;
  FBackPicture.Free;
  FSubBands.Free;
  FVSubBands.Free;
  FHGuides.Free;
  FVGuides.Free;
  if FSubReport <> nil then
    FSubReport.FPage := nil;
  inherited;
end;

class function TfrxReportPage.GetDescription: String;
begin
  Result := frxResources.Get('obRepPage');
end;

procedure TfrxReportPage.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FDataSet) then
    FDataSet := nil;
end;

procedure TfrxReportPage.SetDataSet(const Value: TfrxDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
end;

procedure TfrxReportPage.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  FDataSet := FindDataSet(FDataSet, FDataSetName);
end;

function TfrxReportPage.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;

procedure TfrxReportPage.SetPaperHeight(const Value: Double);
begin
  FPaperHeight := Round8(Value);
  FPaperSize := 256;
  UpdateDimensions;
end;

procedure TfrxReportPage.SetPaperWidth(const Value: Double);
begin
  FPaperWidth := Round8(Value);
  FPaperSize := 256;
  UpdateDimensions;
end;

procedure TfrxReportPage.SetPaperSize(const Value: Integer);
var
  e: Extended;
begin
  FPaperSize := Value;
  if FPaperSize < DMPAPER_USER then
  begin
    if frxGetPaperDimensions(FPaperSize, FPaperWidth, FPaperHeight) then
      if FOrientation = poLandscape then
      begin
        e := FPaperWidth;
        FPaperWidth := FPaperHeight;
        FPaperHeight := e;
      end;
    UpdateDimensions;
  end;
end;

procedure TfrxReportPage.SetSizeAndDimensions(ASize: Integer; AWidth,
  AHeight: Double);
begin
  FPaperSize := ASize;
  FPaperWidth := Round8(AWidth);
  FPaperHeight := Round8(AHeight);
  UpdateDimensions;
end;

procedure TfrxReportPage.SetColumns(const Value: Integer);
begin
  FColumns := Value;
  FColumnPositions.Clear;
  if FColumns <= 0 then exit;

  FColumnWidth := (FPaperWidth - FLeftMargin - FRightMargin) / FColumns;
  while FColumnPositions.Count < FColumns do
    FColumnPositions.Add(FloatToStr(FColumnPositions.Count * FColumnWidth));
end;

procedure TfrxReportPage.SetPageCount(const Value: Integer);
begin
  if Value > 0 then
    FPageCount := Value; 
end;

procedure TfrxReportPage.SetOrientation(Value: TPrinterOrientation);
var
  e, m1, m2, m3, m4: Extended;
begin
  if FOrientation <> Value then
  begin
    e := FPaperWidth;
    FPaperWidth := FPaperHeight;
    FPaperHeight := e;

    m1 := FLeftMargin;
    m2 := FRightMargin;
    m3 := FTopMargin;
    m4 := FBottomMargin;

    if Value = poLandscape then
    begin
      FLeftMargin := m3;
      FRightMargin := m4;
      FTopMargin := m2;
      FBottomMargin := m1;
    end
    else
    begin
      FLeftMargin := m4;
      FRightMargin := m3;
      FTopMargin := m1;
      FBottomMargin := m2;
    end;
    UpdateDimensions;
  end;

  FOrientation := Value;
end;

procedure TfrxReportPage.UpdateDimensions;
begin
  Width := Round(FPaperWidth * fr01cm);
  Height := Round(FPaperHeight * fr01cm);
end;

procedure TfrxReportPage.ClearGuides;
begin
  FHGuides.Clear;
  FVGuides.Clear;
end;

procedure TfrxReportPage.SetHGuides(const Value: TStrings);
begin
  FHGuides.Assign(Value);
end;

procedure TfrxReportPage.SetVGuides(const Value: TStrings);
begin
  FVGuides.Assign(Value);
end;

function TfrxReportPage.FindBand(Band: TfrxBandClass): TfrxBand;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FObjects.Count - 1 do
    if TObject(FObjects[i]) is Band then
    begin
      Result := FObjects[i];
      break;
    end;
end;

function TfrxReportPage.IsSubReport: Boolean;
begin
  Result := SubReport <> nil;
end;

procedure TfrxReportPage.SetColumnPositions(const Value: TStrings);
begin
  FColumnPositions.Assign(Value);
end;

function TfrxReportPage.GetFrame: TfrxFrame;
begin
  Result := FBackPicture.Frame;
end;

procedure TfrxReportPage.SetFrame(const Value: TfrxFrame);
begin
  FBackPicture.Frame := Value;
end;

function TfrxReportPage.GetColor: TAlphaColor;
begin
  Result := FBackPicture.Color;
end;

procedure TfrxReportPage.SetColor(const Value: TAlphaColor);
begin
  FBackPicture.Color := Value;
end;

function TfrxReportPage.GetBackPicture: TBitmap;
begin
  Result := FBackPicture.Picture;
end;

procedure TfrxReportPage.SetBackPicture(const Value: TBitmap);
begin
  FBackPicture.Picture := Value;
end;

procedure TfrxReportPage.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  FBackPicture.Width := (FPaperWidth - FLeftMargin - FRightMargin) * fr01cm;
  FBackPicture.Height := (FPaperHeight - FTopMargin - FBottomMargin) * fr01cm;
  if FBackPictureVisible and (not IsPrinting or FBackPicturePrintable) then
    FBackPicture.Draw(Canvas, ScaleX, ScaleY,
      OffsetX + FLeftMargin * fr01cm * ScaleX,
      OffsetY + FTopMargin * fr01cm * ScaleY);
end;

procedure TfrxReportPage.SetDefaults;
begin
  FLeftMargin := 10;
  FRightMargin := 10;
  FTopMargin := 10;
  FBottomMargin := 10;
  FPaperSize := frxPrinters.Printer.DefPaper;
  FPaperWidth := frxPrinters.Printer.DefPaperWidth;
  FPaperHeight := frxPrinters.Printer.DefPaperHeight;
  FOrientation := frxPrinters.Printer.DefOrientation;
  UpdateDimensions;
end;

procedure TfrxReportPage.AlignChildren;
var
  i: Integer;
  c: TfrxComponent;
begin
  Width := (FPaperWidth - FLeftMargin - FRightMargin) * fr01cm;
  Height := (FPaperHeight - FTopMargin - FBottomMargin) * fr01cm;
  inherited;
  for i := 0 to Objects.Count - 1 do
  begin
    c := Objects[i];
    if c is TfrxBand then
    begin
      if TfrxBand(c).Vertical then
        c.Height := (FPaperHeight - FTopMargin - FBottomMargin) * fr01cm - c.Top
      else
        if (Columns > 1) and not((c is TfrxNullBand) or (c is TfrxReportSummary) or
          (c is TfrxPageHeader) or (c is TfrxPageFooter) or
          (c is TfrxReportTitle) or (c is TfrxOverlay)) then
          c.Width := ColumnWidth * fr01cm
        else       
          c.Width := Width - c.Left;
      c.AlignChildren;
    end;
  end;
  UpdateDimensions;
end;


{ TfrxDataPage }

constructor TfrxDataPage.Create(AOwner: TComponent);
begin
  inherited;
  Width := 1000;
  Height := 1000;
end;

class function TfrxDataPage.GetDescription: String;
begin
  Result := frxResources.Get('obDataPage');
end;


{ TfrxEngineOptions }

constructor TfrxEngineOptions.Create;
begin
  Clear;
  FMaxMemSize := 10;
  FPrintIfEmpty := True;
  FSilentMode := simMessageBoxes;
  FEnableThreadSafe := False;
  FTempDir := '';
  FUseGlobalDataSetList := True;
  FUseFileCache := False;
  FDestroyForms := True;
end;

procedure TfrxEngineOptions.Assign(Source: TPersistent);
begin
  if Source is TfrxEngineOptions then
  begin
    FConvertNulls := TfrxEngineOptions(Source).ConvertNulls;
    FDoublePass := TfrxEngineOptions(Source).DoublePass;
    FMaxMemSize := TfrxEngineOptions(Source).MaxMemSize;
    FPrintIfEmpty := TfrxEngineOptions(Source).PrintIfEmpty;
    NewSilentMode := TfrxEngineOptions(Source).NewSilentMode;
    FTempDir := TfrxEngineOptions(Source).TempDir;
    FUseFileCache := TfrxEngineOptions(Source).UseFileCache;
    FIgnoreDevByZero := TfrxEngineOptions(Source).IgnoreDevByZero;
  end;
end;

procedure TfrxEngineOptions.Clear;
begin
  FConvertNulls := True;
  FIgnoreDevByZero := False;
  FDoublePass := False;
end;

procedure TfrxEngineOptions.SetSilentMode(Mode: Boolean);
begin
  if Mode = True then
    FSilentMode := simSilent
  else
    FSilentMode := simMessageBoxes;
end;

function TfrxEngineOptions.GetSilentMode: Boolean;
begin
  if FSilentMode = simSilent then
    Result := True
  else
    Result := False;
end;


{ TfrxPreviewOptions }

constructor TfrxPreviewOptions.Create;
begin
  Clear;
  FAllowEdit := True;
  FButtons := [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFullScreen,
    pbOutline, pbThumbnails, pbPageSetup, pbEdit, pbNavigator, pbClose];
  FDoubleBuffered := True;
  FMaximized := True;
  FMDIChild := False;
  FModal := True;
  FPagesInCache := 50;
  FShowCaptions := False;
  FZoom := 1;
  FZoomMode := zmDefault;
  FPictureCacheInFile := False;
end;

procedure TfrxPreviewOptions.Assign(Source: TPersistent);
begin
  if Source is TfrxPreviewOptions then
  begin
    FAllowEdit := TfrxPreviewOptions(Source).AllowEdit;
    FButtons := TfrxPreviewOptions(Source).Buttons;
    FDoubleBuffered := TfrxPreviewOptions(Source).DoubleBuffered;
    FMaximized := TfrxPreviewOptions(Source).Maximized;
    FMDIChild := TfrxPreviewOptions(Source).MDIChild;
    FModal := TfrxPreviewOptions(Source).Modal;
    FOutlineExpand := TfrxPreviewOptions(Source).OutlineExpand;
    FOutlineVisible := TfrxPreviewOptions(Source).OutlineVisible;
    FOutlineWidth := TfrxPreviewOptions(Source).OutlineWidth;
    FPagesInCache := TfrxPreviewOptions(Source).PagesInCache;
    FShowCaptions := TfrxPreviewOptions(Source).ShowCaptions;
    FThumbnailVisible := TfrxPreviewOptions(Source).ThumbnailVisible;
    FZoom := TfrxPreviewOptions(Source).Zoom;
    FZoomMode := TfrxPreviewOptions(Source).ZoomMode;
    FPictureCacheInFile := TfrxPreviewOptions(Source).PictureCacheInFile;
    FRTLPreview := TfrxPreviewOptions(Source).RTLPreview;
  end;
end;

procedure TfrxPreviewOptions.Clear;
begin
  FOutlineExpand := True;
  FOutlineVisible := False;
  FOutlineWidth := 120;
  FPagesInCache := 50;
  FThumbnailVisible := False;
end;


{ TfrxPrintOptions }

constructor TfrxPrintOptions.Create;
begin
  Clear;
end;

procedure TfrxPrintOptions.Assign(Source: TPersistent);
begin
  if Source is TfrxPrintOptions then
  begin
    FCopies := TfrxPrintOptions(Source).Copies;
    FCollate := TfrxPrintOptions(Source).Collate;
    FPageNumbers := TfrxPrintOptions(Source).PageNumbers;
    FPrinter := TfrxPrintOptions(Source).Printer;
    FPrintMode := TfrxPrintOptions(Source).PrintMode;
    FPrintOnSheet := TfrxPrintOptions(Source).PrintOnSheet;
    FPrintPages := TfrxPrintOptions(Source).PrintPages;
    FReverse := TfrxPrintOptions(Source).Reverse;
    FShowDialog := TfrxPrintOptions(Source).ShowDialog;
    FSplicingLine := TfrxPrintOptions(Source).SplicingLine;
  end;
end;

procedure TfrxPrintOptions.Clear;
begin
  FCopies := 1;
  FCollate := True;
  FPageNumbers := '';
  FPagesOnSheet := 0;
  FPrinter := frxResources.Get('prDefault');
  FPrintMode := pmDefault;
  FPrintOnSheet := 0;
  FPrintPages := ppAll;
  FReverse := False;
  FShowDialog := True;
  FSplicingLine := 3;
  FDuplex := dmNone;
end;


{ TfrxReportOptions }

constructor TfrxReportOptions.Create;
begin
  FDescription := TStringList.Create;
  FPicture := TBitmap.Create(0, 0);
  FCreateDate := Now;
  FLastChange := Now;
  FPrevPassword := '';
  FInfo := False;
  FIsFMXReport := True;
end;

destructor TfrxReportOptions.Destroy;
begin
  FDescription.Free;
  FPicture.Free;
  inherited;
end;

procedure TfrxReportOptions.Assign(Source: TPersistent);
begin
  if Source is TfrxReportOptions then
  begin
    FAuthor := TfrxReportOptions(Source).Author;
    FCompressed := TfrxReportOptions(Source).Compressed;
    FCreateDate := TfrxReportOptions(Source).CreateDate;
    Description := TfrxReportOptions(Source).Description;
    FInitString := TfrxReportOptions(Source).InitString;
    FLastChange := TfrxReportOptions(Source).LastChange;
    FName := TfrxReportOptions(Source).Name;
    FPassword := TfrxReportOptions(Source).Password;
    Picture := TfrxReportOptions(Source).Picture;
    FVersionBuild := TfrxReportOptions(Source).VersionBuild;
    FVersionMajor := TfrxReportOptions(Source).VersionMajor;
    FVersionMinor := TfrxReportOptions(Source).VersionMinor;
    FVersionRelease := TfrxReportOptions(Source).VersionRelease;
  end;
end;

procedure TfrxReportOptions.Clear;
begin
  if not FInfo then
  begin
    FPicture.Free;
    FAuthor := '';
    FCompressed := False;
    FCreateDate := Now;
    FDescription.Clear;
    FLastChange := Now;
    FPicture := TBitmap.Create(0, 0);
    FVersionBuild := '';
    FVersionMajor := '';
    FVersionMinor := '';
    FVersionRelease := '';
  end;
  FConnectionName := '';
  FInitString := '';
  FName := '';
  FPassword := '';
  FPrevPassword := '';
end;

procedure TfrxReportOptions.SetDescription(const Value: TStrings);
begin
  FDescription.Assign(Value);
end;

procedure TfrxReportOptions.SetPicture(const Value: TBitmap);
begin
  FPicture.Assign(Value);
end;

function TfrxReportOptions.CheckPassword: Boolean;
begin
  Result := True;
  if (FPassword <> '') and (FPassword <> FPrevPassword) and (FPassword <> HiddenPassword) then
    with TfrxPasswordForm.Create(Application) do
    begin
      if (ShowModal <> mrOk) or (FPassword <> PasswordE.Text) then
      begin
        Result := False;
        FReport.Errors.Add(frxResources.Get('Invalid password'));
        frxCommonErrorHandler(FReport, frxResources.Get('clErrors') + #13#10 + FReport.Errors.Text);
      end
      else
        FPrevPassword := FPassword;
      Free;
    end;
end;


{ TfrxDataSetItem }

procedure TfrxDataSetItem.SetDataSet(const Value: TfrxDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
end;

procedure TfrxDataSetItem.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  if FDataSetName = '' then
    FDataSet := nil
  else if TfrxReportDataSets(Collection).FReport <> nil then
    FDataSet := TfrxReportDataSets(Collection).FReport.FindDataSet(FDataSet, FDataSetName);
end;

function TfrxDataSetItem.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;


{ TfrxReportDatasets }

constructor TfrxReportDatasets.Create(AReport: TfrxReport);
begin
  inherited Create(TfrxDatasetItem);
  FReport := AReport;
end;

procedure TfrxReportDataSets.Initialize;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Items[i].DataSet <> nil then
    begin
      Items[i].DataSet.ReportRef := FReport;
      Items[i].DataSet.Initialize;
    end;
end;

procedure TfrxReportDataSets.Finalize;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Items[i].DataSet <> nil then
      Items[i].DataSet.Finalize;
end;

procedure TfrxReportDatasets.Add(ds: TfrxDataSet);
begin
  TfrxDatasetItem(inherited Add).DataSet := ds;
end;

function TfrxReportDatasets.GetItem(Index: Integer): TfrxDatasetItem;
begin
  Result := TfrxDatasetItem(inherited Items[Index]);
end;

function TfrxReportDatasets.Find(ds: TfrxDataSet): TfrxDatasetItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if Items[i].DataSet = ds then
    begin
      Result := Items[i];
      Exit;
    end;
end;

function TfrxReportDatasets.Find(const Name: String): TfrxDatasetItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if Items[i].DataSet <> nil then
      if CompareText(Items[i].DataSet.UserName, Name) = 0 then
      begin
        Result := Items[i];
        Exit;
      end;
end;

procedure TfrxReportDatasets.Delete(const Name: String);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Items[i].DataSet <> nil then
      if CompareText(Items[i].DataSet.UserName, Name) = 0 then
      begin
        Items[i].Free;
        Exit;
      end;
end;

{ TfrxStyleItem }

constructor TfrxStyleItem.Create(Collection: TCollection);
begin
  inherited;
  FColor := claNull;
  FFont := TfrxFont.Create;
  with FFont do
  begin
    Name := DefFontName;
    Size := DefFontSize;
  end;
  FFrame := TfrxFrame.Create;
end;

destructor TfrxStyleItem.Destroy;
begin
  FFont.Free;
  FFrame.Free;
  inherited;
end;

procedure TfrxStyleItem.Assign(Source: TPersistent);
begin
  if Source is TfrxStyleItem then
  begin
    FName := TfrxStyleItem(Source).Name;
    FColor := TfrxStyleItem(Source).Color;
    FFont.Assign(TfrxStyleItem(Source).Font);
    FFrame.Assign(TfrxStyleItem(Source).Frame);
  end;
end;

procedure TfrxStyleItem.SetFont(const Value: TfrxFont);
begin
  FFont.Assign(Value);
end;

procedure TfrxStyleItem.SetFrame(const Value: TfrxFrame);
begin
  FFrame.Assign(Value);
end;

procedure TfrxStyleItem.SetName(const Value: String);
var
  Item: TfrxStyleItem;
begin
  Item := TfrxStyles(Collection).Find(Value);
  if (Item = nil) or (Item = Self) then
    FName := Value else
    raise Exception.Create(frxResources.Get('clDupName'));
end;

procedure TfrxStyleItem.CreateUniqueName;
var
  i: Integer;
begin
  i := 1;
  while TfrxStyles(Collection).Find('Style' + IntToStr(i)) <> nil do
    Inc(i);
  Name := 'Style' + IntToStr(i);
end;


{ TfrxStyles }

constructor TfrxStyles.Create(AReport: TfrxReport);
begin
  inherited Create(TfrxStyleItem);
  FReport := AReport;
end;

function TfrxStyles.Add: TfrxStyleItem;
begin
  Result := TfrxStyleItem(inherited Add);
end;

function TfrxStyles.Find(const Name: String): TfrxStyleItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if AnsiCompareText(Items[i].Name, Name) = 0 then
    begin
      Result := Items[i];
      break;
    end;
end;

function TfrxStyles.GetItem(Index: Integer): TfrxStyleItem;
begin
  Result := TfrxStyleItem(inherited Items[Index]);
end;

procedure TfrxStyles.GetList(List: TStrings);
var
  i: Integer;
begin
  List.Clear;
  for i := 0 to Count - 1 do
    List.Add(Items[i].Name);
end;

procedure TfrxStyles.LoadFromXMLItem(Item: TfrxXMLItem; OldXMLFormat: Boolean);
var
  xs: TfrxXMLSerializer;
  i: Integer;
begin
  Clear;
  xs := TfrxXMLSerializer.Create(nil);
  try
    xs.OldFormat := OldXMLFormat;
    Name := Item.Prop['Name'];
    for i := 0 to Item.Count - 1 do
      if CompareText(Item[i].Name, 'item') = 0 then
        xs.XMLToObj(Item[i].Text, Add);
  finally
    xs.Free;
  end;

  Apply;
end;

procedure TfrxStyles.SaveToXMLItem(Item: TfrxXMLItem);
var
  xi: TfrxXMLItem;
  xs: TfrxXMLSerializer;
  i: Integer;
begin
  xs := TfrxXMLSerializer.Create(nil);
  try
    Item.Name := 'style';
    Item.Prop['Name'] := Name;
    for i := 0 to Count - 1 do
    begin
      xi := Item.Add;
      xi.Name := 'item';
      xi.Text := xs.ObjToXML(Items[i]);
    end;
  finally
    xs.Free;
  end;
end;

procedure TfrxStyles.LoadFromFile(const FileName: String);
var
  f: TFileStream;
begin
  f := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(f);
  finally
    f.Free;
  end;
end;

procedure TfrxStyles.LoadFromStream(Stream: TStream);
var
  x: TfrxXMLDocument;
begin
  Clear;
  x := TfrxXMLDocument.Create;
  try
    x.LoadFromStream(Stream);
    if CompareText(x.Root.Name, 'style') = 0 then
      LoadFromXMLItem(x.Root, x.OldVersion);
  finally
    x.Free;
  end;
end;

procedure TfrxStyles.SaveToFile(const FileName: String);
var
  f: TFileStream;
begin
  f := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(f);
  finally
    f.Free;
  end;
end;

procedure TfrxStyles.SaveToStream(Stream: TStream);
var
  x: TfrxXMLDocument;
begin
  x := TfrxXMLDocument.Create;
  x.AutoIndent := True;
  try
    x.Root.Name := 'style';
    SaveToXMLItem(x.Root);
    x.SaveToStream(Stream);
  finally
    x.Free;
  end;
end;

procedure TfrxStyles.Apply;
var
  i: Integer;
  l: TList;
begin
  if FReport <> nil then
  begin
    l := FReport.AllObjects;
    for i := 0 to l.Count - 1 do
      if TObject(l[i]) is TfrxCustomMemoView then
        if Find(TfrxCustomMemoView(l[i]).Style) = nil then
          TfrxCustomMemoView(l[i]).Style := ''
        else
          TfrxCustomMemoView(l[i]).Style := TfrxCustomMemoView(l[i]).Style;
  end;
end;


{ TfrxStyleSheet }

constructor TfrxStyleSheet.Create;
begin
  FItems := TList.Create;
end;

destructor TfrxStyleSheet.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

procedure TfrxStyleSheet.Clear;
begin
  while Count > 0 do
    Delete(0);
end;

procedure TfrxStyleSheet.Delete(Index: Integer);
begin
  Items[Index].Free;
  FItems.Delete(Index);
end;

function TfrxStyleSheet.Add: TfrxStyles;
begin
  Result := TfrxStyles.Create(nil);
  FItems.Add(Result);
end;

function TfrxStyleSheet.Count: Integer;
begin
  Result := FItems.Count;
end;

function TfrxStyleSheet.GetItems(Index: Integer): TfrxStyles;
begin
  Result := FItems[Index];
end;

function TfrxStyleSheet.Find(const Name: String): TfrxStyles;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if AnsiCompareText(Items[i].Name, Name) = 0 then
    begin
      Result := Items[i];
      break;
    end;
end;

function TfrxStyleSheet.IndexOf(const Name: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if AnsiCompareText(Items[i].Name, Name) = 0 then
    begin
      Result := i;
      break;
    end;
end;

procedure TfrxStyleSheet.GetList(List: TStrings);
var
  i: Integer;
begin
  List.Clear;
  for i := 0 to Count - 1 do
    List.Add(Items[i].Name);
end;

procedure TfrxStyleSheet.LoadFromFile(const FileName: String);
var
  f: TFileStream;
begin
  f := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(f);
  finally
    f.Free;
  end;
end;

procedure TfrxStyleSheet.LoadFromStream(Stream: TStream);
var
  x: TfrxXMLDocument;
  i: Integer;
begin
  Clear;
  x := TfrxXMLDocument.Create;
  try
    x.LoadFromStream(Stream);
    if CompareText(x.Root.Name, 'stylesheet') = 0 then
      for i := 0 to x.Root.Count - 1 do
        if CompareText(x.Root[i].Name, 'style') = 0 then
          Add.LoadFromXMLItem(x.Root[i], x.OldVersion);
  finally
    x.Free;
  end;
end;

procedure TfrxStyleSheet.SaveToFile(const FileName: String);
var
  f: TFileStream;
begin
  f := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(f);
  finally
    f.Free;
  end;
end;

procedure TfrxStyleSheet.SaveToStream(Stream: TStream);
var
  x: TfrxXMLDocument;
  i: Integer;
begin
  x := TfrxXMLDocument.Create;
  x.AutoIndent := True;
  try
    x.Root.Name := 'stylesheet';
    for i := 0 to Count - 1 do
      Items[i].SaveToXMLItem(x.Root.Add);

    x.SaveToStream(Stream);
  finally
    x.Free;
  end;
end;


{ TfrxReport }

constructor TfrxReport.Create(AOwner: TComponent);
begin
  inherited;
{$IFNDEF MSWINDOWS}
{$IFDEF DELPHI17}
  FRAppService := nil;
{$ENDIF}
{$ENDIF}
  FVersion := FR_VERSION;
  FDatasets := TfrxReportDatasets.Create(Self);
  FVariables := TfrxVariables.Create;
  FScript := TfsScript.Create(nil);
  FScript.ExtendedCharset := True;
  FScript.AddRTTI;

  FTimer := TTimer.Create(nil);
  FTimer.Interval := 50;
  FTimer.Enabled := False;
  FTimer.OnTimer := OnTimer;

  FEngineOptions := TfrxEngineOptions.Create;
  FPreviewOptions := TfrxPreviewOptions.Create;
  FPrintOptions := TfrxPrintOptions.Create;
  FReportOptions := TfrxReportOptions.Create(Self);
  FReportOptions.FReport := Self;

  FIniFile := '';
  FScriptText := TStringList.Create;
  FFakeScriptText := TStringList.Create;
  FExpressionCache := TfrxExpressionCache.Create(FScript);
  FErrors := TStringList.Create;
  TStringList(FErrors).Sorted := True;
  TStringList(FErrors).Duplicates := dupIgnore;
  FStyles := TfrxStyles.Create(Self);
  FSysVariables := TStringList.Create;
  FEnabledDataSets := TfrxReportDataSets.Create(Self);
  FShowProgress := True;
  FStoreInDFM := True;
  FOldStyleProgress := True;

  FEngine := TfrxEngine.Create(Self);
  FPreviewPages := TfrxPreviewPages.Create(Self);
  FEngine.FPreviewPages := FPreviewPages;
  FPreviewPages.FEngine := FEngine;
  FDrillState := TStringList.Create;
  Clear;
end;

destructor TfrxReport.Destroy;
begin
  inherited;
  if FPreviewForm <> nil then
    FPreviewForm.Close;
  Preview := nil;
  if FParentReportObject <> nil then
    FParentReportObject.Free;
  FDatasets.Free;
  FEngineOptions.Free;
  FPreviewOptions.Free;
  FPrintOptions.Free;
  FReportOptions.Free;
  FExpressionCache.Free;
  FScript.Free;
  FScriptText.Free;
  FFakeScriptText.Free;
  FVariables.Free;
  FEngine.Free;
  FPreviewPages.Free;
  FErrors.Free;
  FStyles.Free;
  FSysVariables.Free;
  FEnabledDataSets.Free;
  FTimer.Free;
  TObject(FDrawText).Free;
  FDrillState.Free;

  if FParentForm <> nil then
    FParentForm.Free;
end;

class function TfrxReport.GetDescription: String;
begin
  Result := frxResources.Get('obReport');
end;

procedure TfrxReport.DoClear;
begin
  inherited Clear;
  FDataSets.Clear;
  FVariables.Clear;
  FEngineOptions.Clear;
  FPreviewOptions.Clear;
  FPrintOptions.Clear;
  FReportOptions.Clear;
  FStyles.Clear;
  FDataSet := nil;
  FDataSetName := '';
  FDotMatrixReport := False;
  ParentReport := '';

  FScriptLanguage := 'PascalScript';
  with FScriptText do
  begin
    Clear;
    Add('begin');
    Add('');
    Add('end.');
  end;

  with FSysVariables do
  begin
    Clear;
    Add('Date');
    Add('Time');
    Add('Page');
    Add('Page#');
    Add('TotalPages');
    Add('TotalPages#');
    Add('Line');
    Add('Line#');
    Add('CopyName#');
  end;

  FOnRunDialogs := '';
  FOnStartReport := '';
  FOnStopReport := '';
end;

procedure TfrxReport.Clear;
begin
  DoClear;
end;

procedure TfrxReport.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
    if AComponent is TfrxDataSet then
    begin
      if FDataSets.Find(TfrxDataSet(AComponent)) <> nil then
        FDataSets.Find(TfrxDataSet(AComponent)).Free;
      if FDataset = AComponent then
        FDataset := nil;
      if Designer <> nil then
        Designer.UpdateDataTree;
    end
    else if AComponent is TfrxCustomPreview then
      if FPreview = AComponent then
        FPreview := nil;
end;

procedure TfrxReport.AncestorNotFound(Reader: TReader; const ComponentName: string;
  ComponentClass: TPersistentClass; var Component: TComponent);
begin
  Component := FindObject(ComponentName);
end;

procedure TfrxReport.AppHandleMessage;
{$IFDEF DELPHI17}
{$IFNDEF MSWINDOWS}
var
  AutoReleasePool: NSAutoreleasePool;
  NSApp: NSApplication;
  TimeoutDate: NSDate;
  LEvent: NSEvent;
{$ENDIF}
{$ENDIF}
begin
    if not EngineOptions.EnableThreadSafe then
    begin
{$IFDEF DELPHI17}
{$IFDEF MSWINDOWS}
      Application.ProcessMessages;
{$ELSE}
      // starts from XE5 ProcessMessages under mac has interval delay with 0.1 seconds
      // and ProcessMessages cycle can't be used for synchronization anymore - cause very long delays
      // reported to Embarcadero, but bug still present
      AutoReleasePool := TNSAutoreleasePool.Alloc;
      try
        AutoReleasePool.init;
        NSApp := TNSApplication.Wrap(TNSApplication.OCClass.sharedApplication);
        TimeoutDate := TNSDate.Wrap(TNSDate.OCClass.dateWithTimeIntervalSinceNow(0));
        LEvent := NSApp.nextEventMatchingMask(NSAnyEventMask, TimeoutDate, NSDefaultRunLoopMode, True);
        if LEvent <> nil then
          NSApp.sendEvent(LEvent);
      finally
        AutoReleasePool.release;
      end;
{$ENDIF}
{$ELSE}
      Application.ProcessMessages;
{$ENDIF}
    end;
end;

procedure TfrxReport.DefineProperties(Filer: TFiler);
begin
  inherited;
  if (csWriting in ComponentState) and not FStoreInDFM then Exit;

  Filer.DefineProperty('Datasets', ReadDatasets, WriteDatasets, True);
  Filer.DefineProperty('Variables', ReadVariables, WriteVariables, True);
  Filer.DefineProperty('Style', ReadStyle, WriteStyle, True);
  if Filer is TReader then
    TReader(Filer).OnAncestorNotFound := AncestorNotFound;
end;

procedure TfrxReport.ReadDatasets(Reader: TReader);
begin
  frxReadCollection(FDatasets, Reader, Self);
end;

procedure TfrxReport.ReadStyle(Reader: TReader);
begin
  frxReadCollection(FStyles, Reader, Self);
end;

procedure TfrxReport.ReadVariables(Reader: TReader);
begin
  frxReadCollection(FVariables, Reader, Self);
end;

procedure TfrxReport.WriteDatasets(Writer: TWriter);
begin
  frxWriteCollection(FDatasets, Writer, Self);
end;

procedure TfrxReport.WriteStyle(Writer: TWriter);
begin
  frxWriteCollection(FStyles, Writer, Self);
end;

procedure TfrxReport.WriteVariables(Writer: TWriter);
begin
  frxWriteCollection(FVariables, Writer, Self);
end;

function TfrxReport.GetPages(Index: Integer): TfrxPage;
begin
  Result := TfrxPage(Objects[Index]);
end;

function TfrxReport.GetPagesCount: Integer;
begin
  Result := Objects.Count;
end;

procedure TfrxReport.SetScriptText(const Value: TStrings);
begin
  FScriptText.Assign(Value);
end;

procedure TfrxReport.SetEngineOptions(const Value: TfrxEngineOptions);
begin
  FEngineOptions.Assign(Value);
end;

procedure TfrxReport.SetParentReport(const Value: String);
var
  i: Integer;
  list: TList;
  c: TfrxComponent;
  fName, SaveFileName: String;
  SaveXMLSerializer: TObject;
begin
  FParentReport := Value;
  if FParentReportObject <> nil then
  begin
    FParentReportObject.Free;
    FParentReportObject := nil;
  end;
  if Value = '' then
  begin
    list := AllObjects;
    for i := 0 to list.Count - 1 do
    begin
      c := list[i];
      c.FAncestor := False;
    end;

    FAncestor := False;
    Exit;
  end;

  SaveFileName := FFileName;
  SaveXMLSerializer := FXMLSerializer;
  if Assigned(FOnLoadTemplate) then
    FOnLoadTemplate(Self, Value)
  else
  begin
    fName := Value;
    { check relative path, exclude network path }
    if (Length(fName) > 1) and (fName[2] <> ':')
      and not ((fName[1] = '\') and (fName[2] = '\')) then
      begin
        fName := ExtractFilePath(SaveFileName) + Value;
        if not FileExists(fName) then
          fName := GetApplicationFolder + Value;
      end;
    LoadFromFile(fName);
  end;

  if FParentReportObject <> nil then
    FParentReportObject.Free;
  FParentReportObject := TfrxReport.Create(nil);
  FParentReportObject.FileName := FFileName;
  FParentReportObject.AssignAll(Self);
  FFileName := SaveFileName;

  for i := 0 to FParentReportObject.Objects.Count - 1 do
    if TObject(FParentReportObject.Objects[i]) is TfrxReportPage then
      TfrxReportPage(FParentReportObject.Objects[i]).PaperSize := 256;

  { set ancestor flag for parent objects }
  list := AllObjects;
  for i := 0 to list.Count - 1 do
  begin
    c := list[i];
    c.FAncestor := True;
  end;

  FAncestor := True;
  FParentReport := Value;
  FXMLSerializer := SaveXMLSerializer;
end;

function TfrxReport.InheritFromTemplate(const templName: String; InheriteMode: TfrxInheriteMode = imDefault): Boolean;
var
  tempReport: TfrxReport;
  Ref: TObject;
  i: Integer;
  DS: TfrxDataSet;
  lItem: TfrxFixupItem;
  l, FixupList: TList;
  c: TfrxComponent;
  found, DeleteDuplicates: Boolean;
  saveScript, OpenQuote, CloseQuote: String;
  fn1, fn2: String;

  procedure FixNames(OldName, NewName: String);
  var
    i: Integer;
  begin
    for i := 0 to FixupList.Count - 1 do
      with TfrxFixupItem(FixupList[i]) do
      begin
        if Value = OldName then Value := NewName;
      end;
  end;

  procedure EnumObjects(ToParent, FromParent: TfrxComponent);
  var
    xs: TfrxXMLSerializer;
    s, OldName: String;
    i: Integer;
    cFrom, cTo, tObj: TfrxComponent;
    cFromSubPage, cToSubPage: TfrxReportPage;
  begin
    xs := TfrxXMLSerializer.Create(nil);
    { don't serialize ParentReport property! }
    xs.SerializeDefaultValues := not (ToParent is TfrxReport);
    if FromParent.Owner is TfrxComponent then
      xs.Owner := TfrxComponent(FromParent.Owner);
    s := xs.ObjToXML(FromParent);
    if ToParent.Owner is TfrxComponent then
      xs.Owner := TfrxComponent(ToParent.Owner);
    xs.XMLToObj(s, ToParent);
    xs.CopyFixupList(FixupList);
    xs.Free;
    i := 0;
    while (i < FromParent.Objects.Count) do
    begin
      cFrom := FromParent.Objects[i];
      cTo := Self.FindObject(cFrom.Name);
      inc(i);

      if (cTo <> nil) and not (cTo is TfrxPage) then
      begin
        { skip duplicate object }
        if DeleteDuplicates then continue;
        { set empty name for duplicate object, rename later }
        OldName := cFrom.Name;
        cFrom.Name := '';
        cTo := nil;
      end;

      if cTo = nil then
      begin
        cTo := TfrxComponent(cFrom.NewInstance);
        cTo.Create(ToParent);
        if cFrom.Name = '' then
        begin
          cTo.CreateUniqueName;
          tObj := tempReport.FindObject(cTo.Name);
          if tObj <> nil then
          begin
            tObj.Name := '';
            cFrom.Name := cTo.Name;
            tObj.CreateUniqueName;
          end
          else cFrom.Name := cTo.Name;
          FixNames(OldName, cTo.Name);
          if cFrom is TfrxDataSet then
          begin
            TfrxDataSet(cFrom).UserName := cFrom.Name;
            Self.DataSets.Add(TfrxDataSet(cTo));
          end;
        end
        else
          cTo.Name := cFrom.Name;

        if cFrom is TfrxSubreport then
        begin
          cFromSubPage := TfrxSubreport(cFrom).Page;
          TfrxSubreport(cTo).Page := TfrxReportPage.Create(Self);
          cToSubPage := TfrxSubreport(cTo).Page;
          cToSubPage.Assign(cFromSubPage);
          cToSubPage.CreateUniqueName;
          EnumObjects(cToSubPage, cFromSubPage);
          tempReport.Objects.Remove(cFromSubPage);
        end
      end;
      EnumObjects(cTo, cFrom);
    end;
  end;

begin
  Result := True;

  if (Length(FileName) > 1) and ((FileName[1] = '.') or (FileName[1] = '\')) then
    fn1 := ExpandFileName(FileName)
  else
    fn1 := FileName;

  if (Length(templName) > 1) and ((templName[1] = '.') or (templName[1] = '\')) then
    fn2 := ExpandFileName(templName)
  else
    fn2 := templName;

  if fn1 = fn2 then
  begin
    Result := False;
    Exit;
  end;

  tempReport := TfrxReport.Create(nil);
  FixupList := TList.Create;
  tempReport.AssignAll(Self);
  { load the template }
  ParentReport := ExtractRelativePath(ExtractFilePath(FileName), templName);
  { find duplicate objects }
  found := False;
  l := tempReport.AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if not (c is TfrxPage) and (FindObject(c.Name) <> nil) then
    begin
      found := True;
      break;
    end;
  end;

  deleteDuplicates := False;
  if (found) and (InheriteMode = imDefault) then
  begin
    with TfrxInheritErrorForm.Create(nil) do
    begin
      Result := ShowModal = mrOk;
      if Result then
        deleteDuplicates := DeleteRB.IsChecked;
      Free;
    end;
  end
  else
    deleteDuplicates := (InheriteMode = imDelete);

  if Result then
  begin
    saveScript := ScriptText.Text;
    EnumObjects(Self, tempReport);

    if (Script.SyntaxType = 'C++Script') or (Script.SyntaxType = 'JScript') then
    begin
      OpenQuote := '/*';
      CloseQuote := '*/';
    end
    else if (Script.SyntaxType = 'BasicScript') then
    begin
      OpenQuote := '/\';
      CloseQuote := '/\';
    end
    else if (Script.SyntaxType = 'PascalScript') then
    begin
      OpenQuote := '{';
      CloseQuote := '}';
    end;

    ScriptText.Add(OpenQuote);
    ScriptText.Add('**********Script from parent report**********');
    ScriptText.Text := ScriptText.Text + saveScript;
    ScriptText.Add(CloseQuote);

    { fixup datasets }
    for i := 0 to Self.DataSets.Count - 1 do
    begin
      DS := Self.FindDataSet(nil, DataSets[i].DataSetName);
      DataSets[i].DataSet := DS;
    end;

    { fixup properties}
    while FixupList.Count > 0 do
    begin
      lItem := TfrxFixupItem(FixupList[0]);
      Ref := Self.FindObject(lItem.Value);
      if Ref = nil then
        Ref := frxFindComponent(Self, lItem.Value);
      if Ref <> nil then
        SetOrdProp(lItem.Obj, lItem.PropInfo, frxInteger(Ref));
      lItem.Free;
      FixupList.Delete(0);
    end;
  end
  else
    AssignAll(tempReport);

  FixupList.Free;
  tempReport.Free;
end;

procedure TfrxReport.SetPreviewOptions(const Value: TfrxPreviewOptions);
begin
  FPreviewOptions.Assign(Value);
end;

procedure TfrxReport.SetPrintOptions(const Value: TfrxPrintOptions);
begin
  FPrintOptions.Assign(Value);
end;

procedure TfrxReport.SetReportOptions(const Value: TfrxReportOptions);
begin
  FReportOptions.Assign(Value);
end;

procedure TfrxReport.SetStyles(const Value: TfrxStyles);
begin
  if Value <> nil then
  begin
    FStyles.Assign(Value);
    FStyles.Apply;
  end
  else
    FStyles.Clear;
end;

procedure TfrxReport.SetDataSet(const Value: TfrxDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
end;

procedure TfrxReport.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  FDataSet := FindDataSet(FDataSet, FDataSetName);
end;

function TfrxReport.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;

function TfrxReport.Calc(const Expr: String; AScript: TfsScript = nil): Variant;
var
  ErrorMsg: String;
  CalledFromScript: Boolean;
begin
  CalledFromScript := False;
  if frxInteger(AScript) = 1 then
  begin
    AScript := FScript;
    CalledFromScript := True;
  end;
  if AScript = nil then
    AScript := FScript;
  if not DoGetValue(Expr, Result) then
  begin
    Result := FExpressionCache.Calc(Expr, ErrorMsg, AScript);
    if (ErrorMsg <> '') and
     not ((ErrorMsg = SZeroDivide) and FEngineOptions.IgnoreDevByZero) then
    begin
      if not CalledFromScript then
      begin
        if FCurObject <> '' then
          ErrorMsg := FCurObject + ': ' + ErrorMsg;
        FErrors.Add(ErrorMsg);
      end
      else ErrorMsg := frxResources.Get('clErrorInExp') + ErrorMsg;
      raise Exception.Create(ErrorMsg);
    end;
  end;
end;

function TfrxReport.GetAlias(DataSet: TfrxDataSet): String;
var
  ds: TfrxDataSetItem;
begin
  if DataSet = nil then
  begin
    Result := '';
    Exit;
  end;

  ds := DataSets.Find(DataSet);
  if ds <> nil then
    Result := ds.DataSet.UserName else
    Result := frxResources.Get('clDSNotIncl');
end;

function TfrxReport.GetDataset(const Alias: String): TfrxDataset;
var
  ds: TfrxDataSetItem;
begin
  ds := DataSets.Find(Alias);
  if ds <> nil then
    Result := ds.DataSet else
    Result := nil;
end;

procedure TfrxReport.GetDatasetAndField(const ComplexName: String;
  var DataSet: TfrxDataSet; var Field: String);
var
  i: Integer;
  s: String;
begin
  DataSet := nil;
  Field := '';

  { ComplexName has format: dataset name."field name"
    Spaces are allowed in both parts of the complex name }
  i := Pos('."', ComplexName);
  if i <> 0 then
  begin
    s := Copy(ComplexName, 1, i - 1); { dataset name }
    DataSet := GetDataSet(s);
    Field := Copy(ComplexName, i + 2, Length(ComplexName) - i - 2);
  end;
end;

procedure TfrxReport.GetDataSetList(List: TStrings; OnlyDB: Boolean = False);
var
  i: Integer;
begin
  List.Clear;
  for i := 0 to DataSets.Count - 1 do
    if Datasets[i].DataSet <> nil then
      if not OnlyDB or not (DataSets[i].DataSet is TfrxUserDataSet) then
        List.AddObject(DataSets[i].DataSet.UserName, DataSets[i].DataSet);
end;

procedure TfrxReport.GetActiveDataSetList(List: TStrings);
var
  i: Integer;
  ds: TfrxDataSet;
begin
  if EngineOptions.FUseGlobalDataSetList then
    frxGetDataSetList(List)
  else
  begin
    List.Clear;
    for i := 0 to EnabledDataSets.Count - 1 do
    begin
      ds := EnabledDataSets[i].DataSet;
      if ds <> nil then
        List.AddObject(ds.UserName, ds);
    end;
  end;
end;

procedure TfrxReport.DoLoadFromStream;
var
  SaveLeftTop: Longint;
  Loaded: Boolean;
begin
  SaveLeftTop := DesignInfo;
  Loaded := False;
  if Assigned(frxConverter.OnLoad) then
    Loaded := frxConverter.OnLoad(Self, FLoadStream);
  if not Loaded then
    inherited LoadFromStream(FLoadStream);
  if Assigned(frxConverter.OnAfterLoad) then
    frxConverter.OnAfterLoad(Self);
  DesignInfo := SaveLeftTop;
end;

procedure TfrxReport.CheckDataPage;
var
  i, x: Integer;
  l: TList;
  hasDataPage, hasDataObjects: Boolean;
  p: TfrxDataPage;
  c: TfrxComponent;
begin
  { check if report has datapage and datacomponents }
  hasDataPage := False;
  hasDataObjects := False;
  l := AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if c is TfrxDataPage then
      hasDataPage := True;
    if c is TfrxDialogComponent then
      hasDataObjects := True;
  end;

  if not hasDataPage then
  begin
    { create the datapage }
    p := TfrxDataPage.Create(Self);
    if FindObject('Data') = nil then
      p.Name := 'Data'
    else
      p.CreateUniqueName;

    { make it the first page }
    Objects.Delete(Objects.Count - 1);
    Objects.Insert(0, p);

    { move existing datacomponents to this page }
    if hasDataObjects then
    begin
      x := 60;
      for i := 0 to l.Count - 1 do
      begin
        c := l[i];
        if c is TfrxDialogComponent then
        begin
          c.Parent := p;
          c.Left := x;
          c.Top := 20;
          Inc(x, 64);
        end;
      end;
    end;
  end;
end;

procedure TfrxReport.LoadFromStream(Stream: TStream);
var
  Compressor: TfrxCustomCompressor;
  Crypter: TfrxCustomCrypter;
  SaveEngineOptions: TfrxEngineOptions;
  SavePreviewOptions: TfrxPreviewOptions;
  SaveConvertNulls: Boolean;
  SaveIgnoreDevByZero: Boolean;
  SaveDoublePass: Boolean;
  SaveOutlineVisible, SaveOutlineExpand: Boolean;
  SaveOutlineWidth, SavePagesInCache: Integer;
  SaveIni: String;
  SavePreview: TfrxCustomPreview;
  SaveOldStyleProgress, SaveShowProgress, SaveStoreInDFM: Boolean;
  Crypted, SaveThumbnailVisible: Boolean;

  function DecodePwd(const s: String): String;
  var
    i: Integer;
  begin
    Result := '';
    for i := 1 to Length(s) do
      Result := Result + Chr(Ord(s[i]) + 10);
  end;

begin
  FErrors.Clear;

  Compressor := nil;
  if frxCompressorClass <> nil then
  begin
    Compressor := TfrxCustomCompressor(frxCompressorClass.NewInstance);
    Compressor.Create(nil);
    Compressor.Report := Self;
    Compressor.IsFR3File := True;
    try
      Compressor.CreateStream;
      if Compressor.Decompress(Stream) then
        Stream := Compressor.Stream;
    except
      Compressor.Free;
      FErrors.Add(frxResources.Get('clDecompressError'));
      frxCommonErrorHandler(Self, frxResources.Get('clErrors') + #13#10 + FErrors.Text);
      Exit;
    end;
  end;

  ReportOptions.Password := ReportOptions.HiddenPassword;
  Crypter := nil;
  Crypted := False;
  if frxCrypterClass <> nil then
  begin
    Crypter := TfrxCustomCrypter(frxCrypterClass.NewInstance);
    Crypter.Create(nil);
    try
      Crypter.CreateStream;
      Crypted := Crypter.Decrypt(Stream, AnsiString(ReportOptions.Password));
      if Crypted then
        Stream := Crypter.Stream;
    except
      Crypter.Free;
      FErrors.Add(frxResources.Get('clDecryptError'));
      frxCommonErrorHandler(Self, frxResources.Get('clErrors') + #13#10 + FErrors.Text);
      Exit;
    end;
  end;

  SaveEngineOptions := TfrxEngineOptions.Create;
  SaveEngineOptions.Assign(FEngineOptions);
  SavePreviewOptions := TfrxPreviewOptions.Create;
  SavePreviewOptions.Assign(FPreviewOptions);
  SaveIni := FIniFile;
  SavePreview := FPreview;
  SaveOldStyleProgress := FOldStyleProgress;
  SaveShowProgress := FShowProgress;
  SaveStoreInDFM := FStoreInDFM;
  FStreamLoaded := True;
  try
    FLoadStream := Stream;
    try
      DoLoadFromStream;
    except
      on E: Exception do
      begin
        FStreamLoaded := False;
        if (E is TfrxInvalidXMLException) and Crypted then
          FErrors.Add('Invalid password')
       else
         FErrors.Add(E.Message)
      end;
    end;
  finally
    if Compressor <> nil then
      Compressor.Free;
    if Crypter <> nil then
      Crypter.Free;

    CheckDataPage;

    SaveConvertNulls := FEngineOptions.ConvertNulls;
    SaveIgnoreDevByZero := FEngineOptions.IgnoreDevByZero;
    SaveDoublePass := FEngineOptions.DoublePass;
    FEngineOptions.Assign(SaveEngineOptions);
    FEngineOptions.ConvertNulls := SaveConvertNulls;
    FEngineOptions.IgnoreDevByZero := SaveIgnoreDevByZero; 
    FEngineOptions.DoublePass := SaveDoublePass;
    SaveEngineOptions.Free;

    SaveOutlineVisible := FPreviewOptions.OutlineVisible;
    SaveOutlineWidth := FPreviewOptions.OutlineWidth;
    SaveOutlineExpand := FPreviewOptions.OutlineExpand;
    SavePagesInCache := FPreviewOptions.PagesInCache;
    SaveThumbnailVisible := FPreviewOptions.ThumbnailVisible;
    FPreviewOptions.Assign(SavePreviewOptions);
    FPreviewOptions.OutlineVisible := SaveOutlineVisible;
    FPreviewOptions.OutlineWidth := SaveOutlineWidth;
    FPreviewOptions.OutlineExpand := SaveOutlineExpand;
    FPreviewOptions.PagesInCache := SavePagesInCache;
    FPreviewOptions.ThumbnailVisible := SaveThumbnailVisible;
    SavePreviewOptions.Free;
    FIniFile := SaveIni;
    FPreview := SavePreview;
    FOldStyleProgress := SaveOldStyleProgress;
    FShowProgress := SaveShowProgress;
    FStoreInDFM := SaveStoreInDFM;
    if not Crypted then
      ReportOptions.Password := DecodePwd(ReportOptions.Password);

    if ReportOptions.Info or ((not FReloading) and
       (not FEngineOptions.EnableThreadSafe) and
       (not Crypted and not FReportOptions.CheckPassword)) then

      Clear
    else if (FErrors.Count > 0) then
      frxCommonErrorHandler(Self, frxResources.Get('clErrors') + #13#10 + FErrors.Text);
  end;
end;

procedure TfrxReport.SaveToStream(Stream: TStream; SaveChildren: Boolean = True;
  SaveDefaultValues: Boolean = False; UseGetAncestor: Boolean = False);
var
  Compressor: TfrxCustomCompressor;
  Crypter: TfrxCustomCrypter;
  StreamTo: TStream;
  SavePwd: String;
  SavePreview: TfrxCustomPreview;

  function EncodePwd(const s: String): String;
  var
    i: Integer;
  begin
    Result := '';
    for i := 1 to Length(s) do
      Result := Result + Chr(Ord(s[i]) - 10);
  end;

begin
  StreamTo := Stream;

  Compressor := nil;
  if FReportOptions.Compressed and (frxCompressorClass <> nil) then
  begin
    Compressor := TfrxCustomCompressor(frxCompressorClass.NewInstance);
    Compressor.Create(nil);
    Compressor.Report := Self;
    Compressor.IsFR3File := True;
    Compressor.CreateStream;
    StreamTo := Compressor.Stream;
  end;

  Crypter := nil;
  if (FReportOptions.Password <> '') and (frxCrypterClass <> nil) then
  begin
    Crypter := TfrxCustomCrypter(frxCrypterClass.NewInstance);
    Crypter.Create(nil);
    Crypter.CreateStream;
    StreamTo := Crypter.Stream;
  end;

  SavePwd := ReportOptions.Password;
  ReportOptions.PrevPassword := SavePwd;
  if Crypter = nil then
    ReportOptions.Password := EncodePwd(SavePwd);
  SavePreview := FPreview;
  FPreview := nil;

  try
    inherited SaveToStream(StreamTo, SaveChildren, SaveDefaultValues);
  finally
    FPreview := SavePreview;
    ReportOptions.Password := SavePwd;
    { crypt }
    if Crypter <> nil then
    begin
      try
        if Compressor <> nil then
          Crypter.Crypt(Compressor.Stream, UTF8Encode(ReportOptions.Password))
        else
          Crypter.Crypt(Stream, UTF8Encode(ReportOptions.Password));
      finally
        Crypter.Free;
      end;
    end;
    { compress }
    if Compressor <> nil then
    begin
      try
        Compressor.Compress(Stream);
      finally
        Compressor.Free;
      end;
    end;
  end;
end;

function TfrxReport.LoadFromFile(const FileName: String;
  ExceptionIfNotFound: Boolean = False): Boolean;
var
  f: TFileStream;
begin
  Clear;
  FFileName := '';
  Result := FileExists(FileName);
  if Result or ExceptionIfNotFound then
  begin
    f := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      FFileName := FileName;
      LoadFromStream(f);

    finally
      f.Free;
    end;
  end;
end;

procedure TfrxReport.SaveToFile(const FileName: String);
var
  f: TFileStream;
begin
  //fix up ParentReport property
  if (Length(FParentReport) > 1) and (FParentReport[2] = ':') then
    FParentReport := ExtractRelativePath(ExtractFilePath(FileName), FParentReport);
  f := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(f);
  finally
    f.Free;
  end;
end;

function TfrxReport.GetIniFile: TCustomIniFile;
var
  fileName: String;
begin
  fileName := FIniFile;
  if fileName = '' then
    fileName := GetHomePath + PathDelim + 'FastReportFMX.config';
  Result := TIniFile.Create(fileName);
end;

function TfrxReport.GetApplicationFolder: String;
begin
  if csDesigning in ComponentState then
    Result := GetCurrentDir + '\'
  else
    Result := GetAppPath;
end;

procedure TfrxReport.SelectPrinter;
begin
  if frxPrinters.IndexOf(FPrintOptions.Printer) <> -1 then
    frxPrinters.PrinterIndex := frxPrinters.IndexOf(FPrintOptions.Printer);
end;

procedure TfrxReport.DoNotifyEvent(Obj: TObject; const EventName: String;
  RunAlways: Boolean = False);
begin
{$IFNDEF FR_VER_BASIC}
  if FEngine.Running or RunAlways then
    if EventName <> '' then
    begin
      FScript.CallFunction(EventName, VarArrayOf([frxInteger(Obj)]));
    end;
{$ENDIF}
end;

procedure TfrxReport.DoParamEvent(const EventName: String; var Params: Variant;
  RunAlways: Boolean = False);
begin
{$IFNDEF FR_VER_BASIC}
  if FEngine.Running or RunAlways then
    if EventName <> '' then
      FScript.CallFunction1(EventName, Params);
{$ENDIF}
end;

procedure TfrxReport.DoBeforePrint(c: TfrxReportComponent);
begin
  if Assigned(FOnBeforePrint) then
    FOnBeforePrint(c);
  DoNotifyEvent(c, c.OnBeforePrint);
end;

procedure TfrxReport.DoAfterPrint(c: TfrxReportComponent);
begin
  if Assigned(FOnAfterPrint) then
    FOnAfterPrint(c);
  DoNotifyEvent(c, c.OnAfterPrint);
end;

procedure TfrxReport.DoPreviewClick(v: TfrxView; Button: TMouseButton;
  Shift: TShiftState; var Modified: Boolean; DblClick: Boolean);
var
  arr: Variant;
begin
  arr := VarArrayOf([frxInteger(v), Button, ShiftToByte(Shift), Modified]);
  if DblClick then
    DoParamEvent(v.OnPreviewDblClick, arr, True)
  else
    DoParamEvent(v.OnPreviewClick, arr, True);
  Modified := arr[3];
  if DblClick then
  begin
    if Assigned(FOnDblClickObject) then
      FOnDblClickObject(v, Button, Shift, Modified)
  end
  else
    if Assigned(FOnClickObject) then
      FOnClickObject(v, Button, Shift, Modified);
end;

procedure TfrxReport.DoGetAncestor(const Name: String; var Ancestor: TPersistent);
begin
  if FParentReportObject <> nil then
  begin
    if Name = Self.Name then
      Ancestor := FParentReportObject
    else
      Ancestor := FParentReportObject.FindObject(Name);
  end;
end;

function TfrxReport.DoGetValue(const Expr: String; var Value: Variant): Boolean;
var
  i: Integer;
  ds: TfrxDataSet;
  fld: String;
  val: Variant;
  v: TfsCustomVariable;
begin
  Result := False;
  Value := Null;

  { maybe it's a dataset/field? }
  GetDataSetAndField(Expr, ds, fld);
  if (ds <> nil) and (fld <> '') then
  begin
    Value := ds.Value[fld];
    if FEngineOptions.ConvertNulls and (Value = Null) then
      case ds.FieldType[fld] of
        fftNumeric:
          Value := 0;
        fftString:
          Value := '';
        fftBoolean:
          Value := False;
      end;
    Result := True;
    Exit;
  end;

  { searching in the sys variables }
  i := FSysVariables.IndexOf(Expr);
  if i <> -1 then
  begin
    case i of
      0: Value := FEngine.StartDate;  { Date }
      1: Value := FEngine.StartTime;  { Time }
      2: Value := FPreviewPages.GetLogicalPageNo; { Page }
      3: Value := FPreviewPages.CurPage + 1;  { Page# }
      4: Value := FPreviewPages.GetLogicalTotalPages;  { TotalPages }
      5: Value := FEngine.TotalPages;  { TotalPages# }
      6: Value := FEngine.CurLine;  { Line }
      7: Value := FEngine.CurLineThrough; { Line# }
      8: Value := frxGlobalVariables['CopyName0'];
    end;
    Result := True;
    Exit;
  end;

  { value supplied by OnGetValue event }
  TVarData(val).VType := varEmpty;
  if Assigned(FOnGetValue) then
    FOnGetValue(Expr, val);
  if Assigned(FOnNewGetValue) then
    FOnNewGetValue(Self, Expr, val);
  if TVarData(val).VType <> varEmpty then
  begin
    Value := val;
    Result := True;
    Exit;
  end;

  { searching in the variables }
  i := FVariables.IndexOf(Expr);
  if i <> -1 then
  begin
    val := FVariables.Items[i].Value;
    if (TVarData(val).VType = varString) or (TVarData(val).VType = varOleStr) or (TVarData(val).VType = varUString) then
    begin
      if (Pos(#13#10, val) <> 0) or (Pos(System.sLineBreak, val) <> 0) then
        Value := val
      else
        Value := Calc(val);
    end
    else
      Value := val;
    Result := True;
    Exit;
  end;

  { searching in the global variables }
  i := frxGlobalVariables.IndexOf(Expr);
  if i <> -1 then
  begin
    Value := frxGlobalVariables.Items[i].Value;
    Result := True;
    Exit;
  end;

  { searching in the script }
  v := FScript.FindLocal(Expr);
  if (v <> nil) and
    not ((v is TfsProcVariable) or (v is TfsMethodHelper)) then
  begin
    Value := v.Value;
    Result := True;
    Exit;
  end;
end;

function TfrxReport.GetScriptValue(Instance: TObject; ClassType: TClass;
  const MethodName: String; var Params: Variant): Variant;
var
  i: Integer;
  s: String;
begin
  if not DoGetValue(Params[0], Result) then
  begin
    { checking aggregate functions }
    s := VarToStr(Params[0]);
    i := Pos('(', s);
    if i <> 0 then
    begin
      s := UpperCase(Trim(Copy(s, 1, i - 1)));
      if (s = 'SUM') or (s = 'MIN') or (s = 'MAX') or
         (s = 'AVG') or (s = 'COUNT') then
      begin
        Result := Calc(Params[0]);
        Exit;
      end;
    end;

    FErrors.Add(frxResources.Get('clUnknownVar') + ' ' + VarToStr(Params[0]));
  end;
end;

function TfrxReport.SetScriptValue(Instance: TObject; ClassType: TClass;
  const MethodName: String; var Params: Variant): Variant;
begin
  FVariables[Params[0]] := Params[1];
end;

function TfrxReport.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; var Params: Variant): Variant;
var
  p1, p2, p3: Variant;
begin
  if MethodName = 'IIF' then
  begin
    p1 := Params[0];
    p2 := Params[1];
    p3 := Params[2];
    try
      if Calc(p1, FScript.ProgRunning) = True then
        Result := Calc(p2, FScript.ProgRunning) else
        Result := Calc(p3, FScript.ProgRunning);
    except
    end;
  end
  else if (MethodName = 'SUM') or (MethodName = 'AVG') or
    (MethodName = 'MIN') or (MethodName = 'MAX') then
  begin
    p2 := Params[1];
    if Trim(VarToStr(p2)) = '' then
      p2 := 0
    else
      p2 := Calc(p2, FScript.ProgRunning);
    p3 := Params[2];
    if Trim(VarToStr(p3)) = '' then
      p3 := 0
    else
      p3 := Calc(p3, FScript.ProgRunning);
    Result := FEngine.GetAggregateValue(MethodName, Params[0],
      TfrxBand(frxInteger(p2)), p3);
  end
  else if MethodName = 'COUNT' then
  begin
    p1 := Params[0];
    if Trim(VarToStr(p1)) = '' then
      p1 := 0
    else
      p1 := Calc(p1, FScript.ProgRunning);
    p2 := Params[1];
    if Trim(VarToStr(p2)) = '' then
      p2 := 0
    else
      p2 := Calc(p2, FScript.ProgRunning);
    Result := FEngine.GetAggregateValue(MethodName, '',
      TfrxBand(frxInteger(p1)), p2);
  end
end;

function TfrxReport.DoUserFunction(Instance: TObject; ClassType: TClass;
  const MethodName: String; var Params: Variant): Variant;
begin
  if Assigned(FOnUserFunction) then
    Result := FOnUserFunction(MethodName, Params);
end;

function TfrxReport.PrepareScript: Boolean;
var
  i: Integer;
  l: TList;
  c: TfrxComponent;
begin
  FExpressionCache.Clear;
  FExpressionCache.FScriptLanguage := FScriptLanguage;
  FEngine.NotifyList.Clear;

  FScript.ClearItems(Self);
  FScript.AddedBy := Self;
  FScript.MainProg := True;
  try
    l := AllObjects;
    for i := 0 to l.Count - 1 do
    begin
      c := l[i];
      c.IsDesigning := False;
      c.BeforeStartReport;
      if c is TfrxPictureView then
        TfrxPictureView(c).FPictureChanged := True;
      FScript.AddObject(c.Name, c);
    end;

    FScript.AddObject('Report', Self);
    FScript.AddObject('Engine', FEngine);
    FScript.AddObject('Outline', FPreviewPages.Outline);
    FScript.AddVariable('Value', 'Variant', Null);
    FScript.AddVariable('Self', 'TfrxView', Null);
    FScript.AddMethod('function Get(Name: String): Variant', GetScriptValue);
    FScript.AddMethod('procedure Set(Name: String; Value: Variant)', SetScriptValue);
    FScript.AddMethod('macrofunction IIF(Expr: Boolean; TrueValue, FalseValue: Variant): Variant',
      CallMethod);
    FScript.AddMethod('macrofunction SUM(Expr: Variant; Band: Variant = 0; Flags: Integer = 0): Variant',
      CallMethod);
    FScript.AddMethod('macrofunction AVG(Expr: Variant; Band: Variant = 0; Flags: Integer = 0): Variant',
      CallMethod);
    FScript.AddMethod('macrofunction MIN(Expr: Variant; Band: Variant = 0; Flags: Integer = 0): Variant',
      CallMethod);
    FScript.AddMethod('macrofunction MAX(Expr: Variant; Band: Variant = 0; Flags: Integer = 0): Variant',
      CallMethod);
    FScript.AddMethod('macrofunction COUNT(Band: Variant = 0; Flags: Integer = 0): Variant',
      CallMethod);

    FLocalValue := FScript.Find('Value');
    FSelfValue := FScript.Find('Self');
    FScript.Lines := FScriptText;
    FScript.SyntaxType := FScriptLanguage;
  {$IFNDEF FR_VER_BASIC}
    Result := FScript.Compile;
    if not Result then
      FErrors.Add(Format(frxResources.Get('clScrError'),
        [FScript.ErrorPos, FScript.ErrorMsg]));
  {$ELSE}
    Result := True;
  {$ENDIF}
  finally
    FScript.AddedBy := nil;
  end;
end;

function TfrxReport.PrepareReport(ClearLastReport: Boolean = True): Boolean;
var
  TempStream: TStream;
  ErrorsText: String;
  ErrorMessage: String;
  SavePwd: String;
  SaveSplisLine: Integer;
  TmpFile: String;
  EngineRun: Boolean;

  function CheckDatasets: Boolean;
  var
    i: Integer;
  begin
    for i := 0 to FDataSets.Count - 1 do
      if FDatasets[i].DataSet = nil then
        FErrors.Add(Format(frxResources.Get('clDSNotExist'), [FDatasets[i].DataSetName]));
    Result := FErrors.Count = 0;
  end;

begin
  if ClearLastReport then
    PreviewPages.Clear;
  SaveSplisLine := 0;
  FErrors.Clear;
  FTerminated := False;
  Result := False;
  EngineRun := False;

  if CheckDatasets then
  begin
    TempStream := nil;
    SavePwd := ReportOptions.Password;

    { save the report state }
    if FEngineOptions.DestroyForms then
    begin
      if EngineOptions.UseFileCache then
      begin
        TmpFile := frxCreateTempFile(EngineOptions.TempDir);
        TempStream := TFileStream.Create(TmpFile, fmCreate);
      end
      else TempStream := TMemoryStream.Create;

      ReportOptions.Password := '';
      SaveSplisLine := PrintOptions.SplicingLine;
      SaveToStream(TempStream);
    end;

    try
      if Assigned(FOnBeginDoc) then
        FOnBeginDoc(Self);
      if PrepareScript then
      begin
{$IFNDEF FR_VER_BASIC}
        if Assigned(FOnAfterScriptCompile) then FOnAfterScriptCompile(Self);
        if FScript.Statement.Count > 0 then
          FScript.Execute;
{$ENDIF}
        if not Terminated then
          EngineRun := FEngine.Run;
        if EngineRun then
        begin
          if Assigned(FOnEndDoc) then
            FOnEndDoc(Self);
          Result := True
        end
        else if FPreviewForm <> nil then
          FPreviewForm.Close;
      end;
    except
      on e: Exception do
        FErrors.Add(e.Message);
    end;

    if FEngineOptions.DestroyForms then
    begin
      ErrorsText := FErrors.Text;
      TempStream.Position := 0;
      FReloading := True;
      try
//        if FEngineOptions.ReportThread = nil then
          LoadFromStream(TempStream);
      finally
        FReloading := False;
        ReportOptions.Password := SavePwd;
        PrintOptions.SplicingLine := SaveSplisLine;
      end;
      TempStream.Free;
      if EngineOptions.UseFileCache then
        DeleteFile(TmpFile);
      FErrors.Text := ErrorsText;
    end;
  end;

  if FErrors.Text <> '' then
  begin
    Result := False;
    ErrorMessage := frxResources.Get('clErrors') + #13#10 + FErrors.Text;
    frxCommonErrorHandler(Self, ErrorMessage);
  end;
end;

procedure TfrxReport.ShowPreparedReport;
begin
  FPreviewForm := nil;
  if FPreview <> nil then
  begin
    FPreview.FReport := Self;
    FPreview.FPreviewPages := FPreviewPages;
    FPreview.Init;
  end
  else
  begin
    FPreviewForm := TfrxPreviewForm.Create(Application);
    with TfrxPreviewForm(FPreviewForm) do
    begin
      Preview.FReport := Self;
      Preview.FPreviewPages := FPreviewPages;
      FPreview := Preview;
      Init;
      if Assigned(FOnPreview) then
        FOnPreview(Self);
      if PreviewOptions.Maximized then
        Position := TFormPosition.poDesigned;
      if FPreviewOptions.Modal then
      begin
        ShowModal;
        Free;
        FPreviewForm := nil;
      end
      else
      begin
        FreeOnClose := True;
        Show;
      end;
    end;
  end;
end;

procedure TfrxReport.ShowReport(ClearLastReport: Boolean = True);
begin
  if ClearLastReport then
    PreviewPages.Clear;

  if FOldStyleProgress then
  begin
    if PrepareReport(False) then
      ShowPreparedReport;
  end
  else
  begin
    FTimer.Enabled := True;
    ShowPreparedReport;
  end;
end;

procedure TfrxReport.OnTimer(Sender: TObject);
begin
  FTimer.Enabled := False;
  PrepareReport(False);
end;

{$HINTS OFF}

{$UNDEF FR_RUN_DESIGNER}

{$IFDEF FR_LITE}
  {$DEFINE FR_RUN_DESIGNER}
{$ENDIF}

{$IFNDEF FR_VER_BASIC}
  {$DEFINE FR_RUN_DESIGNER}
{$ENDIF}

procedure TfrxReport.DesignReport(Modal: Boolean = True; MDIChild: Boolean = False);
var
  l: TList;
  i: Integer;
  c: TfrxComponent;
begin
{$IFDEF FR_RUN_DESIGNER}
  if FDesigner <> nil then Exit;
  if frxDesignerClass <> nil then
  begin
    FScript.ClearItems(Self);
    l := AllObjects;
    for i := 0 to l.Count - 1 do
    begin
      c := l[i];
      if c is TfrxCustomDBDataset then
        c.BeforeStartReport;
    end;

    FModified := False;
    FDesigner := TfrxCustomDesigner(frxDesignerClass.NewInstance);
    FDesigner.CreateDesigner(nil, Self);
    FDesigner.FormShow(FDesigner);
    if Modal then
    begin
      FDesigner.ShowModal;
      FDesigner.Free;
      AppHandleMessage;
      FDesigner := nil;
    end
    else
    begin
      FDesigner.Show;
    end;
  end;
{$ENDIF}
end;
{$HINTS ON}

procedure TfrxReport.DesignReport(IDesigner: IUnknown; Editor: TObject);
var
  l: TList;
  i: Integer;
  c: TfrxComponent;
begin
  if FDesigner <> nil then
  begin
    FDesigner.Activate;
    Exit;
  end;
  if (IDesigner = nil) or (Editor.ClassName <> 'TfrxReportEditor') then Exit;

  l := AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if c is TfrxCustomDBDataset then
      c.BeforeStartReport;
  end;

  FDesigner := TfrxCustomDesigner(frxDesignerClass.NewInstance);
  FDesigner.CreateDesigner(nil, Self);
  FDesigner.FormShow(FDesigner);
  FDesigner.ShowModal;
  FreeAndNil(FDesigner);
end;

{$HINTS OFF}
function TfrxReport.DesignPreviewPage: Boolean;
begin
  Result := False;
{$IFNDEF FR_VER_BASIC}
  if FDesigner <> nil then
  begin
    FDesigner.Activate;
    Exit;
  end;
  if frxDesignerClass <> nil then
  begin
    FDesigner := TfrxCustomDesigner(frxDesignerClass.NewInstance);
    FDesigner.CreateDesigner(nil, Self, True);
    FDesigner.FormShow(FDesigner);
    FDesigner.ShowModal;
    Result := FModified;
    FreeAndNil(FDesigner);
  end;
{$ENDIF}
end;
{$HINTS ON}

function TfrxReport.Export(Filter: TfrxCustomExportFilter): Boolean;
begin
  Result := FPreviewPages.Export(Filter);
end;

function TfrxReport.Print: Boolean;
begin
  Result := FPreviewPages.Print;
end;

procedure TfrxReport.AddFunction(const FuncName: String;
  const Category: String = ''; const Description: String = '');
begin
  FScript.AddedBy := nil;
  FScript.AddMethod(FuncName, DoUserFunction, Category, Description);
end;

function TfrxReport.GetLocalValue: Variant;
begin
  Result := FLocalValue.Value;
end;

function TfrxReport.GetSelfValue: TfrxView;
begin
  Result := TfrxView(frxInteger(FSelfValue.Value));
end;

procedure TfrxReport.SetLocalValue(const Value: Variant);
begin
  FLocalValue.Value := Value;
end;

procedure TfrxReport.SetSelfValue(const Value: TfrxView);
begin
  FSelfValue.Value := frxInteger(Value);
end;

procedure TfrxReport.SetTerminated(const Value: Boolean);
begin
  FTerminated := Value;
  if Value then
    FScript.Terminate;
end;

procedure TfrxReport.SetPreview(const Value: TfrxCustomPreview);
begin
  if (FPreview <> nil) and (Value = nil) then
  begin
    FPreview.FReport := nil;
    FPreview.FPreviewPages := nil;
    FPreviewForm := nil;
  end;

  FPreview := Value;

  if FPreview <> nil then
  begin
    FPreview.FReport := Self;
    FPreview.FPreviewPages := FPreviewPages;
    if not (csDesigning in FPreview.ComponentState) then
      FPreview.Init;
  end;
end;

function TfrxReport.GetCaseSensitive: Boolean;
begin
  Result := FExpressionCache.CaseSensitive;
end;

function TfrxReport.GetScriptText: TStrings;
begin
  if (csWriting in ComponentState) and not FStoreInDFM then
    Result := FFakeScriptText
   else Result := FScriptText;
end;

procedure TfrxReport.SetCaseSensitive(const Value: Boolean);
begin
  FExpressionCache.CaseSensitive := Value;
end;

procedure TfrxReport.InternalOnProgressStart(ProgressType: TfrxProgressType);
begin
  if (FEngineOptions.EnableThreadSafe) then Exit; //(FEngineOptions.ReportThread <> nil) or

  if Assigned(FOnProgressStart) then
    FOnProgressStart(Self, ProgressType, 0);

  if OldStyleProgress or (ProgressType <> ptRunning) then
  begin
    if FShowProgress then
    begin
      if FProgress <> nil then
        FProgress.Free;
      FProgress := TfrxProgress.Create(nil);
      FProgress.Execute(0, '', True, False);
    end;
  end;

  if (FPreview <> nil) and (ProgressType = ptRunning) then
    FPreview.InternalOnProgressStart(Self, ProgressType, 0);
  AppHandleMessage;
end;

procedure TfrxReport.InternalOnProgress(ProgressType: TfrxProgressType;
  Progress: Integer);
begin
  if FEngineOptions.EnableThreadSafe then Exit;

  if Assigned(FOnProgress) then
    FOnProgress(Self, ProgressType, Progress);

  if OldStyleProgress or (ProgressType <> ptRunning) then
  begin
    if FShowProgress then
    begin
      case ProgressType of
        ptRunning:
          if not Engine.FinalPass then
            FProgress.Message := Format(frxResources.Get('prRunningFirst'), [Progress])
          else
            FProgress.Message := Format(frxResources.Get('prRunning'), [Progress]);
        ptPrinting:
          FProgress.Message := Format(frxResources.Get('prPrinting'), [Progress]);
        ptExporting:
          FProgress.Message := Format(frxResources.Get('prExporting'), [Progress]);
      end;
      if FProgress.Terminated then
        Terminated := True;
    end;
  end;

  if (FPreview <> nil) and (ProgressType = ptRunning) then
    FPreview.InternalOnProgress(Self, ProgressType, Progress - 1);
  AppHandleMessage;
end;

procedure TfrxReport.InternalOnProgressStop(ProgressType: TfrxProgressType);
begin
  if FEngineOptions.EnableThreadSafe then Exit;

  if Assigned(FOnProgressStop) then
    FOnProgressStop(Self, ProgressType, 0);

  if OldStyleProgress or (ProgressType <> ptRunning) then
  begin
    if FShowProgress then
    begin
      FProgress.Free;
      FProgress := nil;
    end;
  end;

  if (FPreview <> nil) and (ProgressType = ptRunning) then
    FPreview.InternalOnProgressStop(Self, ProgressType, 0);
  AppHandleMessage;
end;

procedure TfrxReport.SetProgressMessage(const Value: String; IsHint: Boolean);
begin
  if FEngineOptions.EnableThreadSafe then Exit;

  if OldStyleProgress and Engine.Running then
  begin
    if FShowProgress then
      FProgress.Message := Value
  end;

  if FPreviewForm <> nil then
    TfrxPreviewForm(FPreviewForm).SetMessageText(Value, IsHint);
  AppHandleMessage;
end;

procedure TfrxReport.SetVersion(const Value: String);
begin
  FVersion := FR_VERSION;
end;


{ TfrxCustomDesigner }

constructor TfrxCustomDesigner.CreateDesigner(AOwner: TComponent;
  AReport: TfrxReport; APreviewDesigner: Boolean);
begin
  inherited Create(AOwner);
  FReport := AReport;
  FIsPreviewDesigner := APreviewDesigner;
  FObjects := TList.Create;
  FSelectedObjects := TList.Create;
end;

destructor TfrxCustomDesigner.Destroy;
begin
  FObjects.Free;
  FSelectedObjects.Free;
  inherited;
end;

procedure TfrxCustomDesigner.SetModified(const Value: Boolean);
begin
  FModified := Value;
  if Value then
    FReport.Modified := True;
end;

procedure TfrxCustomDesigner.SetPage(const Value: TfrxPage);
begin
  FPage := Value;
end;


{ TfrxCustomEngine }

procedure TfrxCustomEngine.BreakAllKeep;
begin
// do nothing
end;

constructor TfrxCustomEngine.Create(AReport: TfrxReport);
begin
  FReport := AReport;
  FNotifyList := TList.Create;
end;

destructor TfrxCustomEngine.Destroy;
begin
  FNotifyList.Free;
  inherited;
end;

function TfrxCustomEngine.GetDoublePass: Boolean;
begin
  Result := FReport.EngineOptions.DoublePass;
end;

procedure TfrxCustomEngine.ShowBandByName(const BandName: String);
begin
  ShowBand(TfrxBand(Report.FindObject(BandName)));
end;

procedure TfrxCustomEngine.StopReport;
begin
  Report.Terminated := True;
end;

function TfrxCustomEngine.GetPageHeight: Double;
begin
  Result := FPageHeight;
end;


{ TfrxCustomOutline }

constructor TfrxCustomOutline.Create(APreviewPages: TfrxCustomPreviewPages);
begin
  FPreviewPages := APreviewPages;
end;

function TfrxCustomOutline.Engine: TfrxCustomEngine;
begin
  Result := FPreviewPages.Engine;
end;

{ TfrxCustomPreviewPages }

constructor TfrxCustomPreviewPages.Create(AReport: TfrxReport);
begin
  FReport := AReport;
  FOutline := TfrxOutline.Create(Self);
end;

destructor TfrxCustomPreviewPages.Destroy;
begin
  FOutline.Free;
  inherited;
end;


{ TfrxExpressionCache }

constructor TfrxExpressionCache.Create(AScript: TfsScript);
begin
  FExpressions := TStringList.Create;
  FExpressions.Sorted := True;
  FScript := TfsScript.Create(nil);
  FScript.ExtendedCharset := True;
  FMainScript := AScript;
end;

destructor TfrxExpressionCache.Destroy;
begin
  FExpressions.Free;
  FScript.Free;
  inherited;
end;

procedure TfrxExpressionCache.Clear;
begin
  FExpressions.Clear;
  FScript.Clear;
end;

function TfrxExpressionCache.Calc(const Expression: String;
  var ErrorMsg: String; AScript: TfsScript): Variant;
var
  i: Integer;
  v: TfsProcVariable;
  Compiled: Boolean;
begin
  ErrorMsg := '';
  FScript.Parent := AScript;
  i := FExpressions.IndexOf(Expression);
  if i = -1 then
  begin
    i := FExpressions.Count;
    FScript.SyntaxType := FScriptLanguage;
    if CompareText(FScriptLanguage, 'PascalScript') = 0 then
      FScript.Lines.Text := 'function fr3f' + IntToStr(i) + ': Variant; begin ' +
        'Result := ' + Expression + ' end; begin end.'
    else if CompareText(FScriptLanguage, 'C++Script') = 0 then
      FScript.Lines.Text := 'Variant fr3f' + IntToStr(i) + '() { ' +
        'return ' + Expression + '; } {}'
    else if CompareText(FScriptLanguage, 'BasicScript') = 0 then
      FScript.Lines.Text := 'function fr3f' + IntToStr(i) + #13#10 +
        'return ' + Expression + #13#10 + 'end function'
    else if CompareText(FScriptLanguage, 'JScript') = 0 then
      FScript.Lines.Text := 'function fr3f' + IntToStr(i) + '() { ' +
        'return ' + Expression + '; }';

    Compiled := FScript.Compile;
    v := TfsProcVariable(FScript.Find('fr3f' + IntToStr(i)));

    if not Compiled then
    begin
      if v <> nil then
      begin
        v.Free;
        FScript.Remove(v);
      end;
      ErrorMsg := frxResources.Get('clExprError') + ' ''' + Expression + ''': ' +
        FScript.ErrorMsg;
      Result := Null;
      Exit;
    end;

    FExpressions.AddObject(Expression, v);
  end
  else
    v := TfsProcVariable(FExpressions.Objects[i]);
  FMainScript.MainProg := False;
  try
    try
      Result := v.Value;
    except
      on e: Exception do
        ErrorMsg := e.Message;
    end;
  finally
    FMainScript.MainProg := True;
  end;
end;

function TfrxExpressionCache.GetCaseSensitive: Boolean;
begin
  Result := FExpressions.CaseSensitive;
end;

procedure TfrxExpressionCache.SetCaseSensitive(const Value: Boolean);
begin
  FExpressions.CaseSensitive := Value;
end;


{ TfrxCustomExportFilter }

constructor TfrxCustomExportFilter.Create(AOwner: TComponent);
begin
  inherited;
  if not FNoRegister then
    frxExportFilters.Register(Self);
  FShowDialog := True;
  FUseFileCache := True;
  FDefaultPath := '';
  FShowProgress := True;
  FSlaveExport := False;
  FOverwritePrompt := False;
  FFiles := nil;
end;

constructor TfrxCustomExportFilter.CreateNoRegister;
begin
  FNoRegister := True;
  Create(nil);
end;

destructor TfrxCustomExportFilter.Destroy;
begin
  if not FNoRegister then
    frxExportFilters.Unregister(Self);
  if FFiles <> nil then
    FFiles.Free;
  inherited;
end;

class function TfrxCustomExportFilter.GetDescription: String;
begin
  Result := '';
end;

procedure TfrxCustomExportFilter.Finish;
begin
//
end;

procedure TfrxCustomExportFilter.FinishPage(Page: TfrxReportPage;
  Index: Integer);
begin
//
end;

function TfrxCustomExportFilter.ShowModal: TModalResult;
begin
  Result := mrOk;
end;

function TfrxCustomExportFilter.Start: Boolean;
begin
  Result := True;
end;

procedure TfrxCustomExportFilter.StartPage(Page: TfrxReportPage;
  Index: Integer);
begin
//
end;


{ TfrxCustomWizard }

constructor TfrxCustomWizard.Create(AOwner: TComponent);
begin
  inherited;
  FDesigner := TfrxCustomDesigner(AOwner);
  FReport := FDesigner.Report;
end;

class function TfrxCustomWizard.GetDescription: String;
begin
  Result := '';
end;


{ TfrxCustomCompressor }

constructor TfrxCustomCompressor.Create(AOwner: TComponent);
begin
  inherited;
  FOldCompressor := frxCompressorClass;
  frxCompressorClass := TfrxCompressorClass(ClassType);
end;

destructor TfrxCustomCompressor.Destroy;
begin
  frxCompressorClass := FOldCompressor;
  if FStream <> nil then
    FStream.Free;
  if FTempFile <> '' then
    DeleteFile(FTempFile);
  inherited;
end;

procedure TfrxCustomCompressor.CreateStream;
begin
  if FIsFR3File or not FReport.EngineOptions.UseFileCache then
    FStream := TMemoryStream.Create
  else
  begin
    FTempFile := frxCreateTempFile(FReport.EngineOptions.TempDir);
    FStream := TFileStream.Create(FTempFile, fmCreate);
  end;
end;


{ TfrxCustomCrypter }

constructor TfrxCustomCrypter.Create(AOwner: TComponent);
begin
  inherited;
  frxCrypterClass := TfrxCrypterClass(ClassType);
end;

destructor TfrxCustomCrypter.Destroy;
begin
  if FStream <> nil then
    FStream.Free;
  inherited;
end;

procedure TfrxCustomCrypter.CreateStream;
begin
  FStream := TMemoryStream.Create;
end;


{ TfrxGlobalDataSetList }

constructor TfrxGlobalDataSetList.Create;
begin
{$IFNDEF NO_CRITICAL_SECTION}
  FCriticalSection := TCriticalSection.Create;
{$ENDIF}
  inherited;
end;

destructor TfrxGlobalDataSetList.Destroy;
begin
{$IFNDEF NO_CRITICAL_SECTION}
  FCriticalSection.Free;
  FCriticalSection := nil;
{$ENDIF}
  inherited;
end;

procedure TfrxGlobalDataSetList.Lock;
begin
{$IFNDEF NO_CRITICAL_SECTION}
  if FCriticalSection <> nil then
    FCriticalSection.Enter;
{$ENDIF}
end;

procedure TfrxGlobalDataSetList.Unlock;
begin
{$IFNDEF NO_CRITICAL_SECTION}
  if FCriticalSection <> nil then
    FCriticalSection.Leave;
{$ENDIF}
end;

initialization
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TfrxComponent, TFmxObject);
  GroupDescendentsWith(TfrxDBComponents, TFmxObject);
  GroupDescendentsWith(TfrxCustomCrypter, TFmxObject);
  GroupDescendentsWith(TfrxCustomCompressor, TFmxObject);
  GroupDescendentsWith(TfrxCustomExportFilter, TFmxObject);
  GroupDescendentsWith(TfrxCustomWizard, TFmxObject);
  GroupDescendentsWith(TfrxFrame, TFmxObject);
  GroupDescendentsWith(TfrxHighlight, TFmxObject);
  GroupDescendentsWith(TfrxStyleItem, TFmxObject);
{$IFNDEF DELPHI20}
  GlobalUseDirect2D := False;
{$ENDIF}
{$IFNDEF NO_CRITICAL_SECTION}
  frxCS := TCriticalSection.Create;
{$ENDIF}
  frxConverter := TfrxConverterEvents.Create;
  DatasetList := TfrxGlobalDataSetList.Create;
  frxGlobalVariables := TfrxVariables.Create;

  RegisterFmxClasses([
    TfrxChild, TfrxColumnFooter, TfrxColumnHeader, TfrxCustomMemoView, TfrxMasterData,
    TfrxDetailData, TfrxSubDetailData, TfrxDataBand4, TfrxDataBand5, TfrxDataBand6,
    TfrxDialogPage, TfrxFooter, TfrxFrame, TfrxGroupFooter, TfrxGroupHeader,
    TfrxHeader, TfrxHighlight, TfrxLineView, TfrxMemoView, TfrxOverlay, TfrxPageFooter,
    TfrxPageHeader, TfrxPictureView, TfrxReport, TfrxReportPage, TfrxReportSummary,
    TfrxReportTitle, TfrxShapeView, TfrxSubreport, TfrxSysMemoView, TfrxStyleItem,
    TfrxNullBand, TfrxCustomLineView, TfrxDataPage]);


  frxResources.UpdateFSResources;


finalization
{$IFNDEF NO_CRITICAL_SECTION}
  frxCS.Free;
{$ENDIF}
  frxGlobalVariables.Free;
  DatasetList.Free;
  frxConverter.Free;
end.



//56db3b0f55102b9488a240d37950543f