// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxDesgnCtrls.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxdesgnctrlsHPP
#define Fmx_FrxdesgnctrlsHPP

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
#include <FMX.Objects.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxPictureCache.hpp>
#include <System.Variants.hpp>
#include <FMX.TabControl.hpp>
#include <System.UIConsts.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <System.Math.Vectors.hpp>
#include <FMX.Controls.Presentation.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxdesgnctrls
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxRuler;
class DELPHICLASS TfrxScrollBox;
class DELPHICLASS TfrxTabControl;
class DELPHICLASS TfrxCustomSelector;
class DELPHICLASS TfrxColorSelector;
class DELPHICLASS TfrxLineSelector;
class DELPHICLASS TfrxUndoBuffer;
class DELPHICLASS TfrxClipboard;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxRulerUnits : unsigned char { ruCM, ruInches, ruPixels, ruChars };

class PASCALIMPLEMENTATION TfrxRuler : public Fmx::Stdctrls::TPanel
{
	typedef Fmx::Stdctrls::TPanel inherited;
	
private:
	int FOffset;
	double FScale;
	int FStart;
	TfrxRulerUnits FUnits;
	double FPosition;
	int FRulerSize;
	Fmx::Graphics::TBitmap* FBitmap;
	bool FNeedRedraw;
	void __fastcall SetOffset(const int Value);
	HIDESBASE void __fastcall SetScale(const double Value);
	void __fastcall SetStart(const int Value);
	void __fastcall SetUnits(const TfrxRulerUnits Value);
	HIDESBASE void __fastcall SetPosition(const double Value);
	void __fastcall SetRulerSize(const int Value);
	
protected:
	virtual void __fastcall DoContentPaint(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas, const System::Types::TRectF &ARect);
	void __fastcall DrawRuler(void);
	
public:
	__fastcall virtual TfrxRuler(System::Classes::TComponent* AOwner)/* overload */;
	__fastcall virtual ~TfrxRuler(void);
	
__published:
	__property int Offset = {read=FOffset, write=SetOffset, nodefault};
	__property double Scale = {read=FScale, write=SetScale};
	__property int Start = {read=FStart, write=SetStart, nodefault};
	__property TfrxRulerUnits Units = {read=FUnits, write=SetUnits, default=2};
	__property double RulePosition = {read=FPosition, write=SetPosition};
	__property int RulerSize = {read=FRulerSize, write=SetRulerSize, nodefault};
};


class PASCALIMPLEMENTATION TfrxScrollBox : public Fmx::Layouts::TScrollBox
{
	typedef Fmx::Layouts::TScrollBox inherited;
	
private:
	Fmx::Controls::TContent* FContent;
	System::Classes::TNotifyEvent FOnPositionChanged;
	
protected:
	virtual void __fastcall ApplyStyle(void);
	virtual void __fastcall DoContentPaint(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas, const System::Types::TRectF &ARect);
	virtual void __fastcall DialogKey(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall KeyDown(System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	virtual void __fastcall KeyUp(System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	virtual void __fastcall HScrollChange(void);
	virtual void __fastcall VScrollChange(void);
	
__published:
	__property System::Classes::TNotifyEvent OnPositionChanged = {read=FOnPositionChanged, write=FOnPositionChanged};
public:
	/* TCustomScrollBox.Create */ inline __fastcall virtual TfrxScrollBox(System::Classes::TComponent* AOwner)/* overload */ : Fmx::Layouts::TScrollBox(AOwner) { }
	/* TCustomScrollBox.Destroy */ inline __fastcall virtual ~TfrxScrollBox(void) { }
	
};


class PASCALIMPLEMENTATION TfrxTabControl : public Fmx::Tabcontrol::TTabControl
{
	typedef Fmx::Tabcontrol::TTabControl inherited;
	
protected:
	virtual void __fastcall ApplyStyle(void);
public:
	/* TTabControl.Create */ inline __fastcall virtual TfrxTabControl(System::Classes::TComponent* AOwner)/* overload */ : Fmx::Tabcontrol::TTabControl(AOwner) { }
	/* TTabControl.Destroy */ inline __fastcall virtual ~TfrxTabControl(void) { }
	
};


class PASCALIMPLEMENTATION TfrxCustomSelector : public Fmx::Controls::TPopup
{
	typedef Fmx::Controls::TPopup inherited;
	
protected:
	bool FMouseOver;
	float FX;
	float FY;
	virtual void __fastcall DrawEdge(float X, float Y) = 0 ;
	virtual void __fastcall MouseMove(System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall DoMouseEnter(void);
	virtual void __fastcall DoMouseLeave(void);
	
public:
	__fastcall virtual TfrxCustomSelector(System::Classes::TComponent* AOwner)/* overload */;
	HIDESBASE void __fastcall Popup(Fmx::Controls::TControl* AControl)/* overload */;
public:
	/* TPopup.Destroy */ inline __fastcall virtual ~TfrxCustomSelector(void) { }
	
};


class PASCALIMPLEMENTATION TfrxColorSelector : public TfrxCustomSelector
{
	typedef TfrxCustomSelector inherited;
	
private:
	System::Uitypes::TColor FColor;
	System::Classes::TNotifyEvent FOnColorChanged;
	System::UnicodeString FBtnCaption;
	
protected:
	virtual void __fastcall DrawEdge(float X, float Y);
	virtual void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	
public:
	__fastcall virtual TfrxColorSelector(System::Classes::TComponent* AOwner)/* overload */;
	virtual void __fastcall DoPaint(void);
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, nodefault};
	__property System::Classes::TNotifyEvent OnColorChanged = {read=FOnColorChanged, write=FOnColorChanged};
	__property System::UnicodeString BtnCaption = {read=FBtnCaption, write=FBtnCaption};
public:
	/* TPopup.Destroy */ inline __fastcall virtual ~TfrxColorSelector(void) { }
	
};


class PASCALIMPLEMENTATION TfrxLineSelector : public TfrxCustomSelector
{
	typedef TfrxCustomSelector inherited;
	
private:
	System::Byte FStyle;
	System::Classes::TNotifyEvent FOnStyleChanged;
	
protected:
	virtual void __fastcall DrawEdge(float X, float Y);
	virtual void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	
public:
	__fastcall virtual TfrxLineSelector(System::Classes::TComponent* AOwner)/* overload */;
	virtual void __fastcall DoPaint(void);
	__property System::Byte Style = {read=FStyle, nodefault};
	__property System::Classes::TNotifyEvent OnStyleChanged = {read=FOnStyleChanged, write=FOnStyleChanged};
public:
	/* TPopup.Destroy */ inline __fastcall virtual ~TfrxLineSelector(void) { }
	
};


class PASCALIMPLEMENTATION TfrxUndoBuffer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Fmx::Frxpicturecache::TfrxPictureCache* FPictureCache;
	System::Classes::TList* FRedo;
	System::Classes::TList* FUndo;
	int __fastcall GetRedoCount(void);
	int __fastcall GetUndoCount(void);
	void __fastcall SetPictureFlag(Fmx::Frxclass::TfrxComponent* ReportComponent, bool Flag);
	void __fastcall SetPictures(Fmx::Frxclass::TfrxComponent* ReportComponent);
	
public:
	__fastcall TfrxUndoBuffer(void);
	__fastcall virtual ~TfrxUndoBuffer(void);
	void __fastcall AddUndo(Fmx::Frxclass::TfrxComponent* ReportComponent);
	void __fastcall AddRedo(Fmx::Frxclass::TfrxComponent* ReportComponent);
	void __fastcall GetUndo(Fmx::Frxclass::TfrxComponent* ReportComponent);
	void __fastcall GetRedo(Fmx::Frxclass::TfrxComponent* ReportComponent);
	void __fastcall ClearUndo(void);
	void __fastcall ClearRedo(void);
	__property int UndoCount = {read=GetUndoCount, nodefault};
	__property int RedoCount = {read=GetRedoCount, nodefault};
	__property Fmx::Frxpicturecache::TfrxPictureCache* PictureCache = {read=FPictureCache, write=FPictureCache};
};


class PASCALIMPLEMENTATION TfrxClipboard : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Fmx::Frxclass::TfrxCustomDesigner* FDesigner;
	Fmx::Frxpicturecache::TfrxPictureCache* FPictureCache;
	bool __fastcall GetPasteAvailable(void);
	
public:
	__fastcall TfrxClipboard(Fmx::Frxclass::TfrxCustomDesigner* ADesigner);
	void __fastcall Copy(void);
	void __fastcall Paste(void);
	__property bool PasteAvailable = {read=GetPasteAvailable, nodefault};
	__property Fmx::Frxpicturecache::TfrxPictureCache* PictureCache = {read=FPictureCache, write=FPictureCache};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxClipboard(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdesgnctrls */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXDESGNCTRLS)
using namespace Fmx::Frxdesgnctrls;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxdesgnctrlsHPP
