// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxDialogForm.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxdialogformHPP
#define Fmx_FrxdialogformHPP

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
#include <FMX.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxdialogform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxDialogForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxDialogForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	
protected:
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	
private:
	System::Classes::TNotifyEvent FOnModify;
	bool FThreadSafe;
	
public:
	__fastcall virtual TfrxDialogForm(System::Classes::TComponent* AOwner);
	__property System::Classes::TNotifyEvent OnModify = {read=FOnModify, write=FOnModify};
	__property bool ThreadSafe = {read=FThreadSafe, write=FThreadSafe, nodefault};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxDialogForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxDialogForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdialogform */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXDIALOGFORM)
using namespace Fmx::Frxdialogform;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxdialogformHPP
