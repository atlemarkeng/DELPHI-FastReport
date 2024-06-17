// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditPicture.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxeditpictureHPP
#define Fmx_FrxeditpictureHPP

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
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxCtrls.hpp>
#include <FMX.frxBaseModalForm.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Types.hpp>
#include <FMX.frxFMX.hpp>
#include <System.Variants.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditpicture
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxPictureEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxPictureEditorForm : public Fmx::Frxbasemodalform::TfrxForm
{
	typedef Fmx::Frxbasemodalform::TfrxForm inherited;
	
__published:
	Fmx::Stdctrls::TToolBar* ToolBar;
	Fmx::Frxfmx::TfrxToolButton* LoadB;
	Fmx::Frxfmx::TfrxToolButton* ClearB;
	Fmx::Frxfmx::TfrxToolButton* OkB;
	Fmx::Layouts::TScrollBox* Box;
	Fmx::Frxfmx::TfrxToolButton* CancelB;
	Fmx::Objects::TImage* Image;
	Fmx::Stdctrls::TStatusBar* StatusBar;
	Fmx::Frxfmx::TfrxToolButton* CopyB;
	Fmx::Frxfmx::TfrxToolButton* PasteB;
	void __fastcall ClearBClick(System::TObject* Sender);
	void __fastcall LoadBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CopyBClick(System::TObject* Sender);
	void __fastcall PasteBClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormActivate(System::TObject* Sender);
	
private:
	void __fastcall UpdateImage(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxPictureEditorForm(System::Classes::TComponent* AOwner) : Fmx::Frxbasemodalform::TfrxForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxPictureEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Frxbasemodalform::TfrxForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxPictureEditorForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditpicture */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITPICTURE)
using namespace Fmx::Frxeditpicture;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditpictureHPP
