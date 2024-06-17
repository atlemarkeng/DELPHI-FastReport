// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TTFHelpers.pas' rev: 30.00 (MacOS)

#ifndef Fmx_TtfhelpersHPP
#define Fmx_TtfhelpersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Ttfhelpers
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTF_Helpers;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TTF_Helpers : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	__fastcall TTF_Helpers(void);
	
public:
	static void * __fastcall Increment(void * ptr, int cbSize);
	static short __fastcall SwapInt16(short v);
	static int __fastcall SwapInt32(int v);
	static System::Word __fastcall SwapUInt16(System::Word v);
	static unsigned __fastcall SwapUInt32(unsigned v);
	static unsigned __int64 __fastcall SwapUInt64(unsigned __int64 v);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTF_Helpers(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Ttfhelpers */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TTFHELPERS)
using namespace Fmx::Ttfhelpers;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TtfhelpersHPP
