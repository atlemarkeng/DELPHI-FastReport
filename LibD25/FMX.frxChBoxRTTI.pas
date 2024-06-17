
{******************************************}
{                                          }
{             FastReport v2.0              }
{              CheckBox RTTI               }
{                                          }
{         Copyright (c) 1998-2014          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxChBoxRTTI;

interface

{$I frx.inc}

implementation

uses
  System.Classes, System.Types, System.SysUtils, FMX.Forms, FMX.fs_iinterpreter, FMX.frxChBox, FMX.frxClassRTTI, System.Variants;


type
  TFunctions = class(TfsRTTIModule)
  public
    constructor Create(AScript: TfsScript); override;
  end;


{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
    AddEnum('TfrxCheckStyle', 'csCross, csCheck, csLineCross, csPlus');
    AddEnum('TfrxUncheckStyle', 'usEmpty, usCross, usLineCross, usMinus');
    AddClass(TfrxCheckBoxView, 'TfrxView');
  end;
end;


initialization
  fsRTTIModules.Add(TFunctions);

finalization
  fsRTTIModules.Remove(TFunctions);

end.

