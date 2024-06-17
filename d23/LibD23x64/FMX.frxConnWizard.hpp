// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxConnWizard.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxconnwizardHPP
#define Fmx_FrxconnwizardHPP

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
#include <FMX.frxFMX.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.fs_synmemo.hpp>
#include <FMX.frxCustomDB.hpp>
#include <FMX.Types.hpp>
#include <System.Variants.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxconnwizard
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxDBConnWizard;
class DELPHICLASS TfrxDBTableWizard;
class DELPHICLASS TfrxDBQueryWizard;
class DELPHICLASS TfrxConnectionWizardForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxDBConnWizard : public Fmx::Frxclass::TfrxCustomWizard
{
	typedef Fmx::Frxclass::TfrxCustomWizard inherited;
	
private:
	Fmx::Frxclass::TfrxCustomDatabase* FDatabase;
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual bool __fastcall Execute(void);
	__property Fmx::Frxclass::TfrxCustomDatabase* Database = {read=FDatabase, write=FDatabase};
public:
	/* TfrxCustomWizard.Create */ inline __fastcall virtual TfrxDBConnWizard(System::Classes::TComponent* AOwner) : Fmx::Frxclass::TfrxCustomWizard(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxDBConnWizard(void) { }
	
};


class PASCALIMPLEMENTATION TfrxDBTableWizard : public Fmx::Frxclass::TfrxCustomWizard
{
	typedef Fmx::Frxclass::TfrxCustomWizard inherited;
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual bool __fastcall Execute(void);
public:
	/* TfrxCustomWizard.Create */ inline __fastcall virtual TfrxDBTableWizard(System::Classes::TComponent* AOwner) : Fmx::Frxclass::TfrxCustomWizard(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxDBTableWizard(void) { }
	
};


class PASCALIMPLEMENTATION TfrxDBQueryWizard : public Fmx::Frxclass::TfrxCustomWizard
{
	typedef Fmx::Frxclass::TfrxCustomWizard inherited;
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual bool __fastcall Execute(void);
public:
	/* TfrxCustomWizard.Create */ inline __fastcall virtual TfrxDBQueryWizard(System::Classes::TComponent* AOwner) : Fmx::Frxclass::TfrxCustomWizard(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxDBQueryWizard(void) { }
	
};


class PASCALIMPLEMENTATION TfrxConnectionWizardForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OKB;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Tabcontrol::TTabControl* PageControl1;
	Fmx::Tabcontrol::TTabItem* ConnTS;
	Fmx::Tabcontrol::TTabItem* TableTS;
	Fmx::Stdctrls::TLabel* ConnL1;
	Fmx::Stdctrls::TLabel* DBL;
	Fmx::Stdctrls::TLabel* LoginL;
	Fmx::Stdctrls::TLabel* PasswordL;
	Fmx::Stdctrls::TSpeedButton* ChooseB;
	Fmx::Listbox::TComboBox* ConnCB;
	Fmx::Edit::TEdit* DatabaseE;
	Fmx::Edit::TEdit* LoginE;
	Fmx::Edit::TEdit* PasswordE;
	Fmx::Stdctrls::TRadioButton* PromptRB;
	Fmx::Stdctrls::TRadioButton* LoginRB;
	Fmx::Stdctrls::TLabel* ConnL2;
	Fmx::Listbox::TComboBox* ConnCB1;
	Fmx::Stdctrls::TLabel* TableL;
	Fmx::Listbox::TComboBox* TableCB;
	Fmx::Stdctrls::TCheckBox* FilterCB;
	Fmx::Edit::TEdit* FilterE;
	Fmx::Tabcontrol::TTabItem* QueryTS;
	Fmx::Stdctrls::TLabel* ConnL3;
	Fmx::Listbox::TComboBox* ConnCB2;
	Fmx::Stdctrls::TLabel* QueryL;
	Fmx::Stdctrls::TToolBar* ToolBar1;
	Fmx::Frxfmx::TfrxToolButton* BuildSQLB;
	Fmx::Frxfmx::TfrxToolButton* ParamsB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ChooseBClick(System::TObject* Sender);
	void __fastcall ConnCBClick(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ConnCB1Click(System::TObject* Sender);
	void __fastcall ConnCB2Click(System::TObject* Sender);
	void __fastcall BuildSQLBClick(System::TObject* Sender);
	void __fastcall ParamsBClick(System::TObject* Sender);
	void __fastcall OKBClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	Fmx::Frxclass::TfrxComponent* FComponent;
	Fmx::Frxclass::TfrxCustomDatabase* FDatabase;
	Fmx::Frxclass::TfrxCustomDesigner* FDesigner;
	int FItem;
	int FItemIndex;
	Fmx::Fs_synmemo::TfsSyntaxMemo* FMemo;
	int FOldItem;
	Fmx::Frxclass::TfrxPage* FPage;
	Fmx::Frxcustomdb::TfrxCustomQuery* FQuery;
	Fmx::Frxclass::TfrxReport* FReport;
	Fmx::Frxcustomdb::TfrxCustomTable* FTable;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxConnectionWizardForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxConnectionWizardForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxConnectionWizardForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxconnwizard */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXCONNWIZARD)
using namespace Fmx::Frxconnwizard;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxconnwizardHPP
