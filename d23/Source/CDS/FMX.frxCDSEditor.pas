
{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{      CDS components design editors       }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxCDSEditor;

interface

{$I frx.inc}

implementation

uses
  System.Classes, FMX.frxCDSComponents, FMX.frxCustomDB, FMX.frxDsgnIntf, Data.DB
, System.Variants, System.UITypes, FMX.Dialogs, Datasnap.DBClient;


type
  TfrxFileNameProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
    function Edit: Boolean; override;
  end;

  TfrxIndexNameProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
  end;


{ TfrxFileNameProperty }

function TfrxFileNameProperty.Edit: Boolean;
var
  OpDlg: TOpenDialog;
begin
  with TOpenDialog.Create(nil) do
  begin
    Filter := 'XML data table|*.xml';
    Options := [TOpenOption.ofFileMustExist];
    if Execute then
    begin
      SetValue(FileName);
      Result := True;
    end;
    Free;
  end;
end;

function TfrxFileNameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [{paDialog}];
end;

procedure TfrxFileNameProperty.GetValues;
begin
  inherited;
end;

{ TfrxIndexProperty }

function TfrxIndexNameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList];
end;

procedure TfrxIndexNameProperty.GetValues;
var
  i: Integer;
begin
  inherited;
  try
    with TfrxClientDataSet(Component).ClientDataSet do
      if (FileName <> '') and (IndexDefs <> nil) then
      begin
        IndexDefs.Update;
        for i := 0 to IndexDefs.Count - 1 do
          if IndexDefs[i].Name <> '' then
            Values.Add(IndexDefs[i].Name);
      end;
  except
  end;
end;


initialization
  frxPropertyEditors.Register(TypeInfo(String), TfrxClientDataSet, 'FileName',
    TfrxFileNameProperty);
  frxPropertyEditors.Register(TypeInfo(String), TfrxClientDataSet, 'IndexName',
    TfrxIndexNameProperty);
  frxHideProperties(TfrxClientDataSet, 'TableName')


end.
