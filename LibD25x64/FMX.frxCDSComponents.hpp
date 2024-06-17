// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxCDSComponents.pas' rev: 32.00 (Windows)

#ifndef Fmx_FrxcdscomponentsHPP
#define Fmx_FrxcdscomponentsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxCustomDB.hpp>
#include <Data.DB.hpp>
#include <System.Variants.hpp>
#include <Datasnap.DBClient.hpp>
#include <FMX.Types.hpp>
#include <FMX.frxDBSet.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxcdscomponents
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxCDSComponents;
class DELPHICLASS TfrxClientDataSet;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxCDSComponents : public Fmx::Frxclass::TfrxDBComponents
{
	typedef Fmx::Frxclass::TfrxDBComponents inherited;
	
private:
	TfrxCDSComponents* FOldComponents;
	
public:
	__fastcall virtual TfrxCDSComponents(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxCDSComponents(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
};


class PASCALIMPLEMENTATION TfrxClientDataSet : public Fmx::Frxcustomdb::TfrxCustomTable
{
	typedef Fmx::Frxcustomdb::TfrxCustomTable inherited;
	
private:
	Datasnap::Dbclient::TClientDataSet* FCDS;
	System::UnicodeString __fastcall GetFileName(void);
	void __fastcall SetFileName(const System::UnicodeString Value);
	int __fastcall GetPacketRecords(void);
	System::UnicodeString __fastcall GetProviderName(void);
	bool __fastcall GetStoreDefs(void);
	void __fastcall SetPacketRecords(const int Value);
	void __fastcall SetProviderName(const System::UnicodeString Value);
	void __fastcall SetStoreDefs(const bool Value);
	
protected:
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const Value);
	virtual void __fastcall SetMasterFields(const System::UnicodeString Value);
	virtual void __fastcall SetIndexName(const System::UnicodeString Value);
	virtual void __fastcall SetIndexFieldNames(const System::UnicodeString Value);
	virtual void __fastcall SetTableName(const System::UnicodeString Value);
	virtual System::UnicodeString __fastcall GetIndexName(void);
	virtual System::UnicodeString __fastcall GetIndexFieldNames(void);
	
public:
	__fastcall virtual TfrxClientDataSet(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Datasnap::Dbclient::TClientDataSet* ClientDataSet = {read=FCDS};
	
__published:
	__property Active = {default=0};
	__property System::UnicodeString FileName = {read=GetFileName, write=SetFileName};
	__property bool StoreDefs = {read=GetStoreDefs, write=SetStoreDefs, nodefault};
	__property int PacketRecords = {read=GetPacketRecords, write=SetPacketRecords, nodefault};
	__property System::UnicodeString ProviderName = {read=GetProviderName, write=SetProviderName};
public:
	/* TfrxCustomDataset.Destroy */ inline __fastcall virtual ~TfrxClientDataSet(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxClientDataSet(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxcustomdb::TfrxCustomTable(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxCDSComponents* CDSComponents;
}	/* namespace Frxcdscomponents */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXCDSCOMPONENTS)
using namespace Fmx::Frxcdscomponents;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxcdscomponentsHPP
