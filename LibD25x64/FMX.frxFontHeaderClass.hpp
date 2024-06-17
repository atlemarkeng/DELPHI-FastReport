// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxFontHeaderClass.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxfontheaderclassHPP
#define Fmx_FrxfontheaderclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMX.TTFHelpers.hpp>
#include <FMX.frxTrueTypeTable.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxfontheaderclass
{
//-- forward type declarations -----------------------------------------------
struct FontHeader;
class DELPHICLASS FontHeaderClass;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD FontHeader
{
public:
	unsigned version;
	unsigned revision;
	unsigned checkSumAdjustment;
	unsigned magicNumber;
	System::Word flags;
	System::Word unitsPerEm;
	unsigned __int64 CreatedDateTime;
	unsigned __int64 ModifiedDateTime;
	short xMin;
	short yMin;
	short xMax;
	short yMax;
	System::Word macStyle;
	System::Word lowestRecPPEM;
	short fontDirectionHint;
	short indexToLocFormat;
	short glyphDataFormat;
};
#pragma pack(pop)


enum DECLSPEC_DENUM IndexToLoc : unsigned char { LongType = 0x1, ShortType = 0x0 };

enum DECLSPEC_DENUM FontType : unsigned int { TrueTypeCollection = 1717793908, TrueTypeFontType = 0 };

class PASCALIMPLEMENTATION FontHeaderClass : public Fmx::Frxtruetypetable::TrueTypeTable
{
	typedef Fmx::Frxtruetypetable::TrueTypeTable inherited;
	
public:
	FontHeader font_header;
	
private:
	IndexToLoc __fastcall get_indexToLocFormat(void);
	__property unsigned checkSumAdjustment = {write=font_header.checkSumAdjustment, nodefault};
	__property System::Word Flags = {read=font_header.flags, nodefault};
	
public:
	__property IndexToLoc indexToLocFormat = {read=get_indexToLocFormat, nodefault};
	__property System::Word unitsPerEm = {read=font_header.unitsPerEm, nodefault};
	__fastcall FontHeaderClass(Fmx::Frxtruetypetable::TrueTypeTable* src);
	
private:
	HIDESBASE void __fastcall ChangeEndian(void);
	
public:
	virtual void __fastcall Load(void * font);
	void __fastcall SaveFontHeader(void * header_ptr, unsigned CheckSum);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~FontHeaderClass(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxfontheaderclass */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXFONTHEADERCLASS)
using namespace Fmx::Frxfontheaderclass;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxfontheaderclassHPP
