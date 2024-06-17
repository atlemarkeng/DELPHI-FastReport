// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxDataTree.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxdatatreeHPP
#define Fmx_FrxdatatreeHPP

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
#include <FMX.fs_xml.hpp>
#include <FMX.Types.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.TreeView.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.TabControl.hpp>
#include <System.Variants.hpp>
#include <FMX.Objects.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxdatatree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxDataTreeForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxDataTreeForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TPanel* MainDataPanel;
	Fmx::Stdctrls::TPanel* ClassesPn;
	Fmx::Stdctrls::TPanel* DataPn;
	Fmx::Stdctrls::TPanel* CBPanel;
	Fmx::Stdctrls::TCheckBox* InsFieldCB;
	Fmx::Stdctrls::TCheckBox* InsCaptionCB;
	Fmx::Stdctrls::TCheckBox* SortCB;
	Fmx::Stdctrls::TLabel* NoDataL;
	Fmx::Stdctrls::TPanel* FunctionsPn;
	Fmx::Stdctrls::TSplitter* Splitter1;
	Fmx::Layouts::TScrollBox* HintPanel;
	Fmx::Stdctrls::TLabel* FunctionDescL;
	Fmx::Stdctrls::TLabel* FunctionNameL;
	Fmx::Stdctrls::TPanel* VariablesPn;
	Fmx::Objects::TRectangle* Rectangle1;
	Fmx::Stdctrls::TLabel* Label1;
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall FunctionsTreeChange(System::TObject* Sender);
	void __fastcall DataTreeDblClick(System::TObject* Sender);
	void __fastcall SortCBClick(System::TObject* Sender);
	void __fastcall MainDataPanelDragEnd(System::TObject* Sender);
	
private:
	Fmx::Fs_xml::TfsXMLDocument* FXML;
	Fmx::Frxfmx::TfrxImageList* FImages;
	Fmx::Frxclass::TfrxReport* FReport;
	bool FUpdating;
	bool FFirstTime;
	Fmx::Frxfmx::TfrxTreeView* DataTree;
	Fmx::Frxfmx::TfrxTreeView* VariablesTree;
	Fmx::Frxfmx::TfrxTreeView* FunctionsTree;
	Fmx::Frxfmx::TfrxTreeView* ClassesTree;
	Fmx::Tabcontrol::TTabControl* FTabs;
	void __fastcall FillClassesTree(void);
	void __fastcall FillDataTree(void);
	void __fastcall FillFunctionsTree(void);
	void __fastcall FillVariablesTree(void);
	void __fastcall TabsChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetCollapsedNodes(void);
	
public:
	__fastcall virtual TfrxDataTreeForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxDataTreeForm(void);
	void __fastcall SetLastPosition(const System::Types::TPoint &p);
	void __fastcall ShowTab(int Index);
	void __fastcall UpdateItems(void);
	void __fastcall UpdateSelection(void);
	void __fastcall UpdateSize(void);
	int __fastcall GetActivePage(void);
	System::UnicodeString __fastcall GetFieldName(void);
	System::Types::TPoint __fastcall GetLastPosition(void);
	bool __fastcall IsDataField(void);
	__property Fmx::Frxclass::TfrxReport* Report = {read=FReport, write=FReport};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxDataTreeForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdatatree */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXDATATREE)
using namespace Fmx::Frxdatatree;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxdatatreeHPP
