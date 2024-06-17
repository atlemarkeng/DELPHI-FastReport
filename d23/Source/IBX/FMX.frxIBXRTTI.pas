
{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{          IBX components RTTI             }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxIBXRTTI;

interface

{$I frx.inc}

implementation

uses
  System.Classes, FMX.fs_iinterpreter, FMX.frxIBXComponents, FMX.fs_iibxrtti
, System.Variants;


type
  TFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance: TObject; ClassType: TClass;
      const MethodName: String; Caller: TfsMethodHelper): Variant;
    function GetProp(Instance: TObject; ClassType: TClass;
      const PropName: String): Variant;
  public
    constructor Create(AScript: TfsScript); override;
  end;


{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
    with AddClass(TfrxIBXDatabase, 'TfrxCustomDatabase') do
      AddProperty('Database', 'TIBDatabase', GetProp, nil);
    with AddClass(TfrxIBXTable, 'TfrxCustomTable') do
      AddProperty('Table', 'TIBTable', GetProp, nil);
    with AddClass(TfrxIBXQuery, 'TfrxCustomQuery') do
    begin
      AddMethod('procedure ExecSQL', CallMethod);
      AddProperty('Query', 'TIBQuery', GetProp, nil);
    end;
  end;
end;

function TFunctions.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result := 0;

  if ClassType = TfrxIBXQuery then
  begin
    if MethodName = 'EXECSQL' then
      TfrxIBXQuery(Instance).Query.ExecSQL
  end
end;

function TFunctions.GetProp(Instance: TObject; ClassType: TClass;
  const PropName: String): Variant;
begin
  Result := 0;

  if ClassType = TfrxIBXDatabase then
  begin
    if PropName = 'DATABASE' then
      Result := frxInteger(TfrxIBXDatabase(Instance).Database)
  end
  else if ClassType = TfrxIBXTable then
  begin
    if PropName = 'TABLE' then
      Result := frxInteger(TfrxIBXTable(Instance).Table)
  end
  else if ClassType = TfrxIBXQuery then
  begin
    if PropName = 'QUERY' then
      Result := frxInteger(TfrxIBXQuery(Instance).Query)
  end
end;


initialization
  fsRTTIModules.Add(TFunctions);

finalization
  fsRTTIModules.Remove(TFunctions);

end.
