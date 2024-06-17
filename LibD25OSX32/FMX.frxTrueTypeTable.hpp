// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxTrueTypeTable.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxtruetypetableHPP
#define Fmx_FrxtruetypetableHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMX.TTFHelpers.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxtruetypetable
{
//-- forward type declarations -----------------------------------------------
struct TableEntry;
class DELPHICLASS TrueTypeTable;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TableEntry
{
public:
	unsigned tag;
	unsigned checkSum;
	unsigned offset;
	unsigned length;
};
#pragma pack(pop)


#pragma pack(push,4)
class PASCALIMPLEMENTATION TrueTypeTable : public Fmx::Ttfhelpers::TTF_Helpers
{
	typedef Fmx::Ttfhelpers::TTF_Helpers inherited;
	
protected:
	TableEntry entry;
	
public:
	__fastcall TrueTypeTable(TrueTypeTable* parent)/* overload */;
	__fastcall TrueTypeTable(void * entry_ptr)/* overload */;
	
private:
	void __fastcall ChangeEndian(void);
	
protected:
	virtual void __fastcall Load(void * font);
	
public:
	virtual unsigned __fastcall Save(void * font, unsigned offset);
	void * __fastcall StoreDescriptor(void * descriptor_ptr);
	
private:
	unsigned __fastcall StoreTable(void * source_ptr, void * destination_ptr, unsigned output_offset);
	System::UnicodeString __fastcall get_TAGLINE(void);
	void __fastcall set_length(unsigned length);
	void __fastcall set_offset(unsigned offset);
	
public:
	__property unsigned length = {read=entry.length, write=set_length, nodefault};
	__property unsigned offset = {read=entry.offset, write=set_offset, nodefault};
	__property unsigned checkSum = {read=entry.checkSum, write=entry.checkSum, nodefault};
	__property unsigned tag = {read=entry.tag, write=entry.tag, nodefault};
	__property System::UnicodeString TAGLINE = {read=get_TAGLINE};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TrueTypeTable(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxtruetypetable */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXTRUETYPETABLE)
using namespace Fmx::Frxtruetypetable;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxtruetypetableHPP
