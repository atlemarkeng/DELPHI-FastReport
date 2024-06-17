// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxGraphicUtils.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxgraphicutilsHPP
#define Fmx_FrxgraphicutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <System.StrUtils.hpp>
#include <System.WideStrings.hpp>
#include <System.Types.hpp>
#include <System.Variants.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Math.hpp>
#include <FMX.Types.hpp>
#include <FMX.Forms.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.Graphics.hpp>
#include <System.Math.Vectors.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxgraphicutils
{
//-- forward type declarations -----------------------------------------------
struct TStyleDescriptor;
class DELPHICLASS TfrxHTMLTag;
class DELPHICLASS TfrxHTMLTags;
class DELPHICLASS TfrxHTMLTagsList;
class DELPHICLASS TAdvancedTextRenderer;
class DELPHICLASS TParagraph;
class DELPHICLASS TLine;
class DELPHICLASS TWord;
class DELPHICLASS TTab;
class DELPHICLASS TRun;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TBaseLine : unsigned char { Normal, Subscript, Superscript };

struct DECLSPEC_DRECORD TStyleDescriptor
{
public:
	System::Uitypes::TFontStyles FontStyle;
	System::Uitypes::TAlphaColor Color;
	TBaseLine BaseLine;
};


enum DECLSPEC_DENUM TSubStyle : unsigned char { ssNormal, ssSubscript, ssSuperscript };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxHTMLTag : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int Position;
	int Size;
	int AddY;
	System::Uitypes::TFontStyles Style;
	System::Uitypes::TAlphaColor Color;
	bool Default;
	bool Small;
	bool DontWRAP;
	TSubStyle SubType;
	void __fastcall Assign(TfrxHTMLTag* Tag);
public:
	/* TObject.Create */ inline __fastcall TfrxHTMLTag(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxHTMLTag(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxHTMLTags : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxHTMLTag* operator[](int Index) { return Items[Index]; }
	
private:
	System::Classes::TList* FItems;
	void __fastcall Add(TfrxHTMLTag* Tag);
	TfrxHTMLTag* __fastcall GetItems(int Index);
	
public:
	__fastcall TfrxHTMLTags(void);
	__fastcall virtual ~TfrxHTMLTags(void);
	void __fastcall Clear(void);
	int __fastcall Count(void);
	__property TfrxHTMLTag* Items[int Index] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxHTMLTagsList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxHTMLTags* operator[](int Index) { return Items[Index]; }
	
private:
	bool FAllowTags;
	int FAddY;
	int FColor;
	int FDefColor;
	int FDefSize;
	System::Uitypes::TFontStyles FDefStyle;
	System::Classes::TList* FItems;
	int FPosition;
	int FSize;
	System::Uitypes::TFontStyles FStyle;
	bool FDontWRAP;
	TSubStyle FSubStyle;
	void __fastcall NewLine(void);
	void __fastcall Wrap(int TagsCount, bool AddBreak);
	TfrxHTMLTag* __fastcall Add(void);
	TfrxHTMLTags* __fastcall GetItems(int Index);
	TfrxHTMLTag* __fastcall GetPrevTag(void);
	
public:
	__fastcall TfrxHTMLTagsList(void);
	__fastcall virtual ~TfrxHTMLTagsList(void);
	void __fastcall Clear(void);
	void __fastcall SetDefaults(System::Uitypes::TColor DefColor, int DefSize, System::Uitypes::TFontStyles DefStyle);
	void __fastcall ExpandHTMLTags(System::WideString &s);
	int __fastcall Count(void);
	__property bool AllowTags = {read=FAllowTags, write=FAllowTags, nodefault};
	__property TfrxHTMLTags* Items[int Index] = {read=GetItems/*, default*/};
	__property int Position = {read=FPosition, write=FPosition, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TAdvancedTextRenderer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Generics::Collections::TList__1<TParagraph*>* FParagraphs;
	System::UnicodeString FText;
	Fmx::Graphics::TCanvas* FCanvas;
	Fmx::Frxfmx::TfrxFont* FFont;
	System::Types::TRectF FDisplayRect;
	Fmx::Frxclass::TfrxHAlign FHorzAlign;
	Fmx::Frxclass::TfrxVAlign FVertAlign;
	float FLineHeight;
	float FFontLineHeight;
	int FAngle;
	bool FForceJustify;
	bool FWysiwyg;
	bool FHtmlTags;
	bool FWordWrap;
	bool FRightToLeft;
	bool FPDFMode;
	float FSpaceWidth;
	void __fastcall SplitToParagraphs(const System::UnicodeString text);
	void __fastcall AdjustParagraphLines(void);
	
public:
	__fastcall TAdvancedTextRenderer(Fmx::Graphics::TCanvas* aCanvas, const System::UnicodeString aText, Fmx::Frxfmx::TfrxFont* aFont, const System::Types::TRectF &rect, Fmx::Frxclass::TfrxHAlign aHorzAlign, Fmx::Frxclass::TfrxVAlign aVertAlign, float aLineHeight, int aAngle, bool aWordWrap, bool aForceJustify, bool aHtmlTags, bool aPdfMode);
	__fastcall virtual ~TAdvancedTextRenderer(void);
	float __fastcall CalcWidth(void);
	float __fastcall MeasureTextWidth(const System::UnicodeString aText);
	float __fastcall CalcHeight(void)/* overload */;
	float __fastcall CalcHeight(int &charsFit, TStyleDescriptor &style)/* overload */;
	float __fastcall GetTabPosition(float pos);
	void __fastcall Draw(void);
	__property System::Generics::Collections::TList__1<TParagraph*>* Paragraphs = {read=FParagraphs};
	__property Fmx::Graphics::TCanvas* Canvas = {read=FCanvas};
	__property Fmx::Frxfmx::TfrxFont* Font = {read=FFont};
	__property System::Types::TRectF DisplayRect = {read=FDisplayRect};
	__property Fmx::Frxclass::TfrxHAlign HorzAlign = {read=FHorzAlign, nodefault};
	__property Fmx::Frxclass::TfrxVAlign VertAlign = {read=FVertAlign, nodefault};
	__property float LineHeight = {read=FLineHeight};
	__property float FontLineHeight = {read=FFontLineHeight};
	__property int Angle = {read=FAngle, nodefault};
	__property bool ForceJustify = {read=FForceJustify, nodefault};
	__property bool Wysiwyg = {read=FWysiwyg, nodefault};
	__property bool HtmlTags = {read=FHtmlTags, nodefault};
	__property bool WordWrap = {read=FWordWrap, nodefault};
	__property bool RightToLeft = {read=FRightToLeft, nodefault};
	__property bool PDFMode = {read=FPDFMode, nodefault};
	__property float SpaceWidth = {read=FSpaceWidth};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TParagraph : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Generics::Collections::TList__1<TLine*>* FLines;
	TAdvancedTextRenderer* FRenderer;
	System::UnicodeString FText;
	int FOriginalCharIndex;
	
public:
	__fastcall TParagraph(const System::UnicodeString text, TAdvancedTextRenderer* renderer, int originalCharIndex);
	__fastcall virtual ~TParagraph(void);
	bool __fastcall IsLast(void);
	bool __fastcall IsEmpty(void);
	TStyleDescriptor __fastcall WrapLines(const TStyleDescriptor &style);
	void __fastcall AlignLines(bool forceJustify);
	void __fastcall Draw(void);
	__property System::Generics::Collections::TList__1<TLine*>* Lines = {read=FLines};
	__property TAdvancedTextRenderer* Renderer = {read=FRenderer};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLine : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Generics::Collections::TList__1<TWord*>* FWords;
	TParagraph* FParagraph;
	float FTop;
	float FWidth;
	int FOriginalCharIndex;
	System::Generics::Collections::TList__1<System::Types::TRectF>* FUnderlines;
	System::Generics::Collections::TList__1<System::Types::TRectF>* FStrikeouts;
	TStyleDescriptor __fastcall GetStyle(void);
	TAdvancedTextRenderer* __fastcall GetRenderer(void);
	float __fastcall GetLeft(void);
	void __fastcall PrepareUnderlines(System::Generics::Collections::TList__1<System::Types::TRectF>* list, System::Uitypes::TFontStyle style);
	
public:
	__fastcall TLine(TParagraph* paragraph, int originalCharIndex);
	__fastcall virtual ~TLine(void);
	bool __fastcall IsLast(void);
	void __fastcall AlignWords(Fmx::Frxclass::TfrxHAlign align);
	void __fastcall MakeUnderlines(void);
	void __fastcall Draw(void);
	__property System::Generics::Collections::TList__1<TWord*>* Words = {read=FWords};
	__property float Left = {read=GetLeft};
	__property float Top = {read=FTop, write=FTop};
	__property float Width = {read=FWidth};
	__property int OriginalCharIndex = {read=FOriginalCharIndex, nodefault};
	__property TAdvancedTextRenderer* Renderer = {read=GetRenderer};
	__property TStyleDescriptor Style = {read=GetStyle};
	__property System::Generics::Collections::TList__1<System::Types::TRectF>* Underlines = {read=FUnderlines};
	__property System::Generics::Collections::TList__1<System::Types::TRectF>* Strikeouts = {read=FStrikeouts};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWord : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Generics::Collections::TList__1<TRun*>* FRuns;
	float FLeft;
	float FWidth;
	TLine* FLine;
	float __fastcall GetWidth(void);
	float __fastcall GetTop(void);
	TAdvancedTextRenderer* __fastcall GetRenderer(void);
	
public:
	__fastcall TWord(TLine* aLine);
	__fastcall virtual ~TWord(void);
	void __fastcall AdjustRuns(void);
	void __fastcall SetLine(TLine* aLine);
	void __fastcall Draw(void);
	__property float Left = {read=FLeft, write=FLeft};
	__property float Width = {read=GetWidth};
	__property float Top = {read=GetTop};
	__property TAdvancedTextRenderer* Renderer = {read=GetRenderer};
	__property System::Generics::Collections::TList__1<TRun*>* Runs = {read=FRuns};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTab : public TWord
{
	typedef TWord inherited;
	
public:
	/* TWord.Create */ inline __fastcall TTab(TLine* aLine) : TWord(aLine) { }
	/* TWord.Destroy */ inline __fastcall virtual ~TTab(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TRun : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FText;
	TStyleDescriptor FStyle;
	TWord* FWord;
	float FLeft;
	float FWidth;
	TAdvancedTextRenderer* __fastcall GetRenderer(void);
	float __fastcall GetTop(void);
	Fmx::Frxfmx::TfrxFont* __fastcall GetFont(bool disableUnderlinesStrikeouts)/* overload */;
	
public:
	__fastcall TRun(const System::UnicodeString aText, const TStyleDescriptor &aStyle, TWord* aWord);
	Fmx::Frxfmx::TfrxFont* __fastcall GetFont(void)/* overload */;
	void __fastcall Draw(void);
	__property System::UnicodeString Text = {read=FText};
	__property TStyleDescriptor Style = {read=FStyle};
	__property TAdvancedTextRenderer* Renderer = {read=GetRenderer};
	__property float Left = {read=FLeft, write=FLeft};
	__property float Top = {read=GetTop};
	__property float Width = {read=FWidth};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TRun(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxgraphicutils */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXGRAPHICUTILS)
using namespace Fmx::Frxgraphicutils;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxgraphicutilsHPP
