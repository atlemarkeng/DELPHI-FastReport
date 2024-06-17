
{******************************************}
{                                          }
{             FastReport v4.0              }
{              Search dialog               }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxSearchDialog;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.Classes, System.UITypes,
  FMX.Controls, FMX.Forms, FMX.Edit, FMX.Types
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};

type
  TfrxSearchDialog = class(TForm)
    ReplacePanel: TPanel;
    ReplaceL: TLabel;
    ReplaceE: TEdit;
    Panel2: TPanel;
    TextL: TLabel;
    TextE: TEdit;
    Panel3: TPanel;
    OkB: TButton;
    CancelB: TButton;
    SearchL: TGroupBox;
    CaseCB: TCheckBox;
    TopCB: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
  end;


implementation

{$R *.FMX}

uses 
  FMX.frxRes, FMX.frxFMX;

var
  LastText: String;

procedure TfrxSearchDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then
    LastText := TextE.Text;
end;

procedure TfrxSearchDialog.FormCreate(Sender: TObject);
begin
  Caption := frxGet(300);
  TextL.Text := frxGet(301);
  SearchL.Text := frxGet(302);
  ReplaceL.Text := frxGet(303);
  TopCB.Text := frxGet(304);
  CaseCB.Text := frxGet(305);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  TextE.Text := LastText;
end;

procedure TfrxSearchDialog.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxSearchDialog.FormActivate(Sender: TObject);
begin
  TextE.SetFocus;
  TextE.SelectAll;
end;

end.


