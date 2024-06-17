// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditVar.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxeditvarHPP
#define Fmx_FrxeditvarHPP

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
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxVariables.hpp>
#include <FMX.frxDataTree.hpp>
#include <FMX.Memo.hpp>
#include <FMX.Types.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.TreeView.hpp>
#include <System.Variants.hpp>
#include <FMX.Edit.hpp>
#include <FMX.frxBaseModalForm.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Memo.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditvar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxVarEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxVarEditorForm : public Fmx::Frxbasemodalform::TfrxForm
{
	typedef Fmx::Frxbasemodalform::TfrxForm inherited;
	
__published:
	Fmx::Stdctrls::TToolBar* ToolBar;
	Fmx::Frxfmx::TfrxToolButton* NewCategoryB;
	Fmx::Frxfmx::TfrxToolButton* NewVarB;
	Fmx::Frxfmx::TfrxToolButton* EditB;
	Fmx::Frxfmx::TfrxToolButton* DeleteB;
	Fmx::Frxfmx::TfrxToolButton* EditListB;
	Fmx::Frxfmx::TfrxToolButton* OkB;
	Fmx::Frxfmx::TfrxToolButton* CancelB;
	Fmx::Memo::TMemo* ExprMemo;
	Fmx::Stdctrls::TSplitter* Splitter1;
	Fmx::Stdctrls::TSplitter* Splitter2;
	Fmx::Stdctrls::TPanel* ExprPanel;
	Fmx::Frxfmx::TfrxToolButton* LoadB;
	Fmx::Frxfmx::TfrxToolButton* SaveB;
	Fmx::Dialogs::TOpenDialog* OpenDialog1;
	Fmx::Dialogs::TSaveDialog* SaveDialog1;
	Fmx::Stdctrls::TPanel* Panel;
	Fmx::Frxfmx::TfrxTreeView* VarTree;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall DeleteBClick(System::TObject* Sender);
	void __fastcall NewCategoryBClick(System::TObject* Sender);
	void __fastcall NewVarBClick(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall EditBClick(System::TObject* Sender);
	void __fastcall VarTreeEdited(System::TObject* Sender, Fmx::Frxfmx::TfrxTreeViewItem* Node, System::UnicodeString &S);
	void __fastcall ExprMemoDragOver(System::TObject* Sender, const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point, bool &Accept);
	void __fastcall ExprMemoDragDrop(System::TObject* Sender, const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point);
	void __fastcall VarTreeChange(System::TObject* Sender);
	void __fastcall VarTreeChanging(System::TObject* Sender, Fmx::Frxfmx::TfrxTreeViewItem* OldNode, Fmx::Frxfmx::TfrxTreeViewItem* NewNode);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall EditListBClick(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall LoadBClick(System::TObject* Sender);
	void __fastcall SaveBClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall Splitter2Moved(System::TObject* Sender);
	void __fastcall VarTreeResize(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall ExprMemoChange(System::TObject* Sender);
	void __fastcall ExprMemoEnter(System::TObject* Sender);
	
private:
	Fmx::Frxclass::TfrxReport* FReport;
	bool FUpdating;
	Fmx::Frxvariables::TfrxVariables* FVariables;
	Fmx::Frxdatatree::TfrxDataTreeForm* FDataTree;
	bool FExprMemoModified;
	System::UnicodeString FNodeOldText;
	HIDESBASE Fmx::Frxfmx::TfrxTreeViewItem* __fastcall Root(void);
	void __fastcall CreateUniqueName(System::UnicodeString &s);
	void __fastcall FillVariables(void);
	void __fastcall UpdateItem0(void);
	void __fastcall OnDataTreeDblClick(System::TObject* Sender);
	void __fastcall VarTreeKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxVarEditorForm(System::Classes::TComponent* AOwner) : Fmx::Frxbasemodalform::TfrxForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxVarEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Frxbasemodalform::TfrxForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxVarEditorForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditvar */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITVAR)
using namespace Fmx::Frxeditvar;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditvarHPP
