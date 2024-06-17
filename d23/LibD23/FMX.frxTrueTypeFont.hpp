// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxTrueTypeFont.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxtruetypefontHPP
#define Fmx_FrxtruetypefontHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMX.TTFHelpers.hpp>
#include <FMX.frxCmapTableClass.hpp>
#include <FMX.frxFontHeaderClass.hpp>
#include <FMX.frxGlyphTableClass.hpp>
#include <FMX.frxGlyphSubstitutionClass.hpp>
#include <FMX.frxHorizontalHeaderClass.hpp>
#include <FMX.frxHorizontalMetrixClass.hpp>
#include <FMX.frxIndexToLocationClass.hpp>
#include <FMX.frxKerningTableClass.hpp>
#include <FMX.frxNameTableClass.hpp>
#include <FMX.frxPostScriptClass.hpp>
#include <FMX.frxMaximumProfileClass.hpp>
#include <FMX.frxOS2WindowsMetricsClass.hpp>
#include <System.Classes.hpp>
#include <FMX.frxTrueTypeTable.hpp>
#include <FMX.frxPreProgramClass.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <System.Generics.Collections.hpp>
#include <System.SysUtils.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxtruetypefont
{
//-- forward type declarations -----------------------------------------------
struct TPanose;
struct TableDirectory;
class DELPHICLASS TrueTypeFont;
//-- type declarations -------------------------------------------------------
typedef _ABC TABC;

struct DECLSPEC_DRECORD TPanose
{
public:
	System::Byte bFamilyType;
	System::Byte bSerifStyle;
	System::Byte bWeight;
	System::Byte bProportion;
	System::Byte bContrast;
	System::Byte bStrokeVariation;
	System::Byte bArmStyle;
	System::Byte bLetterform;
	System::Byte bMidline;
	System::Byte bXHeight;
};


typedef tagTEXTMETRICA *PTextMetricA;

typedef tagTEXTMETRICW *PTextMetricW;

typedef PTextMetricW PTextMetric;

typedef tagTEXTMETRICA TTextMetricA;

typedef tagTEXTMETRICW TTextMetricW;

typedef tagTEXTMETRICW TTextMetric;

typedef _OUTLINETEXTMETRICA *POutlineTextmetricA;

typedef _OUTLINETEXTMETRICW *POutlineTextmetricW;

typedef POutlineTextmetricW POutlineTextmetric;

typedef _OUTLINETEXTMETRICA TOutlineTextmetricA;

typedef _OUTLINETEXTMETRICW TOutlineTextmetricW;

typedef _OUTLINETEXTMETRICW TOutlineTextmetric;

enum DECLSPEC_DENUM ChecksumFaultAction : unsigned char { IgnoreChecksum, ThrowException, Warn };

enum DECLSPEC_DENUM TablesID : unsigned int { CMAP = 1885433187, ControlValueTable = 544503395, DigitalSignature = 1195987780, EmbedBitmapLocation = 1129071173, EmbededBitmapData = 1413759557, FontHeader = 1684104552, FontProgram = 1835495526, Glyph = 1719233639, GlyphDefinition = 1178944583, GlyphPosition = 1397706823, GlyphSubstitution = 1112888135, GridFittingAndScanConversion = 1886609767, HorizontakDeviceMetrix = 2020435048, HorizontalHeader = 1634035816, HorizontalMetrix = 2020896104, IndexToLocation = 1633906540, Justification = 1179931466, KerningTable = 1852990827, LinearThreshold = 1213420620, MaximumProfile = 1886937453, Name = 1701667182, OS2Table = 841962319, PCL5Table = 1414284112, Postscript = 1953722224, PreProgram = 1885696624, 
	VerticalDeviceMetrix = 1481458774, VerticalMetrix = 2020896118, VertivalMetrixHeader = 1634035830 };

typedef System::DynamicArray<System::Byte> TByteArray;

typedef System::Classes::TList TTagList;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TableDirectory
{
public:
	unsigned sfntversion;
	System::Word numTables;
	System::Word searchRange;
	System::Word entrySelector;
	System::Word rangeShift;
};
#pragma pack(pop)


#pragma pack(push,4)
class PASCALIMPLEMENTATION TrueTypeFont : public Fmx::Ttfhelpers::TTF_Helpers
{
	typedef Fmx::Ttfhelpers::TTF_Helpers inherited;
	
private:
	bool FIsLoaded;
	void *beginfile_ptr;
	
public:
	ChecksumFaultAction checksum_action;
	
private:
	Fmx::Frxcmaptableclass::CmapTableClass* cmap_table;
	TableDirectory dir;
	Fmx::Frxfontheaderclass::FontHeaderClass* font_header;
	Fmx::Frxglyphtableclass::GlyphTableClass* glyph_table;
	Fmx::Frxglyphsubstitutionclass::GlyphSubstitutionClass* gsub_table;
	Fmx::Frxhorizontalheaderclass::HorizontalHeaderClass* horizontal_header;
	Fmx::Frxhorizontalmetrixclass::HorizontalMetrixClass* horizontal_metrix_table;
	Fmx::Frxindextolocationclass::IndexToLocationClass* index_to_location;
	Fmx::Frxkerningtableclass::KerningTableClass* kerning_table;
	Fmx::Frxnametableclass::NameTableClass* name_table;
	Fmx::Frxpostscriptclass::PostScriptClass* postscript;
	Fmx::Frxmaximumprofileclass::MaximumProfileClass* profile;
	void *selector_ptr;
	Fmx::Frxos2windowsmetricsclass::OS2WindowsMetricsClass* windows_metrix;
	Fmx::Frxpreprogramclass::PreProgramClass* preprogram_table;
	System::Generics::Collections::TDictionary__2<TablesID,Fmx::Frxtruetypetable::TrueTypeTable*>* ListOfTables;
	System::Classes::TList* ListOfUsedGlyphs;
	
public:
	__fastcall TrueTypeFont(void * bgn, void * font, ChecksumFaultAction action);
	void __fastcall AddCharacterToKeepList(System::WideChar ch);
	
private:
	void __fastcall BuildGlyphIndexList(System::Classes::TList* used_glyphs, bool uniscribe, bool decompose, bool collate, bool use_kerning, System::Classes::TList* &Indices, System::Classes::TList* &GlyphWidths, System::Classes::TList* ComposedList);
	unsigned __fastcall CalcTableChecksum(void * font, Fmx::Frxtruetypetable::TrueTypeTable* entry, bool debug);
	void __fastcall CalculateFontChecksum(void * start_offset, unsigned font_length);
	void __fastcall ChangeEndian(void);
	void __fastcall CheckTablesChecksum(void);
	
public:
	int __fastcall GetGlyphIndices(System::UnicodeString text, System::PWord glyphs, System::PInteger widths, bool rtl, System::Classes::TList* ComposedList);
	void __fastcall GetOutlineTextMetrics(_OUTLINETEXTMETRICW &FTextMetric);
	
private:
	System::Classes::TList* __fastcall GetTablesOrder(void);
	void __fastcall LoadCoreTables(void);
	void __fastcall LoadDescriptors(System::Classes::TList* skip_array);
	
public:
	TByteArray __fastcall PackFont(Fmx::Frxfontheaderclass::FontType translate_to, bool uniscribe, System::Classes::TStream* sStream);
	void __fastcall PrepareFont(System::Classes::TList* skip_list);
	
private:
	void __fastcall ReorderGlyphTable(void * position, bool uniscribe);
	void __fastcall SaveDescriptors(void * position);
	void __fastcall set_UsedGlyphs(System::Classes::TList* dict);
	
public:
	__property Fmx::Frxnametableclass::NameTableClass* Names = {read=name_table};
	__property bool IsLoaded = {read=FIsLoaded, nodefault};
	__property System::Classes::TList* UsedGlyphs = {write=set_UsedGlyphs};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TrueTypeFont(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxtruetypefont */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXTRUETYPEFONT)
using namespace Fmx::Frxtruetypefont;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxtruetypefontHPP
