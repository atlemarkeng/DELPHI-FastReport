
{******************************************}
{                                          }
{             FastReport v4.0              }
{     Parent form for pop-up controls      }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxPopupForm;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Platform,
  System.Variants;
  

type
  TfrxPopupForm = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frxPopupFormCloseTime: Single = 0;


implementation

{$R *.FMX}


procedure TfrxPopupForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  frxPopupFormCloseTime := Platform.GetTick;
  Release;
end;

end.
