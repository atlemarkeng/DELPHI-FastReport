{ --------------------------------------------------------------------------- }
{ AnyDAC FastReport v 2.0 enduser components                                  }
{                                                                             }
{ (c)opyright DA-SOFT Technologies 2004-2013.                                 }
{ All rights reserved.                                                        }
{                                                                             }
{ Initially created by: Serega Glazyrin <glserega@mezonplus.ru>               }
{ Extended by: Francisco Armando Duenas Rodriguez <fduenas@gmxsoftware.com>   }
{ --------------------------------------------------------------------------- }
{$I frx.inc}

unit FMX.frxFDReg;

interface

procedure Register;

implementation

uses
 System.SysUtils, System.Classes
{$IFNDEF Delphi6}
, DsgnIntf
{$ELSE}
, DesignIntf, DesignEditors
{$ENDIF}
, FMX.frxFDComponents;

procedure Register;
begin
  RegisterComponents('FastReport 2.0 FMX', [TfrxFDComponents]);
end;

end.
