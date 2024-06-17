// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditStyle.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxeditstyleHPP
#define Fmx_FrxeditstyleHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.TreeView.hpp>
#include <FMX.Types.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Edit.hpp>
#include <System.UIConsts.hpp>
#include <FMX.frxFontForm.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditstyle
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxStyleEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxStyleEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TToolBar* ToolBar;
	Fmx::Frxfmx::TfrxToolButton* AddB;
	Fmx::Frxfmx::TfrxToolButton* DeleteB;
	Fmx::Frxfmx::TfrxToolButton* LoadB;
	Fmx::Frxfmx::TfrxToolButton* SaveB;
	Fmx::Frxfmx::TfrxToolButton* CancelB;
	Fmx::Frxfmx::TfrxToolButton* OkB;
	Fmx::Dialogs::TOpenDialog* OpenDialog;
	Fmx::Dialogs::TSaveDialog* SaveDialog;
	Fmx::Frxfmx::TfrxToolButton* EditB;
	Fmx::Objects::TPaintBox* PaintBox;
	Fmx::Stdctrls::TButton* ColorB;
	Fmx::Stdctrls::TButton* FontB;
	Fmx::Stdctrls::TButton* FrameB;
	Fmx::Frxfmx::TfrxTreeView* StylesTV;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall PaintBoxPaint(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall AddBClick(System::TObject* Sender);
	void __fastcall DeleteBClick(System::TObject* Sender);
	void __fastcall LoadBClick(System::TObject* Sender);
	void __fastcall SaveBClick(System::TObject* Sender);
	void __fastcall BClick(System::TObject* Sender);
	void __fastcall StylesTVClick(System::TObject* Sender);
	void __fastcall StylesTVEdited(System::TObject* Sender, Fmx::Frxfmx::TfrxTreeViewItem* Node, System::UnicodeString &S);
	void __fastcall EditBClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	Fmx::Frxclass::TfrxReport* FReport;
	Fmx::Frxclass::TfrxStyles* FStyles;
	void __fastcall UpdateStyles(int Focus = 0x0);
	void __fastcall UpdateControls(void);
	
public:
	__fastcall virtual TfrxStyleEditorForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxStyleEditorForm(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxStyleEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditstyle */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITSTYLE)
using namespace Fmx::Frxeditstyle;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditstyleHPP
