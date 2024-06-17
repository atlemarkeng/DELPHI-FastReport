// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxXMLSerializer.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxxmlserializerHPP
#define Fmx_FrxxmlserializerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.TypInfo.hpp>
#include <System.Variants.hpp>
#include <FMX.frxXML.hpp>
#include <FMX.frxClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxxmlserializer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxXMLSerializer;
class DELPHICLASS TfrxFixupItem;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TfrxGetAncestorEvent)(const System::UnicodeString ComponentName, System::Classes::TPersistent* &Ancestor);

class PASCALIMPLEMENTATION TfrxXMLSerializer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStringList* FErrors;
	System::Classes::TList* FFixups;
	Fmx::Frxclass::TfrxComponent* FOwner;
	System::Classes::TReader* FReader;
	System::Classes::TMemoryStream* FReaderStream;
	bool FSerializeDefaultValues;
	System::Classes::TStream* FStream;
	bool FOldFormat;
	TfrxGetAncestorEvent FOnGetAncestor;
	System::Classes::TStringList* FCachedClasses;
	void __fastcall AddFixup(System::Classes::TPersistent* Obj, System::Typinfo::PPropInfo p, System::UnicodeString Value);
	void __fastcall ClearFixups(void);
	void __fastcall FixupReferences(void);
	
public:
	__fastcall TfrxXMLSerializer(System::Classes::TStream* Stream);
	__fastcall virtual ~TfrxXMLSerializer(void);
	System::UnicodeString __fastcall ObjToXML(System::Classes::TPersistent* Obj, const System::UnicodeString Add = System::UnicodeString(), System::Classes::TPersistent* Ancestor = (System::Classes::TPersistent*)(0x0));
	Fmx::Frxclass::TfrxComponent* __fastcall ReadComponent(Fmx::Frxclass::TfrxComponent* Root);
	Fmx::Frxclass::TfrxComponent* __fastcall ReadComponentStr(Fmx::Frxclass::TfrxComponent* Root, System::UnicodeString s, bool DontFixup = false);
	System::UnicodeString __fastcall WriteComponentStr(Fmx::Frxclass::TfrxComponent* c);
	void __fastcall ReadRootComponent(Fmx::Frxclass::TfrxComponent* Root, Fmx::Frxxml::TfrxXMLItem* XMLItem = (Fmx::Frxxml::TfrxXMLItem*)(0x0));
	void __fastcall CopyFixupList(System::Classes::TList* FixList);
	void __fastcall ReadPersistentStr(System::Classes::TComponent* Root, System::Classes::TPersistent* Obj, const System::UnicodeString s);
	void __fastcall WriteComponent(Fmx::Frxclass::TfrxComponent* c);
	void __fastcall WriteRootComponent(Fmx::Frxclass::TfrxComponent* Root, bool SaveChildren = true, Fmx::Frxxml::TfrxXMLItem* XMLItem = (Fmx::Frxxml::TfrxXMLItem*)(0x0), bool Streaming = false);
	void __fastcall XMLToObj(const System::UnicodeString s, System::Classes::TPersistent* Obj);
	__property System::Classes::TStringList* Errors = {read=FErrors};
	__property Fmx::Frxclass::TfrxComponent* Owner = {read=FOwner, write=FOwner};
	__property System::Classes::TStream* Stream = {read=FStream};
	__property bool SerializeDefaultValues = {read=FSerializeDefaultValues, write=FSerializeDefaultValues, nodefault};
	__property TfrxGetAncestorEvent OnGetAncestor = {read=FOnGetAncestor, write=FOnGetAncestor};
	__property bool OldFormat = {read=FOldFormat, write=FOldFormat, nodefault};
};


class PASCALIMPLEMENTATION TfrxFixupItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Classes::TPersistent* Obj;
	System::Typinfo::TPropInfo *PropInfo;
	System::UnicodeString Value;
public:
	/* TObject.Create */ inline __fastcall TfrxFixupItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxFixupItem(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxxmlserializer */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXXMLSERIALIZER)
using namespace Fmx::Frxxmlserializer;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxxmlserializerHPP
