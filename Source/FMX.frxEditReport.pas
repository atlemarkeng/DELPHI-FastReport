
{******************************************}
{                                          }
{             FastReport v4.0              }
{             Report options               }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditReport;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, System.Types, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.ExtCtrls, FMX.frxCtrls, FMX.Memo, FMX.Objects, FMX.frxBaseModalForm,
  FMX.Edit, FMX.Layouts, FMX.ListBox, FMX.Types, System.Variants, FMX.TabControl
 {$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};


type
  TfrxReportEditorForm = class(TfrxForm)
    OkB: TButton;
    CancelB: TButton;
    PageControl: TTabControl;
    GeneralTS: TTabItem;
    DescriptionTS: TTabItem;
    InheritTS: TTabItem;
    GeneralL: TGroupBox;
    PasswordL: TLabel;
    DoublePassCB: TCheckBox;
    PrintIfEmptyCB: TCheckBox;
    PasswordE: TEdit;
    ReportSettingsL: TGroupBox;
    CopiesL: TLabel;
    PrintersLB: TListBox;
    CopiesE: TEdit;
    CollateCB: TCheckBox;
    DescriptionL: TGroupBox;
    NameL: TLabel;
    PictureImg: TImage;
    Description1L: TLabel;
    PictureL: TLabel;
    AuthorL: TLabel;
    NameE: TEdit;
    DescriptionE: TMemo;
    PictureB: TButton;
    AuthorE: TEdit;
    VersionL: TGroupBox;
    MajorL: TLabel;
    MinorL: TLabel;
    ReleaseL: TLabel;
    BuildL: TLabel;
    CreatedL: TLabel;
    Created1L: TLabel;
    ModifiedL: TLabel;
    Modified1L: TLabel;
    MajorE: TEdit;
    MinorE: TEdit;
    ReleaseE: TEdit;
    BuildE: TEdit;
    InheritGB: TGroupBox;
    InheritStateL: TLabel;
    SelectL: TLabel;
    PathLB: TLabel;
    DetachRB: TRadioButton;
    InheritRB: TRadioButton;
    DontChangeRB: TRadioButton;
    PathE: TEdit;
    BrowseB: TButton;
    InheritLV: TListBox;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure PictureBClick(Sender: TObject);
    //procedure PrintersLBDrawItem(Control: TWinControl; Index: Integer;
    //  ARect: TRect; State: TOwnerDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure BrowseBClick(Sender: TObject);
    procedure FillTemplatelist;
    procedure PathEKeyPress(Sender: TObject; var Key: Char);
    procedure PageControlChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FTemplates: TStringList;
  public
    { Public declarations }
  end;


implementation

{$R *.FMX}

uses
  System.IOUtils, FMX.frxDesgn, FMX.frxEditPicture, FMX.frxPrinter, FMX.frxUtils, FMX.frxRes, FMX.frxClass;


procedure TfrxReportEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
//var
//  templ: String;
begin
  if ModalResult = mrOk then
    with TfrxDesignerForm(Owner).Report do
    begin
      if PrintersLB.ItemIndex <> -1 then
      begin
        PrintOptions.Printer := PrintersLB.Items[PrintersLB.ItemIndex];
        SelectPrinter;
      end;
      PrintOptions.Collate := CollateCB.IsChecked;
      PrintOptions.Copies := StrToInt(CopiesE.Text);
      EngineOptions.DoublePass := DoublePassCB.IsChecked;
      EngineOptions.PrintIfEmpty := PrintIfEmptyCB.IsChecked;

      if ReportOptions.HiddenPassword = '' then
        ReportOptions.Password := PasswordE.Text;

      if not DontChangeRB.IsChecked then
      begin
        Designer.Lock;
        try
          if DetachRB.IsChecked then
            ParentReport := ''
          else if InheritRB.IsChecked and (InheritLV.Selected <> nil) then
          begin
            ParentReport := '';
            //templ := FTemplates[Integer(InheritLV.Selected.Data)];
            InheritFromTemplate(InheritLV.Selected.Text{templ});
          end;
        finally
          Designer.ReloadReport;
        end;
      end;

      ReportOptions.Name := NameE.Text;
      ReportOptions.Author := AuthorE.Text;
      ReportOptions.Description.Text := DescriptionE.Lines.Text;
      ReportOptions.Picture.Assign(PictureImg.Bitmap);
      ReportOptions.VersionMajor := MajorE.Text;
      ReportOptions.VersionMinor := MinorE.Text;
      ReportOptions.VersionRelease := ReleaseE.Text;
      ReportOptions.VersionBuild := BuildE.Text;
    end;
end;

procedure TfrxReportEditorForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(4700);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  GeneralTS.Text := frxGet(4701);
  ReportSettingsL.Text := frxGet(4702);
  CopiesL.Text := frxGet(4703);
  GeneralL.Text := frxGet(4704);
  PasswordL.Text := frxGet(4705);
  CollateCB.Text := frxGet(4706);
  DoublePassCB.Text := frxGet(4707);
  PrintIfEmptyCB.Text := frxGet(4708);
  DescriptionTS.Text := frxGet(4709);
  NameL.Text := frxGet(4710);
  Description1L.Text := frxGet(4711);
  PictureL.Text := frxGet(4712);
  AuthorL.Text := frxGet(4713);
  MajorL.Text := frxGet(4714);
  MinorL.Text := frxGet(4715);
  ReleaseL.Text := frxGet(4716);
  BuildL.Text := frxGet(4717);
  CreatedL.Text := frxGet(4718);
  ModifiedL.Text := frxGet(4719);
  DescriptionL.Text := frxGet(4720);
  VersionL.Text := frxGet(4721);
  PictureB.Text := frxGet(4722);
  InheritTS.Text := frxGet(4728);
  InheritGB.Text := frxGet(4723);
  SelectL.Text := frxGet(4724);
  DontChangeRB.Text := frxGet(4725);
  DetachRB.Text := frxGet(4726);
  InheritRB.Text := frxGet(4727);
  PathLB.Text := frxGet(4729);

  //if Screen.PixelsPerInch > 96 then
  //  PrintersLB.ItemHeight := 19;
  //InheritLV.LargeImages := frxResources.WizardImages;

  FTemplates := TStringList.Create;
  FTemplates.Sorted := True;
  FormShow(Self);
  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
end;

procedure TfrxReportEditorForm.FormDestroy(Sender: TObject);
begin
  FTemplates.Free;
end;

procedure TfrxReportEditorForm.FormShow(Sender: TObject);
var
  i: Integer;
begin
  with TfrxDesignerForm(Owner).Report do
  begin
    PrintersLB.Items.BeginUpdate;
    PrintersLB.Items.Add(frxResources.Get('prDefault'));
    for i := 0 to frxPrinters.Printers.Count - 1 do
      PrintersLB.Items.Add(frxPrinters.Printers[i]);
    PrintersLB.Items.EndUpdate;

    CollateCB.IsChecked := PrintOptions.Collate;
    CopiesE.Text := IntToStr(PrintOptions.Copies);
    DoublePassCB.IsChecked := EngineOptions.DoublePass;
    PrintIfEmptyCB.IsChecked := EngineOptions.PrintIfEmpty;
    if ReportOptions.HiddenPassword = '' then
      PasswordE.Text := ReportOptions.Password
    else
    begin
      PasswordE.Enabled := False;
      //PasswordE.Color := claGray;
    end;

    if Trim(ParentReport) = '' then
    begin
      InheritStateL.Text := frxResources.Get('riNotInherited');
      DetachRB.Enabled := False;
    end
    else
      InheritStateL.Text := Format(frxResources.Get('riInherited'), [ParentReport]);

    FillTemplatelist;
    NameE.Text := ReportOptions.Name;
    AuthorE.Text := ReportOptions.Author;
    DescriptionE.Lines.Text := ReportOptions.Description.Text;
    PictureImg.Bitmap.Assign(ReportOptions.Picture);
    //PictureImg.Stretch := (PictureImg.Picture.Width > PictureImg.Width) or
    //  (PictureImg.Picture.Height > PictureImg.Height);

    MajorE.Text := ReportOptions.VersionMajor;
    MinorE.Text := ReportOptions.VersionMinor;
    ReleaseE.Text := ReportOptions.VersionRelease;
    BuildE.Text := ReportOptions.VersionBuild;
    Created1L.Text := DateTimeToStr(ReportOptions.CreateDate);
    Modified1L.Text := DateTimeToStr(ReportOptions.LastChange);
  end;
end;


procedure TfrxReportEditorForm.PictureBClick(Sender: TObject);
begin
  with TfrxPictureEditorForm.Create(Owner) do
  begin
    Image.Bitmap.Assign(PictureImg.Bitmap);
    if ShowModal = mrOk then
    begin
      PictureImg.Bitmap.Assign(Image.Bitmap);
      //PictureImg.Stretch := (PictureImg.Picture.Width > PictureImg.Width) or
      //  (PictureImg.Picture.Height > PictureImg.Height);
    end;
    Free;
  end;
end;

//procedure TfrxReportEditorForm.PrintersLBDrawItem(Control: TWinControl;
//  Index: Integer; ARect: TRect; State: TOwnerDrawState);
//var
//  s: String;
//begin
//  with PrintersLB.Canvas do
//  begin
//    FillRect(ARect);
//    frxResources.PreviewButtonImages.Draw(PrintersLB.Canvas, ARect.Left + 2, ARect.Top, 2);
//    s := PrintersLB.Items[Index];
//    if (Index <> 0) and (frxPrinters[Index - 1].Port <> '') then
//      s := s + ' ' + frxResources.Get('rePrnOnPort') + ' ' + frxPrinters[Index - 1].Port;
//    TextOut(ARect.Left + 24, ARect.Top + 1, s);
//  end;
//end;

procedure TfrxReportEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

procedure TfrxReportEditorForm.BrowseBClick(Sender: TObject);
var
  FolderName: String;
begin
    OpenDialog1.InitialDir := PathE.Text;
    if OpenDialog1.Execute() then
    begin
      FolderName := ExtractFilePath(OpenDialog1.FileName);
      TfrxDesignerForm(Owner).TemplatePath := FolderName;
      FillTemplatelist;
  end;
  PeekLastModalResult;
end;

procedure TfrxReportEditorForm.FillTemplatelist;
//var
//  i: Integer;
begin
  PathE.Text := TfrxDesignerForm(Owner).TemplatePath;
  TfrxDesignerForm(Owner).GetTemplateList(FTemplates);
  InheritLV.Clear;
  InheritLV.Items := FTemplates;
//  InheritLV.Items.Clear;
//  for i := 0 to FTemplates.Count - 1 do
//    begin
//      lvItem := InheritLV.Items.Add;
//      lvItem.Caption := ExtractFileName(FTemplates[i]);
//      lvItem.Data := Pointer(i);
//      lvItem.ImageIndex := 5;
//    end;
end;

procedure TfrxReportEditorForm.PathEKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    if DirectoryExists(PathE.Text) then
    begin
      TfrxDesignerForm(Owner).TemplatePath := PathE.Text;
      FillTemplatelist;
    end;
end;

procedure TfrxReportEditorForm.PageControlChange(Sender: TObject);
begin
  if PageControl.ActiveTab = InheritTS then
    OkB.Default := False
  else OkB.Default := True;
end;

end.
