// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxFontForm.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxfontformHPP
#define Fmx_FrxfontformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.frxRes.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Colors.hpp>
#include <System.UIConsts.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxfontform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxFontForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxFontForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TLabel* FontL;
	Fmx::Stdctrls::TLabel* SizeL;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Stdctrls::TGroupBox* Sample;
	Fmx::Objects::TPaintBox* PaintBox1;
	Fmx::Edit::TEdit* FontE;
	Fmx::Edit::TEdit* SizeE;
	Fmx::Listbox::TListBox* FontLB;
	Fmx::Listbox::TListBox* SizeLB;
	Fmx::Stdctrls::TButton* CancelBtn;
	Fmx::Stdctrls::TButton* OkBtn;
	Fmx::Frxfmx::TfrxToolButton* BoldB;
	Fmx::Frxfmx::TfrxToolButton* ItalicB;
	Fmx::Frxfmx::TfrxToolButton* UnderlineB;
	Fmx::Frxfmx::TfrxToolButton* StrikeoutB;
	Fmx::Colors::TComboColorBox* ComboColorBox1;
	Fmx::Stdctrls::TLabel* ColorL;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FontEChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall ComboColorBox1Change(System::TObject* Sender);
	void __fastcall FontLBChange(System::TObject* Sender);
	void __fastcall SizeLBChange(System::TObject* Sender);
	void __fastcall SizeEChangeTracking(System::TObject* Sender);
	void __fastcall PaintBox1Paint(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas);
	void __fastcall BoldBClick(System::TObject* Sender);
	void __fastcall ItalicBClick(System::TObject* Sender);
	void __fastcall UnderlineBClick(System::TObject* Sender);
	void __fastcall StrikeoutBClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	
private:
	Fmx::Frxfmx::TfrxFont* FFontS;
	bool FIsCallFromEdit;
	
public:
	__property Fmx::Frxfmx::TfrxFont* FontS = {read=FFontS};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxFontForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxFontForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxFontForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxFontForm* frxFontForm;
}	/* namespace Frxfontform */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXFONTFORM)
using namespace Fmx::Frxfontform;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxfontformHPP
