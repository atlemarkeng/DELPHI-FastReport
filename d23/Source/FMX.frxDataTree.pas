
{******************************************}
{                                          }
{             FastReport v4.0              }
{          Data Tree tool window           }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxDataTree;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UiTypes, System.Types, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.frxClass, FMX.fs_xml, FMX.Types, FMX.Layouts, FMX.TreeView, FMX.frxFMX, FMX.TabControl
, System.Variants, FMX.Objects
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};


type
  TfrxDataTreeForm = class(TForm)
    MainDataPanel: TPanel;
    ClassesPn: TPanel;
    DataPn: TPanel;
    CBPanel: TPanel;
    InsFieldCB: TCheckBox;
    InsCaptionCB: TCheckBox;
    SortCB: TCheckBox;
    NoDataL: TLabel;
    FunctionsPn: TPanel;
    Splitter1: TSplitter;
    HintPanel: TScrollBox;
    FunctionDescL: TLabel;
    FunctionNameL: TLabel;
    VariablesPn: TPanel;
    Rectangle1: TRectangle;
    Label1: TLabel;
    procedure FormResize(Sender: TObject);
    //procedure DataTreeCustomDrawItem(Sender: TCustomTreeView;
    //  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FunctionsTreeChange(Sender: TObject);
    procedure DataTreeDblClick(Sender: TObject);
    //procedure ClassesTreeExpanding(Sender: TObject; Node: TTreeNode;
    //  var AllowExpansion: Boolean);
    //procedure ClassesTreeCustomDrawItem(Sender: TCustomTreeView;
    //  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure SortCBClick(Sender: TObject);
    procedure MainDataPanelDragEnd(Sender: TObject);
  private
    { Private declarations }
    FXML: TfsXMLDocument;
    FImages: TfrxImageList;
    FReport: TfrxReport;
    FUpdating: Boolean;
    FFirstTime: Boolean;
    DataTree: TfrxTreeView;
    VariablesTree: TfrxTreeView;
    FunctionsTree: TfrxTreeView;
    ClassesTree: TfrxTreeView;
    FTabs: TTabControl;

    procedure FillClassesTree;
    procedure FillDataTree;
    procedure FillFunctionsTree;
    procedure FillVariablesTree;
    procedure TabsChange(Sender: TObject);
    function GetCollapsedNodes: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetLastPosition(p: TPoint);
    procedure ShowTab(Index: Integer);
    procedure UpdateItems;
    procedure UpdateSelection;
    procedure UpdateSize;
    function GetActivePage: Integer;
    function GetFieldName: String;
    function GetLastPosition: TPoint;
    function IsDataField: Boolean;
    property Report: TfrxReport read FReport write FReport;
  end;


implementation

{$R *.FMX}

uses FMX.fs_iinterpreter, FMX.fs_itools, FMX.frxRes;

type
  THackTreeView = class(TCustomTreeView);

var
  CollapsedNodes: String;


procedure SetImageIndex(Node: TfrxTreeViewItem; Index: Integer);
begin
  Node.OpenImageIndex := Index;
  Node.CloseImageIndex := Index;
end;


{ TfrxDataTreeForm }

constructor TfrxDataTreeForm.Create(AOwner: TComponent);
var
  aTabItem: TTabItem;
begin
  inherited;
  //FImages := frxResources.MainButtonImages;
  DataTree := TfrxTreeView.Create(Self);

  DataTree.Parent := DataPn;
  DataTree.Align := TAlignLayout.alClient;
  DataTree.OnDblClick := DataTreeDblClick;
{$IFDEF DELPHI18}
  DataTree.DragMode := TDragMode.dmManual;
  DataPn.Margins.Top := Rectangle1.Height;
  DataTree.ManualDragAndDrop := True;
{$ELSE}
  DataTree.DragMode := TDragMode.dmAutomatic;
{$ENDIF}
  DataTree.SetImages(frxResources.Images);
  DataTree.AutoCapture := False;

  VariablesTree := TfrxTreeView.Create(Self);
  VariablesTree.Parent := VariablesPn;
  VariablesTree.Align := TAlignLayout.alClient;
  VariablesTree.OnDblClick := DataTreeDblClick;
{$IFDEF DELPHI18}
  VariablesTree.DragMode := TDragMode.dmManual;
  VariablesTree.Margins.Top := Rectangle1.Height;
  VariablesTree.ManualDragAndDrop := True;
{$ELSE}
  VariablesTree.DragMode := TDragMode.dmAutomatic;
{$ENDIF}
  VariablesTree.SetImages(frxResources.Images);
  VariablesTree.AutoCapture := False;

  FunctionsTree := TfrxTreeView.Create(Self);
  FunctionsTree.Parent := FunctionsPn;
  FunctionsTree.Align := TAlignLayout.alClient;
  FunctionsTree.OnDblClick := DataTreeDblClick;
  FunctionsTree.OnChange := FunctionsTreeChange;
{$IFDEF DELPHI18}
  FunctionsTree.DragMode := TDragMode.dmManual;
  FunctionsTree.Margins.Top := Rectangle1.Height;
  FunctionsTree.ManualDragAndDrop := True;
{$ELSE}
  FunctionsTree.DragMode := TDragMode.dmAutomatic;
{$ENDIF}
  FunctionsTree.SetImages(frxResources.Images);
  FunctionsTree.AutoCapture := False;

  ClassesTree := TfrxTreeView.Create(Self);
  ClassesTree.Parent := ClassesPn;
  ClassesTree.Align := TAlignLayout.alClient;
  ClassesTree.OnDblClick := DataTreeDblClick;
{$IFDEF DELPHI18}
  ClassesTree.DragMode := TDragMode.dmManual;
  ClassesTree.Margins.Top := Rectangle1.Height;
  ClassesTree.ManualDragAndDrop := True;
{$ELSE}
  ClassesTree.DragMode := TDragMode.dmAutomatic;
{$ENDIF}
  ClassesTree.SetImages(frxResources.Images);
  ClassesTree.AutoCapture := False;

  FXML := TfsXMLDocument.Create;
  FFirstTime := True;

  FTabs := TTabControl.Create(Self);
  FTabs.Parent := MainDataPanel;
{$IFDEF Delphi17}
  FTabs.TabHeight := 21;
{$ENDIF}
  FTabs.SetBounds(0, 0, 40, 20);
  FTabs.Align := TAlignLayout.alTop;
  MainDataPanel.StyleLookup := 'backgroundstyle';
  CBPanel.StyleLookup := 'backgroundstyle';

  Label1.Text := frxGet(2100);

  aTabItem := TTabItem.Create(FTabs);
  aTabItem.TagObject := DataPn;
  aTabItem.Text := frxGet(2101);
  FTabs.AddObject(aTabItem);

  aTabItem := TTabItem.Create(FTabs);
  aTabItem.TagObject := VariablesPn;
  aTabItem.Text := frxGet(2102);
  FTabs.AddObject(aTabItem);

  aTabItem := TTabItem.Create(FTabs);
  aTabItem.TagObject := FunctionsPn;
  aTabItem.Text := frxGet(2103);
  FTabs.AddObject(aTabItem);

  aTabItem := TTabItem.Create(FTabs);
  aTabItem.TagObject := ClassesPn;
  aTabItem.Text := frxGet(2106);
  FTabs.AddObject(aTabItem);

  FTabs.TabIndex := 0;
  InsFieldCB.Text := frxGet(2104);
  InsCaptionCB.Text := frxGet(2105);
  SortCB.Text := frxGet(6004);
  FTabs.OnChange := TabsChange;

end;

destructor TfrxDataTreeForm.Destroy;
begin
  if Owner is TfrxCustomDesigner then
    CollapsedNodes := GetCollapsedNodes;
  FUpdating := True;
  FXML.Free;
  inherited;
end;

procedure TfrxDataTreeForm.FillDataTree;
var
  ds: TfrxDataSet;
  DatasetsList, FieldsList: TStrings;
  i, j: Integer;
  Root, Node1, Node2: TfrxTreeViewItem;
  s, Collapsed: String;

begin
  DatasetsList := TStringList.Create;
  FieldsList := TStringList.Create;
  TStringList(FieldsList).Sorted := SortCB.IsChecked;
  TStringList(DatasetsList).Sorted := SortCB.IsChecked;

  FReport.GetDataSetList(DatasetsList);

  try
    if FFirstTime then
      Collapsed := CollapsedNodes
    else
      Collapsed := GetCollapsedNodes;

    DataTree.BeginUpdate;
    DataTree.Clear;
    if DatasetsList.Count = 0 then
    begin
      NoDataL.Text := frxResources.Get('dtNoData') + #13#10#13#10 +
        frxResources.Get('dtNoData1');
      NoDataL.BringToFront;
      NoDataL.Visible := True;
    end
    else
    begin
      NoDataL.Visible := False;
      s := frxResources.Get('dtData');

      Root := DataTree.AddItem(DataTree, s);// DataTree.Items.AddChild(nil, s);
      SetImageIndex(Root, 72);

      for i := 0 to DatasetsList.Count - 1 do
      begin
        ds := TfrxDataSet(DatasetsList.Objects[i]);
        if ds = nil then continue;
        try
          ds.GetFieldList(FieldsList);
        except
        end;

        Node1 := DataTree.AddItem(Root, FReport.GetAlias(ds));//DataTree.Items.AddChild(Root, FReport.GetAlias(ds));
        Node1.Data := ds;
        SetImageIndex(Node1, 72);

        for j := 0 to FieldsList.Count - 1 do
        begin
          Node2 := DataTree.AddItem(Node1, FieldsList[j]);//DataTree.Items.AddChild(Node1, FieldsList[j]);
          Node2.Data := ds;
          SetImageIndex(Node2, 54);
        end;
      end;
      DataTree.Items[0].IsExpanded := True;
      for i := 0 to DataTree.Items[0].Count - 1 do
      begin
        s := DataTree.Items[0][i].Text;
        if Pos(s + ',', Collapsed) = 0 then
          DataTree.Items[0][i].IsExpanded := True;
      end;
    end;
  finally
    DataTree.EndUpdate;
    DatasetsList.Free;
    FieldsList.Free;
  end;
end;

procedure TfrxDataTreeForm.FillVariablesTree;
var
  CategoriesList, VariablesList: TStrings;
  i: Integer;
  Root, Node: TfrxTreeViewItem;

  procedure AddVariables(Node: TfrxTreeViewItem);
  var
    i: Integer;
    Node1: TfrxTreeViewItem;
  begin
    for i := 0 to VariablesList.Count - 1 do
    begin
      Node1 := VariablesTree.AddItem(Node, VariablesList[i]);
      SetImageIndex(Node1, 224);
    end;
  end;

  procedure AddSystemVariables;
  var
    SysNode: TfrxTreeViewItem;

    procedure AddNode(const s: String);
    var
      Node: TfrxTreeViewItem;
    begin
      Node := VariablesTree.AddItem(SysNode, s);
      SetImageIndex(Node, 224);
    end;

  begin
    SysNode := VariablesTree.AddItem(Root, frxResources.Get('dtSysVar'));
    SetImageIndex(SysNode, 66);

    AddNode('Date');
    AddNode('Time');
    AddNode('Page');
    AddNode('Page#');
    AddNode('TotalPages');
    AddNode('TotalPages#');
    AddNode('Line');
    AddNode('Line#');
    AddNode('CopyName#');
  end;

begin
  CategoriesList := TStringList.Create;
  VariablesList := TStringList.Create;
  FReport.Variables.GetCategoriesList(CategoriesList);

  VariablesTree.BeginUpdate;
  VariablesTree.Clear;
  Root := VariablesTree.AddItem(VariablesTree, frxResources.Get('dtVar'));
  SetImageIndex(Root, 66);

  for i := 0 to CategoriesList.Count - 1 do
  begin
    FReport.Variables.GetVariablesList(CategoriesList[i], VariablesList);
    Node := VariablesTree.AddItem(Root, CategoriesList[i]);
    SetImageIndex(Node, 66);
    AddVariables(Node);
  end;

  if CategoriesList.Count = 0 then
  begin
    FReport.Variables.GetVariablesList('', VariablesList);
    AddVariables(Root);
  end;

  AddSystemVariables;

  VariablesTree.ExpandAll;
  //VariablesTree.TopItem := Root;
  VariablesTree.EndUpdate;
  CategoriesList.Free;
  VariablesList.Free;
end;

procedure TfrxDataTreeForm.FillFunctionsTree;

  procedure AddFunctions(xi: TfsXMLItem; Root: TfrxTreeViewItem);
  var
    i: Integer;
    Node: TfrxTreeViewItem;
    s: String;
  begin
    s := xi.Prop['text'];
    if xi.Count = 0 then
      s := Copy(s, Pos(' ', s) + 1, 255) else  { function }
      s := frxResources.Get(s);                { category }

    if CompareText(s, 'hidden') = 0 then Exit;
    if Root = nil then
      Node := FunctionsTree.AddItem(FunctionsTree, s)
    else
      Node := FunctionsTree.AddItem(Root, s);
    if xi.Count = 0 then
      Node.Data := xi;
    if Root = nil then
      Node.Text := frxResources.Get('dtFunc');
    if xi.Count = 0 then
      SetImageIndex(Node, 52) else
      SetImageIndex(Node, 66);

    for i := 0 to xi.Count - 1 do
      AddFunctions(xi[i], Node);
  end;

begin
  FUpdating := True;

  FunctionsTree.BeginUpdate;
  FunctionsTree.Clear;
  AddFunctions(FXML.Root.FindItem('Functions'), nil);

  FunctionsTree.ExpandAll;
  //FunctionsTree.TopItem := FunctionsTree.Items[0];
  FunctionsTree.EndUpdate;
  FUpdating := False;
end;

procedure TfrxDataTreeForm.FillClassesTree;

  procedure AddClasses(xi: TfsXMLItem; Root: TfrxTreeViewItem);
  var
    i: Integer;
    Node: TfrxTreeViewItem;
    s: String;
  begin
    s := xi.Prop['text'];




    if Root = nil then
    begin
      Node := ClassesTree.AddItem(ClassesTree, s);
      Node.Text := frxResources.Get('2106');
      SetImageIndex(Node, 66);
    end
    else
    begin
      Node := ClassesTree.AddItem(Root, s);
      SetImageIndex(Node, 78);
    end;
    Node.Data := xi;

    if Root = nil then
    begin
      for i := 0 to xi.Count - 1 do
        AddClasses(xi[i], Node);
    end
    else
      ClassesTree.AddItem(Node, 'more...');  // do not localize
  end;

begin
  FUpdating := True;

  ClassesTree.BeginUpdate;
  ClassesTree.Clear;
  AddClasses(FXML.Root.FindItem('Classes'), nil);

  //ClassesTree.TopItem := ClassesTree.Items[0];
  //ClassesTree.TopItem.Expand(False);
  ClassesTree.EndUpdate;
  FUpdating := False;
end;

function TfrxDataTreeForm.GetCollapsedNodes: String;
var
  i: Integer;
  s: String;
begin
  Result := '';
  if DataTree.Count > 0 then
    for i := 0 to DataTree.Count - 1 do
    begin
      if DataTree.Items[i] is TTreeViewItem then
      begin
        s := DataTree.Items[i].Text;
        if not DataTree.Items[i].ISExpanded then
          Result := Result + s + ',';
      end;
    end;
end;

function TfrxDataTreeForm.GetFieldName: String;
var
  i, n: Integer;
  s: String;
  Node: TfrxTreeViewItem;
begin
  Result := '';
  if FTabs.TabIndex = 0 then   // data
  begin
    Node := TfrxTreeViewItem(DataTree.Selected);
    if (Node <> nil) and (Node.Count = 0) and (Node.Data <> nil) then
      Result := '<' + FReport.GetAlias(TfrxDataSet(Node.Data)) +
        '."' + Node.Text + '"' + '>';
  end
  else if FTabs.TabIndex = 1 then  // variables
  begin
    Node := TfrxTreeViewItem(VariablesTree.Selected);
    if (Node <> nil) and (Node.Count = 0) then
      if Node.Data <> nil then
        Result := Node.Text else
        Result := '<' + Node.Text + '>';
  end
  else if FTabs.TabIndex = 2 then  // functions
  begin
    if (FunctionsTree.Selected <> nil) and (FunctionsTree.Selected.Count = 0) then
    begin
      s := FunctionsTree.Selected.Text;
      if Pos('(', s) <> 0 then
        n := 1 else
        n := 0;
      for i := 1 to Length(s) do
        if CharInSet(s[i], [',', ';']) then
          Inc(n);

      if n = 0 then
        s := Copy(s, 1, Pos(':', s) - 1)
      else
      begin
        s := Copy(s, 1, Pos('(', s));
        for i := 1 to n - 1 do
          s := s + ',';
        s := s + ')';
      end;
      Result := s;
    end;
  end;
end;

function TfrxDataTreeForm.IsDataField: Boolean;
begin
  Result := FTabs.TabIndex = 0;
end;

procedure TfrxDataTreeForm.MainDataPanelDragEnd(Sender: TObject);
begin
ShowMessage('');
end;

procedure TfrxDataTreeForm.UpdateItems;
begin
// XE3 bug - reset TCustomTreeView.FHoveredItem
  //THackTreeView(DataTree).MouseMove([], -1, -1);
  //THackTreeView(VariablesTree).MouseMove([], -1, -1);
  //THackTreeView(FunctionsTree).MouseMove([], -1, -1);
  //THackTreeView(ClassesTree).MouseMove([], -1, -1);

  FillDataTree;
  FillVariablesTree;
  FFirstTime := False;
end;

procedure TfrxDataTreeForm.FormResize(Sender: TObject);
begin
  UpdateSize;
end;

{procedure TfrxDataTreeForm.DataTreeCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Node.Count <> 0 then
    Sender.Canvas.Font.Style := [fsBold];
end;

procedure TfrxDataTreeForm.ClassesTreeCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Node.Level = 0 then
    Sender.Canvas.Font.Style := [fsBold];
end;}

procedure TfrxDataTreeForm.FunctionsTreeChange(Sender: TObject);
var
  xi: TfsXMLItem;
  Node: TfrxTreeViewItem;
begin
  if FUpdating then Exit;
  Node := TfrxTreeViewItem(FunctionsTree.Selected);
  if (Node = nil) or (Node.Data = nil) then
  begin
    FunctionNameL.Text := '';
    FunctionDescL.Text := '';
    Exit;
  end
  else
  begin
    xi := TfsXMLItem(Node.Data);
    FunctionNameL.Text := xi.Prop['text'];
    FunctionDescL.Text := frxResources.Get(xi.Prop['description']);
    FunctionNameL.AutoSize := True;
  end;
end;

procedure TfrxDataTreeForm.DataTreeDblClick(Sender: TObject);
begin
  if Assigned(MainDataPanel.OnDblClick) then
    MainDataPanel.OnDblClick(Sender);
end;

//procedure TfrxDataTreeForm.ClassesTreeExpanding(Sender: TObject;
//  Node: TfrxTreeViewItem; var AllowExpansion: Boolean);
//var
//  i: Integer;
//  xi: TfsXMLItem;
//  s: String;
//  n: TfrxTreeViewItem;
//begin
//  if (Node.Level = 1) and (Node.Data <> nil) then
//  begin
//    FUpdating := True;
//    ClassesTree.BeginUpdate;
//
//    Node.;
//    xi := TfsXMLItem(Node.Data);
//    Node.Data := nil;
//
//    for i := 0 to xi.Count - 1 do
//    begin
//      s := xi[i].Prop['text'];
//      n := ClassesTree.Items.AddChild(Node, s);
//      if Pos('property', s) = 1 then
//        SetImageIndex(n, 73)
//      else if Pos('event', s) = 1 then
//        SetImageIndex(n, 79)
//      else
//        SetImageIndex(n, 74);
//    end;
//
//    ClassesTree.Items.EndUpdate;
//    FUpdating := False;
//  end;
//end;

function TfrxDataTreeForm.GetLastPosition: TPoint;
var
  Item: TTreeViewItem;
begin
  Result.X := FTabs.TabIndex;
  Result.Y := 0;
  Item := nil;
  case Result.X of
    0: Item := DataTree.Items[0];
    1: Item := VariablesTree.Items[0];
    2: Item := FunctionsTree.Items[0];
    3: Item := ClassesTree.Items[0];
  end;
  if Item <> nil then
    Result.Y := Item.GlobalIndex;
end;

procedure TfrxDataTreeForm.SetLastPosition(p: TPoint);
begin
  ShowTab(p.X);
  case p.X of
    0: if DataTree.Count > 0 then DataTree.Selected := DataTree.Items[p.Y];
    1: if VariablesTree.Count > 0 then VariablesTree.Selected := VariablesTree.Items[p.Y];
    2: if FunctionsTree.Count > 0 then FunctionsTree.Selected := FunctionsTree.Items[p.Y];
    3: if ClassesTree.Count > 0 then ClassesTree.Selected := ClassesTree.Items[p.Y];
  end;
end;

procedure TfrxDataTreeForm.TabsChange(Sender: TObject);
begin
  ShowTab(FTabs.TabIndex);
end;

procedure TfrxDataTreeForm.ShowTab(Index: Integer);
var
  i: Integer;
begin
  if (Index < 0) or (Index > FTabs.TabCount - 1) then Exit;
  FTabs.TabIndex := Index;
  for i := 0 to FTabs.TabCount - 1 do
    TControl(FTabs.Tabs[i].TagObject).Visible := i = Index;

  if FXML.Root.Count = 0 then
  begin
    FReport.Script.AddRTTI;
    GenerateXMLContents(FReport.Script, FXML.Root);
  end;

  if (Index = 2) and (FunctionsTree.Count < 2) then
    FillFunctionsTree;
  if (Index = 3) and (ClassesTree.Count < 2) then
    FillClassesTree;
end;



procedure TfrxDataTreeForm.UpdateSize;
var
  Y: Integer;
begin
  with FTabs.Parent do
  begin
    //if Screen.PixelsPerInch > 96 then
    //  Y := 26
    //else
      Y := 21;
    FTabs.SetBounds(0, Rectangle1.Height, MainDataPanel.Width, Y);
    Y := Round(FTabs.Position.Y + FTabs.Height);
    DataPn.SetBounds(0, Y, MainDataPanel.Width, MainDataPanel.Height - Y);
    VariablesPn.SetBounds(0, Y, MainDataPanel.Width, MainDataPanel.Height - Y+1);
    FunctionsPn.SetBounds(0, Y, MainDataPanel.Width, MainDataPanel.Height - Y+1);
    ClassesPn.SetBounds(0, Y, MainDataPanel.Width, MainDataPanel.Height - Y+1);
    NoDataL.SetBounds(10, {$IFDEF DELPHI18}20{$ELSE}10{$ENDIF}, MainDataPanel.Width - 20, MainDataPanel.Height - Y);
  end;
  InsCaptionCB.Width := DataPn.Width;
  SortCB.Width := DataPn.Width;
  InsFieldCB.Width := DataPn.Width;
  CBPanel.Width := DataPn.Width;
  FunctionNameL.AutoSize := False;
  FunctionNameL.AutoSize := True;
end;

function TfrxDataTreeForm.GetActivePage: Integer;
begin
  Result := FTabs.TabIndex;
end;

procedure TfrxDataTreeForm.UpdateSelection;
var
  i: Integer;
begin
  if GetActivePage = 0 then
  begin
    DataTree.Selected := nil;
    if (Report.Designer.SelectedObjects.Count = 1) and
      (TObject(Report.Designer.SelectedObjects[0]) is TfrxDataset) then
    begin
      if  (DataTree.Count > 0) then
      for i := 0 to DataTree.Items[0].Count - 1 do
        if TfrxTreeViewItem(DataTree.Items[0].Items[i]).Data = Report.Designer.SelectedObjects[0] then
        begin
          DataTree.Selected := DataTree.Items[0].Items[i];
          break;
        end;
    end;
  end;
end;

procedure TfrxDataTreeForm.SortCBClick(Sender: TObject);
begin
  FillDataTree;
end;

end.


//56db3b0f55102b9488a240d37950543f