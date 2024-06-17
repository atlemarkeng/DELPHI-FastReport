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

unit FMX.frxNameTableClass;

interface uses  FMX.TTFHelpers, FMX.frxFontHeaderClass, FMX.frxTrueTypeTable;

type
  NameID = (CompatibleFull=$12, CopyrightNotice=0, Description=10, Designer=9,
  FamilyName=1, FullName=4, LicenseDescription=13, LicenseInfoURL=14,
  Manufacturer=8, PostscriptCID=20, PostscriptName=6, PreferredFamily=$10,
  PreferredSubFamily=$11, SampleText=$13, SubFamilyName=2, Trademark=7,
  UniqueID=3, URL_Designer=12, URL_Vendor=11, Version=5, WWS_Family_Name=$15,
  WWS_SubFamily_Name=$16);

  NamingTableHeader = packed record
  public
    TableVersion: Word;
    Count: Word;
    stringOffset: Word;
  end;

  NamingRecord = packed record
    public 
	  PlatformID: Word;
      EncodingID: Word;
      LanguageID: Word;
      NameID: Word;
      Length: Word;
      Offset: Word;
  end;

  NameTableClass = class(TrueTypeTable)
    // Fields
    private 
		name_header: NamingTableHeader;
		namerecord_ptr: Pointer;
		string_storage_ptr: Pointer;

    // Methods
    public constructor Create(src: TrueTypeTable);
    strict private procedure ChangeEndian;
    public procedure Load(font: Pointer); override;
    strict private function  get_Item(Index: NameID): string;

    // Properties
    public property Item[Index: NameID]: string read get_Item;
  end;

  implementation

  constructor NameTableClass.Create(src: TrueTypeTable);
  begin
      inherited Create(src);
  end;

  function  NameTableClass.get_Item(Index: NameID): string;
  var
    i,sz:  Integer;
    name_record_ptr: ^NamingRecord;
    name_rec: NamingRecord;
    string_ptr: Pointer;

    p: PAnsiChar;

  begin
    Result := '';
    name_record_ptr := namerecord_ptr;
    for i := 0 to name_header.Count do
    begin
      name_rec.PlatformID := SwapUInt16(name_record_ptr.PlatformID);
      name_rec.EncodingID := SwapUInt16(name_record_ptr.EncodingID);
      name_rec.LanguageID := SwapUInt16(name_record_ptr.LanguageID);
      name_rec.NameID := SwapUInt16(name_record_ptr.NameID);
      name_rec.Length := SwapUInt16(name_record_ptr.Length);
      name_rec.Offset := SwapUInt16(name_record_ptr.Offset);

      if (((name_rec.PlatformID = 3) and (name_rec.EncodingID = 1))
            or (name_rec.PlatformID = 0)) and (NameID(name_rec.NameID) = Index) then
      begin
        { Dirty dirty hack with +1 }
        string_ptr := TTF_Helpers.Increment(string_storage_ptr, name_rec.Offset + 1);
        GetMem(p, name_rec.Length);
        sz := LocaleCharsFromUnicode( DefaultSystemCodePage, 0, string_ptr, name_rec.Length Div 2, p, name_rec.Length, nil, nil);
        Result := String(p);
        if sz > 0 then SetLength(Result, sz);
        FreeMem(p, name_rec.Length);
        Exit
      end;
      Inc(name_record_ptr);
    end;
  end;

  procedure NameTableClass.ChangeEndian;
  begin
    self.name_header.Count := TTF_Helpers.SwapUInt16(self.name_header.Count);
    self.name_header.stringOffset := TTF_Helpers.SwapUInt16(self.name_header.stringOffset);
    self.name_header.TableVersion := TTF_Helpers.SwapUInt16(self.name_header.TableVersion);
  end;

  procedure NameTableClass.Load(font: Pointer);
  var
    pNTH:               ^NamingTableHeader;
  begin
    pNTH := TTF_Helpers.Increment( font, self.entry.offset );
    name_header.TableVersion  := pNTH.TableVersion;
    name_header.stringOffset  := pNTH.stringOffset;
    name_header.Count         := pNTH.Count;
    ChangeEndian;
    namerecord_ptr := Pointer(NativeInt(pNTH) + SizeOf(NamingTableHeader));
    string_storage_ptr := Pointer(NativeInt(pNTH) + name_header.stringOffset);
  end;

end.
