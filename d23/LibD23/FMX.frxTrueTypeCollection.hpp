// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxTrueTypeCollection.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxtruetypecollectionHPP
#define Fmx_FrxtruetypecollectionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Objects.hpp>
#include <FMX.TTFHelpers.hpp>
#include <FMX.frxTrueTypeFont.hpp>
#include <FMX.frxFontHeaderClass.hpp>
#include <FMX.frxNameTableClass.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxtruetypecollection
{
//-- forward type declarations -----------------------------------------------
struct TTCollectionHeader;
class DELPHICLASS TrueTypeCollection;
//-- type declarations -------------------------------------------------------
typedef System::Classes::TList TFontCollection;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TTCollectionHeader
{
public:
	unsigned TTCTag;
	unsigned Version;
	unsigned numFonts;
};
#pragma pack(pop)


#pragma pack(push,4)
class PASCALIMPLEMENTATION TrueTypeCollection : public Fmx::Ttfhelpers::TTF_Helpers
{
	typedef Fmx::Ttfhelpers::TTF_Helpers inherited;
	
private:
	System::Classes::TList* fonts_collection;
	
private:
	System::Classes::TList* __fastcall get_FontCollection(void);
	Fmx::Frxtruetypefont::TrueTypeFont* __fastcall get_Item(System::UnicodeString FamilyName);
	Fmx::Frxtruetypefont::TrueTypeFont* __fastcall get_FamilyItem(System::UnicodeString FamilyName);
	
public:
	__fastcall TrueTypeCollection(void);
	void __fastcall Initialize(char * FD, int FontDataSize);
	Fmx::Frxtruetypefont::TByteArray __fastcall PackFont(Fmx::Graphics::TFont* font, System::Classes::TList* UsedAlphabet, System::Classes::TStream* sStream);
	__property System::Classes::TList* FontCollection = {read=get_FontCollection};
	__property Fmx::Frxtruetypefont::TrueTypeFont* Item[System::UnicodeString FamilyName] = {read=get_Item};
	__property Fmx::Frxtruetypefont::TrueTypeFont* FamilyItem[System::UnicodeString FamilyName] = {read=get_FamilyItem};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TrueTypeCollection(void) { }
	
};

#pragma pack(pop)

typedef System::StaticArray<System::AnsiString, 10> Fmx_Frxtruetypecollection__2;

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 Elements = System::Int8(0xa);
extern DELPHI_PACKAGE Fmx_Frxtruetypecollection__2 Substitutes;
}	/* namespace Frxtruetypecollection */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXTRUETYPECOLLECTION)
using namespace Fmx::Frxtruetypecollection;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxtruetypecollectionHPP
