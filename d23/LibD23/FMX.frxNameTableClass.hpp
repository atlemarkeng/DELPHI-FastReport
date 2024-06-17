// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxNameTableClass.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxnametableclassHPP
#define Fmx_FrxnametableclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMX.TTFHelpers.hpp>
#include <FMX.frxFontHeaderClass.hpp>
#include <FMX.frxTrueTypeTable.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxnametableclass
{
//-- forward type declarations -----------------------------------------------
struct NamingTableHeader;
struct NamingRecord;
class DELPHICLASS NameTableClass;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM NameID : unsigned char { CompatibleFull = 18, CopyrightNotice = 0, Description = 10, Designer = 9, FamilyName = 1, FullName = 4, LicenseDescription = 13, LicenseInfoURL, Manufacturer = 8, PostscriptCID = 20, PostscriptName = 6, PreferredFamily = 16, PreferredSubFamily, SampleText = 19, SubFamilyName = 2, Trademark = 7, UniqueID = 3, URL_Designer = 12, URL_Vendor = 11, Version = 5, WWS_Family_Name = 21, WWS_SubFamily_Name };

#pragma pack(push,1)
struct DECLSPEC_DRECORD NamingTableHeader
{
public:
	System::Word TableVersion;
	System::Word Count;
	System::Word stringOffset;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD NamingRecord
{
public:
	System::Word PlatformID;
	System::Word EncodingID;
	System::Word LanguageID;
	System::Word NameID;
	System::Word Length;
	System::Word Offset;
};
#pragma pack(pop)


#pragma pack(push,4)
class PASCALIMPLEMENTATION NameTableClass : public Fmx::Frxtruetypetable::TrueTypeTable
{
	typedef Fmx::Frxtruetypetable::TrueTypeTable inherited;
	
private:
	NamingTableHeader name_header;
	void *namerecord_ptr;
	void *string_storage_ptr;
	
public:
	__fastcall NameTableClass(Fmx::Frxtruetypetable::TrueTypeTable* src);
	
private:
	HIDESBASE void __fastcall ChangeEndian(void);
	
public:
	virtual void __fastcall Load(void * font);
	
private:
	System::UnicodeString __fastcall get_Item(NameID Index);
	
public:
	__property System::UnicodeString Item[NameID Index] = {read=get_Item};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~NameTableClass(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxnametableclass */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXNAMETABLECLASS)
using namespace Fmx::Frxnametableclass;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxnametableclassHPP
