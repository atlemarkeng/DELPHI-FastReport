
{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{       IBX components registration        }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMXfrxIBXReg;

interface

{$I frx.inc}
{$I fmx.inc}

procedure Register;

implementation

uses
  System.SysUtils, System.Classes, FMX.Controls
, DesignIntf, DesignEditors
, FMX.frxIBXComponents;

procedure Register;
begin
  RegisterComponents('FastReport 2.0 FMX', [TfrxIBXComponents]);
end;

end.
