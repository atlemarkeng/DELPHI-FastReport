
{******************************************}
{                                          }
{             FastReport v4.0              }
{         ZIP archiver support unit        }
{                                          }
{         Copyright (c) 2006-2008          }
{          by Alexander Fediachov,         }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit FMX.frxZip;

{$I frx.inc}

interface

uses System.Classes,
  ZLib, FMX.frxGZip, FMX.frxUtils, System.Types{, frxFileUtils}
  {$IFDEF MSWINDOWS}
  , Winapi.Windows
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  , Posix.SysTime, Posix.SysTypes, Posix.Time, Posix.Utime
{$ENDIF POSIX};

type
  TfrxZipLocalFileHeader = class;
  TfrxZipCentralDirectory = class;
  TfrxZipFileHeader = class;

  TfrxZipArchive = class(TObject)
  private
    FRootFolder: AnsiString;
    FErrors: TStringList;
    FFileList: TStringList;
    FComment: AnsiString;
    FProgress: TNotifyEvent;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure AddFile(const FileName: AnsiString);
    procedure AddDir(const DirName: AnsiString);
    procedure SaveToFile(const Filename: AnsiString);
    procedure SaveToStream(const Stream: TStream);
    property Errors: TStringList read FErrors;
    property Comment: AnsiString read FComment write FComment;
    property RootFolder: AnsiString read FRootFolder write FRootFolder;
    property FileCount: Integer read GetCount;
    property OnProgress: TNotifyEvent read FProgress write FProgress;
  end;

  TfrxZipLocalFileHeader = class(TObject)
  private
    FLocalFileHeaderSignature: Longword;
    FVersion: WORD;
    FGeneralPurpose: WORD;
    FCompressionMethod: WORD;
    FCrc32: Longword;
    FLastModFileDate: WORD;
    FLastModFileTime: WORD;
    FCompressedSize: Longword;
    FUnCompressedSize: Longword;
    FExtraField: AnsiString;
    FFileName: AnsiString;
    FFileNameLength: WORD;
    FExtraFieldLength: WORD;
    procedure SetExtraField(const Value: AnsiString);
    procedure SetFileName(const Value: AnsiString);
  public
    constructor Create;
    procedure SaveToStream(const Stream: TStream);
    property LocalFileHeaderSignature: Longword read FLocalFileHeaderSignature;
    property Version: WORD read FVersion write FVersion;
    property GeneralPurpose: WORD read FGeneralPurpose write FGeneralPurpose;
    property CompressionMethod: WORD read FCompressionMethod write FCompressionMethod;
    property LastModFileTime: WORD read FLastModFileTime write FLastModFileTime;
    property LastModFileDate: WORD read FLastModFileDate write FLastModFileDate;
    property Crc32: Longword read FCrc32 write FCrc32;
    property CompressedSize: Longword read FCompressedSize write FCompressedSize;
    property UnCompressedSize: Longword read FUnCompressedSize write FUnCompressedSize;
    property FileNameLength: WORD read FFileNameLength write FFileNameLength;
    property ExtraFieldLength: WORD read FExtraFieldLength write FExtraFieldLength;
    property FileName: AnsiString read FFileName write SetFileName;
    property ExtraField: AnsiString read FExtraField write SetExtraField;
  end;

  TfrxZipCentralDirectory = class(TObject)
  private
    FEndOfChentralDirSignature: Longword;
    FNumberOfTheDisk: WORD;
    FTotalOfEntriesCentralDirOnDisk: WORD;
    FNumberOfTheDiskStartCentralDir: WORD;
    FTotalOfEntriesCentralDir: WORD;
    FSizeOfCentralDir: Longword;
    FOffsetStartingDiskDir: Longword;
    FComment: AnsiString;
    FCommentLength: WORD;
    procedure SetComment(const Value: AnsiString);
  public
    constructor Create;
    procedure SaveToStream(const Stream: TStream);
    property EndOfChentralDirSignature: Longword read FEndOfChentralDirSignature;
    property NumberOfTheDisk: WORD read FNumberOfTheDisk write FNumberOfTheDisk;
    property NumberOfTheDiskStartCentralDir: WORD
      read FNumberOfTheDiskStartCentralDir write FNumberOfTheDiskStartCentralDir;
    property TotalOfEntriesCentralDirOnDisk: WORD
      read FTotalOfEntriesCentralDirOnDisk write FTotalOfEntriesCentralDirOnDisk;
    property TotalOfEntriesCentralDir: WORD
      read FTotalOfEntriesCentralDir write FTotalOfEntriesCentralDir;
    property SizeOfCentralDir: Longword read FSizeOfCentralDir write FSizeOfCentralDir;
    property OffsetStartingDiskDir: Longword read FOffsetStartingDiskDir write FOffsetStartingDiskDir;
    property CommentLength: WORD read FCommentLength write FCommentLength;
    property Comment: AnsiString read FComment write SetComment;
  end;

  TfrxZipFileHeader = class(TObject)
  private
    FCentralFileHeaderSignature: Longword;
    FRelativeOffsetLocalHeader: Longword;
    FUnCompressedSize: Longword;
    FCompressedSize: Longword;
    FCrc32: Longword;
    FExternalFileAttribute: Longword;
    FExtraField: AnsiString;
    FFileComment: AnsiString;
    FFileName: AnsiString;
    FCompressionMethod: WORD;
    FDiskNumberStart: WORD;
    FLastModFileDate: WORD;
    FLastModFileTime: WORD;
    FVersionMadeBy: WORD;
    FGeneralPurpose: WORD;
    FFileNameLength: WORD;
    FInternalFileAttribute: WORD;
    FExtraFieldLength: WORD;
    FVersionNeeded: WORD;
    FFileCommentLength: WORD;
    procedure SetExtraField(const Value: AnsiString);
    procedure SetFileComment(const Value: AnsiString);
    procedure SetFileName(const Value: AnsiString);
  public
    constructor Create;
    procedure SaveToStream(const Stream: TStream);
    property CentralFileHeaderSignature: Longword read FCentralFileHeaderSignature;
    property VersionMadeBy: WORD read FVersionMadeBy;
    property VersionNeeded: WORD read FVersionNeeded;
    property GeneralPurpose: WORD read FGeneralPurpose write FGeneralPurpose;
    property CompressionMethod: WORD read FCompressionMethod write FCompressionMethod;
    property LastModFileTime: WORD read FLastModFileTime write FLastModFileTime;
    property LastModFileDate: WORD read FLastModFileDate write FLastModFileDate;
    property Crc32: Longword read FCrc32 write FCrc32;
    property CompressedSize: Longword read FCompressedSize write FCompressedSize;
    property UnCompressedSize: Longword read FUnCompressedSize write FUnCompressedSize;
    property FileNameLength: WORD read FFileNameLength write FFileNameLength;
    property ExtraFieldLength: WORD read FExtraFieldLength write FExtraFieldLength;
    property FileCommentLength: WORD read FFileCommentLength write FFileCommentLength;
    property DiskNumberStart: WORD read FDiskNumberStart write FDiskNumberStart;
    property InternalFileAttribute: WORD read FInternalFileAttribute write FInternalFileAttribute;
    property ExternalFileAttribute: Longword read FExternalFileAttribute write FExternalFileAttribute;
    property RelativeOffsetLocalHeader: Longword read FRelativeOffsetLocalHeader write FRelativeOffsetLocalHeader;
    property FileName: AnsiString read FFileName write SetFileName;
    property ExtraField: AnsiString read FExtraField write SetExtraField;
    property FileComment: AnsiString read FFileComment write SetFileComment;
  end;

  TfrxZipLocalFile = class(TObject)
  private
    FLocalFileHeader: TfrxZipLocalFileHeader;
    FFileData: TMemoryStream;
    FOffset: Longword;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SaveToStream(const Stream: TStream);
    property LocalFileHeader: TfrxZipLocalFileHeader read FLocalFileHeader;
    property FileData: TMemoryStream read FFileData write FFileData;
    property Offset: Longword read FOffset write FOffset;
  end;

implementation

uses System.SysUtils, AnsiStrings, System.IOUtils;

const
  ZIP_VERSIONMADEBY = 20;
  ZIP_NONE = 0;
  ZIP_DEFLATED = 8;
  ZIP_MINSIZE = 128;

{ TfrxZipLocalFile }

constructor TfrxZipLocalFile.Create;
begin
  FLocalFileHeader := TfrxZipLocalFileHeader.Create;
  FOffset := 0;
end;

destructor TfrxZipLocalFile.Destroy;
begin
  FLocalFileHeader.Free;
  inherited;
end;

procedure TfrxZipLocalFile.SaveToStream(const Stream: TStream);
begin
  FLocalFileHeader.SaveToStream(Stream);
  FFileData.Position := 0;
  FFileData.SaveToStream(Stream);
end;

{ TfrxZipLocalFileHeader }

constructor TfrxZipLocalFileHeader.Create;
begin
  inherited;
  FLocalFileHeaderSignature := $04034b50;
  FVersion := ZIP_VERSIONMADEBY;
  FGeneralPurpose := 0;
  FCompressionMethod := ZIP_NONE;
  FCrc32 := 0;
  FLastModFileDate := 0;
  FLastModFileTime := 0;
  FCompressedSize := 0;
  FUnCompressedSize := 0;
  FExtraField := '';
  FFileName := '';
  FFileNameLength := 0;
  FExtraFieldLength := 0;
end;

procedure TfrxZipLocalFileHeader.SaveToStream(const Stream: TStream);
begin
  Stream.Write(FLocalFileHeaderSignature, 4);
  Stream.Write(FVersion, 2);
  Stream.Write(FGeneralPurpose, 2);
  Stream.Write(FCompressionMethod, 2);
  Stream.Write(FLastModFileTime, 2);
  Stream.Write(FLastModFileDate, 2);
  Stream.Write(FCrc32, 4);
  Stream.Write(FCompressedSize, 4);
  Stream.Write(FUnCompressedSize, 4);
  Stream.Write(FFileNameLength, 2);
  Stream.Write(FExtraFieldLength, 2);
  if FFileNameLength > 0 then
    Stream.Write(FFileName[1], FFileNameLength);
  if FExtraFieldLength > 0 then
    Stream.Write(FExtraField[1], FExtraFieldLength);
end;

procedure TfrxZipLocalFileHeader.SetExtraField(const Value: AnsiString);
begin
  FExtraField := Value;
  FExtraFieldLength := Length(Value);
end;

procedure TfrxZipLocalFileHeader.SetFileName(const Value: AnsiString);
begin
  FFileName :=  StringReplace(Value,
    AnsiString('\'), AnsiString('/'), [rfReplaceAll]);
  FFileNameLength := Length(Value);
end;

{ TfrxZipCentralDirectory }

constructor TfrxZipCentralDirectory.Create;
begin
  inherited;
  FEndOfChentralDirSignature := $06054b50;
  FNumberOfTheDisk := 0;
  FNumberOfTheDiskStartCentralDir := 0;
  FTotalOfEntriesCentralDirOnDisk := 0;
  FTotalOfEntriesCentralDir := 0;
  FSizeOfCentralDir := 0;
  FOffsetStartingDiskDir := 0;
  FCommentLength := 0;
  FComment := '';
end;

procedure TfrxZipCentralDirectory.SaveToStream(const Stream: TStream);
begin
  Stream.Write(FEndOfChentralDirSignature, 4);
  Stream.Write(FNumberOfTheDisk, 2);
  Stream.Write(FNumberOfTheDiskStartCentralDir, 2);
  Stream.Write(FTotalOfEntriesCentralDirOnDisk, 2);
  Stream.Write(FTotalOfEntriesCentralDir, 2);
  Stream.Write(FSizeOfCentralDir, 4);
  Stream.Write(FOffsetStartingDiskDir, 4);
  Stream.Write(FCommentLength, 2);
  if FCommentLength > 0 then
    Stream.Write(FComment[1], FCommentLength);
end;

procedure TfrxZipCentralDirectory.SetComment(const Value: AnsiString);
begin
  FComment := Value;
  FCommentLength := Length(Value);
end;

{ TfrxZipFileHeader }

constructor TfrxZipFileHeader.Create;
begin
  FCentralFileHeaderSignature := $02014b50;
  FRelativeOffsetLocalHeader := 0;
  FUnCompressedSize := 0;
  FCompressedSize := 0;
  FCrc32 := 0;
  FExternalFileAttribute := 0;
  FExtraField := '';
  FFileComment := '';
  FFileName := '';
  FCompressionMethod := 0;
  FDiskNumberStart := 0;
  FLastModFileDate := 0;
  FLastModFileTime := 0;
  FVersionMadeBy := ZIP_VERSIONMADEBY;
  FGeneralPurpose := 0;
  FFileNameLength := 0;
  FInternalFileAttribute := 0;
  FExtraFieldLength := 0;
  FVersionNeeded := ZIP_VERSIONMADEBY;
  FFileCommentLength := 0;
end;

procedure TfrxZipFileHeader.SaveToStream(const Stream: TStream);
begin
  Stream.Write(FCentralFileHeaderSignature, 4);
  Stream.Write(FVersionMadeBy, 2);
  Stream.Write(FVersionNeeded, 2);
  Stream.Write(FGeneralPurpose, 2);
  Stream.Write(FCompressionMethod, 2);
  Stream.Write(FLastModFileTime, 2);
  Stream.Write(FLastModFileDate, 2);
  Stream.Write(FCrc32, 4);
  Stream.Write(FCompressedSize, 4);
  Stream.Write(FUnCompressedSize, 4);
  Stream.Write(FFileNameLength, 2);
  Stream.Write(FExtraFieldLength, 2);
  Stream.Write(FFileCommentLength, 2);
  Stream.Write(FDiskNumberStart, 2);
  Stream.Write(FInternalFileAttribute, 2);
  Stream.Write(FExternalFileAttribute, 4);
  Stream.Write(FRelativeOffsetLocalHeader, 4);
  Stream.Write(FFilename[1], FFileNameLength);
  Stream.Write(FExtraField[1], FExtraFieldLength);
  Stream.Write(FFileComment[1], FFileCommentLength);
end;

procedure TfrxZipFileHeader.SetExtraField(const Value: AnsiString);
begin
  FExtraField := Value;
  FExtraFieldLength := Length(Value);
end;

procedure TfrxZipFileHeader.SetFileComment(const Value: AnsiString);
begin
  FFileComment := Value;
  FFileNameLength := Length(Value);
end;

procedure TfrxZipFileHeader.SetFileName(const Value: AnsiString);
begin
  FFileName := StringReplace(Value,
    AnsiString('\'), AnsiString('/'), [rfReplaceAll]);
  FFileNameLength := Length(Value);
end;

{ TfrxZipArchive }

procedure TfrxZipArchive.AddDir(const DirName: AnsiString);
var
  SRec: TSearchRec;
  i: Integer;
  s: AnsiString;
begin
  if DirectoryExists(String(DirName)) then
  begin
    s := DirName;
    if s[Length(s)] <> '\' then
      s := s + '\';
    i := FindFirst(String(s) + '*.*', faDirectory + faArchive, SRec);
    try
      while i = 0 do
      begin
        if (SRec.Name <> '.') and (SRec.Name <> '..') then
        begin
          if (SRec.Attr and faDirectory) = faDirectory then
            AddDir(s + AnsiString(SRec.Name))
          else
            AddFile(s + AnsiString(SRec.Name));
        end;
        i := FindNext(SRec);
      end;
    finally
      FindClose(SRec);
    end;
  end;
end;

procedure TfrxZipArchive.AddFile(const FileName: AnsiString);
begin
  if FileExists(String(FileName)) then
  begin
    FFileList.Add(String(FileName));
    if FRootFolder = '' then
      FRootFolder := ExtractFilePath(FileName);
  end
  else
    FErrors.Add('File ' + String(FileName) + ' not found!');
end;

procedure TfrxZipArchive.Clear;
begin
  FErrors.Clear;
  FFileList.Clear;
  FRootFolder := '';
  FComment := '';
end;

constructor TfrxZipArchive.Create;
begin
  FProgress := nil;
  FErrors := TStringList.Create;
  FFileList := TStringList.Create;
  Clear;
end;

destructor TfrxZipArchive.Destroy;
begin
  FErrors.Free;
  FFileList.Free;
  inherited;
end;

function TfrxZipArchive.GetCount: Integer;
begin
  Result := FFileList.Count;
end;

procedure TfrxZipArchive.SaveToFile(const FileName: AnsiString);
var
  f: TFileStream;
begin
  f := TFileStream.Create(String(FileName), fmCreate);
  try
    SaveToStream(f);
  finally
    f.Free;
  end;
end;

procedure TfrxZipArchive.SaveToStream(const Stream: TStream);
var
  i: Integer;
  ZipFile: TfrxZipLocalFile;
  ZipFileHeader: TfrxZipFileHeader;
  ZipDir: TfrxZipCentralDirectory;
  FileStream: TFileStream;
  TempStream: TMemoryStream;
  FileName: AnsiString;
  CentralStartPos, CentralEndPos: Longword;



LFT: Integer;
begin
  for i := 0 to FFileList.Count - 1 do
  begin
    ZipFile := TfrxZipLocalFile.Create;
    ZipFile.FileData := TMemoryStream.Create;
    try
      FileName := StringReplace(AnsiString(FFileList[i]), FRootFolder, AnsiString(''), []);
      ZipFile.LocalFileHeader.FileName := FileName;
      FileStream := TFileStream.Create(FFileList[i], fmOpenRead + fmShareDenyWrite);
      try
        if FileStream.Size > ZIP_MINSIZE then
        begin
          FileStream.Position := 0;
          TempStream := TMemoryStream.Create;
          try
            frxDeflateStream(FileStream, TempStream);
            TempStream.Position := 2;
            ZipFile.FileData.CopyFrom(TempStream, TempStream.Size - 6);
          finally
            TempStream.Free;
          end;
          ZipFile.LocalFileHeader.CompressionMethod := ZIP_DEFLATED;
        end
        else
        begin
          ZipFile.FileData.CopyFrom(FileStream, 0);
          ZipFile.LocalFileHeader.CompressionMethod := ZIP_NONE;
        end;
        ZipFile.LocalFileHeader.CompressedSize := ZipFile.FileData.Size;
        ZipFile.LocalFileHeader.UnCompressedSize := FileStream.Size;
        TempStream := TMemoryStream.Create;
        try
          TempStream.CopyFrom(FileStream, 0);
          ZipFile.LocalFileHeader.Crc32 := frxStreamCRC32(TempStream);
        finally
          TempStream.Free;
        end;
        ZipFile.Offset := Stream.Position;

        LFT := FileGetDate(FileStream.Handle);

        {$IFNDEF STATIC_EXPORTING_RESULTS}
        ZipFile.LocalFileHeader.LastModFileDate := Hi(LFT);
        ZipFile.LocalFileHeader.LastModFileTime := Lo(LFT);
        {$ENDIF}
      finally
        FileStream.Free;
      end;
      ZipFile.SaveToStream(Stream);
      if Assigned(FProgress) then
        FProgress(Self);
    finally
      ZipFile.FileData.Free;
      ZipFile.FileData := nil;
    end;
    FFileList.Objects[i] := ZipFile;
  end;
  CentralStartPos := Stream.Position;
  for i := 0 to FFileList.Count - 1 do
  begin
    ZipFile := TfrxZipLocalFile(FFileList.Objects[i]);
    ZipFileHeader := TfrxZipFileHeader.Create;
    try
      ZipFileHeader.CompressionMethod := ZipFile.LocalFileHeader.CompressionMethod;
      ZipFileHeader.LastModFileTime := ZipFile.LocalFileHeader.LastModFileTime;
      ZipFileHeader.LastModFileDate := ZipFile.LocalFileHeader.LastModFileDate;
      ZipFileHeader.GeneralPurpose := ZipFile.LocalFileHeader.GeneralPurpose;
      ZipFileHeader.Crc32 := ZipFile.LocalFileHeader.Crc32;
      ZipFileHeader.CompressedSize := ZipFile.LocalFileHeader.CompressedSize;
      ZipFileHeader.UnCompressedSize := ZipFile.LocalFileHeader.UnCompressedSize;
      ZipFileHeader.RelativeOffsetLocalHeader := ZipFile.Offset;
      ZipFileHeader.FileName := ZipFile.LocalFileHeader.FileName;
      ZipFileHeader.SaveToStream(Stream);
    finally
      ZipFileHeader.Free;
    end;
    ZipFile.Free;
  end;
  CentralEndPos := Stream.Position;
  ZipDir := TfrxZipCentralDirectory.Create;
  try
    ZipDir.TotalOfEntriesCentralDirOnDisk := FFileList.Count;
    ZipDir.TotalOfEntriesCentralDir := FFileList.Count;
    ZipDir.SizeOfCentralDir := CentralEndPos - CentralStartPos;
    ZipDir.OffsetStartingDiskDir := CentralStartPos;
    ZipDir.SaveToStream(Stream);
  finally
    ZipDir.Free;
  end;
end;

end.