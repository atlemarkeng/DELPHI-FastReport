
{******************************************}
{                                          }
{             FastReport v4.0              }
{               Dialog form                }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxDialogForm;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.Classes, System.UITypes,
  FMX.Controls, FMX.Forms;


type
  TfrxDialogForm = class(TForm)
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  protected
    procedure ReadState(Reader: TReader); override;
  private
    FOnModify: TNotifyEvent;
    FThreadSafe: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    property OnModify: TNotifyEvent read FOnModify write FOnModify;
    property ThreadSafe: Boolean read FThreadSafe write FThreadSafe;
  end;

implementation

{$R *.FMX}

{procedure TfrxDialogForm.WMExitSizeMove(var Msg: TMessage);
begin
  inherited;
  if Assigned(OnModify) then
    OnModify(Self);
end;}

procedure TfrxDialogForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
end;

procedure TfrxDialogForm.ReadState(Reader: TReader);
begin
  if not ThreadSafe then
    inherited ReadState(Reader);
end;

constructor TfrxDialogForm.Create(AOwner: TComponent);
begin
  if AOwner <> nil then
    FThreadSafe := AOwner.Tag = 318;
  AOwner := nil;

  inherited CreateNew(AOwner);
end;


end.
