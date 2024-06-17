// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditGroup.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxeditgroupHPP
#define Fmx_FrxeditgroupHPP

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
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxCtrls.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Types.hpp>
#include <FMX.Edit.hpp>
#include <System.Variants.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditgroup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxGroupEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxGroupEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OKB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TGroupBox* BreakOnL;
	Fmx::Listbox::TComboBox* DataFieldCB;
	Fmx::Listbox::TComboBox* DataSetCB;
	Fmx::Frxctrls::TfrxEditWithButton* ExpressionE;
	Fmx::Stdctrls::TRadioButton* DataFieldRB;
	Fmx::Stdctrls::TRadioButton* ExpressionRB;
	Fmx::Stdctrls::TGroupBox* OptionsL;
	Fmx::Stdctrls::TCheckBox* KeepGroupTogetherCB;
	Fmx::Stdctrls::TCheckBox* StartNewPageCB;
	Fmx::Stdctrls::TCheckBox* OutlineCB;
	Fmx::Stdctrls::TCheckBox* DrillCB;
	Fmx::Stdctrls::TCheckBox* ResetCB;
	void __fastcall ExpressionEButtonClick(System::TObject* Sender);
	void __fastcall DataFieldRBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall DataSetCBChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	Fmx::Frxclass::TfrxGroupHeader* FGroupHeader;
	Fmx::Frxclass::TfrxReport* FReport;
	void __fastcall FillDataFieldCB(void);
	void __fastcall FillDataSetCB(void);
	
public:
	__property Fmx::Frxclass::TfrxGroupHeader* GroupHeader = {read=FGroupHeader, write=FGroupHeader};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxGroupEditorForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxGroupEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxGroupEditorForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditgroup */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITGROUP)
using namespace Fmx::Frxeditgroup;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditgroupHPP
