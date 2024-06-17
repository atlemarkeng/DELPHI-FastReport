// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditHighlight.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxedithighlightHPP
#define Fmx_FrxedithighlightHPP

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
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxCtrls.hpp>
#include <System.Variants.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Colors.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxedithighlight
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxHighlightEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxHighlightEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OKB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TGroupBox* ConditionL;
	Fmx::Frxctrls::TfrxEditWithButton* ConditionE;
	Fmx::Stdctrls::TGroupBox* FontL;
	Fmx::Colors::TColorComboBox* FontColorB;
	Fmx::Stdctrls::TCheckBox* BoldCB;
	Fmx::Stdctrls::TCheckBox* ItalicCB;
	Fmx::Stdctrls::TCheckBox* UnderlineCB;
	Fmx::Stdctrls::TGroupBox* BackgroundL;
	Fmx::Colors::TColorComboBox* BackColorB;
	Fmx::Stdctrls::TRadioButton* TransparentRB;
	Fmx::Stdctrls::TRadioButton* OtherRB;
	void __fastcall TransparentRBClick(System::TObject* Sender);
	void __fastcall ConditionEButtonClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	Fmx::Frxclass::TfrxHighlight* FHighlight;
	Fmx::Frxclass::TfrxCustomMemoView* FMemoView;
	
public:
	__property Fmx::Frxclass::TfrxCustomMemoView* MemoView = {read=FMemoView, write=FMemoView};
	void __fastcall HostControls(Fmx::Types::TFmxObject* Host);
	void __fastcall UnhostControls(System::Uitypes::TModalResult AModalResult);
	void __fastcall FormShow(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxHighlightEditorForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxHighlightEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxHighlightEditorForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxedithighlight */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITHIGHLIGHT)
using namespace Fmx::Frxedithighlight;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxedithighlightHPP
