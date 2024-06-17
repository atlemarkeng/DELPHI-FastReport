// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxIBXComponents.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxibxcomponentsHPP
#define Fmx_FrxibxcomponentsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxCustomDB.hpp>
#include <Data.DB.hpp>
#include <IBX.IBDatabase.hpp>
#include <IBX.IBTable.hpp>
#include <IBX.IBQuery.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.frxDBSet.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxibxcomponents
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxIBXComponents;
class DELPHICLASS TfrxIBXDatabase;
class DELPHICLASS TfrxIBXTable;
class DELPHICLASS TfrxIBXQuery;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxIBXComponents : public Fmx::Frxclass::TfrxDBComponents
{
	typedef Fmx::Frxclass::TfrxDBComponents inherited;
	
private:
	Ibx::Ibdatabase::TIBDatabase* FDefaultDatabase;
	TfrxIBXComponents* FOldComponents;
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetDefaultDatabase(Ibx::Ibdatabase::TIBDatabase* Value);
	
public:
	__fastcall virtual TfrxIBXComponents(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxIBXComponents(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	
__published:
	__property Ibx::Ibdatabase::TIBDatabase* DefaultDatabase = {read=FDefaultDatabase, write=SetDefaultDatabase};
};


class PASCALIMPLEMENTATION TfrxIBXDatabase : public Fmx::Frxclass::TfrxCustomDatabase
{
	typedef Fmx::Frxclass::TfrxCustomDatabase inherited;
	
private:
	Ibx::Ibdatabase::TIBDatabase* FDatabase;
	Ibx::Ibdatabase::TIBTransaction* FTransaction;
	int __fastcall GetSQLDialect(void);
	void __fastcall SetSQLDialect(const int Value);
	
protected:
	virtual void __fastcall SetConnected(bool Value);
	virtual void __fastcall SetDatabaseName(const System::UnicodeString Value);
	virtual void __fastcall SetLoginPrompt(bool Value);
	virtual void __fastcall SetParams(System::Classes::TStrings* Value);
	virtual bool __fastcall GetConnected(void);
	virtual System::UnicodeString __fastcall GetDatabaseName(void);
	virtual bool __fastcall GetLoginPrompt(void);
	virtual System::Classes::TStrings* __fastcall GetParams(void);
	
public:
	__fastcall virtual TfrxIBXDatabase(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxIBXDatabase(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall SetLogin(const System::UnicodeString Login, const System::UnicodeString Password);
	__property Ibx::Ibdatabase::TIBDatabase* Database = {read=FDatabase};
	
__published:
	__property DatabaseName = {default=0};
	__property LoginPrompt = {default=1};
	__property Params;
	__property int SQLDialect = {read=GetSQLDialect, write=SetSQLDialect, nodefault};
	__property Connected = {default=0};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxIBXDatabase(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxCustomDatabase(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxIBXTable : public Fmx::Frxcustomdb::TfrxCustomTable
{
	typedef Fmx::Frxcustomdb::TfrxCustomTable inherited;
	
private:
	TfrxIBXDatabase* FDatabase;
	Ibx::Ibtable::TIBTable* FTable;
	void __fastcall SetDatabase(TfrxIBXDatabase* const Value);
	
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
	__fastcall virtual TfrxIBXTable(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxIBXTable(System::Classes::TComponent* AOwner, System::Word Flags);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall BeforeStartReport(void);
	__property Ibx::Ibtable::TIBTable* Table = {read=FTable};
	
__published:
	__property TfrxIBXDatabase* Database = {read=FDatabase, write=SetDatabase};
public:
	/* TfrxCustomDataset.Destroy */ inline __fastcall virtual ~TfrxIBXTable(void) { }
	
};


class PASCALIMPLEMENTATION TfrxIBXQuery : public Fmx::Frxcustomdb::TfrxCustomQuery
{
	typedef Fmx::Frxcustomdb::TfrxCustomQuery inherited;
	
private:
	TfrxIBXDatabase* FDatabase;
	Ibx::Ibquery::TIBQuery* FQuery;
	void __fastcall SetDatabase(TfrxIBXDatabase* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const Value);
	virtual void __fastcall SetSQL(System::Classes::TStrings* Value);
	virtual System::Classes::TStrings* __fastcall GetSQL(void);
	
public:
	__fastcall virtual TfrxIBXQuery(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxIBXQuery(System::Classes::TComponent* AOwner, System::Word Flags);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall BeforeStartReport(void);
	virtual void __fastcall UpdateParams(void);
	__property Ibx::Ibquery::TIBQuery* Query = {read=FQuery};
	
__published:
	__property TfrxIBXDatabase* Database = {read=FDatabase, write=SetDatabase};
public:
	/* TfrxCustomQuery.Destroy */ inline __fastcall virtual ~TfrxIBXQuery(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxIBXComponents* IBXComponents;
}	/* namespace Frxibxcomponents */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXIBXCOMPONENTS)
using namespace Fmx::Frxibxcomponents;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxibxcomponentsHPP
