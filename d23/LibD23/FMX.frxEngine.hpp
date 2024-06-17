// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEngine.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxengineHPP
#define Fmx_FrxengineHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <FMX.Forms.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxAggregate.hpp>
#include <FMX.frxXML.hpp>
#include <FMX.frxDMPClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxengine
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxHeaderListItem;
class DELPHICLASS TfrxHeaderList;
class DELPHICLASS TfrxEngine;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxHeaderListItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Fmx::Frxclass::TfrxBand* Band;
	System::Extended Left;
	bool IsInKeepList;
public:
	/* TObject.Create */ inline __fastcall TfrxHeaderListItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxHeaderListItem(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxHeaderList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxHeaderListItem* operator[](int Index) { return Items[Index]; }
	
private:
	System::Classes::TList* FList;
	int __fastcall GetCount(void);
	TfrxHeaderListItem* __fastcall GetItems(int Index);
	
public:
	__fastcall TfrxHeaderList(void);
	__fastcall virtual ~TfrxHeaderList(void);
	void __fastcall Clear(void);
	void __fastcall AddItem(Fmx::Frxclass::TfrxBand* ABand, System::Extended ALeft, bool AInKeepList);
	void __fastcall RemoveItem(Fmx::Frxclass::TfrxBand* ABand);
	__property int Count = {read=GetCount, nodefault};
	__property TfrxHeaderListItem* Items[int Index] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxEngine : public Fmx::Frxclass::TfrxCustomEngine
{
	typedef Fmx::Frxclass::TfrxCustomEngine inherited;
	
private:
	Fmx::Frxaggregate::TfrxAggregateList* FAggregates;
	bool FCallFromAddPage;
	bool FCallFromEndPage;
	Fmx::Frxclass::TfrxBand* FCurBand;
	Fmx::Frxclass::TfrxBand* FLastBandOnPage;
	bool FDontShowHeaders;
	TfrxHeaderList* FHeaderList;
	bool FFirstReportPage;
	System::Extended FFirstColumnY;
	bool FIsFirstBand;
	bool FIsFirstPage;
	bool FIsLastPage;
	bool FTitlePrinted;
	System::Classes::TStrings* FHBandNamesTree;
	Fmx::Frxclass::TfrxBand* FKeepBand;
	bool FKeepFooter;
	bool FKeeping;
	bool FKeepHeader;
	System::Extended FKeepCurY;
	System::Extended FPrevFooterHeight;
	Fmx::Frxxml::TfrxXMLItem* FKeepOutline;
	int FKeepPosition;
	int FKeepAnchor;
	bool FCallFromPHeader;
	Fmx::Frxclass::TfrxNullBand* FOutputTo;
	Fmx::Frxclass::TfrxReportPage* FPage;
	System::Extended FPageCurX;
	Fmx::Frxclass::TfrxBand* FStartNewPageBand;
	System::Classes::TList* FVHeaderList;
	Fmx::Frxclass::TfrxBand* FVMasterBand;
	System::Classes::TList* FVPageList;
	void __fastcall AddBandOutline(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall AddColumn(void);
	void __fastcall AddPage(void);
	void __fastcall AddPageOutline(void);
	void __fastcall AddToHeaderList(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall AddToVHeaderList(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall CheckBandColumns(Fmx::Frxclass::TfrxDataBand* Band, int ColumnKeepPos, System::Extended SaveCurY);
	void __fastcall CheckDrill(Fmx::Frxclass::TfrxDataBand* Master, Fmx::Frxclass::TfrxGroupHeader* Band);
	void __fastcall CheckGroups(Fmx::Frxclass::TfrxDataBand* Master, Fmx::Frxclass::TfrxGroupHeader* Band, int ColumnKeepPos, System::Extended SaveCurY);
	void __fastcall CheckSubReports(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall CheckSuppress(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall DoShow(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall DrawSplit(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall EndColumn(void);
	void __fastcall EndKeep(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall InitGroups(Fmx::Frxclass::TfrxDataBand* Master, Fmx::Frxclass::TfrxGroupHeader* Band, int Index, bool ResetLineN = false);
	void __fastcall InitPage(void);
	void __fastcall NotifyObjects(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall OutlineRoot(void);
	void __fastcall OutlineUp(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall PreparePage(System::Classes::TStrings* ErrorList, bool PrepareVBands);
	void __fastcall PrepareShiftTree(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall RemoveFromHeaderList(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall RemoveFromVHeaderList(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall ResetSuppressValues(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall RunPage(Fmx::Frxclass::TfrxReportPage* Page);
	void __fastcall RunReportPages(void);
	void __fastcall ShowGroupFooters(Fmx::Frxclass::TfrxGroupHeader* Band, int Index, Fmx::Frxclass::TfrxDataBand* Master);
	void __fastcall ShowVBands(Fmx::Frxclass::TfrxBand* HBand);
	void __fastcall StartKeep(Fmx::Frxclass::TfrxBand* Band, int Position = 0x0);
	void __fastcall Stretch(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall UnStretch(Fmx::Frxclass::TfrxBand* Band);
	bool __fastcall CanShow(System::TObject* Obj, bool PrintIfDetailEmpty);
	Fmx::Frxclass::TfrxBand* __fastcall FindBand(Fmx::Frxclass::TfrxBandClass Band);
	bool __fastcall RunDialogs(void);
	
protected:
	virtual double __fastcall GetPageHeight(void);
	
public:
	__fastcall virtual TfrxEngine(Fmx::Frxclass::TfrxReport* AReport);
	__fastcall virtual ~TfrxEngine(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall NewColumn(void);
	virtual void __fastcall NewPage(void);
	virtual bool __fastcall Run(void);
	virtual void __fastcall ShowBand(Fmx::Frxclass::TfrxBand* Band)/* overload */;
	virtual void __fastcall ShowBand(Fmx::Frxclass::TfrxBandClass Band)/* overload */;
	virtual double __fastcall HeaderHeight(void);
	virtual double __fastcall FooterHeight(void);
	virtual double __fastcall FreeSpace(void);
	virtual void __fastcall BreakAllKeep(void);
	virtual System::Variant __fastcall GetAggregateValue(const System::UnicodeString Name, const System::UnicodeString Expression, Fmx::Frxclass::TfrxBand* Band, int Flags);
	bool __fastcall Initialize(void);
	void __fastcall Finalize(void);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxengine */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXENGINE)
using namespace Fmx::Frxengine;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxengineHPP
