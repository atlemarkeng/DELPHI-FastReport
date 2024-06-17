// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxExportRTF.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxexportrtfHPP
#define Fmx_FrxexportrtfHPP

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
#include <FMX.frxGraphicUtils.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxexportrtf
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxRTFExportDialog;
class DELPHICLASS TfrxRTFExport;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxHeaderFooterMode : unsigned char { hfText, hfPrint, hfNone };

class PASCALIMPLEMENTATION TfrxRTFExportDialog : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TGroupBox* GroupPageRange;
	Fmx::Stdctrls::TLabel* DescrL;
	Fmx::Stdctrls::TRadioButton* AllRB;
	Fmx::Stdctrls::TRadioButton* CurPageRB;
	Fmx::Stdctrls::TRadioButton* PageNumbersRB;
	Fmx::Edit::TEdit* PageNumbersE;
	Fmx::Stdctrls::TGroupBox* GroupQuality;
	Fmx::Stdctrls::TCheckBox* WCB;
	Fmx::Stdctrls::TCheckBox* PageBreaksCB;
	Fmx::Stdctrls::TCheckBox* PicturesCB;
	Fmx::Stdctrls::TCheckBox* OpenCB;
	Fmx::Dialogs::TSaveDialog* SaveDialog1;
	Fmx::Stdctrls::TCheckBox* ContinuousCB;
	Fmx::Stdctrls::TLabel* HeadFootL;
	Fmx::Listbox::TComboBox* PColontitulCB;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageNumbersEChange(System::TObject* Sender);
	void __fastcall PageNumbersEKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxRTFExportDialog(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxRTFExportDialog(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxRTFExportDialog(void) { }
	
};


class PASCALIMPLEMENTATION TfrxRTFExport : public Fmx::Frxclass::TfrxCustomExportFilter
{
	typedef Fmx::Frxclass::TfrxCustomExportFilter inherited;
	
private:
	System::Classes::TStringList* FColorTable;
	int FCurrentPage;
	System::Classes::TList* FDataList;
	bool FExportPageBreaks;
	bool FExportPictures;
	bool FFirstPage;
	System::Classes::TStringList* FFontTable;
	System::Classes::TStringList* FCharsetTable;
	Fmx::Frxexportmatrix::TfrxIEMatrix* FMatrix;
	bool FOpenAfterExport;
	Fmx::Frxprogress::TfrxProgress* FProgress;
	bool FWysiwyg;
	System::UnicodeString FCreator;
	TfrxHeaderFooterMode FHeaderFooterMode;
	bool FAutoSize;
	Fmx::Frximageconverter::TfrxPictureType FPictureType;
	System::WideString __fastcall TruncReturns(const System::WideString Str);
	System::UnicodeString __fastcall GetRTFBorders(Fmx::Frxexportmatrix::TfrxIEMStyle* const Style);
	System::UnicodeString __fastcall GetRTFColor(const System::Uitypes::TAlphaColor c);
	System::UnicodeString __fastcall GetRTFFontStyle(const System::Uitypes::TFontStyles f);
	System::UnicodeString __fastcall GetRTFFontColor(const System::UnicodeString f);
	System::UnicodeString __fastcall GetRTFFontName(const System::UnicodeString f, const int charset);
	System::UnicodeString __fastcall GetRTFHAlignment(const Fmx::Frxclass::TfrxHAlign HAlign);
	System::UnicodeString __fastcall GetRTFVAlignment(const Fmx::Frxclass::TfrxVAlign VAlign);
	System::WideString __fastcall StrToRTFSlash(const System::WideString Value);
	System::UnicodeString __fastcall StrToRTFUnicodeEx(const System::WideString Value);
	System::UnicodeString __fastcall StrToRTFUnicode(const System::WideString Value);
	void __fastcall ExportPage(System::Classes::TStream* const Stream);
	void __fastcall PrepareExport(void);
	void __fastcall SaveGraphic(Fmx::Graphics::TBitmap* Graphic, System::Classes::TStream* Stream, System::Extended Width, System::Extended Height, Fmx::Frximageconverter::TfrxPictureType PicType);
	
public:
	__fastcall virtual TfrxRTFExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Fmx::Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Fmx::Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Fmx::Frxclass::TfrxComponent* Obj);
	
__published:
	__property Fmx::Frximageconverter::TfrxPictureType PictureType = {read=FPictureType, write=FPictureType, nodefault};
	__property bool ExportPageBreaks = {read=FExportPageBreaks, write=FExportPageBreaks, default=1};
	__property bool ExportPictures = {read=FExportPictures, write=FExportPictures, default=1};
	__property bool OpenAfterExport = {read=FOpenAfterExport, write=FOpenAfterExport, default=0};
	__property bool Wysiwyg = {read=FWysiwyg, write=FWysiwyg, nodefault};
	__property System::UnicodeString Creator = {read=FCreator, write=FCreator};
	__property SuppressPageHeadersFooters;
	__property TfrxHeaderFooterMode HeaderFooterMode = {read=FHeaderFooterMode, write=FHeaderFooterMode, nodefault};
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, nodefault};
	__property OverwritePrompt;
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxRTFExport(void) : Fmx::Frxclass::TfrxCustomExportFilter() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxRTFExport(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexportrtf */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEXPORTRTF)
using namespace Fmx::Frxexportrtf;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxexportrtfHPP
