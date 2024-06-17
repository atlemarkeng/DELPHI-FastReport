
{******************************************}
{                                          }
{             FastReport v4.0              }
{          Preview Page settings           }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxPreviewPageSettings;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.Classes, System.Variants, System.UITypes,
  FMX.Objects, FMX.Forms, FMX.Controls, FMX.Edit, FMX.ListBox,
  FMX.frxClass, FMX.Types
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};


type
  TfrxDesignerUnits = (duCM, duInches, duPixels, duChars);

  TfrxPageSettingsForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    SizeL: TGroupBox;
    WidthL: TLabel;
    HeightL: TLabel;
    UnitL1: TLabel;
    UnitL2: TLabel;
    WidthE: TEdit;
    HeightE: TEdit;
    SizeCB: TComboBox;
    OrientationL: TGroupBox;
    PortraitImg: TImage;
    LandscapeImg: TImage;
    PortraitRB: TRadioButton;
    LandscapeRB: TRadioButton;
    MarginsL: TGroupBox;
    LeftL: TLabel;
    TopL: TLabel;
    RightL: TLabel;
    BottomL: TLabel;
    UnitL3: TLabel;
    UnitL4: TLabel;
    UnitL5: TLabel;
    UnitL6: TLabel;
    MarginLeftE: TEdit;
    MarginTopE: TEdit;
    MarginRightE: TEdit;
    MarginBottomE: TEdit;
    OtherL: TGroupBox;
    ApplyToCurRB: TRadioButton;
    ApplyToAllRB: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure PortraitRBClick(Sender: TObject);
    procedure SizeCBClick(Sender: TObject);
    procedure WidthEChange(Sender: TObject);
    procedure FormKeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PortraitRBChange(Sender: TObject);
  protected
    { Private declarations }
    FPage: TfrxReportPage;
    FReport: TfrxReport;
    FUnits: TfrxDesignerUnits;
    FUpdating: Boolean;
    function GetNeedRebuild: Boolean;
    function mmToUnits(mm: Extended): Extended;
    function UnitsTomm(mm: Extended): Extended;
  public
    { Public declarations }
    property NeedRebuild: Boolean read GetNeedRebuild;
    property Page: TfrxReportPage read FPage write FPage;
    property Report: TfrxReport read FReport write FReport;
  end;


implementation

{$R *.fmx}

uses
  FMX.Printer, FMX.frxPrinter, FMX.frxUtils, FMX.frxRes, FMX.frxFMX, System.IniFiles;


function TfrxPageSettingsForm.mmToUnits(mm: Extended): Extended;
begin
  Result := 0;
  case FUnits of
    duCM, duPixels, duChars:
      Result := mm / 10;
    duInches:
      Result := mm / 25.4;
  end;
end;

function TfrxPageSettingsForm.UnitsTomm(mm: Extended): Extended;
begin
  Result := 0;
  case FUnits of
    duCM, duPixels, duChars:
      Result := mm * 10;
    duInches:
      Result := mm * 25.4;
  end;
end;

function TfrxPageSettingsForm.GetNeedRebuild: Boolean;
begin
  Result := ApplyToAllRB.IsChecked;
end;

procedure TfrxPageSettingsForm.FormShow(Sender: TObject);
var
  i: Integer;
  Ini: TCustomIniFile;
  uStr: String;
begin
  FUpdating := True;

  Caption := frxGet(400);

  WidthL.Text := frxGet(401);
  HeightL.Text := frxGet(402);
  SizeL.Text := frxGet(403);
  OrientationL.Text := frxGet(404);
  LeftL.Text := frxGet(405);
  TopL.Text := frxGet(406);
  RightL.Text := frxGet(407);
  BottomL.Text := frxGet(408);
  MarginsL.Text := frxGet(409);
  PortraitRB.Text := frxGet(410);
  LandscapeRB.Text := frxGet(411);
  OKB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  OtherL.Text := frxGet(412);
  ApplyToCurRB.Text := frxGet(413);
  ApplyToAllRB.Text := frxGet(414);

  Ini := Report.GetIniFile;
  FUnits := TfrxDesignerUnits(Ini.ReadInteger('TfrxDesignerForm', 'Units', 0));
  Ini.Free;

  uStr := '';
  case FUnits of
    duCM, duPixels, duChars:
      uStr := frxResources.Get('uCm');
    duInches:
      uStr := frxResources.Get('uInch');
  end;

  UnitL1.Text := uStr;
  UnitL2.Text := uStr;
  UnitL3.Text := uStr;
  UnitL4.Text := uStr;
  UnitL5.Text := uStr;
  UnitL6.Text := uStr;

  SizeCB.Items := frxPrinters.Printer.Papers;
  i := frxPrinters.Printer.PaperIndex(FPage.PaperSize);
  if i = -1 then
    i := frxPrinters.Printer.PaperIndex(256);
  SizeCB.ItemIndex := i;
  //SizeCB.ItemIndex := 0;

  WidthE.Text := frxFloatToStr(mmToUnits(Page.PaperWidth));
  HeightE.Text := frxFloatToStr(mmToUnits(Page.PaperHeight));
  PortraitRB.IsChecked := Page.Orientation = poPortrait;
  LandscapeRB.IsChecked := Page.Orientation = poLandscape;

  MarginLeftE.Text := frxFloatToStr(mmToUnits(Page.LeftMargin));
  MarginRightE.Text := frxFloatToStr(mmToUnits(Page.RightMargin));
  MarginTopE.Text := frxFloatToStr(mmToUnits(Page.TopMargin));
  MarginBottomE.Text := frxFloatToStr(mmToUnits(Page.BottomMargin));

  PortraitRBClick(nil);
  FUpdating := False;
end;

procedure TfrxPageSettingsForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrOk then
  begin
    if PortraitRB.IsChecked then
      Page.Orientation := poPortrait else
      Page.Orientation := poLandscape;

    Page.PaperWidth := UnitsTomm(frxStrToFloat(WidthE.Text));
    Page.PaperHeight := UnitsTomm(frxStrToFloat(HeightE.Text));
   //Page.PaperSize := frxPrinters.Printer.PaperNameToNumber(SizeCB.Selected.Text);

    Page.LeftMargin := UnitsTomm(frxStrToFloat(MarginLeftE.Text));
    Page.RightMargin := UnitsTomm(frxStrToFloat(MarginRightE.Text));
    Page.TopMargin := UnitsTomm(frxStrToFloat(MarginTopE.Text));
    Page.BottomMargin := UnitsTomm(frxStrToFloat(MarginBottomE.Text));

    Page.AlignChildren;
  end;
end;

procedure TfrxPageSettingsForm.PortraitRBChange(Sender: TObject);
begin
  SizeCBClick(nil);
end;

procedure TfrxPageSettingsForm.PortraitRBClick(Sender: TObject);
begin
  PortraitImg.Visible := PortraitRB.IsChecked;
  LandscapeImg.Visible := LandscapeRB.IsChecked;
  //SizeCBClick(nil);
end;

procedure TfrxPageSettingsForm.SizeCBClick(Sender: TObject);
var
  pOr: TPrinterOrientation;
  pNumber: Integer;
  pWidth, pHeight: Extended;
begin
  if FUpdating then Exit;
  FUpdating := True;
  if SizeCB.Count = 0 then  Exit;

  with frxPrinters.Printer do
  begin
    pNumber := PaperNameToNumber(SizeCB.Selected.Text);
    pWidth := UnitsTomm(frxStrToFloat(WidthE.Text));
    pHeight := UnitsTomm(frxStrToFloat(HeightE.Text));
    if PortraitRB.IsChecked then
      pOr := poPortrait else
      pOr := poLandscape;

    if pNumber = 256 then
      SetViewParams(pNumber, pHeight, pWidth, pOr) else
      SetViewParams(pNumber, pWidth, pHeight, pOr);

    WidthE.Text := frxFloatToStr(mmToUnits(PaperWidth));
    HeightE.Text := frxFloatToStr(mmToUnits(PaperHeight));
  end;

  FUpdating := False;
end;

procedure TfrxPageSettingsForm.WidthEChange(Sender: TObject);
begin
  if not FUpdating then
    SizeCB.ItemIndex := 0;
end;

procedure TfrxPageSettingsForm.FormKeyDown(var Key: Word;
  var KeyChar: System.WideChar; Shift: TShiftState);
begin
{  if Key = VK_F1 then
    frxResources.Help(Self); }
end;

end.



//56db3b0f55102b9488a240d37950543f