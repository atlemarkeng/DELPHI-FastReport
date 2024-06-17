
{******************************************}
{                                          }
{             FastReport v4.0              }
{      Property editors for Designer       }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxDesgnEditors;

interface

{$I frx.inc}

implementation

uses
  System.Classes, System.SysUtils, System.UITypes, System.Types, System.UIConsts,
  FMX.Types, FMX.Objects, FMX.Controls, FMX.Forms, FMX.Menus,
  FMX.Dialogs, FMX.frxClass, FMX.frxDMPClass, FMX.frxDesgn, FMX.frxDsgnIntf, FMX.frxUtils,
  FMX.frxCtrls, FMX.frxCustomEditors, FMX.frxEditPage, FMX.frxEditMemo,
  FMX.frxEditDataBand, FMX.frxEditStrings, FMX.frxEditFormat, FMX.frxEditGroup, FMX.frxEditSysMemo,
  FMX.frxCodeUtils, FMX.frxEditPicture, FMX.frxEditFrame, FMX.frxRes,
  FMX.frxUnicodeUtils, FMX.frxPrinter, System.Variants, System.WideStrings, FMX.ListBox
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF}
{$IFDEF DELPHI20}
  , System.Math.Vectors
{$ENDIF};



type
  { Component editors }

  TfrxPageEditor = class(TfrxComponentEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
  end;

  TfrxMemoEditor = class(TfrxCustomMemoEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
  end;

  TfrxSysMemoEditor = class(TfrxCustomMemoEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
  end;

  TfrxLineEditor = class(TfrxViewEditor)
  public
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  TfrxPictureEditor = class(TfrxViewEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  TfrxBandEditor = class(TfrxComponentEditor)
  public
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  TfrxDataBandEditor = class(TfrxBandEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  TfrxHeaderEditor = class(TfrxBandEditor)
  public
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  TfrxPageHeaderEditor = class(TfrxBandEditor)
  public
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  TfrxPageFooterEditor = class(TfrxComponentEditor)
  public
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  TfrxGroupHeaderEditor = class(TfrxBandEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  TfrxColumnHeaderEditor = class(TfrxBandEditor)
  public
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  TfrxColumnFooterEditor = class(TfrxBandEditor)
  public
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  TfrxOverlayEditor = class(TfrxBandEditor)
  public
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;


  TfrxDialogControlEditor = class(TfrxComponentEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
  end;

  TfrxSubreportEditor = class(TfrxComponentEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  { Property editors }

  TfrxMemoProperty = class(TfrxClassProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
  end;

  TfrxFrameProperty = class(TfrxClassProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
  end;

  TfrxPictureProperty = class(TfrxClassProperty)
  public
    function GetValue: String; override;
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
  end;

  TfrxBitmapProperty = class(TfrxClassProperty)
  public
    function GetValue: String; override;
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
  end;

  TfrxDataSetProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxDataFieldProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxEventProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
    procedure GetValues; override;
  end;

  TfrxLocSizeXProperty = class(TfrxFloatProperty)
  protected
    FRatio: Extended;
  public
    constructor Create(Designer: TfrxCustomDesigner); override;
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxLocSizeYProperty = class(TfrxLocSizeXProperty)
  public
    constructor Create(Designer: TfrxCustomDesigner); override;
  end;

  TfrxPaperXProperty = class(TfrxFloatProperty)
  protected
    FRatio: Extended;
  public
    constructor Create(Designer: TfrxCustomDesigner); override;
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxPaperYProperty = class(TfrxPaperXProperty)
  public
    constructor Create(Designer: TfrxCustomDesigner); override;
  end;

  TfrxStringsProperty = class(TfrxClassProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
  end;

  TfrxBrushProperty = class(TfrxEnumProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure OnDrawLBItem(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF); override;
    procedure OnDrawItem(Canvas: TCanvas; ARect: TRectF); override;
  end;

  TfrxFrameStyleProperty = class(TfrxEnumProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetExtraLBSize: Integer; override;
    procedure OnDrawLBItem(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF); override;
    procedure OnDrawItem(Canvas: TCanvas; ARect: TRectF); override;
  end;

  TfrxDisplayFormatProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
  end;

  TfrxBooleanProperty = class(TfrxEnumProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure OnDrawLBItem(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF); override;
    procedure OnDrawItem(Canvas: TCanvas; ARect: TRectF); override;
  end;

  TfrxPrinterProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
  end;

  TfrxPaperProperty = class(TfrxIntegerProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxStyleProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
  end;



{ TfrxPageEditor }

function TfrxPageEditor.Edit: Boolean;
begin
  Result := False;
  if (Component is TfrxReportPage) and
    (TfrxReportPage(Component).Subreport = nil) then
    with TfrxPageEditorForm.Create(Designer) do
    begin
      Result := ShowModal = mrOk;
      Free;
    end;
end;

function TfrxPageEditor.HasEditor: Boolean;
begin
  Result := True;
end;


{ TfrxMemoEditor }

function TfrxMemoEditor.Edit: Boolean;
begin
  with TfrxMemoEditorForm.Create(Designer) do
  begin
    MemoView := TfrxMemoView(Component);
    FormShow(Self);
    Result := ShowModal = mrOk;
    if Result then
    begin
      MemoView.Text := Text;
      MemoView.DataField := '';
    end;
    Free;
  end;
end;

function TfrxMemoEditor.HasEditor: Boolean;
begin
  Result := True;
end;


{ TfrxSysMemoEditor }

function TfrxSysMemoEditor.Edit: Boolean;
begin
  with TfrxSysMemoEditorForm.Create(Designer) do
  begin
    Text := TfrxSysMemoView(Component).Text;
    FormShow(Self);
    Result := ShowModal = mrOk;
    if Result then
      TfrxSysMemoView(Component).Text := Text;
    Free;
  end;
end;

function TfrxSysMemoEditor.HasEditor: Boolean;
begin
  Result := True;
end;


{ TfrxLineEditor }

function TfrxLineEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  i: Integer;
  c: TfrxComponent;
  l: TfrxCustomLineView;
begin
  Result := inherited Execute(Tag, Checked);

  for i := 0 to Designer.SelectedObjects.Count - 1 do
  begin
    c := Designer.SelectedObjects[i];
    if (c is TfrxCustomLineView) and not (rfDontModify in c.Restrictions) then
    begin
      l := TfrxCustomLineView(c);
      case Tag of
        0: l.Diagonal := Checked;
        1: if Checked then
             l.StretchMode := smMaxHeight else
             l.StretchMode := smDontStretch;
      end;

      Result := True;
    end;
  end;
end;

procedure TfrxLineEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
var
  l: TfrxCustomLineView;
begin
  inherited;
  l := TfrxCustomLineView(Component);

  if l is TfrxLineView then
    AddItem(frxResources.Get('lvDiagonal'), 0, l.Diagonal);
  AddItem(frxResources.Get('mvStretch'), 1, l.StretchMode = smMaxHeight);

  inherited;
end;


{ TfrxPictureEditor }

function TfrxPictureEditor.Edit: Boolean;
begin
  with TfrxPictureEditorForm.Create(Designer) do
  begin
    Image.Bitmap.Assign(TfrxPictureView(Component).Picture);
    FormShow(Self);
    Result := ShowModal = mrOk;
    if Result then
    begin
      TfrxPictureView(Component).Picture.Assign(Image.Bitmap);
      TfrxDesignerForm(Self.Designer).PictureCache.AddPicture(TfrxPictureView(Component));
    end;
    Free;
  end;
end;

function TfrxPictureEditor.HasEditor: Boolean;
begin
  Result := True;
end;

function TfrxPictureEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  i: Integer;
  c: TfrxComponent;
  p: TfrxPictureView;
begin
  Result := inherited Execute(Tag, Checked);

  for i := 0 to Designer.SelectedObjects.Count - 1 do
  begin
    c := Designer.SelectedObjects[i];
    if (c is TfrxPictureView) and not (rfDontModify in c.Restrictions) then
    begin
      p := TfrxPictureView(c);
      case Tag of
        0: p.AutoSize := Checked;
        1: p.Stretched := Checked;
        2: p.Center := Checked;
        3: p.KeepAspectRatio := Checked;
      end;

      Result := True;
    end;
  end;
end;

procedure TfrxPictureEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
var
  p: TfrxPictureView;
begin
  inherited;
  p := TfrxPictureView(Component);

  AddItem(frxResources.Get('pvAutoSize'), 0, p.AutoSize);
  AddItem(frxResources.Get('mvStretch'), 1, p.Stretched);
  AddItem(frxResources.Get('pvCenter'), 2, p.Center);
  AddItem(frxResources.Get('pvAspect'), 3, p.KeepAspectRatio);
  AddItem('-', -1);

  inherited;
end;


{ TfrxBandEditor }

function TfrxBandEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  b: TfrxBand;
begin
  Result := False;

  b := Designer.SelectedObjects[0];
  if not (rfDontModify in b.Restrictions) then
  begin
    case Tag of
      10: b.Stretched := Checked;
      11: b.AllowSplit := Checked;
      12: b.KeepChild := Checked;
      13: b.PrintChildIfInvisible := Checked;
      14: b.StartNewPage := Checked;
    end;
    Result := True;
  end;
end;

procedure TfrxBandEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
var
  b: TfrxBand;
begin
  inherited;
  if Designer.SelectedObjects.Count > 1 then Exit;
  b := TfrxBand(Component);

  if not b.Vertical then
  begin
    AddItem(frxResources.Get('mvStretch'), 10, b.Stretched);
    if not (b.BandNumber in [2,3,15,16]) then
      AddItem(frxResources.Get('bvSplit'), 11, b.AllowSplit);
    if not (b.BandNumber in [2,15]) then
      AddItem(frxResources.Get('bvKeepChild'), 12, b.KeepChild);
  end;
  AddItem(frxResources.Get('bvPrintChild'), 13, b.PrintChildIfInvisible);
  if not (b.BandNumber in [2,3,5,13,15,16]) then
    AddItem(frxResources.Get('bvStartPage'), 14, b.StartNewPage);
end;


{ TfrxDataBandEditor }

function TfrxDataBandEditor.Edit: Boolean;
begin
  with TfrxDataBandEditorForm.Create(Designer) do
  begin
    DataBand := TfrxDataBand(Component);
    FormShow(Self);
    Result := ShowModal = mrOk;
    Free;
  end;
end;

function TfrxDataBandEditor.HasEditor: Boolean;
begin
  Result := True;
end;

function TfrxDataBandEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  b: TfrxDataBand;
begin
  Result := inherited Execute(Tag, Checked);

  b := Designer.SelectedObjects[0];
  if not (rfDontModify in b.Restrictions) then
  begin
    case Tag of
      0: b.PrintIfDetailEmpty := Checked;
      1: b.FooterAfterEach := Checked;
      2: b.KeepTogether := Checked;
      3: b.KeepFooter := Checked;
      4: b.KeepHeader := Checked;
    end;
    Result := True;
  end;
end;

procedure TfrxDataBandEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
var
  b: TfrxDataBand;
begin
  inherited;
  if Designer.SelectedObjects.Count > 1 then Exit;
  b := TfrxDataBand(Component);

  AddItem(frxResources.Get('bvPrintIfEmpty'), 0, b.PrintIfDetailEmpty);
  AddItem(frxResources.Get('bvFooterAfterEach'), 1, b.FooterAfterEach);
  if not b.Vertical then
  begin
    AddItem(frxResources.Get('bvKeepDetail'), 2, b.KeepTogether);
    AddItem(frxResources.Get('bvKeepFooter'), 3, b.KeepFooter);
    AddItem(frxResources.Get('bvKeepHeader'), 4, b.KeepHeader);
  end;
end;


{ TfrxHeaderEditor }

function TfrxHeaderEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  b: TfrxHeader;
begin
  Result := inherited Execute(Tag, Checked);

  b := Designer.SelectedObjects[0];
  if not (rfDontModify in b.Restrictions) then
  begin
    if Tag = 0 then
      b.ReprintOnNewPage := Checked;
    Result := True;
  end;
end;

procedure TfrxHeaderEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
var
  b: TfrxHeader;
begin
  inherited;
  if Designer.SelectedObjects.Count > 1 then Exit;
  b := TfrxHeader(Component);

  AddItem(frxResources.Get('bvReprint'), 0, b.ReprintOnNewPage);
end;


{ TfrxPageHeaderEditor }

function TfrxPageHeaderEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  b: TfrxPageHeader;
begin
  Result := inherited Execute(Tag, Checked);

  b := Designer.SelectedObjects[0];
  if not (rfDontModify in b.Restrictions) then
  begin
    if Tag = 0 then
      b.PrintOnFirstPage := Checked;
    Result := True;
  end;
end;

procedure TfrxPageHeaderEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
var
  b: TfrxPageHeader;
begin
  inherited;
  if Designer.SelectedObjects.Count > 1 then Exit;
  b := TfrxPageHeader(Component);

  AddItem(frxResources.Get('bvOnFirst'), 0, b.PrintOnFirstPage);
end;


{ TfrxPageFooterEditor }

function TfrxPageFooterEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  b: TfrxPageFooter;
begin
  Result := False;

  b := Designer.SelectedObjects[0];
  if not (rfDontModify in b.Restrictions) then
  begin
    case Tag of
      0: b.PrintOnFirstPage := Checked;
      1: b.PrintOnLastPage := Checked;
    end;
    Result := True;
  end;
end;

procedure TfrxPageFooterEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
var
  b: TfrxPageFooter;
begin
  inherited;
  if Designer.SelectedObjects.Count > 1 then Exit;
  b := TfrxPageFooter(Component);

  AddItem(frxResources.Get('bvOnFirst'), 0, b.PrintOnFirstPage);
  AddItem(frxResources.Get('bvOnLast'), 1, b.PrintOnLastPage);
end;


{ TfrxGroupHeaderEditor }

function TfrxGroupHeaderEditor.Edit: Boolean;
begin
  with TfrxGroupEditorForm.Create(Designer) do
  begin
    GroupHeader := TfrxGroupHeader(Component);
    FormShow(Self);
    Result := ShowModal = mrOk;
    Free;
  end;
end;

function TfrxGroupHeaderEditor.HasEditor: Boolean;
begin
  Result := True;
end;

function TfrxGroupHeaderEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  b: TfrxGroupHeader;
begin
  Result := inherited Execute(Tag, Checked);

  b := Designer.SelectedObjects[0];
  if not (rfDontModify in b.Restrictions) then
  begin
    if Tag = 0 then
      b.KeepTogether := Checked
    else if Tag = 1 then
      b.ReprintOnNewPage := Checked
    else if Tag = 2 then
      b.DrillDown := Checked
    else if Tag = 3 then
    begin
      b.ResetPageNumbers := Checked;
      if Checked then
        b.StartNewPage := True;
    end;
    Result := True;
  end;
end;

procedure TfrxGroupHeaderEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
var
  b: TfrxGroupHeader;
begin
  inherited;
  if Designer.SelectedObjects.Count > 1 then Exit;
  b := TfrxGroupHeader(Component);

  AddItem(frxResources.Get('bvKeepGroup'), 0, b.KeepTogether);
  AddItem(frxResources.Get('bvReprint'), 1, b.ReprintOnNewPage);
  AddItem(frxResources.Get('bvDrillDown'), 2, b.DrillDown);
  AddItem(frxResources.Get('bvResetPageNo'), 3, b.ResetPageNumbers);
end;


{ TfrxDialogControlEditor }

function TfrxDialogControlEditor.Edit: Boolean;
var
  i: Integer;
  c: TfrxDialogControl;
  s: String;
begin
  c := TfrxDialogControl(Component);
  if c.OnClick = '' then
  begin
    s := c.Name + 'OnClick';
    c.OnClick := s;
    i := frxLocateEventHandler(Designer.Code, Designer.Report.ScriptLanguage, s);
    if i = -1 then
      i := frxAddEvent(Designer.Code, Designer.Report.ScriptLanguage,
        TypeInfo(TfrxNotifyEvent), s) else
      Inc(i, 3);

    TfrxDesignerForm(Designer).SwitchToCodeWindow;
    TfrxDesignerForm(Designer).CodeWindow.UpdateView;
    TfrxDesignerForm(Designer).CodeWindow.SetPos(3, i);
    Result := True;
  end
  else
  begin
    i := frxLocateEventHandler(Designer.Code, Designer.Report.ScriptLanguage,
      c.OnClick);

    TfrxDesignerForm(Designer).SwitchToCodeWindow;
    TfrxDesignerForm(Designer).CodeWindow.SetPos(1, i + 3);
    Result := False;
  end;
end;

function TfrxDialogControlEditor.HasEditor: Boolean;
begin
  Result := True;
end;


{ TfrxSubreportEditor }

function TfrxSubreportEditor.Edit: Boolean;
var
  s: TfrxSubreport;
begin
  Result := False;
  s := TfrxSubreport(Component);
  if s.Page <> nil then
    Designer.Page := s.Page;
end;

function TfrxSubreportEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  s: TfrxSubreport;
begin
  Result := inherited Execute(Tag, Checked);

  s := TfrxSubreport(Component);
  if not (rfDontModify in s.Restrictions) then
  begin
    if Tag = 0 then
      s.PrintOnParent := Checked;
    Result := True;
  end;
end;

procedure TfrxSubreportEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
begin
  inherited;
  AddItem(frxResources.Get('srParent'), 0, TfrxSubreport(Component).PrintOnParent);
end;

function TfrxSubreportEditor.HasEditor: Boolean;
begin
  Result := True;
end;


{ TfrxMemoProperty }

function TfrxMemoProperty.Edit: Boolean;
begin
  with TfrxMemoEditorForm.Create(Designer) do
  begin
    MemoView := TfrxMemoView(Component);
    FormShow(Self);
    Result := ShowModal = mrOk;
    if Result then
      MemoView.Text := Memo.Text;
    Free;
  end;
end;

function TfrxMemoProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;


{ TfrxFrameProperty }

function TfrxFrameProperty.Edit: Boolean;
begin
  with TfrxFrameEditorForm.Create(Designer) do
  begin
    Frame.Assign(TfrxFrame(GetOrdValue));
    FormShow(Self);
    Result := ShowModal = mrOk;
    if Result then
      TfrxFrame(GetOrdValue).Assign(Frame);
    Free;
  end;
end;

function TfrxFrameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog, paReadOnly];
end;


{ TfrxPictureProperty }

function TfrxPictureProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TfrxPictureProperty.Edit: Boolean;
var
  Pict: TBitmap;
begin
  with TfrxPictureEditorForm.Create(Designer) do
  begin
    Pict := TBitmap(GetOrdValue);
    Image.Bitmap.Assign(Pict);
    FormShow(Self);
    Result := ShowModal = mrOk;
    if Result then
      Pict.Assign(Image.Bitmap);
    Free;
  end;
end;

function TfrxPictureProperty.GetValue: String;
var
  Pict: TBitmap;
begin
  Pict := TBitmap(GetOrdValue);
  if Pict.IsEmpty then
    Result := frxResources.Get('prNotAssigned') else
    Result := frxResources.Get('prPict');
end;


{ TfrxBitmapProperty }

function TfrxBitmapProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TfrxBitmapProperty.Edit: Boolean;
var
  Bmp: TBitmap;
begin
  with TfrxPictureEditorForm.Create(Designer) do
  begin
    Bmp := TBitmap(GetOrdValue);
    Image.Bitmap.Assign(Bmp);
    FormShow(Self);
    Result := ShowModal = mrOk;
    if Result then
      Bmp.Assign(Image.Bitmap);
    Free;
  end;
end;

function TfrxBitmapProperty.GetValue: String;
begin
  Result := frxResources.Get('prPict');
end;


{ TfrxDataSetProperty }

function TfrxDataSetProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList];
end;

function TfrxDataSetProperty.GetValue: String;
var
  ds: TfrxDataSet;
begin
  ds := TfrxDataSet(GetOrdValue);
  if (ds <> nil) and (frComponent.Report <> nil) then
    Result := frComponent.Report.GetAlias(ds) else
    Result := frxResources.Get('prNotAssigned');
end;

procedure TfrxDataSetProperty.GetValues;
begin
  if frComponent.Report = nil then Exit;
  frComponent.Report.GetDataSetList(Values);
  if Component is TfrxDataSet then
    Values.Delete(Values.IndexOf(TfrxDataSet(Component).UserName));
end;

procedure TfrxDataSetProperty.SetValue(const Value: String);
var
  ds: TfrxDataSet;
begin
  if Value = '' then
    SetOrdValue(0)
  else
  begin
    ds := frComponent.Report.GetDataSet(Value);
    if ds <> nil then
      SetOrdValue(frxInteger(ds)) else
      raise Exception.Create(frxResources.Get('prInvProp'));

    if Component is TfrxCustomMemoView then
      with TfrxCustomMemoView(Component) do
        if IsDataField then
          Text := '[' + DataSet.UserName + '."' + DataField + '"]';
  end;
end;


{ TfrxDataFieldProperty }

function TfrxDataFieldProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList];
end;

function TfrxDataFieldProperty.GetValue: String;
begin
  Result := GetStrValue;
end;

procedure TfrxDataFieldProperty.SetValue(const Value: String);
begin
  SetStrValue(Value);
  if Component is TfrxCustomMemoView then
    with TfrxCustomMemoView(Component) do
      if IsDataField then
        Text := '[' + DataSet.UserName + '."' + DataField + '"]';
end;

procedure TfrxDataFieldProperty.GetValues;
var
  ds: TfrxDataSet;
begin
  inherited;
  ds := TfrxView(Component).DataSet;
  if ds <> nil then
    ds.GetFieldList(Values);
end;


{ TfrxLocSizeXProperty }

constructor TfrxLocSizeXProperty.Create(Designer: TfrxCustomDesigner);
begin
  inherited;
  FRatio := fr1CharX;
end;

function TfrxLocSizeXProperty.GetValue: String;
var
  e: Extended;
begin
  e := GetFloatValue;
  case TfrxDesignerForm(Designer).Units of
    duCM: e := e / 96 * 2.54;
    duInches: e := e / 96;
    duChars: e := e / FRatio;
  end;

  if e = Int(e) then
    Result := FloatToStr(e) else
    Result := Format('%f', [e]);
end;

procedure TfrxLocSizeXProperty.SetValue(const Value: String);
var
  e: Extended;
begin
  e := frxStrToFloat(Value);
  case TfrxDesignerForm(Designer).Units of
    duCM: e := e * 96 / 2.54;
    duInches: e := e * 96;
    duChars: e := e * FRatio;
  end;

  SetFloatValue(e);
end;


{ TfrxLocSizeYProperty }

constructor TfrxLocSizeYProperty.Create(Designer: TfrxCustomDesigner);
begin
  inherited;
  FRatio := fr1CharY;
end;


{ TfrxPaperXProperty }

constructor TfrxPaperXProperty.Create(Designer: TfrxCustomDesigner);
begin
  inherited;
  FRatio := fr1CharX;
end;

function TfrxPaperXProperty.GetValue: String;
var
  e: Extended;
begin
  e := GetFloatValue;
  case TfrxDesignerForm(Designer).Units of
    duCM: e := e / 10;
    duInches: e := e / 25.4;
    duPixels: e := e * 96 / 25.4;
    duChars: e := e * 96 / 25.4 / FRatio;
  end;

  if e = Int(e) then
    Result := FloatToStr(e) else
    Result := Format('%f', [e]);
end;

procedure TfrxPaperXProperty.SetValue(const Value: String);
var
  e: Extended;
begin
  e := frxStrToFloat(Value);
  case TfrxDesignerForm(Designer).Units of
    duCM: e := e * 10;
    duInches: e := e * 25.4;
    duPixels: e := e * 25.4 / 96;
    duChars: e := e * 25.4 / 96 * FRatio;
  end;

  SetFloatValue(e);
end;


{ TfrxPaperYProperty }

constructor TfrxPaperYProperty.Create(Designer: TfrxCustomDesigner);
begin
  inherited;
  FRatio := fr1CharY;
end;


{ TfrxEventProperty }

function TfrxEventProperty.Edit: Boolean;
var
  i: Integer;
begin
  if not TfrxDesignerForm(Designer).CheckOp(drDontEditReportScript) then
  begin
   Result := False;
   Exit;
  end;
  if Value = '' then
  begin
    Value := frComponent.Name + GetName;
    i := frxLocateEventHandler(Designer.Code, Designer.Report.ScriptLanguage,
      Value);
    if i = -1 then
      i := frxAddEvent(Designer.Code, Designer.Report.ScriptLanguage,
        PropInfo.PropType^, Value) else
      Inc(i, 3);

      if i = -1 then
      begin
        Value := '';
        raise Exception.Create(frxResources.Get('dsCantFindProc'));
      end;

    TfrxDesignerForm(Designer).SwitchToCodeWindow;
    TfrxDesignerForm(Designer).CodeWindow.UpdateView;
    TfrxDesignerForm(Designer).CodeWindow.SetPos(3, i);
    Result := True;
  end
  else
  begin
    i := frxLocateEventHandler(Designer.Code, Designer.Report.ScriptLanguage,
      Value);

    TfrxDesignerForm(Designer).SwitchToCodeWindow;
    TfrxDesignerForm(Designer).CodeWindow.SetPos(1, i + 3);
    Result := False;
  end;
end;

function TfrxEventProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList];
end;

procedure TfrxEventProperty.GetValues;
begin
  inherited;
  frxGetEventHandlersList(Designer.Code, Designer.Report.ScriptLanguage,
    PropInfo.PropType^, Values);
end;


{ TfrxStringsProperty }

function TfrxStringsProperty.Edit: Boolean;
var
  l: TStrings;
begin
  with TfrxStringsEditorForm.Create(Designer) do
  begin
    l := TStrings(GetOrdValue);
    Memo.Lines.Assign(l);
    Result := ShowModal = mrOk;
    if Result then
      l.Assign(Memo.Lines);
    Free;
  end;
end;

function TfrxStringsProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;


{ TfrxBrushProperty }

function TfrxBrushProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paOwnerDraw];
end;

procedure TfrxBrushProperty.OnDrawLBItem(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
begin
  inherited;
//  with TListBox(Control), TListBox(Control).Canvas do
//  begin
//    Brush.Style := TBrushStyle(Index);
//    Brush.Color := clBlack;
//    Rectangle(ARect.Left + 2, ARect.Top + 2, ARect.Left + (ARect.Bottom - ARect.Top - 2), ARect.Bottom - 2);
//  end;
end;

procedure TfrxBrushProperty.OnDrawItem(Canvas: TCanvas; ARect: TRectF);
begin
  inherited;
//  with Canvas do
//  begin
//    Brush.Style := TBrushStyle(GetOrdValue);
//    Brush.Color := clBlack;
//    Rectangle(ARect.Left, ARect.Top + 1, ARect.Left + (ARect.Bottom - ARect.Top - 5), ARect.Bottom - 4);
//  end;
end;


{ TfrxFrameStyleProperty }

function TfrxFrameStyleProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paOwnerDraw];
end;

procedure HLine(Canvas: TCanvas; X, Y, DX: Integer);
var
  i: Integer;
begin
  with Canvas do
  begin
    Stroke.Color := claBlack;
    if Stroke.Kind = TBrushKind.bkNone then
    begin
      Stroke.Kind := TBrushKind.bkSolid;
      for i := 0 to 1 do
        DrawLine(PointF(X, Y - 2 + i * 2), PointF(X + DX, Y - 2 + i * 2), 1);
    end
    else
      for i := 0 to 1 do
        DrawLine(PointF(X, Y - 1 + i), PointF(X + DX, Y - 1 + i), 1);
  end;
end;

procedure TfrxFrameStyleProperty.OnDrawLBItem(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
begin
//  with TListBox(Control), TListBox(Control).Canvas do
//  begin
//    FillRect(ARect);
//    TextOut(ARect.Left + 40, ARect.Top + 1, TListBox(Control).Items[Index]);
//
//    Pen.Color := clGray;
//    Brush.Color := clWhite;
//    Rectangle(ARect.Left + 2, ARect.Top + 2, ARect.Left + 36, ARect.Bottom - 2);
//
//    Pen.Style := TPenStyle(Index);
//    HLine(TListBox(Control).Canvas, ARect.Left + 3, ARect.Top + (ARect.Bottom - ARect.Top) div 2, 32);
//    Pen.Style := psSolid;
//  end;
end;

procedure TfrxFrameStyleProperty.OnDrawItem(Canvas: TCanvas; ARect: TRectF);
begin
//  with Canvas do
//  begin
//    TextOut(ARect.Left + 38, ARect.Top, Value);
//
//    Pen.Color := clGray;
//    Brush.Color := clWhite;
//    Rectangle(ARect.Left, ARect.Top + 1, ARect.Left + 34, ARect.Bottom - 4);
//
//    Pen.Color := clBlack;
//    Pen.Style := TPenStyle(GetOrdValue);
//    HLine(Canvas, ARect.Left + 1, ARect.Top + (ARect.Bottom - ARect.Top) div 2 - 1, 32);
//    Pen.Style := psSolid;
//  end;
end;

function TfrxFrameStyleProperty.GetExtraLBSize: Integer;
begin
  Result := 36;
end;


{ TfrxDisplayFormatProperty }

function TfrxDisplayFormatProperty.Edit: Boolean;
var
  i: Integer;
  c: TfrxComponent;
begin
  with TfrxFormatEditorForm.Create(Designer) do
  begin
    Format.Assign(TfrxCustomMemoView(Component).DisplayFormat);
    FormShow(Self);
    Result := ShowModal = mrOk;
    if Result then
      for i := 0 to Self.Designer.SelectedObjects.Count - 1 do
      begin
        c := Self.Designer.SelectedObjects[i];
        if (c is TfrxCustomMemoView) and not (rfDontModify in c.Restrictions) then
          TfrxCustomMemoView(c).DisplayFormat := Format;
      end;
    Free;
  end;
end;

function TfrxDisplayFormatProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect, paReadOnly];
end;


{ TfrxBooleanProperty }

function TfrxBooleanProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paOwnerDraw];
end;

procedure TfrxBooleanProperty.OnDrawItem(Canvas: TCanvas; ARect: TRectF);
var
  add, i: Integer;
begin
  inherited;
  with Canvas do
  begin
    Stroke.Color := claDimGray;
    DrawRect(RectF(Round(ARect.Left) + 0.5, Round(ARect.Top) + 1.5, Round(ARect.Left + (ARect.Bottom - ARect.Top - 5)) - 0.5, Round(ARect.Bottom) - 4.5),
      0, 0, allCorners, 1);
    Stroke.Color := claBlack;
//    if Screen.PixelsPerInch > 96 then
//      add := 2
//    else
      add := 0;
    if Boolean(GetOrdValue) = True then
    begin
      for i := 0 to 2 do
      begin
        DrawLine(PointF(Round(ARect.Left) + 2.5 + add, Round(ARect.Top) + 5.5 + add + i), PointF(Round(ARect.Left) + 4.5 + add, Round(ARect.Top) + 7.5 + add + i), 1);
        DrawLine(PointF(Round(ARect.Left) + 4.5 + add, Round(ARect.Top) + 7.5 + add + i), PointF(Round(ARect.Left) + 8.5 + add, Round(ARect.Top) + 3.5 + add + i), 1);
      end;
    end;
  end;
end;

procedure TfrxBooleanProperty.OnDrawLBItem(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  add, i: Integer;
begin
  inherited;
  with Canvas do
  begin
    Fill.Color := claWhite;
    Fill.Kind := TBrushKind.bkSolid;
    FillRect(RectF(ARect.Left + 2, ARect.Top + 2, ARect.Left + (ARect.Bottom - ARect.Top - 2), ARect.Bottom - 2),
      0, 0, allCorners, 1);
    Stroke.Color := claDimGray;
    Stroke.Kind := TBrushKind.bkSolid;
    DrawRect(RectF(Round(ARect.Left) + 3.5, Round(ARect.Top) + 3.5, Round(ARect.Left + (ARect.Bottom - ARect.Top - 2)) - 0.5, Round(ARect.Bottom) - 2.5),
      0, 0, allCorners, 1);
    Stroke.Color := claBlack;
//    if Screen.PixelsPerInch > 96 then
//      add := 2
//    else
      add := 0;
    if TListBoxItem(Sender).Text = 'True' then
    begin
      for i := 0 to 2 do
      begin
        DrawLine(PointF(Round(ARect.Left) + 5.5 + add, Round(ARect.Top) + 7.5 + add + i), PointF(Round(ARect.Left) + 7.5 + add, Round(ARect.Top) + 9.5 + add + i), 1);
        DrawLine(PointF(Round(ARect.Left) + 7.5 + add, Round(ARect.Top) + 9.5 + add + i), PointF(Round(ARect.Left) + 11.5 + add, Round(ARect.Top) + 5.5 + add + i), 1);
      end;
    end;
  end;
end;


{ TfrxPrinterProperty }

function TfrxPrinterProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TfrxPrinterProperty.GetValues;
begin
  inherited;
  Values.Assign(frxPrinters.Printers);
  Values.Insert(0, frxResources.Get('prDefault'));
end;


{ TfrxPaperProperty }

function TfrxPaperProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paValueList];
end;

function TfrxPaperProperty.GetValue: String;
var
  i: Integer;
begin
  i := frxPrinters.Printer.PaperIndex(GetOrdValue);
  if i = -1 then
    i := frxPrinters.Printer.PaperIndex(256);
  Result := frxPrinters.Printer.Papers[i];
end;

procedure TfrxPaperProperty.GetValues;
begin
  inherited;
  Values.Assign(frxPrinters.Printer.Papers);
end;

procedure TfrxPaperProperty.SetValue(const Value: String);
begin
  SetOrdValue(frxPrinters.Printer.PaperNameToNumber(Value));
end;


{ TfrxStyleProperty }

function TfrxStyleProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paValueList, paMultiSelect];
end;

procedure TfrxStyleProperty.GetValues;
begin
  inherited;
  Designer.Report.Styles.GetList(Values);
end;


{ TfrxColumnFooterEditor }

function TfrxColumnFooterEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
begin
// do nothing
  Result := False;
end;

procedure TfrxColumnFooterEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
begin
// do nothing
end;

{ TfrxColumnHeaderEditor }

function TfrxColumnHeaderEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  b: TfrxBand;
begin
  Result := False;
  b := Designer.SelectedObjects[0];
  if not (rfDontModify in b.Restrictions) then
  begin
    case Tag of
      10: b.Stretched := Checked;
    end;
    Result := True;
  end;
end;

procedure TfrxColumnHeaderEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
var
  b: TfrxBand;
begin
  if Designer.SelectedObjects.Count > 1 then Exit;
  inherited;
  b := TfrxBand(Component);
  AddItem(frxResources.Get('mvStretch'), 10, b.Stretched);
end;

{ TfrxOverlayEditor }

function TfrxOverlayEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
begin
  //do nothhing
  Result := False;
end;

procedure TfrxOverlayEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
begin
  //do nothhing
end;

initialization
  frxObjects.RegisterObject1(TfrxMemoView, nil, '', '', 0, 102, [ctReport, ctData]);
  frxObjects.RegisterObject1(TfrxPictureView, nil, '', '', 0, 103);
  frxObjects.RegisterObject1(TfrxSubreport, nil, '', '', 0, 104, [ctReport, ctDMP]);
  frxObjects.RegisterObject1(TfrxSysMemoView, nil, '', '', 0, 132);
  frxObjects.RegisterCategory('Draw', nil, 'obCatDraw', 106);
  frxObjects.RegisterCategory('Other', nil, 'obCatOther', 179);
  {$IFDEF DB_CAT}
  frxObjects.RegisterCategory('DATABASES',nil,'obDataBases',53);
  frxObjects.RegisterCategory('TABLES',nil,'obTables',54);
  frxObjects.RegisterCategory('QUERIES',nil,'obQueries',56);
  {$ENDIF}
  frxObjects.RegisterObject1(TfrxLineView, nil, '', 'Draw', 0, 105, [ctReport, ctData]);
  frxObjects.RegisterObject1(TfrxLineView, nil, 'obDiagLine', 'Draw', 1, 107);
  frxObjects.RegisterObject1(TfrxLineView, nil, 'obDiagLine', 'Draw', 2, 150);
  frxObjects.RegisterObject1(TfrxLineView, nil, 'obDiagLine', 'Draw', 3, 151);
  frxObjects.RegisterObject1(TfrxLineView, nil, 'obDiagLine', 'Draw', 4, 152);
  frxObjects.RegisterObject1(TfrxShapeView, nil, 'obRect', 'Draw', 0, 108);
  frxObjects.RegisterObject1(TfrxShapeView, nil, 'obRoundRect', 'Draw', 1, 109);
  frxObjects.RegisterObject1(TfrxShapeView, nil, 'obEllipse', 'Draw', 2, 110);
  frxObjects.RegisterObject1(TfrxShapeView, nil, 'obTrian', 'Draw', 3, 111);
  frxObjects.RegisterObject1(TfrxShapeView, nil, 'obDiamond', 'Draw', 4, 131);

  frxComponentEditors.Register(TfrxReportPage, TfrxPageEditor);
  frxComponentEditors.Register(TfrxView, TfrxViewEditor);
  frxComponentEditors.Register(TfrxMemoView, TfrxMemoEditor);
  frxComponentEditors.Register(TfrxSysMemoView, TfrxSysMemoEditor);
  frxComponentEditors.Register(TfrxDMPMemoView, TfrxMemoEditor);
  frxComponentEditors.Register(TfrxLineView, TfrxLineEditor);
  frxComponentEditors.Register(TfrxDMPLineView, TfrxLineEditor);
  frxComponentEditors.Register(TfrxPictureView, TfrxPictureEditor);
  frxComponentEditors.Register(TfrxBand, TfrxBandEditor);
  frxComponentEditors.Register(TfrxDataBand, TfrxDataBandEditor);
  frxComponentEditors.Register(TfrxHeader, TfrxHeaderEditor);
  frxComponentEditors.Register(TfrxPageHeader, TfrxPageHeaderEditor);
  frxComponentEditors.Register(TfrxPageFooter, TfrxPageFooterEditor);
  frxComponentEditors.Register(TfrxGroupHeader, TfrxGroupHeaderEditor);
  frxComponentEditors.Register(TfrxColumnHeader, TfrxColumnHeaderEditor);
  frxComponentEditors.Register(TfrxColumnFooter, TfrxColumnFooterEditor);
  frxComponentEditors.Register(TfrxOverlay, TfrxOverlayEditor);
  frxComponentEditors.Register(TfrxDialogControl, TfrxDialogControlEditor);
  frxComponentEditors.Register(TfrxSubreport, TfrxSubreportEditor);

  frxPropertyEditors.Register(TypeInfo(Double), TfrxComponent, 'Left', TfrxLocSizeXProperty);
  frxPropertyEditors.Register(TypeInfo(Double), TfrxComponent, 'Top', TfrxLocSizeYProperty);
  frxPropertyEditors.Register(TypeInfo(Double), TfrxComponent, 'Width', TfrxLocSizeXProperty);
  frxPropertyEditors.Register(TypeInfo(Double), TfrxComponent, 'Height', TfrxLocSizeYProperty);

  frxPropertyEditors.Register(TypeInfo(Double), TfrxReportPage, 'PaperWidth', TfrxPaperXProperty);
  frxPropertyEditors.Register(TypeInfo(Double), TfrxReportPage, 'PaperHeight', TfrxPaperYProperty);
  frxPropertyEditors.Register(TypeInfo(Double), TfrxReportPage, 'LeftMargin', TfrxPaperXProperty);
  frxPropertyEditors.Register(TypeInfo(Double), TfrxReportPage, 'RightMargin', TfrxPaperXProperty);
  frxPropertyEditors.Register(TypeInfo(Double), TfrxReportPage, 'TopMargin', TfrxPaperYProperty);
  frxPropertyEditors.Register(TypeInfo(Double), TfrxReportPage, 'BottomMargin', TfrxPaperYProperty);
  frxPropertyEditors.Register(TypeInfo(Integer), TfrxReportPage, 'PaperSize', TfrxPaperProperty);

  frxPropertyEditors.RegisterEventEditor(TfrxEventProperty);

  frxPropertyEditors.Register(TypeInfo(Boolean), nil, '', TfrxBooleanProperty);
  frxPropertyEditors.Register(TypeInfo(TfrxFrame), nil, '', TfrxFrameProperty);
  frxPropertyEditors.Register(TypeInfo(TBitmap), nil, '', TfrxPictureProperty);
  frxPropertyEditors.Register(TypeInfo(TBitmap), nil, '', TfrxBitmapProperty);
  frxPropertyEditors.Register(TypeInfo(TfrxDataSet), nil, '', TfrxDataSetProperty);
  frxPropertyEditors.Register(TypeInfo(String), TfrxView, 'DataField', TfrxDataFieldProperty);
  frxPropertyEditors.Register(TypeInfo(TStrings), nil, '', TfrxStringsProperty);
  frxPropertyEditors.Register(TypeInfo(TWideStrings), TfrxCustomMemoView, 'Memo', TfrxMemoProperty);
  frxPropertyEditors.Register(TypeInfo(TBrushKind), nil, '', TfrxBrushProperty);
  frxPropertyEditors.Register(TypeInfo(TfrxFrameStyle), nil, '', TfrxFrameStyleProperty);
  frxPropertyEditors.Register(TypeInfo(String), TfrxMemoView, 'DisplayFormat', TfrxDisplayFormatProperty);
  frxPropertyEditors.Register(TypeInfo(String), TfrxDMPMemoView, 'DisplayFormat', TfrxDisplayFormatProperty);
  frxPropertyEditors.Register(TypeInfo(String), TfrxMemoView, 'Style', TfrxStyleProperty);
  frxPropertyEditors.Register(TypeInfo(Double), TfrxDataBand, 'ColumnWidth', TfrxLocSizeXProperty);
  frxPropertyEditors.Register(TypeInfo(Double), TfrxDataBand, 'ColumnGap', TfrxLocSizeXProperty);
  frxPropertyEditors.Register(TypeInfo(String), TfrxPrintOptions, 'Printer', TfrxPrinterProperty);
  frxPropertyEditors.Register(TypeInfo(Integer), TfrxPrintOptions, 'PrintOnSheet', TfrxPaperProperty);
  frxPropertyEditors.Register(TypeInfo(Double), nil, 'NextCrossGap', TfrxLocSizeXProperty);
  frxPropertyEditors.Register(TypeInfo(Double), nil, 'AddWidth', TfrxLocSizeXProperty);
  frxPropertyEditors.Register(TypeInfo(Double), nil, 'AddHeight', TfrxLocSizeYProperty);

  frxHideProperties(TfrxReport, 'DefaultLanguage;IniFile;Name;Preview;ScriptLanguage;ScriptText;Tag;Variables;DataSetName;DotMatrixReport;OldStyleProgress;ShowProgress;StoreInDFM;ParentReport');
  frxHideProperties(TfrxEngineOptions, 'NewSilentMode;MaxMemSize;PrintIfEmpty;SilentMode;TempDir;UseFileCache');
  frxHideProperties(TfrxPreviewOptions, 'AllowEdit;Buttons;DoubleBuffered;Maximized;MDIChild;Modal;ShowCaptions;Zoom;ZoomMode');
  frxHideProperties(TfrxReportOptions, 'CreateDate;LastChange;Compressed;Password');
  frxHideProperties(TfrxReportPage, 'Bin;BinOtherPages;ColumnWidth;ColumnPositions;DataSetName;HGuides;VGuides');
  frxHideProperties(TfrxDialogPage, 'Font');
  frxHideProperties(TfrxDMPPage, 'BackPicture;Color;Font;Frame');
  frxHideProperties(TfrxReportComponent, 'GroupIndex');
  frxHideProperties(TfrxView, 'DataSetName');
  frxHideProperties(TfrxBand, 'Vertical');
  frxHideProperties(TfrxDataBand, 'DataSetName');
  frxHideProperties(TfrxGroupHeader, 'DrillName');
  frxHideProperties(TFont, 'Height;Pitch');
  frxHideProperties(TfrxHighlight, 'Active');
  frxHideProperties(TfrxPictureView, 'ImageIndex');
  frxHideProperties(TfrxSubreport, 'Page');
  frxHideProperties(TfrxDataPage, 'Left;Tag;Top;Visible');
  frxHideProperties(TfrxCustomMemoView, 'FirstParaBreak;LastParaBreak');


end.
