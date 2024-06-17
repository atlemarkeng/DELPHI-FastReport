
{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{      Custom TDataSet-based classes       }
{        for enduser DB components         }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxCustomDB;

interface

{$I frx.inc}

uses
  System.Classes, System.SysUtils, Data.DB, FMX.frxClass, FMX.frxDBSet,
  FMX.ListBox, System.Variants, System.Types, FMX.Types
{$IFDEF QBUILDER}
, FMX.fqbClass
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};


type
  TfrxCustomDataset = class(TfrxDBDataSet)
  private
    FDBConnected: Boolean;
    FDataSource: TDataSource;
    FMaster: TfrxDBDataSet;
    FMasterFields: String;
    procedure SetActive(Value: Boolean);
    procedure SetFilter(const Value: String);
    procedure SetFiltered(Value: Boolean);
    function GetActive: Boolean;
    function GetFields: TFields;
    function GetFilter: String;
    function GetFiltered: Boolean;
    procedure InternalSetMaster(const Value: TfrxDBDataSet);
    procedure InternalSetMasterFields(const Value: String);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetParent(AParent: TfrxComponent); override;
    procedure SetUserName(const Value: String); override;
    procedure SetMaster(const Value: TDataSource); virtual;
    procedure SetMasterFields(const Value: String); virtual;
    property DataSet;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure OnPaste; override;
    property DBConnected: Boolean read FDBConnected write FDBConnected;
    property Fields: TFields read GetFields;
    property MasterFields: String read FMasterFields write InternalSetMasterFields;
    property Active: Boolean read GetActive write SetActive default False;
  published
    property Filter: String read GetFilter write SetFilter;
    property Filtered: Boolean read GetFiltered write SetFiltered default False;
    property Master: TfrxDBDataset read FMaster write InternalSetMaster;
  end;

  TfrxCustomTable = class(TfrxCustomDataset)
  protected
    function GetIndexFieldNames: String; virtual;
    function GetIndexName: String; virtual;
    function GetTableName: String; virtual;
    procedure SetIndexFieldNames(const Value: String); virtual;
    procedure SetIndexName(const Value: String); virtual;
    procedure SetTableName(const Value: String); virtual;
    property DataSet;
  published
    property MasterFields;
    property TableName: String read GetTableName write SetTableName;
    property IndexName: String read GetIndexName write SetIndexName;
    property IndexFieldNames: String read GetIndexFieldNames write SetIndexFieldNames;
  end;

  TfrxParamItem = class(TCollectionItem)
  private
    FDataType: TFieldType;
    FExpression: String;
    FName: String;
    FValue: Variant;
  public
    procedure Assign(Source: TPersistent); override;
    property Value: Variant read FValue write FValue;
  published
    property Name: String read FName write FName;
    property DataType: TFieldType read FDataType write FDataType;
    property Expression: String read FExpression write FExpression;
  end;

  TfrxParams = class(TCollection)
  private
    FIgnoreDuplicates: Boolean;
    function GetParam(Index: Integer): TfrxParamItem;
  public
    constructor Create;
    function Add: TfrxParamItem;
    function Find(const Name: String): TfrxParamItem;
    function IndexOf(const Name: String): Integer;
    procedure UpdateParams(const SQL: String);
    property Items[Index: Integer]: TfrxParamItem read GetParam; default;
    property IgnoreDuplicates: Boolean read FIgnoreDuplicates write FIgnoreDuplicates;
  end;


  TfrxCustomQuery = class(TfrxCustomDataset)
  private
    FParams: TfrxParams;
    FSaveOnBeforeOpen: TDataSetNotifyEvent;
    FSaveOnChange: TNotifyEvent;
    FSQLSchema: String;
    procedure ReadData(Reader: TReader);
    procedure SetParams(Value: TfrxParams);
    procedure WriteData(Writer: TWriter);
    function GetIgnoreDupParams: Boolean;
    procedure SetIgnoreDupParams(const Value: Boolean);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure OnBeforeOpen(DataSet: TDataSet); virtual;
    procedure OnChangeSQL(Sender: TObject); virtual;
    procedure SetSQL(Value: TStrings); virtual;
    function GetSQL: TStrings; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateParams; virtual;
    function ParamByName(const Value: String): TfrxParamItem;
{$IFDEF QBUILDER}
    function QBEngine: TfqbEngine; virtual;
{$ENDIF}
  published
    property IgnoreDupParams: Boolean read GetIgnoreDupParams write SetIgnoreDupParams;
    property Params: TfrxParams read FParams write SetParams;
    property SQL: TStrings read GetSQL write SetSQL;
    property SQLSchema: String read FSQLSchema write FSQLSchema;
  end;

  { emulates work of DBLookupComboBox in VCL, for back compatibility only }
  TfrxDBLookupComboBox = class(TfrxDialogControl)
  private
    FDataSet: TfrxDBDataSet;
    FDataSetName: String;
    FComboBox: TComboBox;
    FAutoOpenDataSet: Boolean;
    FIsFilled: Boolean;
    FListField: String;
    FKeyField: String;
    FValue: Variant;
    function GetDataSetName: String;
    function GetKeyField: String;
    function GetKeyValue: Variant;
    function GetListField: String;
    function GetText: String;
    procedure SetDataSet(const Value: TfrxDBDataSet);
    procedure SetDataSetName(const Value: String);
    procedure SetKeyField(Value: String);
    procedure SetKeyValue(const Value: Variant);
    procedure SetListField(Value: String);
    procedure UpdateDataSet;
    procedure OnOpenDS(Sender: TObject);
    function GetDropDownWidth: Integer;
    procedure SetDropDownWidth(const Value: Integer);
    function GetDropDownRows: Integer;
    procedure SetDropDownRows(const Value: Integer);
    procedure DoOnChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    procedure BeforeStartReport; override;
    property ComboBox: TComboBox read FComboBox;
    property KeyValue: Variant read GetKeyValue write SetKeyValue;
    property Text: String read GetText;
    procedure PaintControl(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
  published
    property AutoOpenDataSet: Boolean read FAutoOpenDataSet write FAutoOpenDataSet default False;
    property DataSet: TfrxDBDataset read FDataSet write SetDataSet;
    property DataSetName: String read GetDataSetName write SetDataSetName;
    property ListField: String read GetListField write SetListField;
    property KeyField: String read GetKeyField write SetKeyField;
    property DropDownWidth: Integer read GetDropDownWidth write SetDropDownWidth;
    property DropDownRows: Integer read GetDropDownRows write SetDropDownRows;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;


procedure frxParamsToTParams(Query: TfrxCustomQuery; Params: TParams);


implementation

uses
{$IFNDEF NO_EDITORS}
  FMX.frxCustomDBEditor,
{$ENDIF}
  FMX.frxCustomDBRTTI, FMX.frxDsgnIntf, FMX.frxUtils, FMX.frxRes;


{ TfrxParamItem }

procedure TfrxParamItem.Assign(Source: TPersistent);
begin
  if Source is TfrxParamItem then
  begin
    FName := TfrxParamItem(Source).Name;
    FDataType := TfrxParamItem(Source).DataType;
    FExpression := TfrxParamItem(Source).Expression;
    FValue := TfrxParamItem(Source).Value;
  end;
end;

{ TfrxParams }

constructor TfrxParams.Create;
begin
  inherited Create(TfrxParamItem);
  FIgnoreDuplicates := False;
end;

function TfrxParams.Add: TfrxParamItem;
begin
  Result := TfrxParamItem(inherited Add);
end;

function TfrxParams.GetParam(Index: Integer): TfrxParamItem;
begin
  Result := TfrxParamItem(inherited Items[Index]);
end;

function TfrxParams.Find(const Name: String): TfrxParamItem;
var
  i: Integer;
begin
  i := IndexOf(Name);
  if i <> -1 then
    Result := Items[i] else
    Result := nil;
end;

function TfrxParams.IndexOf(const Name: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if CompareText(Items[i].Name, Name) = 0 then
    begin
      Result := i;
      break;
    end;
end;

procedure TfrxParams.UpdateParams(const SQL: String);
var
  i, j: Integer;
  QParams: TParams;
  NewParams: TfrxParams;
begin
  { parse query params }
  QParams := TParams.Create;
  QParams.ParseSQL(SQL, True);

  { create new TfrxParams object and copy all params to it }
  NewParams := TfrxParams.Create;
  for i := 0 to QParams.Count - 1 do
    if not ((NewParams.IndexOf(QParams[i].Name) <> -1) and FIgnoreDuplicates)  then
      with NewParams.Add do
      begin
        Name := QParams[i].Name;
        j := IndexOf(Name);
        if j <> -1 then
        begin
          DataType := Items[j].DataType;
          Value := Items[j].Value;
          Expression := Items[j].Expression;
        end;
      end;
  Assign(NewParams);
  QParams.Free;
  NewParams.Free;
end;

{ TfrxCustomDataset }

constructor TfrxCustomDataset.Create(AOwner: TComponent);
begin
  Component := Dataset;
  inherited;
  CloseDataSource := True;
  FDataSource := TDataSource.Create(nil);
  SetMaster(FDataSource);
end;

destructor TfrxCustomDataset.Destroy;
begin
  FDataSource.Free;
  inherited;
end;

procedure TfrxCustomDataset.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
    if AComponent = FMaster then
      Master := nil
end;

procedure TfrxCustomDataset.SetParent(AParent: TfrxComponent);
begin
  inherited;
  if (AParent <> nil) and (Report <> nil) then
  begin
    if IsDesigning and (Report.DataSets.Find(Self) = nil) then
    begin
      Report.DataSets.Add(Self);
      if Report.Designer <> nil then
        Report.Designer.UpdateDataTree;
    end;
  end;
end;

procedure TfrxCustomDataset.SetUserName(const Value: String);
begin
  inherited;
  if (Report <> nil) and (Report.Designer <> nil) then
    Report.Designer.UpdateDataTree;
end;

procedure TfrxCustomDataset.OnPaste;
var
  i: Integer;
  sl: TStringList;
begin
  if Report = nil then Exit;
  
  if Report.DataSets.Find(Self) = nil then
    Report.DataSets.Add(Self);

  sl := TStringList.Create;

  Report.GetDatasetList(sl);
  for i := 0 to sl.Count - 1 do
    if (sl.Objects[i] <> Self) and (CompareText(sl[i], UserName) = 0) then
    begin
      if Name <> '' then
        UserName := Name;
      break;
    end;
  sl.Free;

  Report.Designer.UpdateDataTree;
end;

procedure TfrxCustomDataset.SetActive(Value: Boolean);
begin
  Dataset.Active := Value;
end;

procedure TfrxCustomDataset.SetFilter(const Value: String);
begin
  Dataset.Filter := Value;
end;

function TfrxCustomDataset.GetActive: Boolean;
begin
  Result := Dataset.Active;
end;

function TfrxCustomDataset.GetFields: TFields;
begin
  Result := Dataset.Fields;
end;

function TfrxCustomDataset.GetFilter: String;
begin
  Result := Dataset.Filter;
end;

function TfrxCustomDataset.GetFiltered: Boolean;
begin
  Result := Dataset.Filtered;
end;

procedure TfrxCustomDataset.SetFiltered(Value: Boolean);
begin
  Dataset.Filtered := Value;
end;

procedure TfrxCustomDataset.InternalSetMaster(const Value: TfrxDBDataSet);
begin
  FMaster := Value;
  if FMaster <> nil then
    FDataSource.DataSet := FMaster.GetDataSet
  else
    FDataSource.DataSet := nil;
end;

procedure TfrxCustomDataset.InternalSetMasterFields(const Value: String);
var
  sl: TStringList;
  s: String;
  i: Integer;

  function ConvertAlias(const s: String): String;
  begin
    if FMaster <> nil then
      Result := FMaster.ConvertAlias(s)
    else
      Result := s;
  end;

begin
  FMasterFields := Value;

  sl := TStringList.Create;
  frxSetCommaText(Value, sl);
  s := '';
  for i := 0 to sl.Count - 1 do
    s := s + ConvertAlias(sl.Values[sl.Names[i]]) + ';';
  s := Copy(s, 1, Length(s) - 1);

  SetMasterFields(s);

  s := '';
  for i := 0 to sl.Count - 1 do
    s := s + ConvertAlias(sl.Names[i]) + ';';
  s := Copy(s, 1, Length(s) - 1);

  if Self is TfrxCustomTable then
    TfrxCustomTable(Self).SetIndexFieldNames(s);

  sl.Free;
end;

procedure TfrxCustomDataset.SetMaster(const Value: TDataSource);
begin
// do nothing
end;

procedure TfrxCustomDataset.SetMasterFields(const Value: String);
begin
// do nothing
end;


{ TfrxCustomTable }

function TfrxCustomTable.GetIndexFieldNames: String;
begin
  Result := '';
end;

function TfrxCustomTable.GetIndexName: String;
begin
  Result := '';
end;

function TfrxCustomTable.GetTableName: String;
begin
  Result := '';
end;

procedure TfrxCustomTable.SetIndexFieldNames(const Value: String);
begin
// do nothing
end;

procedure TfrxCustomTable.SetIndexName(const Value: String);
begin
// do nothing
end;

procedure TfrxCustomTable.SetTableName(const Value: String);
begin
// do nothing
end;


{ TfrxCustomQuery }

constructor TfrxCustomQuery.Create(AOwner: TComponent);
begin
  inherited;
  FParams := TfrxParams.Create;
  FSaveOnBeforeOpen := DataSet.BeforeOpen;
  DataSet.BeforeOpen := OnBeforeOpen;
  FSaveOnChange := TStringList(SQL).OnChange;
  TStringList(SQL).OnChange := OnChangeSQL;
end;

destructor TfrxCustomQuery.Destroy;
begin
  FParams.Free;
  inherited;
end;

procedure TfrxCustomQuery.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Parameters', ReadData, WriteData, True);
end;

procedure TfrxCustomQuery.ReadData(Reader: TReader);
begin
  frxReadCollection(FParams, Reader, Self);
  UpdateParams;
end;

procedure TfrxCustomQuery.WriteData(Writer: TWriter);
begin
  frxWriteCollection(FParams, Writer, Self);
end;

procedure TfrxCustomQuery.OnBeforeOpen(DataSet: TDataSet);
begin
  UpdateParams;
  if Assigned(FSaveOnBeforeOpen) then
    FSaveOnBeforeOpen(DataSet);
end;

procedure TfrxCustomQuery.OnChangeSQL(Sender: TObject);
begin
  if Assigned(FSaveOnChange) then
    FSaveOnChange(Sender);
  FParams.UpdateParams(SQL.Text);
end;

procedure TfrxCustomQuery.SetParams(Value: TfrxParams);
begin
  FParams.Assign(Value);
end;

function TfrxCustomQuery.ParamByName(const Value: String): TfrxParamItem;
begin
  Result := FParams.Find(Value);
  if Result = nil then
    raise Exception.Create('Parameter "' + Value + '" not found'); 
end;

procedure TfrxCustomQuery.SetSQL(Value: TStrings);
begin
//
end;

function TfrxCustomQuery.GetSQL: TStrings;
begin
  Result := nil;
end;

procedure TfrxCustomQuery.UpdateParams;
begin
//
end;

{$IFDEF QBUILDER}
function TfrxCustomQuery.QBEngine: TfqbEngine;
begin
  Result := nil;
end;
{$ENDIF}


{ frxParamsToTParams }

procedure frxParamsToTParams(Query: TfrxCustomQuery; Params: TParams);
var
  i: Integer;
  Item: TfrxParamItem;
begin
  for i := 0 to Params.Count - 1 do
    if Query.Params.IndexOf(Params[i].Name) <> -1 then
    begin
      Item := Query.Params[Query.Params.IndexOf(Params[i].Name)];
      Params[i].Clear;
      Params[i].DataType := Item.DataType;
      { Bound should be True in design mode }
      if not (Query.IsLoading or Query.IsDesigning) then
        Params[i].Bound := False
      else
      begin
        if Item.Expression <> '' then
          Params[i].Value := 0;
        Params[i].Bound := True;
      end;

      if Trim(Item.Expression) <> '' then
        if not (Query.IsLoading or Query.IsDesigning) then
          if Query.Report <> nil then
          begin
            Query.Report.CurObject := Query.Name;
            Item.Value := Query.Report.Calc(Item.Expression);
          end;
      if not VarIsEmpty(Item.Value) then
      begin
        Params[i].Bound := True;
        if Params[i].DataType in [ftDate, ftTime, ftDateTime] then
          Params[i].Value := Item.Value
        else
          Params[i].Text := VarToStr(Item.Value);
      end;

    end;
end;

function TfrxCustomQuery.GetIgnoreDupParams: Boolean;
begin
  Result := FParams.FIgnoreDuplicates;
end;

procedure TfrxCustomQuery.SetIgnoreDupParams(const Value: Boolean);
begin
  FParams.FIgnoreDuplicates := Value;
  FParams.UpdateParams(SQL.Text);
end;

{ TfrxDBLookupComboBox }

constructor TfrxDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited;
  FComboBox := TComboBox.Create(nil);
  InitControl(FComboBox);
  Width := 145;
  Height := 21;
  FComboBox.OnPainting := PaintControl;
  FIsFilled := False;
  FComboBox.OnChange := DoOnChange;
//  FDBLookupComboBox.ListSource := FDataSource;
end;

destructor TfrxDBLookupComboBox.Destroy;
begin
  inherited;
end;

procedure TfrxDBLookupComboBox.DoOnChange(Sender: TObject);
begin
  if (FDataSet <> nil) and FDataSet.HasField(FListField) and (FComboBox.Selected <> nil) then
  begin
    FDataSet.DataSet.Locate(FListField, FComboBox.Selected.Text, []);
    if(FDataSet.HasField(FKeyField)) then
    begin
      FValue := FDataSet.Value[FKeyField];
    end;
  end;

end;

class function TfrxDBLookupComboBox.GetDescription: String;
begin
  Result := frxResources.Get('obDBLookup');
end;

function TfrxDBLookupComboBox.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;

function TfrxDBLookupComboBox.GetKeyField: String;
begin
  Result := FKeyField;
  if FDataSet <> nil then
    Result := FDataSet.GetAlias(Result);
end;

function TfrxDBLookupComboBox.GetKeyValue: Variant;
begin
  Result := FValue;
end;

function TfrxDBLookupComboBox.GetListField: String;
begin
  Result := FListField;
  FDataSet := TfrxDBDataSet(Report.GetDataset(FDataSetName));
  if FDataSet <> nil then
    Result := FDataSet.GetAlias(Result);
end;

function TfrxDBLookupComboBox.GetText: String;
begin
  if FComboBox.Selected <> nil then
    Result := FComboBox.Selected.Text;
end;

procedure TfrxDBLookupComboBox.SetDataSet(const Value: TfrxDBDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
  UpdateDataSet;
end;

procedure TfrxDBLookupComboBox.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  FDataSet := TfrxDBDataSet(FindDataSet(FDataSet, FDataSetName));
  UpdateDataSet;
end;

procedure TfrxDBLookupComboBox.SetKeyField(Value: String);
begin
  if FDataSet <> nil then
    Value := FDataSet.ConvertAlias(Value);
  FKeyField := Value;
  if FListField = '' then
    FListField := FKeyField;
end;

procedure TfrxDBLookupComboBox.SetKeyValue(const Value: Variant);
var
  i: Integer;
begin
  if (FDataSet <> nil) and FDataSet.HasField(FKeyField) and FDataSet.HasField(FListField) then
  begin
    FDataSet.DataSet.Locate(FKeyField, FComboBox.Selected.Text, []);
    i := FComboBox.Items.IndexOf(FDataSet.Value[FListField]);
    if i <> 0 then
    begin
      FValue := Value;
      FComboBox.ListItems[i].IsSelected := True;
    end;
  end;
end;

procedure TfrxDBLookupComboBox.SetListField(Value: String);
begin
  if FDataSet <> nil then
    Value := FDataSet.ConvertAlias(Value);
  FListField := Value;
  FIsFilled := False;
end;

procedure TfrxDBLookupComboBox.UpdateDataSet;
begin
  FIsFilled := False;
end;

procedure TfrxDBLookupComboBox.BeforeStartReport;
begin
//  SetListField(FListField);
//  SetKeyField(FKeyField);
  Self.OnActivate := OnOpenDS;
end;


procedure TfrxDBLookupComboBox.OnOpenDS(Sender: TObject);
begin
  UpdateDataSet;
  if (FDataSet <> nil) and (FAutoOpenDataSet) then
    FDataSet.Open;
  FIsFilled := False;
end;

procedure TfrxDBLookupComboBox.PaintControl(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  if not FIsFilled then
  begin
    if FDataSet = nil then Exit;
    if not FDataSet.HasField(FListField) then Exit;
    FDataSet.First;
{$IFDEF DELPHI23}
    FComboBox.Clear;
{$ELSE}
    FComboBox.Items.Clear;
{$ENDIF}
    FComboBox.BeginUpdate;
    try
      while not FDataSet.Eof do
      begin
        FDataSet.Next;
        FComboBox.Items.Add(FDataSet.Value[FListField]);
      end;
    finally
      FComboBox.EndUpdate;
    end;
    if FComboBox.Items.Count > 0 then
      FComboBox.ListItems[0].IsSelected := True;
    FIsFilled := True;
  end;

end;

function TfrxDBLookupComboBox.GetDropDownWidth: Integer;
begin
  Result := 0;
end;

procedure TfrxDBLookupComboBox.SetDropDownWidth(const Value: Integer);
begin
  //FDBLookupComboBox.DropDownWidth := Value;
end;

function TfrxDBLookupComboBox.GetDropDownRows: Integer;
begin
  Result := FComboBox.DropDownCount;
end;

procedure TfrxDBLookupComboBox.SetDropDownRows(const Value: Integer);
begin
  FComboBox.DropDownCount := Value;;
end;

initialization
  frxObjects.RegisterObject1(TfrxDBLookupComboBox, nil, '', '', 0, 119);

finalization
  frxObjects.UnRegister(TfrxDBLookupComboBox);


end.


//56db3b0f55102b9488a240d37950543f