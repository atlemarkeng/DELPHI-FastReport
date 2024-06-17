// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxCrossEditor.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxcrosseditorHPP
#define Fmx_FrxcrosseditorHPP

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
#include <System.UIConsts.hpp>
#include <System.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Types.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Menus.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxCross.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxCtrls.hpp>
#include <FMX.frxCustomEditors.hpp>
#include <System.Variants.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxcrosseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxCrossEditor;
class DELPHICLASS TfrxCrossEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxCrossEditor : public Fmx::Frxcustomeditors::TfrxViewEditor
{
	typedef Fmx::Frxcustomeditors::TfrxViewEditor inherited;
	
public:
	virtual bool __fastcall Edit(void);
	virtual bool __fastcall HasEditor(void);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall TfrxCrossEditor(Fmx::Frxclass::TfrxComponent* Component, Fmx::Frxclass::TfrxCustomDesigner* Designer, Fmx::Menus::TPopupMenu* Menu) : Fmx::Frxcustomeditors::TfrxViewEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxCrossEditor(void) { }
	
};


class PASCALIMPLEMENTATION TfrxCrossEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
	
private:
	typedef System::StaticArray<System::UnicodeString, 6> _TfrxCrossEditorForm__1;
	
	typedef System::StaticArray<System::UnicodeString, 4> _TfrxCrossEditorForm__2;
	
	
__published:
	Fmx::Menus::TPopupMenu* FuncPopup;
	Fmx::Menus::TPopupMenu* SortPopup;
	Fmx::Stdctrls::TGroupBox* DatasetL;
	Fmx::Listbox::TComboBox* DatasetCB;
	Fmx::Frxfmx::TfrxListBox* FieldsLB;
	Fmx::Stdctrls::TGroupBox* DimensionsL;
	Fmx::Stdctrls::TLabel* RowsL;
	Fmx::Edit::TEdit* RowsE;
	Fmx::Stdctrls::TLabel* ColumnsL;
	Fmx::Edit::TEdit* ColumnsE;
	Fmx::Stdctrls::TLabel* CellsL;
	Fmx::Edit::TEdit* CellsE;
	Fmx::Stdctrls::TGroupBox* StructureL;
	Fmx::Objects::TLine* Shape1;
	Fmx::Objects::TLine* Shape2;
	Fmx::Stdctrls::TSpeedButton* SwapB;
	Fmx::Frxfmx::TfrxListBox* RowsLB;
	Fmx::Frxfmx::TfrxListBox* ColumnsLB;
	Fmx::Frxfmx::TfrxListBox* CellsLB;
	Fmx::Stdctrls::TGroupBox* OptionsL;
	Fmx::Stdctrls::TCheckBox* RowHeaderCB;
	Fmx::Stdctrls::TCheckBox* ColumnHeaderCB;
	Fmx::Stdctrls::TCheckBox* RowTotalCB;
	Fmx::Stdctrls::TCheckBox* ColumnTotalCB;
	Fmx::Stdctrls::TCheckBox* TitleCB;
	Fmx::Stdctrls::TCheckBox* CornerCB;
	Fmx::Stdctrls::TCheckBox* AutoSizeCB;
	Fmx::Stdctrls::TCheckBox* BorderCB;
	Fmx::Stdctrls::TCheckBox* DownAcrossCB;
	Fmx::Stdctrls::TCheckBox* PlainCB;
	Fmx::Stdctrls::TCheckBox* JoinCB;
	Fmx::Layouts::TScrollBox* Box;
	Fmx::Objects::TPaintBox* PaintBox;
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TCheckBox* RepeatCB;
	Fmx::Menus::TPopupMenu* StylePopup;
	Fmx::Menus::TMenuItem* Sep1;
	Fmx::Menus::TMenuItem* SaveStyleMI;
	Fmx::Stdctrls::TToolBar* ToolBar;
	Fmx::Frxfmx::TfrxToolButton* StyleB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall DatasetCBClick(System::TObject* Sender);
	void __fastcall LBDragOver(System::TObject* Sender, const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point, Fmx::Types::TDragOperation &Operation);
	void __fastcall LBDragDrop(System::TObject* Sender, const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point);
	void __fastcall LBMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall LBClick(System::TObject* Sender);
	void __fastcall CBClick(System::TObject* Sender);
	void __fastcall FuncMIClick(System::TObject* Sender);
	void __fastcall SortMIClick(System::TObject* Sender);
	void __fastcall SwapBClick(System::TObject* Sender);
	void __fastcall DimensionsChange(System::TObject* Sender);
	void __fastcall LBDblClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall PaintBoxPaint(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas);
	void __fastcall SaveStyleMIClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall RowsLBDragEnter(System::TObject* Sender, const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point);
	void __fastcall RowsLBDragLeave(System::TObject* Sender);
	void __fastcall StyleBClick(System::TObject* Sender);
	
private:
	Fmx::Frxcross::TfrxCustomCrossView* FCross;
	Fmx::Frxfmx::TfrxListBox* FCurList;
	System::Classes::TList* FSortMenuList;
	System::Classes::TList* FFuncMenuList;
	_TfrxCrossEditorForm__1 FFuncNames;
	Fmx::Frxfmx::TfrxImageList* FImages;
	_TfrxCrossEditorForm__2 FSortNames;
	Fmx::Frxclass::TfrxStyleSheet* FStyleSheet;
	Fmx::Frxcross::TfrxDBCrossView* FTempCross;
	bool FUpdating;
	bool FItemAdded;
	void __fastcall ReflectChanges(System::TObject* ChangesFrom, bool UpdateText = true);
	void __fastcall CreateStyleMenu(void);
	void __fastcall StyleClick(System::TObject* Sender);
	void __fastcall UpdateCheckBoxes(Fmx::Frxfmx::TfrxListBox* aListBox);
	void __fastcall LBButtonClick(System::TObject* Sender, System::TObject* aButton, Fmx::Frxfmx::TfrxListBoxItem* aItem);
	void __fastcall LBCheckChange(System::TObject* Sender);
	
public:
	__fastcall virtual TfrxCrossEditorForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxCrossEditorForm(void);
	__property Fmx::Frxcross::TfrxCustomCrossView* Cross = {read=FCross, write=FCross};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxCrossEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxcrosseditor */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXCROSSEDITOR)
using namespace Fmx::Frxcrosseditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxcrosseditorHPP
