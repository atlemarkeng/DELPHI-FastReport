
{******************************************}
{                                          }
{             FastReport v4.0              }
{         Report datasets selector         }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditReportData;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.frxClass, FMX.Layouts, FMX.ListBox, FMX.Types, System.Variants
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};


type
  TfrxReportDataForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    DatasetsLB: TListBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DatasetsLBClickCheck(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FStandalone: Boolean;
    //procedure BuildConnectionList;
    procedure BuildDatasetList;
  public
    Report: TfrxReport;
  end;


implementation

{$R *.FMX}

uses FMX.frxDesgn, FMX.frxUtils, FMX.frxRes, System.IniFiles;

var
  PrevWidth: Integer = 0;
  PrevHeight: Integer = 0;

procedure TfrxReportDataForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: Integer;
begin
  PrevWidth := Width;
  PrevHeight := Height;
  if ModalResult <> mrOk then Exit;


  Report.Datasets.Clear;

  for i := 0 to DatasetsLB.Items.Count - 1 do
    if DatasetsLB.ListItems[i].IsChecked then
        Report.DataSets.Add(TfrxDataSet(DatasetsLB.Items.Objects[i]));
end;

procedure TfrxReportDataForm.FormCreate(Sender: TObject);
begin
  FStandalone := (frxDesignerComp <> nil) and frxDesignerComp.Standalone;
  if FStandalone then
    Caption := frxGet(5800)
  else
    Caption := frxGet(2800);
  OKB.Text := frxGet(1);
  CancelB.Text := frxGet(2);

  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
end;

procedure TfrxReportDataForm.FormShow(Sender: TObject);
begin
  if PrevWidth <> 0 then
  begin
    Width := PrevWidth;
    Height := PrevHeight;
  end;

  DatasetsLB.SetBounds(4, 4, ClientWidth - 8, ClientHeight - OkB.Height - 12);
  OkB.Position.X := ClientWidth - OkB.Width - CancelB.Width - 8;
  CancelB.Position.X := ClientWidth - CancelB.Width - 4;
  OkB.Position.Y := ClientHeight - OkB.Height - 4;
  CancelB.Position.Y := OkB.Position.Y;

//  if FStandalone then
//    BuildConnectionList
//  else
    BuildDatasetList;
end;


// todo win only ?
//procedure TfrxReportDataForm.BuildConnectionList;
//var
//  i: Integer;
//  sl: TStringList;
//  s2: TStringList;
//begin
//
//  try
//    sl := TStringList.Create;
//    s2 := TStringList.Create;
//    try
//      ini.RootKey := HKEY_LOCAL_MACHINE;
//      if ini.OpenKeyReadOnly(DEF_REG_CONNECTIONS)  then
//      begin
//        ini.GetValueNames(sl);
//        ini.CloseKey;
//      end;
//
//      ini.RootKey := HKEY_CURRENT_USER;
//      if ini.OpenKeyReadOnly(DEF_REG_CONNECTIONS)  then
//      begin
//        ini.GetValueNames(s2);
//        ini.CloseKey;
//      end;
//
//      sl.AddStrings(s2);
//
//      for i := 0 to sl.Count - 1 do
//      begin
//        DataSetsLB.Items.Add(sl[i]);
//        DataSetsLB.Checked[i] := CompareText(sl[i], Report.ReportOptions.ConnectionName) = 0;
//      end;
//    finally
//      sl.Free;
//      s2.Free;
//    end;
//  finally
//    ini.Free;
//  end;
//end;

procedure TfrxReportDataForm.BuildDatasetList;
var
  i: Integer;
  ds: TfrxDataSet;
  dsList: TStringList;
begin
  dsList := TStringList.Create;

  if Report.EnabledDataSets.Count > 0 then
  begin
    for i := 0 to Report.EnabledDataSets.Count - 1 do
    begin
      ds := Report.EnabledDataSets[i].DataSet;
      if ds <> nil then
        dsList.AddObject(ds.UserName, ds);
    end;
  end
  else
    Report.GetActiveDataSetList(dsList);

  dsList.Sort;

  for i := 0 to dsList.Count - 1 do
  begin
    ds := TfrxDataSet(dsList.Objects[i]);
    if (csDesigning in Report.ComponentState) and
      ((ds.Owner is TForm) or (ds.Owner is TDataModule)) then
      DataSetsLB.Items.AddObject(ds.UserName + '  (' + ds.Owner.Name + '.' + ds.Name + ')', ds)
    else
    begin
      if not (ds.Owner is TfrxReport) or (ds.Owner = Report) then
        DataSetsLB.Items.AddObject(ds.UserName, ds);
    end;
    if Report.Datasets.Find(ds) <> nil then
      DataSetsLB.ListItems[DataSetsLB.Items.Count - 1].IsChecked := True;
  end;

  dsList.Free;
end;

procedure TfrxReportDataForm.DatasetsLBClickCheck(Sender: TObject);
var
  i: Integer;
begin
  if FStandalone then
    for i := 0 to DatasetsLB.Items.Count - 1 do
      if i <> DatasetsLB.ItemIndex then
        DatasetsLB.ListItems[i].IsChecked := False;
end;

procedure TfrxReportDataForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

end.
