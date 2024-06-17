
{******************************************}
{                                          }
{             FastReport v4.0              }
{           DisplayFormat editor           }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditFormat;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, System.Types, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.ExtCtrls, FMX.ListBox, FMX.Edit, FMX.frxClass, System.Variants, FMX.Layouts
 {$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};


type
  TfrxFormatEditorForm = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    CategoryL: TGroupBox;
    CategoryLB: TListBox;
    FormatL: TGroupBox;
    FormatLB: TListBox;
    GroupBox1: TGroupBox;
    FormatStrL: TLabel;
    SeparatorL: TLabel;
    FormatE: TEdit;
    SeparatorE: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CategoryLBClick(Sender: TObject);
    //procedure FormatLBDrawItem(Control: TWinControl; Index: Integer;
    //  ARect: TRect; State: TOwnerDrawState);
    procedure FormatLBClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormatStrLClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FFormat: TfrxFormat;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure HostControls(Host: TFmxObject);
    procedure UnhostControls;
    property Format: TfrxFormat read FFormat write FFormat;
  end;


implementation

{$R *.FMX}

uses FMX.frxRes;

const
  CategoryNames: array[0..3] of String =
    ('fkText', 'fkNumber', 'fkDateTime', 'fkBoolean');


constructor TfrxFormatEditorForm.Create(AOwner: TComponent);
begin
  inherited;
  FFormat := TfrxFormat.Create;
end;

destructor TfrxFormatEditorForm.Destroy;
begin
  FFormat.Free;
  inherited;
end;

procedure TfrxFormatEditorForm.FormShow(Sender: TObject);

  procedure FillCategory;
  var
    i: Integer;
  begin
    for i := 0 to 3 do
      CategoryLB.Items.Add(frxResources.Get(CategoryNames[i]));
  end;

  procedure FindFormat;
  var
    i: Integer;
    s: String;
  begin
    for i := 0 to FormatLB.Items.Count - 1 do
    begin
      s := FormatLB.Items[i];
      if Copy(s, Pos(';', s) + 1, 255) = FFormat.FormatStr then
        FormatLB.ItemIndex := i;
    end;
  end;

begin
  FillCategory;
  CategoryLB.ItemIndex := Integer(FFormat.Kind);
  CategoryLBClick(Self);
  FindFormat;
  FormatE.Text := FFormat.FormatStr;
  SeparatorE.Text := FFormat.DecimalSeparator;
end;

procedure TfrxFormatEditorForm.FormHide(Sender: TObject);
var
  s: String;
begin
  FFormat.Kind := TfrxFormatKind(CategoryLB.ItemIndex);
  FFormat.FormatStr := FormatE.Text;
  s := SeparatorE.Text;
  if s = '' then
    FFormat.DecimalSeparator := ''
  else
    FFormat.DecimalSeparator := s[1];
end;

procedure TfrxFormatEditorForm.CategoryLBClick(Sender: TObject);
var
  i, n: Integer;
  s: String;
begin
{$IFDEF DELPHI23}
  FormatLB.Clear;
{$ELSE}
  FormatLB.Items.Clear;
{$ENDIF}
  n := CategoryLB.ItemIndex;
  SeparatorE.Enabled := n = 1;
  SeparatorL.Enabled := n = 1;

  if (n = 0) or (n = 4) or (n = -1) then
    Exit;

  for i := 1 to 10 do
  begin
    s := frxResources.Get(CategoryNames[n] + IntToStr(i));
    if Pos('fk', s) = 0 then
      FormatLB.Items.Add(s);
  end;
end;

procedure TfrxFormatEditorForm.FormatLBClick(Sender: TObject);
var
  s: String;
begin
  s := FormatLB.Items[FormatLB.ItemIndex];
  FormatE.Text := Copy(s, Pos(';', s) + 1, 255);
end;

procedure TfrxFormatEditorForm.FormatStrLClick(Sender: TObject);
begin

end;

//procedure TfrxFormatEditorForm.FormatLBDrawItem(Control: TWinControl;
//  Index: Integer; ARect: TRect; State: TOwnerDrawState);
//var
//  s: String;
//begin
//  with FormatLB do
//  begin
//    Canvas.FillRect(ARect);
//    s := Items[Index];
//    if Pos(';', s) <> 0 then
//      s := Copy(s, 1, Pos(';', s) - 1);
//    Canvas.TextOut(ARect.Left + 2, ARect.Top, s);
//  end;
//end;

procedure TfrxFormatEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormHide(Self);
end;

procedure TfrxFormatEditorForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(4500);
  CategoryL.Text := frxGet(4501);
  FormatL.Text := frxGet(4502);
  FormatStrL.Text := frxGet(4503);
  SeparatorL.Text := frxGet(4504);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
end;

procedure TfrxFormatEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

procedure TfrxFormatEditorForm.HostControls(Host: TFmxObject);
begin
  CategoryL.Parent := Host;
  FormatL.Parent := Host;
  GroupBox1.Parent := Host;
  FormShow(Self);
end;

procedure TfrxFormatEditorForm.UnhostControls;
begin
  FormHide(Self);
end;

end.


//56db3b0f55102b9488a240d37950543f