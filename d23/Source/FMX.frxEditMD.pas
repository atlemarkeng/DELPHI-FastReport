
{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{          Master-Detail editor            }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditMD;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.frxClass, FMX.frxCustomDB, FMX.Layouts, FMX.ListBox, System.Variants
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};
  

type
  TfrxMDEditorForm = class(TForm)
    DetailLB: TListBox;
    MasterLB: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    AddB: TButton;
    LinksLB: TListBox;
    Label3: TLabel;
    ClearB: TButton;
    OkB: TButton;
    CancelB: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ClearBClick(Sender: TObject);
    procedure DetailLBClick(Sender: TObject);
    procedure MasterLBClick(Sender: TObject);
    procedure AddBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FDetailDS: TfrxCustomDataset;
    FMasterDS: TfrxCustomDBDataset;
    FMasterFields: String;
    procedure FillLists;
  public
    property DataSet: TfrxCustomDataset read FDetailDS write FDetailDS;
  end;


implementation

{$R *.FMX}

uses FMX.frxUtils, FMX.frxRes, FMX.frxFMX;


procedure TfrxMDEditorForm.FillLists;
var
  i: Integer;
  s: String;
  sl: TStrings;
begin
  FDetailDS.GetFieldList(DetailLB.Items);
  FMasterDS.GetFieldList(MasterLB.Items);
{$IFDEF DELPHI23}
  LinksLB.Clear;
{$ELSE}
  LinksLB.Items.Clear;
{$ENDIF}

  sl := TStringList.Create;
  frxSetCommaText(FMasterFields, sl);

  for i := 0 to sl.Count - 1 do
  begin
    s := sl.Names[i];
    if DetailLB.Items.IndexOf(s) <> -1 then
      DetailLB.Items.Delete(DetailLB.Items.IndexOf(s));
    s := sl.Values[sl.Names[i]];
    if MasterLB.Items.IndexOf(s) <> -1 then
      MasterLB.Items.Delete(MasterLB.Items.IndexOf(s));
    LinksLB.Items.Add(sl[i]);
  end;

  AddB.Enabled := False;
  sl.Free;
end;

procedure TfrxMDEditorForm.FormShow(Sender: TObject);
begin
  FMasterDS := FDetailDS.Master;
  FMasterFields := FDetailDS.MasterFields;
  FillLists;
end;

procedure TfrxMDEditorForm.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
    FDetailDS.MasterFields := FMasterFields;
end;

procedure TfrxMDEditorForm.ClearBClick(Sender: TObject);
begin
  FMasterFields := '';
  FillLists;
end;

procedure TfrxMDEditorForm.DetailLBClick(Sender: TObject);
begin
  if MasterLB.ItemIndex <> -1 then
    AddB.Enabled := True;
end;

procedure TfrxMDEditorForm.MasterLBClick(Sender: TObject);
begin
  if DetailLB.ItemIndex <> -1 then
    AddB.Enabled := True;
end;

procedure TfrxMDEditorForm.AddBClick(Sender: TObject);
var
  s: String;
begin
  s := DetailLB.Items[DetailLB.ItemIndex] + '=' + MasterLB.Items[MasterLB.ItemIndex];
  if FMasterFields = '' then
    FMasterFields := s else
    FMasterFields := FMasterFields + ';' + s;
  FillLists;
end;

procedure TfrxMDEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormHide(Self);
end;

procedure TfrxMDEditorForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(3800);
  Label1.Text := frxGet(3801);
  Label2.Text := frxGet(3802);
  Label3.Text := frxGet(3803);
  AddB.Text := frxGet(3804);
  ClearB.Text := frxGet(3805);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);


end;

procedure TfrxMDEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

end.



//56db3b0f55102b9488a240d37950543f