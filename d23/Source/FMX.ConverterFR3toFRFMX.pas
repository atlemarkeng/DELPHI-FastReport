
{******************************************}
{                                          }
{             FastReport v4.0              }
{             RB -> FR  importer           }
{                                          }
{         Copyright (c) 1998-2008          }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.ConverterFR3toFRFMX ;

interface

{$I frx.inc}

implementation

uses
  System.SysUtils, System.Classes, FMX.Types, System.UITypes,
  FMX.frxClass, FMX.frxVariables, FMX.frxDCtrl, FMX.frxChart,
  FMX.frxCross, System.Variants, FMX.frxGradient;


type
  TfrxCustomCrossViewHack = class(TfrxCustomCrossView);
  TfrxConverterEventsNew = class(TObject)
  private
    procedure DoAfterLoad(Sender: TfrxReport);
    function DoLoad(Sender: TfrxReport; Stream: TStream): Boolean;
  end;

var
  frxConverterEventsNew: TfrxConverterEventsNew;

function RGB(r, g, b: Byte): TAlphaColor; inline;
begin
  Result := (r or (g shl 8) or (b shl 16));
end;

procedure ToRGB(Color: TAlphaColor; var r, g, b: Byte); inline;
begin
  r := Color and $000000ff;
  g := (Color shr 8) and $000000ff;
  b := (Color shr 16) and $000000ff;
end;

function ColorToAlphaColor(Color: TAlphaColor): TAlphaColor; inline;
var
  R, G, B : BYTE;
begin
   ToRGB(Color, R, G, B);
   Result :=  RGB(B, G, R) or $FF000000;
end;

procedure ConvertViewObj(View: TfrxView);
begin
       if View.Color = $1FFFFFFF then View.Color := 0
      else if(View.Color <> 0) then
      begin
        View.Color := ColorToAlphaColor(View.Color);
      end;

      View.Font.Color := ColorToAlphaColor(View.Font.Color);
      View.Frame.Color := ColorToAlphaColor(View.Frame.Color);
      View.Frame.LeftLine.Color := ColorToAlphaColor(View.Frame.LeftLine.Color);
      View.Frame.RightLine.Color := ColorToAlphaColor(View.Frame.LeftLine.Color);
      View.Frame.TopLine.Color := ColorToAlphaColor(View.Frame.LeftLine.Color);
      View.Frame.BottomLine.Color := ColorToAlphaColor(View.Frame.LeftLine.Color);
end;

procedure ConvertMemoView(Memo: TfrxCustomMemoView);
begin
  ConvertViewObj(Memo);
  Memo.Highlight.Color := ColorToAlphaColor(Memo.Highlight.Color);
end;

procedure CorrectProperties(Report: TfrxReport);
var
  i, j: Integer;
  Obj: TObject;
  ObjList: TList;
begin
  for i := 0 to Report.AllObjects.Count - 1 do
  begin
    Obj := Report.AllObjects[i];
    if Obj is TfrxView then
    begin
      ConvertViewObj(TfrxView(Obj));
    end;
    if Obj is TfrxCustomMemoView  then
      TfrxCustomMemoView(Obj).Highlight.Color := ColorToAlphaColor(TfrxCustomMemoView(Obj).Highlight.Color);
    if Obj is TfrxGradientView then
    begin
      TfrxGradientView(Obj).BeginColor :=  ColorToAlphaColor(TfrxGradientView(Obj).BeginColor);
      TfrxGradientView(Obj).EndColor :=  ColorToAlphaColor(TfrxGradientView(Obj).EndColor);
    end;
    if Obj is TfrxCustomCrossView then
    begin
      ObjList := TfrxCustomCrossViewHack(Obj).GetNestedObjects;
      try
        for j := 0 to ObjList.Count - 1 do
          if TObject(ObjList[j]) is TfrxView then ConvertViewObj(TfrxView(ObjList[j]));
      finally
        ObjList.Free;
      end;
      ObjList := TfrxCustomCrossViewHack(Obj).FCellMemos;
      for j := 0 to ObjList.Count - 1 do
        if TObject(ObjList[j]) is TfrxCustomMemoView then ConvertMemoView(TfrxCustomMemoView(ObjList[j]));
      ObjList := TfrxCustomCrossViewHack(Obj).FCellHeaderMemos;
      for j := 0 to ObjList.Count - 1 do
        if TObject(ObjList[j]) is TfrxCustomMemoView then ConvertMemoView(TfrxCustomMemoView(ObjList[j]));

      ObjList := TfrxCustomCrossViewHack(Obj).FColumnMemos;
      for j := 0 to ObjList.Count - 1 do
        if TObject(ObjList[j]) is TfrxCustomMemoView then ConvertMemoView(TfrxCustomMemoView(ObjList[j]));

      ObjList := TfrxCustomCrossViewHack(Obj).FColumnTotalMemos;
      for j := 0 to ObjList.Count - 1 do
        if TObject(ObjList[j]) is TfrxCustomMemoView then ConvertMemoView(TfrxCustomMemoView(ObjList[j]));

      ObjList := TfrxCustomCrossViewHack(Obj).FCornerMemos;
      for j := 0 to ObjList.Count - 1 do
        if TObject(ObjList[j]) is TfrxCustomMemoView then ConvertMemoView(TfrxCustomMemoView(ObjList[j]));

      ObjList := TfrxCustomCrossViewHack(Obj).FRowMemos;
      for j := 0 to ObjList.Count - 1 do
        if TObject(ObjList[j]) is TfrxCustomMemoView then ConvertMemoView(TfrxCustomMemoView(ObjList[j]));

      ObjList := TfrxCustomCrossViewHack(Obj).FRowTotalMemos;
      for j := 0 to ObjList.Count - 1 do
        if TObject(ObjList[j]) is TfrxCustomMemoView then ConvertMemoView(TfrxCustomMemoView(ObjList[j]));

    end;

  end;
end;

procedure TfrxConverterEventsNew.DoAfterLoad(Sender: TfrxReport);
begin
  if not Sender.ReportOptions.IsFMXReport then
    CorrectProperties(Sender);
  Sender.ReportOptions.IsFMXReport := True;
end;



function TfrxConverterEventsNew.DoLoad(Sender: TfrxReport;
  Stream: TStream): Boolean;
begin
  Sender.ReportOptions.IsFMXReport := False;
  Result := False;
end;

initialization
  frxConverterEventsNew := TfrxConverterEventsNew.Create;
  frxConverter.OnAfterLoad := frxConverterEventsNew.DoAfterLoad;
  frxConverter.OnLoad := frxConverterEventsNew.DoLoad;
  frxConverter.Filter := '*.fr3';

finalization
  frxConverterEventsNew.Free;


end.

//56db3b0f55102b9488a240d37950543f