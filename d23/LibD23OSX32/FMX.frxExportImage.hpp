// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxExportImage.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxexportimageHPP
#define Fmx_FrxexportimageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <System.UIConsts.hpp>
#include <System.Variants.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Surfaces.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxexportimage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxCustomImageExport;
class DELPHICLASS TfrxBMPExport;
class DELPHICLASS TfrxTIFFExport;
class DELPHICLASS TfrxJPEGExport;
class DELPHICLASS TfrxGIFExport;
class DELPHICLASS TfrxPNGExport;
class DELPHICLASS TfrxIMGExportDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxCustomImageExport : public Fmx::Frxclass::TfrxCustomExportFilter
{
	typedef Fmx::Frxclass::TfrxCustomExportFilter inherited;
	
private:
	Fmx::Graphics::TBitmap* FBitmap;
	bool FCrop;
	int FCurrentPage;
	int FJPEGQuality;
	int FMaxX;
	int FMaxY;
	int FMinX;
	int FMinY;
	bool FMonochrome;
	int FResolution;
	int FCurrentRes;
	bool FSeparate;
	int FYOffset;
	System::UnicodeString FFileSuffix;
	bool FFirstPage;
	bool FExportNotPrintable;
	bool __fastcall SizeOverflow(const System::Extended Val);
	
protected:
	double FPaperWidth;
	double FPaperHeight;
	System::Extended FDiv;
	virtual void __fastcall Save(void);
	virtual void __fastcall FinishExport(void);
	
public:
	__fastcall virtual TfrxCustomImageExport(System::Classes::TComponent* AOwner);
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Fmx::Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Fmx::Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Fmx::Frxclass::TfrxComponent* Obj);
	__property int JPEGQuality = {read=FJPEGQuality, write=FJPEGQuality, default=90};
	__property bool CropImages = {read=FCrop, write=FCrop, default=0};
	__property bool Monochrome = {read=FMonochrome, write=FMonochrome, default=0};
	__property int Resolution = {read=FResolution, write=FResolution, nodefault};
	__property bool SeparateFiles = {read=FSeparate, write=FSeparate, nodefault};
	__property bool ExportNotPrintable = {read=FExportNotPrintable, write=FExportNotPrintable, nodefault};
	__property OverwritePrompt;
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxCustomImageExport(void) : Fmx::Frxclass::TfrxCustomExportFilter() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxCustomImageExport(void) { }
	
};


class PASCALIMPLEMENTATION TfrxBMPExport : public TfrxCustomImageExport
{
	typedef TfrxCustomImageExport inherited;
	
protected:
	virtual void __fastcall Save(void);
	
public:
	__fastcall virtual TfrxBMPExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property CropImages = {default=0};
	__property Monochrome = {default=0};
	__property OverwritePrompt;
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxBMPExport(void) : TfrxCustomImageExport() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxBMPExport(void) { }
	
};


class PASCALIMPLEMENTATION TfrxTIFFExport : public TfrxCustomImageExport
{
	typedef TfrxCustomImageExport inherited;
	
private:
	bool FMultiImage;
	
protected:
	virtual void __fastcall Save(void);
	
public:
	__fastcall virtual TfrxTIFFExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property CropImages = {default=0};
	__property Monochrome = {default=0};
	__property OverwritePrompt;
	__property bool MultiImage = {read=FMultiImage, write=FMultiImage, default=0};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxTIFFExport(void) : TfrxCustomImageExport() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxTIFFExport(void) { }
	
};


class PASCALIMPLEMENTATION TfrxJPEGExport : public TfrxCustomImageExport
{
	typedef TfrxCustomImageExport inherited;
	
protected:
	virtual void __fastcall Save(void);
	
public:
	__fastcall virtual TfrxJPEGExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property JPEGQuality = {default=90};
	__property CropImages = {default=0};
	__property Monochrome = {default=0};
	__property OverwritePrompt;
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxJPEGExport(void) : TfrxCustomImageExport() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxJPEGExport(void) { }
	
};


class PASCALIMPLEMENTATION TfrxGIFExport : public TfrxCustomImageExport
{
	typedef TfrxCustomImageExport inherited;
	
protected:
	virtual void __fastcall Save(void);
	
public:
	__fastcall virtual TfrxGIFExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property CropImages = {default=0};
	__property Monochrome = {default=0};
	__property OverwritePrompt;
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxGIFExport(void) : TfrxCustomImageExport() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxGIFExport(void) { }
	
};


class PASCALIMPLEMENTATION TfrxPNGExport : public TfrxCustomImageExport
{
	typedef TfrxCustomImageExport inherited;
	
protected:
	virtual void __fastcall Save(void);
	
public:
	__fastcall virtual TfrxPNGExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property CropImages = {default=0};
	__property Monochrome = {default=0};
	__property OverwritePrompt;
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxPNGExport(void) : TfrxCustomImageExport() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxPNGExport(void) { }
	
};


class PASCALIMPLEMENTATION TfrxIMGExportDialog : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OK;
	Fmx::Stdctrls::TButton* Cancel;
	Fmx::Stdctrls::TGroupBox* GroupPageRange;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Stdctrls::TCheckBox* CropPage;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Edit::TEdit* Quality;
	Fmx::Stdctrls::TCheckBox* Mono;
	Fmx::Dialogs::TSaveDialog* SaveDialog1;
	Fmx::Stdctrls::TLabel* DescrL;
	Fmx::Stdctrls::TRadioButton* AllRB;
	Fmx::Stdctrls::TRadioButton* CurPageRB;
	Fmx::Stdctrls::TRadioButton* PageNumbersRB;
	Fmx::Edit::TEdit* PageNumbersE;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Edit::TEdit* Resolution;
	Fmx::Stdctrls::TCheckBox* SeparateCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageNumbersEChange(System::TObject* Sender);
	void __fastcall PageNumbersEKeyPress(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	
private:
	TfrxCustomImageExport* FFilter;
	void __fastcall SetFilter(TfrxCustomImageExport* const Value);
	
public:
	__property TfrxCustomImageExport* Filter = {read=FFilter, write=SetFilter};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxIMGExportDialog(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxIMGExportDialog(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxIMGExportDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexportimage */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEXPORTIMAGE)
using namespace Fmx::Frxexportimage;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxexportimageHPP
