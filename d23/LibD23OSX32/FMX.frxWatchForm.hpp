// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxWatchForm.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxwatchformHPP
#define Fmx_FrxwatchformHPP

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
#include <FMX.fs_iinterpreter.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.frxFMX.hpp>
#include <System.Variants.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxwatchform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxWatchForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxWatchForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TToolBar* ToolBar1;
	Fmx::Frxfmx::TfrxToolButton* AddB;
	Fmx::Frxfmx::TfrxToolButton* DeleteB;
	Fmx::Frxfmx::TfrxToolButton* EditB;
	Fmx::Listbox::TListBox* WatchLB;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall AddBClick(System::TObject* Sender);
	void __fastcall DeleteBClick(System::TObject* Sender);
	void __fastcall EditBClick(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall WatchLBClickCheck(System::TObject* Sender);
	
private:
	Fmx::Fs_iinterpreter::TfsScript* FScript;
	bool FScriptRunning;
	System::Classes::TStrings* FWatches;
	System::UnicodeString __fastcall CalcWatch(const System::UnicodeString s);
	
public:
	void __fastcall UpdateWatches(void);
	__property Fmx::Fs_iinterpreter::TfsScript* Script = {read=FScript, write=FScript};
	__property bool ScriptRunning = {read=FScriptRunning, write=FScriptRunning, nodefault};
	__property System::Classes::TStrings* Watches = {read=FWatches};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxWatchForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxWatchForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxWatchForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxwatchform */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXWATCHFORM)
using namespace Fmx::Frxwatchform;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxwatchformHPP
