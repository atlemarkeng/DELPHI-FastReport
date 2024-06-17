
{******************************************}
{                                          }
{             FastReport v4.0              }
{               Report Tree                }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxReportTree;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, FMX.Objects, System.UITypes, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.frxClass, FMX.Types, FMX.Layouts, FMX.TreeView, FMX.frxFMX, System.Variants
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};


type
  TfrxReportTreeForm = class(TForm)
    MainPanel: TPanel;
    Rectangle1: TRectangle;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure TreeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FComponents: TList;
    FDesigner: TfrxCustomDesigner;
    FNodes: TList;
    FReport: TfrxReport;
    FUpdating: Boolean;
    FOnSelectionChanged: TNotifyEvent;
    Tree: TfrxTreeView;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateItems;
    procedure UpdateSelection;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged
      write FOnSelectionChanged;
    property Report: TfrxReport read FReport write FReport;
    property ReportTree: TfrxTreeView read Tree;
  end;


implementation

{$R *.FMX}

uses FMX.frxRes, FMX.frxDesgn, FMX.frxDsgnIntf;

type
  THackTreeView = class(TCustomTreeView);


{ TfrxReportTreeForm }

constructor TfrxReportTreeForm.Create(AOwner: TComponent);
begin
  inherited;
  FComponents := TList.Create;
  FNodes := TList.Create;
  Tree := TfrxTreeView.Create(Self);
  Tree.Parent := MainPanel;
  Tree.Align := TAlignLayout.alClient;
  Tree.SetImages(frxResources.Images);
  Tree.OnChange := TreeChange;
end;

destructor TfrxReportTreeForm.Destroy;
begin
  FComponents.Free;
  FNodes.Free;
  inherited;
end;

procedure TfrxReportTreeForm.FormShow(Sender: TObject);
begin
  UpdateItems;
end;

procedure TfrxReportTreeForm.UpdateItems;

  procedure SetImageIndex(Node: TfrxTreeViewItem; Index: Integer);
  begin
    Node.OpenImageIndex := Index;
    Node.CloseImageIndex := Index;
  end;

  procedure EnumItems(c: TfrxComponent; RootNode: TfrxTreeViewItem);
  var
    i: Integer;
    Node: TfrxTreeViewItem;
    Item: TfrxObjectItem;
  begin
    if (c is TfrxDataPage) and (frxDesignerComp <> nil) and
      (drDontEditInternalDatasets in frxDesignerComp.Restrictions) then
        Exit;

    Node := TfrxTreeViewItem.Create(Tree);
    //Node.Text := s;
    if RootNode <> nil then
      Node.Parent := RootNode
    else
      Node.Parent := Tree;
    Node.Parent.AddObject(Node);
    Node.Text := c.Name;
    //Node := Tree.Items.AddChild(RootNode, c.Name);
    FComponents.Add(c);
    FNodes.Add(Node);
    Node.Data := c;
    if c is TfrxReport then
    begin
      Node.Text := 'Report';
      SetImageIndex(Node, 134);
    end
    else if c is TfrxReportPage then
      SetImageIndex(Node, 135)
    else if c is TfrxDialogPage then
      SetImageIndex(Node, 136)
    else if c is TfrxDataPage then
      SetImageIndex(Node, 53)
    else if c is TfrxReportTitle then
      SetImageIndex(Node, 154)
    else if c is TfrxReportSummary then
      SetImageIndex(Node, 155)
    else if c is TfrxPageHeader then
      SetImageIndex(Node, 156)
    else if c is TfrxPageFooter then
      SetImageIndex(Node, 157)
    else if c is TfrxColumnHeader then
      SetImageIndex(Node, 158)
    else if c is TfrxColumnFooter then
      SetImageIndex(Node, 159)
    else if c is TfrxHeader then
      SetImageIndex(Node, 160)
    else if c is TfrxFooter then
      SetImageIndex(Node, 161)
    else if c is TfrxDataBand then
      SetImageIndex(Node, 162)
    else if c is TfrxGroupHeader then
      SetImageIndex(Node, 163)
    else if c is TfrxGroupFooter then
      SetImageIndex(Node, 164)
    else if c is TfrxChild then
      SetImageIndex(Node, 165)
    else if c is TfrxOverlay then
      SetImageIndex(Node, 166)
    else
    begin
      for i := 0 to frxObjects.Count - 1 do
      begin
        Item := frxObjects[i];
        if Item.ClassRef = c.ClassType then
        begin
          SetImageIndex(Node, Item.ButtonImageIndex);
          break;
        end;
      end;
    end;

    if c is TfrxDataPage then
    begin
      for i := 0 to c.Objects.Count - 1 do
        if TObject(c.Objects[i]) is TfrxDialogComponent then
          EnumItems(c.Objects[i], Node)
    end
    else
      for i := 0 to c.Objects.Count - 1 do
        EnumItems(c.Objects[i], Node);
  end;

begin
// XE3 bug - reset TCustomTreeView.FHoveredItem
  THackTreeView(Tree).MouseMove([], -1, -1);

  Tree.BeginUpdate;
  Tree.Clear;
  FComponents.Clear;
  FNodes.Clear;
  EnumItems(FReport, nil);
  //xe4 issue ,EndUpdate should be before update selection or it cause AV
  Tree.EndUpdate;
  Tree.ExpandAll;
  //xe4 issue need to call RealignContent after expanding
{$IFDEF DELPHI18}
  Tree.RealignContent;
{$ENDIF}
  UpdateSelection;

end;

procedure TfrxReportTreeForm.TreeChange(Sender: TObject);
begin
  if FUpdating or (Tree.Selected = nil) then Exit;
  FDesigner.SelectedObjects.Clear;
  FDesigner.SelectedObjects.Add(TfrxTreeViewItem(Tree.Selected).Data);
  if Assigned(FOnSelectionChanged) then
    FOnSelectionChanged(Self);
end;

procedure TfrxReportTreeForm.FormCreate(Sender: TObject);
begin
  FDesigner := TfrxCustomDesigner(Owner);
  FReport := FDesigner.Report;
  Label1.Text := frxGet(2200);
end;

procedure TfrxReportTreeForm.UpdateSelection;
var
  c: TComponent;
  i: Integer;
begin
  if FDesigner.SelectedObjects.Count = 0 then Exit;
  c := FDesigner.SelectedObjects[0];
  FUpdating := True;
  i := FComponents.IndexOf(c);
  if i <> -1 then
  begin
    Tree.Selected := FNodes[i];
    //Tree.Selected := Tree.ItemByGlobalIndex(i);
    //Tree.TopItem := TTreeNode(FNodes[i]);
  end;

  FUpdating := False;
end;

procedure TfrxReportTreeForm.TreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vkDelete then
  begin
    //THackWinControl(TfrxDesignerForm(FDesigner).Workspace).KeyDown(Key, Shift);
  end;
end;

end.


//56db3b0f55102b9488a240d37950543f