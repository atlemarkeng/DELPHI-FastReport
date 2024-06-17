
{******************************************}
{                                          }
{             FastReport v4.0              }
{             Report preview               }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxPreview;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.Classes, System.SysUtils, System.Types, System.UITypes, System.Variants,
  FMX.Types, FMX.Controls, FMX.TreeView, FMX.Menus, FMX.Forms, FMX.Edit,
  FMX.Dialogs, System.UIConsts,
  FMX.frxCtrls, FMX.frxPreviewPages, FMX.frxClass, FMX.frxFMX, FMX.ListBox,
  FMX.Objects
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
  , FMX.ComboEdit
{$ENDIF};


type
  TfrxPreview = class;
  TfrxPreviewWorkspace = class;
  TfrxPageList = class;

  TfrxPageChangedEvent = procedure(Sender: TfrxPreview; PageNo: Integer) of object;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxPreview = class(TfrxCustomPreview)
  private
    FAllowF3: Boolean;
    FCancelButton: TButton;
    FLocked: Boolean;
    FMessageLabel: TLabel;
    FMessagePanel: TPanel;
    FOnPageChanged: TfrxPageChangedEvent;
    FOutline: TTreeView;
    FOutlineColor: TAlphaColor;
    FOutlinePopup: TPopupMenu;
    FPageNo: Integer;
    FRefreshing: Boolean;
    FRunning: Boolean;
    FSplitter: TfrxSplitter;
    FThumbnail: TfrxPreviewWorkspace;
    FTick: Cardinal;
    FWorkspace: TfrxPreviewWorkspace;
    FZoom: Double;
    FZoomMode: TfrxZoomMode;
    HintPanel: TCalloutPanel;
    HintLabel: TLabel;
    function GetActiveFrameColor: TAlphaColor;
    function GetBackColor: TAlphaColor;
    function GetFrameColor: TAlphaColor;
    function GetOutlineVisible: Boolean;
    function GetOutlineWidth: Integer;
    function GetPageCount: Integer;
    function GetThumbnailVisible: Boolean;
    function GetOnMouseDown: TMouseEvent;
    procedure EditTemplate;
    procedure OnCancel(Sender: TObject);
    procedure OnCollapseClick(Sender: TObject);
    procedure OnExpandClick(Sender: TObject);
    procedure OnMoveSplitter(Sender: TObject);
    procedure OnOutlineClick(Sender: TObject);
    procedure SetActiveFrameColor(const Value: TAlphaColor);
    procedure SetBackColor(const Value: TAlphaColor);
    procedure SetFrameColor(const Value: TAlphaColor);
    procedure SetOutlineColor(const Value: TAlphaColor);
    procedure SetOutlineWidth(const Value: Integer);
    procedure SetOutlineVisible(const Value: Boolean);
    procedure SetPageNo(Value: Integer);
    procedure SetThumbnailVisible(const Value: Boolean);
    procedure SetZoom(const Value: Double);
    procedure SetZoomMode(const Value: TfrxZoomMode);
    procedure SetOnMouseDown(const Value: TMouseEvent);
    procedure UpdateOutline;
    procedure UpdatePages;
    procedure UpdatePageNumbers;
  protected
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    procedure Resize; override;
    procedure OnResize(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure Lock; override;
    procedure ShowHint(aRect: TRectF; Text: String); override;
    procedure HideHint; override;
    procedure Unlock; override;
    procedure RefreshReport; override;
    procedure InternalOnProgressStart(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer); override;
    procedure InternalOnProgress(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer); override;
    procedure InternalOnProgressStop(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer); override;

    procedure AddPage;
    procedure DeletePage;
    procedure Print;
    procedure Edit;
    procedure First;
    procedure Next;
    procedure Prior;
    procedure Last;
    procedure PageSetupDlg;
    procedure Cancel;
    procedure Clear;
    procedure SetPosition(PageN, Top: Integer);
    procedure ShowMessage(const s: String);
    procedure HideMessage;
    procedure MouseWheelScroll(Delta: Integer; Horz: Boolean = False;
      Zoom: Boolean = False);
    function  GetTopPosition: Integer;
    procedure LoadFromFile; overload;
    procedure LoadFromFile(FileName: String); overload;
    procedure SaveToFile; overload;
    procedure SaveToFile(FileName: String); overload;
    procedure Export(Filter: TfrxCustomExportFilter);

    property PageCount: Integer read GetPageCount;
    property PageNo: Integer read FPageNo write SetPageNo;
    property Zoom: Double read FZoom write SetZoom;
    property ZoomMode: TfrxZoomMode read FZoomMode write SetZoomMode;
    property Locked: Boolean read FLocked;
    property OutlineTree: TTreeView read FOutline;
    property Splitter: TfrxSplitter read FSplitter;
    property Thumbnail: TfrxPreviewWorkspace read FThumbnail;
    property Workspace: TfrxPreviewWorkspace read FWorkspace;
  published
    property Align;
    property ActiveFrameColor: TAlphaColor read GetActiveFrameColor write SetActiveFrameColor default $804020;
    property BackColor: TAlphaColor read GetBackColor write SetBackColor default claGray;
    property FrameColor: TAlphaColor read GetFrameColor write SetFrameColor default claBlack;
    property OutlineColor: TAlphaColor read FOutlineColor write SetOutlineColor default claWhite;
    property OutlineVisible: Boolean read GetOutlineVisible write SetOutlineVisible;
    property OutlineWidth: Integer read GetOutlineWidth write SetOutlineWidth;
    property PopupMenu;
    property Position;
    property Width;
    property Height;
    property ThumbnailVisible: Boolean read GetThumbnailVisible write SetThumbnailVisible;
    property OnClick;
    property OnDblClick;
    property OnPageChanged: TfrxPageChangedEvent read FOnPageChanged write FOnPageChanged;
    property OnMouseDown: TMouseEvent read GetOnMouseDown write SetOnMouseDown;
    property Anchors;
    property UseReportHints;
  end;

  TfrxPreviewForm = class(TForm)
    ToolBar: TToolBar;
    OpenB: TfrxToolButton;
    SaveB: TfrxToolButton;
    PrintB: TfrxToolButton;
    ExportB: TfrxToolButton;
    PageSettingsB: TfrxToolButton;
    FirstB: TfrxToolButton;
    PriorB: TfrxToolButton;
    PageE: TEdit;
    NextB: TfrxToolButton;
    LastB: TfrxToolButton;
    StatusBar: TStatusBar;
    DesignerB: TfrxToolButton;
    CancelB: TSpeedButton;
    ExportPopup: TPopupMenu;
    HiddenMenu: TPopupMenu;
    Showtemplate1: TMenuItem;
    RightMenu: TPopupMenu;
    FullScreenBtn: TfrxToolButton;
    OutlineB: TfrxToolButton;
    ThumbB: TfrxToolButton;
    N1: TMenuItem;
    ExpandMI: TMenuItem;
    CollapseMI: TMenuItem;
    Line1: TfrxToolSeparator;
    PageWidthB: TfrxToolButton;
    WholePageB: TfrxToolButton;
    Line2: TfrxToolSeparator;
    Line3: TfrxToolSeparator;
    Panel0: TText;
    Panel1: TText;
    Panel2: TText;
    OpenMI: TMenuItem;
    SaveMI: TMenuItem;
    PrintMI: TMenuItem;
    ExportMI: TMenuItem;
    ExportPDFMI: TMenuItem;
    ExportMailMI: TMenuItem;
    FindMI: TMenuItem;
    FullScrMI: TMenuItem;
    ZoomInMI: TMenuItem;
    ZoomOutMI: TMenuItem;
    ZoomCB: TComboEdit;
    HintPanel: TCalloutPanel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ZoomMinusBClick(Sender: TObject);
    procedure FirstBClick(Sender: TObject);
    procedure PriorBClick(Sender: TObject);
    procedure NextBClick(Sender: TObject);
    procedure LastBClick(Sender: TObject);
    procedure PageEClick(Sender: TObject);
    procedure PrintBClick(Sender: TObject);
    procedure OpenBClick(Sender: TObject);
    procedure SaveBClick(Sender: TObject);
    procedure DesignerBClick(Sender: TObject);
    procedure NewPageBClick(Sender: TObject);
    procedure DelPageBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
    procedure PageSettingsBClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure DesignerBMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Showtemplate1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FullScreenBtnClick(Sender: TObject);
    procedure PdfBClick(Sender: TObject);
    procedure EmailBClick(Sender: TObject);
    procedure ZoomPlusBClick(Sender: TObject);
    procedure OutlineBClick(Sender: TObject);
    procedure ThumbBClick(Sender: TObject);
    procedure CollapseAllClick(Sender: TObject);
    procedure ExpandAllClick(Sender: TObject);
    procedure ZoomCBChange(Sender: TObject);
    procedure PageWidthBClick(Sender: TObject);
    procedure WholePageBClick(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure ExportBClick(Sender: TObject);
    procedure ZoomCBClick(Sender: TObject);
    procedure PrintBMouseEnter(Sender: TObject);
    procedure PrintBMouseLeave(Sender: TObject);
  private
    FPopUpMItemsCount: Integer;
    FPopUpExporttemsCount: Integer;
    FFreeOnClose: Boolean;
    FPreview: TfrxPreview;
    FOldBS: TfmxFormBorderStyle;
    FOldState: TWindowState;
    FFullScreen: Boolean;
    FPDFExport: TfrxCustomExportFilter;
    FEmailExport: TfrxCustomExportFilter;
    procedure ExportMIClick(Sender: TObject);
    procedure OnPageChanged(Sender: TfrxPreview; PageNo: Integer);
    procedure OnPreviewDblClick(Sender: TObject);
    procedure UpdateControls;
    procedure UpdateZoom;
    function GetReport: TfrxReport;
  public
    procedure Init;
    procedure SetMessageText(const Value: String; IsHint: Boolean = False);
    procedure SwitchToFullScreen;
    property FreeOnClose: Boolean read FFreeOnClose write FFreeOnClose;
    property Preview: TfrxPreview read FPreview;
    property Report: TfrxReport read GetReport;
  end;

  TfrxPreviewWorkspace = class(TfrxScrollWin)
  private
    FActiveFrameColor: TAlphaColor;
    FBackColor: TAlphaColor;
    FDefaultCursor: TCursor;
    FDisableUpdate: Boolean;
    FDown: Boolean;
    FFrameColor: TAlphaColor;
    FIsThumbnail: Boolean;
    FLastPoint: TPointF;
    FLocked: Boolean;
    FOffset: TPoint;
    FTimeOffset: Cardinal;
    FPageList: TfrxPageList;
    FPageNo: Integer;
    FPreview: TfrxPreview;
    FPreviewPages: TfrxCustomPreviewPages;
    FZoom: Double;
    FRTLLanguage: Boolean;
    procedure DrawPages(BorderOnly: Boolean; ACanvas: TCanvas; ARect: TRectF);
    procedure SetToPageNo(PageNo: Integer);
    procedure UpdateScrollBars;
  protected
    procedure PrevDblClick(Sender: TObject);
    procedure MouseDown(Button: TMouseButton;
      Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Single); override;
    procedure OnHScrollChange(Sender: TObject); override;
    procedure OnVScrollChange(Sender: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetPosition(PageN, Top: Integer);
    function GetTopPosition: Integer;
    { page list }
    procedure AddPage(AWidth, AHeight: Integer);
    procedure ClearPageList;
    procedure CalcPageBounds(ClientWidth: Integer);
    procedure DoContentPaint(Sender: TObject; aCanvas: TCanvas; const ARect: TRectF); override;

    property ActiveFrameColor: TAlphaColor read FActiveFrameColor write FActiveFrameColor default $804020;
    property BackColor: TAlphaColor read FBackColor write FBackColor default claGray;
    property FrameColor: TAlphaColor read FFrameColor write FFrameColor default claBlack;
    property IsThumbnail: Boolean read FIsThumbnail write FIsThumbnail;
    property Locked: Boolean read FLocked write FLocked;
    property PageNo: Integer read FPageNo write FPageNo;
    property Preview: TfrxPreview read FPreview write FPreview;
    property PreviewPages: TfrxCustomPreviewPages read FPreviewPages
      write FPreviewPages;
    property Zoom: Double read FZoom write FZoom;
    property RTLLanguage: Boolean read FRTLLanguage write FRTLLanguage;
    property OnDblClick;
  end;

  TfrxPageItem = class(TCollectionItem)
  public
    Height: Integer;
    Width: Integer;
    OffsetX: Integer;
    OffsetY: Integer;
  end;

  TfrxPageList = class(TCollection)
  private
    FMaxWidth: Integer;
    function GetItems(Index: Integer): TfrxPageItem;
  public
    constructor Create;
    property Items[Index: Integer]: TfrxPageItem read GetItems; default;
    procedure AddPage(AWidth, AHeight: Integer; Zoom: Extended);
    procedure CalcBounds(ClientWidth: Integer);
    function FindPage(OffsetY: Integer; OffsetX: Integer = 0): Integer;
    function GetPageBounds(Index: Integer; ClientWidth: Single; Scale: Extended; RTL: Boolean): TRect;
    function GetMaxBounds: TPoint;
  end;


implementation

{$R *.FMX}
{$R *.RES}

uses
  FMX.frxPrinter, FMX.frxSearchDialog, FMX.frxUtils, FMX.frxRes, FMX.frxDsgnIntf,
  FMX.frxPreviewPageSettings, FMX.frxDMPClass;


{ TfrxPageList }

constructor TfrxPageList.Create;
begin
  inherited Create(TfrxPageItem);
end;

function TfrxPageList.GetItems(Index: Integer): TfrxPageItem;
begin
  Result := TfrxPageItem(inherited Items[Index]);
end;

procedure TfrxPageList.AddPage(AWidth, AHeight: Integer; Zoom: Extended);
begin
  with TfrxPageItem(Add) do
  begin
    Width := Round(AWidth * Zoom);
    Height := Round(AHeight * Zoom);
  end;
end;

procedure TfrxPageList.CalcBounds(ClientWidth: Integer);
var
  i, j, CurX, CurY, MaxY, offs: Integer;
  Item: TfrxPageItem;
begin
  FMaxWidth := 0;
  CurY := 10;
  i := 0;
  while i < Count do
  begin
    j := i;
    CurX := 0;
    MaxY := 0;
    { find series of pages that will fit in the clientwidth }
    { also calculate max height of series }
    while j < Count do
    begin
      Item := Items[j];
      { check the width, allow at least one iteration }
      if (CurX > 0) and (CurX + Item.Width > ClientWidth) then break;
      Item.OffsetX := CurX;
      Item.OffsetY := CurY;
      Inc(CurX, Item.Width + 10);
      if Item.Height > MaxY then
        MaxY := Item.Height;
      Inc(j);
    end;

    if CurX > FMaxWidth then
      FMaxWidth := CurX;

    { center series horizontally }
    offs := (ClientWidth - CurX + 10) div 2;
    if offs < 0 then
      offs := 0;
    Inc(offs, 10);
    while (i < j) do
    begin
      Inc(Items[i].OffsetX, offs);
      Inc(i);
    end;

    Inc(CurY, MaxY + 10);
  end;
end;

function TfrxPageList.FindPage(OffsetY: Integer; OffsetX: Integer = 0): Integer;
var
  i, i0, i1, c, add: Integer;
  Item: TfrxPageItem;
begin
  i0 := 0;
  i1 := Count - 1;

  while i0 <= i1 do
  begin
    i := (i0 + i1) div 2;
    if OffsetX <> 0 then
      add := 0 else
      add := Round(Items[i].Height / 5);
    if Items[i].OffsetY <= OffsetY + add then
      c := -1 else
      c := 1;

    if c < 0 then
      i0 := i + 1 else
      i1 := i - 1;
  end;

  { find exact page }
  if OffsetX <> 0 then
  begin
    for i := i1 - 20 to i1 + 20 do
    begin
      if (i < 0) or (i >= Count) then continue;
      Item := Items[i];
      if PtInRect(Rect(Item.OffsetX, Item.OffsetY,
        Item.OffsetX + Item.Width, Item.OffsetY + Item.Height),
        Point(OffsetX, OffsetY)) then
      begin
        i1 := i;
        break;
      end;
    end;
  end;

  Result := i1;
end;

function TfrxPageList.GetPageBounds(Index: Integer; ClientWidth: Single;
  Scale: Extended; RTL: Boolean): TRect;
var
  ColumnOffs: Integer;
  Item: TfrxPageItem;
begin
  if (Index >= Count) or (Index < 0) then
  begin
    if 794 * Scale > ClientWidth then
      ColumnOffs := 10 else
      ColumnOffs := Round((ClientWidth - 794 * Scale) / 2);
    Result.Left := ColumnOffs;
    Result.Top := Round(10 * Scale);
    Result.Right := Result.Left + Round(794 * Scale);
    Result.Bottom := Result.Top + Round(1123 * Scale);
  end
  else
  begin
    Item := Items[Index];
    if RTL then
      Result.Left := Round(ClientWidth) - Item.Width - Item.OffsetX
    else
      Result.Left := Item.OffsetX;
    Result.Top := Item.OffsetY;
    Result.Right := Result.Left + Item.Width;
    Result.Bottom := Result.Top + Item.Height;
  end;
end;

function TfrxPageList.GetMaxBounds: TPoint;
begin
  if Count = 0 then
    Result := Point(0, 0)
  else
  begin
    Result.X := FMaxWidth;
    Result.Y := Items[Count - 1].OffsetY + Items[Count - 1].Height;
  end;
end;


{ TfrxPreviewWorkspace }

constructor TfrxPreviewWorkspace.Create(AOwner: TComponent);
begin
  inherited;
  FPageList := TfrxPageList.Create;
  OnDblClick := PrevDblClick;

  FBackColor := claGray;
  FFrameColor := claBlack;
  FActiveFrameColor := $804020;
  FZoom := 1;
  FDefaultCursor := crDefault;
end;

destructor TfrxPreviewWorkspace.Destroy;
begin
  FPageList.Free;
  inherited;
end;

procedure TfrxPreviewWorkspace.DoContentPaint(Sender: TObject; aCanvas: TCanvas;
  const ARect: TRectF);
begin
  inherited;
  DrawPages(False, aCanvas, ARect);
end;

procedure TfrxPreviewWorkspace.OnHScrollChange(Sender: TObject);
var
  r: TRect;
begin
  FOffset.X := Round(HorzPosition);
  Repaint;
end;

procedure TfrxPreviewWorkspace.OnVScrollChange(Sender: TObject);
var
  i: Integer;
  r: TRect;
begin
  FOffset.Y := Round(VertPosition);
  Repaint;

  if not FIsThumbnail then
  begin
    i := FPageList.FindPage(FOffset.Y);
    FDisableUpdate := True;
    Preview.PageNo := i + 1;
    FDisableUpdate := False;
  end;
end;

procedure TfrxPreviewWorkspace.DrawPages(BorderOnly: Boolean; ACanvas: TCanvas; ARect: TRectF);
var
  i, n: Integer;
  PageBounds: TRect;
  poly: TPolygon;
  state: TCanvasSaveState;
  cWidth: Single;
  m: TMatrix;

  function PageVisible: Boolean;
  begin
    if (PageBounds.Top > Height) or (PageBounds.Bottom < 0) then
      Result := False
    else
      Result := True;
  end;

  procedure DrawPage(Index: Integer);
  var
    i: Integer;
    TxtBounds: TRect;
  begin
    with ACanvas, PageBounds do
    begin
      Stroke.Color := FrameColor;
      StrokeThickness := 1;
      Stroke.Kind := TBrushKind.bkSolid;

      Stroke.Gradient.Color := claRed;
      Fill.Kind := TBrushKind.bkSolid;
      Fill.Color := claWhite;
      Dec(Bottom);
      DrawRect(RectF(Left, Top, Right, Bottom), 0, 0, allCorners, 1);
      FillRect(RectF(Left, Top, Right, Bottom), 0, 0, allCorners, 1);
    end;

    PreviewPages.DrawPage(Index, ACanvas, Zoom, Zoom, PageBounds.Left, PageBounds.Top);

    if FIsThumbnail then
      with ACanvas do
      begin
        Font.Family := 'Arial';
        Font.Size := 8;
        Font.Style := [];
        Fill.Kind := TBrushKind.bkSolid;
        Fill.Color := claWhite;
        FillText(
          RectF(PageBounds.Left + 1, PageBounds.Top + 1, PageBounds.Left + 10, PageBounds.Top + 10),
          ' ' + IntToStr(Index + 1) + ' ', False, 1, [],
          TTextAlign.taLeading, TTextAlign.taLeading);
      end;
  end;

begin
  if not Visible then Exit;
   ///doesn't work under win7  canvas
  m := Canvas.Matrix;
  State := Canvas.SaveState;
  Canvas.IntersectClipRect(ARect);
  try


    cWidth := ARect.Right - ARect.Left;
    if not BorderOnly then
      with aCanvas do
      begin
        Fill.Color := BackColor;
        Fill.Kind := TBrushKind.bkSolid;
        FillRect(RectF(0, 0, cWidth, Arect.Bottom - ARect.Top), 0, 0, allCorners, 1);
      end;

    if Locked or (FPageList.Count = 0) then
      Exit;

    if PreviewPages = nil then Exit;

    { index of first visible page }
    n := FPageList.FindPage(FOffset.Y);

    { draw border around the active page }
    PageBounds := FPageList.GetPageBounds(PageNo - 1, cWidth, Zoom, FRTLLanguage);
    OffsetRect(PageBounds, -FOffset.X, -FOffset.Y);
    with ACanvas, PageBounds do
    begin
      Stroke.Color := ActiveFrameColor;
      StrokeThickness := 2;
      Stroke.Kind := TBrushKind.bkSolid;
      SetLength(poly, 5);
      poly[0] := PointF(Left - 1, Top - 1);
      poly[1] := PointF(Right + 1, Top - 1);
      poly[2] := PointF(Right + 1, Bottom + 1);
      poly[3] := PointF(Left - 1, Bottom + 1);
      poly[4] := PointF(Left - 1, Top - 2);
      DrawPolygon(poly, 1);
    end;
    if not BorderOnly then
    begin
      { draw visible pages }
     for i := n - 40 to n + 40 do
     begin
      if i < 0 then continue;
      if i >= FPageList.Count then break;

      PageBounds := FPageList.GetPageBounds(i, cWidth, Zoom, FRTLLanguage);
      OffsetRect(PageBounds, -FOffset.X, -FOffset.Y);
      Inc(PageBounds.Bottom);
      if PageVisible then
        DrawPage(i);
    end;
  end;

  finally
    Canvas.RestoreState(state);
    Canvas.SetMatrix(m);
  end;
end;

procedure TfrxPreviewWorkspace.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Assigned(OnMouseDown) then
    OnMouseDown(Self, Button, Shift, X, Y);
  if (FPageList.Count = 0) or Locked then Exit;

  if Button = mbLeft then
  begin
    FDown := True;
    FLastPoint.X := X;
    FLastPoint.Y := Y;
  end;
end;

procedure TfrxPreviewWorkspace.MouseMove(Shift: TShiftState; X, Y: Single);
var
  PageNo: Integer;
  PageBounds: TRect;
  Cur: TCursor;
begin
  if (FPageList.Count = 0) or Locked or FIsThumbnail then Exit;

  if FDown then
  begin
    HorzPosition := HorzPosition - (X - FLastPoint.X);
    VertPosition := VertPosition - (Y - FLastPoint.Y);
    FLastPoint.X := X;
    FLastPoint.Y := Y;
  end
  else
  begin
    PageNo := FPageList.FindPage(FOffset.Y + Round(Y), FOffset.X + Round(X));
    PageBounds := FPageList.GetPageBounds(PageNo, Width, Zoom, FRTLLanguage);
    Cur := FDefaultCursor;
    PreviewPages.ObjectOver(PageNo, Round(X), Round(Y), mbLeft, [], Zoom,
      PageBounds.Left - FOffset.X, PageBounds.Top - FOffset.Y, False, Cur);
    Cursor := Cur;
  end;
end;

procedure TfrxPreviewWorkspace.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
var
  PageNo: Integer;
  PageBounds: TRect;
  Cur: TCursor;
  XOffSet: Integer;
begin
  inherited;
  if not FIsThumbnail and Assigned(Preview.OnClick) then
    Preview.OnClick(Preview);
  if (FPageList.Count = 0) or Locked then Exit;

  FDown := False;
  if FRTLLanguage then
    XOffSet := Round(Width - (FOffset.X + X))
  else
    XOffSet := FOffset.X + Round(X);

  PageNo := FPageList.FindPage(FOffset.Y + Round(Y), XOffSet);
  FDisableUpdate := True;
  Preview.PageNo := PageNo + 1;
  FDisableUpdate := False;

  if not FIsThumbnail and (Button <> mbRight) then
  begin
    PageBounds := FPageList.GetPageBounds(PageNo, Width, Zoom, FRTLLanguage);
// todo - check
    if ssDouble in Shift then
    begin
      PreviewPages.ObjectOver(PageNo, Round(X), Round(Y), Button, Shift, Zoom,
      PageBounds.Left - FOffset.X, PageBounds.Top - FOffset.Y, True, Cur, True);
    end
    else
    begin
      PreviewPages.ObjectOver(PageNo, Round(X), Round(Y), Button, Shift, Zoom,
      PageBounds.Left - FOffset.X, PageBounds.Top - FOffset.Y, True, Cur);
    end;
  end;
end;

procedure TfrxPreviewWorkspace.SetToPageNo(PageNo: Integer);
begin
  if FDisableUpdate then Exit;
  VertPosition :=
    FPageList.GetPageBounds(PageNo - 1, Width, Zoom, FRTLLanguage).Top - 10;
end;

procedure TfrxPreviewWorkspace.UpdateScrollBars;
var
  MaxSize: TPoint;
begin
  MaxSize := FPageList.GetMaxBounds;
  HorzRange := MaxSize.X + 10;
  VertRange := MaxSize.Y + 10;
end;

procedure TfrxPreviewWorkspace.SetPosition(PageN, Top: Integer);
var
  Pos: Integer;
  Page: TfrxReportPage;
begin
  Page := PreviewPages.Page[PageN - 1];
  if Page = nil then
    exit;
  if Top = 0 then
    Pos := 0
  else
    Pos := Round((Top + Page.TopMargin * fr01cm) * Zoom);

  VertPosition := FPageList.GetPageBounds(PageN - 1, Width, Zoom, FRTLLanguage).Top - 10 + Pos;
end;

function TfrxPreviewWorkspace.GetTopPosition: Integer;
var
  Page: TfrxReportPage;
begin
  Result := 0;
  Page := PreviewPages.Page[Preview.PageNo - 1];
  if Page <> nil then
    Result := Round((VertPosition - FPageList.GetPageBounds(Preview.PageNo - 1, Width, Zoom, FRTLLanguage).Top + 10)/ Zoom - Page.TopMargin * fr01cm);
end;

procedure TfrxPreviewWorkspace.AddPage(AWidth, AHeight: Integer);
begin
  FPageList.AddPage(AWidth, AHeight, Zoom);
end;

procedure TfrxPreviewWorkspace.CalcPageBounds(ClientWidth: Integer);
begin
  FPageList.CalcBounds(ClientWidth);
end;

procedure TfrxPreviewWorkspace.ClearPageList;
begin
  FPageList.Clear;
end;


procedure TfrxPreviewWorkspace.PrevDblClick(Sender: TObject);
begin
  if not IsThumbnail and Assigned(FPreview.OnDblClick) then
    FPreview.OnDblClick(Sender);
end;

{ TfrxPreview }

constructor TfrxPreview.Create(AOwner: TComponent);
var
  m: TMenuItem;
begin
  inherited;

  FOutlinePopup := TPopupMenu.Create(Self);
  m := TMenuItem.Create(FOutlinePopup);
  FOutlinePopup.AddObject(m);
  m.Text := frxGet(601);
  FOutlinePopup.Stored := false;
//  m.Bitmap := 13;
  m.OnClick := OnCollapseClick;
  m := TMenuItem.Create(FOutlinePopup);
  FOutlinePopup.AddObject(m);
  m.Text := frxGet(600);
//  m.ImageIndex := 14;
  m.OnClick := OnExpandClick;

  FOutline := TTreeView.Create(Self);
  with FOutline do
  begin
    Parent := Self;
    Align := alLeft;
    OnClick := OnOutlineClick;
    PopupMenu := FOutlinePopup;
    Stored := False;
  end;

  FThumbnail := TfrxPreviewWorkspace.Create(Self);
  FThumbnail.Parent := Self;
  FThumbnail.Align := alLeft;
  FThumbnail.Visible := False;
  FThumbnail.Zoom := 0.1;
  FThumbnail.IsThumbnail := True;
  FThumbnail.Preview := Self;
  FThumbnail.Stored := False;

  FSplitter := TfrxSplitter.Create(Self);
  FSplitter.Parent := Self;
  FSplitter.Align := alLeft;
  FSplitter.Width := 4;
  FSplitter.OnMove := OnMoveSplitter;
  FSplitter.Stored := False;

  FWorkspace := TfrxPreviewWorkspace.Create(Self);
  FWorkspace.Parent := Self;
  FWorkspace.Align := alClient;
  FWorkspace.Preview := Self;
  FWorkspace.OnResize := OnResize;
  FWorkspace.Stored := False;

  FMessagePanel := TPanel.Create(Self);
  FMessagePanel.Parent := Self;
  FMessagePanel.Visible := False;
  FMessagePanel.SetBounds(0, 0, 0, 0);
  FMessagePanel.Stored := False;

  FMessageLabel := TLabel.Create(FMessagePanel);
  FMessageLabel.Parent := FMessagePanel;
  FMessageLabel.AutoSize := False;
  FMessageLabel.TextAlign := taCenter;
  FMessageLabel.SetBounds(4, 20, 255, 20);
  FMessageLabel.Stored := False;

  FCancelButton := TButton.Create(FMessagePanel);
  FCancelButton.Parent := FMessagePanel;
  FCancelButton.SetBounds(92, 44, 75, 25);
  FCancelButton.Text := frxResources.Get('clCancel');
  FCancelButton.Visible := False;
  FCancelButton.OnClick := OnCancel;
  FCancelButton.Stored := False;

  FPageNo := 1;
  FZoom := 1;
  FZoomMode := zmDefault;
  FOutlineColor := claWhite;
  UseReportHints := True;

  Width := 100;
  Height := 100;

  HintPanel := TCalloutPanel.Create(Self);
  HintPanel.Stored := False;
  HintPanel.Parent := Self;
  HintLabel := TLabel.Create(HintPanel);
  HintLabel.Stored := False;
  HintLabel.Parent := HintPanel;
  HintPanel.Visible := False;
  HintPanel.SetBounds(0,0,100, 40);
  HintLabel.Align := TAlignLayout.alClient;
end;

destructor TfrxPreview.Destroy;
begin
  if Report <> nil then
    Report.Preview := nil;
  inherited;
end;

procedure TfrxPreview.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if Operation = opRemove then
    if AComponent = Report then
    begin
      Clear;
      Report := nil;
      PreviewPages := nil;
    end;
end;

procedure TfrxPreview.Init;
begin
  if csDesigning in ComponentState then Exit;

  FWorkspace.PreviewPages := PreviewPages;
  FThumbnail.PreviewPages := PreviewPages;
  FAllowF3 := False;

  OutlineWidth := Report.PreviewOptions.OutlineWidth;
  OutlineVisible := Report.PreviewOptions.OutlineVisible;
  ThumbnailVisible := Report.PreviewOptions.ThumbnailVisible;
  FZoomMode := Report.PreviewOptions.ZoomMode;
  FZoom := Report.PreviewOptions.Zoom;
  UpdatePages;
  UpdateOutline;
  First;
end;

procedure TfrxPreview.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
begin
  inherited;
  if ssCtrl in Shift then
  begin
    if (Key = Ord('P')) and (pbPrint in Report.PreviewOptions.Buttons) then
      Print
    else if (Key = Ord('S')) and (pbSave in Report.PreviewOptions.Buttons) then
      SaveToFile
    else if (Key = Ord('O')) and (pbLoad in Report.PreviewOptions.Buttons) then
      LoadFromFile
  end;
end;

procedure TfrxPreview.Resize;
begin
  inherited;
end;

procedure TfrxPreview.OnMoveSplitter(Sender: TObject);
begin
  UpdatePages;
end;

procedure TfrxPreview.OnCollapseClick(Sender: TObject);
begin
  FOutline.CollapseAll;
  FWorkspace.SetFocus;
end;

procedure TfrxPreview.OnExpandClick(Sender: TObject);
begin
  FOutline.ExpandAll;
  FWorkspace.SetFocus;
end;

procedure TfrxPreview.SetZoom(const Value: Double);
begin
  FZoom := Value;
  if FZoom < 0.25 then
    FZoom := 0.25;
  if FZoom > 5.0 then
    FZoom := 5;

  FZoomMode := zmDefault;
  UpdatePages;
end;

procedure TfrxPreview.SetZoomMode(const Value: TfrxZoomMode);
begin
  FZoomMode := Value;
  UpdatePages;
end;

function TfrxPreview.GetOutlineVisible: Boolean;
begin
  Result := FOutline.Visible;
end;

procedure TfrxPreview.SetOutlineVisible(const Value: Boolean);
var
  NeedChange: Boolean;
begin
  NeedChange := Value <> FOutline.Visible;

  FSplitter.Visible := Value or ThumbnailVisible;
  FOutline.Visible := Value;

  if Value then
    FThumbnail.Visible := False;

  if Owner is TfrxPreviewForm then
    TfrxPreviewForm(Owner).OutlineB.Down := Value;
  if NeedChange then
    UpdatePages;
end;

function TfrxPreview.GetThumbnailVisible: Boolean;
begin
  Result := FThumbnail.Visible;
end;

procedure TfrxPreview.SetThumbnailVisible(const Value: Boolean);
var
  NeedChange: Boolean;
begin
  NeedChange := Value <> FThumbnail.Visible;

  FSplitter.Visible := Value or OutlineVisible;
  FThumbnail.Visible := Value;
  
  if Value then
    FOutline.Visible := False;

  if Value then
  begin
    FThumbnail.HorzPosition := FThumbnail.HorzPosition;
    FThumbnail.VertPosition := FThumbnail.VertPosition;
  end;
  if Owner is TfrxPreviewForm then
    TfrxPreviewForm(Owner).ThumbB.Down := Value;
  if NeedChange then
    UpdatePages;
end;

function TfrxPreview.GetOutlineWidth: Integer;
begin
  Result := Round(FOutline.Width);
end;

procedure TfrxPreview.SetOutlineWidth(const Value: Integer);
begin
  FOutline.Width := Value;
  if not (csDesigning in ComponentState) then
    FThumbnail.Width := Value;
end;

procedure TfrxPreview.SetOutlineColor(const Value: TAlphaColor);
begin
  FOutlineColor := Value;
//  FOutline.Color := Value;
end;

procedure TfrxPreview.SetPageNo(Value: Integer);
var
  ActivePageChanged: Boolean;
begin
  if Value < 1 then
    Value := 1;
  if Value > PageCount then
    Value := PageCount;
  if Value = 0 then Exit;

  ActivePageChanged := FPageNo <> Value;
  FPageNo := Value;
  FWorkspace.PageNo := Value;
  FThumbnail.PageNo := Value;

  FWorkspace.SetToPageNo(FPageNo);
  FThumbnail.SetToPageNo(FPageNo);
  UpdatePageNumbers;
end;

function TfrxPreview.GetActiveFrameColor: TAlphaColor;
begin
  Result := FWorkspace.ActiveFrameColor;
end;

function TfrxPreview.GetBackColor: TAlphaColor;
begin
  Result := FWorkspace.BackColor;
end;

function TfrxPreview.GetFrameColor: TAlphaColor;
begin
  Result := FWorkspace.FrameColor;
end;

procedure TfrxPreview.SetActiveFrameColor(const Value: TAlphaColor);
begin
  FWorkspace.ActiveFrameColor := Value;
end;

procedure TfrxPreview.SetBackColor(const Value: TAlphaColor);
begin
  FWorkspace.BackColor := Value;
end;

procedure TfrxPreview.SetFrameColor(const Value: TAlphaColor);
begin
  FWorkspace.FrameColor := Value;
end;

procedure TfrxPreview.UpdatePageNumbers;
begin
  if Assigned(FOnPageChanged) then
    FOnPageChanged(Self, FPageNo);
end;

function TfrxPreview.GetPageCount: Integer;
begin
  if PreviewPages <> nil then
    Result := PreviewPages.Count
  else
    Result := 0;
end;

function TfrxPreview.GetOnMouseDown: TMouseEvent;
begin
  Result := FWorkspace.OnMouseDown;
end;

procedure TfrxPreview.SetOnMouseDown(const Value: TMouseEvent);
begin
  FWorkspace.OnMouseDown := Value;
end;

procedure TfrxPreview.ShowHint(aRect: TRectF; Text: String);
var
  r: TRectF;
begin
  inherited;
  HintPanel.CalloutPosition := TCalloutPosition.cpTop;
  HintPanel.Position.X := aRect.Left + aRect.Width/2  - HintPanel.Width/2;
  HintPanel.Position.Y := aRect.Top + aRect.Height;
{$IFDEF DELPHI18}
    HintLabel.Margins.Left := 0;
    HintLabel.Margins.Top := 0;
{$ELSE}
    HintLabel.Padding.Left := 0;
    HintLabel.Padding.Top := 0;
{$ENDIF}
  HintLabel.Visible := True;
  HintLabel.WordWrap := True;
  r := RectF(0, 0, 200, 1000);
  if HintLabel.Canvas <> nil then
    HintLabel.Canvas.MeasureText(r, Text, True, [], TTextAlign.taCenter, TTextAlign.taCenter);
  HintPanel.Width := r.Width + 6;
  HintPanel.Height := r.Height + HintPanel.CalloutLength + 10;
  HintPanel.Visible := True;
  HintLabel.WordWrap := True;
  HintLabel.VertTextAlign := TTextAlign.taCenter;
  HintLabel.TextAlign := TTextAlign.taCenter;
  HintLabel.Text := Text;
end;

procedure TfrxPreview.ShowMessage(const s: String);
begin
  FMessagePanel.SetBounds((Width - 260) / 2, (Height - 75) / 3, 260, 75);
  FMessageLabel.Text := s;
  FMessagePanel.Visible := True;
  FMessagePanel.Repaint;
end;

procedure TfrxPreview.HideHint;
begin
  inherited;
  HintPanel.Visible := False;
end;

procedure TfrxPreview.HideMessage;
begin
  FMessagePanel.Visible := False;
  FCancelButton.Visible := False;
end;

procedure TfrxPreview.First;
begin
  PageNo := 1;
end;

procedure TfrxPreview.Next;
begin
  PageNo := PageNo + 1;
end;

procedure TfrxPreview.Prior;
begin
  PageNo := PageNo - 1;
end;

procedure TfrxPreview.Last;
begin
  PageNo := PageCount;
end;

procedure TfrxPreview.Print;
begin
  if FRunning then Exit;
  try
    PreviewPages.CurPreviewPage := PageNo;
    PreviewPages.Print;
  finally
    Unlock;
  end;
end;

procedure TfrxPreview.SaveToFile;
var
  SaveDlg: TSaveDialog;
begin
  if FRunning then Exit;
  SaveDlg := TSaveDialog.Create(Application);
  try
    SaveDlg.Filter := frxResources.Get('clFP3files') + ' (*.fp3)|*.fp3';
    if SaveDlg.Execute then
    begin
      FWorkspace.Repaint;
      SaveToFile(ChangeFileExt(SaveDlg.FileName, '.fp3'));
    end;
  finally
    SaveDlg.Free;
  end;
end;

procedure TfrxPreview.SaveToFile(FileName: String);
begin
  if FRunning then Exit;
  try
    Lock;
    ShowMessage(frxResources.Get('clSaving'));
    PreviewPages.SaveToFile(FileName);
  finally
    Unlock;
  end;
end;

procedure TfrxPreview.LoadFromFile;
var
  OpenDlg: TOpenDialog;
begin
  if FRunning then Exit;
  OpenDlg := TOpenDialog.Create(nil);
  try
    OpenDlg.Filter := frxResources.Get('clFP3files') + ' (*.fp3)|*.fp3';
    if OpenDlg.Execute then
    begin
      FWorkspace.Repaint;
      LoadFromFile(OpenDlg.FileName);
    end;
  finally
    OpenDlg.Free;
  end;
end;

procedure TfrxPreview.LoadFromFile(FileName: String);
begin
  if FRunning then Exit;
  try
    Lock;
    ShowMessage(frxResources.Get('clLoading'));
    PreviewPages.LoadFromFile(FileName);
  finally
    PageNo := 1;
    UpdateOutline;
    Unlock;
  end;
end;

procedure TfrxPreview.Export(Filter: TfrxCustomExportFilter);
begin
  if FRunning then Exit;
  try
    PreviewPages.CurPreviewPage := PageNo;
    if Report.DotMatrixReport and (frxDotMatrixExport <> nil) and
      (Filter.ClassName = 'TfrxTextExport') then
      Filter := frxDotMatrixExport;
    PreviewPages.Export(Filter);
  finally
    Unlock;
  end;
end;

procedure TfrxPreview.PageSetupDlg;
var
  APage: TfrxReportPage;

  procedure UpdateReport;
  var
    i: Integer;
  begin
    for i := 0 to Report.PagesCount - 1 do
      if Report.Pages[i] is TfrxReportPage then
        with TfrxReportPage(Report.Pages[i]) do
        begin
          Orientation := APage.Orientation;
          PaperWidth := APage.PaperWidth;
          PaperHeight := APage.PaperHeight;
          PaperSize := APage.PaperSize;

          LeftMargin := APage.LeftMargin;
          RightMargin := APage.RightMargin;
          TopMargin := APage.TopMargin;
          BottomMargin := APage.BottomMargin;
        end;
  end;

begin
  if FRunning then Exit;
  APage := PreviewPages.Page[PageNo - 1];

  if Assigned(APage) then with TfrxPageSettingsForm.Create(Application) do
  begin
    Page := APage;
    Report := Self.Report;
	FormShow(nil);
    if ShowModal = mrOk then
    begin
      if NeedRebuild then
      begin
        UpdateReport;
        Self.Report.PrepareReport;
      end
      else
      begin
        try
          Lock;
          PreviewPages.ModifyPage(PageNo - 1, Page);
        finally
          Unlock;
        end;
      end;
    end;
    Free;
  end;
end;

procedure TfrxPreview.Edit;
var
  r: TfrxReport;
  p: TfrxReportPage;
  SourcePage: TfrxPage;

  procedure RemoveBands;
  var
    i: Integer;
    l: TList;
    c: TfrxComponent;
  begin
    l := p.AllObjects;

    for i := 0 to l.Count - 1 do
    begin
      c := l[i];
      if c is TfrxView then
      begin
        TfrxView(c).DataField := '';
        TfrxView(c).DataSet := nil;
        TfrxView(c).Restrictions := [];
      end;

      if c.Parent <> p then
      begin
        c.Left := c.AbsLeft;
        c.Top := c.AbsTop;
        c.ParentFont := False;
        c.Parent := p;
        if (c is TfrxView) and (TfrxView(c).Align in [baBottom, baClient]) then
          TfrxView(c).Align := baNone;
      end;
    end;

    for i := 0 to l.Count - 1 do
    begin
      c := l[i];
      if c is TfrxBand then
        c.Free;
    end;
  end;

begin
  SourcePage := PreviewPages.Page[PageNo - 1];
  r := nil;
  if Assigned(SourcePage) then
  try

    if SourcePage is TfrxDMPPage then
      p := TfrxDMPPage.Create(nil) else
      p := TfrxReportPage.Create(nil);
    r := TfrxReport.Create(nil);
    p.AssignAll(SourcePage);
    p.Parent := r;
    RemoveBands;
    if r.DesignPreviewPage then
      try
        Lock;
        PreviewPages.ModifyPage(PageNo - 1, TfrxReportPage(r.Pages[0]));
      finally
        Unlock;
      end;
  except
  end;
  if r <> nil then
    r.Free;
end;

procedure TfrxPreview.EditTemplate;
var
  r: TfrxReport;
  i: Integer;
begin
  r := TfrxReport.Create(nil);
  try
    for i := 0 to TfrxPreviewPages(PreviewPages).SourcePages.Count - 1 do
      r.Objects.Add(TfrxPreviewPages(PreviewPages).SourcePages[i]);
    r.DesignReport;
  finally
    r.Objects.Clear;
    r.Free;
  end;
end;

procedure TfrxPreview.Clear;
begin
  if FRunning then Exit;
  Lock;
  try
    PreviewPages.Clear;
  finally
    Unlock;
  end;

  FWorkspace.ClearPageList;
  FThumbnail.ClearPageList;
  UpdateOutline;
  PageNo := 1;
  with FWorkspace do
  begin
    HorzRange := 0;
    VertRange := 0;
  end;
  if ThumbnailVisible then
  with FThumbnail do
  begin
    HorzRange := 0;
    VertRange := 0;
  end;
end;

procedure TfrxPreview.AddPage;
begin
  if FRunning then Exit;
  PreviewPages.AddEmptyPage(PageNo - 1);
  UpdatePages;
  PageNo := PageNo;
end;

procedure TfrxPreview.DeletePage;
begin
  if FRunning then Exit;
  PreviewPages.DeletePage(PageNo - 1);
  if PageNo >= PageCount then
    PageNo := PageNo - 1;
  UpdatePages;
  UpdatePageNumbers;
end;

procedure TfrxPreview.Lock;
begin
  FLocked := True;
  FWorkspace.Locked := True;
  FThumbnail.Locked := True;
end;

procedure TfrxPreview.Unlock;
begin
  HideMessage;
  FLocked := False;
  FWorkspace.Locked := False;
  FThumbnail.Locked := False;
  UpdatePages;
  FWorkspace.Repaint;
  FThumbnail.Repaint;
end;

procedure TfrxPreview.SetPosition(PageN, Top: Integer);
begin
  if PageN > PageCount then
    PageN := PageCount;
  if PageN <= 0 then
    PageN := 1;
  FWorkspace.SetPosition(PageN, Top);
end;

function  TfrxPreview.GetTopPosition: Integer;
begin
  Result := FWorkspace.GetTopPosition;
end;

procedure TfrxPreview.RefreshReport;
var
  hpos, vpos, pno: Integer;
begin
  if not Assigned(Report) then exit;
  
  hpos := FWorkspace.FOffset.X;
  vpos := FWorkspace.FOffset.Y;
  pno := FPageNo;

  Lock;
  FRefreshing := True;
  try
    Report.PrepareReport;
    FLocked := False;
    FThumbnail.Locked := False;
    if pno <= PageCount then
      FPageNo := pno
    else
      FPageNo := 1;
    UpdatePages;
    UpdateOutline;
  finally
    Unlock;
    FRefreshing := False;
  end;

  FWorkspace.FOffset.X := hpos;
  FWorkspace.FOffset.Y := vpos;
  FWorkspace.Locked := False;
  FWorkspace.Repaint;
  FThumbnail.Repaint;
  if pno > PageCount then
    PageNo := 1;
end;

procedure TfrxPreview.UpdatePages;
var
  PageSize: TPoint;
  i: Integer;
begin
  if FLocked or (PageCount = 0) then Exit;

  { calc zoom if not zmDefault}
  PageSize := PreviewPages.PageSize[PageNo - 1];
  if PageSize.Y = 0 then Exit;
  case FZoomMode of
    zmWholePage:
      begin
        if PageSize.Y / Height < PageSize.X / Width then
          FZoom := (FWorkspace.Width - 26) / PageSize.X
        else
          FZoom := (FWorkspace.Height - 26) / PageSize.Y;
        SetPosition(PageNo, 0);
      end;
    zmPageWidth:
      FZoom := (FWorkspace.Width - 26) / PageSize.X
  end;

  { fill page list and calc bounds }
  FWorkspace.Zoom := FZoom;
  FThumbnail.Zoom := 0.1;
  FWorkspace.ClearPageList;
  FThumbnail.ClearPageList;
  for i := 0 to PageCount - 1 do
  begin
    PageSize := PreviewPages.PageSize[i];
    FWorkspace.AddPage(PageSize.X, PageSize.Y);
    if not FRunning then
      FThumbnail.AddPage(PageSize.X, PageSize.Y);
  end;

  FWorkspace.CalcPageBounds(Round(FWorkspace.Width - 26));
  if not FRunning then
    FThumbnail.CalcPageBounds(Round(FThumbnail.Width - 26));

  FWorkspace.UpdateScrollBars;
  FThumbnail.UpdateScrollBars;
  { avoid positioning errors when resizing }
  FWorkspace.HorzPosition := FWorkspace.HorzPosition;
  FWorkspace.VertPosition := FWorkspace.VertPosition;

  if not FRefreshing then
  begin
    FWorkspace.Repaint;
    FThumbnail.Repaint;
  end;

  if Owner is TfrxPreviewForm then
    TfrxPreviewForm(Owner).UpdateZoom;
end;

procedure TfrxPreview.UpdateOutline;
var
  Outline: TfrxCustomOutline;
  procedure DoUpdate(RootNode: TFmxObject);
  var
    i, n: Integer;
    Node: TTreeViewItem;
    Page, Top: Integer;
    Text: String;
  begin
    n := Outline.Count;
    for i := 0 to n - 1 do
    begin
      Outline.GetItem(i, Text, Page, Top);
      Node := TTreeViewItem.Create(RootNode);
      Node.Text := Text;

      Node.Tag := Page + 1;
      Node.TagFloat := Top;
      RootNode.AddObject(Node);

      Outline.LevelDown(i);
      DoUpdate(Node);
      Outline.LevelUp;
    end;
  end;

begin
  FOutline.BeginUpdate;
  FOutline.Clear;

  Outline := Report.PreviewPages.Outline;
  Outline.LevelRoot;
  DoUpdate(FOutline);
  if Report.PreviewOptions.OutlineExpand then
    FOutline.ExpandAll;
  //todo
  //if FOutline.Count > 0 then
  //  FOutline.TopItem := FOutline.Items[0];
  FOutline.EndUpdate;
end;

procedure TfrxPreview.OnOutlineClick(Sender: TObject);
var
  Node: TTreeViewItem;
  PageN, Top: Integer;
begin
  Node := FOutline.Selected;
  if Node = nil then Exit;

  PageN := Node.Tag;
  Top := Trunc(Node.TagFloat);

  SetPosition(PageN, Top);
  SetFocus;
end;

procedure TfrxPreview.OnResize(Sender: TObject);
begin
  if PreviewPages <> nil then
    UpdatePages;
end;

procedure TfrxPreview.InternalOnProgressStart(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  if FRefreshing then Exit;

  Clear;
  Report.DrillState.Clear;
  FRunning := True;
  if Owner is TfrxPreviewForm then
    TfrxPreviewForm(Owner).UpdateControls;
end;

procedure TfrxPreview.InternalOnProgress(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
var
  PageSize: TPoint;
{$IFNDEF MSWINDOWS}
  bIDLE: Boolean;
{$ENDIF}
begin
  if FRefreshing then
  begin
    UpdatePageNumbers;
    Exit;
  end;

  if Report.Engine.FinalPass then
  begin
    PageSize := Report.PreviewPages.PageSize[Progress];
    if Progress < 50 then
    begin
      FWorkspace.AddPage(PageSize.X, PageSize.Y);
      FWorkspace.CalcPageBounds(Round(FWorkspace.Width) - 26);
    end;
  end;

  if Progress = 0 then
  begin
    PageNo := 1;
    if Report.Engine.FinalPass then
      UpdatePages;
    if Owner is TfrxPreviewForm then
      TfrxPreviewForm(Owner).CancelB.Text := frxResources.Get('clCancel');
//    FTick := GetTickCount;
  end
  else if Progress = 1 then
  begin
{    FTick := GetTickCount - FTick;
    if FTick < 5 then
      FTick := 50
    else if FTick < 10 then
      FTick := 20
    else
      FTick := 5;}
    PageNo := 1;
    if Report.Engine.FinalPass then
      UpdatePages;
  end
  else //if Progress mod Integer(FTick) = 0 then
  begin
    UpdatePageNumbers;
    if Report.Engine.FinalPass then
      FWorkspace.UpdateScrollBars;
  end;

{$IFDEF MSWINDOWS}
      Application.ProcessMessages;
{$ELSE}
      Application.DoIdle(bIDLE);
{$ENDIF}
end;

procedure TfrxPreview.InternalOnProgressStop(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  if FRefreshing then Exit;

  FRunning := False;
  UpdatePageNumbers;
  FWorkspace.UpdateScrollBars;
  FThumbnail.UpdateScrollBars;
  UpdatePages;
  UpdateOutline;
  if Owner is TfrxPreviewForm then
  begin
    TfrxPreviewForm(Owner).CancelB.Text := frxResources.Get('clClose');
    TfrxPreviewForm(Owner).Panel1.Text := '';
    TfrxPreviewForm(Owner).UpdateControls;
  end;
end;

procedure TfrxPreview.OnCancel(Sender: TObject);
begin
  Report.Terminated := True;
end;

procedure TfrxPreview.Cancel;
begin
  if FRunning then
    OnCancel(Self);
end;

procedure TfrxPreview.MouseWheelScroll(Delta: Integer; Horz: Boolean = False;
  Zoom: Boolean = False);
begin
  //disable in sesign time, may cause AV
  if csDesigning in ComponentState then Exit;
  if Delta <> 0 then
    if Zoom then
    begin
      FZoom := FZoom + Round(Delta / Abs(Delta)) / 10;
      if FZoom < 0.3 then
        FZoom := 0.3;
      SetZoom(FZoom);
    end
    else
    begin
      with FWorkspace do
      begin
        if Horz then
          HorzPosition := HorzPosition + Round(-Delta / Abs(Delta)) * 20
        else
          VertPosition := VertPosition + Round(-Delta / Abs(Delta)) * 20;
      end;
    end;
end;


{ TfrxPreviewForm }

procedure TfrxPreviewForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(100);
  frxResources.LoadImageFromResouce(PrintB.Bitmap, 19, 5);
  PrintMI.Bitmap.Assign(PrintB.Bitmap);
  PrintMI.Text := frxGet(102);
  PrintB.Hint := frxGet(102);
  OpenB.Hint := frxGet(104);
  frxResources.LoadImageFromResouce(OpenB.Bitmap, 0, 1);
  OpenMI.Bitmap.Assign(OpenB.Bitmap);
  OpenMI.Text := frxGet(104);
  SaveB.Hint := frxGet(106);
  frxResources.LoadImageFromResouce(SaveB.Bitmap, 0, 2);
  SaveMI.Bitmap.Assign(SaveB.Bitmap);
  SaveMI.Text := frxGet(106);
  ExportB.Hint := frxGet(108);
  frxResources.LoadImageFromResouce(ExportB.Bitmap, 17, 9);
  ExportMI.Bitmap.Assign(ExportB.Bitmap);
  ExportMI.Text := frxGet(108);
  FindMI.Text := frxGet(110);


  PageSettingsB.Hint := frxGet(121);
  frxResources.LoadImageFromResouce(PageSettingsB.Bitmap, 19, 4);
  DesignerB.Hint := frxGet(133);
  frxResources.LoadImageFromResouce(DesignerB.Bitmap, 19, 8);
  {$IFDEF FR_LITE}
    DesignerB.Hint := DesignerB.Hint + #13#10 + 'This feature is not available in FreeReport';
  {$ENDIF}
  FirstB.Hint := frxGet(135);
  frxResources.LoadImageFromResouce(FirstB.Bitmap, 18, 5);
  PriorB.Hint := frxGet(137);
  frxResources.LoadImageFromResouce(PriorB.Bitmap, 18, 6);
  NextB.Hint := frxGet(139);
  frxResources.LoadImageFromResouce(NextB.Bitmap, 18, 7);
  LastB.Hint := frxGet(141);
  frxResources.LoadImageFromResouce(LastB.Bitmap, 18, 8);
  CancelB.Text := frxResources.Get('clClose');
  FullScreenBtn.Hint := frxGet(150);
  frxResources.LoadImageFromResouce(FullScreenBtn.Bitmap, 19, 9);
  FullScrMI.Bitmap.Assign(FullScreenBtn.Bitmap);
  FullScrMI.Text := frxGet(150);
  ExportPDFMI.Text := frxGet(151);
  ExportMailMI.Text := frxGet(152);
  //ZoomPlusB.Hint := frxGet(125);
  ZoomInMI.Text := frxGet(125);
  //ZoomMinusB.Hint := frxGet(127);
  ZoomOutMI.Text := frxGet(127);
  OutlineB.Hint := frxGet(129);
  frxResources.LoadImageFromResouce(OutlineB.Bitmap, 19, 6);
  ThumbB.Hint := frxGet(131);
  frxResources.LoadImageFromResouce(ThumbB.Bitmap, 7, 8);
  frxResources.LoadImageFromResouce(PageWidthB.Bitmap, 23, 5);
  frxResources.LoadImageFromResouce(WholePageB.Bitmap, 23, 6);

//  ZoomCB.Min := 25;
//  ZoomCB.Max := 500;
//  ZoomCB.Frequency := 25;
  ZoomCB.Clear;
  ZoomCB.Items.Add('25%');
  ZoomCB.Items.Add('50%');
  ZoomCB.Items.Add('75%');
  ZoomCB.Items.Add('100%');
  ZoomCB.Items.Add('150%');
  ZoomCB.Items.Add('200%');
  ZoomCB.Items.Add('300%');

  PageWidthB.Hint := frxResources.Get('zmPageWidth');
  WholePageB.Hint := frxResources.Get('zmWholePage');
  ExpandMI.Text := frxGet(600);
  CollapseMI.Text := frxGet(601);

  FPreview := TfrxPreview.Create(Self);
  FPreview.Parent := Self;
  FPreview.Align := alClient;
  FPreview.OnPageChanged := OnPageChanged;
  FPreview.OnDblClick := OnPreviewDblClick;
  FPreview.SetFocus;
//  FPreview.OnMouseUp := FormMouseUp;
  FPreview.FWorkspace.OnMouseUp  := FormMouseUp;
  FFullScreen := False;
  FPDFExport := nil;
  FEmailExport := nil;
end;

procedure TfrxPreviewForm.Init;
var
  i, j, k: Integer;
  m, m2, e: TMenuItem;

  procedure RemoveInvisibleButtons;
  var
    i, j: Integer;
    c, c1: TControl;
  begin
    for i := 0 to ToolBar.ChildrenCount - 1 do
    begin
      c := TControl(ToolBar.Children[i]);
      if not c.Visible then
        for j := 0 to ToolBar.ChildrenCount - 1 do
        begin
          c1 := TControl(ToolBar.Children[j]);
          if(c1.Position.X > c.Position.X + c.Width ) then
            c1.Position.X := c1.Position.X - c.Width - 1;
        end;
    end;
  end;

begin
  FPreview.Init;
  HintPanel.BringToFront;
  with Report.PreviewOptions do
  begin
    if Maximized then
      WindowState := wsMaximized;
    FPreview.Zoom := Zoom;
    FPreview.ZoomMode := ZoomMode;

    {$IFDEF FR_LITE}
      DesignerB.Enabled := False;
    {$ELSE}
      DesignerB.Enabled := AllowEdit;
    {$ENDIF}
    Preview.Workspace.RTLLanguage := RTLPreview;
    PrintB.Visible := pbPrint in Buttons;
    OpenB.Visible := pbLoad in Buttons;
    SaveB.Visible := pbSave in Buttons;
    ExportB.Visible := pbExport in Buttons;

    PageWidthB.Visible := pbZoom in Buttons;
    WholePageB.Visible := pbZoom in Buttons;
    FullScreenBtn.Visible := pbFullScreen in Buttons;
    OutlineB.Visible := pbOutline in Buttons;
    ThumbB.Visible := pbThumbnails in Buttons;
    PageSettingsB.Visible := pbPageSetup in Buttons;
    DesignerB.Visible := pbEdit in Buttons;
    FirstB.Visible := pbNavigator in Buttons;
    PriorB.Visible := pbNavigator in Buttons;
    NextB.Visible := pbNavigator in Buttons;
    PageE.Visible := pbNavigator in Buttons;
    LastB.Visible := pbNavigator in Buttons;
    CancelB.Visible := pbClose in Buttons;
    ZoomCB.Visible := pbZoom in Buttons;
    Line1.Visible := ZoomCB.Visible or PageWidthB.Visible or WholePageB.Visible or FullScreenBtn.Visible;
    Line2.Visible := OutlineB.Visible or ThumbB.Visible or PageSettingsB.Visible or DesignerB.Visible;
    Line3.Visible := FirstB.Visible or PriorB.Visible or PageE.Visible or NextB.Visible or LastB.Visible or CancelB.Visible;
    RemoveInvisibleButtons;

{    ShiftControls([PrintB, OpenB, SaveB, ExportB, 
      Line1, ZoomCB, PageWidthB, WholePageB, FullScreenBtn, 
      Line2, OutlineB, ThumbB, PageSettingsB, DesignerB,
      Line3, FirstB, PriorB, PageE, NextB, LastB, CancelB], 0);}

  end;

  if (frxExportFilters.Count = 0) or
     ((frxExportFilters.Count = 1) and (frxExportFilters[0].Filter = frxDotMatrixExport)) then
    ExportB.Visible := False;

  for i := 0 to frxExportFilters.Count - 1 do
  begin
    if frxExportFilters[i].Filter = frxDotMatrixExport then
      continue;

    m := TMenuItem.Create(ExportMI);
    m2 := TMenuItem.Create(ExportPopup);

    m.Text := TfrxCustomExportFilter(frxExportFilters[i].Filter).GetDescription + '...';
    m2.Text := TfrxCustomExportFilter(frxExportFilters[i].Filter).GetDescription + '...';
    m.Tag := i;
    m2.Tag := i;
    m.OnClick := ExportMIClick;
    m2.OnClick := ExportMIClick;
	if TfrxCustomExportFilter(frxExportFilters[i].Filter).ClassName = 'TfrxPDFExport' then
    begin
      FPDFExport := TfrxCustomExportFilter(frxExportFilters[i].Filter);
      //PdfB.Visible := pbExportQuick in Report.PreviewOptions.Buttons;
    end;
    ExportMI.AddObject(m);
    ExportPopup.AddObject(m2);
  end;
  FPopUpMItemsCount := RightMenu.ChildrenCount;
  FPopUpExporttemsCount := ExportPopup.ChildrenCount;
  if Report.ReportOptions.Name <> '' then
    Caption := Report.ReportOptions.Name;

  k := 0;

  UpdateControls;
end;

procedure TfrxPreviewForm.UpdateControls;

  function HasDrillDown: Boolean;
  var
    l: TList;
    i: Integer;
    c: TfrxComponent;
  begin
    Result := False;
    l := Report.AllObjects;
    for i := 0 to l.Count - 1 do
    begin
      c := l[i];
      if (c is TfrxGroupHeader) and TfrxGroupHeader(c).DrillDown then
      begin
        Result := True;
        break;
      end;
    end;
  end;

  procedure EnableControls(cAr: array of TObject; Enabled: Boolean);
  var
    i: Integer;
  begin
    for i := 0 to High(cAr) do
    begin
      if cAr[i] is TMenuItem then
        TMenuItem(cAr[i]).Visible := Enabled
      else if cAr[i] is TfrxToolButton then
      begin
        TfrxToolButton(cAr[i]).Enabled := Enabled;
        TfrxToolButton(cAr[i]).Down := False;
        if TfrxToolButton(cAr[i]).Tag <> 0 then
          TMenuItem(TfrxToolButton(cAr[i]).Tag).Enabled := Enabled;
      end;
    end;
  end;

begin
  EnableControls([PrintB, OpenB, SaveB, ExportB, PageSettingsB],
    (not FPreview.FRunning) and (FPreview.PageCount > 0));
  EnableControls([OpenB], (not FPreview.FRunning));
  EnableControls([DesignerB],
    not FPreview.FRunning and Report.PreviewOptions.AllowEdit);
  EnableControls([ExpandMI, CollapseMI, N1],
    not FPreview.FRunning and HasDrillDown);
end;

procedure TfrxPreviewForm.PrintBClick(Sender: TObject);
begin
  FPreview.Print;
end;

procedure TfrxPreviewForm.PrintBMouseEnter(Sender: TObject);
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
    HintPanel.Position.Y := p.Top - HintPanel.Height/2 + TControl(Sender).Height/2;
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

procedure TfrxPreviewForm.PrintBMouseLeave(Sender: TObject);
begin
  HintPanel.Visible := False;
end;

procedure TfrxPreviewForm.OpenBClick(Sender: TObject);
begin
  FPreview.LoadFromFile;
  if Report.ReportOptions.Name <> '' then
    Caption := Report.ReportOptions.Name
  else
    Caption := frxGet(100);
{$IFDEF FRVIEWER}
	UpdateControls;
{$ENDIF}
end;

procedure TfrxPreviewForm.SaveBClick(Sender: TObject);
begin
  FPreview.SaveToFile;
end;

procedure TfrxPreviewForm.ZoomPlusBClick(Sender: TObject);
begin
  FPreview.Zoom := FPreview.Zoom + 0.25;
end;

procedure TfrxPreviewForm.ZoomMinusBClick(Sender: TObject);
begin
  FPreview.Zoom := FPreview.Zoom - 0.25;
end;

function TfrxPreviewForm.GetReport: TfrxReport;
begin
  Result := Preview.Report;
end;

procedure TfrxPreviewForm.UpdateZoom;
begin
  ZoomCB.Text := IntToStr(Round(FPreview.Zoom * 100)) + '%';
end;

procedure TfrxPreviewForm.WholePageBClick(Sender: TObject);
begin
  FPreview.ZoomMode := zmWholePage
end;

procedure TfrxPreviewForm.ZoomCBChange(Sender: TObject);

begin
  if FPreview = nil then Exit;

  FPreview.SetFocus;
  //FPreview.Zoom := ZoomCB.Value / 100;
end;

procedure TfrxPreviewForm.ZoomCBClick(Sender: TObject);
var
  s: String;
begin
{ Note: TComboTrakBar causes errors in XE3 under OSX. Was removed }
  if FPreview = nil then Exit;
  s := ZoomCB.Text;
  if Pos('%', s) <> 0 then
    s[Pos('%', s)] := ' ';
  while Pos(' ', s) <> 0 do
    Delete(s, Pos(' ', s), 1);

  if s <> '' then
    FPreview.Zoom := frxStrToFloat(s) / 100;
end;

procedure TfrxPreviewForm.FormKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkESCAPE then
    CancelBClick(Self);
  if Key = vkF11 then
    SwitchToFullScreen;
  if Key = vkF1 then
    frxResources.Help(Self);
  if Key = vkReturn then
  begin
    if ActiveControl = PageE then
      PageEClick(nil);
  end;
end;

procedure TfrxPreviewForm.PageSettingsBClick(Sender: TObject);
begin
  FPreview.PageSetupDlg;
end;

procedure TfrxPreviewForm.PageWidthBClick(Sender: TObject);
begin
  FPreview.ZoomMode := zmPageWidth;
end;

procedure TfrxPreviewForm.OnPageChanged(Sender: TfrxPreview; PageNo: Integer);
var
  FirstPass: Boolean;
begin
  FirstPass := False;
  if FPreview.PreviewPages <> nil then
    FirstPass := not FPreview.PreviewPages.Engine.FinalPass;

  if FirstPass and FPreview.FRunning then
    Panel0.Text := frxResources.Get('clFirstPass') + ' ' +
      IntToStr(FPreview.PageCount)
  else
    Panel0.Text := Format(frxResources.Get('clPageOf'),
      [PageNo, FPreview.PageCount]);
  Panel0.Repaint;
  PageE.Text := IntToStr(PageNo);
end;

procedure TfrxPreviewForm.PageEClick(Sender: TObject);
begin
  FPreview.PageNo := StrToInt(PageE.Text);
  FPreview.SetFocus;
end;

procedure TfrxPreviewForm.FirstBClick(Sender: TObject);
begin
  FPreview.First;
end;

procedure TfrxPreviewForm.PriorBClick(Sender: TObject);
begin
  FPreview.Prior;
end;

procedure TfrxPreviewForm.NextBClick(Sender: TObject);
begin
  FPreview.Next;
end;

procedure TfrxPreviewForm.LastBClick(Sender: TObject);
begin
  FPreview.Last;
end;

procedure TfrxPreviewForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  p: TpointF;
begin
  p := ClientToScreen(PointF(X, Y));
  if Button = TMouseButton.mbRight then
  begin
    { pop up menu never remove itself when clicking right mouse button }
    { and create another instance of the menu }
    { if menu has all Children items, then it's hiden and we can show it again }
    if RightMenu.ChildrenCount = FPopUpMItemsCount then
      RightMenu.Popup(p.X, p.Y);
  end;
end;

procedure TfrxPreviewForm.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; var Handled: Boolean);
begin
  FPreview.MouseWheelScroll(WheelDelta, False, ssCtrl in Shift);
end;

procedure TfrxPreviewForm.DesignerBClick(Sender: TObject);
begin
  FPreview.Edit;
end;

procedure TfrxPreviewForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := not FPreview.FRunning;
end;

procedure TfrxPreviewForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FFreeOnClose then
    Action := TCloseAction.caFree;
  if (Report <> nil) and (Assigned(Report.OnClosePreview)) then
    Report.OnClosePreview(Self);
end;

procedure TfrxPreviewForm.NewPageBClick(Sender: TObject);
begin
  FPreview.AddPage;
end;

procedure TfrxPreviewForm.DelPageBClick(Sender: TObject);
begin
  FPreview.DeletePage;
end;

procedure TfrxPreviewForm.CancelBClick(Sender: TObject);
begin
  if FPreview.FRunning then
    FPreview.Cancel else
    Close;
end;

procedure TfrxPreviewForm.ExportBClick(Sender: TObject);
var
  p: TpointF;
begin
  p := ClientToScreen(ExportB.Position.Point);
  if ExportPopup.ChildrenCount = FPopUpExporttemsCount then
    ExportPopup.Popup(p.X, p.Y);
end;

procedure TfrxPreviewForm.ExportMIClick(Sender: TObject);
begin
  FPreview.Export(TfrxCustomExportFilter(frxExportFilters[TMenuItem(Sender).Tag].Filter));
end;

procedure TfrxPreviewForm.DesignerBMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt: TPoint;
begin
// todo
{  pt := DesignerB.ClientToScreen(Point(0, 0));
  if Button = mbRight then
    HiddenMenu.Popup(pt.X, pt.Y);}
end;

procedure TfrxPreviewForm.Showtemplate1Click(Sender: TObject);
begin
  FPreview.EditTemplate;
end;

procedure TfrxPreviewForm.SetMessageText(const Value: String; IsHint: Boolean);
begin
  if IsHint then
  begin
    if not ((Value = '') and (Panel2.Text = '')) then
      Panel2.Text := Value;
  end
  else
    Panel1.Text := Value;
  //Application.HandleMessage;
  Report.AppHandleMessage;
end;

procedure TfrxPreviewForm.SwitchToFullScreen;
begin
  if not FFullScreen then
  begin
    StatusBar.Visible := False;
    ToolBar.Visible := False;
    FOldState := WindowState;
    WindowState := wsMaximized;
    FFullScreen := True;
  end
  else
  begin
    WindowState := FOldState;
    FFullScreen := False;
    StatusBar.Visible := True;
    ToolBar.Visible := True;
  end;
end;

procedure TfrxPreviewForm.FullScreenBtnClick(Sender: TObject);
begin
  SwitchToFullScreen;
end;

procedure TfrxPreviewForm.PdfBClick(Sender: TObject);
begin
  if Assigned(FPDFExport) then
    FPreview.Export(FPDFExport);
end;

procedure TfrxPreviewForm.EmailBClick(Sender: TObject);
begin
  if Assigned(FEmailExport) then
    FPreview.Export(FEmailExport);
end;

procedure TfrxPreviewForm.OutlineBClick(Sender: TObject);
begin
  FPreview.OutlineVisible := not FPreview.OutlineVisible;//OutlineB.Down;
end;

procedure TfrxPreviewForm.ThumbBClick(Sender: TObject);
begin
  FPreview.ThumbnailVisible := not FPreview.ThumbnailVisible;//ThumbB.Down;
end;

procedure TfrxPreviewForm.OnPreviewDblClick(Sender: TObject);
begin
  if FFullScreen then
    SwitchToFullScreen;
end;

procedure TfrxPreviewForm.CollapseAllClick(Sender: TObject);
var
  l: TList;
  i: Integer;
  c: TfrxComponent;
begin
  FPreview.Lock;
  l := Report.AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if (c is TfrxGroupHeader) and TfrxGroupHeader(c).DrillDown then
      TfrxGroupHeader(c).ExpandDrillDown := False;
  end;
  Report.DrillState.Clear;
  Preview.RefreshReport;
  Preview.SetPosition(0,0);
end;

procedure TfrxPreviewForm.ExpandAllClick(Sender: TObject);
var
  l: TList;
  i: Integer;
  c: TfrxComponent;
begin
  FPreview.Lock;
  l := Report.AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if (c is TfrxGroupHeader) and TfrxGroupHeader(c).DrillDown then
      TfrxGroupHeader(c).ExpandDrillDown := True;
  end;
  Report.DrillState.Clear;
  Preview.RefreshReport;
end;

initialization
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TfrxPreview, TFmxObject);
  GroupDescendentsWith(TfrxPreviewWorkspace, TFmxObject);
  RegisterFmxClasses([TfrxPreviewWorkspace, TfrxPreview]);
end.



//56db3b0f55102b9488a240d37950543f