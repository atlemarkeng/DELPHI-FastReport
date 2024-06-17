
{******************************************}
{                                          }
{             FastReport v4.0              }
{             Design interface             }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxDsgnIntf;

interface

{$I fmx.inc}
{$I frx.inc}

uses
  System.Classes, System.SysUtils, System.TypInfo, System.Types, System.Variants,
  System.UIConsts, System.UITypes, FMX.Types, FMX.Menus, FMX.Colors,
  FMX.frxClass, FMX.frxFMX
{$IFDEF DELPHI19}
  , FMX.Graphics
{$ENDIF};


type
  TfrxPropertyAttribute = (paValueList, paSortList, paDialog,
    paMultiSelect, paSubProperties, paReadOnly, paOwnerDraw);
  TfrxPropertyAttributes = set of TfrxPropertyAttribute;

  TfrxPropertyEditor = class(TObject)
  private
    FDesigner: TfrxCustomDesigner;
    FCompList: TList;
    FPropList: TList;
    FItemHeight: Integer;
    FValues: TStrings;
    function GetPropInfo: PPropInfo;
    function GetComponent: TPersistent;
    function GetfrComponent: TfrxComponent;
  protected
    procedure GetStrProc(const s: String);
    function GetFloatValue: Extended;
    function GetOrdValue: Integer;
    function GetStrValue: String;
    function GetVarValue: Variant;
    procedure SetFloatValue(Value: Extended);
    procedure SetOrdValue(Value: Integer);
    procedure SetStrValue(const Value: String);
    procedure SetVarValue(Value: Variant);
  public
    constructor Create(Designer: TfrxCustomDesigner); virtual;
    destructor Destroy; override;
    function Edit: Boolean; virtual;
    function GetAttributes: TfrxPropertyAttributes; virtual;
    function GetName: String; virtual;
    function GetExtraLBSize: Integer; virtual;
    function GetValue: String; virtual;
    procedure GetValues; virtual;
    procedure SetValue(const Value: String); virtual;
    procedure OnDrawLBItem(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF); virtual;
    procedure OnDrawItem(Canvas: TCanvas; ARect: TRectF); virtual;
    property Component: TPersistent read GetComponent;
    property frComponent: TfrxComponent read GetfrComponent;
    property Designer: TfrxCustomDesigner read FDesigner;
    property ItemHeight: Integer read FItemHeight write FItemHeight;
    property PropInfo: PPropInfo read GetPropInfo;
    property Value: String read GetValue write SetValue;
    property Values: TStrings read FValues;
  end;

  TfrxPropertyEditorClass = class of TfrxPropertyEditor;

  TfrxComponentEditor = class(TObject)
  private
    FComponent: TfrxComponent;
    FDesigner: TfrxCustomDesigner;
    FMenu: TPopupMenu;
    FOnClick: TNotifyEvent;
  protected
    function AddItem(const Caption: String; Tag: Integer;
      Checked: Boolean = False): TMenuItem;
  public
    constructor Create(Component: TfrxComponent; Designer: TfrxCustomDesigner;
      Menu: TPopupMenu);
    function Edit: Boolean; virtual;
    function HasEditor: Boolean; virtual;
    procedure GetMenuItems(OnClickEvent: TNotifyEvent); virtual;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; virtual;
    property Component: TfrxComponent read FComponent;
    property Designer: TfrxCustomDesigner read FDesigner;
  end;

  TfrxComponentEditorClass = class of TfrxComponentEditor;

  TfrxIntegerProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxFloatProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxCharProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxStringProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxEnumProperty = class(TfrxPropertyEditor)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxSetProperty = class(TfrxPropertyEditor)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
  end;

  TfrxSetElementProperty = class(TfrxPropertyEditor)
  private
    FElement: Integer;
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetName: String; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
   end;

  TfrxClassProperty = class(TfrxPropertyEditor)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
  end;

  TfrxComponentProperty = class(TfrxPropertyEditor)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxNameProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
  end;

  TfrxColorProperty = class(TfrxIntegerProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
    procedure OnDrawLBItem(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF); override;
    procedure OnDrawItem(Canvas: TCanvas; ARect: TRectF); override;
  end;

  TfrxFontProperty = class(TfrxClassProperty)
  public
    function Edit: Boolean; override;
    function GetAttributes: TfrxPropertyAttributes; override;
  end;

  TfrxFontNameProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
  end;

  TfrxModalResultProperty = class(TfrxIntegerProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxCursorProperty = class(TfrxIntegerProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxDateTimeProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxDateProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxTimeProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

{ Internal classes used by Object Inspector }

  TfrxPropertyList = class;

  TfrxPropertyItem = class(TCollectionItem)
  private
    FEditor: TfrxPropertyEditor;
    FExpanded: Boolean;
    FSubProperty: TfrxPropertyList;
  public
    destructor Destroy; override;
    property Editor: TfrxPropertyEditor read FEditor;
    property Expanded: Boolean read FExpanded write FExpanded;
    property SubProperty: TfrxPropertyList read FSubProperty;
  end;

  TfrxPropertyList = class(TCollection)
  private
    FComponent: TPersistent;
    FDesigner: TfrxCustomDesigner;
    FParent: TfrxPropertyList;
    procedure AddProperties(PropertyList: TfrxPropertyList);
    procedure FillProperties(AClass: TPersistent);
    procedure FillCommonProperties(PropertyList: TfrxPropertyList);
    procedure SetComponent(Value: TPersistent);
    function GetPropertyItem(Index: Integer): TfrxPropertyItem;
  public
    constructor Create(Designer: TfrxCustomDesigner);
    function Add: TfrxPropertyItem;
    property Component: TPersistent read FComponent write SetComponent;
    property Items[Index: Integer]: TfrxPropertyItem read GetPropertyItem; default;
    property Parent: TfrxPropertyList read FParent;
  end;


{ registered items }

  TfrxObjectCategory = (ctData, ctReport, ctDialog, ctDMP);
  TfrxObjectCategories = set of TfrxObjectCategory;

  TfrxObjectItem = class(TCollectionItem)
  public
    ClassRef: TfrxComponentClass;
    ButtonBmp: TBitmap;
    ButtonImageIndex: Integer;
    ButtonHint: String;
    CategoryName: String;
    Flags: Word;
    Category: TfrxObjectCategories;
  end;

  TfrxComponentEditorItem = class(TCollectionItem)
  public
    ComponentClass: TfrxComponentClass;
    ComponentEditor: TfrxComponentEditorClass;
  end;

  TfrxPropertyEditorItem = class(TCollectionItem)
  public
    PropertyType: PTypeInfo;
    ComponentClass: TClass;
    PropertyName: String;
    EditorClass: TfrxPropertyEditorClass;
  end;

  TfrxExportFilterItem = class(TCollectionItem)
  public
    Filter: TfrxCustomExportFilter;
  end;

  TfrxWizardItem = class(TCollectionItem)
  public
    ClassRef: TfrxWizardClass;
    ButtonBmp: TBitmap;
    ButtonImageIndex: Integer;
    IsToolbarWizard: Boolean;
  end;

  TfrxObjectCollection = class(TCollection)
  private
    function GetObjectItem(Index: Integer): TfrxObjectItem;
  public
    constructor Create;
    procedure RegisterCategory(const CategoryName: String; ButtonBmp: TBitmap;
      const ButtonHint: String; ImageIndex: Integer = -1);
    procedure RegisterObject(ClassRef: TfrxComponentClass; ButtonBmp: TBitmap;
      const CategoryName: String = '');
    procedure RegisterObject1(ClassRef: TfrxComponentClass; ButtonBmp: TBitmap;
      const ButtonHint: String = ''; const CategoryName: String = '';
      Flags: Integer = 0; ImageIndex: Integer = -1;
      Category: TfrxObjectCategories = []);
    procedure Unregister(ClassRef: TfrxComponentClass);
    property Items[Index: Integer]: TfrxObjectItem read GetObjectItem; default;
  end;

  TfrxComponentEditorCollection = class(TCollection)
  private
    function GetComponentEditorItem(Index: Integer): TfrxComponentEditorItem;
  public
    constructor Create;
    procedure Register(ComponentClass: TfrxComponentClass;
      ComponentEditor: TfrxComponentEditorClass);
    procedure UnRegister(ComponentEditor: TfrxComponentEditorClass);
    function GetComponentEditor(Component: TfrxComponent;
      Designer: TfrxCustomDesigner; Menu: TPopupMenu): TfrxComponentEditor;
    property Items[Index: Integer]: TfrxComponentEditorItem
      read GetComponentEditorItem; default;
  end;

  TfrxPropertyEditorCollection = class(TCollection)
  private
    FEventEditorItem: Integer;
    function GetPropertyEditorItem(Index: Integer): TfrxPropertyEditorItem;
  public
    constructor Create;
    procedure Register(PropertyType: PTypeInfo; ComponentClass: TClass;
      const PropertyName: String; EditorClass: TfrxPropertyEditorClass);
    procedure RegisterEventEditor(EditorClass: TfrxPropertyEditorClass);
    procedure UnRegister(EditorClass: TfrxPropertyEditorClass);
    function GetPropertyEditor(PropertyType: PTypeInfo; Component: TPersistent;
      PropertyName: String): Integer;
    property Items[Index: Integer]: TfrxPropertyEditorItem
      read GetPropertyEditorItem; default;
  end;

  TfrxExportFilterCollection = class(TCollection)
  private
    function GetExportFilterItem(Index: Integer): TfrxExportFilterItem;
  public
    constructor Create;
    procedure Register(Filter: TfrxCustomExportFilter);
    procedure Unregister(Filter: TfrxCustomExportFilter);
    property Items[Index: Integer]: TfrxExportFilterItem
      read GetExportFilterItem; default;
  end;

  TfrxWizardCollection = class(TCollection)
  private
    function GetWizardItem(Index: Integer): TfrxWizardItem;
  public
    constructor Create;
    procedure Register(ClassRef: TfrxWizardClass; ButtonBmp: TBitmap;
      IsToolbarWizard: Boolean = False);
    procedure Register1(ClassRef: TfrxWizardClass; ImageIndex: Integer);
    procedure Unregister(ClassRef: TfrxWizardClass);
    property Items[Index: Integer]: TfrxWizardItem read GetWizardItem; default;
  end;


{ internal methods }

function frxCreatePropertyList(ComponentList: TList; Designer: TfrxCustomDesigner): TfrxPropertyList;
procedure frxHideProperties(ComponentClass: TClass; const Properties: String);


function frxObjects: TfrxObjectCollection;
function frxComponentEditors: TfrxComponentEditorCollection;
function frxPropertyEditors: TfrxPropertyEditorCollection;
function frxExportFilters: TfrxExportFilterCollection;
function frxWizards: TfrxWizardCollection;


implementation

uses
  FMX.frxUtils, FMX.frxRes, FMX.ListBox, FMX.frxFontForm;

type
  TIntegerSet = set of 0..31;

var
  FObjects: TfrxObjectCollection = nil;
  FComponentEditors: TfrxComponentEditorCollection = nil;
  FPropertyEditors: TfrxPropertyEditorCollection = nil;
  FExportFilters: TfrxExportFilterCollection = nil;
  FWizards: TfrxWizardCollection = nil;

{ Routines }

procedure frxHideProperties(ComponentClass: TClass; const Properties: String);
var
  i: Integer;
  sl: TStringList;
begin
  sl := TStringList.Create;
  frxSetCommaText(Properties, sl);

  for i := 0 to sl.Count - 1 do
    frxPropertyEditors.Register(nil, ComponentClass, sl[i], nil);

  sl.Free;
end;

function frxCreatePropertyList(ComponentList: TList;
  Designer: TfrxCustomDesigner): TfrxPropertyList;
var
  i: Integer;
  p: TfrxPropertyList;
  l: TList;
begin
  if ComponentList.Count = 0 then
  begin
    Result := nil;
    Exit;
  end;

  l := TList.Create;
  for i := 0 to ComponentList.Count - 1 do
  begin
    p := TfrxPropertyList.Create(Designer);
    l.Add(p);
    p.Component := ComponentList[i];
  end;

  Result := l[0];
  for i := 1 to ComponentList.Count - 1 do
    Result.FillCommonProperties(TfrxPropertyList(l[i]));

  for i := 1 to ComponentList.Count - 1 do
  begin
    TfrxPropertyList(l[i]).FillCommonProperties(Result);
    Result.AddProperties(TfrxPropertyList(l[i]));
    TfrxPropertyList(l[i]).Free;
  end;

  l.Free;
end;

function frStrToFloat(s: String): Extended;
var
  i: Integer;
begin
  for i := 1 to Length(s) do
    if CharInSet(s[i], [',', '.']) then
      s[i] := FormatSettings.DecimalSeparator;
  Result := StrToFloat(Trim(s));
end;


{ TfrxPropertyEditor }

constructor TfrxPropertyEditor.Create(Designer: TfrxCustomDesigner);
begin
  FDesigner := Designer;
  FCompList := TList.Create;
  FPropList := TList.Create;
  FValues := TStringList.Create;
end;

destructor TfrxPropertyEditor.Destroy;
begin
  FCompList.Free;
  FPropList.Free;
  FValues.Free;
  inherited;
end;

function TfrxPropertyEditor.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect];
end;

function TfrxPropertyEditor.GetName: String;
begin
  Result := String(PropInfo.Name);
end;

function TfrxPropertyEditor.GetComponent: TPersistent;
begin
  Result := FCompList[0];
end;

function TfrxPropertyEditor.GetfrComponent: TfrxComponent;
begin
  if TObject(FCompList[0]) is TfrxComponent then
    Result := FCompList[0] else
    Result := nil;
end;

function TfrxPropertyEditor.GetPropInfo: PPropInfo;
begin
  Result := FPropList[0];
end;

function TfrxPropertyEditor.GetValue: String;
begin
  Result := '(Unknown)';
end;

procedure TfrxPropertyEditor.SetValue(const Value: String);
begin
  { empty method }
end;

function TfrxPropertyEditor.GetFloatValue: Extended;
begin
  Result := GetFloatProp(Component, PropInfo);
end;

function TfrxPropertyEditor.GetOrdValue: Integer;
begin
  Result := GetOrdProp(Component, PropInfo);
end;

function TfrxPropertyEditor.GetStrValue: String;
begin
  Result := GetStrProp(Component, PropInfo);
end;

function TfrxPropertyEditor.GetVarValue: Variant;
begin
  Result := GetVariantProp(Component, PropInfo);
end;

procedure TfrxPropertyEditor.SetFloatValue(Value: Extended);
var
  i: Integer;
begin
  for i := 0 to FCompList.Count - 1 do
    if (PPropInfo(FPropList[i]).SetProc <> nil) then
      SetFloatProp(TObject(FCompList[i]), PPropInfo(FPropList[i]), Value);
end;

procedure TfrxPropertyEditor.SetOrdValue(Value: Integer);
var
  i: Integer;
begin
  for i := 0 to FCompList.Count - 1 do
    if (PPropInfo(FPropList[i]).SetProc <> nil) then
      SetOrdProp(TObject(FCompList[i]), PPropInfo(FPropList[i]), Value);
end;

procedure TfrxPropertyEditor.SetStrValue(const Value: String);
var
  i: Integer;
begin
  for i := 0 to FCompList.Count - 1 do
    if (PPropInfo(FPropList[i]).SetProc <> nil) then
      SetStrProp(TObject(FCompList[i]), PPropInfo(FPropList[i]), Value);
end;

procedure TfrxPropertyEditor.SetVarValue(Value: Variant);
var
  i: Integer;
begin
  for i := 0 to FCompList.Count - 1 do
    if (PPropInfo(FPropList[i]).SetProc <> nil) then
      SetVariantProp(TObject(FCompList[i]), PPropInfo(FPropList[i]), Value);
end;

procedure TfrxPropertyEditor.GetValues;
begin
  FValues.Clear;
  TStringList(FValues).Sorted := paSortList in GetAttributes;
end;

procedure TfrxPropertyEditor.GetStrProc(const s: String);
begin
  FValues.Add(s);
end;

function TfrxPropertyEditor.Edit: Boolean;
var
  i: Integer;
begin
  Result := False;
  GetValues;
  if FValues.Count > 0 then
  begin
    i := FValues.IndexOf(Value) + 1;
    if i = FValues.Count then
      i := 0;
    Value := FValues[i];
    Result := True;
  end;
end;

procedure TfrxPropertyEditor.OnDrawLBItem(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  with Canvas do
  begin
    Fill.Kind := TBrushKind.bkSolid;
    Fill.Color := claWhite;
    FillRect(ARect, 0, 0, allCorners, 1);
    Fill.Color := claBlack;
    FillText(RectF(ARect.Left + FItemHeight + 4, ARect.Top + 1, ARect.Right, ARect.Bottom),
      TListBoxItem(Sender).Text, False, 1, [], TTextAlign.taLeading, TTextAlign.taLeading);
  end;
end;

procedure TfrxPropertyEditor.OnDrawItem(Canvas: TCanvas; ARect: TRectF);
begin
  with Canvas do
  begin
    Fill.Kind := TBrushKind.bkSolid;
    FillText(RectF(ARect.Left + FItemHeight - 2, ARect.Top, ARect.Right, ARect.Bottom), Value, False, 1, [], TTextAlign.taLeading, TTextAlign.taLeading);
  end;
end;

function TfrxPropertyEditor.GetExtraLBSize: Integer;
begin
  Result := FItemHeight + 2;
end;


{ TfrxComponentEditor }

function TfrxComponentEditor.Edit: Boolean;
begin
  Result := False;
end;

procedure TfrxComponentEditor.GetMenuItems(OnClickEvent: TNotifyEvent);
var
  SepMI: TMenuItem;
begin
  SepMI := TMenuItem.Create(FMenu);
  SepMI.Text := '-';
  SepMI.Parent := FMenu;
  FOnClick := OnClickEvent;
end;

function TfrxComponentEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
begin
  Result := False;
end;

function TfrxComponentEditor.HasEditor: Boolean;
begin
  Result := False;
end;

function TfrxComponentEditor.AddItem(const Caption: String; Tag: Integer;
  Checked: Boolean): TMenuItem;
begin
  Result := TMenuItem.Create(FMenu);
  Result.Text := Caption;
  Result.Tag := Tag;
  Result.IsChecked := Checked;
  Result.OnClick := FOnClick;
  FMenu.AddObject(Result);
end;


constructor TfrxComponentEditor.Create(Component: TfrxComponent;
  Designer: TfrxCustomDesigner; Menu: TPopupMenu);
begin
  FComponent := Component;
  FDesigner := Designer;
  FMenu := Menu;
  FOnClick := nil;
end;


{ TfrxPropertyList }

constructor TfrxPropertyList.Create(Designer: TfrxCustomDesigner);
begin
  inherited Create(TfrxPropertyItem);
  FDesigner := Designer;
end;

function TfrxPropertyList.GetPropertyItem(Index: Integer): TfrxPropertyItem;
begin
  Result := TfrxPropertyItem(inherited Items[Index]);
end;

function TfrxPropertyList.Add: TfrxPropertyItem;
begin
  Result := TfrxPropertyItem(inherited Add);
end;

procedure TfrxPropertyList.SetComponent(Value: TPersistent);
begin
  FComponent := Value;
  Clear;
  FillProperties(FComponent);
end;

procedure TfrxPropertyList.FillProperties(AClass: TPersistent);
var
  Item, Item1: TfrxPropertyItem;
  TypeInfo: PTypeInfo;
  PropertyCount: Integer;
  PropertyList: PPropList;
  i, j: Integer;
  FClass: TClass;

  function CreateEditor(EditorClass: TfrxPropertyEditorClass; AClass: TPersistent;
    PropInfo: PPropInfo): TfrxPropertyEditor;
  var
    Item: TfrxPropertyEditorItem;
    e: Integer;
  begin
    Result := nil;
    e := frxPropertyEditors.GetPropertyEditor(PropInfo.PropType^, AClass, String(PropInfo.Name));
    if e <> -1 then
    begin
      Item := frxPropertyEditors[e];
      if Item.EditorClass <> nil then
        Result := TfrxPropertyEditor(Item.EditorClass.NewInstance) else
        Exit;
    end
    else
      Result := TfrxPropertyEditor(EditorClass.NewInstance);

    Result.Create(FDesigner);
    Result.FCompList.Add(AClass);
    Result.FPropList.Add(PropInfo);
  end;

begin
  if AClass = nil then exit;

  TypeInfo := AClass.ClassInfo;
  PropertyCount := GetPropList(TypeInfo, tkProperties, nil);
  GetMem(PropertyList, PropertyCount * SizeOf(PPropInfo));
  GetPropList(TypeInfo, tkProperties, PropertyList);

  for i := 0 to PropertyCount - 1 do
  begin
    Item := Add;
    case PropertyList[i].PropType^.Kind of
      tkInteger:
        Item.FEditor := CreateEditor(TfrxIntegerProperty, AClass, PropertyList[i]);

      tkChar, tkWChar:
        Item.FEditor := CreateEditor(TfrxCharProperty, AClass, PropertyList[i]);

      tkFloat:
        Item.FEditor := CreateEditor(TfrxFloatProperty, AClass, PropertyList[i]);

      tkString, tkLString, tkWString, tkUString:
        Item.FEditor := CreateEditor(TfrxStringProperty, AClass, PropertyList[i]);

      tkEnumeration:
        Item.FEditor := CreateEditor(TfrxEnumProperty, AClass, PropertyList[i]);

      tkSet:
        begin
          Item.FSubProperty := TfrxPropertyList.Create(FDesigner);
          Item.FSubProperty.FParent := Self;
          Item.FEditor := CreateEditor(TfrxSetProperty, AClass, PropertyList[i]);
          with GetTypeData(GetTypeData(PropertyList[i].PropType^).CompType^)^ do
            for j := MinValue to MaxValue do
            begin
              Item1 := Item.FSubProperty.Add;
              Item1.FEditor := CreateEditor(TfrxSetElementProperty, AClass, PropertyList[i]);
              if Item1.FEditor <> nil then
                TfrxSetElementProperty(Item1.FEditor).FElement := j;
            end;
        end;

      tkClass:
        begin
          FClass := GetTypeData(PropertyList[i].PropType^)^.ClassType;
          if FClass.InheritsFrom(TComponent) then
            Item.FEditor := CreateEditor(TfrxComponentProperty, AClass, PropertyList[i])
          else if FClass.InheritsFrom(TPersistent) then
          begin
            Item.FEditor := CreateEditor(TfrxClassProperty, AClass, PropertyList[i]);
            Item.FSubProperty := TfrxPropertyList.Create(FDesigner);
            Item.FSubProperty.FParent := Self;
            Item.FSubProperty.Component := TPersistent(GetOrdProp(AClass, PropertyList[i]));
            if Item.SubProperty.Count = 0 then
            begin
              Item.FSubProperty.Free;
              Item.FSubProperty := nil;
            end;
          end;
        end;
    end;
    if Item.FEditor = nil then
      Item.Free;
  end;

  FreeMem(PropertyList, PropertyCount * SizeOf(PPropInfo));
end;

procedure TfrxPropertyList.FillCommonProperties(PropertyList: TfrxPropertyList);
var
  i, j: Integer;
  p, p1: TfrxPropertyItem;
  Found: Boolean;
begin
  i := 0;
  while i < Count do
  begin
    p := Items[i];
    Found := False;
    if paMultiSelect in p.Editor.GetAttributes then
      for j := 0 to PropertyList.Count - 1 do
      begin
        p1 := PropertyList.Items[j];
        if (p1.Editor.GetPropInfo.PropType^.Kind = p.Editor.GetPropInfo.PropType^.Kind) and
           (p1.Editor.GetPropInfo.Name = p.Editor.GetPropInfo.Name) then
        begin
          Found := True;
          break;
        end;
      end;

    if not Found then
      p.Free else
      Inc(i);
  end;
end;

procedure TfrxPropertyList.AddProperties(PropertyList: TfrxPropertyList);

  procedure EnumProperties(p1, p2: TfrxPropertyList);
  var
    i: Integer;
  begin
    for i := 0 to p1.Count - 1 do
    begin
      p1[i].Editor.FCompList.Add(p2[i].Editor.FCompList[0]);
      p1[i].Editor.FPropList.Add(p2[i].Editor.FPropList[0]);
      if p1[i].SubProperty <> nil then
        EnumProperties(p1[i].SubProperty, p2[i].SubProperty);
    end;
  end;

begin
  EnumProperties(Self, PropertyList);
end;


{ TfrxPropertyItem }

destructor TfrxPropertyItem.Destroy;
begin
  if Editor <> nil then
    Editor.Free;
  if SubProperty <> nil then
    SubProperty.Free;
  inherited;
end;


{ TfrxIntegerProperty }

function TfrxIntegerProperty.GetValue: String;
begin
  Result := IntToStr(GetOrdValue);
end;

procedure TfrxIntegerProperty.SetValue(const Value: String);
begin
  SetOrdValue(StrToInt(Value));
end;


{ TfrxFloatProperty }

function TfrxFloatProperty.GetValue: String;
begin
  Result := FloatToStr(GetFloatValue);
end;

procedure TfrxFloatProperty.SetValue(const Value: String);
begin
  SetFloatValue(frStrToFloat(Value));
end;


{ TfrxCharProperty }

function TfrxCharProperty.GetValue: String;
var
  Ch: Char;
begin
  Ch := Chr(GetOrdValue);
  if CharInSet(Ch, [#33..#255]) then
    Result := Ch else
    FmtStr(Result, '#%d', [Ord(Ch)]);
end;

procedure TfrxCharProperty.SetValue(const Value: String);
var
  i: Integer;
begin
  if Length(Value) = 0 then i := 0 else
    if Length(Value) = 1 then i := Ord(Value[1]) else
      if Value[1] = '#' then i := StrToInt(Copy(Value, 2, 255)) else
        raise Exception.Create(frxResources.Get('prInvProp'));
  SetOrdValue(i);
end;


{ TfrxStringProperty }

function TfrxStringProperty.GetValue: String;
begin
  Result := GetStrValue;
end;

procedure TfrxStringProperty.SetValue(const Value: String);
begin
  SetStrValue(Value);
end;


{ TfrxEnumProperty }

function TfrxEnumProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList];
end;

function TfrxEnumProperty.GetValue: String;
var
  i: Integer;
begin
  i := GetOrdValue;
  try
    Result := GetEnumName(PropInfo.PropType^, i);
  except
    Result := '';
  end;
end;

procedure TfrxEnumProperty.GetValues;
var
  i: Integer;
begin
  inherited;
  with GetTypeData(PropInfo.PropType^)^ do
    for i := MinValue to MaxValue do
      Values.Add(GetEnumName(PropInfo.PropType^, i));
end;

procedure TfrxEnumProperty.SetValue(const Value: String);
var
  i: Integer;
begin
  i := GetEnumValue(PropInfo.PropType^, Value);
  if i < 0 then
    raise Exception.Create(frxResources.Get('prInvProp'));
  SetOrdValue(i);
end;


{ TfrxSetProperty }

function TfrxSetProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paSubProperties, paReadOnly];
end;

function TfrxSetProperty.GetValue: String;
var
  S: TIntegerSet;
  TypeInfo: PTypeInfo;
  I: Integer;
begin
  Integer(S) := GetOrdValue;
  TypeInfo := GetTypeData(PropInfo.PropType^).CompType^;
  Result := '[';
  for i := 0 to 31 do
    if i in S then
    begin
      if Length(Result) <> 1 then
        Result := Result + ',';
      Result := Result + GetEnumName(TypeInfo, i);
    end;
  Result := Result + ']';
end;


{ TfrxSetElementProperty }

function TfrxSetElementProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList];
end;

function TfrxSetElementProperty.GetName: String;
begin
  Result := GetEnumName(GetTypeData(PropInfo.PropType^).CompType^, FElement);
end;

function TfrxSetElementProperty.GetValue: String;
var
  S: TIntegerSet;
begin
  Integer(S) := GetOrdValue;
  if FElement in S then
    Result := 'True' else
    Result := 'False';
end;

procedure TfrxSetElementProperty.GetValues;
begin
  inherited;
  Values.Add('False');
  Values.Add('True');
end;

procedure TfrxSetElementProperty.SetValue(const Value: String);
var
  S: TIntegerSet;
begin
  Integer(S) := GetOrdValue;
  if CompareText(Value, 'True') = 0 then
    Include(S, FElement)
  else if CompareText(Value, 'False') = 0 then
    Exclude(S, FElement)
  else
    raise Exception.Create(frxResources.Get('prInvProp'));

  SetOrdValue(Integer(S));
end;


{ TfrxClassProperty }

function TfrxClassProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paSubProperties, paReadOnly];
end;

function TfrxClassProperty.GetValue: String;
begin
  Result := {'';//}'(' + String(PropInfo.PropType^.Name) + ')';
end;


{ TComponentProperty }

function TfrxComponentProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList];
end;

function TfrxComponentProperty.GetValue: String;
var
  c: TComponent;
begin
  c := TComponent(GetOrdValue);
  if c <> nil then
    Result := c.Name else
    Result := '';
end;

procedure TfrxComponentProperty.GetValues;
var
  i: Integer;
  c, c1: TfrxComponent;
begin
  inherited;

  if frComponent <> nil then
  begin
    if frComponent is TfrxReportComponent then
      c := frComponent.Page else
      c := frComponent;
    for i := 0 to c.AllObjects.Count - 1 do
    begin
      c1 := c.AllObjects[i];
      if (c1 <> frComponent) and
        c1.InheritsFrom(GetTypeData(PropInfo.PropType^)^.ClassType) then
        Values.Add(c1.Name);
    end;
  end;
end;

procedure TfrxComponentProperty.SetValue(const Value: String);
var
  c: TComponent;
begin
  c := nil;
  if Value <> '' then
  begin
    c := frComponent.Report.FindObject(Value);
    if c = nil then
      raise Exception.Create(frxResources.Get('prInvProp'));
  end;

  SetOrdValue(Integer(c));
end;


{ TfrxNameProperty }

function TfrxNameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [];
end;


{ TfrxColorProperty }

function TfrxColorProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paOwnerDraw];
end;

function TfrxColorProperty.GetValue: String;
begin
  Result := AlphaColorToString(GetOrdValue);
end;

procedure TfrxColorProperty.SetValue(const Value: String);
begin
  SetOrdValue(StringToAlphaColor(Value));
end;

procedure TfrxColorProperty.GetValues;
begin
  inherited;
  GetAlphaColorValues(GetStrProc);
end;

procedure TfrxColorProperty.OnDrawLBItem(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  r: TRectF;
  c: Integer;
begin
  inherited;
  with Canvas do
  begin
    r := RectF(Round(ARect.Left + 2) + 0.5, Round(ARect.Top + 2) + 0.5, Round(ARect.Left + (ARect.Bottom - ARect.Top - 2)) - 0.5, Round(ARect.Bottom - 2) + 0.5);
    IdentToAlphaColor('cla' + TListBoxItem(Sender).Text, c);
    Fill.Color := c;
    Fill.Kind := TBrushKind.bkSolid;
    FillRect(r, 0, 0, allCorners, 1);
    Stroke.Color := claDimGray;
    Stroke.Kind := TBrushKind.bkSolid;
    DrawRect(r, 0, 0, allCorners, 1);
  end;
end;

procedure TfrxColorProperty.OnDrawItem(Canvas: TCanvas; ARect: TRectF);
var
  r: TRectF;
begin
  inherited;
  with Canvas do
  begin
    r := RectF(Round(ARect.Left) + 0.5, Round(ARect.Top) + 1.5, Round(ARect.Left + (ARect.Bottom - ARect.Top - 5)) - 0.5, Round(ARect.Bottom - 5) + 0.5);
    Fill.Color := GetOrdValue or $FF000000;
    Fill.Kind := TBrushKind.bkSolid;
    FillRect(r, 0, 0, allCorners, 1);
    Stroke.Color := claDimGray;
    Stroke.Kind := TBrushKind.bkSolid;
    DrawRect(r, 0, 0, allCorners, 1);
  end;
end;


{ TfrxFontProperty }

function TfrxFontProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog, paSubProperties, paReadOnly];
end;

function TfrxFontProperty.Edit: Boolean;
//var
  //FontDialog: TFontDialog;
begin
// todo
{  FontDialog := TFontDialog.Create(Application);
  try
    FontDialog.Font := TFont(GetOrdValue);
    FontDialog.Options := FontDialog.Options + [fdForceFontExist];
    FontDialog.Device := fdBoth;
    Result := FontDialog.Execute;
    if Result then
      SetOrdValue(Integer(FontDialog.Font));
  finally
    FontDialog.Free;
  end;}
  with TfrxFontForm.Create(nil) do
  begin

    try
      FontS.Assign(TfrxFont(GetOrdValue));
      FormActivate(nil);
      if ShowModal = mrOk then
         SetOrdValue(frxInteger(FontS));
    finally
      Free;
    end;
  end;
  Result := True;
end;


{ TfrxFontNameProperty }

function TfrxFontNameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList];
end;

procedure TfrxFontNameProperty.GetValues;
begin
  if Values.Count = 0 then
    FillFontsList(Values);
end;


{ TfrxModalResultProperty }

const
  ModalResults: array[mrNone..mrYesToAll] of string = (
    'mrNone',
    'mrOk',
    'mrCancel',
    'mrAbort',
    'mrRetry',
    'mrIgnore',
    'mrYes',
    'mrNo',
    'mrClose',
    'mrHelp',
    'mrTryAgain',
    'mrContinue',
    'mrAll',
    'mrNoToAll',
    'mrYesToAll');

function TfrxModalResultProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList];
end;

function TfrxModalResultProperty.GetValue: String;
begin
  if GetOrdValue in [mrNone..mrYesToAll] then
    Result := ModalResults[GetOrdValue] else
    Result := inherited GetValue;
end;

procedure TfrxModalResultProperty.SetValue(const Value: String);
var
  i: Integer;
  s: String;
begin
  s := Value;
  if s = '' then
    s := '0';
  for i := Low(ModalResults) to High(ModalResults) do
    if CompareText(ModalResults[i], s) = 0 then
    begin
      SetOrdValue(i);
      Exit;
    end;
  inherited SetValue(s);
end;

procedure TfrxModalResultProperty.GetValues;
var
  i: Integer;
begin
  inherited;
  for i := mrNone to mrYesToAll do
    Values.Add(ModalResults[i]);
end;



{ TfrxCursorProperty }

function TfrxCursorProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList];
end;

function TfrxCursorProperty.GetValue: string;
begin
  Result := CursorToString(TCursor(GetOrdValue));
end;

procedure TfrxCursorProperty.GetValues;
begin
  inherited;
  GetCursorValues(GetStrProc);
end;

procedure TfrxCursorProperty.SetValue(const Value: string);
var
  NewValue: Integer;
begin
  if IdentToCursor(Value, NewValue) then
    SetOrdValue(NewValue) else
    inherited;
end;


{ TfrxDateTimeProperty }

function TfrxDateTimeProperty.GetValue: String;
var
  DT: TDateTime;
begin
  DT := GetFloatValue;
  if DT = 0.0 then
    Result := ''
  else
    Result := DateTimeToStr(DT);
end;

procedure TfrxDateTimeProperty.SetValue(const Value: String);
var
  DT: TDateTime;
begin
  if Value = '' then
    DT := 0.0
  else
    DT := StrToDateTime(Value);
  SetFloatValue(DT);
end;


{ TfrxDateProperty }

function TfrxDateProperty.GetValue: String;
var
  DT: TDateTime;
begin
  DT := GetFloatValue;
  if DT = 0.0 then
    Result := ''
  else
    Result := DateToStr(DT);
end;

procedure TfrxDateProperty.SetValue(const Value: String);
var
  DT: TDateTime;
begin
  if Value = '' then
    DT := 0.0
  else
    DT := StrToDate(Value);
  SetFloatValue(DT);
end;


{ TfrxTimeProperty }

function TfrxTimeProperty.GetValue: String;
var
  DT: TDateTime;
begin
  DT := GetFloatValue;
  if DT = 0.0 then
    Result := ''
  else
    Result := TimeToStr(DT);
end;

procedure TfrxTimeProperty.SetValue(const Value: String);
var
  DT: TDateTime;
begin
  if Value = '' then
    DT := 0.0
  else
    DT := StrToTime(Value);
  SetFloatValue(DT);
end;


{ TfrxObjectCollection }

constructor TfrxObjectCollection.Create;
begin
  inherited Create(TfrxObjectItem);
end;

function TfrxObjectCollection.GetObjectItem(Index: Integer): TfrxObjectItem;
begin
  Result := TfrxObjectItem(inherited Items[Index]);
end;

procedure TfrxObjectCollection.RegisterCategory(const CategoryName: String;
  ButtonBmp: TBitmap; const ButtonHint: String; ImageIndex: Integer);
begin
  RegisterObject1(nil, ButtonBmp, ButtonHint, CategoryName, 0, ImageIndex);
end;

procedure TfrxObjectCollection.RegisterObject(ClassRef: TfrxComponentClass;
  ButtonBmp: TBitmap; const CategoryName: String);
begin
  RegisterObject1(ClassRef, ButtonBmp, '', CategoryName);
end;

procedure TfrxObjectCollection.RegisterObject1(
  ClassRef: TfrxComponentClass; ButtonBmp: TBitmap;
  const ButtonHint: String = ''; const CategoryName: String = '';
  Flags: Integer = 0; ImageIndex: Integer = -1;
  Category: TfrxObjectCategories = []);
var
  i: Integer;
  Item: TfrxObjectItem;
begin
  for i := 0 to Count - 1 do
  begin
    Item := Items[i];
    if (Item.ClassRef <> nil) and (Item.ClassRef = ClassRef) and
      (Item.Flags = Flags) then
      Exit;
  end;

  if ClassRef <> nil then
    RegisterFmxClasses([ClassRef]);

  Item := TfrxObjectItem(Add);
  Item.ClassRef := ClassRef;
  Item.ButtonBmp := ButtonBmp;
  Item.ButtonImageIndex := ImageIndex;
  Item.ButtonHint := ButtonHint;
  Item.CategoryName := CategoryName;
  Item.Flags := Flags;
  Item.Category := Category;

  { if category is not set, determine it automatically }
  if (ClassRef <> nil) and (Category = []) then
  begin
    if ClassRef.InheritsFrom(TfrxDataset) or
      ClassRef.InheritsFrom(TfrxCustomDatabase) then
      Item.Category := [ctData]
    else if ClassRef.InheritsFrom(TfrxDialogControl) or
      ClassRef.InheritsFrom(TfrxDialogComponent) then
      Item.Category := [ctDialog]
    else
      Item.Category := [ctReport];
  end;
end;

procedure TfrxObjectCollection.UnRegister(ClassRef: TfrxComponentClass);
var
  i: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if Items[i].ClassRef = ClassRef then
      Items[i].Free else
      Inc(i);
  end;
end;


{ TfrxComponentEditorCollection }

constructor TfrxComponentEditorCollection.Create;
begin
  inherited Create(TfrxComponentEditorItem);
end;

function TfrxComponentEditorCollection.GetComponentEditorItem(
  Index: Integer): TfrxComponentEditorItem;
begin
  Result := TfrxComponentEditorItem(inherited Items[Index]);
end;

function TfrxComponentEditorCollection.GetComponentEditor(Component: TfrxComponent;
  Designer: TfrxCustomDesigner; Menu: TPopupMenu): TfrxComponentEditor;
var
  i, j: Integer;
begin
  Result := nil;
  j := -1;
  for i := 0 to Count - 1 do
    if Items[i].ComponentClass = Component.ClassType then
    begin
      j := i;
      break;
    end
    else if Component.InheritsFrom(Items[i].ComponentClass) then
      j := i;

  if j <> -1 then
  begin
    Result := TfrxComponentEditor(Items[j].ComponentEditor.NewInstance);
    Result.Create(Component, Designer, Menu);
  end;
end;

procedure TfrxComponentEditorCollection.Register(ComponentClass: TfrxComponentClass;
  ComponentEditor: TfrxComponentEditorClass);
var
  Item: TfrxComponentEditorItem;
begin
  Item := TfrxComponentEditorItem(Add);
  Item.ComponentClass := ComponentClass;
  Item.ComponentEditor := ComponentEditor;
end;

procedure TfrxComponentEditorCollection.UnRegister(ComponentEditor: TfrxComponentEditorClass);
var
  i: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if Items[i].ComponentEditor = ComponentEditor then
      Items[i].Free else
      Inc(i);
  end;
end;


{ TfrxPropertyEditorCollection }

constructor TfrxPropertyEditorCollection.Create;
begin
  inherited Create(TfrxPropertyEditorItem);
  FEventEditorItem := -1;
end;

function TfrxPropertyEditorCollection.GetPropertyEditorItem(
  Index: Integer): TfrxPropertyEditorItem;
begin
  Result := TfrxPropertyEditorItem(inherited Items[Index]);
end;

function TfrxPropertyEditorCollection.GetPropertyEditor(PropertyType: PTypeInfo;
  Component: TPersistent; PropertyName: String): Integer;
var
  i: Integer;
  Item: TfrxPropertyEditorItem;
begin
  if (Pos('tfrx', LowerCase(String(PropertyType.Name))) = 1) and
    (Pos('event', LowerCase(String(PropertyType.Name))) = Length(PropertyType.Name) - 4) then
  begin
    Result := FEventEditorItem;
    Exit;
  end;

  Result := -1;
  for i := Count - 1 downto 0 do
  begin
    Item := Items[i];
    if (Item.ComponentClass = nil) and (Item.PropertyName = '') and
      (Item.PropertyType = PropertyType) then
      Result := i
    else if (Item.ComponentClass = nil) and (Item.PropertyType = PropertyType) and
      (CompareText(Item.PropertyName, PropertyName) = 0) then
    begin
      Result := i;
      break;
    end
    else if (Component.InheritsFrom(Item.ComponentClass)) and
      (CompareText(Item.PropertyName, PropertyName) = 0) then
    begin
      Result := i;
      break;
    end;
  end;
end;

procedure TfrxPropertyEditorCollection.Register(PropertyType: PTypeInfo;
  ComponentClass: TClass; const PropertyName: String;
  EditorClass: TfrxPropertyEditorClass);
var
  Item: TfrxPropertyEditorItem;
begin
  Item := TfrxPropertyEditorItem(Add);
  Item.PropertyType := PropertyType;
  Item.ComponentClass := ComponentClass;
  Item.PropertyName := PropertyName;
  Item.EditorClass := EditorClass;
end;

procedure TfrxPropertyEditorCollection.RegisterEventEditor(
  EditorClass: TfrxPropertyEditorClass);
begin
  Register(nil, nil, '', EditorClass);
  FEventEditorItem := Count - 1;
end;

procedure TfrxPropertyEditorCollection.UnRegister(EditorClass: TfrxPropertyEditorClass);
var
  i: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if Items[i].EditorClass = EditorClass then
      Items[i].Free else
      Inc(i);
  end;
end;


{ TfrxExportFilterCollection }

constructor TfrxExportFilterCollection.Create;
begin
  inherited Create(TfrxExportFilterItem);
end;

function TfrxExportFilterCollection.GetExportFilterItem(
  Index: Integer): TfrxExportFilterItem;
begin
  Result := TfrxExportFilterItem(inherited Items[Index]);
end;

procedure TfrxExportFilterCollection.Register(Filter: TfrxCustomExportFilter);
var
  i: Integer;
  Item: TfrxExportFilterItem;
begin
  if Filter = nil then Exit;
  for i := 0 to Count - 1 do
    if Items[i].Filter = Filter then
      Exit;

  Item := TfrxExportFilterItem(Add);
  Item.Filter := Filter;
end;

procedure TfrxExportFilterCollection.UnRegister(Filter: TfrxCustomExportFilter);
var
  i: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if Items[i].Filter = Filter then
      Items[i].Free else
      Inc(i);
  end;
end;


{ TfrxWizardCollection }

constructor TfrxWizardCollection.Create;
begin
  inherited Create(TfrxWizardItem);
end;

function TfrxWizardCollection.GetWizardItem(Index: Integer): TfrxWizardItem;
begin
  Result := TfrxWizardItem(inherited Items[Index]);
end;

procedure TfrxWizardCollection.Register(ClassRef: TfrxWizardClass;
  ButtonBmp: TBitmap; IsToolbarWizard: Boolean);
var
  i: Integer;
  Item: TfrxWizardItem;
begin
  for i := 0 to Count - 1 do
    if Items[i].ClassRef = ClassRef then
      Exit;

  Item := TfrxWizardItem(Add);
  Item.ClassRef := ClassRef;
  Item.ButtonBmp := ButtonBmp;
  Item.ButtonImageIndex := -1;
  Item.IsToolbarWizard := IsToolbarWizard;
end;

procedure TfrxWizardCollection.Register1(ClassRef: TfrxWizardClass;
  ImageIndex: Integer);
var
  i: Integer;
  Item: TfrxWizardItem;
begin
  for i := 0 to Count - 1 do
    if Items[i].ClassRef = ClassRef then
      Exit;

  Item := TfrxWizardItem(Add);
  Item.ClassRef := ClassRef;
  Item.ButtonImageIndex := ImageIndex;
end;

procedure TfrxWizardCollection.UnRegister(ClassRef: TfrxWizardClass);
var
  i: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if Items[i].ClassRef = ClassRef then
      Items[i].Free else
      Inc(i);
  end;
end;


{ globals }

function frxObjects: TfrxObjectCollection;
begin
  if FObjects = nil then
    FObjects := TfrxObjectCollection.Create;
  Result := FObjects;
end;

function frxComponentEditors: TfrxComponentEditorCollection;
begin
  if FComponentEditors = nil then
    FComponentEditors := TfrxComponentEditorCollection.Create;
  Result := FComponentEditors;
end;

function frxPropertyEditors: TfrxPropertyEditorCollection;
begin
  if FPropertyEditors = nil then
    FPropertyEditors := TfrxPropertyEditorCollection.Create;
  Result := FPropertyEditors;
end;

function frxExportFilters: TfrxExportFilterCollection;
begin
  if FExportFilters = nil then
    FExportFilters := TfrxExportFilterCollection.Create;
  Result := FExportFilters;
end;

function frxWizards: TfrxWizardCollection;
begin
  if FWizards = nil then
    FWizards := TfrxWizardCollection.Create;
  Result := FWizards;
end;


initialization
  frxPropertyEditors.Register(TypeInfo(TComponentName), nil, 'Name', TfrxNameProperty);
  frxPropertyEditors.Register(TypeInfo(TAlphaColor), nil, '', TfrxColorProperty);
//  frxPropertyEditors.Register(TypeInfo(TfrxFont), nil, '', TfrxFontProperty);
  frxPropertyEditors.Register(TypeInfo(String), TfrxFont, 'Name', TfrxFontNameProperty);
  frxPropertyEditors.Register(TypeInfo(TModalResult), nil, '', TfrxModalResultProperty);
  frxPropertyEditors.Register(TypeInfo(TCursor), nil, '', TfrxCursorProperty);
  frxPropertyEditors.Register(TypeInfo(TDateTime), nil, '', TfrxDateTimeProperty);
  frxPropertyEditors.Register(TypeInfo(TDate), nil, '', TfrxDateProperty);
  frxPropertyEditors.Register(TypeInfo(TTime), nil, '', TfrxTimeProperty);


finalization
  if FObjects <> nil then
    FObjects.Free;
  FObjects := nil;
  if FComponentEditors <> nil then
    FComponentEditors.Free;
  FComponentEditors := nil;
  if FPropertyEditors <> nil then
    FPropertyEditors.Free;
  FPropertyEditors := nil;
  if FExportFilters <> nil then
    FExportFilters.Free;
  FExportFilters := nil;
  if FWizards <> nil then
    FWizards.Free;
  FWizards := nil;  


end.



//56db3b0f55102b9488a240d37950543f