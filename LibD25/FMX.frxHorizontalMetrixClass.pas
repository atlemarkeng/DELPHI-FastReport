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

unit FMX.frxHorizontalMetrixClass;

interface uses FMX.TTFHelpers, FMX.frxTrueTypeTable;

type
    longHorMetric = packed record
        public advanceWidth: Word;
        public lsb: Smallint;
    end;

    THorMetricArray = array of longHorMetric;

  HorizontalMetrixClass = class(TrueTypeTable)
    strict private MetrixTable: THorMetricArray;
    public NumberOfMetrics: Word;

    public constructor Create(src: TrueTypeTable);
    public procedure Load(font: Pointer); override;
    public function GetItem(index : integer): longHorMetric;

    public property Item[index: Integer]: longHorMetric read GetItem;


end;

implementation

    constructor HorizontalMetrixClass.Create(src: TrueTypeTable);
    begin
      inherited Create(src);
    end;

    function HorizontalMetrixClass.GetItem(index : integer): longHorMetric;
    begin
      Result := MetrixTable[index];
    end;

    procedure HorizontalMetrixClass.Load(font: Pointer);
    var
      h_metrix: ^longHorMetric;
      i: Integer;
    begin

        SetLength(self.MetrixTable, self.NumberOfMetrics);
        h_metrix := TTF_Helpers.Increment(font, self.entry.offset);
        i := 0;
        while ((i < self.NumberOfMetrics)) do
        begin
            self.MetrixTable[i].advanceWidth := TTF_Helpers.SwapUInt16( h_metrix.advanceWidth );
            self.MetrixTable[i].lsb := TTF_Helpers.SwapInt16( h_metrix.lsb);
            Inc(h_metrix); // Check incremet size - must be record size
            inc(i)
        end
    end;
end.
