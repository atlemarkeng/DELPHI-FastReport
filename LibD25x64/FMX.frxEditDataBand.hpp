// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditDataBand.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxeditdatabandHPP
#define Fmx_FrxeditdatabandHPP

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
#include <FMX.Objects.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Types.hpp>
#include <System.Variants.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.SpinBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditdataband
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxDataBandEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxDataBandEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Listbox::TListBox* DatasetsLB;
	Fmx::Stdctrls::TLabel* RecordsL;
	Fmx::Spinbox::TSpinBox* RecordsS;
	void __fastcall DatasetsLBDblClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall DatasetsLBClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall OkBClick(System::TObject* Sender);
	
private:
	Fmx::Frxclass::TfrxDataBand* FDataBand;
	Fmx::Frxclass::TfrxCustomDesigner* FDesigner;
	
public:
	__property Fmx::Frxclass::TfrxDataBand* DataBand = {read=FDataBand, write=FDataBand};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxDataBandEditorForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxDataBandEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxDataBandEditorForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditdataband */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITDATABAND)
using namespace Fmx::Frxeditdataband;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditdatabandHPP
