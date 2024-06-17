
{******************************************}
{                                          }
{             FastReport v4.0              }
{            Graphic routines              }
{                                          }
{         Copyright (c) 1998-2011          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxGraphicUtils;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, System.UIConsts, System.StrUtils,
  System.WideStrings, System.Types, System.Variants, System.Generics.Collections,
  System.Math, FMX.Types, FMX.Forms,
  FMX.frxFMX, FMX.frxClass
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF}
{$IFDEF DELPHI20}
  , System.Math.Vectors
{$ENDIF};

type
  TBaseLine = (Normal, Subscript, Superscript);

  TStyleDescriptor = record
    FontStyle: TFontStyles;
    Color: TAlphaColor;
    BaseLine: TBaseLine;
  end;

  TParagraph = class;
  TLine = class;
  TWord = class;
  TRun = class;

    TSubStyle = (ssNormal, ssSubscript, ssSuperscript);

  TfrxHTMLTag = class(TObject)
  public
    Position: Integer;
    Size: Integer;
    AddY: Integer;
    Style: TFontStyles;
    Color: TAlphaColor;
    Default: Boolean;
    Small: Boolean;
    DontWRAP: Boolean;
    SubType: TSubStyle;
    procedure Assign(Tag: TfrxHTMLTag);
  end;

  TfrxHTMLTags = class(TObject)
  private
    FItems: TList;
    procedure Add(Tag: TfrxHTMLTag);
    function GetItems(Index: Integer): TfrxHTMLTag;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Count: Integer;
    property Items[Index: Integer]: TfrxHTMLTag read GetItems; default;
  end;

  TfrxHTMLTagsList = class(TObject)
  private
    FAllowTags: Boolean;
    FAddY: Integer;
    FColor: LongInt;
    FDefColor: LongInt;
    FDefSize: Integer;
    FDefStyle: TFontStyles;
    FItems: TList;
    FPosition: Integer;
    FSize: Integer;
    FStyle: TFontStyles;
    FDontWRAP: Boolean;
    FSubStyle: TSubStyle;
    procedure NewLine;
    procedure Wrap(TagsCount: Integer; AddBreak: Boolean);
    function Add: TfrxHTMLTag;
    function GetItems(Index: Integer): TfrxHTMLTags;
    function GetPrevTag: TfrxHTMLTag;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure SetDefaults(DefColor: TColor; DefSize: Integer;
      DefStyle: TFontStyles);
    procedure ExpandHTMLTags(var s: WideString);
    function Count: Integer;
    property AllowTags: Boolean read FAllowTags write FAllowTags;
    property Items[Index: Integer]: TfrxHTMLTags read GetItems; default;
    property Position: Integer read FPosition write FPosition;
  end;

  TAdvancedTextRenderer = class
  private
    FParagraphs: TList<TParagraph>;
    FText: String;
    FCanvas: TCanvas;
    FFont: TfrxFont;
    FDisplayRect: TRectF;
    FHorzAlign: TfrxHAlign;
    FVertAlign: TfrxVAlign;
    FLineHeight: Single;
    FFontLineHeight: Single;
    FAngle: Integer;
    FForceJustify: Boolean;
    FWysiwyg: Boolean;
    FHtmlTags: Boolean;
    FWordWrap: Boolean;
    FRightToLeft: Boolean;
    FPDFMode: Boolean;
    FSpaceWidth: Single;
    procedure SplitToParagraphs(const text: String);
    procedure AdjustParagraphLines;
  public
    constructor Create(aCanvas: TCanvas; const aText: String; aFont: TfrxFont; rect: TRectF;
      aHorzAlign: TfrxHAlign; aVertAlign: TfrxVAlign; aLineHeight: Single; aAngle: Integer;
      aWordWrap: Boolean; aForceJustify: Boolean; aHtmlTags: Boolean; aPdfMode: Boolean);
    destructor Destroy; override;
    function CalcWidth: Single;
    function MeasureTextWidth(const aText: String): Single;
    function CalcHeight: Single; overload;
    function CalcHeight(var charsFit: Integer; var style: TStyleDescriptor): Single; overload;
    function GetTabPosition(pos: Single): Single;
    procedure Draw;
    property Paragraphs: TList<TParagraph> read FParagraphs;
    property Canvas: TCanvas read FCanvas;
    property Font: TfrxFont read FFont;
    property DisplayRect: TRectF read FDisplayRect;
    property HorzAlign: TfrxHAlign read FHorzAlign;
    property VertAlign: TfrxVAlign read FVertAlign;
    property LineHeight: Single read FLineHeight;
    property FontLineHeight: Single read FFontLineHeight;
    property Angle: Integer read FAngle;
    property ForceJustify: Boolean read FForceJustify;
    property Wysiwyg: Boolean read FWysiwyg;
    property HtmlTags: Boolean read FHtmlTags;
    property WordWrap: Boolean read FWordWrap;
    property RightToLeft: Boolean read FRightToLeft;
    property PDFMode: Boolean read FPDFMode;
    property SpaceWidth: Single read FSpaceWidth;
  end;

  TParagraph = class
  private
    FLines: TList<TLine>;
    FRenderer: TAdvancedTextRenderer;
    FText: String;
    FOriginalCharIndex: Integer;
  public
    constructor Create(const text: String; renderer: TAdvancedTextRenderer; originalCharIndex: Integer);
    destructor Destroy; override;
    function IsLast: Boolean;
    function IsEmpty: Boolean;
    function WrapLines(style: TStyleDescriptor): TStyleDescriptor;
    procedure AlignLines(forceJustify: Boolean);
    procedure Draw;
    property Lines: TList<TLine> read FLines;
    property Renderer: TAdvancedTextRenderer read FRenderer;
  end;

  TLine = class
  private
    FWords: TList<TWord>;
    FParagraph: TParagraph;
    FTop: Single;
    FWidth: Single;
    FOriginalCharIndex: Integer;
    FUnderlines: TList<TRectF>;
    FStrikeouts: TList<TRectF>;
    function GetStyle: TStyleDescriptor;
    function GetRenderer: TAdvancedTextRenderer;
    function GetLeft: Single;
    procedure PrepareUnderlines(list: TList<TRectF>; style: TFontStyle);
  public
    constructor Create(paragraph: TParagraph; originalCharIndex: Integer);
    destructor Destroy; override;
    function IsLast: Boolean;
    procedure AlignWords(align: TfrxHAlign);
    procedure MakeUnderlines;
    procedure Draw;
    property Words: TList<TWord> read FWords;
    property Left: Single read GetLeft;
    property Top: Single read FTop write FTop;
    property Width: Single read FWidth;
    property OriginalCharIndex: Integer read FOriginalCharIndex;
    property Renderer: TAdvancedTextRenderer read GetRenderer;
    property Style: TStyleDescriptor read GetStyle;
    property Underlines: TList<TRectF> read FUnderlines;
    property Strikeouts: TList<TRectF> read FStrikeouts;
  end;

  TWord = class
  private
    FRuns: TList<TRun>;
    FLeft: Single;
    FWidth: Single;
    FLine: TLine;
    function GetWidth: Single;
    function GetTop: Single;
    function GetRenderer: TAdvancedTextRenderer;
  public
    constructor Create(aLine: TLine);
    destructor Destroy; override;
    procedure AdjustRuns;
    procedure SetLine(aLine: TLine);
    procedure Draw;
    property Left: Single read FLeft write FLeft;
    property Width: Single read GetWidth;
    property Top: Single read GetTop;
    property Renderer: TAdvancedTextRenderer read GetRenderer;
    property Runs: TList<TRun> read FRuns;
  end;

  TTab = class(TWord);

  TRun = class
  private
    FText: String;
    FStyle: TStyleDescriptor;
    FWord: TWord;
    FLeft: Single;
    FWidth: Single;
    function GetRenderer: TAdvancedTextRenderer;
    function GetTop: Single;
    function GetFont(disableUnderlinesStrikeouts: Boolean): TfrxFont; overload;
  public
    constructor Create(const aText: String; aStyle: TStyleDescriptor; aWord: TWord);
    function GetFont: TfrxFont; overload;
    procedure Draw;
    property Text: String read FText;
    property Style: TStyleDescriptor read FStyle;
    property Renderer: TAdvancedTextRenderer read GetRenderer;
    property Left: Single read FLeft write FLeft;
    property Top: Single read GetTop;
    property Width: Single read FWidth;
  end;

implementation
{ TStyleDescriptor routines }

function StyleDescriptor(FontStyle: TFontStyles; Color: TAlphaColor; BaseLine: TBaseLine): TStyleDescriptor;
begin
  Result.FontStyle := FontStyle;
  Result.Color := Color;
  Result.BaseLine := BaseLine;
end;

function NullStyle: TStyleDescriptor;
begin
  Result.FontStyle := [];
  Result.Color := 0;
  Result.BaseLine := TBaseLine.Normal;
end;

function StyleDescriptorToString(style: TStyleDescriptor): String;
begin
  Result := '';

  if fsBold in style.FontStyle then
    Result := Result + '<b>';
  if fsItalic in style.FontStyle then
    Result := Result + '<i>';
  if fsUnderline in style.FontStyle then
    Result := Result + '<u>';
  if fsStrikeout in style.FontStyle then
    Result := Result + '<strike>';
  if style.BaseLine = TBaseLine.Subscript then
    Result := Result + '<sub>';
  if style.BaseLine = TBaseLine.Superscript then
    Result := Result + '<sup>';

  Result := Result + '<font color="' + AlphaColorToString(style.Color) + '">';
end;

function AdjY(Value, Thickness: Single): Single;
begin
  Result := Round(Value);
  if (Trunc(Thickness) mod 2) = 1 then
    Result := Result + 0.5;
end;

{ TfrxHTMLTag }

procedure TfrxHTMLTag.Assign(Tag: TfrxHTMLTag);
begin
  Position := Tag.Position;
  Size := Tag.Size;
  AddY := Tag.AddY;
  Style := Tag.Style;
  Color := Tag.Color;
  Default := Tag.Default;
  Small := Tag.Small;
  Self.SubType := Tag.SubType;
end;


{ TfrxHTMLTags }

constructor TfrxHTMLTags.Create;
begin
  FItems := TList.Create;
end;

destructor TfrxHTMLTags.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

procedure TfrxHTMLTags.Clear;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TfrxHTMLTag(FItems[i]).Free;
  FItems.Clear;
end;

function TfrxHTMLTags.GetItems(Index: Integer): TfrxHTMLTag;
begin
  Result := TfrxHTMLTag(FItems[Index]);
end;

function TfrxHTMLTags.Count: Integer;
begin
  Result := FItems.Count;
end;

procedure TfrxHTMLTags.Add(Tag: TfrxHTMLTag);
begin
  FItems.Add(Tag);
end;


{ TfrxHTMLTagsList }

constructor TfrxHTMLTagsList.Create;
begin
  FItems := TList.Create;
  FAllowTags := True;
end;

destructor TfrxHTMLTagsList.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

procedure TfrxHTMLTagsList.Clear;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TfrxHTMLTags(FItems[i]).Free;
  FItems.Clear;
end;

procedure TfrxHTMLTagsList.NewLine;
begin
  if Count <> 0 then
    FItems.Add(TfrxHTMLTags.Create);
end;

procedure TfrxHTMLTagsList.Wrap(TagsCount: Integer; AddBreak: Boolean);
var
  i: Integer;
  Line, OldLine: TfrxHTMLTags;
  NewTag: TfrxHTMLTag;
begin
  OldLine := Items[Count - 1];
  if OldLine.Count <= TagsCount then
    Exit;

  NewLine;
  Line := Items[Count - 1];
  for i := TagsCount to OldLine.Count - 1 do
    Line.Add(OldLine[i]);
  OldLine.FItems.Count := TagsCount;
  if AddBreak then
  begin
    NewTag := TfrxHTMLTag.Create;
    OldLine.FItems.Add(NewTag);
    NewTag.Assign(TfrxHTMLTag(OldLine.FItems[TagsCount - 1]))
  end
  else if Line[0].Default then
    Line[0].Assign(OldLine[TagsCount - 1]);
end;

function TfrxHTMLTagsList.Count: Integer;
begin
  Result := FItems.Count;
end;

function TfrxHTMLTagsList.GetItems(Index: Integer): TfrxHTMLTags;
begin
  Result := TfrxHTMLTags(FItems[Index]);
end;

function TfrxHTMLTagsList.Add: TfrxHTMLTag;
var
  i: Integer;
begin
  Result := TfrxHTMLTag.Create;
  i := Count - 1;
  if i = -1 then
  begin
    FItems.Add(TfrxHTMLTags.Create);
    i := 0;
  end;
  Items[i].Add(Result);
end;

function TfrxHTMLTagsList.GetPrevTag: TfrxHTMLTag;
var
  Tags: TfrxHTMLTags;
begin
  Result := nil;
  Tags := Items[Count - 1];
  if Tags.Count > 1 then
    Result := Tags[Tags.Count - 2]
  else if Count > 1 then
  begin
    Tags := Items[Count - 2];
    Result := Tags[Tags.Count - 1];
  end;
end;

procedure TfrxHTMLTagsList.SetDefaults(DefColor: TColor; DefSize: Integer;
  DefStyle: TFontStyles);
begin
  FDefColor := DefColor;
  FDefSize := DefSize;
  FDefStyle := DefStyle;
  FAddY := 0;
  FColor := FDefColor;
  FSize := FDefSize;
  FStyle := FDefStyle;
  FDontWRAP := False;
  FPosition := 1;
  Self.FSubStyle := ssNormal;
  Clear;
end;

procedure TfrxHTMLTagsList.ExpandHTMLTags(var s: WideString);
var
  i, j, j1: Integer;
  b: Boolean;
  cl: WideString;

  procedure AddTag;
  var
    Tag, PrevTag: TfrxHTMLTag;
  begin
    Tag := Add;
    Tag.Position := FPosition; // this will help us to get position in the original text
    Tag.Size := FSize;
    Tag.Style := FStyle;
    Tag.Color := FColor;
    Tag.AddY := FAddY;
    Tag.DontWRAP := FDontWRAP;
    Tag.SubType := Self.FSubStyle;
// when "Default" changes, we need to set Font.Style, Size and Color
    if FAllowTags then
    begin
      PrevTag := GetPrevTag;
      if PrevTag <> nil then
        Tag.Default := (FStyle = PrevTag.Style) and
                       (FColor = PrevTag.Color) and
                       (FSize = PrevTag.Size) and (FAddY = PrevTag.AddY) and (FDontWRAP = PrevTag.DontWRAP)
      else
        Tag.Default := (FStyle = FDefStyle) and (FColor = FDefColor) and (FSize = FDefSize);
    end
    else
      Tag.Default := True;
    Tag.Small := FSize <> FDefSize;
  end;

begin
  i := 1;
  if Length(s) = 0 then Exit;

  while i <= Length(s) do
  begin
    b := True;

    if FAllowTags then
      if s[i] = '<' then
      begin

        // <b>, <u>, <i> tags
        if (i + 2 <= Length(s)) and (s[i + 2] = '>') then
        begin
          case s[i + 1] of
            'b','B': FStyle := FStyle + [fsBold];
            'i','I': FStyle := FStyle + [fsItalic];
            'u','U': FStyle := FStyle + [fsUnderline];
            else
              b := False;
          end;
          if b then
          begin
            System.Delete(s, i, 3);
            Inc(FPosition, 3);
            continue;
          end;
        end

        // <sub>, <sup> tags
        else if (i + 4 <= Length(s)) and (s[i + 4] = '>') then
        begin
          if Pos('SUB>', AnsiUpperCase(s)) = i + 1 then
          begin
            FSize := Round(FDefSize / 1.5);
            FAddY := 1;
            b := True;
            Self.FSubStyle := ssSubscript;
          end
          else if Pos('SUP>', AnsiUpperCase(s)) = i + 1 then
          begin
            FSize := Round(FDefSize / 1.5);
            FAddY := 0;
            b := True;
            Self.FSubStyle := ssSuperscript;
          end;
          if b then
          begin
            System.Delete(s, i, 5);
            Inc(FPosition, 5);
            continue;
          end;
        end

        // <sub>, <sup> tags
        else if (i + 5 <= Length(s)) and (s[i + 5] = '>') then
        begin
          if (Pos('/SUB>', AnsiUpperCase(s)) = i + 1) or (Pos('/SUP>', AnsiUpperCase(s)) = i + 1) then
          begin
            FSize := FDefSize;
            FAddY := 0;
            b := True;
            Self.FSubStyle := ssNormal;
          end;
          if b then
          begin
            System.Delete(s, i, 6);
            Inc(FPosition, 6);
            continue;
          end;
        end


        else if (i + 7 <= Length(s)) and ((s[i + 1] = 'n') or (s[i + 1] = 'N')) then
        begin
          if Pos('NOWRAP>', AnsiUpperCase(s)) = i + 1 then
          begin
            FDontWRAP := True;
            System.Delete(s, i, 8);
            Inc(FPosition, 8);
            continue;
          end;
        end

        // <strike> tag
        else if (i + 1 <= Length(s)) and ((s[i + 1] = 's') or (s[i + 1] = 'S')) then
        begin
          if Pos('STRIKE>', AnsiUpperCase(s)) = i + 1 then
          begin
            FStyle := FStyle + [fsStrikeOut];
            System.Delete(s, i, 8);
            Inc(FPosition, 8);
            continue;
          end;
        end

        // </b>, </u>, </i>, </strike>, </font>, </sub>, </sup> tags
        else if (i + 1 <= Length(s)) and (s[i + 1] = '/') then
        begin
          if (i + 3 <= Length(s)) and (s[i + 3] = '>') then
          begin
            case s[i + 2] of
              'b','B': FStyle := FStyle - [fsBold];
              'i','I': FStyle := FStyle - [fsItalic];
              'u','U': FStyle := FStyle - [fsUnderline];
              else
                b := False;
            end;
            if b then
            begin
              System.Delete(s, i, 4);
              Inc(FPosition, 4);
              continue;
            end;
          end
          else if (Pos('STRIKE>', AnsiUpperCase(s)) = i + 2) then
          begin
            FStyle := FStyle - [fsStrikeOut];
            System.Delete(s, i, 9);
            Inc(FPosition, 9);
            continue;
          end
          else if (Pos('NOWRAP>', AnsiUpperCase(s)) = i + 2) then
          begin
            FDontWRAP := False;
            System.Delete(s, i, 9);
            Inc(FPosition, 9);
            continue;
          end
          else if Pos('FONT>', AnsiUpperCase(s)) = i + 2 then
          begin
            FColor := FDefColor;
            System.Delete(s, i, 7);
            Inc(FPosition, 7);
            continue;
          end
          else if (Pos('SUB>', AnsiUpperCase(s)) = i + 2) or
            (Pos('SUP>', AnsiUpperCase(s)) = i + 2) then
          begin
            FSize := FDefSize;
            FAddY := 0;
            System.Delete(s, i, 6);
            Inc(FPosition, 6);
            continue;
          end
        end

  // <font color = ...> tag
        else if Pos('FONT COLOR', AnsiUpperCase(s)) = i + 1 then
        begin
          j := i + 11;
          while (j <= Length(s)) and (s[j] <> '=') do
            Inc(j);
          Inc(j);
          while (j <= Length(s)) and (s[j] = ' ') do
            Inc(j);
          j1 := j;
          while (j <= Length(s)) and (s[j] <> '>') do
            Inc(j);

          cl := Copy(s, j1, j - j1);
          if cl <> '' then
          begin
            if (Length(cl) > 3) and (cl[1] = '"') and (cl[2] = '#') and
              (cl[Length(cl)] = '"') then
            begin
              cl := '$' + Copy(cl, 3, Length(cl) - 3);
              FColor := StrToInt(cl);
              FColor := (FColor and $000000FF) div 65536 +
                        (FColor and $00FF0000) * 65536 +
                        (FColor and $0000FF00);
              System.Delete(s, i, j - i + 1);
              Inc(FPosition, j - i + 1);
              continue;
            end
            else if IdentToAlphaColor('cl' + cl, FColor) then
            begin
              System.Delete(s, i, j - i + 1);
              Inc(FPosition, j - i + 1);
              continue;
            end;
          end;
        end
      end;

    AddTag;
    Inc(i);
    Inc(FPosition);
  end;

  if Length(s) = 0 then
  begin
    AddTag;
    s := ' ';
  end;
end;

{ TAdvancedTextRenderer }

function TAdvancedTextRenderer.MeasureTextWidth(const aText: String): Single;
var
  r: TRectF;
begin
  r := RectF(0, 0, 10000, 10000);
  Canvas.MeasureText(r, aText, False, [], TTextAlign.taLeading, TTextAlign.taLeading);
  Result := r.Width;
end;

procedure TAdvancedTextRenderer.SplitToParagraphs(const text: String);
var
  style: TStyleDescriptor;
  lines: TStringDynArray;
  line: String;
  i, lineLength, originalCharIndex: Integer;
  paragraph: TParagraph;
begin
  style := StyleDescriptor(Font.Style, Font.Color, TBaseLine.Normal);
  lines := SplitString(text, #10);
  originalCharIndex := 0;

  for i := 0 to Length(lines) - 1 do
  begin
    line := lines[i];
    lineLength := Length(line);
    if (lineLength > 0) and (line[lineLength] = #13) then
      Delete(line, lineLength, 1);

    paragraph := TParagraph.Create(line, self, originalCharIndex);
    FParagraphs.Add(paragraph);
    style := paragraph.WrapLines(style);

    Inc(originalCharIndex, lineLength + 1);
  end;

  // skip empty paragraphs at the end
  for i := FParagraphs.Count - 1 downto 0 do
  begin
    if FParagraphs[i].IsEmpty then
    begin
      FParagraphs[i].Free;
      FParagraphs.Delete(i);
    end
    else
      break;
  end;
end;

procedure TAdvancedTextRenderer.AdjustParagraphLines;
var
  i, j: Integer;
  height, offsetY: Single;
  paragraph: TParagraph;
  line: TLine;
begin
  // calculate text height
  height := 0;
  for paragraph in Paragraphs do
    height := height + paragraph.Lines.Count * LineHeight;

  // calculate Y offset
  offsetY := DisplayRect.Top;
  if VertAlign = vaCenter then
    offsetY := offsetY + (DisplayRect.Height - height) / 2
  else if VertAlign = vaBottom then
    offsetY := offsetY + (DisplayRect.Height - height) - 1;

  for i := 0 to Paragraphs.Count - 1 do
  begin
    paragraph := Paragraphs[i];
    paragraph.AlignLines((i = Paragraphs.Count - 1) and ForceJustify);

    // adjust line tops
    for line in paragraph.Lines do
    begin
      line.Top := offsetY;
      line.MakeUnderlines;
      offsetY := offsetY + LineHeight;
    end;
  end;
end;

procedure TAdvancedTextRenderer.Draw;
var
  state: TCanvasSaveState;
  m, OldM: TMatrix;
  paragraph: TParagraph;
begin
  // set clipping
  // avoid bug under win platform, after state restore matrix has unexpected values
  OldM := Canvas.Matrix;
  State := Canvas.SaveState;

  try
    Canvas.IntersectClipRect(DisplayRect);

  if Angle <> 0 then
  begin
    m := CreateRotationMatrix(-DegToRad(Angle));
    // offset
    m.m31 := OldM.m31 + DisplayRect.Left + DisplayRect.Width / 2;
    m.m32 := OldM.m32 + DisplayRect.Top + DisplayRect.Height / 2;
    Canvas.SetMatrix(m);
  end;

  for paragraph in Paragraphs do
    paragraph.Draw;

  finally
   // restore clipping
   Canvas.RestoreState(state);
   Canvas.SetMatrix(OldM);
  end;
end;

function TAdvancedTextRenderer.CalcHeight: Single;
var
  charsFit: Integer;
  style: TStyleDescriptor;
begin
  Result := CalcHeight(charsFit, style);
end;

function TAdvancedTextRenderer.CalcHeight(var charsFit: Integer; var style: TStyleDescriptor): Single;
var
  i, j: Integer;
  height, displayHeight: Single;
  line: TLine;
begin
  charsFit := 0;
  style := NullStyle;
  height := 0;
  displayHeight := DisplayRect.Height;
  if LineHeight > displayHeight then
  begin
    Result := 0;
    Exit;
  end;

  for i := 0 to Paragraphs.Count - 1 do
    for j := 0 to Paragraphs[i].Lines.Count - 1 do
    begin
      line := Paragraphs[i].Lines[j];
      height := height + LineHeight;
      if (charsFit = 0) and (height > displayHeight) then
      begin
        charsFit := line.OriginalCharIndex;
        if HtmlTags then
          style := line.Style;
      end;
    end;

  if charsFit = 0 then
    charsFit := Length(FText);
  Result := height;
end;

function TAdvancedTextRenderer.CalcWidth: Single;
var
  paragraph: TParagraph;
  line: TLine;
  width: Single;
begin
  width := 0;

  for paragraph in Paragraphs do
    for line in paragraph.Lines do
    begin
      if width < line.Width then
        width := line.Width;
    end;

  Result := width + FSpaceWidth;
end;

function TAdvancedTextRenderer.GetTabPosition(pos: Single): Single;
var
  tabOffset, tabSize: Single;
  tabPosition: Integer;
begin
  tabOffset := 0;
  tabSize := 64;
  tabPosition := Trunc((pos - tabOffset) / tabSize);
  if pos < tabOffset then
    Result := tabOffset
  else
    Result := (tabPosition + 1) * tabSize + tabOffset;
end;

constructor TAdvancedTextRenderer.Create(aCanvas: TCanvas; const aText: String;
  aFont: TfrxFont; rect: TRectF; aHorzAlign: TfrxHAlign; aVertAlign: TfrxVAlign;
  aLineHeight: Single; aAngle: Integer; aWordWrap: Boolean; aForceJustify: Boolean;
  aHtmlTags: Boolean; aPdfMode: Boolean);
begin
  FParagraphs := TList<TParagraph>.Create;
  FText := aText;
  FCanvas := aCanvas;
  FFont := aFont;
  FDisplayRect := rect;
  FHorzAlign := aHorzAlign;
  FVertAlign := aVertAlign;
  FLineHeight := aLineHeight;
  FFontLineHeight := aFont.GetHeight(aCanvas) + 2;
  if FLineHeight = 0 then
    FLineHeight := FFontLineHeight;
  FAngle := aAngle;
  FWordWrap := aWordWrap;
  FForceJustify := aForceJustify;
  FHtmlTags := aHtmlTags;
  FPDFMode := aPdfMode;
  aFont.AssignToCanvas(aCanvas);
  FSpaceWidth := MeasureTextWidth(' ');

  if Angle <> 0 then
  begin
    // shift displayrect
    FDisplayRect.Left := -rect.Width / 2;
    FDisplayRect.Top := -rect.Height / 2;
    FDisplayRect.Right := FDisplayRect.Left + rect.Width;
    FDisplayRect.Bottom := FDisplayRect.Top + rect.Height;

    // rotate displayrect if angle is 90 or 270
    if ((Angle >= 90) and (Angle < 180)) or ((Angle >= 270) and (Angle < 360)) then
      FDisplayRect := RectF(DisplayRect.Top, DisplayRect.Left, DisplayRect.Bottom, DisplayRect.Right);
  end;

  SplitToParagraphs(aText);
  AdjustParagraphLines;

  // restore original values
  FDisplayRect := rect;
end;

destructor TAdvancedTextRenderer.Destroy;
var
  paragraph: TParagraph;
begin
  for paragraph in Paragraphs do
    paragraph.Free;
  Paragraphs.Free;
  inherited;
end;


{ TParagraph }

function TParagraph.IsLast: Boolean;
begin
  Result := FRenderer.Paragraphs[FRenderer.Paragraphs.Count - 1] = self;
end;

function TParagraph.IsEmpty: Boolean;
begin
  Result := FText = '';
end;

function TParagraph.WrapLines(style: TStyleDescriptor): TStyleDescriptor;
var
  line: TLine;
  aWord: TWord;
  text, currentWord, tag, colorName: String;
  width, WLineWidth: Single;
  skipSpace, match, isLastWord: Boolean;
  i, originalCharIndex, istart, iend: Integer;
  newStyle: TStyleDescriptor;
begin
  line := TLine.Create(self, FOriginalCharIndex);
  FLines.Add(line);
  aWord := TWord.Create(line);
  line.Words.Add(aWord);
  WLineWidth := 0;
  text := FText;
  currentWord := '';
  width := 0;
  skipSpace := True;
  originalCharIndex := FOriginalCharIndex;

  i := 1;
  while i <= Length(text) do
  begin
    if Renderer.HtmlTags and (text[i] = '<') then
    begin
      // probably html tag
      newStyle := style;
      tag := '';
      match := False;

      // <b>, <i>, <u>
      if i + 3-1 <= Length(text) then
      begin
        match := True;
        tag := LowerCase(Copy(text, i, 3));
        if tag = '<b>' then
          newStyle.FontStyle := newStyle.FontStyle + [fsBold]
        else if tag = '<i>' then
          newStyle.FontStyle := newStyle.FontStyle + [fsItalic]
        else if tag = '<u>' then
          newStyle.FontStyle := newStyle.FontStyle + [fsUnderline]
        else
          match := False;

        if match then
          Inc(i, 3);
      end;

      // </b>, </i>, </u>
      if not match and (i + 4-1 <= Length(text)) and (text[i + 1] = '/') then
      begin
        match := True;
        tag := LowerCase(Copy(text, i, 4));
        if tag = '</b>' then
          newStyle.FontStyle := newStyle.FontStyle - [fsBold]
        else if tag = '</i>' then
          newStyle.FontStyle := newStyle.FontStyle - [fsItalic]
        else if tag = '</u>' then
          newStyle.FontStyle := newStyle.FontStyle - [fsUnderline]
        else
          match := False;

        if match then
          Inc(i, 4);
      end;

      // <sub>, <sup>
      if not match and (i + 5-1 <= Length(text)) then
      begin
        match := True;
        tag := LowerCase(Copy(text, i, 5));
        if tag = '<sub>' then
          newStyle.BaseLine := TBaseLine.Subscript
        else if tag = '<sup>' then
          newStyle.BaseLine := TBaseLine.Superscript
        else
          match := False;

        if match then
          Inc(i, 5);
      end;

      // </sub>, </sup>
      if not match and (i + 6-1 <= Length(text)) and (text[i + 1] = '/') then
      begin
        match := True;
        tag := LowerCase(Copy(text, i, 6));
        if (tag = '</sub>') or (tag = '</sup>') then
          newStyle.BaseLine := TBaseLine.Normal
        else
          match := False;

        if match then
          Inc(i, 6);
      end;

      // <strike>
      if not match and (i + 8-1 <= Length(text)) then
      begin
        tag := LowerCase(Copy(text, i, 8));
        if tag = '<strike>' then
        begin
          newStyle.FontStyle := newStyle.FontStyle + [fsStrikeout];
          match := True;
          Inc(i, 8);
        end;
      end;

      // </strike>
      if not match and (i + 9-1 <= Length(text)) then
      begin
        tag := LowerCase(Copy(text, i, 9));
        if tag = '</strike>' then
        begin
          newStyle.FontStyle := newStyle.FontStyle - [fsStrikeout];
          match := True;
          Inc(i, 9);
        end;
      end;

      // <font color
      if not match and (i + 12-1 < Length(text)) then
      begin
        tag := LowerCase(Copy(text, i, 12));
        if tag = '<font color=' then
        begin
          istart := i + 12;
          iend := istart;
          while (iend <= Length(text)) and (text[iend] <> '>') do
            Inc(iend);

          if iend <= Length(text) then
          begin
            colorName := Copy(text, istart, iend - istart);
            if (colorName[1] = '"') and (colorName[Length(colorName)] = '"') then
              colorName := Copy(colorName, 2, Length(colorName) - 2);
            newStyle.Color := StringToAlphaColor(colorName);
            i := iend + 1;
            match := True;
          end;
        end;
      end;

      // </font>
      if not match and (i + 7-1 <= Length(text)) then
      begin
        tag := LowerCase(Copy(text, i, 7));
        if tag = '</font>' then
        begin
          newStyle.Color := Renderer.Font.Color;
          match := True;
          Inc(i, 7);
        end;
      end;

      if match then
      begin
        // finish the word
        if currentWord <> '' then
          aWord.Runs.Add(TRun.Create(currentWord, style, aWord));

        currentWord := '';
        style := newStyle;
        
        if i >= Length(text) then
        begin
          // check width
          width := width + aWord.Width + Renderer.SpaceWidth;
          if width > Renderer.DisplayRect.Width then
          begin
            // line is too long, make a new line
            if line.Words.Count > 1 then
            begin
              // if line has several words, delete the last word from the current line
              line.Words.Delete(line.Words.Count - 1);
              // make new line
              line := TLine.Create(self, originalCharIndex);
              // and add word to it
              line.Words.Add(aWord);
              aWord.SetLine(line);
              FLines.Add(line);
            end;
          end;
        end;
        continue;
      end;
    end;

    if (text[i] = ' ') or (text[i] = #9) or (i = Length(text)) or (WLineWidth > Renderer.DisplayRect.Width) then
    begin
      // finish the last word
      isLastWord := i = Length(text);
      if isLastWord then
      begin
        currentWord := currentWord + text[i];
        skipSpace := False;
      end;

      if text[i] = #9 then
        skipSpace := False;

      // space
      if skipSpace then
        currentWord := currentWord + text[i]
      else
      begin
        // finish the word
        if currentWord <> '' then
          aWord.Runs.Add(TRun.Create(currentWord, style, aWord));

        // check width
        width := width + aWord.Width + Renderer.SpaceWidth;
        if width > Renderer.DisplayRect.Width then
        begin
          // line is too long, make a new line
          width := 0;
          if line.Words.Count > 1 then
          begin
            // if line has several words, delete the last word from the current line
            line.Words.Delete(line.Words.Count - 1);
            // make new line
            line := TLine.Create(self, originalCharIndex);
            // and add word to it
            line.Words.Add(aWord);
            aWord.SetLine(line);
            width := width + aWord.Width + Renderer.SpaceWidth;
          end
          else
            line := TLine.Create(self, i + 1);
          FLines.Add(line);
        end;

        // TAB symbol
        if text[i] = #9 then
        begin
          if currentWord = '' then
            line.Words.Delete(line.Words.Count - 1);
          aWord := TTab.Create(line);
          line.Words.Add(aWord);
          // adjust width
          width := Renderer.GetTabPosition(width);
        end;

        if not isLastWord then
        begin
          aWord := TWord.Create(line);
          line.Words.Add(aWord);
          currentWord := '';
          originalCharIndex := FOriginalCharIndex + i + 1;
          skipSpace := True;
          WLineWidth := 0;
        end;
      end;
    end
    else
    begin
      // symbol
      currentWord := currentWord + text[i];
      skipSpace := False;

      // word wrap - do something better than call measure text every time
      // TODO
      if FRenderer.WordWrap then
        with TRun.Create(currentWord, Style, aWord) do
        begin
          WLineWidth := Width;
          if (WLineWidth > renderer.DisplayRect.Width) and
            (Length(currentWord) > 4) then
          begin
            Delete(currentWord, Length(currentWord) - 2, 3);
            Dec(i, 4);
          end;
          Free;
        end;
    end;

    Inc(i);
  end;

  Result := style;
end;

procedure TParagraph.AlignLines(forceJustify: Boolean);
var
  i: Integer;
  align: TfrxHAlign;
begin
  for i := 0 to Lines.Count - 1 do
  begin
    align := Renderer.HorzAlign;
    if (align = TfrxHAlign.haBlock) and (i = Lines.Count - 1) and not forceJustify then
      align := TfrxHAlign.haLeft;
    Lines[i].AlignWords(align);
  end;
end;

procedure TParagraph.Draw;
var
  line: TLine;
begin
  for line in Lines do
    line.Draw;
end;

constructor TParagraph.Create(const text: String; renderer: TAdvancedTextRenderer; originalCharIndex: Integer);
begin
  FLines := TList<TLine>.Create;
  FText := text;
  FRenderer := renderer;
  FOriginalCharIndex := originalCharIndex;
end;

destructor TParagraph.Destroy;
var
  line: TLine;
begin
  for line in Lines do
    line.Free;
  Lines.Free;
  inherited;
end;


{ TLine }

function TLine.GetLeft: Single;
begin
  if Words.Count > 0 then
    Result := Words[0].Left
  else
    Result := 0;
end;

function TLine.GetRenderer: TAdvancedTextRenderer;
begin
  Result := FParagraph.Renderer;
end;

function TLine.GetStyle: TStyleDescriptor;
begin
  Result := NullStyle;
  if Words.Count > 0 then
    if Words[0].Runs.Count > 0 then
       Result := Words[0].Runs[0].Style;
end;

function TLine.IsLast: Boolean;
begin
  Result := FParagraph.Lines[FParagraph.Lines.Count - 1] = self;
end;

procedure TLine.PrepareUnderlines(list: TList<TRectF>; style: TFontStyle);
var
  left, right, lineWidth: Single;
  styleOn: Boolean;
  aWord: TWord;
  run: TRun;
  fnt: TfrxFont;
begin
  list.Clear;
  if Words.Count = 0 then
    Exit;

  left := 0;
  right := 0;
  styleOn := False;

  for aWord in Words do
  begin
    for run in aWord.Runs do
    begin
      fnt := run.GetFont;
      if style in fnt.Style then
      begin
        if not styleOn then
        begin
          styleOn := True;
          left := run.Left;
        end;
        right := run.Left + run.Width;
      end;
      if not (style in fnt.Style) and styleOn then
      begin
        styleOn := False;
        list.Add(RectF(left, Top, right, Top));
      end;
      fnt.Free;
    end;
  end;
  // close the style
  if styleOn then
    list.Add(RectF(left, Top, right, Top));
end;

procedure TLine.AlignWords(align: TfrxHAlign);
var
  left, rectWidth, delta, curDelta: Single;
  i: Integer;
  aWord: TWord;
begin
  FWidth := 0;
  left := 0;
  i := 0;
  while i < Words.Count do
  begin
    aWord := Words[i];
    aWord.Left := left;

    if aWord is TTab then
    begin
      left := Renderer.GetTabPosition(left);
      // remove tab
      Words.Delete(i);
      aWord.Free;
      Dec(i);
    end
    else
      left := left + aWord.Width + Renderer.SpaceWidth;
    Inc(i);
  end;

  FWidth := left;
  rectWidth := Renderer.DisplayRect.Width;
  if align = TfrxHAlign.haBlock then
  begin
    if Words.Count > 1 then
    begin
      delta := (rectWidth - FWidth) / (Words.Count - 1);
      curDelta := delta;
      for i := 1 to Words.Count - 1 do
      begin
        FWords[i].Left := FWords[i].Left + curDelta;
        curDelta := curDelta + delta;
      end;
    end;
  end
  else
  begin
    delta := 0;
    if align = TfrxHAlign.haCenter then
      delta := (rectWidth - FWidth) / 2
    else if align = TfrxHAlign.haRight then
      delta := rectWidth - (FWidth - Renderer.SpaceWidth);
    for aWord in Words do
      aWord.Left := aWord.Left + delta;
  end;

  // adjust X offset
  for aWord in Words do
  begin
    if Renderer.RightToLeft then
      aWord.Left := Renderer.DisplayRect.Right - aWord.Left
    else
      aWord.Left := aWord.Left + Renderer.DisplayRect.Left;
    aWord.AdjustRuns;
    if Renderer.RightToLeft and Renderer.PDFMode then
      aWord.Left := aWord.Left - aWord.Width;
  end;
end;

procedure TLine.MakeUnderlines;
begin
  PrepareUnderlines(FUnderlines, TFontStyle.fsUnderline);
  PrepareUnderlines(FStrikeouts, TFontStyle.fsStrikeout);
end;

procedure TLine.Draw;
var
  aWord: TWord;
  h, w, th: Single;
  rect: TRectF;
begin
  for aWord in Words do
    aWord.Draw;

  if (Underlines.Count > 0) or (Strikeouts.Count > 0) then
  begin
    h := Renderer.FontLineHeight;
    w := h * 0.1; // to match char X offset
    // invert offset in case of rtl
    if Renderer.RightToLeft then
      w := -w;
    th := Round(Renderer.Font.Size * 0.1);
    Renderer.Canvas.StrokeThickness := th;
    Renderer.Canvas.Stroke.Color := Renderer.Font.Color;

    // emulate underline & strikeout
    for rect in Underlines do
      Renderer.Canvas.DrawLine(
        PointF(rect.Left + w, AdjY(rect.Top + h - w, th)), PointF(rect.Right + w, AdjY(rect.Top + h - w, th)), 1);

    h := h / 2;
    for rect in Strikeouts do
      Renderer.Canvas.DrawLine(
        PointF(rect.Left + w, AdjY(rect.Top + h, th)), PointF(rect.Right + w, AdjY(rect.Top + h, th)), 1);
  end;
end;

constructor TLine.Create(paragraph: TParagraph; originalCharIndex: Integer);
begin
  FWords := TList<TWord>.Create;
  FParagraph := paragraph;
  FOriginalCharIndex := originalCharIndex;
  FUnderlines := TList<TRectF>.Create;
  FStrikeouts := TList<TRectF>.Create;
end;

destructor TLine.Destroy;
var
  aWord: TWord;
begin
  for aWord in Words do
    aWord.Free;
  Words.Free;
  Underlines.Free;
  Strikeouts.Free;
  inherited;
end;


{ TWord }

function TWord.GetTop: Single;
begin
  Result := FLine.Top;
end;

function TWord.GetRenderer: TAdvancedTextRenderer;
begin
  Result := FLine.Renderer;
end;

function TWord.GetWidth: Single;
var
  run: TRun;
begin
  if FWidth = -1 then
  begin
    FWidth := 0;
    for run in Runs do
      FWidth := FWidth + run.Width;
  end;
  Result := FWidth;
end;

procedure TWord.AdjustRuns;
var
  aLeft: Single;
  run: TRun;
begin
  aLeft := Left;
  for run in Runs do
  begin
    run.Left := aLeft;

    if Renderer.RightToLeft then
    begin
      aLeft := aLeft - run.Width;
      if Renderer.PDFMode then
        run.Left := run.Left - run.Width;
    end
    else
      aLeft := aLeft + run.Width;
  end;
end;

procedure TWord.SetLine(aLine: TLine);
begin
  FLine := aLine;
end;

procedure TWord.Draw;
var
  run: TRun;
begin
  for run in Runs do
    run.Draw;
end;

constructor TWord.Create(aLine: TLine);
begin
  FRuns := TList<TRun>.Create;
  FLine := aLine;
  FWidth := -1;
end;

destructor TWord.Destroy;
var
  run: TRun;
begin
  for run in Runs do
    run.Free;
  FRuns.Free;
  inherited;
end;


{ TRun }

function TRun.GetRenderer: TAdvancedTextRenderer;
begin
  Result := FWord.Renderer;
end;

function TRun.GetTop: Single;
var
  baseLine: Single;
begin
  baseLine := 0;
  if Style.BaseLine = TBaseLine.Subscript then
    baseLine := baseLine + Renderer.FontLineHeight * 0.45
  else if Style.BaseLine = TBaseLine.Superscript then
    baseLine := baseLine - Renderer.FontLineHeight * 0.15;
  Result := FWord.Top + baseLine;
end;

function TRun.GetFont(disableUnderlinesStrikeouts: Boolean): TfrxFont;
var
  fontSize: Single;
  fontStyle: TFontStyles;
begin
  fontSize := Renderer.Font.Size;
  if Style.BaseLine <> TBaseLine.Normal then
    fontSize := fontSize * 0.6;

  fontStyle := Style.FontStyle;
  if disableUnderlinesStrikeouts then
    fontStyle := fontStyle - [fsUnderline, fsStrikeout];

  Result := TfrxFont.Create;
  Result.Name := Renderer.Font.Name;
  Result.Color := Style.Color;
  Result.Size := fontSize;
  Result.Style := fontStyle;
end;

function TRun.GetFont: TfrxFont;
begin
  Result := GetFont(false);
end;

procedure TRun.Draw;
var
  font: TfrxFont;
begin
  font := GetFont(True);
  font.AssignToCanvas(Renderer.Canvas);
  Renderer.Canvas.FillText(RectF(Left, Top, Left + 10000, Top + 10000), FText, False, 1, [], TTextAlign.taLeading, TTextAlign.taLeading);
  font.Free;
end;

constructor TRun.Create(const aText: String; aStyle: TStyleDescriptor; aWord: TWord);
var
  font: TfrxFont;
begin
  FText := aText;
  FStyle := aStyle;
  FWord := aWord;

  font := GetFont;
  font.AssignToCanvas(Renderer.Canvas);
  FWidth := Renderer.MeasureTextWidth(aText);
  font.Free;
end;

end.


//56db3b0f55102b9488a240d37950543f