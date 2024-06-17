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

unit FMX.frxTrueTypeCollection;
{$I frx.inc}
interface uses System.Classes, System.SysUtils, System.UITypes, FMX.Types, FMX.Objects,
  FMX.TTFHelpers, FMX.frxTrueTypeFont, FMX.frxFontHeaderClass, FMX.frxNameTableClass
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};

type // Nested Types

  TFontCollection = TList;
  TTCollectionHeader = packed record
      public TTCTag: Cardinal;
      public Version: Cardinal;
      public numFonts: Cardinal;
  end;

  TrueTypeCollection = class(TTF_Helpers)
    // Fields
    strict private fonts_collection: TFontCollection;

    private function get_FontCollection: TFontCollection;
    private function get_Item(FamilyName: string): TrueTypeFont;
    private function get_FamilyItem(FamilyName: string): TrueTypeFont;

    // Methods
    public constructor Create;
    public procedure Initialize(FD: PAnsiChar; FontDataSize: Longint);
    public function PackFont(font: Tfont; UsedAlphabet: TList; sStream: TStream) : TByteArray;

    // Properties
    public property FontCollection: TFontCollection read get_FontCollection;
    public property Item[FamilyName: string]: TrueTypeFont read get_Item;
    public property FamilyItem[FamilyName: string]: TrueTypeFont read get_FamilyItem;
  end;

const
    // You may put national font names here
    Elements =10;
    Substitutes  : array  [1..Elements] of AnsiString = (
      'ＭＳ ゴシック',        'MS Gothic',
      'ＭＳ Ｐゴシック',     'MS PGothic',
      'ＭＳ 明朝',              'MS Mincho',
      'ＭＳ Ｐ明朝',           'MS PMincho',
      'メイリオ',               'Meiryo'
    );

implementation

function TrueTypeCollection.get_FamilyItem(FamilyName: string): TrueTypeFont;
  var
    font: TrueTypeFont;
    nt: NameTableClass;
    s : String;
    i:  Integer;
  begin
    Result := nil;
    for i := 0 to fonts_collection.Count - 1 do
    begin
      font := TrueTypeFont(fonts_collection[i]);
      nt := font.Names;
      s := nt.Item[NameID.FamilyName];
      if s = FamilyName then
      begin
        Result := font;
        break
      end;
    end;
    if  Result = nil then raise Exception.Create('Font not found in collection');
  end;

function TrueTypeCollection.get_FontCollection: TFontCollection;
  begin
    Result := fonts_collection;
  end;

  function TrueTypeCollection.get_Item(FamilyName: string): TrueTypeFont;
  var
    font: TrueTypeFont;
    nt: NameTableClass;
    s : String;
    i:  Integer;
  begin
    Result := nil;
    for i := 0 to fonts_collection.Count - 1 do
    begin
      font := TrueTypeFont(fonts_collection[i]);
      nt := font.Names;
      s := nt.Item[NameID.FullName];
      if s = FamilyName then
      begin
        Result := font;
        break
      end;
    end;
    if  Result = nil then raise Exception.Create('Font not found in collection');
  end;


  constructor TrueTypeCollection.Create;
  begin
    self.fonts_collection := TFontCollection.Create;
  end;

  procedure TrueTypeCollection.Initialize(FD: PAnsiChar; FontDataSize: Longint);
  var
    CollectionMode:   FontType;
    i: Integer;
    f: TrueTypeFont;
    pch: ^TTCollectionHeader;
    ch: TTCollectionHeader;
    subfont_table: ^Cardinal;
    subfont_idx: Cardinal;
    subfont_ptr: Pointer;
  begin
    if (FD[0] = AnsiChar(0)) and (FD[1] = AnsiChar(1)) and (FD[2] = AnsiChar(0)) and (FD[3] = AnsiChar(0)) then
      CollectionMode := FontType.TrueTypeFontType
    else if (FD[0] = 't') and (FD[1] = 't') and (FD[2] = 'c') and (FD[3] = 'f') then
      CollectionMode := FontType.TrueTypeCollection
    else
      raise Exception.Create('TrueType font format error');

    if (CollectionMode = FontType.TrueTypeFontType) then
    begin
      f := TrueTypeFont.Create( Pointer(FD), Pointer(FD), ChecksumFaultAction.Warn);
      self.fonts_collection.Add( f )
    end else begin
        pch := Pointer(FD);
        ch.TTCTag := TTF_Helpers.SwapUInt32(pch.TTCTag);
        ch.Version := TTF_Helpers.SwapUInt32(pch.Version);
        ch.numFonts := TTF_Helpers.SwapUInt32(pch.numFonts);
        case ch.Version of
        $10000: subfont_table := TTF_Helpers.Increment( pch, 12 ); // Version 1
        $20000: subfont_table := TTF_Helpers.Increment( pch, 12 ); // Version 2
        else raise Exception.Create('Unknown font collection version');
        end;

        i := 0;
        while i < ch.numFonts do
        begin
            subfont_idx := TTF_Helpers.SwapUInt32( subfont_table^ );
            subfont_ptr := TTF_Helpers.Increment( FD, subfont_idx);
            f := TrueTypeFont.Create(FD, subfont_ptr, ChecksumFaultAction.Warn);
            self.fonts_collection.Add( f );
            inc(i);
            inc( subfont_table, 1)
        end
    end
  end;

  function TrueTypeCollection.PackFont( font: Tfont; UsedAlphabet: TList; sStream: TStream) : TByteArray;
  var
    i, j:       Integer;
    ttf:       TrueTypeFont;
    skip_list:  TList;
    ch:         Char;
    s:          String;
    Name:       String;
    Style:      TFontStyles;
    // -----------
    Transform:   WideString;
  begin
    Result := nil;
    skip_list := TList.Create;
    skip_list.Add( Pointer(TablesID.EmbedBitmapLocation));
    skip_list.Add( Pointer(TablesID.EmbededBitmapData));
    skip_list.Add( Pointer(TablesID.HorizontakDeviceMetrix));
    skip_list.Add( Pointer(TablesID.VerticalDeviceMetrix));
    skip_list.Add( Pointer(TablesID.DigitalSignature));

    Name := font.Family;

    i := 1;
    while i <= ((High(Substitutes)-Low(Substitutes)) ) do
    begin
      Transform := UTF8Decode(Substitutes[i]);
      if Transform = Name then
      begin
        Name := Substitutes[i+1];
        break;
      end;
      i := i + 2;
    end;

    if TFontStyle.fsBold in font.Style   then Name := Name + ' Bold';
    if TFontStyle.fsItalic in font.Style then Name := Name + ' Italic';

    for i := 0 to Self.fonts_collection.Count - 1 do
    begin
      ttf := TrueTypeFont(Self.fonts_collection[i]);
      if not ttf.IsLoaded then
        ttf.PrepareFont( skip_list );
      s := ttf.Names.Item[NameID.FullName];
      if s = Name then
      begin
        break;
      end;
    end;

    for j := 0 to UsedAlphabet.Count - 1 do
    begin
      ch := Char(UsedAlphabet[j]);
      ttf.AddCharacterToKeepList(ch);
    end;
    Result := ttf.PackFont(FontType.TrueTypeFontType, True, sStream);

    skip_list.Free;
  end;

end.
