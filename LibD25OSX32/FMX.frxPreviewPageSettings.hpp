// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxPreviewPageSettings.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxpreviewpagesettingsHPP
#define Fmx_FrxpreviewpagesettingsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <System.UITypes.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.Types.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxpreviewpagesettings
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxPageSettingsForm;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxDesignerUnits : unsigned char { duCM, duInches, duPixels, duChars };

class PASCALIMPLEMENTATION TfrxPageSettingsForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OKB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TGroupBox* SizeL;
	Fmx::Stdctrls::TLabel* WidthL;
	Fmx::Stdctrls::TLabel* HeightL;
	Fmx::Stdctrls::TLabel* UnitL1;
	Fmx::Stdctrls::TLabel* UnitL2;
	Fmx::Edit::TEdit* WidthE;
	Fmx::Edit::TEdit* HeightE;
	Fmx::Listbox::TComboBox* SizeCB;
	Fmx::Stdctrls::TGroupBox* OrientationL;
	Fmx::Objects::TImage* PortraitImg;
	Fmx::Objects::TImage* LandscapeImg;
	Fmx::Stdctrls::TRadioButton* PortraitRB;
	Fmx::Stdctrls::TRadioButton* LandscapeRB;
	Fmx::Stdctrls::TGroupBox* MarginsL;
	Fmx::Stdctrls::TLabel* LeftL;
	Fmx::Stdctrls::TLabel* TopL;
	Fmx::Stdctrls::TLabel* RightL;
	Fmx::Stdctrls::TLabel* BottomL;
	Fmx::Stdctrls::TLabel* UnitL3;
	Fmx::Stdctrls::TLabel* UnitL4;
	Fmx::Stdctrls::TLabel* UnitL5;
	Fmx::Stdctrls::TLabel* UnitL6;
	Fmx::Edit::TEdit* MarginLeftE;
	Fmx::Edit::TEdit* MarginTopE;
	Fmx::Edit::TEdit* MarginRightE;
	Fmx::Edit::TEdit* MarginBottomE;
	Fmx::Stdctrls::TGroupBox* OtherL;
	Fmx::Stdctrls::TRadioButton* ApplyToCurRB;
	Fmx::Stdctrls::TRadioButton* ApplyToAllRB;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall PortraitRBClick(System::TObject* Sender);
	void __fastcall SizeCBClick(System::TObject* Sender);
	void __fastcall WidthEChange(System::TObject* Sender);
	void __fastcall FormKeyDown(System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall PortraitRBChange(System::TObject* Sender);
	
protected:
	Fmx::Frxclass::TfrxReportPage* FPage;
	Fmx::Frxclass::TfrxReport* FReport;
	TfrxDesignerUnits FUnits;
	bool FUpdating;
	bool __fastcall GetNeedRebuild(void);
	System::Extended __fastcall mmToUnits(System::Extended mm);
	System::Extended __fastcall UnitsTomm(System::Extended mm);
	
public:
	__property bool NeedRebuild = {read=GetNeedRebuild, nodefault};
	__property Fmx::Frxclass::TfrxReportPage* Page = {read=FPage, write=FPage};
	__property Fmx::Frxclass::TfrxReport* Report = {read=FReport, write=FReport};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxPageSettingsForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxPageSettingsForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxPageSettingsForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxpreviewpagesettings */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXPREVIEWPAGESETTINGS)
using namespace Fmx::Frxpreviewpagesettings;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxpreviewpagesettingsHPP
