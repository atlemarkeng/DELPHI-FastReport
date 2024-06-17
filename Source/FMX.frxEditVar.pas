
{******************************************}
{                                          }
{             FastReport v4.0              }
{             Variables editor             }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditVar;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, System.Types, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.frxClass, FMX.frxVariables, FMX.frxDataTree, FMX.Memo, FMX.Types, FMX.frxFMX,
  FMX.Layouts, FMX.TreeView, System.Variants, FMX.Edit, FMX.frxBaseModalForm
 {$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI22}
  ,FMX.Memo.Types
{$ENDIF};


type
  TfrxVarEditorForm = class(TfrxForm)
    ToolBar: TToolBar;
    NewCategoryB: TfrxToolButton;
    NewVarB: TfrxToolButton;
    EditB: TfrxToolButton;
    DeleteB: TfrxToolButton;
    EditListB: TfrxToolButton;
    OkB: TfrxToolButton;
    CancelB: TfrxToolButton;
    ExprMemo: TMemo;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    ExprPanel: TPanel;
    LoadB: TfrxToolButton;
    SaveB: TfrxToolButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel: TPanel;
    VarTree: TfrxTreeView;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DeleteBClick(Sender: TObject);
    procedure NewCategoryBClick(Sender: TObject);
    procedure NewVarBClick(Sender: TObject);
    procedure OkBClick(Sender: TObject);
    procedure EditBClick(Sender: TObject);
    procedure VarTreeEdited(Sender: TObject; Node: TfrxTreeViewItem; var S: String);
    procedure ExprMemoDragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF; var Accept: Boolean);
    procedure ExprMemoDragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
    procedure VarTreeChange(Sender: TObject);
    procedure VarTreeChanging(Sender: TObject; OldNode: TfrxTreeViewItem; NewNode: TfrxTreeViewItem);
    //procedure VarTreeChanging(Sender: TObject; Node: TTreeNode;
     // var AllowChange: Boolean);
    procedure CancelBClick(Sender: TObject);
    procedure EditListBClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure LoadBClick(Sender: TObject);
    procedure SaveBClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure Splitter2Moved(Sender: TObject);
    procedure VarTreeResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ExprMemoChange(Sender: TObject);
    procedure ExprMemoEnter(Sender: TObject);
  private
    FReport: TfrxReport;
    FUpdating: Boolean;
    FVariables: TfrxVariables;
    FDataTree: TfrxDataTreeForm;
    FExprMemoModified: Boolean;
    FNodeOldText: String;
    function Root: TfrxTreeViewItem;
    procedure CreateUniqueName(var s: String);
    procedure FillVariables;
    procedure UpdateItem0;
    procedure OnDataTreeDblClick(Sender: TObject);
    procedure VarTreeKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
  public
  end;


implementation

{$R *.FMX}

uses FMX.frxEditStrings, FMX.frxUtils, FMX.frxRes, System.IniFiles;

var
  lastPosition: TPoint;


procedure SetImageIndex(Node: TfrxTreeViewItem; Index: Integer);
begin
  Node.OpenImageIndex := Index;
  Node.CloseImageIndex := Index;
end;

{ TfrxVarEditorForm }

procedure TfrxVarEditorForm.FormActivate(Sender: TObject);
begin
  if FDataTree <> nil then FDataTree.FormResize(FDataTree);
end;

procedure TfrxVarEditorForm.FormCreate(Sender: TObject);
begin

  FReport := TfrxCustomDesigner(Owner).Report;
  //VarTree.Images := frxResources.MainButtonImages;
  //Toolbar.Images := VarTree.Images;
  VarTree.Editable := True;
  VarTree.OnKeyDown := VarTreeKeyDown;

  FVariables := TfrxVariables.Create;
  FVariables.Assign(FReport.Variables);

  FDataTree := TfrxDataTreeForm.Create(Owner);
  FDataTree.Report := FReport;
  FDataTree.MainDataPanel.Parent := Self.Panel;
  FDataTree.MainDataPanel.Align := TAlignLayout.alClient;
  FDataTree.Visible := False;
  FDataTree.MainDataPanel.OnDblClick := OnDataTreeDblClick;
  //FDataTree.OnDblClick := OnDataTreeDblClick;
  //FDataTree.SetControlsParent(Panel);
  FDataTree.HintPanel.Height := 64;
  FDataTree.UpdateItems;

  Caption := frxGet(2900);
  NewCategoryB.Hint := frxGet(2901);
  NewVarB.Hint := frxGet(2902);
  EditB.Hint := frxGet(2903);
  DeleteB.Hint := frxGet(2904);
  EditListB.Hint := frxGet(2905);
  LoadB.Hint := frxGet(2906);
  SaveB.Hint := frxGet(2907);
  CancelB.Hint := frxGet(2);
  OkB.Hint := frxGet(1);
  OpenDialog1.Filter := frxGet(2909);
  SaveDialog1.Filter := frxGet(2910);
  VarTree.OnEdited := VarTreeEdited;
  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
  FillVariables;
  VarTree.SetFocus;
  FDataTree.SetLastPosition(lastPosition);
  frxResources.LoadImageFromResouce(NewCategoryB.Bitmap, 20, 2);
  frxResources.LoadImageFromResouce(NewVarB.Bitmap, 6, 0);
  frxResources.LoadImageFromResouce(EditB.Bitmap, 11, 3);
  frxResources.LoadImageFromResouce(DeleteB.Bitmap, 5, 1);
  frxResources.LoadImageFromResouce(EditListB.Bitmap, 10, 5);
  frxResources.LoadImageFromResouce(LoadB.Bitmap, 0, 1);
  frxResources.LoadImageFromResouce(SaveB.Bitmap, 0, 2);
  frxResources.LoadImageFromResouce(CancelB.Bitmap, 21, 2);
  frxResources.LoadImageFromResouce(OkB.Bitmap, 21, 0);
  VarTree.SetImages(frxResources.Images);
end;

procedure TfrxVarEditorForm.FormDestroy(Sender: TObject);
begin
  FDataTree.Free;
  FVariables.Free;
end;

procedure TfrxVarEditorForm.FormShow(Sender: TObject);
//var
//  Ini: TCustomIniFile;
begin
//  Ini := FReport.GetIniFile;
//  Ini.WriteBool('Form4.TfrxVarEditorForm', 'Visible', True);
//  frxRestoreFormPosition(Ini, Self);
//  ExprMemo.Height := Ini.ReadInteger('Form4.TfrxVarEditorForm', 'Split1Pos', 76);
//  Panel.Width := Ini.ReadInteger('Form4.TfrxVarEditorForm', 'Split2Pos', 400);
//  FDataTree.UpdateSize;
//  Ini.Free;


end;

procedure TfrxVarEditorForm.FormHide(Sender: TObject);
//var
//  Ini: TCustomIniFile;
begin
//  Ini := FReport.GetIniFile;
//  frxSaveFormPosition(Ini, Self);
//  Ini.WriteInteger('Form4.TfrxVarEditorForm', 'Split1Pos', ExprMemo.Height);
//  Ini.WriteInteger('Form4.TfrxVarEditorForm', 'Split2Pos', Panel.Width);
//  Ini.Free;
  lastPosition := FDataTree.GetLastPosition;
end;

procedure TfrxVarEditorForm.OkBClick(Sender: TObject);
begin
  FExprMemoModified := True; //save variable's value if OkB pressed without leaving of ExprMemo
  ModalResult := mrOk;
  VarTree.Selected := VarTree.ItemByGlobalIndex(0);
  FReport.Variables.Assign(FVariables);
end;

procedure TfrxVarEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TfrxVarEditorForm.Root: TfrxTreeViewItem;
begin
  //VarTree.UpdateGlobalIndexes;
//  Result := TfrxTreeViewItem(VarTree.ItemByGlobalIndex(0));
  Result := TfrxTreeViewItem(VarTree.Items[0]);
end;

procedure TfrxVarEditorForm.UpdateItem0;
begin
  if Root.Count = 0 then
    Root.Text := frxResources.Get('vaNoVar') else
    Root.Text := frxResources.Get('vaVar');
end;

procedure TfrxVarEditorForm.CreateUniqueName(var s: String);
var
  i: Integer;
begin
  i := 0;
  repeat
    Inc(i);
  until FVariables.IndexOf(s + IntToStr(i)) = -1;
  s := s + IntToStr(i);
end;

procedure TfrxVarEditorForm.FillVariables;
var
  i: Integer;
  CategoriesList, VariablesList: TStrings;
  Node: TfrxTreeViewItem;

  procedure AddVariables(Node: TfrxTreeViewItem);
  var
    i: Integer;
    Node1: TfrxTreeViewItem;
  begin
    for i := 0 to VariablesList.Count - 1 do
    begin
      Node1 := VarTree.AddItem(Node, VariablesList[i]);
      SetImageIndex(Node1, 80);
    end;
  end;

begin
  FUpdating := True;
  CategoriesList := TStringList.Create;
  VariablesList := TStringList.Create;
  FVariables.GetCategoriesList(CategoriesList);

  VarTree.Clear;
  VarTree.AddItem(VarTree, '');


  SetImageIndex(Root, 66);
  VarTree.BeginUpdate;
  for i := 0 to CategoriesList.Count - 1 do
  begin
    FVariables.GetVariablesList(CategoriesList[i], VariablesList);
    Node := VarTree.AddItem(Root, CategoriesList[i]);
    SetImageIndex(Node, 66);
    AddVariables(Node);
  end;

  if CategoriesList.Count = 0 then
  begin
    FVariables.GetVariablesList('', VariablesList);
    AddVariables(Root);
  end;
  VarTree.EndUpdate;
  UpdateItem0;
  VarTree.ExpandAll;

  CategoriesList.Free;
  VariablesList.Free;
  FUpdating := False;
end;

procedure TfrxVarEditorForm.DeleteBClick(Sender: TObject);
var
  Node: TTreeViewItem;
begin
  Node := VarTree.Selected;
  if (Node = nil) or (Node = Root) then Exit;

  FUpdating := True;
  if Node.ParentItem <> Root then
    FVariables.DeleteVariable(Node.Text) else
    FVariables.DeleteCategory(Node.Text);
  Node.Free;
  FUpdating := False;
  UpdateItem0;
end;

procedure TfrxVarEditorForm.NewCategoryBClick(Sender: TObject);
var
  Node: TfrxTreeViewItem;
  s: String;
begin
  s := ' New Category';
  CreateUniqueName(s);
  VarTree.BeginUpdate;
  Node := VarTree.AddItem(Root, Trim(s));
  VarTree.EndUpdate;
  SetImageIndex(Node, 66);
  FVariables.Add.Name := s;
  VarTree.ExpandAll;
  UpdateItem0;
end;

procedure TfrxVarEditorForm.NewVarBClick(Sender: TObject);
var
  Node: TTreeViewItem;
  s: String;
begin
  if Root.Count = 0 then Exit;
  Node := VarTree.Selected;
  if (Node = nil) or (Node = Root) then
    Node := VarTree.ItemByGlobalIndex(Root.Count - 1)
  else if (Node.ParentItem <> Root) and (Node.ParentItem is TTreeViewItem) then
    Node := TTreeViewItem(Node.ParentItem);

  s := 'New Variable';
  CreateUniqueName(s);
  FVariables.AddVariable(Node.Text, s, '');
  VarTree.BeginUpdate;
  Node := VarTree.AddItem(Node, s);
  VarTree.EndUpdate;
  SetImageIndex(TfrxTreeViewItem(Node), 80);

  VarTree.ExpandAll;
  UpdateItem0;
end;

procedure TfrxVarEditorForm.EditBClick(Sender: TObject);
var
  Node: TTreeViewItem;
begin
  Node := VarTree.Selected;
  if (Node = nil) or (Node = Root) then Exit;
  VarTree.DoEdit;
end;

procedure TfrxVarEditorForm.VarTreeEdited(Sender: TObject; Node: TfrxTreeViewItem; var S: String);
var
  s1, s2: String;
begin
  if (FNodeOldText = s) or (Root.Count = 0) then Exit;
  s1 := s;
  s2 := FNodeOldText;

  if Node.ParentItem = Root then
  begin
    s1 := ' ' + s1;
    s2 := ' ' + s2;
  end;

  if FVariables.IndexOf(s1) <> -1 then
  begin
    s := FNodeOldText;
    frxErrorMsg(frxResources.Get('vaDupName'));
  end
  else
    FVariables.Items[FVariables.IndexOf(s2)].Name := s1;
end;

procedure TfrxVarEditorForm.VarTreeKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  case Key of
    vkInsert:
      if not VarTree.IsEditing then
        if Root.Count = 0 then
          NewCategoryBClick(nil) else
          NewVarBClick(nil);
    vkDelete:
      if not VarTree.IsEditing then
        DeleteBClick(nil);
    vkReturn, vkF2:
      if not VarTree.IsEditing then
        EditBClick(nil);
  end;
end;

procedure TfrxVarEditorForm.VarTreeResize(Sender: TObject);
begin
  if Assigned(FDataTree) then
    FDataTree.UpdateSize;
end;

procedure TfrxVarEditorForm.ExprMemoDragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF; var Accept: Boolean);
begin
  Accept := (Data.Source is TTreeView) and (TControl(Data.Source).Owner = FDataTree) and
    (FDataTree.GetFieldName <> '');
end;

procedure TfrxVarEditorForm.ExprMemoDragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
var
  SelStart: TCaretPosition;
  SelLen: Integer;
begin
  SelLen := ExprMemo.SelLength;
  SelStart := ExprMemo.TextPosToPos(ExprMemo.SelStart);
  ExprMemo.DeleteFrom(SelStart, SelLen, []);
  ExprMemo.InsertAfter(SelStart, FDataTree.GetFieldName, []);
end;

procedure TfrxVarEditorForm.ExprMemoEnter(Sender: TObject);
begin
     FExprMemoModified := False;
end;

procedure TfrxVarEditorForm.ExprMemoChange(Sender: TObject);
begin
     FExprMemoModified := True;
end;

procedure TfrxVarEditorForm.OnDataTreeDblClick(Sender: TObject);
var
  SelStart: TCaretPosition;
  SelLen: Integer;
begin
  SelLen := ExprMemo.SelLength;
  SelStart := ExprMemo.TextPosToPos(ExprMemo.SelStart);
  ExprMemo.DeleteFrom(SelStart, SelLen, []);
  ExprMemo.InsertAfter(SelStart, FDataTree.GetFieldName, []);
end;

procedure TfrxVarEditorForm.VarTreeChange(Sender: TObject);
begin
  if FUpdating then Exit;
  FNodeOldText := VarTree.Selected.Text;
  if (VarTree.Selected = nil) or (VarTree.Selected = Root) or (VarTree.Selected.ParentItem = Root) then
    ExprMemo.Text := '' else
    ExprMemo.Text := VarToStr(FVariables[VarTree.Selected.Text]);
end;

procedure TfrxVarEditorForm.VarTreeChanging(Sender: TObject; OldNode: TfrxTreeViewItem; NewNode: TfrxTreeViewItem);
begin
  if FUpdating then Exit;

  if FExprMemoModified then
    if not ((OldNode = nil) or (OldNode = Root) or (OldNode.ParentItem = Root) or (csDestroying in OldNode.ComponentState)) then
       begin
         FVariables[OldNode.Text] := ExprMemo.Text;
         FExprMemoModified := False;
       end;
end;

procedure TfrxVarEditorForm.EditListBClick(Sender: TObject);

  procedure VarToStrings(Lines: TStrings);
  var
    i: Integer;
    s: String;
  begin
    for i := 0 to FVariables.Count - 1 do
    begin
      s := FVariables.Items[i].Name;
      if s <> '' then
        if s[1] = ' ' then
          s := Copy(s, 2, 255) else
          s := ' ' + s;
      Lines.Add(s);
    end;
  end;

  procedure StringsToVar(Lines: TStrings);
  var
    i: Integer;
    v: TfrxVariables;
    s: String;
  begin
    v := TfrxVariables.Create;
    for i := 0 to Lines.Count - 1 do
    begin
      s := Lines[i];
      if Trim(s) <> '' then
      begin
        if s[1] = ' ' then
          s := Copy(s, 2, 255) else
          s := ' ' + s;
        if FVariables.IndexOf(s) <> -1 then
          v[s] := FVariables[s] else
          v[s] := '';
      end;
    end;

    FVariables.Assign(v);
    FillVariables;
    v.Free;
  end;

begin
  with TfrxStringsEditorForm.Create(Owner) do
  begin
    VarToStrings(Memo.Lines);
    if ShowModal = mrOk then
      StringsToVar(Memo.Lines);
    VarTree.Selected := VarTree.ItemByGlobalIndex(0);
    Free;
  end;
end;

procedure TfrxVarEditorForm.LoadBClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    FVariables.LoadFromFile(OpenDialog1.FileName);
    FillVariables;
  end;
  PeekLastModalResult;
end;

procedure TfrxVarEditorForm.SaveBClick(Sender: TObject);
begin
  VarTree.Selected := VarTree.Items[0];
  if SaveDialog1.Execute then
    FVariables.SaveToFile(SaveDialog1.FileName);
  PeekLastModalResult;
end;

procedure TfrxVarEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = vkReturn) then
    OkBClick(nil);
  if Key = VKESCAPE then
    CancelBClick(nil);
  if Key = VKF1 then
    frxResources.Help(Self);
end;

procedure TfrxVarEditorForm.Splitter2Moved(Sender: TObject);
begin
  if FDataTree <> nil then FDataTree.UpdateSize;
end;

end.
