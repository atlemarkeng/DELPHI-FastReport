// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.fs_isysrtti.pas' rev: 30.00 (Windows)

#ifndef Fmx_Fs_isysrttiHPP
#define Fmx_Fs_isysrttiHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.fs_iinterpreter.hpp>
#include <FMX.fs_itools.hpp>
#include <FMX.Dialogs.hpp>
#include <System.MaskUtils.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Fs_isysrtti
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfsSysFunctions;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfsSysFunctions : public Fmx::Fs_iinterpreter::TfsRTTIModule
{
	typedef Fmx::Fs_iinterpreter::TfsRTTIModule inherited;
	
private:
	System::UnicodeString FCatConv;
	System::UnicodeString FCatDate;
	System::UnicodeString FCatFormat;
	System::UnicodeString FCatMath;
	System::UnicodeString FCatOther;
	System::UnicodeString FCatStr;
	System::Variant __fastcall CallMethod1(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fmx::Fs_iinterpreter::TfsMethodHelper* Caller);
	System::Variant __fastcall CallMethod2(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fmx::Fs_iinterpreter::TfsMethodHelper* Caller);
	System::Variant __fastcall CallMethod3(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fmx::Fs_iinterpreter::TfsMethodHelper* Caller);
	System::Variant __fastcall CallMethod4(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fmx::Fs_iinterpreter::TfsMethodHelper* Caller);
	System::Variant __fastcall CallMethod5(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fmx::Fs_iinterpreter::TfsMethodHelper* Caller);
	System::Variant __fastcall CallMethod6(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fmx::Fs_iinterpreter::TfsMethodHelper* Caller);
	System::Variant __fastcall CallMethod7(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fmx::Fs_iinterpreter::TfsMethodHelper* Caller);
	
public:
	__fastcall virtual TfsSysFunctions(Fmx::Fs_iinterpreter::TfsScript* AScript);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfsSysFunctions(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Fs_isysrtti */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FS_ISYSRTTI)
using namespace Fmx::Fs_isysrtti;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_Fs_isysrttiHPP
