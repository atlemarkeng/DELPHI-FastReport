// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxBarcodeQR.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxbarcodeqrHPP
#define Fmx_FrxbarcodeqrHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.StrUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Objects.hpp>
#include <FMX.frxBarcode2DBase.hpp>
#include <FMX.DelphiZXingQRCode.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxbarcodeqr
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBarcodeQR;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxBarcodeQR : public Fmx::Frxbarcode2dbase::TfrxBarcode2DBase
{
	typedef Fmx::Frxbarcode2dbase::TfrxBarcode2DBase inherited;
	
private:
	Fmx::Delphizxingqrcode::TDelphiZXingQRCode* FDelphiZXingQRCode;
	void __fastcall Generate(void);
	Fmx::Delphizxingqrcode::TQRCodeEncoding __fastcall GetEncoding(void);
	int __fastcall GetQuietZone(void);
	void __fastcall SetEncoding(const Fmx::Delphizxingqrcode::TQRCodeEncoding Value);
	void __fastcall SetQuietZone(const int Value);
	Fmx::Delphizxingqrcode::TQRErrorLevels __fastcall GetErrorLevels(void);
	void __fastcall SetErrorLevels(const Fmx::Delphizxingqrcode::TQRErrorLevels Value);
	int __fastcall GetPixelSize(void);
	void __fastcall SetPixelSize(int v);
	int __fastcall GetCodepage(void);
	void __fastcall SetCodepage(const int Value);
	
protected:
	virtual void __fastcall SetText(System::UnicodeString v);
	
public:
	__fastcall virtual TfrxBarcodeQR(void);
	__fastcall virtual ~TfrxBarcodeQR(void);
	virtual void __fastcall Assign(Fmx::Frxbarcode2dbase::TfrxBarcode2DBase* src);
	
__published:
	__property Fmx::Delphizxingqrcode::TQRCodeEncoding Encoding = {read=GetEncoding, write=SetEncoding, nodefault};
	__property int QuietZone = {read=GetQuietZone, write=SetQuietZone, nodefault};
	__property Fmx::Delphizxingqrcode::TQRErrorLevels ErrorLevels = {read=GetErrorLevels, write=SetErrorLevels, nodefault};
	__property int PixelSize = {read=GetPixelSize, write=SetPixelSize, nodefault};
	__property int Codepage = {read=GetCodepage, write=SetCodepage, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbarcodeqr */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXBARCODEQR)
using namespace Fmx::Frxbarcodeqr;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxbarcodeqrHPP
