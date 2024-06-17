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
unit FMX.frxTrueTypeTable;
interface

uses FMX.TTFHelpers;

type // Nested Types

  TableEntry = packed record
      public tag: Cardinal;
      public checkSum: Cardinal;
      public offset: Cardinal;
      public length: Cardinal;
  end;

  TrueTypeTable = class(TTF_Helpers)
    // Fields
    strict protected entry: TableEntry;

    // Methods
    public constructor Create(parent: TrueTypeTable); overload;
    public constructor Create(entry_ptr: Pointer); overload;
    strict private procedure ChangeEndian;
    protected procedure Load(font: Pointer); virtual;
    public function Save(font: Pointer; offset: Cardinal): Cardinal; virtual;
    public function StoreDescriptor(descriptor_ptr: Pointer): Pointer;
    strict private function StoreTable(source_ptr: Pointer; destination_ptr: Pointer; output_offset: Cardinal): Cardinal;
    strict private function get_TAGLINE: string;
    strict private procedure set_length(length: Cardinal);
    strict private procedure set_offset(offset: Cardinal);

    // Properties
    public property length: Cardinal read entry.length write set_length;
    public property offset: Cardinal read entry.offset write set_offset;
    public property checkSum: Cardinal read entry.checkSum write entry.checkSum;
    public property tag: Cardinal read entry.tag write entry.tag;
    public property TAGLINE: string read get_TAGLINE;
    { to do
    public property descriptor_size: Integer read get_descriptor_size;
    }

end;

implementation uses System.Classes;

    function TrueTypeTable.get_TAGLINE: string;
    var
      s: string;
      c: char;
      tag: cardinal;
    begin
      SetLength(s, 4);
      tag := entry.tag;
      c := Char(tag mod $100);
      tag := tag div $100;
      s[1] := c;
      c := Char(tag mod $100);
      tag := tag div $100;
      s[2] := c;
      c := Char(tag mod $100);
      tag := tag div $100;
      s[3] := c;
      c := Char(tag mod $100);
      tag := tag div $100;
      s[4] := c;
      Result := s;
    end;

    procedure TrueTypeTable.set_length(length: Cardinal);
    begin
      self.entry.length := length;
    end;

    procedure TrueTypeTable.set_offset(offset: Cardinal);
    begin
      self.entry.offset := offset;
    end;

    constructor TrueTypeTable.Create(parent: TrueTypeTable);
    begin
        self.entry := parent.entry
    end;

    constructor TrueTypeTable.Create(entry_ptr: Pointer);
    var
      table_ptr: ^TableEntry;
    begin
        table_ptr := entry_ptr;
        self.entry.checkSum := table_ptr.checkSum;
        self.entry.length := table_ptr.length;
        self.entry.offset := table_ptr.offset;
        self.entry.tag := table_ptr.tag;
        self.ChangeEndian;
    end;

    procedure TrueTypeTable.ChangeEndian;
    begin
        self.entry.checkSum := TTF_Helpers.SwapUInt32(self.entry.checkSum);
        self.entry.offset := TTF_Helpers.SwapUInt32(self.entry.offset);
        self.entry.length := TTF_Helpers.SwapUInt32(self.entry.length)
    end;

    procedure TrueTypeTable.Load(font: Pointer);
    begin

    end;

    function TrueTypeTable.Save(font: Pointer; offset: Cardinal): Cardinal;
//    begin
//       Result := self.StoreTable(font, font, offset)
//    end;
    var
      out_ms: TMemoryStream;
      name: string;
      length: Integer;
      buffer: Pointer;
    begin
        Result := self.StoreTable(font, font, offset);

        begin
          length := Integer((self.entry.length + 3) Div 4) * 4;
          buffer := TTF_Helpers.Increment(font, self.entry.offset);

{$IFDEF DEBUG_FONT}
          out_ms := TMemoryStream.Create; // Debug issue
          with out_ms do begin
            SetSize(length);
            CopyMemory(out_ms.Memory, buffer, length);
          end;
          if Self.get_TAGLINE = 'OS/2' then
            name := 'C:\TEMP\FONT\OS2'
          else
            name := 'C:\TEMP\FONT\' + Self.get_TAGLINE;
          out_ms.SaveToFile(name);
          out_ms.Clear;
          out_ms.Free;
{$ENDIF}
        end;
    end;

    function TrueTypeTable.StoreDescriptor(descriptor_ptr: Pointer): Pointer;
    var
      table_ptr: ^TableEntry;
    begin
        self.ChangeEndian;
        table_ptr := descriptor_ptr;
        table_ptr.checkSum := self.entry.checkSum;
        table_ptr.length := self.entry.length;
        table_ptr.offset := self.entry.offset;
        table_ptr.tag := self.entry.tag;
        self.ChangeEndian;
        Result := TTF_Helpers.Increment(descriptor_ptr, SizeOf(TableEntry))
    end;

    function TrueTypeTable.StoreTable(source_ptr: Pointer; destination_ptr: Pointer; output_offset: Cardinal): Cardinal;
    var
      src, dst, buffer: Pointer;
      length: Integer;
    begin
        length := Integer((self.entry.length + 3) Div 4) * 4;
        src := TTF_Helpers.Increment(source_ptr, self.entry.offset);
        dst := TTF_Helpers.Increment(destination_ptr, output_offset);
        if (src <> dst) then
        begin
            buffer := AllocMem(length);
            Move( src^, buffer^, length);
            Move( buffer^, dst^, length);
            FreeMem(buffer, length);
            self.entry.offset := output_offset
        end;
        output_offset := NativeInt(output_offset) + length;

        begin
            Result := output_offset;
            exit
        end
    end;
{$hints on}
end.

