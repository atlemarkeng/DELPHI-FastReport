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

unit FMX.frxIndexToLocationClass;
interface uses System.SysUtils, FMX.TTFHelpers, FMX.frxFontHeaderClass, FMX.frxTrueTypeTable;
type
    TCardinalArray = array of Cardinal;
    TWordArray = array of Word;

  IndexToLocationClass = class(TrueTypeTable)
    strict private LongIndexToLocation: TCardinalArray;
    strict private ShortIndexToLocation: TWordArray;

    // Methods
    public constructor Create(src: TrueTypeTable);
    public function GetGlyph(i2l_idx: Word; font_header: FontHeaderClass; var location: Cardinal): Word;
    public procedure LoadIndexToLocation(font: Pointer; font_header: FontHeaderClass);

    // Properties
    public property Long: TCardinalArray read LongIndexToLocation;
    public property Short: TWordArray read ShortIndexToLocation;

end;

implementation

    constructor IndexToLocationClass.Create(src: TrueTypeTable);
    begin
        inherited Create(src);
        self.ShortIndexToLocation := nil;
        self.LongIndexToLocation := nil
    end;

    function IndexToLocationClass.GetGlyph(i2l_idx: Word; font_header: FontHeaderClass; var location: Cardinal): Word;
    begin
        location := 0;
        case font_header.indexToLocFormat of
            IndexToLoc.ShortType:
                begin
                    location := Cardinal(self.ShortIndexToLocation[i2l_idx] * 2);
                    Result := Word(2 * (self.ShortIndexToLocation[(i2l_idx + 1)] - self.ShortIndexToLocation[i2l_idx]));
                    exit
                end;
            IndexToLoc.LongType:
                begin
                    location := self.LongIndexToLocation[i2l_idx];
                    Result := Word(self.LongIndexToLocation[(i2l_idx + 1)] - self.LongIndexToLocation[i2l_idx]);
                    exit
                end;
        end;
        begin
            Result := 0;
            exit
        end
    end;

    procedure IndexToLocationClass.LoadIndexToLocation(font: Pointer; font_header: FontHeaderClass);
    type
        TShortPtr =  ^Word;
        TLongPtr =   ^Integer;
    var
        count:      Integer;
        i:          Integer;
        short_ptr:  ^Word;
        long_ptr:   ^Integer;
    begin
        case font_header.indexToLocFormat of
            IndexToLoc.ShortType:
                begin
                  count := self.entry.length div 2;
                  SetLength(self.ShortIndexToLocation, count );
                  short_ptr := TTF_Helpers.Increment(font, self.entry.offset);
                  i := 0;
                  while ((i < count)) do
                  begin
                    self.ShortIndexToLocation[i] := TTF_Helpers.SwapUInt16( short_ptr^ );
                    Inc(short_ptr);
                    Inc(i)
                  end;
                end;
            IndexToLoc.LongType:
                begin
                  count := self.entry.length div 4;
                  SetLength(self.LongIndexToLocation, count );
                  long_ptr := TTF_Helpers.Increment(font, self.entry.offset);
                  i := 0;
                  while ((i < count)) do
                  begin
                    self.LongIndexToLocation[i] := TTF_Helpers.SwapUInt32(long_ptr^);
                    Inc(long_ptr);
                    inc(i)
                  end;
                end;

            else raise Exception.Create('Unsupported Index to Location format')
      end;
    end;

end.
