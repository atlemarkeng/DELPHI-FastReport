
{******************************************}
{                                          }
{             FastReport v4.0              }
{              About window                }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxAbout;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, System.Types, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.Objects, FMX.Types
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};

type
  TfrxAboutForm = class(TForm)
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Label5: TLabel;
    Shape1: TLine;
    Label1: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure LabelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses FMX.frxClass, FMX.frxUtils, FMX.frxRes
{$IFDEF MSWINDOWS}
 , Winapi.ShellAPI, Winapi.Windows
 {$ENDIF}
 {$IFDEF MACOS}
 , Posix.Stdlib
{$ENDIF};

{$R *.FMX}

procedure TfrxAboutForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(2600);
  Label4.Text := frxGet(2601);
  Label6.Text := frxGet(2602);
  Label8.Text := frxGet(2603);
  Label2.Text := 'Version ' + FR_VERSION;
  Label10.Text := #174;
  Label3.Text := '(c) 2011-' + FormatDateTime('YYYY', Now) + ' by Alexander Tzyganenko, Fast Reports Inc.';
end;

procedure TfrxAboutForm.LabelClick(Sender: TObject);
var
  sLink: String;
begin
  case TLabel(Sender).Tag of
    1: sLink := TLabel(Sender).Text;
    2: sLink := 'mailto:' + TLabel(Sender).Text;
  end;

{$IFDEF MSWINDOWS}
  ShellExecute(0, 'open', PChar(sLink), '', '', SW_SHOWNORMAL);
{$ENDIF}
{$IFDEF MACOS}
  _system(PAnsiChar('open ' + AnsiString(sLink)));
{$ENDIF}
end;

procedure TfrxAboutForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKESCAPE then
    ModalResult := mrCancel;
end;

end.

