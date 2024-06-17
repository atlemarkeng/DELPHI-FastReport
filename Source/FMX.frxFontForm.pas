unit FMX.frxFontForm;

{$I frx.inc}
interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.frxFMX, FMX.Layouts, FMX.frxRes,
  FMX.ListBox, FMX.Edit, FMX.Objects, FMX.Colors, System.UIConsts
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};


type
  TfrxFontForm = class(TForm)
    FontL: TLabel;
    SizeL: TLabel;
    GroupBox1: TGroupBox;
    Sample: TGroupBox;
    PaintBox1: TPaintBox;
    FontE: TEdit;
    SizeE: TEdit;
    FontLB: TListBox;
    SizeLB: TListBox;
    CancelBtn: TButton;
    OkBtn: TButton;
    BoldB: TfrxToolButton;
    ItalicB: TfrxToolButton;
    UnderlineB: TfrxToolButton;
    StrikeoutB: TfrxToolButton;
    ComboColorBox1: TComboColorBox;
    ColorL: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FontEChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboColorBox1Change(Sender: TObject);
    procedure FontLBChange(Sender: TObject);
    procedure SizeLBChange(Sender: TObject);
    procedure SizeEChangeTracking(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
    procedure BoldBClick(Sender: TObject);
    procedure ItalicBClick(Sender: TObject);
    procedure UnderlineBClick(Sender: TObject);
    procedure StrikeoutBClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FFontS: TfrxFont;
    FIsCallFromEdit: Boolean;
    { Private declarations }
  public
    property FontS: TfrxFont read FFontS;
    { Public declarations }
  end;

var
  frxFontForm: TfrxFontForm;

implementation

{$R *.fmx}

procedure SetFontStyle(AFont: TfrxFont; fStyle: TFontStyle; Include: Boolean);
begin
    with AFont do
      if Include then
        Style := Style + [fStyle] else
        Style := Style - [fStyle];
end;

procedure TfrxFontForm.BoldBClick(Sender: TObject);
begin
  SetFontStyle(FFontS, fsBold, BoldB.IsPressed);
  Self.InvalidateRect(RectF(0, 0, Self.Width, Self.Height));
end;

procedure TfrxFontForm.ComboColorBox1Change(Sender: TObject);
begin
  FFonts.Color := ComboColorBox1.Color;
  Self.InvalidateRect(RectF(0, 0, Self.Width, Self.Height));
end;

procedure TfrxFontForm.FontEChange(Sender: TObject);
var
  i: Integer;
begin
  //i := FontLB.Items.IndexOf(FontE.Text);
  for i := 0 to FontLB.Items.Count - 1 do
  begin
    if (Pos(UpperCase(FontE.Text), UpperCase(FontLB.Items[i])) = 1) then
    begin
      FIsCallFromEdit := True;
      FontLB.ItemIndex := i;
      FIsCallFromEdit := False;
      break;
    end;
  end;
end;

procedure TfrxFontForm.FontLBChange(Sender: TObject);
begin
  if FontLB.Selected  <> nil then
  begin
    FFontS.Name := FontLB.Selected.Text;
    if not FIsCallFromEdit then
      FontE.Text := FontLB.Selected.Text;
    Self.InvalidateRect(RectF(0, 0, Self.Width, Self.Height));
  end;
end;

procedure TfrxFontForm.FormActivate(Sender: TObject);
begin
  BoldB.IsPressed := fsBold in FFontS.Style;
  ItalicB.IsPressed := fsItalic in FFontS.Style;
  StrikeoutB.IsPressed := fsStrikeout in FFontS.Style;
  UnderlineB.IsPressed := fsUnderline in FFontS.Style;
end;

procedure TfrxFontForm.FormCreate(Sender: TObject);
begin
  FFontS := TfrxFont.Create;
  frxResources.LoadImageFromResouce(UnderlineB.Bitmap, 2, 2);
  frxResources.LoadImageFromResouce(BoldB.Bitmap, 2, 0);
  frxResources.LoadImageFromResouce(ItalicB.Bitmap, 2, 1);
  FIsCallFromEdit := False;
{$IFDEF DELPHI23}
  SizeLB.Clear;
{$ELSE}
  SizeLB.Items.Clear;
{$ENDIF}
  SizeLB.BeginUpdate;
  SizeLB.Items.Add('8');
  SizeLB.Items.Add('9');
  SizeLB.Items.Add('10');
  SizeLB.Items.Add('11');
  SizeLB.Items.Add('12');
  SizeLB.Items.Add('14');
  SizeLB.Items.Add('16');
  SizeLB.Items.Add('18');
  SizeLB.Items.Add('20');
  SizeLB.Items.Add('22');
  SizeLB.Items.Add('24');
  SizeLB.Items.Add('26');
  SizeLB.Items.Add('28');
  SizeLB.Items.Add('36');
  SizeLB.Items.Add('48');
  SizeLB.Items.Add('72');
  SizeLB.EndUpdate;
{$IFDEF DELPHI23}
  FontLB.Clear;
{$ELSE}
  FontLB.Items.Clear;
{$ENDIF}
  FontLB.BeginUpdate;
  FillFontsList(FontLB.Items);
  FontLB.EndUpdate;
  FontE.Text := FFontS.Name;
  SizeE.Text := FloatToStr(FFontS.Size);
end;

procedure TfrxFontForm.FormDestroy(Sender: TObject);
begin
  FFontS.Free;
end;

procedure TfrxFontForm.FormResize(Sender: TObject);
begin
  FormActivate(Sender);
end;

procedure TfrxFontForm.ItalicBClick(Sender: TObject);
begin
  SetFontStyle(FFontS, fsItalic, ItalicB.IsPressed);
  Self.InvalidateRect(RectF(0, 0, Self.Width, Self.Height));
end;

procedure TfrxFontForm.PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
begin
  Canvas.Fill.Color := claWhite;
  Canvas.FillRect(RectF(0, 0, PaintBox1.Width, PaintBox1.Height), 0,0, AllCorners, 1);
  FFontS.AssignToCanvas(Canvas);
  Canvas.FillText(RectF(0, 0, PaintBox1.Width, PaintBox1.Height), 'Sample Text', false, 1, [], TTextAlign.taCenter );
end;

procedure TfrxFontForm.SizeEChangeTracking(Sender: TObject);
var
  OutF: Single;
begin
  if TryStrToFloat(SizeE.Text, OutF) then
  begin
    FFontS.Size := OutF;
    Self.InvalidateRect(RectF(0, 0, Self.Width, Self.Height));
  end
  else
    SizeE.Text := FloatToStr(FFontS.Size);
end;

procedure TfrxFontForm.SizeLBChange(Sender: TObject);
begin
  if SizeLB.Selected <> nil then
    SizeE.Text := SizeLB.Selected.Text;
end;

procedure TfrxFontForm.StrikeoutBClick(Sender: TObject);
begin
  SetFontStyle(FFontS, fsStrikeout, StrikeoutB.IsPressed);
  Self.InvalidateRect(RectF(0, 0, Self.Width, Self.Height));
end;

procedure TfrxFontForm.UnderlineBClick(Sender: TObject);
begin
  SetFontStyle(FFontS, fsUnderline, UnderlineB.IsPressed);
  Self.InvalidateRect(RectF(0, 0, Self.Width, Self.Height));
end;

end.
