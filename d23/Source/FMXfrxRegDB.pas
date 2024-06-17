
{******************************************}
{                                          }
{             FastReport v4.0              }
{            Registration unit             }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMXfrxRegDB;

{$I frx.inc}

interface


procedure Register;

implementation

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Forms, FMX.Controls,
  DesignIntf, DesignEditors,
  FMX.frxDBSet, FMX.frxCustomDB, FMX.frxCustomDBEditor, FMX.frxCustomDBRTTI, FMX.frxEditMD,
  FMX.frxEditQueryParams;


{-----------------------------------------------------------------------}
procedure Register;
begin
  RegisterComponents('FastReport 2.0 FMX', [TfrxDBDataset]);
  ///GroupDescendentsWith(TfrxDBDataset, TControl);
end;

end.


//56db3b0f55102b9488a240d37950543f