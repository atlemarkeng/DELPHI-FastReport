
{******************************************}
{                                          }
{             FastReport v4.0              }
{              Picture editor              }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditPicture;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Controls,
  FMX.Forms, FMX.Dialogs, FMX.ExtCtrls, FMX.frxCtrls, FMX.frxBaseModalForm,
  FMX.Objects, FMX.Layouts, FMX.Types, FMX.frxFMX, System.Variants
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};
  

type
  TfrxPictureEditorForm = class(TfrxForm)
    ToolBar: TToolBar;
    LoadB: TfrxToolButton;
    ClearB: TfrxToolButton;
    OkB: TfrxToolButton;
    Box: TScrollBox;
    CancelB: TfrxToolButton;
    Image: TImage;
    StatusBar: TStatusBar;
    CopyB: TfrxToolButton;
    PasteB: TfrxToolButton;
    procedure ClearBClick(Sender: TObject);
    procedure LoadBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OkBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CopyBClick(Sender: TObject);
    procedure PasteBClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    //FStatusBarOldWindowProc: TWndMethod;
    //procedure StatusBarWndProc(var Message: TMessage);
    { Private declarations }
    procedure UpdateImage;
  public
    { Public declarations }
  end;


implementation

{$R *.FMX}

uses FMX.frxClass, FMX.frxUtils, FMX.frxRes, FMX.Platform ;


{ TfrxPictureEditorForm }

procedure TfrxPictureEditorForm.UpdateImage;
begin
//  if (Image.Bitmap = nil) or Image.Bitmap.IsEmpty then
//    StatusBar.Panels[0].Text := frxResources.Get('piEmpty')
//  else
//  begin
//    StatusBar. Panels[0].Text := Format('%d x %d',
//      [Image.Picture.Width, Image.Picture.Height]);
//    Image.Stretch := (Image.Picture.Width > Image.Width) or
//      (Image.Picture.Height > Image.Height);
//  end;
end;

procedure TfrxPictureEditorForm.FormShow(Sender: TObject);
begin
  //Toolbar.Images := frxResources.MainButtonImages;


end;

procedure TfrxPictureEditorForm.ClearBClick(Sender: TObject);
begin
  Image.Bitmap.Assign(nil);
  UpdateImage;
end;

procedure TfrxPictureEditorForm.LoadBClick(Sender: TObject);
var
  OpenDlg: TOpenDialog;
begin
  OpenDlg := TOpenDialog.Create(nil);
  OpenDlg.Options := [];
  OpenDlg.Filter := frxResources.Get('ftPictures') + ' (*.bmp ' +
{$IFDEF JPEG}
    '*.jpg ' +
{$ENDIF}
{$IFDEF PNG}
    '*.png ' +
{$ENDIF}
    '*.ico *.wmf *.emf)|*.bmp;' +
{$IFDEF JPEG}
    '*.jpg;' +
{$ENDIF}
{$IFDEF PNG}
    '*.png;' +
{$ENDIF}
    '*.ico;*.wmf;*.emf|' + frxResources.Get('ftAllFiles') + '|*.*';
  if OpenDlg.Execute then
    Image.Bitmap.LoadFromFile(OpenDlg.FileName);
  PeekLastModalResult;
  OpenDlg.Free;
  UpdateImage;
end;

procedure TfrxPictureEditorForm.OkBClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrxPictureEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrxPictureEditorForm.FormActivate(Sender: TObject);
begin
  UpdateImage;
end;

procedure TfrxPictureEditorForm.FormCreate(Sender: TObject);
begin
  //FStatusBarOldWindowProc := StatusBar.WindowProc;
  //StatusBar.WindowProc := StatusBarWndProc;
  Caption := frxGet(4000);
  LoadB.Hint := frxGet(4001);
  CopyB.Hint := frxGet(4002);
  PasteB.Hint := frxGet(4003);
  ClearB.Hint := frxGet(4004);
  CancelB.Hint := frxGet(2);
  OkB.Hint := frxGet(1);
  frxResources.LoadImageFromResouce(OkB.Bitmap, 21, 0);
  frxResources.LoadImageFromResouce(CancelB.Bitmap, 21, 2);
  frxResources.LoadImageFromResouce(ClearB.Bitmap, 8, 2);
  frxResources.LoadImageFromResouce(PasteB.Bitmap, 0, 7);
  frxResources.LoadImageFromResouce(CopyB.Bitmap, 0, 6);
  frxResources.LoadImageFromResouce(LoadB.Bitmap, 0, 1);
  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
end;

procedure TfrxPictureEditorForm.CopyBClick(Sender: TObject);
begin
  //if Image.Bitmap <> nil then
   //Platform.SetClipboard();
   // Clipboard.Assign(Image.Picture);
   //todo Platform.SetClipboard support only trxt clipboard
end;

procedure TfrxPictureEditorForm.PasteBClick(Sender: TObject);
begin
//    if Clipboard.HasFormat(CF_BITMAP) or Clipboard.HasFormat(CF_METAFILEPICT) or
//     Clipboard.HasFormat(CF_PICTURE) then
//    begin
//      Image.Picture.Assign(Clipboard);
//      UpdateImage;
//    end
//  else
//    ShowMessage(frxResources.Get('erInvalidImg'));
end;

procedure TfrxPictureEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

//procedure TfrxPictureEditorForm.StatusBarWndProc(var Message: TMessage);
//begin
//  if Message.Msg = WM_SYSCOLORCHANGE then
//    DefWindowProc(StatusBar.Handle,Message.Msg,Message.WParam,Message.LParam)
//  else
//    FStatusBarOldWindowProc(Message);
//end;

end.

