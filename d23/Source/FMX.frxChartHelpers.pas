
{******************************************}
{                                          }
{             FastReport v4.0              }
{         TeeChart series helpers          }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxChartHelpers;

interface

{$I frx.inc}
{$I tee.inc}

uses
  System.SysUtils, System.Classes, System.UIConsts, FMX.Types, FMX.Menus, FMX.Controls, FMX.frxChart,
  FMXTee.Procs, FMXTee.Engine, FMXTee.Chart, FMXTee.Series, FMXTee.Canvas
{$IFDEF TeeChartPro}
, FMXTee.Series.Polar,
{$IFNDEF TeeChart4}
  FMXTee.Series.Smith, FMXTee.Series.Pyramid, FMXTee.Series.Donut, FMXTee.Series.Funnel, FMXTee.Series.BoxPlot, FMXTee.Series.TriSurface,{$ENDIF}
  FMXTee.Series.Bezier, FMXTee.Series.OHLC, FMXTee.Series.Candle, FMXTee.Series.Error, FMXTee.Functions.Stats,
  FMXTee.Series.Surface, FMXTee.Series.Point3D, FMXTee.Series.Bar3D
{$IFDEF TeeChart7}
, FMXTee.TeeGauges, FMXTee.TeePointFigure
{$ENDIF}
{$ENDIF}

, System.Variants
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};


type
  TfrxSeriesHelper = class(TObject)
  public
    function GetParamNames: String; virtual; abstract;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); virtual; abstract;
  end;

  TfrxStdSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxPieSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

{$IFDEF TeeChartPro}
  TfrxPolarSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxGaugeSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxSmithSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxCandleSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxErrorSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxHiLoSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxFunnelSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxSurfaceSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxVector3DSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxBubble3DSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxBar3DSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;
{$ENDIF}

  TfrxSeriesHelperClass = class of TfrxSeriesHelper;


const
{$IFDEF TeeChartPro}
  frxNumSeries = 38;
{$ELSE}
  frxNumSeries = 7;
{$ENDIF}
  frxChartSeries: array[0..frxNumSeries - 1] of TSeriesClass =
    (TLineSeries, TAreaSeries, TPointSeries,
     TBarSeries, THorizBarSeries, TPieSeries,
     TFastLineSeries
{$IFDEF TeeChartPro}
   , {$IFDEF TeeChart7}THorizAreaSeries{$ELSE}nil{$ENDIF}, {$IFNDEF TeeChart4}THorizLineSeries{$ELSE}nil{$ENDIF}, TPolarSeries,
     TRadarSeries, {$IFDEF TeeChart7}TPolarBarSeries{$ELSE}nil{$ENDIF}, {$IFDEF TeeChart7}TGaugeSeries{$ELSE}nil{$ENDIF},
     {$IFNDEF TeeChart4}TSmithSeries, TPyramidSeries, TDonutSeries{$ELSE}nil, nil, nil{$ENDIF},
     TBezierSeries, TCandleSeries, TVolumeSeries,
     {$IFDEF TeeChart7}TPointFigureSeries{$ELSE}nil{$ENDIF}, {$IFNDEF TeeChart4}THistogramSeries{$ELSE}nil{$ENDIF}, {$IFDEF TeeChart7}THorizHistogramSeries{$ELSE}nil{$ENDIF},
     TErrorBarSeries, TErrorSeries, {$IFNDEF TeeChart4}THighLowSeries{$ELSE}nil{$ENDIF},
     {$IFNDEF TeeChart4}TFunnelSeries, TBoxSeries, THorizBoxSeries{$ELSE}nil, nil, nil{$ENDIF},
     TSurfaceSeries, TContourSeries, {$IFNDEF TeeChart4}TWaterFallSeries,
     TColorGridSeries{$ELSE}nil, nil{$ENDIF}, {$IFDEF TeeChart7}TVector3DSeries{$ELSE}nil{$ENDIF}, {$IFDEF TeeChart7}TTowerSeries{$ELSE}nil{$ENDIF},
     {$IFNDEF TeeChart4}TTriSurfaceSeries{$ELSE}nil{$ENDIF}, TPoint3DSeries, {$IFDEF TeeChart7}TBubble3DSeries{$ELSE}nil{$ENDIF},
     TBar3DSeries
{$ENDIF}
    );
  frxSeriesHelpers: array[0..frxNumSeries - 1] of TfrxSeriesHelperClass =
    (TfrxStdSeriesHelper, TfrxStdSeriesHelper, TfrxStdSeriesHelper,
     TfrxStdSeriesHelper, TfrxStdSeriesHelper, TfrxPieSeriesHelper,
     TfrxStdSeriesHelper
{$IFDEF TeeChartPro}
   , TfrxStdSeriesHelper, TfrxStdSeriesHelper, TfrxPolarSeriesHelper,
     TfrxPolarSeriesHelper, TfrxPolarSeriesHelper, TfrxGaugeSeriesHelper,
     TfrxSmithSeriesHelper, TfrxStdSeriesHelper, TfrxPieSeriesHelper,
     TfrxStdSeriesHelper, TfrxCandleSeriesHelper, TfrxStdSeriesHelper,
     TfrxCandleSeriesHelper, TfrxStdSeriesHelper, TfrxStdSeriesHelper,
     TfrxErrorSeriesHelper, TfrxErrorSeriesHelper, TfrxHiLoSeriesHelper,
     TfrxFunnelSeriesHelper, TfrxStdSeriesHelper, TfrxStdSeriesHelper,
     TfrxSurfaceSeriesHelper, TfrxSurfaceSeriesHelper, TfrxSurfaceSeriesHelper,
     TfrxSurfaceSeriesHelper, TfrxVector3DSeriesHelper, TfrxSurfaceSeriesHelper,
     TfrxSurfaceSeriesHelper, TfrxSurfaceSeriesHelper, TfrxBubble3DSeriesHelper,
     TfrxBar3DSeriesHelper
{$ENDIF}
    );


function frxFindSeriesHelper(Series: TChartSeries): TfrxSeriesHelper;


implementation

uses FMX.frxDsgnIntf, FMX.frxUtils, FMX.frxRes;


function CheckNulls(Value: String): Boolean;
begin
  Result := (UpperCase(Value) = 'NULL') or (Value = '');
end;

function frxFindSeriesHelper(Series: TChartSeries): TfrxSeriesHelper;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to frxNumSeries - 1 do
    if Series.ClassType = frxChartSeries[i] then
    begin
      Result := TfrxSeriesHelper(frxSeriesHelpers[i].NewInstance);
      Result.Create;
      break;
    end;

  if Result = nil then
    Result := TfrxStdSeriesHelper.Create;
end;

{ TfrxStdSeriesHelper }

procedure TfrxStdSeriesHelper.AddValues(Series: TChartSeries; const v1, v2,
  v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  d: Double;
  Color: TColor;
  s: String;
begin
  d := 0;
  Color := clTeeColor;
  if v4 <> '' then
    try
      Color := StringToColor(v4);
    except
    end;
  if CheckNulls(v2) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  if Series.YValues.DateTime then
    d := StrToDateTime(v2)
  else if frxIsValidFloat(v2) then
    d := frxStrToFloat(v2);
  if v3 <> '' then
    s := v3
  else
    s := v1;
  case XType of
    xtText:
      Series.Add(d, v1, Color);
    xtNumber:
      Series.AddXY(frxStrToFloat(s), d, v1, Color);
    xtDate:
      Series.AddXY(StrToDateTime(s), d, v1, Color);
  end;
end;

function TfrxStdSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Y;X (optional);Color (optional)';
end;


{ TfrxPieSeriesHelper }

procedure TfrxPieSeriesHelper.AddValues(Series: TChartSeries; const v1, v2,
  v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  d: Double;
  c: TColor;
begin
  if CheckNulls(v2) then
  begin
    Series.AddNull(v1);
    Exit;
  end;

  if Series.YValues.DateTime then
    d := StrToDateTime(v2)
  else
    d := frxStrToFloat(v2);

  c := clTeeColor;
  if v3 <> '' then
  try
    c := StringToColor(v3);
  except
  end;

  Series.Add(d, v1, c);
end;

function TfrxPieSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Pie;Color (optional)';
end;


{$IFDEF TeeChartPro}
{ TfrxPolarSeriesHelper }

procedure TfrxPolarSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) or CheckNulls(v3) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v4 <> '' then
    try
      Color := StringToColor(v4);
    except
    end;
  Series.AddXY(frxStrToFloat(v2), frxStrToFloat(v3), v1, Color);
end;

function TfrxPolarSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Angle;Value;Color (optional)';
end;

{ TfrxGaugeSeriesHelper }

procedure TfrxGaugeSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v3 <> '' then
    try
      Color := StringToColor(v3);
    except
    end;
  Series.Clear;
  Series.Add(frxStrToFloat(v2), v1, Color);
end;

function TfrxGaugeSeriesHelper.GetParamNames: String;
begin
  Result := 'Label (optional);Value;Color (optional)';
end;


{ TfrxSmithSeriesHelper }

procedure TfrxSmithSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
begin
{$IFNDEF TeeChart4}
  if CheckNulls(v2) or CheckNulls(v3) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  TSmithSeries(Series).AddPoint(frxStrToFloat(v2), frxStrToFloat(v3), v1);
{$ENDIF}
end;

function TfrxSmithSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Resistance;Reactance';
end;


{ TfrxCandleSeriesHelper }

procedure TfrxCandleSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
begin
  TOHLCSeries(Series).AddOHLC(StrToDateTime(v1),
    frxStrToFloat(v2), frxStrToFloat(v3), frxStrToFloat(v4), frxStrToFloat(v5));
end;

function TfrxCandleSeriesHelper.GetParamNames: String;
begin
  Result := 'Date;Open;High;Low;Close';
end;


{ TfrxErrorSeriesHelper }

procedure TfrxErrorSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
begin
  if CheckNulls(v2) or CheckNulls(v3) or CheckNulls(v4) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  TCustomErrorSeries(Series).AddErrorBar(frxStrToFloat(v2), frxStrToFloat(v3),
    frxStrToFloat(v4), v1);
end;

function TfrxErrorSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Error';
end;


{ TfrxHiLoSeriesHelper }

procedure TfrxHiLoSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
begin
{$IFNDEF TeeChart4}
  if CheckNulls(v2) or CheckNulls(v3) or CheckNulls(v4) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  THighLowSeries(Series).AddHighLow(frxStrToFloat(v2), frxStrToFloat(v3),
    frxStrToFloat(v4), v1);
{$ENDIF}
end;

function TfrxHiLoSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;High;Low';
end;


{ TfrxFunnelSeriesHelper }

procedure TfrxFunnelSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
{$IFNDEF TeeChart4}
var
  Color: TColor;
{$ENDIF}
begin
{$IFNDEF TeeChart4}
  if CheckNulls(v2) or CheckNulls(v3) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v4 <> '' then
    try
      Color := StringToColor(v4);
    except
    end;
  TFunnelSeries(Series).AddSegment(frxStrToFloat(v2), frxStrToFloat(v3), v1, Color);
{$ENDIF}
end;

function TfrxFunnelSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Quote;Opportunity;Color (optional)';
end;


{ TfrxSurfaceSeriesHelper }

procedure TfrxSurfaceSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) or CheckNulls(v3) or CheckNulls(v4) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v5 <> '' then
    try
      Color := StringToColor(v5);
    except
    end;
{$IFDEF TeeChart4}
  TCustom3DSeries(Series).AddXYZ(Round(frxStrToFloat(v2)), frxStrToFloat(v3),
    Round(frxStrToFloat(v4)), v1, Color);
{$ELSE}
  TCustom3DSeries(Series).AddXYZ(frxStrToFloat(v2), frxStrToFloat(v3),
    frxStrToFloat(v4), v1, Color);
{$ENDIF}
end;

function TfrxSurfaceSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Z;Color (optional)';
end;


{ TfrxVector3DSeriesHelper }

procedure TfrxVector3DSeriesHelper.AddValues(Series: TChartSeries;
  const v1, v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
begin
{$IFDEF TeeChart7}
  TVector3DSeries(Series).AddVector(frxStrToFloat(v1), frxStrToFloat(v2),
    frxStrToFloat(v3), frxStrToFloat(v4), frxStrToFloat(v5), frxStrToFloat(v6));
{$ENDIF}
end;

function TfrxVector3DSeriesHelper.GetParamNames: String;
begin
  Result := 'X1;Y1;Z1;X2;Y2;Z2';
end;


{ TfrxBubble3DSeriesHelper }

procedure TfrxBubble3DSeriesHelper.AddValues(Series: TChartSeries;
  const v1, v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
{$IFDEF TeeChart7}
var
  Color: TColor;
{$ENDIF}
begin
{$IFDEF TeeChart7}
  if CheckNulls(v2) or CheckNulls(v3) or
    CheckNulls(v4) or CheckNulls(v5) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v6 <> '' then
    try
      Color := StringToColor(v6);
    except
    end;
  TBubble3DSeries(Series).AddBubble(frxStrToFloat(v2), frxStrToFloat(v3),
    frxStrToFloat(v4), frxStrToFloat(v5), v1, Color);
{$ENDIF}
end;

function TfrxBubble3DSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Z;Radius;Color (optional)';
end;


{ TfrxBar3DSeriesHelper }

procedure TfrxBar3DSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) or CheckNulls(v3) or CheckNulls(v4) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v5 <> '' then
    try
      Color := StringToColor(v5);
    except
    end;
  TBar3DSeries(Series).AddBar(frxStrToFloat(v2), frxStrToFloat(v3),
    frxStrToFloat(v4), v1, Color);
end;

function TfrxBar3DSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Offset;Color (optional)';
end;
{$ENDIF}

end.


//56db3b0f55102b9488a240d37950543f