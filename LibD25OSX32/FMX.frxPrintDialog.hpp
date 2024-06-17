// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxPrintDialog.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxprintdialogHPP
#define Fmx_FrxprintdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.UITypes.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Edit.hpp>
#include <FMX.frxCtrls.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxprintdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxPrintDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxPrintDialog : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Dialogs::TSaveDialog* FileDlg;
	Fmx::Stdctrls::TGroupBox* Label12;
	Fmx::Stdctrls::TLabel* WhereL;
	Fmx::Stdctrls::TLabel* WhereL1;
	Fmx::Listbox::TComboBox* PrintersCB;
	Fmx::Stdctrls::TButton* PropButton;
	Fmx::Stdctrls::TCheckBox* FileCB;
	Fmx::Stdctrls::TGroupBox* Label1;
	Fmx::Stdctrls::TLabel* DescrL;
	Fmx::Stdctrls::TRadioButton* AllRB;
	Fmx::Stdctrls::TRadioButton* CurPageRB;
	Fmx::Stdctrls::TRadioButton* PageNumbersRB;
	Fmx::Edit::TEdit* PageNumbersE;
	Fmx::Stdctrls::TGroupBox* Label2;
	Fmx::Stdctrls::TLabel* CopiesL;
	Fmx::Objects::TImage* CollateImg;
	Fmx::Objects::TImage* NonCollateImg;
	Fmx::Objects::TPaintBox* CopiesPB;
	Fmx::Edit::TEdit* CopiesE;
	Fmx::Stdctrls::TCheckBox* CollateCB;
	Fmx::Stdctrls::TGroupBox* ScaleGB;
	Fmx::Listbox::TComboBox* PagPageSizeCB;
	Fmx::Stdctrls::TLabel* NameL;
	Fmx::Stdctrls::TLabel* PagSizeL;
	Fmx::Listbox::TComboBox* PrintModeCB;
	Fmx::Stdctrls::TGroupBox* OtherGB;
	Fmx::Stdctrls::TLabel* PrintL;
	Fmx::Stdctrls::TLabel* DuplexL;
	Fmx::Listbox::TComboBox* PrintPagesCB;
	Fmx::Listbox::TComboBox* DuplexCB;
	Fmx::Stdctrls::TLabel* OrderL;
	Fmx::Listbox::TComboBox* OrderCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PropButtonClick(System::TObject* Sender);
	void __fastcall PrintersCBClick(System::TObject* Sender);
	void __fastcall PageNumbersRBClick(System::TObject* Sender);
	void __fastcall CollateLClick(System::TObject* Sender);
	void __fastcall CollateCBClick(System::TObject* Sender);
	void __fastcall PageNumbersEEnter(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall PrintModeCBClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	int OldIndex;
	
public:
	Fmx::Frxclass::TfrxReport* AReport;
	Fmx::Frxclass::TfrxDuplexMode ADuplexMode;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxPrintDialog(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxPrintDialog(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxPrintDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxprintdialog */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXPRINTDIALOG)
using namespace Fmx::Frxprintdialog;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxprintdialogHPP
