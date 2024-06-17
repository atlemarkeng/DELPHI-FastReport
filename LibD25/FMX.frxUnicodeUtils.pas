{*******************************************************}
{    The Delphi Unicode Controls Project                }
{                                                       }
{      http://home.ccci.org/wolbrink                    }
{                                                       }
{ Copyright (c) 2002, Troy Wolbrink (wolbrink@ccci.org) }
{                                                       }
{*******************************************************}

unit FMX.frxUnicodeUtils;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.Classes, System.Types, System.SysUtils, System.WideStrings;

type
  UINT = LongWord;
  {$EXTERNALSYM UINT}
  TWString = record
    WString: WideString;
    Obj: TObject;
  end;

  TfrxWideStrings = class(TWideStrings)
  private
    FWideStringList: TList;
    procedure ReadData(Reader: TReader);
    procedure ReadDataWOld(Reader: TReader);
    procedure ReadDataW(Reader: TReader);
    procedure WriteDataW(Writer: TWriter);
  protected
    function Get(Index: Integer): WideString; override;
    procedure Put(Index: Integer; const S: WideString); override;
    function GetObject(Index: Integer): TObject; override;
    procedure PutObject(Index: Integer; Value: TObject); override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetTextStr: WideString; override;
    procedure SetTextStr(const Value: WideString); override;
    function GetCount: Integer; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    function Add(const S: WideString): Integer; override;
    procedure AddStrings(Strings: TWideStrings); override;
    function AddObject(const S: WideString; AObject: TObject): Integer; override;
    function IndexOf(const S: WideString): Integer; override;
    procedure Insert(Index: Integer; const S: WideString); override;
    procedure LoadFromFile(const FileName: WideString); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure LoadFromWStream(Stream: TStream);
    procedure SaveToFile(const FileName: WideString); override;
    procedure SaveToStream(Stream: TStream); override;
    property Objects[Index: Integer]: TObject read GetObject write PutObject;
    property Strings[Index: Integer]: WideString read Get write Put; default;
    property Text: WideString read GetTextStr write SetTextStr;
  end;


implementation

const
  sLineBreak = #13#10;
  WideLineSeparator = WideChar($2028);
  NameValueSeparator = '=';


{ TWideStrings }
constructor TfrxWideStrings.Create;
begin
  FWideStringList := TList.Create;
end;

destructor TfrxWideStrings.Destroy;
begin
  Clear;
  FWideStringList.Free;
  inherited;
end;

procedure TfrxWideStrings.Clear;
var
  Index: Integer;
  PWStr: ^TWString;
begin
  for Index := 0 to FWideStringList.Count-1 do
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      Dispose(PWStr);
  end;
  FWideStringList.Clear;
end;

function TfrxWideStrings.Get(Index: Integer): WideString;
var
  PWStr: ^TWString;
begin
  Result := '';
  if ( (Index >= 0) and (Index < FWideStringList.Count) ) then
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      Result := PWStr^.WString;
  end;
end;

procedure TfrxWideStrings.Put(Index: Integer; const S: WideString);
begin
  Insert(Index, S);
end;

function TfrxWideStrings.GetObject(Index: Integer): TObject;
var
  PWStr: ^TWString;
begin
  Result := nil;
  if ( (Index >= 0) and (Index < FWideStringList.Count) ) then
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      Result := PWStr^.Obj;
  end;
end;

procedure TfrxWideStrings.PutObject(Index: Integer; Value: TObject);
var
  PWStr: ^TWString;
begin
  if ( (Index >= 0) and (Index < FWideStringList.Count) ) then
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      PWStr^.Obj := Value;
  end;
end;

function TfrxWideStrings.Add(const S: WideString): Integer;
var
  PWStr: ^TWString;
begin
  New(PWStr);
  PWStr^.WString := S;
  PWStr^.Obj := nil;
  Result := FWideStringList.Add(PWStr);
end;

procedure TfrxWideStrings.Delete(Index: Integer);
var
  PWStr: ^TWString;
begin
  PWStr := FWideStringList.Items[Index];
  if PWStr <> nil then
    Dispose(PWStr);
  FWideStringList.Delete(Index);
end;

function TfrxWideStrings.IndexOf(const S: WideString): Integer;
var
  Index: Integer;
  PWStr: ^TWString;
begin
  Result := -1;
  for Index := 0 to FWideStringList.Count -1 do
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
    begin
      if S = PWStr^.WString then
      begin
        Result := Index;
        break;
      end;
    end;
  end;
end;

function TfrxWideStrings.GetCount: Integer;
begin
  Result := FWideStringList.Count;
end;

procedure TfrxWideStrings.Insert(Index: Integer; const S: WideString);
var
  PWStr: ^TWString;
begin
  if((Index < 0) or (Index > FWideStringList.Count)) then
    raise Exception.Create('Wide String Out of Bounds');
  if Index < FWideStringList.Count then
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      PWStr.WString := S;
  end
  else
    Add(S);
end;

procedure TfrxWideStrings.AddStrings(Strings: TWideStrings);
var
  I: Integer;
begin
  for I := 0 to Strings.Count - 1 do
    AddObject(Strings[I], Strings.Objects[I]);
end;

function TfrxWideStrings.AddObject(const S: WideString; AObject: TObject): Integer;
begin
  Result := Add(S);
  PutObject(Result, AObject);
end;

procedure TfrxWideStrings.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TWideStrings then
  begin
    Clear;
    AddStrings(TWideStrings(Source));
  end
  else if Source is TStrings then
  begin
    Clear;
    for I := 0 to TStrings(Source).Count - 1 do
      AddObject(TStrings(Source)[I], TStrings(Source).Objects[I]);
  end
  else
    inherited Assign(Source);
end;

procedure TfrxWideStrings.AssignTo(Dest: TPersistent);
var
  I: Integer;
begin
  if Dest is TWideStrings then
    Dest.Assign(Self)
  else if Dest is TStrings then
  begin
    TStrings(Dest).BeginUpdate;
    try
      TStrings(Dest).Clear;
      for I := 0 to Count - 1 do
        TStrings(Dest).AddObject(Strings[I], Objects[I]);
    finally
      TStrings(Dest).EndUpdate;
    end;
  end
  else
    inherited AssignTo(Dest);
end;

procedure TfrxWideStrings.DefineProperties(Filer: TFiler);
begin
  // compatibility
  Filer.DefineProperty('Strings', ReadData, nil, Count > 0);
  Filer.DefineProperty('UTF8', ReadDataWOld, nil, Count > 0);
  Filer.DefineProperty('UTF8W', ReadDataW, WriteDataW, Count > 0);
end;

function TfrxWideStrings.GetTextStr: WideString;
var
  I, L, Size, Count: Integer;
  P: PWideChar;
  S, LB: WideString;
begin
  Count := FWideStringList.Count;
  Size := 0;
  LB := sLineBreak;
  for I := 0 to Count - 1 do Inc(Size, Length(Get(I)) + Length(LB));
  SetString(Result, nil, Size);
  P := Pointer(Result);
  for I := 0 to Count - 1 do
  begin
    S := Get(I);
    L := Length(S);
    if L <> 0 then
    begin
      System.Move(Pointer(S)^, P^, L * SizeOf(WideChar));
      Inc(P, L);
    end;
    L := Length(LB);
    if L <> 0 then
    begin
      System.Move(Pointer(LB)^, P^, L * SizeOf(WideChar));
      Inc(P, L);
    end;
  end;
end;

procedure TfrxWideStrings.LoadFromFile(const FileName: WideString);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TfrxWideStrings.LoadFromStream(Stream: TStream);
var
  Size: Integer;
  S: WideString;
  ansiS: String;
  sign: Word;
begin
  Size := Stream.Size - Stream.Position;
  sign := 0;
  if Size > 2 then
    Stream.Read(sign, 2);

  if sign = $FEFF then
  begin
    Dec(Size, 2);
    SetLength(S, Size div 2);
    Stream.Read(S[1], Size);
    SetTextStr(S);
  end
  else
  begin
    Stream.Seek(-2, soFromCurrent);
    SetLength(ansiS, Size);
    Stream.Read(ansiS[1], Size);
    SetTextStr(ansiS);
  end;
end;

procedure TfrxWideStrings.LoadFromWStream(Stream: TStream);
var
  Size: Integer;
  S: WideString;
begin
  Size := Stream.Size - Stream.Position;
  SetLength(S, Size div 2);
  Stream.Read(S[1], Size);
  SetTextStr(S);
end;

procedure TfrxWideStrings.ReadData(Reader: TReader);
begin
  Clear;
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    if Reader.NextValue in [vaString, vaLString] then
      Add(Reader.ReadString) {TStrings compatiblity}
    else
      Add(Reader.ReadWideString);
  Reader.ReadListEnd;
end;

procedure TfrxWideStrings.ReadDataW(Reader: TReader);
begin
  Clear;
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    Add(Reader.ReadString);
  Reader.ReadListEnd;
end;

procedure TfrxWideStrings.ReadDataWOld(Reader: TReader);
begin
  Clear;
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    Add(Utf8Decode(AnsiString(Reader.ReadString)));
  Reader.ReadListEnd;
end;

procedure TfrxWideStrings.SaveToFile(const FileName: WideString);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TfrxWideStrings.SaveToStream(Stream: TStream);
var
  SW: WideString;
begin
  SW := GetTextStr;
  Stream.WriteBuffer(PWideChar(SW)^, Length(SW) * SizeOf(WideChar));
end;

procedure TfrxWideStrings.SetTextStr(const Value: WideString);
var
  P, Start: PWideChar;
  S: WideString;
begin
  Clear;
  P := Pointer(Value);
  if P <> nil then
    while P^ <> #0 do
    begin
      Start := P;
      while not (CharInSet(P^, [WideChar(#0), WideChar(#10), WideChar(#13)])) and (P^ <> WideLineSeparator) do
        Inc(P);
      SetString(S, Start, P - Start);
      Add(S);
      if P^ = #13 then Inc(P);
      if P^ = #10 then Inc(P);
      if P^ = WideLineSeparator then Inc(P);
    end;
end;

procedure TfrxWideStrings.WriteDataW(Writer: TWriter);
var
  I: Integer;
begin
  Writer.WriteListBegin;
  for I := 0 to Count - 1 do
    Writer.WriteString(Get(I));
  Writer.WriteListEnd;
end;

end.

