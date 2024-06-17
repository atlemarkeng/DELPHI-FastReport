
{******************************************}
{                                          }
{             FastReport v4.0              }
{           Chart design editor            }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxChartEditor;

interface
{$I frx.inc}
{$I tee.inc}
uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.Menus, FMX.ExtCtrls, FMX.frxClass, FMX.frxChart, FMX.frxCustomEditors,
  FMX.frxCtrls, FMX.frxInsp, FMX.Edit, FMX.ListBox, FMX.Layouts, FMX.TreeView,
  FMX.Types, FMXTee.Procs, FMXTee.Engine, FMXTee.Chart, FMXTee.Series, {$IFDEF TeeChartPro}FMXTee.Commander, FMXTee.Editor.EditorPanel,{$ENDIF}
  System.Variants, FMX.frxFMX, FMXTee.Chart.GalleryPanel
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF}
{$IFDEF DELPHI21}
  , FMX.ComboEdit
{$ENDIF};


type
  TfrxChartEditor = class(TfrxViewEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  TfrxChartEditorForm = class(TForm)
    OkB: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    CancelB: TButton;
    SourcePanel: TPanel;
    DataSourceGB: TGroupBox;
    DBSourceRB: TRadioButton;
    BandSourceRB: TRadioButton;
    FixedDataRB: TRadioButton;
    DatasetsCB: TComboBox;
    DatabandsCB: TComboBox;
    ValuesGB: TGroupBox;
    Values1CB: TComboEdit;
    Values1L: TLabel;
    Values2L: TLabel;
    Values2CB: TComboEdit;
    Values3L: TLabel;
    Values3CB: TComboEdit;
    Values4L: TLabel;
    Values4CB: TComboEdit;
    OptionsGB: TGroupBox;
    ShowTopLbl: TLabel;
    CaptionLbl: TLabel;
    SortLbl: TLabel;
    XLbl: TLabel;
    TopNE: TEdit;
    TopNCaptionE: TEdit;
    SortCB: TComboBox;
    XTypeCB: TComboBox;
    InspSite: TPanel;
    Values5L: TLabel;
    Values5CB: TComboEdit;
    HintL: TLabel;
    Values6L: TLabel;
    Values6CB: TComboEdit;
    Panel3: TPanel;
    TreePanel: TPanel;
    AddB: TSpeedButton;
    DeleteB: TSpeedButton;
    EditB: TSpeedButton;
    UPB: TSpeedButton;
    DownB: TSpeedButton;
    ChartTree: TfrxTreeView;
    procedure FormShow(Sender: TObject);
    procedure ChartTreeClick(Sender: TObject);
    procedure AddBClick(Sender: TObject);
    procedure DeleteBClick(Sender: TObject);
    procedure DoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpDown1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure DatasetsCBClick(Sender: TObject);
    procedure DatabandsCBClick(Sender: TObject);
    procedure DBSourceRBClick(Sender: TObject);
    procedure OkBClick(Sender: TObject);
    procedure EditBClick(Sender: TObject);
    procedure ChartTreeEdited(Sender: TObject; Node: TfrxTreeViewItem;
      var S: String);
    procedure ChartTreeEditing(Sender: TObject; OldNode: TfrxTreeViewItem; NewNode: TfrxTreeViewItem);
    procedure UPBClick(Sender: TObject);
    procedure DownBClick(Sender: TObject);
  private
    { Private declarations }
    FChart: TfrxChartView;
    FCurSeries: TfrxSeriesItem;
    FInspector: TfrxObjectInspector;
    FModified: Boolean;
    FReport: TfrxReport;
    FUpdating: Boolean;
    FValuesGBHeight: Single;
    procedure FillDropDownLists(ds: TfrxDataset);
    procedure SetCurSeries(const Value: TfrxSeriesItem);
    procedure SetModified(const Value: Boolean);
    procedure ShowSeriesData;
    procedure UpdateSeriesData;
    property Modified: Boolean read FModified write SetModified;
    property CurSeries: TfrxSeriesItem read FCurSeries write SetCurSeries;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Chart: TfrxChartView read FChart write FChart;
  end;


implementation

uses FMX.frxDsgnIntf, FMX.frxUtils, FMX.frxRes, FMX.frxChartHelpers, FMX.frxChartGallery;
//{$IFDEF DELPHI16}
//{$IFDEF TeeChartPro}, VCLTee.TeeEdit{$IFNDEF TeeChart4}, VCLTee.TeeEditCha{$ENDIF} {$ENDIF};
//{$ELSE}
//{$IFDEF TeeChartPro}, TeeEdit{$IFNDEF TeeChart4}, TeeEditCha{$ENDIF} {$ENDIF};
//{$ENDIF}

{$R *.FMX}

type
  THackControl = class(TControl);


{ TfrxChartEditor }

function TfrxChartEditor.HasEditor: Boolean;
begin
  Result := True;
end;

function TfrxChartEditor.Edit: Boolean;
begin
  with TfrxChartEditorForm.Create(Designer) do
  begin
    Chart.Assign(TfrxChartView(Component));
    FormShow(Self);
    Result := ShowModal = mrOk;
    if Result then
      TfrxChartView(Component).Assign(Chart);
    Free;
  end;
end;

function TfrxChartEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  i: Integer;
  c: TfrxComponent;
  v: TfrxChartView;
begin
  Result := inherited Execute(Tag, Checked);
  for i := 0 to Designer.SelectedObjects.Count - 1 do
  begin
    c := Designer.SelectedObjects[i];
    if (c is TfrxChartView) and not (rfDontModify in c.Restrictions) then
    begin
      v := TfrxChartView(c);
      if Tag = 1 then
        v.Chart.View3D := Checked
      else if Tag = 2 then
        v.Chart.AxisVisible := Checked;
      Result := True;
    end;
  end;
end;

procedure TfrxChartEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
var
  v: TfrxChartView;
begin
  v := TfrxChartView(Component);
  AddItem(frxResources.Get('ch3D'), 1, v.Chart.View3D);
  AddItem(frxResources.Get('chAxis'), 2, v.Chart.AxisVisible);
  inherited;
end;


{ TfrxChartEditorForm }

constructor TfrxChartEditorForm.Create(AOwner: TComponent);
var
  bmp: TBitmap;
begin
  inherited;
  FReport := TfrxCustomDesigner(AOwner).Report;
  FChart := TfrxChartView.Create(FReport);
  FInspector := TfrxObjectInspector.Create(Owner);
  with FInspector do
  begin
    SplitterPos := InspSite.Width / 2;
    Box.Parent := InspSite;
    Box.Align := alClient;
  end;

  { add chart image }
  bmp := TBitmap.Create(24, 24);
  //frxResources.LoadImageFromResouce(
  //ObjectImages.Draw(bmp.Canvas, 0, 0, 25);
  //frxAssignImages(bmp, 24, 24, ChartImages);
  bmp.Free;
  FValuesGBHeight := ValuesGB.Height;
{$IFDEF TeeChartPro}
  EditB.Visible := True;
{$ENDIF}
end;

destructor TfrxChartEditorForm.Destroy;
begin
  FChart.Free;
  inherited;
end;

procedure TfrxChartEditorForm.FormShow(Sender: TObject);

  procedure FillChartTree;
  var
    i: Integer;
    n: TfrxTreeViewItem;
  begin
    for i := 0 to FChart.Chart.SeriesCount - 1 do
    begin

      n := ChartTree.AddItem(ChartTree.Items[0], GetGallerySeriesName(FChart.Chart.Series[i]) + ' - ' + FChart.Chart.Series[i].Name);

      n.OpenImageIndex := 0;
      n.CloseImageIndex := 0;
    end;

    ChartTree.ExpandAll;
    ChartTree.Selected := ChartTree.Items[0];
  end;

  procedure FillBandsList;
  var
    i: Integer;
    c: TfrxComponent;
  begin
    for i := 0 to FReport.Designer.Objects.Count - 1 do
    begin
      c := FReport.Designer.Objects[i];
      if c is TfrxDataBand then
        DatabandsCB.Items.Add(c.Name);
    end;
  end;

begin
  ChartTree.AddItem(ChartTree, 'Root');
  FReport.GetDatasetList(DatasetsCB.Items);
  FillBandsList;
  FillChartTree;
  CurSeries := nil;
  //Constraints.MinWidth := Width;
  //Constraints.MinHeight := Height;
  //Constraints.MaxHeight := Height;
end;

procedure TfrxChartEditorForm.ShowSeriesData;
var
  Helper: TfrxSeriesHelper;
  sl: TStrings;
  NewHeight: Single;
begin
  FUpdating := True;

  if FCurSeries <> nil then
    with FCurSeries do
    begin
      if DataType = dtDBData then
        DBSourceRB.IsChecked := True
      else if DataType = dtBandData then
        BandSourceRB.IsChecked := True
      else if DataType = dtFixedData then
        FixedDataRB.IsChecked := True;
      if Values1CB.Count > 0 then
        Values1CB.ItemIndex := Values1CB.Items.IndexOf(FCurSeries.Source1)
      else
        Values1CB.Text := FCurSeries.Source1;

      if Values2CB.Count > 0 then
        Values2CB.ItemIndex := Values2CB.Items.IndexOf(FCurSeries.Source2)
      else
        Values2CB.Text := FCurSeries.Source2;
      if Values3CB.Count > 0 then
        Values3CB.ItemIndex := Values3CB.Items.IndexOf(FCurSeries.Source3)
      else
        Values3CB.Text := FCurSeries.Source3;
      if Values4CB.Count > 0 then
        Values4CB.ItemIndex := Values4CB.Items.IndexOf(FCurSeries.Source4)
      else
        Values4CB.Text := FCurSeries.Source4;
      if Values5CB.Count > 0 then
        Values5CB.ItemIndex := Values5CB.Items.IndexOf(FCurSeries.Source5)
      else
        Values5CB.Text := FCurSeries.Source5;
      if Values6CB.Count > 0 then
        Values6CB.ItemIndex := Values6CB.Items.IndexOf(FCurSeries.Source6)
      else
        Values6CB.Text := FCurSeries.Source6;
      Helper := frxFindSeriesHelper(FChart.Chart.Series[FCurSeries.Index]);
      sl := TStringList.Create;
      frxSetCommaText(Helper.GetParamNames, sl);

      NewHeight := FValuesGBHeight;
      Values2CB.Visible := sl.Count >= 2;
      Values2L.Visible := sl.Count >= 2;
      if not Values2CB.Visible then
        NewHeight :=  NewHeight - (Values2CB.Height + 4);
      Values3CB.Visible := sl.Count >= 3;
      Values3L.Visible := sl.Count >= 3;
      if not Values3CB.Visible then
        NewHeight :=  NewHeight - (Values3CB.Height + 4);
      Values4CB.Visible := sl.Count >= 4;
      Values4L.Visible := sl.Count >= 4;
      if not Values4CB.Visible then
        NewHeight :=  NewHeight - (Values4CB.Height + 4);
      Values5CB.Visible := sl.Count >= 5;
      Values5L.Visible := sl.Count >= 5;
      if not Values5CB.Visible then
        NewHeight :=  NewHeight - (Values5CB.Height + 4);
      Values6CB.Visible := sl.Count >= 6;
      Values6L.Visible := sl.Count >= 6;
      if not Values6CB.Visible then
        NewHeight :=  NewHeight - (Values6CB.Height + 4);

      ValuesGB.Height := NewHeight;
      OptionsGB.Position.Y := ValuesGB.Position.Y + ValuesGB.Height + 8;

      if sl.Count > 0 then
        Values1L.Text := sl[0];
      if sl.Count > 1 then
        Values2L.Text := sl[1];
      if sl.Count > 2 then
        Values3L.Text := sl[2];
      if sl.Count > 3 then
        Values4L.Text := sl[3];
      if sl.Count > 4 then
        Values5L.Text := sl[4];
      if sl.Count > 5 then
        Values6L.Text := sl[5];

      sl.Free;
      Helper.Free;


      if DataSet = nil then
        DatasetsCB.ItemIndex := -1
      else
      begin
        DatasetsCB.ItemIndex := DatasetsCB.Items.IndexOf(FReport.GetAlias(DataSet));
        DatasetsCBClick(nil);
      end;

      if DataBand = nil then
        DatabandsCB.ItemIndex := -1
      else
      begin
        DatabandsCB.ItemIndex := DatabandsCB.Items.IndexOf(DataBand.Name);
        DatabandsCBClick(nil);
      end;

      TopNE.Text := IntToStr(TopN);
      TopNCaptionE.Text := TopNCaption;
      SortCB.ItemIndex := Integer(SortOrder);
      XTypeCB.ItemIndex := Integer(XType);
    end;

  FUpdating := False;
end;

procedure TfrxChartEditorForm.UpdateSeriesData;
begin
  if FCurSeries <> nil then
    with FCurSeries do
    begin
      if DBSourceRB.IsChecked then
        DataType := dtDBData
      else if BandSourceRB.IsChecked then
        DataType := dtBandData
      else if FixedDataRB.IsChecked then
        DataType := dtFixedData;

      if DatabandsCB.ItemIndex <> -1 then
        DataBand := TfrxDataBand(FReport.FindObject(DatabandsCB.Items[DatabandsCB.ItemIndex]))
      else
        DataBand := nil;
      if DatasetsCB.ItemIndex <> -1 then
        DataSet := FReport.GetDataSet(DatasetsCB.Items[DatasetsCB.ItemIndex])
      else
        DataSet := nil;

//      if Values1CB.Selected <> nil then
//        Source1 := Values1CB.Selected.Text;
//      if Values2CB.Selected <> nil then
//        Source2 := Values2CB.Selected.Text;
//      if Values3CB.Selected <> nil then
//        Source3 := Values3CB.Selected.Text;
//      if Values4CB.Selected <> nil then
//        Source4 := Values4CB.Selected.Text;
//      if Values5CB.Selected <> nil then
//        Source5 := Values5CB.Selected.Text;
//      if Values6CB.Selected <> nil then
//        Source6 := Values6CB.Selected.Text;


      Source1 := Values1CB.Text;
      Source2 := Values2CB.Text;
      Source3 := Values3CB.Text;
      Source4 := Values4CB.Text;
      Source5 := Values5CB.Text;
      Source6 := Values6CB.Text;

      SortOrder := TfrxSeriesSortOrder(SortCB.ItemIndex);
      TopN := StrToInt(TopNE.Text);
      TopNCaption := TopNCaptionE.Text;
      XType := TfrxSeriesXType(XTypeCB.ItemIndex);
    end;

  Modified := False;
end;

procedure TfrxChartEditorForm.SetCurSeries(const Value: TfrxSeriesItem);
var
  InspectObj: TPersistent;
begin
  if Modified then
    UpdateSeriesData;
  FCurSeries := Value;

  if FCurSeries = nil then
    InspectObj := FChart.Chart
  else
  begin
    InspectObj := FChart.Chart.Series[FCurSeries.Index];
    UPB.Enabled := FCurSeries.Index > 0;
    DownB.Enabled := (FCurSeries.Index < FChart.Chart.SeriesCount) and (FChart.Chart.SeriesCount <> FCurSeries.Index + 1);
  end;
  FInspector.Inspect([InspectObj]);
  SourcePanel.Visible := FCurSeries <> nil;
  HintL.Visible := not SourcePanel.Visible;
  DeleteB.Visible := FCurSeries <> nil;
  UPB.Visible := (FCurSeries <> nil);
  DownB.Visible := (FCurSeries <> nil);
  ShowSeriesData;
end;

procedure TfrxChartEditorForm.SetModified(const Value: Boolean);
begin
  if not FUpdating then
    FModified := Value;
end;

procedure TfrxChartEditorForm.FillDropDownLists(ds: TfrxDataset);
var
  l: TStringList;
  i: Integer;
begin
  if ds = nil then
  begin
{$IFDEF DELPHI23}
    Values1CB.Clear;
    Values2CB.Clear;
    Values3CB.Clear;
    Values4CB.Clear;
    Values5CB.Clear;
    Values6CB.Clear;
{$ELSE}
    Values1CB.Items.Clear;
    Values2CB.Items.Clear;
    Values3CB.Items.Clear;
    Values4CB.Items.Clear;
    Values5CB.Items.Clear;
    Values6CB.Items.Clear;
{$ENDIF}
  end
  else
  begin
    l := TStringList.Create;
    try
      ds.GetFieldList(l);
      for i := 0 to l.Count - 1 do
        l[i] := FReport.GetAlias(ds) + '."' + l[i] + '"';

      Values1CB.Items := l;
      Values2CB.Items := l;
      Values3CB.Items := l;
      Values4CB.Items := l;
      Values5CB.Items := l;
      Values6CB.Items := l;
    finally
      l.Free;
    end;
  end;
end;

procedure TfrxChartEditorForm.ChartTreeClick(Sender: TObject);
var
  i: Integer;
begin
  i := ChartTree.Selected.GlobalIndex - 1;
  if i >= 0 then
    CurSeries := FChart.SeriesData[i] else
    CurSeries := nil;
end;

{$HINTS OFF}
procedure TfrxChartEditorForm.AddBClick(Sender: TObject);
var
  s: TChartSeries;
  n: TfrxTreeViewItem;
  b: Boolean;
  ind, i: Integer;
  TeeGalleryForm: TfrxChartGalleryForm;
//{$IFDEF Delphi11}
//  TeeGalleryForm: TTeeGalleryForm;
  ChartSeriesClass : TChartSeriesClass;
  TeeFunctionClass : TTeeFunctionClass;
//{$ENDIF}
begin
  ind := 0;
{$IFDEF TeeChartStd7}
  s := CreateNewSeriesGallery(nil, nil, FChart.Chart, False, False, ind);
{$ELSE}

//{$IFDEF Delphi11}
   s := nil;
   TeeGalleryForm := TfrxChartGalleryForm.Create(nil);
//   TeeGalleryForm := TTeeGalleryForm.Create(nil);
   TeeGalleryForm.Position := TFormPosition.poScreenCenter;
   if TeeGalleryForm.ShowModal = mrOk then
   begin
      ChartSeriesClass := nil;
      TeeFunctionClass := nil;
      TeeGalleryForm.GetGallery.GetSeriesClass(ChartSeriesClass, TeeFunctionClass, ind);
      s := CreateNewSeries(nil, FChart.Chart, ChartSeriesClass, TeeFunctionClass);
     end;
//{$ELSE}
//   s := CreateNewSeriesGallery(nil, nil, FChart.Chart, False, False{$IFNDEF TeeChart4}{$IFDEF TeeChartPro}, ind{$ENDIF}{$ENDIF});
//{$ENDIF}

{$ENDIF}
  if s = nil then
    Exit;
  FChart.SeriesData.Add;

  with FChart.Chart do
  begin
    b := not (s is TPieSeries);
    View3DOptions.Orthogonal := b;
    AxisVisible := b;
    View3DWalls := b;
  end;

  n := ChartTree.AddItem(ChartTree.ItemByGlobalIndex(0), GetGallerySeriesName(s) + ' - ' + s.Name);

  n.OpenImageIndex := 0;
  n.CloseImageIndex := 0;

  ChartTree.Selected := n;

  TeeGalleryForm.Free;

  ChartTreeClick(nil);
end;
{$HINTS ON}

procedure TfrxChartEditorForm.DeleteBClick(Sender: TObject);
var
  s: TChartSeries;
begin
  s := FChart.Chart.Series[FCurSeries.Index];
  s.Free;
  FCurSeries.Free;
  ChartTree.Selected.Free;

  ChartTree.SetFocus;
  ChartTree.Selected := ChartTree.Items[0];
  ChartTreeClick(nil);
end;

procedure TfrxChartEditorForm.EditBClick(Sender: TObject);
begin
{$IFDEF TeeChartPro}
  with TChartEditor.Create(nil) do
  begin
  //TChartEditor.Create(nil).Chart;
    Chart := FChart.Chart;
    //F//mxTee.Editor.EditorPanel.
    if FCurSeries <> nil then
      Series := FChart.Chart.Series[FCurSeries.Index];

   // HideTabs := [cetGeneral, cetTitles, cetPaging, cetSeriesData, cetMain,
   //   cetExport, {$IFDEF TeeChart7}cetExportNative,{$ENDIF} cetPrintPreview];
   // Tab := DefaultTab - [ceDataSource, ceHelp, ceClone, ceTitle, ceAdd];

    Execute;
    Free;
  end;
{$ENDIF}
end;

procedure TfrxChartEditorForm.DoClick(Sender: TObject);
begin
  if not FUpdating then
    Modified := True;
end;

procedure TfrxChartEditorForm.UpDown1Click(Sender: TObject);
begin
  DoClick(Sender);
end;

procedure TfrxChartEditorForm.DatasetsCBClick(Sender: TObject);
var
  ds: TfrxDataSet;
begin
   if DatasetsCB.ItemIndex = -1 then Exit;
   
  ds := FReport.GetDataSet(DatasetsCB.Items[DatasetsCB.ItemIndex]);
  FillDropDownLists(ds);
  DoClick(nil);
end;

procedure TfrxChartEditorForm.DatabandsCBClick(Sender: TObject);
var
  db: TfrxDataBand;
  ds: TfrxDataSet;
begin
  if DatabandsCB.ItemIndex = -1 then Exit;
  db := TfrxDataBand(FReport.FindObject(DatabandsCB.Items[DatabandsCB.ItemIndex]));
  if db <> nil then
    ds := db.DataSet
  else
    ds := nil;
  FillDropDownLists(ds);
  DoClick(nil);
end;

procedure TfrxChartEditorForm.DBSourceRBClick(Sender: TObject);
begin
  DatasetsCB.ItemIndex := -1;
  DatabandsCB.ItemIndex := -1;
  FillDropDownLists(nil);
  DoClick(nil);
end;

procedure TfrxChartEditorForm.OkBClick(Sender: TObject);
begin
  FInspector.FormDeactivate(nil);
  CurSeries := nil;
end;

procedure TfrxChartEditorForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(4100);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  //AddB.Hint := frxGet(4101);
  //DeleteB.Hint := frxGet(4102);
  //EditB.Hint := frxGet(4103);

  DatasourceGB.Text := frxGet(4107);
  DBSourceRB.Text := frxGet(4106);
  BandSourceRB.Text := frxGet(4104);
  FixedDataRB.Text := frxGet(4105);

  ValuesGB.Text := frxGet(4108);
  HintL.Text := frxGet(4109);

  OptionsGB.Text := frxGet(4114);
  ShowTopLbl.Text := frxGet(4115);
  CaptionLbl.Text := frxGet(4116);
  SortLbl.Text := frxGet(4117);
  XLbl.Text := frxGet(4126);
{$IFDEF DELPHI23}
  XTypeCB.Clear;
{$ELSE}
  XTypeCB.Items.Clear;
{$ENDIF}
  XTypeCB.Items.Add(frxResources.Get('chxtText'));
  XTypeCB.Items.Add(frxResources.Get('chxtNumber'));
  XTypeCB.Items.Add(frxResources.Get('chxtDate'));
{$IFDEF DELPHI23}
  SortCB.Clear;
{$ELSE}
  SortCB.Items.Clear;
{$ENDIF}
  SortCB.Items.Add(frxResources.Get('chsoNone'));
  SortCB.Items.Add(frxResources.Get('chsoAscending'));
  SortCB.Items.Add(frxResources.Get('chsoDescending'));
  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
end;

procedure TfrxChartEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

procedure TfrxChartEditorForm.ChartTreeEdited(Sender: TObject; Node: TfrxTreeViewItem;
      var S: String);
var
  Ser: TChartSeries;
begin
  if FCurSeries <> nil then
  begin
    Ser := FChart.Chart.Series[FCurSeries.Index];
    Ser.Name := S;
    S := GetGallerySeriesName(Ser) + ' - ' + Ser.Name;
  end;
end;

procedure TfrxChartEditorForm.ChartTreeEditing(Sender: TObject; OldNode: TfrxTreeViewItem; NewNode: TfrxTreeViewItem);
//var
// FEditHandle: HWND;
begin
//  if Node.Parent = nil then
//  begin
//    AllowEdit := False;
//    exit;
//  end;
//  FEditHandle := HWND( SendMessage(ChartTree.Handle, $110F, 0, 0) );
//  if (FCurSeries <> nil) and (FEditHandle <> 0) then
//    Windows.SetWindowText(FEditHandle, PChar(FChart.Chart.Series[FCurSeries.Index].Name));
end;

procedure TfrxChartEditorForm.UPBClick(Sender: TObject);
//var
//  tNode: TTreeNode;
//  idx: Integer;
begin
//  idx := FCurSeries.Index;
//  FChart.Chart.SeriesUp(FChart.Chart.Series[idx]);
//  FChart.SeriesData.Items[idx].Index := idx - 1;
//
//  with ChartTree.Items.GetFirstNode do
//  begin
//    tNode := Item[idx - 1];
//    Item[idx].MoveTo(tNode, naInsert);
//    ChartTree.Selected := Item[idx - 1];
//  end;
//
//  ChartTree.SetFocus;
//  ChartTreeClick(nil);
end;

procedure TfrxChartEditorForm.DownBClick(Sender: TObject);
//var
//  tNode: TTreeNode;
//  idx: Integer;
begin
//  idx := FCurSeries.Index;
//  FChart.Chart.SeriesDown(FChart.Chart.Series[idx]);
//  FChart.SeriesData.Items[idx].Index := idx + 1;
//
//  with ChartTree.Items.GetFirstNode do
//  begin
//    if idx + 2 = Count then
//      Item[idx].MoveTo(ChartTree.Items.GetFirstNode, naAddChild)
//    else
//    begin
//      tNode := Item[idx + 2];
//      Item[idx].MoveTo(tNode, naInsert);
//    end;
//    ChartTree.Selected := Item[idx + 1];
//  end;
//
//  ChartTree.SetFocus;
//  ChartTreeClick(nil);
end;

initialization
  frxComponentEditors.Register(TfrxChartView, TfrxChartEditor);
  frxHideProperties(TChart, 'Align;AllowPanning;AllowZoom;Anchors;AnimatedZoom;' +
    'AnimatedZoomSteps;AutoSize;BackImage;BackImageInside;BackImageMode;' +
    'BevelInner;BevelOuter;BevelWidth;BorderStyle;BorderWidth;ClipPoints;Color;' +
    'Constraints;Cursor;DragCursor;DragKind;DragMode;DockSite;Enabled;Foot;Frame;Height;' +
    'HelpContext;HelpType;HelpKeyword;Hint;Left;Locked;MarginBottom;MarginLeft;MarginRight;MarginTop;' +
    'MaxPointsPerPage;Name;Page;ParentColor;ParentShowHint;PopupMenu;PrintProportional;' +
    'ScaleLastPage;ScrollMouseButton;SeriesList;ShowHint;TabOrder;TabStop;Tag;Top;UseDockManager;' +
    'Visible;Width');
  frxHideProperties(TChartSeries, 'ColorSource;Cursor;DataSource;Name;' +
    'ParentChart;Tag;XLabelsSource');
  frxHideProperties(TfrxChartView, 'SeriesData;BrushStyle');


end.


//56db3b0f55102b9488a240d37950543f