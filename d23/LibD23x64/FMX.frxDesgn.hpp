// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxDesgn.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxdesgnHPP
#define Fmx_FrxdesgnHPP

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
#include <FMX.Types.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Menus.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxCtrls.hpp>
#include <FMX.frxDesgnCtrls.hpp>
#include <FMX.frxDesgnWorkspace.hpp>
#include <FMX.frxInsp.hpp>
#include <FMX.frxDialogForm.hpp>
#include <FMX.frxDataTree.hpp>
#include <FMX.frxReportTree.hpp>
#include <FMX.fs_synmemo.hpp>
#include <FMX.fs_iinterpreter.hpp>
#include <FMX.Printer.hpp>
#include <FMX.frxWatchForm.hpp>
#include <FMX.frxPictureCache.hpp>
#include <System.Variants.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Edit.hpp>
#include <System.UIConsts.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <System.Math.Vectors.hpp>
#include <FMX.ComboEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxdesgn
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxDesigner;
class DELPHICLASS TfrxDesignerForm;
class DELPHICLASS TSampleFormat;
class DELPHICLASS TfrxCustomSavePlugin;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxDesignerUnits : unsigned char { duCM, duInches, duPixels, duChars };

typedef bool __fastcall (__closure *TfrxLoadReportEvent)(Fmx::Frxclass::TfrxReport* Report);

typedef bool __fastcall (__closure *TfrxLoadRecentReportEvent)(Fmx::Frxclass::TfrxReport* Report, System::UnicodeString FileName);

typedef bool __fastcall (__closure *TfrxSaveReportEvent)(Fmx::Frxclass::TfrxReport* Report, bool SaveAs);

typedef void __fastcall (__closure *TfrxGetTemplateListEvent)(System::Classes::TStrings* List);

enum DECLSPEC_DENUM TfrxDesignerRestriction : unsigned char { drDontInsertObject, drDontDeletePage, drDontCreatePage, drDontChangePageOptions, drDontCreateReport, drDontLoadReport, drDontSaveReport, drDontPreviewReport, drDontEditVariables, drDontChangeReportOptions, drDontEditReportData, drDontShowRecentFiles, drDontEditReportScript, drDontEditInternalDatasets };

typedef System::Set<TfrxDesignerRestriction, TfrxDesignerRestriction::drDontInsertObject, TfrxDesignerRestriction::drDontEditInternalDatasets> TfrxDesignerRestrictions;

class PASCALIMPLEMENTATION TfrxDesigner : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FCloseQuery;
	System::UnicodeString FDefaultScriptLanguage;
	Fmx::Frxfmx::TfrxFont* FDefaultFont;
	double FDefaultLeftMargin;
	double FDefaultBottomMargin;
	double FDefaultRightMargin;
	double FDefaultTopMargin;
	int FDefaultPaperSize;
	System::Uitypes::TPrinterOrientation FDefaultOrientation;
	System::UnicodeString FOpenDir;
	System::UnicodeString FSaveDir;
	System::UnicodeString FTemplatesExt;
	System::UnicodeString FTemplateDir;
	bool FStandalone;
	TfrxDesignerRestrictions FRestrictions;
	bool FRTLLanguage;
	bool FMemoParentFont;
	TfrxLoadReportEvent FOnLoadReport;
	TfrxLoadRecentReportEvent FOnLoadRecentReport;
	TfrxSaveReportEvent FOnSaveReport;
	System::Classes::TNotifyEvent FOnShow;
	System::Classes::TNotifyEvent FOnInsertObject;
	TfrxGetTemplateListEvent FOnGetTemplateList;
	System::Classes::TNotifyEvent FOnShowStartupScreen;
	void __fastcall SetDefaultFont(Fmx::Frxfmx::TfrxFont* const Value);
	
public:
	__fastcall virtual TfrxDesigner(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxDesigner(void);
	
__published:
	__property bool CloseQuery = {read=FCloseQuery, write=FCloseQuery, default=1};
	__property System::UnicodeString DefaultScriptLanguage = {read=FDefaultScriptLanguage, write=FDefaultScriptLanguage};
	__property Fmx::Frxfmx::TfrxFont* DefaultFont = {read=FDefaultFont, write=SetDefaultFont};
	__property double DefaultLeftMargin = {read=FDefaultLeftMargin, write=FDefaultLeftMargin};
	__property double DefaultRightMargin = {read=FDefaultRightMargin, write=FDefaultRightMargin};
	__property double DefaultTopMargin = {read=FDefaultTopMargin, write=FDefaultTopMargin};
	__property double DefaultBottomMargin = {read=FDefaultBottomMargin, write=FDefaultBottomMargin};
	__property int DefaultPaperSize = {read=FDefaultPaperSize, write=FDefaultPaperSize, nodefault};
	__property System::Uitypes::TPrinterOrientation DefaultOrientation = {read=FDefaultOrientation, write=FDefaultOrientation, nodefault};
	__property System::UnicodeString OpenDir = {read=FOpenDir, write=FOpenDir};
	__property System::UnicodeString SaveDir = {read=FSaveDir, write=FSaveDir};
	__property System::UnicodeString TemplatesExt = {read=FTemplatesExt, write=FTemplatesExt};
	__property System::UnicodeString TemplateDir = {read=FTemplateDir, write=FTemplateDir};
	__property bool Standalone = {read=FStandalone, write=FStandalone, default=0};
	__property TfrxDesignerRestrictions Restrictions = {read=FRestrictions, write=FRestrictions, nodefault};
	__property bool RTLLanguage = {read=FRTLLanguage, write=FRTLLanguage, nodefault};
	__property bool MemoParentFont = {read=FMemoParentFont, write=FMemoParentFont, nodefault};
	__property TfrxLoadReportEvent OnLoadReport = {read=FOnLoadReport, write=FOnLoadReport};
	__property TfrxLoadRecentReportEvent OnLoadRecentReport = {read=FOnLoadRecentReport, write=FOnLoadRecentReport};
	__property TfrxSaveReportEvent OnSaveReport = {read=FOnSaveReport, write=FOnSaveReport};
	__property System::Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property System::Classes::TNotifyEvent OnInsertObject = {read=FOnInsertObject, write=FOnInsertObject};
	__property System::Classes::TNotifyEvent OnShowStartupScreen = {read=FOnShowStartupScreen, write=FOnShowStartupScreen};
	__property TfrxGetTemplateListEvent OnGetTemplateList = {read=FOnGetTemplateList, write=FOnGetTemplateList};
};


class PASCALIMPLEMENTATION TfrxDesignerForm : public Fmx::Frxclass::TfrxCustomDesigner
{
	typedef Fmx::Frxclass::TfrxCustomDesigner inherited;
	
__published:
	Fmx::Stdctrls::TStatusBar* StatusBar;
	Fmx::Menus::TPopupMenu* PagePopup;
	Fmx::Menus::TMenuBar* MainMenu;
	Fmx::Menus::TMenuItem* FileMenu;
	Fmx::Menus::TMenuItem* EditMenu;
	Fmx::Menus::TMenuItem* ViewMenu;
	Fmx::Menus::TMenuItem* OptionsMI;
	Fmx::Menus::TMenuItem* HelpMenu;
	Fmx::Menus::TMenuItem* AboutMI;
	Fmx::Dialogs::TOpenDialog* OpenDialog;
	Fmx::Dialogs::TSaveDialog* SaveDialog;
	Fmx::Menus::TPopupMenu* TabPopup;
	Fmx::Menus::TMenuItem* NewPageMI1;
	Fmx::Menus::TMenuItem* NewDialogMI1;
	Fmx::Menus::TMenuItem* DeletePageMI1;
	Fmx::Menus::TMenuItem* PageSettingsMI1;
	Fmx::Menus::TMenuItem* NewMI;
	Fmx::Menus::TMenuItem* NewReportMI;
	Fmx::Menus::TMenuItem* NewPageMI;
	Fmx::Menus::TMenuItem* NewDialogMI;
	Fmx::Menus::TMenuItem* OpenMI;
	Fmx::Menus::TMenuItem* SaveMI;
	Fmx::Menus::TMenuItem* SaveAsMI;
	Fmx::Menus::TMenuItem* VariablesMI;
	Fmx::Menus::TMenuItem* PreviewMI;
	Fmx::Menus::TMenuItem* ExitMI;
	Fmx::Menus::TMenuItem* UndoMI;
	Fmx::Menus::TMenuItem* RedoMI;
	Fmx::Menus::TMenuItem* CutMI;
	Fmx::Menus::TMenuItem* CopyMI;
	Fmx::Menus::TMenuItem* PasteMI;
	Fmx::Menus::TMenuItem* DeleteMI;
	Fmx::Menus::TMenuItem* DeletePageMI;
	Fmx::Menus::TMenuItem* SelectAllMI;
	Fmx::Menus::TMenuItem* BringtoFrontMI;
	Fmx::Menus::TMenuItem* SendtoBackMI;
	Fmx::Menus::TMenuItem* EditMI;
	Fmx::Stdctrls::TToolBar* ObjectsTB1;
	Fmx::Menus::TPopupMenu* BandsPopup;
	Fmx::Menus::TMenuItem* ReportTitleMI;
	Fmx::Menus::TMenuItem* ReportSummaryMI;
	Fmx::Menus::TMenuItem* PageHeaderMI;
	Fmx::Menus::TMenuItem* PageFooterMI;
	Fmx::Menus::TMenuItem* HeaderMI;
	Fmx::Menus::TMenuItem* FooterMI;
	Fmx::Menus::TMenuItem* MasterDataMI;
	Fmx::Menus::TMenuItem* DetailDataMI;
	Fmx::Menus::TMenuItem* SubdetailDataMI;
	Fmx::Menus::TMenuItem* GroupHeaderMI;
	Fmx::Menus::TMenuItem* GroupFooterMI;
	Fmx::Menus::TMenuItem* ColumnHeaderMI;
	Fmx::Menus::TMenuItem* ColumnFooterMI;
	Fmx::Menus::TMenuItem* ChildMI;
	Fmx::Menus::TMenuItem* PageSettingsMI;
	Fmx::Types::TTimer* Timer;
	Fmx::Menus::TMenuItem* ReportSettingsMI;
	Fmx::Menus::TMenuItem* Data4levelMI;
	Fmx::Menus::TMenuItem* Data5levelMI;
	Fmx::Menus::TMenuItem* Data6levelMI;
	Fmx::Menus::TMenuItem* ShowGuidesMI;
	Fmx::Menus::TMenuItem* ShowRulersMI;
	Fmx::Menus::TMenuItem* DeleteGuidesMI;
	Fmx::Menus::TPopupMenu* RotationPopup;
	Fmx::Menus::TMenuItem* R0MI;
	Fmx::Menus::TMenuItem* R45MI;
	Fmx::Menus::TMenuItem* R90MI;
	Fmx::Menus::TMenuItem* R180MI;
	Fmx::Menus::TMenuItem* R270MI;
	Fmx::Menus::TMenuItem* ReportMenu;
	Fmx::Menus::TMenuItem* ReportDataMI;
	Fmx::Dialogs::TOpenDialog* OpenScriptDialog;
	Fmx::Dialogs::TSaveDialog* SaveScriptDialog;
	Fmx::Menus::TPopupMenu* ObjectsPopup;
	Fmx::Menus::TMenuItem* OverlayMI;
	Fmx::Menus::TMenuItem* ReportStylesMI;
	Fmx::Menus::TMenuItem* N2;
	Fmx::Menus::TMenuItem* FindMI;
	Fmx::Menus::TMenuItem* FindNextMI;
	Fmx::Menus::TMenuItem* ReplaceMI;
	Fmx::Menus::TPopupMenu* DMPPopup;
	Fmx::Menus::TMenuItem* BoldMI;
	Fmx::Menus::TMenuItem* ItalicMI;
	Fmx::Menus::TMenuItem* UnderlineMI;
	Fmx::Menus::TMenuItem* SuperScriptMI;
	Fmx::Menus::TMenuItem* SubScriptMI;
	Fmx::Menus::TMenuItem* CondensedMI;
	Fmx::Menus::TMenuItem* WideMI;
	Fmx::Menus::TMenuItem* N12cpiMI;
	Fmx::Menus::TMenuItem* N15cpiMI;
	Fmx::Menus::TMenuItem* VerticalbandsMI;
	Fmx::Menus::TMenuItem* HeaderMI1;
	Fmx::Menus::TMenuItem* FooterMI1;
	Fmx::Menus::TMenuItem* MasterDataMI1;
	Fmx::Menus::TMenuItem* DetailDataMI1;
	Fmx::Menus::TMenuItem* SubdetailDataMI1;
	Fmx::Menus::TMenuItem* GroupHeaderMI1;
	Fmx::Menus::TMenuItem* GroupFooterMI1;
	Fmx::Menus::TMenuItem* ChildMI1;
	Fmx::Menus::TMenuItem* N3;
	Fmx::Menus::TMenuItem* GroupMI;
	Fmx::Menus::TMenuItem* UngroupMI;
	Fmx::Stdctrls::TPanel* BackPanel;
	Fmx::Stdctrls::TPanel* ScrollBoxPanel;
	Fmx::Frxdesgnctrls::TfrxScrollBox* ScrollBox;
	Fmx::Frxdesgnctrls::TfrxRuler* LeftRuler;
	Fmx::Frxdesgnctrls::TfrxRuler* TopRuler;
	Fmx::Stdctrls::TPanel* CodePanel;
	Fmx::Stdctrls::TToolBar* CodeTB;
	Fmx::Frxfmx::TfrxToolButton* OpenScriptB;
	Fmx::Frxfmx::TfrxToolButton* SaveScriptB;
	Fmx::Frxfmx::TfrxToolButton* RunScriptB;
	Fmx::Frxfmx::TfrxToolButton* RunToCursorB;
	Fmx::Frxfmx::TfrxToolButton* StepScriptB;
	Fmx::Frxfmx::TfrxToolButton* StopScriptB;
	Fmx::Frxfmx::TfrxToolButton* EvaluateB;
	Fmx::Frxfmx::TfrxToolButton* BreakPointB;
	Fmx::Stdctrls::TPanel* TabPanel;
	Fmx::Stdctrls::TToolBar* TopToolBox;
	Fmx::Stdctrls::TToolBar* AlignTB;
	Fmx::Frxfmx::TfrxToolButton* AlignLeftsB;
	Fmx::Frxfmx::TfrxToolButton* AlignHorzCentersB;
	Fmx::Frxfmx::TfrxToolButton* AlignRightsB;
	Fmx::Frxfmx::TfrxToolButton* AlignTopsB;
	Fmx::Frxfmx::TfrxToolButton* AlignVertCentersB;
	Fmx::Frxfmx::TfrxToolButton* AlignBottomsB;
	Fmx::Frxfmx::TfrxToolButton* SpaceHorzB;
	Fmx::Frxfmx::TfrxToolButton* SpaceVertB;
	Fmx::Frxfmx::TfrxToolButton* CenterHorzB;
	Fmx::Frxfmx::TfrxToolButton* CenterVertB;
	Fmx::Frxfmx::TfrxToolButton* SameWidthB;
	Fmx::Frxfmx::TfrxToolButton* SameHeightB;
	Fmx::Stdctrls::TToolBar* ExtraToolsTB;
	Fmx::Stdctrls::TToolBar* FrameTB;
	Fmx::Frxfmx::TfrxToolButton* FrameTopB;
	Fmx::Frxfmx::TfrxToolButton* FrameBottomB;
	Fmx::Frxfmx::TfrxToolButton* FrameLeftB;
	Fmx::Frxfmx::TfrxToolButton* FrameRightB;
	Fmx::Frxfmx::TfrxToolButton* FrameAllB;
	Fmx::Frxfmx::TfrxToolButton* FrameNoB;
	Fmx::Frxfmx::TfrxToolButton* ShadowB;
	Fmx::Frxfmx::TfrxToolButton* FillColorB;
	Fmx::Frxfmx::TfrxToolButton* FrameColorB;
	Fmx::Frxfmx::TfrxToolButton* FrameStyleB;
	Fmx::Stdctrls::TToolBar* StandardTB;
	Fmx::Frxfmx::TfrxToolButton* NewB;
	Fmx::Frxfmx::TfrxToolButton* OpenB;
	Fmx::Frxfmx::TfrxToolButton* SaveB;
	Fmx::Frxfmx::TfrxToolButton* PreviewB;
	Fmx::Frxfmx::TfrxToolButton* NewPageB;
	Fmx::Frxfmx::TfrxToolButton* NewDialogB;
	Fmx::Frxfmx::TfrxToolButton* DeletePageB;
	Fmx::Frxfmx::TfrxToolButton* PageSettingsB;
	Fmx::Frxfmx::TfrxToolButton* CutB;
	Fmx::Frxfmx::TfrxToolButton* CopyB;
	Fmx::Frxfmx::TfrxToolButton* PasteB;
	Fmx::Frxfmx::TfrxToolButton* UndoB;
	Fmx::Frxfmx::TfrxToolButton* RedoB;
	Fmx::Frxfmx::TfrxToolButton* GroupB;
	Fmx::Frxfmx::TfrxToolButton* UngroupB;
	Fmx::Frxfmx::TfrxToolButton* ShowGridB;
	Fmx::Frxfmx::TfrxToolButton* AlignToGridB;
	Fmx::Frxfmx::TfrxToolButton* SetToGridB;
	Fmx::Stdctrls::TToolBar* TextTB;
	Fmx::Frxfmx::TfrxToolButton* BoldB;
	Fmx::Frxfmx::TfrxToolButton* ItalicB;
	Fmx::Frxfmx::TfrxToolButton* UnderlineB;
	Fmx::Frxfmx::TfrxToolButton* FontB;
	Fmx::Frxfmx::TfrxToolButton* FontColorB;
	Fmx::Frxfmx::TfrxToolButton* HighlightB;
	Fmx::Frxfmx::TfrxToolButton* RotateB;
	Fmx::Frxfmx::TfrxToolButton* TextAlignLeftB;
	Fmx::Frxfmx::TfrxToolButton* TextAlignCenterB;
	Fmx::Frxfmx::TfrxToolButton* TextAlignRightB;
	Fmx::Frxfmx::TfrxToolButton* TextAlignBlockB;
	Fmx::Frxfmx::TfrxToolButton* TextAlignTopB;
	Fmx::Frxfmx::TfrxToolButton* TextAlignMiddleB;
	Fmx::Frxfmx::TfrxToolButton* TextAlignBottomB;
	Fmx::Comboedit::TComboEdit* ScaleCB;
	Fmx::Comboedit::TComboEdit* LangCB;
	Fmx::Comboedit::TComboEdit* FrameWidthCB;
	Fmx::Comboedit::TComboEdit* FontNameCB;
	Fmx::Comboedit::TComboEdit* StyleCB;
	Fmx::Comboedit::TComboEdit* FontSizeCB;
	Fmx::Stdctrls::TToolBar* RightDockTB;
	Fmx::Stdctrls::TSplitter* Splitter1;
	Fmx::Stdctrls::TToolBar* LeftDockTB;
	Fmx::Stdctrls::TSplitter* Splitter2;
	Fmx::Controls::TStyleBook* StyleBook1;
	Fmx::Frxfmx::TfrxToolSeparator* Sep1;
	Fmx::Frxfmx::TfrxToolSeparator* Sep2;
	Fmx::Frxfmx::TfrxToolSeparator* Sep4;
	Fmx::Frxfmx::TfrxToolSeparator* Sep5;
	Fmx::Frxfmx::TfrxToolSeparator* Sep6;
	Fmx::Frxfmx::TfrxToolSeparator* Sep7;
	Fmx::Frxfmx::TfrxToolSeparator* Sep8;
	Fmx::Frxfmx::TfrxToolSeparator* Sep9;
	Fmx::Frxfmx::TfrxToolSeparator* Sep10;
	Fmx::Frxfmx::TfrxToolSeparator* Sep11;
	Fmx::Frxfmx::TfrxToolSeparator* Sep12;
	Fmx::Frxfmx::TfrxToolSeparator* Sep13;
	Fmx::Frxfmx::TfrxToolSeparator* Sep14;
	Fmx::Frxfmx::TfrxToolGrip* Grip1;
	Fmx::Frxfmx::TfrxToolGrip* Grip2;
	Fmx::Frxfmx::TfrxToolGrip* Grip3;
	Fmx::Frxfmx::TfrxToolGrip* Grip4;
	Fmx::Stdctrls::TCalloutPanel* HintPanel;
	Fmx::Stdctrls::TLabel* Label1;
	void __fastcall ExitCmdExecute(System::TObject* Sender);
	void __fastcall ObjectsButtonClick(System::TObject* Sender);
	void __fastcall ScrollBoxMouseWheelUp(System::TObject* Sender, System::Classes::TShiftState Shift, int WheelDelta, bool &Handled);
	void __fastcall ScrollBoxMouseWheelDown(System::TObject* Sender, System::Classes::TShiftState Shift, int WheelDelta, bool &Handled);
	void __fastcall ScrollBoxResize(System::TObject* Sender);
	void __fastcall ScaleCBClick(System::TObject* Sender);
	void __fastcall ShowGridBClick(System::TObject* Sender);
	void __fastcall AlignToGridBClick(System::TObject* Sender);
	void __fastcall StatusBarDblClick(System::TObject* Sender);
	void __fastcall StatusBarMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall InsertBandClick(System::TObject* Sender);
	void __fastcall BandsPopupPopup(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall NewReportCmdExecute(System::TObject* Sender);
	void __fastcall ToolButtonClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall FontColorBClick(System::TObject* Sender);
	void __fastcall FrameStyleBClick(System::TObject* Sender);
	void __fastcall TabChange(System::TObject* Sender);
	void __fastcall UndoCmdExecute(System::TObject* Sender);
	void __fastcall RedoCmdExecute(System::TObject* Sender);
	void __fastcall CutCmdExecute(System::TObject* Sender);
	void __fastcall CopyCmdExecute(System::TObject* Sender);
	void __fastcall PasteCmdExecute(System::TObject* Sender);
	void __fastcall TimerTimer(System::TObject* Sender);
	void __fastcall DeletePageCmdExecute(System::TObject* Sender);
	void __fastcall NewDialogCmdExecute(System::TObject* Sender);
	void __fastcall NewPageCmdExecute(System::TObject* Sender);
	void __fastcall SaveCmdExecute(System::TObject* Sender);
	void __fastcall SaveAsCmdExecute(System::TObject* Sender);
	void __fastcall OpenCmdExecute(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall DeleteCmdExecute(System::TObject* Sender);
	void __fastcall SelectAllCmdExecute(System::TObject* Sender);
	void __fastcall EditCmdExecute(System::TObject* Sender);
	void __fastcall TabChanging(System::TObject* Sender, bool &AllowChange);
	void __fastcall PageSettingsCmdExecute(System::TObject* Sender);
	void __fastcall TopRulerDragOver(System::TObject* Sender, const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point, Fmx::Types::TDragOperation &Operation);
	void __fastcall AlignLeftsBClick(System::TObject* Sender);
	void __fastcall AlignRightsBClick(System::TObject* Sender);
	void __fastcall AlignTopsBClick(System::TObject* Sender);
	void __fastcall AlignBottomsBClick(System::TObject* Sender);
	void __fastcall AlignHorzCentersBClick(System::TObject* Sender);
	void __fastcall AlignVertCentersBClick(System::TObject* Sender);
	void __fastcall CenterHorzBClick(System::TObject* Sender);
	void __fastcall CenterVertBClick(System::TObject* Sender);
	void __fastcall SpaceHorzBClick(System::TObject* Sender);
	void __fastcall SpaceVertBClick(System::TObject* Sender);
	void __fastcall SelectToolBClick(System::TObject* Sender);
	void __fastcall RotateBClick(System::TObject* Sender);
	void __fastcall PagePopupPopup(System::TObject* Sender, float X, float Y);
	void __fastcall BringToFrontCmdExecute(System::TObject* Sender);
	void __fastcall SendToBackCmdExecute(System::TObject* Sender);
	void __fastcall LangCBClick(System::TObject* Sender);
	void __fastcall OpenScriptBClick(System::TObject* Sender);
	void __fastcall SaveScriptBClick(System::TObject* Sender);
	void __fastcall CodeWindowDragOver(System::TObject* Sender, const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point, Fmx::Types::TDragOperation &Operation);
	void __fastcall CodeWindowDragDrop(System::TObject* Sender, const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point);
	void __fastcall VariablesCmdExecute(System::TObject* Sender);
	void __fastcall ObjectBandBClick(System::TObject* Sender);
	void __fastcall PreviewCmdExecute(System::TObject* Sender);
	void __fastcall HighlightBClick(System::TObject* Sender);
	void __fastcall TabMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall TabMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall TabMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall TabDragDrop(System::TObject* Sender, const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point);
	void __fastcall TabDragOver(System::TObject* Sender, const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point, Fmx::Types::TDragOperation &Operation);
	void __fastcall SameWidthBClick(System::TObject* Sender);
	void __fastcall SameHeightBClick(System::TObject* Sender);
	void __fastcall NewItemCmdExecute(System::TObject* Sender);
	void __fastcall TabOrderMIClick(System::TObject* Sender);
	void __fastcall RunScriptBClick(System::TObject* Sender);
	void __fastcall StopScriptBClick(System::TObject* Sender);
	void __fastcall EvaluateBClick(System::TObject* Sender);
	void __fastcall GroupCmdExecute(System::TObject* Sender);
	void __fastcall UngroupCmdExecute(System::TObject* Sender);
	void __fastcall LangSelectClick(System::TObject* Sender);
	void __fastcall BreakPointBClick(System::TObject* Sender);
	void __fastcall RunToCursorBClick(System::TObject* Sender);
	void __fastcall TabSetChange(System::TObject* Sender, int NewTab, bool &AllowChange);
	virtual void __fastcall FormShow(System::TObject* Sender);
	void __fastcall AddChildMIClick(System::TObject* Sender);
	void __fastcall FindCmdExecute(System::TObject* Sender);
	void __fastcall ReplaceCmdExecute(System::TObject* Sender);
	void __fastcall FindNextCmdExecute(System::TObject* Sender);
	void __fastcall ReportDataCmdExecute(System::TObject* Sender);
	void __fastcall ReportStylesCmdExecute(System::TObject* Sender);
	void __fastcall ReportOptionsCmdExecute(System::TObject* Sender);
	void __fastcall ShowRulersCmdExecute(System::TObject* Sender);
	void __fastcall ShowGuidesCmdExecute(System::TObject* Sender);
	void __fastcall DeleteGuidesCmdExecute(System::TObject* Sender);
	void __fastcall OptionsCmdExecute(System::TObject* Sender);
	void __fastcall HelpContentsCmdExecute(System::TObject* Sender);
	void __fastcall AboutCmdExecute(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormMouseWheel(System::TObject* Sender, System::Classes::TShiftState Shift, int WheelDelta, bool &Handled);
	void __fastcall RightDockTBResize(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall LeftDockTBResize(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FrameWidthCBKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall NewPageBMouseEnter(System::TObject* Sender);
	void __fastcall NewPageBMouseLeave(System::TObject* Sender);
	void __fastcall FontBClick(System::TObject* Sender);
	
private:
	Fmx::Frxfmx::TfrxToolButton* ObjectSelectB;
	Fmx::Frxfmx::TfrxToolButton* ObjectBandB;
	Fmx::Frxdesgnctrls::TfrxClipboard* FClipboard;
	Fmx::Fs_synmemo::TfsSyntaxMemo* FCodeWindow;
	System::Uitypes::TColor FColor;
	System::UnicodeString FCoord1;
	System::UnicodeString FCoord2;
	System::UnicodeString FCoord3;
	Fmx::Frxdialogform::TfrxDialogForm* FDialogForm;
	bool FEditAfterInsert;
	Fmx::Frxdatatree::TfrxDataTreeForm* FDataTree;
	bool FDropFields;
	bool FGridAlign;
	double FGridSize1;
	double FGridSize2;
	double FGridSize3;
	double FGridSize4;
	Fmx::Frxinsp::TfrxObjectInspector* FInspector;
	Fmx::Frxclass::TfrxFrameStyle FLineStyle;
	bool FLocalizedOI;
	bool FLockSelectionChanged;
	System::TObject* FModifiedBy;
	bool FMouseDown;
	TfrxDesigner* FOldDesignerComp;
	TfrxDesignerUnits FOldUnits;
	System::Classes::TStrings* FPagePositions;
	Fmx::Frxpicturecache::TfrxPictureCache* FPictureCache;
	System::Classes::TStringList* FRecentFiles;
	int FRecentMenuIndex;
	Fmx::Frxreporttree::TfrxReportTreeForm* FReportTree;
	TSampleFormat* FSampleFormat;
	double FScale;
	bool FScriptFirstTime;
	bool FScriptRunning;
	bool FScriptStep;
	bool FScriptStopped;
	bool FSearchCase;
	int FSearchIndex;
	bool FSearchReplace;
	System::UnicodeString FSearchReplaceText;
	System::UnicodeString FSearchText;
	bool FShowGrid;
	bool FShowGuides;
	bool FShowRulers;
	bool FShowStartup;
	Fmx::Tabcontrol::TTabControl* FTabs;
	System::Uitypes::TColor FToolsColor;
	Fmx::Frxdesgnctrls::TfrxUndoBuffer* FUndoBuffer;
	TfrxDesignerUnits FUnits;
	bool FUnitsDblClicked;
	bool FUpdatingControls;
	Fmx::Frxwatchform::TfrxWatchForm* FWatchList;
	Fmx::Frxdesgnworkspace::TfrxDesignerWorkspace* FWorkspace;
	System::UnicodeString FTemplatePath;
	System::UnicodeString FTemplateExt;
	Fmx::Stdctrls::TSplitter* Splitter3;
	Fmx::Frxdesgnctrls::TfrxColorSelector* FColorSelector;
	Fmx::Frxdesgnctrls::TfrxLineSelector* FLineSelector;
	void __fastcall CreateColorSelector(Fmx::Frxfmx::TfrxToolButton* Sender);
	void __fastcall CreateExtraToolbar(void);
	void __fastcall CreateToolWindows(void);
	void __fastcall CreateObjectsToolbar(void);
	void __fastcall CreateWorkspace(void);
	virtual void __fastcall Done(void);
	void __fastcall FindOrReplace(bool replace);
	void __fastcall FindText(void);
	virtual void __fastcall Init(void);
	void __fastcall OnCodeChanged(System::TObject* Sender);
	void __fastcall OnCodeCompletion(const System::UnicodeString Name, System::Classes::TStrings* List);
	void __fastcall OnColorChanged(System::TObject* Sender);
	void __fastcall OnComponentMenuClick(System::TObject* Sender);
	void __fastcall OnChangePosition(System::TObject* Sender);
	void __fastcall OnDataTreeDblClick(System::TObject* Sender);
	void __fastcall OnEditObject(System::TObject* Sender);
	void __fastcall OnExtraToolClick(System::TObject* Sender);
	void __fastcall OnInsertObject(System::TObject* Sender);
	void __fastcall OnModify(System::TObject* Sender);
	void __fastcall OnNotifyPosition(const Fmx::Frxclass::TfrxRect &ARect);
	void __fastcall OnRunLine(Fmx::Fs_iinterpreter::TfsScript* Sender, const System::UnicodeString UnitName, const System::UnicodeString SourcePos);
	void __fastcall OnSelectionChanged(System::TObject* Sender);
	void __fastcall OnStyleChanged(System::TObject* Sender);
	void __fastcall OpenRecentFile(System::TObject* Sender);
	void __fastcall ReadButtonImages(void);
	void __fastcall ReloadObjects(void);
	void __fastcall RestorePagePosition(void);
	void __fastcall SavePagePosition(void);
	HIDESBASE void __fastcall SaveState(void);
	void __fastcall SetScale(double Value);
	void __fastcall SetGridAlign(const bool Value);
	void __fastcall SetShowGrid(const bool Value);
	void __fastcall SetShowRulers(const bool Value);
	void __fastcall SetUnits(const TfrxDesignerUnits Value);
	void __fastcall SwitchToolbar(void);
	void __fastcall UpdateCaption(void);
	void __fastcall UpdateControls(void);
	void __fastcall UpdatePageDimensions(void);
	void __fastcall UpdateRecentFiles(System::UnicodeString NewFile);
	void __fastcall UpdateStyles(void);
	void __fastcall UpdateSyntaxType(void);
	void __fastcall UpdateWatches(void);
	System::Word __fastcall AskSave(void);
	int __fastcall GetPageIndex(void);
	System::UnicodeString __fastcall GetReportName(void);
	void __fastcall SetShowGuides(const bool Value);
	void __fastcall Localize(void);
	void __fastcall CreateLangMenu(void);
	void __fastcall SetGridSize1(const double Value);
	void __fastcall SetGridSize2(const double Value);
	void __fastcall SetGridSize3(const double Value);
	void __fastcall SetGridSize4(const double Value);
	
protected:
	virtual void __fastcall SetModified(const bool Value);
	virtual void __fastcall SetPage(Fmx::Frxclass::TfrxPage* const Value);
	virtual System::Classes::TStrings* __fastcall GetCode(void);
	
public:
	bool __fastcall CheckOp(TfrxDesignerRestriction Op);
	virtual System::UnicodeString __fastcall InsertExpression(const System::UnicodeString Expr);
	void __fastcall LoadFile(System::UnicodeString FileName, bool UseOnLoadEvent);
	virtual void __fastcall Lock(void);
	virtual void __fastcall ReloadPages(int Index);
	virtual void __fastcall ReloadReport(void);
	void __fastcall RestoreState(bool RestoreDefault = false, bool RestoreMainForm = false);
	bool __fastcall SaveFile(bool SaveAs, bool UseOnSaveEvent);
	void __fastcall SetReportDefaults(void);
	void __fastcall SwitchToCodeWindow(void);
	virtual void __fastcall UpdateDataTree(void);
	virtual void __fastcall UpdatePage(void);
	virtual void __fastcall UpdateInspector(void);
	Fmx::Frxclass::TfrxPoint __fastcall GetDefaultObjectSize(void);
	System::Extended __fastcall mmToUnits(System::Extended mm, bool X = true);
	System::Extended __fastcall UnitsTomm(System::Extended mm, bool X = true);
	void __fastcall GetTemplateList(System::Classes::TStrings* List);
	__property Fmx::Fs_synmemo::TfsSyntaxMemo* CodeWindow = {read=FCodeWindow};
	__property Fmx::Frxdatatree::TfrxDataTreeForm* DataTree = {read=FDataTree};
	__property bool DropFields = {read=FDropFields, write=FDropFields, nodefault};
	__property bool EditAfterInsert = {read=FEditAfterInsert, write=FEditAfterInsert, nodefault};
	__property bool GridAlign = {read=FGridAlign, write=SetGridAlign, nodefault};
	__property double GridSize1 = {read=FGridSize1, write=SetGridSize1};
	__property double GridSize2 = {read=FGridSize2, write=SetGridSize2};
	__property double GridSize3 = {read=FGridSize3, write=SetGridSize3};
	__property double GridSize4 = {read=FGridSize4, write=SetGridSize4};
	__property Fmx::Frxinsp::TfrxObjectInspector* Inspector = {read=FInspector};
	__property Fmx::Frxpicturecache::TfrxPictureCache* PictureCache = {read=FPictureCache};
	__property System::Classes::TStringList* RecentFiles = {read=FRecentFiles};
	__property Fmx::Frxreporttree::TfrxReportTreeForm* ReportTree = {read=FReportTree};
	__property TSampleFormat* SampleFormat = {read=FSampleFormat};
	__property double Scale = {read=FScale, write=SetScale};
	__property bool ShowGrid = {read=FShowGrid, write=SetShowGrid, nodefault};
	__property bool ShowGuides = {read=FShowGuides, write=SetShowGuides, nodefault};
	__property bool ShowRulers = {read=FShowRulers, write=SetShowRulers, nodefault};
	__property bool ShowStartup = {read=FShowStartup, write=FShowStartup, nodefault};
	__property TfrxDesignerUnits Units = {read=FUnits, write=SetUnits, nodefault};
	__property Fmx::Frxdesgnworkspace::TfrxDesignerWorkspace* Workspace = {read=FWorkspace};
	__property System::UnicodeString TemplatePath = {read=FTemplatePath, write=FTemplatePath};
public:
	/* TfrxCustomDesigner.CreateDesigner */ inline __fastcall TfrxDesignerForm(System::Classes::TComponent* AOwner, Fmx::Frxclass::TfrxReport* AReport, bool APreviewDesigner) : Fmx::Frxclass::TfrxCustomDesigner(AOwner, AReport, APreviewDesigner) { }
	/* TfrxCustomDesigner.Destroy */ inline __fastcall virtual ~TfrxDesignerForm(void) { }
	
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxDesignerForm(System::Classes::TComponent* AOwner) : Fmx::Frxclass::TfrxCustomDesigner(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxDesignerForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Frxclass::TfrxCustomDesigner(AOwner, Dummy) { }
	
};


class PASCALIMPLEMENTATION TSampleFormat : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Fmx::Frxclass::TfrxCustomMemoView* FMemo;
	void __fastcall Clear(void);
	
public:
	__fastcall TSampleFormat(void);
	__fastcall virtual ~TSampleFormat(void);
	void __fastcall ApplySample(Fmx::Frxclass::TfrxCustomMemoView* Memo);
	void __fastcall SetAsSample(Fmx::Frxclass::TfrxCustomMemoView* Memo);
	__property Fmx::Frxclass::TfrxCustomMemoView* Memo = {read=FMemo};
};


class PASCALIMPLEMENTATION TfrxCustomSavePlugin : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::UnicodeString FileFilter;
	virtual void __fastcall Save(Fmx::Frxclass::TfrxReport* Report, const System::UnicodeString FileName) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TfrxCustomSavePlugin(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxCustomSavePlugin(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxDesigner* frxDesignerComp;
extern DELPHI_PACKAGE TfrxCustomSavePlugin* frxSavePlugin;
}	/* namespace Frxdesgn */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXDESGN)
using namespace Fmx::Frxdesgn;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxdesgnHPP
