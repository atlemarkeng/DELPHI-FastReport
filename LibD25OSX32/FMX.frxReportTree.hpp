// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxReportTree.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxreporttreeHPP
#define Fmx_FrxreporttreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Objects.hpp>
#include <System.UITypes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.Types.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.TreeView.hpp>
#include <FMX.frxFMX.hpp>
#include <System.Variants.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxreporttree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxReportTreeForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxReportTreeForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TPanel* MainPanel;
	Fmx::Objects::TRectangle* Rectangle1;
	Fmx::Stdctrls::TLabel* Label1;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall TreeChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall TreeKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	System::Classes::TList* FComponents;
	Fmx::Frxclass::TfrxCustomDesigner* FDesigner;
	System::Classes::TList* FNodes;
	Fmx::Frxclass::TfrxReport* FReport;
	bool FUpdating;
	System::Classes::TNotifyEvent FOnSelectionChanged;
	Fmx::Frxfmx::TfrxTreeView* Tree;
	
public:
	__fastcall virtual TfrxReportTreeForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxReportTreeForm(void);
	void __fastcall UpdateItems(void);
	void __fastcall UpdateSelection(void);
	__property System::Classes::TNotifyEvent OnSelectionChanged = {read=FOnSelectionChanged, write=FOnSelectionChanged};
	__property Fmx::Frxclass::TfrxReport* Report = {read=FReport, write=FReport};
	__property Fmx::Frxfmx::TfrxTreeView* ReportTree = {read=Tree};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxReportTreeForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxreporttree */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXREPORTTREE)
using namespace Fmx::Frxreporttree;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxreporttreeHPP
