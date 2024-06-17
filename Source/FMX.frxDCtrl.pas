
{******************************************}
{                                          }
{     FastReport v2.4 - Dialog designer    }
{         Standard Dialog controls         }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxDCtrl;

interface

{$I frx.inc}

uses
  System.SysUtils, System.Classes, System.UiTypes, FMX.Types, FMX.Controls, FMX.ExtCtrls, FMX.Objects,
  FMX.Forms, FMX.Menus, FMX.Dialogs, FMX.frxClass, System.Variants, FMX.Edit, FMX.Memo, FMX.ListBox, FMX.frxFMX
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF DELPHI19}
  , FMX.Graphics, FMX.DateTimeCtrls
{$ENDIF};


type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TfrxDialogControls = class(TComponent) // fake component
  end;
{$IFDEF DELPHI21}
  TCalendarBox = class(TDateEdit);
{$ENDIF}
  TfrxLabelControl = class(TfrxDialogControl)
  private
    FLabel: TLabel;
    function GetAlignment: TTextAlign;
    function GetAutoSize: Boolean;
    function GetWordWrap: Boolean;
    procedure SetAlignment(const Value: TTextAlign);
    procedure SetAutoSize(const Value: Boolean);
    procedure SetWordWrap(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    procedure BeforeStartReport; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    property LabelCtl: TLabel read FLabel;
  published
    property Alignment: TTextAlign read GetAlignment write SetAlignment
      default TTextAlign.taLeading;
    property AutoSize: Boolean read GetAutoSize write SetAutoSize default True;
    property Caption;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default False;

    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TfrxCustomEditControl = class(TfrxDialogControl)
  private
    FOnChange: TfrxNotifyEvent;
    function GetMaxLength: Integer;
    function GetPasswordChar: Char;
    function GetReadOnly: Boolean;
    function GetText: String;
    procedure DoOnChange(Sender: TObject);
    procedure SetMaxLength(const Value: Integer);
    procedure SetPasswordChar(const Value: Char);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetText(const Value: String);
  protected
    FCustomEdit: TControl;
  public
    constructor Create(AOwner: TComponent); override;
    property MaxLength: Integer read GetMaxLength write SetMaxLength;
    property PasswordChar: Char read GetPasswordChar write SetPasswordChar;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property Text: String read GetText write SetText;
    property OnChange: TfrxNotifyEvent read FOnChange write FOnChange;
  end;

  TfrxEditControl = class(TfrxCustomEditControl)
  private
    FEdit: TEdit;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property Edit: TEdit read FEdit;
  published
    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property TabStop;
    property Text;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TfrxMemoControl = class(TfrxDialogControl)
  private
    FMemo: TMemo;
    FOnChange: TfrxNotifyEvent;
    function GetLines: TStrings;
    procedure SetLines(const Value: TStrings);
    function GetShowScrollBars: Boolean;
    function GetWordWrap: Boolean;
    procedure SetShowScrollBars(const Value: Boolean);
    procedure SetWordWrap(const Value: Boolean);
    procedure DoOnChange(Sender: TObject);
    function GetMaxLength: Integer;
    function GetReadOnly: Boolean;
    procedure SetMaxLength(const Value: Integer);
    procedure SetReadOnly(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property Memo: TMemo read FMemo;
  published
    property Lines: TStrings read GetLines write SetLines;
    property MaxLength: Integer read GetMaxLength write SetMaxLength;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowScrollBars: Boolean read GetShowScrollBars write SetShowScrollBars default False;
    property TabStop;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default True;
    property OnChange: TfrxNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TfrxButtonControl = class(TfrxDialogControl)
  private
    FButton: TButton;
    function GetCancel: Boolean;
    function GetDefault: Boolean;
    function GetModalResult: TModalResult;
    procedure SetCancel(const Value: Boolean);
    procedure SetDefault(const Value: Boolean);
    procedure SetModalResult(const Value: TModalResult);
    function GetWordWrap: Boolean;
    procedure SetWordWrap(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property Button: TButton read FButton;
  published
    property Cancel: Boolean read GetCancel write SetCancel default False;
    property Caption;
    property Default: Boolean read GetDefault write SetDefault default False;
    property ModalResult: TModalResult read GetModalResult write SetModalResult default mrNone;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default False;
    property TabStop;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TfrxCheckBoxControl = class(TfrxDialogControl)
  private
    FCheckBox: TCheckBox;
    FOnChange: TfrxNotifyEvent;
    function GetChecked: Boolean;
    procedure SetChecked(const Value: Boolean);
    function GetWordWrap: Boolean;
    procedure SetWordWrap(const Value: Boolean);
    procedure DoOnChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property CheckBox: TCheckBox read FCheckBox;
  published
    property Caption;
    property Checked: Boolean read GetChecked write SetChecked default False;
    property TabStop;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default False;
    property OnChange: TfrxNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TfrxRadioButtonControl = class(TfrxDialogControl)
  private
    FRadioButton: TRadioButton;
    FOnChange: TfrxNotifyEvent;
    function GetChecked: Boolean;
    procedure SetChecked(const Value: Boolean);
    function GetWordWrap: Boolean;
    procedure SetWordWrap(const Value: Boolean);
    procedure DoOnChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property RadioButton: TRadioButton read FRadioButton;
  published
    property Caption;
    property Checked: Boolean read GetChecked write SetChecked default False;
    property TabStop;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default False;
    property OnChange: TfrxNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TfrxListBoxControl = class(TfrxDialogControl)
  private
    FListBox: TListBox;
    function GetItems: TStrings;
    procedure SetItems(const Value: TStrings);
    function GetItemIndex: Integer;
    procedure SetItemIndex(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    property ListBox: TListBox read FListBox;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
  published
    property Items: TStrings read GetItems write SetItems;
    property TabStop;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TfrxComboBoxControl = class(TfrxDialogControl)
  private
    FComboBox: TComboBox;
    FOnChange: TfrxNotifyEvent;
    function GetItemIndex: Integer;
    function GetItems: TStrings;
    //function GetStyle: TComboBoxStyle;
    function GetText: String;
    procedure DoOnChange(Sender: TObject);
    procedure SetItemIndex(const Value: Integer);
    procedure SetItems(const Value: TStrings);
    //procedure SetStyle(const Value: TComboBoxStyle);
    procedure SetText(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property ComboBox: TComboBox read FComboBox;
  published
    //property Color;
    property Items: TStrings read GetItems write SetItems;
    //property Style: TComboBoxStyle read GetStyle write SetStyle default csDropDown;
    property TabStop;
    property Text: String read GetText write SetText;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property OnChange: TfrxNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TfrxPanelControl = class(TfrxDialogControl)
  private
    FPanel: TPanel;
    function GetAlignment: TAlignment;
    //function GetBevelInner: TPanelBevel;
    //function GetBevelOuter: TPanelBevel;
    function GetBevelWidth: Integer;
    procedure SetAlignment(const Value: TAlignment);
    //procedure SetBevelInner(const Value: TPanelBevel);
    //procedure SetBevelOuter(const Value: TPanelBevel);
    procedure SetBevelWidth(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property Panel: TPanel read FPanel;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment default TAlignment.taCenter;
    //property BevelInner: TPanelBevel read GetBevelInner write SetBevelInner default bvNone;
    //property BevelOuter: TPanelBevel read GetBevelOuter write SetBevelOuter default bvRaised;
    property BevelWidth: Integer read GetBevelWidth write SetBevelWidth default 1;
    property Caption;
    //property Color;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TfrxGroupBoxControl = class(TfrxDialogControl)
  private
    FGroupBox: TGroupBox;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property GroupBox: TGroupBox read FGroupBox;
  published
    property Caption;
    //property Color;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TfrxDateEditControl = class(TfrxDialogControl)
  private
    FDateEdit: TCalendarBox;
    FOnChange: TfrxNotifyEvent;
    FWeekNumbers: Boolean;
    function GetDate: TDate;
    function GetTime: TTime;
    //function GetDateFormat: TDTDateFormat;
    //function GetKind: TDateTimeKind;
    procedure SetDate(const Value: TDate);
    procedure SetTime(const Value: TTime);
    //procedure SetDateFormat(const Value: TDTDateFormat);
    //procedure SetKind(const Value: TDateTimeKind);
  protected
    // remove
    procedure DoOnChange(Sender: TObject);
    procedure DropDown(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property DateEdit: TCalendarBox read FDateEdit;
  published
    //property Color;
    property Date: TDate read GetDate write SetDate;
    //property DateFormat: TDTDateFormat read GetDateFormat write SetDateFormat
    //  default dfShort;
    //property Kind: TDateTimeKind read GetKind write SetKind default dtkDate;
    property TabStop;
    property Time: TTime read GetTime write SetTime;
    property WeekNumbers: Boolean read FWeekNumbers write FWeekNumbers;
    property OnChange: TfrxNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TfrxImageControl = class(TfrxDialogControl)
  private
    FImage: TImage;
    function GetAutoSize: Boolean;
    function GetCenter: Boolean;
    function GetPicture: TBitmap;
    function GetStretch: Boolean;
    procedure SetAutoSize(const Value: Boolean);
    procedure SetCenter(const Value: Boolean);
    procedure SetPicture(const Value: TBitmap);
    procedure SetStretch(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property Image: TImage read FImage;
  published
    property AutoSize: Boolean read GetAutoSize write SetAutoSize default False;
    property Center: Boolean read GetCenter write SetCenter default False;
    property Picture: TBitmap read GetPicture write SetPicture;
    property Stretch: Boolean read GetStretch write SetStretch default False;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TfrxBevelControl = class(TfrxDialogControl)
  private
    FBevel: TPanel;
    //function GetBevelShape: TBevelShape;
    //function GetBevelStyle: TBevelStyle;
    //procedure SetBevelShape(const Value: TBevelShape);
    //procedure SetBevelStyle(const Value: TBevelStyle);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property Bevel: TPanel read FBevel;
  published
    //property Shape: TBevelShape read GetBevelShape write SetBevelShape default bsBox;
    //property Style: TBevelStyle read GetBevelStyle write SetBevelStyle default bsLowered;
  end;

  TfrxBitBtnControl = class(TfrxDialogControl)
  private
    FBitBtn: TfrxToolButton;
    function GetGlyph: TBitmap;
    //function GetKind: TBitBtnKind;
    //function GetLayout: TButtonLayout;
    function GetMargin: Integer;
    function GetModalResult: TModalResult;
    function GetSpacing: Integer;
    procedure SetGlyph(const Value: TBitmap);
    //procedure SetKind(const Value: TBitBtnKind);
    //procedure SetLayout(const Value: TButtonLayout);
    procedure SetMargin(const Value: Integer);
    procedure SetModalResult(const Value: TModalResult);
    procedure SetSpacing(const Value: Integer);
    function GetNumGlyphs: Integer;
    procedure SetNumGlyphs(const Value: Integer);
    function GetWordWrap: Boolean;
    procedure SetWordWrap(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property BitBtn: TfrxToolButton read FBitBtn;
  published
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    //property Kind: TBitBtnKind read GetKind write SetKind default bkCustom;
    property Caption; // should be after Kind prop
    //property Layout: TButtonLayout read GetLayout write SetLayout default blGlyphLeft;
    property Margin: Integer read GetMargin write SetMargin default -1;
    property ModalResult: TModalResult read GetModalResult write SetModalResult default mrNone;
    property NumGlyphs: Integer read GetNumGlyphs write SetNumGlyphs default 1;
    property Spacing: Integer read GetSpacing write SetSpacing default 4;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default False;
    property TabStop;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;
{
  TfrxSpeedButtonControl = class(TfrxDialogControl)
  private
    FSpeedButton: TSpeedButton;
    function GetAllowAllUp: Boolean;
    function GetDown: Boolean;
    function GetFlat: Boolean;
    function GetGlyph: TBitmap;
    function GetGroupIndex: Integer;
    //function GetLayout: TButtonLayout;
    function GetMargin: Integer;
    function GetSpacing: Integer;
    procedure SetAllowAllUp(const Value: Boolean);
    procedure SetDown(const Value: Boolean);
    procedure SetFlat(const Value: Boolean);
    procedure SetGlyph(const Value: TBitmap);
    procedure SetGroupIndex(const Value: Integer);
    //procedure SetLayout(const Value: TButtonLayout);
    procedure SetMargin(const Value: Integer);
    procedure SetSpacing(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property SpeedButton: TSpeedButton read FSpeedButton;
  published
    property AllowAllUp: Boolean read GetAllowAllUp write SetAllowAllUp default False;
    property Caption;
    property Down: Boolean read GetDown write SetDown default False;
    property Flat: Boolean read GetFlat write SetFlat default False;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property GroupIndex: Integer read GetGroupIndex write SetGroupIndex;
    //property Layout: TButtonLayout read GetLayout write SetLayout default blGlyphLeft;
    property Margin: Integer read GetMargin write SetMargin default -1;
    property Spacing: Integer read GetSpacing write SetSpacing default 4;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;
}
  {TfrxMaskEditControl = class(TfrxCustomEditControl)
  private
    FMaskEdit: TMaskEdit;
    function GetEditMask: String;
    procedure SetEditMask(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property MaskEdit: TMaskEdit read FMaskEdit;
  published
    property Color;
    property EditMask: String read GetEditMask write SetEditMask;
    property MaxLength;
    property ReadOnly;
    property TabStop;
    property Text;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;  }

  {TfrxCheckListBoxControl = class(TfrxDialogControl)
  private
    FCheckListBox: TCheckListBox;
    function GetAllowGrayed: Boolean;
    function GetItems: TStrings;
    function GetSorted: Boolean;
    function GetChecked(Index: Integer): Boolean;
    function GetState(Index: Integer): TCheckBoxState;
    procedure SetAllowGrayed(const Value: Boolean);
    procedure SetItems(const Value: TStrings);
    procedure SetSorted(const Value: Boolean);
    procedure SetChecked(Index: Integer; const Value: Boolean);
    procedure SetState(Index: Integer; const Value: TCheckBoxState);
    function GetItemIndex: Integer;
    procedure SetItemIndex(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property CheckListBox: TCheckListBox read FCheckListBox;
    property Checked[Index: Integer]: Boolean read GetChecked write SetChecked;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property State[Index: Integer]: TCheckBoxState read GetState write SetState;
  published
    property AllowGrayed: Boolean read GetAllowGrayed write SetAllowGrayed default False;
    property Color;
    property Items: TStrings read GetItems write SetItems;
    property Sorted: Boolean read GetSorted write SetSorted default False;
    property TabStop;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;    }



implementation

uses FMX.frxDCtrlRTTI, FMX.frxUtils, FMX.frxDsgnIntf, FMX.frxRes;

type
  THackCustomEdit = class(TCustomEdit);


{ TfrxLabelControl }

constructor TfrxLabelControl.Create(AOwner: TComponent);
begin
  inherited;
  FLabel := TLabel.Create(nil);
  InitControl(FLabel);
end;

class function TfrxLabelControl.GetDescription: String;
begin
  Result := frxResources.Get('obLabel');
end;

procedure TfrxLabelControl.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  if FLabel.AutoSize then
  begin
    Width := FLabel.Width;
    Height := FLabel.Height;
  end
  else
  begin
    FLabel.Width := Round(Width);
    FLabel.Height := Round(Height);
  end;
  inherited;
end;

function TfrxLabelControl.GetAlignment: TTextAlign;
begin
  Result := FLabel.TextAlign;
end;

function TfrxLabelControl.GetAutoSize: Boolean;
begin
  Result := FLabel.AutoSize;
end;

function TfrxLabelControl.GetWordWrap: Boolean;
begin
  Result := FLabel.WordWrap;
end;

procedure TfrxLabelControl.SetAlignment(const Value: TTextAlign);
begin
  FLabel.TextAlign := Value;
end;

procedure TfrxLabelControl.SetAutoSize(const Value: Boolean);
begin
  FLabel.AutoSize := Value;
end;

procedure TfrxLabelControl.SetWordWrap(const Value: Boolean);
begin
  FLabel.WordWrap := Value;
end;

procedure TfrxLabelControl.BeforeStartReport;
begin
  if not FLabel.AutoSize then
  begin
    FLabel.Width := Round(Width);
    FLabel.Height := Round(Height);
  end;
end;


{ TfrxCustomEditControl }

constructor TfrxCustomEditControl.Create(AOwner: TComponent);
begin
  inherited;
  THackCustomEdit(FCustomEdit).OnChange := DoOnChange;
  InitControl(FCustomEdit);
end;

function TfrxCustomEditControl.GetMaxLength: Integer;
begin
  Result := THackCustomEdit(FCustomEdit).MaxLength;
end;

function TfrxCustomEditControl.GetPasswordChar: Char;
begin
  Result := '-';// THackCustomEdit(FCustomEdit).PasswordChar;
end;

function TfrxCustomEditControl.GetReadOnly: Boolean;
begin
  Result := THackCustomEdit(FCustomEdit).ReadOnly;
end;

function TfrxCustomEditControl.GetText: String;
begin
  Result := THackCustomEdit(FCustomEdit).Text;
end;

procedure TfrxCustomEditControl.SetMaxLength(const Value: Integer);
begin
  THackCustomEdit(FCustomEdit).MaxLength := Value;
end;

procedure TfrxCustomEditControl.SetPasswordChar(const Value: Char);
begin
  //THackCustomEdit(FCustomEdit).PasswordChar := Value;
end;

procedure TfrxCustomEditControl.SetReadOnly(const Value: Boolean);
begin
  THackCustomEdit(FCustomEdit).ReadOnly := Value;
end;

procedure TfrxCustomEditControl.SetText(const Value: String);
begin
  THackCustomEdit(FCustomEdit).Text := Value;
end;

procedure TfrxCustomEditControl.DoOnChange(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnChange, True);
end;


{ TfrxEditControl }

constructor TfrxEditControl.Create(AOwner: TComponent);
begin
  FEdit := TEdit.Create(nil);
  FCustomEdit := FEdit;
  inherited;

  Width := 121;
  Height := 21;
end;

class function TfrxEditControl.GetDescription: String;
begin
  Result := frxResources.Get('obEdit');
end;


{ TfrxMemoControl }

constructor TfrxMemoControl.Create(AOwner: TComponent);
begin
  FMemo := TMemo.Create(nil);
  //FCustomEdit := FMemo;
  inherited;
  InitControl(FMemo);
  Width := 185;
  Height := 89;
  FMemo.OnChange := DoOnChange;
end;

procedure TfrxMemoControl.DoOnChange(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnChange, True);
end;

class function TfrxMemoControl.GetDescription: String;
begin
  Result := frxResources.Get('obMemoC');
end;

function TfrxMemoControl.GetLines: TStrings;
begin
  Result := FMemo.Lines;
end;

function TfrxMemoControl.GetMaxLength: Integer;
begin
  Result := FMemo.MaxLength;
end;

function TfrxMemoControl.GetReadOnly: Boolean;
begin
  Result := FMemo.ReadOnly;
end;

function TfrxMemoControl.GetShowScrollBars: Boolean;
begin
  Result := FMemo.ShowScrollBars;
end;

function TfrxMemoControl.GetWordWrap: Boolean;
begin
  Result := FMemo.WordWrap;
end;

procedure TfrxMemoControl.SetLines(const Value: TStrings);
begin
  FMemo.Lines := Value;
end;

procedure TfrxMemoControl.SetMaxLength(const Value: Integer);
begin
  FMemo.MaxLength := Value;
end;

procedure TfrxMemoControl.SetReadOnly(const Value: Boolean);
begin
  FMemo.ReadOnly := Value;
end;

procedure TfrxMemoControl.SetShowScrollBars(const Value: boolean);
begin
  FMemo.ShowScrollBars := Value;
end;

procedure TfrxMemoControl.SetWordWrap(const Value: Boolean);
begin
  FMemo.WordWrap := Value;
end;


{ TfrxButtonControl }

constructor TfrxButtonControl.Create(AOwner: TComponent);
begin
  inherited;
  FButton := TButton.Create(nil);
  InitControl(FButton);

  Width := 75;
  Height := 25;
end;

class function TfrxButtonControl.GetDescription: String;
begin
  Result := frxResources.Get('obButton');
end;

function TfrxButtonControl.GetCancel: Boolean;
begin
  Result := FButton.Cancel;
end;

function TfrxButtonControl.GetDefault: Boolean;
begin
  Result := FButton.Default;
end;

function TfrxButtonControl.GetModalResult: TModalResult;
begin
  Result := FButton.ModalResult;
end;

procedure TfrxButtonControl.SetCancel(const Value: Boolean);
begin
  FButton.Cancel := Value;
end;

procedure TfrxButtonControl.SetDefault(const Value: Boolean);
begin
  FButton.Default := Value;
end;

procedure TfrxButtonControl.SetModalResult(const Value: TModalResult);
begin
  FButton.ModalResult := Value;
end;

function TfrxButtonControl.GetWordWrap: Boolean;
begin
  Result := FButton.WordWrap;
end;

procedure TfrxButtonControl.SetWordWrap(const Value: Boolean);
begin
  FButton.WordWrap := Value;
end;

{ TfrxCheckBoxControl }

constructor TfrxCheckBoxControl.Create(AOwner: TComponent);
begin
  inherited;
  FCheckBox := TCheckBox.Create(nil);
  FCheckBox.OnChange := DoOnChange;
  InitControl(FCheckBox);

  Width := 97;
  Height := 17;
end;

class function TfrxCheckBoxControl.GetDescription: String;
begin
  Result := frxResources.Get('obChBoxC');
end;

function TfrxCheckBoxControl.GetChecked: Boolean;
begin
  Result := FCheckBox.IsChecked;
end;

procedure TfrxCheckBoxControl.SetChecked(const Value: Boolean);
begin
  FCheckBox.IsChecked := Value;
end;

function TfrxCheckBoxControl.GetWordWrap: Boolean;
begin
  Result := FCheckBox.WordWrap;
end;

procedure TfrxCheckBoxControl.SetWordWrap(const Value: Boolean);
begin
  FCheckBox.WordWrap := Value;
end;

procedure TfrxCheckBoxControl.DoOnChange(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnChange, True);
end;

{ TfrxRadioButtonControl }

constructor TfrxRadioButtonControl.Create(AOwner: TComponent);
begin
  inherited;
  FRadioButton := TRadioButton.Create(nil);
  FRadioButton.OnChange := DoOnChange;
  InitControl(FRadioButton);

  Width := 113;
  Height := 17;
end;

class function TfrxRadioButtonControl.GetDescription: String;
begin
  Result := frxResources.Get('obRButton');
end;

function TfrxRadioButtonControl.GetChecked: Boolean;
begin
  Result := FRadioButton.IsChecked;
end;

procedure TfrxRadioButtonControl.SetChecked(const Value: Boolean);
begin
  FRadioButton.IsChecked := Value;
end;

function TfrxRadioButtonControl.GetWordWrap: Boolean;
begin
  Result := FRadioButton.WordWrap;
end;

procedure TfrxRadioButtonControl.SetWordWrap(const Value: Boolean);
begin
  FRadioButton.WordWrap := Value;
end;

procedure TfrxRadioButtonControl.DoOnChange(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnChange, True);
end;


{ TfrxListBoxControl }

constructor TfrxListBoxControl.Create(AOwner: TComponent);
begin
  inherited;
  FListBox := TListBox.Create(AOwner);
  InitControl(FListBox);
  Width := 121;
  Height := 97;
end;

destructor TfrxListBoxControl.Destroy;
begin
  inherited;
end;

class function TfrxListBoxControl.GetDescription: String;
begin
  Result := frxResources.Get('obLBox');
end;

function TfrxListBoxControl.GetItems: TStrings;
begin
  Result := FListBox.Items;
end;

function TfrxListBoxControl.GetItemIndex: Integer;
begin
  Result := FListBox.ItemIndex;
end;

procedure TfrxListBoxControl.SetItems(const Value: TStrings);
begin
  FListBox.Items := Value;
end;

procedure TfrxListBoxControl.SetItemIndex(const Value: Integer);
begin
  FListBox.ItemIndex := Value;
end;


{ TfrxComboBoxControl }

constructor TfrxComboBoxControl.Create(AOwner: TComponent);
begin
  inherited;
  FComboBox := TComboBox.Create(nil);
  FComboBox.OnChange := DoOnChange;
  InitControl(FComboBox);

  Width := 145;
  Height := 21;
end;

class function TfrxComboBoxControl.GetDescription: String;
begin
  Result := frxResources.Get('obCBox');
end;

function TfrxComboBoxControl.GetItems: TStrings;
begin
  Result := FComboBox.Items;
end;

function TfrxComboBoxControl.GetItemIndex: Integer;
begin
  Result := FComboBox.ItemIndex;
end;

{function TfrxComboBoxControl.GetStyle: TComboBoxStyle;
begin
  Result := FComboBox.Style;
end;          }

function TfrxComboBoxControl.GetText: String;
begin
  Result := FComboBox.Items.Text;
end;

procedure TfrxComboBoxControl.SetItems(const Value: TStrings);
begin
  FComboBox.Items := Value;
end;

procedure TfrxComboBoxControl.SetItemIndex(const Value: Integer);
begin
  FComboBox.ItemIndex := Value;
end;

{procedure TfrxComboBoxControl.SetStyle(const Value: TComboBoxStyle);
begin
  FComboBox.Style := Value;
end;  }

procedure TfrxComboBoxControl.SetText(const Value: String);
begin
  FComboBox.Items.Text := Value;
end;

procedure TfrxComboBoxControl.DoOnChange(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnChange, True);
end;


{ TfrxDateEditControl }

constructor TfrxDateEditControl.Create(AOwner: TComponent);
begin
  inherited;
  FDateEdit := TCalendarBox.Create(nil);
  //FDateEdit.OnChange := DoOnChange;
  //FDateEdit.OnDropDown := DropDown;
  InitControl(FDateEdit);

  Width := 145;
  Height := 21;
end;

class function TfrxDateEditControl.GetDescription: String;
begin
  Result := frxResources.Get('obDateEdit');
end;

function TfrxDateEditControl.GetDate: TDate;
begin
  Result := FDateEdit.Date;
end;

function TfrxDateEditControl.GetTime: TTime;
begin
  Result := Now;
end;

{function TfrxDateEditControl.GetDateFormat: TDTDateFormat;
begin
  Result := FDateEdit.DateFormat;
end;

function TfrxDateEditControl.GetKind: TDateTimeKind;
begin
  Result := FDateEdit.Kind;
end; }

procedure TfrxDateEditControl.SetDate(const Value: TDate);
begin
  FDateEdit.Date := Value;
end;

procedure TfrxDateEditControl.SetTime(const Value: TTime);
begin
  //FDateEdit.Time := Value;
end;
{
procedure TfrxDateEditControl.SetDateFormat(const Value: TDTDateFormat);
begin
  FDateEdit.DateFormat := Value;
end;

procedure TfrxDateEditControl.SetKind(const Value: TDateTimeKind);
begin
  FDateEdit.Kind := Value;
end;    }

procedure TfrxDateEditControl.DoOnChange(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnChange, True);
end;


procedure TfrxDateEditControl.DropDown(Sender: TObject);
begin
//
end;

{ TfrxImageControl }

constructor TfrxImageControl.Create(AOwner: TComponent);
begin
  inherited;
  FImage := TImage.Create(nil);
  InitControl(FImage);

  Width := 100;
  Height := 100;
end;

class function TfrxImageControl.GetDescription: String;
begin
  Result := frxResources.Get('obImageC');
end;

function TfrxImageControl.GetAutoSize: Boolean;
begin
  Result := False;
end;

function TfrxImageControl.GetCenter: Boolean;
begin
  Result := False;
end;

function TfrxImageControl.GetPicture: TBitmap;
begin
  Result := FImage.Bitmap;
end;

function TfrxImageControl.GetStretch: Boolean;
begin
  Result := False;
end;

procedure TfrxImageControl.SetAutoSize(const Value: Boolean);
begin
  //FImage.AutoSize := Value;
end;

procedure TfrxImageControl.SetCenter(const Value: Boolean);
begin
  //FImage.Center := Value;
end;

procedure TfrxImageControl.SetPicture(const Value: TBitmap);
begin
  FImage.Bitmap.Assign(Value);
end;

procedure TfrxImageControl.SetStretch(const Value: Boolean);
begin
  //FImage.Stretch := Value;
end;


{ TfrxBevelControl }

constructor TfrxBevelControl.Create(AOwner: TComponent);
begin
  inherited;
  FBevel := TPanel.Create(nil);
  InitControl(FBevel);

  Width := 50;
  Height := 50;
end;

class function TfrxBevelControl.GetDescription: String;
begin
  Result := frxResources.Get('obBevel');
end;

{function TfrxBevelControl.GetBevelShape: TBevelShape;
begin
  Result := FBevel.Shape;
end;

function TfrxBevelControl.GetBevelStyle: TBevelStyle;
begin
  Result := FBevel.Style;
end;

procedure TfrxBevelControl.SetBevelShape(const Value: TBevelShape);
begin
  FBevel.Shape := Value;
end;

procedure TfrxBevelControl.SetBevelStyle(const Value: TBevelStyle);
begin
  FBevel.Style := Value;
end; }


{ TfrxPanelControl }

constructor TfrxPanelControl.Create(AOwner: TComponent);
begin
  inherited;
  FPanel := TPanel.Create(nil);
  InitControl(FPanel);
  Width := 185;
  Height := 41;
end;

class function TfrxPanelControl.GetDescription: String;
begin
  Result := frxResources.Get('obPanel');
end;

function TfrxPanelControl.GetAlignment: TAlignment;
begin
  Result := TAlignment.taRightJustify;
end;


function TfrxPanelControl.GetBevelWidth: Integer;
begin
  Result := 0;
end;

procedure TfrxPanelControl.SetAlignment(const Value: TAlignment);
begin
  //FPanel.Alignment := Value;
end;



procedure TfrxPanelControl.SetBevelWidth(const Value: Integer);
begin
  //FPanel.BevelWidth := Value;
end;


{ TfrxGroupBoxControl }

constructor TfrxGroupBoxControl.Create(AOwner: TComponent);
begin
  inherited;
  FGroupBox := TGroupBox.Create(nil);
  InitControl(FGroupBox);

  Width := 185;
  Height := 105;
end;

class function TfrxGroupBoxControl.GetDescription: String;
begin
  Result := frxResources.Get('obGrBox');
end;


{ TfrxBitBtnControl }

constructor TfrxBitBtnControl.Create(AOwner: TComponent);
begin
  inherited;
  FBitBtn := TfrxToolButton.Create(nil);
  InitControl(FBitBtn);

  Width := 75;
  Height := 25;
end;

class function TfrxBitBtnControl.GetDescription: String;
begin
  Result := frxResources.Get('obBBtn');
end;

function TfrxBitBtnControl.GetGlyph: TBitmap;
begin
  Result := FBitBtn.Bitmap;
end;

{function TfrxBitBtnControl.GetKind: TBitBtnKind;
begin
  Result := FBitBtn.Kind;
end;

function TfrxBitBtnControl.GetLayout: TButtonLayout;
begin
  Result := FBitBtn.Layout;
end;  }

function TfrxBitBtnControl.GetMargin: Integer;
begin
  Result := 0;
end;

function TfrxBitBtnControl.GetModalResult: TModalResult;
begin
  Result := FBitBtn.ModalResult;
end;

function TfrxBitBtnControl.GetNumGlyphs: Integer;
begin
  Result := 0;
end;

function TfrxBitBtnControl.GetSpacing: Integer;
begin
  Result := 0;
end;

function TfrxBitBtnControl.GetWordWrap: Boolean;
begin
  Result := FBitBtn.WordWrap;
end;

procedure TfrxBitBtnControl.SetGlyph(const Value: TBitmap);
begin
  //FBitBtn.Glyph := Value;
end;

{procedure TfrxBitBtnControl.SetKind(const Value: TBitBtnKind);
begin
  FBitBtn.Kind := Value;
end;

procedure TfrxBitBtnControl.SetLayout(const Value: TButtonLayout);
begin
  FBitBtn.Layout := Value;
end;   }

procedure TfrxBitBtnControl.SetMargin(const Value: Integer);
begin
  //FBitBtn.Margin := Value;
end;

procedure TfrxBitBtnControl.SetModalResult(const Value: TModalResult);
begin
  FBitBtn.ModalResult := Value;
end;

procedure TfrxBitBtnControl.SetNumGlyphs(const Value: Integer);
begin
  //FBitBtn.NumGlyphs := Value;
end;

procedure TfrxBitBtnControl.SetSpacing(const Value: Integer);
begin
  //FBitBtn.Spacing := Value;
end;

procedure TfrxBitBtnControl.SetWordWrap(const Value: Boolean);
begin
  FBitBtn.WordWrap := Value;
end;

{ TfrxSpeedButtonControl }
{
constructor TfrxSpeedButtonControl.Create(AOwner: TComponent);
begin
  inherited;
  FSpeedButton := TSpeedButton.Create(nil);
  InitControl(FSpeedButton);

  Width := 22;
  Height := 22;
end;

class function TfrxSpeedButtonControl.GetDescription: String;
begin
  Result := frxResources.Get('obSBtn');
end;

function TfrxSpeedButtonControl.GetAllowAllUp: Boolean;
begin
  //Result := FSpeedButton.AllowAllUp;
end;

function TfrxSpeedButtonControl.GetDown: Boolean;
begin
 // Result := FSpeedButton.Down;
end;

function TfrxSpeedButtonControl.GetFlat: Boolean;
begin
  //Result := FSpeedButton.Flat;
end;

function TfrxSpeedButtonControl.GetGlyph: TBitmap;
begin
 // Result := FSpeedButton.Glyph;
end;

function TfrxSpeedButtonControl.GetGroupIndex: Integer;
begin
  //Result := FSpeedButton.GroupIndex;
end;

//function TfrxSpeedButtonControl.GetLayout: TButtonLayout;
//begin
//  //Result := FSpeedButton.Layout;
//end;

function TfrxSpeedButtonControl.GetMargin: Integer;
begin
  //Result := FSpeedButton.Margin;
end;

function TfrxSpeedButtonControl.GetSpacing: Integer;
begin
  //Result := FSpeedButton.Spacing;
end;

procedure TfrxSpeedButtonControl.SetAllowAllUp(const Value: Boolean);
begin
 // FSpeedButton.AllowAllUp := Value;
end;

procedure TfrxSpeedButtonControl.SetDown(const Value: Boolean);
begin
  //FSpeedButton.Down := Value;
end;

procedure TfrxSpeedButtonControl.SetFlat(const Value: Boolean);
begin
  //FSpeedButton.Flat := Value;
end;

procedure TfrxSpeedButtonControl.SetGlyph(const Value: TBitmap);
begin
  //FSpeedButton.Glyph := Value;
end;

procedure TfrxSpeedButtonControl.SetGroupIndex(const Value: Integer);
begin
  //FSpeedButton.GroupIndex := Value;
end;

//procedure TfrxSpeedButtonControl.SetLayout(const Value: TButtonLayout);
//begin
//  FSpeedButton.Layout := Value;
//end;

procedure TfrxSpeedButtonControl.SetMargin(const Value: Integer);
begin
  //FSpeedButton.Margin := Value;
end;

procedure TfrxSpeedButtonControl.SetSpacing(const Value: Integer);
begin
  //FSpeedButton.Spacing := Value;
end;
}

{ TfrxMaskEditControl }
 {
constructor TfrxMaskEditControl.Create(AOwner: TComponent);
begin
  FMaskEdit := TMaskEdit.Create(nil);
  FCustomEdit := FMaskEdit;
  inherited;

  Width := 121;
  Height := 21;
end;

class function TfrxMaskEditControl.GetDescription: String;
begin
  Result := frxResources.Get('obMEdit');
end;

function TfrxMaskEditControl.GetEditMask: String;
begin
  Result := FMaskEdit.EditMask;
end;

procedure TfrxMaskEditControl.SetEditMask(const Value: String);
begin
  FMaskEdit.EditMask := Value;
end;

 }
{ TfrxCheckListBoxControl }
 {
constructor TfrxCheckListBoxControl.Create(AOwner: TComponent);
begin
  inherited;
  FCheckListBox := TCheckListBox.Create(nil);
  InitControl(FCheckListBox);

  Width := 121;
  Height := 97;
end;

class function TfrxCheckListBoxControl.GetDescription: String;
begin
  Result := frxResources.Get('obChLB');
end;

function TfrxCheckListBoxControl.GetAllowGrayed: Boolean;
begin
  Result := FCheckListBox.AllowGrayed;
end;

function TfrxCheckListBoxControl.GetItems: TStrings;
begin
  Result := FCheckListBox.Items;
end;

function TfrxCheckListBoxControl.GetSorted: Boolean;
begin
  Result := FCheckListBox.Sorted;
end;

function TfrxCheckListBoxControl.GetChecked(Index: Integer): Boolean;
begin
  Result := FCheckListBox.Checked[Index];
end;

function TfrxCheckListBoxControl.GetState(Index: Integer): TCheckBoxState;
begin
  Result := FCheckListBox.State[Index];
end;

procedure TfrxCheckListBoxControl.SetAllowGrayed(const Value: Boolean);
begin
  FCheckListBox.AllowGrayed := Value;
end;

procedure TfrxCheckListBoxControl.SetItems(const Value: TStrings);
begin
  FCheckListBox.Items := Value;
end;

procedure TfrxCheckListBoxControl.SetSorted(const Value: Boolean);
begin
  FCheckListBox.Sorted := Value;
end;

procedure TfrxCheckListBoxControl.SetChecked(Index: Integer; const Value: Boolean);
begin
  FCheckListBox.Checked[Index] := Value;
end;

procedure TfrxCheckListBoxControl.SetState(Index: Integer; const Value: TCheckBoxState);
begin
  FCheckListBox.State[Index] := Value;
end;

function TfrxCheckListBoxControl.GetItemIndex: Integer;
begin
  Result := FCheckListBox.ItemIndex;
end;

procedure TfrxCheckListBoxControl.SetItemIndex(const Value: Integer);
begin
  FCheckListBox.ItemIndex := Value;
end;
 }

initialization
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TfrxDialogControls, TFmxObject);
  frxObjects.RegisterObject1(TfrxLabelControl, nil, '', '', 0, 112);
  frxObjects.RegisterObject1(TfrxEditControl, nil, '', '', 0, 113);
  frxObjects.RegisterObject1(TfrxMemoControl, nil, '', '', 0, 114);
  frxObjects.RegisterObject1(TfrxButtonControl, nil, '', '', 0, 115);
  frxObjects.RegisterObject1(TfrxCheckBoxControl, nil, '', '', 0, 116);
  frxObjects.RegisterObject1(TfrxRadioButtonControl, nil, '', '', 0, 117);
  frxObjects.RegisterObject1(TfrxListBoxControl, nil, '', '', 0, 118);
  frxObjects.RegisterObject1(TfrxComboBoxControl, nil, '', '', 0, 119);
  frxObjects.RegisterObject1(TfrxPanelControl, nil, '', '', 0, 144);
  frxObjects.RegisterObject1(TfrxGroupBoxControl, nil, '', '', 0, 143);

  frxObjects.RegisterObject1(TfrxDateEditControl, nil, '', '', 0, 145);
  frxObjects.RegisterObject1(TfrxImageControl, nil, '', '', 0, 103);
  //frxObjects.RegisterObject1(TfrxBevelControl, nil, '', '', 0, 33);
  //frxObjects.RegisterObject1(TfrxBitBtnControl, nil, '', '', 0, 115);
  //frxObjects.RegisterObject1(TfrxSpeedButtonControl, nil, '', '', 0, 115);
{  frxObjects.RegisterObject1(TfrxMaskEditControl, nil, '', '', 0, 47);
  frxObjects.RegisterObject1(TfrxCheckListBoxControl, nil, '', '', 0, 48); }



end.
