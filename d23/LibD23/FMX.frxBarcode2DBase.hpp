// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxBarcode2DBase.pas' rev: 30.00 (Windows)

#ifndef Fmx_Frxbarcode2dbaseHPP
#define Fmx_Frxbarcode2dbaseHPP

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
#include <System.UIConsts.hpp>
#include <System.Math.hpp>
#include <FMX.Types.hpp>
#include <FMX.Objects.hpp>
#include <FMX.frxPrinter.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.frxFMX.hpp>
#include <System.Math.Vectors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxbarcode2dbase
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBarcode2DBase;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxBarcode2DBase : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
protected:
	System::DynamicArray<System::Byte> FImage;
	int FHeight;
	int FWidth;
	int FPixelWidth;
	int FPixelHeight;
	bool FShowText;
	int FRotation;
	System::UnicodeString FText;
	double FZoom;
	bool FFontScaled;
	Fmx::Graphics::TFont* FFont;
	System::Uitypes::TAlphaColor FColor;
	System::Uitypes::TAlphaColor FColorBar;
	System::Uitypes::TAlphaColor FFontColor;
	System::UnicodeString FErrorText;
	int FQuiteZone;
	virtual void __fastcall SetShowText(bool Value);
	virtual void __fastcall SetRotation(int Value);
	virtual void __fastcall SetText(System::UnicodeString Value);
	virtual void __fastcall SetZoom(double Value);
	virtual void __fastcall SetFontScaled(bool Value);
	virtual void __fastcall SetFont(Fmx::Graphics::TFont* Value);
	virtual void __fastcall SetColor(System::Uitypes::TAlphaColor Value);
	virtual void __fastcall SetColorBar(System::Uitypes::TAlphaColor Value);
	virtual void __fastcall SetErrorText(System::UnicodeString Value);
	virtual int __fastcall GetWidth(void);
	virtual int __fastcall GetHeight(void);
	
public:
	__fastcall virtual TfrxBarcode2DBase(void);
	__fastcall virtual ~TfrxBarcode2DBase(void);
	HIDESBASE virtual void __fastcall Assign(TfrxBarcode2DBase* Source);
	virtual int __fastcall GetFooterHeight(void);
	virtual void __fastcall Draw2DBarcode(Fmx::Graphics::TCanvas* &Canvas, System::Extended scalex, System::Extended scaley, int x, int y, bool IsPrinting = false);
	__property bool ShowText = {read=FShowText, write=SetShowText, nodefault};
	__property int Rotation = {read=FRotation, write=SetRotation, nodefault};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property double Zoom = {read=FZoom, write=SetZoom};
	__property bool FontScaled = {read=FFontScaled, write=SetFontScaled, nodefault};
	__property Fmx::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=SetColor, nodefault};
	__property System::Uitypes::TAlphaColor FontColor = {read=FFontColor, write=FFontColor, nodefault};
	__property System::Uitypes::TAlphaColor ColorBar = {read=FColorBar, write=SetColorBar, nodefault};
	__property System::UnicodeString ErrorText = {read=FErrorText, write=SetErrorText};
	__property int Width = {read=GetWidth, nodefault};
	__property int Height = {read=GetHeight, nodefault};
	__property int PixelWidth = {read=FPixelWidth, write=FPixelWidth, nodefault};
	__property int PixelHeight = {read=FPixelHeight, write=FPixelHeight, nodefault};
	__property int QuiteZone = {read=FQuiteZone, write=FQuiteZone, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
#define cbDefaultText L"12345678"
}	/* namespace Frxbarcode2dbase */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXBARCODE2DBASE)
using namespace Fmx::Frxbarcode2dbase;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_Frxbarcode2dbaseHPP
