
{******************************************}
{                                          }
{             FastReport v4.0              }
{                CSV export                }
{                                          }
{         Copyright (c) 1998-2008          }
{          by Alexander Fediachov,         }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

{ The specification of the CSV document file format
  can be downloaded from here:

  http://www.rfc-editor.org/rfc/rfc4180.txt }

unit FMX.frxExportCSV;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Forms, FMX.Dialogs,
  FMX.frxClass, FMX.frxExportMatrix, FMX.Edit, FMX.Types
, System.Variants, FMX.Controls, FMX.frxBaseModalForm
{$IFDEF DELPHI18}
  , FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};

type
  TfrxCSVExportDialog = class(TfrxForm)
    OkB: TButton;
    CancelB: TButton;
    SaveDialog1: TSaveDialog;
    GroupPageRange: TGroupBox;
    DescrL: TLabel;
    AllRB: TRadioButton;
    CurPageRB: TRadioButton;
    PageNumbersRB: TRadioButton;
    PageNumbersE: TEdit;
    GroupQuality: TGroupBox;
    OpenCB: TCheckBox;
    OEMCB: TCheckBox;
    SeparatorLB: TLabel;
    SeparatorE: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure PageNumbersEChange(Sender: TObject);
    procedure PageNumbersEKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxCSVExport = class(TfrxCustomExportFilter)
  private

    FMatrix: TfrxIEMatrix;
    FOpenAfterExport: Boolean;
    Exp: TStream;
    FPage: TfrxReportPage;
    FOEM: Boolean;
    FSeparator: String;
    FNoSysSymbols: Boolean;
    FForcedQuotes: Boolean;

    procedure ExportPage(Stream: TStream);

  public

    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    function ShowModal: TModalResult; override;
    function Start: Boolean; override;
    procedure Finish; override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure ExportObject(Obj: TfrxComponent); override;

  published

    property Separator: String read FSeparator write FSeparator;
    property OEMCodepage: Boolean read FOEM write FOEM;
    property OpenAfterExport: Boolean read FOpenAfterExport write FOpenAfterExport default False;
    property OverwritePrompt;

    { CSV export can ignore exporting of special system characters
      from original strings in the report. The special characters are
      all characters with ASCII codes $00..$1F.  }

    property NoSysSymbols: Boolean read FNoSysSymbols write FNoSysSymbols; {default True}

    { Specification of CSV format allows to leave some fields to be unquoted.
      The ForcedQuotes option allows to enclose all fields in double quotes. }

    property ForcedQuotes: Boolean read FForcedQuotes write FForcedQuotes; {default False}

  end;


implementation

uses FMX.frxUtils, {FMX.frxFileUtils,} FMX.frxUnicodeUtils, FMX.frxRes, FMX.frxFMX, FMX.frxrcExports
{$IFDEF MSWINDOWS}
, Winapi.ShellAPI, Winapi.Windows
{$ENDIF}
{$IFDEF MACOS}
, Posix.Stdlib
{$ENDIF};

{$R *.FMX}


function AnsiPos(const Substr, S: AnsiString): Integer;
var
  P: PAnsiChar;
begin
  Result := 0;
  P := AnsiStrPos(PAnsiChar(S), PAnsiChar(SubStr));
  if P <> nil then
    Result := Integer(P) - Integer(PAnsiChar(S)) + 1;
end;

 function StringReplace(const S, OldPattern, NewPattern: AnsiString;
  Flags: TReplaceFlags): AnsiString;
var
  SearchStr, Patt, NewStr: AnsiString;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then
  begin
    SearchStr := AnsiString(AnsiUpperCase(String(S)));
    Patt := AnsiString(AnsiUpperCase(String(OldPattern)));
  end else
  begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do
  begin
    Offset := AnsiPos(Patt, SearchStr);
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then
    begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;


{ TfrxCSVExport }

constructor TfrxCSVExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOEM := False;
  FSeparator := FormatSettings.ListSeparator;
  FNoSysSymbols := True;
  FilterDesc := frxGet(8851);
  DefaultExt := frxGet(8852);
end;

class function TfrxCSVExport.GetDescription: String;
begin
  Result := frxResources.Get('CSVExport');
end;

procedure TfrxCSVExport.ExportPage(Stream: TStream);
var
  x, y: Integer;
  Obj: TfrxIEMObject;
  s: AnsiString;

  { Before a byte string can be written to an output CSV document,
    it must be prepaired as follows:

    1. text with special characters must be enclosed in double quotes
    2. if the text contains double quotes and was enclosed in double quotes,
        its double quotes must be escaped by double quotes
    3. append the text by a separator (usually it's ";" or ",") }

  function PrepareString(const Str: AnsiString): AnsiString;

    { Returns count of a character within a byte string }

    function CharCount(const s: AnsiString; c: AnsiChar): Integer;
    var
      i: Integer;
    begin
      Result := 0;

      for i := 1 to Length(s) do
        if s[i] = c then
          Inc(Result);
    end;

    { Copies a source byte string to a destination byte string.
      A specified character is copied twice. }

    procedure DoubleCharacter(r: PAnsiChar; const s: AnsiString; c: AnsiChar);
    var
      si, ri: Integer;

      procedure PushChar(c: AnsiChar);
      begin
        PAnsiChar(Integer(r) + ri)^ := c;
        Inc(ri);
      end;

    begin
      ri := 0;

      for si := 1 to Length(s) do
      begin
        PushChar(s[si]);

        if s[si] = c then
          PushChar(s[si]);
      end;
    end;

    { This routine finds special characters in a byte string.
      If characters were found, the result is true, otherwise
      the result is false.

      Special characters are:

      a) all characters with codes 00..31
      b) the double quote character "
      c) a specified character in the 2-nd argument }

    function FindSpecChar(const s: AnsiString; c: AnsiChar): Boolean;
    var
      i: Integer;
    begin
      for i := 1 to Length(s) do
        if (s[i] = c) or (Ord(s[i]) < 32) or (s[i] = '"') then
        begin
          Result := True;
          Exit;
        end;

      Result := False;
    end;

    { Removes system symbols and returns a count of characters in
      the cleaned up string. System symbols are characters with codes 0..31. }

    function CleanSysSymbols(var s: AnsiString): Integer;
    var
      i, j: Integer;
    begin
      j := 1;

      for i := 1 to Length(s) do
        if Ord(s[i]) > 31 then
        begin
          s[j] := s[i];
          Inc(j);
        end;

      Result := j - 1;
    end;

  var
    s:    AnsiString; // buffer
    len:  LongWord;   // Length(Str)
    qn:   LongWord;   // Count of the quote characters in Str
    sep:  AnsiChar;
  begin

    { FSeparator must never be empty,
      but if it's empty, the export must not
      crash }

    if FSeparator = '' then
      sep := AnsiChar(FormatSettings.ListSeparator)
    else
      sep := AnsiChar(FSeparator[1]);

    if Str = '' then
    begin
      Result := sep;
      Exit;
    end;

    { Convert to the OEM codepage if it needs }

    if FOEM then
      s := Str // todo oem
    else
      s := Str;

    len := Length(s);

    { Suppress ending trash }

    if (len >= 2) and (s[len] = #10) and (s[len - 1] = #13) then
    begin
      Dec(len, 2);
      SetLength(s, len);
    end;

    { Remove system symbols if it needs. }

    if (len > 0) and NoSysSymbols then
    begin
      len := CleanSysSymbols(s);
      SetLength(s, len);
    end;

    if len = 0 then
    begin
      Result := sep;
      Exit;
    end;

    { If the text has no special characters,
      it can be written directly to the output CSV
      document }

    if not FindSpecChar(s, sep) then
    begin
      if not ForcedQuotes then
        Result := s + sep
      else
      begin
        SetLength(Result, Length(s) + 3);
        Result[1] := '"';
        Result[2 + Length(s)] := '"';
        Result[3 + Length(s)] := sep;
        Move(s[1], Result[2], Length(s));
      end;

      Exit;
    end;

    { If the text contains special characters,
      escape all double quotes with additional double quotes and
      enclose the text in double quotes }

    qn := CharCount(s, '"');
    SetLength(Result, len + qn + 3);

    Result[1]             := '"';
    Result[2 + qn + len]  := '"';
    Result[3 + qn + len]  := sep;

    DoubleCharacter(@Result[2], s, '"');
  end;

var
  eoln: Word;
  n: Integer;
begin
  FMatrix.Prepare;
  eoln := $0a0d;

  for y := 0 to FMatrix.Height - 2 do
  begin
    n := 0;

    for x := 0 to FMatrix.Width - 1 do
    begin
      Obj := FMatrix.GetObject(x, y);
      if Obj = nil then Continue;
      Inc(n);

      if Obj.Counter = 0 then
      begin
        s := AnsiString(Obj.Memo.Text);
        s := PrepareString(s);
        Stream.Write(s[1], Length(s));
        Obj.Counter := 1;
      end
      else
      begin
        s := AnsiString(FSeparator);
        Stream.Write(s[1], Length(s));
      end;
    end;

    { this removes the last separator symbol }

    if n > 0 then
      Stream.Seek(-1, soFromCurrent);

    Stream.Write(eoln, 2);
  end;
end;

function TfrxCSVExport.ShowModal: TModalResult;
begin
  if not Assigned(Stream) then
  begin
    with TfrxCSVExportDialog.Create(nil) do
    begin
      OpenCB.Visible := not SlaveExport;
      if OverwritePrompt then
        SaveDialog1.Options := SaveDialog1.Options + [TOpenOption.ofOverwritePrompt];
      if SlaveExport then
        FOpenAfterExport := False;

      if (FileName = '') and (not SlaveExport) then
        SaveDialog1.FileName := ChangeFileExt(ExtractFileName(frxUnixPath2WinPath(Report.FileName)), SaveDialog1.DefaultExt)
      else
        SaveDialog1.FileName := FileName;

      OpenCB.IsChecked := FOpenAfterExport;
      OEMCB.IsChecked := FOEM;
      SeparatorE.Text := FSeparator;

      if PageNumbers <> '' then
      begin
        PageNumbersE.Text := PageNumbers;
        PageNumbersRB.IsChecked := True;
      end;

      Result := ShowModal;
      PeekLastModalResult;
      if Result = mrOk then
      begin
        PageNumbers := '';
        CurPage := False;
        if CurPageRB.IsChecked then
          CurPage := True
        else if PageNumbersRB.IsChecked then
          PageNumbers := PageNumbersE.Text;

        FOpenAfterExport := OpenCB.IsChecked;
        FOEM := OEMCB.IsChecked;
        FSeparator := SeparatorE.Text;

        if not SlaveExport then
        begin
          if DefaultPath <> '' then
            SaveDialog1.InitialDir := DefaultPath;
          if SaveDialog1.Execute then
            FileName := SaveDialog1.FileName
          else
            Result := mrCancel;
          PeekLastModalResult;
        end;
      end;
      Free;
    end;
  end else
    Result := mrOk;
end;

function TfrxCSVExport.Start: Boolean;
begin
  if SlaveExport then
  begin
    if Report.FileName <> '' then
      FileName := ChangeFileExt(GetTemporaryFolder + ExtractFileName(Report.FileName), frxGet(8852))
    else
      FileName := ChangeFileExt(GetTempFile, frxGet(8852))
  end;
  if (FileName <> '') or Assigned(Stream) then
  begin
    if (ExtractFilePath(FileName) = '') and (DefaultPath <> '') then
      FileName := DefaultPath + '\' + FileName;
    FMatrix := TfrxIEMatrix.Create(UseFileCache, Report.EngineOptions.TempDir);
    FMatrix.Background := False;
    FMatrix.BackgroundImage := False;
    FMatrix.Printable := ExportNotPrintable;
    FMatrix.RichText := True;
    FMatrix.PlainRich := True;
    FMatrix.AreaFill := False;
    FMatrix.CropAreaFill := True;
    FMatrix.Inaccuracy := 0.5;
    FMatrix.DeleteHTMLTags := True;
    FMatrix.Images := False;
    FMatrix.WrapText := True;
    FMatrix.ShowProgress := False;
    FMatrix.FramesOptimization := True;
    try
      if Assigned(Stream) then
        Exp := Stream
      else
        Exp := TFileStream.Create(FileName, fmCreate);
       Result := True;
    except
      Result := False;
    end;
  end
  else
    Result := False;
end;

procedure TfrxCSVExport.StartPage(Page: TfrxReportPage; Index: Integer);
begin
  FMatrix.Clear;
end;

procedure TfrxCSVExport.ExportObject(Obj: TfrxComponent);
begin
  if Obj is TfrxView then
    FMatrix.AddObject(TfrxView(Obj));
end;

procedure TfrxCSVExport.FinishPage(Page: TfrxReportPage; Index: Integer);
begin
  FPage := Page;
  ExportPage(Exp);
end;

procedure TfrxCSVExport.Finish;
begin
  FMatrix.Free;
  if not Assigned(Stream) then
    Exp.Free;
  //if FOpenAfterExport and (not Assigned(Stream)) then
  //  ShellExecute(GetDesktopWindow, 'open', PChar(FileName), nil, nil, SW_SHOW);
  if FOpenAfterExport and (not Assigned(Stream)) then
  {$IFDEF MSWINDOWS}
    ShellExecute(0, 'open', PChar(FileName), '', '', 5);
  {$ENDIF}
  {$IFDEF MACOS}
    ShellExecute(FileName);
  {$ENDIF}
end;

{ TfrxCSVExportDialog }

procedure TfrxCSVExportDialog.FormCreate(Sender: TObject);
begin
  Caption := frxGet(8850);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  GroupPageRange.Text := frxGet(7);
  AllRB.Text := frxGet(3);
  CurPageRB.Text := frxGet(4);
  PageNumbersRB.Text := frxGet(5);
  DescrL.Text := frxGet(9);
  GroupQuality.Text := frxGet(8302);
  OEMCB.Text := frxGet(8304);
  OpenCB.Text := frxGet(8706);
  SaveDialog1.Filter := frxGet(8851);
  SaveDialog1.DefaultExt := frxGet(8852);
  SeparatorLB.Text := frxGet(8853);

  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
end;

procedure TfrxCSVExportDialog.PageNumbersEChange(Sender: TObject);
begin
  PageNumbersRB.IsChecked := True;
end;

procedure TfrxCSVExportDialog.PageNumbersEKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    '0'..'9':;
    #8, '-', ',':;
  else
    key := #0;
  end;
end;

procedure TfrxCSVExportDialog.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

end.
