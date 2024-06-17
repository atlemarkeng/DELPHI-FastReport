// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxVariables.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxvariablesHPP
#define Fmx_FrxvariablesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.frxXML.hpp>
#include <System.Variants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxvariables
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxVariable;
class DELPHICLASS TfrxVariables;
class DELPHICLASS TfrxArray;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxVariable : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	System::Variant FValue;
	
public:
	__fastcall virtual TfrxVariable(System::Classes::TCollection* Collection);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property System::Variant Value = {read=FValue, write=FValue};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxVariable(void) { }
	
};


class PASCALIMPLEMENTATION TfrxVariables : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	System::Variant operator[](System::UnicodeString Index) { return Variables[Index]; }
	
private:
	TfrxVariable* __fastcall GetItems(int Index);
	System::Variant __fastcall GetVariable(System::UnicodeString Index);
	void __fastcall SetVariable(System::UnicodeString Index, const System::Variant &Value);
	
public:
	__fastcall TfrxVariables(void);
	HIDESBASE TfrxVariable* __fastcall Add(void);
	HIDESBASE TfrxVariable* __fastcall Insert(int Index);
	int __fastcall IndexOf(const System::UnicodeString Name);
	void __fastcall AddVariable(const System::UnicodeString ACategory, const System::UnicodeString AName, const System::Variant &AValue);
	void __fastcall DeleteCategory(const System::UnicodeString Name);
	void __fastcall DeleteVariable(const System::UnicodeString Name);
	void __fastcall GetCategoriesList(System::Classes::TStrings* List, bool ClearList = true);
	void __fastcall GetVariablesList(const System::UnicodeString Category, System::Classes::TStrings* List);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromXMLItem(Fmx::Frxxml::TfrxXMLItem* Item, bool OldXMLFormat = true);
	void __fastcall SaveToFile(const System::UnicodeString FileName);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall SaveToXMLItem(Fmx::Frxxml::TfrxXMLItem* Item);
	__property TfrxVariable* Items[int Index] = {read=GetItems};
	__property System::Variant Variables[System::UnicodeString Index] = {read=GetVariable, write=SetVariable/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxVariables(void) { }
	
};


class PASCALIMPLEMENTATION TfrxArray : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	System::Variant operator[](System::Variant Index) { return Variables[Index]; }
	
private:
	TfrxVariable* __fastcall GetItems(int Index);
	System::Variant __fastcall GetVariable(const System::Variant &Index);
	void __fastcall SetVariable(const System::Variant &Index, const System::Variant &Value);
	
public:
	__fastcall TfrxArray(void);
	int __fastcall IndexOf(const System::Variant &Name);
	__property TfrxVariable* Items[int Index] = {read=GetItems};
	__property System::Variant Variables[System::Variant Index] = {read=GetVariable, write=SetVariable/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxArray(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxvariables */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXVARIABLES)
using namespace Fmx::Frxvariables;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxvariablesHPP
