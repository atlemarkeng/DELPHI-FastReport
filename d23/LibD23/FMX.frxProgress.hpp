// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxProgress.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxprogressHPP
#define Fmx_FrxprogressHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Types.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxprogress
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxProgress;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxProgress : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Stdctrls::TLabel* LMessage;
	Fmx::Stdctrls::TProgressBar* Bar;
	Fmx::Stdctrls::TButton* CancelB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CancelBClick(System::TObject* Sender);
	
private:
	Fmx::Forms::TForm* FActiveForm;
	bool FTerminated;
	int FPosition;
	System::UnicodeString FMessage;
	bool FProgress;
	HIDESBASE void __fastcall SetPosition(int Value);
	void __fastcall SetMessage(const System::UnicodeString Value);
	void __fastcall SetTerminated(bool Value);
	void __fastcall SetProgress(bool Value);
	
public:
	void __fastcall Reset(void);
	void __fastcall Execute(int MaxValue, const System::UnicodeString Msg, bool Canceled, bool Progress);
	void __fastcall Tick(void);
	__property bool Terminated = {read=FTerminated, write=SetTerminated, nodefault};
	__property int Position = {read=FPosition, write=SetPosition, nodefault};
	__property bool ShowProgress = {read=FProgress, write=SetProgress, nodefault};
	__property System::UnicodeString Message = {read=FMessage, write=SetMessage};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxProgress(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxProgress(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxProgress(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxprogress */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXPROGRESS)
using namespace Fmx::Frxprogress;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxprogressHPP
