
{******************************************}
{                                          }
{             FastReport v4.0              }
{              Style editor                }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditStyle;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.Types, System.UITypes, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.frxClass, FMX.Layouts, FMX.TreeView, FMX.Types, FMX.frxFMX, FMX.Objects,
  FMX.Edit, System.UIConsts, FMX.frxFontForm
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};

type
  TfrxStyleEditorForm = class(TForm)
    ToolBar: TToolBar;
    AddB: TfrxToolButton;
    DeleteB: TfrxToolButton;
    LoadB: TfrxToolButton;
    SaveB: TfrxToolButton;
    CancelB: TfrxToolButton;
    OkB: TfrxToolButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    EditB: TfrxToolButton;
    PaintBox: TPaintBox;
    ColorB: TButton;
    FontB: TButton;
    FrameB: TButton;
    StylesTV: TfrxTreeView;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure OkBClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject; Canvas: TCanvas);
    procedure FormHide(Sender: TObject);
    procedure AddBClick(Sender: TObject);
    procedure DeleteBClick(Sender: TObject);
    procedure LoadBClick(Sender: TObject);
    procedure SaveBClick(Sender: TObject);
    procedure BClick(Sender: TObject);
    procedure StylesTVClick(Sender: TObject);
    procedure StylesTVEdited(Sender: TObject; Node: TfrxTreeViewItem; var S: String);
    procedure EditBClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FReport: TfrxReport;
    FStyles: TfrxStyles;
    procedure UpdateStyles(Focus: Integer = 0);
    procedure UpdateControls;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;


implementation

{$R *.FMX}

uses FMX.frxDesgn, FMX.frxEditFrame, FMX.frxDesgnCtrls, FMX.frxRes;


constructor TfrxStyleEditorForm.Create(AOwner: TComponent);
begin
  inherited;
  FStyles := TfrxStyles.Create(nil);
end;

destructor TfrxStyleEditorForm.Destroy;
begin
  FStyles.Free;
  inherited;
end;

procedure TfrxStyleEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormHide(Self);
end;

procedure TfrxStyleEditorForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(5100);
  ColorB.Text := frxGet(5101);
  FontB.Text := frxGet(5102);
  FrameB.Text := frxGet(5103);
  AddB.Hint := frxGet(5104);
  DeleteB.Hint := frxGet(5105);
  EditB.Hint := frxGet(5106);
  LoadB.Hint := frxGet(5107);
  SaveB.Hint := frxGet(5108);
  CancelB.Hint := frxGet(2);
  OkB.Hint := frxGet(1);
  StylesTV.Editable := True;
  StylesTV.OnEdited := StylesTVEdited;
  FReport := TfrxCustomDesigner(Owner).Report;
  frxResources.LoadImageFromResouce(AddB.Bitmap, 8, 7);
  frxResources.LoadImageFromResouce(DeleteB.Bitmap, 5, 1);
  frxResources.LoadImageFromResouce(EditB.Bitmap, 10, 5);
  frxResources.LoadImageFromResouce(LoadB.Bitmap, 0, 1);
  frxResources.LoadImageFromResouce(SaveB.Bitmap, 0, 2);
  frxResources.LoadImageFromResouce(CancelB.Bitmap, 21, 2);
  frxResources.LoadImageFromResouce(OkB.Bitmap, 21, 0);
end;

procedure TfrxStyleEditorForm.FormShow(Sender: TObject);
begin
  FStyles.Assign(FReport.Styles);
  UpdateStyles;
end;

procedure TfrxStyleEditorForm.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
    FReport.Styles.Assign(FStyles);
end;

procedure TfrxStyleEditorForm.UpdateStyles(Focus: Integer = 0);
var
  i: Integer;
  Node: TfrxTreeViewItem;
begin
  StylesTV.BeginUpdate;
  StylesTV.Clear;
  for i := 0 to FStyles.Count - 1 do
  begin
    Node := StylesTV.AddItem(StylesTV, FStyles[i].Name);
    Node.TagObject := FStyles[i];
  end;
  StylesTV.EndUpdate;

  if Focus >= StylesTV.Count then
    Focus := StylesTV.Count - 1;
  if Focus <> -1 then
    StylesTV.Selected := StylesTV.Items[Focus];
  StylesTVClick(nil);
end;

procedure TfrxStyleEditorForm.UpdateControls;
var
  b: Boolean;
begin
  b := StylesTV.Selected <> nil;
  ColorB.Enabled := b;
  FontB.Enabled := b;
  FrameB.Enabled := b;
end;

procedure TfrxStyleEditorForm.PaintBoxPaint(Sender: TObject; Canvas: TCanvas);
var
  m: TfrxMemoView;
begin
  with PaintBox.Canvas do
  begin
    Fill.Color := claWhite;
    Stroke.Color := claGray;
    StrokeThickness := 1;
    Stroke.Kind := TBrushKind.bkSolid;
    DrawRect(RectF(0, 0, PaintBox.Width, PaintBox.Height), 1, 1, AllCorners, 1, TCornerType.ctBevel);
  end;

  if StylesTV.Selected = nil then Exit;

  m := TfrxMemoView.Create(nil);
  m.ApplyStyle(TfrxStyleItem(StylesTV.Selected.TagObject));
  m.Text := frxResources.Get('dsStyleSample');
  m.GapX := 20;
  m.GapY := 10;
  m.Width := m.CalcWidth;
  m.Height := m.CalcHeight;
  m.Left := (PaintBox.Width - m.Width) / 2;
  m.Top := (PaintBox.Height - m.Height) / 2;
  m.Draw(PaintBox.Canvas, 1, 1, 0, 0);
  m.Free;
end;

procedure TfrxStyleEditorForm.StylesTVClick(Sender: TObject);
begin
  UpdateControls;
  //PaintBoxPaint(nil, PaintBox.Canvas);
  Self.InvalidateRect(RectF(0, 0, Self.Width, Self.Height));
end;

procedure TfrxStyleEditorForm.BClick(Sender: TObject);
var
  Style: TfrxStyleItem;
begin
  if StylesTV.Selected = nil then Exit;
  Style := TfrxStyleItem(StylesTV.Selected.TagObject);

  case TControl(Sender).Tag of
    2:
      with TfrxColorSelector.Create(TComponent(Sender)) do
      begin
        OnColorChanged := BClick;

        //Color := AColor;
        BtnCaption := frxResources.Get('dsColorOth');
        Popup(ColorB);
        Tag := 20;
      end;

    20:
    Style.Color := TfrxColorSelector(Sender).Color;

    3:
      with TfrxFontForm.Create(Application) do
      begin
        FontS.Assign(Style.Font);
        FormActivate(Sender);
        if ShowModal = mrOk then
          Style.Font.Assign(FontS);
        Free;
      end;

    4:
      with TfrxFrameEditorForm.Create(Owner) do
      begin
        Frame.Assign(Style.Frame);
        if ShowModal = mrOk then
          Style.Frame := Frame;
        Free;
      end;
  end;
  Self.InvalidateRect(RectF(0, 0, Self.Width, Self.Height));
  //PaintBoxPaint(nil, PaintBox.Canvas);
end;

procedure TfrxStyleEditorForm.AddBClick(Sender: TObject);
begin
  FStyles.Add.CreateUniqueName;
  UpdateStyles(FStyles.Count - 1);
  StylesTV.DoEdit;
end;

procedure TfrxStyleEditorForm.DeleteBClick(Sender: TObject);
begin
  if StylesTV.Selected = nil then Exit;
  TfrxStyleItem(StylesTV.Selected.TagObject).Free;
  UpdateStyles(StylesTV.Selected.Index);
end;

procedure TfrxStyleEditorForm.LoadBClick(Sender: TObject);
begin
  OpenDialog.Filter := frxResources.Get('dsStyleFile') + ' (*.fs3)|*.fs3';
  if frxDesignerComp <> nil then
    OpenDialog.InitialDir := frxDesignerComp.OpenDir;
  if OpenDialog.Execute then
  begin
    FStyles.LoadFromFile(OpenDialog.FileName);
    UpdateStyles;
  end;
end;

procedure TfrxStyleEditorForm.SaveBClick(Sender: TObject);
begin
  SaveDialog.Filter := frxResources.Get('dsStyleFile') + ' (*.fs3)|*.fs3';
  if frxDesignerComp <> nil then
    SaveDialog.InitialDir := frxDesignerComp.SaveDir;
  if SaveDialog.Execute then
    FStyles.SaveToFile(ChangeFileExt(SaveDialog.FileName, '.fs3'));
end;

procedure TfrxStyleEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrxStyleEditorForm.OkBClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrxStyleEditorForm.StylesTVEdited(Sender: TObject; Node: TfrxTreeViewItem; var S: String);
var
  Style: TfrxStyleItem;
begin
  Style := TfrxStyleItem(Node.TagObject);
  Style.Name := s;
end;

procedure TfrxStyleEditorForm.EditBClick(Sender: TObject);
begin
  if StylesTV.Selected = nil then Exit;
  StylesTV.DoEdit;
end;

procedure TfrxStyleEditorForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VKF1 then
    frxResources.Help(Self);
  if Key = VKF2 then
    EditBClick(nil);
end;

end.


//56db3b0f55102b9488a240d37950543f