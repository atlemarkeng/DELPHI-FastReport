// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxDBSet.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxdbsetHPP
#define Fmx_FrxdbsetHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.frxClass.hpp>
#include <Data.DB.hpp>
#include <System.Variants.hpp>
#include <System.WideStrings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxdbset
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxDBDataset;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxDBDataset : public Fmx::Frxclass::TfrxCustomDBDataSet
{
	typedef Fmx::Frxclass::TfrxCustomDBDataSet inherited;
	
private:
	System::DynamicArray<System::Byte> FBookmark;
	Data::Db::TDataSet* FDataSet;
	Data::Db::TDataSource* FDataSource;
	Data::Db::TDataSet* FDS;
	bool FEof;
	bool FBCDToCurrency;
	Data::Db::TDataSetNotifyEvent FSaveOpenEvent;
	Data::Db::TDataSetNotifyEvent FSaveCloseEvent;
	void __fastcall BeforeClose(Data::Db::TDataSet* Sender);
	void __fastcall AfterOpen(Data::Db::TDataSet* Sender);
	void __fastcall SetDataSet(Data::Db::TDataSet* Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	bool __fastcall DataSetActive(void);
	bool __fastcall IsDataSetStored(void);
	
protected:
	virtual System::WideString __fastcall GetDisplayText(System::UnicodeString Index);
	virtual int __fastcall GetDisplayWidth(System::UnicodeString Index);
	virtual Fmx::Frxclass::TfrxFieldType __fastcall GetFieldType(System::UnicodeString Index);
	virtual System::Variant __fastcall GetValue(System::UnicodeString Index);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	virtual void __fastcall Initialize(void);
	virtual void __fastcall Finalize(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual void __fastcall Prior(void);
	virtual void __fastcall Open(void);
	virtual void __fastcall Close(void);
	virtual bool __fastcall Eof(void);
	Data::Db::TDataSet* __fastcall GetDataSet(void);
	virtual bool __fastcall IsBlobField(const System::UnicodeString fName);
	virtual int __fastcall RecordCount(void);
	virtual void __fastcall AssignBlobTo(const System::UnicodeString fName, System::TObject* Obj);
	virtual void __fastcall GetFieldList(System::Classes::TStrings* List);
	
__published:
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet, stored=IsDataSetStored};
	__property Data::Db::TDataSource* DataSource = {read=FDataSource, write=SetDataSource, stored=IsDataSetStored};
	__property bool BCDToCurrency = {read=FBCDToCurrency, write=FBCDToCurrency, nodefault};
public:
	/* TfrxCustomDBDataSet.Create */ inline __fastcall virtual TfrxDBDataset(System::Classes::TComponent* AOwner) : Fmx::Frxclass::TfrxCustomDBDataSet(AOwner) { }
	/* TfrxCustomDBDataSet.Destroy */ inline __fastcall virtual ~TfrxDBDataset(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDBDataset(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxCustomDBDataSet(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdbset */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXDBSET)
using namespace Fmx::Frxdbset;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxdbsetHPP
