
{******************************************}
{                                          }
{             FastReport v4.0              }
{            Designer options              }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxEditOptions;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.Types, System.UITypes, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.ExtCtrls, FMX.frxCtrls, FMX.Objects, FMX.ListBox, FMX.Edit, FMX.Types, System.Variants
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};
  

type
  TfrxOptionsEditor = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    RestoreDefaultsB: TButton;
    Label1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    CMRB: TRadioButton;
    InchesRB: TRadioButton;
    PixelsRB: TRadioButton;
    CME: TEdit;
    InchesE: TEdit;
    PixelsE: TEdit;
    DialogFormE: TEdit;
    ShowGridCB: TCheckBox;
    AlignGridCB: TCheckBox;
    Label6: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    CodeWindowFontCB: TComboBox;
    CodeWindowSizeCB: TComboBox;
    MemoEditorFontCB: TComboBox;
    MemoEditorSizeCB: TComboBox;
    ObjectFontCB: TCheckBox;
    Label5: TGroupBox;
    Label12: TLabel;
    Label17: TLabel;
    EditAfterInsCB: TCheckBox;
    FreeBandsCB: TCheckBox;
    GapE: TEdit;
    BandsCaptionsCB: TCheckBox;
    DropFieldsCB: TCheckBox;
    StartupCB: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure RestoreDefaultsBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FWColor: TColor;
    FTColor: TColor;
  public
    { Public declarations }
  end;


implementation

{$R *.FMX}

uses FMX.frxDesgn, FMX.frxDesgnWorkspace, FMX.frxUtils, FMX.frxRes, FMX.frxFMX;


{ TfrxPreferencesEditor }

procedure TfrxOptionsEditor.FormShow(Sender: TObject);

  procedure SetEnabled(cAr: Array of TControl; Enabled: Boolean);
  var
    i: Integer;
  begin
    for i := 0 to High(cAr) do
      cAr[i].Enabled := Enabled;
  end;

begin
  //ColorDialog.CustomColors.Add('ColorA=' + IntToHex(ColorToRGB(clBtnFace), 6));

  with TfrxDesignerForm(Owner) do
  begin
    FillFontsList(CodeWindowFontCB.Items);
    FillFontsList(MemoEditorFontCB.Items);

    SetEnabled([CMRB, InchesRB, PixelsRB, CME, InchesE, PixelsE],
      (Workspace.GridType <> gtDialog) and (Workspace.GridType <> gtChar));

    CMRB.IsChecked := Units = duCM;
    InchesRB.IsChecked := Units = duInches;
    PixelsRB.IsChecked := Units = duPixels;

    CME.Text := FloatToStr(GridSize1);
    InchesE.Text := FloatToStr(GridSize2);
    PixelsE.Text := FloatToStr(GridSize3);
    DialogFormE.Text := FloatToStr(GridSize4);

    ShowGridCB.IsChecked := ShowGrid;
    AlignGridCB.IsChecked := GridAlign;
    EditAfterInsCB.IsChecked := EditAfterInsert;
    BandsCaptionsCB.IsChecked := Workspace.ShowBandCaptions;
    DropFieldsCB.IsChecked := DropFields;
    StartupCB.IsChecked := ShowStartup;
    StartupCB.Visible := False;
    FreeBandsCB.IsChecked := Workspace.FreeBandsPlacement;
    GapE.Text := IntToStr(Workspace.GapBetweenBands);

    //CodeWindowFontCB.Selected.Text := CodeWindow.Font.Name;
    //CodeWindowSizeCB.Selected.Text := IntToStr(CodeWindow.Font.Size);
    MemoEditorFontCB.ItemIndex := MemoEditorFontCB.Items.IndexOf(MemoFontName);
    MemoEditorSizeCB.ItemIndex := MemoEditorSizeCB.Items.IndexOf(IntToStr(MemoFontSize));
    ObjectFontCB.IsChecked := UseObjectFont;
  end;
end;


procedure TfrxOptionsEditor.RestoreDefaultsBClick(Sender: TObject);
begin
  TfrxDesignerForm(Owner).RestoreState(True);
  ModalResult := mrOk;
end;

procedure TfrxOptionsEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrOk then
    with TfrxDesignerForm(Owner) do
    begin
      GridSize4 := frxStrToFloat(DialogFormE.Text);

      if CMRB.Enabled then
      begin
        GridSize1 := frxStrToFloat(CME.Text);
        GridSize2 := frxStrToFloat(InchesE.Text);
        GridSize3 := frxStrToFloat(PixelsE.Text);

        if CMRB.IsChecked then
          Units := duCM
        else if InchesRB.IsChecked then
          Units := duInches else
          Units := duPixels;
      end;

      ShowGrid := ShowGridCB.IsChecked;
      GridAlign := AlignGridCB.IsChecked;
      EditAfterInsert := EditAfterInsCB.IsChecked;
      Workspace.ShowBandCaptions := BandsCaptionsCB.IsChecked;
      DropFields := DropFieldsCB.IsChecked;
      ShowStartup := StartupCB.IsChecked;
      Workspace.FreeBandsPlacement := FreeBandsCB.IsChecked;
      Workspace.GapBetweenBands := StrToInt(GapE.Text);

      //CodeWindow.Font.Name := CodeWindowFontCB.Text;
      //CodeWindow.Font.Size := StrToInt(CodeWindowSizeCB.Text);
      if MemoEditorFontCB.Selected <> nil then
        MemoFontName := MemoEditorFontCB.Selected.Text;
      if MemoEditorSizeCB.Selected <> nil then
        MemoFontSize := StrToInt(MemoEditorSizeCB.Selected.Text);
      UseObjectFont := ObjectFontCB.IsChecked;
    end;
end;

procedure TfrxOptionsEditor.FormCreate(Sender: TObject);
begin
  Caption := frxGet(3000);
  Label1.Text := frxGet(3001);
  Label2.Text := frxGet(3002);
  Label3.Text := frxGet(3003);
  Label4.Text := frxGet(3004);
  Label5.Text := frxGet(3005);
  Label6.Text := frxGet(3006);
  Label7.Text := frxGet(3007);
  Label8.Text := frxGet(3008);
  Label9.Text := frxGet(3009);
  Label10.Text := frxGet(3010);
  Label12.Text := frxGet(3012);
  Label13.Text := frxGet(3013);
  Label14.Text := frxGet(3014);
  Label15.Text := frxGet(3015);
  Label16.Text := frxGet(3016);
  Label17.Text := frxGet(3017);
  OkB.Text := frxGet(1);
  CancelB.Text := frxGet(2);
  CMRB.Text := frxGet(3018);
  InchesRB.Text := frxGet(3019);
  PixelsRB.Text := frxGet(3020);
  ShowGridCB.Text := frxGet(3021);
  AlignGridCB.Text := frxGet(3022);
  EditAfterInsCB.Text := frxGet(3023);
  ObjectFontCB.Text := frxGet(3024);
  FreeBandsCB.Text := frxGet(3028);
  DropFieldsCB.Text := frxGet(3029);
  StartupCB.Text := frxGet(3030);
  RestoreDefaultsB.Text := frxGet(3031);
  BandsCaptionsCB.Text := frxGet(3032);
  FormShow(Self);
  //if UseRightToLeftAlignment then
  //  FlipChildren(True);
end;

procedure TfrxOptionsEditor.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

end.


//56db3b0f55102b9488a240d37950543f