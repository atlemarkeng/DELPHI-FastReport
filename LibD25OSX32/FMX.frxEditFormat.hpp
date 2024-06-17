// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditFormat.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxeditformatHPP
#define Fmx_FrxeditformatHPP

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
#include <System.Types.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMX.frxClass.hpp>
#include <System.Variants.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditformat
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxFormatEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxFormatEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TGroupBox* CategoryL;
	Fmx::Listbox::TListBox* CategoryLB;
	Fmx::Stdctrls::TGroupBox* FormatL;
	Fmx::Listbox::TListBox* FormatLB;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Stdctrls::TLabel* FormatStrL;
	Fmx::Stdctrls::TLabel* SeparatorL;
	Fmx::Edit::TEdit* FormatE;
	Fmx::Edit::TEdit* SeparatorE;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CategoryLBClick(System::TObject* Sender);
	void __fastcall FormatLBClick(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormatStrLClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	Fmx::Frxclass::TfrxFormat* FFormat;
	
public:
	__fastcall virtual TfrxFormatEditorForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxFormatEditorForm(void);
	void __fastcall HostControls(Fmx::Types::TFmxObject* Host);
	void __fastcall UnhostControls(void);
	__property Fmx::Frxclass::TfrxFormat* Format = {read=FFormat, write=FFormat};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxFormatEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditformat */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITFORMAT)
using namespace Fmx::Frxeditformat;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditformatHPP
