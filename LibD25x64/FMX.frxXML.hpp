// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxXML.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxxmlHPP
#define Fmx_FrxxmlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxxml
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxInvalidXMLException;
class DELPHICLASS TfrxXMLItem;
class DELPHICLASS TfrxXMLDocument;
class DELPHICLASS TfrxXMLReader;
class DELPHICLASS TfrxXMLWriter;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxInvalidXMLException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall TfrxInvalidXMLException(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall TfrxInvalidXMLException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall TfrxInvalidXMLException(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall TfrxInvalidXMLException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall TfrxInvalidXMLException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall TfrxInvalidXMLException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall TfrxInvalidXMLException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall TfrxInvalidXMLException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall TfrxInvalidXMLException(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall TfrxInvalidXMLException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall TfrxInvalidXMLException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall TfrxInvalidXMLException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~TfrxInvalidXMLException(void) { }
	
};


class PASCALIMPLEMENTATION TfrxXMLItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxXMLItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	void *FData;
	System::Byte FHiOffset;
	System::Classes::TList* FItems;
	bool FLoaded;
	int FLoOffset;
	bool FModified;
	System::UnicodeString FName;
	TfrxXMLItem* FParent;
	System::UnicodeString FText;
	bool FUnloadable;
	System::UnicodeString FValue;
	int __fastcall GetCount(void);
	TfrxXMLItem* __fastcall GetItems(int Index);
	__int64 __fastcall GetOffset(void);
	void __fastcall SetOffset(const __int64 Value);
	System::UnicodeString __fastcall GetProp(System::UnicodeString Index);
	void __fastcall SetProp(System::UnicodeString Index, const System::UnicodeString Value);
	
public:
	__fastcall TfrxXMLItem(void);
	__fastcall virtual ~TfrxXMLItem(void);
	void __fastcall AddItem(TfrxXMLItem* Item);
	void __fastcall Clear(void);
	void __fastcall InsertItem(int Index, TfrxXMLItem* Item);
	TfrxXMLItem* __fastcall Add(void)/* overload */;
	TfrxXMLItem* __fastcall Add(System::UnicodeString Name)/* overload */;
	int __fastcall Find(const System::UnicodeString Name);
	TfrxXMLItem* __fastcall FindItem(const System::UnicodeString Name);
	int __fastcall IndexOf(TfrxXMLItem* Item);
	bool __fastcall PropExists(const System::UnicodeString Index);
	TfrxXMLItem* __fastcall Root(void);
	void __fastcall DeleteProp(const System::UnicodeString Index);
	__property int Count = {read=GetCount, nodefault};
	__property void * Data = {read=FData, write=FData};
	__property TfrxXMLItem* Items[int Index] = {read=GetItems/*, default*/};
	__property bool Loaded = {read=FLoaded, nodefault};
	__property bool Modified = {read=FModified, write=FModified, nodefault};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property __int64 Offset = {read=GetOffset, write=SetOffset};
	__property TfrxXMLItem* Parent = {read=FParent};
	__property System::UnicodeString Prop[System::UnicodeString Index] = {read=GetProp, write=SetProp};
	__property System::UnicodeString Text = {read=FText, write=FText};
	__property bool Unloadable = {read=FUnloadable, write=FUnloadable, nodefault};
	__property System::UnicodeString Value = {read=FValue, write=FValue};
};


class PASCALIMPLEMENTATION TfrxXMLDocument : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FAutoIndent;
	TfrxXMLItem* FRoot;
	System::UnicodeString FTempDir;
	System::UnicodeString FTempFile;
	System::Classes::TStream* FTempStream;
	bool FTempFileCreated;
	bool FOldVersion;
	void __fastcall CreateTempFile(void);
	void __fastcall DeleteTempFile(void);
	
public:
	__fastcall TfrxXMLDocument(void);
	__fastcall virtual ~TfrxXMLDocument(void);
	void __fastcall Clear(void);
	void __fastcall LoadItem(TfrxXMLItem* Item);
	void __fastcall UnloadItem(TfrxXMLItem* Item);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream, bool AllowPartialLoading = false);
	void __fastcall SaveToFile(const System::UnicodeString FileName);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	__property bool AutoIndent = {read=FAutoIndent, write=FAutoIndent, nodefault};
	__property TfrxXMLItem* Root = {read=FRoot};
	__property System::UnicodeString TempDir = {read=FTempDir, write=FTempDir};
	__property bool OldVersion = {read=FOldVersion, nodefault};
};


class PASCALIMPLEMENTATION TfrxXMLReader : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	char *FBuffer;
	int FBufPos;
	int FBufEnd;
	__int64 FPosition;
	__int64 FSize;
	System::Classes::TStream* FStream;
	bool FOldFormat;
	void __fastcall SetPosition(const __int64 Value);
	void __fastcall ReadBuffer(void);
	void __fastcall ReadItem(System::UnicodeString &NameS, System::UnicodeString &Text);
	
public:
	__fastcall TfrxXMLReader(System::Classes::TStream* Stream);
	__fastcall virtual ~TfrxXMLReader(void);
	void __fastcall RaiseException(void);
	void __fastcall ReadHeader(void);
	void __fastcall ReadRootItem(TfrxXMLItem* Item, bool ReadChildren = true);
	__property __int64 Position = {read=FPosition, write=SetPosition};
	__property __int64 Size = {read=FSize};
};


class PASCALIMPLEMENTATION TfrxXMLWriter : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FAutoIndent;
	System::AnsiString FBuffer;
	System::Classes::TStream* FStream;
	System::Classes::TStream* FTempStream;
	void __fastcall FlushBuffer(void);
	void __fastcall WriteLn(const System::AnsiString s);
	void __fastcall WriteItem(TfrxXMLItem* Item, int Level = 0x0);
	
public:
	__fastcall TfrxXMLWriter(System::Classes::TStream* Stream);
	void __fastcall WriteHeader(void);
	void __fastcall WriteRootItem(TfrxXMLItem* RootItem);
	__property System::Classes::TStream* TempStream = {read=FTempStream, write=FTempStream};
	__property bool AutoIndent = {read=FAutoIndent, write=FAutoIndent, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxXMLWriter(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxStrToXML(const System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxXMLToStr(const System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxValueToXML(const System::Variant &Value);
}	/* namespace Frxxml */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXXML)
using namespace Fmx::Frxxml;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxxmlHPP
