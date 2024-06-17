
{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{               SQL editor                 }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditSQL;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, FMX.Controls, System.UITypes, System.UIConsts,
  FMX.Forms, FMX.Dialogs, FMX.fs_SynMemo, FMX.frxFMX,
  FMX.frxCustomDB
, System.Variants, FMX.Types
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF QBUILDER}
, FMX.fqbClass
{$ENDIF};


type
  TfrxSQLEditorForm = class(TForm)
    ToolBar: TToolBar;
    OkB: TfrxToolButton;
    CancelB: TfrxToolButton;
    QBB: TfrxToolButton;
    ParamsB: TfrxToolButton;
    procedure OkBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure QBBClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ParamsBClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FMemo: TfsSyntaxMemo;
    FQuery: TfrxCustomQuery;
{$IFDEF QBUILDER}
    FQBEngine: TfqbEngine;
{$ENDIF}
    FSaveSQL: TStrings;
    FSaveSchema: String;
    FSaveParams: TfrxParams;
  public
    { Public declarations }
    property Query: TfrxCustomQuery read FQuery write FQuery;
  end;


implementation

{$R *.FMX}

uses FMX.frxClass, FMX.frxRes, System.IniFiles, FMX.frxEditQueryParams;


procedure TfrxSQLEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormHide(Self);
end;

procedure TfrxSQLEditorForm.FormCreate(Sender: TObject);
begin
  FSaveSQL := TStringList.Create;
  FSaveParams := TfrxParams.Create;

  FMemo := TfsSyntaxMemo.Create(Self);
  with FMemo do
  begin
    Parent := Self;
    Align := alClient;
    SyntaxType := stSQL;
    ShowGutter := True;
//    GutterWidth := 20;
    Fill.Color := claWhite;
    OnKeyDown := MemoKeyDown;
{$I frxEditSQL.inc}
  end;
  frxResources.LoadImageFromResouce(QBB.Bitmap, 5, 8);
  frxResources.LoadImageFromResouce(ParamsB.Bitmap, 5, 6);
  frxResources.LoadImageFromResouce(OkB.Bitmap, 21, 0);
  frxResources.LoadImageFromResouce(CancelB.Bitmap, 21, 2);
{$IFDEF QBUILDER}
  QBB.Visible := True;
{$ENDIF}
  Caption := frxGet(4900);
  QBB.Hint := frxGet(4901);
  ParamsB.Hint := frxGet(5714);
  CancelB.Hint := frxGet(2);
  OkB.Hint := frxGet(1);

//  if UseRightToLeftAlignment then
//    FlipChildren(True);
end;

procedure TfrxSQLEditorForm.FormDestroy(Sender: TObject);
begin
  FSaveSQL.Free;
  FSaveParams.Free;
end;

procedure TfrxSQLEditorForm.FormShow(Sender: TObject);
var
  Ini: TCustomIniFile;
begin
  FSaveSQL.Assign(Query.SQL);
  FSaveParams.Assign(Query.Params);
  FSaveSchema := Query.SQLSchema;
{$IFDEF QBUILDER}
  FQBEngine := Query.QBEngine;
{$ENDIF}
  FMemo.Lines.Assign(Query.SQL);

  Ini := TfrxCustomDesigner(Owner).Report.GetIniFile;
  Ini.WriteBool('Form4.TfrxSQLEditorForm', 'Visible', True);
//  frxRestoreFormPosition(Ini, Self);
  Ini.Free;
end;

procedure TfrxSQLEditorForm.FormHide(Sender: TObject);
var
  Ini: TCustomIniFile;
begin
  if ModalResult = mrOk then
  begin
    Query.SQL.Assign(FMemo.Lines);
  end
  else
  begin
    Query.SQL.Assign(FSaveSQL);
    Query.Params.Assign(FSaveParams);
    Query.SQLSchema := FSaveSchema;
  end;

  Ini := TfrxCustomDesigner(Owner).Report.GetIniFile;
  //frxSaveFormPosition(Ini, Self);
  Ini.Free;
{$IFDEF QBUILDER}
  if FQBEngine <> nil then
    FQBEngine.Free;
{$ENDIF}
end;

procedure TfrxSQLEditorForm.OkBClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrxSQLEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrxSQLEditorForm.MemoKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if (Key = vkReturn) and (ssCtrl in Shift) then
    ModalResult := mrOk
  else if Key = vkEscape then
    ModalResult := mrCancel
  else if Key = vkF1 then
    frxResources.Help(Self);
end;

procedure TfrxSQLEditorForm.QBBClick(Sender: TObject);
{$IFDEF QBUILDER}
var
  fqbDialog: TfqbDialog;
{$ENDIF}
begin
{$IFDEF QBUILDER}
  fqbDialog := TfqbDialog.Create(nil);
  try
    fqbDialog.Engine := FQBEngine;
    fqbDialog.SchemaInsideSQL := False;
    fqbDialog.SQL := FMemo.Lines.Text;
    fqbDialog.SQLSchema := Query.SQLSchema;

    if fqbDialog.Execute then
    begin
      FMemo.Lines.Text := fqbDialog.SQL;
      Query.SQLSchema := fqbDialog.SQLSchema;
    end;
  finally
    fqbDialog.Free;
  end;
{$ENDIF}
end;

procedure TfrxSQLEditorForm.ParamsBClick(Sender: TObject);
begin
  Query.SQL.Assign(FMemo.Lines);
  if Query.Params.Count <> 0 then
    with TfrxParamsEditorForm.Create(Owner) do
    begin
      Params := Query.Params;
      FormShow(Self);
      if ShowModal = mrOk then
        Query.UpdateParams;
      Free;
    end;
end;

end.

