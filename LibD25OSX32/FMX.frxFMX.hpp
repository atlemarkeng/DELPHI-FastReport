// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxFMX.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxfmxHPP
#define Fmx_FrxfmxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <System.Types.hpp>
#include <System.UIConsts.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Objects.hpp>
#include <System.Math.hpp>
#include <FMX.TreeView.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Platform.hpp>
#include <System.Variants.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.TextLayout.hpp>
#include <FMX.Graphics.hpp>
#include <System.Math.Vectors.hpp>
#include <Macapi.CoreText.hpp>
#include <Macapi.CoreFoundation.hpp>
#include <Macapi.CocoaTypes.hpp>
#include <Macapi.Foundation.hpp>
#include <FMX.Canvas.Mac.hpp>
#include <Macapi.CoreGraphics.hpp>
#include <Macapi.AppKit.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.Layouts.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxfmx
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxFont;
class DELPHICLASS TfrxImageList;
class DELPHICLASS TfrxToolButton;
class DELPHICLASS TfrxToolSeparator;
class DELPHICLASS TfrxToolGrip;
class DELPHICLASS TfrxTreeViewItem;
class DELPHICLASS TfrxTreeView;
class DELPHICLASS TfrxListBoxItem;
class DELPHICLASS TfrxListBox;
class DELPHICLASS TfrxStringList;
class DELPHICLASS TfrxFastCanvasLayer;
class DELPHICLASS TfrxFastCanvas;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxFont : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString FName;
	float FSize;
	float FPixelsPerInch;
	System::Uitypes::TFontStyles FStyle;
	System::Uitypes::TAlphaColor FColor;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetSize(float Value);
	void __fastcall SetStyle(System::Uitypes::TFontStyles Value);
	void __fastcall SetColor(System::Uitypes::TAlphaColor Value);
	void __fastcall SetHeight(float Value);
	void __fastcall DoChange(void);
	
protected:
	float __fastcall GetHeight(void)/* overload */;
	
public:
	__fastcall TfrxFont(void);
	HIDESBASE void __fastcall Assign(TfrxFont* Value);
	void __fastcall AssignToFont(Fmx::Graphics::TFont* Value);
	void __fastcall AssignToCanvas(Fmx::Graphics::TCanvas* Canvas);
	float __fastcall GetHeight(Fmx::Graphics::TCanvas* Canvas)/* overload */;
	bool __fastcall IsEqual(System::TObject* ToFont);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property float Size = {read=FSize, write=SetSize, stored=false};
	__property float PixelsPerInch = {read=FPixelsPerInch, write=FPixelsPerInch};
	__property System::Uitypes::TFontStyles Style = {read=FStyle, write=SetStyle, nodefault};
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=SetColor, nodefault};
	__property float Height = {read=GetHeight, write=SetHeight};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxFont(void) { }
	
};


class PASCALIMPLEMENTATION TfrxImageList : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	System::Classes::TList* FImages;
	int FWidth;
	int FHeight;
	int __fastcall GetCount(void);
	
public:
	__fastcall virtual TfrxImageList(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxImageList(void);
	void __fastcall Clear(void);
	void __fastcall AddMasked(Fmx::Graphics::TBitmap* Bmp, System::Uitypes::TAlphaColor Color);
	Fmx::Graphics::TBitmap* __fastcall Get(int Index);
	void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, float x, float y, int Index);
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property int Count = {read=GetCount, nodefault};
};


class PASCALIMPLEMENTATION TfrxToolButton : public Fmx::Stdctrls::TSpeedButton
{
	typedef Fmx::Stdctrls::TSpeedButton inherited;
	
private:
	Fmx::Graphics::TBitmap* FBitmap;
	bool FDown;
	System::UnicodeString FHint;
	void __fastcall SetBitmap(Fmx::Graphics::TBitmap* const Value);
	
protected:
	virtual void __fastcall DoMouseEnter(void);
	virtual void __fastcall DoMouseLeave(void);
	
public:
	__fastcall virtual TfrxToolButton(System::Classes::TComponent* AOwner)/* overload */;
	__fastcall virtual ~TfrxToolButton(void);
	virtual void __fastcall DoPaint(void);
	__property bool Down = {read=FDown, write=FDown, nodefault};
	
__published:
	__property Fmx::Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property TabOrder = {default=-1};
};


class PASCALIMPLEMENTATION TfrxToolSeparator : public Fmx::Controls::TControl
{
	typedef Fmx::Controls::TControl inherited;
	
public:
	virtual void __fastcall Paint(void);
	
__published:
	__property Position;
	__property Width;
	__property Height;
public:
	/* TControl.Create */ inline __fastcall virtual TfrxToolSeparator(System::Classes::TComponent* AOwner) : Fmx::Controls::TControl(AOwner) { }
	/* TControl.Destroy */ inline __fastcall virtual ~TfrxToolSeparator(void) { }
	
};


class PASCALIMPLEMENTATION TfrxToolGrip : public Fmx::Controls::TControl
{
	typedef Fmx::Controls::TControl inherited;
	
public:
	virtual void __fastcall Paint(void);
	
__published:
	__property Position;
	__property Width;
	__property Height;
public:
	/* TControl.Create */ inline __fastcall virtual TfrxToolGrip(System::Classes::TComponent* AOwner) : Fmx::Controls::TControl(AOwner) { }
	/* TControl.Destroy */ inline __fastcall virtual ~TfrxToolGrip(void) { }
	
};


class PASCALIMPLEMENTATION TfrxTreeViewItem : public Fmx::Treeview::TTreeViewItem
{
	typedef Fmx::Treeview::TTreeViewItem inherited;
	
private:
	Fmx::Stdctrls::TCustomButton* FButton;
	int FCloseImageIndex;
	int FOpenImageIndex;
	float FImgPos;
	System::TObject* FData;
	Fmx::Graphics::TBitmap* __fastcall GetBitmap(void);
	
protected:
	virtual void __fastcall ApplyStyle(void);
	
public:
	__fastcall virtual TfrxTreeViewItem(System::Classes::TComponent* AOwner)/* overload */;
	virtual void __fastcall Paint(void);
	__property int CloseImageIndex = {read=FCloseImageIndex, write=FCloseImageIndex, nodefault};
	__property int OpenImageIndex = {read=FOpenImageIndex, write=FOpenImageIndex, nodefault};
	__property System::TObject* Data = {read=FData, write=FData};
public:
	/* TTreeViewItem.Destroy */ inline __fastcall virtual ~TfrxTreeViewItem(void) { }
	
};


typedef void __fastcall (__closure *TfrxOnEditedEvent)(System::TObject* Sender, TfrxTreeViewItem* Node, System::UnicodeString &S);

typedef void __fastcall (__closure *TfrxOnBeforeChangeEvent)(System::TObject* Sender, TfrxTreeViewItem* OldNode, TfrxTreeViewItem* NewNode);

class PASCALIMPLEMENTATION TfrxTreeView : public Fmx::Treeview::TTreeView
{
	typedef Fmx::Treeview::TTreeView inherited;
	
private:
	Fmx::Graphics::TBitmap* FPicBitmap;
	int FIconWidth;
	int FIconHeight;
	Fmx::Edit::TEdit* FEditBox;
	bool FIsEditing;
	bool FEditable;
	bool FFreePicOnDelete;
	TfrxOnEditedEvent FOnEdited;
	TfrxOnBeforeChangeEvent FOnBeforeChange;
	bool FManualDragAndDrop;
	
protected:
	void __fastcall DoEditKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	virtual void __fastcall DoExit(void);
	virtual void __fastcall SetSelected(Fmx::Treeview::TTreeViewItem* const Value);
	virtual void __fastcall DblClick(void);
	void __fastcall DoExitEdit(System::TObject* Sender);
	virtual void __fastcall BeginAutoDrag(void);
	
public:
	__fastcall virtual TfrxTreeView(System::Classes::TComponent* AOwner)/* overload */;
	__fastcall virtual ~TfrxTreeView(void);
	void __fastcall DoEdit(void);
	void __fastcall EndEdit(bool Accept);
	virtual void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall KeyDown(System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall LoadResouces(System::Classes::TStream* Stream, int IconWidth, int IconHeight);
	__property Fmx::Graphics::TBitmap* PicPitmap = {read=FPicBitmap, write=FPicBitmap};
	__property int IconWidth = {read=FIconWidth, write=FIconWidth, nodefault};
	__property int IconHeight = {read=FIconHeight, write=FIconHeight, nodefault};
	System::Types::TRectF __fastcall GetBitmapRect(int Index);
	virtual void __fastcall DragOver(const Fmx::Types::TDragObject &Data, const System::Types::TPointF &Point, Fmx::Types::TDragOperation &Operation);
	virtual void __fastcall DragDrop(const Fmx::Types::TDragObject &Data, const System::Types::TPointF &Point);
	TfrxTreeViewItem* __fastcall AddItem(Fmx::Types::TFmxObject* Root, System::UnicodeString Text);
	HIDESBASE void __fastcall SetImages(Fmx::Graphics::TBitmap* Bmp);
	__property bool IsEditing = {read=FIsEditing, nodefault};
	__property bool ManualDragAndDrop = {read=FManualDragAndDrop, write=FManualDragAndDrop, nodefault};
	
__published:
	__property StyleLookup = {default=0};
	__property CanFocus = {default=1};
	__property DisableFocusEffect = {default=1};
	__property TabOrder = {default=-1};
	__property AllowDrag = {default=0};
	__property AlternatingRowBackground = {default=0};
	__property ItemHeight = {default=0};
	__property MultiSelect = {default=0};
	__property ShowCheckboxes = {default=0};
	__property Sorted = {default=0};
	__property OnChange;
	__property OnChangeCheck;
	__property OnCompare;
	__property OnDragChange;
	__property TfrxOnEditedEvent OnEdited = {read=FOnEdited, write=FOnEdited};
	__property TfrxOnBeforeChangeEvent OnBeforeChange = {read=FOnBeforeChange, write=FOnBeforeChange};
	__property bool Editable = {read=FEditable, write=FEditable, nodefault};
};


class PASCALIMPLEMENTATION TfrxListBoxItem : public Fmx::Listbox::TListBoxItem
{
	typedef Fmx::Listbox::TListBoxItem inherited;
	
private:
	Fmx::Stdctrls::TButton* FButton;
	Fmx::Stdctrls::TCheckBox* FCheck;
	bool FCheckVisible;
	bool __fastcall GetCheckVisible(void);
	void __fastcall SetCheckVisible(const bool Value);
	void __fastcall OnBtnClick(System::TObject* Sender);
	
protected:
	virtual void __fastcall ApplyStyle(void);
	virtual void __fastcall FreeStyle(void);
	
public:
	__fastcall virtual TfrxListBoxItem(System::Classes::TComponent* AOwner)/* overload */;
	__fastcall virtual ~TfrxListBoxItem(void);
	__property bool CheckVisible = {read=GetCheckVisible, write=SetCheckVisible, nodefault};
};


typedef void __fastcall (__closure *TfrxOnButtonClick)(System::TObject* Sender, System::TObject* aButton, TfrxListBoxItem* aItem);

class PASCALIMPLEMENTATION TfrxListBox : public Fmx::Listbox::TListBox
{
	typedef Fmx::Listbox::TListBox inherited;
	
	
private:
	class DELPHICLASS TfrxListBoxStrings;
	#pragma pack(push,4)
	class PASCALIMPLEMENTATION TfrxListBoxStrings : public System::Classes::TStrings
	{
		typedef System::Classes::TStrings inherited;
		
	private:
		Fmx::Listbox::TCustomListBox* FListBox;
		HIDESBASE void __fastcall ReadData(System::Classes::TReader* Reader);
		HIDESBASE void __fastcall WriteData(System::Classes::TWriter* Writer);
		
	protected:
		virtual void __fastcall Put(int Index, const System::UnicodeString S);
		virtual System::UnicodeString __fastcall Get(int Index);
		virtual int __fastcall GetCount(void);
		virtual System::TObject* __fastcall GetObject(int Index);
		virtual void __fastcall PutObject(int Index, System::TObject* AObject);
		virtual void __fastcall SetUpdateState(bool Updating);
		virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
		
	public:
		virtual int __fastcall Add(const System::UnicodeString S);
		virtual void __fastcall Clear(void);
		virtual void __fastcall Delete(int Index);
		virtual void __fastcall Exchange(int Index1, int Index2);
		virtual int __fastcall IndexOf(const System::UnicodeString S);
		virtual void __fastcall Insert(int Index, const System::UnicodeString S);
	public:
		/* TStrings.Create */ inline __fastcall TfrxListBoxStrings(void) : System::Classes::TStrings() { }
		/* TStrings.Destroy */ inline __fastcall virtual ~TfrxListBoxStrings(void) { }
		
	};
	
	#pragma pack(pop)
	
	
private:
	bool FManualDragAndDrop;
	TfrxOnButtonClick FOnButtonClickEvnt;
	System::Classes::TStrings* FItems;
	System::UnicodeString FCheckBoxText;
	System::UnicodeString FButtonText;
	bool FShowButtons;
	HIDESBASE bool __fastcall ItemsStored(void);
	HIDESBASE void __fastcall SetItems(System::Classes::TStrings* const Value);
	
protected:
	virtual void __fastcall BeginAutoDrag(void);
	virtual void __fastcall DragEnd(void);
	
public:
	__fastcall virtual TfrxListBox(System::Classes::TComponent* AOwner)/* overload */;
	__fastcall virtual ~TfrxListBox(void);
	virtual void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall DragOver(const Fmx::Types::TDragObject &Data, const System::Types::TPointF &Point, Fmx::Types::TDragOperation &Operation);
	virtual void __fastcall DragDrop(const Fmx::Types::TDragObject &Data, const System::Types::TPointF &Point);
	void __fastcall DoButtonClick(System::TObject* aButton, TfrxListBoxItem* aItem);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property bool ManualDragAndDrop = {read=FManualDragAndDrop, write=FManualDragAndDrop, nodefault};
	__property System::Classes::TStrings* Items = {read=FItems, write=SetItems, stored=ItemsStored};
	
__published:
	__property StyleLookup = {default=0};
	__property CanFocus = {default=1};
	__property DisableFocusEffect = {default=0};
	__property TabOrder = {default=-1};
	__property AllowDrag = {default=0};
	__property AlternatingRowBackground = {default=0};
	__property ItemHeight = {default=0};
	__property MultiSelect = {default=0};
	__property ShowCheckboxes = {default=0};
	__property Sorted = {default=0};
	__property OnChange;
	__property OnChangeCheck;
	__property OnCompare;
	__property OnDragChange;
	__property bool ShowButtons = {read=FShowButtons, write=FShowButtons, nodefault};
	__property System::UnicodeString CheckBoxText = {read=FCheckBoxText, write=FCheckBoxText};
	__property System::UnicodeString ButtonText = {read=FButtonText, write=FButtonText};
	__property TfrxOnButtonClick OnButtonClick = {read=FOnButtonClickEvnt, write=FOnButtonClickEvnt};
};


class PASCALIMPLEMENTATION TfrxStringList : public System::Classes::TStringList
{
	typedef System::Classes::TStringList inherited;
	
private:
	bool FUseUnicode;
	
protected:
	virtual int __fastcall CompareStrings(const System::UnicodeString S1, const System::UnicodeString S2);
	
public:
	__fastcall TfrxStringList(void)/* overload */;
	__fastcall TfrxStringList(bool UseUnicode)/* overload */;
public:
	/* TStringList.Create */ inline __fastcall TfrxStringList(System::WideChar QuoteChar, System::WideChar Delimiter)/* overload */ : System::Classes::TStringList(QuoteChar, Delimiter) { }
	/* TStringList.Create */ inline __fastcall TfrxStringList(System::WideChar QuoteChar, System::WideChar Delimiter, System::Classes::TStringsOptions Options)/* overload */ : System::Classes::TStringList(QuoteChar, Delimiter, Options) { }
	/* TStringList.Create */ inline __fastcall TfrxStringList(System::Types::TDuplicates Duplicates, bool Sorted, bool CaseSensitive)/* overload */ : System::Classes::TStringList(Duplicates, Sorted, CaseSensitive) { }
	/* TStringList.Destroy */ inline __fastcall virtual ~TfrxStringList(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxFastCanvasLayer : public Fmx::Graphics::TCanvas
{
	typedef Fmx::Graphics::TCanvas inherited;
	
protected:
	unsigned FContext;
	Fmx::Graphics::TCanvas* FCanvas;
	virtual unsigned __fastcall GetContext(void);
	virtual void __fastcall SetContext(const unsigned Value);
	virtual void __fastcall SetFont(Fmx::Graphics::TFont* const Value);
	virtual void __fastcall SetCanvas(Fmx::Graphics::TCanvas* const Value);
	virtual bool __fastcall DoBeginScene(const Fmx::Graphics::PClipRects AClipRects = (Fmx::Graphics::PClipRects)(0x0), NativeUInt AContextHandle = (NativeUInt)(0x0));
	virtual void __fastcall DoEndScene(void);
	__classmethod virtual NativeUInt __fastcall DoInitializeBitmap(const int Width, const int Height, const float Scale, Fmx::Types::TPixelFormat &PixelFormat);
	__classmethod virtual void __fastcall DoFinalizeBitmap(NativeUInt &Bitmap);
	__classmethod virtual bool __fastcall DoMapBitmap(const NativeUInt Bitmap, const Fmx::Graphics::TMapAccess Access, Fmx::Graphics::TBitmapData &Data);
	__classmethod virtual void __fastcall DoUnmapBitmap(const NativeUInt Bitmap, Fmx::Graphics::TBitmapData &Data);
	virtual bool __fastcall DoFillPolygon(const System::Math::Vectors::TPolygon Points, const float AOpacity, Fmx::Graphics::TBrush* const ABrush);
	virtual void __fastcall DoFillRect(const System::Types::TRectF &ARect, const float AOpacity, Fmx::Graphics::TBrush* const ABrush);
	virtual void __fastcall DoFillPath(Fmx::Graphics::TPathData* const APath, const float AOpacity, Fmx::Graphics::TBrush* const ABrush);
	virtual void __fastcall DoFillEllipse(const System::Types::TRectF &ARect, const float AOpacity, Fmx::Graphics::TBrush* const ABrush);
	virtual void __fastcall DoDrawBitmap(Fmx::Graphics::TBitmap* const ABitmap, const System::Types::TRectF &SrcRect, const System::Types::TRectF &DstRect, const float AOpacity, const bool HighSpeed = false);
	virtual void __fastcall DoDrawLine(const System::Types::TPointF &APt1, const System::Types::TPointF &APt2, const float AOpacity, Fmx::Graphics::TStrokeBrush* const ABrush);
	virtual void __fastcall DoDrawRect(const System::Types::TRectF &ARect, const float AOpacity, Fmx::Graphics::TStrokeBrush* const ABrush);
	virtual void __fastcall DoDrawPath(Fmx::Graphics::TPathData* const APath, const float AOpacity, Fmx::Graphics::TStrokeBrush* const ABrush);
	virtual void __fastcall DoDrawEllipse(const System::Types::TRectF &ARect, const float AOpacity, Fmx::Graphics::TStrokeBrush* const ABrush);
	
public:
	__fastcall virtual TfrxFastCanvasLayer(void);
	__fastcall virtual ~TfrxFastCanvasLayer(void);
	virtual void __fastcall ClearCache(void);
	virtual void __fastcall Clear(const System::Uitypes::TAlphaColor Color);
	virtual void __fastcall ClearRect(const System::Types::TRectF &ARect, const System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0x0));
	virtual void __fastcall IntersectClipRect(const System::Types::TRectF &ARect);
	virtual void __fastcall ExcludeClipRect(const System::Types::TRectF &ARect);
	virtual bool __fastcall PtInPath(const System::Types::TPointF &APoint, Fmx::Graphics::TPathData* const APath);
	virtual void __fastcall FillText(const System::Types::TRectF &ARect, const System::UnicodeString AText, const bool WordWrap, const float AOpacity, const Fmx::Graphics::TFillTextFlags Flags, const Fmx::Types::TTextAlign ATextAlign, const Fmx::Types::TTextAlign AVTextAlign);
	virtual void __fastcall MeasureText(System::Types::TRectF &ARect, const System::UnicodeString AText, const bool WordWrap, const Fmx::Graphics::TFillTextFlags Flags, const Fmx::Types::TTextAlign ATextAlign, const Fmx::Types::TTextAlign AVTextAlign);
	virtual float __fastcall CalcHeight(System::UnicodeString aText);
	virtual float __fastcall CalcWidth(System::UnicodeString aText);
	__property Fmx::Graphics::TFont* Font = {write=SetFont};
	__property unsigned Context = {read=GetContext, write=SetContext, nodefault};
	__property Fmx::Graphics::TCanvas* Canvas = {read=FCanvas, write=SetCanvas};
protected:
	/* TCanvas.CreateFromWindow */ inline __fastcall virtual TfrxFastCanvasLayer(Fmx::Types::TWindowHandle* const AParent, const int AWidth, const int AHeight, const Fmx::Graphics::TCanvasQuality AQuality) : Fmx::Graphics::TCanvas(AParent, AWidth, AHeight, AQuality) { }
	/* TCanvas.CreateFromBitmap */ inline __fastcall virtual TfrxFastCanvasLayer(Fmx::Graphics::TBitmap* const ABitmap, const Fmx::Graphics::TCanvasQuality AQuality) : Fmx::Graphics::TCanvas(ABitmap, AQuality) { }
	/* TCanvas.CreateFromPrinter */ inline __fastcall virtual TfrxFastCanvasLayer(Fmx::Graphics::TAbstractPrinter* const APrinter) : Fmx::Graphics::TCanvas(APrinter) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxFastCanvas : public TfrxFastCanvasLayer
{
	typedef TfrxFastCanvasLayer inherited;
	
private:
	void *FCurentFont;
	System::Classes::TStringList* FFontCacheList;
	Macapi::Cocoatypes::CGAffineTransform FFontTransformMatrix;
	void *FColorSpace;
	float FOpacity;
	System::UnicodeString FText;
	Fmx::Types::TTextAlign FTextAlign;
	bool FWordWrap;
	Fmx::Graphics::TFillTextFlags FFlags;
	void *FPath;
	float FTextHeight;
	float FTextWidth;
	void * __fastcall CreateCTFont(Fmx::Graphics::TFont* const AFont);
	void * __fastcall GetCTFont(Fmx::Graphics::TFont* const AFont);
	System::UnicodeString __fastcall GetFontNameHash(Fmx::Graphics::TFont* const AFont);
	int __fastcall AddCTFontToList(const System::UnicodeString aNameFont, void * aFontRef);
	void __fastcall ClearFontCache(void);
	HIDESBASE void __fastcall SetFont(Fmx::Graphics::TFont* const Value);
	void __fastcall CreateFrame(Fmx::Graphics::TCanvas* Canvas, CFStringRef StringRef, CFMutableAttributedStringRef &AttributedS, void * &Frame);
	void __fastcall AddFontAttribute(CFMutableAttributedStringRef AAttribute, Fmx::Graphics::TFont* AFont, const int AStart, const int ALength);
	HIDESBASE float __fastcall CalcHeight(void * Frame);
	HIDESBASE float __fastcall CalcWidth(void * Frame);
	
protected:
	virtual unsigned __fastcall GetContext(void);
	HIDESBASE void __fastcall SetCanvas(Fmx::Graphics::TCanvas* const Value);
	
public:
	__fastcall virtual TfrxFastCanvas(void);
	__fastcall virtual ~TfrxFastCanvas(void);
	virtual void __fastcall FillText(const System::Types::TRectF &ARect, const System::UnicodeString AText, const bool WordWrap, const float AOpacity, const Fmx::Graphics::TFillTextFlags Flags, const Fmx::Types::TTextAlign ATextAlign, const Fmx::Types::TTextAlign AVTextAlign);
	virtual void __fastcall MeasureText(System::Types::TRectF &ARect, const System::UnicodeString AText, const bool WordWrap, const Fmx::Graphics::TFillTextFlags Flags, const Fmx::Types::TTextAlign ATextAlign, const Fmx::Types::TTextAlign AVTextAlign);
protected:
	/* TCanvas.CreateFromWindow */ inline __fastcall virtual TfrxFastCanvas(Fmx::Types::TWindowHandle* const AParent, const int AWidth, const int AHeight, const Fmx::Graphics::TCanvasQuality AQuality) : TfrxFastCanvasLayer(AParent, AWidth, AHeight, AQuality) { }
	/* TCanvas.CreateFromBitmap */ inline __fastcall virtual TfrxFastCanvas(Fmx::Graphics::TBitmap* const ABitmap, const Fmx::Graphics::TCanvasQuality AQuality) : TfrxFastCanvasLayer(ABitmap, AQuality) { }
	/* TCanvas.CreateFromPrinter */ inline __fastcall virtual TfrxFastCanvas(Fmx::Graphics::TAbstractPrinter* const APrinter) : TfrxFastCanvasLayer(APrinter) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Uitypes::TPrinterOrientation poPortrait = (System::Uitypes::TPrinterOrientation)(0);
static const System::Uitypes::TPrinterOrientation poLandscape = (System::Uitypes::TPrinterOrientation)(1);
static const System::Uitypes::TFontStyle fsBold = (System::Uitypes::TFontStyle)(0);
static const System::Uitypes::TFontStyle fsItalic = (System::Uitypes::TFontStyle)(1);
static const System::Uitypes::TFontStyle fsUnderline = (System::Uitypes::TFontStyle)(2);
static const System::Uitypes::TFontStyle fsStrikeout = (System::Uitypes::TFontStyle)(3);
static const System::Uitypes::TMouseButton mbLeft = (System::Uitypes::TMouseButton)(0);
static const System::Uitypes::TMouseButton mbRight = (System::Uitypes::TMouseButton)(1);
static const Fmx::Types::TAlignLayout alLeft = (Fmx::Types::TAlignLayout)(2);
static const Fmx::Types::TAlignLayout alClient = (Fmx::Types::TAlignLayout)(9);
static const Fmx::Types::TTextAlign taCenter = (Fmx::Types::TTextAlign)(0);
static const System::Uitypes::TWindowState wsMaximized = (System::Uitypes::TWindowState)(2);
#define DefFontName u"Arial"
static const System::Int8 DefFontSize = System::Int8(0xa);
extern DELPHI_PACKAGE void __fastcall ShellExecute(System::UnicodeString fName);
extern DELPHI_PACKAGE int __fastcall frxCompareText(System::UnicodeString s1, System::UnicodeString s2);
extern DELPHI_PACKAGE System::Math::Vectors::TMatrix __fastcall CreateScaleMatrix(const float ScaleX, const float ScaleY);
extern DELPHI_PACKAGE System::Math::Vectors::TMatrix __fastcall CreateTranslateMatrix(const float DX, const float DY);
extern DELPHI_PACKAGE System::Math::Vectors::TMatrix __fastcall CreateRotationMatrix(const float Angle);
extern DELPHI_PACKAGE System::Math::Vectors::TMatrix __fastcall MatrixMultiply(const System::Math::Vectors::TMatrix &M1, const System::Math::Vectors::TMatrix &M2);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetLongHint(const System::UnicodeString Hint);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetShortHint(const System::UnicodeString Hint);
extern DELPHI_PACKAGE void __fastcall SetClipboard(const System::UnicodeString Value);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetClipboard(void);
extern DELPHI_PACKAGE void __fastcall FillFontsList(System::Classes::TStrings* List);
extern DELPHI_PACKAGE Fmx::Forms::TCommonCustomForm* __fastcall GetComponentForm(Fmx::Types::TFmxObject* Comp);
}	/* namespace Frxfmx */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXFMX)
using namespace Fmx::Frxfmx;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxfmxHPP
