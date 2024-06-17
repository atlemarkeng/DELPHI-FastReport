// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxBarcodeEditor.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxbarcodeeditorHPP
#define Fmx_FrxbarcodeeditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Menus.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxBarcode.hpp>
#include <FMX.frxCustomEditors.hpp>
#include <System.Types.hpp>
#include <FMX.frxBarcod.hpp>
#include <FMX.frxCtrls.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Types.hpp>
#include <System.Variants.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.ComboEdit.hpp>
#include <FMX.frxDsgnIntf.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxbarcodeeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBarcodeEditor;
class DELPHICLASS TfrxBarcodeEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxBarcodeEditor : public Fmx::Frxcustomeditors::TfrxViewEditor
{
	typedef Fmx::Frxcustomeditors::TfrxViewEditor inherited;
	
public:
	virtual bool __fastcall Edit(void);
	virtual bool __fastcall HasEditor(void);
	virtual void __fastcall GetMenuItems(System::Classes::TNotifyEvent OnClickEvent);
	virtual bool __fastcall Execute(int Tag, bool Checked);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall TfrxBarcodeEditor(Fmx::Frxclass::TfrxComponent* Component, Fmx::Frxclass::TfrxCustomDesigner* Designer, Fmx::Menus::TPopupMenu* Menu) : Fmx::Frxcustomeditors::TfrxViewEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxBarcodeEditor(void) { }
	
};


class PASCALIMPLEMENTATION TfrxBarcodeEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Comboedit::TComboEdit* CodeE;
	Fmx::Stdctrls::TLabel* CodeLbl;
	Fmx::Listbox::TComboBox* TypeCB;
	Fmx::Stdctrls::TLabel* TypeLbl;
	Fmx::Objects::TPaintBox* ExamplePB;
	Fmx::Stdctrls::TGroupBox* OptionsLbl;
	Fmx::Stdctrls::TLabel* ZoomLbl;
	Fmx::Stdctrls::TCheckBox* CalcCheckSumCB;
	Fmx::Stdctrls::TCheckBox* ViewTextCB;
	Fmx::Edit::TEdit* ZoomE;
	Fmx::Stdctrls::TGroupBox* RotationLbl;
	Fmx::Stdctrls::TRadioButton* Rotation0RB;
	Fmx::Stdctrls::TRadioButton* Rotation90RB;
	Fmx::Stdctrls::TRadioButton* Rotation180RB;
	Fmx::Stdctrls::TRadioButton* Rotation270RB;
	void __fastcall ExprBtnClick(System::TObject* Sender);
	void __fastcall UpBClick(System::TObject* Sender);
	void __fastcall DownBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall ExamplePB2Paint(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas);
	void __fastcall Rotation0RBClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	Fmx::Frxbarcode::TfrxBarCodeView* FBarcode;
	
public:
	__property Fmx::Frxbarcode::TfrxBarCodeView* Barcode = {read=FBarcode, write=FBarcode};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxBarcodeEditorForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxBarcodeEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxBarcodeEditorForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbarcodeeditor */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXBARCODEEDITOR)
using namespace Fmx::Frxbarcodeeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxbarcodeeditorHPP
