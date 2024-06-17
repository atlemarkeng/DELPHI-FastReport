// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxPrinter.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxprinterHPP
#define Fmx_FrxprinterHPP

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
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxprinter
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxCustomPrinter;
class DELPHICLASS TfrxVirtualPrinter;
class DELPHICLASS TfrxCustomPrinters;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCustomPrinter : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	int FBin;
	int FDuplex;
	System::Classes::TStrings* FBins;
	Fmx::Graphics::TCanvas* FCanvas;
	System::Uitypes::TPrinterOrientation FDefOrientation;
	int FDefPaper;
	double FDefPaperHeight;
	double FDefPaperWidth;
	int FDefDuplex;
	int FDefBin;
	System::Types::TPoint FDPI;
	System::UnicodeString FFileName;
	NativeUInt FHandle;
	bool FInitialized;
	System::UnicodeString FName;
	int FPaper;
	System::Classes::TStrings* FPapers;
	double FPaperHeight;
	double FPaperWidth;
	double FLeftMargin;
	double FTopMargin;
	double FRightMargin;
	double FBottomMargin;
	System::Uitypes::TPrinterOrientation FOrientation;
	System::UnicodeString FPort;
	bool FPrinting;
	System::UnicodeString FTitle;
	
public:
	__fastcall virtual TfrxCustomPrinter(const System::UnicodeString AName, const System::UnicodeString APort);
	__fastcall virtual ~TfrxCustomPrinter(void);
	virtual void __fastcall Init(void) = 0 ;
	virtual void __fastcall Abort(void) = 0 ;
	virtual void __fastcall BeginDoc(void) = 0 ;
	virtual void __fastcall BeginPage(void) = 0 ;
	virtual void __fastcall BeginRAWDoc(void) = 0 ;
	virtual void __fastcall EndDoc(void) = 0 ;
	virtual void __fastcall EndPage(void) = 0 ;
	virtual void __fastcall EndRAWDoc(void) = 0 ;
	virtual void __fastcall WriteRAWDoc(const System::AnsiString buf) = 0 ;
	int __fastcall BinIndex(int ABin);
	int __fastcall PaperIndex(int APaper);
	int __fastcall BinNameToNumber(const System::UnicodeString ABin);
	int __fastcall PaperNameToNumber(const System::UnicodeString APaper);
	virtual void __fastcall SetViewParams(int APaperSize, System::Extended APaperWidth, System::Extended APaperHeight, System::Uitypes::TPrinterOrientation AOrientation) = 0 ;
	virtual void __fastcall SetPrintParams(int APaperSize, System::Extended APaperWidth, System::Extended APaperHeight, System::Uitypes::TPrinterOrientation AOrientation, int ABin, int ADuplex, int ACopies) = 0 ;
	virtual void __fastcall PropertiesDlg(void) = 0 ;
	virtual bool __fastcall ShowPrintDialog(void) = 0 ;
	__property int Bin = {read=FBin, nodefault};
	__property int Duplex = {read=FDuplex, nodefault};
	__property System::Classes::TStrings* Bins = {read=FBins};
	__property Fmx::Graphics::TCanvas* Canvas = {read=FCanvas};
	__property System::Uitypes::TPrinterOrientation DefOrientation = {read=FDefOrientation, nodefault};
	__property int DefPaper = {read=FDefPaper, nodefault};
	__property double DefPaperHeight = {read=FDefPaperHeight};
	__property double DefPaperWidth = {read=FDefPaperWidth};
	__property int DefBin = {read=FDefBin, nodefault};
	__property int DefDuplex = {read=FDefDuplex, nodefault};
	__property System::Types::TPoint DPI = {read=FDPI};
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property NativeUInt Handle = {read=FHandle, nodefault};
	__property System::UnicodeString Name = {read=FName};
	__property int Paper = {read=FPaper, nodefault};
	__property System::Classes::TStrings* Papers = {read=FPapers};
	__property double PaperHeight = {read=FPaperHeight};
	__property double PaperWidth = {read=FPaperWidth};
	__property double LeftMargin = {read=FLeftMargin};
	__property double TopMargin = {read=FTopMargin};
	__property double RightMargin = {read=FRightMargin};
	__property double BottomMargin = {read=FBottomMargin};
	__property System::Uitypes::TPrinterOrientation Orientation = {read=FOrientation, nodefault};
	__property System::UnicodeString Port = {read=FPort};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property bool Initialized = {read=FInitialized, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxVirtualPrinter : public TfrxCustomPrinter
{
	typedef TfrxCustomPrinter inherited;
	
public:
	virtual void __fastcall Init(void);
	virtual void __fastcall Abort(void);
	virtual void __fastcall BeginDoc(void);
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall BeginRAWDoc(void);
	virtual void __fastcall EndDoc(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall EndRAWDoc(void);
	virtual void __fastcall WriteRAWDoc(const System::AnsiString buf);
	virtual void __fastcall SetViewParams(int APaperSize, System::Extended APaperWidth, System::Extended APaperHeight, System::Uitypes::TPrinterOrientation AOrientation);
	virtual void __fastcall SetPrintParams(int APaperSize, System::Extended APaperWidth, System::Extended APaperHeight, System::Uitypes::TPrinterOrientation AOrientation, int ABin, int ADuplex, int ACopies);
	virtual void __fastcall PropertiesDlg(void);
public:
	/* TfrxCustomPrinter.Create */ inline __fastcall virtual TfrxVirtualPrinter(const System::UnicodeString AName, const System::UnicodeString APort) : TfrxCustomPrinter(AName, APort) { }
	/* TfrxCustomPrinter.Destroy */ inline __fastcall virtual ~TfrxVirtualPrinter(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCustomPrinters : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxCustomPrinter* operator[](int Index) { return this->Items[Index]; }
	
protected:
	bool FHasPhysicalPrinters;
	System::Classes::TStrings* FPrinters;
	int FPrinterIndex;
	System::Classes::TList* FPrinterList;
	TfrxCustomPrinter* __fastcall GetItem(int Index);
	TfrxCustomPrinter* __fastcall GetCurrentPrinter(void);
	void __fastcall SetPrinterIndex(int Value);
	virtual System::UnicodeString __fastcall GetDefaultPrinter(void);
	
public:
	__fastcall TfrxCustomPrinters(void);
	__fastcall virtual ~TfrxCustomPrinters(void);
	int __fastcall IndexOf(System::UnicodeString AName);
	void __fastcall Clear(void);
	virtual void __fastcall FillPrinters(void);
	__property TfrxCustomPrinter* Items[int Index] = {read=GetItem/*, default*/};
	__property bool HasPhysicalPrinters = {read=FHasPhysicalPrinters, nodefault};
	__property TfrxCustomPrinter* Printer = {read=GetCurrentPrinter};
	__property int PrinterIndex = {read=FPrinterIndex, write=SetPrinterIndex, nodefault};
	__property System::Classes::TStrings* Printers = {read=FPrinters};
};

#pragma pack(pop)

typedef System::TMetaClass* TfrxCustomPrintersClass;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall frxGetPaperDimensions(int PaperSize, double &Width, double &Height);
extern DELPHI_PACKAGE TfrxCustomPrinters* __fastcall frxPrinters(void);
}	/* namespace Frxprinter */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXPRINTER)
using namespace Fmx::Frxprinter;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxprinterHPP
