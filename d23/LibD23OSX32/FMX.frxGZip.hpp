// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxGZip.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxgzipHPP
#define Fmx_FrxgzipHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.ZLib.hpp>
#include <FMX.frxClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxgzip
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxGZipCompressor;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxCompressionLevel : unsigned char { gzNone, gzFastest, gzDefault, gzMax };

class PASCALIMPLEMENTATION TfrxGZipCompressor : public Fmx::Frxclass::TfrxCustomCompressor
{
	typedef Fmx::Frxclass::TfrxCustomCompressor inherited;
	
public:
	virtual void __fastcall Compress(System::Classes::TStream* Dest);
	virtual bool __fastcall Decompress(System::Classes::TStream* Source);
public:
	/* TfrxCustomCompressor.Create */ inline __fastcall virtual TfrxGZipCompressor(System::Classes::TComponent* AOwner) : Fmx::Frxclass::TfrxCustomCompressor(AOwner) { }
	/* TfrxCustomCompressor.Destroy */ inline __fastcall virtual ~TfrxGZipCompressor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall frxCompressStream(System::Classes::TStream* Source, System::Classes::TStream* Dest, TfrxCompressionLevel Compression = (TfrxCompressionLevel)(0x2), System::UnicodeString FileNameW = System::UnicodeString());
extern DELPHI_PACKAGE System::AnsiString __fastcall frxDecompressStream(System::Classes::TStream* Source, System::Classes::TStream* Dest);
extern DELPHI_PACKAGE void __fastcall frxDeflateStream(System::Classes::TStream* Source, System::Classes::TStream* Dest, TfrxCompressionLevel Compression = (TfrxCompressionLevel)(0x2));
extern DELPHI_PACKAGE void __fastcall frxInflateStream(System::Classes::TStream* Source, System::Classes::TStream* Dest);
}	/* namespace Frxgzip */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXGZIP)
using namespace Fmx::Frxgzip;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxgzipHPP
