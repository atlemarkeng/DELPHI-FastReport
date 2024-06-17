
{******************************************}
{                                          }
{             FastReport v4.0              }
{            Highlight editor              }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditHighlight;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Types, FMX.Controls, 
  FMX.Forms, FMX.Dialogs, FMX.frxClass, FMX.ExtCtrls, FMX.frxCtrls, 
  System.Variants, FMX.ListBox, FMX.Edit, System.UIConsts, FMX.Colors
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};


type
  TfrxHighlightEditorForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    ConditionL: TGroupBox;
    ConditionE: TfrxEditWithButton;
    FontL: TGroupBox;
    FontColorB: TColorComboBox;
    BoldCB: TCheckBox;
    ItalicCB: TCheckBox;
    UnderlineCB: TCheckBox;
    //ColorDialog1: TColorDialog;
    BackgroundL: TGroupBox;
    BackColorB: TColorComboBox;
    TransparentRB: TRadioButton;
    OtherRB: TRadioButton;
    procedure TransparentRBClick(Sender: TObject);
    procedure ConditionEButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FHighlight: TfrxHighlight;
    FMemoView: TfrxCustomMemoView;
  public
    property MemoView: TfrxCustomMemoView read FMemoView write FMemoView;
    procedure HostControls(Host: TFmxObject);
    procedure UnhostControls(AModalResult: TModalResult);
    procedure FormShow(Sender: TObject);
  end;


implementation

{$R *.FMX}

uses FMX.frxRes;


procedure TfrxHighlightEditorForm.FormShow(Sender: TObject);
begin
  FHighlight := FMemoView.Highlight;

  ConditionE.Text := FHighlight.Condition;
  BoldCB.IsChecked := TFontStyle.fsBold in FHighlight.Font.Style;
  ItalicCB.IsChecked := TFontStyle.fsItalic in FHighlight.Font.Style;
  UnderlineCB.IsChecked := TFontStyle.fsUnderline in FHighlight.Font.Style;
  FontColorB.Color := FHighlight.Font.Color;

  if FHighlight.Color = claNull then
    TransparentRB.IsChecked := True else
    OtherRB.IsChecked := True;
  BackColorB.Color := FHighlight.Color;

  TransparentRBClick(nil);
end;


procedure TfrxHighlightEditorForm.TransparentRBClick(Sender: TObject);
begin
  BackColorB.Enabled := OtherRB.IsChecked;
  if TransparentRB.IsChecked then
    BackColorB.Color := claNull;
end;

procedure TfrxHighlightEditorForm.ConditionEButtonClick(Sender: TObject);
var
  s: String;
begin
  s := TfrxCustomDesigner(Owner).InsertExpression(ConditionE.Text);
  if s <> '' then
    ConditionE.Text := s;
end;

procedure TfrxHighlightEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  fs: TFontStyles;
begin
  if ModalResult = mrOk then
  begin
    FHighlight.Condition := ConditionE.Text;

    fs := [];
    if BoldCB.IsChecked then
      fs := fs + [TFontStyle.fsBold];
    if ItalicCB.IsChecked then
      fs := fs + [TFontStyle.fsItalic];
    if UnderlineCB.IsChecked then
      fs := fs + [TFontStyle.fsUnderline];

    FHighlight.Font := MemoView.Font;
    FHighlight.Font.Style := fs;
    FHighlight.Font.Color := FontColorB.Color;
    FHighlight.Color := BackColorB.Color;
  end;
end;

procedure TfrxHighlightEditorForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(4600);
  ConditionL.Text := frxGet(4603);
  FontL.Text := frxGet(4604);
  BackgroundL.Text := frxGet(4605);
  OKB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  BoldCB.Text := frxGet(4606);
  ItalicCB.Text := frxGet(4607);
  UnderlineCB.Text := frxGet(4608);
  TransparentRB.Text := frxGet(4609);
  OtherRB.Text := frxGet(4610);
end;

procedure TfrxHighlightEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

procedure TfrxHighlightEditorForm.HostControls(Host: TFmxObject);
begin
  ConditionL.Parent := Host;
  FontL.Parent := Host;
  BackgroundL.Parent := Host;
  FormShow(Self);
end;

procedure TfrxHighlightEditorForm.UnhostControls(AModalResult: TModalResult);
var
  ca: TCloseAction;
begin
  ModalResult := AModalResult;
  FormClose(Self, ca);
end;

end.

