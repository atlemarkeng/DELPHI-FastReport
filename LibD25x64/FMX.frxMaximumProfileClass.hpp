// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxMaximumProfileClass.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxmaximumprofileclassHPP
#define Fmx_FrxmaximumprofileclassHPP

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
namespace Frxmaximumprofileclass
{
//-- forward type declarations -----------------------------------------------
struct MaximumProfile;
class DELPHICLASS MaximumProfileClass;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD MaximumProfile
{
public:
	System::Word maxComponentDepth;
	System::Word maxComponentElements;
	System::Word maxCompositeContours;
	System::Word maxCompositePoints;
	System::Word maxContours;
	System::Word maxFunctionDefs;
	System::Word maxInstructionDefs;
	System::Word maxPoints;
	System::Word maxSizeOfInstructions;
	System::Word maxStackElements;
	System::Word maxStorage;
	System::Word maxTwilightPoints;
	System::Word maxZones;
	System::Word numGlyphs;
	unsigned Version;
};
#pragma pack(pop)


class PASCALIMPLEMENTATION MaximumProfileClass : public Fmx::Frxtruetypetable::TrueTypeTable
{
	typedef Fmx::Frxtruetypetable::TrueTypeTable inherited;
	
private:
	MaximumProfile max_profile;
	
public:
	__fastcall MaximumProfileClass(Fmx::Frxtruetypetable::TrueTypeTable* src);
	
private:
	HIDESBASE void __fastcall ChangeEndian(void);
	
public:
	virtual void __fastcall Load(void * font);
	virtual unsigned __fastcall Save(void * font, unsigned offset);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~MaximumProfileClass(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxmaximumprofileclass */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXMAXIMUMPROFILECLASS)
using namespace Fmx::Frxmaximumprofileclass;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxmaximumprofileclassHPP
