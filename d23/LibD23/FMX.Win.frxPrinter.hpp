// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.Win.frxPrinter.pas' rev: 30.00 (Windows)

#ifndef Fmx_Win_FrxprinterHPP
#define Fmx_Win_FrxprinterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.WinSpool.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.frxPrinter.hpp>
#include <FMX.Printer.Win.hpp>
#include <FMX.Printer.hpp>
#include <FMX.Canvas.GDIP.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Win
{
namespace Frxprinter
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THackCanvas;
class DELPHICLASS TFakePrinterWin;
class DELPHICLASS TfrxPrinter;
class DELPHICLASS TfrxPrinters;
class DELPHICLASS TfrxPrinterCanvas;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION THackCanvas : public Fmx::Graphics::TCanvas
{
	typedef Fmx::Graphics::TCanvas inherited;
	
protected:
	/* TCanvas.CreateFromWindow */ inline __fastcall virtual THackCanvas(Fmx::Types::TWindowHandle* const AParent, const int AWidth, const int AHeight, const Fmx::Graphics::TCanvasQuality AQuality) : Fmx::Graphics::TCanvas(AParent, AWidth, AHeight, AQuality) { }
	/* TCanvas.CreateFromBitmap */ inline __fastcall virtual THackCanvas(Fmx::Graphics::TBitmap* const ABitmap, const Fmx::Graphics::TCanvasQuality AQuality) : Fmx::Graphics::TCanvas(ABitmap, AQuality) { }
	/* TCanvas.CreateFromPrinter */ inline __fastcall virtual THackCanvas(Fmx::Graphics::TAbstractPrinter* const APrinter) : Fmx::Graphics::TCanvas(APrinter) { }
	
public:
	/* TCanvas.Destroy */ inline __fastcall virtual ~THackCanvas(void) { }
	
public:
	/* TObject.Create */ inline __fastcall THackCanvas(void) : Fmx::Graphics::TCanvas() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TFakePrinterWin : public Fmx::Printer::Win::TPrinterWin
{
	typedef Fmx::Printer::Win::TPrinterWin inherited;
	
protected:
	int FPageHeight;
	int FPageWidth;
	virtual void __fastcall ActivePrinterChanged(void);
	virtual void __fastcall DoAbortDoc(void);
	virtual void __fastcall DoBeginDoc(void);
	virtual void __fastcall DoEndDoc(void);
	virtual void __fastcall DoNewPage(void);
	virtual Fmx::Graphics::TCanvas* __fastcall GetCanvas(void);
	virtual int __fastcall GetNumCopies(void);
	virtual System::Uitypes::TPrinterOrientation __fastcall GetOrientation(void);
	virtual int __fastcall GetPageHeight(void);
	virtual int __fastcall GetPageWidth(void);
	virtual void __fastcall RefreshFonts(void);
	virtual void __fastcall RefreshPrinterDevices(void);
	virtual void __fastcall SetOrientation(System::Uitypes::TPrinterOrientation Value);
	virtual void __fastcall SetNumCopies(int Value);
	virtual void __fastcall SetDefaultPrinter(void);
	
public:
	__fastcall virtual TFakePrinterWin(void);
	__fastcall virtual ~TFakePrinterWin(void);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxPrinter : public Fmx::Frxprinter::TfrxCustomPrinter
{
	typedef Fmx::Frxprinter::TfrxCustomPrinter inherited;
	
private:
	NativeUInt FDeviceMode;
	HDC FDC;
	System::UnicodeString FDriver;
	_devicemodeW *FMode;
	TFakePrinterWin* FWinPrinter;
	System::Classes::TNotifyEvent FOnChangedFont;
	void __fastcall CreateDevMode(void);
	void __fastcall FreeDevMode(void);
	void __fastcall GetDC(void);
	void __fastcall FontChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TfrxPrinter(const System::UnicodeString AName, const System::UnicodeString APort);
	__fastcall virtual ~TfrxPrinter(void);
	virtual void __fastcall Init(void);
	void __fastcall RecreateDC(void);
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
	virtual bool __fastcall ShowPrintDialog(void);
	bool __fastcall UpdateDeviceCaps(void);
	__property Winapi::Windows::PDeviceModeW DeviceMode = {read=FMode};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPrinters : public Fmx::Frxprinter::TfrxCustomPrinters
{
	typedef Fmx::Frxprinter::TfrxCustomPrinters inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetDefaultPrinter(void);
	
public:
	__fastcall TfrxPrinters(void);
	__fastcall virtual ~TfrxPrinters(void);
	virtual void __fastcall FillPrinters(void);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPrinterCanvas : public Fmx::Graphics::TCanvas
{
	typedef Fmx::Graphics::TCanvas inherited;
	
private:
	Fmx::Frxprinter::TfrxCustomPrinter* FPrinter;
protected:
	/* TCanvas.CreateFromWindow */ inline __fastcall virtual TfrxPrinterCanvas(Fmx::Types::TWindowHandle* const AParent, const int AWidth, const int AHeight, const Fmx::Graphics::TCanvasQuality AQuality) : Fmx::Graphics::TCanvas(AParent, AWidth, AHeight, AQuality) { }
	/* TCanvas.CreateFromBitmap */ inline __fastcall virtual TfrxPrinterCanvas(Fmx::Graphics::TBitmap* const ABitmap, const Fmx::Graphics::TCanvasQuality AQuality) : Fmx::Graphics::TCanvas(ABitmap, AQuality) { }
	/* TCanvas.CreateFromPrinter */ inline __fastcall virtual TfrxPrinterCanvas(Fmx::Graphics::TAbstractPrinter* const APrinter) : Fmx::Graphics::TCanvas(APrinter) { }
	
public:
	/* TCanvas.Destroy */ inline __fastcall virtual ~TfrxPrinterCanvas(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxPrinterCanvas(void) : Fmx::Graphics::TCanvas() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall frxGetPaperDimensions(int PaperSize, System::Extended &Width, System::Extended &Height);
extern DELPHI_PACKAGE Fmx::Frxprinter::TfrxCustomPrintersClass __fastcall ActualfrxPrinterClass(void);
}	/* namespace Frxprinter */
}	/* namespace Win */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_WIN_FRXPRINTER)
using namespace Fmx::Win::Frxprinter;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_WIN)
using namespace Fmx::Win;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_Win_FrxprinterHPP
