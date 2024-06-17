
{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{       DBX components registration        }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMXfrxDBXReg;

interface

{$I frx.inc}

procedure Register;

implementation

uses
  System.SysUtils, System.Classes, FMX.Controls
, DesignIntf, DesignEditors
, FMX.frxDBXComponents;

procedure Register;
begin
  RegisterComponents('FastReport 2.0 FMX', [TfrxDBXComponents]);
end;

end.
