// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxImageConverter.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrximageconverterHPP
#define Fmx_FrximageconverterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Surfaces.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.frxFMX.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frximageconverter
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxPictureType : unsigned char { gpPNG, gpBMP, gpEMF, gpWMF, gpJPG, gpGIF };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetPicFileExtension(TfrxPictureType PicType);
extern DELPHI_PACKAGE void __fastcall SaveGraphicAs(Fmx::Graphics::TBitmap* Graphic, System::UnicodeString Path, TfrxPictureType PicType)/* overload */;
extern DELPHI_PACKAGE void __fastcall SaveGraphicAs(Fmx::Graphics::TBitmap* Graphic, System::Classes::TStream* Stream, TfrxPictureType PicType)/* overload */;
}	/* namespace Frximageconverter */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXIMAGECONVERTER)
using namespace Fmx::Frximageconverter;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrximageconverterHPP
