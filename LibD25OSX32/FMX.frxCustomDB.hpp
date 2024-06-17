// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxCustomDB.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxcustomdbHPP
#define Fmx_FrxcustomdbHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Data.DB.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxDBSet.hpp>
#include <FMX.ListBox.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxcustomdb
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxCustomDataset;
class DELPHICLASS TfrxCustomTable;
class DELPHICLASS TfrxParamItem;
class DELPHICLASS TfrxParams;
class DELPHICLASS TfrxCustomQuery;
class DELPHICLASS TfrxDBLookupComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxCustomDataset : public Fmx::Frxdbset::TfrxDBDataset
{
	typedef Fmx::Frxdbset::TfrxDBDataset inherited;
	
private:
	bool FDBConnected;
	Data::Db::TDataSource* FDataSource;
	Fmx::Frxdbset::TfrxDBDataset* FMaster;
	System::UnicodeString FMasterFields;
	void __fastcall SetActive(bool Value);
	void __fastcall SetFilter(const System::UnicodeString Value);
	void __fastcall SetFiltered(bool Value);
	bool __fastcall GetActive(void);
	Data::Db::TFields* __fastcall GetFields(void);
	System::UnicodeString __fastcall GetFilter(void);
	bool __fastcall GetFiltered(void);
	void __fastcall InternalSetMaster(Fmx::Frxdbset::TfrxDBDataset* const Value);
	void __fastcall InternalSetMasterFields(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetParent(Fmx::Frxclass::TfrxComponent* AParent);
	virtual void __fastcall SetUserName(const System::UnicodeString Value);
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const Value);
	virtual void __fastcall SetMasterFields(const System::UnicodeString Value);
	__property DataSet;
	
public:
	__fastcall virtual TfrxCustomDataset(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxCustomDataset(void);
	virtual void __fastcall OnPaste(void);
	__property bool DBConnected = {read=FDBConnected, write=FDBConnected, nodefault};
	__property Data::Db::TFields* Fields = {read=GetFields};
	__property System::UnicodeString MasterFields = {read=FMasterFields, write=InternalSetMasterFields};
	__property bool Active = {read=GetActive, write=SetActive, default=0};
	
__published:
	__property System::UnicodeString Filter = {read=GetFilter, write=SetFilter};
	__property bool Filtered = {read=GetFiltered, write=SetFiltered, default=0};
	__property Fmx::Frxdbset::TfrxDBDataset* Master = {read=FMaster, write=InternalSetMaster};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCustomDataset(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxdbset::TfrxDBDataset(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxCustomTable : public TfrxCustomDataset
{
	typedef TfrxCustomDataset inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIndexFieldNames(void);
	virtual System::UnicodeString __fastcall GetIndexName(void);
	virtual System::UnicodeString __fastcall GetTableName(void);
	virtual void __fastcall SetIndexFieldNames(const System::UnicodeString Value);
	virtual void __fastcall SetIndexName(const System::UnicodeString Value);
	virtual void __fastcall SetTableName(const System::UnicodeString Value);
	__property DataSet;
	
__published:
	__property MasterFields = {default=0};
	__property System::UnicodeString TableName = {read=GetTableName, write=SetTableName};
	__property System::UnicodeString IndexName = {read=GetIndexName, write=SetIndexName};
	__property System::UnicodeString IndexFieldNames = {read=GetIndexFieldNames, write=SetIndexFieldNames};
public:
	/* TfrxCustomDataset.Create */ inline __fastcall virtual TfrxCustomTable(System::Classes::TComponent* AOwner) : TfrxCustomDataset(AOwner) { }
	/* TfrxCustomDataset.Destroy */ inline __fastcall virtual ~TfrxCustomTable(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCustomTable(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxCustomDataset(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxParamItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Data::Db::TFieldType FDataType;
	System::UnicodeString FExpression;
	System::UnicodeString FName;
	System::Variant FValue;
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property System::Variant Value = {read=FValue, write=FValue};
	
__published:
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property Data::Db::TFieldType DataType = {read=FDataType, write=FDataType, nodefault};
	__property System::UnicodeString Expression = {read=FExpression, write=FExpression};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxParamItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxParamItem(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxParams : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxParamItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	bool FIgnoreDuplicates;
	TfrxParamItem* __fastcall GetParam(int Index);
	
public:
	__fastcall TfrxParams(void);
	HIDESBASE TfrxParamItem* __fastcall Add(void);
	TfrxParamItem* __fastcall Find(const System::UnicodeString Name);
	int __fastcall IndexOf(const System::UnicodeString Name);
	void __fastcall UpdateParams(const System::UnicodeString SQL);
	__property TfrxParamItem* Items[int Index] = {read=GetParam/*, default*/};
	__property bool IgnoreDuplicates = {read=FIgnoreDuplicates, write=FIgnoreDuplicates, nodefault};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxParams(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxCustomQuery : public TfrxCustomDataset
{
	typedef TfrxCustomDataset inherited;
	
private:
	TfrxParams* FParams;
	Data::Db::TDataSetNotifyEvent FSaveOnBeforeOpen;
	System::Classes::TNotifyEvent FSaveOnChange;
	System::UnicodeString FSQLSchema;
	void __fastcall ReadData(System::Classes::TReader* Reader);
	void __fastcall SetParams(TfrxParams* Value);
	void __fastcall WriteData(System::Classes::TWriter* Writer);
	bool __fastcall GetIgnoreDupParams(void);
	void __fastcall SetIgnoreDupParams(const bool Value);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall OnBeforeOpen(Data::Db::TDataSet* DataSet);
	virtual void __fastcall OnChangeSQL(System::TObject* Sender);
	virtual void __fastcall SetSQL(System::Classes::TStrings* Value);
	virtual System::Classes::TStrings* __fastcall GetSQL(void);
	
public:
	__fastcall virtual TfrxCustomQuery(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxCustomQuery(void);
	virtual void __fastcall UpdateParams(void);
	TfrxParamItem* __fastcall ParamByName(const System::UnicodeString Value);
	
__published:
	__property bool IgnoreDupParams = {read=GetIgnoreDupParams, write=SetIgnoreDupParams, nodefault};
	__property TfrxParams* Params = {read=FParams, write=SetParams};
	__property System::Classes::TStrings* SQL = {read=GetSQL, write=SetSQL};
	__property System::UnicodeString SQLSchema = {read=FSQLSchema, write=FSQLSchema};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCustomQuery(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxCustomDataset(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDBLookupComboBox : public Fmx::Frxclass::TfrxDialogControl
{
	typedef Fmx::Frxclass::TfrxDialogControl inherited;
	
private:
	Fmx::Frxdbset::TfrxDBDataset* FDataSet;
	System::UnicodeString FDataSetName;
	Fmx::Listbox::TComboBox* FComboBox;
	bool FAutoOpenDataSet;
	bool FIsFilled;
	System::UnicodeString FListField;
	System::UnicodeString FKeyField;
	System::Variant FValue;
	System::UnicodeString __fastcall GetDataSetName(void);
	System::UnicodeString __fastcall GetKeyField(void);
	System::Variant __fastcall GetKeyValue(void);
	System::UnicodeString __fastcall GetListField(void);
	System::UnicodeString __fastcall GetText(void);
	void __fastcall SetDataSet(Fmx::Frxdbset::TfrxDBDataset* const Value);
	void __fastcall SetDataSetName(const System::UnicodeString Value);
	void __fastcall SetKeyField(System::UnicodeString Value);
	void __fastcall SetKeyValue(const System::Variant &Value);
	void __fastcall SetListField(System::UnicodeString Value);
	void __fastcall UpdateDataSet(void);
	void __fastcall OnOpenDS(System::TObject* Sender);
	int __fastcall GetDropDownWidth(void);
	void __fastcall SetDropDownWidth(const int Value);
	int __fastcall GetDropDownRows(void);
	void __fastcall SetDropDownRows(const int Value);
	void __fastcall DoOnChange(System::TObject* Sender);
	void __fastcall FillWithData(void);
	
public:
	__fastcall virtual TfrxDBLookupComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxDBLookupComboBox(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall BeforeStartReport(void);
	__property Fmx::Listbox::TComboBox* ComboBox = {read=FComboBox};
	__property System::Variant KeyValue = {read=GetKeyValue, write=FValue};
	__property System::UnicodeString Text = {read=GetText};
	void __fastcall PaintControl(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas, const System::Types::TRectF &ARect);
	
__published:
	__property bool AutoOpenDataSet = {read=FAutoOpenDataSet, write=FAutoOpenDataSet, default=0};
	__property Fmx::Frxdbset::TfrxDBDataset* DataSet = {read=FDataSet, write=SetDataSet};
	__property System::UnicodeString DataSetName = {read=GetDataSetName, write=SetDataSetName};
	__property System::UnicodeString ListField = {read=GetListField, write=SetListField};
	__property System::UnicodeString KeyField = {read=GetKeyField, write=SetKeyField};
	__property int DropDownWidth = {read=GetDropDownWidth, write=SetDropDownWidth, nodefault};
	__property int DropDownRows = {read=GetDropDownRows, write=SetDropDownRows, nodefault};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDBLookupComboBox(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall frxParamsToTParams(TfrxCustomQuery* Query, Data::Db::TParams* Params);
}	/* namespace Frxcustomdb */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXCUSTOMDB)
using namespace Fmx::Frxcustomdb;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxcustomdbHPP
