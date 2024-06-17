
{******************************************}
{                                          }
{             FastReport v4.0              }
{          Inherit error dialog            }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxInheritError;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.Classes, System.UITypes,
  FMX.Controls, FMX.Forms, FMX.Edit, FMX.Objects, FMX.Types
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};

type
  TfrxInheritErrorForm = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    MessageL: TLabel;
    DeleteRB: TRadioButton;
    RenameRB: TRadioButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.FMX}

uses
  FMX.frxRes;


procedure TfrxInheritErrorForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(6000);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  MessageL.Text := frxGet(6001);
  DeleteRB.Text := frxGet(6002);
  RenameRB.Text := frxGet(6003);
end;

end.
