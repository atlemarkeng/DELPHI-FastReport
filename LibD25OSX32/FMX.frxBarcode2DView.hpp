// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxBarcode2DView.pas' rev: 32.00 (MacOS)

#ifndef Fmx_Frxbarcode2dviewHPP
#define Fmx_Frxbarcode2dviewHPP

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
#include <System.UIConsts.hpp>
#include <System.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Types.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Menus.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxDesgn.hpp>
#include <FMX.frxBarcodePDF417.hpp>
#include <FMX.frxBarcodeQR.hpp>
#include <FMX.frxBarcodeDataMatrix.hpp>
#include <FMX.frxBarcode2DBase.hpp>
#include <FMX.frxBarcodeProperties.hpp>
#include <System.Variants.hpp>
#include <FMX.Graphics.hpp>
#include <System.Math.Vectors.hpp>
#include <FMX.frxFMX.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxbarcode2dview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS Tfrx2DBarCodeObject;
class DELPHICLASS TfrxBarcode2DView;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxBarcodeType : unsigned char { bc_datamatrix, bc_PDF417, bcCodeQR };

class PASCALIMPLEMENTATION Tfrx2DBarCodeObject : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual Tfrx2DBarCodeObject(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~Tfrx2DBarCodeObject(void) { }
	
};


class PASCALIMPLEMENTATION TfrxBarcode2DView : public Fmx::Frxclass::TfrxView
{
	typedef Fmx::Frxclass::TfrxView inherited;
	
private:
	Fmx::Frxbarcode2dbase::TfrxBarcode2DBase* FBarCode;
	TfrxBarcodeType FBarType;
	Fmx::Frxclass::TfrxHAlign FHAlign;
	Fmx::Frxbarcodeproperties::TUniqueProp* FProp;
	System::UnicodeString FExpression;
	void __fastcall SetZoom(double z);
	double __fastcall GetZoom(void);
	void __fastcall SetRotation(int Value);
	int __fastcall GetRotation(void);
	void __fastcall SetShowText(bool Value);
	bool __fastcall GetShowText(void);
	void __fastcall SetText(System::UnicodeString Value);
	System::UnicodeString __fastcall GetText(void);
	void __fastcall SetFontScaled(bool Value);
	bool __fastcall GetFontScaled(void);
	void __fastcall SetErrorText(System::UnicodeString Value);
	System::UnicodeString __fastcall GetErrorText(void);
	void __fastcall SetQuiteZone(int Value);
	int __fastcall GetQuiteZone(void);
	void __fastcall SetProp(Fmx::Frxbarcodeproperties::TUniqueProp* Value);
	void __fastcall SetBarType(TfrxBarcodeType Value);
	
public:
	__fastcall virtual TfrxBarcode2DView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxBarcode2DView(void);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall GetData(void);
	
__published:
	__property System::UnicodeString Expression = {read=FExpression, write=FExpression};
	__property TfrxBarcodeType BarType = {read=FBarType, write=SetBarType, nodefault};
	__property Fmx::Frxbarcodeproperties::TUniqueProp* BarProperties = {read=FProp, write=SetProp};
	__property BrushStyle;
	__property Color = {default=0};
	__property Cursor = {default=0};
	__property DataField = {default=0};
	__property DataSet;
	__property DataSetName = {default=0};
	__property Frame;
	__property Fmx::Frxclass::TfrxHAlign HAlign = {read=FHAlign, write=FHAlign, default=0};
	__property int Rotation = {read=GetRotation, write=SetRotation, nodefault};
	__property bool ShowText = {read=GetShowText, write=SetShowText, nodefault};
	__property TagStr = {default=0};
	__property System::UnicodeString Text = {read=GetText, write=SetText};
	__property URL = {default=0};
	__property double Zoom = {read=GetZoom, write=SetZoom};
	__property Font;
	__property bool FontScaled = {read=GetFontScaled, write=SetFontScaled, nodefault};
	__property System::UnicodeString ErrorText = {read=GetErrorText, write=SetErrorText};
	__property int QuiteZone = {read=GetQuiteZone, write=SetQuiteZone, nodefault};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxBarcode2DView(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxView(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbarcode2dview */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXBARCODE2DVIEW)
using namespace Fmx::Frxbarcode2dview;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_Frxbarcode2dviewHPP
