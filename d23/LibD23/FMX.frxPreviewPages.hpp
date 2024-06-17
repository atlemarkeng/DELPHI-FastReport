// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxPreviewPages.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxpreviewpagesHPP
#define Fmx_FrxpreviewpagesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <System.UIConsts.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxXML.hpp>
#include <FMX.frxPictureCache.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.Printer.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxpreviewpages
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THackCanvas;
class DELPHICLASS TfrxOutline;
class DELPHICLASS TfrxDictionary;
class DELPHICLASS TfrxPreviewPages;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION THackCanvas : public Fmx::Graphics::TCanvas
{
	typedef Fmx::Graphics::TCanvas inherited;
	
protected:
	/* TCanvas.CreateFromWindow */ inline __fastcall virtual THackCanvas(Fmx::Types::TWindowHandle* const AParent, const int AWidth, const int AHeight, const Fmx::Graphics::TCanvasQuality AQuality) : Fmx::Graphics::TCanvas(AParent, AWidth, AHeight, AQuality) { }
	/* TCanvas.CreateFromBitmap */ inline __fastcall virtual THackCanvas(Fmx::Graphics::TBitmap* const ABitmap, const Fmx::Graphics::TCanvasQuality AQuality) : Fmx::Graphics::TCanvas(ABitmap, AQuality) { }
	/* TCanvas.CreateFromPrinter */ inline __fastcall virtual THackCanvas(Fmx::Graphics::TAbstractPrinter* const APrinter) : Fmx::Graphics::TCanvas(APrinter) { }
	
public:
	/* TCanvas.Destroy */ inline __fastcall virtual ~THackCanvas(void) { }
	
public:
	/* TObject.Create */ inline __fastcall THackCanvas(void) : Fmx::Graphics::TCanvas() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxOutline : public Fmx::Frxclass::TfrxCustomOutline
{
	typedef Fmx::Frxclass::TfrxCustomOutline inherited;
	
protected:
	virtual int __fastcall GetCount(void);
	
public:
	Fmx::Frxxml::TfrxXMLItem* __fastcall Root(void);
	virtual void __fastcall AddItem(const System::UnicodeString Text, int Top);
	virtual void __fastcall LevelDown(int Index);
	virtual void __fastcall LevelRoot(void);
	virtual void __fastcall LevelUp(void);
	virtual void __fastcall GetItem(int Index, System::UnicodeString &Text, int &Page, int &Top);
	virtual void __fastcall ShiftItems(Fmx::Frxxml::TfrxXMLItem* From, int NewTop);
	virtual Fmx::Frxxml::TfrxXMLItem* __fastcall GetCurPosition(void);
public:
	/* TfrxCustomOutline.Create */ inline __fastcall virtual TfrxOutline(Fmx::Frxclass::TfrxCustomPreviewPages* APreviewPages) : Fmx::Frxclass::TfrxCustomOutline(APreviewPages) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxOutline(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxDictionary : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStringList* FNames;
	System::Classes::TStringList* FSourceNames;
	
public:
	__fastcall TfrxDictionary(void);
	__fastcall virtual ~TfrxDictionary(void);
	void __fastcall Add(const System::UnicodeString Name, const System::UnicodeString SourceName, System::TObject* Obj);
	void __fastcall Clear(void);
	System::UnicodeString __fastcall AddUnique(const System::UnicodeString Base, const System::UnicodeString SourceName, System::TObject* Obj);
	System::UnicodeString __fastcall CreateUniqueName(const System::UnicodeString Base);
	System::UnicodeString __fastcall GetSourceName(const System::UnicodeString Name);
	System::TObject* __fastcall GetObject(const System::UnicodeString Name);
	__property System::Classes::TStringList* Names = {read=FNames};
	__property System::Classes::TStringList* SourceNames = {read=FSourceNames};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxPreviewPages : public Fmx::Frxclass::TfrxCustomPreviewPages
{
	typedef Fmx::Frxclass::TfrxCustomPreviewPages inherited;
	
private:
	bool FAllowPartialLoading;
	int FCopyNo;
	TfrxDictionary* FDictionary;
	int FFirstObjectIndex;
	int FFirstPageIndex;
	int FFirstOutlineIndex;
	int FLogicalPageN;
	System::Classes::TStringList* FPageCache;
	System::Classes::TStringList* FPageBitmapCache;
	Fmx::Frxxml::TfrxXMLItem* FPagesItem;
	Fmx::Frxpicturecache::TfrxPictureCache* FPictureCache;
	System::Extended FPrintScale;
	System::Classes::TList* FSourcePages;
	System::Classes::TStream* FTempStream;
	Fmx::Frxxml::TfrxXMLDocument* FXMLDoc;
	int FXMLSize;
	System::Extended FLastY;
	System::Extended FLastScale;
	void __fastcall AfterLoad(void);
	void __fastcall BeforeSave(void);
	void __fastcall ClearPageCache(void);
	void __fastcall ClearPageBitmapCache(void);
	void __fastcall ClearSourcePages(void);
	Fmx::Frxxml::TfrxXMLItem* __fastcall CurXMLPage(void);
	Fmx::Frxclass::TfrxComponent* __fastcall GetObject(const System::UnicodeString Name);
	void __fastcall DoLoadFromStream(void);
	void __fastcall DoSaveToStream(void);
	void __fastcall DrawPageInternal(int Index, Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	
protected:
	virtual int __fastcall GetCount(void);
	virtual Fmx::Frxclass::TfrxReportPage* __fastcall GetPage(int Index);
	virtual System::Types::TPoint __fastcall GetPageSize(int Index);
	
public:
	__fastcall virtual TfrxPreviewPages(Fmx::Frxclass::TfrxReport* AReport);
	__fastcall virtual ~TfrxPreviewPages(void);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Initialize(void);
	void __fastcall AddAnchor(const System::UnicodeString Text);
	virtual void __fastcall AddObject(Fmx::Frxclass::TfrxComponent* Obj);
	virtual void __fastcall AddPage(Fmx::Frxclass::TfrxReportPage* Page);
	virtual void __fastcall AddPicture(Fmx::Frxclass::TfrxPictureView* Picture);
	virtual void __fastcall AddSourcePage(Fmx::Frxclass::TfrxReportPage* Page);
	virtual void __fastcall AddToSourcePage(Fmx::Frxclass::TfrxComponent* Obj);
	virtual void __fastcall BeginPass(void);
	virtual void __fastcall ClearFirstPassPages(void);
	virtual void __fastcall CutObjects(int APosition);
	virtual void __fastcall Finish(void);
	virtual void __fastcall IncLogicalPageNumber(void);
	virtual void __fastcall ResetLogicalPageNumber(void);
	virtual void __fastcall PasteObjects(System::Extended X, System::Extended Y);
	virtual void __fastcall ShiftAnchors(int From, int NewTop);
	void __fastcall UpdatePageDimensions(Fmx::Frxclass::TfrxReportPage* Page, System::Extended Width, System::Extended Height);
	virtual bool __fastcall BandExists(Fmx::Frxclass::TfrxBand* Band);
	Fmx::Frxxml::TfrxXMLItem* __fastcall FindAnchor(const System::UnicodeString Text);
	int __fastcall GetAnchorPage(const System::UnicodeString Text);
	virtual int __fastcall GetAnchorCurPosition(void);
	virtual int __fastcall GetCurPosition(void);
	virtual System::Extended __fastcall GetLastY(System::Extended ColumnPosition = 0.000000E+00);
	virtual int __fastcall GetLogicalPageNo(void);
	virtual int __fastcall GetLogicalTotalPages(void);
	virtual void __fastcall DrawPage(int Index, Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall AddEmptyPage(int Index);
	virtual void __fastcall DeletePage(int Index);
	virtual void __fastcall ModifyPage(int Index, Fmx::Frxclass::TfrxReportPage* Page);
	virtual void __fastcall AddFrom(Fmx::Frxclass::TfrxReport* Report);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream, bool AllowPartialLoading = false);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual bool __fastcall LoadFromFile(const System::UnicodeString FileName, bool ExceptionIfNotFound = false);
	virtual void __fastcall SaveToFile(const System::UnicodeString FileName);
	virtual bool __fastcall Print(void);
	virtual bool __fastcall Export(Fmx::Frxclass::TfrxCustomExportFilter* Filter);
	virtual void __fastcall ObjectOver(int Index, int X, int Y, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, System::Extended Scale, System::Extended OffsetX, System::Extended OffsetY, bool Click, System::Uitypes::TCursor &Cursor, bool DBClick = false);
	__property System::Classes::TList* SourcePages = {read=FSourcePages};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxpreviewpages */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXPREVIEWPAGES)
using namespace Fmx::Frxpreviewpages;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxpreviewpagesHPP
