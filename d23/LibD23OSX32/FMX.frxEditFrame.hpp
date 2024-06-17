// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditFrame.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxeditframeHPP
#define Fmx_FrxeditframeHPP

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
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxCtrls.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.ComboEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditframe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxFrameEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxFrameEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TLabel* FrameL;
	Fmx::Stdctrls::TLabel* LineL;
	Fmx::Stdctrls::TLabel* ShadowL;
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TToolBar* ToolBar1;
	Fmx::Frxfmx::TfrxToolButton* FrameTopB;
	Fmx::Frxfmx::TfrxToolButton* FrameBottomB;
	Fmx::Frxfmx::TfrxToolButton* FrameLeftB;
	Fmx::Frxfmx::TfrxToolButton* FrameRightB;
	Fmx::Frxfmx::TfrxToolButton* FrameAllB;
	Fmx::Frxfmx::TfrxToolButton* FrameNoB;
	Fmx::Stdctrls::TToolBar* ToolBar2;
	Fmx::Frxfmx::TfrxToolButton* FrameColorB;
	Fmx::Frxfmx::TfrxToolButton* FrameStyleB;
	Fmx::Stdctrls::TPanel* Sep2;
	Fmx::Comboedit::TComboEdit* FrameWidthCB;
	Fmx::Stdctrls::TToolBar* ToolBar3;
	Fmx::Frxfmx::TfrxToolButton* ShadowB;
	Fmx::Frxfmx::TfrxToolButton* ShadowColorB;
	Fmx::Stdctrls::TPanel* Sep3;
	Fmx::Comboedit::TComboEdit* ShadowWidthCB;
	Fmx::Comboedit::TComboEdit* FrameLineCB;
	Fmx::Stdctrls::TLabel* FLineL;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall BClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	
private:
	Fmx::Frxclass::TfrxFrame* FFrame;
	Fmx::Frxfmx::TfrxImageList* FImageList;
	void __fastcall UpdateControls(void);
	Fmx::Frxclass::TfrxFrameLine* __fastcall GetFrameLine(void);
	
public:
	__property Fmx::Frxclass::TfrxFrame* Frame = {read=FFrame};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxFrameEditorForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxFrameEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxFrameEditorForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditframe */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITFRAME)
using namespace Fmx::Frxeditframe;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditframeHPP
