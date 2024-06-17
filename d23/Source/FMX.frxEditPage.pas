
{******************************************}
{                                          }
{             FastReport v4.0              }
{              Page options                }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditPage;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Types, FMX.Objects, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.ExtCtrls, FMX.frxCtrls, FMX.TabControl, FMX.LIstBox, FMX.Edit, Fmx.Memo, FMX.frxFMX
, System.Variants, FMX.Layouts
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI21}
  ,FMX.SpinBox
{$ENDIF};


type
  TfrxPageEditorForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    TabControl1: TTabControl;
    TabSheet1: TTabItem;
    TabSheet3: TTabItem;
    Label11: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    UnitL1: TLabel;
    UnitL2: TLabel;
    WidthE: TEdit;
    HeightE: TEdit;
    SizeCB: TComboBox;
    Label12: TGroupBox;
    PortraitImg: TImage;
    LandscapeImg: TImage;
    PortraitRB: TRadioButton;
    LandscapeRB: TRadioButton;
    Label13: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    UnitL3: TLabel;
    UnitL4: TLabel;
    UnitL5: TLabel;
    UnitL6: TLabel;
    MarginLeftE: TEdit;
    MarginTopE: TEdit;
    MarginRightE: TEdit;
    MarginBottomE: TEdit;
    Label14: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Tray1CB: TComboBox;
    Tray2CB: TComboBox;
    Label17: TGroupBox;
    Label18: TLabel;
    PrintOnPrevCB: TCheckBox;
    MirrorMarginsCB: TCheckBox;
    LargeHeightCB: TCheckBox;
    DuplexCB: TComboBox;
    EndlessWidthCB: TCheckBox;
    EndlessHeightCB: TCheckBox;
    Label7: TGroupBox;
    Label8: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    UnitL7: TLabel;
    ColumnWidthE: TEdit;
    ColumnPositionsM: TMemo;
    ColumnsNumberS: TSpinBox;
    procedure PortraitRBClick(Sender: TObject);
    procedure SizeCBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure WidthEChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure ColumnsNumberSChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FUpdating: Boolean;
  public
    { Public declarations }
  end;


implementation

{$R *.FMX}

uses FMX.Printer, FMX.frxPrinter, FMX.frxClass, FMX.frxUtils, FMX.frxDesgn, FMX.frxRes;


procedure TfrxPageEditorForm.FormShow(Sender: TObject);
var
  i: Integer;
  p: TfrxReportPage;
begin
  FUpdating := True;

  with frxPrinters.Printer, TfrxDesignerForm(Owner) do
  begin
    p := TfrxReportPage(Page);

    SizeCB.Items := Papers;
    i := PaperIndex(p.PaperSize);
    if i = -1 then
      i := PaperIndex(256);
    SizeCB.ItemIndex := i;

    WidthE.Text := frxFloatToStr(mmToUnits(p.PaperWidth));
    HeightE.Text := frxFloatToStr(mmToUnits(p.PaperHeight, False));
    PortraitRB.IsChecked := p.Orientation = TPrinterOrientation.poPortrait;
    LandscapeRB.IsChecked := p.Orientation = TPrinterOrientation.poLandscape;

    MarginLeftE.Text := frxFloatToStr(mmToUnits(p.LeftMargin));
    MarginRightE.Text := frxFloatToStr(mmToUnits(p.RightMargin));
    MarginTopE.Text := frxFloatToStr(mmToUnits(p.TopMargin, False));
    MarginBottomE.Text := frxFloatToStr(mmToUnits(p.BottomMargin, False));

    Tray1CB.Items := Bins;
    Tray2CB.Items := Tray1CB.Items;
    i := BinIndex(p.Bin);
    if i = -1 then
      i := BinIndex(DMBIN_AUTO);
    Tray1CB.ItemIndex := i;
    i := BinIndex(p.BinOtherPages);
    if i = -1 then
      i := BinIndex(DMBIN_AUTO);
    Tray2CB.ItemIndex := i;

    ColumnsNumberS.Text := IntToStr(p.Columns);
    ColumnWidthE.Text := frxFloatToStr(mmToUnits(p.ColumnWidth));
    for i := 0 to p.ColumnPositions.Count - 1 do
      ColumnPositionsM.Lines.Add(frxFloatToStr(mmToUnits(frxStrToFloat(p.ColumnPositions[i]))));
    PrintOnPrevCB.IsChecked := p.PrintOnPreviousPage;
    MirrorMarginsCB.IsChecked := p.MirrorMargins;
    EndlessHeightCB.IsChecked := p.EndlessHeight;
    EndlessWidthCB.IsChecked := p.EndlessWidth;
    LargeHeightCB.IsChecked := p.LargeDesignHeight;
    DuplexCB.ItemIndex := Integer(p.Duplex);
  end;

  PortraitRBClick(nil);
  FUpdating := False;
end;

procedure TfrxPageEditorForm.PortraitRBClick(Sender: TObject);
begin
  PortraitImg.Visible := PortraitRB.IsChecked;
  LandscapeImg.Visible := LandscapeRB.IsChecked;
  SizeCBClick(nil);
end;

procedure TfrxPageEditorForm.SizeCBClick(Sender: TObject);
var
  pOr: TPrinterOrientation;
  pNumber: Integer;
  pWidth, pHeight: Extended;
begin
  if FUpdating then Exit;
  FUpdating := True;

  with frxPrinters.Printer, TfrxDesignerForm(Owner) do
  begin
    pNumber := PaperNameToNumber(SizeCB.Selected.Text);
    pWidth := UnitsTomm(frxStrToFloat(WidthE.Text));
    pHeight := UnitsTomm(frxStrToFloat(HeightE.Text), False);
    if PortraitRB.IsChecked then
      pOr := poPortrait else
      pOr := poLandscape;

    if pNumber = 256 then
      SetViewParams(pNumber, pHeight, pWidth, pOr) else
      SetViewParams(pNumber, pWidth, pHeight, pOr);

    WidthE.Text := frxFloatToStr(mmToUnits(PaperWidth));
    HeightE.Text := frxFloatToStr(mmToUnits(PaperHeight, False));
  end;

  FUpdating := False;
end;

procedure TfrxPageEditorForm.ColumnsNumberSChange(Sender: TObject);
var
  n: Integer;
  w: Extended;
begin
  if FUpdating then Exit;

  n := StrToInt(ColumnsNumberS.Text);
  if n = 0 then
    n := 1;

  with TfrxDesignerForm(Owner) do
  begin
    w := (UnitsTomm(frxStrToFloat(WidthE.Text)) -
         UnitsTomm(frxStrToFloat(MarginLeftE.Text)) -
         UnitsTomm(frxStrToFloat(MarginRightE.Text))) / n;
    ColumnWidthE.Text := frxFloatToStr(mmToUnits(w));

    with ColumnPositionsM.Lines do
    begin
      Clear;
      while Count < n do
        Add(frxFloatToStr(mmToUnits(Count * w)));
    end;
  end;
end;


procedure TfrxPageEditorForm.WidthEChange(Sender: TObject);
begin
  if not FUpdating then
    SizeCB.ItemIndex := 0;
end;

procedure TfrxPageEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  p: TfrxReportPage;
  i: Integer;
  c: TfrxReportComponent;

  procedure ChangePage(p: TfrxReportPage);
  var
    i: Integer;
  begin
    with frxPrinters.Printer, TfrxDesignerForm(Owner) do
    begin
      if PortraitRB.IsChecked then
        p.Orientation := TPrinterOrientation.poPortrait else
        p.Orientation := TPrinterOrientation.poLandscape;

      p.SetSizeAndDimensions(PaperNameToNumber(SizeCB.Selected.Text),
        UnitsTomm(frxStrToFloat(WidthE.Text)),
        UnitsTomm(frxStrToFloat(HeightE.Text), False));

      p.LeftMargin := UnitsTomm(frxStrToFloat(MarginLeftE.Text));
      p.RightMargin := UnitsTomm(frxStrToFloat(MarginRightE.Text));
      p.TopMargin := UnitsTomm(frxStrToFloat(MarginTopE.Text), False);
      p.BottomMargin := UnitsTomm(frxStrToFloat(MarginBottomE.Text), False);

      p.Bin := BinNameToNumber(Tray1CB.Selected.Text);
      p.BinOtherPages := BinNameToNumber(Tray2CB.Selected.Text);

      p.Columns := StrToInt(ColumnsNumberS.Text);
      p.ColumnWidth := UnitsTomm(frxStrToFloat(ColumnWidthE.Text));
      p.ColumnPositions.Clear;
      for i := 0 to ColumnPositionsM.Lines.Count - 1 do
        p.ColumnPositions.Add(frxFloatToStr(UnitsTomm(frxStrToFloat(ColumnPositionsM.Lines[i]))));
      p.PrintOnPreviousPage := PrintOnPrevCB.IsChecked;
      p.MirrorMargins := MirrorMarginsCB.IsChecked;
      p.EndlessWidth := EndlessWidthCB.IsChecked;
      p.EndlessHeight := EndlessHeightCB.IsChecked;
      p.LargeDesignHeight := LargeHeightCB.IsChecked;
      p.Duplex := TfrxDuplexMode(DuplexCB.ItemIndex);
    end;
  end;

begin
  if ModalResult = mrOk then
  begin
    p := TfrxReportPage(TfrxDesignerForm(Owner).Page);
    ChangePage(p);

    { change all subreport pages }
    for i := 0 to p.AllObjects.Count - 1 do
    begin
      c := p.AllObjects[i];
      if c is TfrxSubreport then
        ChangePage(TfrxSubreport(c).Page);
    end;
  end;

end;

procedure TfrxPageEditorForm.FormCreate(Sender: TObject);
var
  uStr: String;
begin
  Caption := frxGet(2700);
  OKB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  TabSheet1.Text := frxGet(2701);
  Label1.Text := frxGet(2702);
  Label2.Text := frxGet(2703);
  Label11.Text := frxGet(2704);
  Label12.Text := frxGet(2705);
  Label3.Text := frxGet(2706);
  Label4.Text := frxGet(2707);
  Label5.Text := frxGet(2708);
  Label6.Text := frxGet(2709);
  Label13.Text := frxGet(2710);
  Label14.Text := frxGet(2711);
  Label9.Text := frxGet(2712);
  Label10.Text := frxGet(2713);
  PortraitRB.Text := frxGet(2714);
  LandscapeRB.Text := frxGet(2715);
  TabSheet3.Text := frxGet(2716);
  Label7.Text := frxGet(2717);
  Label8.Text := frxGet(2718);
  Label15.Text := frxGet(2719);
  Label16.Text := frxGet(2720);
  Label17.Text := frxGet(2721);
  Label18.Text := frxGet(2722);
  PrintOnPrevCB.Text := frxGet(2723);
  MirrorMarginsCB.Text := frxGet(2724);
  LargeHeightCB.Text := frxGet(2725);
  EndlessWidthCB.Text := frxGet(2726);
  EndlessHeightCB.Text := frxGet(2727);
{$IFDEF DELPHI23}
  DuplexCB.Clear;
{$ELSE}
  DuplexCB.Items.Clear;
{$ENDIF}
  DuplexCB.Items.Add(frxResources.Get('dupDefault'));
  DuplexCB.Items.Add(frxResources.Get('dupVert'));
  DuplexCB.Items.Add(frxResources.Get('dupHorz'));
  DuplexCB.Items.Add(frxResources.Get('dupSimpl'));

  uStr := '';
  case TfrxDesignerForm(Owner).Units of
    duCM: uStr := frxResources.Get('uCm');
    duInches: uStr := frxResources.Get('uInch');
    duPixels: uStr := frxResources.Get('uPix');
    duChars: uStr := frxResources.Get('uChar');
  end;

  UnitL1.Text := uStr;
  UnitL2.Text := uStr;
  UnitL3.Text := uStr;
  UnitL4.Text := uStr;
  UnitL5.Text := uStr;
  UnitL6.Text := uStr;
  UnitL7.Text := uStr;
  FormShow(Self);
  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
end;

procedure TfrxPageEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
end;

end.



//56db3b0f55102b9488a240d37950543f