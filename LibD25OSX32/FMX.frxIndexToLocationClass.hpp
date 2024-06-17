// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxIndexToLocationClass.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxindextolocationclassHPP
#define Fmx_FrxindextolocationclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <FMX.TTFHelpers.hpp>
#include <FMX.frxFontHeaderClass.hpp>
#include <FMX.frxTrueTypeTable.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxindextolocationclass
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS IndexToLocationClass;
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<unsigned> TCardinalArray;

typedef System::DynamicArray<System::Word> TWordArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION IndexToLocationClass : public Fmx::Frxtruetypetable::TrueTypeTable
{
	typedef Fmx::Frxtruetypetable::TrueTypeTable inherited;
	
private:
	TCardinalArray LongIndexToLocation;
	TWordArray ShortIndexToLocation;
	
public:
	__fastcall IndexToLocationClass(Fmx::Frxtruetypetable::TrueTypeTable* src);
	System::Word __fastcall GetGlyph(System::Word i2l_idx, Fmx::Frxfontheaderclass::FontHeaderClass* font_header, unsigned &location);
	void __fastcall LoadIndexToLocation(void * font, Fmx::Frxfontheaderclass::FontHeaderClass* font_header);
	__property TCardinalArray Long = {read=LongIndexToLocation};
	__property TWordArray Short = {read=ShortIndexToLocation};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~IndexToLocationClass(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxindextolocationclass */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXINDEXTOLOCATIONCLASS)
using namespace Fmx::Frxindextolocationclass;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxindextolocationclassHPP
