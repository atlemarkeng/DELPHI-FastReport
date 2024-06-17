// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditTabOrder.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxedittaborderHPP
#define Fmx_FrxedittaborderHPP

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
#include <FMX.frxClass.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Types.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxedittaborder
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxTabOrderEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxTabOrderEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TButton* UpB;
	Fmx::Stdctrls::TButton* DownB;
	Fmx::Listbox::TListBox* ControlsLB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall UpBClick(System::TObject* Sender);
	void __fastcall DownBClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	System::Classes::TList* FOldOrder;
	Fmx::Frxclass::TfrxComponent* FParent;
	void __fastcall UpdateOrder(void);
	
public:
	__fastcall virtual TfrxTabOrderEditorForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxTabOrderEditorForm(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxTabOrderEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxedittaborder */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITTABORDER)
using namespace Fmx::Frxedittaborder;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxedittaborderHPP
