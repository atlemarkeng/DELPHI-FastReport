// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxDsgnIntf.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxdsgnintfHPP
#define Fmx_FrxdsgnintfHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.TypInfo.hpp>
#include <System.Types.hpp>
#include <System.Variants.hpp>
#include <System.UIConsts.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Menus.hpp>
#include <FMX.Colors.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxdsgnintf
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxPropertyEditor;
class DELPHICLASS TfrxComponentEditor;
class DELPHICLASS TfrxIntegerProperty;
class DELPHICLASS TfrxFloatProperty;
class DELPHICLASS TfrxCharProperty;
class DELPHICLASS TfrxStringProperty;
class DELPHICLASS TfrxEnumProperty;
class DELPHICLASS TfrxSetProperty;
class DELPHICLASS TfrxSetElementProperty;
class DELPHICLASS TfrxClassProperty;
class DELPHICLASS TfrxComponentProperty;
class DELPHICLASS TfrxNameProperty;
class DELPHICLASS TfrxColorProperty;
class DELPHICLASS TfrxFontProperty;
class DELPHICLASS TfrxFontNameProperty;
class DELPHICLASS TfrxModalResultProperty;
class DELPHICLASS TfrxCursorProperty;
class DELPHICLASS TfrxDateTimeProperty;
class DELPHICLASS TfrxDateProperty;
class DELPHICLASS TfrxTimeProperty;
class DELPHICLASS TfrxPropertyItem;
class DELPHICLASS TfrxPropertyList;
class DELPHICLASS TfrxObjectItem;
class DELPHICLASS TfrxComponentEditorItem;
class DELPHICLASS TfrxPropertyEditorItem;
class DELPHICLASS TfrxExportFilterItem;
class DELPHICLASS TfrxWizardItem;
class DELPHICLASS TfrxObjectCollection;
class DELPHICLASS TfrxComponentEditorCollection;
class DELPHICLASS TfrxPropertyEditorCollection;
class DELPHICLASS TfrxExportFilterCollection;
class DELPHICLASS TfrxWizardCollection;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxPropertyAttribute : unsigned char { paValueList, paSortList, paDialog, paMultiSelect, paSubProperties, paReadOnly, paOwnerDraw };

typedef System::Set<TfrxPropertyAttribute, TfrxPropertyAttribute::paValueList, TfrxPropertyAttribute::paOwnerDraw> TfrxPropertyAttributes;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPropertyEditor : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Fmx::Frxclass::TfrxCustomDesigner* FDesigner;
	System::Classes::TList* FCompList;
	System::Classes::TList* FPropList;
	int FItemHeight;
	System::Classes::TStrings* FValues;
	System::Typinfo::PPropInfo __fastcall GetPropInfo(void);
	System::Classes::TPersistent* __fastcall GetComponent(void);
	Fmx::Frxclass::TfrxComponent* __fastcall GetfrComponent(void);
	
protected:
	void __fastcall GetStrProc(const System::UnicodeString s);
	System::Extended __fastcall GetFloatValue(void);
	int __fastcall GetOrdValue(void);
	System::UnicodeString __fastcall GetStrValue(void);
	System::Variant __fastcall GetVarValue(void);
	void __fastcall SetFloatValue(System::Extended Value);
	void __fastcall SetOrdValue(int Value);
	void __fastcall SetStrValue(const System::UnicodeString Value);
	void __fastcall SetVarValue(const System::Variant &Value);
	
public:
	__fastcall virtual TfrxPropertyEditor(Fmx::Frxclass::TfrxCustomDesigner* Designer);
	__fastcall virtual ~TfrxPropertyEditor(void);
	virtual bool __fastcall Edit(void);
	virtual TfrxPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetName(void);
	virtual int __fastcall GetExtraLBSize(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall GetValues(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
	virtual void __fastcall OnDrawLBItem(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas, const System::Types::TRectF &ARect);
	virtual void __fastcall OnDrawItem(Fmx::Graphics::TCanvas* Canvas, const System::Types::TRectF &ARect);
	__property System::Classes::TPersistent* Component = {read=GetComponent};
	__property Fmx::Frxclass::TfrxComponent* frComponent = {read=GetfrComponent};
	__property Fmx::Frxclass::TfrxCustomDesigner* Designer = {read=FDesigner};
	__property int ItemHeight = {read=FItemHeight, write=FItemHeight, nodefault};
	__property System::Typinfo::PPropInfo PropInfo = {read=GetPropInfo};
	__property System::UnicodeString Value = {read=GetValue, write=SetValue};
	__property System::Classes::TStrings* Values = {read=FValues};
};

#pragma pack(pop)

typedef System::TMetaClass* TfrxPropertyEditorClass;

class PASCALIMPLEMENTATION TfrxComponentEditor : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Fmx::Frxclass::TfrxComponent* FComponent;
	Fmx::Frxclass::TfrxCustomDesigner* FDesigner;
	Fmx::Menus::TPopupMenu* FMenu;
	System::Classes::TNotifyEvent FOnClick;
	
protected:
	Fmx::Menus::TMenuItem* __fastcall AddItem(const System::UnicodeString Caption, int Tag, bool Checked = false);
	
public:
	__fastcall TfrxComponentEditor(Fmx::Frxclass::TfrxComponent* Component, Fmx::Frxclass::TfrxCustomDesigner* Designer, Fmx::Menus::TPopupMenu* Menu);
	virtual bool __fastcall Edit(void);
	virtual bool __fastcall HasEditor(void);
	virtual void __fastcall GetMenuItems(System::Classes::TNotifyEvent OnClickEvent);
	virtual bool __fastcall Execute(int Tag, bool Checked);
	__property Fmx::Frxclass::TfrxComponent* Component = {read=FComponent};
	__property Fmx::Frxclass::TfrxCustomDesigner* Designer = {read=FDesigner};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxComponentEditor(void) { }
	
};


typedef System::TMetaClass* TfrxComponentEditorClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxIntegerProperty : public TfrxPropertyEditor
{
	typedef TfrxPropertyEditor inherited;
	
public:
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxIntegerProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxPropertyEditor(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxIntegerProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxFloatProperty : public TfrxPropertyEditor
{
	typedef TfrxPropertyEditor inherited;
	
public:
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxFloatProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxPropertyEditor(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxFloatProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCharProperty : public TfrxPropertyEditor
{
	typedef TfrxPropertyEditor inherited;
	
public:
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxCharProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxPropertyEditor(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxCharProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxStringProperty : public TfrxPropertyEditor
{
	typedef TfrxPropertyEditor inherited;
	
public:
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxStringProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxPropertyEditor(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxStringProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxEnumProperty : public TfrxPropertyEditor
{
	typedef TfrxPropertyEditor inherited;
	
public:
	virtual TfrxPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall GetValues(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxEnumProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxPropertyEditor(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxEnumProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSetProperty : public TfrxPropertyEditor
{
	typedef TfrxPropertyEditor inherited;
	
public:
	virtual TfrxPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxSetProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxPropertyEditor(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxSetProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSetElementProperty : public TfrxPropertyEditor
{
	typedef TfrxPropertyEditor inherited;
	
private:
	int FElement;
	
public:
	virtual TfrxPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetName(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall GetValues(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxSetElementProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxPropertyEditor(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxSetElementProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxClassProperty : public TfrxPropertyEditor
{
	typedef TfrxPropertyEditor inherited;
	
public:
	virtual TfrxPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxClassProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxPropertyEditor(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxClassProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxComponentProperty : public TfrxPropertyEditor
{
	typedef TfrxPropertyEditor inherited;
	
public:
	virtual TfrxPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall GetValues(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxComponentProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxPropertyEditor(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxComponentProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxNameProperty : public TfrxStringProperty
{
	typedef TfrxStringProperty inherited;
	
public:
	virtual TfrxPropertyAttributes __fastcall GetAttributes(void);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxNameProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxStringProperty(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxNameProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxColorProperty : public TfrxIntegerProperty
{
	typedef TfrxIntegerProperty inherited;
	
public:
	virtual TfrxPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall GetValues(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
	virtual void __fastcall OnDrawLBItem(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas, const System::Types::TRectF &ARect);
	virtual void __fastcall OnDrawItem(Fmx::Graphics::TCanvas* Canvas, const System::Types::TRectF &ARect);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxColorProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxIntegerProperty(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxColorProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxFontProperty : public TfrxClassProperty
{
	typedef TfrxClassProperty inherited;
	
public:
	virtual bool __fastcall Edit(void);
	virtual TfrxPropertyAttributes __fastcall GetAttributes(void);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxFontProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxClassProperty(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxFontProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxFontNameProperty : public TfrxStringProperty
{
	typedef TfrxStringProperty inherited;
	
public:
	virtual TfrxPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(void);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxFontNameProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxStringProperty(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxFontNameProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxModalResultProperty : public TfrxIntegerProperty
{
	typedef TfrxIntegerProperty inherited;
	
public:
	virtual TfrxPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall GetValues(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxModalResultProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxIntegerProperty(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxModalResultProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCursorProperty : public TfrxIntegerProperty
{
	typedef TfrxIntegerProperty inherited;
	
public:
	virtual TfrxPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall GetValues(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxCursorProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxIntegerProperty(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxCursorProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxDateTimeProperty : public TfrxPropertyEditor
{
	typedef TfrxPropertyEditor inherited;
	
public:
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxDateTimeProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxPropertyEditor(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxDateTimeProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxDateProperty : public TfrxPropertyEditor
{
	typedef TfrxPropertyEditor inherited;
	
public:
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxDateProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxPropertyEditor(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxDateProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxTimeProperty : public TfrxPropertyEditor
{
	typedef TfrxPropertyEditor inherited;
	
public:
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value);
public:
	/* TfrxPropertyEditor.Create */ inline __fastcall virtual TfrxTimeProperty(Fmx::Frxclass::TfrxCustomDesigner* Designer) : TfrxPropertyEditor(Designer) { }
	/* TfrxPropertyEditor.Destroy */ inline __fastcall virtual ~TfrxTimeProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPropertyItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TfrxPropertyEditor* FEditor;
	bool FExpanded;
	TfrxPropertyList* FSubProperty;
	
public:
	__fastcall virtual ~TfrxPropertyItem(void);
	__property TfrxPropertyEditor* Editor = {read=FEditor};
	__property bool Expanded = {read=FExpanded, write=FExpanded, nodefault};
	__property TfrxPropertyList* SubProperty = {read=FSubProperty};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxPropertyItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPropertyList : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxPropertyItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TPersistent* FComponent;
	Fmx::Frxclass::TfrxCustomDesigner* FDesigner;
	TfrxPropertyList* FParent;
	void __fastcall AddProperties(TfrxPropertyList* PropertyList);
	void __fastcall FillProperties(System::Classes::TPersistent* AClass);
	void __fastcall FillCommonProperties(TfrxPropertyList* PropertyList);
	void __fastcall SetComponent(System::Classes::TPersistent* Value);
	TfrxPropertyItem* __fastcall GetPropertyItem(int Index);
	
public:
	__fastcall TfrxPropertyList(Fmx::Frxclass::TfrxCustomDesigner* Designer);
	HIDESBASE TfrxPropertyItem* __fastcall Add(void);
	__property System::Classes::TPersistent* Component = {read=FComponent, write=SetComponent};
	__property TfrxPropertyItem* Items[int Index] = {read=GetPropertyItem/*, default*/};
	__property TfrxPropertyList* Parent = {read=FParent};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxPropertyList(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TfrxObjectCategory : unsigned char { ctData, ctReport, ctDialog, ctDMP };

typedef System::Set<TfrxObjectCategory, TfrxObjectCategory::ctData, TfrxObjectCategory::ctDMP> TfrxObjectCategories;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxObjectItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
public:
	Fmx::Frxclass::TfrxComponentClass ClassRef;
	Fmx::Graphics::TBitmap* ButtonBmp;
	int ButtonImageIndex;
	System::UnicodeString ButtonHint;
	System::UnicodeString CategoryName;
	System::Word Flags;
	TfrxObjectCategories Category;
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxObjectItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxObjectItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxComponentEditorItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
public:
	Fmx::Frxclass::TfrxComponentClass ComponentClass;
	TfrxComponentEditorClass ComponentEditor;
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxComponentEditorItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxComponentEditorItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPropertyEditorItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
public:
	System::Typinfo::TTypeInfo *PropertyType;
	System::TClass ComponentClass;
	System::UnicodeString PropertyName;
	TfrxPropertyEditorClass EditorClass;
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxPropertyEditorItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxPropertyEditorItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxExportFilterItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
public:
	Fmx::Frxclass::TfrxCustomExportFilter* Filter;
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxExportFilterItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxExportFilterItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxWizardItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
public:
	Fmx::Frxclass::TfrxWizardClass ClassRef;
	Fmx::Graphics::TBitmap* ButtonBmp;
	int ButtonImageIndex;
	bool IsToolbarWizard;
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxWizardItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxWizardItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxObjectCollection : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxObjectItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TfrxObjectItem* __fastcall GetObjectItem(int Index);
	
public:
	__fastcall TfrxObjectCollection(void);
	void __fastcall RegisterCategory(const System::UnicodeString CategoryName, Fmx::Graphics::TBitmap* ButtonBmp, const System::UnicodeString ButtonHint, int ImageIndex = 0xffffffff);
	void __fastcall RegisterObject(Fmx::Frxclass::TfrxComponentClass ClassRef, Fmx::Graphics::TBitmap* ButtonBmp, const System::UnicodeString CategoryName = System::UnicodeString());
	void __fastcall RegisterObject1(Fmx::Frxclass::TfrxComponentClass ClassRef, Fmx::Graphics::TBitmap* ButtonBmp, const System::UnicodeString ButtonHint = System::UnicodeString(), const System::UnicodeString CategoryName = System::UnicodeString(), int Flags = 0x0, int ImageIndex = 0xffffffff, TfrxObjectCategories Category = TfrxObjectCategories() );
	void __fastcall Unregister(Fmx::Frxclass::TfrxComponentClass ClassRef);
	__property TfrxObjectItem* Items[int Index] = {read=GetObjectItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxObjectCollection(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxComponentEditorCollection : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxComponentEditorItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TfrxComponentEditorItem* __fastcall GetComponentEditorItem(int Index);
	
public:
	__fastcall TfrxComponentEditorCollection(void);
	void __fastcall Register(Fmx::Frxclass::TfrxComponentClass ComponentClass, TfrxComponentEditorClass ComponentEditor);
	void __fastcall UnRegister(TfrxComponentEditorClass ComponentEditor);
	TfrxComponentEditor* __fastcall GetComponentEditor(Fmx::Frxclass::TfrxComponent* Component, Fmx::Frxclass::TfrxCustomDesigner* Designer, Fmx::Menus::TPopupMenu* Menu);
	__property TfrxComponentEditorItem* Items[int Index] = {read=GetComponentEditorItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxComponentEditorCollection(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPropertyEditorCollection : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxPropertyEditorItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	int FEventEditorItem;
	TfrxPropertyEditorItem* __fastcall GetPropertyEditorItem(int Index);
	
public:
	__fastcall TfrxPropertyEditorCollection(void);
	void __fastcall Register(System::Typinfo::PTypeInfo PropertyType, System::TClass ComponentClass, const System::UnicodeString PropertyName, TfrxPropertyEditorClass EditorClass);
	void __fastcall RegisterEventEditor(TfrxPropertyEditorClass EditorClass);
	void __fastcall UnRegister(TfrxPropertyEditorClass EditorClass);
	int __fastcall GetPropertyEditor(System::Typinfo::PTypeInfo PropertyType, System::Classes::TPersistent* Component, System::UnicodeString PropertyName);
	__property TfrxPropertyEditorItem* Items[int Index] = {read=GetPropertyEditorItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxPropertyEditorCollection(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxExportFilterCollection : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxExportFilterItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TfrxExportFilterItem* __fastcall GetExportFilterItem(int Index);
	
public:
	__fastcall TfrxExportFilterCollection(void);
	void __fastcall Register(Fmx::Frxclass::TfrxCustomExportFilter* Filter);
	void __fastcall Unregister(Fmx::Frxclass::TfrxCustomExportFilter* Filter);
	__property TfrxExportFilterItem* Items[int Index] = {read=GetExportFilterItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxExportFilterCollection(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxWizardCollection : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxWizardItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TfrxWizardItem* __fastcall GetWizardItem(int Index);
	
public:
	__fastcall TfrxWizardCollection(void);
	void __fastcall Register(Fmx::Frxclass::TfrxWizardClass ClassRef, Fmx::Graphics::TBitmap* ButtonBmp, bool IsToolbarWizard = false);
	void __fastcall Register1(Fmx::Frxclass::TfrxWizardClass ClassRef, int ImageIndex);
	void __fastcall Unregister(Fmx::Frxclass::TfrxWizardClass ClassRef);
	__property TfrxWizardItem* Items[int Index] = {read=GetWizardItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxWizardCollection(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall frxHideProperties(System::TClass ComponentClass, const System::UnicodeString Properties);
extern DELPHI_PACKAGE TfrxPropertyList* __fastcall frxCreatePropertyList(System::Classes::TList* ComponentList, Fmx::Frxclass::TfrxCustomDesigner* Designer);
extern DELPHI_PACKAGE TfrxObjectCollection* __fastcall frxObjects(void);
extern DELPHI_PACKAGE TfrxComponentEditorCollection* __fastcall frxComponentEditors(void);
extern DELPHI_PACKAGE TfrxPropertyEditorCollection* __fastcall frxPropertyEditors(void);
extern DELPHI_PACKAGE TfrxExportFilterCollection* __fastcall frxExportFilters(void);
extern DELPHI_PACKAGE TfrxWizardCollection* __fastcall frxWizards(void);
}	/* namespace Frxdsgnintf */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXDSGNINTF)
using namespace Fmx::Frxdsgnintf;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxdsgnintfHPP
