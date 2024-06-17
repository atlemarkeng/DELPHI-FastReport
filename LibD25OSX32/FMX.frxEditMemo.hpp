// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditMemo.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxeditmemoHPP
#define Fmx_FrxeditmemoHPP

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
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.frxEditFormat.hpp>
#include <FMX.frxEditHighlight.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.Memo.hpp>
#include <System.Variants.hpp>
#include <System.StrUtils.hpp>
#include <FMX.frxBaseModalForm.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Memo.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditmemo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxMemoEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxMemoEditorForm : public Fmx::Frxbasemodalform::TfrxForm
{
	typedef Fmx::Frxbasemodalform::TfrxForm inherited;
	
__published:
	Fmx::Dialogs::TSaveDialog* SaveDialog1;
	Fmx::Tabcontrol::TTabControl* TabControl;
	Fmx::Tabcontrol::TTabItem* TextTS;
	Fmx::Tabcontrol::TTabItem* FormatTS;
	Fmx::Tabcontrol::TTabItem* HighlightTS;
	Fmx::Stdctrls::TToolBar* ToolBar;
	Fmx::Frxfmx::TfrxToolButton* ExprB;
	Fmx::Frxfmx::TfrxToolButton* AggregateB;
	Fmx::Frxfmx::TfrxToolButton* LocalFormatB;
	Fmx::Frxfmx::TfrxToolButton* WordWrapB;
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TButton* OkB;
	void __fastcall WordWrapBClick(System::TObject* Sender);
	void __fastcall MemoKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall ExprBClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall AggregateBClick(System::TObject* Sender);
	void __fastcall LocalFormatBClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall FormShow2(System::TObject* Sender);
	
private:
	Fmx::Frxeditformat::TfrxFormatEditorForm* FFormat;
	Fmx::Frxedithighlight::TfrxHighlightEditorForm* FHighlight;
	Fmx::Frxclass::TfrxCustomMemoView* FMemoView;
	System::WideString FText;
	
public:
	Fmx::Memo::TMemo* Memo;
	void __fastcall FormShow(System::TObject* Sender);
	__property Fmx::Frxclass::TfrxCustomMemoView* MemoView = {read=FMemoView, write=FMemoView};
	__property System::WideString Text = {read=FText, write=FText};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxMemoEditorForm(System::Classes::TComponent* AOwner) : Fmx::Frxbasemodalform::TfrxForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxMemoEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Frxbasemodalform::TfrxForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxMemoEditorForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditmemo */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITMEMO)
using namespace Fmx::Frxeditmemo;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditmemoHPP
