// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxBarcod.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxbarcodHPP
#define Fmx_FrxbarcodHPP

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
#include <System.UIConsts.hpp>
#include <FMX.Types.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <System.Math.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.frxFMX.hpp>
#include <System.Math.Vectors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxbarcod
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBarcode;
struct TBCdata;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxBarcodeType : unsigned char { bcCode_2_5_interleaved, bcCode_2_5_industrial, bcCode_2_5_matrix, bcCode39, bcCode39Extended, bcCode128A, bcCode128B, bcCode128C, bcCode93, bcCode93Extended, bcCodeMSI, bcCodePostNet, bcCodeCodabar, bcCodeEAN8, bcCodeEAN13, bcCodeUPC_A, bcCodeUPC_E0, bcCodeUPC_E1, bcCodeUPC_Supp2, bcCodeUPC_Supp5, bcCodeEAN128A, bcCodeEAN128B, bcCodeEAN128C };

enum DECLSPEC_DENUM TfrxBarLineType : unsigned char { white, black, black_half };

enum DECLSPEC_DENUM TfrxCheckSumMethod : unsigned char { csmNone, csmModulo10 };

class PASCALIMPLEMENTATION TfrxBarcode : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	double FAngle;
	System::Uitypes::TAlphaColor FColor;
	System::Uitypes::TAlphaColor FFontColor;
	System::Uitypes::TAlphaColor FColorBar;
	bool FCheckSum;
	TfrxCheckSumMethod FCheckSumMethod;
	float FHeight;
	float FLeft;
	int FModul;
	double FRatio;
	System::AnsiString FText;
	float FTop;
	TfrxBarcodeType FTyp;
	Fmx::Graphics::TFont* FFont;
	System::Types::TRectF FDrawArea;
	System::StaticArray<System::Int8, 4> modules;
	void __fastcall DoLines(System::AnsiString data, Fmx::Graphics::TCanvas* Canvas, float Zoom);
	void __fastcall OneBarProps(char code, float &Width, TfrxBarLineType &lt);
	System::AnsiString __fastcall SetLen(System::Byte pI);
	System::AnsiString __fastcall Code_2_5_interleaved(void);
	System::AnsiString __fastcall Code_2_5_industrial(void);
	System::AnsiString __fastcall Code_2_5_matrix(void);
	System::AnsiString __fastcall Code_39(void);
	System::AnsiString __fastcall Code_39Extended(void);
	System::AnsiString __fastcall Code_128(void);
	System::AnsiString __fastcall Code_93(void);
	System::AnsiString __fastcall Code_93Extended(void);
	System::AnsiString __fastcall Code_MSI(void);
	System::AnsiString __fastcall Code_PostNet(void);
	System::AnsiString __fastcall Code_Codabar(void);
	System::AnsiString __fastcall Code_EAN8(void);
	System::AnsiString __fastcall Code_EAN13(void);
	System::AnsiString __fastcall Code_UPC_A(void);
	System::AnsiString __fastcall Code_UPC_E0(void);
	System::AnsiString __fastcall Code_UPC_E1(void);
	System::AnsiString __fastcall Code_Supp5(void);
	System::AnsiString __fastcall Code_Supp2(void);
	void __fastcall MakeModules(void);
	float __fastcall GetWidth(void);
	System::AnsiString __fastcall DoCheckSumming(const System::AnsiString data);
	System::AnsiString __fastcall MakeData(void);
	
public:
	__fastcall virtual TfrxBarcode(System::Classes::TComponent* Owner);
	__fastcall virtual ~TfrxBarcode(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall DrawBarcode(Fmx::Graphics::TCanvas* Canvas, const System::Types::TRect &ARect, bool ShowText, float AZoom, bool IsPrinting = false);
	
__published:
	__property System::AnsiString Text = {read=FText, write=FText};
	__property int Modul = {read=FModul, write=FModul, nodefault};
	__property double Ratio = {read=FRatio, write=FRatio};
	__property TfrxBarcodeType Typ = {read=FTyp, write=FTyp, nodefault};
	__property bool Checksum = {read=FCheckSum, write=FCheckSum, nodefault};
	__property TfrxCheckSumMethod CheckSumMethod = {read=FCheckSumMethod, write=FCheckSumMethod, nodefault};
	__property double Angle = {read=FAngle, write=FAngle};
	__property float Width = {read=GetWidth};
	__property float Height = {read=FHeight, write=FHeight};
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=FColor, nodefault};
	__property System::Uitypes::TAlphaColor ColorBar = {read=FColorBar, write=FColorBar, nodefault};
	__property System::Uitypes::TAlphaColor FontColor = {read=FFontColor, write=FFontColor, default=-16777216};
	__property Fmx::Graphics::TFont* Font = {read=FFont, write=FFont};
};


#pragma pack(push,1)
struct DECLSPEC_DRECORD TBCdata
{
public:
	System::AnsiString Name;
	bool num;
};
#pragma pack(pop)


typedef System::StaticArray<TBCdata, 23> Fmx_Frxbarcod__2;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Fmx_Frxbarcod__2 BCdata;
}	/* namespace Frxbarcod */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXBARCOD)
using namespace Fmx::Frxbarcod;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxbarcodHPP
