// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxBarcodeProperties.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxbarcodepropertiesHPP
#define Fmx_FrxbarcodepropertiesHPP

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
#include <FMX.Types.hpp>
#include <FMX.Objects.hpp>
#include <System.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Menus.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxDesgn.hpp>
#include <FMX.frxBarcodePDF417.hpp>
#include <FMX.frxBarcodeDataMatrix.hpp>
#include <FMX.frxBarcode2DBase.hpp>
#include <FMX.DelphiZXingQRCode.hpp>
#include <FMX.frxBarcodeQR.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxbarcodeproperties
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TUniqueProp;
class DELPHICLASS TPDF417UniqueProperties;
class DELPHICLASS TDataMatrixUniqueProperties;
class DELPHICLASS TfrxQRProperties;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TUniqueProp : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Classes::TNotifyEvent FOnChange;
	
public:
	System::TObject* FWhose;
	void __fastcall Changed(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source) = 0 ;
	void __fastcall SetWhose(System::TObject* w);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TUniqueProp(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TUniqueProp(void) : System::Classes::TPersistent() { }
	
};


class PASCALIMPLEMENTATION TPDF417UniqueProperties : public TUniqueProp
{
	typedef TUniqueProp inherited;
	
private:
	double __fastcall GetAspectRatio(void);
	int __fastcall GetColumns(void);
	int __fastcall GetRows(void);
	Fmx::Frxbarcodepdf417::PDF417ErrorCorrection __fastcall GetErrorCorrection(void);
	int __fastcall GetCodePage(void);
	Fmx::Frxbarcodepdf417::PDF417CompactionMode __fastcall GetCompactionMode(void);
	int __fastcall GetPixelWidth(void);
	int __fastcall GetPixelHeight(void);
	void __fastcall SetAspectRatio(double v);
	void __fastcall SetColumns(int v);
	void __fastcall SetRows(int v);
	void __fastcall SetErrorCorrection(Fmx::Frxbarcodepdf417::PDF417ErrorCorrection v);
	void __fastcall SetCodePage(int v);
	void __fastcall SetCompactionMode(Fmx::Frxbarcodepdf417::PDF417CompactionMode v);
	void __fastcall SetPixelWidth(int v);
	void __fastcall SetPixelHeight(int v);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property double AspectRatio = {read=GetAspectRatio, write=SetAspectRatio};
	__property int Columns = {read=GetColumns, write=SetColumns, nodefault};
	__property int Rows = {read=GetRows, write=SetRows, nodefault};
	__property Fmx::Frxbarcodepdf417::PDF417ErrorCorrection ErrorCorrection = {read=GetErrorCorrection, write=SetErrorCorrection, nodefault};
	__property int CodePage = {read=GetCodePage, write=SetCodePage, nodefault};
	__property Fmx::Frxbarcodepdf417::PDF417CompactionMode CompactionMode = {read=GetCompactionMode, write=SetCompactionMode, nodefault};
	__property int PixelWidth = {read=GetPixelWidth, write=SetPixelWidth, nodefault};
	__property int PixelHeight = {read=GetPixelHeight, write=SetPixelHeight, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPDF417UniqueProperties(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TPDF417UniqueProperties(void) : TUniqueProp() { }
	
};


class PASCALIMPLEMENTATION TDataMatrixUniqueProperties : public TUniqueProp
{
	typedef TUniqueProp inherited;
	
private:
	int __fastcall GetCodePage(void);
	int __fastcall GetPixelSize(void);
	Fmx::Frxbarcodedatamatrix::DatamatrixSymbolSize __fastcall GetSymbolSize(void);
	Fmx::Frxbarcodedatamatrix::DatamatrixEncoding __fastcall GetEncoding(void);
	void __fastcall SetCodePage(int v);
	void __fastcall SetPixelSize(int v);
	void __fastcall SetSymbolSize(Fmx::Frxbarcodedatamatrix::DatamatrixSymbolSize v);
	void __fastcall SetEncoding(Fmx::Frxbarcodedatamatrix::DatamatrixEncoding v);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int CodePage = {read=GetCodePage, write=SetCodePage, nodefault};
	__property int PixelSize = {read=GetPixelSize, write=SetPixelSize, nodefault};
	__property Fmx::Frxbarcodedatamatrix::DatamatrixSymbolSize SymbolSize = {read=GetSymbolSize, write=SetSymbolSize, nodefault};
	__property Fmx::Frxbarcodedatamatrix::DatamatrixEncoding Encoding = {read=GetEncoding, write=SetEncoding, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TDataMatrixUniqueProperties(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TDataMatrixUniqueProperties(void) : TUniqueProp() { }
	
};


class PASCALIMPLEMENTATION TfrxQRProperties : public TUniqueProp
{
	typedef TUniqueProp inherited;
	
private:
	Fmx::Delphizxingqrcode::TQRCodeEncoding __fastcall GetEncoding(void);
	int __fastcall GetQuietZone(void);
	int __fastcall GetPixelSize(void);
	void __fastcall SetPixelSize(int v);
	void __fastcall SetEncoding(const Fmx::Delphizxingqrcode::TQRCodeEncoding Value);
	void __fastcall SetQuietZone(const int Value);
	Fmx::Delphizxingqrcode::TQRErrorLevels __fastcall GetErrorLevels(void);
	void __fastcall SetErrorLevels(const Fmx::Delphizxingqrcode::TQRErrorLevels Value);
	int __fastcall GetCodePage(void);
	void __fastcall SetCodePage(const int Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Fmx::Delphizxingqrcode::TQRCodeEncoding Encoding = {read=GetEncoding, write=SetEncoding, nodefault};
	__property int QuietZone = {read=GetQuietZone, write=SetQuietZone, nodefault};
	__property Fmx::Delphizxingqrcode::TQRErrorLevels ErrorLevels = {read=GetErrorLevels, write=SetErrorLevels, nodefault};
	__property int PixelSize = {read=GetPixelSize, write=SetPixelSize, nodefault};
	__property int CodePage = {read=GetCodePage, write=SetCodePage, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxQRProperties(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxQRProperties(void) : TUniqueProp() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbarcodeproperties */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXBARCODEPROPERTIES)
using namespace Fmx::Frxbarcodeproperties;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxbarcodepropertiesHPP
