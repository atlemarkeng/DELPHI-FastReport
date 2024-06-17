// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxDesgnWorkspace1.pas' rev: 30.00 (Windows)

#ifndef Fmx_Frxdesgnworkspace1HPP
#define Fmx_Frxdesgnworkspace1HPP

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
#include <FMX.frxClass.hpp>
#include <FMX.frxDesgn.hpp>
#include <FMX.frxDesgnWorkspace.hpp>
#include <FMX.frxPopupForm.hpp>
#include <System.Variants.hpp>
#include <System.UIConsts.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Graphics.hpp>
#include <System.Math.Vectors.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Controls.Presentation.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxdesgnworkspace1
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxGuideItem;
class DELPHICLASS TfrxVirtualGuides;
class DELPHICLASS TDesignerWorkspace;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxGuideItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
public:
	System::Extended Left;
	System::Extended Top;
	System::Extended Right;
	System::Extended Bottom;
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxGuideItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxGuideItem(void) { }
	
};


class PASCALIMPLEMENTATION TfrxVirtualGuides : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxGuideItem* operator[](int Index) { return Items[Index]; }
	
private:
	TfrxGuideItem* __fastcall GetGuides(int Index);
	
public:
	__fastcall TfrxVirtualGuides(void);
	HIDESBASE void __fastcall Add(System::Extended Left, System::Extended Top, System::Extended Right, System::Extended Bottom);
	__property TfrxGuideItem* Items[int Index] = {read=GetGuides/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxVirtualGuides(void) { }
	
};


class PASCALIMPLEMENTATION TDesignerWorkspace : public Fmx::Frxdesgnworkspace::TfrxDesignerWorkspace
{
	typedef Fmx::Frxdesgnworkspace::TfrxDesignerWorkspace inherited;
	
private:
	Fmx::Frxdesgn::TfrxDesignerForm* FDesigner;
	int FGuide;
	Fmx::Listbox::TListBox* FListBox;
	Fmx::Frxclass::TfrxMemoView* FMemo;
	Fmx::Frxpopupform::TfrxPopupForm* FPopupForm;
	bool FPopupFormVisible;
	bool FShowGuides;
	bool FSimulateMove;
	TfrxVirtualGuides* FVirtualGuides;
	System::Classes::TList* FVirtualGuideObjects;
	void __fastcall DoLBClick(System::TObject* Sender);
	void __fastcall DoPopupHide(System::TObject* Sender);
	void __fastcall CreateVirtualGuides(void);
	void __fastcall SetShowGuides(const bool Value);
	void __fastcall SetHGuides(System::Classes::TStrings* const Value);
	void __fastcall SetVGuides(System::Classes::TStrings* const Value);
	System::Classes::TStrings* __fastcall GetHGuides(void);
	System::Classes::TStrings* __fastcall GetVGuides(void);
	__property System::Classes::TStrings* HGuides = {read=GetHGuides, write=SetHGuides};
	__property System::Classes::TStrings* VGuides = {read=GetVGuides, write=SetVGuides};
	
protected:
	virtual void __fastcall CheckGuides(System::Extended &kx, System::Extended &ky, bool &Result);
	virtual void __fastcall DragOver(const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point, Fmx::Types::TDragOperation &Operation);
	virtual void __fastcall DrawObjects(void);
	virtual void __fastcall KeyDown(System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	virtual void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall MouseMove(System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	
public:
	__fastcall virtual TDesignerWorkspace(System::Classes::TComponent* AOwner)/* overload */;
	__fastcall virtual ~TDesignerWorkspace(void);
	virtual void __fastcall DeleteObjects(void);
	virtual void __fastcall DragDrop(const Fmx::Types::TDragObject &Data, const System::Types::TPointF Point);
	void __fastcall SimulateMove(void);
	virtual void __fastcall SetInsertion(Fmx::Frxclass::TfrxComponentClass AClass, System::Extended AWidth, System::Extended AHeight, System::Word AFlag);
	__property bool ShowGuides = {read=FShowGuides, write=SetShowGuides, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdesgnworkspace1 */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXDESGNWORKSPACE1)
using namespace Fmx::Frxdesgnworkspace1;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_Frxdesgnworkspace1HPP
