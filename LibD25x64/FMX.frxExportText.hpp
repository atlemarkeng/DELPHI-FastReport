// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxExportText.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxexporttextHPP
#define Fmx_FrxexporttextHPP

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
#include <FMX.frxExportMatrix.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <System.Variants.hpp>
#include <FMX.frxBaseModalForm.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxexporttext
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxSimpleTextExportDialog;
class DELPHICLASS TfrxSimpleTextExport;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxSimpleTextExportDialog : public Fmx::Frxbasemodalform::TfrxForm
{
	typedef Fmx::Frxbasemodalform::TfrxForm inherited;
	
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
	Fmx::Stdctrls::TCheckBox* PageBreaksCB;
	Fmx::Stdctrls::TCheckBox* OpenCB;
	Fmx::Stdctrls::TCheckBox* FramesCB;
	Fmx::Stdctrls::TCheckBox* EmptyLinesCB;
	Fmx::Stdctrls::TCheckBox* OEMCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageNumbersEChange(System::TObject* Sender);
	void __fastcall PageNumbersEKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxSimpleTextExportDialog(System::Classes::TComponent* AOwner) : Fmx::Frxbasemodalform::TfrxForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxSimpleTextExportDialog(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Frxbasemodalform::TfrxForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxSimpleTextExportDialog(void) { }
	
};


class PASCALIMPLEMENTATION TfrxSimpleTextExport : public Fmx::Frxclass::TfrxCustomExportFilter
{
	typedef Fmx::Frxclass::TfrxCustomExportFilter inherited;
	
private:
	bool FPageBreaks;
	Fmx::Frxexportmatrix::TfrxIEMatrix* FMatrix;
	bool FOpenAfterExport;
	System::Classes::TStream* Exp;
	Fmx::Frxclass::TfrxReportPage* FPage;
	bool FFrames;
	System::Extended pX;
	System::Extended pY;
	System::Extended pT;
	bool FEmptyLines;
	bool FOEM;
	bool FDeleteEmptyColumns;
	void __fastcall ExportPage(System::Classes::TStream* Stream);
	
public:
	__fastcall virtual TfrxSimpleTextExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Fmx::Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Fmx::Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Fmx::Frxclass::TfrxComponent* Obj);
	
__published:
	__property bool PageBreaks = {read=FPageBreaks, write=FPageBreaks, default=1};
	__property bool Frames = {read=FFrames, write=FFrames, nodefault};
	__property bool EmptyLines = {read=FEmptyLines, write=FEmptyLines, nodefault};
	__property bool OEMCodepage = {read=FOEM, write=FOEM, nodefault};
	__property bool OpenAfterExport = {read=FOpenAfterExport, write=FOpenAfterExport, default=0};
	__property OverwritePrompt;
	__property bool DeleteEmptyColumns = {read=FDeleteEmptyColumns, write=FDeleteEmptyColumns, nodefault};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxSimpleTextExport(void) : Fmx::Frxclass::TfrxCustomExportFilter() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxSimpleTextExport(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexporttext */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEXPORTTEXT)
using namespace Fmx::Frxexporttext;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxexporttextHPP
