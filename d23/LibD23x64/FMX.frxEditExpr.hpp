// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditExpr.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxeditexprHPP
#define Fmx_FrxeditexprHPP

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
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxDataTree.hpp>
#include <FMX.Types.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Memo.hpp>
#include <System.Variants.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Memo.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditexpr
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxExprEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxExprEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Memo::TMemo* ExprMemo;
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TSplitter* Splitter1;
	Fmx::Stdctrls::TPanel* Panel2;
	Fmx::Stdctrls::TLabel* ExprL;
	Fmx::Stdctrls::TPanel* Panel;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ExprMemoDragOver(System::TObject* Sender, const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point, bool &Accept);
	void __fastcall ExprMemoDragDrop(System::TObject* Sender, const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormResize(System::TObject* Sender);
	
private:
	Fmx::Frxdatatree::TfrxDataTreeForm* FDataTree;
	Fmx::Frxclass::TfrxReport* FReport;
	void __fastcall OnDataTreeDblClick(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxExprEditorForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxExprEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxExprEditorForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditexpr */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITEXPR)
using namespace Fmx::Frxeditexpr;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditexprHPP
