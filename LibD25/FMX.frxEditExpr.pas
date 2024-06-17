
{******************************************}
{                                          }
{             FastReport v4.0              }
{            Expression Editor             }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditExpr;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.Types, System.UITypes, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.frxClass, FMX.ExtCtrls, FMX.frxDataTree,
  FMX.Types, FMX.Layouts, FMX.Memo, System.Variants
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI22}
  ,FMX.Memo.Types
{$ENDIF};
  

type
  TfrxExprEditorForm = class(TForm)
    ExprMemo: TMemo;
    Panel1: TPanel;
    OkB: TButton;
    CancelB: TButton;
    Splitter1: TSplitter;
    Panel2: TPanel;
    ExprL: TLabel;
    Panel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure ExprMemoDragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF; var Accept: Boolean);
    procedure ExprMemoDragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
  private
    FDataTree: TfrxDataTreeForm;
    FReport: TfrxReport;
    procedure OnDataTreeDblClick(Sender: TObject);
  public
  end;


implementation

{$R *.FMX}

uses 
  System.IniFiles, FMX.frxRes, FMX.TreeView, FMX.frxUtils;



{ TfrxExprEditorForm }

procedure TfrxExprEditorForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(4400);
  ExprL.Text := frxGet(4401);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);


  FReport := TfrxCustomDesigner(Owner).Report;
  FDataTree := TfrxDataTreeForm.Create(Self);
  FDataTree.Report := FReport;
  FDataTree.MainDataPanel.Parent := Panel;
  FDataTree.MainDataPanel.OnDblClick := OnDataTreeDblClick;
  //FDataTree.SetControlsParent(Panel);
  FDataTree.HintPanel.Height := 60;
  FDataTree.UpdateItems;
end;

procedure TfrxExprEditorForm.FormShow(Sender: TObject);
var
  Ini: TCustomIniFile;
begin
  Ini := FReport.GetIniFile;
  Ini.WriteBool('TfrxExprEditorForm', 'Visible', True);
  frxRestoreFormPosition(Ini, Self);
  Ini.Free;
//  FDataTree.SetLastPosition(lastPosition);
end;

procedure TfrxExprEditorForm.FormHide(Sender: TObject);
var
  Ini: TCustomIniFile;
begin
  Ini := FReport.GetIniFile;
  frxSaveFormPosition(Ini, Self);
  Ini.Free;
//  lastPosition := FDataTree.GetLastPosition;
end;

procedure TfrxExprEditorForm.OnDataTreeDblClick(Sender: TObject);
var
  SelStart: TCaretPosition;
  SelLen: Integer;
begin
  SelLen := ExprMemo.SelLength;
  SelStart := ExprMemo.TextPosToPos(ExprMemo.SelStart);
  ExprMemo.DeleteFrom(SelStart, SelLen, []);
  ExprMemo.InsertAfter(SelStart, FDataTree.GetFieldName, []);
  ExprMemo.SetFocus;
end;

procedure TfrxExprEditorForm.ExprMemoDragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF; var Accept: Boolean);
begin
  Accept := (Data.Source is TTreeView) and (TControl(Data.Source).Owner = FDataTree) and
    (FDataTree.GetFieldName <> '');
end;

procedure TfrxExprEditorForm.ExprMemoDragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
var
  SelStart: TCaretPosition;
  SelLen: Integer;
begin
  SelLen := ExprMemo.SelLength;
  SelStart := ExprMemo.TextPosToPos(ExprMemo.SelStart);
  ExprMemo.DeleteFrom(SelStart, SelLen, []);
  ExprMemo.InsertAfter(SelStart, FDataTree.GetFieldName, []);
  ExprMemo.SetFocus;
end;

procedure TfrxExprEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkF1 then
    frxResources.Help(Self);
end;

procedure TfrxExprEditorForm.FormResize(Sender: TObject);
begin
  FDataTree.UpdateSize;
end;

end.
