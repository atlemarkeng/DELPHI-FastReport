unit FMX.frxBaseModalForm;

interface
{$I fmx.inc}
{$I frx.inc}

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs
{$IFDEF DELPHI18}
{$IFDEF MACoS}
  , Macapi.Foundation, FMX.Platform.Mac, Macapi.AppKit, Macapi.CocoaTypes
{$ENDIF}
{$ENDIF};

type
  TfrxForm = class(TForm)
  private
    FSession: Pointer;
    FFormClosed: Boolean;
{$IFDEF DELPHI18}
{$IFDEF MACoS}
    FNSWin: NSWindow;
    FNSApp: NSApplication;
{$ENDIF}
{$ENDIF}
  protected
    procedure DestroyHandle; override;
{$IFDEF DELPHI18}
    procedure DoClose(var CloseAction: TCloseAction); override;
{$ENDIF}
  public
    function CloseQuery: Boolean; override;
    function ShowModal: TModalResult; overload;
    procedure PeekLastModalResult;
    procedure BeginSesssion;
    procedure EndSession;
  end;

implementation
{ TfrxForm }

procedure TfrxForm.BeginSesssion;
begin
{$IFDEF DELPHI18}
{$IFDEF MACoS}
{$IFDEF DELPHI19}
  HandleNeed;
{$ENDIF}
  FNSApp := TNSApplication.Wrap(TNSApplication.OCClass.sharedApplication);
  FNSWin := WindowHandleToPlatform(Self.Handle).Wnd;
  if FNSWin <> nil then
    FNSWin.retain;
  FSession := FNSApp.beginModalSessionForWindow(FNSWin);
{$ENDIF}
{$ENDIF}
end;

function TfrxForm.CloseQuery: Boolean;
begin
{$IFDEF DELPHI18}
{$IFDEF MACoS}
  Result := True;
  if FFormClosed then Exit;
{$ENDIF}
{$ENDIF}
  Result := inherited;
end;

procedure TfrxForm.DestroyHandle;
begin
  inherited;
  EndSession;
end;

procedure TfrxForm.EndSession;
begin
{$IFDEF DELPHI18}
{$IFDEF MACoS}
  if (FSession <> nil) and (FNSApp <> nil) then
  begin
    FNSApp.runModalSession(FSession);
    FNSApp.endModalSession(FSession);
    FNSWin.release;
    FNSApp.release;
  end;
{$ENDIF}
{$ENDIF}
  FSession := nil;
end;

{$IFDEF DELPHI18}
procedure TfrxForm.DoClose(var CloseAction: TCloseAction);
begin
{$IFDEF MACoS}
  if FFormClosed then Exit; // skip restart modal session from TPlatformCocoa.ShowWindowModal
{$ENDIF}
  inherited;
{$IFDEF MACoS}
  if ModalResult <> mrNone then
    FFormClosed := True;
  EndSession;
  Application.HandleMessage;
{$ENDIF}
end;
{$ENDIF}

procedure TfrxForm.PeekLastModalResult;
begin
{$IFDEF DELPHI18}
{$IFDEF MACoS}
  if (FSession <> nil) and (FNSApp <> nil) then
    FNSApp.runModalSession(FSession);
{$ENDIF}
{$ENDIF}
end;

function TfrxForm.ShowModal: TModalResult;
begin
  BeginSesssion;
  FFormClosed := False;
  Result := inherited;
end;

end.
