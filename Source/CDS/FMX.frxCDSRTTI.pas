
{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{          CDS components RTTI             }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxCDSRTTI;

interface

{$I frx.inc}

implementation

uses
  System.Classes, System.SysUtils, FMX.Forms, FMX.fs_iinterpreter, FMX.frxCDSComponents,
  System.Variants, Datasnap.DBClient;


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
    AddClass(TClientDataSet, 'TDataSet');
    with AddClass(TfrxClientDataSet, 'TfrxCustomTable') do
      AddProperty('ClientDataSet', 'ClientDataSet', GetProp, nil);

  end;
end;

function TFunctions.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result := 0;
  //todo
end;

function TFunctions.GetProp(Instance: TObject; ClassType: TClass;
  const PropName: String): Variant;
begin
  Result := 0;

  if ClassType = TfrxClientDataSet then
  begin
    if PropName = 'CLIENDDATASET' then
      Result := frxInteger(TfrxClientDataSet(Instance).ClientDataSet)
  end
end;


initialization
  fsRTTIModules.Add(TFunctions);

finalization
  fsRTTIModules.Remove(TFunctions);

end.
