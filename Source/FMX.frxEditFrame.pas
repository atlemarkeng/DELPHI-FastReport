
{******************************************}
{                                          }
{             FastReport v4.0              }
{              Frame editor                }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditFrame;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.ExtCtrls, FMX.frxCtrls, FMX.frxClass, FMX.frxFMX, FMX.ListBox, FMX.Edit
 {$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI21}
  , FMX.ComboEdit, FMX.Controls.Presentation
{$ENDIF};

type
  TfrxFrameEditorForm = class(TForm)
    FrameL: TLabel;
    LineL: TLabel;
    ShadowL: TLabel;
    OkB: TButton;
    CancelB: TButton;
    ToolBar1: TToolBar;
    FrameTopB: TfrxToolButton;
    FrameBottomB: TfrxToolButton;
    FrameLeftB: TfrxToolButton;
    FrameRightB: TfrxToolButton;
    FrameAllB: TfrxToolButton;
    FrameNoB: TfrxToolButton;
    ToolBar2: TToolBar;
    FrameColorB: TfrxToolButton;
    FrameStyleB: TfrxToolButton;
    Sep2: TPanel;
    FrameWidthCB: TComboEdit;
    ToolBar3: TToolBar;
    ShadowB: TfrxToolButton;
    ShadowColorB: TfrxToolButton;
    Sep3: TPanel;
    ShadowWidthCB: TComboEdit;
    FrameLineCB: TComboEdit;
    FLineL: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
  private
    FFrame: TfrxFrame;
    procedure UpdateControls;
    function GetFrameLine: TfrxFrameLine;
  public
    property Frame: TfrxFrame read FFrame;
  end;


implementation

{$R *.FMX}

uses FMX.frxDesgnCtrls, FMX.frxUtils, FMX.frxRes;


procedure TfrxFrameEditorForm.FormCreate(Sender: TObject);
begin
  FFrame := TfrxFrame.Create;
  Caption := frxGet(5200);
  FrameL.Text := frxGet(5201);
  LineL.Text := frxGet(2321);
  ShadowL.Text := frxGet(5203);
  FrameTopB.Hint := frxGet(5204);
  FrameBottomB.Hint := frxGet(5205);
  FrameLeftB.Hint := frxGet(5206);
  FrameRightB.Hint := frxGet(5207);
  FrameAllB.Hint := frxGet(5208);
  FrameNoB.Hint := frxGet(5209);
  FrameColorB.Hint := frxGet(5210);
  FrameStyleB.Hint := frxGet(5211);
  //FrameWidthCB.Hint := frxGet(5212);
  ShadowB.Hint := frxGet(5213);
  ShadowColorB.Hint := frxGet(5214);
  //ShadowWidthCB.Hint := frxGet(5215);
  FrameLineCB.Items.Add(frxGet(5208));
  FrameLineCB.Items.Add(frxGet(5206));
  FrameLineCB.Items.Add(frxGet(5207));
  FrameLineCB.Items.Add(frxGet(5204));
  FrameLineCB.Items.Add(frxGet(5205));
  FLineL.Text := frxGet(5202);
  FrameLineCB.ItemIndex := 1;
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  //FImageList := frxResources.MainButtonImages;
  frxResources.LoadImageFromResouce(FrameTopB.Bitmap, 3, 2);
  frxResources.LoadImageFromResouce(FrameBottomB.Bitmap, 3, 3);
  frxResources.LoadImageFromResouce(FrameRightB.Bitmap, 3, 5);
  frxResources.LoadImageFromResouce(FrameLeftB.Bitmap, 3, 4);
  frxResources.LoadImageFromResouce(FrameNoB.Bitmap, 3, 7);
  frxResources.LoadImageFromResouce(FrameAllB.Bitmap, 3, 6);
  frxResources.LoadImageFromResouce(ShadowB.Bitmap, 7, 1);
  frxResources.LoadImageFromResouce(FrameColorB.Bitmap, 3, 9);
  frxResources.LoadImageFromResouce(FrameStyleB.Bitmap, 4, 0);
  FormShow(Self);
  //ToolBar1.Images := FImageList;
  //ToolBar2.Images := FImageList;
  //ToolBar3.Images := FImageList;

  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
end;

function TfrxFrameEditorForm.GetFrameLine: TfrxFrameLine;
begin
  case FrameLineCB.ItemIndex of
    2: Result := FFrame.RightLine;
    3: Result := FFrame.TopLine;
    4: Result := FFrame.BottomLine;
    else Result := FFrame.LeftLine;
  end;
end;

procedure TfrxFrameEditorForm.FormDestroy(Sender: TObject);
begin
  FFrame.Free;
end;

procedure TfrxFrameEditorForm.FormShow(Sender: TObject);
begin
  UpdateControls;
end;

procedure TfrxFrameEditorForm.UpdateControls;
begin
  FrameTopB.Down := ftTop in FFrame.Typ;
  FrameBottomB.Down := ftBottom in FFrame.Typ;
  FrameLeftB.Down := ftLeft in FFrame.Typ;
  FrameRightB.Down := ftRight in FFrame.Typ;
  ShadowB.Down := FFrame.DropShadow;
  FrameWidthCB.Text := FloatToStr(GetFrameLine.Width);
  ShadowWidthCB.Text := FloatToStr(FFrame.ShadowWidth);
  if FrameLineCB.ItemIndex = 0 then
  with FFrame do
  begin
    Style := GetFrameLine.Style;
    Color := GetFrameLine.Color;
    Width := GetFrameLine.Width;
  end;

end;

procedure TfrxFrameEditorForm.BClick(Sender: TObject);

  procedure SetFrameType(fType: TfrxFrameType; Include: Boolean);
  begin
     with FFrame do
      if Include then
        Typ := Typ + [fType] else
        Typ := Typ - [fType];
  end;

begin
  case TControl(Sender).Tag of
    1: SetFrameType(ftTop, FrameTopB.Down);
    2: SetFrameType(ftBottom, FrameBottomB.Down);
    3: SetFrameType(ftLeft, FrameLeftB.Down);
    4: SetFrameType(ftRight, FrameRightB.Down);
    5: FFrame.Typ := [ftLeft, ftRight, ftTop, ftBottom];
    6: FFrame.Typ := [];
    7:
      with TfrxColorSelector.Create(TComponent(Sender)) do
      begin
        OnColorChanged := BClick;
        Tag := 70;
      end;
    70: GetFrameLine.Color := TfrxColorSelector(Sender).Color;
    8:
      with TfrxLineSelector.Create(TComponent(Sender)) do
      begin
        OnStyleChanged := BClick;
        Tag := 80;
      end;
    80: GetFrameLine.Style := TfrxFrameStyle(TfrxLineSelector(Sender).Style);
    9: GetFrameLine.Width := frxStrToFloat(FrameWidthCB.Text);
    10: FFrame.DropShadow := ShadowB.Down;
    11:
      with TfrxColorSelector.Create(TComponent(Sender)) do
      begin
        OnColorChanged := BClick;
        Tag := 110;
      end;
    110: FFrame.ShadowColor := TfrxColorSelector(Sender).Color;
    12: FFrame.ShadowWidth := frxStrToFloat(ShadowWidthCB.Text);
  end;

  UpdateControls;
end;

procedure TfrxFrameEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

end.
