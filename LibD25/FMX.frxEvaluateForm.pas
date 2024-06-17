
{******************************************}
{                                          }
{             FastReport v4.0              }
{             Evaluate dialog              }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEvaluateForm;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.fs_iinterpreter, FMX.Layouts, FMX.Memo, FMX.Edit, FMX.Types, System.Variants
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};

type
  TfrxEvaluateForm = class(TForm)
    Label1: TLabel;
    ExpressionE: TEdit;
    Label2: TLabel;
    ResultM: TMemo;
    OkB: TButton;
    CancelB: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
  private
    FScript: TfsScript;
    FIsWatch: Boolean;
  public
    property IsWatch: Boolean read FIsWatch write FIsWatch;
    property Script: TfsScript read FScript write FScript;
  end;


implementation

{$R *.FMX}

uses FMX.frxRes;


procedure TfrxEvaluateForm.FormShow(Sender: TObject);
begin
  ExpressionE.SelectAll;
  ResultM.Text := '';
  if IsWatch then
  begin
    OkB.Visible := True;
    CancelB.Visible := True;
    ResultM.Visible := False;
    Label2.Visible := False;
    ClientHeight := Round(OkB.Position.Y + OkB.Height + 4);
  end;
end;

procedure TfrxEvaluateForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(5500);
  Label1.Text := frxGet(5501);
  Label2.Text := frxGet(5502);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  FormShow(Self);
  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
end;

procedure TfrxEvaluateForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
var
  v: Variant;
  s: String;
begin
  if IsWatch then Exit;
  if Key = vkReturn then
  begin
    v := FScript.Evaluate(ExpressionE.Text);
    s := VarToStr(v);
    if TVarData(v).VType = varBoolean then
      if Boolean(v) = True then
        s := 'True' else
        s := 'False'
    else if (TVarData(v).VType = varString) or (TVarData(v).VType = varOleStr)
      or (TVarData(v).VType = varOleStr) then
      s := '''' + v + ''''
    else if v = Null then
      s := 'Null';
    ResultM.Text := s;
    ExpressionE.SelectAll;
  end
  else if Key = VKESCAPE then
    Close;
  //if Key = VKESCAPE then
 //   ModalResult := mrCancel;
  if Key = VKF1 then
    frxResources.Help(Self);
end;

end.
