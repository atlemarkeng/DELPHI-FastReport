
{******************************************}
{                                          }
{             FastReport FMX v2.0          }
{         Checkbox Add-In Object           }
{                                          }
{         Copyright (c) 1998-2014          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxChBox;

interface

{$I frx.inc}

uses
  System.Types, System.SysUtils, System.Classes, FMX.Objects, FMX.Controls, FMX.frxClass,
  FMX.Types, FMX.TabControl, System.UIConsts, System.UITypes, System.Variants
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};


type
  TfrxCheckStyle = (csCross, csCheck, csLineCross, csPlus);
  TfrxUncheckStyle = (usEmpty, usCross, usLineCross, usMinus);

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxCheckBoxObject = class(TComponent)  // fake component
  end;

  TfrxCheckBoxView = class(TfrxView)
  private
    FCheckColor: TAlphaColor;
    FChecked: Boolean;
    FCheckStyle: TfrxCheckStyle;
    FUncheckStyle: TfrxUncheckStyle;
    FExpression: String;
    procedure DrawCheck(ARect: TRectF);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure GetData; override;
    class function GetDescription: String; override;
  published
    property BrushStyle;
    property CheckColor: TAlphaColor read FCheckColor write FCheckColor default claBlack;
    property Checked: Boolean read FChecked write FChecked default True;
    property CheckStyle: TfrxCheckStyle read FCheckStyle write FCheckStyle;
    property Color;
    property Cursor;
    property DataField;
    property DataSet;
    property DataSetName;
    property Expression: String read FExpression write FExpression;
    property Frame;
    property TagStr;
    property UncheckStyle: TfrxUncheckStyle read FUncheckStyle write FUncheckStyle default usEmpty;
    property URL;
  end;

implementation

uses FMX.frxChBoxRTTI, FMX.frxDsgnIntf, FMX.frxRes;


constructor TfrxCheckBoxView.Create(AOwner: TComponent);
begin
  inherited;
  FChecked := True;
  Height := fr01cm * 5;
  Width := fr01cm * 5;
  FCheckColor := claBlack;
end;

class function TfrxCheckBoxView.GetDescription: String;
begin
  Result := frxResources.Get('obChBox');
end;

procedure TfrxCheckBoxView.DrawCheck(ARect: TRectF);
var
  Sz: TSize;
  s: AnsiString;
  minVal, dx, dy: Double;
begin
  with FCanvas, ARect do
    if FChecked then
    begin
      if FCheckStyle = csCheck then
      begin
        FCanvas.Stroke.Kind := TBrushKind.bkSolid;;
        FCanvas.StrokeCap := TStrokeCap.scRound;
        FCanvas.Stroke.Color := FCheckColor;
        minVal := (Bottom - Top);
        if (minVal > (Right - Left)) then
          minVal := (Right - Left);

        FCanvas.StrokeThickness := minVal/ 6;
        dx := (Right - Left) / 2;
        dy := (Bottom - Top) / 2;
        DrawLine( PointF(Left + (dx - minVal / 4 + minVal / 20), Top + (dy + minVal / 6)), PointF(Right - (dx ), Bottom - minVal / 6 ), 1);
        DrawLine( PointF(Left + dx, Bottom - minVal / 6), PointF(Right - (dx - minVal / 3), Top + (dy - minVal / 5)), 1);
      end
      else if FCheckStyle = csCross then
      begin
        FCanvas.Stroke.Kind := TBrushKind.bkSolid;;
        FCanvas.StrokeCap := TStrokeCap.scRound;
        FCanvas.Stroke.Color := FCheckColor;
        minVal := (Bottom - Top);
        if (minVal > (Right - Left)) then
          minVal := (Right - Left);

        FCanvas.StrokeThickness := minVal/ 6;
        dx := (Right - Left) / 2;
        dy := (Bottom - Top) / 2;
        DrawLine( PointF(Left + (dx - minVal / 4 + minVal / 20), Top + (dy - minVal / 4)), PointF(Right - (dx - minVal / 4), Bottom - (dy - minVal / 4 )), 1);
        DrawLine( PointF(Left + (dx - minVal / 4 + minVal / 16), Bottom - (dy - minVal / 4)), PointF(Right - (dx - minVal / 4), Top + (dy - minVal / 4)), 1);
      end
      else if FCheckStyle = csLineCross then
      begin
        FCanvas.Stroke.Kind := TBrushKind.bkSolid;
        FCanvas.Stroke.Color := FCheckColor;
        FCanvas.StrokeThickness := FFrameWidth;

        DrawLine( PointF(Left, Top), PointF(Right, Bottom), 1);
        DrawLine( PointF(Left, Bottom), PointF(Right, Top), 1);
      end
      else if FCheckStyle = csPlus then
      begin
        FCanvas.Stroke.Kind := TBrushKind.bkSolid;
        FCanvas.Stroke.Color := FCheckColor;
        FCanvas.StrokeThickness := FFrameWidth;
        DrawLine( PointF(Left + 3, Top + (Bottom - Top) / 2), PointF(Right - 2, Top + (Bottom - Top) / 2), 1);
        DrawLine( PointF(Left + (Right - Left) / 2, Top + 3), PointF(Left + (Right - Left) / 2, Bottom - 2), 1);
      end
    end
    else
    begin
      if FUncheckStyle = usCross then
      begin
        FCanvas.Stroke.Kind := TBrushKind.bkSolid;;
        FCanvas.StrokeCap := TStrokeCap.scRound;
        FCanvas.Stroke.Color := FCheckColor;
        minVal := (Bottom - Top);
        if (minVal > (Right - Left)) then
          minVal := (Right - Left);

        FCanvas.StrokeThickness := minVal/ 6;
        dx := (Right - Left) / 2;
        dy := (Bottom - Top) / 2;
        DrawLine( PointF(Left + (dx - minVal / 4 + minVal / 20), Top + (dy - minVal / 4)), PointF(Right - (dx - minVal / 4), Bottom - (dy - minVal / 4 )), 1);
        DrawLine( PointF(Left + (dx - minVal / 4 + minVal / 16), Bottom - (dy - minVal / 4)), PointF(Right - (dx - minVal / 4), Top + (dy - minVal / 4)), 1);
      end
      else if FUncheckStyle = usLineCross then
      begin
        FCanvas.Stroke.Kind := TBrushKind.bkSolid;
        FCanvas.Stroke.Color := FCheckColor;
        FCanvas.StrokeThickness := FFrameWidth;

        DrawLine( PointF(Left, Top), PointF(Right, Bottom), 1);
        DrawLine( PointF(Left, Bottom), PointF(Right, Top), 1);

      end
      else if FUncheckStyle = usMinus then
      begin
        FCanvas.Stroke.Kind := TBrushKind.bkSolid;
        FCanvas.Stroke.Color := FCheckColor;
        FCanvas.StrokeThickness := FFrameWidth;
        DrawLine(PointF(Left + 3, Top + (Bottom - Top) / 2), PointF(Right - 2, Top + (Bottom - Top) / 2), 1);
      end
    end;
end;

procedure TfrxCheckBoxView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);

  DrawBackground;
  DrawCheck(RectF(FX, FY, FX1, FY1));
  DrawFrame;
end;

procedure TfrxCheckBoxView.GetData;
var
  v: Variant;
begin
  inherited;
  if IsDataField then
  begin
    v := DataSet.Value[DataField];
    if v = Null then
      v := False;
    FChecked := v;
  end
  else if FExpression <> '' then
    FChecked := Report.Calc(FExpression);
end;

initialization
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TfrxCheckBoxObject, TFmxObject);
  frxObjects.RegisterObject1(TfrxCheckBoxView, nil, '', '', 0, 116);

finalization
  frxObjects.UnRegister(TfrxCheckBoxView);


end.


//56db3b0f55102b9488a240d37950543f