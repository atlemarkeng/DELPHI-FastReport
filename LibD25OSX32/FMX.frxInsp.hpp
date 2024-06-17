// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxInsp.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxinspHPP
#define Fmx_FrxinspHPP

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
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxDsgnIntf.hpp>
#include <System.Types.hpp>
#include <System.UIConsts.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.Menus.hpp>
#include <FMX.Types.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Platform.hpp>
#include <System.Variants.hpp>
#include <FMX.TreeView.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxinsp
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxObjectInspector;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxObjectInspector : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Menus::TPopupMenu* PopupMenu1;
	Fmx::Menus::TMenuItem* N11;
	Fmx::Menus::TMenuItem* N21;
	Fmx::Menus::TMenuItem* N31;
	Fmx::Menus::TMenuItem* N41;
	Fmx::Menus::TMenuItem* N51;
	Fmx::Menus::TMenuItem* N61;
	Fmx::Stdctrls::TPanel* MainPanel;
	Fmx::Stdctrls::TPanel* BackPanel;
	Fmx::Stdctrls::TSplitter* Splitter1;
	Fmx::Layouts::TFramedScrollBox* Box;
	Fmx::Objects::TPaintBox* PB;
	Fmx::Edit::TEdit* Edit1;
	Fmx::Stdctrls::TPanel* EditPanel;
	Fmx::Stdctrls::TSpeedButton* EditBtn;
	Fmx::Stdctrls::TPanel* ComboPanel;
	Fmx::Stdctrls::TSpeedButton* ComboBtn;
	Fmx::Stdctrls::TPanel* HintPanel;
	Fmx::Stdctrls::TLabel* PropL;
	Fmx::Stdctrls::TLabel* DescrL;
	Fmx::Listbox::TComboBox* ObjectsCB;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Objects::TRectangle* Rectangle1;
	Fmx::Controls::TStyleBook* StyleBook1;
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall PBPaint(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas);
	void __fastcall PBMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall PBMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall PBMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall Edit1KeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall EditBtnClick(System::TObject* Sender);
	void __fastcall ComboBtnClick(System::TObject* Sender);
	void __fastcall ObjectsCBClick(System::TObject* Sender);
	void __fastcall PBDblClick(System::TObject* Sender);
	void __fastcall FormMouseWheelDown(System::TObject* Sender, System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall FormMouseWheelUp(System::TObject* Sender, System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall TabChange(System::TObject* Sender);
	void __fastcall N11Click(System::TObject* Sender);
	void __fastcall N21Click(System::TObject* Sender);
	void __fastcall N31Click(System::TObject* Sender);
	void __fastcall FormDeactivate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	
private:
	Fmx::Frxclass::TfrxCustomDesigner* FDesigner;
	bool FDisableDblClick;
	bool FDisableUpdate;
	bool FDown;
	Fmx::Frxdsgnintf::TfrxPropertyList* FEventList;
	int FItemIndex;
	System::UnicodeString FLastPosition;
	Fmx::Frxdsgnintf::TfrxPropertyList* FList;
	Fmx::Controls::TPopup* FPopupForm;
	Fmx::Listbox::TListBox* FPopupLB;
	Fmx::Frxdsgnintf::TfrxPropertyList* FPropertyList;
	Fmx::Stdctrls::TPanel* FPanel;
	float FRowHeight;
	System::Classes::TList* FSelectedObjects;
	float FSplitterPos;
	Fmx::Tabcontrol::TTabControl* FTabs;
	System::Classes::TList* FTempList;
	bool FUpdatingObjectsCB;
	bool FUpdatingPB;
	System::Classes::TNotifyEvent FOnSelectionChanged;
	System::Classes::TNotifyEvent FOnModify;
	Fmx::Graphics::TCanvas* FFastCanvas;
	int __fastcall Count(void);
	Fmx::Frxdsgnintf::TfrxPropertyItem* __fastcall GetItem(int Index);
	System::UnicodeString __fastcall GetName(int Index);
	int __fastcall GetOffset(int Index);
	Fmx::Frxdsgnintf::TfrxPropertyAttributes __fastcall GetType(int Index);
	System::UnicodeString __fastcall GetValue(int Index);
	void __fastcall AdjustControls(void);
	void __fastcall DrawOneLine(Fmx::Graphics::TCanvas* Canvas, int i, bool Selected);
	void __fastcall DoModify(void);
	void __fastcall SetObjects(System::Classes::TList* Value);
	void __fastcall SetItemIndex(int Value);
	void __fastcall SetSelectedObjects(System::Classes::TList* Value);
	void __fastcall SetValue(int Index, System::UnicodeString Value);
	void __fastcall LBClick(System::TObject* Sender);
	void __fastcall ClosePopup(System::TObject* Sender);
	int __fastcall GetSplitter1Pos(void);
	void __fastcall SetSplitter1Pos(const int Value);
	
public:
	__fastcall virtual TfrxObjectInspector(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxObjectInspector(void);
	void __fastcall DisableUpdate(void);
	void __fastcall EnableUpdate(void);
	void __fastcall Inspect(System::Classes::TPersistent* *AObjects, const int AObjects_High);
	void __fastcall UpdateProperties(void);
	void __fastcall DoResize(void);
	__property System::Classes::TList* Objects = {write=SetObjects};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, nodefault};
	__property System::Classes::TList* SelectedObjects = {read=FSelectedObjects, write=SetSelectedObjects};
	__property float SplitterPos = {read=FSplitterPos, write=FSplitterPos};
	__property int Splitter1Pos = {read=GetSplitter1Pos, write=SetSplitter1Pos, nodefault};
	__property System::Classes::TNotifyEvent OnModify = {read=FOnModify, write=FOnModify};
	__property System::Classes::TNotifyEvent OnSelectionChanged = {read=FOnSelectionChanged, write=FOnSelectionChanged};
	__property Fmx::Graphics::TCanvas* FastCanvas = {read=FFastCanvas, write=FFastCanvas};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxObjectInspector(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxinsp */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXINSP)
using namespace Fmx::Frxinsp;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxinspHPP
