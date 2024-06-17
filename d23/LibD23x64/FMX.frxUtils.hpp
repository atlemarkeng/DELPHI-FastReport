// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxUtils.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxutilsHPP
#define Fmx_FrxutilsHPP

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
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <System.IniFiles.hpp>
#include <System.UIConsts.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxutils
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxRectArea;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxRectArea : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Extended X;
	System::Extended Y;
	System::Extended X1;
	System::Extended Y1;
	__fastcall TfrxRectArea(Fmx::Frxclass::TfrxComponent* c)/* overload */;
	__fastcall TfrxRectArea(System::Extended Left, System::Extended Top, System::Extended Right, System::Extended Bottom)/* overload */;
	bool __fastcall InterceptsX(TfrxRectArea* a);
	bool __fastcall InterceptsY(TfrxRectArea* a);
	TfrxRectArea* __fastcall InterceptX(TfrxRectArea* a);
	TfrxRectArea* __fastcall InterceptY(TfrxRectArea* a);
	System::Extended __fastcall Max(System::Extended x1, System::Extended x2);
	System::Extended __fastcall Min(System::Extended x1, System::Extended x2);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxRectArea(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall frxSaveFormPosition(System::Inifiles::TCustomIniFile* Ini, Fmx::Forms::TForm* f);
extern DELPHI_PACKAGE void __fastcall frxRestoreFormPosition(System::Inifiles::TCustomIniFile* Ini, Fmx::Forms::TForm* f);
extern DELPHI_PACKAGE Fmx::Types::TTextAlign __fastcall frxHAlignToTextAlign(Fmx::Frxclass::TfrxHAlign HAlign);
extern DELPHI_PACKAGE Fmx::Types::TTextAlign __fastcall frxVAlignToTextAlign(Fmx::Frxclass::TfrxVAlign VAlign);
extern DELPHI_PACKAGE unsigned __fastcall frxStreamCRC32(System::Classes::TStream* Stream);
extern DELPHI_PACKAGE System::Classes::TComponent* __fastcall frxFindComponent(System::Classes::TComponent* Owner, const System::UnicodeString Name);
extern DELPHI_PACKAGE void __fastcall frxGetComponents(System::Classes::TComponent* Owner, System::TClass ClassRef, System::Classes::TStrings* List, System::Classes::TComponent* Skip);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxGetFullName(System::Classes::TComponent* Owner, System::Classes::TComponent* c);
extern DELPHI_PACKAGE void __fastcall frxSetCommaText(const System::UnicodeString Text, System::Classes::TStrings* sl, System::WideChar Comma = (System::WideChar)(0x3b));
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxRemoveQuotes(const System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxStreamToString(System::Classes::TStream* Stream);
extern DELPHI_PACKAGE void __fastcall frxStringToStream(const System::UnicodeString s, System::Classes::TStream* Stream);
extern DELPHI_PACKAGE System::Extended __fastcall frxStrToFloat(System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxFloatToStr(System::Extended d);
extern DELPHI_PACKAGE Fmx::Frxclass::TfrxRect __fastcall frxRect(System::Extended ALeft, System::Extended ATop, System::Extended ARight, System::Extended ABottom);
extern DELPHI_PACKAGE Fmx::Frxclass::TfrxPoint __fastcall frxPoint(System::Extended X, System::Extended Y);
extern DELPHI_PACKAGE System::AnsiString __fastcall frxGetBrackedVariable(const System::AnsiString Str, const System::AnsiString OpenBracket, const System::AnsiString CloseBracket, int &i, int &j);
extern DELPHI_PACKAGE System::WideString __fastcall frxGetBrackedVariableW(const System::WideString Str, const System::WideString OpenBracket, const System::WideString CloseBracket, int &i, int &j);
extern DELPHI_PACKAGE void __fastcall frxCommonErrorHandler(Fmx::Frxclass::TfrxReport* Report, const System::UnicodeString Text);
extern DELPHI_PACKAGE void __fastcall frxErrorMsg(const System::UnicodeString Text);
extern DELPHI_PACKAGE int __fastcall frxConfirmMsg(const System::UnicodeString Text, System::Uitypes::TMsgDlgButtons Buttons);
extern DELPHI_PACKAGE void __fastcall frxInfoMsg(const System::UnicodeString Text);
extern DELPHI_PACKAGE bool __fastcall frxIsValidFloat(const System::UnicodeString Value);
extern DELPHI_PACKAGE void __fastcall frxAssignImages(Fmx::Graphics::TBitmap* Bitmap, int dx, int dy, Fmx::Frxfmx::TfrxImageList* ImgList1, Fmx::Frxfmx::TfrxImageList* ImgList2 = (Fmx::Frxfmx::TfrxImageList*)(0x0));
extern DELPHI_PACKAGE void __fastcall frxParsePageNumbers(const System::UnicodeString PageNumbers, System::Classes::TStrings* List, int Total);
extern DELPHI_PACKAGE System::UnicodeString __fastcall HTMLRGBColor(System::Uitypes::TAlphaColor Color);
extern DELPHI_PACKAGE void __fastcall frxWriteCollection(System::Classes::TCollection* Collection, System::Classes::TWriter* Writer, Fmx::Frxclass::TfrxComponent* Owner);
extern DELPHI_PACKAGE void __fastcall frxReadCollection(System::Classes::TCollection* Collection, System::Classes::TReader* Reader, Fmx::Frxclass::TfrxComponent* Owner);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetTemporaryFolder(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetTempFile(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxCreateTempFile(const System::UnicodeString TempDir);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetAppFileName(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetAppPath(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frFloat2Str(const System::Extended Value, const int Prec = 0x2, const System::WideChar Sep = (System::WideChar)(0x2e));
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxReverseString(const System::UnicodeString AText);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxUnixPath2WinPath(const System::UnicodeString Path);
}	/* namespace Frxutils */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXUTILS)
using namespace Fmx::Frxutils;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxutilsHPP
