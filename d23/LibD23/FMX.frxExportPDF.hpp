// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxExportPDF.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxexportpdfHPP
#define Fmx_FrxexportpdfHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Edit.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.Types.hpp>
#include <FMX.TabControl.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <FMX.frxImageConverter.hpp>
#include <FMX.Printer.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxRC4.hpp>
#include <FMX.Forms.hpp>
#include <System.UIConsts.hpp>
#include <FMX.frxChBox.hpp>
#include <Winapi.ShellAPI.hpp>
#include <System.WideStrings.hpp>
#include <System.AnsiStrings.hpp>
#include <FMX.frxTrueTypeFont.hpp>
#include <FMX.frxTrueTypeCollection.hpp>
#include <FMX.frxNameTableClass.hpp>
#include <System.Variants.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Surfaces.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxexportpdf
{
//-- forward type declarations -----------------------------------------------
struct SCRIPT_ANALYSIS;
struct SCRIPT_ITEM;
struct GOFFSET;
struct TRGBTriple;
struct TRGBAWord;
class DELPHICLASS TfrxPDFExportDialog;
class DELPHICLASS TfrxPDFRun;
struct TfrxPDFXObject;
class DELPHICLASS TfrxPDFFont;
class DELPHICLASS TfrxPDFOutlineNode;
class DELPHICLASS TfrxPDFPage;
class DELPHICLASS TfrxPDFAnnot;
class DELPHICLASS TfrxPDFExport;
//-- type declarations -------------------------------------------------------
typedef void * SCRIPT_CACHE;

typedef void * *PScriptCache;

struct DECLSPEC_DRECORD SCRIPT_ANALYSIS
{
public:
	System::Word fFlags;
	System::Word s;
};


typedef SCRIPT_ANALYSIS *PScriptAnalysis;

struct DECLSPEC_DRECORD SCRIPT_ITEM
{
public:
	int iCharPos;
	SCRIPT_ANALYSIS a;
};


typedef SCRIPT_ITEM *PScriptItem;

struct DECLSPEC_DRECORD GOFFSET
{
public:
	int du;
	int dv;
};


typedef GOFFSET *PGOffset;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TRGBTriple
{
public:
	System::Byte rgbtBlue;
	System::Byte rgbtGreen;
	System::Byte rgbtRed;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD TRGBAWord
{
public:
	System::Byte Blue;
	System::Byte Green;
	System::Byte Red;
	System::Byte Alpha;
};
#pragma pack(pop)


typedef System::StaticArray<TRGBAWord, 4096> TRGBAWordArray;

typedef TRGBAWordArray *PRGBAWord;

enum DECLSPEC_DENUM TfrxPDFEncBit : unsigned char { ePrint, eModify, eCopy, eAnnot };

typedef System::Set<TfrxPDFEncBit, TfrxPDFEncBit::ePrint, TfrxPDFEncBit::eAnnot> TfrxPDFEncBits;

class PASCALIMPLEMENTATION TfrxPDFExportDialog : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* PageControl1;
	Fmx::Tabcontrol::TTabItem* ExportPage;
	Fmx::Tabcontrol::TTabItem* InfoPage;
	Fmx::Tabcontrol::TTabItem* SecurityPage;
	Fmx::Tabcontrol::TTabItem* ViewerPage;
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Dialogs::TSaveDialog* SaveDialog1;
	Fmx::Stdctrls::TCheckBox* OpenCB;
	Fmx::Stdctrls::TGroupBox* GroupQuality;
	Fmx::Stdctrls::TCheckBox* CompressedCB;
	Fmx::Stdctrls::TCheckBox* EmbeddedCB;
	Fmx::Stdctrls::TCheckBox* PrintOptCB;
	Fmx::Stdctrls::TCheckBox* OutlineCB;
	Fmx::Stdctrls::TCheckBox* BackgrCB;
	Fmx::Stdctrls::TGroupBox* GroupPageRange;
	Fmx::Stdctrls::TLabel* DescrL;
	Fmx::Stdctrls::TRadioButton* AllRB;
	Fmx::Stdctrls::TRadioButton* CurPageRB;
	Fmx::Stdctrls::TRadioButton* PageNumbersRB;
	Fmx::Edit::TEdit* PageNumbersE;
	Fmx::Stdctrls::TGroupBox* SecGB;
	Fmx::Stdctrls::TLabel* OwnPassL;
	Fmx::Stdctrls::TLabel* UserPassL;
	Fmx::Edit::TEdit* OwnPassE;
	Fmx::Edit::TEdit* UserPassE;
	Fmx::Stdctrls::TGroupBox* PermGB;
	Fmx::Stdctrls::TCheckBox* PrintCB;
	Fmx::Stdctrls::TCheckBox* ModCB;
	Fmx::Stdctrls::TCheckBox* CopyCB;
	Fmx::Stdctrls::TCheckBox* AnnotCB;
	Fmx::Stdctrls::TGroupBox* DocInfoGB;
	Fmx::Stdctrls::TLabel* TitleL;
	Fmx::Edit::TEdit* TitleE;
	Fmx::Edit::TEdit* AuthorE;
	Fmx::Stdctrls::TLabel* AuthorL;
	Fmx::Stdctrls::TLabel* SubjectL;
	Fmx::Edit::TEdit* SubjectE;
	Fmx::Stdctrls::TLabel* KeywordsL;
	Fmx::Edit::TEdit* KeywordsE;
	Fmx::Edit::TEdit* CreatorE;
	Fmx::Stdctrls::TLabel* CreatorL;
	Fmx::Stdctrls::TLabel* ProducerL;
	Fmx::Edit::TEdit* ProducerE;
	Fmx::Stdctrls::TGroupBox* ViewerGB;
	Fmx::Stdctrls::TCheckBox* HideToolbarCB;
	Fmx::Stdctrls::TCheckBox* HideMenubarCB;
	Fmx::Stdctrls::TCheckBox* HideWindowUICB;
	Fmx::Stdctrls::TCheckBox* FitWindowCB;
	Fmx::Stdctrls::TCheckBox* CenterWindowCB;
	Fmx::Stdctrls::TCheckBox* PrintScalingCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageNumbersEChange(System::TObject* Sender);
	void __fastcall PageNumbersEKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxPDFExportDialog(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxPDFExportDialog(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxPDFExportDialog(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPDFRun : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	SCRIPT_ANALYSIS analysis;
	System::WideString text;
	__fastcall TfrxPDFRun(System::WideString t, SCRIPT_ANALYSIS a);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxPDFRun(void) { }
	
};

#pragma pack(pop)

typedef System::StaticArray<System::Byte, 16> TfrxPDFXObjectHash;

struct DECLSPEC_DRECORD TfrxPDFXObject
{
public:
	int ObjId;
	TfrxPDFXObjectHash Hash;
};


class PASCALIMPLEMENTATION TfrxPDFFont : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Fmx::Graphics::TBitmap* tempBitmap;
	Fmx::Frxtruetypecollection::TrueTypeCollection* TrueTypeTables;
	int __fastcall GetGlyphIndices(System::WideString text, System::PWord glyphs, System::PInteger widths, bool rtl);
	
public:
	int Index;
	System::Classes::TList* Widths;
	System::Classes::TList* UsedAlphabet;
	System::Classes::TList* UsedAlphabetUnicode;
	System::Classes::TList* FComposedList;
	_OUTLINETEXTMETRICW TextMetric;
	System::AnsiString Name;
	Fmx::Graphics::TFont* SourceFont;
	int Reference;
	bool Saved;
	bool PackFont;
	System::Classes::TMemoryStream* FontData;
	int FontDataSize;
	double PDFdpi_divider;
	double FDpiFX;
	__fastcall TfrxPDFFont(Fmx::Graphics::TFont* Font);
	__fastcall virtual ~TfrxPDFFont(void);
	void __fastcall Cleanup(void);
	void __fastcall FillOutlineTextMetrix(void);
	void __fastcall GetFontFile(void);
	void __fastcall PackFontFile(void);
	System::WideString __fastcall RemapString(System::WideString str, bool rtl);
	System::AnsiString __fastcall GetFontName(void);
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPDFOutlineNode : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int Number;
	int Dest;
	int Top;
	int CountTree;
	int Count;
	System::UnicodeString Title;
	TfrxPDFOutlineNode* First;
	TfrxPDFOutlineNode* Last;
	TfrxPDFOutlineNode* Next;
	TfrxPDFOutlineNode* Prev;
	TfrxPDFOutlineNode* Parent;
	__fastcall TfrxPDFOutlineNode(void);
	__fastcall virtual ~TfrxPDFOutlineNode(void);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxPDFPage : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	double Height;
public:
	/* TObject.Create */ inline __fastcall TfrxPDFPage(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxPDFPage(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPDFAnnot : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int Number;
	System::UnicodeString Rect;
	System::UnicodeString Hyperlink;
	int DestPage;
	int DestY;
public:
	/* TObject.Create */ inline __fastcall TfrxPDFAnnot(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxPDFAnnot(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxPDFExport : public Fmx::Frxclass::TfrxCustomExportFilter
{
	typedef Fmx::Frxclass::TfrxCustomExportFilter inherited;
	
	
private:
	typedef System::DynamicArray<TfrxPDFXObject> _TfrxPDFExport__1;
	
	typedef System::DynamicArray<int> _TfrxPDFExport__2;
	
	
private:
	bool FCompressed;
	bool FEmbedded;
	bool FEmbedProt;
	bool FOpenAfterExport;
	bool FPrintOpt;
	System::Classes::TList* FPages;
	bool FOutline;
	int FQuality;
	Fmx::Frxclass::TfrxCustomOutline* FPreviewOutline;
	System::WideString FSubject;
	System::WideString FAuthor;
	bool FBackground;
	System::WideString FCreator;
	bool FTags;
	bool FProtection;
	System::AnsiString FUserPassword;
	System::AnsiString FOwnerPassword;
	TfrxPDFEncBits FProtectionFlags;
	System::WideString FKeywords;
	System::WideString FTitle;
	System::WideString FProducer;
	bool FPrintScaling;
	bool FFitWindow;
	bool FHideMenubar;
	bool FCenterWindow;
	bool FHideWindowUI;
	bool FHideToolbar;
	System::Classes::TStream* pdf;
	int FRootNumber;
	int FPagesNumber;
	int FInfoNumber;
	int FStartXRef;
	System::Classes::TList* FFonts;
	System::Classes::TList* FPageFonts;
	System::Classes::TStringList* FXRef;
	System::Classes::TStringList* FPagesRef;
	System::Extended FWidth;
	System::Extended FHeight;
	System::Extended FMarginLeft;
	System::Extended FMarginWoBottom;
	System::Extended FMarginTop;
	System::AnsiString FEncKey;
	System::AnsiString FOPass;
	System::AnsiString FUPass;
	unsigned FEncBits;
	System::AnsiString FFileID;
	System::Extended FDivider;
	System::Uitypes::TAlphaColor FLastColor;
	System::UnicodeString FLastColorResult;
	System::Classes::TMemoryStream* OutStream;
	_TfrxPDFExport__1 FXObjects;
	_TfrxPDFExport__2 FUsedXObjects;
	unsigned FPicTotalSize;
	System::Classes::TMemoryStream* FPageAnnots;
	System::Classes::TList* FAnnots;
	System::UnicodeString __fastcall PrepXrefPos(int pos);
	void __fastcall Write(System::Classes::TStream* Stream, const System::AnsiString S)/* overload */;
	void __fastcall Write(System::Classes::TStream* Stream, const System::UnicodeString S)/* overload */;
	void __fastcall WriteLn(System::Classes::TStream* Stream, const System::AnsiString S)/* overload */;
	void __fastcall WriteLn(System::Classes::TStream* Stream, const System::UnicodeString S)/* overload */;
	System::AnsiString __fastcall GetID(void);
	System::AnsiString __fastcall CryptStr(System::AnsiString Source, System::AnsiString Key, bool Enc, int id);
	System::AnsiString __fastcall CryptStream(System::Classes::TStream* Source, System::Classes::TStream* Target, System::AnsiString Key, int id);
	System::AnsiString __fastcall PrepareString(const System::WideString Text, System::AnsiString Key, bool Enc, int id);
	System::AnsiString __fastcall EscapeSpecialChar(System::AnsiString TextStr);
	System::AnsiString __fastcall StrToUTF16(const System::WideString Value);
	System::AnsiString __fastcall StrToUTF16H(const System::WideString Value);
	System::AnsiString __fastcall PMD52Str(void * p);
	System::AnsiString __fastcall PadPassword(System::AnsiString Password);
	void __fastcall PrepareKeys(void);
	void __fastcall SetProtectionFlags(const TfrxPDFEncBits Value);
	void __fastcall Clear(void);
	void __fastcall WriteFont(TfrxPDFFont* pdfFont);
	void __fastcall AddObject(Fmx::Frxclass::TfrxView* const Obj);
	System::AnsiString __fastcall StrToHex(const System::WideString Value);
	TfrxPDFPage* __fastcall AddPage(Fmx::Frxclass::TfrxReportPage* Page);
	System::UnicodeString __fastcall ObjNumber(int FNumber);
	System::UnicodeString __fastcall ObjNumberRef(int FNumber);
	int __fastcall UpdateXRef(void);
	System::UnicodeString __fastcall GetPDFColor(const System::Uitypes::TAlphaColor Color);
	int __fastcall FindXObject(const TfrxPDFXObjectHash &Hash);
	int __fastcall AddXObject(int Id, const TfrxPDFXObjectHash &Hash);
	void __fastcall ClearXObject(void);
	void __fastcall GetStreamHash(/* out */ TfrxPDFXObjectHash &Hash, System::Classes::TStream* S);
	
public:
	__fastcall virtual TfrxPDFExport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxPDFExport(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall ExportObject(Fmx::Frxclass::TfrxComponent* Obj);
	virtual void __fastcall Finish(void);
	virtual void __fastcall StartPage(Fmx::Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall FinishPage(Fmx::Frxclass::TfrxReportPage* Page, int Index);
	
__published:
	__property bool Compressed = {read=FCompressed, write=FCompressed, default=1};
	__property bool EmbeddedFonts = {read=FEmbedded, write=FEmbedded, default=0};
	__property bool EmbedFontsIfProtected = {read=FEmbedProt, write=FEmbedProt, default=1};
	__property bool OpenAfterExport = {read=FOpenAfterExport, write=FOpenAfterExport, default=0};
	__property bool PrintOptimized = {read=FPrintOpt, write=FPrintOpt, nodefault};
	__property bool Outline = {read=FOutline, write=FOutline, nodefault};
	__property bool Background = {read=FBackground, write=FBackground, nodefault};
	__property bool HTMLTags = {read=FTags, write=FTags, nodefault};
	__property OverwritePrompt;
	__property int Quality = {read=FQuality, write=FQuality, nodefault};
	__property System::WideString Title = {read=FTitle, write=FTitle};
	__property System::WideString Author = {read=FAuthor, write=FAuthor};
	__property System::WideString Subject = {read=FSubject, write=FSubject};
	__property System::WideString Keywords = {read=FKeywords, write=FKeywords};
	__property System::WideString Creator = {read=FCreator, write=FCreator};
	__property System::WideString Producer = {read=FProducer, write=FProducer};
	__property System::AnsiString UserPassword = {read=FUserPassword, write=FUserPassword};
	__property System::AnsiString OwnerPassword = {read=FOwnerPassword, write=FOwnerPassword};
	__property TfrxPDFEncBits ProtectionFlags = {read=FProtectionFlags, write=SetProtectionFlags, nodefault};
	__property bool HideToolbar = {read=FHideToolbar, write=FHideToolbar, nodefault};
	__property bool HideMenubar = {read=FHideMenubar, write=FHideMenubar, nodefault};
	__property bool HideWindowUI = {read=FHideWindowUI, write=FHideWindowUI, nodefault};
	__property bool FitWindow = {read=FFitWindow, write=FFitWindow, nodefault};
	__property bool CenterWindow = {read=FCenterWindow, write=FCenterWindow, nodefault};
	__property bool PrintScaling = {read=FPrintScaling, write=FPrintScaling, nodefault};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxPDFExport(void) : Fmx::Frxclass::TfrxCustomExportFilter() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Classes::TStringList* frxPDFFontsNeedStyleSimulation;
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfSetLineColor(System::Uitypes::TAlphaColor Color);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfSetLineWidth(double Width);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfFillRect(double Left, double Bottom, double Right, double Top, System::Uitypes::TAlphaColor Color);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfSetColor(System::Uitypes::TAlphaColor Color);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfFill(void);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfPoint(double x, double y);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfLine(double x, double y);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfMove(double x, double y);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfColor(System::Uitypes::TAlphaColor Color);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfString(const System::WideString Str);
}	/* namespace Frxexportpdf */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEXPORTPDF)
using namespace Fmx::Frxexportpdf;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxexportpdfHPP
