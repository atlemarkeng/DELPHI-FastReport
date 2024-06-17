// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxBaseModalForm.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxbasemodalformHPP
#define Fmx_FrxbasemodalformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxbasemodalform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
private:
	void *FSession;
	bool FFormClosed;
	
protected:
	virtual void __fastcall DestroyHandle(void);
	virtual void __fastcall DoClose(System::Uitypes::TCloseAction &CloseAction);
	
public:
	virtual bool __fastcall CloseQuery(void);
	HIDESBASE System::Uitypes::TModalResult __fastcall ShowModal(void)/* overload */;
	void __fastcall PeekLastModalResult(void);
	void __fastcall BeginSesssion(void);
	void __fastcall EndSession(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxForm(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  ShowModal(const System::DelphiInterface<System::Sysutils::TProc__1<System::Uitypes::TModalResult> > ResultProc){ Fmx::Forms::TCommonCustomForm::ShowModal(ResultProc); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbasemodalform */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXBASEMODALFORM)
using namespace Fmx::Frxbasemodalform;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxbasemodalformHPP
