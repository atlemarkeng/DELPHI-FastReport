
{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{       ADO components registration        }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMXfrxADOReg;

interface

{$I frx.inc}

procedure Register;

implementation

uses
  System.SysUtils, System.Classes, FMX.Controls
, DesignIntf, DesignEditors
, FMX.frxADOComponents;

procedure Register;
begin
  RegisterComponents('FastReport 2.0 FMX', [TfrxADOComponents]);
end;

end.
