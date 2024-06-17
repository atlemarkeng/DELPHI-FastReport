// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditPage.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxeditpageHPP
#define Fmx_FrxeditpageHPP

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
#include <FMX.Types.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxCtrls.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Memo.hpp>
#include <FMX.frxFMX.hpp>
#include <System.Variants.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditpage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxPageEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxPageEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OKB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabSheet1;
	Fmx::Tabcontrol::TTabItem* TabSheet3;
	Fmx::Stdctrls::TGroupBox* Label11;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* UnitL1;
	Fmx::Stdctrls::TLabel* UnitL2;
	Fmx::Edit::TEdit* WidthE;
	Fmx::Edit::TEdit* HeightE;
	Fmx::Listbox::TComboBox* SizeCB;
	Fmx::Stdctrls::TGroupBox* Label12;
	Fmx::Objects::TImage* PortraitImg;
	Fmx::Objects::TImage* LandscapeImg;
	Fmx::Stdctrls::TRadioButton* PortraitRB;
	Fmx::Stdctrls::TRadioButton* LandscapeRB;
	Fmx::Stdctrls::TGroupBox* Label13;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TLabel* UnitL3;
	Fmx::Stdctrls::TLabel* UnitL4;
	Fmx::Stdctrls::TLabel* UnitL5;
	Fmx::Stdctrls::TLabel* UnitL6;
	Fmx::Edit::TEdit* MarginLeftE;
	Fmx::Edit::TEdit* MarginTopE;
	Fmx::Edit::TEdit* MarginRightE;
	Fmx::Edit::TEdit* MarginBottomE;
	Fmx::Stdctrls::TGroupBox* Label14;
	Fmx::Stdctrls::TLabel* Label9;
	Fmx::Stdctrls::TLabel* Label10;
	Fmx::Listbox::TComboBox* Tray1CB;
	Fmx::Listbox::TComboBox* Tray2CB;
	Fmx::Stdctrls::TGroupBox* Label17;
	Fmx::Stdctrls::TLabel* Label18;
	Fmx::Stdctrls::TCheckBox* PrintOnPrevCB;
	Fmx::Stdctrls::TCheckBox* MirrorMarginsCB;
	Fmx::Stdctrls::TCheckBox* LargeHeightCB;
	Fmx::Listbox::TComboBox* DuplexCB;
	Fmx::Stdctrls::TCheckBox* EndlessWidthCB;
	Fmx::Stdctrls::TCheckBox* EndlessHeightCB;
	Fmx::Stdctrls::TGroupBox* Label7;
	Fmx::Stdctrls::TLabel* Label8;
	Fmx::Stdctrls::TLabel* Label15;
	Fmx::Stdctrls::TLabel* Label16;
	Fmx::Stdctrls::TLabel* UnitL7;
	Fmx::Edit::TEdit* ColumnWidthE;
	Fmx::Memo::TMemo* ColumnPositionsM;
	Fmx::Spinbox::TSpinBox* ColumnsNumberS;
	void __fastcall PortraitRBClick(System::TObject* Sender);
	void __fastcall SizeCBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall WidthEChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall ColumnsNumberSChange(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	bool FUpdating;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxPageEditorForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxPageEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxPageEditorForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditpage */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITPAGE)
using namespace Fmx::Frxeditpage;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditpageHPP
