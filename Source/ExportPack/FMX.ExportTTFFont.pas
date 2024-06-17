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

unit FMX.ExportTTFFont;

strict private ExportTTFFont = class (IDisposable)
    // Methods
    public constructor Create(font: Font); 
    [DllImport('Gdi32.dll')]
    strict private class extern function DeleteObject(hgdiobj: IntPtr): IntPtr; static; 
    public procedure Dispose; 
    public procedure FillOutlineTextMetrix; 
    public function GetEnglishFontName: string; 
    public function GetFontData: Byte[]; 
    [DllImport('Gdi32.dll', CharSet=CharSet.Auto)]
    strict private class extern function GetFontData(hdc: IntPtr; dwTable: Cardinal; dwOffset: Cardinal; [In, Out] lpvBuffer: Byte[]; cbData: Cardinal): Cardinal; static; 
    [DllImport('Gdi32.dll', CharSet=CharSet.Auto)]
    strict private class extern function GetFontData(hdc: IntPtr; dwTable: Cardinal; dwOffset: Cardinal; [In, Out] lpvBuffer: IntPtr; cbData: Cardinal): Cardinal; static; 
    [DllImport('Gdi32.dll', CharSet=CharSet.Auto)]
    strict private class extern function GetGlyphIndices(hdc: IntPtr; lpstr: string; c: Integer; [In, Out] pgi: Word[]; fl: Cardinal): Cardinal; static; 
    strict private function GetGlyphIndices(hdc: IntPtr; text: string; glyphs: Word[]; widths: Integer[]; rtl: boolean): Integer; 
    strict private function GetGlyphs(hdc: IntPtr; run: Run; glyphs: Word[]; widths: Integer[]; maxGlyphs: Integer; rtl: boolean): Integer; 
    public function GetGlyphWidth(c: Char): Integer; 
    [DllImport('Gdi32.dll')]
    strict private class extern function GetOutlineTextMetrics(hdc: IntPtr; cbData: Integer; var lpOTM: OutlineTextMetric): Integer; static; 
    public function GetPANOSE: string; 
    strict private function Itemize(s: string; rtl: boolean; maxItems: Integer): List<Run>; 
    strict private function Layout(runs: List<Run>; rtl: boolean): List<Run>; 
    public function RemapString(str: string; rtl: boolean): string; 
    [DllImport('usp10.dll')]
    strict private class extern function ScriptApplyDigitSubstitution(var psds: SCRIPT_DIGITSUBSTITUTE; var psc: SCRIPT_CONTROL; var pss: SCRIPT_STATE): Integer; static; 
    [DllImport('usp10.dll')]
    strict private class extern function ScriptFreeCache(var psc: IntPtr): Integer; static; 
    [DllImport('usp10.dll')]
    strict private class extern function ScriptItemize([MarshalAs(UnmanagedType.LPWStr)] pwcInChars: string; cInChars: Integer; cMaxItems: Integer; var psControl: SCRIPT_CONTROL; var psState: SCRIPT_STATE; [In, Out] pItems: SCRIPT_ITEM[]; var pcItems: Integer): Integer; static; 
    [DllImport('usp10.dll')]
    strict private class extern function ScriptLayout(cRuns: Integer; [MarshalAs(UnmanagedType.LPArray)] pbLevel: Byte[]; [MarshalAs(UnmanagedType.LPArray)] piVisualToLogical: Integer[]; [MarshalAs(UnmanagedType.LPArray)] piLogicalToVisual: Integer[]): Integer; static; 
    [DllImport('usp10.dll')]
    strict private class extern function ScriptPlace(hdc: IntPtr; var psc: IntPtr; [MarshalAs(UnmanagedType.LPArray)] pwGlyphs: Word[]; cGlyphs: Integer; [MarshalAs(UnmanagedType.LPArray)] psva: SCRIPT_VISATTR[]; var psa: SCRIPT_ANALYSIS; [MarshalAs(UnmanagedType.LPArray)] piAdvance: Integer[]; [Out, MarshalAs(UnmanagedType.LPArray)] pGoffset: GOFFSET[]; var pABC: ABC): Integer; static; 
    [DllImport('usp10.dll')]
    strict private class extern function ScriptRecordDigitSubstitution(lcid: Cardinal; var psds: SCRIPT_DIGITSUBSTITUTE): Cardinal; static; 
    [DllImport('usp10.dll')]
    strict private class extern function ScriptShape(hdc: IntPtr; var psc: IntPtr; [MarshalAs(UnmanagedType.LPWStr)] pwcChars: string; cChars: Integer; cMaxGlyphs: Integer; var psa: SCRIPT_ANALYSIS; [Out, MarshalAs(UnmanagedType.LPArray)] pwOutGlyphs: Word[]; [Out, MarshalAs(UnmanagedType.LPArray)] pwLogClust: Word[]; [Out, MarshalAs(UnmanagedType.LPArray)] psva: SCRIPT_VISATTR[]; var pcGlyphs: Integer): Integer; static; 
    [DllImport('Gdi32.dll')]
    strict private class extern function SelectObject(hdc: IntPtr; hgdiobj: IntPtr): IntPtr; static; 

    // Properties
    public property Name: string read get_Name write set_Name;
    public property Reference: Int64 read get_Reference write set_Reference;
    public property Saved: boolean read get_Saved write set_Saved;
    public property SourceFont: Font read get_SourceFont;
    public property TextMetric: OutlineTextMetric read get_TextMetric;
    public property UsedAlphabetUnicode: List<Word> read get_UsedAlphabetUnicode;
    public property UsedGlyphIndexes: List<Word> read get_UsedGlyphIndexes;
    public property Widths: List<Integer> read get_Widths;

    // Fields
    strict private FDigitSubstitute: SCRIPT_DIGITSUBSTITUTE;
    strict private FDpiFX: Single;
    strict private FName: string;
    strict private FReference: Int64;
    strict private FSaved: boolean;
    strict private FSourceFont: Font;
    strict private FTextMetric: OutlineTextMetric;
    strict private FUSCache: IntPtr;
    strict private FUsedAlphabetUnicode: List<Word>;
    strict private FUsedGlyphIndexes: List<Word>;
    strict private FWidths: List<Integer>;
    strict private tempBitmap: Bitmap;

    type // Nested Types
        [StructLayout(LayoutKind.Sequential)]
        public ABC = record
            // Fields
            public abcA: Integer;
            public abcB: Integer;
            public abcC: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public FontPanose = record
            // Fields
            public ArmStyle: Byte;
            public bContrast: Byte;
            public bFamilyType: Byte;
            public bLetterform: Byte;
            public bMidline: Byte;
            public bProportion: Byte;
            public bSerifStyle: Byte;
            public bStrokeVariation: Byte;
            public bWeight: Byte;
            public bXHeight: Byte;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public FontPoint = record
            // Fields
            public x: Integer;
            public y: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public FontRect = record
            // Fields
            public bottom: Integer;
            public left: Integer;
            public right: Integer;
            public top: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public FontTextMetric = record
            // Fields
            public tmAscent: Integer;
            public tmAveCharWidth: Integer;
            public tmBreakChar: Char;
            public tmCharSet: Byte;
            public tmDefaultChar: Char;
            public tmDescent: Integer;
            public tmDigitizedAspectX: Integer;
            public tmDigitizedAspectY: Integer;
            public tmExternalLeading: Integer;
            public tmFirstChar: Char;
            public tmHeight: Integer;
            public tmInternalLeading: Integer;
            public tmItalic: Byte;
            public tmLastChar: Char;
            public tmMaxCharWidth: Integer;
            public tmOverhang: Integer;
            public tmPitchAndFamily: Byte;
            public tmStruckOut: Byte;
            public tmUnderlined: Byte;
            public tmWeight: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public GOFFSET = record
            // Fields
            public du: Integer;
            public dv: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public OutlineTextMetric = record
            // Fields
            public otmAscent: Integer;
            public otmDescent: Integer;
            public otmEMSquare: Cardinal;
            public otmFiller: Byte;
            public otmfsSelection: Cardinal;
            public otmfsType: Cardinal;
            public otmItalicAngle: Integer;
            public otmLineGap: Cardinal;
            public otmMacAscent: Integer;
            public otmMacDescent: Integer;
            public otmMacLineGap: Cardinal;
            public otmPanoseNumber: FontPanose;
            public otmpFaceName: string;
            public otmpFamilyName: string;
            public otmpFullName: string;
            public otmpStyleName: string;
            public otmptSubscriptOffset: FontPoint;
            public otmptSubscriptSize: FontPoint;
            public otmptSuperscriptOffset: FontPoint;
            public otmptSuperscriptSize: FontPoint;
            public otmrcFontBox: FontRect;
            public otmsCapEmHeight: Cardinal;
            public otmsCharSlopeRise: Integer;
            public otmsCharSlopeRun: Integer;
            public otmSize: Cardinal;
            public otmsStrikeoutPosition: Integer;
            public otmsStrikeoutSize: Cardinal;
            public otmsUnderscorePosition: Integer;
            public otmsUnderscoreSize: Integer;
            public otmsXHeight: Cardinal;
            public otmTextMetrics: FontTextMetric;
            public otmusMinimumPPEM: Cardinal;

        end;

        strict private Run = class
            // Methods
            public constructor Create(text: string; a: SCRIPT_ANALYSIS); 

            // Fields
            public analysis: SCRIPT_ANALYSIS;
            public text: string;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public SCRIPT_ANALYSIS = record
            // Fields
            public data: Smallint;
            public state: SCRIPT_STATE;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public SCRIPT_CONTROL = record
            // Fields
            public data: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public SCRIPT_DIGITSUBSTITUTE = record
            // Fields
            public DigitSubstitute: Byte;
            public dwReserved: Integer;
            public NationalDigitLanguage: Smallint;
            public TraditionalDigitLanguage: Smallint;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public SCRIPT_ITEM = record
            // Fields
            public analysis: SCRIPT_ANALYSIS;
            public iCharPos: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public SCRIPT_STATE = record
            // Methods
            public procedure SetRtl; 

            // Properties
            public property uBidiLevel: Integer read get_uBidiLevel;

            // Fields
            public data: Smallint;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public SCRIPT_VISATTR = record
            // Fields
            public data: Smallint;

        end;


end;


// Methods
    constructor ExportTTFFont.Create(font: Font);
    begin
        self.FSourceFont := Font.Create(font.Name, (750 * self.FDpiFX), font.Style);
        self.FSaved := false;
        self.FTextMetric := OutlineTextMetric.Create;
        self.FUsedGlyphIndexes := List<Word>.Create;
        self.FUsedAlphabetUnicode := List<Word>.Create;
        self.FWidths := List<Integer>.Create;
        self.tempBitmap := Bitmap.Create(1, 1);
        self.FUSCache := IntPtr.Zero;
        self.FDigitSubstitute := SCRIPT_DIGITSUBSTITUTE.Create;
        ExportTTFFont.ScriptRecordDigitSubstitution($400, @(self.FDigitSubstitute))
    end;

    [DllImport('Gdi32.dll')]
    strict private class extern function DeleteObject(hgdiobj: IntPtr): IntPtr; static; 
    procedure ExportTTFFont.Dispose;
    begin
        ExportTTFFont.ScriptFreeCache(@(self.FUSCache));
        self.tempBitmap.Dispose;
        self.FSourceFont.Dispose
    end;

    procedure ExportTTFFont.FillOutlineTextMetrix;
    var
        g: Graphics;
    begin
        if (self.FSourceFont <> nil) then
            {using g}
            begin
                g := Graphics.FromImage(self.tempBitmap);
                try
                    hdc := g.GetHdc;
                    f := self.FSourceFont.ToHfont;
                    try
                        ExportTTFFont.SelectObject(hdc, f);
                        ExportTTFFont.GetOutlineTextMetrics(hdc, Marshal.SizeOf(typeof(OutlineTextMetric)), @(self.FTextMetric))
                    finally
                        ExportTTFFont.DeleteObject(f);
                        g.ReleaseHdc(hdc)
                    end
                finally
                    g.Dispose
                end
            end
    end;

    function ExportTTFFont.GetEnglishFontName: string;
    var
        c: Char;
    begin
        fontName := self.FSourceFont.FontFamily.GetName($409);
        Result := StringBuilder.Create((fontName.Length * 3));

        for c in fontName do
        begin
            case c of
                '#':
                '%':
                '(':
                ')':
                '/':
                ' ':
                '<':
                '>':
                '[':
                ']':
                '{':
                '}':
                    begin
                        Result.Append('#');
                        Result.Append((c as Integer).ToString('X2'));
                        break;

                    end;
                default:begin
                        if ((c > '~') or (c < ' ')) then
                        begin
                            Result.Append('#');
                            Result.Append((c as Integer).ToString('X2'))
                        end
                        else
                            Result.Append(c);
                        break;

                    end;
            end
        end;
        Style := StringBuilder.Create(9);
        if ((self.FSourceFont.Style and FontStyle.Bold) > FontStyle.Regular) then
            Style.Append('Bold');
        if ((self.FSourceFont.Style and FontStyle.Italic) > FontStyle.Regular) then
            Style.Append('Italic');
        if (Style.Length > 0) then
            Result.Append(',').Append(Style.ToString);
        begin
            Result := Result.ToString;
            exit
        end
    end;

    function ExportTTFFont.GetFontData: Byte[];
    var
        font_collection: TrueTypeCollection;
    begin
        result := nil;
        if (self.FSourceFont = nil) then
            begin
                Result := result;
                exit
            end;
        {using font_collection}
        begin
            font_collection := TrueTypeCollection.Create(self.FSourceFont);
            try
                skip_list := New(array[5] of TablesID, ( ( TablesID.HorizontakDeviceMetrix, TablesID.DigitalSignature, TablesID.GlyphPosition, TablesID.EmbedBitmapLocation, TablesID.EmbededBitmapData ) ));

                for f in font_collection.FontCollection do
                begin
                    f.PrepareFont(skip_list)
                end;
                font := font_collection.Item[self.FSourceFont];

                for ch in self.FUsedGlyphIndexes do
                begin
                    font.AddCharacterToKeepList(ch)
                end;
                begin
                    Result := font.PackFont(FontType.TrueTypeFont, true);
                    exit
                end
            finally
                font_collection.Dispose
            end
        end
    end;

    [DllImport('Gdi32.dll', CharSet=CharSet.Auto)]
    strict private class extern function GetFontData(hdc: IntPtr; dwTable: Cardinal; dwOffset: Cardinal; [In, Out] lpvBuffer: Byte[]; cbData: Cardinal): Cardinal; static; 
    [DllImport('Gdi32.dll', CharSet=CharSet.Auto)]
    strict private class extern function GetFontData(hdc: IntPtr; dwTable: Cardinal; dwOffset: Cardinal; [In, Out] lpvBuffer: IntPtr; cbData: Cardinal): Cardinal; static; 
    [DllImport('Gdi32.dll', CharSet=CharSet.Auto)]
    strict private class extern function GetGlyphIndices(hdc: IntPtr; lpstr: string; c: Integer; [In, Out] pgi: Word[]; fl: Cardinal): Cardinal; static; 
    function ExportTTFFont.GetGlyphIndices(hdc: IntPtr; text: string; glyphs: Word[]; widths: Integer[]; rtl: boolean): Integer;
    var
        run: Run;
    begin
        if (string.IsNullOrEmpty(text)) then
            begin
                Result := 0;
                exit
            end;
        destIndex := 0;
        maxGlyphs := (text.Length * 3);
        maxItems := (text.Length * 2);
        runs := self.Itemize(text, rtl, maxItems);
        runs := self.Layout(runs, rtl);

        for run in runs do
        begin
            tempGlyphs := New(array[maxGlyphs] of Word);
            tempWidths := New(array[maxGlyphs] of Integer);
            length := self.GetGlyphs(hdc, run, tempGlyphs, tempWidths, maxGlyphs, rtl);
            Array.Copy(tempGlyphs, 0, glyphs, destIndex, length);
            Array.Copy(tempWidths, 0, widths, destIndex, length);
            inc(destIndex, length)
        end;
        begin
            Result := destIndex;
            exit
        end
    end;

    function ExportTTFFont.GetGlyphs(hdc: IntPtr; run: Run; glyphs: Word[]; widths: Integer[]; maxGlyphs: Integer; rtl: boolean): Integer;
    begin
        psa := run.analysis;
        pwLogClust := New(array[maxGlyphs] of Word);
        pcGlyphs := 0;
        psva := New(array[maxGlyphs] of SCRIPT_VISATTR);
        pGoffset := New(array[maxGlyphs] of GOFFSET);
        pABC := ABC.Create;
        ExportTTFFont.ScriptShape(hdc, @(self.FUSCache), run.text, run.text.Length, glyphs.Length, @(psa), glyphs, pwLogClust, psva, @(pcGlyphs));
        ExportTTFFont.ScriptPlace(hdc, @(self.FUSCache), glyphs, pcGlyphs, psva, @(psa), widths, pGoffset, @(pABC));
        Result := pcGlyphs
    end;

    function ExportTTFFont.GetGlyphWidth(c: Char): Integer;
    begin
        Result := self.FWidths.Item[self.FUsedGlyphIndexes.IndexOf(c)]
    end;

    [DllImport('Gdi32.dll')]
    strict private class extern function GetOutlineTextMetrics(hdc: IntPtr; cbData: Integer; var lpOTM: OutlineTextMetric): Integer; static; 
    function ExportTTFFont.GetPANOSE: string;
    begin
        panose := StringBuilder.Create($24);
        panose.Append('01 05 ');
        panose.Append(self.FTextMetric.otmPanoseNumber.bFamilyType.ToString('X')).Append(' ');
        panose.Append(self.FTextMetric.otmPanoseNumber.bSerifStyle.ToString('X')).Append(' ');
        panose.Append(self.FTextMetric.otmPanoseNumber.bWeight.ToString('X')).Append(' ');
        panose.Append(self.FTextMetric.otmPanoseNumber.bProportion.ToString('X')).Append(' ');
        panose.Append(self.FTextMetric.otmPanoseNumber.bContrast.ToString('X')).Append(' ');
        panose.Append(self.FTextMetric.otmPanoseNumber.bStrokeVariation.ToString('X')).Append(' ');
        panose.Append(self.FTextMetric.otmPanoseNumber.ArmStyle.ToString('X')).Append(' ');
        panose.Append(self.FTextMetric.otmPanoseNumber.bLetterform.ToString('X')).Append(' ');
        panose.Append(self.FTextMetric.otmPanoseNumber.bMidline.ToString('X')).Append(' ');
        panose.Append(self.FTextMetric.otmPanoseNumber.bXHeight.ToString('X'));
        Result := panose.ToString
    end;

    function ExportTTFFont.Itemize(s: string; rtl: boolean; maxItems: Integer): List<Run>;
    begin
        pItems := New(array[maxItems] of SCRIPT_ITEM);
        pcItems := 0;
        control := SCRIPT_CONTROL.Create;
        state := SCRIPT_STATE.Create;
        if (rtl) then
        begin
            state.SetRtl;
            ExportTTFFont.ScriptApplyDigitSubstitution(@(self.FDigitSubstitute), @(control), @(state))
        end;
        ExportTTFFont.ScriptItemize(s, s.Length, pItems.Length, @(control), @(state), pItems, @(pcItems));
        list := List<Run>.Create;
        i := 0;
        while ((i < pcItems)) do
        begin
            text := s.Substring(pItems[i].iCharPos, (pItems[(i + 1)].iCharPos - pItems[i].iCharPos));
            list.Add(Run.Create(text, pItems[i].analysis));
            inc(i)
        end;
        begin
            Result := list;
            exit
        end
    end;

    function ExportTTFFont.Layout(runs: List<Run>; rtl: boolean): List<Run>;
    var
        i: Integer;
    begin
        pbLevel := New(array[runs.Count] of Byte);
        piVisualToLogical := New(array[runs.Count] of Integer);
        i := 0;
        while ((i < runs.Count)) do
        begin
            pbLevel[i] := (runs.Item[i].analysis.state.uBidiLevel as Byte);
            inc(i)
        end;
        ExportTTFFont.ScriptLayout(runs.Count, pbLevel, piVisualToLogical, nil);
        visualRuns := List<Run>.Create;
        i := 0;
        while ((i < piVisualToLogical.Length)) do
        begin
            visualRuns.Add(runs.Item[piVisualToLogical[i]]);
            inc(i)
        end;
        begin
            Result := visualRuns;
            exit
        end
    end;

    function ExportTTFFont.RemapString(str: string; rtl: boolean): string;
    var
        g: Graphics;
    begin
        str := str.Replace('#13', '').Replace('#10', '');
        maxGlyphs := (str.Length * 3);
        glyphs := New(array[maxGlyphs] of Word);
        widths := New(array[maxGlyphs] of Integer);
        actualLength := 0;
        {using g}
        begin
            g := Graphics.FromImage(self.tempBitmap);
            try
                hdc := g.GetHdc;
                f := self.FSourceFont.ToHfont;
                try
                    ExportTTFFont.SelectObject(hdc, f);
                    actualLength := self.GetGlyphIndices(hdc, str, glyphs, widths, rtl)
                finally
                    ExportTTFFont.DeleteObject(f);
                    g.ReleaseHdc(hdc)
                end
            finally
                g.Dispose
            end
        endsb := StringBuilder.Create(actualLength);
        i := 0;
        while ((i < actualLength)) do
        begin
            c := glyphs[i];
            if (self.FUsedGlyphIndexes.IndexOf(c) = -1) then
            begin
                self.FUsedGlyphIndexes.Add(c);
                self.FWidths.Add(widths[i]);
                if (actualLength > str.Length) then
                    self.FUsedAlphabetUnicode.Add(self.FTextMetric.otmTextMetrics.tmDefaultChar)
                else
                    self.FUsedAlphabetUnicode.Add(str.Chars[ {pseudo} (if rtl then ((actualLength - i) - 1) else i)])
                end;
            sb.Append((c as Char));
            inc(i)
        end;
        begin
            Result := sb.ToString;
            exit
        end
    end;

    [DllImport('usp10.dll')]
    strict private class extern function ScriptApplyDigitSubstitution(var psds: SCRIPT_DIGITSUBSTITUTE; var psc: SCRIPT_CONTROL; var pss: SCRIPT_STATE): Integer; static; 
    [DllImport('usp10.dll')]
    strict private class extern function ScriptFreeCache(var psc: IntPtr): Integer; static; 
    [DllImport('usp10.dll')]
    strict private class extern function ScriptItemize([MarshalAs(UnmanagedType.LPWStr)] pwcInChars: string; cInChars: Integer; cMaxItems: Integer; var psControl: SCRIPT_CONTROL; var psState: SCRIPT_STATE; [In, Out] pItems: SCRIPT_ITEM[]; var pcItems: Integer): Integer; static; 
    [DllImport('usp10.dll')]
    strict private class extern function ScriptLayout(cRuns: Integer; [MarshalAs(UnmanagedType.LPArray)] pbLevel: Byte[]; [MarshalAs(UnmanagedType.LPArray)] piVisualToLogical: Integer[]; [MarshalAs(UnmanagedType.LPArray)] piLogicalToVisual: Integer[]): Integer; static; 
    [DllImport('usp10.dll')]
    strict private class extern function ScriptPlace(hdc: IntPtr; var psc: IntPtr; [MarshalAs(UnmanagedType.LPArray)] pwGlyphs: Word[]; cGlyphs: Integer; [MarshalAs(UnmanagedType.LPArray)] psva: SCRIPT_VISATTR[]; var psa: SCRIPT_ANALYSIS; [MarshalAs(UnmanagedType.LPArray)] piAdvance: Integer[]; [Out, MarshalAs(UnmanagedType.LPArray)] pGoffset: GOFFSET[]; var pABC: ABC): Integer; static; 
    [DllImport('usp10.dll')]
    strict private class extern function ScriptRecordDigitSubstitution(lcid: Cardinal; var psds: SCRIPT_DIGITSUBSTITUTE): Cardinal; static; 
    [DllImport('usp10.dll')]
    strict private class extern function ScriptShape(hdc: IntPtr; var psc: IntPtr; [MarshalAs(UnmanagedType.LPWStr)] pwcChars: string; cChars: Integer; cMaxGlyphs: Integer; var psa: SCRIPT_ANALYSIS; [Out, MarshalAs(UnmanagedType.LPArray)] pwOutGlyphs: Word[]; [Out, MarshalAs(UnmanagedType.LPArray)] pwLogClust: Word[]; [Out, MarshalAs(UnmanagedType.LPArray)] psva: SCRIPT_VISATTR[]; var pcGlyphs: Integer): Integer; static; 
    [DllImport('Gdi32.dll')]
    strict private class extern function SelectObject(hdc: IntPtr; hgdiobj: IntPtr): IntPtr; static; 

    // Properties
    public property Name: string read get_Name write set_Name;
    public property Reference: Int64 read get_Reference write set_Reference;
    public property Saved: boolean read get_Saved write set_Saved;
    public property SourceFont: Font read get_SourceFont;
    public property TextMetric: OutlineTextMetric read get_TextMetric;
    public property UsedAlphabetUnicode: List<Word> read get_UsedAlphabetUnicode;
    public property UsedGlyphIndexes: List<Word> read get_UsedGlyphIndexes;
    public property Widths: List<Integer> read get_Widths;

    // Fields
    strict private FDigitSubstitute: SCRIPT_DIGITSUBSTITUTE;
    strict private FDpiFX: Single = (96 div (DrawUtils.ScreenDpi as Single));
    strict private FName: string;
    strict private FReference: Int64;
    strict private FSaved: boolean;
    strict private FSourceFont: Font;
    strict private FTextMetric: OutlineTextMetric;
    strict private FUSCache: IntPtr;
    strict private FUsedAlphabetUnicode: List<Word>;
    strict private FUsedGlyphIndexes: List<Word>;
    strict private FWidths: List<Integer>;
    strict private tempBitmap: Bitmap;

    type // Nested Types
        [StructLayout(LayoutKind.Sequential)]
        public ABC = record
            // Fields
            public abcA: Integer;
            public abcB: Integer;
            public abcC: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public FontPanose = record
            // Fields
            public ArmStyle: Byte;
            public bContrast: Byte;
            public bFamilyType: Byte;
            public bLetterform: Byte;
            public bMidline: Byte;
            public bProportion: Byte;
            public bSerifStyle: Byte;
            public bStrokeVariation: Byte;
            public bWeight: Byte;
            public bXHeight: Byte;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public FontPoint = record
            // Fields
            public x: Integer;
            public y: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public FontRect = record
            // Fields
            public bottom: Integer;
            public left: Integer;
            public right: Integer;
            public top: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public FontTextMetric = record
            // Fields
            public tmAscent: Integer;
            public tmAveCharWidth: Integer;
            public tmBreakChar: Char;
            public tmCharSet: Byte;
            public tmDefaultChar: Char;
            public tmDescent: Integer;
            public tmDigitizedAspectX: Integer;
            public tmDigitizedAspectY: Integer;
            public tmExternalLeading: Integer;
            public tmFirstChar: Char;
            public tmHeight: Integer;
            public tmInternalLeading: Integer;
            public tmItalic: Byte;
            public tmLastChar: Char;
            public tmMaxCharWidth: Integer;
            public tmOverhang: Integer;
            public tmPitchAndFamily: Byte;
            public tmStruckOut: Byte;
            public tmUnderlined: Byte;
            public tmWeight: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public GOFFSET = record
            // Fields
            public du: Integer;
            public dv: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public OutlineTextMetric = record
            // Fields
            public otmAscent: Integer;
            public otmDescent: Integer;
            public otmEMSquare: Cardinal;
            public otmFiller: Byte;
            public otmfsSelection: Cardinal;
            public otmfsType: Cardinal;
            public otmItalicAngle: Integer;
            public otmLineGap: Cardinal;
            public otmMacAscent: Integer;
            public otmMacDescent: Integer;
            public otmMacLineGap: Cardinal;
            public otmPanoseNumber: FontPanose;
            public otmpFaceName: string;
            public otmpFamilyName: string;
            public otmpFullName: string;
            public otmpStyleName: string;
            public otmptSubscriptOffset: FontPoint;
            public otmptSubscriptSize: FontPoint;
            public otmptSuperscriptOffset: FontPoint;
            public otmptSuperscriptSize: FontPoint;
            public otmrcFontBox: FontRect;
            public otmsCapEmHeight: Cardinal;
            public otmsCharSlopeRise: Integer;
            public otmsCharSlopeRun: Integer;
            public otmSize: Cardinal;
            public otmsStrikeoutPosition: Integer;
            public otmsStrikeoutSize: Cardinal;
            public otmsUnderscorePosition: Integer;
            public otmsUnderscoreSize: Integer;
            public otmsXHeight: Cardinal;
            public otmTextMetrics: FontTextMetric;
            public otmusMinimumPPEM: Cardinal;

        end;

        strict private Run = class
            // Methods
            constructor ExportTTFFont.Run.Create(text: string; a: SCRIPT_ANALYSIS);
            begin
                self.text := text;
                self.analysis := a
            end;


            // Fields
            public analysis: SCRIPT_ANALYSIS;
            public text: string;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public SCRIPT_ANALYSIS = record
            // Fields
            public data: Smallint;
            public state: SCRIPT_STATE;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public SCRIPT_CONTROL = record
            // Fields
            public data: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public SCRIPT_DIGITSUBSTITUTE = record
            // Fields
            public DigitSubstitute: Byte;
            public dwReserved: Integer;
            public NationalDigitLanguage: Smallint;
            public TraditionalDigitLanguage: Smallint;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public SCRIPT_ITEM = record
            // Fields
            public analysis: SCRIPT_ANALYSIS;
            public iCharPos: Integer;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public SCRIPT_STATE = record
            // Methods
            procedure ExportTTFFont.SCRIPT_STATE.SetRtl;
            begin
                self.data := $801
            end;


            // Properties
            public property uBidiLevel: Integer read get_uBidiLevel;

            // Fields
            public data: Smallint;

        end;

        [StructLayout(LayoutKind.Sequential)]
        public SCRIPT_VISATTR = record
            // Fields
            public data: Smallint;

        end;


end;
