
{******************************************}
{                                          }
{             FastReport v4.0              }
{        DotMatrix printers stuff          }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxDMPClass;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Types, System.Variants,
  FMX.frxClass;


type
  TfrxDMPFontStyle = (fsxBold, fsxItalic, fsxUnderline, fsxSuperScript,
    fsxSubScript, fsxCondensed, fsxWide, fsx12cpi, fsx15cpi);
  TfrxDMPFontStyles = set of TfrxDMPFontStyle;

  TfrxDMPMemoView = class(TfrxCustomMemoView)
  private
    FFontStyle: TfrxDMPFontStyles;
    FTruncOutboundText: Boolean;
    procedure SetFontStyle(const Value: TfrxDMPFontStyles);
    function IsFontStyleStored: Boolean;
  protected
    procedure DrawFrame; override;
    procedure SetLeft(Value: Double); override;
    procedure SetTop(Value: Double); override;
    procedure SetWidth(Value: Double); override;
    procedure SetHeight(Value: Double); override;
    procedure SetParentFont(const Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    procedure ResetFontOptions;
    procedure SetBoundsDirect(ALeft, ATop, AWidth, AHeight: Double);
    function CalcHeight: Double; override;
    function CalcWidth: Double; override;
    function Diff(AComponent: TfrxComponent): String; override;
    function GetoutBoundText: String;
  published
    property AutoWidth;
    property AllowExpressions;
    property DataField;
    property DataSet;
    property DataSetName;
    property DisplayFormat;
    property ExpressionDelimiters;
    property FlowTo;
    property FontStyle: TfrxDMPFontStyles read FFontStyle write SetFontStyle
      stored IsFontStyleStored;
    property Frame;
    property HAlign;
    property HideZeros;
    property Memo;
    property ParentFont;
    property RTLReading;
    property SuppressRepeated;
    property WordWrap;
    property TruncOutboundText: Boolean read FTruncOutboundText write FTruncOutboundText;
    property VAlign;
  end;

  TfrxDMPLineView = class(TfrxCustomLineView)
  private
    FFontStyle: TfrxDMPFontStyles;
    procedure SetFontStyle(const Value: TfrxDMPFontStyles);
    function IsFontStyleStored: Boolean;
  protected
    procedure SetLeft(Value: Double); override;
    procedure SetTop(Value: Double); override;
    procedure SetWidth(Value: Double); override;
    procedure SetParentFont(const Value: Boolean); override;
  public
    class function GetDescription: String; override;
    function Diff(AComponent: TfrxComponent): String; override;
  published
    property FontStyle: TfrxDMPFontStyles read FFontStyle write SetFontStyle
      stored IsFontStyleStored;
    property ParentFont;
  end;

  TfrxDMPCommand = class(TfrxView)
  private
    FCommand: String;
  protected
    procedure SetLeft(Value: Double); override;
    procedure SetTop(Value: Double); override;
  public
    class function GetDescription: String; override;
    function Diff(AComponent: TfrxComponent): String; override;
    function ToChr: String;
  published
    property Command: String read FCommand write FCommand;
  end;

  TfrxDMPPage = class(TfrxReportPage)
  private
    FFontStyle: TfrxDMPFontStyles;
    procedure SetFontStyle(const Value: TfrxDMPFontStyles);
  protected
    procedure SetPaperHeight(const Value: Double); override;
    procedure SetPaperWidth(const Value: Double); override;
    procedure SetPaperSize(const Value: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetDefaults; override;
    procedure ResetFontOptions;
  published
    property FontStyle: TfrxDMPFontStyles read FFontStyle write SetFontStyle;
  end;


implementation

uses 
  FMX.frxRes, FMX.frxDsgnIntf, FMX.frxXML, FMX.frxFMX;


function DiffFontStyle(f: TfrxDMPFontStyles): String;
var
  fs: Integer;
begin
  fs := 0;
  if fsxBold in f then fs := 1;
  if fsxItalic in f then fs := fs or 2;
  if fsxUnderline in f then fs := fs or 4;
  if fsxSuperScript in f then fs := fs or 8;
  if fsxSubScript in f then fs := fs or 16;
  if fsxCondensed in f then fs := fs or 32;
  if fsxWide in f then fs := fs or 64;
  if fsx12cpi in f then fs := fs or 128;
  if fsx15cpi in f then fs := fs or 256;
  Result := ' FontStyle="' + String(IntToStr(fs)) + '"';
end;


{ TfrxDMPMemoView }

constructor TfrxDMPMemoView.Create(AOwner: TComponent);
begin
  inherited;
  ResetFontOptions;
end;

class function TfrxDMPMemoView.GetDescription: String;
begin
  Result := frxResources.Get('obDMPText');
end;

procedure TfrxDMPMemoView.ResetFontOptions;
begin
  Font.OnChange := nil;
  Font.Name := 'Courier New';
  Font.Size := 12;
  Font.Style := [];
  if fsxBold in FFontStyle then
    Font.Style := Font.Style + [fsBold];
  if fsxItalic in FFontStyle then
    Font.Style := Font.Style + [fsItalic];
  if fsxUnderline in FFontStyle then
    Font.Style := Font.Style + [fsUnderline];
  CharSpacing := 0;
  LineSpacing := 1;
  GapX := 0;
  GapY := 0;
end;

procedure TfrxDMPMemoView.SetHeight(Value: Double);
begin
  Value := Round(Value / fr1CharY) * fr1CharY;
  inherited;
end;

procedure TfrxDMPMemoView.SetLeft(Value: Double);
begin
  if Align = baRight then
    Value := Trunc(Value / fr1CharX) * fr1CharX else
    Value := Round(Value / fr1CharX) * fr1CharX;
  inherited;
end;

procedure TfrxDMPMemoView.SetTop(Value: Double);
begin
  Value := Round(Value / fr1CharY) * fr1CharY;
  inherited;
end;

procedure TfrxDMPMemoView.SetWidth(Value: Double);
begin
  Value := Round(Value / fr1CharX) * fr1CharX;
  inherited;
end;

procedure TfrxDMPMemoView.SetFontStyle(const Value: TfrxDMPFontStyles);
begin
  FFontStyle := Value;
  ParentFont := False;
  ResetFontOptions;
end;

procedure TfrxDMPMemoView.SetParentFont(const Value: Boolean);
begin
  inherited;
  if Value then
    if Page is TfrxDMPPage then
      FFontStyle := TfrxDMPPage(Page).FontStyle;
end;

function TfrxDMPMemoView.IsFontStyleStored: Boolean;
begin
  Result := not ParentFont;
end;

procedure TfrxDMPMemoView.DrawFrame;
begin
  FX := Round((AbsLeft - fr1CharX / 2) * FScaleX + FOffsetX);
  FY := Round((AbsTop - fr1CharY / 2) * FScaleY + FOffsetY);
  FX1 := Round((AbsLeft + Width + fr1CharX / 2) * FScaleX + FOffsetX);
  FY1 := Round((AbsTop + Height + fr1CharY / 2) * FScaleY + FOffsetY);
  inherited;
end;

function TfrxDMPMemoView.CalcHeight: Double;
begin
  Result := inherited CalcHeight;
  Result := Round(Result / fr1CharY) * fr1CharY;
end;

function TfrxDMPMemoView.CalcWidth: Double;
begin
  Result := inherited CalcWidth;
  Result := Round(Result / fr1CharX) * fr1CharX;
end;

function TfrxDMPMemoView.Diff(AComponent: TfrxComponent): String;
var
  m: TfrxDMPMemoView;
begin
  Result := inherited Diff(AComponent);
  m := TfrxDMPMemoView(AComponent);
  if FFontStyle <> m.FontStyle then
    Result := Result + DiffFontStyle(FFontStyle);
end;

procedure TfrxDMPMemoView.SetBoundsDirect(ALeft, ATop, AWidth, AHeight: Double);
begin
  inherited SetLeft(ALeft);
  inherited SetTop(ATop);
  inherited SetWidth(AWidth);
  inherited SetHeight(AHeight);
end;

function TfrxDMPMemoView.GetoutBoundText: String;
var
  idx, mH: Integer;
begin
  Result := '';
  mH := Round(Height/fr1CharY);
  for idx := 0 to Memo.Count - 1 do
  if mH >= idx + 1 then
  begin
   Result := Result + Copy(Memo.Strings[idx], 1, Round(Width/fr1CharX)) + #13#10;
  end;
end;

{ TfrxDMPLineView }

class function TfrxDMPLineView.GetDescription: String;
begin
  Result := frxResources.Get('obDMPLine');
end;

procedure TfrxDMPLineView.SetLeft(Value: Double);
begin
  if Value < 0 then
    Value := Trunc(Value / fr1CharX) * fr1CharX - fr1CharX / 2
  else if Align = baRight then
    Value := Round(Value / fr1CharX) * fr1CharX - fr1CharX / 2
  else
    Value := Trunc(Value / fr1CharX) * fr1CharX + fr1CharX / 2;
  inherited;
end;

procedure TfrxDMPLineView.SetTop(Value: Double);
begin
  Value := Trunc(Value / fr1CharY) * fr1CharY + fr1CharY / 2;
  inherited;
end;

procedure TfrxDMPLineView.SetWidth(Value: Double);
begin
  if Align = baWidth then
    Value := Trunc(Value / fr1CharX) * fr1CharX
  else
    Value := Round(Value / fr1CharX) * fr1CharX;
  inherited;
end;

procedure TfrxDMPLineView.SetFontStyle(const Value: TfrxDMPFontStyles);
begin
  FFontStyle := Value;
  ParentFont := False;
end;

procedure TfrxDMPLineView.SetParentFont(const Value: Boolean);
begin
  inherited;
  if Value then
    if Page is TfrxDMPPage then
      FFontStyle := TfrxDMPPage(Page).FontStyle;
end;

function TfrxDMPLineView.IsFontStyleStored: Boolean;
begin
  Result := not ParentFont;
end;

function TfrxDMPLineView.Diff(AComponent: TfrxComponent): String;
var
  l: TfrxDMPLineView;
begin
  Result := inherited Diff(AComponent);
  l := TfrxDMPLineView(AComponent);
  if FFontStyle <> l.FontStyle then
    Result := Result + DiffFontStyle(FFontStyle);
end;


{ TfrxDMPCommand }

class function TfrxDMPCommand.GetDescription: String;
begin
  Result := frxResources.Get('obDMPCmd');
end;

procedure TfrxDMPCommand.SetLeft(Value: Double);
begin
  Value := Round(Value / fr1CharX) * fr1CharX;
  inherited;
end;

procedure TfrxDMPCommand.SetTop(Value: Double);
begin
  Value := Round(Value / fr1CharY) * fr1CharY;
  inherited;
end;

function TfrxDMPCommand.Diff(AComponent: TfrxComponent): String;
begin
  Result := inherited Diff(AComponent);
  if FCommand <> TfrxDMPCommand(AComponent).Command then
    Result := Result + frxStrToXML(FCommand);
end;

function TfrxDMPCommand.ToChr: String;
var
  i: Integer;
  s, s1: String;
begin
  Result := '';
  s := FCommand;
  s1 := '';
  if Pos('#', s) = 1 then
  begin
    s := s + '#';
    for i := 2 to Length(s) do
      if s[i] = '#' then
      begin
        Result := Result + Chr(StrToInt(s1));
        s1 := '';
      end
      else
        s1 := s1 + s[i];
  end
  else
  begin
    for i := 1 to Length(s) do
    begin
      s1 := s1 + s[i];
      if i mod 2 = 0 then
      begin
        Result := Result + Chr(StrToInt('$' + s1));
        s1 := '';
      end;
    end;
  end;
end;


{ TfrxDMPPage }

constructor TfrxDMPPage.Create(AOwner: TComponent);
begin
  inherited;
  ResetFontOptions;
end;

procedure TfrxDMPPage.ResetFontOptions;
begin
  Font.OnChange := nil;
  Font.Name := 'Courier New';
  Font.Size := 12;
  Font.Style := [];
  if fsxBold in FFontStyle then
    Font.Style := Font.Style + [fsBold];
  if fsxItalic in FFontStyle then
    Font.Style := Font.Style + [fsItalic];
  if fsxUnderline in FFontStyle then
    Font.Style := Font.Style + [fsUnderline];
end;

procedure TfrxDMPPage.SetDefaults;
begin
  inherited;
  LeftMargin := fr1CharX / fr01cm;
  RightMargin := fr1CharX / fr01cm;
  TopMargin := fr1CharY / fr01cm;
  BottomMargin := fr1CharY / fr01cm;
  FPaperWidth := Trunc(FPaperWidth * fr01cm / fr1CharX) * fr1CharX / fr01cm;
  FPaperHeight := Trunc(FPaperHeight * fr01cm / fr1CharY) * fr1CharY / fr01cm;
  UpdateDimensions;
end;

procedure TfrxDMPPage.SetFontStyle(const Value: TfrxDMPFontStyles);
var
  i: Integer;
  l: TList;
  c: TfrxComponent;
begin
  FFontStyle := Value;
  ResetFontOptions;

  l := AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if c.ParentFont then
      c.ParentFont := True;
  end;
end;

procedure TfrxDMPPage.SetPaperHeight(const Value: Double);
begin
  inherited;
  FPaperHeight := Round(FPaperHeight * fr01cm / fr1CharY) * fr1CharY / fr01cm;
  UpdateDimensions;
end;

procedure TfrxDMPPage.SetPaperSize(const Value: Integer);
begin
  inherited;
  FPaperWidth := Round(FPaperWidth * fr01cm / fr1CharX) * fr1CharX / fr01cm;
  FPaperHeight := Round(FPaperHeight * fr01cm / fr1CharY) * fr1CharY / fr01cm;
  UpdateDimensions;
end;

procedure TfrxDMPPage.SetPaperWidth(const Value: Double);
begin
  inherited;
  FPaperWidth := Round(FPaperWidth * fr01cm / fr1CharX) * fr1CharX / fr01cm;
  UpdateDimensions;
end;


initialization
  RegisterFmxClasses([TfrxDMPPage]);
  frxObjects.RegisterObject1(TfrxDMPMemoView, nil, '', '', 0, 2, [ctDMP]);
  frxObjects.RegisterObject1(TfrxDMPLineView, nil, '', '', 0, 5, [ctDMP]);
  frxObjects.RegisterObject1(TfrxDMPCommand, nil, '', '', 0, 21, [ctDMP]);

finalization
  UnRegisterClasses([TfrxDMPPage]);
  frxObjects.UnRegister(TfrxDMPMemoView);
  frxObjects.UnRegister(TfrxDMPLineView);
  frxObjects.UnRegister(TfrxDMPCommand);


end.



//56db3b0f55102b9488a240d37950543f