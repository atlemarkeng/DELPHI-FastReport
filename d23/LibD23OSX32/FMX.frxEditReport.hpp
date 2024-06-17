// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditReport.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxeditreportHPP
#define Fmx_FrxeditreportHPP

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
#include <System.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxCtrls.hpp>
#include <FMX.Memo.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Types.hpp>
#include <System.Variants.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditreport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxReportEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxReportEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Tabcontrol::TTabControl* PageControl;
	Fmx::Tabcontrol::TTabItem* GeneralTS;
	Fmx::Tabcontrol::TTabItem* DescriptionTS;
	Fmx::Tabcontrol::TTabItem* InheritTS;
	Fmx::Stdctrls::TGroupBox* GeneralL;
	Fmx::Stdctrls::TLabel* PasswordL;
	Fmx::Stdctrls::TCheckBox* DoublePassCB;
	Fmx::Stdctrls::TCheckBox* PrintIfEmptyCB;
	Fmx::Edit::TEdit* PasswordE;
	Fmx::Stdctrls::TGroupBox* ReportSettingsL;
	Fmx::Stdctrls::TLabel* CopiesL;
	Fmx::Listbox::TListBox* PrintersLB;
	Fmx::Edit::TEdit* CopiesE;
	Fmx::Stdctrls::TCheckBox* CollateCB;
	Fmx::Stdctrls::TGroupBox* DescriptionL;
	Fmx::Stdctrls::TLabel* NameL;
	Fmx::Objects::TImage* PictureImg;
	Fmx::Stdctrls::TLabel* Description1L;
	Fmx::Stdctrls::TLabel* PictureL;
	Fmx::Stdctrls::TLabel* AuthorL;
	Fmx::Edit::TEdit* NameE;
	Fmx::Memo::TMemo* DescriptionE;
	Fmx::Stdctrls::TButton* PictureB;
	Fmx::Edit::TEdit* AuthorE;
	Fmx::Stdctrls::TGroupBox* VersionL;
	Fmx::Stdctrls::TLabel* MajorL;
	Fmx::Stdctrls::TLabel* MinorL;
	Fmx::Stdctrls::TLabel* ReleaseL;
	Fmx::Stdctrls::TLabel* BuildL;
	Fmx::Stdctrls::TLabel* CreatedL;
	Fmx::Stdctrls::TLabel* Created1L;
	Fmx::Stdctrls::TLabel* ModifiedL;
	Fmx::Stdctrls::TLabel* Modified1L;
	Fmx::Edit::TEdit* MajorE;
	Fmx::Edit::TEdit* MinorE;
	Fmx::Edit::TEdit* ReleaseE;
	Fmx::Edit::TEdit* BuildE;
	Fmx::Stdctrls::TGroupBox* InheritGB;
	Fmx::Stdctrls::TLabel* InheritStateL;
	Fmx::Stdctrls::TLabel* SelectL;
	Fmx::Stdctrls::TLabel* PathLB;
	Fmx::Stdctrls::TRadioButton* DetachRB;
	Fmx::Stdctrls::TRadioButton* InheritRB;
	Fmx::Stdctrls::TRadioButton* DontChangeRB;
	Fmx::Edit::TEdit* PathE;
	Fmx::Stdctrls::TButton* BrowseB;
	Fmx::Listbox::TListBox* InheritLV;
	Fmx::Dialogs::TOpenDialog* OpenDialog1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PictureBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall BrowseBClick(System::TObject* Sender);
	void __fastcall FillTemplatelist(void);
	void __fastcall PathEKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall PageControlChange(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	System::Classes::TStringList* FTemplates;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxReportEditorForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxReportEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxReportEditorForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditreport */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITREPORT)
using namespace Fmx::Frxeditreport;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditreportHPP
