// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxExportHTML.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxexporthtmlHPP
#define Fmx_FrxexporthtmlHPP

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
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxExportMatrix.hpp>
#include <FMX.frxProgress.hpp>
#include <FMX.frxImageConverter.hpp>
#include <System.UIConsts.hpp>
#include <System.Variants.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxexporthtml
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxHTMLExportDialog;
class DELPHICLASS TfrxHTMLExport;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxHTMLExportDialog : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Dialogs::TSaveDialog* SaveDialog1;
	Fmx::Stdctrls::TGroupBox* GroupQuality;
	Fmx::Stdctrls::TCheckBox* StylesCB;
	Fmx::Stdctrls::TCheckBox* PicsSameCB;
	Fmx::Stdctrls::TCheckBox* FixWidthCB;
	Fmx::Stdctrls::TCheckBox* NavigatorCB;
	Fmx::Stdctrls::TCheckBox* MultipageCB;
	Fmx::Stdctrls::TGroupBox* GroupPageRange;
	Fmx::Stdctrls::TLabel* DescrL;
	Fmx::Stdctrls::TRadioButton* AllRB;
	Fmx::Stdctrls::TRadioButton* CurPageRB;
	Fmx::Stdctrls::TRadioButton* PageNumbersRB;
	Fmx::Edit::TEdit* PageNumbersE;
	Fmx::Stdctrls::TCheckBox* OpenAfterCB;
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TCheckBox* BackgrCB;
	Fmx::Stdctrls::TLabel* PicturesL;
	Fmx::Listbox::TComboBox* PFormatCB;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Listbox::TListBoxItem* ListBoxItem4;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageNumbersEChange(System::TObject* Sender);
	void __fastcall PageNumbersEKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxHTMLExportDialog(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxHTMLExportDialog(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxHTMLExportDialog(void) { }
	
};


typedef void __fastcall (__closure *TfrxHTMLExportGetNavTemplate)(const System::UnicodeString ReportName, bool Multipage, bool PicsInSameFolder, System::UnicodeString Prefix, int TotalPages, System::UnicodeString &Template);

typedef void __fastcall (__closure *TfrxHTMLExportGetMainTemplate)(const System::UnicodeString Title, const System::UnicodeString FrameFolder, bool Multipage, System::UnicodeString &Template);

class PASCALIMPLEMENTATION TfrxHTMLExport : public Fmx::Frxclass::TfrxCustomExportFilter
{
	typedef Fmx::Frxclass::TfrxCustomExportFilter inherited;
	
private:
	System::Classes::TStream* Exp;
	bool FAbsLinks;
	int FCurrentPage;
	bool FExportPictures;
	bool FExportStyles;
	bool FFixedWidth;
	Fmx::Frxexportmatrix::TfrxIEMatrix* FMatrix;
	bool FMozillaBrowser;
	bool FMultipage;
	bool FNavigator;
	bool FOpenAfterExport;
	bool FPicsInSameFolder;
	int FPicturesCount;
	Fmx::Frxprogress::TfrxProgress* FProgress;
	bool FServer;
	System::UnicodeString FPrintLink;
	System::UnicodeString FRefreshLink;
	bool FBackground;
	Fmx::Graphics::TBitmap* FBackImage;
	bool FBackImageExist;
	System::UnicodeString FReportPath;
	bool FCentered;
	bool FEmptyLines;
	System::UnicodeString FURLTarget;
	Fmx::Frximageconverter::TfrxPictureType FPictureType;
	bool FPrint;
	bool FUseTemplates;
	TfrxHTMLExportGetNavTemplate FGetNavTemplate;
	TfrxHTMLExportGetMainTemplate FGetMainTemplate;
	System::Classes::TStrings* FHTMLDocumentBegin;
	System::Classes::TStrings* FHTMLDocumentBody;
	System::Classes::TStrings* FHTMLDocumentEnd;
	void __fastcall WriteExpLn(const System::UnicodeString str);
	void __fastcall WriteExpLnA(const System::AnsiString str);
	void __fastcall ExportPage(void);
	System::UnicodeString __fastcall ChangeReturns(const System::UnicodeString Str);
	System::WideString __fastcall TruncReturns(const System::WideString Str);
	System::UnicodeString __fastcall GetPicsFolder(void);
	System::UnicodeString __fastcall GetPicsFolderRel(void);
	System::UnicodeString __fastcall GetFrameFolder(void);
	System::UnicodeString __fastcall ReverseSlash(const System::UnicodeString S);
	System::UnicodeString __fastcall HTMLCodeStr(const System::UnicodeString Str);
	
public:
	__fastcall virtual TfrxHTMLExport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxHTMLExport(void);
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Fmx::Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Fmx::Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Fmx::Frxclass::TfrxComponent* Obj);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property bool Server = {read=FServer, write=FServer, nodefault};
	__property System::UnicodeString PrintLink = {read=FPrintLink, write=FPrintLink};
	__property System::UnicodeString RefreshLink = {read=FRefreshLink, write=FRefreshLink};
	__property System::UnicodeString ReportPath = {read=FReportPath, write=FReportPath};
	__property bool UseTemplates = {read=FUseTemplates, write=FUseTemplates, nodefault};
	__property TfrxHTMLExportGetMainTemplate OnGetMainTemplate = {read=FGetMainTemplate, write=FGetMainTemplate};
	__property TfrxHTMLExportGetNavTemplate OnGetNavTemplate = {read=FGetNavTemplate, write=FGetNavTemplate};
	
__published:
	__property bool OpenAfterExport = {read=FOpenAfterExport, write=FOpenAfterExport, default=0};
	__property bool FixedWidth = {read=FFixedWidth, write=FFixedWidth, default=0};
	__property bool ExportPictures = {read=FExportPictures, write=FExportPictures, default=1};
	__property bool PicsInSameFolder = {read=FPicsInSameFolder, write=FPicsInSameFolder, default=0};
	__property bool ExportStyles = {read=FExportStyles, write=FExportStyles, default=1};
	__property bool Navigator = {read=FNavigator, write=FNavigator, default=0};
	__property bool Multipage = {read=FMultipage, write=FMultipage, default=0};
	__property bool MozillaFrames = {read=FMozillaBrowser, write=FMozillaBrowser, default=0};
	__property bool AbsLinks = {read=FAbsLinks, write=FAbsLinks, default=0};
	__property bool Background = {read=FBackground, write=FBackground, nodefault};
	__property bool Centered = {read=FCentered, write=FCentered, nodefault};
	__property bool EmptyLines = {read=FEmptyLines, write=FEmptyLines, nodefault};
	__property OverwritePrompt;
	__property System::Classes::TStrings* HTMLDocumentBegin = {read=FHTMLDocumentBegin};
	__property System::Classes::TStrings* HTMLDocumentBody = {read=FHTMLDocumentBody};
	__property System::Classes::TStrings* HTMLDocumentEnd = {read=FHTMLDocumentEnd};
	__property System::UnicodeString URLTarget = {read=FURLTarget, write=FURLTarget};
	__property bool Print = {read=FPrint, write=FPrint, nodefault};
	__property Fmx::Frximageconverter::TfrxPictureType PictureType = {read=FPictureType, write=FPictureType, nodefault};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxHTMLExport(void) : Fmx::Frxclass::TfrxCustomExportFilter() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexporthtml */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEXPORTHTML)
using namespace Fmx::Frxexporthtml;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxexporthtmlHPP
