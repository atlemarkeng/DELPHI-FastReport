// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxDCtrl.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxdctrlHPP
#define Fmx_FrxdctrlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Menus.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.frxClass.hpp>
#include <System.Variants.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Memo.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.DateTimeCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxdctrl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxDialogControls;
class DELPHICLASS TCalendarBox;
class DELPHICLASS TfrxLabelControl;
class DELPHICLASS TfrxCustomEditControl;
class DELPHICLASS TfrxEditControl;
class DELPHICLASS TfrxMemoControl;
class DELPHICLASS TfrxButtonControl;
class DELPHICLASS TfrxCheckBoxControl;
class DELPHICLASS TfrxRadioButtonControl;
class DELPHICLASS TfrxListBoxControl;
class DELPHICLASS TfrxComboBoxControl;
class DELPHICLASS TfrxPanelControl;
class DELPHICLASS TfrxGroupBoxControl;
class DELPHICLASS TfrxDateEditControl;
class DELPHICLASS TfrxImageControl;
class DELPHICLASS TfrxBevelControl;
class DELPHICLASS TfrxBitBtnControl;
class DELPHICLASS TfrxSpeedButtonControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxDialogControls : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfrxDialogControls(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxDialogControls(void) { }
	
};


class PASCALIMPLEMENTATION TCalendarBox : public Fmx::Datetimectrls::TDateEdit
{
	typedef Fmx::Datetimectrls::TDateEdit inherited;
	
public:
	/* TCustomDateEdit.Create */ inline __fastcall virtual TCalendarBox(System::Classes::TComponent* AOwner)/* overload */ : Fmx::Datetimectrls::TDateEdit(AOwner) { }
	
public:
	/* TCustomDateTimeEdit.Destroy */ inline __fastcall virtual ~TCalendarBox(void) { }
	
};


class PASCALIMPLEMENTATION TfrxLabelControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Stdctrls::TLabel* FLabel;
	Fmx::Types::TTextAlign __fastcall GetAlignment(void);
	bool __fastcall GetAutoSize(void);
	bool __fastcall GetWordWrap(void);
	void __fastcall SetAlignment(const Fmx::Types::TTextAlign Value);
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetWordWrap(const bool Value);
	
public:
	__fastcall virtual TfrxLabelControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall BeforeStartReport(void);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	__property Fmx::Stdctrls::TLabel* LabelCtl = {read=FLabel};
	
__published:
	__property Fmx::Types::TTextAlign Alignment = {read=GetAlignment, write=SetAlignment, default=1};
	__property bool AutoSize = {read=GetAutoSize, write=SetAutoSize, default=1};
	__property Caption = {default=0};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=0};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxLabelControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxLabelControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxCustomEditControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Frxclass::TfrxNotifyEvent FOnChange;
	int __fastcall GetMaxLength(void);
	System::WideChar __fastcall GetPasswordChar(void);
	bool __fastcall GetReadOnly(void);
	System::UnicodeString __fastcall GetText(void);
	void __fastcall DoOnChange(System::TObject* Sender);
	void __fastcall SetMaxLength(const int Value);
	void __fastcall SetPasswordChar(const System::WideChar Value);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetText(const System::UnicodeString Value);
	
protected:
	Fmx::Controls::TControl* FCustomEdit;
	
public:
	__fastcall virtual TfrxCustomEditControl(System::Classes::TComponent* AOwner);
	__property int MaxLength = {read=GetMaxLength, write=SetMaxLength, nodefault};
	__property System::WideChar PasswordChar = {read=GetPasswordChar, write=SetPasswordChar, nodefault};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property System::UnicodeString Text = {read=GetText, write=SetText};
	__property Fmx::Frxclass::TfrxNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxCustomEditControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCustomEditControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxEditControl : public TfrxCustomEditControl
{
	typedef TfrxCustomEditControl inherited;
	
private:
	Fmx::Edit::TEdit* FEdit;
	
public:
	__fastcall virtual TfrxEditControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Fmx::Edit::TEdit* Edit = {read=FEdit};
	
__published:
	__property MaxLength;
	__property PasswordChar;
	__property ReadOnly = {default=0};
	__property TabStop = {default=1};
	__property Text = {default=0};
	__property OnChange = {default=0};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxEditControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxEditControl(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxCustomEditControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxMemoControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Memo::TMemo* FMemo;
	Fmx::Frxclass::TfrxNotifyEvent FOnChange;
	System::Classes::TStrings* __fastcall GetLines(void);
	void __fastcall SetLines(System::Classes::TStrings* const Value);
	bool __fastcall GetShowScrollBars(void);
	bool __fastcall GetWordWrap(void);
	void __fastcall SetShowScrollBars(const bool Value);
	void __fastcall SetWordWrap(const bool Value);
	void __fastcall DoOnChange(System::TObject* Sender);
	int __fastcall GetMaxLength(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetMaxLength(const int Value);
	void __fastcall SetReadOnly(const bool Value);
	
public:
	__fastcall virtual TfrxMemoControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Fmx::Memo::TMemo* Memo = {read=FMemo};
	
__published:
	__property System::Classes::TStrings* Lines = {read=GetLines, write=SetLines};
	__property int MaxLength = {read=GetMaxLength, write=SetMaxLength, nodefault};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property bool ShowScrollBars = {read=GetShowScrollBars, write=SetShowScrollBars, default=0};
	__property TabStop = {default=1};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=1};
	__property Fmx::Frxclass::TfrxNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxMemoControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxMemoControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxButtonControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Stdctrls::TButton* FButton;
	bool __fastcall GetCancel(void);
	bool __fastcall GetDefault(void);
	System::Uitypes::TModalResult __fastcall GetModalResult(void);
	void __fastcall SetCancel(const bool Value);
	void __fastcall SetDefault(const bool Value);
	void __fastcall SetModalResult(const System::Uitypes::TModalResult Value);
	bool __fastcall GetWordWrap(void);
	void __fastcall SetWordWrap(const bool Value);
	
public:
	__fastcall virtual TfrxButtonControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Fmx::Stdctrls::TButton* Button = {read=FButton};
	
__published:
	__property bool Cancel = {read=GetCancel, write=SetCancel, default=0};
	__property Caption = {default=0};
	__property bool Default = {read=GetDefault, write=SetDefault, default=0};
	__property System::Uitypes::TModalResult ModalResult = {read=GetModalResult, write=SetModalResult, default=0};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=0};
	__property TabStop = {default=1};
	__property OnClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxButtonControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxButtonControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxCheckBoxControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Stdctrls::TCheckBox* FCheckBox;
	Fmx::Frxclass::TfrxNotifyEvent FOnChange;
	bool __fastcall GetChecked(void);
	void __fastcall SetChecked(const bool Value);
	bool __fastcall GetWordWrap(void);
	void __fastcall SetWordWrap(const bool Value);
	void __fastcall DoOnChange(System::TObject* Sender);
	
public:
	__fastcall virtual TfrxCheckBoxControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Fmx::Stdctrls::TCheckBox* CheckBox = {read=FCheckBox};
	
__published:
	__property Caption = {default=0};
	__property bool Checked = {read=GetChecked, write=SetChecked, default=0};
	__property TabStop = {default=1};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=0};
	__property Fmx::Frxclass::TfrxNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxCheckBoxControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCheckBoxControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxRadioButtonControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Stdctrls::TRadioButton* FRadioButton;
	Fmx::Frxclass::TfrxNotifyEvent FOnChange;
	bool __fastcall GetChecked(void);
	void __fastcall SetChecked(const bool Value);
	bool __fastcall GetWordWrap(void);
	void __fastcall SetWordWrap(const bool Value);
	void __fastcall DoOnChange(System::TObject* Sender);
	
public:
	__fastcall virtual TfrxRadioButtonControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Fmx::Stdctrls::TRadioButton* RadioButton = {read=FRadioButton};
	
__published:
	__property Caption = {default=0};
	__property bool Checked = {read=GetChecked, write=SetChecked, default=0};
	__property TabStop = {default=1};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=0};
	__property Fmx::Frxclass::TfrxNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxRadioButtonControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxRadioButtonControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxListBoxControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Listbox::TListBox* FListBox;
	System::Classes::TStrings* __fastcall GetItems(void);
	void __fastcall SetItems(System::Classes::TStrings* const Value);
	int __fastcall GetItemIndex(void);
	void __fastcall SetItemIndex(const int Value);
	
public:
	__fastcall virtual TfrxListBoxControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxListBoxControl(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Fmx::Listbox::TListBox* ListBox = {read=FListBox};
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	
__published:
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property TabStop = {default=1};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxListBoxControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxComboBoxControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Listbox::TComboBox* FComboBox;
	Fmx::Frxclass::TfrxNotifyEvent FOnChange;
	int __fastcall GetItemIndex(void);
	System::Classes::TStrings* __fastcall GetItems(void);
	System::UnicodeString __fastcall GetText(void);
	void __fastcall DoOnChange(System::TObject* Sender);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetItems(System::Classes::TStrings* const Value);
	void __fastcall SetText(const System::UnicodeString Value);
	
public:
	__fastcall virtual TfrxComboBoxControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Fmx::Listbox::TComboBox* ComboBox = {read=FComboBox};
	
__published:
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property TabStop = {default=1};
	__property System::UnicodeString Text = {read=GetText, write=SetText};
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	__property Fmx::Frxclass::TfrxNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxComboBoxControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxComboBoxControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxPanelControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Stdctrls::TPanel* FPanel;
	System::Classes::TAlignment __fastcall GetAlignment(void);
	int __fastcall GetBevelWidth(void);
	void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetBevelWidth(const int Value);
	
public:
	__fastcall virtual TfrxPanelControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Fmx::Stdctrls::TPanel* Panel = {read=FPanel};
	
__published:
	__property System::Classes::TAlignment Alignment = {read=GetAlignment, write=SetAlignment, default=2};
	__property int BevelWidth = {read=GetBevelWidth, write=SetBevelWidth, default=1};
	__property Caption = {default=0};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxPanelControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxPanelControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxGroupBoxControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Stdctrls::TGroupBox* FGroupBox;
	
public:
	__fastcall virtual TfrxGroupBoxControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Fmx::Stdctrls::TGroupBox* GroupBox = {read=FGroupBox};
	
__published:
	__property Caption = {default=0};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxGroupBoxControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxGroupBoxControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDateEditControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	TCalendarBox* FDateEdit;
	Fmx::Frxclass::TfrxNotifyEvent FOnChange;
	bool FWeekNumbers;
	System::TDate __fastcall GetDate(void);
	System::TTime __fastcall GetTime(void);
	void __fastcall DoOnChange(System::TObject* Sender);
	void __fastcall SetDate(const System::TDate Value);
	void __fastcall SetTime(const System::TTime Value);
	void __fastcall DropDown(System::TObject* Sender);
	
public:
	__fastcall virtual TfrxDateEditControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property TCalendarBox* DateEdit = {read=FDateEdit};
	
__published:
	__property System::TDate Date = {read=GetDate, write=SetDate};
	__property TabStop = {default=1};
	__property System::TTime Time = {read=GetTime, write=SetTime};
	__property bool WeekNumbers = {read=FWeekNumbers, write=FWeekNumbers, nodefault};
	__property Fmx::Frxclass::TfrxNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxDateEditControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDateEditControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxImageControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Objects::TImage* FImage;
	bool __fastcall GetAutoSize(void);
	bool __fastcall GetCenter(void);
	Fmx::Graphics::TBitmap* __fastcall GetPicture(void);
	bool __fastcall GetStretch(void);
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetCenter(const bool Value);
	void __fastcall SetPicture(Fmx::Graphics::TBitmap* const Value);
	void __fastcall SetStretch(const bool Value);
	
public:
	__fastcall virtual TfrxImageControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Fmx::Objects::TImage* Image = {read=FImage};
	
__published:
	__property bool AutoSize = {read=GetAutoSize, write=SetAutoSize, default=0};
	__property bool Center = {read=GetCenter, write=SetCenter, default=0};
	__property Fmx::Graphics::TBitmap* Picture = {read=GetPicture, write=SetPicture};
	__property bool Stretch = {read=GetStretch, write=SetStretch, default=0};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxImageControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxImageControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxBevelControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Stdctrls::TPanel* FBevel;
	
public:
	__fastcall virtual TfrxBevelControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Fmx::Stdctrls::TPanel* Bevel = {read=FBevel};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxBevelControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxBevelControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxBitBtnControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Frxfmx::TfrxToolButton* FBitBtn;
	Fmx::Graphics::TBitmap* __fastcall GetGlyph(void);
	int __fastcall GetMargin(void);
	System::Uitypes::TModalResult __fastcall GetModalResult(void);
	int __fastcall GetSpacing(void);
	void __fastcall SetGlyph(Fmx::Graphics::TBitmap* const Value);
	void __fastcall SetMargin(const int Value);
	void __fastcall SetModalResult(const System::Uitypes::TModalResult Value);
	void __fastcall SetSpacing(const int Value);
	int __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(const int Value);
	bool __fastcall GetWordWrap(void);
	void __fastcall SetWordWrap(const bool Value);
	
public:
	__fastcall virtual TfrxBitBtnControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Fmx::Frxfmx::TfrxToolButton* BitBtn = {read=FBitBtn};
	
__published:
	__property Fmx::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property Caption = {default=0};
	__property int Margin = {read=GetMargin, write=SetMargin, default=-1};
	__property System::Uitypes::TModalResult ModalResult = {read=GetModalResult, write=SetModalResult, default=0};
	__property int NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property int Spacing = {read=GetSpacing, write=SetSpacing, default=4};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=0};
	__property TabStop = {default=1};
	__property OnClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxBitBtnControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxBitBtnControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxSpeedButtonControl : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Stdctrls::TSpeedButton* FSpeedButton;
	bool __fastcall GetAllowAllUp(void);
	bool __fastcall GetDown(void);
	bool __fastcall GetFlat(void);
	Fmx::Graphics::TBitmap* __fastcall GetGlyph(void);
	int __fastcall GetGroupIndex(void);
	int __fastcall GetMargin(void);
	int __fastcall GetSpacing(void);
	void __fastcall SetAllowAllUp(const bool Value);
	void __fastcall SetDown(const bool Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetGlyph(Fmx::Graphics::TBitmap* const Value);
	void __fastcall SetGroupIndex(const int Value);
	void __fastcall SetMargin(const int Value);
	void __fastcall SetSpacing(const int Value);
	
public:
	__fastcall virtual TfrxSpeedButtonControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Fmx::Stdctrls::TSpeedButton* SpeedButton = {read=FSpeedButton};
	
__published:
	__property bool AllowAllUp = {read=GetAllowAllUp, write=SetAllowAllUp, default=0};
	__property Caption = {default=0};
	__property bool Down = {read=GetDown, write=SetDown, default=0};
	__property bool Flat = {read=GetFlat, write=SetFlat, default=0};
	__property Fmx::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property int GroupIndex = {read=GetGroupIndex, write=SetGroupIndex, nodefault};
	__property int Margin = {read=GetMargin, write=SetMargin, default=-1};
	__property int Spacing = {read=GetSpacing, write=SetSpacing, default=4};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxSpeedButtonControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxSpeedButtonControl(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdctrl */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXDCTRL)
using namespace Fmx::Frxdctrl;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxdctrlHPP
