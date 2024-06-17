
{******************************************}
{                                          }
{             FastReport v4.0              }
{              SysMemo editor              }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditSysMemo;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UiTypes, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.ExtCtrls, FMX.frxClass, FMX.frxCtrls, FMX.ListBox, FMX.Edit, System.Variants
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};
  

type
  TfrxSysMemoEditorForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    AggregateRB: TRadioButton;
    SysVariableRB: TRadioButton;
    TextRB: TRadioButton;
    AggregatePanel: TGroupBox;
    DataBandL: TLabel;
    DataSetL: TLabel;
    DataFieldL: TLabel;
    FunctionL: TLabel;
    ExpressionL: TLabel;
    DataFieldCB: TComboBox;
    DataSetCB: TComboBox;
    DataBandCB: TComboBox;
    CountInvisibleCB: TCheckBox;
    FunctionCB: TComboBox;
    ExpressionE: TfrxEditWithButton;
    RunningTotalCB: TCheckBox;
    GroupBox1: TGroupBox;
    SysVariableCB: TComboBox;
    GroupBox2: TGroupBox;
    TextE: TEdit;
    SampleL: TLabel;
    procedure ExpressionEButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DataSetCBChange(Sender: TObject);
    procedure DataBandCBChange(Sender: TObject);
    procedure DataFieldCBChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FunctionCBChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FAggregateOnly: Boolean;
    FReport: TfrxReport;
    FText: String;
    procedure FillDataBandCB;
    procedure FillDataFieldCB;
    procedure FillDataSetCB;
    function CreateAggregate: String;
    procedure UpdateSample;
  public
    property AggregateOnly: Boolean read FAggregateOnly write FAggregateOnly;
    property Text: String read FText write FText;
  end;


implementation

{$R *.FMX}

uses FMX.frxUtils, FMX.frxRes;


procedure TfrxSysMemoEditorForm.FormShow(Sender: TObject);
var
  s: String;
  i: Integer;

  procedure HideControls(ar: array of TControl);
  var
    i: Integer;
  begin
    for i := 0 to High(ar) do
      ar[i].Visible := False;
  end;

begin
  FReport := TfrxCustomDesigner(Owner).Report;
  SysVariableRB.IsChecked := True;
  FillDataBandCB;
  FillDataSetCB;

  s := FText;
  if s <> '' then
    SetLength(s, Length(s) - 2);  { cut #13#10 }
  i := SysVariableCB.Items.IndexOf(s);
  if FAggregateOnly then
  begin
    Caption := frxResources.Get('agAggregate');
    AggregateRB.IsChecked := True;
    HideControls([SysVariableRB, AggregateRB, TextRB, SysVariableCB, TextE,
      GroupBox1, GroupBox2]);
    AggregatePanel.Position.Y := 4;
    OkB.Position.Y := AggregatePanel.Height + 18;
    CancelB.Position.Y := OkB.Position.Y;
    ClientHeight := Round(CancelB.Position.Y + 33);
  end
  else if (i <> -1) or (s = '') then
  begin
    SysVariableRB.IsChecked := True;
    SysVariableCB.ItemIndex := i;
  end
  else
  begin
    TextRB.IsChecked := True;
    TextE.Text := s;
    TextE.SetFocus;
  end;
  UpdateSample;
end;

function TfrxSysMemoEditorForm.CreateAggregate: String;
var
  s: String;
  i: Integer;
begin
  if FunctionCB.Selected <> nil then
    s := FunctionCB.Selected.Text;
  i := 0;
  if CountInvisibleCB.IsChecked then
    i := i or 1;
  if RunningTotalCB.IsChecked then
    i := i or 2;

  if s <> 'COUNT' then
  begin
    s := s + '(';
    if ExpressionE.Text <> '' then
      s := s + ExpressionE.Text
    else if(DataSetCB.Selected <> nil) and (DataFieldCB.Selected <> nil) then
      s := s + '<' + DataSetCB.Selected.Text + '."' + DataFieldCB.Selected.Text + '">';

    if (DataBandCB.Selected <> nil) and (DataBandCB.Selected.Text <> '') then
    begin
      s := s + ',' + DataBandCB.Selected.Text;
      if i <> 0 then
        s := s + ',' + IntToStr(i);
    end;
    s := s + ')';
  end
  else
  begin
    s := s + '(';
    if (DataBandCB.Selected <> nil) then
      s := s + DataBandCB.Selected.Text;
    if i <> 0 then
      s := s + ',' + IntToStr(i);
    s := s + ')';
  end;

  Result := s;
end;

procedure TfrxSysMemoEditorForm.FillDataBandCB;
var
  i: Integer;
  c: TfrxComponent;
begin
{$IFDEF DELPHI23}
  DataBandCB.Clear;
{$ELSE}
  DataBandCB.Items.Clear;
{$ENDIF}
  for i := 0 to FReport.Designer.Objects.Count - 1 do
  begin
    c := FReport.Designer.Objects[i];
    if c is TfrxDataBand then
      DataBandCB.Items.Add(c.Name);
  end;
end;

procedure TfrxSysMemoEditorForm.FillDataSetCB;
begin
  FReport.GetDataSetList(DataSetCB.Items);
end;

procedure TfrxSysMemoEditorForm.FillDataFieldCB;
var
  ds: TfrxDataSet;
begin
  ds := FReport.GetDataSet(DataSetCB.Selected.Text);
  if ds <> nil then
    ds.GetFieldList(DataFieldCB.Items) else
{$IFDEF DELPHI23}
    DataFieldCB.Clear;
{$ELSE}
    DataFieldCB.Items.Clear;
{$ENDIF}
end;

procedure TfrxSysMemoEditorForm.DataBandCBChange(Sender: TObject);
var
  b: TfrxDataBand;
begin
  b := nil;
  if DataBandCB.Selected <> nil then
    b := FReport.Designer.Page.FindObject(DataBandCB.Selected.Text) as TfrxDataBand;
  if (DataSetCB.Selected <> nil) and (b <> nil) and (b.DataSet <> nil) and not (b.DataSet is TfrxUserDataSet) then
  begin
    DataSetCB.Selected.Text := FReport.GetAlias(b.DataSet);
    DataSetCBChange(nil);
  end;
end;

procedure TfrxSysMemoEditorForm.DataSetCBChange(Sender: TObject);
begin
  FillDataFieldCB;
  ExpressionE.Text := '';
  UpdateSample;
end;

procedure TfrxSysMemoEditorForm.DataFieldCBChange(Sender: TObject);
begin
  ExpressionE.Text := '';
  UpdateSample;
end;

procedure TfrxSysMemoEditorForm.ExpressionEButtonClick(Sender: TObject);
var
  s: String;
begin
  s := TfrxCustomDesigner(Owner).InsertExpression(ExpressionE.Text);
  if s <> '' then
    ExpressionE.Text := s;
  UpdateSample;
end;

procedure TfrxSysMemoEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    if ModalResult = mrOk then
  begin
    if (SysVariableRB.IsChecked) and (SysVariableCB.Selected <> nil) then
      FText := SysVariableCB.Selected.Text
    else if AggregateRB.IsChecked then
      FText := '[' + CreateAggregate + ']'
    else
      FText := TextE.Text
  end;
end;

procedure TfrxSysMemoEditorForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  Caption := frxGet(3300);
  DataBandL.Text := frxGet(3301);
  DataSetL.Text := frxGet(3302);
  DataFieldL.Text := frxGet(3303);
  FunctionL.Text := frxGet(3304);
  ExpressionL.Text := frxGet(3305);
  OKB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  AggregateRB.Text := frxGet(3306);
  SysVariableRB.Text := frxGet(3307);
  CountInvisibleCB.Text := frxGet(3308);
  TextRB.Text := frxGet(3309);
  RunningTotalCB.Text := frxGet(3310);
  FunctionCB.BeginUpdate;
  FunctionCB.Items.Add('SUM');
  FunctionCB.Items.Add('MIN');
  FunctionCB.Items.Add('MAX');
  FunctionCB.Items.Add('AVG');
  FunctionCB.Items.Add('COUNT');
  FunctionCB.EndUpdate;
  for i := 1 to 6 do
    SysVariableCB.Items.Add(frxResources.Get('vt' + IntToStr(i)));
  FormShow(Self);
  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
end;

procedure TfrxSysMemoEditorForm.UpdateSample;
begin
  if AggregateRB.IsChecked then
    SampleL.Text := CreateAggregate
  else
    SampleL.Text := '';
end;

procedure TfrxSysMemoEditorForm.FunctionCBChange(Sender: TObject);
begin
  UpdateSample;
end;

procedure TfrxSysMemoEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

end.



//56db3b0f55102b9488a240d37950543f