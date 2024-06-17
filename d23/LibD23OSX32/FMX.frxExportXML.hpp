// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxExportXML.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxexportxmlHPP
#define Fmx_FrxexportxmlHPP

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

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxexportxml
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxXMLExportDialog;
class DELPHICLASS TfrxXMLExport;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxSplitToSheet : unsigned char { ssNotSplit, ssRPages, ssPrintOnPrev, ssRowsCount };

class PASCALIMPLEMENTATION TfrxXMLExportDialog : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Dialogs::TSaveDialog* SaveDialog1;
	Fmx::Stdctrls::TGroupBox* GroupPageRange;
	Fmx::Stdctrls::TLabel* DescrL;
	Fmx::Stdctrls::TRadioButton* AllRB;
	Fmx::Stdctrls::TRadioButton* CurPageRB;
	Fmx::Stdctrls::TRadioButton* PageNumbersRB;
	Fmx::Edit::TEdit* PageNumbersE;
	Fmx::Stdctrls::TGroupBox* GroupQuality;
	Fmx::Stdctrls::TCheckBox* WCB;
	Fmx::Stdctrls::TCheckBox* ContinuousCB;
	Fmx::Stdctrls::TCheckBox* PageBreaksCB;
	Fmx::Stdctrls::TCheckBox* OpenExcelCB;
	Fmx::Stdctrls::TCheckBox* BackgrCB;
	Fmx::Stdctrls::TGroupBox* SplitToSheetGB;
	Fmx::Stdctrls::TRadioButton* RPagesRB;
	Fmx::Stdctrls::TRadioButton* PrintOnPrevRB;
	Fmx::Stdctrls::TRadioButton* RowsCountRB;
	Fmx::Edit::TEdit* ERows;
	Fmx::Stdctrls::TRadioButton* NotSplitRB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageNumbersEChange(System::TObject* Sender);
	void __fastcall PageNumbersEKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall ERowsKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall ERowsChange(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxXMLExportDialog(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxXMLExportDialog(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxXMLExportDialog(void) { }
	
};


class PASCALIMPLEMENTATION TfrxXMLExport : public Fmx::Frxclass::TfrxCustomExportFilter
{
	typedef Fmx::Frxclass::TfrxCustomExportFilter inherited;
	
private:
	bool FExportPageBreaks;
	bool FExportStyles;
	bool FFirstPage;
	Fmx::Frxexportmatrix::TfrxIEMatrix* FMatrix;
	bool FOpenExcelAfterExport;
	System::Extended FPageBottom;
	System::Extended FPageLeft;
	System::Extended FPageRight;
	System::Extended FPageTop;
	System::Uitypes::TPrinterOrientation FPageOrientation;
	Fmx::Frxprogress::TfrxProgress* FProgress;
	bool FWysiwyg;
	bool FBackground;
	System::UnicodeString FCreator;
	bool FEmptyLines;
	int FRowsCount;
	TfrxSplitToSheet FSplit;
	void __fastcall ExportPage(System::Classes::TStream* Stream);
	System::UnicodeString __fastcall ChangeReturns(const System::UnicodeString Str);
	System::WideString __fastcall TruncReturns(const System::WideString Str);
	void __fastcall SetRowsCount(const int Value);
	
public:
	__fastcall virtual TfrxXMLExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Fmx::Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Fmx::Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Fmx::Frxclass::TfrxComponent* Obj);
	
__published:
	__property bool ExportStyles = {read=FExportStyles, write=FExportStyles, default=1};
	__property bool ExportPageBreaks = {read=FExportPageBreaks, write=FExportPageBreaks, default=1};
	__property bool OpenExcelAfterExport = {read=FOpenExcelAfterExport, write=FOpenExcelAfterExport, default=0};
	__property bool Wysiwyg = {read=FWysiwyg, write=FWysiwyg, default=1};
	__property bool Background = {read=FBackground, write=FBackground, default=0};
	__property System::UnicodeString Creator = {read=FCreator, write=FCreator};
	__property bool EmptyLines = {read=FEmptyLines, write=FEmptyLines, nodefault};
	__property SuppressPageHeadersFooters;
	__property OverwritePrompt;
	__property int RowsCount = {read=FRowsCount, write=SetRowsCount, nodefault};
	__property TfrxSplitToSheet Split = {read=FSplit, write=FSplit, nodefault};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxXMLExport(void) : Fmx::Frxclass::TfrxCustomExportFilter() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxXMLExport(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexportxml */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEXPORTXML)
using namespace Fmx::Frxexportxml;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxexportxmlHPP
