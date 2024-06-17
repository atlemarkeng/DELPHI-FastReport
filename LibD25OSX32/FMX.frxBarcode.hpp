// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxBarcode.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxbarcodeHPP
#define Fmx_FrxbarcodeHPP

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
#include <System.UIConsts.hpp>
#include <FMX.Types.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Menus.hpp>
#include <FMX.frxBarcod.hpp>
#include <FMX.frxClass.hpp>
#include <System.Variants.hpp>
#include <FMX.Graphics.hpp>
#include <System.Math.Vectors.hpp>
#include <System.UITypes.hpp>
#include <FMX.frxFMX.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxbarcode
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBarCodeObject;
class DELPHICLASS TfrxBarCodeView;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxBarCodeObject : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfrxBarCodeObject(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxBarCodeObject(void) { }
	
};


class PASCALIMPLEMENTATION TfrxBarCodeView : public Fmx::Frxclass::TfrxView
{
	typedef Fmx::Frxclass::TfrxView inherited;
	
private:
	Fmx::Frxbarcod::TfrxBarcode* FBarCode;
	Fmx::Frxbarcod::TfrxBarcodeType FBarType;
	bool FCalcCheckSum;
	System::UnicodeString FExpression;
	Fmx::Frxclass::TfrxHAlign FHAlign;
	int FRotation;
	bool FShowText;
	System::UnicodeString FText;
	double FWideBarRatio;
	double FZoom;
	void __fastcall BcFontChanged(System::TObject* Sender);
	void __fastcall SetRotation(const int Value);
	
public:
	__fastcall virtual TfrxBarCodeView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxBarCodeView(void);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall GetData(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual Fmx::Frxclass::TfrxRect __fastcall GetRealBounds(void);
	__property Fmx::Frxbarcod::TfrxBarcode* BarCode = {read=FBarCode};
	
__published:
	__property Fmx::Frxbarcod::TfrxBarcodeType BarType = {read=FBarType, write=FBarType, nodefault};
	__property BrushStyle;
	__property bool CalcCheckSum = {read=FCalcCheckSum, write=FCalcCheckSum, default=0};
	__property Color = {default=0};
	__property Cursor = {default=0};
	__property DataField = {default=0};
	__property DataSet;
	__property DataSetName = {default=0};
	__property System::UnicodeString Expression = {read=FExpression, write=FExpression};
	__property Frame;
	__property Fmx::Frxclass::TfrxHAlign HAlign = {read=FHAlign, write=FHAlign, default=0};
	__property int Rotation = {read=FRotation, write=SetRotation, nodefault};
	__property bool ShowText = {read=FShowText, write=FShowText, default=1};
	__property TagStr = {default=0};
	__property System::UnicodeString Text = {read=FText, write=FText};
	__property URL = {default=0};
	__property double WideBarRatio = {read=FWideBarRatio, write=FWideBarRatio};
	__property double Zoom = {read=FZoom, write=FZoom};
	__property Font;
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxBarCodeView(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxView(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbarcode */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXBARCODE)
using namespace Fmx::Frxbarcode;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxbarcodeHPP
