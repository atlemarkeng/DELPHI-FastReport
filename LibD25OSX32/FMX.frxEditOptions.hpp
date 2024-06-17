// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditOptions.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxeditoptionsHPP
#define Fmx_FrxeditoptionsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxCtrls.hpp>
#include <FMX.Objects.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Types.hpp>
#include <System.Variants.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditoptions
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxOptionsEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxOptionsEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TButton* RestoreDefaultsB;
	Fmx::Stdctrls::TGroupBox* Label1;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TLabel* Label13;
	Fmx::Stdctrls::TLabel* Label14;
	Fmx::Stdctrls::TLabel* Label15;
	Fmx::Stdctrls::TLabel* Label16;
	Fmx::Stdctrls::TRadioButton* CMRB;
	Fmx::Stdctrls::TRadioButton* InchesRB;
	Fmx::Stdctrls::TRadioButton* PixelsRB;
	Fmx::Edit::TEdit* CME;
	Fmx::Edit::TEdit* InchesE;
	Fmx::Edit::TEdit* PixelsE;
	Fmx::Edit::TEdit* DialogFormE;
	Fmx::Stdctrls::TCheckBox* ShowGridCB;
	Fmx::Stdctrls::TCheckBox* AlignGridCB;
	Fmx::Stdctrls::TGroupBox* Label6;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Stdctrls::TLabel* Label8;
	Fmx::Stdctrls::TLabel* Label9;
	Fmx::Stdctrls::TLabel* Label10;
	Fmx::Listbox::TComboBox* CodeWindowFontCB;
	Fmx::Listbox::TComboBox* CodeWindowSizeCB;
	Fmx::Listbox::TComboBox* MemoEditorFontCB;
	Fmx::Listbox::TComboBox* MemoEditorSizeCB;
	Fmx::Stdctrls::TCheckBox* ObjectFontCB;
	Fmx::Stdctrls::TGroupBox* Label5;
	Fmx::Stdctrls::TLabel* Label12;
	Fmx::Stdctrls::TLabel* Label17;
	Fmx::Stdctrls::TCheckBox* EditAfterInsCB;
	Fmx::Stdctrls::TCheckBox* FreeBandsCB;
	Fmx::Edit::TEdit* GapE;
	Fmx::Stdctrls::TCheckBox* BandsCaptionsCB;
	Fmx::Stdctrls::TCheckBox* DropFieldsCB;
	Fmx::Stdctrls::TCheckBox* StartupCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall RestoreDefaultsBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxOptionsEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxOptionsEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxOptionsEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditoptions */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITOPTIONS)
using namespace Fmx::Frxeditoptions;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditoptionsHPP
