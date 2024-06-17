
{******************************************}
{                                          }
{             FastReport v4.0              }
{              Group editor                }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditGroup;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.ExtCtrls, FMX.frxClass, FMX.frxCtrls, FMX.ListBox, FMX.Types, FMX.Edit, System.Variants
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};
  

type
  TfrxGroupEditorForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    BreakOnL: TGroupBox;
    DataFieldCB: TComboBox;
    DataSetCB: TComboBox;
    ExpressionE: TfrxEditWithButton;
    DataFieldRB: TRadioButton;
    ExpressionRB: TRadioButton;
    OptionsL: TGroupBox;
    KeepGroupTogetherCB: TCheckBox;
    StartNewPageCB: TCheckBox;
    OutlineCB: TCheckBox;
    DrillCB: TCheckBox;
    ResetCB: TCheckBox;
    procedure ExpressionEButtonClick(Sender: TObject);
    procedure DataFieldRBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DataSetCBChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FGroupHeader: TfrxGroupHeader;
    FReport: TfrxReport;
    procedure FillDataFieldCB;
    procedure FillDataSetCB;
  public
    property GroupHeader: TfrxGroupHeader read FGroupHeader write FGroupHeader;
  end;


implementation

{$R *.FMX}

uses FMX.frxUtils, FMX.frxRes;


procedure TfrxGroupEditorForm.FormShow(Sender: TObject);
var
  ds: TfrxDataSet;
  fld: String;
begin
  FReport := FGroupHeader.Report;
  FillDataSetCB;

  DataFieldRB.IsChecked := True;
  FReport.GetDataSetAndField(FGroupHeader.Condition, ds, fld);
  if FGroupHeader.Condition = '' then
  begin
    DataSetCB.ItemIndex := 0;
    FillDataFieldCB;
    DataFieldCB.SetFocus;
  end
  else if (ds <> nil) and (fld <> '') then
  begin
    DataSetCB.ItemIndex := DataSetCB.Items.IndexOf(FReport.GetAlias(ds));
    FillDataFieldCB;
    DataFieldCB.ItemIndex := DataFieldCB.Items.IndexOf(fld);
    DataFieldCB.SetFocus;
  end
  else
  begin
    ExpressionE.Text := FGroupHeader.Condition;
    ExpressionRB.IsChecked := True;
    ExpressionE.SetFocus;
  end;

  KeepGroupTogetherCB.IsChecked := FGroupHeader.KeepTogether;
  StartNewPageCB.IsChecked := FGroupHeader.StartNewPage;
  OutlineCB.IsChecked := Trim(FGroupHeader.OutlineText) <> '';
  DrillCB.IsChecked := FGroupHeader.DrillDown;
  ResetCB.IsChecked := FGroupHeader.ResetPageNumbers;
end;

procedure TfrxGroupEditorForm.FillDataSetCB;
begin
  FReport.GetDataSetList(DataSetCB.Items);
end;

procedure TfrxGroupEditorForm.FillDataFieldCB;
var
  ds: TfrxDataSet;
begin
  if DataSetCB.Selected <> nil then
    ds := FReport.GetDataSet(DataSetCB.Selected.Text);
  if ds <> nil then
    ds.GetFieldList(DataFieldCB.Items) else
{$IFDEF DELPHI23}
    DataFieldCB.Clear;
{$ELSE}
    DataFieldCB.Items.Clear;
{$ENDIF}
end;

procedure TfrxGroupEditorForm.ExpressionEButtonClick(Sender: TObject);
var
  s: String;
begin
  s := TfrxCustomDesigner(Owner).InsertExpression(ExpressionE.Text);
  if s <> '' then
    ExpressionE.Text := s;
end;

procedure TfrxGroupEditorForm.DataFieldRBClick(Sender: TObject);
begin
  DataSetCB.Enabled := DataFieldRB.IsChecked;
  DataFieldCB.Enabled := DataFieldRB.IsChecked;
  ExpressionE.Enabled := ExpressionRB.IsChecked;
end;

procedure TfrxGroupEditorForm.DataSetCBChange(Sender: TObject);
begin
  FillDataFieldCB;
end;

procedure TfrxGroupEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrOk then
  begin
    if DataFieldRB.IsChecked then
      if (DataSetCB.Selected <> nil) and (DataFieldCB.Selected <> nil) then
        FGroupHeader.Condition := DataSetCB.Selected.Text + '."' + DataFieldCB.Selected.Text + '"' else
      FGroupHeader.Condition := ExpressionE.Text;

    FGroupHeader.KeepTogether := KeepGroupTogetherCB.IsChecked;
    FGroupHeader.StartNewPage := StartNewPageCB.IsChecked;
    if OutlineCB.IsChecked then
      FGroupHeader.OutlineText := FGroupHeader.Condition else
      FGroupHeader.OutlineText := '';
    FGroupHeader.DrillDown := DrillCB.IsChecked;
    FGroupHeader.ResetPageNumbers := ResetCB.IsChecked;
  end;
end;

procedure TfrxGroupEditorForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(3200);
  BreakOnL.Text := frxGet(3201);
  OptionsL.Text := frxGet(3202);
  OKB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  DataFieldRB.Text := frxGet(3203);
  ExpressionRB.Text := frxGet(3204);
  KeepGroupTogetherCB.Text := frxGet(3205);
  StartNewPageCB.Text := frxGet(3206);
  OutlineCB.Text := frxGet(3207);
  DrillCB.Text := frxResources.Get('bvDrillDown');
  ResetCB.Text := frxResources.Get('bvResetPageNo');
end;

procedure TfrxGroupEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

end.



//56db3b0f55102b9488a240d37950543f