
{******************************************}
{                                          }
{             FastReport v4.0              }
{               Chart RTTI                 }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxChartRTTI;

interface

{$I frx.inc}

implementation

uses
 System.Classes, System.SysUtils, FMX.Forms, FMX.fs_iinterpreter, FMX.frxChart, FMX.fs_ichartrtti
, System.Variants, System.Types, FMXTee.Engine;
  

type
  TFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance: TObject; ClassType: TClass;
      const MethodName: String; Caller: TfsMethodHelper): Variant;
    function GetProp(Instance: TObject; ClassType: TClass;
      const PropName: String): Variant;
  public
    constructor Create(AScript: TfsScript); override;
  end;


{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
    AddEnum('TfrxSeriesDataType', 'dtDBData, dtBandData, dtFixedData');
    AddEnum('TfrxChartSeries', 'csLine, csArea, csPoint, csBar, csHorizBar, '+
    'csPie, csGantt, csFastLine, csArrow, csBubble, csChartShape, csHorizArea, '+
    'csHorizLine, csPolar, csRadar, csPolarBar, csGauge, csSmith, csPyramid, '+
    'csDonut, csBezier, csCandle, csVolume, csPointFigure, csHistogram, '+
    'csHorizHistogram, csErrorBar, csError, csHighLow, csFunnel, csBox, '+
    'csHorizBox, csSurface, csContour, csWaterFall, csColorGrid, csVector3D, '+
    'csTower, csTriSurface, csPoint3D, csBubble3D, csMyPoint, csBarJoin, csBar3D');
    AddClass(TfrxSeriesItem, 'TPersistent');
    with AddClass(TfrxSeriesData, 'TPersistent') do
    begin
      AddMethod('function Add: TfrxSeriesItem', CallMethod);
      AddDefaultProperty('Items', 'Integer', 'TfrxSeriesItem', CallMethod, True);
    end;
    with AddClass(TfrxChartView, 'TfrxView') do
    begin
      AddProperty('Chart', 'TChart', GetProp, nil);
      AddIndexProperty('Series', 'Integer', 'TChartSeries', CallMethod, True);
      AddProperty('SeriesData', 'TfrxSeriesData', GetProp, nil);
      AddProperty('SeriesCount', 'Integer', GetProp, nil);
      AddMethod('procedure AddSeries(ASeries:TfrxChartSeries)', CallMethod);
    end;
  end;
end;

function TFunctions.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result := 0;

  if ClassType = TfrxSeriesData then
  begin
    if MethodName = 'ADD' then
      Result := frxInteger(TfrxSeriesData(Instance).Add)
    else if MethodName = 'ITEMS.GET' then
      Result := frxInteger(TfrxSeriesData(Instance).Items[Caller.Params[0]])
  end
  else if ClassType = TfrxChartView then
  begin
    if MethodName = 'SERIES.GET' then
      Result := frxInteger(TfrxChartView(Instance).Chart.Series[Caller.Params[0]])
      else
       if MethodName = 'ADDSERIES' then
         TfrxChartView(Instance).AddSeries(TfrxChartSeries(Caller.Params[0]));
  end
end;

function TFunctions.GetProp(Instance: TObject; ClassType: TClass;
  const PropName: String): Variant;
begin
  Result := 0;

  if ClassType = TfrxChartView then
  begin
    if PropName = 'CHART' then
      Result := frxInteger(TfrxChartView(Instance).Chart)
    else if PropName = 'SERIESCOUNT' then
         Result:=TfrxChartView(Instance).Chart.SeriesCount
    else if PropName = 'SERIESDATA' then
      Result := frxInteger(TfrxChartView(Instance).SeriesData)
  end
end;


initialization
  fsRTTIModules.Add(TFunctions);

finalization
  if fsRTTIModules <> nil then
    fsRTTIModules.Remove(TFunctions);

end.
