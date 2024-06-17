// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxKerningTableClass.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxkerningtableclassHPP
#define Fmx_FrxkerningtableclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <FMX.TTFHelpers.hpp>
#include <FMX.frxFontHeaderClass.hpp>
#include <FMX.frxTrueTypeTable.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxkerningtableclass
{
//-- forward type declarations -----------------------------------------------
struct CommonKerningHeader;
struct FormatZero;
struct FormatZeroPair;
struct KerningTableHeader;
class DELPHICLASS KerningSubtableClass;
class DELPHICLASS KerningTableClass;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD CommonKerningHeader
{
public:
	System::Word Coverage;
	System::Word Length;
	System::Word Version;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD FormatZero
{
public:
	System::Word entrySelector;
	System::Word nPairs;
	System::Word rangeShift;
	System::Word searchRange;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD FormatZeroPair
{
public:
	unsigned key_value;
	short value;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD KerningTableHeader
{
public:
	System::Word Version;
	System::Word nTables;
};
#pragma pack(pop)


#pragma pack(push,4)
class PASCALIMPLEMENTATION KerningSubtableClass : public Fmx::Ttfhelpers::TTF_Helpers
{
	typedef Fmx::Ttfhelpers::TTF_Helpers inherited;
	
private:
	CommonKerningHeader common_header;
	FormatZero format_zero;
	
public:
	__fastcall KerningSubtableClass(void * kerning_table_ptr);
	
private:
	short __fastcall get_Item(unsigned inx);
	
public:
	__property short Item[unsigned hash_value] = {read=get_Item};
	__property System::Word Length = {read=common_header.Length, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~KerningSubtableClass(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION KerningTableClass : public Fmx::Frxtruetypetable::TrueTypeTable
{
	typedef Fmx::Frxtruetypetable::TrueTypeTable inherited;
	
private:
	KerningTableHeader kerning_table_header;
	System::Classes::TList* kerning_subtables_collection;
	
public:
	__fastcall KerningTableClass(Fmx::Frxtruetypetable::TrueTypeTable* src);
	
private:
	HIDESBASE void __fastcall ChangeEndian(void);
	
public:
	virtual void __fastcall Load(void * font);
	
private:
	short __fastcall get_Item(unsigned idx);
	
public:
	__property short Item[unsigned hash_value] = {read=get_Item};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~KerningTableClass(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxkerningtableclass */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXKERNINGTABLECLASS)
using namespace Fmx::Frxkerningtableclass;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxkerningtableclassHPP
