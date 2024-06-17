// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxChartGallery.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxchartgalleryHPP
#define Fmx_FrxchartgalleryHPP

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
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <FMX.frxFMX.hpp>
#include <FMXTee.Chart.GalleryPanel.hpp>
#include <FMXTee.Constants.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxchartgallery
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxChartGalleryForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxChartGalleryForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TToolBar* ToolBar1;
	Fmx::Stdctrls::TButton* Button1;
	Fmx::Stdctrls::TButton* Button2;
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	Fmxtee::Chart::Gallerypanel::TChartGalleryPanel* FTeePanel;
	Fmx::Tabcontrol::TTabControl* FTabs;
	
public:
	Fmxtee::Chart::Gallerypanel::TChartGalleryPanel* __fastcall GetGallery(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxChartGalleryForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxChartGalleryForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxChartGalleryForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxchartgallery */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXCHARTGALLERY)
using namespace Fmx::Frxchartgallery;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxchartgalleryHPP
