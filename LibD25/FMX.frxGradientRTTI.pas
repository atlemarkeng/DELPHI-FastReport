
{******************************************}
{                                          }
{             FastReport v4.0              }
{              Gradient RTTI               }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxGradientRTTI;

interface

{$I frx.inc}

implementation

uses
  System.Classes, System.SysUtils, FMX.Forms, FMX.fs_iinterpreter, FMX.frxGradient, FMX.frxClassRTTI
, System.Variants, System.Types;
  

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
    AddEnum('TfrxGradientStyle', 'gsHorizontal, gsVertical, gsElliptic, ' +
      'gsRectangle, gsVertCenter, gsHorizCenter');
    AddClass(TfrxGradientView, 'TfrxView');
  end;
end;


initialization
  fsRTTIModules.Add(TFunctions);
  
finalization
  fsRTTIModules.Remove(TFunctions);

end.
