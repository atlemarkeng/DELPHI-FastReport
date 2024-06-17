// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxChart.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxchartHPP
#define Fmx_FrxchartHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <FMX.Types.hpp>
#include <FMX.Menus.hpp>
#include <FMX.Controls.hpp>
#include <FMX.frxClass.hpp>
#include <System.UIConsts.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Canvas.hpp>
#include <System.Variants.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.frxFMX.hpp>
#include <System.Math.Vectors.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxchart
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxChartObject;
class DELPHICLASS TfrxSeriesItem;
class DELPHICLASS TfrxSeriesData;
class DELPHICLASS TfrxChartView;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxChartObject : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfrxChartObject(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxChartObject(void) { }
	
};


typedef System::TMetaClass* TChartClass;

enum DECLSPEC_DENUM TfrxSeriesDataType : unsigned char { dtDBData, dtBandData, dtFixedData };

enum DECLSPEC_DENUM TfrxSeriesSortOrder : unsigned char { soNone, soAscending, soDescending };

enum DECLSPEC_DENUM TfrxSeriesXType : unsigned char { xtText, xtNumber, xtDate };

typedef System::TMetaClass* TSeriesClass;

enum DECLSPEC_DENUM TfrxChartSeries : unsigned char { csLine, csArea, csPoint, csBar, csHorizBar, csPie, csGantt, csFastLine, csArrow, csBubble, csChartShape, csHorizArea, csHorizLine, csPolar, csRadar, csPolarBar, csGauge, csSmith, csPyramid, csDonut, csBezier, csCandle, csVolume, csPointFigure, csHistogram, csHorizHistogram, csErrorBar, csError, csHighLow, csFunnel, csBox, csHorizBox, csSurface, csContour, csWaterFall, csColorGrid, csVector3D, csTower, csTriSurface, csPoint3D, csBubble3D, csMyPoint, csBarJoin, csBar3D };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSeriesItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Fmx::Frxclass::TfrxDataBand* FDataBand;
	Fmx::Frxclass::TfrxDataSet* FDataSet;
	System::UnicodeString FDataSetName;
	TfrxSeriesDataType FDataType;
	TfrxSeriesSortOrder FSortOrder;
	int FTopN;
	System::UnicodeString FTopNCaption;
	System::UnicodeString FSource1;
	System::UnicodeString FSource2;
	System::UnicodeString FSource3;
	System::UnicodeString FSource4;
	System::UnicodeString FSource5;
	System::UnicodeString FSource6;
	TfrxSeriesXType FXType;
	System::UnicodeString FValues1;
	System::UnicodeString FValues2;
	System::UnicodeString FValues3;
	System::UnicodeString FValues4;
	System::UnicodeString FValues5;
	System::UnicodeString FValues6;
	bool FIsDataChanged;
	void __fastcall FillSeries(Fmxtee::Engine::TChartSeries* Series);
	void __fastcall SetDataSet(Fmx::Frxclass::TfrxDataSet* const Value);
	void __fastcall SetDataSetName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetDataSetName(void);
	void __fastcall SetValues1(const System::UnicodeString Value);
	void __fastcall SetValues2(const System::UnicodeString Value);
	void __fastcall SetValues3(const System::UnicodeString Value);
	void __fastcall SetValues4(const System::UnicodeString Value);
	void __fastcall SetValues5(const System::UnicodeString Value);
	void __fastcall SetValues6(const System::UnicodeString Value);
	
__published:
	__property TfrxSeriesDataType DataType = {read=FDataType, write=FDataType, nodefault};
	__property Fmx::Frxclass::TfrxDataBand* DataBand = {read=FDataBand, write=FDataBand};
	__property Fmx::Frxclass::TfrxDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property System::UnicodeString DataSetName = {read=GetDataSetName, write=SetDataSetName};
	__property TfrxSeriesSortOrder SortOrder = {read=FSortOrder, write=FSortOrder, nodefault};
	__property int TopN = {read=FTopN, write=FTopN, nodefault};
	__property System::UnicodeString TopNCaption = {read=FTopNCaption, write=FTopNCaption};
	__property TfrxSeriesXType XType = {read=FXType, write=FXType, nodefault};
	__property System::UnicodeString Source1 = {read=FSource1, write=FSource1};
	__property System::UnicodeString Source2 = {read=FSource2, write=FSource2};
	__property System::UnicodeString Source3 = {read=FSource3, write=FSource3};
	__property System::UnicodeString Source4 = {read=FSource4, write=FSource4};
	__property System::UnicodeString Source5 = {read=FSource5, write=FSource5};
	__property System::UnicodeString Source6 = {read=FSource6, write=FSource6};
	__property System::UnicodeString Values1 = {read=FValues1, write=SetValues1};
	__property System::UnicodeString Values2 = {read=FValues2, write=SetValues2};
	__property System::UnicodeString Values3 = {read=FValues3, write=SetValues3};
	__property System::UnicodeString Values4 = {read=FValues4, write=SetValues4};
	__property System::UnicodeString Values5 = {read=FValues5, write=SetValues5};
	__property System::UnicodeString Values6 = {read=FValues6, write=SetValues6};
	__property System::UnicodeString XSource = {read=FSource1, write=FSource1};
	__property System::UnicodeString YSource = {read=FSource2, write=FSource2};
	__property System::UnicodeString XValues = {read=FValues1, write=SetValues1};
	__property System::UnicodeString YValues = {read=FValues2, write=SetValues2};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxSeriesItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxSeriesItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSeriesData : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxSeriesItem* operator[](int Index) { return Items[Index]; }
	
private:
	Fmx::Frxclass::TfrxReport* FReport;
	TfrxSeriesItem* __fastcall GetSeries(int Index);
	
public:
	__fastcall TfrxSeriesData(Fmx::Frxclass::TfrxReport* Report);
	HIDESBASE TfrxSeriesItem* __fastcall Add(void);
	__property TfrxSeriesItem* Items[int Index] = {read=GetSeries/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxSeriesData(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxChartView : public Fmx::Frxclass::TfrxView
{
	typedef Fmx::Frxclass::TfrxView inherited;
	
private:
	Fmxtee::Chart::TCustomChart* FChart;
	TfrxSeriesData* FSeriesData;
	bool FIgnoreNulls;
	Fmx::Graphics::TBitmap* FNormalSize;
	Fmx::Graphics::TBitmap* FBigSize;
	void __fastcall FillChart(void);
	void __fastcall ReadData(System::Classes::TStream* Stream);
	void __fastcall ReadData1(System::Classes::TReader* Reader);
	void __fastcall ReadData2(System::Classes::TReader* Reader);
	void __fastcall WriteData(System::Classes::TStream* Stream);
	void __fastcall WriteData1(System::Classes::TWriter* Writer);
	void __fastcall WriteData2(System::Classes::TWriter* Writer);
	void __fastcall OnFindClass(System::Classes::TReader* Reader, const System::UnicodeString ClassName, System::Classes::TComponentClass &ComponentClass);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall CreateChart(void);
	__classmethod virtual TChartClass __fastcall GetChartClass();
	virtual void __fastcall SetWidth(double Value);
	virtual void __fastcall SetHeight(double Value);
	
public:
	__fastcall virtual TfrxChartView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxChartView(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall AfterPrint(void);
	virtual void __fastcall GetData(void);
	virtual void __fastcall BeforeStartReport(void);
	virtual void __fastcall OnNotify(System::TObject* Sender);
	void __fastcall ClearSeries(void);
	void __fastcall AddSeries(TfrxChartSeries Series);
	__property Fmxtee::Chart::TCustomChart* Chart = {read=FChart};
	__property TfrxSeriesData* SeriesData = {read=FSeriesData};
	
__published:
	__property bool IgnoreNulls = {read=FIgnoreNulls, write=FIgnoreNulls, default=0};
	__property Color = {default=0};
	__property Cursor = {default=0};
	__property Frame;
	__property TagStr = {default=0};
	__property URL = {default=0};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxChartView(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxView(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxchart */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXCHART)
using namespace Fmx::Frxchart;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxchartHPP
