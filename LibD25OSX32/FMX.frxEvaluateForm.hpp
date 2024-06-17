// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEvaluateForm.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxevaluateformHPP
#define Fmx_FrxevaluateformHPP

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
#include <FMX.fs_iinterpreter.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Memo.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Types.hpp>
#include <System.Variants.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxevaluateform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxEvaluateForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxEvaluateForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Edit::TEdit* ExpressionE;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Memo::TMemo* ResultM;
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	
private:
	Fmx::Fs_iinterpreter::TfsScript* FScript;
	bool FIsWatch;
	
public:
	__property bool IsWatch = {read=FIsWatch, write=FIsWatch, nodefault};
	__property Fmx::Fs_iinterpreter::TfsScript* Script = {read=FScript, write=FScript};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxEvaluateForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxEvaluateForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxEvaluateForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxevaluateform */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEVALUATEFORM)
using namespace Fmx::Frxevaluateform;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxevaluateformHPP
