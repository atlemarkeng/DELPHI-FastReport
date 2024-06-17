
{******************************************}
{                                          }
{           FastReport FMX v1.0            }
{          Barcode design editor           }
{                                          }
{         Copyright (c) 1998-2013          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxBarcodeEditor;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.Menus, FMX.frxClass, FMX.frxBarcode, FMX.frxCustomEditors, System.Types,
  FMX.frxBarcod, FMX.frxCtrls, FMX.Edit, FMX.ListBox, FMX.Objects, FMX.Types
, System.Variants, System.UITypes, System.UIConsts
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF}
{$IFDEF DELPHI21}
  , FMX.ComboEdit
{$ENDIF};


type
  TfrxBarcodeEditor = class(TfrxViewEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  TfrxBarcodeEditorForm = class(TForm)
    CancelB: TButton;
    OkB: TButton;
    CodeE: TComboEdit;
    CodeLbl: TLabel;
    TypeCB: TComboBox;
    TypeLbl: TLabel;
    ExamplePB: TPaintBox;
    OptionsLbl: TGroupBox;
    ZoomLbl: TLabel;
    CalcCheckSumCB: TCheckBox;
    ViewTextCB: TCheckBox;
    ZoomE: TEdit;
    RotationLbl: TGroupBox;
    Rotation0RB: TRadioButton;
    Rotation90RB: TRadioButton;
    Rotation180RB: TRadioButton;
    Rotation270RB: TRadioButton;
    procedure ExprBtnClick(Sender: TObject);
    procedure UpBClick(Sender: TObject);
    procedure DownBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure ExamplePB2Paint(Sender: TObject; Canvas: TCanvas);
    procedure Rotation0RBClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FBarcode: TfrxBarcodeView;
  public
    { Public declarations }
    property Barcode: TfrxBarcodeView read FBarcode write FBarcode;
  end;


implementation

uses FMX.frxDsgnIntf, FMX.frxRes, FMX.frxUtils;


{$R *.FMX}

const
  cbDefaultText = '12345678';


{ TfrxBarcodeEditor }

function TfrxBarcodeEditor.HasEditor: Boolean;
begin
  Result := True;
end;

function TfrxBarcodeEditor.Edit: Boolean;
begin
  with TfrxBarcodeEditorForm.Create(Designer) do
  begin
    Barcode := TfrxBarcodeView(Component);
    FormShow(Self);
    Result := ShowModal = mrOk;
    Free;
  end;
end;

function TfrxBarcodeEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  i: Integer;
  c: TfrxComponent;
  v: TfrxBarcodeView;
begin
  Result := inherited Execute(Tag, Checked);
  for i := 0 to Designer.SelectedObjects.Count - 1 do
  begin
    c := Designer.SelectedObjects[i];
    if (c is TfrxBarcodeView) and not (rfDontModify in c.Restrictions) then
    begin
      v := TfrxBarcodeView(c);
      if Tag = 1 then
        v.CalcCheckSum := Checked
      else if Tag = 2 then
        v.ShowText := Checked;
      Result := True;
    end;
  end;
end;

procedure TfrxBarcodeEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
var
  v: TfrxBarcodeView;
begin
  v := TfrxBarcodeView(Component);
  AddItem(frxResources.Get('bcCalcChecksum'), 1, v.CalcCheckSum);
  AddItem(frxResources.Get('bcShowText'), 2, v.ShowText);
  inherited;
end;


{ TfrxBarcodeEditorForm }

procedure TfrxBarcodeEditorForm.FormShow(Sender: TObject);
var
  i: TfrxBarcodeType;
begin
{$IFDEF DELPHI23}
  TypeCB.Clear;
{$ELSE}
  TypeCB.Items.Clear;
{$ENDIF}
  for i := bcCode_2_5_interleaved to bcCodeEAN128C do
    TypeCB.Items.Add(frxResources.Get(String(bcData[i].Name)));

  CodeE.Text := FBarcode.Expression;
  TypeCB.ItemIndex := Integer(FBarcode.BarType);
  CalcCheckSumCB.IsChecked := FBarcode.CalcCheckSum;
  ViewTextCB.IsChecked := FBarcode.ShowText;
  ZoomE.Text := FloatToStr(FBarcode.Zoom);

  case FBarcode.Rotation of
    90:  Rotation90RB.IsChecked := True;
    180: Rotation180RB.IsChecked := True;
    270: Rotation270RB.IsChecked := True;
    else Rotation0RB.IsChecked := True;
  end;

  ExamplePB.Repaint;
end;

procedure TfrxBarcodeEditorForm.Rotation0RBClick(Sender: TObject);
begin
  ExamplePB.Repaint;
end;

procedure TfrxBarcodeEditorForm.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
  begin
    FBarcode.Expression := CodeE.Text;
    FBarcode.BarType := TfrxBarcodeType(TypeCB.ItemIndex);
    FBarcode.CalcCheckSum := CalcCheckSumCB.IsChecked;
    FBarcode.ShowText := ViewTextCB.IsChecked;
    FBarcode.Zoom := frxStrToFloat(ZoomE.Text);

    if Rotation90RB.IsChecked then
      FBarcode.Rotation := 90
    else if Rotation180RB.IsChecked then
      FBarcode.Rotation := 180
    else if Rotation270RB.IsChecked then
      FBarcode.Rotation := 270
    else
      FBarcode.Rotation := 0;
  end;
end;

procedure TfrxBarcodeEditorForm.ExprBtnClick(Sender: TObject);
var
  s: String;
begin
  s := TfrxCustomDesigner(Owner).InsertExpression(CodeE.Text);
  if s <> '' then
    CodeE.Text := s;
end;

procedure TfrxBarcodeEditorForm.UpBClick(Sender: TObject);
var
  i: Double;
begin
  i := frxStrToFloat(ZoomE.Text);
  i := i + 0.1;
  ZoomE.Text := FloatToStr(i);
end;

procedure TfrxBarcodeEditorForm.DownBClick(Sender: TObject);
var
  i: Double;
begin
  i := frxStrToFloat(ZoomE.Text);
  i := i - 0.1;
  if i <= 0 then i := 1;
  ZoomE.Text := FloatToStr(i);
end;

procedure TfrxBarcodeEditorForm.ExamplePB2Paint(Sender: TObject;
  Canvas: TCanvas);
var
  Barcode: TfrxBarcode;
  dRect: TRect;
begin
  Barcode := TfrxBarcode.Create(Self);
  Barcode.Typ := TfrxBarcodeType(TypeCB.ItemIndex);
  Barcode.Text := '12345678';
  Barcode.Ratio := 1;
  if Rotation0RB.IsChecked then
    Barcode.Angle := 0
  else if Rotation90RB.IsChecked then
    Barcode.Angle := 90
  else if Rotation180RB.IsChecked then
    Barcode.Angle := 180
  else
    Barcode.Angle := 270;
  Barcode.CheckSum  := CalcCheckSumCB.IsChecked;

  with ExamplePB.Canvas do
  begin
    Fill.Color := claWhite;

    if (Barcode.Angle = 0) or (Barcode.Angle = 180) then
      dRect := Rect(40, 20, 40 + Round(Barcode.Width * 1.5), 200)
    else
      dRect := Rect(20, 40, 200, 40 + Round(Barcode.Width * 1.5));

    Barcode.Color := claWhite;
    Canvas.FillRect(RectF(0, 0, ExamplePB.Width, ExamplePB.Height), 0, 0, allCorners, 1);
    Barcode.DrawBarcode(Canvas, dRect ,
      ViewTextCB.IsChecked, 1.5);
  end;

  Barcode.Free;



end;

procedure TfrxBarcodeEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormHide(Self);
end;

procedure TfrxBarcodeEditorForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(3500);
  CodeLbl.Text := frxGet(3501);
  TypeLbl.Text := frxGet(3502);
  ZoomLbl.Text := frxGet(3503);
  OptionsLbl.Text := frxGet(3504);
  RotationLbl.Text := frxGet(3505);
  CancelB.Text := frxGet(2);
  OkB.Text := frxGet(1);
  CalcCheckSumCB.Text := frxGet(3506);
  ViewTextCB.Text := frxGet(3507);
  Rotation0RB.Text := frxGet(3508);
  Rotation90RB.Text := frxGet(3509);
  Rotation180RB.Text := frxGet(3510);
  Rotation270RB.Text := frxGet(3511);

end;


procedure TfrxBarcodeEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkF1 then
    frxResources.Help(Self);
end;

initialization
  frxComponentEditors.Register(TfrxBarcodeView, TfrxBarcodeEditor);


end.


//56db3b0f55102b9488a240d37950543f