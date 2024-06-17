{******************************************}
{                                          }
{             FastReport FMX v2.0          }
{            	Font parser                }
{                                          }
{         Copyright (c) 1998-2013          }
{          by Aleksey Mandrykin,       	   }
{             Fast Reports Inc.            }
{                                          }
{******************************************}
{$hints off}
unit FMX.frxTrueTypeFont;
interface

uses  FMX.TTFHelpers, FMX.frxCmapTableClass, FMX.frxFontHeaderClass, FMX.frxGlyphTableClass,
      FMX.frxGlyphSubstitutionClass, FMX.frxHorizontalHeaderClass,
      FMX.frxHorizontalMetrixClass, FMX.frxIndexToLocationClass,
      FMX.frxKerningTableClass, FMX.frxNameTableClass, FMX.frxPostScriptClass,
      FMX.frxMaximumProfileClass, FMX.frxOS2WindowsMetricsClass,
      System.Classes, FMX.frxTrueTypeTable,
      FMX.frxPreprogramClass, FMX.Types, System.UITypes, System.Types,
      System.Generics.Collections;

type

  {$EXTERNALSYM PABC}
  PABC = ^TABC;
  {$EXTERNALSYM _ABC}
  _ABC = record
    abcA: Integer;
    abcB: LongWord;
    abcC: Integer;
  end;
  TABC = _ABC;
  {$EXTERNALSYM ABC}
  ABC = _ABC;

    TPanose = record
    bFamilyType: Byte;
    bSerifStyle: Byte;
    bWeight: Byte;
    bProportion: Byte;
    bContrast: Byte;
    bStrokeVariation: Byte;
    bArmStyle: Byte;
    bLetterform: Byte;
    bMidline: Byte;
    bXHeight: Byte;
  end;

     PTextMetricA = ^TTextMetricA;
  PTextMetricW = ^TTextMetricW;
  PTextMetric = PTextMetricW;
  {$EXTERNALSYM tagTEXTMETRICA}
  tagTEXTMETRICA = record
    tmHeight: Longint;
    tmAscent: Longint;
    tmDescent: Longint;
    tmInternalLeading: Longint;
    tmExternalLeading: Longint;
    tmAveCharWidth: Longint;
    tmMaxCharWidth: Longint;
    tmWeight: Longint;
    tmOverhang: Longint;
    tmDigitizedAspectX: Longint;
    tmDigitizedAspectY: Longint;
    tmFirstChar: AnsiChar;
    tmLastChar: AnsiChar;
    tmDefaultChar: AnsiChar;
    tmBreakChar: AnsiChar;
    tmItalic: Byte;
    tmUnderlined: Byte;
    tmStruckOut: Byte;
    tmPitchAndFamily: Byte;
    tmCharSet: Byte;
  end;
  {$EXTERNALSYM tagTEXTMETRICW}
  tagTEXTMETRICW = record
    tmHeight: Longint;
    tmAscent: Longint;
    tmDescent: Longint;
    tmInternalLeading: Longint;
    tmExternalLeading: Longint;
    tmAveCharWidth: Longint;
    tmMaxCharWidth: Longint;
    tmWeight: Longint;
    tmOverhang: Longint;
    tmDigitizedAspectX: Longint;
    tmDigitizedAspectY: Longint;
    tmFirstChar: WideChar;
    tmLastChar: WideChar;
    tmDefaultChar: WideChar;
    tmBreakChar: WideChar;
    tmItalic: Byte;
    tmUnderlined: Byte;
    tmStruckOut: Byte;
    tmPitchAndFamily: Byte;
    tmCharSet: Byte;
  end;
  {$EXTERNALSYM tagTEXTMETRIC}
  tagTEXTMETRIC = tagTEXTMETRICW;
  TTextMetricA = tagTEXTMETRICA;
  TTextMetricW = tagTEXTMETRICW;
  TTextMetric = TTextMetricW;
  {$EXTERNALSYM TEXTMETRICA}
  TEXTMETRICA = tagTEXTMETRICA;
  {$EXTERNALSYM TEXTMETRICW}
  TEXTMETRICW = tagTEXTMETRICW;

  POutlineTextmetricA = ^TOutlineTextmetricA;
  POutlineTextmetricW = ^TOutlineTextmetricW;
  POutlineTextmetric = POutlineTextmetricW;
  {$EXTERNALSYM _OUTLINETEXTMETRICA}
  _OUTLINETEXTMETRICA = record
  public
    otmSize: LongWord;
    otmTextMetrics: TTextMetricA;
    otmFiller: Byte;
    otmPanoseNumber: TPanose;
    otmfsSelection: LongWord;
    otmfsType: LongWord;
    otmsCharSlopeRise: Integer;
    otmsCharSlopeRun: Integer;
    otmItalicAngle: Integer;
    otmEMSquare: LongWord;
    otmAscent: Integer;
    otmDescent: Integer;
    otmLineGap: LongWord;
    otmsCapEmHeight: LongWord;
    otmsXHeight: LongWord;
    otmrcFontBox: TRect;
    otmMacAscent: Integer;
    otmMacDescent: Integer;
    otmMacLineGap: LongWord;
    otmusMinimumPPEM: LongWord;
    otmptSubscriptSize: TPoint;
    otmptSubscriptOffset: TPoint;
    otmptSuperscriptSize: TPoint;
    otmptSuperscriptOffset: TPoint;
    otmsStrikeoutSize: LongWord;
    otmsStrikeoutPosition: Integer;
    otmsUnderscoreSize: Integer;
    otmsUnderscorePosition: Integer;
    otmpFamilyName: PAnsiChar; // Offset from the beginning of the structure
    otmpFaceName: PAnsiChar;   // Offset from the beginning of the structure
    otmpStyleName: PAnsiChar;  // Offset from the beginning of the structure
    otmpFullName: PAnsiChar;   // Offset from the beginning of the structure
  end;
  {$EXTERNALSYM _OUTLINETEXTMETRICW}
  _OUTLINETEXTMETRICW = record
  public
    otmSize: LongWord;
    otmTextMetrics: TTextMetricW;
    otmFiller: Byte;
    otmPanoseNumber: TPanose;
    otmfsSelection: LongWord;
    otmfsType: LongWord;
    otmsCharSlopeRise: Integer;
    otmsCharSlopeRun: Integer;
    otmItalicAngle: Integer;
    otmEMSquare: LongWord;
    otmAscent: Integer;
    otmDescent: Integer;
    otmLineGap: LongWord;
    otmsCapEmHeight: LongWord;
    otmsXHeight: LongWord;
    otmrcFontBox: TRect;
    otmMacAscent: Integer;
    otmMacDescent: Integer;
    otmMacLineGap: LongWord;
    otmusMinimumPPEM: LongWord;
    otmptSubscriptSize: TPoint;
    otmptSubscriptOffset: TPoint;
    otmptSuperscriptSize: TPoint;
    otmptSuperscriptOffset: TPoint;
    otmsStrikeoutSize: LongWord;
    otmsStrikeoutPosition: Integer;
    otmsUnderscoreSize: Integer;
    otmsUnderscorePosition: Integer;
    otmpFamilyName: PAnsiChar; // Offset from the beginning of the structure
    otmpFaceName: PAnsiChar;   // Offset from the beginning of the structure
    otmpStyleName: PAnsiChar;  // Offset from the beginning of the structure
    otmpFullName: PAnsiChar;   // Offset from the beginning of the structure
  end;
  {$EXTERNALSYM _OUTLINETEXTMETRIC}
  _OUTLINETEXTMETRIC = _OUTLINETEXTMETRICW;
  TOutlineTextmetricA = _OUTLINETEXTMETRICA;
  TOutlineTextmetricW = _OUTLINETEXTMETRICW;
  TOutlineTextmetric = TOutlineTextmetricW;
  {$EXTERNALSYM OUTLINETEXTMETRICA}
  OUTLINETEXTMETRICA = _OUTLINETEXTMETRICA;
  {$EXTERNALSYM OUTLINETEXTMETRICW}
  OUTLINETEXTMETRICW = _OUTLINETEXTMETRICW;
  {$EXTERNALSYM OUTLINETEXTMETRIC}
  OUTLINETEXTMETRIC = OUTLINETEXTMETRICW;

    ChecksumFaultAction = (IgnoreChecksum=0, ThrowException=1, Warn=2);
    TablesID = (CMAP=$70616d63, ControlValueTable=$20747663, DigitalSignature=$47495344, EmbedBitmapLocation=$434c4245, EmbededBitmapData=$54444245, FontHeader=$64616568, FontProgram=$6d677066, Glyph=$66796c67, GlyphDefinition=$46454447, GlyphPosition=$534f5047, GlyphSubstitution=$42555347, GridFittingAndScanConversion=$70736167, HorizontakDeviceMetrix=$786d6468, HorizontalHeader=$61656868, HorizontalMetrix=$78746d68, IndexToLocation=$61636f6c, Justification=$4654534a, KerningTable=$6e72656b, LinearThreshold=$4853544c, MaximumProfile=$7078616d, Name=$656d616e, OS2Table=$322f534f, PCL5Table=$544c4350, Postscript=$74736f70, PreProgram=$70657270, VerticalDeviceMetrix=$584d4456, VerticalMetrix=$78746d76, VertivalMetrixHeader=$61656876);

    TByteArray = Array of Byte;
    TTagList = TList;

    TableDirectory = packed record
        public sfntversion: Cardinal;
        public numTables: Word;
        public searchRange: Word;
        public entrySelector: Word;
        public rangeShift: Word;
    end;

    TrueTypeFont = class(TTF_Helpers)
      // Fields
      strict private FIsLoaded: Boolean;
      strict private beginfile_ptr: Pointer;
      public checksum_action: ChecksumFaultAction;
      strict private cmap_table: CmapTableClass;
      strict private dir: TableDirectory;
      strict private font_header: FontHeaderClass;
      strict private glyph_table: GlyphTableClass;
      strict private gsub_table: GlyphSubstitutionClass;
      strict private horizontal_header: HorizontalHeaderClass;
      strict private horizontal_metrix_table: HorizontalMetrixClass;
      strict private index_to_location: IndexToLocationClass;
      strict private kerning_table: KerningTableClass;
      strict private name_table: NameTableClass;
      strict private postscript: PostScriptClass;
      strict private profile: MaximumProfileClass;
      strict private selector_ptr: Pointer;
      strict private windows_metrix: OS2WindowsMetricsClass;
      strict private preprogram_table: PreProgramClass;

      strict private ListOfTables: TDictionary<TablesID, TrueTypeTable>;
      strict private ListOfUsedGlyphs: TList;


      // Methods
      public constructor Create(bgn: Pointer; font: Pointer; action: ChecksumFaultAction);
      public destructor Destroy; override;
      public procedure AddCharacterToKeepList(ch: Char);
      strict private procedure BuildGlyphIndexList(used_glyphs: TList; uniscribe: boolean; decompose: boolean; collate: boolean; use_kerning: boolean; var Indices: TIntegerList; var GlyphWidths: TIntegerList; ComposedList: TList);
      strict private function CalcTableChecksum(font: Pointer; entry: TrueTypeTable; debug: boolean): Cardinal;
      strict private procedure CalculateFontChecksum(start_offset: Pointer; font_length: Cardinal);
      strict private procedure ChangeEndian;
      strict private procedure CheckTablesChecksum;
  //    public function DrawString(text: string; position: Point; size: Integer): GraphicsPath;
  //    public function GetGlyph(ch: Char; size: Integer; position: Point): GraphicsPath;
      public function GetGlyphIndices(text: string; glyphs: PWord; widths: PInteger; rtl: boolean; ComposedList: TList): Integer;
      public procedure GetOutlineTextMetrics(var FTextMetric: OutlineTextMetric);
      strict private function GetTablesOrder: TTagList;
      strict private procedure LoadCoreTables;
      strict private procedure LoadDescriptors(skip_array: TIntegerList);
      public function PackFont(translate_to: FontType; uniscribe: boolean; sStream: TStream): TByteArray;
      public procedure PrepareFont(skip_list: TIntegerList);
      strict private procedure ReorderGlyphTable(position: Pointer; uniscribe: boolean);
      strict private procedure SaveDescriptors(position: Pointer);
      strict private procedure set_UsedGlyphs(dict: TList);

      // Properties

     public property Names: NameTableClass read name_table;
     public property IsLoaded: Boolean read FIsLoaded;
     public property UsedGlyphs: Tlist write set_UsedGlyphs;
  //    public property TablesList: ICollection read get_TablesList;
  end;

implementation uses System.SysUtils;

    constructor TrueTypeFont.Create(bgn: Pointer; font: Pointer; action: ChecksumFaultAction);
//    var
//      key: Word;
    begin
      FIsLoaded := False;
      self.ListOfTables := TDictionary<TablesID, TrueTypeTable>.Create;
      self.ListOfUsedGlyphs := TList.Create;
      self.beginfile_ptr := {&}bgn;
      self.selector_ptr := font;
      self.checksum_action := action;
//        key := 0;
//        self.ListOfUsedGlyphs.Add(key)
    end;


destructor TrueTypeFont.Destroy;
    var
      t:    TrueTypeTable;
      i: TablesID;
    begin
      for i in ListOfTables.Keys do
      begin
        t := self.ListOfTables.Items[i];
        t.Free;
      end;
      self.ListOfTables.Clear;
      self.ListOfTables.Free;
      self.ListOfUsedGlyphs.Clear;
      self.ListOfUsedGlyphs.Free;
//      self.ListOfUsedWidths.Clear;
//      self.ListOfUsedWidths.Free;


    end;


procedure TrueTypeFont.set_UsedGlyphs(dict: TList);
    var
      i: Integer;
      key: Word;
    begin
      self.ListOfUsedGlyphs.Clear;
//      self.ListOfUsedGlyphs.Add(0);
      for i := 0 to dict.Count - 1 do
      if Integer(Word(dict[i])) = Integer(dict[i]) then
      begin
        key := Word(dict[i]);
        if (self.ListOfUsedGlyphs.IndexOf(Pointer(key)) = -1) then
          self.ListOfUsedGlyphs.Add(Pointer(key))
      end
      else
        raise Exception.Create('Format errir');
    end;

    procedure TrueTypeFont.AddCharacterToKeepList(ch: Char);
    var
      key: Word;
    begin
        key := Word(ch);
        if (self.ListOfUsedGlyphs.IndexOf(Pointer(key)) = -1) then
            self.ListOfUsedGlyphs.Add(Pointer(key))
    end;

    procedure TrueTypeFont.BuildGlyphIndexList(used_glyphs: TList; uniscribe: boolean; decompose: boolean; collate: boolean; use_kerning: boolean; var Indices: TIntegerlist; var GlyphWidths: TIntegerList; ComposedList: TList);
    var
        location: Cardinal;
        composed_idx: Word;
        i, j, length, GlyphWidth: Integer;
        key, idx, next_idx: Word;
        hash_index: Cardinal;
        composed_indexes: TIntegerlist;
        new_key, kerning: Smallint;
    begin
        composed_indexes := nil;
        i := 0;
        while ((i < used_glyphs.Count)) do
        begin
            key := Word(used_glyphs[i]);
            if uniscribe then idx := key else idx := self.cmap_table.GetGlyphIndex(key);
//            if (collate) then self.ListOfUsedGlyphs[key] := idx;
            length := self.index_to_location.GetGlyph(idx, self.font_header, location);
            if (length <> 0) then
            begin
              GlyphWidth := 0;
              composed_idx := $FFFF;

              if (not collate or (Indices.IndexOf(Pointer(idx)) = -1)) then
              begin
                //if composed_idx = $FFFF then
                  Indices.Add( Pointer(idx));
                //GlyphWidth := ((self.horizontal_metrix_table.Item[idx].advanceWidth * $3e8) div self.font_header.unitsPerEm);
                //if idx < self.horizontal_metrix_table.NumberOfMetrics then
                    GlyphWidth := ((self.horizontal_metrix_table.Item[idx].advanceWidth * $3e8) div self.font_header.unitsPerEm);
                //  else
                //    GlyphWidth := (self.windows_metrix.AvgCharWidth * $3e8) div self.font_header.unitsPerEm;

                GlyphWidths.Add(Pointer(GlyphWidth));
              end;

              composed_indexes := self.glyph_table.CheckGlyph(Cardinal(location), length);
              for j := 0 to composed_indexes.Count - 1 do
              begin
                composed_idx := Word(composed_indexes[j]);
                new_key := Indices.IndexOf(Pointer(composed_idx));
                if (not collate or (decompose and (new_key = -1))) then
                begin
                  if ComposedList <> nil then
                  begin
                    if ComposedList.IndexOf(Pointer(composed_idx)) = -1 then
                      ComposedList.Add(Pointer(composed_idx))
                  end
                  else
                    Indices.Add( Pointer(composed_idx));
                  //GlyphWidth := ((self.horizontal_metrix_table.Item[composed_idx].advanceWidth * $3e8) div self.font_header.unitsPerEm);
//                if (use_kerning and ((i < (used_glyphs.Count - 1)) and (self.kerning_table <> nil))) then
//                begin
//                  new_key := Word(used_glyphs[i + 1]);
//                  if uniscribe then next_idx := new_key else next_idx :=  self.cmap_table.GetGlyphIndex(new_key);
//                  hash_index := Cardinal(composed_idx or (next_idx shl $10));
//                  kerning := self.kerning_table.Item[hash_index];
//                  inc(GlyphWidth, ((kerning * $3e8) div self.font_header.unitsPerEm))
//                end;
                //GlyphWidths.Add(Pointer(GlyphWidth))
                end;
              end;
              if Assigned(composed_indexes) then
                FreeandNil(composed_indexes);

            end
            else
            begin
              new_key := Indices.IndexOf(Pointer(idx));
              if (((key = $20) or (key = $A0)) and (not collate or (new_key = -1))) then
              begin
                Indices.Add(Pointer(idx));
                j := (self.windows_metrix.AvgCharWidth * $3e8) div self.font_header.unitsPerEm;

                if (use_kerning and (i < (used_glyphs.Count - 1))) then
                begin
                  new_key := Word(used_glyphs[i + 1]);
                  if uniscribe then next_idx := new_key else next_idx :=  self.cmap_table.GetGlyphIndex(new_key);
                  hash_index := Cardinal(idx or (next_idx shl 16));
                  kerning := 0;
                  if (self.kerning_table <> nil) then
                    kerning := self.kerning_table.Item[hash_index];
                  if kerning = 0 then
                    kerning := self.horizontal_metrix_table.Item[next_idx].lsb;

                  Dec(j, ((kerning * $3e8) div self.font_header.unitsPerEm))
                end;

                GlyphWidths.Add(Pointer(j))
              end;


            end;
            inc(i)
        end;
        //FreeandNil(used_glyphs);
    end;

    function TrueTypeFont.CalcTableChecksum(font: Pointer; entry: TrueTypeTable; debug: boolean): Cardinal;
    var
      Sum, Length, i: Cardinal;
      Temp: ^Cardinal;
      test: LongWord;
    begin
      Sum := 0;
      test := 0;
      Length := entry.length div 4;
      Temp := TTF_Helpers.Increment(font, entry.offset );
      i := 0;
      while ((i < Length)) do
      begin
          inc( Sum, TTF_Helpers.SwapUInt32( Temp^ ));
//          if debug then WriteLn( 'Idx ', i, ' Value ', Integer(Temp^), ' Sum ', IntToHex( Sum, 8));
          Inc( Temp, 1 );
          Inc(i, 1)
      end;

      if entry.length mod 4 <> 0 then
      begin
        i := i*4;
        if i + 1 = entry.length then Test:= $ff000000;
        if i + 2 = entry.length then Test:= $ffff0000;
        if i + 3 = entry.length then Test:= $ffffff00;
        inc( Sum, (Test and TTF_Helpers.SwapUInt32( Temp^ )) );
      end;
      Length := (entry.length + 3) div 4;
      Result := Sum;
    end;

    procedure TrueTypeFont.CalculateFontChecksum(start_offset: Pointer; font_length: Cardinal);
    var
      Sum, Length, i: Cardinal;
      Temp: ^Cardinal;
    begin
        Sum := 0;
        length := font_length div 4;
        Temp := start_offset;
        i := 0;
        while ((i < length)) do
        begin
            Inc(Sum, TTF_Helpers.SwapUInt32( Temp^ ));
//            WriteLn( 'Font checksum[', i, '] is  ', IntToHex( Sum, 8));
            Inc( Temp );
            Inc(i, 1)
        end;
        Sum := ($b1b0afba - Sum);
        self.font_header.SaveFontHeader(self.beginfile_ptr, Sum)
    end;

    procedure TrueTypeFont.ChangeEndian;
    begin
        self.dir.sfntversion := TTF_Helpers.SwapUInt32(self.dir.sfntversion);
        self.dir.numTables := TTF_Helpers.SwapUInt16(self.dir.numTables);
        self.dir.searchRange := TTF_Helpers.SwapUInt16(self.dir.searchRange);
        self.dir.entrySelector := TTF_Helpers.SwapUInt16(self.dir.entrySelector);
        self.dir.rangeShift := TTF_Helpers.SwapUInt16(self.dir.rangeShift)
    end;

    procedure TrueTypeFont.CheckTablesChecksum;
    var
      entry: TrueTypeTable;
      checksum: Cardinal;
    begin
      if (self.checksum_action <> ChecksumFaultAction.IgnoreChecksum) then
        for entry in self.ListOfTables.Values do try
          checksum := self.CalcTableChecksum(self.beginfile_ptr, entry, false);
          if ( checksum <> entry.checkSum) then
            raise Exception.Create( String('Table ID "' + entry.TAGLINE + '" checksum error.' + IntToStr(checksum) + ' ' + IntToStr(entry.checkSum)))
          except
            on ex: Exception do
            begin
                if (self.checksum_action = ChecksumFaultAction.ThrowException) then
                    raise ex;
                //if (Windows.MessageBox(GetDesktopWindow, PChar(ex.Message), PChar('Font table checksum error'), MB_YESNO) = 0) then
                //    raise ex
            end
          end
    end;

{$IFDEF DRAWING_MANUALLY}
    function TrueTypeFont.DrawString(text: string; position: Point; size: Integer): GraphicsPath;
    var
        ch: Char;
        location: Cardinal;
        gheader: GlyphHeader;
        glyph_path: GraphicsPath;
        composed_idx: Word;
    begin
        path := GraphicsPath.Create(FillMode.Winding);
        rsize := ((self.font_header.unitsPerEm as Single) div (size as Single));
        uniscribe := false;

        for ch in text do
        begin
            glyph_width := 0;
            gheader.xMin := 0;
            gheader.xMax := 10;
            idx :=  /*pseudo*/ (if uniscribe then ch else self.cmap_table.GetGlyphIndex(ch));
            glyph_size := self.index_to_location.GetGlyph(idx, self.font_header, @(location));
            if (glyph_size <> 0) then
            begin
                composed_indexes := self.glyph_table.CheckGlyph((location as Integer), glyph_size);
                if (composed_indexes.Count <> 0) then

                    for composed_idx in composed_indexes do
                    begin
                        glyph_size := self.index_to_location.GetGlyph(composed_idx, self.font_header, @(location));
                        glyph_path := self.glyph_table.GetGlyph((location as Integer), glyph_size, rsize, position, @(gheader));
                        path.AddPath(glyph_path, false)
                    end
                else
                begin
                    glyph_path := self.glyph_table.GetGlyph((location as Integer), glyph_size, rsize, position, @(gheader));
                    path.AddPath(glyph_path, false)
                end
            end;
            glyph_width := (((gheader.xMax as Single) div rsize) as Integer);
            inc(glyph_width, 4);
            inc(position.X, glyph_width)
        end;
        begin
            Result := path;
            exit
        end
    end;

    function TrueTypeFont.GetGlyph(ch: Char; size: Integer; position: Point): GraphicsPath;
    var
        gheader: GlyphHeader;
        location: Cardinal;
    begin
        i2l_idx := self.cmap_table.GetGlyphIndex(ch);
        length := self.index_to_location.GetGlyph(i2l_idx, self.font_header, @(location));
        rsize := ((self.font_header.unitsPerEm as Single) div (size as Single));
        Result := self.glyph_table.GetGlyph((location as Integer), length, rsize, position, @(gheader))
    end;
{$ENDIF}
    function TrueTypeFont.GetGlyphIndices(text: string; glyphs: PWord; widths: PInteger; rtl: boolean; ComposedList: TList): Integer;
    var
        text_widths, text_as_array, IndexList: TIntegerList;
        ch: Char;
        I: Integer;
    begin
         IndexList := TIntegerList.Create;
        text_widths := TIntegerList.Create;
        text_as_array := TIntegerList.Create;

        for ch in text do
        begin
            text_as_array.Add(PWord(ch))
        end;
        self.BuildGlyphIndexList(text_as_array, false, false, false, false, IndexList, text_widths, ComposedList);
        //glyphs := GetMemory(sizeof(Word) * IndexList.Count);
        for I := 0 to IndexList.Count - 1 do
        begin
          glyphs^ := Word(IndexList[I]);
          Inc(glyphs);
        end;
       // widths := GetMemory(sizeof(Integer) * text_widths.Count);
        for I := 0 to text_widths.Count - 1 do
        begin
          widths^ := Integer(text_widths[I]);
          Inc(widths);
        end;
        //widths := (text_widths.ToArray(typeof(Integer)) as Integer[]);
        //text_as_array.Free;

        //begin
        Result := IndexList.Count;
        FreeandNil(IndexList);
        FreeandNil(text_widths);
        text_as_array.Free;
        //    exit
       // end
    end;


    procedure TrueTypeFont.GetOutlineTextMetrics(var FTextMetric: OutlineTextMetric);
    begin
        FTextMetric.otmSize := $d4;
        FTextMetric.otmTextMetrics.tmHeight := (self.windows_metrix.Ascent + self.windows_metrix.Descent);
        FTextMetric.otmTextMetrics.tmAscent := self.windows_metrix.Ascent;
        FTextMetric.otmTextMetrics.tmDescent := self.windows_metrix.Descent;
        FTextMetric.otmTextMetrics.tmAveCharWidth := self.windows_metrix.AvgCharWidth;
        FTextMetric.otmTextMetrics.tmMaxCharWidth := self.horizontal_header.MaxWidth;
        FTextMetric.otmTextMetrics.tmFirstChar := WideChar(self.windows_metrix.FirstCharIndex);
        FTextMetric.otmTextMetrics.tmLastChar := WideChar(self.windows_metrix.LastCharIndex);
        FTextMetric.otmTextMetrics.tmDefaultChar := WideChar(self.windows_metrix.DefaultChar);
        FTextMetric.otmTextMetrics.tmBreakChar := WideChar(self.windows_metrix.BreakChar);
        FTextMetric.otmPanoseNumber.bFamilyType := self.windows_metrix.Panose[0];
        FTextMetric.otmPanoseNumber.bSerifStyle := self.windows_metrix.Panose[1];
        FTextMetric.otmPanoseNumber.bWeight := self.windows_metrix.Panose[2];
        FTextMetric.otmPanoseNumber.bProportion := self.windows_metrix.Panose[3];
        FTextMetric.otmPanoseNumber.bContrast := self.windows_metrix.Panose[4];
        FTextMetric.otmPanoseNumber.bStrokeVariation := self.windows_metrix.Panose[5];
//        FTextMetric.otmPanoseNumber.ArmStyle := self.windows_metrix.Panose[6];
        FTextMetric.otmPanoseNumber.bLetterform := self.windows_metrix.Panose[7];
        FTextMetric.otmPanoseNumber.bMidline := self.windows_metrix.Panose[8];
        FTextMetric.otmPanoseNumber.bXHeight := self.windows_metrix.Panose[9];
        FTextMetric.otmItalicAngle := ((self.postscript.ItalicAngle shr $10) * 10);
        FTextMetric.otmEMSquare := self.font_header.unitsPerEm;
        FTextMetric.otmAscent := self.horizontal_header.Ascender;
        FTextMetric.otmDescent := self.horizontal_header.Descender;
        if self.horizontal_header.LineGap > 0 then
          FTextMetric.otmLineGap := Cardinal(self.horizontal_header.LineGap)
        else
          FTextMetric.otmLineGap := 0;
        FTextMetric.otmpFamilyName := PAnsiChar(AnsiString(self.name_table.Item[NameID.FamilyName]));
        FTextMetric.otmpFullName := PAnsiChar(AnsiString(self.name_table.Item[NameID.FullName]))
    end;


    function TrueTypeFont.GetTablesOrder: TTagList;
    var
      entry: TrueTypeTable;
      offset: Cardinal;
      indexed_tags: TList; //<TablesID>;
      tables_positions: TList<Cardinal>;
      TablesOrder: TDictionary<Cardinal,Cardinal>;
      tag: Cardinal;
      i: Integer;
    begin
      TablesOrder := TDictionary<Cardinal,Cardinal>.Create;

      for entry in self.ListOfTables.Values do
      begin
        TablesOrder.Add(entry.offset, entry.tag)
      end;

      tables_positions := TList<Cardinal>.Create(TablesOrder.Keys);
      tables_positions.Sort;
      indexed_tags := TList.Create;

      for i := 0 to tables_positions.Count - 1 do
      begin
        offset := Cardinal(tables_positions[i]);
        tag := Cardinal(TablesOrder.Items[offset]);
        indexed_tags.Add(Pointer(tag))
      end;
      tables_positions.Clear;
      TablesOrder.Clear;
      begin
          Result := indexed_tags;
      end;
      TablesOrder.Free;
      tables_positions.Free;
    end;

    procedure TrueTypeFont.LoadCoreTables;
    begin
        if (not self.ListOfTables.ContainsKey(TablesID.FontHeader)) then
            raise Exception.Create('FontHeader not found.');
        self.font_header := (self.ListOfTables.Items[TablesID.FontHeader] as FontHeaderClass);
        self.font_header.Load(self.beginfile_ptr);

        if (not self.ListOfTables.ContainsKey(TablesID.MaximumProfile)) then
            raise Exception.Create('MaximuProfile not found.');
        self.profile := (self.ListOfTables.Items[TablesID.MaximumProfile] as MaximumProfileClass);
        self.profile.Load(self.beginfile_ptr);

        if (not self.ListOfTables.ContainsKey(TablesID.HorizontalHeader)) then
            raise Exception.Create('HorizontalHeader not found.');
        self.horizontal_header := (self.ListOfTables.Items[TablesID.HorizontalHeader] as HorizontalHeaderClass);
        self.horizontal_header.Load(self.beginfile_ptr);

        if (self.ListOfTables.ContainsKey(TablesID.Postscript)) then
        begin
            self.postscript := (self.ListOfTables.Items[TablesID.Postscript] as PostScriptClass);
            self.postscript.Load(self.beginfile_ptr)
        end;

        if (not self.ListOfTables.ContainsKey(TablesID.OS2Table)) then
            raise Exception.Create('OS2WindowsMetrics table not found.');
        self.windows_metrix := (self.ListOfTables.Items[TablesID.OS2Table] as OS2WindowsMetricsClass);
        self.windows_metrix.Load(self.beginfile_ptr);

        if (not self.ListOfTables.ContainsKey(TablesID.IndexToLocation)) then
            raise Exception.Create('IndexToLocation not found.');
        self.index_to_location := (self.ListOfTables.Items[TablesID.IndexToLocation] as IndexToLocationClass);
        self.index_to_location.LoadIndexToLocation(self.beginfile_ptr, self.font_header);

        if (not self.ListOfTables.ContainsKey(TablesID.CMAP)) then
            raise Exception.Create('CMAP not found.');
        self.cmap_table := (self.ListOfTables.Items[TablesID.CMAP] as CmapTableClass);
        self.cmap_table.LoadCmapTable(self.beginfile_ptr);

        if (not self.ListOfTables.ContainsKey(TablesID.Name)) then
            raise Exception.Create('Name not found.');
        self.name_table := (self.ListOfTables.Items[TablesID.Name] as NameTableClass);
        self.name_table.Load(self.beginfile_ptr);

        if (not self.ListOfTables.ContainsKey(TablesID.Glyph)) then
            raise Exception.Create('Glyphs not found.');
        self.glyph_table := (self.ListOfTables.Items[TablesID.Glyph] as GlyphTableClass);
        self.glyph_table.Load(self.beginfile_ptr);

        if (self.ListOfTables.ContainsKey(TablesID.KerningTable)) then
        begin
          self.kerning_table := (self.ListOfTables.Items[TablesID.KerningTable] as KerningTableClass);
          self.kerning_table.Load(self.beginfile_ptr)
        end;

        if (self.ListOfTables.ContainsKey(TablesID.GlyphSubstitution)) then
        begin
          self.gsub_table := (self.ListOfTables.Items[TablesID.GlyphSubstitution] as GlyphSubstitutionClass);
          self.gsub_table.Load(self.beginfile_ptr)
        end;

        if (self.ListOfTables.ContainsKey(TablesID.PreProgram)) then
        begin
          self.preprogram_table := self.ListOfTables.Items[TablesID.PreProgram] as PreProgramClass;
          self.preprogram_table.Load(self.beginfile_ptr);
        end;

        if (self.ListOfTables.ContainsKey(TablesID.HorizontalMetrix)) then
        begin
            self.horizontal_metrix_table := (self.ListOfTables.Items[TablesID.HorizontalMetrix] as HorizontalMetrixClass);
            self.horizontal_metrix_table.NumberOfMetrics := self.horizontal_header.NumberOfHMetrics;
            self.horizontal_metrix_table.Load(self.beginfile_ptr)
        end
    end;

    procedure TrueTypeFont.LoadDescriptors(skip_array: TIntegerList);
    var
        parsed_table: TrueTypeTable;
        table: TrueTypeTable;
        i: Integer;
//        tbls: Pointer;
        tdir_ptr: ^TableDirectory;
        entry_ptr: ^TableEntry;
    begin
        tdir_ptr := self.selector_ptr;
        self.dir.sfntversion := tdir_ptr.sfntversion;
        self.dir.numTables := tdir_ptr.numTables;
        self.dir.searchRange := tdir_ptr.searchRange;
        self.dir.entrySelector := tdir_ptr.entrySelector;
        self.dir.rangeShift := tdir_ptr.rangeShift;
        self.ChangeEndian;
        entry_ptr := TTF_Helpers.Increment(self.selector_ptr, SizeOf(TableDirectory));
        i := 0;
        while ((i < self.dir.numTables)) do
        begin
            table := TrueTypeTable.Create(entry_ptr);
            if (skip_array.IndexOf( Pointer(table.tag)) = -1) then
            begin
                case ( TablesID(table.tag) ) of
                    TablesID.HorizontalHeader:
                        begin parsed_table := HorizontalHeaderClass.Create(table);
                        table.Free;
                        end;
                    TablesID.FontHeader:
                        begin parsed_table := FontHeaderClass.Create(table);
                        table.Free;
                        end;
                    TablesID.Name:
                        begin parsed_table := NameTableClass.Create(table);
                        table.Free;
                        end;
                    TablesID.OS2Table:
                        begin parsed_table := OS2WindowsMetricsClass.Create(table);
                        table.Free;
                        end;
                    TablesID.GlyphSubstitution:
                        begin parsed_table := GlyphSubstitutionClass.Create(table);
                        table.Free;
                        end;
                    TablesID.IndexToLocation:
                        begin parsed_table := IndexToLocationClass.Create(table);
                        table.Free;
                        end;
                    TablesID.Glyph:
                        begin parsed_table := GlyphTableClass.Create(table);
                        table.Free;
                        end;
                    TablesID.KerningTable:
                        begin parsed_table := KerningTableClass.Create(table);
                        table.Free;
                        end;
                    TablesID.CMAP:
                        begin parsed_table := CmapTableClass.Create(table);
                        table.Free;
                        end;
                    TablesID.Postscript:
                        begin parsed_table := PostScriptClass.Create(table);
                        table.Free;
                        end;
                    TablesID.HorizontalMetrix:
                        begin parsed_table := HorizontalMetrixClass.Create(table);
                        table.Free;
                        end;
                    TablesID.PreProgram:
                        begin parsed_table := PreProgramClass.Create(table);
                        table.Free;
                        end;
                    TablesID.MaximumProfile:
                        begin parsed_table := MaximumProfileClass.Create(table);
                        table.Free;
                        end;
                    else
                        begin parsed_table := table; end;
                  end;

                try
                  self.ListOfTables.Add( TablesID(table.tag), parsed_table)
                except
                    //on ex: Exception do
                    //  Windows.MessageBox(0, PChar(ex.Message), PChar('Font format error'), MB_YesNo)
                end
            end
            else
              table.Free;
//            else Writeln('Skip table ', table.TAGLINE );
            entry_ptr := TTF_Helpers.Increment(entry_ptr, SizeOf(TableEntry));
            inc(i)
        end;
        self.dir.numTables := self.ListOfTables.Count
    end;

    procedure TrueTypeFont.SaveDescriptors(position: Pointer);
    var
        i: Integer;
        tag: TablesID;
        td_ptr: ^TableDirectory;
        descriptor_list: TList<TablesID>;
        tbls: Pointer;
    begin
        td_ptr := position;
        td_ptr.sfntversion := TTF_Helpers.SwapUInt32(self.dir.sfntversion);
        td_ptr.numTables := TTF_Helpers.SwapUInt16(self.dir.numTables);
        td_ptr.searchRange := TTF_Helpers.SwapUInt16(self.dir.searchRange);
        td_ptr.entrySelector := TTF_Helpers.SwapUInt16(self.dir.entrySelector);
        td_ptr.rangeShift := TTF_Helpers.SwapUInt16(self.dir.rangeShift);

        tbls := TTF_Helpers.Increment(position, SizeOf(TableDirectory));
        descriptor_list := TList<TablesID>.Create(self.ListOfTables.Keys);
        i := 0;
        while ((i < descriptor_list.Count)) do
        begin
            descriptor_list.Items[i] := TablesID(TTF_Helpers.SwapUInt32( Cardinal(descriptor_list.Items[i])));
            inc(i)
        end;
        descriptor_list.Sort;
        i := 0;
        while ((i < descriptor_list.Count)) do
        begin
            descriptor_list.Items[i] := TablesID(TTF_Helpers.SwapUInt32( Cardinal(descriptor_list.Items[i])));
            inc(i)
        end;

        for tag in descriptor_list do
        begin
            tbls := TrueTypeTable(self.ListOfTables.Items[tag]).StoreDescriptor(tbls);
            {
            Writeln(
              'Indexed tag ', TrueTypeTable(self.ListOfTables.Items[tag]).TAGLINE,
              ' Checksum ', IntToHex(TrueTypeTable(self.ListOfTables.Items[tag]).checkSum, 8),
              ' Size ', TrueTypeTable(self.ListOfTables.Items[tag]).length );
            }
        end;
        descriptor_list.Free;
        descriptor_list := nil
    end;

    function TrueTypeFont.PackFont(translate_to: FontType; uniscribe: boolean; sStream: TStream): TByteArray;
    var
      tag: TablesID;
      indexed_tags: TTagList;
      current_offset: Cardinal;
      buff: TByteArray;
      table_ptr:  TrueTypeTable;
      i: Integer;
      ptr: ^Byte;
    begin
        indexed_tags := self.GetTablesOrder;
        self.ReorderGlyphTable(self.beginfile_ptr, uniscribe);
        current_offset := Cardinal( 12 {SizeOf(FontHeaderClass.FontHeader)} + (self.dir.numTables * $10));
        for i := 0 to indexed_tags.Count - 1 do
        begin
          tag := TablesID(indexed_tags[i]);
          table_ptr := self.ListOfTables.Items[tag];
          current_offset := table_ptr.Save(self.beginfile_ptr, current_offset);
          if ((current_offset mod 4) <> 0) then
             raise Exception.Create('Align error');
        end;
        self.SaveDescriptors(self.beginfile_ptr);
        self.CalculateFontChecksum(self.beginfile_ptr, current_offset);
        SetLength( buff, current_offset );
        ptr := self.beginfile_ptr;
        for i:=0 to current_offset - 1 do
        begin
          buff[i] := ptr^;
          Inc(Ptr);
        end;
        Result := buff;
        indexed_tags.Free;
    end;

    procedure TrueTypeFont.PrepareFont(skip_list: TIntegerList);
    begin
        self.LoadDescriptors(skip_list);
        self.LoadCoreTables;
        self.CheckTablesChecksum;
        FIsLoaded := True;
    end;

    function ThisSort(Item1, Item2: Pointer): Integer;
    begin
       if ( NativeInt(Item1) < NativeInt(Item2) ) then Result := -1
       else if (NativeInt(Item1) > NativeInt(Item2) )
       then Result := 1  else Result := 0;
    end;

    procedure TrueTypeFont.ReorderGlyphTable(position: Pointer; uniscribe: boolean);
    var

        //used_glyphs: TList<Word>;
        i,j: Cardinal;
        idx: Word;
        i2l_idx: Word;
        length: Word;
        glyph_table_size, location: Cardinal;
        LongIndexToLocation: TCardinalArray;
        ShortIndexToLocation: FMX.frxIndexToLocationClass.TWordArray;
        table_entry:  TrueTypeTable;
        out_index : Cardinal;
        sqz_index : Integer;
        glyph_table_ptr: ^Byte;
        glyph_ptr: ^Byte;
        SelectedGlyphs: Array of Byte;
        i2ll_ptr: ^Cardinal;
        i2ls_ptr: ^Smallint;
        out_ms: TMemoryStream;
        composite_indexes: TIntegerList;
        glyph_widths: TIntegerList;
    begin
        ShortIndexToLocation := self.index_to_location.Short;
        LongIndexToLocation := self.index_to_location.Long;
        self.ListOfUsedGlyphs.Sort(ThisSort);
        self.ListOfUsedGlyphs.Add(nil);
        composite_indexes := TIntegerList.Create;
        glyph_widths := TIntegerList.Create;
        self.BuildGlyphIndexList(self.ListOfUsedGlyphs, uniscribe, true, true, false, composite_indexes, glyph_widths, nil);
        composite_indexes.Sort(ThisSort);
        glyph_table_size := 0;
        length := 0;
        location := 0;

        for i := 0 to composite_indexes.Count - 1 do
        begin
            idx := Integer(composite_indexes[i]);
            inc(glyph_table_size, self.index_to_location.GetGlyph(idx, self.font_header, location))
        end;

        table_entry := self.ListOfTables.Items[TablesID.Glyph];
        glyph_table_ptr := TTF_Helpers.Increment(self.beginfile_ptr, (table_entry.offset));
        SetLength( SelectedGlyphs, glyph_table_size);
        out_index := 0;
        sqz_index := 0;

        for i := 0 to composite_indexes.Count - 1 do
        begin
          i2l_idx := Integer(composite_indexes[i]);
          length := self.index_to_location.GetGlyph(i2l_idx, self.font_header, location);
          case self.font_header.indexToLocFormat of
            IndexToLoc.ShortType:
                while ((sqz_index <= i2l_idx)) do
                begin
                  ShortIndexToLocation[sqz_index] := Word((out_index div 2));
                  inc(sqz_index);
                end;
            IndexToLoc.LongType:
                while ((sqz_index <= i2l_idx)) do
                begin
                  LongIndexToLocation[sqz_index] := out_index;
                  inc(sqz_index);
                end
            else raise Exception.Create('Unknown IndexToLoc value')
          end;
          if length <> 0 then
          begin
            glyph_ptr := TTF_Helpers.Increment(glyph_table_ptr, location);
            for j:= 0 to length-1 do
            begin
              SelectedGlyphs[out_index + j] := glyph_ptr^;
              Inc(glyph_ptr);
            end;
            Inc(out_index, length);
          end;
        end;

        glyph_table_ptr := TTF_Helpers.Increment(self.beginfile_ptr, (table_entry.offset));
        for i:= 0 to out_index do
        begin
          glyph_table_ptr^ := SelectedGlyphs[i];
          Inc(glyph_table_ptr);
        end;
        table_entry.length := out_index;

{   // Just debug
        /////////////////////////////////////////////
        begin
          glyph_table_ptr := TTF_Helpers.Increment(self.beginfile_ptr, (table_entry.offset));
          out_ms := TMemoryStream.Create;
          with out_ms do begin
            SetSize(out_index);
            CopyMemory(out_ms.Memory, glyph_table_ptr, out_index);
          end;

          out_ms.SaveToFile('packed_glyf.bin');
          out_ms.Clear;
          out_ms.Free;

        end;
        /////////////////////////////////////////////
}

        SelectedGlyphs := nil;
        table_entry := (self.ListOfTables.Items[TablesID.IndexToLocation] as TrueTypeTable);
        i := 0;
        case self.font_header.indexToLocFormat of
          IndexToLoc.ShortType:
          begin
            i2ls_ptr := TTF_Helpers.Increment(self.beginfile_ptr, table_entry.offset);
            while (sqz_index < High(ShortIndexToLocation)) do
            begin
              ShortIndexToLocation[sqz_index] := Word((out_index div 2));
              inc(sqz_index)
            end;
            while (i < Cardinal(High(ShortIndexToLocation))) do
            begin
              i2ls_ptr^ :=  Smallint(TTF_Helpers.SwapUInt16(ShortIndexToLocation[i]));
              Inc(i2ls_ptr);
              inc(i)
            end;
          end;

          IndexToLoc.LongType:
          begin
            i2ll_ptr := TTF_Helpers.Increment(self.beginfile_ptr, table_entry.offset);
            while (sqz_index <= High(LongIndexToLocation)) do
            begin
                LongIndexToLocation[sqz_index] := out_index;
                inc(sqz_index)
            end;
            while (i <= Cardinal(High(LongIndexToLocation))) do
            begin
              i2ll_ptr^ := Cardinal(TTF_Helpers.SwapUInt32(LongIndexToLocation[i]));
              Inc(i2ll_ptr);
              inc(i)
            end;
          end;
        end;
        table_entry.checkSum := self.CalcTableChecksum(self.beginfile_ptr, table_entry, false);
        table_entry := (self.ListOfTables.Items[TablesID.Glyph] as TrueTypeTable);
        table_entry.checkSum := self.CalcTableChecksum(self.beginfile_ptr, table_entry, true );
        if glyph_widths <> nil then
        begin
          glyph_widths.Clear;
          glyph_widths.Free;
        end;
      if composite_indexes <> nil then
        begin
          composite_indexes.Clear;
          composite_indexes.Free;
        end;
    end;
{$hints on}
end.


