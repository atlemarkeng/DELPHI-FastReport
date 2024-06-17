// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxSearchDialog.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxsearchdialogHPP
#define Fmx_FrxsearchdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Types.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxsearchdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxSearchDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxSearchDialog : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TPanel* ReplacePanel;
	Fmx::Stdctrls::TLabel* ReplaceL;
	Fmx::Edit::TEdit* ReplaceE;
	Fmx::Stdctrls::TPanel* Panel2;
	Fmx::Stdctrls::TLabel* TextL;
	Fmx::Edit::TEdit* TextE;
	Fmx::Stdctrls::TPanel* Panel3;
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TGroupBox* SearchL;
	Fmx::Stdctrls::TCheckBox* CaseCB;
	Fmx::Stdctrls::TCheckBox* TopCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxSearchDialog(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxSearchDialog(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxSearchDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxsearchdialog */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXSEARCHDIALOG)
using namespace Fmx::Frxsearchdialog;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxsearchdialogHPP
