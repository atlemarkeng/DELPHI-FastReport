
{******************************************}
{                                          }
{             FastReport v4.0              }
{                Designer                  }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxDesgn;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, System.Types, FMX.Types, FMX.Objects, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.Menus, FMX.frxClass, FMX.frxCtrls, FMX.frxDesgnCtrls, FMX.frxDesgnWorkspace,
  FMX.frxInsp, FMX.frxDialogForm, FMX.frxDataTree, FMX.frxReportTree, FMX.fs_SynMemo,
  FMX.fs_iinterpreter, FMX.Printer, FMX.frxWatchForm, FMX.frxPictureCache, System.Variants, 
  FMX.TabControl, FMX.frxFMX, FMX.Layouts, FMX.Edit, System.UIConsts
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF}
{$IFDEF DELPHI20}
  , System.Math.Vectors
{$ENDIF}
{$IFDEF DELPHI21}
  , FMX.ComboEdit, FMX.Controls.Presentation
{$ENDIF};

type
  TfrxDesignerUnits = (duCM, duInches, duPixels, duChars);
  TfrxLoadReportEvent = function(Report: TfrxReport): Boolean of object;
  TfrxLoadRecentReportEvent = function(Report: TfrxReport; FileName: String): Boolean of object;
  TfrxSaveReportEvent = function(Report: TfrxReport; SaveAs: Boolean): Boolean of object;
  TfrxGetTemplateListEvent = procedure(List: TStrings) of object;
  TfrxDesignerRestriction =
    (drDontInsertObject, drDontDeletePage, drDontCreatePage, drDontChangePageOptions,
     drDontCreateReport, drDontLoadReport, drDontSaveReport,
     drDontPreviewReport, drDontEditVariables, drDontChangeReportOptions,
     drDontEditReportData, drDontShowRecentFiles, drDontEditReportScript, drDontEditInternalDatasets);
  TfrxDesignerRestrictions = set of TfrxDesignerRestriction;
  TSampleFormat = class;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxDesigner = class(TComponent)
  private
    FCloseQuery: Boolean;
    FDefaultScriptLanguage: String;
    FDefaultFont: TfrxFont;
    FDefaultLeftMargin: Double;
    FDefaultBottomMargin: Double;
    FDefaultRightMargin: Double;
    FDefaultTopMargin: Double;
    FDefaultPaperSize: Integer;
    FDefaultOrientation: TPrinterOrientation;
    FOpenDir: String;
    FSaveDir: String;
    FTemplatesExt: String;
    FTemplateDir: String;
    FStandalone: Boolean;
    FRestrictions: TfrxDesignerRestrictions;
    FRTLLanguage: Boolean;
    FMemoParentFont: Boolean;
    FOnLoadReport: TfrxLoadReportEvent;
    FOnLoadRecentReport: TfrxLoadRecentReportEvent;
    FOnSaveReport: TfrxSaveReportEvent;
    FOnShow: TNotifyEvent;
    FOnInsertObject: TNotifyEvent;
    FOnGetTemplateList: TfrxGetTemplateListEvent;
    FOnShowStartupScreen: TNotifyEvent;
    procedure SetDefaultFont(const Value: TfrxFont);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CloseQuery: Boolean read FCloseQuery write FCloseQuery default True;
    property DefaultScriptLanguage: String read FDefaultScriptLanguage write FDefaultScriptLanguage;
    property DefaultFont: TfrxFont read FDefaultFont write SetDefaultFont;
    property DefaultLeftMargin: Double read FDefaultLeftMargin write FDefaultLeftMargin;
    property DefaultRightMargin: Double read FDefaultRightMargin write FDefaultRightMargin;
    property DefaultTopMargin: Double read FDefaultTopMargin write FDefaultTopMargin;
    property DefaultBottomMargin: Double read FDefaultBottomMargin write FDefaultBottomMargin;
    property DefaultPaperSize: Integer read FDefaultPaperSize write FDefaultPaperSize;
    property DefaultOrientation: TPrinterOrientation read FDefaultOrientation write FDefaultOrientation;
    property OpenDir: String read FOpenDir write FOpenDir;
    property SaveDir: String read FSaveDir write FSaveDir;
    property TemplatesExt: String read FTemplatesExt write FTemplatesExt;
    property TemplateDir: String read FTemplateDir write FTemplateDir;
    property Standalone: Boolean read FStandalone write FStandalone default False;
    property Restrictions: TfrxDesignerRestrictions read FRestrictions write FRestrictions;
    property RTLLanguage: Boolean read FRTLLanguage write FRTLLanguage;
    property MemoParentFont: Boolean read FMemoParentFont write FMemoParentFont;
    property OnLoadReport: TfrxLoadReportEvent read FOnLoadReport write FOnLoadReport;
    property OnLoadRecentReport: TfrxLoadRecentReportEvent read FOnLoadRecentReport write FOnLoadRecentReport;
    property OnSaveReport: TfrxSaveReportEvent read FOnSaveReport write FOnSaveReport;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnInsertObject: TNotifyEvent read FOnInsertObject write FOnInsertObject;
    property OnShowStartupScreen: TNotifyEvent read FOnShowStartupScreen write FOnShowStartupScreen;
    property OnGetTemplateList: TfrxGetTemplateListEvent read FOnGetTemplateList write FOnGetTemplateList;
  end;

  TfrxDesignerForm = class(TfrxCustomDesigner)
    StatusBar: TStatusBar;
    PagePopup: TPopupMenu;
    MainMenu: TMenuBar;
    FileMenu: TMenuItem;
    EditMenu: TMenuItem;
    ViewMenu: TMenuItem;
    OptionsMI: TMenuItem;
    HelpMenu: TMenuItem;
    AboutMI: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    TabPopup: TPopupMenu;
    NewPageMI1: TMenuItem;
    NewDialogMI1: TMenuItem;
    DeletePageMI1: TMenuItem;
    PageSettingsMI1: TMenuItem;
    NewMI: TMenuItem;
    NewReportMI: TMenuItem;
    NewPageMI: TMenuItem;
    NewDialogMI: TMenuItem;
    OpenMI: TMenuItem;
    SaveMI: TMenuItem;
    SaveAsMI: TMenuItem;
    VariablesMI: TMenuItem;
    PreviewMI: TMenuItem;
    ExitMI: TMenuItem;
    UndoMI: TMenuItem;
    RedoMI: TMenuItem;
    CutMI: TMenuItem;
    CopyMI: TMenuItem;
    PasteMI: TMenuItem;
    DeleteMI: TMenuItem;
    DeletePageMI: TMenuItem;
    SelectAllMI: TMenuItem;
    BringtoFrontMI: TMenuItem;
    SendtoBackMI: TMenuItem;
    EditMI: TMenuItem;
    ObjectsTB1: TToolBar;
    BandsPopup: TPopupMenu;
    ReportTitleMI: TMenuItem;
    ReportSummaryMI: TMenuItem;
    PageHeaderMI: TMenuItem;
    PageFooterMI: TMenuItem;
    HeaderMI: TMenuItem;
    FooterMI: TMenuItem;
    MasterDataMI: TMenuItem;
    DetailDataMI: TMenuItem;
    SubdetailDataMI: TMenuItem;
    GroupHeaderMI: TMenuItem;
    GroupFooterMI: TMenuItem;
    ColumnHeaderMI: TMenuItem;
    ColumnFooterMI: TMenuItem;
    ChildMI: TMenuItem;
    PageSettingsMI: TMenuItem;
    Timer: TTimer;
    ReportSettingsMI: TMenuItem;
    Data4levelMI: TMenuItem;
    Data5levelMI: TMenuItem;
    Data6levelMI: TMenuItem;
    ShowGuidesMI: TMenuItem;
    ShowRulersMI: TMenuItem;
    DeleteGuidesMI: TMenuItem;
    RotationPopup: TPopupMenu;
    R0MI: TMenuItem;
    R45MI: TMenuItem;
    R90MI: TMenuItem;
    R180MI: TMenuItem;
    R270MI: TMenuItem;
    ReportMenu: TMenuItem;
    ReportDataMI: TMenuItem;
    OpenScriptDialog: TOpenDialog;
    SaveScriptDialog: TSaveDialog;
    ObjectsPopup: TPopupMenu;
    OverlayMI: TMenuItem;
    ReportStylesMI: TMenuItem;
    N2: TMenuItem;
    FindMI: TMenuItem;
    FindNextMI: TMenuItem;
    ReplaceMI: TMenuItem;
    DMPPopup: TPopupMenu;
    BoldMI: TMenuItem;
    ItalicMI: TMenuItem;
    UnderlineMI: TMenuItem;
    SuperScriptMI: TMenuItem;
    SubScriptMI: TMenuItem;
    CondensedMI: TMenuItem;
    WideMI: TMenuItem;
    N12cpiMI: TMenuItem;
    N15cpiMI: TMenuItem;
    VerticalbandsMI: TMenuItem;
    HeaderMI1: TMenuItem;
    FooterMI1: TMenuItem;
    MasterDataMI1: TMenuItem;
    DetailDataMI1: TMenuItem;
    SubdetailDataMI1: TMenuItem;
    GroupHeaderMI1: TMenuItem;
    GroupFooterMI1: TMenuItem;
    ChildMI1: TMenuItem;
    N3: TMenuItem;
    GroupMI: TMenuItem;
    UngroupMI: TMenuItem;
    BackPanel: TPanel;
    ScrollBoxPanel: TPanel;
    ScrollBox: TfrxScrollBox;
    LeftRuler: TfrxRuler;
    TopRuler: TfrxRuler;
    CodePanel: TPanel;
    CodeTB: TToolBar;
    OpenScriptB: TfrxToolButton;
    SaveScriptB: TfrxToolButton;
    RunScriptB: TfrxToolButton;
    RunToCursorB: TfrxToolButton;
    StepScriptB: TfrxToolButton;
    StopScriptB: TfrxToolButton;
    EvaluateB: TfrxToolButton;
    BreakPointB: TfrxToolButton;
    TabPanel: TPanel;
    TopToolBox: TToolBar;
    AlignTB: TToolBar;
    AlignLeftsB: TfrxToolButton;
    AlignHorzCentersB: TfrxToolButton;
    AlignRightsB: TfrxToolButton;
    AlignTopsB: TfrxToolButton;
    AlignVertCentersB: TfrxToolButton;
    AlignBottomsB: TfrxToolButton;
    SpaceHorzB: TfrxToolButton;
    SpaceVertB: TfrxToolButton;
    CenterHorzB: TfrxToolButton;
    CenterVertB: TfrxToolButton;
    SameWidthB: TfrxToolButton;
    SameHeightB: TfrxToolButton;
    ExtraToolsTB: TToolBar;
    FrameTB: TToolBar;
    FrameTopB: TfrxToolButton;
    FrameBottomB: TfrxToolButton;
    FrameLeftB: TfrxToolButton;
    FrameRightB: TfrxToolButton;
    FrameAllB: TfrxToolButton;
    FrameNoB: TfrxToolButton;
    ShadowB: TfrxToolButton;
    FillColorB: TfrxToolButton;
    FrameColorB: TfrxToolButton;
    FrameStyleB: TfrxToolButton;
    StandardTB: TToolBar;
    NewB: TfrxToolButton;
    OpenB: TfrxToolButton;
    SaveB: TfrxToolButton;
    PreviewB: TfrxToolButton;
    NewPageB: TfrxToolButton;
    NewDialogB: TfrxToolButton;
    DeletePageB: TfrxToolButton;
    PageSettingsB: TfrxToolButton;
    CutB: TfrxToolButton;
    CopyB: TfrxToolButton;
    PasteB: TfrxToolButton;
    UndoB: TfrxToolButton;
    RedoB: TfrxToolButton;
    GroupB: TfrxToolButton;
    UngroupB: TfrxToolButton;
    ShowGridB: TfrxToolButton;
    AlignToGridB: TfrxToolButton;
    SetToGridB: TfrxToolButton;
    TextTB: TToolBar;
    BoldB: TfrxToolButton;
    ItalicB: TfrxToolButton;
    UnderlineB: TfrxToolButton;
    FontB: TfrxToolButton;
    FontColorB: TfrxToolButton;
    HighlightB: TfrxToolButton;
    RotateB: TfrxToolButton;
    TextAlignLeftB: TfrxToolButton;
    TextAlignCenterB: TfrxToolButton;
    TextAlignRightB: TfrxToolButton;
    TextAlignBlockB: TfrxToolButton;
    TextAlignTopB: TfrxToolButton;
    TextAlignMiddleB: TfrxToolButton;
    TextAlignBottomB: TfrxToolButton;
    ScaleCB: TComboEdit;
    LangCB: TComboEdit;
    FrameWidthCB: TComboEdit;
    FontNameCB: TComboEdit;
    StyleCB: TComboEdit;
    FontSizeCB: TComboEdit;
    RightDockTB: TToolBar;
    Splitter1: TSplitter;
    LeftDockTB: TToolBar;
    Splitter2: TSplitter;
    StyleBook1: TStyleBook;
    Sep1: TfrxToolSeparator;
    Sep2: TfrxToolSeparator;
    Sep4: TfrxToolSeparator;
    Sep5: TfrxToolSeparator;
    Sep6: TfrxToolSeparator;
    Sep7: TfrxToolSeparator;
    Sep8: TfrxToolSeparator;
    Sep9: TfrxToolSeparator;
    Sep10: TfrxToolSeparator;
    Sep11: TfrxToolSeparator;
    Sep12: TfrxToolSeparator;
    Sep13: TfrxToolSeparator;
    Sep14: TfrxToolSeparator;
    Grip1: TfrxToolGrip;
    Grip2: TfrxToolGrip;
    Grip3: TfrxToolGrip;
    Grip4: TfrxToolGrip;
    HintPanel: TCalloutPanel;
    Label1: TLabel;
    procedure ExitCmdExecute(Sender: TObject);
    procedure ObjectsButtonClick(Sender: TObject);
//    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
//      Panel: TStatusPanel; const ARect: TRect);
    procedure ScrollBoxMouseWheelUp(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure ScrollBoxMouseWheelDown(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure ScrollBoxResize(Sender: TObject);
    procedure ScaleCBClick(Sender: TObject);
    procedure ShowGridBClick(Sender: TObject);
    procedure AlignToGridBClick(Sender: TObject);
    procedure StatusBarDblClick(Sender: TObject);
    procedure StatusBarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure InsertBandClick(Sender: TObject);
    procedure BandsPopupPopup(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NewReportCmdExecute(Sender: TObject);
    procedure ToolButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FontColorBClick(Sender: TObject);
    procedure FrameStyleBClick(Sender: TObject);
    procedure TabChange(Sender: TObject);
    procedure UndoCmdExecute(Sender: TObject);
    procedure RedoCmdExecute(Sender: TObject);
    procedure CutCmdExecute(Sender: TObject);
    procedure CopyCmdExecute(Sender: TObject);
    procedure PasteCmdExecute(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure DeletePageCmdExecute(Sender: TObject);
    procedure NewDialogCmdExecute(Sender: TObject);
    procedure NewPageCmdExecute(Sender: TObject);
    procedure SaveCmdExecute(Sender: TObject);
    procedure SaveAsCmdExecute(Sender: TObject);
    procedure OpenCmdExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DeleteCmdExecute(Sender: TObject);
    procedure SelectAllCmdExecute(Sender: TObject);
    procedure EditCmdExecute(Sender: TObject);
    procedure TabChanging(Sender: TObject; var AllowChange: Boolean);
    procedure PageSettingsCmdExecute(Sender: TObject);
    procedure TopRulerDragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF});
    procedure AlignLeftsBClick(Sender: TObject);
    procedure AlignRightsBClick(Sender: TObject);
    procedure AlignTopsBClick(Sender: TObject);
    procedure AlignBottomsBClick(Sender: TObject);
    procedure AlignHorzCentersBClick(Sender: TObject);
    procedure AlignVertCentersBClick(Sender: TObject);
    procedure CenterHorzBClick(Sender: TObject);
    procedure CenterVertBClick(Sender: TObject);
    procedure SpaceHorzBClick(Sender: TObject);
    procedure SpaceVertBClick(Sender: TObject);
    procedure SelectToolBClick(Sender: TObject);
    procedure RotateBClick(Sender: TObject);
    procedure PagePopupPopup(Sender: TObject; X, Y: Single);
    procedure BringToFrontCmdExecute(Sender: TObject);
    procedure SendToBackCmdExecute(Sender: TObject);
    procedure LangCBClick(Sender: TObject);
    procedure OpenScriptBClick(Sender: TObject);
    procedure SaveScriptBClick(Sender: TObject);
    procedure CodeWindowDragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF});
    procedure CodeWindowDragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
    procedure VariablesCmdExecute(Sender: TObject);
    procedure ObjectBandBClick(Sender: TObject);
    procedure PreviewCmdExecute(Sender: TObject);
    procedure HighlightBClick(Sender: TObject);
    procedure TabMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure TabMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure TabMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure TabDragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
    procedure TabDragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF});
    procedure SameWidthBClick(Sender: TObject);
    procedure SameHeightBClick(Sender: TObject);
    procedure NewItemCmdExecute(Sender: TObject);
    procedure TabOrderMIClick(Sender: TObject);
    procedure RunScriptBClick(Sender: TObject);
    procedure StopScriptBClick(Sender: TObject);
    procedure EvaluateBClick(Sender: TObject);
    procedure GroupCmdExecute(Sender: TObject);
    procedure UngroupCmdExecute(Sender: TObject);
    procedure LangSelectClick(Sender: TObject);
    procedure BreakPointBClick(Sender: TObject);
    procedure RunToCursorBClick(Sender: TObject);
    procedure TabSetChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure FormShow(Sender: TObject); override;
    procedure AddChildMIClick(Sender: TObject);
    procedure FindCmdExecute(Sender: TObject);
    procedure ReplaceCmdExecute(Sender: TObject);
    procedure FindNextCmdExecute(Sender: TObject);
    procedure ReportDataCmdExecute(Sender: TObject);
    procedure ReportStylesCmdExecute(Sender: TObject);
    procedure ReportOptionsCmdExecute(Sender: TObject);
    procedure ShowRulersCmdExecute(Sender: TObject);
    procedure ShowGuidesCmdExecute(Sender: TObject);
    procedure DeleteGuidesCmdExecute(Sender: TObject);
    procedure OptionsCmdExecute(Sender: TObject);
    procedure HelpContentsCmdExecute(Sender: TObject);
    procedure AboutCmdExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure RightDockTBResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure LeftDockTBResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FrameWidthCBKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure NewPageBMouseEnter(Sender: TObject);
    procedure NewPageBMouseLeave(Sender: TObject);
    procedure FontBClick(Sender: TObject);
  private
    { Private declarations }
    ObjectSelectB: TfrxToolButton;
    ObjectBandB: TfrxToolButton;

    FClipboard: TfrxClipboard;
    FCodeWindow: TfsSyntaxMemo;
    FColor: TColor;
    FCoord1: String;
    FCoord2: String;
    FCoord3: String;
    FDialogForm: TfrxDialogForm;
    FEditAfterInsert: Boolean;
    FDataTree: TfrxDataTreeForm;
    FDropFields: Boolean;
    FGridAlign: Boolean;
    FGridSize1: Double;
    FGridSize2: Double;
    FGridSize3: Double;
    FGridSize4: Double;
    FInspector: TfrxObjectInspector;
    FLineStyle: TfrxFrameStyle;
    FLocalizedOI: Boolean;
    FLockSelectionChanged: Boolean;
    FModifiedBy: TObject;
    FMouseDown: Boolean;
    FOldDesignerComp: TfrxDesigner;
    FOldUnits: TfrxDesignerUnits;
    FPagePositions: TStrings;
    FPictureCache: TfrxPictureCache;
    FRecentFiles: TStringList;
//    FRecentMenuIndex: Integer;
    FReportTree: TfrxReportTreeForm;
    FSampleFormat: TSampleFormat;
    FScale: Double;
    FScriptFirstTime: Boolean;
    FScriptRunning: Boolean;
    FScriptStep: Boolean;
    FScriptStopped: Boolean;
    FSearchCase: Boolean;
    FSearchIndex: Integer;
    FSearchReplace: Boolean;
    FSearchReplaceText: String;
    FSearchText: String;
    FShowGrid: Boolean;
    FShowGuides: Boolean;
    FShowRulers: Boolean;
    FShowStartup: Boolean;
    FTabs: TTabControl;
    FUndoBuffer: TfrxUndoBuffer;
    FUnits: TfrxDesignerUnits;
    FUnitsDblClicked: Boolean;
    FUpdatingControls: Boolean;
    FWatchList: TfrxWatchForm;
    FWorkspace: TfrxDesignerWorkspace;
    FTemplatePath: String;
    FTemplateExt: String;
    Splitter3: TSplitter;
    FColorSelector: TfrxColorSelector;
    FLineSelector: TfrxLineSelector;
    procedure CreateColorSelector(Sender: TfrxToolButton);
    procedure CreateExtraToolbar;
    procedure CreateToolWindows;
    procedure CreateObjectsToolbar;
    procedure CreateWorkspace;
    procedure FindOrReplace(replace: Boolean);
    procedure FindText;
    procedure OnCodeChanged(Sender: TObject);
//    procedure OnCodeCompletion(const Name: String; List: TStrings);
    procedure OnColorChanged(Sender: TObject);
    procedure OnComponentMenuClick(Sender: TObject);
    procedure OnChangePosition(Sender: TObject);
//    procedure OnDataTreeDblClick(Sender: TObject);
    procedure OnEditObject(Sender: TObject);
//    procedure OnExtraToolClick(Sender: TObject);
    procedure OnInsertObject(Sender: TObject);
    procedure OnModify(Sender: TObject);
    procedure OnNotifyPosition(ARect: TfrxRect);
    procedure OnRunLine(Sender: TfsScript; const UnitName, SourcePos: String);
    procedure OnSelectionChanged(Sender: TObject);
    procedure OnStyleChanged(Sender: TObject);
    procedure OpenRecentFile(Sender: TObject);
    procedure ReadButtonImages;
    procedure ReloadObjects;
    procedure RestorePagePosition;
    procedure SavePagePosition;
    procedure SaveState;
    procedure SetScale(Value: Double);
    procedure SetGridAlign(const Value: Boolean);
    procedure SetShowGrid(const Value: Boolean);
    procedure SetShowRulers(const Value: Boolean);
    procedure SetUnits(const Value: TfrxDesignerUnits);
    procedure SwitchToolbar;
    procedure UpdateCaption;
    procedure UpdateControls;
    procedure UpdatePageDimensions;
    procedure UpdateRecentFiles(NewFile: String);
    procedure UpdateStyles;
    procedure UpdateSyntaxType;
    procedure UpdateWatches;
    function AskSave: Word;
    function GetPageIndex: Integer;
    function GetReportName: String;
    procedure SetShowGuides(const Value: Boolean);
    procedure Localize;
    procedure CreateLangMenu;
    procedure SetGridSize1(const Value: Double);
    procedure SetGridSize2(const Value: Double);
    procedure SetGridSize3(const Value: Double);
    procedure SetGridSize4(const Value: Double);
  protected
    procedure SetModified(const Value: Boolean); override;
    procedure SetPage(const Value: TfrxPage); override;
    function GetCode: TStrings; override;
  public
    { Public declarations }
    procedure Init; override;
    procedure Done; override;
    function CheckOp(Op: TfrxDesignerRestriction): Boolean;
    function InsertExpression(const Expr: String): String; override;
    procedure LoadFile(FileName: String; UseOnLoadEvent: Boolean);
    procedure Lock; override;
    procedure ReloadPages(Index: Integer); override;
    procedure ReloadReport; override;
    procedure RestoreState(RestoreDefault: Boolean = False;
      RestoreMainForm: Boolean = False);
    function SaveFile(SaveAs: Boolean; UseOnSaveEvent: Boolean): Boolean;
    procedure SetReportDefaults;
    procedure SwitchToCodeWindow;
    procedure UpdateDataTree; override;
    procedure UpdatePage; override;
    procedure UpdateInspector; override;
    function GetDefaultObjectSize: TfrxPoint;
    function mmToUnits(mm: Extended; X: Boolean = True): Extended;
    function UnitsTomm(mm: Extended; X: Boolean = True): Extended;
    procedure GetTemplateList(List: TStrings);

    property CodeWindow: TfsSyntaxMemo read FCodeWindow;
    property DataTree: TfrxDataTreeForm read FDataTree;
    property DropFields: Boolean read FDropFields write FDropFields;
    property EditAfterInsert: Boolean read FEditAfterInsert write FEditAfterInsert;
    property GridAlign: Boolean read FGridAlign write SetGridAlign;
    property GridSize1: Double read FGridSize1 write SetGridSize1;
    property GridSize2: Double read FGridSize2 write SetGridSize2;
    property GridSize3: Double read FGridSize3 write SetGridSize3;
    property GridSize4: Double read FGridSize4 write SetGridSize4;
    property Inspector: TfrxObjectInspector read FInspector;
    property PictureCache: TfrxPictureCache read FPictureCache;
    property RecentFiles: TStringList read FRecentFiles;
    property ReportTree: TfrxReportTreeForm read FReportTree;
    property SampleFormat: TSampleFormat read FSampleFormat;
    property Scale: Double read FScale write SetScale;
    property ShowGrid: Boolean read FShowGrid write SetShowGrid;
    property ShowGuides: Boolean read FShowGuides write SetShowGuides;
    property ShowRulers: Boolean read FShowRulers write SetShowRulers;
    property ShowStartup: Boolean read FShowStartup write FShowStartup;
    property Units: TfrxDesignerUnits read FUnits write SetUnits;
    property Workspace: TfrxDesignerWorkspace read FWorkspace;
    property TemplatePath: String read FTemplatePath write FTemplatePath;
  end;

  TSampleFormat = class(TObject)
  private
    FMemo: TfrxCustomMemoView;
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ApplySample(Memo: TfrxCustomMemoView);
    procedure SetAsSample(Memo: TfrxCustomMemoView);
    property Memo: TfrxCustomMemoView read FMemo;
  end;

  TfrxCustomSavePlugin = class(TObject)
  public
    FileFilter: String;
    procedure Save(Report: TfrxReport; const FileName: String); virtual; abstract;
  end;

var
  frxDesignerComp: TfrxDesigner;
  frxSavePlugin: TfrxCustomSavePlugin;

implementation
{$IFDEF DELPHI23}
{$R FMX.frxDesgn_D23.FMX}
{$ELSE}
{$R *.FMX}
{$ENDIF}
{$R *.RES}

uses
  System.TypInfo, System.IniFiles,
  FMX.frxDsgnIntf, FMX.frxUtils, FMX.frxDesgnWorkspace1,
  FMX.frxDesgnEditors, FMX.frxEditOptions, FMX.frxEditReport, FMX.frxEditPage, FMX.frxAbout,
  FMX.fs_itools, FMX.frxXML, FMX.frxEditReportData, FMX.frxEditVar, FMX.frxEditExpr,
  FMX.frxEditHighlight, FMX.frxEditStyle, {FMX.frxNewItem, FMX.frxStdWizard,} FMX.frxFontForm,
  FMX.frxEditTabOrder, FMX.frxCodeUtils, FMX.frxRes, FMX.frxrcDesgn, FMX.frxDMPClass, FMX.TreeView, FMX.Platform,
  FMX.frxEvaluateForm, FMX.frxSearchDialog, {FMX.frxConnEditor,} FMX.fs_xml, FMX.frxVariables, FMX.frxBaseModalForm;


 Type THackControl = class(TControl);

{ TSampleFormat }

constructor TSampleFormat.Create;
begin
  Clear;
end;

destructor TSampleFormat.Destroy;
begin
  FMemo.Free;
  inherited;
end;

procedure TSampleFormat.Clear;
begin
  if FMemo <> nil then
    FMemo.Free;
  FMemo := TfrxMemoView.Create(nil);
  if frxDesignerComp <> nil then
  begin
    FMemo.Font := frxDesignerComp.DefaultFont;
    FMemo.RTLReading := frxDesignerComp.RTLLanguage;
    FMemo.ParentFont := frxDesignerComp.MemoParentFont;
  end;
end;

procedure TSampleFormat.ApplySample(Memo: TfrxCustomMemoView);
begin
  Memo.Color := FMemo.Color;
  if not (Memo is TfrxDMPMemoView) then
    Memo.Font := FMemo.Font;
  Memo.Frame.Assign(FMemo.Frame);
  Memo.HAlign := FMemo.HAlign;
  Memo.VAlign := FMemo.VAlign;
  Memo.RTLReading := FMemo.RTLReading;
  Memo.ParentFont := FMemo.ParentFont;
end;

procedure TSampleFormat.SetAsSample(Memo: TfrxCustomMemoView);
begin
  FMemo.Color := Memo.Color;
  if not (Memo is TfrxDMPMemoView) then
    FMemo.Font := Memo.Font;
  FMemo.Frame.Assign(Memo.Frame);
  FMemo.HAlign := Memo.HAlign;
  FMemo.VAlign := Memo.VAlign;
  FMemo.RTLReading := Memo.RTLReading;
  Memo.ParentFont := FMemo.ParentFont;
end;


{ TfrxDesigner }

constructor TfrxDesigner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCloseQuery := True;
  FDefaultFont := TfrxFont.Create;
  with FDefaultFont do
  begin
    Name := 'Arial';
    Size := 10;
  end;
  FDefaultScriptLanguage := 'PascalScript';
  FTemplatesExt := 'fr3';
  FDefaultLeftMargin := 10;
  FDefaultBottomMargin := 10;
  FDefaultRightMargin := 10;
  FDefaultTopMargin := 10;
  FDefaultPaperSize := DMPAPER_A4;
  FDefaultOrientation := poPortrait;
  frxDesignerComp := Self;
end;

destructor TfrxDesigner.Destroy;
begin
  FDefaultFont.Free;
  frxDesignerComp := nil;
  inherited Destroy;
end;

procedure TfrxDesigner.SetDefaultFont(const Value: TfrxFont);
begin
  FDefaultFont.Assign(Value);
end;


{ TfrxDesignerForm }

{ Form events }
{------------------------------------------------------------------------------}

procedure TfrxDesignerForm.FormShow(Sender: TObject);
begin
  ReadButtonImages;
  CreateObjectsToolbar;
  CreateWorkspace;
  CreateToolWindows;
  Init;
  CreateExtraToolbar;

  Localize;
  CreateLangMenu;

  with ScaleCB.Items do
  begin
    Clear;
    Add('25%');
    Add('50%');
    Add('75%');
    Add('100%');
    Add('150%');
    Add('200%');
    Add(frxResources.Get('zmPageWidth'));
    Add(frxResources.Get('zmWholePage'));
  end;

//  if Screen.PixelsPerInch > 96 then
//  begin
//    StyleCB.Font.Height := -11;
//    FontNameCB.Font.Height := -11;
//    FontSizeCB.Font.Height := -11;
//    ScaleCB.Font.Height := -11;
//    FrameWidthCB.Font.Height := -11;
//    LangL.Font.Height := -11;
//    LangCB.Font.Height := -11;
//  end;
  R45MI.HelpContext := 45;
  R90MI.HelpContext := 90;
  R180MI.HelpContext := 180;
  R270MI.HelpContext := 270;
  FontSizeCB.DropDownCount := FontSizeCB.Items.Count;
  
  RestoreState;
  ReloadReport;
  RestoreState(False, True);

  if frxDesignerComp <> nil then
  begin
    FTemplatePath := frxDesignerComp.FTemplateDir;
    if Assigned(frxDesignerComp.FOnShow) then
      frxDesignerComp.FOnShow(Self);
  end;
  if FTemplatePath = '' then
    FTemplatePath := Report.GetApplicationFolder;
  FileMenu.Visible := True;
  OpenMI.Visible := True;
end;

procedure TfrxDesignerForm.FormActivate(Sender: TObject);
begin
  FDataTree.FormResize(Self);
  FInspector.FormResize(Self);
{$IFNDEF DELPHI20}
  MainMenu.UpdateStyle;
{$ENDIF}
  FileMenu.Visible := True;
  OpenMI.Visible := True;
end;

procedure TfrxDesignerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveState;
  BeginUpdate;
  Done;
  Report.Modified := Modified;
  if not (TFmxFormState.fsModal in FormState) then
  begin
    Report.Designer := nil;
    Action := TCloseAction.caFree;
  end;
end;

procedure TfrxDesignerForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  w: Word;
begin
  FInspector.FormDeactivate(nil);
  if FScriptRunning then
  begin
    CanClose := False;
    Exit;
  end;
  CanClose := True;
  Report.ScriptText := CodeWindow.Lines;

  if (frxDesignerComp <> nil) and not frxDesignerComp.CloseQuery then
    Exit;

  if Modified and not (csDesigning in Report.ComponentState) and CheckOp(drDontSaveReport) then
  begin
    w := AskSave;

    if IsPreviewDesigner then
    begin
      if w = mrNo then
        Modified := False
    end
    else if w = mrYes then
      if not SaveFile(False, True) then
        CanClose := False;

    if not IsPreviewDesigner then
    begin
      if w = mrNo then
        Modified := False
      else
        Modified := True;
    end;

    if w = mrCancel then
      CanClose := False;
  end;
end;

procedure TfrxDesignerForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkReturn then
    if ActiveControl = FontSizeCB then
      ToolButtonClick(FontSizeCB)
    else if ActiveControl = ScaleCB then
      ScaleCBClick(Self);

  if (Page <> nil) and (FWorkspace.IsFocused) then
  begin
    if Key = vkInsert then
      if Shift = [ssShift] then
      begin
        PasteCmdExecute(nil);
        Key := 0;
      end
      else if Shift = [ssCtrl] then
      begin
        CopyCmdExecute(nil);
        Key := 0;
      end;

    if Key = vkDelete then
      if Shift = [ssShift] then
      begin
        CutCmdExecute(nil);
        Key := 0;
      end;

    if (Shift = [ssCtrl]) or (Shift = [ssCommand]) then
      if Key = Ord('C') then
      begin
        CopyCmdExecute(nil);
        Key := 0;
      end
      else if Key = Ord('V') then
      begin
        PasteCmdExecute(nil);
        Key := 0;
      end
      else if Key = Ord('X') then
      begin
        CutCmdExecute(nil);
        Key := 0;
      end;
  end;

  if (Key = Ord('E')) and (Shift = [ssCtrl]) then
    Page := nil;

  if ((Key = vkF4) or (Key = vkF5)) and (Shift = []) and (Page = nil) then
  begin
    if Key = vkF4 then
      RunToCursorBClick(nil)
    else
      BreakPointBClick(nil);
  end
  else if (Key = vkF2) and (Shift = [ssCtrl]) then
    StopScriptBClick(StopScriptB)
  else if (Key = vkF7) and (Shift = [ssCtrl]) and (Page = nil) then
    EvaluateBClick(EvaluateB)
  else if Key = vkF9 then
    RunScriptBClick(RunScriptB)
  else if ((Key = vkF7) or (Key = vkF8)) and (Page = nil) then
    RunScriptBClick(StepScriptB);
end;

procedure TfrxDesignerForm.RightDockTBResize(Sender: TObject);
begin
 if FDataTree <> nil then
   FDataTree.UpdateSize;
end;

{ Get/Set methods }
{------------------------------------------------------------------------------}

function TfrxDesignerForm.GetDefaultObjectSize: TfrxPoint;
begin
  case FUnits of
    duCM:     Result := frxPoint(fr1cm * 2.5, fr1cm * 0.5);
    duInches: Result := frxPoint(fr1in, fr1in * 0.2);
    duPixels: Result := frxPoint(80, 16);
    duChars:  Result := frxPoint(fr1CharX * 10, fr1CharY);
  end;
end;

function TfrxDesignerForm.GetCode: TStrings;
begin
  Result := CodeWindow.Lines;
end;

procedure TfrxDesignerForm.SetGridAlign(const Value: Boolean);
begin
  FGridAlign := Value;
  AlignToGridB.IsPressed := FGridAlign;
  FWorkspace.GridAlign := FGridAlign;
end;

procedure TfrxDesignerForm.SetModified(const Value: Boolean);
var
  i: Integer;
begin
  inherited;
  Report.ScriptText := CodeWindow.Lines;
  if IsPreviewDesigner then
    FUndoBuffer.AddUndo(FPage)
  else
    FUndoBuffer.AddUndo(Report);
  FUndoBuffer.ClearRedo;
  SaveMI.Visible := Modified;
  SaveB.Enabled := Modified;
//  SaveCmd.Enabled := Modified;

  if FModifiedBy <> Self then
    UpdateControls;

  if FModifiedBy = FInspector then
    if (FSelectedObjects[0] = FPage) {or
       (TObject(FSelectedObjects[0]) is TfrxSubreport)} then
    begin
      FLockSelectionChanged := True;
      try
        i := Report.Objects.IndexOf(FPage);
        if i >= 0 then
          ReloadPages(i);
      finally
        FLockSelectionChanged := False;
      end;
    end;

  if FModifiedBy <> FWorkspace then
  begin
    FWorkspace.UpdateView;
    FWorkspace.AdjustBands;
  end;

  if FModifiedBy <> FInspector then
    FInspector.UpdateProperties;

  FReportTree.UpdateItems;
  FModifiedBy := nil;
end;

procedure TfrxDesignerForm.SetPage(const Value: TfrxPage);
begin
  inherited;

  FTabs.TabIndex := Report.Objects.IndexOf(FPage) + 1;
  ScrollBoxPanel.Visible := FPage <> nil;
  CodePanel.Visible := FPage = nil;

  SwitchToolbar;
  UpdateControls;

  if FPage = nil then
  begin
    CodeWindow.SetFocus;
    Exit;
  end
  else if FPage is TfrxReportPage then
  begin
    with FWorkspace do
    begin
      Parent := ScrollBox;
      Align := TAlignLayout.alNone;
      Color := claWhite;
      Scale := Self.Scale;
    end;

    if FPage is TfrxDMPPage then
      Units := duChars else
      Units := FOldUnits;
    UpdatePageDimensions;
    if Visible then
      ScrollBox.SetFocus;
  end
  else if FPage is TfrxDialogPage then
  begin
    FDialogForm := TfrxDialogForm(TfrxDialogPage(FPage).DialogForm);
    Units := duPixels;
    with FWorkspace do
    begin
      FWorkspace.Parent := ScrollBox;
      Align := TAlignLayout.alNone;
      GridType := gtDialog;
      GridX := FGridSize4;
      GridY := FGridSize4;
      Color := TfrxDialogPage(FPage).Color;
      Scale := 1;
    end;

    UpdatePageDimensions;
    if Visible then
      ScrollBox.SetFocus;
  end
  else if FPage is TfrxDataPage then
  begin
    Units := duPixels;
    with FWorkspace do
    begin
      Parent := ScrollBox;
      Align := TAlignLayout.alNone;
      Color := claWhite;
      Scale := 1;
      GridType := gtNone;
      GridX := FGridSize4;
      GridY := FGridSize4;
    end;

    UpdatePageDimensions;
    if Visible then
      ScrollBox.SetFocus;
  end
  else
  begin
    Report.Errors.Add('Page object is not page');
  end;

  ReloadObjects;
  RestorePagePosition;
end;

procedure TfrxDesignerForm.SetScale(Value: Double);
begin
  //ScrollBox.AutoScroll := False;
  if Value = 0 then
    Value := 1;
  if Value > 20 then
    Value := 20;
  FScale := Value;
  TopRuler.Scale := Value;
  LeftRuler.Scale := Value;
  FWorkspace.Scale := Value;
  ScaleCB.OnChange := nil;
  ScaleCB.Text := IntToStr(Round(FScale * 100)) + '%';
  ScaleCB.OnChange := ScaleCBClick;
  UpdatePageDimensions;
  //ScrollBox.AutoScroll := True;
end;

procedure TfrxDesignerForm.SetShowGrid(const Value: Boolean);
begin
  FShowGrid := Value;
  ShowGridB.IsPressed := FShowGrid;
  FWorkspace.ShowGrid := FShowGrid;
end;

procedure TfrxDesignerForm.SetShowRulers(const Value: Boolean);
begin
  FShowRulers := Value;
  TopRuler.Visible := FShowRulers;
  LeftRuler.Visible := FShowRulers;
  ShowRulersMI.IsChecked := FShowRulers;
//  ShowRulersCmd.Checked := FShowRulers;
end;

procedure TfrxDesignerForm.SetShowGuides(const Value: Boolean);
begin
  FShowGuides := Value;
  TDesignerWorkspace(FWorkspace).ShowGuides := FShowGuides;
  ShowGuidesMI.IsChecked := FShowGuides;
end;

procedure TfrxDesignerForm.SetUnits(const Value: TfrxDesignerUnits);
var
  s: String;
  gType: TfrxGridType;
  gSizeX, gSizeY: Extended;
begin
  FUnits := Value;
  s := '';
  if FUnits = duCM then
  begin
    s := frxResources.Get('dsCm');
    gType := gt1cm;
    gSizeX := FGridSize1 * fr1cm;
    gSizeY := gSizeX;
  end
  else if FUnits = duInches then
  begin
    s := frxResources.Get('dsInch');
    gType := gt1in;
    gSizeX := FGridSize2 * fr1in;
    gSizeY := gSizeX;
  end
  else if FUnits = duPixels then
  begin
    s := frxResources.Get('dsPix');
    gType := gt1pt;
    gSizeX := FGridSize3;
    gSizeY := gSizeX;
  end
  else {if FUnits = duChars then}
  begin
    s := frxResources.Get('dsChars');
    gType := gtChar;
    gSizeX := fr1CharX;
    gSizeY := fr1CharY;
  end;

  //StatusBar.Panels[0].Text := s;
  TopRuler.Units := TfrxRulerUnits(FUnits);
  LeftRuler.Units := TfrxRulerUnits(FUnits);

  with FWorkspace do
  begin
    GridType := gType;
    GridX := gSizeX;
    GridY := gSizeY;
    AdjustBands;
  end;

  if FSelectedObjects.Count <> 0 then
    OnSelectionChanged(Self);
end;


{ Service methods }
{------------------------------------------------------------------------------}

procedure TfrxDesignerForm.Init;
var
  i: Integer;
begin
  Label1.WordWrap := True;
  FPictureCache := TfrxPictureCache.Create;
  FScale := 1;
  ScrollBoxPanel.Align := alClient;
  ScrollBox.ShowScrollBars := true;
{$IFNDEF MSWINDOWS}
 {$IFDEF DELPHI18}
  ScrollBox.AutoHide := false;
 {$ENDIF}
{$ENDIF}
{$IFDEF DELPHI19}
  ScrollBox.AniCalculations.AutoShowing := false;
{$ENDIF}
  CodePanel.Align := alClient;
  ScrollBoxPanel.StyleLookup := 'backgroundstyle';
  BackPanel.StyleLookup := 'backgroundstyle';
  TabPanel.StyleLookup := 'backgroundstyle';
  RightDockTB.StyleLookup := 'backgroundstyle';
  LeftDockTB.StyleLookup := 'backgroundstyle';

//  if Screen.PixelsPerInch > 96 then
//  begin
//    StatusBar.Panels[0].Width := 100;
//    StatusBar.Panels[1].Width := 280;
//    StatusBar.Height := 24;
//  end;


  LangCB.OnChange := nil;
  fsGetLanguageList(LangCB.Items);
  LangCB.OnChange := LangCBClick;
  frxAddCodeRes;

  FUndoBuffer := TfrxUndoBuffer.Create;
  FUndoBuffer.PictureCache := FPictureCache;

  FClipboard := TfrxClipboard.Create(Self);
  FClipboard.PictureCache := FPictureCache;
  Timer.Enabled := True;

  FRecentFiles := TStringList.Create;
//  FRecentMenuIndex := FileMenu.IndexOf(SepMI4);
  FSampleFormat := TSampleFormat.Create;
  FPagePositions := TStringList.Create;
  for i := 1 to 256 do
    FPagePositions.Add('');

  if IsPreviewDesigner then
  begin
    FOldDesignerComp := frxDesignerComp;
    TfrxDesigner.Create(nil);
    frxDesignerComp.Restrictions := [drDontDeletePage, drDontCreatePage,
      drDontCreateReport, drDontLoadReport, drDontPreviewReport,
      drDontEditVariables, drDontChangeReportOptions];
    if FOldDesignerComp <> nil then
      frxDesignerComp.Restrictions := frxDesignerComp.Restrictions + FOldDesignerComp.Restrictions;

    ObjectBandB.Enabled := False;
  end;

  Report.SelectPrinter;
  FontNameCB.BeginUpdate;
  FontNameCB.Clear;
  FillFontsList(FontNameCB.Items);
{  for i := 0 to FontNameCB.ListBox.Count - 1 do
  begin
    FontNameCB.ListBox.ListItems[i].Font.Family := FontNameCB.Items[i];
    FontNameCB.ListBox.ListItems[i].Font.Size := 14;
  end;}

  FontNameCB.EndUpdate;

  NewMI.Visible := False;

{$IFDEF FR_VER_BASIC}
  NewDialogMI1.Enabled := False;
  NewDialogMI.Enabled := False;
  NewDialogB.Enabled := False;
{$ENDIF}

  NewReportMI.Enabled := CheckOp(drDontCreateReport);
  NewMI.Enabled := CheckOp(drDontCreateReport);
  NewPageMI.Enabled := CheckOp(drDontCreatePage);
  NewDialogMI1.Enabled := NewDialogMI1.Enabled and CheckOp(drDontCreatePage);
  SaveAsMI.Enabled := CheckOp(drDontSaveReport);
  OpenMI.Enabled := CheckOp(drDontLoadReport);
  ReportSettingsMI.Enabled := CheckOp(drDontChangeReportOptions);
  ReportStylesMI.Enabled := CheckOp(drDontChangeReportOptions);
  ReportDataMI.Enabled := CheckOp(drDontEditReportData);
  VariablesMI.Enabled := CheckOp(drDontEditVariables);
  PreviewMI.Enabled := CheckOp(drDontPreviewReport);
end;

procedure TfrxDesignerForm.Done;
begin
  if IsPreviewDesigner then
  begin
    frxDesignerComp.Free;
    frxDesignerComp := FOldDesignerComp;
  end;

  FPictureCache.Free;
  FUndoBuffer.Free;
  FClipboard.Free;
  FRecentFiles.Free;
  FSampleFormat.Free;
  FPagePositions.Free;
end;

procedure TfrxDesignerForm.ReadButtonImages;
begin
end;

procedure TfrxDesignerForm.CreateToolWindows;
begin
  FInspector := TfrxObjectInspector.Create(Self);
  with FInspector do
  begin
    OnModify := Self.OnModify;
    OnSelectionChanged := Self.OnSelectionChanged;
    FInspector.MainPanel.Parent := LeftDockTB;
	FInspector.FastCanvas := FWorkspace.FastCanvas;
    FInspector.Visible := False;
    SelectedObjects := FSelectedObjects;
  end;

  FDataTree := TfrxDataTreeForm.Create(Self);
  with FDataTree do
  begin
    Report := Self.Report;
    CBPanel.Visible := True;
    FDataTree.MainDataPanel.Parent := RightDockTB;
  end;
  UpdateDataTree;

  Splitter3 := TSplitter.Create(Self);
  Splitter3.Align := TAlignLayout.alTop;
  Splitter3.Height := 5;
  Splitter3.MinSize := 100;
  Splitter3.Parent := LeftDockTB;

  FReportTree := TfrxReportTreeForm.Create(Self);
  FReportTree.OnSelectionChanged := OnSelectionChanged;
  FReportTree.MainPanel.Parent := LeftDockTB;
  FReportTree.MainPanel.Align := TAlignLayout.alMostTop;
  FReportTree.MainPanel.Height := Round(LeftDockTB.Height / 2);

  FWatchList := TfrxWatchForm.Create(Self);
  FWatchList.Script := Report.Script;
end;

procedure TfrxDesignerForm.CreateWorkspace;
begin
  FWorkspace := TDesignerWorkspace.Create(Self);
  with FWorkspace do
  begin
    Parent := ScrollBox;
    OnNotifyPosition := Self.OnNotifyPosition;
    OnInsert := OnInsertObject;
    OnEdit := OnEditObject;
    OnModify := Self.OnModify;
    OnSelectionChanged := Self.OnSelectionChanged;
    OnPopup := PagePopupPopup;
    Objects := FObjects;
    SelectedObjects := FSelectedObjects;
  end;

  FCodeWindow := TfsSyntaxMemo.Create(Self);
  with FCodeWindow do
  begin
    Parent := CodePanel;
    Align := alClient;
    Lines := Report.ScriptText;
    //Color := claWhite;
    OnChange := OnCodeChanged;
    //OnChangePos := OnChangePosition;
    OnDragOver := CodeWindowDragOver;
    OnDragDrop := CodeWindowDragDrop;
    //OnCodeCompletion := Self.OnCodeCompletion;
  end;


  FTabs := TTabControl.Create(Self);
  FTabs.OnChange := TabChange;
  //FTabs.OnChanging := TabChanging;

  FTabs.OnDragDrop := TabDragDrop;
  FTabs.OnDragOver := TabDragOver;
  FTabs.OnMouseDown := TabMouseDown;
  FTabs.OnMouseMove := TabMouseMove;
  FTabs.OnMouseUp := TabMouseUp;
  FTabs.Parent := TabPanel;
  FTabs.TabHeight := 20;
  TabPanel.Margins.Top := 3;
  FTabs.Align := TAlignLayout.alTop;
  FTabs.Height := TabPanel.Height - TabPanel.Margins.Top;
  FTabs.StyleLookup := 'TabControl1Style1';
  ScrollBoxPanel.Margins.Top := 2;
end;

procedure TfrxDesignerForm.CreateObjectsToolbar;
var
  i: Integer;
  ObjCount: Integer;
  Item: TfrxObjectItem;

  function HasButtons(Item: TfrxObjectItem): Boolean;
  var
    i: Integer;
    Item1: TfrxObjectItem;
  begin
    Result := False;
    for i := 0 to frxObjects.Count - 1 do
    begin
      Item1 := frxObjects[i];
      if (Item1.ClassRef <> nil) and (Item1.CategoryName = Item.CategoryName) then
        Result := True;
    end;
  end;

  procedure CreateButton(Index: Integer; Item: TfrxObjectItem);
  var
    b: TfrxToolButton;
    s: String;
  begin
    b := TfrxToolButton.Create(Self);
    b.Parent := ObjectsTB1;
    frxResources.LoadImageFromResouce(b.Bitmap, Item.ButtonImageIndex);
    b.SetBounds(0, 30, 30, 30);
    b.Align := TAlignLayout.alTop;
    s := Item.ButtonHint;
    if s = '' then
    begin
      if Item.ClassRef <> nil then
        s := Item.ClassRef.GetDescription;
    end
    else
      s := frxResources.Get(s);
    b.Hint := s;
    b.OnMouseEnter := NewPageBMouseEnter;
    b.OnMouseLeave := NewPageBMouseLeave;
    b.Tag := Index;
    if Item.ClassRef = nil then  { category }
      if not HasButtons(Item) then
      begin
        b.Free;
        Exit;
      end;
    b.OnClick := ObjectsButtonClick;
  end;

begin
  ObjectSelectB := TfrxToolButton.Create(Self);
  with ObjectSelectB do
  begin
    Parent := ObjectsTB1;
    StaysPressed := True;
    Down := True;
    Align := TAlignLayout.alTop;
    Height := 30;
    frxResources.LoadImageFromResouce(Bitmap, 10, 0);
    OnClick := SelectToolBClick;
  end;

  ObjectBandB := TfrxToolButton.Create(Self);
  with ObjectBandB do
  begin
    Parent := ObjectsTB1;
    Tag := 1000;
    Align := TAlignLayout.alTop;
    Height := 30;
    frxResources.LoadImageFromResouce(Bitmap, 21, 8);
    OnClick := ObjectBandBClick;
  end;

  ObjCount := frxObjects.Count - 1;

  { add category buttons }
  for i := ObjCount downto 0 do
  begin
    Item := frxObjects[i];
{    if (Item.ButtonBmp <> nil) and (Item.ButtonImageIndex = -1) then
    begin
      frxResources.SetObjectImages(Item.ButtonBmp);
      Item.ButtonImageIndex := frxResources.ObjectImages.Count - 1;
    end;}
    if Item.ClassRef = nil then
      CreateButton(i, Item);
  end;

  { add object buttons }
  for i := ObjCount downto 0 do
  begin
    Item := frxObjects[i];
{    if (Item.ButtonBmp <> nil) and (Item.ButtonImageIndex = -1) then
    begin
      frxResources.SetObjectImages(Item.ButtonBmp);
      Item.ButtonImageIndex := frxResources.ObjectImages.Count - 1;
    end;}

    if (Item.ClassRef <> nil) and (Item.CategoryName = '') then
      CreateButton(i, Item);
  end;
end;

procedure TfrxDesignerForm.CreateExtraToolbar;
//var
//  i: Integer;
//  Item: TfrxWizardItem;
//  b: TfrxToolButton;
begin
{  for i := 0 to frxWizards.Count - 1 do
  begin
    Item := frxWizards[i];
    if Item.IsToolbarWizard then
    begin
      b := TfrxToolButton.Create(Self);
      with b do
      begin
        Tag := i;
        if (Item.ButtonBmp <> nil) and (Item.ButtonImageIndex = -1) then
        begin
          frxResources.SetButtonImages(Item.ButtonBmp);
          Item.ButtonImageIndex := frxResources.MainButtonImages.Count - 1;
        end;
        //ImageIndex := Item.ButtonImageIndex;
        Hint := Item.ClassRef.GetDescription;
        SetBounds(1000, 0, 22, 22);
        Parent := ExtraToolsTB;
      end;
      b.OnClick := OnExtraToolClick;
    end;
  end;

  ExtraToolsTB.Height := 27;
  ExtraToolsTB.Width := 27;}
end;

procedure TfrxDesignerForm.ReloadReport;
var
  i: Integer;
  l: TList;
  c: TfrxComponent;
  p: TfrxPage;
  isDMP: Boolean;
begin
  if Report.PagesCount = 0 then
  begin
    isDMP := Report.DotMatrixReport;
    p := TfrxDataPage.Create(Report);
    p.Name := 'Data';
    if isDMP then
      p := TfrxDMPPage.Create(Report)
    else
    begin
      p := TfrxReportPage.Create(Report);
      TfrxReportPage(p).SetDefaults;
    end;
    p.Name := 'Page1';
  end;

  if not IsPreviewDesigner then
    Report.CheckDataPage;
  LangCB.OnChange := nil;
  LangCB.ItemIndex := LangCB.Items.IndexOf(Report.ScriptLanguage);
  LangCB.OnChange := LangCBClick;
  CodeWindow.Lines := Report.ScriptText;
  UpdateSyntaxType;
  ReloadPages(-2);
  UpdateRecentFiles(Report.FileName);
  UpdateCaption;
  UpdateStyles;

  FPictureCache.Clear;
  l := Report.AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if c is TfrxPictureView then
      FPictureCache.AddPicture(TfrxPictureView(c));
  end;

  FUndoBuffer.ClearUndo;
  Modified := False;
end;

procedure TfrxDesignerForm.ReloadPages(Index: Integer);
var
  i: Integer;
  c: TfrxPage;
  s: String;
  tItem: TTabItem;
begin
{$IFDEF Delphi20}
  FTabs.BeginUpdate;
{$ENDIF}
  while FTabs.TabCount > 0 do
{$IFNDEF Delphi17}
    FTabs.RemoveObject(FTabs.Tabs[FTabs.TabCount - 1]);
{$ELSE}
    FTabs.Tabs[0].Free;
{$ENDIF}
{$IFDEF Delphi20}
  FTabs.TabIndex := -1;
{$ENDIF}
  tItem := TTabItem.Create(FTabs);
  tItem.Text := frxResources.Get('dsCode');
  FTabs.AddObject(tItem);

  for i := 0 to Report.PagesCount - 1 do
  begin
    c := Report.Pages[i];
    c.IsDesigning := True;
    if (c is TfrxReportPage) and (TfrxReportPage(c).Subreport <> nil) then
      s := TfrxReportPage(c).Subreport.Name
    else if c is TfrxDataPage then
      s := frxResources.Get('dsData')
    else if c.Name = '' then
      s := frxResources.Get('dsPage') + IntToStr(i + 1) else
      s := c.Name;
    tItem := TTabItem.Create(FTabs);
    tItem.Text := s;
    FTabs.AddObject(tItem);
  end;
{$IFDEF Delphi20}
  FTabs.EndUpdate;
{$ENDIF}
  if Index = -1 then
    Page := nil
  else if Index = -2 then
  begin
    for i := 0 to Report.PagesCount - 1 do
    begin
      c := Report.Pages[i];
      if not (c is TfrxDataPage) then
      begin
        Page := c;
        break;
      end;
    end;
  end
  else if Index < Report.PagesCount then
    Page := Report.Pages[Index] else
    Page := Report.Pages[0];
end;

procedure TfrxDesignerForm.ReloadObjects;
var
  i: Integer;
begin
  FObjects.Clear;
  FSelectedObjects.Clear;

  for i := 0 to FPage.AllObjects.Count - 1 do
    FObjects.Add(FPage.AllObjects[i]);

  FObjects.Add(Report);
  FObjects.Add(FPage);
  FSelectedObjects.Add(FPage);
  FWorkspace.Page := FPage;
  FWorkspace.EnableUpdate;
  FWorkspace.AdjustBands;

  FInspector.EnableUpdate;

  UpdateDataTree;
  FReportTree.UpdateItems;
  OnSelectionChanged(Self);
end;

procedure TfrxDesignerForm.SetReportDefaults;
begin
  if frxDesignerComp <> nil then
  begin
    Report.ScriptLanguage := frxDesignerComp.DefaultScriptLanguage;
    frxEmptyCode(CodeWindow.Lines, Report.ScriptLanguage);
    UpdateSyntaxType;
    LangCB.OnChange := nil;
    LangCB.ItemIndex := LangCB.Items.IndexOf(Report.ScriptLanguage);
    LangCB.OnChange := LangCBClick;

    with TfrxReportPage(Report.Pages[1]) do
    begin
      LeftMargin := frxDesignerComp.DefaultLeftMargin;
      BottomMargin := frxDesignerComp.DefaultBottomMargin;
      RightMargin := frxDesignerComp.DefaultRightMargin;
      TopMargin := frxDesignerComp.DefaultTopMargin;
      PaperSize := frxDesignerComp.DefaultPaperSize;
      Orientation := frxDesignerComp.DefaultOrientation;
    end;
  end
  else
  begin
    Report.ScriptLanguage := 'PascalScript';
    frxEmptyCode(CodeWindow.Lines, Report.ScriptLanguage);
    UpdateSyntaxType;
    LangCB.OnChange := nil;
    LangCB.ItemIndex := LangCB.Items.IndexOf(Report.ScriptLanguage);
    LangCB.OnChange := LangCBClick;

    TfrxReportPage(Report.Pages[1]).SetDefaults;
  end;
  Report.ScriptText.Text := CodeWindow.Lines.Text;
end;

procedure TfrxDesignerForm.UpdatePageDimensions;
var
  h: Extended;
begin
  if FPage is TfrxReportPage then
  begin
    with FPage as TfrxReportPage do
    begin
{$IFDEF DELPHI18}
      ScrollBox.ViewportPosition := PointF(0, 0);
{$ELSE}
      ScrollBox.HScrollBar.Value := 0;
      ScrollBox.VScrollBar.Value := 0;
{$ENDIF}

      FWorkspace.Origin := Point(10, 10);
      h := PaperHeight;
      if LargeDesignHeight then
        h := h * 5;
      FWorkspace.SetPageDimensions(
        Round(PaperWidth * 96 / 25.4),
        Round(h * 96 / 25.4),
        Rect(Round(LeftMargin * 96 / 25.4), Round(TopMargin * 96 / 25.4),
             Round(RightMargin * 96 / 25.4), Round(BottomMargin * 96 / 25.4)));
    end;
  end
  else if FPage is TfrxDialogPage then
  begin
    with FPage as TfrxDialogPage do
    begin
{$IFDEF DELPHI18}
      ScrollBox.ViewportPosition := PointF(0, 0);
{$ELSE}
      ScrollBox.HScrollBar.Value := 0;
      ScrollBox.VScrollBar.Value := 0;
{$ENDIF}

      FWorkspace.Origin := Point(10, 10);
      TfrxDialogPage(FPage).UpdateClientRect;
      FWorkspace.SetPageDimensions(Round(ClientWidth), Round(ClientHeight), Rect(0, 0, 0, 0));
    end;
  end
  else if FPage is TfrxDataPage then
  begin
{$IFDEF DELPHI18}
      ScrollBox.ViewportPosition := PointF(0, 0);
{$ELSE}
      ScrollBox.HScrollBar.Value := 0;
      ScrollBox.VScrollBar.Value := 0;
{$ENDIF}

    FWorkspace.Origin := Point(0, 0);
    FWorkspace.SetPageDimensions(
      Round(FPage.Width),
      Round(FPage.Height),
      Rect(0, 0, 0, 0));
  end;

  ScrollBoxResize(nil);
end;

procedure TfrxDesignerForm.UpdateControls;

const WidthsArr: array[0..12] of Extended = (0.1, 0.5, 1, 1.5, 2, 3, 4, 5, 6, 7, 8, 9, 10);

var
  c: TfrxComponent;
  p1, p2, p3: PPropInfo;
  Count, i: Integer;
  FontEnabled, AlignEnabled, IsReportPage: Boolean;
  Frame1Enabled, Frame2Enabled, Frame3Enabled, ObjSelected, DMPEnabled: Boolean;
  s: String;
  Frame: TfrxFrame;
  DMPFontStyle: TfrxDMPFontStyles;

  procedure SetEnabled(cAr: array of TControl; Enabled: Boolean);
  var
    i: Integer;
  begin
    for i := 0 to High(cAr) do
    begin
      cAr[i].Enabled := Enabled;
      if (cAr[i] is TfrxToolButton) and not Enabled then
        TfrxToolButton(cAr[i]).IsPressed := False;
    end;
  end;

  procedure ButtonUp(cAr: array of TfrxToolButton);
  var
    i: Integer;
  begin
    for i := 0 to High(cAr) do
      cAr[i].IsPressed := False;
  end;

begin
  FUpdatingControls := True;

  Count := FSelectedObjects.Count;
  if Count > 0 then
  begin
    c := FSelectedObjects[0];
    p1 := GetPropInfo(PTypeInfo(c.ClassInfo), 'Font');
    p2 := GetPropInfo(PTypeInfo(c.ClassInfo), 'Frame');
    p3 := GetPropInfo(PTypeInfo(c.ClassInfo), 'Color');
  end
  else
  begin
    c := nil;
    p1 := nil;
    p2 := nil;
    p3 := nil;
  end;

  if Count = 1 then
  begin
    FontNameCB.Text := c.Font.Name;
    FontSizeCB.Text := IntToStr(Round(c.Font.Size));

    BoldB.IsPressed := fsBold in c.Font.Style;
    ItalicB.IsPressed := fsItalic in c.Font.Style;
    UnderlineB.IsPressed := fsUnderline in c.Font.Style;

    if c is TfrxCustomMemoView then
      with TfrxCustomMemoView(c) do
      begin
        TextAlignLeftB.IsPressed := HAlign = haLeft;
        TextAlignCenterB.IsPressed := HAlign = haCenter;
        TextAlignRightB.IsPressed := HAlign = haRight;
        TextAlignBlockB.IsPressed := HAlign = haBlock;

        TextAlignTopB.IsPressed := VAlign = vaTop;
        TextAlignMiddleB.IsPressed := VAlign = vaCenter;
        TextAlignBottomB.IsPressed := VAlign = vaBottom;
        if not (c is TfrxDMPMemoView) then
          if Style = '' then
            StyleCB.Text := StyleCB.Items[0] else
            StyleCB.Text := Style;
      end;

    Frame := nil;
    if c is TfrxView then
      Frame := TfrxView(c).Frame
    else if c is TfrxReportPage then
      Frame := TfrxReportPage(c).Frame;
    FrameWidthCB.BeginUpdate;
{$IFDEF DELPHI23}
    FrameWidthCB.Clear;
{$ELSE}
    FrameWidthCB.Items.Clear;
{$ENDIF}
    for i := 0 to 12 do
      FrameWidthCB.Items.Add(FloatToStr(WidthsArr[i]));
    FrameWidthCB.EndUpdate;
    if Frame <> nil then
      with Frame do
      begin
        FrameTopB.IsPressed := ftTop in Typ;
        FrameBottomB.IsPressed := ftBottom in Typ;
        FrameLeftB.IsPressed := ftLeft in Typ;
        FrameRightB.IsPressed := ftRight in Typ;
        ShadowB.IsPressed := DropShadow;

        FrameWidthCB.Text := FloatToStr(Width);
      end;
  end
  else
  begin
    FontNameCB.Text := '';
    FontSizeCB.Text := '';
    FrameWidthCB.Text := '';

    ButtonUp([BoldB, ItalicB, UnderlineB, TextAlignLeftB, TextAlignCenterB,
      TextAlignRightB, TextAlignBlockB, TextAlignTopB, TextAlignMiddleB,
      TextAlignBottomB, FrameTopB, FrameBottomB, FrameLeftB,
      FrameRightB, ShadowB]);
  end;

  FontEnabled := (p1 <> nil) and not (c is TfrxDMPPage) and (FPage <> nil);
  AlignEnabled := (c is TfrxCustomMemoView) and (FPage <> nil);
  Frame1Enabled := (p2 <> nil) and not (c is TfrxLineView) and
    not (c is TfrxShapeView) and not (c is TfrxDMPPage) and (FPage <> nil);
  Frame2Enabled := (p2 <> nil) and not (c is TfrxDMPPage) and (FPage <> nil);
  Frame3Enabled := (p3 <> nil) and not (c is TfrxDMPPage) and (FPage <> nil);
  IsReportPage := FPage is TfrxReportPage;
  ObjSelected := (Count <> 0) and (FPage <> nil) and (FSelectedObjects[0] <> FPage);
  DMPEnabled := (c is TfrxDMPMemoView) or (c is TfrxDMPLineView) or
    (c is TfrxDMPCommand) or (c is TfrxDMPPage);

  SetEnabled([FontNameCB, FontSizeCB, BoldB, ItalicB, UnderlineB, FontColorB],
    (FontEnabled or (Count > 1)) and not (FPage is TfrxDMPPage));
  SetEnabled([FontB], (FontEnabled or DMPEnabled or (Count > 1)));
  SetEnabled([TextAlignLeftB, TextAlignCenterB, TextAlignRightB,
    TextAlignBlockB, TextAlignTopB, TextAlignMiddleB, TextAlignBottomB],
    AlignEnabled or (Count > 1));
  SetEnabled([StyleCB, HighlightB, RotateB],
    (AlignEnabled or (Count > 1)) and not (FPage is TfrxDMPPage));
  SetEnabled([FrameTopB, FrameBottomB, FrameLeftB, FrameRightB, FrameAllB,
    FrameNoB, ShadowB], Frame1Enabled or (Count > 1));
  SetEnabled([FrameColorB, FrameStyleB, FrameWidthCB],
    (Frame2Enabled or (Count > 1)) and not (FPage is TfrxDMPPage));
  SetEnabled([FillColorB], Frame3Enabled and not (FPage is TfrxDMPPage));
  if Report.DotMatrixReport then
  begin
    //FontB.DropDownMenu := DMPPopup;
    FontB.OnClick := nil;
  end
  else
  begin
    //FontB.DropDownMenu := nil;
    FontB.OnClick := FontBClick;
  end;

  DMPFontStyle := [];
  if c is TfrxDMPMemoView then
    DMPFontStyle := TfrxDMPMemoView(c).FontStyle;
  if c is TfrxDMPLineView then
    DMPFontStyle := TfrxDMPLineView(c).FontStyle;
  if c is TfrxDMPPage then
    DMPFontStyle := TfrxDMPPage(c).FontStyle;

  BoldMI.IsChecked := fsxBold in DMPFontStyle;
  ItalicMI.IsChecked := fsxItalic in DMPFontStyle;
  UnderlineMI.IsChecked := fsxUnderline in DMPFontStyle;
  SuperScriptMI.IsChecked := fsxSuperScript in DMPFontStyle;
  SubScriptMI.IsChecked := fsxSubScript in DMPFontStyle;
  CondensedMI.IsChecked := fsxCondensed in DMPFontStyle;
  WideMI.IsChecked := fsxWide in DMPFontStyle;
  N12cpiMI.IsChecked := fsx12cpi in DMPFontStyle;
  N15cpiMI.IsChecked := fsx15cpi in DMPFontStyle;

  UndoB.Enabled := (FUndoBuffer.UndoCount > 1);
  RedoB.Enabled := (FUndoBuffer.RedoCount > 0) and (FPage <> nil);
  CutB.Enabled := ((Count <> 0) and (FSelectedObjects[0] <> FPage)) or (FPage = nil);
  CopyB.Enabled := CutB.Enabled;
  TimerTimer(nil);

  PageSettingsB.Enabled := IsReportPage and CheckOp(drDontChangePageOptions);
  DeletePageB.Enabled := (Report.PagesCount > 2) and (FPage <> nil) and
    not (FPage is TfrxDataPage) and CheckOp(drDontDeletePage) and 
    not Page.IsAncestor;
  SaveB.Enabled := Modified and CheckOp(drDontSaveReport);
  DeleteMI.Enabled := ObjSelected;
  SelectAllMI.Enabled := (FObjects.Count > 2) or (FPage = nil);
  EditMI.Enabled := (Count = 1) and (FPage <> nil);
  SetToGridB.Enabled := ObjSelected;
  BringtoFrontMI.Enabled := ObjSelected;
  SendtoBackMI.Enabled := ObjSelected;
  GroupB.Enabled := ObjSelected and (FSelectedObjects[0] <> Report);
  UngroupB.Enabled := GroupB.Enabled;
  ScaleCB.Enabled := IsReportPage;

  if Count <> 1 then
    s := ''
  else
  begin
    s := c.Name;
    if c is TfrxView then
      if TfrxView(c).IsDataField then
        s := s + ': ' + Report.GetAlias(TfrxView(c).DataSet) + '."' + TfrxView(c).DataField + '"'
      else if c is TfrxCustomMemoView then
        s := s + ': ' + Copy(TfrxCustomMemoView(c).Text, 1, 128);
    if c is TfrxDataBand then
      if TfrxDataBand(c).DataSet <> nil then
        s := s + ': ' + Report.GetAlias(TfrxDataBand(c).DataSet);
    if c is TfrxGroupHeader then
      s := s + ': ' + TfrxGroupHeader(c).Condition
  end;

  //StatusBar.Panels[2].Text := s;

  FUpdatingControls := False;
end;

procedure TfrxDesignerForm.UpdateDataTree;
begin
  FDataTree.UpdateItems;
end;

procedure TfrxDesignerForm.UpdateInspector;
begin
  FInspector.UpdateProperties;
end;

procedure TfrxDesignerForm.UpdateStyles;
begin
  Report.Styles.GetList(StyleCB.Items);
  StyleCB.Items.Insert(0, frxResources.Get('dsNoStyle'));
end;

procedure TfrxDesignerForm.UpdateSyntaxType;
begin
  //CodeWindow.SyntaxType := Report.ScriptLanguage;
  if CompareText(Report.ScriptLanguage, 'PascalScript') = 0 then
  begin
    CodeWindow.SyntaxType := TSyntaxType.stPascal;
    OpenScriptDialog.FilterIndex := 1;
    OpenScriptDialog.DefaultExt := 'pas';
    SaveScriptDialog.FilterIndex := 1;
    SaveScriptDialog.DefaultExt := 'pas';
  end
  else if CompareText(Report.ScriptLanguage, 'C++Script') = 0 then
  begin
    CodeWindow.SyntaxType := TSyntaxType.stCpp;
    OpenScriptDialog.FilterIndex := 2;
    OpenScriptDialog.DefaultExt := 'cpp';
    SaveScriptDialog.FilterIndex := 2;
    SaveScriptDialog.DefaultExt := 'cpp';
  end
  else if CompareText(Report.ScriptLanguage, 'JScript') = 0 then
  begin
    CodeWindow.SyntaxType := TSyntaxType.stJs;
    OpenScriptDialog.FilterIndex := 3;
    OpenScriptDialog.DefaultExt := 'js';
    SaveScriptDialog.FilterIndex := 3;
    SaveScriptDialog.DefaultExt := 'js';
  end
  else if CompareText(Report.ScriptLanguage, 'BasicScript') = 0 then
  begin
    CodeWindow.SyntaxType := TSyntaxType.stVB;
    OpenScriptDialog.FilterIndex := 4;
    OpenScriptDialog.DefaultExt := 'vb';
    SaveScriptDialog.FilterIndex := 4;
    SaveScriptDialog.DefaultExt := 'vb';
  end
  else
  begin
    OpenScriptDialog.FilterIndex := 5;
    OpenScriptDialog.DefaultExt := '';
    SaveScriptDialog.FilterIndex := 5;
    SaveScriptDialog.DefaultExt := '';
  end
end;

procedure TfrxDesignerForm.FindOrReplace(replace: Boolean);
begin
  with TfrxSearchDialog.Create(Application) do
  begin
    FSearchReplace := replace;
    //if FSearchReplace then
    //  ReplacePanel.Show;
    if Page <> nil then
      TopCB.Enabled := False;
    if ShowModal = mrOk then
    begin
      FSearchText := TextE.Text;
      FSearchReplaceText := ReplaceE.Text;
      FSearchCase := CaseCB.IsChecked;
      FSearchIndex := 0;
      //if (Page = nil) and not TopCB.IsChecked then
      //  FSearchIndex := CodeWindow.GetPlainPos;
      FindNextMI.Enabled := True;
      FindText;
    end;
    Free;
  end;
end;

procedure TfrxDesignerForm.Lock;
begin
  FObjects.Clear;
  FSelectedObjects.Clear;
  FWorkspace.DisableUpdate;
  FInspector.DisableUpdate;
end;

procedure TfrxDesignerForm.CreateColorSelector(Sender: TfrxToolButton);
var
  AColor: TAlphaColor;
  i: Integer;
begin
  AColor := claBlack;
  for i := 0 to SelectedObjects.Count - 1 do
    if TObject(SelectedObjects[i]) is TfrxView then
    begin
      if Sender = FontColorB then
        AColor := TfrxView(SelectedObjects[i]).Font.Color
      else if Sender = FrameColorB then
        AColor := TfrxView(SelectedObjects[i]).Frame.Color
      else
        AColor := TfrxView(SelectedObjects[i]).Color;
      break;
    end;

  if FColorSelector = nil then
  begin
    FColorSelector := TfrxColorSelector.Create(Self);
    FColorSelector.Parent := Self;
    FColorSelector.OnColorChanged := Self.OnColorChanged;
  end;

  with FColorSelector do
  begin
    Color := AColor;
    BtnCaption := frxResources.Get('dsColorOth');
    Popup(Sender);
  end;
end;

procedure TfrxDesignerForm.SwitchToCodeWindow;
begin
  Page := nil;
end;

function TfrxDesignerForm.AskSave: Word;
begin
  if IsPreviewDesigner then
    Result := frxConfirmMsg(frxResources.Get('dsSavePreviewChanges'), [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo, TMsgDlgBtn.mbCancel])
  else
    Result := frxConfirmMsg(frxResources.Get('dsSaveChangesTo') + ' ' +
      GetReportName + '?', [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo, TMsgDlgBtn.mbCancel]);
end;

function TfrxDesignerForm.CheckOp(Op: TfrxDesignerRestriction): Boolean;
begin
  Result := True;
  if (frxDesignerComp <> nil) and (Op in frxDesignerComp.Restrictions) then
    Result := False;
end;

function TfrxDesignerForm.GetPageIndex: Integer;
begin
  Result := Report.Objects.IndexOf(FPage);
end;

function TfrxDesignerForm.GetReportName: String;
begin
  if Report.FileName = '' then
    Result := 'Untitled.'+ FTemplateExt else
    Result := ExtractFileName(Report.FileName);
end;

procedure TfrxDesignerForm.LoadFile(FileName: String; UseOnLoadEvent: Boolean);
var
  SaveSilentMode: Boolean;

  function SaveCurrentFile: Boolean;
  var
    w: Word;
  begin
    Result := True;
    if Modified then
    begin
      w := AskSave;
      if w = mrYes then
        SaveFile(False, UseOnLoadEvent)
      else if w = mrCancel then
        Result := False;
    end;
  end;

  procedure EmptyReport;
  var
    p: TfrxPage;
  begin
    Report.Clear;
    p := TfrxDataPage.Create(Report);
    p.Name := 'Data';
    p := TfrxReportPage.Create(Report);
    p.Name := 'Page1';
  end;

  procedure Error;
  begin
    frxErrorMsg(frxResources.Get('dsCantLoad'));
  end;

begin
  SaveSilentMode := Report.EngineOptions.SilentMode;
  Report.EngineOptions.SilentMode := False;

  if FileName <> '' then  // call from recent filelist
  begin
    if SaveCurrentFile then
    begin
      Lock;
        if UseOnLoadEvent and (frxDesignerComp <> nil) and
          Assigned(frxDesignerComp.FOnLoadRecentReport) then
        begin
          if frxDesignerComp.FOnLoadRecentReport(Report, FileName) then
            ReloadReport else
            ReloadPages(-2);
        end
        else
        begin
          try
            if not Report.LoadFromFile(FileName) then
              Error;
            except
              EmptyReport;
            end;
        end;
    end;
    Report.EngineOptions.SilentMode := SaveSilentMode;
    ReloadReport;
    Exit;
  end;

  if UseOnLoadEvent then
    if (frxDesignerComp <> nil) and Assigned(frxDesignerComp.FOnLoadReport) then
    begin
      Lock;
      if frxDesignerComp.FOnLoadReport(Report) then
        ReloadReport else
        ReloadPages(-2);
      Report.EngineOptions.SilentMode := SaveSilentMode;
      Exit;
    end;

  if frxDesignerComp <> nil then
    OpenDialog.InitialDir := frxDesignerComp.OpenDir;
  if OpenDialog.Execute then
  begin
    if SaveCurrentFile then
    begin
      Lock;
      if not Report.LoadFromFile(OpenDialog.FileName) then
      begin
        Error;
        EmptyReport;
      end;
    end;
    Report.EngineOptions.SilentMode := SaveSilentMode;
    ReloadReport;
  end;
  PeekLastModalResult;
end;

function TfrxDesignerForm.SaveFile(SaveAs: Boolean; UseOnSaveEvent: Boolean): Boolean;
var
  Saved: Boolean;
  FilterCount: Integer;
begin
  Result := True;
  Report.ScriptText := CodeWindow.Lines;
  Report.ReportOptions.LastChange := Now;

  if UseOnSaveEvent then
    if (frxDesignerComp <> nil) and Assigned(frxDesignerComp.FOnSaveReport) then
    begin
      if frxDesignerComp.FOnSaveReport(Report, SaveAs) then
      begin
        UpdateRecentFiles(Report.FileName);
        UpdateCaption;
        Modified := False;
      end;
      Exit;
    end;

  Saved := True;
  if SaveAs or (Report.FileName = '') then
  begin
    SaveDialog.DefaultExt := FTemplateExt;
    SaveDialog.Filter := frxResources.Get('dsRepFilter');
    FilterCount := 1;
    if frxCompressorClass <> nil then
    begin
      SaveDialog.Filter := SaveDialog.Filter + '|' + frxResources.Get('dsComprRepFilter');
      Inc(FilterCount);
    end;
    if frxSavePlugin <> nil then
    begin
      SaveDialog.Filter := SaveDialog.Filter + '|' + frxSavePlugin.FileFilter;
      Inc(FilterCount);
    end;

    if Report.ReportOptions.Compressed and (frxCompressorClass <> nil) then
      SaveDialog.FilterIndex := 2 else
      SaveDialog.FilterIndex := 1;
    if frxDesignerComp <> nil then
      SaveDialog.InitialDir := frxDesignerComp.SaveDir;

    Saved := SaveDialog.Execute;
    PeekLastModalResult;
    if Saved then
    begin
      if (frxSavePlugin <> nil) and (SaveDialog.FilterIndex = FilterCount) then
        frxSavePlugin.Save(Report, SaveDialog.FileName)
      else
      begin
        Report.ReportOptions.Compressed := SaveDialog.FilterIndex = 2;
        Report.FileName := SaveDialog.FileName;
        Report.SaveToFile(Report.FileName);
      end;
    end
  end
  else
    Report.SaveToFile(Report.FileName);

  UpdateRecentFiles(Report.FileName);
  UpdateCaption;
  if Saved then
    Modified := False;
  Result := Saved;
end;

procedure TfrxDesignerForm.UpdateCaption;
begin
  Caption := 'FastReport - ' + GetReportName;
end;

procedure TfrxDesignerForm.UpdateRecentFiles(NewFile: String);
var
  i: Integer;
  m: TMenuItem;
begin
  if NewFile <> '' then
  begin
    if FRecentFiles.IndexOf(NewFile) <> -1 then
      FRecentFiles.Delete(FRecentFiles.IndexOf(NewFile));
    FRecentFiles.Add(NewFile);
    while FRecentFiles.Count > 8 do
      FRecentFiles.Delete(0);
  end;

  //SepMI11.Visible := FRecentFiles.Count <> 0;

//  for i := FileMenu.Count - 1 downto 0 do
//  begin
//    m := FileMenu.Items[i];
//    if m.Tag = 100 then
//      m.Free;
//  end;

  if CheckOp(drDontShowRecentFiles) then
    for i := FRecentFiles.Count - 1 downto 0 do
    begin
      m := TMenuItem.Create(FileMenu);
      m.Text := FRecentFiles[i];
      m.OnClick := OpenRecentFile;
      m.Tag := 100;
      //FileMenu.Insert(FileMenu.IndexOf(SepMI4), m);
    end;
end;

procedure TfrxDesignerForm.SwitchToolbar;
var
  i: Integer;
  Item: TfrxObjectItem;
  b: TfrxToolButton;
  Category: TfrxObjectCategories;
  IsToolandBand: Boolean;

  function GetCategory(Category: Integer): TfrxObjectCategories;
  var
    i: Integer;
    Item: TfrxObjectItem;
  begin
    Result := [];
    for i := 0 to frxObjects.Count - 1 do
    begin
      Item := frxObjects[i];
      if (Item.ClassRef <> nil) and
         (Item.CategoryName = frxObjects[Category].CategoryName) then
      begin
        Result := Item.Category;
        break;
      end;
    end;
  end;

begin
  ObjectSelectB.IsPressed := True;
  SelectToolBClick(nil);

  for i := ObjectsTB1.ChildrenCount - 1 downto 0 do
  begin
    b := TfrxToolButton(ObjectsTB1.Children[i]);

    if b <> ObjectSelectB then
    begin
      IsToolandBand := False;
      Category := [];

      if b.Tag = 1000 then  { tools and band }
        IsToolandBand := True
      else                  { object or category }
      begin
        Item := frxObjects[b.Tag];
        if Item.ClassRef <> nil then  { object }
          Category := Item.Category
        else
          Category := GetCategory(b.Tag);
      end;

      if FPage is TfrxDialogPage then
        b.Visible := ctDialog in Category
      else if FPage is TfrxDMPPage then
        b.Visible := (ctDMP in Category) or IsToolandBand
      else if FPage is TfrxReportPage then
        b.Visible := (ctReport in Category) or IsToolandBand
      else if FPage is TfrxDataPage then
        b.Visible := ctData in Category
      else if FPage = nil then
        b.Visible := False;
    end;
  end;
end;

function TfrxDesignerForm.mmToUnits(mm: Extended; X: Boolean = True): Extended;
begin
  Result := 0;
  case FUnits of
    duCM:
      Result := mm / 10;
    duInches:
      Result := mm / 25.4;
    duPixels:
      Result := mm * 96 / 25.4;
    duChars:
      if X then
        Result := Round(mm * fr01cm / fr1CharX) else
        Result := Round(mm * fr01cm / fr1CharY);
  end;
end;

function TfrxDesignerForm.UnitsTomm(mm: Extended; X: Boolean = True): Extended;
begin
  Result := 0;
  case FUnits of
    duCM:
      Result := mm * 10;
    duInches:
      Result := mm * 25.4;
    duPixels:
      Result := mm / 96 * 25.4;
    duChars:
      if X then
        Result := Round(mm) * fr1CharX / fr01cm  else
        Result := Round(mm) * fr1CharY / fr01cm;
  end;
end;

function TfrxDesignerForm.InsertExpression(const Expr: String): String;
begin
  with TfrxExprEditorForm.Create(Self) do
  begin
    ExprMemo.Text := Expr;
    if ShowModal = mrOk then
      Result := ExprMemo.Text else
      Result := '';
    Free;
  end
end;

procedure TfrxDesignerForm.UpdatePage;
begin
  FWorkspace.Repaint;
end;

procedure TfrxDesignerForm.FindText;
var
  i: Integer;
  c: TfrxComponent;
  s: String;
  Found, FoundOne: Boolean;
  Flags: TReplaceFlags;
  ReplaceAll: Boolean;

  function AskReplace: Boolean;
  var
    i: Integer;
  begin
    if not ReplaceAll then
      i := MessageDlg(Format(frxResources.Get('dsReplace'), [FSearchText]),
        TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo, TMsgDlgBtn.mbCancel, TMsgDlgBtn.mbAll], 0)
    else
      i := mrAll;
    Result := i in [mrYes, mrAll];
    ReplaceAll := i = mrAll;

{    Result := Application.MessageBox(
      PChar(Format(frxResources.Get('dsReplace'), [FSearchText])),
      PChar(frxResources.Get('mbConfirm')), mb_IconQuestion + mb_YesNo) = mrYes;}
  end;

begin
  ReplaceAll := False;
  FoundOne := False;

  repeat
    Found := False;
    if FPage <> nil then
    begin
      c := nil;
      for i := FSearchIndex to Objects.Count - 1 do
      begin
        c := Objects[i];
        if c is TfrxCustomMemoView then
        begin
          s := TfrxCustomMemoView(c).Text;
          if FSearchCase then
          begin
            if Pos(FSearchText, s) <> 0 then
              Found := True;
          end
          else if Pos(AnsiUpperCase(FSearchText), AnsiUpperCase(s)) <> 0 then
            Found := True;
        end;
        if Found then break;
      end;

      if Found then
      begin
        FSearchIndex := i + 1;
        SelectedObjects.Clear;
        SelectedObjects.Add(c);
        OnSelectionChanged(Self);
        if FSearchReplace then
          if AskReplace then
          begin
            Flags := [rfReplaceAll];
            if not FSearchCase then
              Flags := Flags + [rfIgnoreCase];
            TfrxCustomMemoView(c).Text := StringReplace(s, FSearchText,
              FSearchReplaceText, Flags);
            Modified := True;
          end;
      end;
    end
    else
    begin
      Found := CodeWindow.Find(FSearchText);//, FSearchCase, FSearchIndex);
      if FSearchReplace then
        if Found and AskReplace then
        begin
          CodeWindow.SelText := FSearchReplaceText;
          Modified := True;
        end;
    end;

    if Found then
      FoundOne := True;
  until not ReplaceAll or not Found;

  if not FoundOne then
    frxInfoMsg(Format(frxResources.Get('dsTextNotFound'), [FSearchText]));
end;

procedure TfrxDesignerForm.RestorePagePosition;
var
  pt: TPoint;
begin
  if (FTabs.TabIndex > 0) and (FTabs.TabIndex < 255) then
  begin
    pt := fsPosToPoint(FPagePositions[FTabs.TabIndex]);
{$IFDEF DELPHI18}
    ScrollBox.ViewportPosition := PointF(pt.X, pt.Y);
{$ELSE}
    ScrollBox.VScrollBar.Value := pt.X;
    ScrollBox.HScrollBar.Value := pt.Y;
{$ENDIF}
  end;
end;

procedure TfrxDesignerForm.SavePagePosition;
begin
  if (FTabs.TabIndex > 0) and (FTabs.TabIndex < 255) then
{$IFDEF DELPHI18}
    FPagePositions[FTabs.TabIndex] := IntToStr(Round(ScrollBox.ViewportPosition.X)) +
      ':' + IntToStr(Round(ScrollBox.ViewportPosition.Y));
{$ELSE}
    FPagePositions[FTabs.TabIndex] := IntToStr(Round(ScrollBox.HScrollBar.Value)) +
      ':' + IntToStr(Round(ScrollBox.VScrollBar.Value));
{$ENDIF}

end;


{ Workspace/Inspector event handlers }
{------------------------------------------------------------------------------}

procedure TfrxDesignerForm.OnModify(Sender: TObject);
begin
  FModifiedBy := Sender;
  Modified := True;
end;

procedure TfrxDesignerForm.OnSelectionChanged(Sender: TObject);
var
  c: TfrxComponent;
begin
  if FLockSelectionChanged then Exit;
  if Sender = FReportTree then
  begin
    c := SelectedObjects[0];
    if (c <> Report) and (Page <> nil) then
      if c.Page <> Page then
      begin
        Page := c.Page;
        SelectedObjects[0] := c;
        FReportTree.UpdateSelection;
      end;
  end
  else
    FReportTree.UpdateSelection;

  if Sender <> FWorkspace then
    FWorkspace.UpdateView;

  if Sender <> FInspector then
  begin
    FInspector.Objects := FObjects;
    FInspector.UpdateProperties;
  end;

  FDataTree.UpdateSelection;
  UpdateControls;
end;

procedure TfrxDesignerForm.OnEditObject(Sender: TObject);
var
  ed: TfrxComponentEditor;
begin
  if FSelectedObjects[0] <> nil then
    if rfDontEdit in TfrxComponent(FSelectedObjects[0]).Restrictions then
      Exit;

  ed := frxComponentEditors.GetComponentEditor(FSelectedObjects[0], Self, nil);
  if (ed <> nil) and ed.HasEditor then
    if ed.Edit then
    begin
      Modified := True;
      if FSelectedObjects[0] = FPage then
        UpdatePageDimensions;
    end;
  ed.Free;
end;

procedure TfrxDesignerForm.OnInsertObject(Sender: TObject);
var
  c: TfrxComponent;
  SaveLeft, SaveTop, SaveWidth, SaveHeight: Extended;

  function CheckContainers(Obj: TfrxComponent): Boolean;
  var
    i: Integer;
    c: TfrxComponent;
  begin
    Result := False;
    for i := 0 to FObjects.Count - 1 do
    begin
      c := FObjects[i];
      if (c <> Obj) and (csContainer in c.frComponentStyle) then
        if (Obj.Left >= c.AbsLeft) and (Obj.Top >= c.AbsTop) and
          (Obj.Left + Obj.Width <= c.AbsLeft + c.Width) and
          (Obj.Top + Obj.Height <= c.AbsTop + c.Height) then
      begin
        Result := c.ContainerAdd(Obj);
        break;
      end;
    end;
  end;

begin
  if (not CheckOp(drDontInsertObject) or (FWorkspace.Insertion.Top < 0)) then
  begin
    FWorkspace.SetInsertion(nil, 0, 0, 0);
    ObjectSelectB.IsPressed := True;
    Exit;
  end;

  with FWorkspace.Insertion do
  begin
    if (ComponentClass = nil) or ((Width = 0) and (Height = 0)) then Exit;

    SaveLeft := Left;
    SaveTop := Top;
    SaveWidth := Width;
    SaveHeight := Height;
    c := TfrxComponent(ComponentClass.NewInstance);
    c.DesignCreate(FPage, Flags);
    c.SetBounds(SaveLeft, SaveTop, SaveWidth, SaveHeight);
    c.CreateUniqueName;
    if c is TfrxCustomLineView then
      FWorkspace.SetInsertion(ComponentClass, 0, 0, Flags)
    else
    begin
      FWorkspace.SetInsertion(nil, 0, 0, 0);
      ObjectSelectB.IsPressed := True;
    end;

    if c is TfrxCustomMemoView then
    begin
      FSampleFormat.ApplySample(TfrxCustomMemoView(c));
      if FPage is TfrxDataPage then
        TfrxCustomMemoView(c).Wysiwyg := False;
    end;

    if not CheckContainers(c) then
      FObjects.Add(c);
    FSelectedObjects.Clear;
    FSelectedObjects.Add(c);

    if (frxDesignerComp <> nil) and Assigned(frxDesignerComp.FOnInsertObject) then
      frxDesignerComp.FOnInsertObject(c);

    if c is TfrxSubreport then
    begin
      NewPageCmdExecute(Self);
      TfrxSubreport(c).Page := TfrxReportPage(Report.Pages[Report.PagesCount - 1]);
      ReloadPages(Report.PagesCount - 1);
    end
    else
    begin
      Modified := True;
      if EditAfterInsert and not
        ((c is TfrxDialogControl) or (c is TfrxDialogComponent)) then
        OnEditObject(Self);
    end;

    FWorkspace.BringToFront;
  end;
end;

procedure TfrxDesignerForm.OnNotifyPosition(ARect: TfrxRect);
var
  dx, dy: Extended;
begin
  with ARect do
  begin
    if FUnits = duCM then
    begin
      dx := 1 / 96 * 2.54;
      dy := dx;
    end
    else if FUnits = duChars then
    begin
      dx := 1 / fr1CharX;
      dy := 1 / fr1CharY;
    end
    else if FUnits = duPixels then
    begin
      dx := 1;
      dy := dx;
    end
    else
    begin
      dx := 1 / 96;
      dy := dx;
    end;

    Left := Left * dx;
    Top := Top * dy;
    if FWorkspace.Mode <> dmScale then
    begin
      Right := Right * dx;
      Bottom := Bottom * dy;
    end;

    if FUnits = duChars then
    begin
      Left := Trunc(Left);
      Top := Trunc(Top);
      Right := Trunc(Right);
      Bottom := Trunc(Bottom);
    end;


    FCoord1 := '';
    FCoord2 := '';
    FCoord3 := '';
    if (not FWorkspace.IsMouseDown) and (FWorkspace.Mode <> dmInsertObject) then
      if (FSelectedObjects.Count > 0) and (FSelectedObjects[0] = FPage) then
        FCoord1 := Format('%f; %f', [Left, Top])
      else
      begin
        FCoord1 := Format('%f; %f', [Left, Top]);
        FCoord2 := Format('%f; %f', [Right, Bottom]);
      end
    else
    case FWorkspace.Mode of
      dmMove, dmSize, dmSizeBand, dmInsertObject, dmInsertLine:
        begin
          FCoord1 := Format('%f; %f', [Left, Top]);
          FCoord2 := Format('%f; %f', [Right, Bottom]);
        end;

      dmScale:
        begin
          FCoord1 := Format('%f; %f', [Left, Top]);
          FCoord3 := Format('%s%f; %s%f', ['%', Right * 100, '%', Bottom * 100]);
        end;
    end;
  end;

  LeftRuler.RulePosition := ARect.Top;
  TopRuler.RulePosition := ARect.Left;

  if FPage = nil then
    OnChangePosition(Self);  

//  StatusBar.Repaint;
end;


{ Toolbar buttons' events }
{------------------------------------------------------------------------------}

procedure TfrxDesignerForm.SelectToolBClick(Sender: TObject);
begin
  if Sender is TfrxToolButton then
    TfrxToolButton(Sender).IsPressed := True;

  FWorkspace.SetInsertion(nil, 0, 0, 0);
end;

procedure TfrxDesignerForm.ObjectBandBClick(Sender: TObject);
var
  pt: TPointF;
begin
  pt := Self.ClientToScreen(PointF(TControl(Sender).AbsoluteRect.Right, TControl(Sender).AbsoluteRect.Top));
  BandsPopup.Popup(pt.X, pt.Y);
end;

procedure TfrxDesignerForm.ObjectsButtonClick(Sender: TObject);
var
  i: Integer;
  Obj, Item: TfrxObjectItem;
  c: TfrxComponent;
  dx, dy: Extended;
  m: TMenuItem;
  pt: TPointF;
  s: String;
begin
  SelectToolBClick(Sender);
  if Page = nil then Exit;
  Obj := frxObjects[TComponent(Sender).Tag];

  if Obj.ClassRef = nil then  { it's a category }
  begin
{$IFDEF Delphi17}
    ObjectsPopup.Clear;
{$ELSE}
    while ObjectsPopup.ChildrenCount > 0 do
      ObjectsPopup.Children[0].Free;
{$ENDIF}
    for i := 0 to frxObjects.Count - 1 do
    begin
      Item := frxObjects[i];
      if (Item.ClassRef <> nil) and (Item.CategoryName = Obj.CategoryName) then
      begin
        if FPage is TfrxDMPPage then
          if not ((Item.ClassRef.ClassName = 'TfrxCrossView') or
            (Item.ClassRef.ClassName = 'TfrxDBCrossView') or
            (Item.ClassRef.InheritsFrom(TfrxDialogComponent))) then continue;

        m := TMenuItem.Create(ObjectsPopup);
        m.Parent := ObjectsPopup;
        frxResources.LoadImageFromResouce(m.Bitmap, Item.ButtonImageIndex);
        s := Item.ButtonHint;
        if s = '' then
          s := Item.ClassRef.GetDescription else
          s := frxResources.Get(s);
        m.Text := s;
        m.OnClick := ObjectsButtonClick;
        m.Tag := i;
      end;
    end;

    pt := Self.ClientToScreen(PointF(TControl(Sender).AbsoluteRect.Right, TControl(Sender).AbsoluteRect.Top));
    ObjectsPopup.Popup(pt.X, pt.Y);
  end
  else  { it's a simple object }
  begin
    c := TfrxComponent(Obj.ClassRef.NewInstance);
    c.Create(FPage);
    dx := c.Width;
    dy := c.Height;
    c.Free;

    if (dx = 0) and (dy = 0) then
    begin
      dx := GetDefaultObjectSize.X;
      dy := GetDefaultObjectSize.Y;
    end;

    FWorkspace.SetInsertion(Obj.ClassRef, dx, dy, Obj.Flags);
  end;
end;

{procedure TfrxDesignerForm.OnExtraToolClick(Sender: TObject);
var
  w: TfrxCustomWizard;
  Item: TfrxWizardItem;
begin
  Item := frxWizards[TfrxToolButton(Sender).Tag];
  w := TfrxCustomWizard(Item.ClassRef.NewInstance);
  w.Create(Self);
  if w.Execute then
    Modified := True;
  w.Free;
end;}

procedure TfrxDesignerForm.InsertBandClick(Sender: TObject);
var
  i: Integer;
  Band: TfrxBand;
  Size: Extended;

  function FindFreeSpace: Extended;
  var
    i: Integer;
    b: TfrxComponent;
  begin
    Result := 0;
    for i := 0 to FPage.Objects.Count - 1 do
    begin
      b := FPage.Objects[i];
      if (b is TfrxBand) and not TfrxBand(b).Vertical then
        if b.Top + b.Height > Result then
          Result := b.Top + b.Height;
    end;

    Result := Round((Result + Workspace.BandHeader + 4) / Workspace.GridY) * Workspace.GridY;
    Result := Round(Result * 100000000) / 100000000;
  end;

begin
  if Page = nil then Exit;

  i := (Sender as TMenuItem).Tag;

  Band := TfrxBand(frxBands[i mod 100].NewInstance);
  Band.Create(FPage);
  Band.CreateUniqueName;
{$IFNDEF RAD_ED}
  if i >= 100 then
    Band.Vertical := True;
{$ENDIF}

  if not Band.Vertical then
    if Workspace.FreeBandsPlacement then
      Band.Top := FindFreeSpace else
      Band.Top := 10000;

  Size := 0;
  case FUnits of
    duCM:     Size := fr01cm * 6;
    duInches: Size := fr01in * 3;
    duPixels: Size := 20;
    duChars:  Size := fr1CharY;
  end;

  if not Band.Vertical then
    Band.Height := Size
  else
  begin
    Band.Left := Size;
    Band.Width := Size;
  end;

  FObjects.Add(Band);
  FSelectedObjects.Clear;
  FSelectedObjects.Add(Band);
  Modified := True;
  OnSelectionChanged(Self);

  ObjectSelectB.IsPressed := True;
  SelectToolBClick(Sender);

  if EditAfterInsert then
    OnEditObject(Self);
end;

procedure TfrxDesignerForm.ToolButtonClick(Sender: TObject);
var
  i, cbIdx: Integer;
  c: TfrxComponent;
  wasModified: Boolean;
  gx, gy: Extended;
  TheFont: TfrxFont;

  procedure EditFont;
  begin
//    with TFontDialog.Create(Application) do
//    begin
//      Font := TfrxComponent(FSelectedObjects[0]).Font;
//      Options := Options + [fdForceFontExist];
//      if Execute then
//      begin
//        TheFont := TFont.Create;
//        TheFont.Assign(Font);
//      end;
//      Free;
//    end;
  end;

  procedure SetFontStyle(c: TfrxComponent; fStyle: TFontStyle; Include: Boolean);
  begin
    with c.Font do
      if Include then
        Style := Style + [fStyle] else
        Style := Style - [fStyle];
  end;

  procedure SetFrameType(c: TfrxComponent; fType: TfrxFrameType; Include: Boolean);
  var
    f: TfrxFrame;
  begin
    if c is TfrxView then
      f := TfrxView(c).Frame
    else if c is TfrxReportPage then
      f := TfrxReportPage(c).Frame else
      Exit;

     with f do
      if Include then
        Typ := Typ + [fType] else
        Typ := Typ - [fType];
  end;

  procedure SetDMPFontStyle(c: TfrxComponent; fStyle: TfrxDMPFontStyle;
    Include: Boolean);
  var
    Style: TfrxDMPFontStyles;
  begin
    Style := [];
    if c is TfrxDMPMemoView then
      Style := TfrxDMPMemoView(c).FontStyle;
    if c is TfrxDMPLineView then
      Style := TfrxDMPLineView(c).FontStyle;
    if c is TfrxDMPPage then
      Style := TfrxDMPPage(c).FontStyle;
    if not Include then
      Style := Style + [fStyle] else
      Style := Style - [fStyle];
    if c is TfrxDMPMemoView then
      TfrxDMPMemoView(c).FontStyle := Style;
    if c is TfrxDMPLineView then
      TfrxDMPLineView(c).FontStyle := Style;
    if c is TfrxDMPPage then
      TfrxDMPPage(c).FontStyle := Style;
  end;

begin
  if FUpdatingControls then Exit;

  TheFont := nil;
  wasModified := False;
  if TComponent(Sender).Tag = 43 then
    EditFont;

  for i := 0 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if rfDontModify in c.Restrictions then continue;

    case TComponent(Sender).Tag of

      0:
      begin
        // OSX is a case sensetive to font names
        cbIdx := FontNameCB.Items.IndexOf(FontNameCB.Text);
        if(cbIdx <> -1) then
          c.Font.Name := FontNameCB.Items[cbIdx];
      end;

      1:  c.Font.Size := StrToInt(FontSizeCB.Text);

      2:  SetFontStyle(c, fsBold, BoldB.IsPressed);

      3:  SetFontStyle(c, fsItalic, ItalicB.IsPressed);

      4:  SetFontStyle(c, fsUnderline, UnderlineB.IsPressed);

      5:  c.Font.Color := FColor;

      6:;

      7:
          if c is TfrxCustomMemoView then
            TfrxCustomMemoView(c).HAlign := haLeft;
      8:
          if c is TfrxCustomMemoView then
            TfrxCustomMemoView(c).HAlign := haCenter;
      9:
          if c is TfrxCustomMemoView then
            TfrxCustomMemoView(c).HAlign := haRight;
      10: 
          if c is TfrxCustomMemoView then
            TfrxCustomMemoView(c).HAlign := haBlock;
      11:
          if c is TfrxCustomMemoView then
            TfrxCustomMemoView(c).VAlign := vaTop;
      12:
          if c is TfrxCustomMemoView then
            TfrxCustomMemoView(c).VAlign := vaCenter;
      13:
          if c is TfrxCustomMemoView then
            TfrxCustomMemoView(c).VAlign := vaBottom;

      20: SetFrameType(c, ftTop, FrameTopB.IsPressed);

      21: SetFrameType(c, ftBottom, FrameBottomB.IsPressed);

      22: SetFrameType(c, ftLeft, FrameLeftB.IsPressed);

      23: SetFrameType(c, ftRight, FrameRightB.IsPressed);

      24: begin
            SetFrameType(c, ftTop, True);
            SetFrameType(c, ftBottom, True);
            SetFrameType(c, ftLeft, True);
            SetFrameType(c, ftRight, True);
          end;

      25: begin
            SetFrameType(c, ftTop, False);
            SetFrameType(c, ftBottom, False);
            SetFrameType(c, ftLeft, False);
            SetFrameType(c, ftRight, False);
          end;

      26: if c is TfrxView then
            TfrxView(c).Color := FColor
          else if c is TfrxReportPage then
            TfrxReportPage(c).Color := FColor
          else if c is TfrxDialogPage then
          begin
            TfrxDialogPage(c).Color := FColor;
            FWorkspace.Color := FColor;
          end;
          //else if c is TfrxDialogControl then
            //TfrxDialogControl(c).Color := FColor;

      27: if c is TfrxView then
            TfrxView(c).Frame.Color := FColor
          else if c is TfrxReportPage then
            TfrxReportPage(c).Frame.Color := FColor;

      28: if c is TfrxView then
            TfrxView(c).Frame.Style := FLineStyle
          else if c is TfrxReportPage then
            TfrxReportPage(c).Frame.Style := FLineStyle;

      29:
        begin
          if FrameWidthCB.Text = '' then exit;
          if c is TfrxView then
            TfrxView(c).Frame.Width := frxStrToFloat(FrameWidthCB.Text)
          else if c is TfrxReportPage then
            TfrxReportPage(c).Frame.Width := frxStrToFloat(FrameWidthCB.Text);
        end;

      30: if c is TfrxCustomMemoView then
            TfrxCustomMemoView(c).Rotation := TMenuItem(Sender).HelpContext;

      31:
        begin
          gx := FWorkspace.GridX;
          gy := FWorkspace.GridY;
          c.Left := Round(c.Left / gx) * gx;
          c.Top := Round(c.Top / gy) * gy;
          c.Width := Round(c.Width / gx) * gx;
          c.Height := Round(c.Height / gy) * gy;
          if c.Width = 0 then
            c.Width := gx;
          if c.Height = 0 then
            c.Height := gy;
        end;

      32: if c is TfrxView then
            TfrxView(c).Frame.DropShadow := ShadowB.IsPressed
          else if c is TfrxReportPage then
            TfrxReportPage(c).Frame.DropShadow := ShadowB.IsPressed;

      33: if c is TfrxCustomMemoView then
            if StyleCB.ItemIndex = 0 then
              TfrxCustomMemoView(c).Style := '' else
              TfrxCustomMemoView(c).Style := StyleCB.Text;

      34: SetDMPFontStyle(c, fsxBold, BoldMI.IsChecked);

      35: SetDMPFontStyle(c, fsxItalic, ItalicMI.IsChecked);

      36: SetDMPFontStyle(c, fsxUnderline, UnderlineMI.IsChecked);

      37: SetDMPFontStyle(c, fsxSuperScript, SuperScriptMI.IsChecked);

      38: SetDMPFontStyle(c, fsxSubScript, SubScriptMI.IsChecked);

      39: SetDMPFontStyle(c, fsxCondensed, CondensedMI.IsChecked);

      40: SetDMPFontStyle(c, fsxWide, WideMI.IsChecked);

      41: SetDMPFontStyle(c, fsx12cpi, N12cpiMI.IsChecked);

      42: SetDMPFontStyle(c, fsx15cpi, N15cpiMI.IsChecked);

      43: if TheFont <> nil then
            c.Font := TheFont;
    end;

    if TComponent(Sender).Tag in [0..5, 20..29, 32] then
      if c is TfrxCustomMemoView then
      begin
        TfrxCustomMemoView(c).Style := '';
        StyleCB.Text := StyleCB.Items[0];
      end;

    if c is TfrxCustomMemoView then
      FSampleFormat.SetAsSample(TfrxCustomMemoView(c));
    wasModified := True;
  end;

  if TheFont <> nil then
    TheFont.Free;

  if not TComponent(Sender).Tag in [1] then
    ScrollBox.SetFocus;

  if wasModified then
  begin
    FModifiedBy := Self;
    Modified := True;

    if TComponent(Sender).Tag in [7..13, 24, 25, 34..43] then
      UpdateControls;
  end;
end;

procedure TfrxDesignerForm.FontBClick(Sender: TObject);
var
  i: Integer;
  c: TfrxComponent;
begin
  with TfrxFontForm.Create(nil) do
  begin
    if FSelectedObjects.Count > 0 then
    begin
      c := FSelectedObjects[0];
      FontS.Assign(c.Font);
    end;
    FormActivate(Sender);
    if ShowModal = mrOk then
    begin
     for i := 0 to FSelectedObjects.Count - 1 do
     begin
       c := FSelectedObjects[i];
       if rfDontModify in c.Restrictions then continue;
       c.Font.Assign(FontS);
     end;
      FModifiedBy := Self;
      Modified := True;
    end;
    Free;
  end;
end;

procedure TfrxDesignerForm.FontColorBClick(Sender: TObject);
begin
  CreateColorSelector(Sender as TfrxToolButton);
end;

procedure TfrxDesignerForm.FrameStyleBClick(Sender: TObject);
begin
  if FLineSelector = nil then
  begin
    FLineSelector := TfrxLineSelector.Create(Self);
    FLineSelector.Parent := Self;
    FLineSelector.OnStyleChanged := Self.OnStyleChanged;
  end;

  FLineSelector.Popup(TControl(Sender));
end;

procedure TfrxDesignerForm.ScaleCBClick(Sender: TObject);
var
  s: String;
  dx, dy: Integer;
begin
  if ScaleCB.ItemIndex = 6 then
    s := IntToStr(Round((ScrollBox.Width - 40) / (TfrxReportPage(FPage).PaperWidth * 96 / 25.4) * 100))
  else if ScaleCB.ItemIndex = 7 then
  begin
    dx := Round(TfrxReportPage(FPage).PaperWidth * 96 / 25.4);
    dy := Round(TfrxReportPage(FPage).PaperHeight * 96 / 25.4);
    if (ScrollBox.Width - 20) / dx < (ScrollBox.Height - 20) / dy then
      s := IntToStr(Round((ScrollBox.Width - 20) / dx * 100)) else
      s := IntToStr(Round((ScrollBox.Height - 20) / dy * 100));
  end
  else
    s := ScaleCB.Text;

  if Pos('%', s) <> 0 then
    s[Pos('%', s)] := ' ';
  while Pos(' ', s) <> 0 do
    Delete(s, Pos(' ', s), 1);

  if s <> '' then
  begin
    Scale := frxStrToFloat(s) / 100;
    ScaleCB.OnChange := nil;
    ScaleCB.Text := s + '%';
    ScaleCB.OnChange := ScaleCBClick;
    ScrollBox.SetFocus;
  end;
end;

procedure TfrxDesignerForm.ShowGridBClick(Sender: TObject);
begin
  ShowGrid := ShowGridB.IsPressed;
end;

procedure TfrxDesignerForm.AlignToGridBClick(Sender: TObject);
begin
  GridAlign := AlignToGridB.IsPressed;
end;

procedure TfrxDesignerForm.LangCBClick(Sender: TObject);
begin
  LangCB.OnChange := nil;
  if frxConfirmMsg(frxResources.Get('dsClearScript'), [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo]) <> mrYes then
  begin
    LangCB.ItemIndex := LangCB.Items.IndexOf(Report.ScriptLanguage);
    Exit;
  end;

  Report.ScriptLanguage := LangCB.Text;
  frxEmptyCode(CodeWindow.Lines, Report.ScriptLanguage);

  UpdateSyntaxType;
  Modified := True;
  CodeWindow.SetFocus;
  LangCB.OnChange := LangCBClick;
end;

procedure TfrxDesignerForm.OpenScriptBClick(Sender: TObject);
begin
  with OpenScriptDialog do
    if Execute then
    begin
      CodeWindow.Lines.LoadFromFile(FileName);
      Modified := True;
    end;
end;

procedure TfrxDesignerForm.SaveScriptBClick(Sender: TObject);
begin
  with SaveScriptDialog do
    if Execute then
      CodeWindow.Lines.SaveToFile(FileName);
end;

procedure TfrxDesignerForm.HighlightBClick(Sender: TObject);
var
  i: Integer;
begin
  with TfrxHighlightEditorForm.Create(Self) do
  begin
    MemoView := SelectedObjects[0];
    FormShow(Self);
    if ShowModal = mrOk then
    begin
      for i := 1 to SelectedObjects.Count - 1 do
        if TObject(SelectedObjects[i]) is TfrxMemoView then
          TfrxMemoView(SelectedObjects[i]).Highlight.Assign(MemoView.Highlight);

      Modified := True;
    end;
    Free;
  end;
end;


{ Controls' event handlers }
{------------------------------------------------------------------------------}

procedure TfrxDesignerForm.OnCodeChanged(Sender: TObject);
begin
  if FPage = nil then
  begin
    FModified := True;
    SaveB.Enabled := CheckOp(drDontSaveReport);
    UndoB.Enabled := True;
  end;
end;

procedure TfrxDesignerForm.OnChangePosition(Sender: TObject);
begin
  if FPage = nil then
  begin
    FCoord1 := Format('%d; %d', [CodeWindow.GetPos.Y, CodeWindow.GetPos.X]);
    FCoord2 := '';
    FCoord3 := '';
  end;
  StatusBar.Repaint;
end;

procedure TfrxDesignerForm.OnColorChanged(Sender: TObject);
begin
  with TfrxColorSelector(Sender) do
  begin
    FColor := Color;
    ToolButtonClick(TfrxColorSelector(Sender));
  end;
end;

procedure TfrxDesignerForm.OnStyleChanged(Sender: TObject);
begin
  with TfrxLineSelector(Sender) do
  begin
    FLineStyle := TfrxFrameStyle(Style);
    ToolButtonClick(TfrxLineSelector(Sender));
  end;
end;

procedure TfrxDesignerForm.ScrollBoxMouseWheelUp(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
{$IFDEF DELPHI18}
  with ScrollBox.ViewportPosition do
    ScrollBox.ViewportPosition := PointF(X, Y - 16)
{$ELSE}
  with ScrollBox.VScrollBar do
    Value := Value - 16;
{$ENDIF}
end;

procedure TfrxDesignerForm.ScrollBoxMouseWheelDown(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
{$IFDEF DELPHI18}
  with ScrollBox.ViewportPosition do
    ScrollBox.ViewportPosition := PointF(X, Y + 16)
{$ELSE}
  with ScrollBox.VScrollBar do
    Value := Value + 16;
{$ENDIF}
end;

procedure TfrxDesignerForm.ScrollBoxResize(Sender: TObject);
var
  ofs, st: Single;
begin
  if FWorkspace = nil then Exit;
{$IFDEF DELPHI18}
  ofs := ScrollBox.Position.X + 2 + FWorkspace.Position.X - ScrollBox.ViewportPosition.X;
{$ELSE}
  ofs := ScrollBox.Position.X + 2 + FWorkspace.Position.X - ScrollBox.HScrollBar.Value;
{$ENDIF}
  st := 0;
  if ofs < ScrollBox.Position.X + 2 then
  begin
    st := ScrollBox.Position.X + 2 - ofs;
    ofs := ScrollBox.Position.X + 2;
  end;

  TopRuler.Offset := Round(ofs);
  TopRuler.Start := Round(st);


{$IFDEF DELPHI18}
  ofs := 2 + FWorkspace.Position.Y - ScrollBox.ViewportPosition.Y;
{$ELSE}
  ofs := 2 + FWorkspace.Position.Y - ScrollBox.VScrollBar.Value;
{$ENDIF}
  st := 0;
  if ofs < 2 then
  begin
    st := 2 - ofs;
    ofs := 2;
  end;

  LeftRuler.Offset := Round(ofs);
  LeftRuler.Start := Round(st);
end;

procedure TfrxDesignerForm.StatusBarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  //FUnitsDblClicked := X < StatusBar.Panels[0].Width;
end;

procedure TfrxDesignerForm.StatusBarDblClick(Sender: TObject);
var
  i: Integer;
begin
  if FUnitsDblClicked and not
    ((FWorkspace.GridType = gtDialog) or (FWorkspace.GridType = gtChar)) then
  begin
    i := Integer(FUnits);
    Inc(i);
    if i > 2 then
      i := 0;
    Units := TfrxDesignerUnits(i);
    FOldUnits := FUnits;
  end;
end;

//procedure TfrxDesignerForm.StatusBarDrawPanel(StatusBar: TStatusBar;
//  Panel: TStatusPanel; const ARect: TRect);
//begin
//  with StatusBar.Canvas do
//  begin
//    FillRect(ARect);
//
//    if FCoord1 <> '' then
//    begin
//      frxResources.MainButtonImages.Draw(StatusBar.Canvas, ARect.Left + 2, ARect.Top - 1, 62);
//      TextOut(ARect.Left + 20, ARect.Top + 1, FCoord1);
//    end;
//
//    if FCoord2 <> '' then
//    begin
//      frxResources.MainButtonImages.Draw(StatusBar.Canvas, ARect.Left + 110, ARect.Top - 1, 63);
//      TextOut(ARect.Left + 130, ARect.Top + 1, FCoord2);
//    end;
//
//    if FCoord3 <> '' then
//      TextOut(ARect.Left + 110, ARect.Top + 1, FCoord3);
//  end;
//end;

procedure TfrxDesignerForm.TimerTimer(Sender: TObject);
begin
  PasteB.Enabled := FClipboard.PasteAvailable or (FPage = nil);
end;

procedure TfrxDesignerForm.BandsPopupPopup(Sender: TObject);

  function FindBand(Band: TfrxComponentClass): TfrxBand;
  var
    i: Integer;
  begin
    Result := nil;
    if FPage = nil then Exit;
    for i := 0 to FPage.Objects.Count - 1 do
      if TObject(FPage.Objects[i]) is Band then
        Result := FPage.Objects[i];
  end;

begin
  ReportTitleMI.Enabled := FindBand(TfrxReportTitle) = nil;
  ReportSummaryMI.Enabled := FindBand(TfrxReportSummary) = nil;
  PageHeaderMI.Enabled := FindBand(TfrxPageHeader) = nil;
  PageFooterMI.Enabled := FindBand(TfrxPageFooter) = nil;
  ColumnHeaderMI.Enabled := FindBand(TfrxColumnHeader) = nil;
  ColumnFooterMI.Enabled := FindBand(TfrxColumnFooter) = nil;
end;

procedure TfrxDesignerForm.TopRulerDragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF});
{$IFDEF DELPHI20}
var  
  Accept: Boolean;
{$ENDIF}
begin
  Accept := Data.Source is TfrxDesignerWorkspace;
 {$IFDEF DELPHI20}
  if Accept then
	Operation := TDragOperation.Copy;
{$ENDIF} 
end;

procedure TfrxDesignerForm.PagePopupPopup(Sender: TObject; X, Y: Single);
var
  ed: TfrxComponentEditor;
  pt: TPointF;
 // m: TMenuItem;
  EditMI1, AddChildMI, CutMI1, CopyMI1, PasteMI1, DeleteMI1, SelectAllMI1, 
  BringtoFrontMI1, SendtoBackMI1, TabOrderMI, SepMI: TMenuItem;
begin
{$IFDEF Delphi17}
  PagePopup.Clear;
{$ELSE}
  while PagePopup.ChildrenCount > 0 do
    PagePopup.Children[0].Free;
{$ENDIF}

  EditMI1 := TMenuItem.Create(PagePopup);
  EditMI1.Parent := PagePopup;
  EditMI1.Text := frxGet(2415);
  EditMI1.OnClick := EditCmdExecute;

  if (TObject(FSelectedObjects[0]) is TfrxBand) and
    not (TObject(FSelectedObjects[0]) is TfrxColumnFooter) and
    not (TObject(FSelectedObjects[0]) is TfrxOverlay) then
  begin
    AddChildMI := TMenuItem.Create(PagePopup);
    AddChildMI.Text := frxGet(2478);
    AddChildMI.OnClick := AddChildMIClick;
    AddChildMI.Parent := PagePopup;
  end;


  ed := frxComponentEditors.GetComponentEditor(FSelectedObjects[0], Self, PagePopup);
  if ed <> nil then
  begin
    EditMI1.Enabled := ed.HasEditor;

    ed.GetMenuItems(OnComponentMenuClick);
    ed.Free;
  end
  else
  begin
    EditMI1.Enabled := False;
  end;

  SepMI := TMenuItem.Create(PagePopup);
  SepMI.Text := '-';
  SepMI.Parent := PagePopup;

  CutMI1 := TMenuItem.Create(PagePopup);
  CutMI1.Text := frxGet(2407);
  CutMI1.OnClick := CutCmdExecute;
  CutMI1.Parent := PagePopup;
  frxResources.LoadImageFromResouce(CutMI1.Bitmap, 0, 5);
  
  CopyMI1 := TMenuItem.Create(PagePopup);
  CopyMI1.Text := frxGet(2408);
  CopyMI1.OnClick := CopyCmdExecute;
  CopyMI1.Parent := PagePopup;
  frxResources.LoadImageFromResouce(CopyMI1.Bitmap, 0, 6);

  PasteMI1 := TMenuItem.Create(PagePopup);
  PasteMI1.Text := frxGet(2409);
  PasteMI1.OnClick := PasteCmdExecute;
  PasteMI1.Parent := PagePopup;
  frxResources.LoadImageFromResouce(PasteMI1.Bitmap, 0, 7);

  DeleteMI1 := TMenuItem.Create(PagePopup);
  DeleteMI1.Text := frxGet(2412);
  DeleteMI1.OnClick := DeleteCmdExecute;
  DeleteMI1.Parent := PagePopup;
  frxResources.LoadImageFromResouce(DeleteMI1.Bitmap, 5, 1);

  SelectAllMI1 := TMenuItem.Create(PagePopup);
  SelectAllMI1.Text := frxGet(2414);
  SelectAllMI1.OnClick := SelectAllCmdExecute;
  SelectAllMI1.Parent := PagePopup;

  BringtoFrontMI1 := TMenuItem.Create(PagePopup);
  BringtoFrontMI1.Text := frxGet(2416);
  BringtoFrontMI1.OnClick := BringToFrontCmdExecute;
  BringtoFrontMI1.Parent := PagePopup;
  frxResources.LoadImageFromResouce(BringtoFrontMI1.Bitmap, 1, 4);

  SendtoBackMI1 := TMenuItem.Create(PagePopup);
  SendtoBackMI1.Text := frxGet(2417);
  SendtoBackMI1.OnClick := SendToBackCmdExecute;
  SendtoBackMI1.Parent := PagePopup;
  frxResources.LoadImageFromResouce(SendtoBackMI1.Bitmap, 1, 5);

  if FPage is TfrxDialogPage then
  begin
    TabOrderMI := TMenuItem.Create(PagePopup);
    TabOrderMI.Text := frxGet(2404);
    TabOrderMI.OnClick := TabOrderMIClick;
    TabOrderMI.Parent := PagePopup;
  end;

  pt := Self.ClientToScreen(PointF((Sender as TControl).AbsoluteRect.Left + X, (Sender as TControl).AbsoluteRect.Top + Y));
  PagePopup.Popup(pt.X, pt.Y);
  //p.Free;
end;

procedure TfrxDesignerForm.CodeWindowDragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF});
{$IFDEF DELPHI20}
var  
  Accept: Boolean;
{$ENDIF}
begin
  Accept := (Data.Source is TTreeView) and (TTreeView(Data.Source).Owner = FDataTree) and
     (FDataTree.GetFieldName <> '');
 {$IFDEF DELPHI20}
  if Accept then
	Operation := TDragOperation.Copy;
{$ENDIF} 
end;

procedure TfrxDesignerForm.CodeWindowDragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
begin
  CodeWindow.SelText := FDataTree.GetFieldName;
  CodeWindow.SetFocus;
end;

{procedure TfrxDesignerForm.OnDataTreeDblClick(Sender: TObject);
begin
  if Page = nil then
  begin
    CodeWindow.SelText := FDataTree.GetFieldName;
    CodeWindow.SetFocus;
  end
  else if (FDataTree.GetActivePage = 0) and
    (Report.DataSets.Count = 0) then
    ReportDataCmdExecute(Self);
end;}

procedure TfrxDesignerForm.TabChanging(Sender: TObject; var AllowChange: Boolean);
begin
  if IsPreviewDesigner or FScriptRunning then
    AllowChange := False;

  if (FTabs.TabIndex = 0) and CodeWindow.Modified then
  begin
    Modified := True;
    CodeWindow.Modified := False;
  end;

  SavePagePosition;
end;

procedure TfrxDesignerForm.TabSetChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  TabChanging(nil, AllowChange);
end;

procedure TfrxDesignerForm.TabChange(Sender: TObject);
begin
  if FTabs.TabIndex = -1 then Exit;

  if (FTabs.TabIndex = 0) then
{$IFDEF FR_VER_BASIC}
    FTabs.TabIndex := 1 else
{$ELSE}
  begin
    if CheckOp(drDontEditReportScript) then Page := nil
    else FTabs.TabIndex := 1
  end else
{$ENDIF}
  if (FTabs.TabIndex = 1) and not CheckOp(drDontEditInternalDatasets) then
    FTabs.TabIndex := 2
  else Page := Report.Pages[FTabs.TabIndex - 1];
end;

procedure TfrxDesignerForm.TabMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
//var
//  p: TPointF;
begin
//  p := Platform.GetMousePos;
//  if Button = mbRight then
//    TabPopup.Popup(p.X, p.Y) else
    FMouseDown := True;
end;

procedure TfrxDesignerForm.TabMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  pt: TPointF;
begin
  FMouseDown := False;
  if Button = mbRight then
  begin
    pt := Self.ClientToScreen(PointF(X, Y));
    TabPopup.Popup(pt.X, pt.Y);
  end;
end;

procedure TfrxDesignerForm.TabMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
begin
  //if FMouseDown then
  //  FTabs.BeginDrag(False);
end;

procedure TfrxDesignerForm.TabDragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF});
{$IFDEF DELPHI20}
var  
  Accept: Boolean;
{$ENDIF}
begin
  Accept := Data.Source is Sender.ClassType;
 {$IFDEF DELPHI20}
  if Accept then
	Operation := TDragOperation.Copy;
{$ENDIF} 
end;


procedure TfrxDesignerForm.TabDragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
//var
//  HitPage, CurPage: Integer;
//  HitTestInfo: TTCHitTestInfo;
begin
//  HitTestInfo.pt := Point(X, Y);
//  HitPage := SendMessage(FTabs.Handle, TCM_HITTEST, 0, Longint(@HitTestInfo));
//  CurPage := Report.Objects.IndexOf(Page) + 1;
//  if (CurPage < 2) or (HitPage < 2) then Exit;
//
//  FTabs.Tabs.Move(CurPage, HitPage);
//  Report.Objects.Move(CurPage - 1, HitPage - 1);
//  Modified := True;
end;


{ Menu commands }
{------------------------------------------------------------------------------}

procedure TfrxDesignerForm.ExitCmdExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrxDesignerForm.UndoCmdExecute(Sender: TObject);
var
  i: Integer;
  SaveX, SaveY: Single;
  TmpPage: TfrxReportPage;
begin
  if FPage = nil then
  begin
    CodeWindow.Undo;
    Exit;
  end;
  Lock;
  Report.ScriptText := CodeWindow.Lines;
{$IFDEF DELPHI18}
  SaveY := ScrollBox.ViewportPosition.Y;
  SaveX := ScrollBox.ViewportPosition.X;
{$ELSE}
  SaveY := ScrollBox.VScrollBar.Value;
  SaveX := ScrollBox.HScrollBar.Value;
{$ENDIF}
  if IsPreviewDesigner then
  begin
    i := 1;
    if FPage is TfrxDMPPage then
      TmpPage := TfrxDMPPage.Create(nil)
    else
      TmpPage := TfrxReportPage.Create(nil);

    FUndoBuffer.AddRedo(FPage);
    FPage.Free;
    FUndoBuffer.GetUndo(TmpPage);
    TmpPage.Parent := Report;
    FPage := TmpPage;
  end
  else
  begin
    i := GetPageIndex;
    FUndoBuffer.AddRedo(Report);
    FUndoBuffer.GetUndo(Report);
    CodeWindow.Lines := Report.ScriptText;
  end;

  ReloadPages(i);
{$IFDEF DELPHI18}
  ScrollBox.ViewportPosition := PointF(Savex, SaveY);
{$ELSE}
  ScrollBox.VScrollBar.Value := SaveY;
  ScrollBox.HScrollBar.Value := SaveX;
{$ENDIF}
  if not Modified then
    SaveB.Enabled := True;
end;

procedure TfrxDesignerForm.RedoCmdExecute(Sender: TObject);
var
  i: Integer;
  SaveX, SaveY: Single;
  TmpPage: TfrxReportPage;
begin
  Lock;
{$IFDEF DELPHI18}
  SaveY := ScrollBox.ViewportPosition.Y;
  SaveX := ScrollBox.ViewportPosition.X;
{$ELSE}
  SaveY := ScrollBox.VScrollBar.Value;
  SaveX := ScrollBox.HScrollBar.Value;
{$ENDIF}
  if IsPreviewDesigner then
  begin
    i := 1;
    if FPage is TfrxDMPPage then
      TmpPage := TfrxDMPPage.Create(nil)
    else
      TmpPage := TfrxReportPage.Create(nil);

    FUndoBuffer.GetRedo(TmpPage);
    FUndoBuffer.AddUndo(TmpPage);
    FPage.Free;
    TmpPage.Parent := Report;
    FPage := TmpPage;
  end
  else
  begin
    i := GetPageIndex;
    Report.Reloading := True;
    FUndoBuffer.GetRedo(Report);
    Report.Reloading := False;
    FUndoBuffer.AddUndo(Report);
    CodeWindow.Lines := Report.ScriptText;
  end;

  ReloadPages(i);
{$IFDEF DELPHI18}
  ScrollBox.ViewportPosition := PointF(Savex, SaveY);
{$ELSE}
  ScrollBox.VScrollBar.Value := SaveY;
  ScrollBox.HScrollBar.Value := SaveX;
{$ENDIF}
end;

procedure TfrxDesignerForm.CutCmdExecute(Sender: TObject);
begin
  if FPage = nil then
  begin
    CodeWindow.CutToClipboard;
    Exit;
  end;

  FClipboard.Copy;
  FWorkspace.DeleteObjects;
  FInspector.Objects := FObjects;

  Modified := True;
end;

procedure TfrxDesignerForm.CopyCmdExecute(Sender: TObject);
begin
  if FPage = nil then
  begin
    CodeWindow.CopyToClipboard;
    Exit;
  end;

  FClipboard.Copy;
  TimerTimer(nil);
end;

procedure TfrxDesignerForm.PasteCmdExecute(Sender: TObject);
begin
  if FPage = nil then
  begin
    CodeWindow.PasteFromClipboard;
    Exit;
  end;

  FClipboard.Paste;
  FWorkspace.BringToFront;
  FInspector.Objects := FObjects;
  FInspector.UpdateProperties;

  if TfrxComponent(FSelectedObjects[0]) is TfrxDialogComponent then
    Modified := True
  else if FSelectedObjects[0] <> FPage then
    TDesignerWorkspace(FWorkspace).SimulateMove;
end;

procedure TfrxDesignerForm.GroupCmdExecute(Sender: TObject);
begin
  FWorkspace.GroupObjects;
end;

procedure TfrxDesignerForm.UngroupCmdExecute(Sender: TObject);
begin
  FWorkspace.UngroupObjects;
end;

procedure TfrxDesignerForm.DeletePageCmdExecute(Sender: TObject);
begin
  if not CheckOp(drDontDeletePage) then Exit;

  Lock;
  if (FPage is TfrxReportPage) and (TfrxReportPage(FPage).Subreport <> nil) then
    TfrxReportPage(FPage).Subreport.Free;

  FPage.Free;
  ReloadPages(-2);
  Modified := True;
end;

procedure TfrxDesignerForm.NewPageBMouseEnter(Sender: TObject);
var
  p, r: TRectF;
  s: String;
begin
  if (Sender is TControl) then
  begin

  if Sender is TfrxToolButton then
    s:= TfrxToolButton(Sender).Hint
  else
    s := TControl(Sender).TagString;
  p := TControl(Sender).AbsoluteRect;

  r := RectF(0, 0, 300, 1000);
  if Label1.Canvas <> nil then
  begin
    Label1.Canvas.MeasureText(r, s, True, [], TTextAlign.taCenter, TTextAlign.taCenter);
    HintPanel.Width := r.Width + 12;
    HintPanel.Height := r.Height + HintPanel.CalloutLength + 10;
  end;


  if (p.Left + TControl(Sender).Width/2 > HintPanel.Width/2) then
  begin
    HintPanel.CalloutPosition := TCalloutPosition.cpTop;
    HintPanel.Position.X := p.Left + TControl(Sender).Width/2  - HintPanel.Width/2;
    HintPanel.Position.Y := p.Top + TControl(Sender).Height;
{$IFDEF DELPHI18}
    Label1.Margins.Left := 0;
    Label1.Margins.Top := 0;
{$ELSE}
    Label1.Padding.Left := 0;
    Label1.Padding.Top := 0;
{$ENDIF}
  end
  else
  begin
    HintPanel.CalloutPosition := TCalloutPosition.cpLeft;
    HintPanel.Position.X := p.Left + TControl(Sender).Width;
    HintPanel.Position.Y := p.Top - HintPanel.Height/2  + TControl(Sender).Height/2;
    HintPanel.Width := HintPanel.Width + HintPanel.CalloutLength;
{$IFDEF DELPHI18}
    Label1.Margins.Left := HintPanel.CalloutLength;
    Label1.Margins.Top := -HintPanel.CalloutLength;
{$ELSE}
    Label1.Padding.Left := HintPanel.CalloutLength;
    Label1.Padding.Top := -HintPanel.CalloutLength;
{$ENDIF}
  end;
  HintPanel.Visible := True;
  Label1.Text := s;
end;

end;

procedure TfrxDesignerForm.NewPageBMouseLeave(Sender: TObject);
begin
HintPanel.Visible := False;
end;

procedure TfrxDesignerForm.NewPageCmdExecute(Sender: TObject);
begin
  if not CheckOp(drDontCreatePage) then Exit;

  Lock;
  if Report.DotMatrixReport then
    FPage := TfrxDMPPage.Create(Report)
  else
    FPage := TfrxReportPage.Create(Report);
  FPage.CreateUniqueName;
  TfrxReportPage(FPage).SetDefaults;
  ReloadPages(Report.PagesCount - 1);
  Modified := True;
end;

procedure TfrxDesignerForm.NewDialogCmdExecute(Sender: TObject);
begin
  if not CheckOp(drDontCreatePage) then Exit;

  Lock;
  FPage := TfrxDialogPage.Create(Report);
  FPage.CreateUniqueName;
  FPage.SetBounds(265, 150, 300, 200);
  if frxDesignerComp <> nil then
    FPage.Font.Assign(frxDesignerComp.DefaultFont);
  ReloadPages(Report.PagesCount - 1);
  Modified := True;
end;

procedure TfrxDesignerForm.NewReportCmdExecute(Sender: TObject);
var
  dp: TfrxDataPage;
  p: TfrxReportPage;
  b: TfrxBand;
  m: TfrxMemoView;
  h, t: Extended;
  w: Word;
begin
  if not CheckOp(drDontCreateReport) then Exit;

  if Modified then
  begin
    w := AskSave;
    if w = mrYes then
      SaveCmdExecute(Self)
    else if w = mrCancel then
      Exit;
  end;

  t := FWorkspace.BandHeader;
  h := 0;
  case FUnits of
    duCM:     h := fr01cm * 6;
    duInches: h := fr01in * 3;
    duPixels: h := 20;
    duChars:  h := fr1CharY;
  end;

  ObjectSelectB.IsPressed := True;
  SelectToolBClick(Self);

  Lock;
  Report.Clear;
  Report.FileName := '';

  dp := TfrxDataPage.Create(Report);
  dp.Name := 'Data';

  p := TfrxReportPage.Create(Report);
  p.Name := 'Page1';
  SetReportDefaults;

  b := TfrxReportTitle.Create(p);
  b.Name := 'ReportTitle1';
  b.Top := t;
  b.Height := h;

  b := TfrxMasterData.Create(p);
  b.Name := 'MasterData1';
  b.Height := h;
  b.Top := t * 2 + h * 2;

  b := TfrxPageFooter.Create(p);
  b.Name := 'PageFooter1';
  b.Height := h;
  b.Top := t * 3 + h * 4;

  m := TfrxMemoView.Create(b);
  m.Name := 'Memo1';
  m.SetBounds((p.PaperWidth - p.LeftMargin - p.RightMargin - 20) * fr01cm, 0,
    2 * fr1cm, 5 * fr01cm);
  m.HAlign := haRight;
  m.Memo.Text := '[Page#]';

  ReloadPages(-2);
  UpdateCaption;
  Modified := False;
end;

procedure TfrxDesignerForm.SaveCmdExecute(Sender: TObject);
begin
  FInspector.ItemIndex := FInspector.ItemIndex;
  if CheckOp(drDontSaveReport) then
    SaveFile(False, Sender = Self);
end;

procedure TfrxDesignerForm.SaveAsCmdExecute(Sender: TObject);
begin
  FInspector.ItemIndex := FInspector.ItemIndex;
  if CheckOp(drDontSaveReport) then
    SaveFile(True, Sender = Self);
end;

procedure TfrxDesignerForm.OpenCmdExecute(Sender: TObject);
begin
  if CheckOp(drDontLoadReport) then
    LoadFile('', Sender = Self);
end;

procedure TfrxDesignerForm.OpenRecentFile(Sender: TObject);
begin
  if CheckOp(drDontLoadReport) then
    LoadFile(TMenuItem(Sender).Text, True);
end;

procedure TfrxDesignerForm.DeleteCmdExecute(Sender: TObject);
begin
  FWorkspace.DeleteObjects;
end;

procedure TfrxDesignerForm.SelectAllCmdExecute(Sender: TObject);
var
  i: Integer;
  Parent: TfrxComponent;
begin
  if Page = nil then
  begin
    //CodeWindow.SelectAll;
    Exit;
  end;

  Parent := FPage;
  if FSelectedObjects.Count = 1 then
    if TfrxComponent(FSelectedObjects[0]) is TfrxBand then
      Parent := FSelectedObjects[0]
    else if TfrxComponent(FSelectedObjects[0]).Parent is TfrxBand then
      Parent := TfrxComponent(FSelectedObjects[0]).Parent;

  if Parent.Objects.Count <> 0 then
    FSelectedObjects.Clear;
  for i := 0 to Parent.Objects.Count - 1 do
    FSelectedObjects.Add(Parent.Objects[i]);
  OnSelectionChanged(Self);
end;

procedure TfrxDesignerForm.EditCmdExecute(Sender: TObject);
begin
  FWorkspace.EditObject;
end;

procedure TfrxDesignerForm.BringToFrontCmdExecute(Sender: TObject);
var
  i: Integer;
  c: TfrxComponent;
begin
  for i := 0 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if c.Parent <> nil then
      if (c is TfrxReportComponent) and not (rfDontMove in c.Restrictions) then
      begin
        c.Parent.Objects.Remove(c);
        c.Parent.Objects.Add(c);
      end;
  end;

  ReloadObjects;
  Modified := True;
end;

procedure TfrxDesignerForm.SendToBackCmdExecute(Sender: TObject);
var
  i: Integer;
  c: TfrxComponent;
begin
  for i := 0 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if c.Parent <> nil then
      if (c is TfrxReportComponent) and not (rfDontMove in c.Restrictions) then
      begin
        c.Parent.Objects.Remove(c);
        c.Parent.Objects.Insert(0, c);
      end;
  end;

  ReloadObjects;
  Modified := True;
end;

procedure TfrxDesignerForm.TabOrderMIClick(Sender: TObject);
begin
  with TfrxTabOrderEditorForm.Create(Self) do
  begin
    if ShowModal = mrOk then
      Modified := True;
    ReloadObjects;
    Free;
  end;
end;

procedure TfrxDesignerForm.PageSettingsCmdExecute(Sender: TObject);
begin
  if CheckOp(drDontChangePageOptions) then
    if (FPage is TfrxReportPage) and (TfrxReportPage(FPage).Subreport = nil) then
      with TfrxPageEditorForm.Create(Self) do
      begin
        if ShowModal = mrOk then
        begin
          Modified := True;
          UpdatePageDimensions;
        end;
        Free;
      end;
end;

procedure TfrxDesignerForm.OnComponentMenuClick(Sender: TObject);
var
  ed: TfrxComponentEditor;
begin
  ed := frxComponentEditors.GetComponentEditor(FSelectedObjects[0], Self, nil);
  if ed <> nil then
  begin
    if ed.Execute(TMenuItem(Sender).Tag, not TMenuItem(Sender).IsChecked) then
      Modified := True;
    ed.Free;
  end;
end;

procedure TfrxDesignerForm.ReportDataCmdExecute(Sender: TObject);
begin
  if CheckOp(drDontEditReportData) then
    with TfrxReportDataForm.Create(Self) do
    begin
      Report := Self.Report;
      FormShow(Self);
      if ShowModal = mrOk then
      begin
        Modified := True;
        UpdateDataTree;
      end;
      Free;
    end;
end;

procedure TfrxDesignerForm.ReportStylesCmdExecute(Sender: TObject);
begin
  if CheckOp(drDontChangeReportOptions) then
    with TfrxStyleEditorForm.Create(Self) do
    begin
      FormShow(Self);
      if ShowModal = mrOk then
      begin
        Modified := True;
        UpdateStyles;
        Report.Styles.Apply;
      end;
      Free;
    end;
end;

procedure TfrxDesignerForm.ReportOptionsCmdExecute(Sender: TObject);
{$IFNDEF DELPHI21}
var
  i: Integer;
{$ENDIF}
begin
  if CheckOp(drDontChangeReportOptions) then
    with TfrxReportEditorForm.Create(Self) do
    begin
      if ShowModal = mrOk then
      begin
        { reload printer fonts }
        FontNameCB.BeginUpdate;
        FontNameCB.Clear;
        FillFontsList(FontNameCB.Items);
{$IFNDEF DELPHI21}
        for i := 0 to FontNameCB.ListBox.Count - 1 do
          FontNameCB.ListBox.ListItems[i].Font.Family := FontNameCB.Items[i];
{$ENDIF}
        FontNameCB.EndUpdate;
        Modified := True;
      end;
      Free;
    end;
end;

procedure TfrxDesignerForm.VariablesCmdExecute(Sender: TObject);
begin
  if CheckOp(drDontEditVariables) then
    with TfrxVarEditorForm.Create(Self) do
    begin
      if ShowModal = mrOk then
      begin
        Modified := True;
        UpdateDataTree;
      end;
      Free;
    end;
end;

procedure TfrxDesignerForm.PreviewCmdExecute(Sender: TObject);
var
  Preview: TfrxCustomPreview;
  pt: TPoint;
  SavePageNo: Integer;
  SaveModalPreview: Boolean;
  SaveDestroyForms: Boolean;
  SaveMDIChild: Boolean;
  SaveVariables: TfrxVariables;
begin
  FInspector.ItemIndex := FInspector.ItemIndex;
  if not CheckOp(drDontPreviewReport) then Exit;

  if FScriptStopped then
  begin
    RunScriptBClick(RunScriptB);
    Exit;
  end;

  SavePagePosition;
  Report.ScriptText := CodeWindow.Lines;
  if not Report.PrepareScript then
  begin
    pt := fsPosToPoint(Report.Script.ErrorPos);
    SwitchToCodeWindow;
    FCodeWindow.SetPos(pt.X, pt.Y);
    FCodeWindow.ShowMessage(Report.Script.ErrorMsg);
    Exit;
  end;

  SavePageNo := GetPageIndex;
  SaveModalPreview := Report.PreviewOptions.Modal;
  SaveDestroyForms := Report.EngineOptions.DestroyForms;
  SaveMDIChild := Report.PreviewOptions.MDIChild;
  SaveVariables := TfrxVariables.Create;
  SaveVariables.Assign(Report.Variables);

  FUndoBuffer.AddUndo(Report);

  Preview := Report.Preview;
  try
    Report.Preview := nil;
    Report.PreviewOptions.Modal := True;
    Report.EngineOptions.DestroyForms := False;
    Report.PreviewOptions.MDIChild := False;
    FWatchList.ScriptRunning := True;
    Report.ShowReport;
  except
  end;

  FWatchList.ScriptRunning := False;
  Lock;
  FUndoBuffer.GetUndo(Report);

  Report.Script.ClearItems(Report);
  Report.Preview := Preview;
  Report.PreviewOptions.Modal := SaveModalPreview;
  Report.EngineOptions.DestroyForms := SaveDestroyForms;
  Report.PreviewOptions.MDIChild := SaveMDIChild;
  Report.Variables.Assign(SaveVariables);
  SaveVariables.Free;

  if SavePageNo <> -1 then
    ReloadPages(SavePageNo)
  else
  begin
    ReloadPages(-2);
    Page := nil;
  end;

  UpdateWatches;
end;

procedure TfrxDesignerForm.NewItemCmdExecute(Sender: TObject);
begin
//  if CheckOp(drDontCreateReport) then
//    with TfrxNewItemForm.Create(Self) do
//    begin
//      ShowModal;
//      Free;
//    end;
end;

procedure TfrxDesignerForm.FindCmdExecute(Sender: TObject);
begin
  FindOrReplace(False);
end;

procedure TfrxDesignerForm.ReplaceCmdExecute(Sender: TObject);
begin
  FindOrReplace(True);
end;

procedure TfrxDesignerForm.FindNextCmdExecute(Sender: TObject);
begin
  FindText;
end;

procedure TfrxDesignerForm.FrameWidthCBKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if not CharInSet(KeyChar, [#30 .. #39])  then
  begin
    Key := 0;
    KeyChar := #0;
  end;
end;

procedure TfrxDesignerForm.RotateBClick(Sender: TObject);
var
  pt: TPointF;
begin
  pt := Self.ClientToScreen(PointF(RotateB.AbsoluteRect.Left, RotateB.AbsoluteRect.Bottom));
  RotationPopup.Popup(pt.X, pt.Y);
end;

procedure TfrxDesignerForm.ShowRulersCmdExecute(Sender: TObject);
begin
  ShowRulersMI.IsChecked := not ShowRulersMI.IsChecked;
  ShowRulers := ShowRulersMI.IsChecked;
end;

procedure TfrxDesignerForm.ShowGuidesCmdExecute(Sender: TObject);
begin
  ShowGuidesMI.IsChecked := not ShowGuidesMI.IsChecked;
  ShowGuides := ShowGuidesMI.IsChecked;
end;

procedure TfrxDesignerForm.DeleteGuidesCmdExecute(Sender: TObject);
begin
  if FPage is TfrxReportPage then
  begin
    TfrxReportPage(FPage).ClearGuides;
    FWorkspace.Repaint;
    Modified := True;
  end;
end;

procedure TfrxDesignerForm.OptionsCmdExecute(Sender: TObject);
var
  u: TfrxDesignerUnits;
begin
  u := FUnits;

  with TfrxOptionsEditor.Create(Self) do
  begin
    ShowModal;
    Free;
  end;

  if u <> FUnits then
    FOldUnits := FUnits;

  if FWorkspace.GridType = gtDialog then
  begin
    FWorkspace.GridX := FGridSize4;
    FWorkspace.GridY := FGridSize4;
  end;

  FWorkspace.UpdateView;
  CodeWindow.Repaint;
end;

procedure TfrxDesignerForm.HelpContentsCmdExecute(Sender: TObject);
var
  tempC: TfrxDialogComponent;
begin
  if Page = nil then
    frxResources.Help(FCodeWindow)
  else if Page is TfrxDialogPage then
    frxResources.Help(Page)
  else if TObject(SelectedObjects[0]) is TfrxDialogComponent then
  begin
    tempC := TfrxDialogComponent.Create(nil);
    frxResources.Help(tempC);
    tempC.Free;
  end
  else
    frxResources.Help(Self);
end;

procedure TfrxDesignerForm.AboutCmdExecute(Sender: TObject);
begin
  with TfrxAboutForm.Create(Self) do
  begin
    ShowModal;
    Free;
  end;
end;

procedure TfrxDesignerForm.AddChildMIClick(Sender: TObject);
var
  b, bc: TfrxBand;
begin
  b := FSelectedObjects[0];
  bc := b.Child;
  InsertBandClick(ChildMI);
  b.Child := FSelectedObjects[0];
  b.Child.Child := TfrxChild(bc);
  Modified := True;
end;


{ Debugging }
{------------------------------------------------------------------------------}

procedure TfrxDesignerForm.RunScriptBClick(Sender: TObject);
begin
  if FScriptRunning then
  begin
    FScriptStep := Sender = StepScriptB;
    //if (Sender = RunScriptB) and (CodeWindow.BreakPoints.Count = 0) then
    //  Report.Script.OnRunLine := nil;
    FScriptStopped := False;
    Exit;
  end;

  //if (Sender = RunScriptB) and (CodeWindow.BreakPoints.Count = 0) then
  //  Report.Script.OnRunLine := nil
  //else
    Report.Script.OnRunLine := OnRunLine;

  try
    FScriptRunning := True;
    FScriptFirstTime := True;
    PreviewCmdExecute(Self);
  finally
    FScriptRunning := False;
    Report.Script.OnRunLine := nil;
    //CodeWindow.DeleteF4BreakPoints;
    //CodeWindow.ActiveLine := -1;
  end;
end;

procedure TfrxDesignerForm.StopScriptBClick(Sender: TObject);
begin
  Report.Script.OnRunLine := nil;
  Report.Script.Terminate;
  Report.Terminated := True;
  FScriptStopped := False;
end;

procedure TfrxDesignerForm.EvaluateBClick(Sender: TObject);
begin
  with TfrxEvaluateForm.Create(Self) do
  begin
    Script := Report.Script;
    if CodeWindow.SelText <> '' then
      ExpressionE.Text := CodeWindow.SelText;
    ShowModal;
    Free;
  end;
end;

procedure TfrxDesignerForm.BreakPointBClick(Sender: TObject);
begin
  //CodeWindow.ToggleBreakPoint(CodeWindow.GetPos.Y, '');
end;

procedure TfrxDesignerForm.RunToCursorBClick(Sender: TObject);
begin
  //CodeWindow.AddBreakPoint(CodeWindow.GetPos.Y, 'F4');
  RunScriptBClick(nil);
end;

procedure TfrxDesignerForm.OnRunLine(Sender: TfsScript; const UnitName,
  SourcePos: String);
//var
//  p: TPoint;
//  SaveActiveForm: TForm;
//  Condition: String;
//
//  procedure CreateLineMarks;
//  var
//
//    i: Integer;
//  begin
//    for i := 0 to Report.Script.Lines.Count - 1 do
//      CodeWindow.RunLine[i + 1] := Report.Script.IsExecutableLine(i + 1);
//  end;

begin
//  p := fsPosToPoint(SourcePos);
//  if not FScriptStep and (CodeWindow.BreakPoints.Count > 0) then
//    if not CodeWindow.IsBreakPoint(p.Y) then
//      Exit;
//
//  Condition := CodeWindow.GetBreakPointCondition(p.Y);
//  { F4 - run to line, remove the breakpoint }
//  if Condition = 'F4' then
//    CodeWindow.DeleteBreakPoint(p.Y);
//
//  if FScriptFirstTime then
//    CreateLineMarks;
//  FScriptFirstTime := False;
//
//  SaveActiveForm := Screen.ActiveForm;
//
//  if ParentForm <> nil then
//  begin
//    EnableWindow(ParentForm.Handle, True);
////{$IFDEF Delphi9}
//    ParentForm.Enabled := True;
////{$ENDIF}
//    ParentForm.SetFocus;
//  end
//  else
//  begin
//    EnableWindow(Handle, True);
////{$IFDEF Delphi9}
//    Enabled := True;
////{$ENDIF}
//    SetFocus;
//  end;
//
//  {switch to code Tab}
//  if FTabs.TabIndex <> 0  then
//    SetPage(nil);
//
//  CodeWindow.ActiveLine := p.Y;
//  CodeWindow.SetPos(p.X, p.Y);
//  UpdateWatches;
//
//  FScriptStopped := True;
//  while FScriptStopped do
//    Application.ProcessMessages;
//
//  if SaveActiveForm <> nil then
//    SaveActiveForm.SetFocus;
end;


{ Alignment palette }
{------------------------------------------------------------------------------}

procedure TfrxDesignerForm.AlignLeftsBClick(Sender: TObject);
var
  i: Integer;
  c0, c: TfrxComponent;
begin
  if FSelectedObjects.Count < 2 then Exit;

  c0 := FSelectedObjects[0];
  for i := 1 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if not (rfDontMove in c.Restrictions) then
      c.Left := c0.Left;
  end;

  Modified := True;
end;

procedure TfrxDesignerForm.AlignRightsBClick(Sender: TObject);
var
  i: Integer;
  c0, c: TfrxComponent;
begin
  if FSelectedObjects.Count < 2 then Exit;

  c0 := FSelectedObjects[0];
  for i := 1 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if not (rfDontMove in c.Restrictions) then
      c.Left := c0.Left + c0.Width - c.Width;
  end;

  Modified := True;
end;

procedure TfrxDesignerForm.AlignTopsBClick(Sender: TObject);
var
  i: Integer;
  c0, c: TfrxComponent;
begin
  if FSelectedObjects.Count < 2 then Exit;

  c0 := FSelectedObjects[0];
  for i := 1 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if not (rfDontMove in c.Restrictions) then
      if Abs(c.Top - c.AbsTop) < 1e-4 then
        c.Top := c0.AbsTop
      else
        c.Top := c0.AbsTop - c.AbsTop + c.Top;
  end;

  Modified := True;
end;

procedure TfrxDesignerForm.AlignBottomsBClick(Sender: TObject);
var
  i: Integer;
  c0, c: TfrxComponent;
begin
  if FSelectedObjects.Count < 2 then Exit;

  c0 := FSelectedObjects[0];
  for i := 1 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if not (rfDontMove in c.Restrictions) then
      if Abs(c.Top - c.AbsTop) < 1e-4 then
        c.Top := c0.AbsTop + c0.Height - c.Height
      else
        c.Top := c0.AbsTop - c.AbsTop + c.Top + c0.Height - c.Height;
  end;

  Modified := True;
end;

procedure TfrxDesignerForm.AlignHorzCentersBClick(Sender: TObject);
var
  i: Integer;
  c0, c: TfrxComponent;
begin
  if FSelectedObjects.Count < 2 then Exit;

  c0 := FSelectedObjects[0];
  for i := 1 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if not (rfDontMove in c.Restrictions) then
      c.Left := c0.Left + c0.Width / 2 - c.Width / 2;
  end;

  Modified := True;
end;

procedure TfrxDesignerForm.AlignVertCentersBClick(Sender: TObject);
var
  i: Integer;
  c0, c: TfrxComponent;
begin
  if FSelectedObjects.Count < 2 then Exit;

  c0 := FSelectedObjects[0];
  for i := 1 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if not (rfDontMove in c.Restrictions) then
      c.Top := c0.Top + c0.Height / 2 - c.Height / 2;
  end;

  Modified := True;
end;

procedure TfrxDesignerForm.CenterHorzBClick(Sender: TObject);
var
  i: Integer;
  c: TfrxComponent;
begin
  if FSelectedObjects.Count < 1 then Exit;

  for i := 0 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if not (rfDontMove in c.Restrictions) and (c is TfrxView) then
      if c.Parent is TfrxBand then
        c.Left := (c.Parent.Width - c.Width) / 2 else
        c.Left := (FWorkspace.Width / Scale - c.Width) / 2;
  end;

  Modified := True;
end;

procedure TfrxDesignerForm.CenterVertBClick(Sender: TObject);
var
  i: Integer;
  c: TfrxComponent;
begin
  if FSelectedObjects.Count < 1 then Exit;

  for i := 0 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if not (rfDontMove in c.Restrictions) and (c is TfrxView) then
      if c.Parent is TfrxBand then
        c.Top := (c.Parent.Height - c.Height) / 2 else
        c.Top := (FWorkspace.Height / Scale - c.Height) / 2;
  end;

  Modified := True;
end;

procedure TfrxDesignerForm.SpaceHorzBClick(Sender: TObject);
var
  i: Integer;
  c: TfrxComponent;
  sl: TStringList;
  dx: Extended;
begin
  if FSelectedObjects.Count < 3 then Exit;

  sl := TfrxStringList.Create;
  sl.Sorted := True;
  sl.Duplicates := dupAccept;

  for i := 0 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    sl.AddObject(Format('%4.4d', [Round(c.Left)]), c);
  end;

  dx := (TfrxComponent(sl.Objects[sl.Count - 1]).Left -
    TfrxComponent(sl.Objects[0]).Left) / (sl.Count - 1);

  for i := 1 to sl.Count - 2 do
  begin
    c := TfrxComponent(sl.Objects[i]);
    if not (rfDontMove in c.Restrictions) then
      c.Left := TfrxComponent(sl.Objects[i - 1]).Left + dx;
  end;

  sl.Free;
  Modified := True;
end;

procedure TfrxDesignerForm.SpaceVertBClick(Sender: TObject);
var
  i: Integer;
  c: TfrxComponent;
  sl: TStringList;
  dy: Extended;
begin
  if FSelectedObjects.Count < 3 then Exit;

  sl := TfrxStringList.Create;
  sl.Sorted := True;
  sl.Duplicates := dupAccept;

  for i := 0 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    sl.AddObject(Format('%4.4d', [Round(c.Top)]), c);
  end;

  dy := (TfrxComponent(sl.Objects[sl.Count - 1]).Top -
    TfrxComponent(sl.Objects[0]).Top) / (sl.Count - 1);

  for i := 1 to sl.Count - 2 do
  begin
    c := TfrxComponent(sl.Objects[i]);
    if not (rfDontMove in c.Restrictions) then
      c.Top := TfrxComponent(sl.Objects[i - 1]).Top + dy;
  end;

  sl.Free;
  Modified := True;
end;

procedure TfrxDesignerForm.SameWidthBClick(Sender: TObject);
var
  i: Integer;
  c0, c: TfrxComponent;
begin
  if FSelectedObjects.Count < 2 then Exit;

  c0 := FSelectedObjects[0];
  for i := 1 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if not (rfDontSize in c.Restrictions) then
      c.Width := c0.Width;
  end;

  Modified := True;
end;

procedure TfrxDesignerForm.SameHeightBClick(Sender: TObject);
var
  i: Integer;
  c0, c: TfrxComponent;
begin
  if FSelectedObjects.Count < 2 then Exit;

  c0 := FSelectedObjects[0];
  for i := 1 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if not (rfDontSize in c.Restrictions) then
      c.Height := c0.Height;
  end;

  Modified := True;
end;


{ Save/restore state }
{------------------------------------------------------------------------------}

procedure TfrxDesignerForm.SaveState;
var
  Ini: TCustomIniFile;
  Nm: String;
begin
  if IsPreviewDesigner then Exit;

  Ini := Report.GetIniFile;

  try
  if Ini is TIniFile then
  begin
    Nm := ExtractFilePath(Ini.FileName);
    if not DirectoryExists(Nm) then
      if not CreateDir(Nm) then
      begin
        Ini.Free;
        Exit;
      end;
  end;

  Nm := 'TfrxDesignerForm';
  Ini.WriteInteger('TfrxObjectInspector', 'SplitPos', Round(FInspector.SplitterPos));
  Ini.WriteInteger('TfrxObjectInspector', 'Split1Pos', Round(FInspector.Splitter1Pos));
  Ini.WriteInteger(Nm, 'LeftDockSize', Round(LeftDockTB.Width));
  Ini.WriteInteger(Nm, 'RightDockSize', Round(RightDockTB.Width));
  Ini.WriteInteger(Nm, 'LeftDockSplit', Round(FReportTree.MainPanel.Height));
  Ini.WriteFloat(Nm, 'Scale', FScale);
  Ini.WriteBool(Nm, 'ShowGrid', FShowGrid);
  Ini.WriteBool(Nm, 'GridAlign', FGridAlign);
  Ini.WriteBool(Nm, 'ShowRulers', FShowRulers);
  Ini.WriteBool(Nm, 'ShowGuides', FShowGuides);
  Ini.WriteFloat(Nm, 'Grid1', FGridSize1);
  Ini.WriteFloat(Nm, 'Grid2', FGridSize2);
  Ini.WriteFloat(Nm, 'Grid3', FGridSize3);
  Ini.WriteFloat(Nm, 'Grid4', FGridSize4);
  FUnits := FOldUnits;
  Ini.WriteInteger(Nm, 'Units', Integer(FUnits));
//  Ini.WriteString(Nm, 'ScriptFontName', CodeWindow.Font.Name);
//  Ini.WriteInteger(Nm, 'ScriptFontSize', CodeWindow.Font.Size);
  Ini.WriteString(Nm, 'MemoFontName', MemoFontName);
  Ini.WriteInteger(Nm, 'MemoFontSize', MemoFontSize);
  Ini.WriteBool(Nm, 'UseObjectFont', UseObjectFont);
  Ini.WriteBool(Nm, 'EditAfterInsert', FEditAfterInsert);
  Ini.WriteBool(Nm, 'LocalizedOI', FLocalizedOI);
  Ini.WriteString(Nm, 'RecentFiles', '"'+FRecentFiles.CommaText+'"');
  Ini.WriteBool(Nm, 'FreeBands', FWorkspace.FreeBandsPlacement);
  Ini.WriteInteger(Nm, 'BandsGap', FWorkspace.GapBetweenBands);
  Ini.WriteBool(Nm, 'ShowBandCaptions', FWorkspace.ShowBandCaptions);
  Ini.WriteBool(Nm, 'DropFields', FDropFields);
  Ini.WriteString(Nm, 'WatchList', FWatchList.Watches.Text);

  frxSaveFormPosition(Ini, Self);
  finally
    Ini.Free;
  end;

end;

procedure TfrxDesignerForm.RestoreState(RestoreDefault: Boolean = False;
  RestoreMainForm: Boolean = False);
var
  Ini: TCustomIniFile;
  Nm: String;

  function Def(Value, DefValue: Extended): Extended;
  begin
    if Value = 0 then
      Result := DefValue else
      Result := Value;
  end;

  procedure DoRestore;
  begin
    if not RestoreMainForm then
    begin
      FInspector.SplitterPos := Ini.ReadInteger('TfrxObjectInspector',
        'SplitPos', FInspector.Width div 2);
      if FInspector.SplitterPos > FInspector.Width - 10 then
        FInspector.SplitterPos := FInspector.Width div 2;
      FInspector.Splitter1Pos := Ini.ReadInteger('TfrxObjectInspector',
        'Split1Pos', 65);
      if (FInspector.Splitter1Pos < 10) or (FInspector.Splitter1Pos > FInspector.Height - 20) then
        FInspector.Splitter1Pos := 65;
      LeftDockTB.Width := Ini.ReadInteger(Nm, 'LeftDockSize', 200);
      RightDockTB.Width := Ini.ReadInteger(Nm, 'RightDockSize', 150);
      FReportTree.MainPanel.Height := Ini.ReadInteger(Nm, 'LeftDockSplit', 150);
      Scale := Ini.ReadFloat(Nm, 'Scale', 1);
      ShowGrid := Ini.ReadBool(Nm, 'ShowGrid', True);
      GridAlign := Ini.ReadBool(Nm, 'GridAlign', True);
      ShowRulers := Ini.ReadBool(Nm, 'ShowRulers', True);
      ShowGuides := Ini.ReadBool(Nm, 'ShowGuides', True);
      FGridSize1 := Def(Ini.ReadFloat(Nm, 'Grid1', 0), 0.1);
      FGridSize2 := Def(Ini.ReadFloat(Nm, 'Grid2', 0), 0.1);
      FGridSize3 := Def(Ini.ReadFloat(Nm, 'Grid3', 0), 4);
      FGridSize4 := Def(Ini.ReadFloat(Nm, 'Grid4', 0), 4);
      Units := TfrxDesignerUnits(Ini.ReadInteger(Nm, 'Units', 0));
      FOldUnits := FUnits;

//      CodeWindow.Font.Name := Ini.ReadString(Nm, 'ScriptFontName', 'Courier New');
//      CodeWindow.Font.Size := Ini.ReadInteger(Nm, 'ScriptFontSize', 10);
      MemoFontName := Ini.ReadString(Nm, 'MemoFontName', 'Arial');
      MemoFontSize := Ini.ReadInteger(Nm, 'MemoFontSize', 10);
      UseObjectFont := Ini.ReadBool(Nm, 'UseObjectFont', True);
      FEditAfterInsert := Ini.ReadBool(Nm, 'EditAfterInsert', False);
      FRecentFiles.CommaText := Ini.ReadString(Nm, 'RecentFiles', '');
      FWorkspace.FreeBandsPlacement := Ini.ReadBool(Nm, 'FreeBands', False);
      FWorkspace.GapBetweenBands := Ini.ReadInteger(Nm, 'BandsGap', 4);
      FWorkspace.ShowBandCaptions := Ini.ReadBool(Nm, 'ShowBandCaptions', True);
      FDropFields := Ini.ReadBool(Nm, 'DropFields', True);
      FWatchList.Watches.Text := Ini.ReadString(Nm, 'WatchList', '');
      FWatchList.UpdateWatches;

    end
    else
      frxRestoreFormPosition(Ini, Self);
  end;

   procedure ReadDefIni;
   begin
     Scale := 1;
     ShowGrid := True;
     GridAlign := True;
     ShowRulers :=  True;
     ShowGuides := True;
     FGridSize1 := 0.1;
     FGridSize2 := 0.1;
     FGridSize3 := 4;
     FGridSize4 := 4;
     Units := TfrxDesignerUnits(0);
     FWorkspace.ShowBandCaptions := true;
     FOldUnits := FUnits;
   end;

begin
  Ini := Report.GetIniFile;
  Nm := 'TfrxDesignerForm';
  try
    if RestoreDefault or (Ini.ReadFloat(Nm, 'Scale', 0) = 0) then
      ReadDefIni
    else
    begin
      try
        DoRestore;
      except
        ReadDefIni;
      end
    end;
  finally
    Ini.Free;
  end;
end;

procedure TfrxDesignerForm.Localize;
begin
  OpenScriptB.Hint := frxGet(2300);
  SaveScriptB.Hint := frxGet(2301);
  RunScriptB.Hint := frxGet(2302);
  StepScriptB.Hint := frxGet(2303);
  StopScriptB.Hint := frxGet(2304);
  EvaluateB.Hint := frxGet(2305);
  //LangCB.Text := frxGet(2306);
  AlignLeftsB.Hint := frxGet(2308);
  AlignHorzCentersB.Hint := frxGet(2309);
  AlignRightsB.Hint := frxGet(2310);
  AlignTopsB.Hint := frxGet(2311);
  AlignVertCentersB.Hint := frxGet(2312);
  AlignBottomsB.Hint := frxGet(2313);
  SpaceHorzB.Hint := frxGet(2314);
  SpaceVertB.Hint := frxGet(2315);
  CenterHorzB.Hint := frxGet(2316);
  CenterVertB.Hint := frxGet(2317);
  SameWidthB.Hint := frxGet(2318);
  SameHeightB.Hint := frxGet(2319);
  StyleCB.TagString := frxGet(2321);
  FontNameCB.TagString := frxGet(2322);
  FontSizeCB.TagString := frxGet(2323);
  BoldB.Hint := frxGet(2324);
  ItalicB.Hint := frxGet(2325);
  UnderlineB.Hint := frxGet(2326);
  FontColorB.Hint := frxGet(2327);
  HighlightB.Hint := frxGet(2328);
  RotateB.Hint := frxGet(2329);
  TextAlignLeftB.Hint := frxGet(2330);
  TextAlignCenterB.Hint := frxGet(2331);
  TextAlignRightB.Hint := frxGet(2332);
  TextAlignBlockB.Hint := frxGet(2333);
  TextAlignTopB.Hint := frxGet(2334);
  TextAlignMiddleB.Hint := frxGet(2335);
  TextAlignBottomB.Hint := frxGet(2336);
  FrameTopB.Hint := frxGet(2338);
  FrameBottomB.Hint := frxGet(2339);
  FrameLeftB.Hint := frxGet(2340);
  FrameRightB.Hint := frxGet(2341);
  FrameAllB.Hint := frxGet(2342);
  FrameNoB.Hint := frxGet(2343);
  ShadowB.Hint := frxGet(2344);
  FillColorB.Hint := frxGet(2345);
  FrameColorB.Hint := frxGet(2346);
  FrameStyleB.Hint := frxGet(2347);
  FrameWidthCB.TagString := frxGet(2348);
  NewB.Hint := frxGet(2350);
  OpenB.Hint := frxGet(2351);
  SaveB.Hint := frxGet(2352);
  PreviewB.Hint := frxGet(2353);
  NewPageB.Hint := frxGet(2354);
  NewDialogB.Hint := frxGet(2355);
  DeletePageB.Hint := frxGet(2356);
  PageSettingsB.Hint := frxGet(2357);
  CutB.Hint := frxGet(2359);
  CopyB.Hint := frxGet(2360);
  PasteB.Hint := frxGet(2361);
  UndoB.Hint := frxGet(2363);
  RedoB.Hint := frxGet(2364);
  GroupB.Hint := frxGet(2365);
  UngroupB.Hint := frxGet(2366);
  ShowGridB.Hint := frxGet(2367);
  AlignToGridB.Hint := frxGet(2368);
  SetToGridB.Hint := frxGet(2369);
  ScaleCB.TagString := frxGet(2370);

  ObjectSelectB.Hint := frxGet(2372);
  ObjectBandB.Hint := frxGet(2377);
  FileMenu.Text := frxGet(2378);
  EditMenu.Text := frxGet(2379);
  FindMI.Text := frxGet(2380);
  FindNextMI.Text := frxGet(2381);
  ReplaceMI.Text := frxGet(2382);
  ReportMenu.Text := frxGet(2383);
  ReportDataMI.Text := frxGet(2384);
  ReportSettingsMI.Text := frxGet(2385);
  ReportStylesMI.Text := frxGet(2386);
  ViewMenu.Text := frxGet(2387);
  ShowRulersMI.Text := frxGet(2397);
  ShowGuidesMI.Text := frxGet(2398);
  DeleteGuidesMI.Text := frxGet(2399);
  OptionsMI.Text := frxGet(2400);
  HelpMenu.Text := frxGet(2401);

  AboutMI.Text := frxGet(2403);
//
  UndoMI.Text := frxGet(2405);
  RedoMI.Text := frxGet(2406);
  CutMI.Text := frxGet(2407);
  CopyMI.Text := frxGet(2408);
  PasteMI.Text := frxGet(2409);
  GroupMI.Text := frxGet(2410);
  UngroupMI.Text := frxGet(2411);
  DeleteMI.Text := frxGet(2412);
  DeletePageMI.Text := frxGet(2413);
  DeletePageMI1.Text := frxGet(2413);
  SelectAllMI.Text := frxGet(2414);
  EditMI.Text := frxGet(2415);
  BringtoFrontMI.Text := frxGet(2416);
  SendtoBackMI.Text := frxGet(2417);
  NewMI.Text := frxGet(2418);
  NewReportMI.Text := frxGet(2419);
  NewPageMI1.Text := frxGet(2420);
  NewPageMI.Text := frxGet(2420);
  NewDialogMI1.Text := frxGet(2421);
  NewDialogMI.Text := frxGet(2421);
  OpenMI.Text := frxGet(2422);
  SaveMI.Text := frxGet(2423);
  SaveAsMI.Text := frxGet(2424);
  VariablesMI.Text := frxGet(2425);
  PageSettingsMI1.Text := frxGet(2426);
  PageSettingsMI.Text := frxGet(2426);
  PreviewMI.Text := frxGet(2427);
  ExitMI.Text := frxGet(2428);
  ReportTitleMI.Text := frxGet(2429);
  ReportSummaryMI.Text := frxGet(2430);
  PageHeaderMI.Text := frxGet(2431);
  PageFooterMI.Text := frxGet(2432);
  HeaderMI.Text := frxGet(2433);
  FooterMI.Text := frxGet(2434);
  MasterDataMI.Text := frxGet(2435);
  DetailDataMI.Text := frxGet(2436);
  SubdetailDataMI.Text := frxGet(2437);
  Data4levelMI.Text := frxGet(2438);
  Data5levelMI.Text := frxGet(2439);
  Data6levelMI.Text := frxGet(2440);
  GroupHeaderMI.Text := frxGet(2441);
  GroupFooterMI.Text := frxGet(2442);
  ChildMI.Text := frxGet(2443);
  ColumnHeaderMI.Text := frxGet(2444);
  ColumnFooterMI.Text := frxGet(2445);
  OverlayMI.Text := frxGet(2446);
  VerticalbandsMI.Text := frxGet(2447);
  HeaderMI1.Text := frxGet(2448);
  FooterMI1.Text := frxGet(2449);
  MasterDataMI1.Text := frxGet(2450);
  DetailDataMI1.Text := frxGet(2451);
  SubdetailDataMI1.Text := frxGet(2452);
  GroupHeaderMI1.Text := frxGet(2453);
  GroupFooterMI1.Text := frxGet(2454);
  ChildMI1.Text := frxGet(2455);
  R0MI.Text := frxGet(2456);
  R45MI.Text := frxGet(2457);
  R90MI.Text := frxGet(2458);
  R180MI.Text := frxGet(2459);
  R270MI.Text := frxGet(2460);
  FontB.Hint := frxGet(2461);
  BoldMI.Text := frxGet(2462);
  ItalicMI.Text := frxGet(2463);
  UnderlineMI.Text := frxGet(2464);
  SuperScriptMI.Text := frxGet(2465);
  SubScriptMI.Text := frxGet(2466);
  CondensedMI.Text := frxGet(2467);
  WideMI.Text := frxGet(2468);
  N12cpiMI.Text := frxGet(2469);
  N15cpiMI.Text := frxGet(2470);
  OpenDialog.Filter := frxGet(2471);
  OpenDialog.Options := OpenDialog.Options + [TOpenOption.ofNoChangeDir];
  SaveDialog.Options := SaveDialog.Options + [TOpenOption.ofNoChangeDir];
  OpenScriptDialog.Options :=  OpenScriptDialog.Options + [TOpenOption.ofNoChangeDir];
  SaveScriptDialog.Options :=  SaveScriptDialog.Options + [TOpenOption.ofNoChangeDir];
  OpenScriptDialog.Filter := frxGet(2472);
  SaveScriptDialog.Filter := frxGet(2473);
  BreakPointB.Hint := frxGet(2476);
  RunToCursorB.Hint := frxGet(2477);


  frxResources.LoadImageFromResouce(NewB.Bitmap, 0, 0);
  frxResources.LoadImageFromResouce(NewReportMI.Bitmap, 0, 0);
  frxResources.LoadImageFromResouce(OpenB.Bitmap, 0, 1);
  frxResources.LoadImageFromResouce(OpenMI.Bitmap, 0, 1);
  frxResources.LoadImageFromResouce(SaveB.Bitmap, 0, 2);
  frxResources.LoadImageFromResouce(SaveMI.Bitmap, 0, 2);
  frxResources.LoadImageFromResouce(SaveAsMI.Bitmap, 0, 2);
  frxResources.LoadImageFromResouce(PreviewB.Bitmap, 0, 3);
  frxResources.LoadImageFromResouce(PreviewMI.Bitmap, 0, 3);
  frxResources.LoadImageFromResouce(NewDialogB.Bitmap, 0, 4);
  frxResources.LoadImageFromResouce(NewDialogMI1.Bitmap, 0, 4);
  frxResources.LoadImageFromResouce(NewDialogMI.Bitmap, 0, 4);
  frxResources.LoadImageFromResouce(NewPageB.Bitmap, 1, 0);
  frxResources.LoadImageFromResouce(NewPageMI1.Bitmap, 1, 0);
  frxResources.LoadImageFromResouce(NewPageMI.Bitmap, 1, 0);

  frxResources.LoadImageFromResouce(DeletePageB.Bitmap, 1, 2);
  frxResources.LoadImageFromResouce(DeletePageMI1.Bitmap, 1, 2);
  frxResources.LoadImageFromResouce(DeletePageMI.Bitmap, 1, 2);

  frxResources.LoadImageFromResouce(PageSettingsB.Bitmap, 1, 3);
  frxResources.LoadImageFromResouce(PageSettingsMI.Bitmap, 1, 3);
  frxResources.LoadImageFromResouce(PageSettingsMI1.Bitmap, 1, 3);
  frxResources.LoadImageFromResouce(CutB.Bitmap, 0, 5);
  frxResources.LoadImageFromResouce(CutMI.Bitmap, 0, 5);
  frxResources.LoadImageFromResouce(CopyB.Bitmap, 0, 6);
  frxResources.LoadImageFromResouce(CopyMI.Bitmap, 0, 6);
  frxResources.LoadImageFromResouce(PasteB.Bitmap, 0, 7);
  frxResources.LoadImageFromResouce(PasteMI.Bitmap, 0, 7);

  frxResources.LoadImageFromResouce(UndoB.Bitmap, 0, 8);
  frxResources.LoadImageFromResouce(UndoMI.Bitmap, 0, 8);
  frxResources.LoadImageFromResouce(RedoB.Bitmap, 0, 9);
  frxResources.LoadImageFromResouce(RedoMI.Bitmap, 0, 9);
  frxResources.LoadImageFromResouce(GroupB.Bitmap, 1, 7);
  frxResources.LoadImageFromResouce(GroupMI.Bitmap, 1, 7);
  frxResources.LoadImageFromResouce(UngroupB.Bitmap, 1, 6);
  frxResources.LoadImageFromResouce(UngroupMI.Bitmap, 1, 6);
  frxResources.LoadImageFromResouce(ShowGridB.Bitmap, 12, 7);
  frxResources.LoadImageFromResouce(AlignToGridB.Bitmap, 9, 8);
  frxResources.LoadImageFromResouce(SetToGridB.Bitmap, 5, 7);
  frxResources.LoadImageFromResouce(AlignLeftsB.Bitmap, 4, 1);
  frxResources.LoadImageFromResouce(AlignHorzCentersB.Bitmap, 4, 7);
  frxResources.LoadImageFromResouce(AlignRightsB.Bitmap, 4, 5);
  frxResources.LoadImageFromResouce(AlignTopsB.Bitmap, 4, 6);
  frxResources.LoadImageFromResouce(AlignVertCentersB.Bitmap, 4, 2);
  frxResources.LoadImageFromResouce(AlignBottomsB.Bitmap, 5, 0);

  frxResources.LoadImageFromResouce(SpaceHorzB.Bitmap, 4, 4);
  frxResources.LoadImageFromResouce(SpaceVertB.Bitmap, 4, 9);
  frxResources.LoadImageFromResouce(CenterHorzB.Bitmap, 4, 3);
  frxResources.LoadImageFromResouce(CenterVertB.Bitmap, 4, 9);
  frxResources.LoadImageFromResouce(SameWidthB.Bitmap, 8, 3);
  frxResources.LoadImageFromResouce(SameHeightB.Bitmap, 8, 4);


  frxResources.LoadImageFromResouce(BoldB.Bitmap, 2, 0);
  frxResources.LoadImageFromResouce(ItalicB.Bitmap, 2, 1);
  frxResources.LoadImageFromResouce(UnderlineB.Bitmap, 2, 2);
  frxResources.LoadImageFromResouce(FontB.Bitmap, 5, 9);
  frxResources.LoadImageFromResouce(FontColorB.Bitmap, 2, 3);
  frxResources.LoadImageFromResouce(HighlightB.Bitmap, 2, 4);
  frxResources.LoadImageFromResouce(RotateB.Bitmap, 6, 4);

  frxResources.LoadImageFromResouce(TextAlignLeftB.Bitmap, 2, 5);
  frxResources.LoadImageFromResouce(TextAlignCenterB.Bitmap, 2, 6);
  frxResources.LoadImageFromResouce(TextAlignRightB.Bitmap, 2, 7);
  frxResources.LoadImageFromResouce(TextAlignBlockB.Bitmap, 2, 8);

  frxResources.LoadImageFromResouce(TextAlignTopB.Bitmap, 2, 9);
  frxResources.LoadImageFromResouce(TextAlignMiddleB.Bitmap, 3, 0);
  frxResources.LoadImageFromResouce(TextAlignBottomB.Bitmap, 3, 1);

  frxResources.LoadImageFromResouce(FrameTopB.Bitmap, 3, 2);
  frxResources.LoadImageFromResouce(FrameBottomB.Bitmap, 3, 3);
  frxResources.LoadImageFromResouce(FrameRightB.Bitmap, 3, 5);
  frxResources.LoadImageFromResouce(FrameLeftB.Bitmap, 3, 4);
  frxResources.LoadImageFromResouce(FrameNoB.Bitmap, 3, 7);
  frxResources.LoadImageFromResouce(FrameAllB.Bitmap, 3, 6);
  frxResources.LoadImageFromResouce(ShadowB.Bitmap, 4, 0);
  frxResources.LoadImageFromResouce(FillColorB.Bitmap, 3, 8);
  frxResources.LoadImageFromResouce(FrameColorB.Bitmap, 3, 9);
  frxResources.LoadImageFromResouce(FrameStyleB.Bitmap, 7, 1);

  frxResources.LoadImageFromResouce(DeleteMI.Bitmap, 5, 1);
  frxResources.LoadImageFromResouce(FindMI.Bitmap, 18, 1);

  frxResources.LoadImageFromResouce(BringtoFrontMI.Bitmap, 1, 4);
  frxResources.LoadImageFromResouce(SendtoBackMI.Bitmap, 1, 5);

  frxResources.LoadImageFromResouce(ReportDataMI.Bitmap, 5, 3);
  frxResources.LoadImageFromResouce(ReportSettingsMI.Bitmap, 4, 0);
  frxResources.LoadImageFromResouce(ReportStylesMI.Bitmap, 8, 7);
  frxResources.LoadImageFromResouce(VariablesMI.Bitmap, 11, 3);
end;

procedure TfrxDesignerForm.CreateLangMenu;
//var
//  m, t: TMenuItem;
//  i: Integer;
//  reg: TRegistry;
//  current: String;
begin
//  current := '';
//  reg := TRegistry.Create;
//  try
//    reg.RootKey := HKEY_CURRENT_USER;
//    if reg.OpenKey('\Software\Fast Reports\Resources', false) then
//      current := reg.ReadString('Language');
//  finally
//    reg.Free;
//  end;
//  if frxResources.Languages.Count > 0 then
//  begin
//    m := TMenuItem.Create(ViewMenu);
//    m.Caption := '-';
//    ViewMenu.Add(m);
//    m := TMenuItem.Create(ViewMenu);
//    m.Caption := frxGet(2475);
//    ViewMenu.Add(m);
//    for i := 0 to frxResources.Languages.Count - 1 do
//    begin
//      t := TMenuItem.Create(m);
//      t.Caption := frxResources.Languages[i];
//      t.RadioItem := True;
//      t.OnClick := LangSelectClick;
//      if UpperCase(t.Caption) = UpperCase(current) then
//        t.Checked := True;
//      m.Add(t);
//    end;
//  end;
end;

procedure TfrxDesignerForm.LangSelectClick(Sender: TObject);
//var
//  m: TMenuItem;
//  reg: TRegistry;
begin
//  m := Sender as TMenuItem;
//  m.Checked := True;
//  frxResources.LoadFromFile(GetAppPath + m.Caption + '.frc');
//  Localize;
//  reg := TRegistry.Create;
//  try
//    reg.RootKey := HKEY_CURRENT_USER;
//    if reg.OpenKey('\Software\Fast Reports\Resources', false) then
//      reg.WriteString('Language', m.Caption);
//  finally
//    reg.Free;
//  end;
end;

procedure TfrxDesignerForm.LeftDockTBResize(Sender: TObject);
begin
  if FInspector <> nil then
    FInspector.DoResize;
end;

{procedure TfrxDesignerForm.OnCodeCompletion(const Name: String; List: TStrings);
var
  obj: TPersistent;
  xd: TfsXMLDocument;
  i, j: Integer;
  sl, members: TStringList;
  s: String;
  clName: String;
  clVar: TfsClassVariable;
  clMethod: TfsCustomHelper;
  cl: TClass;
  l: TList;
begin
  members := TStringList.Create;
  frxSetCommaText(Name, members, '.');
  if members.Count = 0 then
  begin
    List.Clear;
    l := Report.AllObjects;
    for i := 0 to l.Count - 1 do
      List.AddObject(TfrxComponent(l[i]).Name + ' : ' + TfrxComponent(l[i]).ClassName, nil);

    members.Free;
    Exit;
  end;

  for i := 0 to members.Count - 1 do
    members[i] := Trim(members[i]);

  if CompareText('Report', members[0]) = 0 then
    obj := Report
  else if CompareText('Engine', members[0]) = 0 then
    obj := Report.Engine
  else if CompareText('Outline', members[0]) = 0 then
    obj := Report.PreviewPages.Outline
  else
    obj := Report.FindObject(members[0]);

  clName := '';
  if obj <> nil then
    clName := obj.ClassName;

  i := 1;
  while (clName <> '') and (i < members.Count) do
  begin
    clVar := Report.Script.FindClass(clName);
    clName := '';
    if clVar <> nil then
    begin
      clMethod := clVar.Find(members[i]);
      if clMethod <> nil then
        clName := clMethod.TypeName;
      Inc(i);
    end;
  end;

  if clName <> '' then
  begin
    clVar := Report.Script.FindClass(clName);
    if clVar <> nil then
    begin
      cl := Report.Script.FindClass(clName).ClassRef;

      xd := TfsXMLDocument.Create;
      GenerateMembers(Report.Script, cl, xd.Root);
      sl := TStringList.Create;
      sl.Sorted := True;
      sl.Duplicates := dupIgnore;
      for i := 0 to xd.Root.Count - 1 do
      begin
        s := xd.Root[i].Prop['text'];
        j := 0;
        if Pos('property', s) = 1 then
        begin
          Delete(s, 1, 9);
          j := 1;
        end;
        if Pos('index property', s) = 1 then
        begin
          Delete(s, 1, 15);
          j := 1;
        end;
        if Pos('procedure', s) = 1 then
        begin
          Delete(s, 1, 10);
          j := 2;
        end;
        if Pos('function', s) = 1 then
        begin
          Delete(s, 1, 9);
          j := 3;
        end;

        sl.AddObject(s, TObject(j));
      end;
      List.Assign(sl);
      sl.Free;
      xd.Free;
    end;
  end;
end;
}
procedure TfrxDesignerForm.FormCreate(Sender: TObject);
begin
  FGridSize4 := fr01cm;
 //FormShow(Sender);

{$IFDEF RAD_ED}
  VerticalbandsMI.Visible := False;
  VerticalbandsMI.Enabled := False;
{$ENDIF}
  if frxDesignerComp <> nil then
  begin
    if (Length(frxDesignerComp.FTemplatesExt) > 1) and
    (frxDesignerComp.FTemplatesExt[1] = '.') then
       Delete(frxDesignerComp.FTemplatesExt, 1, 1);
    FTemplateExt := frxDesignerComp.FTemplatesExt;
  end
  else
    FTemplateExt := 'fr3'
end;


procedure TfrxDesignerForm.GetTemplateList(List: TStrings);
var
  sr: TSearchRec;
  dir, DefExt: String;

  function NormalDir(const DirName: string): string;
  begin
    Result := DirName;
    if (Result <> '') and
      not (CharInSet(Result[Length(Result)], [':', '\'])) then
    begin
      if (Length(Result) = 1) and (CharInSet(UpCase(Result[1]),['A'..'Z'])) then
        Result := Result + ':\'
      else Result := Result + '\';
    end;
  end;

begin
  List.Clear;
  DefExt := FTemplateExt;

  if (frxDesignerComp <> nil) and Assigned(frxDesignerComp.OnGetTemplateList) then
    frxDesignerComp.OnGetTemplateList(List)
  else
  begin
    dir := FTemplatePath;
    if (Trim(dir) = '') or (Trim(dir) = '.') then
      if csDesigning in ComponentState then
        dir := GetCurrentDir
      else
        dir := ExtractFilePath(ParamStr(0));
    dir := NormalDir(dir);
    if FindFirst(dir + '*.' + DefExt, faAnyFile, sr) = 0 then
    begin
      repeat
        List.Add(dir + sr.Name);
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  end;
end;


procedure TfrxDesignerForm.SetGridSize1(const Value: Double);
begin
  if Value > 0 then
    FGridSize1 := Value;
end;

procedure TfrxDesignerForm.SetGridSize2(const Value: Double);
begin
  if Value > 0 then
    FGridSize2 := Value;
end;

procedure TfrxDesignerForm.SetGridSize3(const Value: Double);
begin
  if Value > 0 then
    FGridSize3 := Value;
end;

procedure TfrxDesignerForm.SetGridSize4(const Value: Double);
begin
  if Value > 0 then
    FGridSize4 := Value;
end;

procedure TfrxDesignerForm.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  if ssCtrl in Shift then
  begin
    Scale := Scale + Round(WheelDelta / Abs(WheelDelta)) / 20;
    if Scale < 0.3 then
      Scale := 0.3;
    ScaleCB.Text := frxFloatToStr(Round(Scale * 100)) + '%';
    ScrollBox.SetFocus;
  end;
end;

procedure TfrxDesignerForm.FormResize(Sender: TObject);
begin
  RightDockTBResize(Self);
end;

procedure TfrxDesignerForm.UpdateWatches;
var
  ErrCount: Integer;
begin
  ErrCount := Report.Errors.Count;
  FWatchList.UpdateWatches;
  ErrCount := Report.Errors.Count - ErrCount;
  while (ErrCount <> 0) do
  begin
    Report.Errors.Delete(Report.Errors.Count - 1);
    dec(ErrCount);
  end;
end;

initialization
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TfrxDesigner, TFmxObject);
  frxDesignerClass := TfrxDesignerForm;

end.
