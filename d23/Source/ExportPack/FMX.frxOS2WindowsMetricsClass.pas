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

unit FMX.frxOS2WindowsMetricsClass;
interface uses FMX.TTFHelpers, FMX.frxTrueTypeTable;

type
  TVendorID = packed array[0..3] of Byte;
  TPanose   = packed array[0..9] of Byte;
  OS2WindowsMetrics = packed record
    public Version: Word;         // version number 0x0004
    public xAvgCharWidth: Smallint;
    public usWeightClass: Word;
    public usWidthClass: Word;
    public fsType: Word;
    public ySubscriptXSize: Smallint;
    public ySubscriptYSize: Smallint;
    public ySubscriptXOffset: Smallint;
    public ySubscriptYOffset: Smallint;
    public ySuperscriptXSize: Smallint;
    public ySuperscriptYSize: Smallint;
    public ySuperscriptXOffset: Smallint;
    public ySuperscriptYOffset: Smallint;
    public yStrikeoutSize: Smallint;
    public yStrikeoutPosition: Smallint;
    public sFamilyClass: Smallint;
    public panose: TPanose;
    public ulUnicodeRange1: Cardinal;
    public ulUnicodeRange2: Cardinal;
    public ulUnicodeRange3: Cardinal;
    public ulUnicodeRange4: Cardinal;
    public achVendID: TVendorID;
    public fsSelection: Word;
    public usFirstCharIndex: Word;
    public usLastCharIndex: Word;
    public sTypoAscender: Smallint;
    public sTypoDescender: Smallint;
    public sTypoLineGap: Smallint;
    public usWinAscent: Word;
    public usWinDescent: Word;
    public ulCodePageRange1: Cardinal;
    public ulCodePageRange2: Cardinal;
    public sxHeight: Smallint;
    public sCapHeight: Smallint;
    public usDefaultChar: Word;
    public usBreakChar: Word;
    public usMaxContext: Word;
  end;

    OS2WindowsMetricsClass = class(TrueTypeTable)
        // Fields
      strict private win_metrix: OS2WindowsMetrics;
      // Methods
      public constructor Create(src: TrueTypeTable);
      strict private procedure ChangeEndian;
      public procedure Load(font: Pointer); override;
      public function Save(font: Pointer; offset: Cardinal): Cardinal; override;

      // Properties
      public property Ascent: Word read win_metrix.usWinAscent;
      public property AvgCharWidth: Smallint read win_metrix.xAvgCharWidth;
      public property BreakChar: Word read win_metrix.usBreakChar;
      public property DefaultChar: Word read win_metrix.usDefaultChar;
      public property Descent: Word read win_metrix.usWinDescent;
      public property FirstCharIndex: Word read win_metrix.usFirstCharIndex;
      public property LastCharIndex: Word read win_metrix.usLastCharIndex;
      public property Panose: TPanose read win_metrix.panose;
    end;

implementation

    constructor OS2WindowsMetricsClass.Create(src: TrueTypeTable);
    begin
      inherited Create(src);
    end;

    procedure OS2WindowsMetricsClass.ChangeEndian;
    begin
        self.win_metrix.Version := TTF_Helpers.SwapUInt16(self.win_metrix.Version);
        self.win_metrix.xAvgCharWidth := TTF_Helpers.SwapInt16(self.win_metrix.xAvgCharWidth);
        self.win_metrix.usWeightClass := TTF_Helpers.SwapUInt16(self.win_metrix.usWeightClass);
        self.win_metrix.usWidthClass := TTF_Helpers.SwapUInt16(self.win_metrix.usWidthClass);
        self.win_metrix.fsType := TTF_Helpers.SwapUInt16(self.win_metrix.fsType);
        self.win_metrix.ySubscriptXSize := TTF_Helpers.SwapInt16(self.win_metrix.ySubscriptXSize);
        self.win_metrix.ySubscriptYSize := TTF_Helpers.SwapInt16(self.win_metrix.ySubscriptYSize);
        self.win_metrix.ySubscriptXOffset := TTF_Helpers.SwapInt16(self.win_metrix.ySubscriptXOffset);
        self.win_metrix.ySubscriptYOffset := TTF_Helpers.SwapInt16(self.win_metrix.ySubscriptYOffset);
        self.win_metrix.ySuperscriptXSize := TTF_Helpers.SwapInt16(self.win_metrix.ySuperscriptXSize);
        self.win_metrix.ySuperscriptYSize := TTF_Helpers.SwapInt16(self.win_metrix.ySuperscriptYSize);
        self.win_metrix.ySuperscriptXOffset := TTF_Helpers.SwapInt16(self.win_metrix.ySuperscriptXOffset);
        self.win_metrix.ySuperscriptYOffset := TTF_Helpers.SwapInt16(self.win_metrix.ySuperscriptYOffset);
        self.win_metrix.yStrikeoutSize := TTF_Helpers.SwapInt16(self.win_metrix.yStrikeoutSize);
        self.win_metrix.yStrikeoutPosition := TTF_Helpers.SwapInt16(self.win_metrix.yStrikeoutPosition);
        self.win_metrix.sFamilyClass := TTF_Helpers.SwapInt16(self.win_metrix.sFamilyClass);
        self.win_metrix.ulUnicodeRange1 := TTF_Helpers.SwapUInt32(self.win_metrix.ulUnicodeRange1);
        self.win_metrix.ulUnicodeRange2 := TTF_Helpers.SwapUInt32(self.win_metrix.ulUnicodeRange2);
        self.win_metrix.ulUnicodeRange3 := TTF_Helpers.SwapUInt32(self.win_metrix.ulUnicodeRange3);
        self.win_metrix.ulUnicodeRange4 := TTF_Helpers.SwapUInt32(self.win_metrix.ulUnicodeRange4);
        self.win_metrix.fsSelection := TTF_Helpers.SwapUInt16(self.win_metrix.fsSelection);
        self.win_metrix.usFirstCharIndex := TTF_Helpers.SwapUInt16(self.win_metrix.usFirstCharIndex);
        self.win_metrix.usLastCharIndex := TTF_Helpers.SwapUInt16(self.win_metrix.usLastCharIndex);
        self.win_metrix.sTypoAscender := TTF_Helpers.SwapInt16(self.win_metrix.sTypoAscender);
        self.win_metrix.sTypoDescender := TTF_Helpers.SwapInt16(self.win_metrix.sTypoDescender);
        self.win_metrix.sTypoLineGap := TTF_Helpers.SwapInt16(self.win_metrix.sTypoLineGap);
        self.win_metrix.usWinAscent := TTF_Helpers.SwapUInt16(self.win_metrix.usWinAscent);
        self.win_metrix.usWinDescent := TTF_Helpers.SwapUInt16(self.win_metrix.usWinDescent);
        self.win_metrix.ulCodePageRange1 := TTF_Helpers.SwapUInt32(self.win_metrix.ulCodePageRange1);
        self.win_metrix.ulCodePageRange1 := TTF_Helpers.SwapUInt32(self.win_metrix.ulCodePageRange2);
        self.win_metrix.sxHeight := TTF_Helpers.SwapInt16(self.win_metrix.sxHeight);
        self.win_metrix.sCapHeight := TTF_Helpers.SwapInt16(self.win_metrix.sCapHeight);
        self.win_metrix.usDefaultChar := TTF_Helpers.SwapUInt16(self.win_metrix.usDefaultChar);
        self.win_metrix.usBreakChar := TTF_Helpers.SwapUInt16(self.win_metrix.usBreakChar);
        self.win_metrix.usMaxContext := TTF_Helpers.SwapUInt16(self.win_metrix.usMaxContext)
    end;

    procedure OS2WindowsMetricsClass.Load(font: Pointer);
    var
      win_metrix: ^OS2WindowsMetrics;
    begin
        win_metrix := TTF_Helpers.Increment(font, self.entry.offset );
        self.win_metrix.Version := TTF_Helpers.SwapUInt16(win_metrix.Version);
        self.win_metrix.xAvgCharWidth := TTF_Helpers.SwapInt16(win_metrix.xAvgCharWidth);
        self.win_metrix.usWeightClass := TTF_Helpers.SwapUInt16(win_metrix.usWeightClass);
        self.win_metrix.usWidthClass := TTF_Helpers.SwapUInt16(win_metrix.usWidthClass);
        self.win_metrix.fsType := TTF_Helpers.SwapUInt16(win_metrix.fsType);
        self.win_metrix.ySubscriptXSize := TTF_Helpers.SwapInt16(win_metrix.ySubscriptXSize);
        self.win_metrix.ySubscriptYSize := TTF_Helpers.SwapInt16(win_metrix.ySubscriptYSize);
        self.win_metrix.ySubscriptXOffset := TTF_Helpers.SwapInt16(win_metrix.ySubscriptXOffset);
        self.win_metrix.ySubscriptYOffset := TTF_Helpers.SwapInt16(win_metrix.ySubscriptYOffset);
        self.win_metrix.ySuperscriptXSize := TTF_Helpers.SwapInt16(win_metrix.ySuperscriptXSize);
        self.win_metrix.ySuperscriptYSize := TTF_Helpers.SwapInt16(win_metrix.ySuperscriptYSize);
        self.win_metrix.ySuperscriptXOffset := TTF_Helpers.SwapInt16(win_metrix.ySuperscriptXOffset);
        self.win_metrix.ySuperscriptYOffset := TTF_Helpers.SwapInt16(win_metrix.ySuperscriptYOffset);
        self.win_metrix.yStrikeoutSize := TTF_Helpers.SwapInt16(win_metrix.yStrikeoutSize);
        self.win_metrix.yStrikeoutPosition := TTF_Helpers.SwapInt16(win_metrix.yStrikeoutPosition);
        self.win_metrix.sFamilyClass := TTF_Helpers.SwapInt16(win_metrix.sFamilyClass);
        self.win_metrix.ulUnicodeRange1 := TTF_Helpers.SwapUInt32(win_metrix.ulUnicodeRange1);
        self.win_metrix.ulUnicodeRange2 := TTF_Helpers.SwapUInt32(win_metrix.ulUnicodeRange2);
        self.win_metrix.ulUnicodeRange3 := TTF_Helpers.SwapUInt32(win_metrix.ulUnicodeRange3);
        self.win_metrix.ulUnicodeRange4 := TTF_Helpers.SwapUInt32(win_metrix.ulUnicodeRange4);
        self.win_metrix.fsSelection := TTF_Helpers.SwapUInt16(win_metrix.fsSelection);
        self.win_metrix.usFirstCharIndex := TTF_Helpers.SwapUInt16(win_metrix.usFirstCharIndex);
        self.win_metrix.usLastCharIndex := TTF_Helpers.SwapUInt16(win_metrix.usLastCharIndex);
        self.win_metrix.sTypoAscender := TTF_Helpers.SwapInt16(win_metrix.sTypoAscender);
        self.win_metrix.sTypoDescender := TTF_Helpers.SwapInt16(win_metrix.sTypoDescender);
        self.win_metrix.sTypoLineGap := TTF_Helpers.SwapInt16(win_metrix.sTypoLineGap);
        self.win_metrix.usWinAscent := TTF_Helpers.SwapUInt16(win_metrix.usWinAscent);
        self.win_metrix.usWinDescent := TTF_Helpers.SwapUInt16(win_metrix.usWinDescent);
        self.win_metrix.ulCodePageRange1 := TTF_Helpers.SwapUInt32(win_metrix.ulCodePageRange1);
        self.win_metrix.ulCodePageRange1 := TTF_Helpers.SwapUInt32(win_metrix.ulCodePageRange2);
        self.win_metrix.sxHeight := TTF_Helpers.SwapInt16(win_metrix.sxHeight);
        self.win_metrix.sCapHeight := TTF_Helpers.SwapInt16(win_metrix.sCapHeight);
        self.win_metrix.usDefaultChar := TTF_Helpers.SwapUInt16(win_metrix.usDefaultChar);
        self.win_metrix.usBreakChar := TTF_Helpers.SwapUInt16(win_metrix.usBreakChar);
        self.win_metrix.usMaxContext := TTF_Helpers.SwapUInt16(win_metrix.usMaxContext);
//        self.ChangeEndian
    end;

    function OS2WindowsMetricsClass.Save(font: Pointer; offset: Cardinal): Cardinal;
    var
      win_metrix: ^OS2WindowsMetrics;
    begin
        self.entry.offset := offset;
        self.entry.length := SizeOf(OS2WindowsMetrics);
//        self.ChangeEndian;
        win_metrix := TTF_Helpers.Increment(font, self.entry.offset);
        win_metrix.Version := TTF_Helpers.SwapUInt16(self.win_metrix.Version);
        win_metrix.xAvgCharWidth := TTF_Helpers.SwapInt16(self.win_metrix.xAvgCharWidth);
        win_metrix.usWeightClass := TTF_Helpers.SwapUInt16(self.win_metrix.usWeightClass);
        win_metrix.usWidthClass := TTF_Helpers.SwapUInt16(self.win_metrix.usWidthClass);
        win_metrix.fsType := TTF_Helpers.SwapUInt16(self.win_metrix.fsType);
        win_metrix.ySubscriptXSize := TTF_Helpers.SwapInt16(self.win_metrix.ySubscriptXSize);
        win_metrix.ySubscriptYSize := TTF_Helpers.SwapInt16(self.win_metrix.ySubscriptYSize);
        win_metrix.ySubscriptXOffset := TTF_Helpers.SwapInt16(self.win_metrix.ySubscriptXOffset);
        win_metrix.ySubscriptYOffset := TTF_Helpers.SwapInt16(self.win_metrix.ySubscriptYOffset);
        win_metrix.ySuperscriptXSize := TTF_Helpers.SwapInt16(self.win_metrix.ySuperscriptXSize);
        win_metrix.ySuperscriptYSize := TTF_Helpers.SwapInt16(self.win_metrix.ySuperscriptYSize);
        win_metrix.ySuperscriptXOffset := TTF_Helpers.SwapInt16(self.win_metrix.ySuperscriptXOffset);
        win_metrix.ySuperscriptYOffset := TTF_Helpers.SwapInt16(self.win_metrix.ySuperscriptYOffset);
        win_metrix.yStrikeoutSize := TTF_Helpers.SwapInt16(self.win_metrix.yStrikeoutSize);
        win_metrix.yStrikeoutPosition := TTF_Helpers.SwapInt16(self.win_metrix.yStrikeoutPosition);
        win_metrix.sFamilyClass := TTF_Helpers.SwapInt16(self.win_metrix.sFamilyClass);
        win_metrix.ulUnicodeRange1 := TTF_Helpers.SwapUInt32(self.win_metrix.ulUnicodeRange1);
        win_metrix.ulUnicodeRange2 := TTF_Helpers.SwapUInt32(self.win_metrix.ulUnicodeRange2);
        win_metrix.ulUnicodeRange3 := TTF_Helpers.SwapUInt32(self.win_metrix.ulUnicodeRange3);
        win_metrix.ulUnicodeRange4 := TTF_Helpers.SwapUInt32(self.win_metrix.ulUnicodeRange4);
        win_metrix.fsSelection := TTF_Helpers.SwapUInt16(self.win_metrix.fsSelection);
        win_metrix.usFirstCharIndex := TTF_Helpers.SwapUInt16(self.win_metrix.usFirstCharIndex);
        win_metrix.usLastCharIndex := TTF_Helpers.SwapUInt16(self.win_metrix.usLastCharIndex);
        win_metrix.sTypoAscender := TTF_Helpers.SwapInt16(self.win_metrix.sTypoAscender);
        win_metrix.sTypoDescender := TTF_Helpers.SwapInt16(self.win_metrix.sTypoDescender);
        win_metrix.sTypoLineGap := TTF_Helpers.SwapInt16(self.win_metrix.sTypoLineGap);
        win_metrix.usWinAscent := TTF_Helpers.SwapUInt16(self.win_metrix.usWinAscent);
        win_metrix.usWinDescent := TTF_Helpers.SwapUInt16(self.win_metrix.usWinDescent);
        win_metrix.ulCodePageRange1 := TTF_Helpers.SwapUInt32(self.win_metrix.ulCodePageRange1);
        win_metrix.ulCodePageRange1 := TTF_Helpers.SwapUInt32(self.win_metrix.ulCodePageRange2);
        win_metrix.sxHeight := TTF_Helpers.SwapInt16(self.win_metrix.sxHeight);
        win_metrix.sCapHeight := TTF_Helpers.SwapInt16(self.win_metrix.sCapHeight);
        win_metrix.usDefaultChar := TTF_Helpers.SwapUInt16(self.win_metrix.usDefaultChar);
        win_metrix.usBreakChar := TTF_Helpers.SwapUInt16(self.win_metrix.usBreakChar);
        win_metrix.usMaxContext := TTF_Helpers.SwapUInt16(self.win_metrix.usMaxContext);
//        self.ChangeEndian;
        Result := (offset + self.entry.length)
    end;
end.
