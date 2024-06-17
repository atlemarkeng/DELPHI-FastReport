// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxCtrls.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxctrlsHPP
#define Fmx_FrxctrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Edit.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.Controls.Presentation.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxctrls
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxScrollWin;
class DELPHICLASS TfrxSplitter;
class DELPHICLASS TfrxEditWithButton;
class DELPHICLASS TfrxEditButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxScrollWin : public Fmx::Controls::TStyledControl
{
	typedef Fmx::Controls::TStyledControl inherited;
	
private:
	Fmx::Stdctrls::TScrollBar* FHScrollBar;
	Fmx::Stdctrls::TScrollBar* FVScrollBar;
	Fmx::Controls::TContent* FContent;
	void __fastcall SetHorzRange(float Value);
	void __fastcall SetHorzPosition(float Value);
	void __fastcall SetVertRange(float Value);
	void __fastcall SetVertPosition(float Value);
	void __fastcall CheckScrollBars(void);
	void __fastcall UpdateScrollBars(void);
	Fmx::Stdctrls::TScrollBar* __fastcall HScrollBar(void);
	Fmx::Stdctrls::TScrollBar* __fastcall VScrollBar(void);
	float __fastcall GetHorzPosition(void);
	float __fastcall GetVertPosition(void);
	float __fastcall GetHorzRange(void);
	float __fastcall GetVertRange(void);
	
protected:
	virtual void __fastcall ApplyStyle(void);
	virtual void __fastcall FreeStyle(void);
	virtual void __fastcall KeyDown(System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	virtual void __fastcall MouseWheel(System::Classes::TShiftState Shift, int WheelDelta, bool &Handled);
	virtual void __fastcall OnHScrollChange(System::TObject* Sender);
	virtual void __fastcall OnVScrollChange(System::TObject* Sender);
	virtual void __fastcall DoContentPaint(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas, const System::Types::TRectF &ARect);
	Fmx::Graphics::TCanvas* __fastcall GetContentCanvas(void);
	
public:
	__fastcall virtual TfrxScrollWin(System::Classes::TComponent* AOwner)/* overload */;
	virtual void __fastcall Resize(void);
	System::Types::TRectF __fastcall GetClientRect(void);
	__property float HorzRange = {read=GetHorzRange, write=SetHorzRange};
	__property float HorzPosition = {read=GetHorzPosition, write=SetHorzPosition};
	__property float VertRange = {read=GetVertRange, write=SetVertRange};
	__property float VertPosition = {read=GetVertPosition, write=SetVertPosition};
public:
	/* TStyledControl.Destroy */ inline __fastcall virtual ~TfrxScrollWin(void) { }
	
};


class PASCALIMPLEMENTATION TfrxSplitter : public Fmx::Stdctrls::TSplitter
{
	typedef Fmx::Stdctrls::TSplitter inherited;
	
private:
	System::Classes::TNotifyEvent FOnMove;
	
public:
	virtual void __fastcall MouseMove(System::Classes::TShiftState Shift, float X, float Y);
	__property System::Classes::TNotifyEvent OnMove = {read=FOnMove, write=FOnMove};
public:
	/* TSplitter.Create */ inline __fastcall virtual TfrxSplitter(System::Classes::TComponent* AOwner)/* overload */ : Fmx::Stdctrls::TSplitter(AOwner) { }
	
public:
	/* TStyledControl.Destroy */ inline __fastcall virtual ~TfrxSplitter(void) { }
	
};


class PASCALIMPLEMENTATION TfrxEditWithButton : public Fmx::Edit::TEdit
{
	typedef Fmx::Edit::TEdit inherited;
	
private:
	Fmx::Edit::TEditButton* FButton;
	System::Classes::TNotifyEvent FOnButtonClick;
	void __fastcall DoButtonClick(System::TObject* Sender);
	
protected:
	virtual System::UnicodeString __fastcall DefinePresentationName(void);
	virtual void __fastcall ApplyStyle(void);
	
public:
	__fastcall virtual TfrxEditWithButton(System::Classes::TComponent* AOwner)/* overload */;
	
__published:
	__property System::Classes::TNotifyEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
public:
	/* TCustomEdit.Destroy */ inline __fastcall virtual ~TfrxEditWithButton(void) { }
	
};


class PASCALIMPLEMENTATION TfrxEditButton : public Fmx::Stdctrls::TSpeedButton
{
	typedef Fmx::Stdctrls::TSpeedButton inherited;
	
private:
	void __fastcall DoContentPaint(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas, const System::Types::TRectF &ARect);
	
protected:
	virtual void __fastcall ApplyStyle(void);
public:
	/* TSpeedButton.Create */ inline __fastcall virtual TfrxEditButton(System::Classes::TComponent* AOwner)/* overload */ : Fmx::Stdctrls::TSpeedButton(AOwner) { }
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TfrxEditButton(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxctrls */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXCTRLS)
using namespace Fmx::Frxctrls;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxctrlsHPP
