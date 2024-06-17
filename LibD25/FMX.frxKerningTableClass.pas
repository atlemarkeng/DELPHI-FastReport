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

unit FMX.frxKerningTableClass;
{$HINTS OFF}
interface uses System.Classes, FMX.TTFHelpers, FMX.frxFontHeaderClass, FMX.frxTrueTypeTable, System.Generics.Collections;

type // Nested Types

    CommonKerningHeader = packed record
        public Coverage: Word;
        public Length: Word;
        public Version: Word;
    end;

    FormatZero = packed record
        public entrySelector: Word;
        public nPairs: Word;
        public rangeShift: Word;
        public searchRange: Word;
    end;

    FormatZeroPair = packed record
        public key_value: Cardinal;
        public value: Smallint;
    end;

    KerningTableHeader = packed record
        public Version: Word;
        public nTables: Word;
    end;

    KerningSubtableClass = class(TTF_Helpers)
        // Fields
        strict private common_header: CommonKerningHeader;
        strict private format_zero: FormatZero;
        strict private zero_pairs: TDictionary<Cardinal,Smallint>;
        // Methods
        public constructor Create(kerning_table_ptr: Pointer);
        public destructor Destroy; override;

        strict private function get_Item(inx: Cardinal): Smallint;
        // Properties
        public property Item[hash_value: Cardinal]: Smallint read get_Item;
        public property Length: Word read common_header.Length;
    end;

    KerningTableClass = class(TrueTypeTable)
        // Fields
        strict private kerning_table_header: KerningTableHeader;
        strict private kerning_subtables_collection: TList;
        // Methods
        public constructor Create(src: TrueTypeTable);
        public Destructor Destroy; override;
        strict private procedure ChangeEndian;
        public procedure Load(font: Pointer); override;

        private function get_Item(idx: Cardinal): Smallint;
        // Properties
        public property Item[hash_value: Cardinal]: Smallint read get_Item;
    end;

implementation uses System.SysUtils;

    constructor KerningTableClass.Create(src: TrueTypeTable);
    begin
        inherited Create(src);
        self.kerning_subtables_collection := TList.Create
    end;

destructor KerningTableClass.Destroy;
var
  i: Integer;
begin
  for I := 0 to kerning_subtables_collection.Count - 1 do
    TObject(kerning_subtables_collection[i]).Free;

  kerning_subtables_collection.Free;
  inherited;
end;

procedure KerningTableClass.ChangeEndian;
    begin
        self.kerning_table_header.nTables := TTF_Helpers.SwapUInt16(self.kerning_table_header.nTables)
    end;

    function KerningTableClass.get_Item(idx: Cardinal): Smallint;
    var
      subtable: KerningSubtableClass;
    begin
      subtable := self.kerning_subtables_collection[0];
      Result := subtable.Item[idx];
    end;

    procedure KerningTableClass.Load(font: Pointer);
    var
       kerning_table_header: ^KerningTableHeader;
       i: Integer;
       subtable_ptr: Pointer;
       subtable: KerningSubtableClass;
    begin
        kerning_table_header := TTF_Helpers.Increment(font, self.entry.offset);
        self.kerning_table_header.nTables := kerning_table_header.nTables;
        self.ChangeEndian;

        subtable_ptr := TTF_Helpers.Increment(kerning_table_header, SizeOf(KerningTableHeader));
        i := 0;
        while ((i < self.kerning_table_header.nTables)) do
        begin
            subtable := KerningSubtableClass.Create(subtable_ptr);
            self.kerning_subtables_collection.Add(subtable);
            subtable_ptr := TTF_Helpers.Increment(subtable_ptr, subtable.Length);
            inc(i)
        end
    end;


    constructor KerningSubtableClass.Create(kerning_table_ptr: Pointer);
    var
      subtable: ^CommonKerningHeader;
      coverage_zero: ^FormatZero;
      pair_zero: ^FormatZeroPair;
      single_pair: ^FormatZeroPair;
      i: Integer;
      Val: Cardinal;
    begin
      zero_pairs := TDictionary<Cardinal,Smallint>.Create;
      subtable := kerning_table_ptr;
      self.common_header.Length := TTF_Helpers.SwapUInt16(subtable.Length);
      self.common_header.Coverage := TTF_Helpers.SwapUInt16(subtable.Coverage);
      if (self.common_header.Coverage <> 1) then
         Exit;
      coverage_zero := TTF_Helpers.Increment(subtable, SizeOf(subtable^));
      self.format_zero.nPairs := TTF_Helpers.SwapUInt16(coverage_zero.nPairs);
      self.format_zero.searchRange := TTF_Helpers.SwapUInt16(coverage_zero.searchRange);
      self.format_zero.entrySelector := TTF_Helpers.SwapUInt16(coverage_zero.entrySelector);
      self.format_zero.rangeShift := TTF_Helpers.SwapUInt16(coverage_zero.rangeShift);

//      pair_zero := TTF_Helpers.Increment( coverage_zero, SizeOf(FormatZero));
      i := 0;
      single_pair := TTF_Helpers.Increment( kerning_table_ptr, SizeOf(FormatZero)) ;
      while ((i < self.format_zero.nPairs)) do
      begin
          Val := TTF_Helpers.SwapUInt32(single_pair.key_value);
          if not self.zero_pairs.ContainsKey(Val) then
            self.zero_pairs.Add(Val, TTF_Helpers.SwapInt16(single_pair.value));
//          self.zero_pairs.Items[] := );
//          kerning_table_ptr := kerning_table_ptr + SizeOf(single_pair);
          Inc(single_pair);
          inc(i)
      end

    end;

destructor KerningSubtableClass.Destroy;
begin
  zero_pairs.Free;
  inherited;
end;

function KerningSubtableClass.get_Item(inx: Cardinal): Smallint;
    begin
      Result := 0;
      if zero_pairs.ContainsKey(inx) then
        Result := zero_pairs.Items[inx];
    end;
{$HINTS ON}
end.
