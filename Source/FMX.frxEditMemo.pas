
{******************************************}
{                                          }
{             FastReport v4.0              }
{               Memo editor                }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditMemo;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, System.Types, FMX.Types, FMX.Controls,
  FMX.Forms, FMX.Dialogs, FMX.ExtCtrls, FMX.frxClass, FMX.TabControl,
  FMX.frxEditFormat, FMX.frxEditHighlight, FMX.frxFMX, FMX.Memo, System.Variants, System.StrUtils,
  FMX.frxBaseModalForm
 {$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
 {$IFDEF DELPHI22}
  ,FMX.Memo.Types
{$ENDIF};
  

type
  TfrxMemoEditorForm = class(TfrxForm)
    SaveDialog1: TSaveDialog;
    TabControl: TTabControl;
    TextTS: TTabItem;
    FormatTS: TTabItem;
    HighlightTS: TTabItem;
    ToolBar: TToolBar;
    ExprB: TfrxToolButton;
    AggregateB: TfrxToolButton;
    LocalFormatB: TfrxToolButton;
    WordWrapB: TfrxToolButton;
    Panel1: TPanel;
    CancelB: TButton;
    OkB: TButton;
    procedure WordWrapBClick(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure ExprBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AggregateBClick(Sender: TObject);
    procedure LocalFormatBClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow2(Sender: TObject);
  private
    FFormat: TfrxFormatEditorForm;
    FHighlight: TfrxHighlightEditorForm;
    FMemoView: TfrxCustomMemoView;
    FText: WideString;
  public
    Memo: TMemo;
    procedure FormShow(Sender: TObject);
    property MemoView: TfrxCustomMemoView read FMemoView write FMemoView;
    property Text: WideString read FText write FText;
  end;


implementation

{$R *.FMX}

uses 
  FMX.frxEditSysMemo, System.IniFiles, FMX.frxRes, FMX.frxUnicodeUtils, FMX.frxUtils;


{ TfrxMemoEditorForm }

procedure TfrxMemoEditorForm.FormShow2(Sender: TObject);
begin
Memo.SetFocus;
end;

procedure TfrxMemoEditorForm.FormShow(Sender: TObject);
var
  Ini: TCustomIniFile;
begin
  Memo := TMemo.Create(TextTS);

  with Memo do
  begin
    Parent := TextTS;
    Align := TAlignLayout.alClient;
    ///ScrollBars := ssBoth;
    //TabOrder := 1;
    OnKeyDown := MemoKeyDown;
  end;

  FFormat := TfrxFormatEditorForm.Create(Owner);
  FFormat.Format.Assign(MemoView.DisplayFormat);
  FFormat.HostControls(FormatTS);

  FHighlight := TfrxHighlightEditorForm.Create(Owner);
  FHighlight.MemoView := MemoView;
  FHighlight.HostControls(HighlightTS);

  Ini := TfrxCustomDesigner(Owner).Report.GetIniFile;
  WordWrapB.Down := Ini.ReadBool('TfrxMemoEditorForm', 'WordWrap', False);
  WordWrapBClick(nil);
  frxRestoreFormPosition(Ini, Self);
  Ini.Free;

  with TfrxCustomDesigner(Owner) do
  begin
    if UseObjectFont then
    begin
      FMemoView.Font.AssignToFont(Memo.Font);
    end
    else
    begin
      Memo.Font.Family := 'Arial';
      Memo.Font.Size := 13;
    end;
  end;


  Memo.Text := FMemoView.Text;
  Memo.SelStart := Length(Memo.Text);
  Memo.SelLength := 1;
end;


procedure TfrxMemoEditorForm.ExprBClick(Sender: TObject);
var
  s, s1, s2: String;
  SelStart: TCaretPosition;
  SelLen: Integer;

  function BracketCount: Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 1 to Length(s) do
      if s[i] = '<' then
        Inc(Result);
  end;

begin
  s := TfrxCustomDesigner(Owner).InsertExpression('');
  if s <> '' then
  begin
    s1 := MemoView.ExpressionDelimiters;
    s2 := Copy(s1, Pos(',', s1) + 1, 255);
    s1 := Copy(s1, 1, Pos(',', s1) - 1);
    if (s[1] = '<') and (s[Length(s)] = '>') and (BracketCount = 1) then
      s := Copy(s, 2, Length(s) - 2);
    SelLen := Memo.SelLength;
    SelStart := Memo.TextPosToPos(Memo.SelStart);
    Memo.DeleteFrom(SelStart, SelLen, []);
    Memo.InsertAfter(SelStart, s1 + s + s2, []);
    //Memo.SelText := s1 + s + s2;
    //todo
  end;

end;

procedure TfrxMemoEditorForm.WordWrapBClick(Sender: TObject);
begin
  Memo.WordWrap := WordWrapB.Down;
end;

procedure TfrxMemoEditorForm.MemoKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if (Key = vkReturn) and (ssCtrl in Shift) then
    ModalResult := mrOk
  else if Key = vkEscape then
    ModalResult := mrCancel
  else if (Key = Ord('A')) and (Shift = [ssCtrl]) then
    Memo.SelectAll;
end;

procedure TfrxMemoEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Ini: TCustomIniFile;
begin
  Ini := TfrxCustomDesigner(Owner).Report.GetIniFile;
  frxSaveFormPosition(Ini, Self);
  Ini.WriteBool('TfrxMemoEditorForm', 'WordWrap', Memo.WordWrap);
  Ini.Free;

  FText := Memo.Text;

  FFormat.UnhostControls;
  if ModalResult = mrOk then
    FMemoView.DisplayFormat.Assign(FFormat.Format);
  FFormat.Free;
  FHighlight.UnhostControls(ModalResult);
  FHighlight.Free;
end;


procedure TfrxMemoEditorForm.FormCreate(Sender: TObject);
begin
  frxResources.LoadImageFromResouce(ExprB.Bitmap, 11, 3);
  frxResources.LoadImageFromResouce(AggregateB.Bitmap, 6, 5);
  frxResources.LoadImageFromResouce(LocalFormatB.Bitmap, 5, 2);
  frxResources.LoadImageFromResouce(WordWrapB.Bitmap, 2, 5);
  Caption := frxGet(3900);
  ExprB.Hint := frxGet(3901);
  AggregateB.Hint := frxGet(3902);
  LocalFormatB.Hint := frxGet(3903);
  WordWrapB.Hint := frxGet(3904);
  TextTS.Text := frxGet(3905);
  FormatTS.Text := frxGet(3906);
  HighlightTS.Text := frxGet(3907);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
{$IFDEF DELPHI18}
  CancelB.Anchors := [TAnchorKind.akRight, TAnchorKind.akTop];
  OkB.Anchors := [TAnchorKind.akRight, TAnchorKind.akTop];
{$ENDIF}
{$IFDEF DELPHI18}
  OnShow := FormShow2;
{$ENDIF}

  Toolbar.StyleLookup := 'backgroundstyle';
  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
end;

procedure TfrxMemoEditorForm.AggregateBClick(Sender: TObject);
var
  SelStart: TCaretPosition;
  SelLen: Integer;
begin
  with TfrxSysMemoEditorForm.Create(Owner) do
  begin
    AggregateOnly := True;
    FormShow(nil);
    if ShowModal = mrOk then
    begin
      SelLen := Memo.SelLength;
      SelStart := Memo.TextPosToPos(Memo.SelStart);
      Memo.DeleteFrom(SelStart, SelLen, []);
      Memo.InsertAfter(SelStart, Text, []);
    end;
      ///Memo.SelText := Text;
    Free;
  end;
end;

procedure TfrxMemoEditorForm.LocalFormatBClick(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  with TfrxFormatEditorForm.Create(Owner) do
  begin
    FormShow(nil);
    if ShowModal = mrOk then
    begin
      case Format.Kind of
        fkText:
          s := '';

        fkNumeric:
          begin
            s := Format.FormatStr;
            for i := 1 to Length(s) do
              if CharInSet(s[i], ['.', ',', '-']) then
                if Format.DecimalSeparator <> '' then
                  s[i] := Format.DecimalSeparator[1] else
                  s[i] :=  FormatSettings.DecimalSeparator;
            s := ' #n' + s;
          end;

        fkDateTime:
          s := ' #d' + Format.FormatStr;

        fkBoolean:
          s := ' #b' + Format.FormatStr;
      end;

      if s <> '' then
      begin
        i := Memo.SelStart;
        if (i > 0) and (Memo.Text[i] = ']') then
          Memo.SelStart := Memo.SelStart - 1;
        //Memo.SelText := s;

      end;
    end;
    Free;
  end;
end;

procedure TfrxMemoEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

end.

