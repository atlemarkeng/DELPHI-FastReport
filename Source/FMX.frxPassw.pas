
{******************************************}
{                                          }
{             FastReport v4.0              }
{              Password form               }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxPassw;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.Classes, System.UITypes,
  FMX.Controls, FMX.Forms, FMX.Edit
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};



type
  TfrxPasswordForm = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    PasswordE: TEdit;
    PasswordL: TLabel;
    Image1: TImageControl;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;


implementation

//{$R *.dfm}

uses 
  FMX.frxRes;


procedure TfrxPasswordForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(5000);
  PasswordL.Text := frxGet(5001);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
end;

end.

