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

unit FMX.frxFontHeaderClass;

interface uses FMX.TTFHelpers, FMX.frxTrueTypeTable;

type // Nested Types
  FontHeader = packed record
      public version: Cardinal;
      public revision: Cardinal;
      public checkSumAdjustment: Cardinal;
      public magicNumber: Cardinal;
      public flags: Word;
      public unitsPerEm: Word;
      public CreatedDateTime: UInt64;
      public ModifiedDateTime: UInt64;
      public xMin: Smallint;
      public yMin: Smallint;
      public xMax: Smallint;
      public yMax: Smallint;
      public macStyle: Word;
      public lowestRecPPEM: Word;
      public fontDirectionHint: Smallint;
      public indexToLocFormat: Smallint;
      public glyphDataFormat: Smallint;
  end;

  IndexToLoc = (LongType=1, ShortType=0);

  FontType = (TrueTypeCollection=$66637474, TrueTypeFontType=0);

  FontHeaderClass = class(TrueTypeTable)
    public font_header: FontHeader;

    private function get_indexToLocFormat: IndexToLoc;

    // Properties
    private property checkSumAdjustment: Cardinal write font_header.checkSumAdjustment;
    private property Flags: Word read font_header.flags;
//    public property FontBox: FontRect read font_header.FontBox;
    public property indexToLocFormat: IndexToLoc read get_indexToLocFormat;
    public property unitsPerEm: Word read font_header.unitsPerEm;


    // Methods
    public constructor Create(src: TrueTypeTable);
    strict private procedure ChangeEndian;
    public procedure Load(font: Pointer); override;
    public procedure SaveFontHeader(header_ptr: Pointer; CheckSum: Cardinal);

end;

implementation

    constructor FontHeaderClass.Create(src: TrueTypeTable);
    begin
      inherited Create(src);
    end;

    function FontHeaderClass.get_indexToLocFormat: IndexToLoc;
    begin
      Result := IndexToLoc(font_header.indexToLocFormat);
    end;

    procedure FontHeaderClass.ChangeEndian;
    begin
        self.font_header.indexToLocFormat := TTF_Helpers.SwapInt16(self.font_header.indexToLocFormat);
        self.font_header.magicNumber := TTF_Helpers.SwapUInt32(self.font_header.magicNumber);
        self.font_header.unitsPerEm := TTF_Helpers.SwapUInt16(self.font_header.unitsPerEm);
        self.font_header.flags := TTF_Helpers.SwapUInt16(self.font_header.flags);
    end;

    procedure FontHeaderClass.Load(font: Pointer);
    var
      header: ^FontHeader;
    begin
        header := TTF_Helpers.Increment(font, self.entry.offset); //header_ptr;
        self.font_header.checkSumAdjustment := header.checkSumAdjustment;
        self.font_header.CreatedDateTime := header.CreatedDateTime;
        self.font_header.flags := header.flags;
        self.font_header.fontDirectionHint := header.fontDirectionHint;
        self.font_header.glyphDataFormat := header.glyphDataFormat;
        self.font_header.indexToLocFormat:= header.indexToLocFormat;
        self.font_header.lowestRecPPEM := header.lowestRecPPEM;
        self.font_header.macStyle := header.macStyle;
        self.font_header.magicNumber := header.magicNumber;
        self.font_header.ModifiedDateTime := header.ModifiedDateTime;
        self.font_header.revision := header.revision;
        self.font_header.unitsPerEm := header.unitsPerEm;
        self.font_header.version := header.version;
        self.font_header.xMax := header.xMax;
        self.font_header.xMin := header.xMin;
        self.font_header.yMax := header.yMax;
        self.font_header.yMin := header.yMin;
        self.ChangeEndian;

        header.checkSumAdjustment := 0;
    end;

    procedure FontHeaderClass.SaveFontHeader(header_ptr: Pointer; CheckSum: Cardinal);
    var
      header: ^FontHeader;
    begin
        self.ChangeEndian;
        header_ptr := TTF_Helpers.Increment(header_ptr, self.entry.offset);
        header := header_ptr;

        self.font_header.checkSumAdjustment := TTF_Helpers.SwapUInt32(CheckSum);

        header.checkSumAdjustment := self.font_header.checkSumAdjustment;
        header.CreatedDateTime := self.font_header.CreatedDateTime;
        self.font_header.flags := header.flags;
        header.fontDirectionHint := self.font_header.fontDirectionHint;
        header.glyphDataFormat := self.font_header.glyphDataFormat;
        header.indexToLocFormat := self.font_header.indexToLocFormat;
        header.lowestRecPPEM := self.font_header.lowestRecPPEM;
        header.macStyle := self.font_header.macStyle;
        header.magicNumber := self.font_header.magicNumber;
        header.ModifiedDateTime := self.font_header.ModifiedDateTime;
        header.revision := self.font_header.revision;
        header.unitsPerEm := self.font_header.unitsPerEm;
        header.version := self.font_header.version;
        header.xMax := self.font_header.xMax;
        header.xMin := self.font_header.xMin;
        header.yMax := self.font_header.yMax;
        header.yMin := self.font_header.yMin;
        self.ChangeEndian
    end;
end.
