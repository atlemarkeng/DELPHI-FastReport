// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxADOComponents.pas' rev: 30.00 (Windows)

#ifndef Fmx_FrxadocomponentsHPP
#define Fmx_FrxadocomponentsHPP

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
#include <Data.Win.ADODB.hpp>
#include <Winapi.ADOInt.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.frxDBSet.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxadocomponents
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxADOComponents;
class DELPHICLASS TfrxADODatabase;
class DELPHICLASS TfrxADOTable;
class DELPHICLASS TfrxADOQuery;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxADOComponents : public Fmx::Frxclass::TfrxDBComponents
{
	typedef Fmx::Frxclass::TfrxDBComponents inherited;
	
private:
	Data::Win::Adodb::TADOConnection* FDefaultDatabase;
	TfrxADOComponents* FOldComponents;
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetDefaultDatabase(Data::Win::Adodb::TADOConnection* Value);
	
public:
	__fastcall virtual TfrxADOComponents(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxADOComponents(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	
__published:
	__property Data::Win::Adodb::TADOConnection* DefaultDatabase = {read=FDefaultDatabase, write=SetDefaultDatabase};
};


class PASCALIMPLEMENTATION TfrxADODatabase : public Fmx::Frxclass::TfrxCustomDatabase
{
	typedef Fmx::Frxclass::TfrxCustomDatabase inherited;
	
private:
	Data::Win::Adodb::TADOConnection* FDatabase;
	
protected:
	virtual void __fastcall SetConnected(bool Value);
	virtual void __fastcall SetDatabaseName(const System::UnicodeString Value);
	virtual void __fastcall SetLoginPrompt(bool Value);
	virtual bool __fastcall GetConnected(void);
	virtual System::UnicodeString __fastcall GetDatabaseName(void);
	virtual bool __fastcall GetLoginPrompt(void);
	void __fastcall ADOBeforeConnect(System::TObject* Sende);
	void __fastcall ADOAfterDisconnect(System::TObject* Sende);
	
public:
	__fastcall virtual TfrxADODatabase(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall SetLogin(const System::UnicodeString Login, const System::UnicodeString Password);
	virtual System::WideString __fastcall ToString(void);
	virtual void __fastcall FromString(const System::WideString Connection);
	__property Data::Win::Adodb::TADOConnection* Database = {read=FDatabase};
	
__published:
	__property DatabaseName = {default=0};
	__property LoginPrompt = {default=1};
	__property Connected = {default=0};
public:
	/* TfrxDialogComponent.Destroy */ inline __fastcall virtual ~TfrxADODatabase(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxADODatabase(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxCustomDatabase(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxADOTable : public Fmx::Frxcustomdb::TfrxCustomTable
{
	typedef Fmx::Frxcustomdb::TfrxCustomTable inherited;
	
private:
	TfrxADODatabase* FDatabase;
	Data::Win::Adodb::TADOTable* FTable;
	void __fastcall SetDatabase(TfrxADODatabase* Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const Value);
	virtual void __fastcall SetMasterFields(const System::UnicodeString Value);
	virtual void __fastcall SetIndexFieldNames(const System::UnicodeString Value);
	virtual void __fastcall SetIndexName(const System::UnicodeString Value);
	virtual void __fastcall SetTableName(const System::UnicodeString Value);
	virtual System::UnicodeString __fastcall GetIndexFieldNames(void);
	virtual System::UnicodeString __fastcall GetIndexName(void);
	virtual System::UnicodeString __fastcall GetTableName(void);
	
public:
	__fastcall virtual TfrxADOTable(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxADOTable(System::Classes::TComponent* AOwner, System::Word Flags);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall BeforeStartReport(void);
	__property Data::Win::Adodb::TADOTable* Table = {read=FTable};
	
__published:
	__property TfrxADODatabase* Database = {read=FDatabase, write=SetDatabase};
public:
	/* TfrxCustomDataset.Destroy */ inline __fastcall virtual ~TfrxADOTable(void) { }
	
};


class PASCALIMPLEMENTATION TfrxADOQuery : public Fmx::Frxcustomdb::TfrxCustomQuery
{
	typedef Fmx::Frxcustomdb::TfrxCustomQuery inherited;
	
private:
	TfrxADODatabase* FDatabase;
	Data::Win::Adodb::TADOQuery* FQuery;
	System::Classes::TStrings* FStrings;
	bool FLock;
	void __fastcall SetDatabase(TfrxADODatabase* Value);
	int __fastcall GetCommandTimeout(void);
	void __fastcall SetCommandTimeout(const int Value);
	Data::Win::Adodb::TADOLockType __fastcall GetLockType(void);
	void __fastcall SetLockType(const Data::Win::Adodb::TADOLockType Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall OnChangeSQL(System::TObject* Sender);
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const Value);
	virtual void __fastcall SetSQL(System::Classes::TStrings* Value);
	virtual System::Classes::TStrings* __fastcall GetSQL(void);
	
public:
	__fastcall virtual TfrxADOQuery(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxADOQuery(System::Classes::TComponent* AOwner, System::Word Flags);
	__fastcall virtual ~TfrxADOQuery(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall BeforeStartReport(void);
	virtual void __fastcall UpdateParams(void);
	__property Data::Win::Adodb::TADOQuery* Query = {read=FQuery};
	
__published:
	__property int CommandTimeout = {read=GetCommandTimeout, write=SetCommandTimeout, nodefault};
	__property TfrxADODatabase* Database = {read=FDatabase, write=SetDatabase};
	__property Data::Win::Adodb::TADOLockType LockType = {read=GetLockType, write=SetLockType, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxADOComponents* ADOComponents;
extern DELPHI_PACKAGE void __fastcall frxParamsToTParameters(Fmx::Frxcustomdb::TfrxCustomQuery* Query, Data::Win::Adodb::TParameters* Params);
extern DELPHI_PACKAGE void __fastcall frxADOGetTableNames(Data::Win::Adodb::TADOConnection* conADO, System::Classes::TStrings* List, bool SystemTables);
}	/* namespace Frxadocomponents */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXADOCOMPONENTS)
using namespace Fmx::Frxadocomponents;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxadocomponentsHPP
