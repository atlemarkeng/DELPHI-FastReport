// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxChartEditor.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxcharteditorHPP
#define Fmx_FrxcharteditorHPP

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
#include <FMX.Menus.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxChart.hpp>
#include <FMX.frxCustomEditors.hpp>
#include <FMX.frxCtrls.hpp>
#include <FMX.frxInsp.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.TreeView.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <System.Variants.hpp>
#include <FMX.frxFMX.hpp>
#include <FMXTee.Chart.GalleryPanel.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.ComboEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxcharteditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxChartEditor;
class DELPHICLASS TfrxChartEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxChartEditor : public Fmx::Frxcustomeditors::TfrxViewEditor
{
	typedef Fmx::Frxcustomeditors::TfrxViewEditor inherited;
	
public:
	virtual bool __fastcall Edit(void);
	virtual bool __fastcall HasEditor(void);
	virtual void __fastcall GetMenuItems(System::Classes::TNotifyEvent OnClickEvent);
	virtual bool __fastcall Execute(int Tag, bool Checked);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall TfrxChartEditor(Fmx::Frxclass::TfrxComponent* Component, Fmx::Frxclass::TfrxCustomDesigner* Designer, Fmx::Menus::TPopupMenu* Menu) : Fmx::Frxcustomeditors::TfrxViewEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxChartEditor(void) { }
	
};


class PASCALIMPLEMENTATION TfrxChartEditorForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OkB;
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Stdctrls::TPanel* Panel2;
	Fmx::Stdctrls::TButton* CancelB;
	Fmx::Stdctrls::TPanel* SourcePanel;
	Fmx::Stdctrls::TGroupBox* DataSourceGB;
	Fmx::Stdctrls::TRadioButton* DBSourceRB;
	Fmx::Stdctrls::TRadioButton* BandSourceRB;
	Fmx::Stdctrls::TRadioButton* FixedDataRB;
	Fmx::Listbox::TComboBox* DatasetsCB;
	Fmx::Listbox::TComboBox* DatabandsCB;
	Fmx::Stdctrls::TGroupBox* ValuesGB;
	Fmx::Comboedit::TComboEdit* Values1CB;
	Fmx::Stdctrls::TLabel* Values1L;
	Fmx::Stdctrls::TLabel* Values2L;
	Fmx::Comboedit::TComboEdit* Values2CB;
	Fmx::Stdctrls::TLabel* Values3L;
	Fmx::Comboedit::TComboEdit* Values3CB;
	Fmx::Stdctrls::TLabel* Values4L;
	Fmx::Comboedit::TComboEdit* Values4CB;
	Fmx::Stdctrls::TGroupBox* OptionsGB;
	Fmx::Stdctrls::TLabel* ShowTopLbl;
	Fmx::Stdctrls::TLabel* CaptionLbl;
	Fmx::Stdctrls::TLabel* SortLbl;
	Fmx::Stdctrls::TLabel* XLbl;
	Fmx::Edit::TEdit* TopNE;
	Fmx::Edit::TEdit* TopNCaptionE;
	Fmx::Listbox::TComboBox* SortCB;
	Fmx::Listbox::TComboBox* XTypeCB;
	Fmx::Stdctrls::TPanel* InspSite;
	Fmx::Stdctrls::TLabel* Values5L;
	Fmx::Comboedit::TComboEdit* Values5CB;
	Fmx::Stdctrls::TLabel* HintL;
	Fmx::Stdctrls::TLabel* Values6L;
	Fmx::Comboedit::TComboEdit* Values6CB;
	Fmx::Stdctrls::TPanel* Panel3;
	Fmx::Stdctrls::TPanel* TreePanel;
	Fmx::Stdctrls::TSpeedButton* AddB;
	Fmx::Stdctrls::TSpeedButton* DeleteB;
	Fmx::Stdctrls::TSpeedButton* EditB;
	Fmx::Stdctrls::TSpeedButton* UPB;
	Fmx::Stdctrls::TSpeedButton* DownB;
	Fmx::Frxfmx::TfrxTreeView* ChartTree;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ChartTreeClick(System::TObject* Sender);
	void __fastcall AddBClick(System::TObject* Sender);
	void __fastcall DeleteBClick(System::TObject* Sender);
	void __fastcall DoClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall UpDown1Click(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall DatasetsCBClick(System::TObject* Sender);
	void __fastcall DatabandsCBClick(System::TObject* Sender);
	void __fastcall DBSourceRBClick(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall EditBClick(System::TObject* Sender);
	void __fastcall ChartTreeEdited(System::TObject* Sender, Fmx::Frxfmx::TfrxTreeViewItem* Node, System::UnicodeString &S);
	void __fastcall ChartTreeEditing(System::TObject* Sender, Fmx::Frxfmx::TfrxTreeViewItem* OldNode, Fmx::Frxfmx::TfrxTreeViewItem* NewNode);
	void __fastcall UPBClick(System::TObject* Sender);
	void __fastcall DownBClick(System::TObject* Sender);
	
private:
	Fmx::Frxchart::TfrxChartView* FChart;
	Fmx::Frxchart::TfrxSeriesItem* FCurSeries;
	Fmx::Frxinsp::TfrxObjectInspector* FInspector;
	bool FModified;
	Fmx::Frxclass::TfrxReport* FReport;
	bool FUpdating;
	float FValuesGBHeight;
	void __fastcall FillDropDownLists(Fmx::Frxclass::TfrxDataSet* ds);
	void __fastcall SetCurSeries(Fmx::Frxchart::TfrxSeriesItem* const Value);
	void __fastcall SetModified(const bool Value);
	void __fastcall ShowSeriesData(void);
	void __fastcall UpdateSeriesData(void);
	__property bool Modified = {read=FModified, write=SetModified, nodefault};
	__property Fmx::Frxchart::TfrxSeriesItem* CurSeries = {read=FCurSeries, write=SetCurSeries};
	
public:
	__fastcall virtual TfrxChartEditorForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxChartEditorForm(void);
	__property Fmx::Frxchart::TfrxChartView* Chart = {read=FChart, write=FChart};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxChartEditorForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxcharteditor */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXCHARTEDITOR)
using namespace Fmx::Frxcharteditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxcharteditorHPP
