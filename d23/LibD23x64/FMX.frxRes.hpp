// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxRes.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxresHPP
#define Fmx_FrxresHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <System.WideStrings.hpp>
#include <System.Types.hpp>
#include <FMX.Types.hpp>
#include <System.UIConsts.hpp>
#include <FMX.frxUnicodeUtils.hpp>
#include <FMX.frxUtils.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxres
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxResources;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxResources : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStringList* FNames;
	Fmx::Graphics::TBitmap* FImages;
	System::Widestrings::TWideStrings* FValues;
	System::Classes::TStringList* FLanguages;
	System::UnicodeString FHelpFile;
	unsigned FCP;
	int FImgWidth;
	int FImgHeight;
	void __fastcall BuildLanguagesList(void);
	Fmx::Graphics::TBitmap* __fastcall GetImages(void);
	
public:
	__fastcall TfrxResources(void);
	__fastcall virtual ~TfrxResources(void);
	System::UnicodeString __fastcall Get(const System::UnicodeString StrName);
	void __fastcall Add(const System::UnicodeString Ref, const System::UnicodeString Str);
	void __fastcall AddW(const System::UnicodeString Ref, System::WideString Str);
	void __fastcall AddStrings(const System::UnicodeString Str);
	void __fastcall AddXML(const System::AnsiString Str);
	void __fastcall Clear(void);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall LoadImageFromResouce(Fmx::Graphics::TBitmap* Image, int RowId, int ColId)/* overload */;
	void __fastcall LoadImageFromResouce(Fmx::Graphics::TBitmap* Image, int Index)/* overload */;
	void __fastcall UpdateFSResources(void);
	void __fastcall Help(System::TObject* Sender)/* overload */;
	__property Fmx::Graphics::TBitmap* Images = {read=GetImages};
	__property System::Classes::TStringList* Languages = {read=FLanguages};
	__property System::UnicodeString HelpFile = {read=FHelpFile, write=FHelpFile};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxResources* __fastcall frxResources(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxGet(int ID);
}	/* namespace Frxres */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXRES)
using namespace Fmx::Frxres;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxresHPP
