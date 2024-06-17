
{******************************************}
{                                          }
{          FastReport FMX v1.0             }
{      Language resources management       }
{                                          }
{         Copyright (c) 1998-2011          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxRes;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.Variants, System.WideStrings,
  System.Types, FMX.Types, System.UIConsts,
  FMX.frxUnicodeUtils, FMX.frxUtils, FMX.frxFMX
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};


type
  TfrxResources = class(TObject)
  private
    FNames: TStringList;
    FImages: TBitmap;
    FValues: TWideStrings;// TStringList;
    FLanguages: TStringList;
    FHelpFile: String;
    FCP: Cardinal;
    FImgWidth: Integer;
    FImgHeight: Integer;
    procedure BuildLanguagesList;
    function GetImages: TBitmap;
  public
    constructor Create;
    destructor Destroy; override;
    function Get(const StrName: String): String;
    procedure Add(const Ref, Str: String);
    procedure AddW(const Ref: String; Str: WideString);
    procedure AddStrings(const Str: String);
    procedure AddXML(const Str: AnsiString);
    procedure Clear;
    procedure LoadFromFile(const FileName: String);
    procedure LoadFromStream(Stream: TStream);
    procedure LoadImageFromResouce(Image: TBitmap; RowId: Integer; ColId: Integer); overload;
    procedure LoadImageFromResouce(Image: TBitmap; Index: Integer); overload;
    procedure UpdateFSResources;
    procedure Help(Sender: TObject); overload;
    property Images: TBitmap read GetImages;
    property Languages: TStringList read FLanguages;
    property HelpFile: String read FHelpFile write FHelpFile;
  end;

function frxResources: TfrxResources;
function frxGet(ID: Integer): String;


implementation

uses 
  FMX.fs_iconst, FMX.frxGZip, FMX.frxXML;

var
  FResources: TfrxResources = nil;

type
  frxInteger = NativeInt;

{ TfrxResources }

constructor TfrxResources.Create;
begin
  inherited;
  FImgWidth := 16;
  FImgHeight := 16;
  FImages := TBitmap.Create(0, 0);
  FNames := TfrxStringList.Create;
  FValues := TfrxWideStrings.Create;
  FNames.Sorted := True;
  FLanguages := TStringList.Create;
  HelpFile := 'FRUser.chm';
  FCP := 0;
  BuildLanguagesList;
end;

destructor TfrxResources.Destroy;
begin
  FLanguages.Free;
  FNames.Free;
  FValues.Free;
  FImages.Free;
  inherited;
end;

procedure TfrxResources.AddW(const Ref: String; Str: WideString);
var
  i: Integer;
begin
  i := FNames.IndexOf(Ref);
  if i = -1 then
  begin
    FNames.AddObject(Ref, Pointer(FValues.Count));
    FValues.Add(Str);
  end
  else
    FValues[frxInteger(FNames.Objects[i])] := Str;
end;

procedure TfrxResources.Add(const Ref, Str: String);
begin
  AddW(Ref, Str);
end;

procedure TfrxResources.AddStrings(const Str: String);
var
  i: Integer;
  sl: TWideStrings;
  nm, vl: WideString;
begin
  sl := TfrxWideStrings.Create;
  sl.Text := Str;
  for i := 0 to sl.Count - 1 do
  begin
    nm := sl[i];
    vl := Copy(nm, Pos('=', nm) + 1, MaxInt);
    nm := Copy(nm, 1, Pos('=', nm) - 1);
    if (nm <> '') and (vl <> '') then
      Add(nm, vl);
  end;
  sl.Free;
end;

procedure TfrxResources.AddXML(const Str: AnsiString);
var
  Stream: TStringStream;
begin
  Stream := TStringStream.Create('', TEncoding.UTF8);
  Stream.Write(Str[1], Length(Str));
  Stream.Position := 0;
  LoadFromStream(Stream);
  Stream.Free;
end;

procedure TfrxResources.Clear;
begin
  FNames.Clear;
  FValues.Clear;
end;

function TfrxResources.Get(const StrName: String): String;
var
  i: Integer;
begin
  i := FNames.IndexOf(StrName);
  if i <> -1 then
    Result :=  FValues[frxInteger(FNames.Objects[i])] else
    Result := StrName;
  if (Result <> '') and (Result[1] = '!') then
    Delete(Result, 1, 1);
  // UI amps
  if Pos('&', Result) <> 0 then
    Delete(Result, Pos('&', Result), 1);
end;

function TfrxResources.GetImages: TBitmap;
var
  res: TResourceStream;
begin
  if FImages.IsEmpty then
  begin
    res := TResourceStream.Create(hInstance, 'BUTTONS', RT_RCDATA);
    try
      FImages.LoadFromStream(res);
    finally
      res.Free;
    end;
  end;
  Result := FImages;
end;

procedure TfrxResources.LoadFromFile(const FileName: String);
var
  f: TFileStream;
begin
  if FileExists(FileName) then
  begin
    f := TFileStream.Create(FileName, fmOpenRead);
    try
      LoadFromStream(f);
    finally
      f.Free;
    end;
  end;
end;

procedure TfrxResources.LoadFromStream(Stream: TStream);
var
  FXMLRes: TfrxXMLDocument;
  idx: Integer;
begin
  FXMLRes := TfrxXMLDocument.Create;
  FXMLRes.LoadFromStream(Stream);
  try
    with FXMLRes.Root do
    begin
      if Name = 'Resources' then
      begin
        FCP := StrToInt(Prop['CodePage']);
        for idx := 0 to  Count - 1 do
          if Items[idx].Name = 'StrRes' then
          if not FXMLRes.OldVersion then
            Self.AddW(Items[idx].Prop['Name'], frxXMLToStr(Items[idx].Prop['Text'])) else
            Self.AddW(Items[idx].Prop['Name'], UTF8Decode(AnsiString(frxXMLToStr(Items[idx].Prop['Text']))));

      end;
    end;
  finally
    FXMLRes.Free;
  end;
  UpdateFSResources;
end;

procedure TfrxResources.LoadImageFromResouce(Image: TBitmap;
  RowId: Integer; ColId: Integer);
begin
    Image.SetSize(FImgWidth, FImgHeight);
    Image.Canvas.BeginScene;
    // need to clear image to avoid garbage output
    Image.Clear(claNull);
    Image.Canvas.DrawBitmap(Images, RectF(FImgWidth * ColId  , FImgHeight * RowId, FImgWidth * ColId + FImgWidth , FImgHeight * RowId + FImgHeight), RectF(0, 0, FImgWidth, FImgHeight), 1 );
    Image.Canvas.EndScene;
{$IFNDEF Delphi17}
    Image.BitmapChanged;
{$ENDIF}
end;

procedure TfrxResources.LoadImageFromResouce(Image: TBitmap; Index: Integer);
var
  ColCount, ColId, RowId: Integer;
begin
    ColCount := Images.Width div FImgWidth;
    RowId := Index div ColCount;
    ColId := Index mod ColCount;
    Image.SetSize(FImgWidth, FImgHeight);
    Image.Canvas.BeginScene;
    // need to clear image to avoid garbage output
    Image.Clear(claNull);
    Image.Canvas.DrawBitmap(Images, RectF(FImgWidth * ColId  , FImgHeight * RowId, FImgWidth * ColId + FImgWidth , FImgHeight * RowId + FImgHeight), RectF(0, 0, FImgWidth, FImgHeight), 1 );
    Image.Canvas.EndScene;
{$IFNDEF Delphi17}
    Image.BitmapChanged;
{$ENDIF}
end;

procedure TfrxResources.UpdateFSResources;
begin
  SLangNotFound := Get('SLangNotFound');
  SInvalidLanguage := Get('SInvalidLanguage');
  SIdRedeclared := Get('SIdRedeclared');
  SUnknownType := Get('SUnknownType');
  SIncompatibleTypes := Get('SIncompatibleTypes');
  SIdUndeclared := Get('SIdUndeclared');
  SClassRequired := Get('SClassRequired');
  SIndexRequired := Get('SIndexRequired');
  SStringError := Get('SStringError');
  SClassError := Get('SClassError');
  SArrayRequired := Get('SArrayRequired');
  SVarRequired := Get('SVarRequired');
  SNotEnoughParams := Get('SNotEnoughParams');
  STooManyParams := Get('STooManyParams');
  SLeftCantAssigned := Get('SLeftCantAssigned');
  SForError := Get('SForError');
  SEventError := Get('SEventError');
end;

type
  THelpTopic = record
    Sender: String;
    Topic: String;
  end;

const
  helpTopicsCount = 17;
  helpTopics: array[0..helpTopicsCount - 1] of THelpTopic =
   (
    (Sender: 'TfrxDesignerForm'; Topic: 'Designer.htm'),
    (Sender: 'TfrxOptionsEditor'; Topic: 'Designer_options.htm'),
    (Sender: 'TfrxReportEditorForm'; Topic: 'Report_options.htm'),
    (Sender: 'TfrxPageEditorForm'; Topic: 'Page_options.htm'),
    (Sender: 'TfrxCrossEditorForm'; Topic: 'Cross_tab_reports.htm'),
    (Sender: 'TfrxChartEditorForm'; Topic: 'Diagrams.htm'),
    (Sender: 'TfrxSyntaxMemo'; Topic: 'Script.htm'),
    (Sender: 'TfrxDialogPage'; Topic: 'Dialogue_forms.htm'),
    (Sender: 'TfrxDialogComponent'; Topic: 'Data_access_components.htm'),
    (Sender: 'TfrxVarEditorForm'; Topic: 'Variables.htm'),
    (Sender: 'TfrxHighlightEditorForm'; Topic: 'Conditional_highlighting.htm'),
    (Sender: 'TfrxSysMemoEditorForm'; Topic: 'Inserting_aggregate_function.htm'),
    (Sender: 'TfrxFormatEditorForm'; Topic: 'Values_formatting.htm'),
    (Sender: 'TfrxGroupEditorForm'; Topic: 'Report_with_groups.htm'),
    (Sender: 'TfrxPictureEditorForm'; Topic: 'Picture_object.htm'),
    (Sender: 'TfrxMemoEditorForm'; Topic: 'Text_object.htm'),
    (Sender: 'TfrxSQLEditorForm'; Topic: 'TfrxADOQuery.htm')
   );




procedure TfrxResources.Help(Sender: TObject);
var
  i: Integer;
  topic: String;
begin
  topic := '';
  if Sender <> nil then
    for i := 0 to helpTopicsCount - 1 do
      if CompareText(helpTopics[i].Sender, Sender.ClassName) = 0 then
        topic := '::/' + helpTopics[i].Topic;
end;

procedure TfrxResources.BuildLanguagesList;
var
  i: Integer;
  SRec: TSearchRec;
  Dir: String;
  s: String;
begin
  Dir := GetAppPath;
  FLanguages.Clear;
  i := FindFirst(Dir + '*.frc', faAnyFile, SRec);
  try
    while i = 0 do
    begin
      s := LowerCase(SRec.Name);
      s := UpperCase(Copy(s, 1, 1)) + Copy(s, 2, Length(s) - 1);
      s := StringReplace(s, '.frc', '', []);
      FLanguages.Add(s);
      i := FindNext(SRec);
    end;
    FLanguages.Sort;
  finally
    FindClose(Srec);
  end;
end;


function frxResources: TfrxResources;
begin
  if FResources = nil then
    FResources := TfrxResources.Create;
  Result := FResources;
end;

function frxGet(ID: Integer): String;
begin
  Result := frxResources.Get(IntToStr(ID));
end;


initialization

finalization
  if FResources <> nil then
    FResources.Free;
  FResources := nil;

end.

