// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditAliases.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxeditaliasesHPP
#define Fmx_FrxeditaliasesHPP

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
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <System.Math.hpp>
#include <FMX.frxClass.hpp>
#include <System.Variants.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Types.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Grid.hpp>
#include <System.UITypes.hpp>
#include <System.Rtti.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.ScrollBox.hpp>
#include <FMX.Controls.Presentation.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditaliases
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THackStringGrid;
class DELPHICLASS TfrxAliasesEditorForm;
class DELPHICLASS TStringCheckColumn;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THackStringGrid : public Fmx::Grid::TStringGrid
{
	typedef Fmx::Grid::TStringGrid inherited;
	
public:
	/* TCustomGrid.Create */ inline __fastcall virtual THackStringGrid(System::Classes::TComponent* AOwner)/* overload */ : Fmx::Grid::TStringGrid(AOwner) { }
	/* TCustomGrid.Destroy */ inline __fastcall virtual ~THackStringGrid(void) { }
	
};


class PASCALIMPLEMENTATION TfrxAliasesEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TButton* ResetB;
	Fmx::Stdctrls::TLabel* HintL;
	Fmx::Stdctrls::TLabel* DSAliasL;
	Fmx::Edit::TEdit* DSAliasE;
	Fmx::Stdctrls::TLabel* FieldAliasesL;
	Fmx::Stdctrls::TButton* UpdateB;
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ResetBClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall UpdateBClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	Fmx::Frxclass::TfrxCustomDBDataSet* FDataSet;
	Fmx::Grid::TStringGrid* AliasGrid;
	void __fastcall BuildAliasList(System::Classes::TStrings* List);
	
public:
	__property Fmx::Frxclass::TfrxCustomDBDataSet* DataSet = {read=FDataSet, write=FDataSet};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxAliasesEditorForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxAliasesEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxAliasesEditorForm(void) { }
	
};


class PASCALIMPLEMENTATION TStringCheckColumn : public Fmx::Grid::TCheckColumn
{
	typedef Fmx::Grid::TCheckColumn inherited;
	
	
private:
	typedef System::DynamicArray<bool> _TStringCheckColumn__1;
	
	
private:
	int FRowCount;
	_TStringCheckColumn__1 FCheckCells;
public:
	/* TColumn.Create */ inline __fastcall virtual TStringCheckColumn(System::Classes::TComponent* AOwner) : Fmx::Grid::TCheckColumn(AOwner) { }
	/* TColumn.Destroy */ inline __fastcall virtual ~TStringCheckColumn(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditaliases */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITALIASES)
using namespace Fmx::Frxeditaliases;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditaliasesHPP
