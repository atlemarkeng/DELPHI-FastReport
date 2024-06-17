// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxExportMatrix.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxexportmatrixHPP
#define Fmx_FrxexportmatrixHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxPreviewPages.hpp>
#include <FMX.frxProgress.hpp>
#include <FMX.frxUtils.hpp>
#include <FMX.frxUnicodeUtils.hpp>
#include <FMX.frxFMX.hpp>
#include <System.WideStrings.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxexportmatrix
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxIEMatrix;
class DELPHICLASS TfrxIEMObject;
class DELPHICLASS TfrxIEMObjectList;
class DELPHICLASS TfrxIEMPos;
class DELPHICLASS TfrxIEMPage;
class DELPHICLASS TfrxIEMStyle;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxIEMatrix : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<int> _TfrxIEMatrix__1;
	
	
private:
	System::Classes::TList* FIEMObjectList;
	System::Classes::TList* FIEMStyleList;
	System::Classes::TList* FXPos;
	System::Classes::TList* FYPos;
	System::Classes::TList* FPages;
	int FWidth;
	int FHeight;
	System::Extended FMaxWidth;
	System::Extended FMaxHeight;
	System::Extended FMinLeft;
	System::Extended FMinTop;
	_TfrxIEMatrix__1 FMatrix;
	System::Extended FDeltaY;
	bool FShowProgress;
	System::Extended FMaxCellHeight;
	System::Extended FMaxCellWidth;
	System::Extended FInaccuracy;
	Fmx::Frxprogress::TfrxProgress* FProgress;
	bool FRotatedImage;
	bool FPlainRich;
	bool FRichText;
	bool FCropFillArea;
	bool FFillArea;
	bool FOptFrames;
	System::Extended FLeft;
	System::Extended FTop;
	bool FDeleteHTMLTags;
	bool FBackImage;
	bool FBackground;
	Fmx::Frxclass::TfrxReport* FReport;
	bool FPrintable;
	bool FImages;
	bool FWrap;
	bool FEmptyLines;
	Fmx::Frxclass::TfrxBand* FHeader;
	Fmx::Frxclass::TfrxBand* FFooter;
	bool FBrushAsBitmap;
	System::Classes::TStringList* FFontList;
	bool FEMFPictures;
	bool FDotMatrix;
	int __fastcall AddStyleInternal(TfrxIEMStyle* Style);
	int __fastcall AddStyle(Fmx::Frxclass::TfrxView* Obj);
	int __fastcall AddInternalObject(TfrxIEMObject* Obj, int x, int y, int dx, int dy);
	bool __fastcall IsMemo(Fmx::Frxclass::TfrxView* Obj);
	bool __fastcall IsLine(Fmx::Frxclass::TfrxView* Obj);
	bool __fastcall IsRect(Fmx::Frxclass::TfrxView* Obj);
	bool __fastcall QuickFind(System::Classes::TList* aList, System::Extended aPosition, int &Index);
	void __fastcall SetCell(int x, int y, int Value);
	void __fastcall FillArea(int x, int y, int dx, int dy, int Value);
	void __fastcall ReplaceArea(int ObjIndex, int x, int y, int dx, int dy, int Value);
	void __fastcall FindRectArea(int x, int y, int &dx, int &dy);
	void __fastcall CutObject(int ObjIndex, int x, int y, int dx, int dy);
	void __fastcall CloneFrames(int Obj1, int Obj2);
	void __fastcall AddPos(System::Classes::TList* List, System::Extended Value);
	void __fastcall OrderPosArray(System::Classes::TList* List, bool Vert);
	void __fastcall OrderByCells(void);
	void __fastcall Render(void);
	void __fastcall Analyse(void);
	void __fastcall OptimizeFrames(void);
	TfrxIEMPage* __fastcall GetIEPages(int Index);
	
public:
	__fastcall TfrxIEMatrix(const bool UseFileCache, const System::UnicodeString TempDir);
	__fastcall virtual ~TfrxIEMatrix(void);
	Fmx::Frxclass::TfrxRect __fastcall GetObjectBounds(TfrxIEMObject* Obj);
	int __fastcall GetFontCharset(Fmx::Graphics::TFont* Font);
	int __fastcall GetCell(int x, int y);
	TfrxIEMObject* __fastcall GetObjectById(int ObjIndex);
	TfrxIEMStyle* __fastcall GetStyleById(int StyleIndex);
	System::Extended __fastcall GetXPosById(int PosIndex);
	System::Extended __fastcall GetYPosById(int PosIndex);
	TfrxIEMObject* __fastcall GetObject(int x, int y);
	TfrxIEMStyle* __fastcall GetStyle(int x, int y);
	System::Extended __fastcall GetCellXPos(int x);
	System::Extended __fastcall GetCellYPos(int y);
	void __fastcall DeleteMatrixLine(int y);
	int __fastcall GetStylesCount(void);
	int __fastcall GetPagesCount(void);
	int __fastcall GetObjectsCount(void);
	void __fastcall Clear(void);
	void __fastcall AddObject(Fmx::Frxclass::TfrxView* Obj);
	void __fastcall AddDialogObject(Fmx::Frxclass::TfrxReportComponent* Obj);
	void __fastcall AddPage(System::Uitypes::TPrinterOrientation Orientation, System::Extended Width, System::Extended Height, System::Extended LeftMargin, System::Extended TopMargin, System::Extended RightMargin, System::Extended BottomMargin, bool MirrorMargins, int Index);
	void __fastcall Prepare(void);
	void __fastcall GetObjectPos(int ObjIndex, int &x, int &y, int &dx, int &dy);
	System::Extended __fastcall GetPageBreak(int Page);
	System::Extended __fastcall GetPageWidth(int Page);
	System::Extended __fastcall GetPageHeight(int Page);
	System::Extended __fastcall GetPageLMargin(int Page);
	System::Extended __fastcall GetPageTMargin(int Page);
	System::Extended __fastcall GetPageRMargin(int Page);
	System::Extended __fastcall GetPageBMargin(int Page);
	bool __fastcall GetPageMirrorMargin(int Page);
	System::Uitypes::TPrinterOrientation __fastcall GetPageOrientation(int Page);
	void __fastcall SetPageHeader(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall SetPageFooter(Fmx::Frxclass::TfrxBand* Band);
	__property int Width = {read=FWidth, nodefault};
	__property int Height = {read=FHeight, nodefault};
	__property System::Extended MaxWidth = {read=FMaxWidth};
	__property System::Extended MaxHeight = {read=FMaxHeight};
	__property System::Extended MinLeft = {read=FMinLeft};
	__property System::Extended MinTop = {read=FMinTop};
	__property bool ShowProgress = {read=FShowProgress, write=FShowProgress, nodefault};
	__property System::Extended MaxCellHeight = {read=FMaxCellHeight, write=FMaxCellHeight};
	__property System::Extended MaxCellWidth = {read=FMaxCellWidth, write=FMaxCellWidth};
	__property int PagesCount = {read=GetPagesCount, nodefault};
	__property int StylesCount = {read=GetStylesCount, nodefault};
	__property int ObjectsCount = {read=GetObjectsCount, nodefault};
	__property System::Extended Inaccuracy = {read=FInaccuracy, write=FInaccuracy};
	__property bool RotatedAsImage = {read=FRotatedImage, write=FRotatedImage, nodefault};
	__property bool RichText = {read=FRichText, write=FRichText, nodefault};
	__property bool PlainRich = {read=FPlainRich, write=FPlainRich, nodefault};
	__property bool AreaFill = {read=FFillArea, write=FFillArea, nodefault};
	__property bool CropAreaFill = {read=FCropFillArea, write=FCropFillArea, nodefault};
	__property bool FramesOptimization = {read=FOptFrames, write=FOptFrames, nodefault};
	__property bool DeleteHTMLTags = {read=FDeleteHTMLTags, write=FDeleteHTMLTags, nodefault};
	__property System::Extended Left = {read=FLeft};
	__property System::Extended Top = {read=FTop};
	__property bool BackgroundImage = {read=FBackImage, write=FBackImage, nodefault};
	__property bool Background = {read=FBackground, write=FBackground, nodefault};
	__property Fmx::Frxclass::TfrxReport* Report = {read=FReport, write=FReport};
	__property bool Printable = {read=FPrintable, write=FPrintable, nodefault};
	__property bool Images = {read=FImages, write=FImages, nodefault};
	__property bool WrapText = {read=FWrap, write=FWrap, nodefault};
	__property bool EmptyLines = {read=FEmptyLines, write=FEmptyLines, nodefault};
	__property bool BrushAsBitmap = {read=FBrushAsBitmap, write=FBrushAsBitmap, nodefault};
	__property bool EMFPictures = {read=FEMFPictures, write=FEMFPictures, nodefault};
	__property bool DotMatrix = {read=FDotMatrix, write=FDotMatrix, nodefault};
	__property TfrxIEMPage* IEPages[int Index] = {read=GetIEPages};
};


class PASCALIMPLEMENTATION TfrxIEMObject : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Widestrings::TWideStrings* FMemo;
	System::UnicodeString FURL;
	int FStyleIndex;
	TfrxIEMStyle* FStyle;
	bool FIsText;
	bool FIsRichText;
	bool FIsDialogObject;
	System::Extended FLeft;
	System::Extended FTop;
	System::Extended FWidth;
	System::Extended FHeight;
	Fmx::Graphics::TBitmap* FImage;
	TfrxIEMObject* FParent;
	int FCounter;
	System::TObject* FLink;
	bool FRTL;
	System::UnicodeString FAnchor;
	bool FCached;
	bool FFooter;
	bool FHeader;
	System::UnicodeString FName;
	bool FHTMLTags;
	void __fastcall SetMemo(System::Widestrings::TWideStrings* const Value);
	Fmx::Graphics::TBitmap* __fastcall GetImage(void);
	void __fastcall SetImage(Fmx::Graphics::TBitmap* const Value);
	
public:
	__fastcall TfrxIEMObject(void);
	__fastcall virtual ~TfrxIEMObject(void);
	__property System::Widestrings::TWideStrings* Memo = {read=FMemo, write=SetMemo};
	__property System::UnicodeString URL = {read=FURL, write=FURL};
	__property int StyleIndex = {read=FStyleIndex, write=FStyleIndex, nodefault};
	__property bool IsText = {read=FIsText, write=FIsText, nodefault};
	__property bool IsRichText = {read=FIsRichText, write=FIsRichText, nodefault};
	__property bool IsDialogObject = {read=FIsDialogObject, write=FIsDialogObject, nodefault};
	__property System::Extended Left = {read=FLeft, write=FLeft};
	__property System::Extended Top = {read=FTop, write=FTop};
	__property System::Extended Width = {read=FWidth, write=FWidth};
	__property System::Extended Height = {read=FHeight, write=FHeight};
	__property Fmx::Graphics::TBitmap* Image = {read=GetImage, write=SetImage};
	__property TfrxIEMObject* Parent = {read=FParent, write=FParent};
	__property TfrxIEMStyle* Style = {read=FStyle, write=FStyle};
	__property int Counter = {read=FCounter, write=FCounter, nodefault};
	__property System::TObject* Link = {read=FLink, write=FLink};
	__property bool RTL = {read=FRTL, write=FRTL, nodefault};
	__property System::UnicodeString Anchor = {read=FAnchor, write=FAnchor};
	__property bool Cached = {read=FCached, write=FCached, nodefault};
	__property bool Footer = {read=FFooter, write=FFooter, nodefault};
	__property bool Header = {read=FHeader, write=FHeader, nodefault};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property bool HTMLTags = {read=FHTMLTags, write=FHTMLTags, nodefault};
};


class PASCALIMPLEMENTATION TfrxIEMObjectList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxIEMObject* Obj;
	int x;
	int y;
	int dx;
	int dy;
	bool Exist;
	__fastcall TfrxIEMObjectList(void);
	__fastcall virtual ~TfrxIEMObjectList(void);
};


class PASCALIMPLEMENTATION TfrxIEMPos : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Extended Value;
public:
	/* TObject.Create */ inline __fastcall TfrxIEMPos(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxIEMPos(void) { }
	
};


class PASCALIMPLEMENTATION TfrxIEMPage : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Extended Value;
	System::Uitypes::TPrinterOrientation Orientation;
	System::Extended Width;
	System::Extended Height;
	System::Extended LeftMargin;
	System::Extended TopMargin;
	System::Extended BottomMargin;
	System::Extended RightMargin;
	bool MirrorMargin;
	bool PrintOnPreviousPage;
	System::UnicodeString PageName;
public:
	/* TObject.Create */ inline __fastcall TfrxIEMPage(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxIEMPage(void) { }
	
};


class PASCALIMPLEMENTATION TfrxIEMStyle : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Fmx::Frxfmx::TfrxFont* Font;
	System::Extended LineSpacing;
	Fmx::Frxclass::TfrxVAlign VAlign;
	Fmx::Frxclass::TfrxHAlign HAlign;
	Fmx::Frxclass::TfrxFrameTypes FrameTyp;
	float FrameWidth;
	System::Uitypes::TColor FrameColor;
	Fmx::Frxclass::TfrxFrameStyle FrameStyle;
	System::Uitypes::TColor Color;
	int Rotation;
	Fmx::Graphics::TBrushKind BrushStyle;
	System::Extended ParagraphGap;
	System::Extended GapX;
	System::Extended GapY;
	System::Extended CharSpacing;
	bool WordBreak;
	int Charset;
	Fmx::Frxclass::TfrxFormat* FDisplayFormat;
	bool WordWrap;
	__fastcall TfrxIEMStyle(void);
	__fastcall virtual ~TfrxIEMStyle(void);
	void __fastcall Assign(TfrxIEMStyle* Style);
	void __fastcall SetDisplayFormat(Fmx::Frxclass::TfrxFormat* const Value);
	__property Fmx::Frxclass::TfrxFormat* DisplayFormat = {read=FDisplayFormat, write=SetDisplayFormat};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexportmatrix */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEXPORTMATRIX)
using namespace Fmx::Frxexportmatrix;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxexportmatrixHPP
