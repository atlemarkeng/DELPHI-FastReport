
{******************************************}
{                                          }
{             FastReport v4.0              }
{              Print dialog                }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxPrintDialog;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.Classes, System.SysUtils, System.Variants, System.UITypes,
  FMX.Objects, FMX.Types, FMX.Controls, FMX.Forms, FMX.ListBox, FMX.Dialogs, FMX.Edit,
  FMX.frxCtrls, FMX.frxClass
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};

type
  TfrxPrintDialog = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    FileDlg: TSaveDialog;
    Label12: TGroupBox;
    WhereL: TLabel;
    WhereL1: TLabel;
    PrintersCB: TComboBox;
    PropButton: TButton;
    FileCB: TCheckBox;
    Label1: TGroupBox;
    DescrL: TLabel;
    AllRB: TRadioButton;
    CurPageRB: TRadioButton;
    PageNumbersRB: TRadioButton;
    PageNumbersE: TEdit;
    Label2: TGroupBox;
    CopiesL: TLabel;
    CollateImg: TImage;
    NonCollateImg: TImage;
    CopiesPB: TPaintBox;
    CopiesE: TEdit;
    CollateCB: TCheckBox;
    //UpDown1: TUpDown;
    ScaleGB: TGroupBox;
    PagPageSizeCB: TComboBox;
    NameL: TLabel;
    PagSizeL: TLabel;
    PrintModeCB: TComboBox;
    //PrintModeIL: TfrxImageList;
    OtherGB: TGroupBox;
    PrintL: TLabel;
    DuplexL: TLabel;
    PrintPagesCB: TComboBox;
    DuplexCB: TComboBox;
    OrderL: TLabel;
    OrderCB: TComboBox;
    {procedure PrintersCBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState); }
    procedure FormCreate(Sender: TObject);
    procedure PropButtonClick(Sender: TObject);
    procedure PrintersCBClick(Sender: TObject);
    procedure PageNumbersRBClick(Sender: TObject);
    procedure CollateLClick(Sender: TObject);
    procedure CollateCBClick(Sender: TObject);
    {procedure CopiesPBPaint(Sender: TObject);  }
    procedure PageNumbersEEnter(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    {procedure PrintModeCBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);}
    procedure FormShow(Sender: TObject);
    procedure PrintModeCBClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    OldIndex: Integer;
  public
    { Public declarations }
    AReport: TfrxReport;
    ADuplexMode: TfrxDuplexMode;
  end;


implementation

{$R *.FMX}

uses 
  FMX.frxPrinter, FMX.frxUtils, FMX.frxRes, FMX.FrxFmx;


procedure TfrxPrintDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormHide(Sender);
end;

procedure TfrxPrintDialog.FormCreate(Sender: TObject);
begin
  Caption := frxGet(200);
  Label12.Text := frxGet(201);
  DescrL.Text := frxGet(9);
  Label1.Text := frxGet(202);
  CopiesL.Text := frxGet(203);
  CollateCB.Text := frxGet(204);
  Label2.Text := frxGet(205);
  PrintL.Text := frxGet(206);
  WhereL.Text := frxGet(208);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  PropButton.Text := frxGet(209);
  AllRB.Text := frxGet(3);
  CurPageRB.Text := frxGet(4);
  PageNumbersRB.Text := frxGet(5);
  FileCB.Text := frxGet(210);
  NameL.Text := frxGet(212);
  ScaleGB.Text := frxGet(213);
  PagSizeL.Text := frxGet(214);
  DuplexL.Text := frxGet(216);
  OtherGB.Text := frxGet(207);
  OrderL.Text := frxGet(211);
  FileDlg.Title := frxGet(507);
  FileDlg.Filter := frxGet(510);

{$IFDEF DELPHI23}
  OrderCB.Clear;
{$ELSE}
  OrderCB.Items.Clear;
{$ENDIF}
  OrderCB.Items.Add(frxResources.Get('poDirect'));
  OrderCB.Items.Add(frxResources.Get('poReverse'));

{$IFDEF DELPHI23}
  PrintPagesCB.Clear;
{$ELSE}
  PrintPagesCB.Items.Clear;
{$ENDIF}
  PrintPagesCB.Items.Add(frxResources.Get('ppAll'));
  PrintPagesCB.Items.Add(frxResources.Get('ppOdd'));
  PrintPagesCB.Items.Add(frxResources.Get('ppEven'));
  PrintPagesCB.ItemIndex := 0;


{$IFDEF DELPHI23}
  DuplexCB.Clear;
{$ELSE}
  DuplexCB.Items.Clear;
{$ENDIF}
  DuplexCB.Items.Add(frxResources.Get('dupDefault'));
  DuplexCB.Items.Add(frxResources.Get('dupVert'));
  DuplexCB.Items.Add(frxResources.Get('dupHorz'));
  DuplexCB.Items.Add(frxResources.Get('dupSimpl'));
  DuplexCB.ItemIndex := 0;

{$IFDEF DELPHI23}
  PrintModeCB.Clear;
{$ELSE}
  PrintModeCB.Items.Clear;
{$ENDIF}
  PrintModeCB.Items.Add(frxResources.Get('pmDefault'));
  PrintModeCB.Items.Add(frxResources.Get('pmSplit'));
  PrintModeCB.Items.Add(frxResources.Get('pmJoin'));
  PrintModeCB.Items.Add(frxResources.Get('pmScale'));

  //SetWindowLong(CopiesE.Handle, GWL_STYLE, GetWindowLong(CopiesE.Handle, GWL_STYLE) or ES_NUMBER);

  //if Screen.PixelsPerInch > 96 then
  //  PrintersCB.ItemHeight := 19;
  PrintersCB.Items.Assign(frxPrinters.Printers);
  PrintersCB.ItemIndex := frxPrinters.PrinterIndex;
  PrintersCBClick(nil);

  OldIndex := frxPrinters.PrinterIndex;
  CollateCBClick(nil);

 // if UseRightToLeftAlignment then
 //   FlipChildren(True);
end;

procedure TfrxPrintDialog.FormShow(Sender: TObject);
begin
  //UpDown1.Position := AReport.PrintOptions.Copies;
  CollateCB.IsChecked := AReport.PrintOptions.Collate;
  PageNumbersE.Text := AReport.PrintOptions.PageNumbers;
  if AReport.PrintOptions.PageNumbers <> '' then
    PageNumbersRB.IsChecked := True;
  PrintPagesCB.ItemIndex := Integer(AReport.PrintOptions.PrintPages);
  if AReport.PrintOptions.Reverse then
    OrderCB.ItemIndex := 1
  else
    OrderCB.ItemIndex := 0;

  PrintModeCB.ItemIndex := Integer(AReport.PrintOptions.PrintMode);
  DuplexCB.ItemIndex := Integer(ADuplexMode);
  PrintModeCBClick(nil);
  if AReport.PrintOptions.PrintMode <> pmDefault then
  begin
    PagPageSizeCB.ItemIndex := frxPrinters.Printer.PaperIndex(AReport.PrintOptions.PrintOnSheet) + 1;
    if frxPrinters.Printer.PaperIndex(256) < frxPrinters.Printer.PaperIndex(AReport.PrintOptions.PrintOnSheet) then
      PagPageSizeCB.ItemIndex := PagPageSizeCB.ItemIndex - 1;
  end;
end;

procedure TfrxPrintDialog.FormHide(Sender: TObject);
begin
  if ModalResult <> mrOk then
    frxPrinters.PrinterIndex := OldIndex
  else
  begin
    frxPrinters.Printer.FileName := '';
    if FileCB.IsChecked then
      if FileDlg.Execute then
        frxPrinters.Printer.FileName := ChangeFileExt(FileDlg.FileName, '.prn') else
        ModalResult := mrCancel;
  end;

  if ModalResult = mrOk then
  begin
    AReport.PrintOptions.Copies := StrToInt(CopiesE.Text);
    AReport.PrintOptions.Collate := CollateCB.IsChecked;
    if AllRB.IsChecked then
      AReport.PrintOptions.PageNumbers := ''
    else if CurPageRB.IsChecked then
      AReport.PrintOptions.PageNumbers := IntToStr(AReport.PreviewPages.CurPreviewPage)
    else
      AReport.PrintOptions.PageNumbers := PageNumbersE.Text;
    AReport.PrintOptions.PrintPages := TfrxPrintPages(PrintPagesCB.ItemIndex);
    ADuplexMode := TfrxDuplexMode(DuplexCB.ItemIndex);
    AReport.PrintOptions.Reverse := OrderCB.ItemIndex = 1;

    AReport.PrintOptions.PrintMode := TfrxPrintMode(PrintModeCB.ItemIndex);
//    AReport.PrintOptions.PrintOnSheet := frxPrinters.Printer.PaperNameToNumber(PagPageSizeCB.Text);
  end;
end;

{procedure TfrxPrintDialog.PrintersCBDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
begin
  with PrintersCB.Canvas do
  begin
    FillRect(ARect);
    frxResources.PreviewButtonImages.Draw(PrintersCB.Canvas, ARect.Left + 2, ARect.Top, 2);
    TextOut(ARect.Left + 24, ARect.Top + 1, PrintersCB.Items[Index]);
  end;
end;         }

procedure TfrxPrintDialog.PropButtonClick(Sender: TObject);
var
  dup: Integer;
begin
  frxPrinters.Printer.PropertiesDlg;
  dup := frxPrinters.Printer.Duplex - 1;
  if dup = 0 then dup := 3;

  if dup > 0 then
  begin
    ADuplexMode := TfrxDuplexMode(dup);
    DuplexCB.ItemIndex := dup;
  end;
end;

procedure TfrxPrintDialog.PrintersCBClick(Sender: TObject);
var
  SaveSheet: Integer;
begin
  if PagPageSizeCB.ItemIndex <= 0 then
    SaveSheet := -1
  else
    SaveSheet := frxPrinters.Printer.PaperNameToNumber(PagPageSizeCB.Items[PagPageSizeCB.ItemIndex]);

  frxPrinters.PrinterIndex := PrintersCB.ItemIndex;
  WhereL1.Text := frxPrinters.Printer.Port;
  PagPageSizeCB.Items := frxPrinters.Printer.Papers;
  PagPageSizeCB.Items.Delete(frxPrinters.Printer.PaperIndex(256));
  PagPageSizeCB.Items.Insert(0, frxResources.Get('pgDefault'));

  if (SaveSheet <> -1) and (frxPrinters.Printer.PaperIndex(SaveSheet) <> -1) then
  begin
    PagPageSizeCB.ItemIndex := frxPrinters.Printer.PaperIndex(SaveSheet) + 1;
    if frxPrinters.Printer.PaperIndex(256) < frxPrinters.Printer.PaperIndex(SaveSheet) then
      PagPageSizeCB.ItemIndex := PagPageSizeCB.ItemIndex - 1
  end
  else
    PagPageSizeCB.ItemIndex := 0
end;

procedure TfrxPrintDialog.PageNumbersEEnter(Sender: TObject);
begin
  PageNumbersRB.IsChecked := True;
end;

procedure TfrxPrintDialog.PageNumbersRBClick(Sender: TObject);
begin
  if Visible then
    PageNumbersE.SetFocus;
end;

procedure TfrxPrintDialog.CollateLClick(Sender: TObject);
begin
  CollateCB.IsChecked := not CollateCB.IsChecked;
end;

procedure TfrxPrintDialog.CollateCBClick(Sender: TObject);
begin
  //CopiesPBPaint(nil);
end;

{procedure TfrxPrintDialog.CopiesPBPaint(Sender: TObject);
begin
  with CopiesPB.Canvas do
  begin
    Brush.Color := Color;
    FillRect(Rect(0, 0, CopiesPB.Width, CopiesPB.Height));
    if CollateCB.Checked then
      frxDrawTransparent(CopiesPB.Canvas, 0, 0, CollateImg.Picture.Bitmap) else
      frxDrawTransparent(CopiesPB.Canvas, 0, 0, NonCollateImg.Picture.Bitmap);
  end;
end;        }

procedure TfrxPrintDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if Key = VK_F1 then
 //   frxResources.Help(Self);
end;
 {
procedure TfrxPrintDialog.PrintModeCBDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
begin
  with PrintModeCB do
  begin
    Canvas.FillRect(ARect);
    PrintModeIL.Draw(Canvas, ARect.Left + 2, ARect.Top + 1, Index);
    Canvas.TextOut(ARect.Left + 74, ARect.Top + 10, Items[Index]);
  end;
end;   }

procedure TfrxPrintDialog.PrintModeCBClick(Sender: TObject);
var
  DefaultMode: Boolean;
begin
  DefaultMode := PrintModeCB.ItemIndex = 0;
  if DefaultMode then
    PagPageSizeCB.ItemIndex := 0;
  PagPageSizeCB.Enabled := not DefaultMode;
  if not DefaultMode and (PagPageSizeCB.ItemIndex = 0) then
    PagPageSizeCB.ItemIndex := frxPrinters.Printer.PaperIndex(DMPAPER_A4);
end;

end.

