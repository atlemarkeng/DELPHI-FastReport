
{******************************************}
{                                          }
{             FastReport v4.0              }
{                Progress                  }
{                                          }
{          Copyright (c) 2004-2008         }
{          by Alexander Fediachov,         }
{             Fast Reports, Inc.           }
{                                          }
{******************************************}

unit FMX.frxProgress;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.SysUtils, System.Classes, FMX.Forms, FMX.Controls, FMX.Types
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};

type
  TfrxProgress = class(TForm)
    Panel1: TPanel;
    LMessage: TLabel;
    Bar: TProgressBar;
    CancelB: TButton;
    procedure FormCreate(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
  private
    FActiveForm: TForm;
    FTerminated: Boolean;
    FPosition: Integer;
    FMessage: String;
    FProgress: Boolean;
    procedure SetPosition(Value: Integer);
    procedure SetMessage(const Value: String);
    procedure SetTerminated(Value: Boolean);
    procedure SetProgress(Value: Boolean);
  public
    procedure Reset;
    procedure Execute(MaxValue: Integer; const Msg: String;
      Canceled: Boolean; Progress: Boolean);
    procedure Tick;
    property Terminated: Boolean read FTerminated write SetTerminated;
    property Position: Integer read FPosition write SetPosition;
    property ShowProgress: Boolean read FProgress write SetProgress;
    property Message: String read FMessage write SetMessage;
  end;


implementation

{$R *.FMX}

uses 
  FMX.frxRes;


{ TfrxProgress }

procedure TfrxProgress.FormCreate(Sender: TObject);
begin
  CancelB.Text := frxGet(2);
  Bar.Min := 0;
  Bar.Max := 100;
  Position := 0;
end;

procedure TfrxProgress.Reset;
begin
  Position := 0;
end;

procedure TfrxProgress.SetPosition(Value: Integer);
begin
  FPosition := Value;
  Bar.Value := Value;
  BringToFront;
end;

procedure TfrxProgress.Execute(MaxValue: Integer; const Msg: String;
  Canceled: Boolean; Progress: Boolean);
begin
  Terminated := False;
  CancelB.Visible := Canceled;
  ShowProgress := Progress;
  Bar.Min := 0;
  Reset;
  Bar.Max := MaxValue;
  Message := Msg;
  Show;
end;

procedure TfrxProgress.Tick;
begin
  if (Position < Bar.Max) and (Position >= Bar.Min) then
    Position := Position + 1;
end;

procedure TfrxProgress.SetMessage(const Value: String);
begin
  FMessage := Value;
  LMessage.Text := Value;
  LMessage.Repaint;
end;

procedure TfrxProgress.CancelBClick(Sender: TObject);
begin
  Terminated := True;
end;

procedure TfrxProgress.SetTerminated(Value: boolean);
begin
  FTerminated := Value;
  if Value then Close;
end;

procedure TfrxProgress.SetProgress(Value: boolean);
begin
  Bar.Visible := Value;
  FProgress := Value;
  if Value then
    LMessage.Position.Y := 15
  else
    LMessage.Position.Y := 35;
end;

end.




//56db3b0f55102b9488a240d37950543f