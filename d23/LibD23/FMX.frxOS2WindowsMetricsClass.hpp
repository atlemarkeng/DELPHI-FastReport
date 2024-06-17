// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxOS2WindowsMetricsClass.pas' rev: 30.00 (Windows)

#ifndef Fmx_Frxos2windowsmetricsclassHPP
#define Fmx_Frxos2windowsmetricsclassHPP

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
namespace Frxos2windowsmetricsclass
{
//-- forward type declarations -----------------------------------------------
struct OS2WindowsMetrics;
class DELPHICLASS OS2WindowsMetricsClass;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::Byte, 4> TVendorID;

typedef System::StaticArray<System::Byte, 10> TPanose;

#pragma pack(push,1)
struct DECLSPEC_DRECORD OS2WindowsMetrics
{
public:
	System::Word Version;
	short xAvgCharWidth;
	System::Word usWeightClass;
	System::Word usWidthClass;
	System::Word fsType;
	short ySubscriptXSize;
	short ySubscriptYSize;
	short ySubscriptXOffset;
	short ySubscriptYOffset;
	short ySuperscriptXSize;
	short ySuperscriptYSize;
	short ySuperscriptXOffset;
	short ySuperscriptYOffset;
	short yStrikeoutSize;
	short yStrikeoutPosition;
	short sFamilyClass;
	TPanose panose;
	unsigned ulUnicodeRange1;
	unsigned ulUnicodeRange2;
	unsigned ulUnicodeRange3;
	unsigned ulUnicodeRange4;
	TVendorID achVendID;
	System::Word fsSelection;
	System::Word usFirstCharIndex;
	System::Word usLastCharIndex;
	short sTypoAscender;
	short sTypoDescender;
	short sTypoLineGap;
	System::Word usWinAscent;
	System::Word usWinDescent;
	unsigned ulCodePageRange1;
	unsigned ulCodePageRange2;
	short sxHeight;
	short sCapHeight;
	System::Word usDefaultChar;
	System::Word usBreakChar;
	System::Word usMaxContext;
};
#pragma pack(pop)


#pragma pack(push,4)
class PASCALIMPLEMENTATION OS2WindowsMetricsClass : public Fmx::Frxtruetypetable::TrueTypeTable
{
	typedef Fmx::Frxtruetypetable::TrueTypeTable inherited;
	
private:
	OS2WindowsMetrics win_metrix;
	
public:
	__fastcall OS2WindowsMetricsClass(Fmx::Frxtruetypetable::TrueTypeTable* src);
	
private:
	HIDESBASE void __fastcall ChangeEndian(void);
	
public:
	virtual void __fastcall Load(void * font);
	virtual unsigned __fastcall Save(void * font, unsigned offset);
	__property System::Word Ascent = {read=win_metrix.usWinAscent, nodefault};
	__property short AvgCharWidth = {read=win_metrix.xAvgCharWidth, nodefault};
	__property System::Word BreakChar = {read=win_metrix.usBreakChar, nodefault};
	__property System::Word DefaultChar = {read=win_metrix.usDefaultChar, nodefault};
	__property System::Word Descent = {read=win_metrix.usWinDescent, nodefault};
	__property System::Word FirstCharIndex = {read=win_metrix.usFirstCharIndex, nodefault};
	__property System::Word LastCharIndex = {read=win_metrix.usLastCharIndex, nodefault};
	__property TPanose Panose = {read=win_metrix.panose};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~OS2WindowsMetricsClass(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxos2windowsmetricsclass */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXOS2WINDOWSMETRICSCLASS)
using namespace Fmx::Frxos2windowsmetricsclass;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_Frxos2windowsmetricsclassHPP
