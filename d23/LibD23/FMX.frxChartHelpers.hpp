// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxChartHelpers.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxcharthelpersHPP
#define Fmx_FrxcharthelpersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Types.hpp>
#include <FMX.Menus.hpp>
#include <FMX.Controls.hpp>
#include <FMX.frxChart.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Canvas.hpp>
#include <System.Variants.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxcharthelpers
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxSeriesHelper;
class DELPHICLASS TfrxStdSeriesHelper;
class DELPHICLASS TfrxPieSeriesHelper;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSeriesHelper : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void) = 0 ;
	virtual void __fastcall AddValues(Fmxtee::Engine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Fmx::Frxchart::TfrxSeriesXType XType) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TfrxSeriesHelper(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxSeriesHelper(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxStdSeriesHelper : public TfrxSeriesHelper
{
	typedef TfrxSeriesHelper inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void);
	virtual void __fastcall AddValues(Fmxtee::Engine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Fmx::Frxchart::TfrxSeriesXType XType);
public:
	/* TObject.Create */ inline __fastcall TfrxStdSeriesHelper(void) : TfrxSeriesHelper() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxStdSeriesHelper(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPieSeriesHelper : public TfrxSeriesHelper
{
	typedef TfrxSeriesHelper inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void);
	virtual void __fastcall AddValues(Fmxtee::Engine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Fmx::Frxchart::TfrxSeriesXType XType);
public:
	/* TObject.Create */ inline __fastcall TfrxPieSeriesHelper(void) : TfrxSeriesHelper() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxPieSeriesHelper(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TfrxSeriesHelperClass;

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 frxNumSeries = System::Int8(0x7);
extern DELPHI_PACKAGE System::StaticArray<Fmx::Frxchart::TSeriesClass, 7> frxChartSeries;
extern DELPHI_PACKAGE System::StaticArray<TfrxSeriesHelperClass, 7> frxSeriesHelpers;
extern DELPHI_PACKAGE TfrxSeriesHelper* __fastcall frxFindSeriesHelper(Fmxtee::Engine::TChartSeries* Series);
}	/* namespace Frxcharthelpers */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXCHARTHELPERS)
using namespace Fmx::Frxcharthelpers;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxcharthelpersHPP
