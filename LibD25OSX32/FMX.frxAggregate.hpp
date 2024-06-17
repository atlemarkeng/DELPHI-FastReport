// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxAggregate.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxaggregateHPP
#define Fmx_FrxaggregateHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.frxClass.hpp>
#include <System.Variants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxaggregate
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxAggregateItem;
class DELPHICLASS TfrxAggregateList;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxAggregateFunction : unsigned char { agSum, agAvg, agMin, agMax, agCount };

class PASCALIMPLEMENTATION TfrxAggregateItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TfrxAggregateFunction FAggregateFunction;
	Fmx::Frxclass::TfrxDataBand* FBand;
	bool FCountInvisibleBands;
	bool FDontReset;
	System::UnicodeString FExpression;
	bool FIsPageFooter;
	System::Variant FItemsArray;
	int FItemsCount;
	System::Variant FItemsCountArray;
	System::Variant FItemsValue;
	bool FKeeping;
	int FLastCount;
	System::Variant FLastValue;
	System::UnicodeString FMemoName;
	System::UnicodeString FOriginalName;
	Fmx::Frxclass::TfrxBand* FParentBand;
	Fmx::Frxclass::TfrxReport* FReport;
	int FTempItemsCount;
	System::Variant FTempItemsValue;
	int FVColumn;
	
public:
	void __fastcall Calc(void);
	void __fastcall DeleteValue(void);
	void __fastcall Reset(void);
	void __fastcall StartKeep(void);
	void __fastcall EndKeep(void);
	System::Variant __fastcall Value(void);
public:
	/* TObject.Create */ inline __fastcall TfrxAggregateItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxAggregateItem(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxAggregateList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxAggregateItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TList* FList;
	Fmx::Frxclass::TfrxReport* FReport;
	TfrxAggregateItem* __fastcall GetItem(int Index);
	void __fastcall FindAggregates(Fmx::Frxclass::TfrxCustomMemoView* Memo, Fmx::Frxclass::TfrxDataBand* DataBand);
	void __fastcall ParseName(const System::UnicodeString ComplexName, TfrxAggregateFunction &Func, System::UnicodeString &Expr, Fmx::Frxclass::TfrxDataBand* &Band, bool &CountInvisible, bool &DontReset);
	__property TfrxAggregateItem* Items[int Index] = {read=GetItem/*, default*/};
	
public:
	__fastcall TfrxAggregateList(Fmx::Frxclass::TfrxReport* AReport);
	__fastcall virtual ~TfrxAggregateList(void);
	void __fastcall Clear(void);
	void __fastcall ClearValues(void);
	void __fastcall AddItems(Fmx::Frxclass::TfrxReportPage* Page);
	void __fastcall AddValue(Fmx::Frxclass::TfrxBand* Band, int VColumn = 0x0);
	void __fastcall DeleteValue(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall EndKeep(void);
	void __fastcall Reset(Fmx::Frxclass::TfrxBand* ParentBand);
	void __fastcall StartKeep(void);
	System::Variant __fastcall GetValue(Fmx::Frxclass::TfrxBand* ParentBand, const System::UnicodeString ComplexName, int VColumn = 0x0)/* overload */;
	System::Variant __fastcall GetValue(Fmx::Frxclass::TfrxBand* ParentBand, int VColumn, const System::UnicodeString Name, const System::UnicodeString Expression, Fmx::Frxclass::TfrxBand* Band, int Flags)/* overload */;
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxaggregate */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXAGGREGATE)
using namespace Fmx::Frxaggregate;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxaggregateHPP
