
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

unit FMXfrxRegTee;

{$I frx.inc}

interface


procedure Register;

implementation

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Controls, FMX.Forms, FMX.Types,
  DesignIntf, DesignEditors,
  FMX.frxChart;


procedure Register;
begin
  RegisterComponents('FastReport 2.0 FMX',
    [TfrxChartObject]);
  //GroupDescendentsWith(TfrxChartObject, TControl);
end;

end.


//56db3b0f55102b9488a240d37950543f