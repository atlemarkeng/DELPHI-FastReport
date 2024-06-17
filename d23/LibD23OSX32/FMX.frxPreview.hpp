// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxPreview.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxpreviewHPP
#define Fmx_FrxpreviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.TreeView.hpp>
#include <FMX.Menus.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Dialogs.hpp>
#include <System.UIConsts.hpp>
#include <FMX.frxCtrls.hpp>
#include <FMX.frxPreviewPages.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Objects.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <System.Math.Vectors.hpp>
#include <FMX.ComboEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxpreview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxPreview;
class DELPHICLASS TfrxPreviewForm;
class DELPHICLASS TfrxPreviewWorkspace;
class DELPHICLASS TfrxPageItem;
class DELPHICLASS TfrxPageList;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TfrxPageChangedEvent)(TfrxPreview* Sender, int PageNo);

class PASCALIMPLEMENTATION TfrxPreview : public Fmx::Frxclass::TfrxCustomPreview
{
	typedef Fmx::Frxclass::TfrxCustomPreview inherited;
	
private:
	bool FAllowF3;
	Fmx::Stdctrls::TButton* FCancelButton;
	bool FLocked;
	Fmx::Stdctrls::TLabel* FMessageLabel;
	Fmx::Stdctrls::TPanel* FMessagePanel;
	TfrxPageChangedEvent FOnPageChanged;
	Fmx::Treeview::TTreeView* FOutline;
	System::Uitypes::TAlphaColor FOutlineColor;
	Fmx::Menus::TPopupMenu* FOutlinePopup;
	int FPageNo;
	bool FRefreshing;
	bool FRunning;
	Fmx::Frxctrls::TfrxSplitter* FSplitter;
	TfrxPreviewWorkspace* FThumbnail;
	unsigned FTick;
	TfrxPreviewWorkspace* FWorkspace;
	double FZoom;
	Fmx::Frxclass::TfrxZoomMode FZoomMode;
	Fmx::Stdctrls::TCalloutPanel* HintPanel;
	Fmx::Stdctrls::TLabel* HintLabel;
	System::Uitypes::TAlphaColor __fastcall GetActiveFrameColor(void);
	System::Uitypes::TAlphaColor __fastcall GetBackColor(void);
	System::Uitypes::TAlphaColor __fastcall GetFrameColor(void);
	bool __fastcall GetOutlineVisible(void);
	int __fastcall GetOutlineWidth(void);
	int __fastcall GetPageCount(void);
	bool __fastcall GetThumbnailVisible(void);
	Fmx::Types::TMouseEvent __fastcall GetOnMouseDown(void);
	void __fastcall EditTemplate(void);
	void __fastcall OnCancel(System::TObject* Sender);
	void __fastcall OnCollapseClick(System::TObject* Sender);
	void __fastcall OnExpandClick(System::TObject* Sender);
	void __fastcall OnMoveSplitter(System::TObject* Sender);
	void __fastcall OnOutlineClick(System::TObject* Sender);
	void __fastcall SetActiveFrameColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetBackColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetFrameColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetOutlineColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetOutlineWidth(const int Value);
	void __fastcall SetOutlineVisible(const bool Value);
	void __fastcall SetPageNo(int Value);
	void __fastcall SetThumbnailVisible(const bool Value);
	void __fastcall SetZoom(const double Value);
	void __fastcall SetZoomMode(const Fmx::Frxclass::TfrxZoomMode Value);
	void __fastcall SetOnMouseDown(const Fmx::Types::TMouseEvent Value);
	void __fastcall UpdateOutline(void);
	void __fastcall UpdatePages(void);
	void __fastcall UpdatePageNumbers(void);
	
protected:
	virtual void __fastcall KeyDown(System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	virtual void __fastcall Resize(void);
	HIDESBASE void __fastcall OnResize(System::TObject* Sender);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TfrxPreview(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxPreview(void);
	virtual void __fastcall Init(void);
	virtual void __fastcall Lock(void);
	virtual void __fastcall ShowHint(const System::Types::TRectF &aRect, System::UnicodeString Text);
	virtual void __fastcall HideHint(void);
	virtual void __fastcall Unlock(void);
	virtual void __fastcall RefreshReport(void);
	virtual void __fastcall InternalOnProgressStart(Fmx::Frxclass::TfrxReport* Sender, Fmx::Frxclass::TfrxProgressType ProgressType, int Progress);
	virtual void __fastcall InternalOnProgress(Fmx::Frxclass::TfrxReport* Sender, Fmx::Frxclass::TfrxProgressType ProgressType, int Progress);
	virtual void __fastcall InternalOnProgressStop(Fmx::Frxclass::TfrxReport* Sender, Fmx::Frxclass::TfrxProgressType ProgressType, int Progress);
	void __fastcall AddPage(void);
	void __fastcall DeletePage(void);
	void __fastcall Print(void);
	void __fastcall Edit(void);
	void __fastcall First(void);
	void __fastcall Next(void);
	void __fastcall Prior(void);
	void __fastcall Last(void);
	void __fastcall PageSetupDlg(void);
	void __fastcall Cancel(void);
	void __fastcall Clear(void);
	HIDESBASE void __fastcall SetPosition(int PageN, int Top);
	void __fastcall ShowMessage(const System::UnicodeString s);
	void __fastcall HideMessage(void);
	void __fastcall MouseWheelScroll(int Delta, bool Horz = false, bool Zoom = false);
	int __fastcall GetTopPosition(void);
	void __fastcall LoadFromFile(void)/* overload */;
	void __fastcall LoadFromFile(System::UnicodeString FileName)/* overload */;
	void __fastcall SaveToFile(void)/* overload */;
	void __fastcall SaveToFile(System::UnicodeString FileName)/* overload */;
	void __fastcall Export(Fmx::Frxclass::TfrxCustomExportFilter* Filter);
	__property int PageCount = {read=GetPageCount, nodefault};
	__property int PageNo = {read=FPageNo, write=SetPageNo, nodefault};
	__property double Zoom = {read=FZoom, write=SetZoom};
	__property Fmx::Frxclass::TfrxZoomMode ZoomMode = {read=FZoomMode, write=SetZoomMode, nodefault};
	__property bool Locked = {read=FLocked, nodefault};
	__property Fmx::Treeview::TTreeView* OutlineTree = {read=FOutline};
	__property Fmx::Frxctrls::TfrxSplitter* Splitter = {read=FSplitter};
	__property TfrxPreviewWorkspace* Thumbnail = {read=FThumbnail};
	__property TfrxPreviewWorkspace* Workspace = {read=FWorkspace};
	
__published:
	__property Align = {default=0};
	__property System::Uitypes::TAlphaColor ActiveFrameColor = {read=GetActiveFrameColor, write=SetActiveFrameColor, default=8405024};
	__property System::Uitypes::TAlphaColor BackColor = {read=GetBackColor, write=SetBackColor, default=-8355712};
	__property System::Uitypes::TAlphaColor FrameColor = {read=GetFrameColor, write=SetFrameColor, default=-16777216};
	__property System::Uitypes::TAlphaColor OutlineColor = {read=FOutlineColor, write=SetOutlineColor, default=-1};
	__property bool OutlineVisible = {read=GetOutlineVisible, write=SetOutlineVisible, nodefault};
	__property int OutlineWidth = {read=GetOutlineWidth, write=SetOutlineWidth, nodefault};
	__property PopupMenu;
	__property Position;
	__property Width;
	__property Height;
	__property bool ThumbnailVisible = {read=GetThumbnailVisible, write=SetThumbnailVisible, nodefault};
	__property OnClick;
	__property OnDblClick;
	__property TfrxPageChangedEvent OnPageChanged = {read=FOnPageChanged, write=FOnPageChanged};
	__property Fmx::Types::TMouseEvent OnMouseDown = {read=GetOnMouseDown, write=SetOnMouseDown};
	__property Anchors;
	__property UseReportHints;
};


class PASCALIMPLEMENTATION TfrxPreviewForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TToolBar* ToolBar;
	Fmx::Frxfmx::TfrxToolButton* OpenB;
	Fmx::Frxfmx::TfrxToolButton* SaveB;
	Fmx::Frxfmx::TfrxToolButton* PrintB;
	Fmx::Frxfmx::TfrxToolButton* ExportB;
	Fmx::Frxfmx::TfrxToolButton* PageSettingsB;
	Fmx::Frxfmx::TfrxToolButton* FirstB;
	Fmx::Frxfmx::TfrxToolButton* PriorB;
	Fmx::Edit::TEdit* PageE;
	Fmx::Frxfmx::TfrxToolButton* NextB;
	Fmx::Frxfmx::TfrxToolButton* LastB;
	Fmx::Stdctrls::TStatusBar* StatusBar;
	Fmx::Frxfmx::TfrxToolButton* DesignerB;
	Fmx::Stdctrls::TSpeedButton* CancelB;
	Fmx::Menus::TPopupMenu* ExportPopup;
	Fmx::Menus::TPopupMenu* HiddenMenu;
	Fmx::Menus::TMenuItem* Showtemplate1;
	Fmx::Menus::TPopupMenu* RightMenu;
	Fmx::Frxfmx::TfrxToolButton* FullScreenBtn;
	Fmx::Frxfmx::TfrxToolButton* OutlineB;
	Fmx::Frxfmx::TfrxToolButton* ThumbB;
	Fmx::Menus::TMenuItem* N1;
	Fmx::Menus::TMenuItem* ExpandMI;
	Fmx::Menus::TMenuItem* CollapseMI;
	Fmx::Frxfmx::TfrxToolSeparator* Line1;
	Fmx::Frxfmx::TfrxToolButton* PageWidthB;
	Fmx::Frxfmx::TfrxToolButton* WholePageB;
	Fmx::Frxfmx::TfrxToolSeparator* Line2;
	Fmx::Frxfmx::TfrxToolSeparator* Line3;
	Fmx::Objects::TText* Panel0;
	Fmx::Objects::TText* Panel1;
	Fmx::Objects::TText* Panel2;
	Fmx::Menus::TMenuItem* OpenMI;
	Fmx::Menus::TMenuItem* SaveMI;
	Fmx::Menus::TMenuItem* PrintMI;
	Fmx::Menus::TMenuItem* ExportMI;
	Fmx::Menus::TMenuItem* ExportPDFMI;
	Fmx::Menus::TMenuItem* ExportMailMI;
	Fmx::Menus::TMenuItem* FindMI;
	Fmx::Menus::TMenuItem* FullScrMI;
	Fmx::Menus::TMenuItem* ZoomInMI;
	Fmx::Menus::TMenuItem* ZoomOutMI;
	Fmx::Comboedit::TComboEdit* ZoomCB;
	Fmx::Stdctrls::TCalloutPanel* HintPanel;
	Fmx::Stdctrls::TLabel* Label1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ZoomMinusBClick(System::TObject* Sender);
	void __fastcall FirstBClick(System::TObject* Sender);
	void __fastcall PriorBClick(System::TObject* Sender);
	void __fastcall NextBClick(System::TObject* Sender);
	void __fastcall LastBClick(System::TObject* Sender);
	void __fastcall PageEClick(System::TObject* Sender);
	void __fastcall PrintBClick(System::TObject* Sender);
	void __fastcall OpenBClick(System::TObject* Sender);
	void __fastcall SaveBClick(System::TObject* Sender);
	void __fastcall DesignerBClick(System::TObject* Sender);
	void __fastcall NewPageBClick(System::TObject* Sender);
	void __fastcall DelPageBClick(System::TObject* Sender);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall PageSettingsBClick(System::TObject* Sender);
	void __fastcall FormMouseWheel(System::TObject* Sender, System::Classes::TShiftState Shift, int WheelDelta, bool &Handled);
	void __fastcall DesignerBMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall Showtemplate1Click(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall FullScreenBtnClick(System::TObject* Sender);
	void __fastcall PdfBClick(System::TObject* Sender);
	void __fastcall EmailBClick(System::TObject* Sender);
	void __fastcall ZoomPlusBClick(System::TObject* Sender);
	void __fastcall OutlineBClick(System::TObject* Sender);
	void __fastcall ThumbBClick(System::TObject* Sender);
	void __fastcall CollapseAllClick(System::TObject* Sender);
	void __fastcall ExpandAllClick(System::TObject* Sender);
	void __fastcall ZoomCBChange(System::TObject* Sender);
	void __fastcall PageWidthBClick(System::TObject* Sender);
	void __fastcall WholePageBClick(System::TObject* Sender);
	void __fastcall FormMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall ExportBClick(System::TObject* Sender);
	void __fastcall ZoomCBClick(System::TObject* Sender);
	void __fastcall PrintBMouseEnter(System::TObject* Sender);
	void __fastcall PrintBMouseLeave(System::TObject* Sender);
	
private:
	int FPopUpMItemsCount;
	int FPopUpExporttemsCount;
	bool FFreeOnClose;
	TfrxPreview* FPreview;
	Fmx::Forms::TFmxFormBorderStyle FOldBS;
	System::Uitypes::TWindowState FOldState;
	bool FFullScreen;
	Fmx::Frxclass::TfrxCustomExportFilter* FPDFExport;
	Fmx::Frxclass::TfrxCustomExportFilter* FEmailExport;
	void __fastcall ExportMIClick(System::TObject* Sender);
	void __fastcall OnPageChanged(TfrxPreview* Sender, int PageNo);
	void __fastcall OnPreviewDblClick(System::TObject* Sender);
	void __fastcall UpdateControls(void);
	void __fastcall UpdateZoom(void);
	Fmx::Frxclass::TfrxReport* __fastcall GetReport(void);
	
public:
	void __fastcall Init(void);
	void __fastcall SetMessageText(const System::UnicodeString Value, bool IsHint = false);
	void __fastcall SwitchToFullScreen(void);
	__property bool FreeOnClose = {read=FFreeOnClose, write=FFreeOnClose, nodefault};
	__property TfrxPreview* Preview = {read=FPreview};
	__property Fmx::Frxclass::TfrxReport* Report = {read=GetReport};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxPreviewForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxPreviewForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxPreviewForm(void) { }
	
};


class PASCALIMPLEMENTATION TfrxPreviewWorkspace : public Fmx::Frxctrls::TfrxScrollWin
{
	typedef Fmx::Frxctrls::TfrxScrollWin inherited;
	
private:
	System::Uitypes::TAlphaColor FActiveFrameColor;
	System::Uitypes::TAlphaColor FBackColor;
	System::Uitypes::TCursor FDefaultCursor;
	bool FDisableUpdate;
	bool FDown;
	System::Uitypes::TAlphaColor FFrameColor;
	bool FIsThumbnail;
	System::Types::TPointF FLastPoint;
	bool FLocked;
	System::Types::TPoint FOffset;
	unsigned FTimeOffset;
	TfrxPageList* FPageList;
	int FPageNo;
	TfrxPreview* FPreview;
	Fmx::Frxclass::TfrxCustomPreviewPages* FPreviewPages;
	double FZoom;
	bool FRTLLanguage;
	void __fastcall DrawPages(bool BorderOnly, Fmx::Graphics::TCanvas* ACanvas, const System::Types::TRectF &ARect);
	void __fastcall SetToPageNo(int PageNo);
	HIDESBASE void __fastcall UpdateScrollBars(void);
	
protected:
	void __fastcall PrevDblClick(System::TObject* Sender);
	virtual void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall MouseMove(System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall OnHScrollChange(System::TObject* Sender);
	virtual void __fastcall OnVScrollChange(System::TObject* Sender);
	
public:
	__fastcall virtual TfrxPreviewWorkspace(System::Classes::TComponent* AOwner)/* overload */;
	__fastcall virtual ~TfrxPreviewWorkspace(void);
	HIDESBASE void __fastcall SetPosition(int PageN, int Top);
	int __fastcall GetTopPosition(void);
	void __fastcall AddPage(int AWidth, int AHeight);
	void __fastcall ClearPageList(void);
	void __fastcall CalcPageBounds(int ClientWidth);
	virtual void __fastcall DoContentPaint(System::TObject* Sender, Fmx::Graphics::TCanvas* aCanvas, const System::Types::TRectF &ARect);
	__property System::Uitypes::TAlphaColor ActiveFrameColor = {read=FActiveFrameColor, write=FActiveFrameColor, default=8405024};
	__property System::Uitypes::TAlphaColor BackColor = {read=FBackColor, write=FBackColor, default=-8355712};
	__property System::Uitypes::TAlphaColor FrameColor = {read=FFrameColor, write=FFrameColor, default=-16777216};
	__property bool IsThumbnail = {read=FIsThumbnail, write=FIsThumbnail, nodefault};
	__property bool Locked = {read=FLocked, write=FLocked, nodefault};
	__property int PageNo = {read=FPageNo, write=FPageNo, nodefault};
	__property TfrxPreview* Preview = {read=FPreview, write=FPreview};
	__property Fmx::Frxclass::TfrxCustomPreviewPages* PreviewPages = {read=FPreviewPages, write=FPreviewPages};
	__property double Zoom = {read=FZoom, write=FZoom};
	__property bool RTLLanguage = {read=FRTLLanguage, write=FRTLLanguage, nodefault};
	__property OnDblClick;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPageItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
public:
	int Height;
	int Width;
	int OffsetX;
	int OffsetY;
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxPageItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxPageItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPageList : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxPageItem* operator[](int Index) { return Items[Index]; }
	
private:
	int FMaxWidth;
	TfrxPageItem* __fastcall GetItems(int Index);
	
public:
	__fastcall TfrxPageList(void);
	__property TfrxPageItem* Items[int Index] = {read=GetItems/*, default*/};
	void __fastcall AddPage(int AWidth, int AHeight, System::Extended Zoom);
	void __fastcall CalcBounds(int ClientWidth);
	int __fastcall FindPage(int OffsetY, int OffsetX = 0x0);
	System::Types::TRect __fastcall GetPageBounds(int Index, float ClientWidth, System::Extended Scale, bool RTL);
	System::Types::TPoint __fastcall GetMaxBounds(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxPageList(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxpreview */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXPREVIEW)
using namespace Fmx::Frxpreview;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxpreviewHPP
