
{******************************************}
{                                          }
{             FastReport v4.0              }
{              Cross editor                }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxCrossEditor;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, System.UIConsts, System.Types, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.Types, FMX.Objects, FMX.Edit, FMX.ListBox, FMX.Layouts, FMX.Menus, FMX.ExtCtrls,
  FMX.frxCross, FMX.frxClass, FMX.frxCtrls, FMX.frxCustomEditors, System.Variants,
  FMX.frxFMX
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};

type
  TfrxCrossEditor = class(TfrxViewEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
  end;

  TfrxCrossEditorForm = class(TForm)
    FuncPopup: TPopupMenu;
    SortPopup: TPopupMenu;
    DatasetL: TGroupBox;
    DatasetCB: TComboBox;
    FieldsLB: TfrxListBox;
    DimensionsL: TGroupBox;
    RowsL: TLabel;
    RowsE: TEdit;
    ColumnsL: TLabel;
    ColumnsE: TEdit;
    CellsL: TLabel;
    CellsE: TEdit;
    StructureL: TGroupBox;
    Shape1: TLine;
    Shape2: TLine;
    SwapB: TSpeedButton;
    RowsLB: TfrxListBox;
    ColumnsLB: TfrxListBox;
    CellsLB: TfrxListBox;
    OptionsL: TGroupBox;
    RowHeaderCB: TCheckBox;
    ColumnHeaderCB: TCheckBox;
    RowTotalCB: TCheckBox;
    ColumnTotalCB: TCheckBox;
    TitleCB: TCheckBox;
    CornerCB: TCheckBox;
    AutoSizeCB: TCheckBox;
    BorderCB: TCheckBox;
    DownAcrossCB: TCheckBox;
    PlainCB: TCheckBox;
    JoinCB: TCheckBox;
    Box: TScrollBox;
    PaintBox: TPaintBox;
    OkB: TButton;
    CancelB: TButton;
    RepeatCB: TCheckBox;
    StylePopup: TPopupMenu;
    Sep1: TMenuItem;
    SaveStyleMI: TMenuItem;
    ToolBar: TToolBar;
    StyleB: TfrxToolButton;
    procedure FormCreate(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure OkBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DatasetCBClick(Sender: TObject);
//    procedure DatasetCBDrawItem(Control: TWinControl; Index: Integer;
//      ARect: TRect; State: TOwnerDrawState);
//    procedure FieldsLBDrawItem(Control: TWinControl; Index: Integer;
//      ARect: TRect; State: TOwnerDrawState);
//    procedure LBDrawItem(Control: TWinControl; Index: Integer;
//      ARect: TRect; State: TOwnerDrawState);
//    procedure CellsLBDrawItem(Control: TWinControl; Index: Integer;
//      ARect: TRect; State: TOwnerDrawState);
    procedure LBDragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF});
    procedure LBDragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
    procedure LBMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LBClick(Sender: TObject);
    procedure CBClick(Sender: TObject);
    procedure FuncMIClick(Sender: TObject);
    procedure SortMIClick(Sender: TObject);
    procedure SwapBClick(Sender: TObject);
    procedure DimensionsChange(Sender: TObject);
    procedure LBDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure PaintBoxPaint(Sender: TObject; Canvas: TCanvas);
    procedure SaveStyleMIClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RowsLBDragEnter(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
    procedure RowsLBDragLeave(Sender: TObject);
    procedure StyleBClick(Sender: TObject);
  private
    FCross: TfrxCustomCrossView;
    FCurList: TfrxListBox;
    FSortMenuList: TList;
    FFuncMenuList: TList;
    FFuncNames: array[TfrxCrossFunction] of String;
    FImages: TfrxImageList;
    FSortNames: array[TfrxCrossSortOrder] of String;
    FStyleSheet: TfrxStyleSheet;
    FTempCross: TfrxDBCrossView;
    FUpdating: Boolean;
    FItemAdded: Boolean;
    procedure ReflectChanges(ChangesFrom: TObject; UpdateText: Boolean = True);
    procedure CreateStyleMenu;
    procedure StyleClick(Sender: TObject);
    procedure UpdateCheckBoxes(aListBox: TfrxListBox);
    procedure LBButtonClick(Sender: TObject; aButton: TObject; aItem: TfrxListBoxItem);
    procedure LBCheckChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Cross: TfrxCustomCrossView read FCross write FCross;
  end;


implementation

{$R *.FMX}

uses
  FMX.frxDsgnIntf, FMX.frxEditFormat, FMX.frxEditHighlight, FMX.frxEditMemo,
  FMX.frxEditFrame, FMX.frxDesgnCtrls, FMX.frxRes, FMX.frxUtils, FMX.frxXML;

const
  CrossStyles =
'<?xml version="1.0" encoding="utf-8" standalone="no"?>' +
'<stylesheet>' +
  '<style Name="White">' +
    '<item Name="cellheader" Color="-1" Font.Color="-16777216" Font.Style="0" Frame.Typ="15"/>' +
    '<item Name="cell" Color="-1" Font.Color="-16777216" Font.Style="0" Frame.Typ="15"/>' +
    '<item Name="column" Color="-1" Font.Color="-16777216" Font.Style="0" Frame.Typ="15"/>' +
    '<item Name="colgrand" Color="-1" Font.Color="-16777216" Font.Style="1" Frame.Typ="15"/>' +
    '<item Name="coltotal" Color="-1" Font.Color="-16777216" Font.Style="1" Frame.Typ="15"/>' +
    '<item Name="row" Color="-1" Font.Color="-16777216" Font.Style="0" Frame.Typ="15"/>' +
    '<item Name="rowgrand" Color="-1" Font.Color="-16777216" Font.Style="1" Frame.Typ="15"/>' +
    '<item Name="rowtotal" Color="-1" Font.Color="-16777216" Font.Style="1" Frame.Typ="15"/>' +
    '<item Name="corner" Color="-1" Font.Color="-16777216" Font.Style="0" Frame.Typ="15"/>' +
  '</style>' +
  '<style Name="Gray">' +
    '<item Name="cellheader" Color="-2565928" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="cell" Color="-986896" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="column" Color="-2565928" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="colgrand" Color="-2565928" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="coltotal" Color="-2565928" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="row" Color="-2565928" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowgrand" Color="-2565928" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowtotal" Color="-2565928" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="corner" Color="-2565928" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
  '</style>' +
  '<style Name="Orange">' +
    '<item Name="cellheader" Color="-9658" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="cell" Color="-5221" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="column" Color="-9658" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="colgrand" Color="-9658" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="coltotal" Color="-9658" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="row" Color="-9658" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowgrand" Color="-9658" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowtotal" Color="-9658" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="corner" Color="-9658" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
  '</style>' +
  '<style Name="Green">' +
    '<item Name="cellheader" Color="-8674304" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="cell" Color="-6368768" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="column" Color="-8674304" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="colgrand" Color="-8674304" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="coltotal" Color="-8674304" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="row" Color="-8674304" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowgrand" Color="-8674304" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowtotal" Color="-8674304" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="corner" Color="-8674304" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
  '</style>' +
  '<style Name="Green and Orange">' +
    '<item Name="cellheader" Color="-6763520" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="cell" Color="-13312" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="column" Color="-6763520" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="colgrand" Color="-6763520" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="coltotal" Color="-6763520" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="row" Color="-6763520" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowgrand" Color="-6763520" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowtotal" Color="-6763520" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="corner" Color="-6763520" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
  '</style>' +
  '<style Name="Blue">' +
    '<item Name="cellheader" Color="-6832643" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="cell" Color="-4533250" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="column" Color="-6832643" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="colgrand" Color="-6832643" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="coltotal" Color="-6832643" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="row" Color="-6832643" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowgrand" Color="-6832643" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowtotal" Color="-6832643" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="corner" Color="-6832643" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
  '</style>' +
  '<style Name="Blue and White">' +
    '<item Name="cellheader" Color="-6832643" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="cell" Color="-1" Font.Color="-16777216" Font.Style="0" Frame.Color="-2565928" Frame.Typ="15"/>' +
    '<item Name="column" Color="-6832643" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="colgrand" Color="-6832643" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="coltotal" Color="-6832643" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="row" Color="-6832643" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowgrand" Color="-6832643" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowtotal" Color="-6832643" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="corner" Color="-6832643" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
  '</style>' +
  '<style Name="Gray and Orange">' +
    '<item Name="cellheader" Color="-8355712" Font.Color="-1" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="cell" Color="-13312" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="column" Color="-8355712" Font.Color="-1" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="coltotal" Color="-8355712" Font.Color="-1" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="colgrand" Color="-8355712" Font.Color="-1" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="row" Color="-8355712" Font.Color="-1" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowtotal" Color="-8355712" Font.Color="-1" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowgrand" Color="-8355712" Font.Color="-1" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="corner" Color="-8355712" Font.Color="-1" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
  '</style>' +
  '<style Name="Blue and Orange">' +
    '<item Name="cellheader" Color="-6832643" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="cell" Color="-12438" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="column" Color="-6832643" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="colgrand" Color="-6832643" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="coltotal" Color="-6832643" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="row" Color="-6832643" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowgrand" Color="-6832643" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowtotal" Color="-6832643" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="corner" Color="-6832643" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
  '</style>' +
  '<style Name="Orange and White">' +
    '<item Name="cellheader" Color="-12438" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="cell" Color="-1" Font.Color="-16777216" Font.Style="0" Frame.Color="-2565928" Frame.Typ="15"/>' +
    '<item Name="column" Color="-12438" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="colgrand" Color="-12438" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="coltotal" Color="-12438" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="row" Color="-12438" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowgrand" Color="-12438" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="rowtotal" Color="-12438" Font.Color="-16777216" Font.Style="1" Frame.Color="-1" Frame.Typ="15"/>' +
    '<item Name="corner" Color="-12438" Font.Color="-16777216" Font.Style="0" Frame.Color="-1" Frame.Typ="15"/>' +
  '</style>' +
'</stylesheet>';

type
  THackControl = class(TControl);
  THackListBoxItem = class(TfrxListBoxItem);


{ TfrxCrossEditor }

function TfrxCrossEditor.Edit: Boolean;
begin
  with TfrxCrossEditorForm.Create(Designer) do
  begin
    Cross := TfrxCustomCrossView(Component);
    FormShow(Self);
    Result := ShowModal = mrOk;
    Free;
  end;
end;

function TfrxCrossEditor.HasEditor: Boolean;
begin
  Result := True;
end;


{ TfrxCrossEditorForm }


constructor TfrxCrossEditorForm.Create(AOwner: TComponent);
var
  TempStream: TStringStream;
begin
  inherited;
  FSortMenuList := TList.Create;
  FFuncMenuList := TList.Create;
  FStyleSheet := TfrxStyleSheet.Create;
  if FileExists(ExtractFilePath(ParamStr(0)) + 'crossstyles.xml') then
    FStyleSheet.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'crossstyles.xml')
  else
  begin
    TempStream := TStringStream.Create(CrossStyles, TEncoding.UTF8);
    FStyleSheet.LoadFromStream(TempStream);
    TempStream.Free;
  end;

  FImages := TfrxImageList.Create(nil);
  FTempCross := TfrxDBCrossView.Create(nil);
  FFuncNames[cfNone] := frxResources.Get('crNone');
  FFuncNames[cfSum] := frxResources.Get('crSum');
  FFuncNames[cfMin] := frxResources.Get('crMin');
  FFuncNames[cfMax] := frxResources.Get('crMax');
  FFuncNames[cfAvg] := frxResources.Get('crAvg');
  FFuncNames[cfCount] := frxResources.Get('crCount');
  FSortNames[soAscending] := frxResources.Get('crAsc');
  FSortNames[soDescending] := frxResources.Get('crDesc');
  FSortNames[soNone] := frxResources.Get('crNone');
  FSortNames[soGrouping] := frxResources.Get('crGroup');
end;

destructor TfrxCrossEditorForm.Destroy;
begin
  FImages.Free;
  FStyleSheet.Free;
  FTempCross.Free;
  FSortMenuList.Free;
  FFuncMenuList.Free;
  inherited;
end;

procedure TfrxCrossEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
    FCross.Assign(FTempCross);
end;

procedure TfrxCrossEditorForm.FormCreate(Sender: TObject);
var
  i: Integer;
  m: TMenuItem;
begin
	CellsLB.ShowCheckboxes := False;
  CellsLB.ShowButtons := True;
  RowsLB.ShowCheckboxes := True;
  RowsLB.ShowButtons := True;
  ColumnsLB.ShowCheckboxes := True;
  ColumnsLB.ShowButtons := True;

{$IFDEF DELPHI18}
	ColumnsLB.DragMode := TDragMode.dmManual;
  RowsLB.DragMode := TDragMode.dmManual;
  CellsLB.DragMode := TDragMode.dmManual;
  FieldsLB.DragMode := TDragMode.dmManual;

	CellsLB.ManualDragAndDrop := True;
	RowsLB.ManualDragAndDrop := True;
	ColumnsLB.ManualDragAndDrop := True;
	FieldsLB.ManualDragAndDrop := True;
{$ENDIF}
  // compatibility XE2- XE6
  for i := 0 to 3 do
  begin
    m := TMenuItem.Create(SortPopup);
    case i of
      0: m.Text := frxGet(4328);
      1: m.Text := frxGet(4329);
      2: m.Text := frxGet(4330);
      3: m.Text := frxGet(4331);
     end;
      m.OnClick := SortMIClick;
      m.Tag := i;
      SortPopup.AddObject(m);
      FSortMenuList.Add(Pointer(m));
  end;

  for i := 0 to 5 do
  begin
    m := TMenuItem.Create(FuncPopup);
    case i of
      0: m.Text := frxGet(4322);
      1: m.Text := frxGet(4323);
      2: m.Text := frxGet(4324);
      3: m.Text := frxGet(4325);
      4: m.Text := frxGet(4326);
      5: m.Text := frxGet(4327);
     end;
      m.OnClick := FuncMIClick;
      m.Tag := i;
      FuncPopup.AddObject(m);
      FFuncMenuList.Add(Pointer(m));
  end;

  Caption := frxGet(4300);
  DatasetL.Text := frxGet(4301);
  DimensionsL.Text := frxGet(4302);
  RowsL.Text := frxGet(4303);
  ColumnsL.Text := frxGet(4304);
  CellsL.Text := frxGet(4305);
  StructureL.Text := frxGet(4306);
  RowHeaderCB.Text := frxGet(4307);
  ColumnHeaderCB.Text := frxGet(4308);
  RowTotalCB.Text := frxGet(4309);
  ColumnTotalCB.Text := frxGet(4310);
  //SwapB.Hint := frxGet(4311);


  TitleCB.Text := frxGet(4314);
  CornerCB.Text := frxGet(4315);
  AutoSizeCB.Text := frxGet(4317);
  BorderCB.Text := frxGet(4318);
  DownAcrossCB.Text := frxGet(4319);
  RepeatCB.Text := frxGet(4316);
  PlainCB.Text := frxGet(4320);
  JoinCB.Text := frxGet(4321);
  StyleB.Text := frxGet(4312);
  StyleB.OnClick := StyleBClick;
  SaveStyleMI.Text := frxGet(4313);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  FItemAdded := False;
  CreateStyleMenu;

  CellsLB.CheckBoxText := frxResources.Get('crSubtotal');
  RowsLB.CheckBoxText := frxResources.Get('crSubtotal');
  ColumnsLB.CheckBoxText := frxResources.Get('crSubtotal');

  CellsLB.ButtonText := 'Func';
  CellsLB.OnButtonClick := LBButtonClick;
  RowsLB.ButtonText := 'A-Z';
  RowsLB.OnButtonClick := LBButtonClick;
  RowsLB.OnChangeCheck := LBCheckChange;
  ColumnsLB.ButtonText := 'A-Z';
  ColumnsLB.OnButtonClick := LBButtonClick;
  ColumnsLB.OnChangeCheck := LBCheckChange;

end;

procedure TfrxCrossEditorForm.FormShow(Sender: TObject);

  procedure SelectDataset;
  begin
    DatasetCB.ItemIndex := DatasetCB.Items.IndexOfObject(FCross.DataSet);
    if DatasetCB.ItemIndex = -1 then
      DatasetCB.ItemIndex := 0;
    DatasetCBClick(nil);
  end;

  procedure SelectFields;
  var
    i: Integer;
    Item: TfrxListBoxItem;
  begin
    for i := 0 to FCross.RowFields.Count - 1 do
    begin
      Item := RowsLB.ListItems[RowsLB.Count - 1] as TfrxListBoxItem;
      if Item <> nil then
      begin
       Item.CheckVisible := True;
       Item.IsChecked := FCross.RowTotalMemos[THackListBoxItem(Item).Index + 1].Visible;
      end;
      RowsLB.Items.Add(FCross.RowFields[i]);
    end;

    for i := 0 to FCross.ColumnFields.Count - 1 do
    begin
       Item := ColumnsLB.ListItems[ColumnsLB.Count - 1] as TfrxListBoxItem;
       if Item <> nil then
       begin
        Item.CheckVisible := True;
        Item.IsChecked := FCross.ColumnTotalMemos[THackListBoxItem(Item).Index + 1].Visible;
       end;
      ColumnsLB.Items.Add(FCross.ColumnFields[i]);
    end;

    CellsLB.Items := FCross.CellFields;
  end;

begin
  FUpdating := True;
  FTempCross.Assign(FCross);
  FCross.Report.GetDataSetList(DatasetCB.Items);
  SelectDataset;
  SelectFields;



  if FCross is TfrxCrossView then
  begin
    
    SwapB.Visible := False;
    DimensionsL.Visible := True;
    RowsE.Text := IntToStr(FCross.RowLevels);
    ColumnsE.Text := IntToStr(FCross.ColumnLevels);
    CellsE.Text := IntToStr(FCross.CellLevels);
  end
  else
    DatasetL.Visible := True;

  TitleCB.IsChecked := FCross.ShowTitle;
  CornerCB.IsChecked := FCross.ShowCorner;
  ColumnHeaderCB.IsChecked := FCross.ShowColumnHeader;
  RowHeaderCB.IsChecked := FCross.ShowRowHeader;
  ColumnTotalCB.IsChecked := FCross.ShowColumnTotal;
  RowTotalCB.IsChecked := FCross.ShowRowTotal;

  AutoSizeCB.IsChecked := FCross.AutoSize;
  BorderCB.IsChecked := FCross.Border;
  DownAcrossCB.IsChecked := FCross.DownThenAcross;
  RepeatCB.IsChecked := FCross.RepeatHeaders;
  PlainCB.IsChecked := FCross.PlainCells;
  JoinCB.IsChecked := FCross.JoinEqualCells;

  StyleB.Visible := not FCross.DotMatrix;

  FUpdating := False;
end;


procedure TfrxCrossEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

procedure TfrxCrossEditorForm.CreateStyleMenu;
var
  i: Integer;
  sl: TStringList;
  m: TMenuItem;
  b: TBitmap;
  Style: TfrxStyles;
begin
  sl := TStringList.Create;
  FStyleSheet.GetList(sl);

  FImages.Clear;
  b := TBitmap.Create(16, 16);

  //frxResources.MainButtonImages.Draw(b.Canvas, 0, 0, 2);
  //FImages.Add(b, nil);

  { create thumbnail images for each style }
  for i := 0 to sl.Count - 1 do
  begin
    Style := FStyleSheet[i];
    with b.Canvas do
    begin
      Fill.Color := Style.Find('column').Color;
      if Fill.Color = claNull then
        Fill.Color := claWhite;
      FillRect(RectF(0, 0, 16, 8), 1, 1, AllCorners, 1, TCornerType.ctBevel);
      Fill.Color := Style.Find('cell').Color;
      if Fill.Color = claNull then
        Fill.Color := claWhite;
      FillRect(RectF(0, 8, 16, 16), 1, 1, AllCorners, 1, TCornerType.ctBevel);
      Stroke.Color := claSilver;
      Fill.Kind := TBrushKind.bkNone;
      DrawRect(RectF(0, 0, 16, 16), 1, 1, AllCorners, 1, TCornerType.ctBevel);
    end;
    //FImages.Add(b, nil);
  end;

  //while StylePopup.Items[0] <> Sep1 do
  //  StylePopup.Items[0].Free;

  for i := sl.Count - 1 downto 0 do
  begin
    m := TMenuItem.Create(StylePopup);
    m.Text := sl[i];
    //m.ImageIndex := i + 1;
    m.OnClick := StyleClick;
    StylePopup.AddObject(m);
    //StylePopup.Items.Insert(0, m);
  end;
  
  b.Free;
  sl.Free;
end;

procedure TfrxCrossEditorForm.ReflectChanges(ChangesFrom: TObject; UpdateText: Boolean);
var
  i, j: Integer;
  s: String;
begin
  if (DatasetCB.ItemIndex = -1) or (DatasetCB.Items.Count = 0) then
    FCross.DataSet := nil else
    FCross.DataSet := TfrxCustomDBDataSet(DatasetCB.Items.Objects[DatasetCB.ItemIndex]);
  if FCross is TfrxDBCrossView then
  begin
    FCross.RowFields := RowsLB.Items;
    FCross.ColumnFields := ColumnsLB.Items;
    FCross.CellFields := CellsLB.Items;
  end;
  FCross.RowLevels := FCross.RowFields.Count;
  FCross.ColumnLevels := FCross.ColumnFields.Count;
  FCross.CellLevels := FCross.CellFields.Count;

  if ChangesFrom = nil then // change all
  begin
    if FCross.CellLevels = 1 then
      if UpdateText then
        FCross.CornerMemos[0].Text := FCross.CellFields[0]
    else
    begin
      FCross.CornerMemos[0].Text := '';
      FCross.CornerMemos[2].Text := 'Data';
    end;

    if UpdateText then
      for i := 0 to FCross.RowLevels do
        for j := 0 to FCross.CellLevels - 1 do
          FCross.CellHeaderMemos[i * FCross.CellLevels + j].Text := FCross.CellFields[j];

    s := '';
    for i := 0 to FCross.ColumnLevels - 1 do
      s := s + FCross.ColumnFields[i] + ', ';
    if s <> '' then
      SetLength(s, Length(s) - 2);
    if UpdateText then
      FCross.CornerMemos[1].Text := s;

    if UpdateText then
      for i := 0 to FCross.RowLevels - 1 do
        FCross.CornerMemos[i + 3].Text := FCross.RowFields[i];
  end
  else if (ChangesFrom = RowsLB) or (ChangesFrom = RowsE) then
  begin
    if UpdateText then
      for i := 0 to FCross.RowLevels do
        for j := 0 to FCross.CellLevels - 1 do
          FCross.CellHeaderMemos[i * FCross.CellLevels + j].Text := FCross.CellFields[j];

    if UpdateText then
      for i := 0 to FCross.RowLevels - 1 do
        FCross.CornerMemos[i + 3].Text := FCross.RowFields[i];
  end
  else if (ChangesFrom = ColumnsLB) or (ChangesFrom = ColumnsE) then
  begin
    s := '';
    for i := 0 to FCross.ColumnLevels - 1 do
      s := s + FCross.ColumnFields[i] + ', ';
    if s <> '' then
      SetLength(s, Length(s) - 2);
    if UpdateText then
      FCross.CornerMemos[1].Text := s;
  end
  else if (ChangesFrom = CellsLB) or (ChangesFrom = CellsE) then
  begin
    if FCross.CellLevels = 1 then
      if UpdateText then
        FCross.CornerMemos[0].Text := FCross.CellFields[0]
    else
    begin
      FCross.CornerMemos[0].Text := '';
      FCross.CornerMemos[2].Text := 'Data';
    end;

    if UpdateText then
      for i := 0 to FCross.RowLevels do
        for j := 0 to FCross.CellLevels - 1 do
          FCross.CellHeaderMemos[i * FCross.CellLevels + j].Text := FCross.CellFields[j];
  end;
  PaintBox.InvalidateRect(PaintBox.BoundsRect);
//  PaintBoxPaint(nil, PaintBox.Canvas);
end;

procedure TfrxCrossEditorForm.RowsLBDragEnter(Sender: TObject;
  const Data: TDragObject; const Point: TPointF);
begin
  if (Data.Source is TfrxListBox) and (TfrxListBox(Sender).Count = 0) then
  begin
    FItemAdded := True;
    TfrxListBox(Sender).Items.Add('');// add fake item
  end;
  TfrxListBox(Sender).ItemIndex := 0;
end;

procedure TfrxCrossEditorForm.RowsLBDragLeave(Sender: TObject);
begin
   if FItemAdded then
   begin
     TfrxListBox(Sender).Items.Delete(0);
     FItemAdded := False;
   end;
end;

procedure TfrxCrossEditorForm.DatasetCBClick(Sender: TObject);
var
  ds: TfrxCustomDBDataSet;
  i: Integer;
begin
  if (DatasetCB.ItemIndex = -1) or (DatasetCB.Items.Count = 0) then Exit;
  ds := TfrxCustomDBDataSet(DatasetCB.Items.Objects[DatasetCB.ItemIndex]);
  ds.GetFieldList(FieldsLB.Items);
  RowsLB.Clear;
  ColumnsLB.Clear;
  CellsLB.Clear;
  if (Sender <> nil) and not FUpdating then
    ReflectChanges(nil);
end;

procedure TfrxCrossEditorForm.LBDragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF});
{$IFDEF DELPHI20}
var
  Accept: Boolean;
{$ENDIF}
begin
  Accept := (Data.Source is TfrxListBox) and (TfrxListBox(Data.Source).Items.Count > 0);
  if not Accept then
    Accept := (Data.Source is TListBoxItem);
{$IFDEF DELPHI20}
  if Accept then
	  Operation := TDragOperation.Copy;
{$ENDIF}
end;

procedure TfrxCrossEditorForm.UpdateCheckBoxes(aListBox: TfrxListBox);
var
  i: Integer;
  item2: TfrxListBoxItem;
begin
  FUpdating := True;
  if aListBox.ShowCheckboxes then
    for i := 0 to aListBox.Items.Count - 1 do
    begin
      item2 := aListBox.ListItems[i] as TfrxListBoxItem;
      if item2 <> nil then
      begin
        item2.CheckVisible := (aListBox.Items.Count - 1 <> i);
        if item2.CheckVisible then
          if aListBox = ColumnsLB then
            item2.IsChecked := FCross.ColumnTotalMemos[i].Visible
          else if aListBox = RowsLB then
            item2.IsChecked := FCross.RowTotalMemos[i].Visible;
      end;
  end;
  FUpdating := False;
end;

procedure TfrxCrossEditorForm.LBDragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
var
  s: String;
  i: Integer;
  item: TListBoxItem;
  SourceLB, SenderLB: TfrxListBox;
begin
  SourceLB := nil;
//there are two ways to drag an item select and drag list box or drag item
  if Data.Source is TfrxListBoxItem then
    SourceLB := TfrxListBox(THackListBoxItem(Data.Source).ListBox)
  else if Data.Source is TfrxListBox then
    SourceLB := TfrxListBox(Data.Source);
  if SourceLB = nil then Exit;
  SenderLB := TfrxListBox(Sender);
  if FItemAdded then
   begin
     TfrxListBox(Sender).Items.Delete(0);
     FItemAdded := False;
   end;
  if (SourceLB.ItemIndex = -1) or (SourceLB.Count = 0) then Exit;
  if (Data.Source = Sender) and (Data.Source <> FieldsLB) then
  begin
    item := SourceLB.ItemByPoint(Point.X, Point.Y);
    i := -1;
    if item <> nil then i := item.Index;

    if i = -1 then
      i := SourceLB.Items.Count - 1;
    SourceLB.Items.Exchange(SourceLB.ItemIndex, i);
  end
  else if SourceLB <> Sender then
  begin
    s := SourceLB.Items[SourceLB.ItemIndex];
    if SourceLB <> FieldsLB then
      SourceLB.Items.Delete(SourceLB.Items.IndexOf(s));
    if Sender <> FieldsLB then
      SenderLB.Items.Add(s);
  end;


  UpdateCheckBoxes(SourceLB);
  UpdateCheckBoxes(SenderLB);
  ReflectChanges(Data.Source);
  ReflectChanges(Sender);
end;

procedure TfrxCrossEditorForm.LBButtonClick(Sender, aButton: TObject;
  aItem: TfrxListBoxItem);
var
  Memo: TfrxCustomMemoView;
  sort: TfrxCrossSortOrder;
  f: TfrxCrossFunction;
  i: Integer;
  pt: TPointF;
  m : TMenuItem;
  //Button: TButton;
begin
  FCurList := TfrxListBox(Sender);
  //Button := aButton as TButton;
  if (Sender = RowsLB) or (Sender = ColumnsLB) then
  begin
    if Sender = RowsLB then
      sort := FCross.RowSort[THackListBoxItem(aItem).Index] else
      sort := FCross.ColumnSort[THackListBoxItem(aItem).Index];

    for i := 0 to FSortMenuList.Count - 1 do
    begin
      m := TMenuItem(FSortMenuList[i]);
      if m.Tag = Integer(sort) then
         m.IsChecked := True
      else
        m.IsChecked := False;
    end;
    pt := aItem.LocalToAbsolute(PointF(aItem.Position.X + aItem.Width, 0));
    pt := Self.ClientToScreen(pt);
    SortPopup.Popup(pt.X, pt.Y);
  end
  else if (Sender = CellsLB) then
  begin
    if CellsLB.ItemIndex = -1 then Exit;
    f := FCross.CellFunctions[CellsLB.ItemIndex];
    for i := 0 to FFuncMenuList.Count - 1 do
    begin
      m := TMenuItem(FFuncMenuList[i]);
      if m.Tag = Integer(f) then
         m.IsChecked := True
      else
         m.IsChecked := False;
    end;
    pt := aItem.LocalToAbsolute(PointF(aItem.Position.X + aItem.Width, 0));
    pt := Self.ClientToScreen(pt);
    FuncPopup.Popup(pt.X, pt.Y);
  end;
end;

procedure TfrxCrossEditorForm.LBCheckChange(Sender: TObject);
var
  FCurItem: TfrxListBoxItem;
  Memo: TfrxCustomMemoView;
begin

  FCurItem := Sender as TfrxListBoxItem;
  if (FCurItem = nil) or FUpdating then Exit;
  FCurList := TfrxListBox(THackListBoxItem(FCurItem).ListBox);
  if THackListBoxItem(FCurItem).ListBox = RowsLB then
    Memo := FCross.RowTotalMemos[THackListBoxItem(FCurItem).Index + 1] else
    Memo := FCross.ColumnTotalMemos[THackListBoxItem(FCurItem).Index + 1];
  Memo.Visible := FCurItem.IsChecked;
  PaintBox.InvalidateRect(PaintBox.BoundsRect);
end;

procedure TfrxCrossEditorForm.LBClick(Sender: TObject);
begin
  if Sender <> FieldsLB then
    FieldsLB.ItemIndex := -1;
  if Sender <> RowsLB then
    RowsLB.ItemIndex := -1;
  if Sender <> ColumnsLB then
    ColumnsLB.ItemIndex := -1;
  if Sender <> CellsLB then
    CellsLB.ItemIndex := -1;
end;

procedure TfrxCrossEditorForm.LBDblClick(Sender: TObject);
var
  lb: TfrxListBox;
  s: String;
begin
  lb := TfrxListBox(Sender);
  if lb.ItemIndex = -1 then
    exit;
  s := Cross.Report.Designer.InsertExpression(lb.Items[lb.ItemIndex]);
  if s <> '' then
  begin
    lb.Items[lb.ItemIndex] := s;
    ReflectChanges(Sender);
  end;
end;

procedure TfrxCrossEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrxCrossEditorForm.OkBClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrxCrossEditorForm.LBMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  Memo: TfrxCustomMemoView;
  sort: TfrxCrossSortOrder;
  i: Integer;
  pt: TPointF;
begin
  FCurList := TfrxListBox(Sender);
  FCurList.Repaint;
  ReflectChanges(Sender, False);
end;

procedure TfrxCrossEditorForm.CBClick(Sender: TObject);
begin
  if FUpdating then Exit;

  FCross.ShowTitle := TitleCB.IsChecked;
  FCross.ShowCorner := CornerCB.IsChecked;
  FCross.ShowColumnHeader := ColumnHeaderCB.IsChecked;
  FCross.ShowRowHeader := RowHeaderCB.IsChecked;
  FCross.ShowColumnTotal := ColumnTotalCB.IsChecked;
  FCross.ShowRowTotal := RowTotalCB.IsChecked;

  FCross.AutoSize := AutoSizeCB.IsChecked;
  FCross.Border := BorderCB.IsChecked;
  FCross.DownThenAcross := DownAcrossCB.IsChecked;
  FCross.RepeatHeaders := RepeatCB.IsChecked;
  FCross.PlainCells := PlainCB.IsChecked;
  FCross.JoinEqualCells := JoinCB.IsChecked;
  ReflectChanges(Sender, False);
end;

procedure TfrxCrossEditorForm.DimensionsChange(Sender: TObject);
begin
  if FUpdating then Exit;

  case TControl(Sender).Tag of
    0: FCross.RowLevels := StrToInt(RowsE.Text);
    1: FCross.ColumnLevels := StrToInt(ColumnsE.Text);
    2: FCross.CellLevels := StrToInt(CellsE.Text);
  end;

  RowsLB.Items := FCross.RowFields;
  ColumnsLB.Items := FCross.ColumnFields;
  CellsLB.Items := FCross.CellFields;

  ReflectChanges(Sender);
end;

procedure TfrxCrossEditorForm.FuncMIClick(Sender: TObject);
begin
  if CellsLB.ItemIndex = -1 then Exit;
  FCross.CellFunctions[CellsLB.ItemIndex] := TfrxCrossFunction(TControl(Sender).Tag);
  CellsLB.Repaint;
  THackControl(CellsLB).DragEnd;
end;


procedure TfrxCrossEditorForm.SortMIClick(Sender: TObject);
begin
  if FCurList.ItemIndex = -1 then Exit;
  if FCurList = ColumnsLB then
    FCross.ColumnSort[FCurList.ItemIndex] := TfrxCrossSortOrder(TControl(Sender).Tag) else
    FCross.RowSort[FCurList.ItemIndex] := TfrxCrossSortOrder(TControl(Sender).Tag);
  FCurList.Repaint;
  THackControl(FCurList).DragEnd;
end;

procedure TfrxCrossEditorForm.SwapBClick(Sender: TObject);
var
  sl: TStrings;
begin
  sl := TStringList.Create;
  sl.Assign(RowsLB.Items);
  FUpdating := True;
  RowsLB.Items := ColumnsLB.Items;
  ColumnsLB.Items := sl;
  sl.Free;
  FUpdating := False;
  UpdateCheckBoxes(RowsLB);
  UpdateCheckBoxes(ColumnsLB);
  ReflectChanges(nil);
  RowsLB.Repaint;
  ColumnsLB.Repaint;
end;

procedure TfrxCrossEditorForm.StyleBClick(Sender: TObject);
var
  pt: TPointF;
begin
 pt := PaintBox.LocalToAbsolute(PointF(StyleB.Position.X, StyleB.Position.Y + ToolBar.Height));
 StylePopup.Popup(Self.Left + pt.X, Self.Top  + pt.Y );
end;

procedure TfrxCrossEditorForm.StyleClick(Sender: TObject);
var
  Style: TfrxStyles;
begin
  Style := FStyleSheet.Find(TMenuItem(Sender).Text);
  if Style <> nil then
    FCross.ApplyStyle(Style);
  PaintBox.InvalidateRect(PaintBox.BoundsRect);
end;

procedure TfrxCrossEditorForm.SaveStyleMIClick(Sender: TObject);
var
  s: String;
  Style: TfrxStyles;
begin
  s := '';
  s := InputBox(frxGet(4313), frxResources.Get('crStName'), s);
  if s <> '' then
  begin
    Style := FStyleSheet.Find(s);
    if Style = nil then
      Style := FStyleSheet.Add;
    Style.Name := s;
    FCross.GetStyle(Style);
    FStyleSheet.SaveToFile(ExtractFilePath(ParamStr(0)) + 'crossstyles.xml');
    CreateStyleMenu;
  end;
end;

procedure TfrxCrossEditorForm.PaintBoxPaint(Sender: TObject; Canvas: TCanvas);
begin
  with Canvas do
  begin
    Fill.Color := claWhite;
    FillRect(RectF(0, 0, PaintBox.Width, PaintBox.Height), 1, 1, AllCorners, 1, TCornerType.ctBevel);
  end;
  FCross.DrawCross(PaintBox.Canvas, 1, 1, 0, 0);
end;


initialization
  frxComponentEditors.Register(TfrxCrossView, TfrxCrossEditor);
  frxComponentEditors.Register(TfrxDBCrossView, TfrxCrossEditor);

end.


//56db3b0f55102b9488a240d37950543f