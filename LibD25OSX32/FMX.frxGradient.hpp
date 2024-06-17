// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxGradient.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxgradientHPP
#define Fmx_FrxgradientHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Classes.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Types.hpp>
#include <FMX.frxClass.hpp>
#include <System.Variants.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxgradient
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxGradientObject;
class DELPHICLASS TfrxGradientView;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxGradientObject : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfrxGradientObject(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxGradientObject(void) { }
	
};


enum DECLSPEC_DENUM TfrxGradientStyle : unsigned char { gsHorizontal, gsVertical, gsElliptic, gsRectangle, gsVertCenter, gsHorizCenter };

class PASCALIMPLEMENTATION TfrxGradientView : public Fmx::Frxclass::TfrxView
{
	typedef Fmx::Frxclass::TfrxView inherited;
	
private:
	System::Uitypes::TAlphaColor FBeginColor;
	System::Uitypes::TAlphaColor FEndColor;
	TfrxGradientStyle FStyle;
	void __fastcall DrawGradient(int X, int Y, int X1, int Y1);
	System::Uitypes::TAlphaColor __fastcall GetColor(void);
	void __fastcall SetColor(const System::Uitypes::TAlphaColor Value);
	
public:
	__fastcall virtual TfrxGradientView(System::Classes::TComponent* AOwner);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property System::Uitypes::TAlphaColor BeginColor = {read=FBeginColor, write=FBeginColor, default=-1};
	__property System::Uitypes::TAlphaColor EndColor = {read=FEndColor, write=FEndColor, default=-8355712};
	__property TfrxGradientStyle Style = {read=FStyle, write=FStyle, nodefault};
	__property Frame;
	__property System::Uitypes::TAlphaColor Color = {read=GetColor, write=SetColor, nodefault};
public:
	/* TfrxView.Destroy */ inline __fastcall virtual ~TfrxGradientView(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxGradientView(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxView(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxgradient */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXGRADIENT)
using namespace Fmx::Frxgradient;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxgradientHPP
