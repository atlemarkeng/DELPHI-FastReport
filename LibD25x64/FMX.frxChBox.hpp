// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxChBox.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxchboxHPP
#define Fmx_FrxchboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Controls.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.Types.hpp>
#include <FMX.TabControl.hpp>
#include <System.UIConsts.hpp>
#include <System.UITypes.hpp>
#include <System.Variants.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxchbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxCheckBoxObject;
class DELPHICLASS TfrxCheckBoxView;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxCheckStyle : unsigned char { csCross, csCheck, csLineCross, csPlus };

enum DECLSPEC_DENUM TfrxUncheckStyle : unsigned char { usEmpty, usCross, usLineCross, usMinus };

class PASCALIMPLEMENTATION TfrxCheckBoxObject : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfrxCheckBoxObject(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxCheckBoxObject(void) { }
	
};


class PASCALIMPLEMENTATION TfrxCheckBoxView : public Fmx::Frxclass::TfrxView
{
	typedef Fmx::Frxclass::TfrxView inherited;
	
private:
	System::Uitypes::TAlphaColor FCheckColor;
	bool FChecked;
	TfrxCheckStyle FCheckStyle;
	TfrxUncheckStyle FUncheckStyle;
	System::UnicodeString FExpression;
	void __fastcall DrawCheck(const System::Types::TRectF &ARect);
	
public:
	__fastcall virtual TfrxCheckBoxView(System::Classes::TComponent* AOwner);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall GetData(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property BrushStyle;
	__property System::Uitypes::TAlphaColor CheckColor = {read=FCheckColor, write=FCheckColor, default=-16777216};
	__property bool Checked = {read=FChecked, write=FChecked, default=1};
	__property TfrxCheckStyle CheckStyle = {read=FCheckStyle, write=FCheckStyle, nodefault};
	__property Color = {default=0};
	__property Cursor = {default=0};
	__property DataField = {default=0};
	__property DataSet;
	__property DataSetName = {default=0};
	__property System::UnicodeString Expression = {read=FExpression, write=FExpression};
	__property Frame;
	__property TagStr = {default=0};
	__property TfrxUncheckStyle UncheckStyle = {read=FUncheckStyle, write=FUncheckStyle, default=0};
	__property URL = {default=0};
public:
	/* TfrxView.Destroy */ inline __fastcall virtual ~TfrxCheckBoxView(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCheckBoxView(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxView(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxchbox */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXCHBOX)
using namespace Fmx::Frxchbox;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxchboxHPP
