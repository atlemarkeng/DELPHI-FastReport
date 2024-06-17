// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxHorizontalMetrixClass.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxhorizontalmetrixclassHPP
#define Fmx_FrxhorizontalmetrixclassHPP

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
namespace Frxhorizontalmetrixclass
{
//-- forward type declarations -----------------------------------------------
struct longHorMetric;
class DELPHICLASS HorizontalMetrixClass;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD longHorMetric
{
public:
	System::Word advanceWidth;
	short lsb;
};
#pragma pack(pop)


typedef System::DynamicArray<longHorMetric> THorMetricArray;

class PASCALIMPLEMENTATION HorizontalMetrixClass : public Fmx::Frxtruetypetable::TrueTypeTable
{
	typedef Fmx::Frxtruetypetable::TrueTypeTable inherited;
	
private:
	THorMetricArray MetrixTable;
	
public:
	System::Word NumberOfMetrics;
	__fastcall HorizontalMetrixClass(Fmx::Frxtruetypetable::TrueTypeTable* src);
	virtual void __fastcall Load(void * font);
	longHorMetric __fastcall GetItem(int index);
	__property longHorMetric Item[int index] = {read=GetItem};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~HorizontalMetrixClass(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxhorizontalmetrixclass */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXHORIZONTALMETRIXCLASS)
using namespace Fmx::Frxhorizontalmetrixclass;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxhorizontalmetrixclassHPP
