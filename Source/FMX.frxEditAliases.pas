
{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{              Aliases editor              }
{                                          }
{         Copyright (c) 1998-2011          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditAliases;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, FMX.Objects, FMX.Controls, FMX.Forms, FMX.Dialogs, System.Math,
  FMX.frxClass, System.Variants, FMX.Edit, FMX.Types, FMX.Layouts, FMX.Grid, System.UITypes, System.Rtti
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};


type


{$IFNDEF DELPHI17}
  TfrxStringGrid = class(TStringGrid)
  protected
    function GetValue(Col, Row: Integer): Variant; override;
    procedure SetValue(Col, Row: Integer; const Value: Variant); override;
  end;
  THackStringGrid = class(TfrxStringGrid);
{$ELSE}
  THackStringGrid = class(TStringGrid);
{$ENDIF}

  TfrxAliasesEditorForm = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    ResetB: TButton;
    HintL: TLabel;
    DSAliasL: TLabel;
    DSAliasE: TEdit;
    FieldAliasesL: TLabel;
    UpdateB: TButton;
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ResetBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateBClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FDataSet: TfrxCustomDBDataset;
{$IFDEF DELPHI17}
    AliasGrid: TStringGrid;
{$ELSE}
    AliasGrid: TfrxStringGrid;
{$ENDIF}
    procedure BuildAliasList(List: TStrings);
  public
    property DataSet: TfrxCustomDBDataset read FDataSet write FDataSet;
  end;

  { TStringColumn }

  TStringCheckColumn = class(TCheckColumn)
  private
    FRowCount: integer;
    FCheckCells: array of Boolean;
  protected
{$IFNDEF DELPHI17}
    procedure UpdateColumn; override;
{$ELSE}
{$IFNDEF DELPHI24}
    procedure UpdateRowCount(const RowCount: integer); override;
    function GetCells(ARow: Integer): TValue; override;
    procedure SetCells(ARow: Integer; const Value: TValue); override;
{$ENDIF}
{$ENDIF}
  end;


implementation

{$R *.FMX}

uses FMX.frxRes, FMX.frxFMX;


{ TStringColumn }

{$IFNDEF DELPHI17}
procedure TStringCheckColumn.UpdateColumn;
begin
  inherited;
  FRowCount := Min(Grid.RowCount, Grid.VisibleRows);
  SetLength(FCellControls, FRowCount);
end;
{$ELSE}
{$IFNDEF DELPHI24}
procedure TStringCheckColumn.UpdateRowCount(const RowCount: integer);
begin
  if (RowCount > 0) then
    SetLength(FCheckCells, RowCount);
  FRowCount := RowCount;
end;

function TStringCheckColumn.GetCells(ARow: Integer): TValue;
begin
  if (ARow >= 0) and (ARow < Length(FCheckCells)) then
    Result := FCheckCells[ARow]
  else
    Result := inherited GetCells(ARow);
end;

procedure TStringCheckColumn.SetCells(ARow: Integer; const Value: TValue);
var
  S: Boolean;
  LGrid : TCustomGrid;
begin
  if (ARow >= 0) and (ARow < Length(FCheckCells)) then
  begin
    S := Value.AsBoolean;
    if FCheckCells[ARow] <> S then
    begin
      FCheckCells[ARow] := S;
      LGrid := Grid;
      if Assigned(LGrid) then
{$IFDEF DELPHI20}
        UpdateCell(ARow);
{$ELSE}
        UpdateColumn;
{$ENDIF}
    end;
  end
  else
    inherited SetCells(ARow, Value);
end;
{$ENDIF}
{$ENDIF}

procedure TfrxAliasesEditorForm.BuildAliasList(List: TStrings);
var
  i, CheckColumn, AliasColumn, NameColumn: Integer;
  s: String;
begin
  AliasGrid.BeginUpdate;
  AliasGrid.RowCount := List.Count;

  // in case column was moved
  for i := 0 to AliasGrid.ColumnCount - 1 do
    case AliasGrid.Columns[i].Tag of
      1: CheckColumn := AliasGrid.Columns[i].Index;
      2: AliasColumn := AliasGrid.Columns[i].Index;
      3: NameColumn := AliasGrid.Columns[i].Index;
    end;

  for i := 0 to List.Count - 1 do
  begin
    s := List.Names[i];
{$IFNDEF DELPHI24}
    THackStringGrid(AliasGrid).SetValue(CheckColumn, i, False);
{$ELSE}
    THackStringGrid(AliasGrid).Cells[CheckColumn, i] := BoolToStr(False);
{$ENDIF}
    AliasGrid.Cells[AliasColumn, i] := List.Values[s];
    if s[1] = '-' then   { field is disabled }
      s := Copy(s, 2, 255) else
{$IFNDEF DELPHI24}
      THackStringGrid(AliasGrid).SetValue(CheckColumn, i, True);
{$ELSE}
      THackStringGrid(AliasGrid).Cells[CheckColumn, i] := BoolToStr(True);
{$ENDIF}
    AliasGrid.Cells[NameColumn, i] := s;
  end;
  AliasGrid.EndUpdate;
end;



procedure TfrxAliasesEditorForm.FormShow(Sender: TObject);
begin
  DSAliasE.Text := FDataSet.UserName;
  BuildAliasList(FDataSet.FieldAliases);
  if FDataSet.FieldAliases.Count = 0 then
    ResetBClick(nil);
end;

procedure TfrxAliasesEditorForm.FormHide(Sender: TObject);
var
  i, CheckColumn, AliasColumn, NameColumn: Integer;
  s: String;
begin
  if ModalResult = mrOk then
  begin
    FDataSet.UserName := DSAliasE.Text;
    FDataSet.FieldAliases.Clear;

    // in case column was moved
    for i := 0 to AliasGrid.ColumnCount - 1 do
      case AliasGrid.Columns[i].Tag of
        1: CheckColumn := AliasGrid.Columns[i].Index;
        2: AliasColumn := AliasGrid.Columns[i].Index;
        3: NameColumn := AliasGrid.Columns[i].Index;
      end;

    for i := 0 to AliasGrid.RowCount - 1 do
    begin
      s := AliasGrid.Cells[NameColumn, i];
{$IFNDEF DELPHI17}
      if THackStringGrid(AliasGrid).GetValue(CheckColumn, i) <> True then { disable the field }
{$ELSE}
{$IFNDEF DELPHI24}
      if THackStringGrid(AliasGrid).GetValue(CheckColumn, i).AsBoolean <> True then { disable the field }
{$ELSE}
      if StrToBool(AliasGrid.Cells[CheckColumn, i]) <> True then { disable the field }
{$ENDIF}
{$ENDIF}
        s := '-' + s;
      FDataSet.FieldAliases.Add(s + '=' + AliasGrid.Cells[AliasColumn, i]);
    end;
  end;
end;

procedure TfrxAliasesEditorForm.ResetBClick(Sender: TObject);
var
  i: Integer;
  l1, l2: TStrings;
begin
  l1 := TStringList.Create;
  l2 := TStringList.Create;
  l1.Assign(FDataSet.FieldAliases);
  { clear aliases to get real field names }
  FDataSet.FieldAliases.Clear;
  FDataSet.GetFieldList(l2);
  { set aliases back }
  FDataSet.FieldAliases.Assign(l1);
  l1.Free;

  for i := 0 to l2.Count - 1 do
    l2[i] := l2[i] + '=' + l2[i];

  BuildAliasList(l2);
  l2.Free;
end;

procedure TfrxAliasesEditorForm.UpdateBClick(Sender: TObject);
var
  i: Integer;
  l1, l2: TStrings;
begin
  l1 := TStringList.Create;
  l2 := TStringList.Create;
  l1.Assign(FDataSet.FieldAliases);
  try
    { clear aliases to get real field names }
    FDataSet.FieldAliases.Clear;
    FDataSet.GetFieldList(l2);
  finally
    { set aliases back }
    FDataSet.FieldAliases.Assign(l1);
  end;

  for i := 0 to l2.Count - 1 do
    if l1.IndexOfName(l2[i]) = -1 then
      l2[i] := l2[i] + '=' + l2[i]
    else
      l2[i] := l2[i] + '=' + l1.Values[l2[i]];

  BuildAliasList(l2);
  l1.Free;
  l2.Free;
end;

procedure TfrxAliasesEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormHide(Self);
end;

procedure TfrxAliasesEditorForm.FormCreate(Sender: TObject);
var
  SColumn: TStringColumn;
  CBColumn: TStringCheckColumn;
begin
  Caption := frxGet(3600);
  HintL.Text := frxGet(3601);
  DSAliasL.Text := frxGet(3602);
  FieldAliasesL.Text := frxGet(3603);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  ResetB.Text := frxGet(3604);
  UpdateB.Text := frxGet(3605);

{$IFDEF DELPHI17}
  AliasGrid := TStringGrid.Create(Self);
{$ELSE}
  AliasGrid := TfrxStringGrid.Create(Self);
{$ENDIF}
  AliasGrid.Parent := Self;
  with AliasGrid do
  begin
    Position.X := 5;
    Position.Y := 32;
    Width := 337;
    Height := 321;
    StyleLookup := 'gridstyle';
    TabOrder := 8;
{$IFDEF DELPHI20}
    Options := Options + [TGridOption.AlternatingRowBackground];
{$ELSE}
	AlternatingRowBackground := True;
{$ENDIF}
    RowHeight := 21;
    RowCount := 0;
  end;

  AliasGrid.BeginUpdate;

  AliasGrid.RowCount := 0;
  CBColumn := TStringCheckColumn.Create(AliasGrid);
  CBColumn.Tag := 1;
  CBColumn.Header := ' - ';
  CBColumn.Width := 20;
  AliasGrid.AddObject(CBColumn);

  SColumn := TStringColumn.Create(AliasGrid);
  SColumn.Header := frxResources.Get('alUserName');
  SColumn.Tag := 2;
  AliasGrid.AddObject(SColumn);

  SColumn := TStringColumn.Create(AliasGrid);
  SColumn.Header := frxResources.Get('alOriginal');
  SColumn.ReadOnly := True;
  SColumn.Tag := 3;
  AliasGrid.AddObject(SColumn);
  TCheckColumn(AliasGrid.ColumnByIndex(0)).Header := '-';

  AliasGrid.EndUpdate;
end;

procedure TfrxAliasesEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
  if Key = vkF5 then
   UpdateBClick(nil);
end;

{$IFNDEF DELPHI17}
{ TfrxStringGrid }

function TfrxStringGrid.GetValue(Col, Row: Integer): Variant;
var
  C: TColumn;
begin
  C := Columns[Col];
  if C is TStringCheckColumn then
  begin
    if Length(TStringCheckColumn(C).FCheckCells) <> RowCount then
      SetLength(TStringCheckColumn(C).FCheckCells, RowCount);
    Result := TStringCheckColumn(C).FCheckCells[Row]
  end
  else
    Result := inherited GetValue(Col, Row);
end;

procedure TfrxStringGrid.SetValue(Col, Row: Integer; const Value: Variant);
var
  C: TColumn;
begin
  C := Columns[Col];
  if C is TStringCheckColumn then
  begin
    if Length(TStringCheckColumn(C).FCheckCells) <> RowCount then
      SetLength(TStringCheckColumn(C).FCheckCells, RowCount);
    TStringCheckColumn(C).FCheckCells[Row] := Value;
    //TStringCheckColumn(C).UpdateColumn;
  end
  else
    inherited;
end;
{$ENDIF}

end.
