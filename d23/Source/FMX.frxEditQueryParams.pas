
{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{           Query params editor            }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditQueryParams;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Forms,
  Data.DB, FMX.frxCustomDB, FMX.frxCtrls, System.Rtti, System.UITypes
, System.Variants, FMX.Edit, FMX.ListBox, FMX.Layouts, FMX.Grid, System.Types
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};


type
  THackStringGrid = class(TStringGrid);
  TfrxParamsEditorForm = class(TForm)
    TypeCB: TComboBox;
    OkB: TButton;
    CancelB: TButton;
    ButtonPanel: TPanel;
    ExpressionB: TSpeedButton;
    ParamGrid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure OkBClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ValueEButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure ParamGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure TypeCBChange(Sender: TObject);
    procedure ParamGridResize(Sender: TObject);
    procedure ParamGridDragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF});
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FParams: TfrxParams;
  public
    property Params: TfrxParams read FParams write FParams;
  end;


implementation

{$R *.FMX}

uses FMX.frxClass, FMX.frxRes, FMX.frxFMX;

{ TfrxParamEditorForm }

procedure TfrxParamsEditorForm.FormShow(Sender: TObject);
var
  i, NameColumn, dTypeColumn, ExpColumn: Integer;
  t: TFieldType;
begin
    // in case column was moved
  for i := 0 to ParamGrid.ColumnCount - 1 do
    case ParamGrid.Columns[i].Tag of
      1: NameColumn := ParamGrid.Columns[i].Index;
      2: dTypeColumn := ParamGrid.Columns[i].Index;
      3: ExpColumn := ParamGrid.Columns[i].Index;
    end;

  ParamGrid.RowCount := Params.Count;
  ParamGrid.BeginUpdate;
  for i := 0 to Params.Count - 1 do
  begin
    ParamGrid.Cells[0, i] := Params[i].Name;
    ParamGrid.Cells[1, i] := FieldTypeNames[Params[i].DataType];
    ParamGrid.Cells[2, i] := Params[i].Expression;
  end;
  ParamGrid.EndUpdate;
  for t := Low(TFieldType) to High(TFieldType) do
    TypeCB.Items.Add(FieldTypeNames[t]);

  ButtonPanel.Height := TypeCB.Height - 2;
  ExpressionB.Height := TypeCB.Height - 2;
  ButtonPanel.Visible := False;
  TypeCB.Visible := False;
end;

procedure TfrxParamsEditorForm.FormHide(Sender: TObject);
var
  i, dTypeColumn, ExpColumn: Integer;
  t: TFieldType;
begin
  if ModalResult <> mrOk then Exit;

    // in case column was moved
  for i := 0 to ParamGrid.ColumnCount - 1 do
    case ParamGrid.Columns[i].Tag of
      2: dTypeColumn := ParamGrid.Columns[i].Index;
      3: ExpColumn := ParamGrid.Columns[i].Index;
    end;

  for i := 0 to ParamGrid.RowCount - 1 do
  begin
    for t := Low(TFieldType) to High(TFieldType) do
      if ParamGrid.Cells[dTypeColumn, i] = FieldTypeNames[t] then
      begin
        Params[i].DataType := t;
        break;
      end;
    Params[i].Expression := ParamGrid.Cells[ExpColumn, i];
  end;
end;

procedure TfrxParamsEditorForm.ParamGridDragOver(Sender: TObject;
  const Data: TDragObject; const Point: TPointF; {$IFNDEF DELPHI20}var Accept: Boolean{$ELSE} var Operation: TDragOperation{$ENDIF});
begin
  ParamGridResize(nil);
end;

procedure TfrxParamsEditorForm.ParamGridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
 C: TColumn;
 RowIndex, i: Integer;
 s: String;
begin
  TypeCB.Visible := False;
  ButtonPanel.Visible := False;
  C := ParamGrid.ColumnByPoint(X, Y);
  if C <> nil then
  begin
    if C.Tag = 2 then
    begin
      TypeCB.Position.X := C.Position.X + ParamGrid.Position.X + 2;
      RowIndex := ParamGrid.RowByPoint(X, Y);
      if RowIndex > ParamGrid.RowCount - 1 then Exit;
      i := TypeCB.Items.IndexOf(ParamGrid.Cells[C.Index, RowIndex]);
      if i <> -1 then
        TypeCB.ListItems[i].IsSelected := True
      else
        TypeCB.ListItems[0].IsSelected := True;
      TypeCB.Position.Y := RowIndex * ParamGrid.RowHeight + ParamGrid.Position.Y + ParamGrid.RowHeight + 3;
      TypeCB.Width := C.Width;
      TypeCB.Visible := True;
    end
    else
    if C.Tag = 3 then
    begin
      ButtonPanel.Visible := True;
      ButtonPanel.Position.X := C.Position.X + ParamGrid.Position.X + C.Width -  ButtonPanel.Width - 2;
      RowIndex := ParamGrid.RowByPoint(X, Y);
      if RowIndex > ParamGrid.RowCount - 1 then Exit;

      ButtonPanel.Position.Y := RowIndex * ParamGrid.RowHeight + ParamGrid.Position.Y + ParamGrid.RowHeight + 3;
      ButtonPanel.Visible := True;
    end;
  end;
end;


procedure TfrxParamsEditorForm.ParamGridResize(Sender: TObject);
begin
  TypeCB.Visible := False;
  ButtonPanel.Visible := False;
end;

procedure TfrxParamsEditorForm.TypeCBChange(Sender: TObject);
begin
  if TypeCB.Selected <> nil then
    ParamGrid.Cells[ParamGrid.ColumnIndex, ParamGrid.Selected] := TypeCB.Selected.Text;
end;

procedure TfrxParamsEditorForm.OkBClick(Sender: TObject);
begin
//  ParamsLV.Selected := ParamsLV.Items[0];
end;

procedure TfrxParamsEditorForm.ValueEButtonClick(Sender: TObject);
var
  s: String;
begin
  s := TfrxCustomDesigner(Owner).InsertExpression(ParamGrid.Cells[ParamGrid.ColumnIndex, ParamGrid.Selected]);
  if s <> '' then
    ParamGrid.Cells[ParamGrid.ColumnIndex, ParamGrid.Selected] := s;
end;

procedure TfrxParamsEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormHide(Self);
end;

procedure TfrxParamsEditorForm.FormCreate(Sender: TObject);
var
  SColumn: TStringColumn;
begin

  Caption := frxGet(3700);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  ParamGrid.BeginUpdate;

  ParamGrid.RowCount := 0;

  SColumn := TStringColumn.Create(ParamGrid);
  SColumn.Header := frxResources.Get('qpName');
  SColumn.ReadOnly := True;
  SColumn.Tag := 1;
  SColumn.OnResize := ParamGridResize;
  SColumn.OnDragEnd := ParamGridResize;
  SColumn.OnDragOver := ParamGridDragOver;
  ParamGrid.AddObject(SColumn);

  SColumn := TStringColumn.Create(ParamGrid);
  SColumn.Header := frxResources.Get('qpDataType');
  SColumn.ReadOnly := True;
  SColumn.Tag := 2;
  SColumn.OnResize := ParamGridResize;
  SColumn.OnDragEnd := ParamGridResize;
  SColumn.OnDragOver := ParamGridDragOver;
  ParamGrid.AddObject(SColumn);

  SColumn := TStringColumn.Create(ParamGrid);
  SColumn.Header := frxResources.Get('qpValue');
  SColumn.ReadOnly := False;
  SColumn.OnResize := ParamGridResize;
  SColumn.OnDragEnd := ParamGridResize;
  SColumn.OnDragOver := ParamGridDragOver;
  SColumn.Tag := 3;
  ParamGrid.AddObject(SColumn);

  ParamGrid.EndUpdate;

end;

procedure TfrxParamsEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

end.


//56db3b0f55102b9488a240d37950543f