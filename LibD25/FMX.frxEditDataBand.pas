
{******************************************}
{                                          }
{             FastReport v4.0              }
{             Data Band editor             }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditDataBand;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Objects, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.ExtCtrls, FMX.frxClass, FMX.Edit, FMX.Layouts, FMX.ListBox,
  FMX.Types, System.Variants
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF}
{$IFDEF DELPHI21}
  ,FMX.SpinBox
{$ENDIF};


type
  TfrxDataBandEditorForm = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    GroupBox1: TGroupBox;
    DatasetsLB: TListBox;
    RecordsL: TLabel;
    RecordsS: TSpinBox;
//    procedure DatasetsLBDrawItem(Control: TWinControl; Index: Integer;
//      ARect: TRect; State: TOwnerDrawState);
    procedure DatasetsLBDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure DatasetsLBClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OkBClick(Sender: TObject);
  private
    { Private declarations }
    FDataBand: TfrxDataBand;
    FDesigner: TfrxCustomDesigner;
  public
    { Public declarations }
    property DataBand: TfrxDataBand read FDataBand write FDataBand;
  end;


implementation

{$R *.FMX}

uses FMX.frxUtils, FMX.frxRes;


procedure TfrxDataBandEditorForm.FormShow(Sender: TObject);
var
  i: Integer;
  dsList: TStringList;
begin
  FDesigner := TfrxCustomDesigner(Owner);

  dsList := TStringList.Create;
  FDesigner.Report.GetDatasetList(dsList);
  dsList.Sort;
  //DatasetsLB.Items := dsList;
  DatasetsLB.Items.Add(frxResources.Get('dbNotAssigned'));
  for i := 0 to dsList.Count - 1 do
    DatasetsLB.Items.AddObject(dsList[i], dsList.Objects[i]);
    //Add(dsList[i]);

  dsList.Free;

  i := DatasetsLB.Items.IndexOfObject(FDataBand.DataSet);
  if i = -1 then
    i := 0;
  DatasetsLB.ItemIndex := i;

  RecordsS.Text := IntToStr(FDataBand.RowCount);
end;

procedure TfrxDataBandEditorForm.OkBClick(Sender: TObject);
begin

end;

//procedure TfrxDataBandEditorForm.DatasetsLBDrawItem(Control: TWinControl;
//  Index: Integer; ARect: TRect; State: TOwnerDrawState);
//var
//  r: TRect;
//begin
//  r := ARect;
//  r.Right := r.Left + 18;
//  r.Bottom := r.Top + 16;
//  OffsetRect(r, 2, 0);
//  with TListBox(Control) do
//  begin
//    Canvas.FillRect(ARect);
//    if Index > 0 then
//      frxResources.MainButtonImages.Draw(Canvas, ARect.Left + 2, ARect.Top + 1, 53);
//    Canvas.TextOut(ARect.Left + 22, ARect.Top + 2, Items[Index]);
//  end;
//end;

procedure TfrxDataBandEditorForm.DatasetsLBDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrxDataBandEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    if ModalResult = mrOk then
    if DatasetsLB.ItemIndex = 0 then
    begin
      FDataBand.DataSet := nil;
      FDataBand.RowCount := StrToInt(RecordsS.Text);
    end
    else
    begin
      FDataBand.DataSet := TfrxDataSet(DatasetsLB.Items.Objects[DatasetsLB.ItemIndex]);
      FDataBand.RowCount := StrToInt(RecordsS.Text);
    end;
end;

procedure TfrxDataBandEditorForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(3100);
  RecordsL.Text := frxGet(3101);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
end;

procedure TfrxDataBandEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

procedure TfrxDataBandEditorForm.DatasetsLBClick(Sender: TObject);
begin
  if DatasetsLB.ItemIndex <> 0 then
    RecordsS.Text := '0';
end;

end.

