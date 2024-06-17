
{******************************************}
{                                          }
{             FastReport v4.0              }
{             TStrings editor              }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditStrings;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Controls,
  FMX.Forms, FMX.Dialogs, FMX.ExtCtrls, FMX.Layouts,
  FMX.Memo, FMX.Types, FMX.frxFMX
, System.Variants
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};
  

type
  TfrxStringsEditorForm = class(TForm)
    ToolBar: TToolBar;
    OkB: TfrxToolButton;
    CancelB: TfrxToolButton;
    Memo: TMemo;
    procedure OkBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.FMX}

uses FMX.frxClass, FMX.frxRes;


procedure TfrxStringsEditorForm.OkBClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrxStringsEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrxStringsEditorForm.FormCreate(Sender: TObject);
begin
  //Toolbar.Images := frxResources.MainButtonImages;
  //todo images
  Caption := frxGet(4800);
  CancelB.Hint := frxGet(2);
  OkB.Hint := frxGet(1);

  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
end;

procedure TfrxStringsEditorForm.MemoKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if (Key = vkReturn) and (ssCtrl in Shift) then
    ModalResult := mrOk
  else if Key = vkEscape then
    ModalResult := mrCancel;
end;

procedure TfrxStringsEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

end.



//56db3b0f55102b9488a240d37950543f