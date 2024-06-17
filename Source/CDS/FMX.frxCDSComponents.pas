
{******************************************}
{                                          }
{             FastReport FMX v1.0          }
{         CDS enduser components           }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxCDSComponents;

interface

{$I frx.inc}

uses
  System.Classes, System.SysUtils, FMX.frxClass, FMX.frxCustomDB, Data.DB
, System.Variants, Datasnap.DBClient, FMX.Types
{$IFDEF QBUILDER}
, fqbClass
{$ENDIF};


type
[ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxCDSComponents = class(TfrxDBComponents)
  private
    FOldComponents: TfrxCDSComponents;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetDescription: String; override;
  end;

  TfrxClientDataSet = class(TfrxCustomTable)
  private
    FCDS: TClientDataSet;
    function GetFileName: String;
    procedure SetFileName(const Value: String);
    function GetPacketRecords: Integer;
    function GetProviderName: String;
    function GetStoreDefs: Boolean;
    procedure SetPacketRecords(const Value: Integer);
    procedure SetProviderName(const Value: String);
    procedure SetStoreDefs(const Value: Boolean);
  protected
    procedure SetMaster(const Value: TDataSource); override;
    procedure SetMasterFields(const Value: String); override;
    procedure SetIndexName(const Value: String); override;
    procedure SetIndexFieldNames(const Value: String); override;
    procedure SetTableName(const Value: String); override;
    function GetIndexName: String; override;
    function GetIndexFieldNames: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property ClientDataSet: TClientDataSet read FCDS;
  published
    property Active;
    property FileName: String read GetFileName write SetFileName;
    property StoreDefs: Boolean read GetStoreDefs write SetStoreDefs;
    property PacketRecords: Integer read GetPacketRecords write SetPacketRecords;
    property ProviderName: String read GetProviderName write SetProviderName;
  end;

var
  CDSComponents: TfrxCDSComponents;


implementation

uses
  FMX.frxCDSRTTI,
{$IFNDEF NO_EDITORS}
  FMX.frxCDSEditor,
{$ENDIF}
  FMX.frxDsgnIntf, FMX.frxRes;


{ TfrxCDSComponents }

constructor TfrxCDSComponents.Create(AOwner: TComponent);
begin
  inherited;;
  FOldComponents := CDSComponents;
  CDSComponents := Self;
end;

destructor TfrxCDSComponents.Destroy;
begin
  if CDSComponents = Self then
    CDSComponents := FOldComponents;
  inherited;
end;

function TfrxCDSComponents.GetDescription: String;
begin
  Result := 'CDS';
end;


{ TfrxCDSComponents }

constructor TfrxClientDataSet.Create(AOwner: TComponent);
begin

  FCDS := TClientDataSet.Create(nil);
  DataSet := FCDS;
  if CDSComponents <> nil then
  begin
  end;
  inherited;
end;

class function TfrxClientDataSet.GetDescription: String;
begin
  // to do add to res
  Result := frxResources.Get('Client Dataset');
end;

function TfrxClientDataSet.GetFileName: String;
begin
  Result := FCDS.FileName;
end;

function TfrxClientDataSet.GetIndexName: String;
begin
  Result := FCDS.IndexName;
end;

function TfrxClientDataSet.GetPacketRecords: Integer;
begin
  Result := FCDS.PacketRecords;
end;

function TfrxClientDataSet.GetProviderName: String;
begin
  Result := FCDS.ProviderName;
end;

function TfrxClientDataSet.GetStoreDefs: Boolean;
begin
  Result := FCDS.StoreDefs;
end;

function TfrxClientDataSet.GetIndexFieldNames: String;
begin
  Result := FCDS.IndexFieldNames;
end;


procedure TfrxClientDataSet.SetIndexName(const Value: String);
begin
  FCDS.IndexName := Value;
end;

procedure TfrxClientDataSet.SetFileName(const Value: String);
begin
  FCDS.FileName := Value;
end;

procedure TfrxClientDataSet.SetIndexFieldNames(const Value: String);
begin
  FCDS.IndexFieldNames := Value;
end;


procedure TfrxClientDataSet.SetMaster(const Value: TDataSource);
begin
  FCDS.MasterSource := Value;
end;

procedure TfrxClientDataSet.SetMasterFields(const Value: String);
begin
  FCDS.MasterFields := Value;
end;

procedure TfrxClientDataSet.SetPacketRecords(const Value: Integer);
begin
  FCDS.PacketRecords := Value;
end;

procedure TfrxClientDataSet.SetProviderName(const Value: String);
begin
  FCDS.ProviderName := Value;
end;

procedure TfrxClientDataSet.SetStoreDefs(const Value: Boolean);
begin
  FCDS.StoreDefs := Value;
end;

procedure TfrxClientDataSet.SetTableName(const Value: String);
begin
  inherited;

end;

initialization
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TfrxCDSComponents, TFmxObject);
  frxObjects.RegisterObject1(TfrxClientDataSet, nil, '', {$IFDEF DB_CAT}'DATABASES'{$ELSE}''{$ENDIF}, 0, 254);

finalization
  frxObjects.UnRegister(TfrxClientDataSet);


end.