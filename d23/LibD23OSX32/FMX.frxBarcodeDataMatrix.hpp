// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxBarcodeDataMatrix.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxbarcodedatamatrixHPP
#define Fmx_FrxbarcodedatamatrixHPP

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
#include <System.StrUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.frxBarcode2DBase.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxbarcodedatamatrix
{
//-- forward type declarations -----------------------------------------------
struct DmParams;
struct SizeF;
class DELPHICLASS TfrxBarcodeDataMatrix;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM DatamatrixEncoding : unsigned char { Auto, Ascii, C40, Txt, Base256, X12, Edifact };

enum DECLSPEC_DENUM DatamatrixSymbolSize : unsigned char { AutoSize, Size10x10, Size12x12, Size8x18, Size14x14, Size8x32, Size16x16, Size12x26, Size18x18, Size20x20, Size12x36, Size22x22, Size16x36, Size24x24, Size26x26, Size16x48, Size32x32, Size36x36, Size40x40, Size44x44, Size48x48, Size52x52, Size64x64, Size72x72, Size80x80, Size88x88, Size96x96, Size104x104, Size120x120, Size132x132, Size144x144 };

struct DECLSPEC_DRECORD DmParams
{
public:
	int height;
	int width;
	int heightSection;
	int widthSection;
	int dataSize;
	int dataBlock;
	int errorBlock;
};


struct DECLSPEC_DRECORD SizeF
{
public:
	double height;
	double width;
};


typedef System::DynamicArray<int> TInts;

class PASCALIMPLEMENTATION TfrxBarcodeDataMatrix : public Fmx::Frxbarcode2dbase::TfrxBarcode2DBase
{
	typedef Fmx::Frxbarcode2dbase::TfrxBarcode2DBase inherited;
	
private:
	TInts FPlace;
	DatamatrixSymbolSize FSymbolSize;
	DatamatrixEncoding FEncoding;
	int FCodePage;
	void __fastcall SetBit(int x, int y, int xByte);
	void __fastcall Generate(System::UnicodeString &text)/* overload */;
	void __fastcall Generate(System::DynamicArray<System::Byte> &text, int textOffset, int textSize)/* overload */;
	int __fastcall GetEncodation(System::DynamicArray<System::Byte> &Text, int textOffset, int textSize, System::DynamicArray<System::Byte> &data, int dataOffset, int dataSize, bool firstMatch);
	void __fastcall Draw(System::DynamicArray<System::Byte> &data, int dataSize, const DmParams &dm);
	virtual void __fastcall SetText(System::UnicodeString v);
	void __fastcall SetCodePage(int cp);
	void __fastcall SetEncoding(DatamatrixEncoding v);
	void __fastcall Ecc200(void);
	void __fastcall SetSymbolSize(DatamatrixSymbolSize s);
	int __fastcall GetPixelSize(void);
	void __fastcall SetPixelSize(int v);
	
public:
	__fastcall virtual TfrxBarcodeDataMatrix(void);
	__fastcall virtual ~TfrxBarcodeDataMatrix(void);
	virtual void __fastcall Assign(Fmx::Frxbarcode2dbase::TfrxBarcode2DBase* src);
	
__published:
	__property DatamatrixSymbolSize SymbolSize = {read=FSymbolSize, write=SetSymbolSize, nodefault};
	__property DatamatrixEncoding Encoding = {read=FEncoding, write=SetEncoding, nodefault};
	__property int CodePage = {read=FCodePage, write=SetCodePage, nodefault};
	__property int PixelSize = {read=GetPixelSize, write=SetPixelSize, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::StaticArray<DmParams, 30> dmSizes;
extern DELPHI_PACKAGE System::StaticArray<int, 256> log;
extern DELPHI_PACKAGE System::StaticArray<int, 256> alog;
extern DELPHI_PACKAGE System::StaticArray<int, 5> poly5;
extern DELPHI_PACKAGE System::StaticArray<int, 7> poly7;
extern DELPHI_PACKAGE System::StaticArray<int, 10> poly10;
extern DELPHI_PACKAGE System::StaticArray<int, 11> poly11;
extern DELPHI_PACKAGE System::StaticArray<int, 12> poly12;
extern DELPHI_PACKAGE System::StaticArray<int, 14> poly14;
extern DELPHI_PACKAGE System::StaticArray<int, 18> poly18;
extern DELPHI_PACKAGE System::StaticArray<int, 20> poly20;
extern DELPHI_PACKAGE System::StaticArray<int, 24> poly24;
extern DELPHI_PACKAGE System::StaticArray<int, 28> poly28;
extern DELPHI_PACKAGE System::StaticArray<int, 36> poly36;
extern DELPHI_PACKAGE System::StaticArray<int, 42> poly42;
extern DELPHI_PACKAGE System::StaticArray<int, 48> poly48;
extern DELPHI_PACKAGE System::StaticArray<int, 56> poly56;
extern DELPHI_PACKAGE System::StaticArray<int, 62> poly62;
extern DELPHI_PACKAGE System::StaticArray<int, 68> poly68;
#define _x12 u"\r*> 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define cbDefaultText u"12345678"
extern DELPHI_PACKAGE void __fastcall GenerateECC(System::DynamicArray<System::Byte> &wd, int nd, int datablock, int nc);
}	/* namespace Frxbarcodedatamatrix */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXBARCODEDATAMATRIX)
using namespace Fmx::Frxbarcodedatamatrix;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxbarcodedatamatrixHPP
