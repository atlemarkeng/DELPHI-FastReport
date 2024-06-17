
{******************************************}
{                                          }
{             FastReport v4.0              }
{          DBX components RTTI             }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxDBXRTTI;

interface

{$I frx.inc}

implementation

uses
  System.Classes, FMX.fs_iinterpreter, FMX.frxDBXComponents, System.Variants;


type
  TFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance: TObject; ClassType: TClass;
      const MethodName: String; Caller: TfsMethodHelper): Variant;
  public
    constructor Create(AScript: TfsScript); override;
  end;


{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
    AddClass(TfrxDBXDatabase, 'TfrxCustomDatabase');
    AddClass(TfrxDBXTable, 'TfrxCustomTable');
    with AddClass(TfrxDBXQuery, 'TfrxCustomQuery') do
      AddMethod('procedure ExecSQL', CallMethod);
  end;
end;

function TFunctions.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result := 0;

  if ClassType = TfrxDBXQuery then
  begin
    if MethodName = 'EXECSQL' then
      TfrxDBXQuery(Instance).Query.ExecSQL
  end
end;


initialization
  fsRTTIModules.Add(TFunctions);

finalization
  fsRTTIModules.Remove(TFunctions);

end.
