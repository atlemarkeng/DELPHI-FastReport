// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditSysMemo.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxeditsysmemoHPP
#define Fmx_FrxeditsysmemoHPP

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
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxCtrls.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <System.Variants.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditsysmemo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxSysMemoEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxSysMemoEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OKB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TRadioButton* AggregateRB;
	Fmx::Stdctrls::TRadioButton* SysVariableRB;
	Fmx::Stdctrls::TRadioButton* TextRB;
	Fmx::Stdctrls::TGroupBox* AggregatePanel;
	Fmx::Stdctrls::TLabel* DataBandL;
	Fmx::Stdctrls::TLabel* DataSetL;
	Fmx::Stdctrls::TLabel* DataFieldL;
	Fmx::Stdctrls::TLabel* FunctionL;
	Fmx::Stdctrls::TLabel* ExpressionL;
	Fmx::Listbox::TComboBox* DataFieldCB;
	Fmx::Listbox::TComboBox* DataSetCB;
	Fmx::Listbox::TComboBox* DataBandCB;
	Fmx::Stdctrls::TCheckBox* CountInvisibleCB;
	Fmx::Listbox::TComboBox* FunctionCB;
	Fmx::Frxctrls::TfrxEditWithButton* ExpressionE;
	Fmx::Stdctrls::TCheckBox* RunningTotalCB;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Listbox::TComboBox* SysVariableCB;
	Fmx::Stdctrls::TGroupBox* GroupBox2;
	Fmx::Edit::TEdit* TextE;
	Fmx::Stdctrls::TLabel* SampleL;
	void __fastcall ExpressionEButtonClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall DataSetCBChange(System::TObject* Sender);
	void __fastcall DataBandCBChange(System::TObject* Sender);
	void __fastcall DataFieldCBChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FunctionCBChange(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	bool FAggregateOnly;
	Fmx::Frxclass::TfrxReport* FReport;
	System::UnicodeString FText;
	void __fastcall FillDataBandCB(void);
	void __fastcall FillDataFieldCB(void);
	void __fastcall FillDataSetCB(void);
	System::UnicodeString __fastcall CreateAggregate(void);
	void __fastcall UpdateSample(void);
	
public:
	__property bool AggregateOnly = {read=FAggregateOnly, write=FAggregateOnly, nodefault};
	__property System::UnicodeString Text = {read=FText, write=FText};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxSysMemoEditorForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxSysMemoEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxSysMemoEditorForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditsysmemo */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITSYSMEMO)
using namespace Fmx::Frxeditsysmemo;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditsysmemoHPP
