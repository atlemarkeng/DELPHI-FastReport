// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxDesgnWorkspace.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxdesgnworkspaceHPP
#define Fmx_FrxdesgnworkspaceHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Platform.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Types.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.Memo.hpp>
#include <FMX.frxClass.hpp>
#include <System.Variants.hpp>
#include <System.UIConsts.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <System.Math.Vectors.hpp>
#include <FMX.Controls.Presentation.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxdesgnworkspace
{
//-- forward type declarations -----------------------------------------------
struct TfrxInsertion;
class DELPHICLASS TfrxDesignerWorkspace;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxDesignMode : unsigned char { dmSelect, dmInsert, dmDrag };

enum DECLSPEC_DENUM TfrxDesignMode1 : unsigned char { dmNone, dmMove, dmSize, dmSizeBand, dmScale, dmSelectionRect, dmInsertObject, dmInsertLine, dmMoveGuide, dmContainer };

enum DECLSPEC_DENUM TfrxGridType : unsigned char { gt1pt, gt1cm, gt1in, gtDialog, gtChar, gtNone };

enum DECLSPEC_DENUM TfrxCursorType : unsigned char { ct0, ct1, ct2, ct3, ct4, ct5, ct6, ct7, ct8, ct9, ct10 };

typedef void __fastcall (__closure *TfrxNotifyPositionEvent)(const Fmx::Frxclass::TfrxRect &ARect);

typedef void __fastcall (__closure *TfrxPopupEvent)(System::TObject* Sender, float X, float Y);

#pragma pack(push,1)
struct DECLSPEC_DRECORD TfrxInsertion
{
public:
	Fmx::Frxclass::TfrxComponentClass ComponentClass;
	System::Extended Left;
	System::Extended Top;
	System::Extended Width;
	System::Extended Height;
	System::Extended OriginalWidth;
	System::Extended OriginalHeight;
	System::Word Flags;
};
#pragma pack(pop)


class PASCALIMPLEMENTATION TfrxDesignerWorkspace : public Fmx::Stdctrls::TPanel
{
	typedef Fmx::Stdctrls::TPanel inherited;
	
protected:
	System::Extended FBandHeader;
	Fmx::Graphics::TCanvas* FCanvas;
	System::Uitypes::TColor FColor;
	TfrxCursorType FCT;
	bool FDblClicked;
	bool FDisableUpdate;
	bool FFreeBandsPlacement;
	int FGapBetweenBands;
	bool FGridAlign;
	bool FGridLCD;
	TfrxGridType FGridType;
	System::Extended FGridX;
	System::Extended FGridY;
	Fmx::Memo::TMemo* FInplaceMemo;
	Fmx::Frxclass::TfrxCustomMemoView* FInplaceObject;
	TfrxInsertion FInsertion;
	System::Extended FLastMousePointX;
	System::Extended FLastMousePointY;
	System::Types::TRect FMargins;
	Fmx::Stdctrls::TPanel* FMarginsPanel;
	TfrxDesignMode FMode;
	TfrxDesignMode1 FMode1;
	bool FModifyFlag;
	bool FMouseDown;
	System::Classes::TList* FObjects;
	System::Extended FOffsetX;
	System::Extended FOffsetY;
	Fmx::Frxclass::TfrxPage* FPage;
	int FPageHeight;
	int FPageWidth;
	System::Extended FScale;
	Fmx::Frxclass::TfrxRect FScaleRect;
	Fmx::Frxclass::TfrxRect FScaleRect1;
	System::Classes::TList* FSelectedObjects;
	System::Classes::TList* FSavedAlign;
	Fmx::Frxclass::TfrxRect FSelectionRect;
	bool FShowBandCaptions;
	bool FShowEdges;
	bool FShowGrid;
	Fmx::Frxclass::TfrxBand* FSizedBand;
	System::Classes::TNotifyEvent FOnModify;
	System::Classes::TNotifyEvent FOnEdit;
	System::Classes::TNotifyEvent FOnInsert;
	TfrxNotifyPositionEvent FOnNotifyPosition;
	System::Classes::TNotifyEvent FOnSelectionChanged;
	bool FDrawSelection;
	bool FDrawInsertion;
	TfrxPopupEvent FOnPopup;
	void __fastcall DoModify(void);
	void __fastcall AdjustBandHeight(Fmx::Frxclass::TfrxBand* Bnd);
	virtual void __fastcall CheckGuides(System::Extended &kx, System::Extended &ky, bool &Result);
	void __fastcall DoNudge(System::Extended dx, System::Extended dy, bool Smooth);
	void __fastcall DoSize(System::Extended dx, System::Extended dy);
	void __fastcall DoStick(int dx, int dy);
	void __fastcall DoTab(void);
	void __fastcall DrawBackground(void);
	void __fastcall DrawCross(void);
	void __fastcall DrawInsertionRect(void);
	virtual void __fastcall DrawObjects(void);
	void __fastcall DrawSelectionRect(void);
	void __fastcall FindNearest(int dx, int dy);
	void __fastcall MouseLeave(void);
	void __fastcall NormalizeCoord(Fmx::Frxclass::TfrxComponent* c);
	void __fastcall NormalizeRect(Fmx::Frxclass::TfrxRect &R);
	void __fastcall SelectionChanged(void);
	HIDESBASE void __fastcall SetScale(System::Extended Value);
	void __fastcall SetShowBandCaptions(const bool Value);
	void __fastcall UpdateBandHeader(void);
	virtual void __fastcall DblClick(void);
	virtual void __fastcall KeyDown(System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	virtual void __fastcall KeyUp(System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	virtual void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall MouseMove(System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall PrepareShiftTree(Fmx::Frxclass::TfrxBand* Band);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetGridType(const TfrxGridType Value);
	void __fastcall SetOrigin(const System::Types::TPoint Value);
	virtual void __fastcall SetParent(Fmx::Types::TFmxObject* const Value);
	void __fastcall SetShowGrid(const bool Value);
	System::Types::TPoint __fastcall GetOrigin(void);
	Fmx::Frxclass::TfrxComponent* __fastcall GetRightBottomObject(void);
	Fmx::Frxclass::TfrxRect __fastcall GetSelectionBounds(void);
	bool __fastcall ListsEqual(System::Classes::TList* List1, System::Classes::TList* List2);
	int __fastcall SelectedCount(void);
	
public:
	__fastcall virtual TfrxDesignerWorkspace(System::Classes::TComponent* AOwner)/* overload */;
	__fastcall virtual ~TfrxDesignerWorkspace(void);
	virtual void __fastcall DoPaint(void);
	void __fastcall AdjustBands(bool AttachObjects = true);
	virtual void __fastcall DeleteObjects(void);
	void __fastcall DisableUpdate(void);
	void __fastcall EnableUpdate(void);
	virtual void __fastcall EditObject(void);
	void __fastcall GroupObjects(void);
	void __fastcall UngroupObjects(void);
	virtual void __fastcall SetInsertion(Fmx::Frxclass::TfrxComponentClass AClass, System::Extended AWidth, System::Extended AHeight, System::Word AFlag);
	void __fastcall SetPageDimensions(int AWidth, int AHeight, const System::Types::TRect &AMargins);
	void __fastcall UpdateView(void);
	__property System::Extended BandHeader = {read=FBandHeader, write=FBandHeader};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property bool FreeBandsPlacement = {read=FFreeBandsPlacement, write=FFreeBandsPlacement, nodefault};
	__property int GapBetweenBands = {read=FGapBetweenBands, write=FGapBetweenBands, nodefault};
	__property bool GridAlign = {read=FGridAlign, write=FGridAlign, nodefault};
	__property bool GridLCD = {read=FGridLCD, write=FGridLCD, nodefault};
	__property TfrxGridType GridType = {read=FGridType, write=SetGridType, nodefault};
	__property System::Extended GridX = {read=FGridX, write=FGridX};
	__property System::Extended GridY = {read=FGridY, write=FGridY};
	__property TfrxInsertion Insertion = {read=FInsertion};
	__property bool IsMouseDown = {read=FMouseDown, nodefault};
	__property TfrxDesignMode1 Mode = {read=FMode1, nodefault};
	__property System::Classes::TList* Objects = {read=FObjects, write=FObjects};
	__property System::Extended OffsetX = {read=FOffsetX, write=FOffsetX};
	__property System::Extended OffsetY = {read=FOffsetY, write=FOffsetY};
	__property System::Types::TPoint Origin = {read=GetOrigin, write=SetOrigin};
	__property Fmx::Frxclass::TfrxPage* Page = {read=FPage, write=FPage};
	__property System::Extended Scale = {read=FScale, write=SetScale};
	__property System::Classes::TList* SelectedObjects = {read=FSelectedObjects, write=FSelectedObjects};
	__property bool ShowBandCaptions = {read=FShowBandCaptions, write=SetShowBandCaptions, nodefault};
	__property bool ShowEdges = {read=FShowEdges, write=FShowEdges, nodefault};
	__property bool ShowGrid = {read=FShowGrid, write=SetShowGrid, nodefault};
	__property System::Classes::TNotifyEvent OnModify = {read=FOnModify, write=FOnModify};
	__property System::Classes::TNotifyEvent OnEdit = {read=FOnEdit, write=FOnEdit};
	__property System::Classes::TNotifyEvent OnInsert = {read=FOnInsert, write=FOnInsert};
	__property TfrxNotifyPositionEvent OnNotifyPosition = {read=FOnNotifyPosition, write=FOnNotifyPosition};
	__property System::Classes::TNotifyEvent OnSelectionChanged = {read=FOnSelectionChanged, write=FOnSelectionChanged};
	__property TfrxPopupEvent OnPopup = {read=FOnPopup, write=FOnPopup};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdesgnworkspace */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXDESGNWORKSPACE)
using namespace Fmx::Frxdesgnworkspace;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxdesgnworkspaceHPP
