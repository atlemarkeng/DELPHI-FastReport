// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxGlyphTableClass.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxglyphtableclassHPP
#define Fmx_FrxglyphtableclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMX.TTFHelpers.hpp>
#include <System.Classes.hpp>
#include <FMX.frxTrueTypeTable.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxglyphtableclass
{
//-- forward type declarations -----------------------------------------------
struct CompositeGlyphHeader;
struct GlyphHeader;
class DELPHICLASS GlyphTableClass;
class DELPHICLASS GlyphPoint;
//-- type declarations -------------------------------------------------------
typedef System::Classes::TList TIntegerList;

enum DECLSPEC_DENUM CompositeFlags : unsigned int { ARG_1_AND_2_ARE_WORDS = 0x1, ARGS_ARE_XY_VALUES, MORE_COMPONENTS = 0x20, OVERLAP_COMPOUND = 0x400, RESERVED = 0x10, ROUND_XY_TO_GRID = 0x4, SCALED_COMPONENT_OFFSET = 0x800, UNSCALED_COMPONENT_OFFSET = 0x10000, USE_MY_METRICS = 0x200, WE_HAVE_A_SCALE = 0x8, WE_HAVE_A_TWO_BY_TWO = 0x80, WE_HAVE_AN_X_AND_Y_SCALE = 0x40, WE_HAVE_INSTRUCTIONS = 0x100 };

enum DECLSPEC_DENUM GlyphFlags : unsigned char { ON_CURVE = 0x1, REP = 0x8, X_POSITIVE = 0x10, X_SAME = 0x10, X_SHORT = 0x2, Y_POSITIVE = 0x20, Y_SAME = 0x20, Y_SHORT = 0x4 };

#pragma pack(push,1)
struct DECLSPEC_DRECORD CompositeGlyphHeader
{
public:
	System::Word flags;
	System::Word glyphIndex;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD GlyphHeader
{
public:
	short numberOfContours;
	short xMin;
	short yMin;
	short xMax;
	short yMax;
};
#pragma pack(pop)


class PASCALIMPLEMENTATION GlyphTableClass : public Fmx::Frxtruetypetable::TrueTypeTable
{
	typedef Fmx::Frxtruetypetable::TrueTypeTable inherited;
	
private:
	void *glyph_table_ptr;
	
public:
	__fastcall GlyphTableClass(Fmx::Frxtruetypetable::TrueTypeTable* src);
	System::Classes::TList* __fastcall CheckGlyph(int glyph_offset, int glyph_size);
	
private:
	GlyphHeader __fastcall GetGlyphHeader(int glyph_offset);
	
public:
	virtual void __fastcall Load(void * font);
	
private:
	void * __fastcall ReadRawByte(void * ptr, System::Byte &val);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~GlyphTableClass(void) { }
	
};


class PASCALIMPLEMENTATION GlyphPoint : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	bool end_of_contour;
	bool on_curve;
	float x;
	float y;
public:
	/* TObject.Create */ inline __fastcall GlyphPoint(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~GlyphPoint(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxglyphtableclass */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXGLYPHTABLECLASS)
using namespace Fmx::Frxglyphtableclass;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxglyphtableclassHPP
