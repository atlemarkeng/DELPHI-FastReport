// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxEditQueryParams.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxeditqueryparamsHPP
#define Fmx_FrxeditqueryparamsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <Data.DB.hpp>
#include <FMX.frxCustomDB.hpp>
#include <FMX.frxCtrls.hpp>
#include <System.Rtti.hpp>
#include <System.UITypes.hpp>
#include <System.Variants.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Grid.hpp>
#include <System.Types.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Grid.Style.hpp>
#include <FMX.ScrollBox.hpp>
#include <FMX.Controls.Presentation.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxeditqueryparams
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THackStringGrid;
class DELPHICLASS TfrxParamsEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THackStringGrid : public Fmx::Grid::TStringGrid
{
	typedef Fmx::Grid::TStringGrid inherited;
	
public:
	/* TCustomGrid.Create */ inline __fastcall virtual THackStringGrid(System::Classes::TComponent* AOwner)/* overload */ : Fmx::Grid::TStringGrid(AOwner) { }
	/* TCustomGrid.Destroy */ inline __fastcall virtual ~THackStringGrid(void) { }
	
};


class PASCALIMPLEMENTATION TfrxParamsEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Listbox::TComboBox* TypeCB;
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TPanel* ButtonPanel;
	Fmx::Stdctrls::TSpeedButton* ExpressionB;
	Fmx::Grid::TStringGrid* ParamGrid;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ValueEButtonClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall TypeCBChange(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall ParamGridResize(System::TObject* Sender);
	
private:
	Fmx::Frxcustomdb::TfrxParams* FParams;
	void __fastcall ParamGridDragOver(System::TObject* Sender, const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point, Fmx::Types::TDragOperation &Operation);
	void __fastcall ParamGridMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	
public:
	__property Fmx::Frxcustomdb::TfrxParams* Params = {read=FParams, write=FParams};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxParamsEditorForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxParamsEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxParamsEditorForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditqueryparams */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXEDITQUERYPARAMS)
using namespace Fmx::Frxeditqueryparams;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxeditqueryparamsHPP
