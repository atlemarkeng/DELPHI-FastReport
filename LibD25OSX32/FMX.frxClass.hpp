// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxClass.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxclassHPP
#define Fmx_FrxclassHPP

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
#include <System.WideStrings.hpp>
#include <System.Types.hpp>
#include <System.SyncObjs.hpp>
#include <System.IniFiles.hpp>
#include <System.Variants.hpp>
#include <FMX.Platform.hpp>
#include <FMX.Types.hpp>
#include <FMX.Printer.hpp>
#include <FMX.Forms.hpp>
#include <System.StrUtils.hpp>
#include <System.UIConsts.hpp>
#include <FMX.frxVariables.hpp>
#include <FMX.frxXML.hpp>
#include <FMX.frxProgress.hpp>
#include <FMX.fs_iinterpreter.hpp>
#include <FMX.frxUnicodeUtils.hpp>
#include <FMX.frxFMX.hpp>
#include <FMX.frxBaseModalForm.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Graphics.hpp>
#include <System.Math.Vectors.hpp>
#include <FMX.ActnList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxclass
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EDuplicateName;
class DELPHICLASS EExportTerminated;
struct TfrxRect;
struct TfrxPoint;
class DELPHICLASS TfrxComponent;
class DELPHICLASS TfrxReportComponent;
class DELPHICLASS TfrxDialogComponent;
class DELPHICLASS TfrxDialogControl;
class DELPHICLASS TfrxDataSet;
class DELPHICLASS TfrxUserDataSet;
class DELPHICLASS TfrxCustomDBDataSet;
class DELPHICLASS TfrxDBComponents;
class DELPHICLASS TfrxCustomDatabase;
class DELPHICLASS TfrxFrameLine;
class DELPHICLASS TfrxFrame;
class DELPHICLASS TfrxView;
class DELPHICLASS TfrxStretcheable;
class DELPHICLASS TfrxHighlight;
class DELPHICLASS TfrxFormat;
class DELPHICLASS TfrxCustomMemoView;
class DELPHICLASS TfrxMemoView;
class DELPHICLASS TfrxSysMemoView;
class DELPHICLASS TfrxCustomLineView;
class DELPHICLASS TfrxLineView;
class DELPHICLASS TfrxPictureView;
class DELPHICLASS TfrxShapeView;
class DELPHICLASS TfrxSubreport;
class DELPHICLASS TfrxBand;
class DELPHICLASS TfrxDataBand;
class DELPHICLASS TfrxHeader;
class DELPHICLASS TfrxFooter;
class DELPHICLASS TfrxMasterData;
class DELPHICLASS TfrxDetailData;
class DELPHICLASS TfrxSubdetailData;
class DELPHICLASS TfrxDataBand4;
class DELPHICLASS TfrxDataBand5;
class DELPHICLASS TfrxDataBand6;
class DELPHICLASS TfrxPageHeader;
class DELPHICLASS TfrxPageFooter;
class DELPHICLASS TfrxColumnHeader;
class DELPHICLASS TfrxColumnFooter;
class DELPHICLASS TfrxGroupHeader;
class DELPHICLASS TfrxGroupFooter;
class DELPHICLASS TfrxReportTitle;
class DELPHICLASS TfrxReportSummary;
class DELPHICLASS TfrxChild;
class DELPHICLASS TfrxOverlay;
class DELPHICLASS TfrxNullBand;
class DELPHICLASS TfrxPage;
class DELPHICLASS TfrxReportPage;
class DELPHICLASS TfrxDialogPage;
class DELPHICLASS TfrxDataPage;
class DELPHICLASS TfrxEngineOptions;
class DELPHICLASS TfrxPrintOptions;
class DELPHICLASS TfrxPreviewOptions;
class DELPHICLASS TfrxReportOptions;
class DELPHICLASS TfrxExpressionCache;
class DELPHICLASS TfrxDataSetItem;
class DELPHICLASS TfrxReportDataSets;
class DELPHICLASS TfrxStyleItem;
class DELPHICLASS TfrxStyles;
class DELPHICLASS TfrxStyleSheet;
class DELPHICLASS TfrxReport;
class DELPHICLASS TfrxCustomDesigner;
class DELPHICLASS TfrxCustomExportFilter;
class DELPHICLASS TfrxCustomWizard;
class DELPHICLASS TfrxCustomEngine;
class DELPHICLASS TfrxCustomOutline;
class DELPHICLASS TfrxCustomPreviewPages;
class DELPHICLASS TfrxCustomPreview;
class DELPHICLASS TfrxCustomCompressor;
class DELPHICLASS TfrxCustomCrypter;
class DELPHICLASS TfrxConverterEvents;
class DELPHICLASS TfrxGlobalDataSetList;
//-- type declarations -------------------------------------------------------
typedef System::UnicodeString TfrxNotifyEvent;

typedef System::UnicodeString TfrxCloseQueryEvent;

typedef System::UnicodeString TfrxKeyEvent;

typedef System::UnicodeString TfrxKeyPressEvent;

typedef System::UnicodeString TfrxMouseEvent;

typedef System::UnicodeString TfrxMouseMoveEvent;

typedef System::UnicodeString TfrxPreviewClickEvent;

typedef System::UnicodeString TfrxRunDialogsEvent;

#pragma pack(push,4)
class PASCALIMPLEMENTATION EDuplicateName : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EDuplicateName(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EDuplicateName(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EDuplicateName(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EDuplicateName(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EDuplicateName(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EDuplicateName(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EDuplicateName(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EDuplicateName(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EDuplicateName(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EDuplicateName(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EDuplicateName(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EDuplicateName(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EDuplicateName(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION EExportTerminated : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	/* TObject.Create */ inline __fastcall EExportTerminated(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~EExportTerminated(void) { }
	
};

#pragma pack(pop)

typedef int SYSINT;

enum DECLSPEC_DENUM Fmx_Frxclass__3 : unsigned char { csContainer, csPreviewVisible, csDefaultDiff };

typedef System::Set<Fmx_Frxclass__3, Fmx_Frxclass__3::csContainer, Fmx_Frxclass__3::csDefaultDiff> TfrxComponentStyle;

enum DECLSPEC_DENUM TfrxStretchMode : unsigned char { smDontStretch, smActualHeight, smMaxHeight };

enum DECLSPEC_DENUM TfrxShiftMode : unsigned char { smDontShift, smAlways, smWhenOverlapped };

enum DECLSPEC_DENUM TfrxDuplexMode : unsigned char { dmNone, dmVertical, dmHorizontal, dmSimplex };

enum DECLSPEC_DENUM TfrxAlign : unsigned char { baNone, baLeft, baRight, baCenter, baWidth, baBottom, baClient };

enum DECLSPEC_DENUM TfrxFrameStyle : unsigned char { fsSolid, fsDash, fsDot, fsDashDot, fsDashDotDot, fsDouble, fsAltDot, fsSquare };

enum DECLSPEC_DENUM TfrxFrameType : unsigned char { ftLeft, ftRight, ftTop, ftBottom };

typedef System::Set<TfrxFrameType, TfrxFrameType::ftLeft, TfrxFrameType::ftBottom> TfrxFrameTypes;

enum DECLSPEC_DENUM TfrxFormatKind : unsigned char { fkText, fkNumeric, fkDateTime, fkBoolean };

enum DECLSPEC_DENUM TfrxHAlign : unsigned char { haLeft, haRight, haCenter, haBlock };

enum DECLSPEC_DENUM TfrxVAlign : unsigned char { vaTop, vaBottom, vaCenter };

enum DECLSPEC_DENUM TfrxSilentMode : unsigned char { simMessageBoxes, simSilent, simReThrow };

enum DECLSPEC_DENUM TfrxRestriction : unsigned char { rfDontModify, rfDontSize, rfDontMove, rfDontDelete, rfDontEdit };

typedef System::Set<TfrxRestriction, TfrxRestriction::rfDontModify, TfrxRestriction::rfDontEdit> TfrxRestrictions;

enum DECLSPEC_DENUM TfrxShapeKind : unsigned char { skRectangle, skRoundRectangle, skEllipse, skTriangle, skDiamond, skDiagonal1, skDiagonal2 };

enum DECLSPEC_DENUM TfrxPreviewButton : unsigned char { pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFullScreen, pbOutline, pbThumbnails, pbPageSetup, pbEdit, pbNavigator, pbClose };

typedef System::Set<TfrxPreviewButton, TfrxPreviewButton::pbPrint, TfrxPreviewButton::pbClose> TfrxPreviewButtons;

enum DECLSPEC_DENUM TfrxZoomMode : unsigned char { zmDefault, zmWholePage, zmPageWidth, zmManyPages };

enum DECLSPEC_DENUM TfrxPrintPages : unsigned char { ppAll, ppOdd, ppEven };

enum DECLSPEC_DENUM TfrxAddPageAction : unsigned char { apWriteOver, apAdd };

enum DECLSPEC_DENUM TfrxRangeBegin : unsigned char { rbFirst, rbCurrent };

enum DECLSPEC_DENUM TfrxRangeEnd : unsigned char { reLast, reCurrent, reCount };

enum DECLSPEC_DENUM TfrxFieldType : unsigned char { fftNumeric, fftString, fftBoolean };

enum DECLSPEC_DENUM TfrxProgressType : unsigned char { ptRunning, ptExporting, ptPrinting };

enum DECLSPEC_DENUM TfrxPrintMode : unsigned char { pmDefault, pmSplit, pmJoin, pmScale };

enum DECLSPEC_DENUM TfrxInheriteMode : unsigned char { imDefault, imDelete, imRename };

typedef NativeInt frxInteger;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TfrxRect
{
public:
	double Left;
	double Top;
	double Right;
	double Bottom;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD TfrxPoint
{
public:
	double X;
	double Y;
};
#pragma pack(pop)


typedef void __fastcall (__closure *TfrxProgressEvent)(TfrxReport* Sender, TfrxProgressType ProgressType, int Progress);

typedef void __fastcall (__closure *TfrxBeforePrintEvent)(TfrxReportComponent* Sender);

typedef void __fastcall (__closure *TfrxGetValueEvent)(const System::UnicodeString VarName, System::Variant &Value);

typedef void __fastcall (__closure *TfrxNewGetValueEvent)(System::TObject* Sender, const System::UnicodeString VarName, System::Variant &Value);

typedef System::Variant __fastcall (__closure *TfrxUserFunctionEvent)(const System::UnicodeString MethodName, System::Variant &Params);

typedef void __fastcall (__closure *TfrxManualBuildEvent)(TfrxPage* Page);

typedef void __fastcall (__closure *TfrxClickObjectEvent)(TfrxView* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, bool &Modified);

typedef void __fastcall (__closure *TfrxMouseOverObjectEvent)(TfrxView* Sender);

typedef void __fastcall (__closure *TfrxCheckEOFEvent)(System::TObject* Sender, bool &Eof);

typedef void __fastcall (__closure *TfrxRunDialogEvent)(TfrxDialogPage* Page);

typedef System::UnicodeString __fastcall (__closure *TfrxEditConnectionEvent)(const System::UnicodeString ConnString);

typedef void __fastcall (__closure *TfrxSetConnectionEvent)(const System::UnicodeString ConnString);

typedef void __fastcall (__closure *TfrxBeforeConnectEvent)(TfrxCustomDatabase* Sender, bool &Connected);

typedef void __fastcall (__closure *TfrxAfterDisconnectEvent)(TfrxCustomDatabase* Sender);

typedef void __fastcall (__closure *TfrxPrintPageEvent)(TfrxReportPage* Page, int CopyNo);

typedef void __fastcall (__closure *TfrxLoadTemplateEvent)(TfrxReport* Report, const System::UnicodeString TemplateName);

class PASCALIMPLEMENTATION TfrxComponent : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Fmx::Frxfmx::TfrxFont* FFont;
	System::Classes::TList* FObjects;
	System::Classes::TList* FAllObjects;
	TfrxComponent* FParent;
	double FLeft;
	double FTop;
	double FWidth;
	double FHeight;
	bool FParentFont;
	int FGroupIndex;
	bool FIsDesigning;
	bool FIsLoading;
	bool FIsPrinting;
	bool FIsWriting;
	TfrxRestrictions FRestrictions;
	bool FVisible;
	System::UnicodeString FDescription;
	bool FAncestor;
	TfrxComponentStyle FComponentStyle;
	double __fastcall GetAbsTop(void);
	TfrxPage* __fastcall GetPage(void);
	TfrxReport* __fastcall GetReport(void);
	bool __fastcall IsFontStored(void);
	System::Classes::TList* __fastcall GetAllObjects(void);
	double __fastcall GetAbsLeft(void);
	bool __fastcall GetIsLoading(void);
	bool __fastcall GetIsAncestor(void);
	
protected:
	System::UnicodeString FAliasName;
	System::UnicodeString FBaseName;
	TfrxComponent* FOriginalComponent;
	TfrxRect FOriginalRect;
	TfrxComponent* FOriginalBand;
	virtual void __fastcall SetParent(TfrxComponent* AParent);
	virtual void __fastcall SetLeft(double Value);
	virtual void __fastcall SetTop(double Value);
	virtual void __fastcall SetWidth(double Value);
	virtual void __fastcall SetHeight(double Value);
	virtual void __fastcall SetName(const System::Classes::TComponentName AName);
	virtual void __fastcall SetFont(Fmx::Frxfmx::TfrxFont* Value);
	virtual void __fastcall SetParentFont(const bool Value);
	virtual void __fastcall SetVisible(bool Value);
	virtual void __fastcall FontChanged(System::TObject* Sender);
	System::UnicodeString __fastcall DiffFont(Fmx::Frxfmx::TfrxFont* f1, Fmx::Frxfmx::TfrxFont* f2, const System::UnicodeString Add);
	System::UnicodeString __fastcall InternalDiff(TfrxComponent* AComponent);
	virtual System::Classes::TList* __fastcall GetContainerObjects(void);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner(void);
	
public:
	__fastcall virtual TfrxComponent(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxComponent(System::Classes::TComponent* AOwner, System::Word Flags);
	__fastcall virtual ~TfrxComponent(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall AlignChildren(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall AssignAll(TfrxComponent* Source, bool Streaming = false);
	virtual void __fastcall AddSourceObjects(void);
	virtual void __fastcall BeforeStartReport(void);
	virtual void __fastcall Clear(void);
	void __fastcall CreateUniqueName(void);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream, bool SaveChildren = true, bool SaveDefaultValues = false, bool Streaming = false);
	void __fastcall SetBounds(double ALeft, double ATop, double AWidth, double AHeight);
	virtual void __fastcall OnNotify(System::TObject* Sender);
	virtual void __fastcall OnPaste(void);
	System::UnicodeString __fastcall AllDiff(TfrxComponent* AComponent);
	virtual System::UnicodeString __fastcall Diff(TfrxComponent* AComponent);
	TfrxComponent* __fastcall FindObject(const System::UnicodeString AName);
	virtual bool __fastcall ContainerAdd(TfrxComponent* Obj);
	virtual bool __fastcall ContainerMouseDown(System::TObject* Sender, int X, int Y);
	virtual void __fastcall ContainerMouseMove(System::TObject* Sender, int X, int Y);
	virtual void __fastcall ContainerMouseUp(System::TObject* Sender, int X, int Y);
	TfrxDataSet* __fastcall FindDataSet(TfrxDataSet* DataSet, const System::UnicodeString DSName);
	__property System::Classes::TList* Objects = {read=FObjects};
	__property System::Classes::TList* AllObjects = {read=GetAllObjects};
	__property System::Classes::TList* ContainerObjects = {read=GetContainerObjects};
	__property TfrxComponent* Parent = {read=FParent, write=SetParent};
	__property TfrxPage* Page = {read=GetPage};
	__property TfrxReport* Report = {read=GetReport};
	__property bool IsAncestor = {read=GetIsAncestor, nodefault};
	__property bool IsDesigning = {read=FIsDesigning, write=FIsDesigning, nodefault};
	__property bool IsLoading = {read=GetIsLoading, write=FIsLoading, nodefault};
	__property bool IsPrinting = {read=FIsPrinting, write=FIsPrinting, nodefault};
	__property bool IsWriting = {read=FIsWriting, write=FIsWriting, nodefault};
	__property System::UnicodeString BaseName = {read=FBaseName};
	__property int GroupIndex = {read=FGroupIndex, write=FGroupIndex, default=0};
	__property TfrxComponentStyle frComponentStyle = {read=FComponentStyle, write=FComponentStyle, nodefault};
	__property double Left = {read=FLeft, write=SetLeft};
	__property double Top = {read=FTop, write=SetTop};
	__property double Width = {read=FWidth, write=SetWidth};
	__property double Height = {read=FHeight, write=SetHeight};
	__property double AbsLeft = {read=GetAbsLeft};
	__property double AbsTop = {read=GetAbsTop};
	__property System::UnicodeString Description = {read=FDescription, write=FDescription};
	__property bool ParentFont = {read=FParentFont, write=SetParentFont, default=1};
	__property TfrxRestrictions Restrictions = {read=FRestrictions, write=FRestrictions, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Fmx::Frxfmx::TfrxFont* Font = {read=FFont, write=SetFont, stored=IsFontStored};
};


class PASCALIMPLEMENTATION TfrxReportComponent : public TfrxComponent
{
	typedef TfrxComponent inherited;
	
private:
	TfrxNotifyEvent FOnAfterData;
	TfrxNotifyEvent FOnAfterPrint;
	TfrxNotifyEvent FOnBeforePrint;
	TfrxPreviewClickEvent FOnPreviewClick;
	TfrxPreviewClickEvent FOnPreviewDblClick;
	
public:
	double FShiftAmount;
	System::Classes::TList* FShiftChildren;
	__fastcall virtual TfrxReportComponent(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxReportComponent(void);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY) = 0 ;
	virtual void __fastcall BeforePrint(void);
	virtual void __fastcall GetData(void);
	virtual void __fastcall AfterPrint(void);
	virtual System::UnicodeString __fastcall GetComponentText(void);
	virtual TfrxRect __fastcall GetRealBounds(void);
	__property TfrxNotifyEvent OnAfterData = {read=FOnAfterData, write=FOnAfterData};
	__property TfrxNotifyEvent OnAfterPrint = {read=FOnAfterPrint, write=FOnAfterPrint};
	__property TfrxNotifyEvent OnBeforePrint = {read=FOnBeforePrint, write=FOnBeforePrint};
	__property TfrxPreviewClickEvent OnPreviewClick = {read=FOnPreviewClick, write=FOnPreviewClick};
	__property TfrxPreviewClickEvent OnPreviewDblClick = {read=FOnPreviewDblClick, write=FOnPreviewDblClick};
	
__published:
	__property Description = {default=0};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxReportComponent(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxComponent(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDialogComponent : public TfrxReportComponent
{
	typedef TfrxReportComponent inherited;
	
private:
	System::Classes::TComponent* FComponent;
	Fmx::Graphics::TBitmap* FImage;
	bool FImageIsLoaded;
	HIDESBASE void __fastcall ReadLeft(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall ReadTop(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall WriteLeft(System::Classes::TWriter* Writer);
	HIDESBASE void __fastcall WriteTop(System::Classes::TWriter* Writer);
	
protected:
	int FImageIndex;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TfrxDialogComponent(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxDialogComponent(void);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	__property System::Classes::TComponent* Component = {read=FComponent, write=FComponent};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDialogComponent(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxReportComponent(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDialogControl : public TfrxReportComponent
{
	typedef TfrxReportComponent inherited;
	
private:
	Fmx::Controls::TControl* FControl;
	TfrxNotifyEvent FOnClick;
	TfrxNotifyEvent FOnDblClick;
	TfrxNotifyEvent FOnEnter;
	TfrxNotifyEvent FOnExit;
	TfrxKeyEvent FOnKeyDown;
	TfrxKeyPressEvent FOnKeyPress;
	TfrxKeyEvent FOnKeyUp;
	TfrxMouseEvent FOnMouseDown;
	TfrxMouseMoveEvent FOnMouseMove;
	TfrxMouseEvent FOnMouseUp;
	System::Classes::TNotifyEvent FOnActivate;
	bool __fastcall GetEnabled(void);
	void __fastcall DoOnClick(System::TObject* Sender);
	void __fastcall DoOnDblClick(System::TObject* Sender);
	void __fastcall DoOnEnter(System::TObject* Sender);
	void __fastcall DoOnExit(System::TObject* Sender);
	void __fastcall DoOnKeyDown(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall DoOnKeyUp(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall DoOnMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall DoOnMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall DoOnMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall SetEnabled(const bool Value);
	System::UnicodeString __fastcall GetCaption(void);
	void __fastcall SetCaption(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetHint(void);
	void __fastcall SetHint(const System::UnicodeString Value);
	bool __fastcall GetShowHint(void);
	void __fastcall SetShowHint(const bool Value);
	bool __fastcall GetTabStop(void);
	void __fastcall SetTabStop(const bool Value);
	
protected:
	virtual void __fastcall SetLeft(double Value);
	virtual void __fastcall SetTop(double Value);
	virtual void __fastcall SetWidth(double Value);
	virtual void __fastcall SetHeight(double Value);
	virtual void __fastcall SetParentFont(const bool Value);
	virtual void __fastcall SetVisible(bool Value);
	virtual void __fastcall SetParent(TfrxComponent* AParent);
	virtual void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall InitControl(Fmx::Controls::TControl* AControl);
	
public:
	__fastcall virtual TfrxDialogControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxDialogControl(void);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	__property System::UnicodeString Caption = {read=GetCaption, write=SetCaption};
	__property Fmx::Controls::TControl* Control = {read=FControl, write=FControl};
	__property bool TabStop = {read=GetTabStop, write=SetTabStop, default=1};
	__property TfrxNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property TfrxNotifyEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property TfrxNotifyEvent OnEnter = {read=FOnEnter, write=FOnEnter};
	__property TfrxNotifyEvent OnExit = {read=FOnExit, write=FOnExit};
	__property TfrxKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
	__property TfrxKeyPressEvent OnKeyPress = {read=FOnKeyPress, write=FOnKeyPress};
	__property TfrxKeyEvent OnKeyUp = {read=FOnKeyUp, write=FOnKeyUp};
	__property TfrxMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property TfrxMouseMoveEvent OnMouseMove = {read=FOnMouseMove, write=FOnMouseMove};
	__property TfrxMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
	__property System::Classes::TNotifyEvent OnActivate = {read=FOnActivate, write=FOnActivate};
	
__published:
	__property Left = {default=0};
	__property Top = {default=0};
	__property Width = {default=0};
	__property Height = {default=0};
	__property Font;
	__property GroupIndex = {default=0};
	__property ParentFont = {default=1};
	__property bool Enabled = {read=GetEnabled, write=SetEnabled, default=1};
	__property System::UnicodeString Hint = {read=GetHint, write=SetHint};
	__property bool ShowHint = {read=GetShowHint, write=SetShowHint, nodefault};
	__property Visible = {default=1};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDialogControl(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxReportComponent(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDataSet : public TfrxDialogComponent
{
	typedef TfrxDialogComponent inherited;
	
private:
	bool FCloseDataSource;
	bool FEnabled;
	bool FEof;
	bool FOpenDataSource;
	TfrxRangeBegin FRangeBegin;
	TfrxRangeEnd FRangeEnd;
	int FRangeEndCount;
	TfrxReport* FReportRef;
	System::UnicodeString FUserName;
	TfrxCheckEOFEvent FOnCheckEOF;
	System::Classes::TNotifyEvent FOnFirst;
	System::Classes::TNotifyEvent FOnNext;
	System::Classes::TNotifyEvent FOnPrior;
	System::Classes::TNotifyEvent FOnOpen;
	System::Classes::TNotifyEvent FOnClose;
	
protected:
	bool FInitialized;
	int FRecNo;
	virtual System::WideString __fastcall GetDisplayText(System::UnicodeString Index);
	virtual int __fastcall GetDisplayWidth(System::UnicodeString Index);
	virtual TfrxFieldType __fastcall GetFieldType(System::UnicodeString Index);
	virtual System::Variant __fastcall GetValue(System::UnicodeString Index);
	virtual void __fastcall SetName(const System::Classes::TComponentName NewName);
	virtual void __fastcall SetUserName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TfrxDataSet(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxDataSet(void);
	virtual void __fastcall Initialize(void);
	virtual void __fastcall Finalize(void);
	virtual void __fastcall Open(void);
	virtual void __fastcall Close(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual void __fastcall Prior(void);
	virtual bool __fastcall Eof(void);
	virtual int __fastcall FieldsCount(void);
	bool __fastcall HasField(const System::UnicodeString fName);
	virtual bool __fastcall IsBlobField(const System::UnicodeString fName);
	virtual int __fastcall RecordCount(void);
	virtual void __fastcall AssignBlobTo(const System::UnicodeString fName, System::TObject* Obj);
	virtual void __fastcall GetFieldList(System::Classes::TStrings* List);
	__property System::WideString DisplayText[System::UnicodeString Index] = {read=GetDisplayText};
	__property int DisplayWidth[System::UnicodeString Index] = {read=GetDisplayWidth};
	__property TfrxFieldType FieldType[System::UnicodeString Index] = {read=GetFieldType};
	__property System::Variant Value[System::UnicodeString Index] = {read=GetValue};
	__property bool CloseDataSource = {read=FCloseDataSource, write=FCloseDataSource, nodefault};
	__property bool OpenDataSource = {read=FOpenDataSource, write=FOpenDataSource, default=1};
	__property int RecNo = {read=FRecNo, nodefault};
	__property TfrxReport* ReportRef = {read=FReportRef, write=FReportRef};
	__property System::Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property System::Classes::TNotifyEvent OnOpen = {read=FOnOpen, write=FOnOpen};
	
__published:
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property TfrxRangeBegin RangeBegin = {read=FRangeBegin, write=FRangeBegin, default=0};
	__property TfrxRangeEnd RangeEnd = {read=FRangeEnd, write=FRangeEnd, default=0};
	__property int RangeEndCount = {read=FRangeEndCount, write=FRangeEndCount, default=0};
	__property System::UnicodeString UserName = {read=FUserName, write=SetUserName};
	__property TfrxCheckEOFEvent OnCheckEOF = {read=FOnCheckEOF, write=FOnCheckEOF};
	__property System::Classes::TNotifyEvent OnFirst = {read=FOnFirst, write=FOnFirst};
	__property System::Classes::TNotifyEvent OnNext = {read=FOnNext, write=FOnNext};
	__property System::Classes::TNotifyEvent OnPrior = {read=FOnPrior, write=FOnPrior};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDataSet(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxDialogComponent(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxUserDataSet : public TfrxDataSet
{
	typedef TfrxDataSet inherited;
	
private:
	System::Classes::TStrings* FFields;
	TfrxGetValueEvent FOnGetValue;
	TfrxNewGetValueEvent FOnNewGetValue;
	void __fastcall SetFields(System::Classes::TStrings* const Value);
	
protected:
	virtual System::WideString __fastcall GetDisplayText(System::UnicodeString Index);
	virtual System::Variant __fastcall GetValue(System::UnicodeString Index);
	
public:
	__fastcall virtual TfrxUserDataSet(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxUserDataSet(void);
	virtual int __fastcall FieldsCount(void);
	virtual void __fastcall GetFieldList(System::Classes::TStrings* List);
	
__published:
	__property System::Classes::TStrings* Fields = {read=FFields, write=SetFields};
	__property TfrxGetValueEvent OnGetValue = {read=FOnGetValue, write=FOnGetValue};
	__property TfrxNewGetValueEvent OnNewGetValue = {read=FOnNewGetValue, write=FOnNewGetValue};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxUserDataSet(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxDataSet(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxCustomDBDataSet : public TfrxDataSet
{
	typedef TfrxDataSet inherited;
	
private:
	System::Classes::TStrings* FAliases;
	System::Classes::TStringList* FFields;
	void __fastcall SetFieldAliases(System::Classes::TStrings* const Value);
	
protected:
	__property System::Classes::TStringList* Fields = {read=FFields};
	
public:
	__fastcall virtual TfrxCustomDBDataSet(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxCustomDBDataSet(void);
	System::UnicodeString __fastcall ConvertAlias(const System::UnicodeString fName);
	System::UnicodeString __fastcall GetAlias(const System::UnicodeString fName);
	virtual int __fastcall FieldsCount(void);
	
__published:
	__property CloseDataSource;
	__property System::Classes::TStrings* FieldAliases = {read=FAliases, write=SetFieldAliases};
	__property OpenDataSource = {default=1};
	__property OnClose;
	__property OnOpen;
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCustomDBDataSet(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxDataSet(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDBComponents : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	virtual System::UnicodeString __fastcall GetDescription(void);
public:
	/* TComponent.Create */ inline __fastcall virtual TfrxDBComponents(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxDBComponents(void) { }
	
};


class PASCALIMPLEMENTATION TfrxCustomDatabase : public TfrxDialogComponent
{
	typedef TfrxDialogComponent inherited;
	
protected:
	void __fastcall BeforeConnect(bool &Value);
	void __fastcall AfterDisconnect(void);
	virtual void __fastcall SetConnected(bool Value);
	virtual void __fastcall SetDatabaseName(const System::UnicodeString Value);
	virtual void __fastcall SetLoginPrompt(bool Value);
	virtual void __fastcall SetParams(System::Classes::TStrings* Value);
	virtual bool __fastcall GetConnected(void);
	virtual System::UnicodeString __fastcall GetDatabaseName(void);
	virtual bool __fastcall GetLoginPrompt(void);
	virtual System::Classes::TStrings* __fastcall GetParams(void);
	
public:
	HIDESBASE virtual System::WideString __fastcall ToString(void);
	virtual void __fastcall FromString(const System::WideString Connection);
	virtual void __fastcall SetLogin(const System::UnicodeString Login, const System::UnicodeString Password);
	__property bool Connected = {read=GetConnected, write=SetConnected, default=0};
	__property System::UnicodeString DatabaseName = {read=GetDatabaseName, write=SetDatabaseName};
	__property bool LoginPrompt = {read=GetLoginPrompt, write=SetLoginPrompt, default=1};
	__property System::Classes::TStrings* Params = {read=GetParams, write=SetParams};
public:
	/* TfrxDialogComponent.Create */ inline __fastcall virtual TfrxCustomDatabase(System::Classes::TComponent* AOwner) : TfrxDialogComponent(AOwner) { }
	/* TfrxDialogComponent.Destroy */ inline __fastcall virtual ~TfrxCustomDatabase(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCustomDatabase(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxDialogComponent(AOwner, Flags) { }
	
};


typedef System::TMetaClass* TfrxComponentClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxFrameLine : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TfrxFrame* FFrame;
	System::Uitypes::TAlphaColor FColor;
	TfrxFrameStyle FStyle;
	double FWidth;
	bool __fastcall IsColorStored(void);
	bool __fastcall IsStyleStored(void);
	bool __fastcall IsWidthStored(void);
	
public:
	__fastcall TfrxFrameLine(TfrxFrame* AFrame);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::UnicodeString __fastcall Diff(TfrxFrameLine* ALine, const System::UnicodeString LineName, bool ColorChanged, bool StyleChanged, bool WidthChanged);
	
__published:
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=FColor, stored=IsColorStored, nodefault};
	__property TfrxFrameStyle Style = {read=FStyle, write=FStyle, stored=IsStyleStored, nodefault};
	__property double Width = {read=FWidth, write=FWidth, stored=IsWidthStored};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxFrameLine(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxFrame : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TfrxFrameLine* FLeftLine;
	TfrxFrameLine* FTopLine;
	TfrxFrameLine* FRightLine;
	TfrxFrameLine* FBottomLine;
	System::Uitypes::TAlphaColor FColor;
	bool FDropShadow;
	double FShadowWidth;
	System::Uitypes::TAlphaColor FShadowColor;
	TfrxFrameStyle FStyle;
	TfrxFrameTypes FTyp;
	double FWidth;
	bool __fastcall IsShadowWidthStored(void);
	bool __fastcall IsTypStored(void);
	bool __fastcall IsWidthStored(void);
	void __fastcall SetBottomLine(TfrxFrameLine* const Value);
	void __fastcall SetLeftLine(TfrxFrameLine* const Value);
	void __fastcall SetRightLine(TfrxFrameLine* const Value);
	void __fastcall SetTopLine(TfrxFrameLine* const Value);
	void __fastcall SetColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetStyle(const TfrxFrameStyle Value);
	void __fastcall SetWidth(const double Value);
	
public:
	__fastcall TfrxFrame(void);
	__fastcall virtual ~TfrxFrame(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::UnicodeString __fastcall Diff(TfrxFrame* AFrame);
	
__published:
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=SetColor, default=-16777216};
	__property bool DropShadow = {read=FDropShadow, write=FDropShadow, default=0};
	__property System::Uitypes::TAlphaColor ShadowColor = {read=FShadowColor, write=FShadowColor, default=-16777216};
	__property double ShadowWidth = {read=FShadowWidth, write=FShadowWidth, stored=IsShadowWidthStored};
	__property TfrxFrameStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property TfrxFrameTypes Typ = {read=FTyp, write=FTyp, stored=IsTypStored, nodefault};
	__property double Width = {read=FWidth, write=SetWidth, stored=IsWidthStored};
	__property TfrxFrameLine* LeftLine = {read=FLeftLine, write=SetLeftLine};
	__property TfrxFrameLine* TopLine = {read=FTopLine, write=SetTopLine};
	__property TfrxFrameLine* RightLine = {read=FRightLine, write=SetRightLine};
	__property TfrxFrameLine* BottomLine = {read=FBottomLine, write=SetBottomLine};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxView : public TfrxReportComponent
{
	typedef TfrxReportComponent inherited;
	
private:
	TfrxAlign FAlign;
	System::Uitypes::TAlphaColor FColor;
	System::Uitypes::TCursor FCursor;
	System::UnicodeString FDataField;
	TfrxDataSet* FDataSet;
	System::UnicodeString FDataSetName;
	TfrxFrame* FFrame;
	bool FPrintable;
	TfrxShiftMode FShiftMode;
	System::UnicodeString FTagStr;
	System::UnicodeString FTempTag;
	System::UnicodeString FTempURL;
	System::UnicodeString FHint;
	bool FHintIsActive;
	bool FShowHint;
	System::UnicodeString FURL;
	bool FPlainText;
	Fmx::Graphics::TBrushKind FBrushStyle;
	void __fastcall SetFrame(TfrxFrame* const Value);
	void __fastcall SetDataSet(TfrxDataSet* const Value);
	void __fastcall SetDataSetName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetDataSetName(void);
	
protected:
	int FX;
	int FY;
	int FX1;
	int FY1;
	int FDX;
	int FDY;
	double FFrameWidth;
	double FScaleX;
	double FScaleY;
	double FOffsetX;
	double FOffsetY;
	Fmx::Graphics::TCanvas* FCanvas;
	Fmx::Graphics::TCanvas* FFastCanvas;
	virtual void __fastcall BeginDraw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall DrawBackground(void);
	virtual void __fastcall DrawFrame(void);
	void __fastcall ExpandVariables(System::UnicodeString &Expr);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TfrxView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxView(void);
	virtual System::UnicodeString __fastcall Diff(TfrxComponent* AComponent);
	bool __fastcall IsDataField(void);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall BeforePrint(void);
	virtual void __fastcall GetData(void);
	virtual void __fastcall AfterPrint(void);
	void __fastcall SetFastCanvas(Fmx::Graphics::TCanvas* aCanvas);
	virtual void __fastcall GetVisibleRect(System::Types::TRectF &aRect);
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=FColor, default=0};
	__property System::UnicodeString DataField = {read=FDataField, write=FDataField};
	__property TfrxDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property System::UnicodeString DataSetName = {read=GetDataSetName, write=SetDataSetName};
	__property TfrxFrame* Frame = {read=FFrame, write=SetFrame};
	__property bool PlainText = {read=FPlainText, write=FPlainText, nodefault};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=FCursor, default=0};
	__property System::UnicodeString TagStr = {read=FTagStr, write=FTagStr};
	__property System::UnicodeString URL = {read=FURL, write=FURL};
	__property bool HintIsActive = {read=FHintIsActive, write=FHintIsActive, nodefault};
	__property Fmx::Graphics::TBrushKind BrushStyle = {read=FBrushStyle, write=FBrushStyle, nodefault};
	
__published:
	__property TfrxAlign Align = {read=FAlign, write=FAlign, default=0};
	__property bool Printable = {read=FPrintable, write=FPrintable, default=1};
	__property TfrxShiftMode ShiftMode = {read=FShiftMode, write=FShiftMode, default=1};
	__property Left = {default=0};
	__property Top = {default=0};
	__property Width = {default=0};
	__property Height = {default=0};
	__property GroupIndex = {default=0};
	__property Restrictions = {default=0};
	__property Visible = {default=1};
	__property OnAfterData = {default=0};
	__property OnAfterPrint = {default=0};
	__property OnBeforePrint = {default=0};
	__property OnPreviewClick = {default=0};
	__property OnPreviewDblClick = {default=0};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property bool ShowHint = {read=FShowHint, write=FShowHint, nodefault};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxView(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxReportComponent(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxStretcheable : public TfrxView
{
	typedef TfrxView inherited;
	
private:
	TfrxStretchMode FStretchMode;
	
public:
	double FSaveHeight;
	double FSavedTop;
	__fastcall virtual TfrxStretcheable(System::Classes::TComponent* AOwner);
	virtual double __fastcall CalcHeight(void);
	virtual double __fastcall DrawPart(void);
	virtual void __fastcall InitPart(void);
	virtual bool __fastcall HasNextDataPart(void);
	
__published:
	__property TfrxStretchMode StretchMode = {read=FStretchMode, write=FStretchMode, default=0};
public:
	/* TfrxView.Destroy */ inline __fastcall virtual ~TfrxStretcheable(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxStretcheable(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxView(AOwner, Flags) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxHighlight : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FActive;
	System::Uitypes::TAlphaColor FColor;
	System::UnicodeString FCondition;
	Fmx::Frxfmx::TfrxFont* FFont;
	void __fastcall SetFont(Fmx::Frxfmx::TfrxFont* const Value);
	
public:
	__fastcall TfrxHighlight(void);
	__fastcall virtual ~TfrxHighlight(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool Active = {read=FActive, write=FActive, default=0};
	__property Fmx::Frxfmx::TfrxFont* Font = {read=FFont, write=SetFont};
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=FColor, default=0};
	__property System::UnicodeString Condition = {read=FCondition, write=FCondition};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxFormat : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString FDecimalSeparator;
	System::UnicodeString FThousandSeparator;
	System::UnicodeString FFormatStr;
	TfrxFormatKind FKind;
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString DecimalSeparator = {read=FDecimalSeparator, write=FDecimalSeparator};
	__property System::UnicodeString ThousandSeparator = {read=FThousandSeparator, write=FThousandSeparator};
	__property System::UnicodeString FormatStr = {read=FFormatStr, write=FFormatStr};
	__property TfrxFormatKind Kind = {read=FKind, write=FKind, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxFormat(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxFormat(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxCustomMemoView : public TfrxStretcheable
{
	typedef TfrxStretcheable inherited;
	
private:
	bool FAllowExpressions;
	bool FAllowHTMLTags;
	bool FAutoWidth;
	double FCharSpacing;
	bool FClipped;
	TfrxFormat* FDisplayFormat;
	System::UnicodeString FExpressionDelimiters;
	TfrxCustomMemoView* FFlowTo;
	bool FFirstParaBreak;
	double FGapX;
	double FGapY;
	TfrxHAlign FHAlign;
	bool FHideZeros;
	TfrxHighlight* FHighlight;
	bool FLastParaBreak;
	double FLineSpacing;
	System::Widestrings::TWideStrings* FMemo;
	double FParagraphGap;
	System::WideString FPartMemo;
	int FRotation;
	bool FRTLReading;
	System::UnicodeString FStyle;
	bool FSuppressRepeated;
	System::WideString FTempMemo;
	bool FUnderlines;
	TfrxVAlign FVAlign;
	System::Variant FValue;
	bool FWordBreak;
	bool FWordWrap;
	bool FWysiwyg;
	System::TObject* FTextRenderer;
	void __fastcall SetMemo(System::Widestrings::TWideStrings* const Value);
	void __fastcall SetRotation(int Value);
	void __fastcall SetText(const System::WideString Value);
	double __fastcall AdjustCalcHeight(void);
	double __fastcall AdjustCalcWidth(void);
	System::WideString __fastcall GetText(void);
	bool __fastcall IsExprDelimitersStored(void);
	bool __fastcall IsLineSpacingStored(void);
	bool __fastcall IsGapXStored(void);
	bool __fastcall IsGapYStored(void);
	bool __fastcall IsHighlightStored(void);
	bool __fastcall IsParagraphGapStored(void);
	void __fastcall SetHighlight(TfrxHighlight* const Value);
	void __fastcall SetDisplayFormat(TfrxFormat* const Value);
	void __fastcall SetStyle(const System::UnicodeString Value);
	bool __fastcall IsCharSpacingStored(void);
	void __fastcall SetAllowHTMLTags(const bool Value);
	
protected:
	System::Variant FLastValue;
	int FTotalPages;
	int FCopyNo;
	System::Types::TRectF FTextRect;
	double FPrintScale;
	System::WideString __fastcall CalcAndFormat(const System::WideString Expr);
	virtual void __fastcall BeginDraw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	bool __fastcall IsAdvancedRendererNeeded(void);
	
public:
	__fastcall virtual TfrxCustomMemoView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxCustomMemoView(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual System::UnicodeString __fastcall Diff(TfrxComponent* AComponent);
	virtual double __fastcall CalcHeight(void);
	virtual double __fastcall CalcWidth(void);
	virtual double __fastcall DrawPart(void);
	virtual System::UnicodeString __fastcall GetComponentText(void);
	System::WideString __fastcall FormatData(const System::Variant &Value, TfrxFormat* AFormat = (TfrxFormat*)(0x0));
	System::WideString __fastcall WrapText(bool WrapWords, float &aLineHeight, Fmx::Graphics::TBitmap* aBitmap = (Fmx::Graphics::TBitmap*)(0x0));
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall BeforePrint(void);
	virtual void __fastcall GetData(void);
	virtual void __fastcall AfterPrint(void);
	virtual void __fastcall InitPart(void);
	void __fastcall ApplyStyle(TfrxStyleItem* Style);
	void __fastcall ExtractMacros(void);
	void __fastcall ResetSuppress(void);
	__property System::WideString Text = {read=GetText, write=SetText};
	__property System::Variant Value = {read=FValue, write=FValue};
	__property System::Widestrings::TWideStrings* Lines = {read=FMemo, write=SetMemo};
	__property bool AllowExpressions = {read=FAllowExpressions, write=FAllowExpressions, default=1};
	__property bool AllowHTMLTags = {read=FAllowHTMLTags, write=SetAllowHTMLTags, default=0};
	__property bool AutoWidth = {read=FAutoWidth, write=FAutoWidth, default=0};
	__property double CharSpacing = {read=FCharSpacing, write=FCharSpacing, stored=IsCharSpacingStored};
	__property bool Clipped = {read=FClipped, write=FClipped, default=1};
	__property TfrxFormat* DisplayFormat = {read=FDisplayFormat, write=SetDisplayFormat};
	__property System::UnicodeString ExpressionDelimiters = {read=FExpressionDelimiters, write=FExpressionDelimiters, stored=IsExprDelimitersStored};
	__property TfrxCustomMemoView* FlowTo = {read=FFlowTo, write=FFlowTo};
	__property double GapX = {read=FGapX, write=FGapX, stored=IsGapXStored};
	__property double GapY = {read=FGapY, write=FGapY, stored=IsGapYStored};
	__property TfrxHAlign HAlign = {read=FHAlign, write=FHAlign, default=0};
	__property bool HideZeros = {read=FHideZeros, write=FHideZeros, default=0};
	__property TfrxHighlight* Highlight = {read=FHighlight, write=SetHighlight, stored=IsHighlightStored};
	__property double LineSpacing = {read=FLineSpacing, write=FLineSpacing, stored=IsLineSpacingStored};
	__property System::Widestrings::TWideStrings* Memo = {read=FMemo, write=SetMemo};
	__property double ParagraphGap = {read=FParagraphGap, write=FParagraphGap, stored=IsParagraphGapStored};
	__property int Rotation = {read=FRotation, write=SetRotation, default=0};
	__property bool RTLReading = {read=FRTLReading, write=FRTLReading, default=0};
	__property System::UnicodeString Style = {read=FStyle, write=SetStyle};
	__property bool SuppressRepeated = {read=FSuppressRepeated, write=FSuppressRepeated, default=0};
	__property bool Underlines = {read=FUnderlines, write=FUnderlines, default=0};
	__property bool WordBreak = {read=FWordBreak, write=FWordBreak, default=0};
	__property bool WordWrap = {read=FWordWrap, write=FWordWrap, default=1};
	__property bool Wysiwyg = {read=FWysiwyg, write=FWysiwyg, default=1};
	__property TfrxVAlign VAlign = {read=FVAlign, write=FVAlign, default=0};
	
__published:
	__property bool FirstParaBreak = {read=FFirstParaBreak, write=FFirstParaBreak, default=0};
	__property bool LastParaBreak = {read=FLastParaBreak, write=FLastParaBreak, default=0};
	__property Cursor = {default=0};
	__property TagStr = {default=0};
	__property URL = {default=0};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCustomMemoView(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxStretcheable(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxMemoView : public TfrxCustomMemoView
{
	typedef TfrxCustomMemoView inherited;
	
__published:
	__property AutoWidth = {default=0};
	__property AllowExpressions = {default=1};
	__property AllowHTMLTags = {default=0};
	__property CharSpacing = {default=0};
	__property Clipped = {default=1};
	__property Color = {default=0};
	__property DataField = {default=0};
	__property DataSet;
	__property DataSetName = {default=0};
	__property DisplayFormat;
	__property ExpressionDelimiters = {default=0};
	__property FlowTo;
	__property Font;
	__property Frame;
	__property GapX = {default=0};
	__property GapY = {default=0};
	__property HAlign = {default=0};
	__property HideZeros = {default=0};
	__property Highlight;
	__property LineSpacing = {default=0};
	__property Memo;
	__property ParagraphGap = {default=0};
	__property ParentFont = {default=1};
	__property Rotation = {default=0};
	__property RTLReading = {default=0};
	__property Style = {default=0};
	__property SuppressRepeated = {default=0};
	__property Underlines = {default=0};
	__property WordBreak = {default=0};
	__property WordWrap = {default=1};
	__property Wysiwyg = {default=1};
	__property VAlign = {default=0};
public:
	/* TfrxCustomMemoView.Create */ inline __fastcall virtual TfrxMemoView(System::Classes::TComponent* AOwner) : TfrxCustomMemoView(AOwner) { }
	/* TfrxCustomMemoView.Destroy */ inline __fastcall virtual ~TfrxMemoView(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxMemoView(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxCustomMemoView(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxSysMemoView : public TfrxCustomMemoView
{
	typedef TfrxCustomMemoView inherited;
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property AutoWidth = {default=0};
	__property CharSpacing = {default=0};
	__property Color = {default=0};
	__property DisplayFormat;
	__property Font;
	__property Frame;
	__property GapX = {default=0};
	__property GapY = {default=0};
	__property HAlign = {default=0};
	__property HideZeros = {default=0};
	__property Highlight;
	__property Memo;
	__property ParentFont = {default=1};
	__property Rotation = {default=0};
	__property RTLReading = {default=0};
	__property Style = {default=0};
	__property SuppressRepeated = {default=0};
	__property VAlign = {default=0};
	__property WordWrap = {default=1};
public:
	/* TfrxCustomMemoView.Create */ inline __fastcall virtual TfrxSysMemoView(System::Classes::TComponent* AOwner) : TfrxCustomMemoView(AOwner) { }
	/* TfrxCustomMemoView.Destroy */ inline __fastcall virtual ~TfrxSysMemoView(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxSysMemoView(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxCustomMemoView(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxCustomLineView : public TfrxStretcheable
{
	typedef TfrxStretcheable inherited;
	
private:
	bool FDiagonal;
	bool FArrowEnd;
	int FArrowLength;
	bool FArrowSolid;
	bool FArrowStart;
	int FArrowWidth;
	void __fastcall DrawArrow(System::Extended x1, System::Extended y1, System::Extended x2, System::Extended y2);
	void __fastcall DrawDiagonalLine(void);
	
public:
	__fastcall virtual TfrxCustomLineView(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxCustomLineView(System::Classes::TComponent* AOwner, System::Word Flags);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall GetVisibleRect(System::Types::TRectF &aRect);
	__property bool ArrowEnd = {read=FArrowEnd, write=FArrowEnd, default=0};
	__property int ArrowLength = {read=FArrowLength, write=FArrowLength, default=20};
	__property bool ArrowSolid = {read=FArrowSolid, write=FArrowSolid, default=0};
	__property bool ArrowStart = {read=FArrowStart, write=FArrowStart, default=0};
	__property int ArrowWidth = {read=FArrowWidth, write=FArrowWidth, default=5};
	__property bool Diagonal = {read=FDiagonal, write=FDiagonal, default=0};
	
__published:
	__property TagStr = {default=0};
public:
	/* TfrxView.Destroy */ inline __fastcall virtual ~TfrxCustomLineView(void) { }
	
};


class PASCALIMPLEMENTATION TfrxLineView : public TfrxCustomLineView
{
	typedef TfrxCustomLineView inherited;
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property ArrowEnd = {default=0};
	__property ArrowLength = {default=20};
	__property ArrowSolid = {default=0};
	__property ArrowStart = {default=0};
	__property ArrowWidth = {default=5};
	__property Frame;
	__property Diagonal = {default=0};
public:
	/* TfrxCustomLineView.Create */ inline __fastcall virtual TfrxLineView(System::Classes::TComponent* AOwner) : TfrxCustomLineView(AOwner) { }
	/* TfrxCustomLineView.DesignCreate */ inline __fastcall virtual TfrxLineView(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxCustomLineView(AOwner, Flags) { }
	
public:
	/* TfrxView.Destroy */ inline __fastcall virtual ~TfrxLineView(void) { }
	
};


class PASCALIMPLEMENTATION TfrxPictureView : public TfrxView
{
	typedef TfrxView inherited;
	
protected:
	void __fastcall ReadVCLPicture(System::Classes::TStream* Stream);
	
private:
	bool FAutoSize;
	bool FCenter;
	System::UnicodeString FFileLink;
	int FImageIndex;
	bool FIsImageIndexStored;
	bool FIsPictureStored;
	bool FKeepAspectRatio;
	Fmx::Graphics::TBitmap* FPicture;
	bool FPictureChanged;
	bool FStretched;
	bool FHightQuality;
	bool FTransparent;
	System::Uitypes::TAlphaColor FTransparentColor;
	void __fastcall SetPicture(Fmx::Graphics::TBitmap* const Value);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetTransparent(const bool Value);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TfrxPictureView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxPictureView(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual System::UnicodeString __fastcall Diff(TfrxComponent* AComponent);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall GetData(void);
	__property bool IsImageIndexStored = {read=FIsImageIndexStored, write=FIsImageIndexStored, nodefault};
	__property bool IsPictureStored = {read=FIsPictureStored, write=FIsPictureStored, nodefault};
	
__published:
	__property Cursor = {default=0};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=0};
	__property bool Center = {read=FCenter, write=FCenter, default=0};
	__property DataField = {default=0};
	__property DataSet;
	__property DataSetName = {default=0};
	__property Frame;
	__property System::UnicodeString FileLink = {read=FFileLink, write=FFileLink};
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, stored=FIsImageIndexStored, nodefault};
	__property bool KeepAspectRatio = {read=FKeepAspectRatio, write=FKeepAspectRatio, default=1};
	__property Fmx::Graphics::TBitmap* Picture = {read=FPicture, write=SetPicture, stored=FIsPictureStored};
	__property bool Stretched = {read=FStretched, write=FStretched, default=1};
	__property TagStr = {default=0};
	__property URL = {default=0};
	__property bool HightQuality = {read=FHightQuality, write=FHightQuality, nodefault};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, nodefault};
	__property System::Uitypes::TAlphaColor TransparentColor = {read=FTransparentColor, write=FTransparentColor, nodefault};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxPictureView(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxView(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxShapeView : public TfrxView
{
	typedef TfrxView inherited;
	
private:
	int FCurve;
	TfrxShapeKind FShape;
	
public:
	__fastcall virtual TfrxShapeView(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxShapeView(System::Classes::TComponent* AOwner, System::Word Flags);
	virtual System::UnicodeString __fastcall Diff(TfrxComponent* AComponent);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall GetVisibleRect(System::Types::TRectF &aRect);
	
__published:
	__property Color = {default=0};
	__property Cursor = {default=0};
	__property int Curve = {read=FCurve, write=FCurve, default=0};
	__property Frame;
	__property TfrxShapeKind Shape = {read=FShape, write=FShape, default=0};
	__property TagStr = {default=0};
	__property URL = {default=0};
public:
	/* TfrxView.Destroy */ inline __fastcall virtual ~TfrxShapeView(void) { }
	
};


class PASCALIMPLEMENTATION TfrxSubreport : public TfrxView
{
	typedef TfrxView inherited;
	
private:
	TfrxReportPage* FPage;
	bool FPrintOnParent;
	void __fastcall SetPage(TfrxReportPage* const Value);
	
public:
	__fastcall virtual TfrxSubreport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxSubreport(void);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property TfrxReportPage* Page = {read=FPage, write=SetPage};
	__property bool PrintOnParent = {read=FPrintOnParent, write=FPrintOnParent, default=0};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxSubreport(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxView(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxBand : public TfrxReportComponent
{
	typedef TfrxReportComponent inherited;
	
private:
	bool FAllowSplit;
	TfrxChild* FChild;
	bool FKeepChild;
	TfrxNotifyEvent FOnAfterCalcHeight;
	System::UnicodeString FOutlineText;
	bool FOverflow;
	bool FStartNewPage;
	bool FStretched;
	bool FPrintChildIfInvisible;
	bool FVertical;
	System::UnicodeString __fastcall GetBandName(void);
	void __fastcall SetChild(TfrxChild* Value);
	void __fastcall SetVertical(const bool Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetLeft(double Value);
	virtual void __fastcall SetTop(double Value);
	virtual void __fastcall SetHeight(double Value);
	
public:
	System::Classes::TList* FSubBands;
	TfrxBand* FHeader;
	TfrxBand* FFooter;
	TfrxBand* FGroup;
	int FLineN;
	int FLineThrough;
	int FOriginalObjectsCount;
	bool FHasVBands;
	double FStretchedHeight;
	__fastcall virtual TfrxBand(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxBand(void);
	int __fastcall BandNumber(void);
	virtual void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property bool AllowSplit = {read=FAllowSplit, write=FAllowSplit, default=0};
	__property System::UnicodeString BandName = {read=GetBandName};
	__property TfrxChild* Child = {read=FChild, write=SetChild};
	__property bool KeepChild = {read=FKeepChild, write=FKeepChild, default=0};
	__property System::UnicodeString OutlineText = {read=FOutlineText, write=FOutlineText};
	__property bool Overflow = {read=FOverflow, write=FOverflow, nodefault};
	__property bool PrintChildIfInvisible = {read=FPrintChildIfInvisible, write=FPrintChildIfInvisible, default=0};
	__property bool StartNewPage = {read=FStartNewPage, write=FStartNewPage, default=0};
	__property bool Stretched = {read=FStretched, write=FStretched, default=0};
	
__published:
	__property Font;
	__property Height = {default=0};
	__property Left = {default=0};
	__property ParentFont = {default=1};
	__property Restrictions = {default=0};
	__property Top = {default=0};
	__property bool Vertical = {read=FVertical, write=SetVertical, default=0};
	__property Visible = {default=1};
	__property Width = {default=0};
	__property TfrxNotifyEvent OnAfterCalcHeight = {read=FOnAfterCalcHeight, write=FOnAfterCalcHeight};
	__property OnAfterPrint = {default=0};
	__property OnBeforePrint = {default=0};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxBand(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxReportComponent(AOwner, Flags) { }
	
};


typedef System::TMetaClass* TfrxBandClass;

class PASCALIMPLEMENTATION TfrxDataBand : public TfrxBand
{
	typedef TfrxBand inherited;
	
private:
	double FColumnGap;
	double FColumnWidth;
	int FColumns;
	int FCurColumn;
	TfrxDataSet* FDataSet;
	System::UnicodeString FDataSetName;
	bool FFooterAfterEach;
	bool FKeepFooter;
	bool FKeepHeader;
	bool FKeepTogether;
	bool FPrintIfDetailEmpty;
	int FRowCount;
	TfrxNotifyEvent FOnMasterDetail;
	TfrxUserDataSet* FVirtualDataSet;
	void __fastcall SetCurColumn(int Value);
	void __fastcall SetRowCount(const int Value);
	void __fastcall SetDataSet(TfrxDataSet* const Value);
	void __fastcall SetDataSetName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetDataSetName(void);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	double FMaxY;
	__fastcall virtual TfrxDataBand(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxDataBand(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property int CurColumn = {read=FCurColumn, write=SetCurColumn, nodefault};
	__property TfrxUserDataSet* VirtualDataSet = {read=FVirtualDataSet};
	
__published:
	__property AllowSplit = {default=0};
	__property Child;
	__property int Columns = {read=FColumns, write=FColumns, default=0};
	__property double ColumnWidth = {read=FColumnWidth, write=FColumnWidth};
	__property double ColumnGap = {read=FColumnGap, write=FColumnGap};
	__property TfrxDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property System::UnicodeString DataSetName = {read=GetDataSetName, write=SetDataSetName};
	__property bool FooterAfterEach = {read=FFooterAfterEach, write=FFooterAfterEach, default=0};
	__property KeepChild = {default=0};
	__property bool KeepFooter = {read=FKeepFooter, write=FKeepFooter, default=0};
	__property bool KeepHeader = {read=FKeepHeader, write=FKeepHeader, default=0};
	__property bool KeepTogether = {read=FKeepTogether, write=FKeepTogether, default=0};
	__property OutlineText = {default=0};
	__property PrintChildIfInvisible = {default=0};
	__property bool PrintIfDetailEmpty = {read=FPrintIfDetailEmpty, write=FPrintIfDetailEmpty, default=0};
	__property int RowCount = {read=FRowCount, write=SetRowCount, nodefault};
	__property StartNewPage = {default=0};
	__property Stretched = {default=0};
	__property TfrxNotifyEvent OnMasterDetail = {read=FOnMasterDetail, write=FOnMasterDetail};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDataBand(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxHeader : public TfrxBand
{
	typedef TfrxBand inherited;
	
private:
	bool FReprintOnNewPage;
	
__published:
	__property AllowSplit = {default=0};
	__property Child;
	__property KeepChild = {default=0};
	__property PrintChildIfInvisible = {default=0};
	__property bool ReprintOnNewPage = {read=FReprintOnNewPage, write=FReprintOnNewPage, default=0};
	__property StartNewPage = {default=0};
	__property Stretched = {default=0};
public:
	/* TfrxBand.Create */ inline __fastcall virtual TfrxHeader(System::Classes::TComponent* AOwner) : TfrxBand(AOwner) { }
	/* TfrxBand.Destroy */ inline __fastcall virtual ~TfrxHeader(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxHeader(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxFooter : public TfrxBand
{
	typedef TfrxBand inherited;
	
__published:
	__property AllowSplit = {default=0};
	__property Child;
	__property KeepChild = {default=0};
	__property PrintChildIfInvisible = {default=0};
	__property Stretched = {default=0};
public:
	/* TfrxBand.Create */ inline __fastcall virtual TfrxFooter(System::Classes::TComponent* AOwner) : TfrxBand(AOwner) { }
	/* TfrxBand.Destroy */ inline __fastcall virtual ~TfrxFooter(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxFooter(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxMasterData : public TfrxDataBand
{
	typedef TfrxDataBand inherited;
	
public:
	/* TfrxDataBand.Create */ inline __fastcall virtual TfrxMasterData(System::Classes::TComponent* AOwner) : TfrxDataBand(AOwner) { }
	/* TfrxDataBand.Destroy */ inline __fastcall virtual ~TfrxMasterData(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxMasterData(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxDataBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDetailData : public TfrxDataBand
{
	typedef TfrxDataBand inherited;
	
public:
	/* TfrxDataBand.Create */ inline __fastcall virtual TfrxDetailData(System::Classes::TComponent* AOwner) : TfrxDataBand(AOwner) { }
	/* TfrxDataBand.Destroy */ inline __fastcall virtual ~TfrxDetailData(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDetailData(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxDataBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxSubdetailData : public TfrxDataBand
{
	typedef TfrxDataBand inherited;
	
public:
	/* TfrxDataBand.Create */ inline __fastcall virtual TfrxSubdetailData(System::Classes::TComponent* AOwner) : TfrxDataBand(AOwner) { }
	/* TfrxDataBand.Destroy */ inline __fastcall virtual ~TfrxSubdetailData(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxSubdetailData(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxDataBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDataBand4 : public TfrxDataBand
{
	typedef TfrxDataBand inherited;
	
public:
	/* TfrxDataBand.Create */ inline __fastcall virtual TfrxDataBand4(System::Classes::TComponent* AOwner) : TfrxDataBand(AOwner) { }
	/* TfrxDataBand.Destroy */ inline __fastcall virtual ~TfrxDataBand4(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDataBand4(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxDataBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDataBand5 : public TfrxDataBand
{
	typedef TfrxDataBand inherited;
	
public:
	/* TfrxDataBand.Create */ inline __fastcall virtual TfrxDataBand5(System::Classes::TComponent* AOwner) : TfrxDataBand(AOwner) { }
	/* TfrxDataBand.Destroy */ inline __fastcall virtual ~TfrxDataBand5(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDataBand5(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxDataBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDataBand6 : public TfrxDataBand
{
	typedef TfrxDataBand inherited;
	
public:
	/* TfrxDataBand.Create */ inline __fastcall virtual TfrxDataBand6(System::Classes::TComponent* AOwner) : TfrxDataBand(AOwner) { }
	/* TfrxDataBand.Destroy */ inline __fastcall virtual ~TfrxDataBand6(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDataBand6(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxDataBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxPageHeader : public TfrxBand
{
	typedef TfrxBand inherited;
	
private:
	bool FPrintOnFirstPage;
	
public:
	__fastcall virtual TfrxPageHeader(System::Classes::TComponent* AOwner);
	
__published:
	__property Child;
	__property PrintChildIfInvisible = {default=0};
	__property bool PrintOnFirstPage = {read=FPrintOnFirstPage, write=FPrintOnFirstPage, default=1};
	__property Stretched = {default=0};
public:
	/* TfrxBand.Destroy */ inline __fastcall virtual ~TfrxPageHeader(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxPageHeader(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxPageFooter : public TfrxBand
{
	typedef TfrxBand inherited;
	
private:
	bool FPrintOnFirstPage;
	bool FPrintOnLastPage;
	
public:
	__fastcall virtual TfrxPageFooter(System::Classes::TComponent* AOwner);
	
__published:
	__property bool PrintOnFirstPage = {read=FPrintOnFirstPage, write=FPrintOnFirstPage, default=1};
	__property bool PrintOnLastPage = {read=FPrintOnLastPage, write=FPrintOnLastPage, default=1};
public:
	/* TfrxBand.Destroy */ inline __fastcall virtual ~TfrxPageFooter(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxPageFooter(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxColumnHeader : public TfrxBand
{
	typedef TfrxBand inherited;
	
__published:
	__property Child;
	__property Stretched = {default=0};
public:
	/* TfrxBand.Create */ inline __fastcall virtual TfrxColumnHeader(System::Classes::TComponent* AOwner) : TfrxBand(AOwner) { }
	/* TfrxBand.Destroy */ inline __fastcall virtual ~TfrxColumnHeader(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxColumnHeader(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxColumnFooter : public TfrxBand
{
	typedef TfrxBand inherited;
	
public:
	/* TfrxBand.Create */ inline __fastcall virtual TfrxColumnFooter(System::Classes::TComponent* AOwner) : TfrxBand(AOwner) { }
	/* TfrxBand.Destroy */ inline __fastcall virtual ~TfrxColumnFooter(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxColumnFooter(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxGroupHeader : public TfrxBand
{
	typedef TfrxBand inherited;
	
private:
	System::UnicodeString FCondition;
	System::UnicodeString FDrillName;
	bool FDrillDown;
	bool FExpandDrillDown;
	bool FShowFooterIfDrillDown;
	bool FShowChildIfDrillDown;
	bool FKeepTogether;
	bool FReprintOnNewPage;
	bool FResetPageNumbers;
	
public:
	System::Variant FLastValue;
	virtual System::UnicodeString __fastcall Diff(TfrxComponent* AComponent);
	
__published:
	__property AllowSplit = {default=0};
	__property Child;
	__property System::UnicodeString Condition = {read=FCondition, write=FCondition};
	__property bool DrillDown = {read=FDrillDown, write=FDrillDown, default=0};
	__property bool ExpandDrillDown = {read=FExpandDrillDown, write=FExpandDrillDown, default=0};
	__property KeepChild = {default=0};
	__property bool KeepTogether = {read=FKeepTogether, write=FKeepTogether, default=0};
	__property bool ReprintOnNewPage = {read=FReprintOnNewPage, write=FReprintOnNewPage, default=0};
	__property OutlineText = {default=0};
	__property PrintChildIfInvisible = {default=0};
	__property bool ResetPageNumbers = {read=FResetPageNumbers, write=FResetPageNumbers, default=0};
	__property bool ShowFooterIfDrillDown = {read=FShowFooterIfDrillDown, write=FShowFooterIfDrillDown, default=0};
	__property bool ShowChildIfDrillDown = {read=FShowChildIfDrillDown, write=FShowChildIfDrillDown, default=0};
	__property StartNewPage = {default=0};
	__property Stretched = {default=0};
	__property System::UnicodeString DrillName = {read=FDrillName, write=FDrillName};
public:
	/* TfrxBand.Create */ inline __fastcall virtual TfrxGroupHeader(System::Classes::TComponent* AOwner) : TfrxBand(AOwner) { }
	/* TfrxBand.Destroy */ inline __fastcall virtual ~TfrxGroupHeader(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxGroupHeader(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxGroupFooter : public TfrxBand
{
	typedef TfrxBand inherited;
	
private:
	bool FHideIfSingleDataRecord;
	
__published:
	__property AllowSplit = {default=0};
	__property Child;
	__property bool HideIfSingleDataRecord = {read=FHideIfSingleDataRecord, write=FHideIfSingleDataRecord, default=0};
	__property KeepChild = {default=0};
	__property PrintChildIfInvisible = {default=0};
	__property Stretched = {default=0};
public:
	/* TfrxBand.Create */ inline __fastcall virtual TfrxGroupFooter(System::Classes::TComponent* AOwner) : TfrxBand(AOwner) { }
	/* TfrxBand.Destroy */ inline __fastcall virtual ~TfrxGroupFooter(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxGroupFooter(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxReportTitle : public TfrxBand
{
	typedef TfrxBand inherited;
	
__published:
	__property AllowSplit = {default=0};
	__property Child;
	__property KeepChild = {default=0};
	__property PrintChildIfInvisible = {default=0};
	__property StartNewPage = {default=0};
	__property Stretched = {default=0};
public:
	/* TfrxBand.Create */ inline __fastcall virtual TfrxReportTitle(System::Classes::TComponent* AOwner) : TfrxBand(AOwner) { }
	/* TfrxBand.Destroy */ inline __fastcall virtual ~TfrxReportTitle(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxReportTitle(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxReportSummary : public TfrxBand
{
	typedef TfrxBand inherited;
	
__published:
	__property AllowSplit = {default=0};
	__property Child;
	__property KeepChild = {default=0};
	__property PrintChildIfInvisible = {default=0};
	__property StartNewPage = {default=0};
	__property Stretched = {default=0};
public:
	/* TfrxBand.Create */ inline __fastcall virtual TfrxReportSummary(System::Classes::TComponent* AOwner) : TfrxBand(AOwner) { }
	/* TfrxBand.Destroy */ inline __fastcall virtual ~TfrxReportSummary(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxReportSummary(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxChild : public TfrxBand
{
	typedef TfrxBand inherited;
	
__published:
	__property AllowSplit = {default=0};
	__property Child;
	__property KeepChild = {default=0};
	__property PrintChildIfInvisible = {default=0};
	__property StartNewPage = {default=0};
	__property Stretched = {default=0};
public:
	/* TfrxBand.Create */ inline __fastcall virtual TfrxChild(System::Classes::TComponent* AOwner) : TfrxBand(AOwner) { }
	/* TfrxBand.Destroy */ inline __fastcall virtual ~TfrxChild(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxChild(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxOverlay : public TfrxBand
{
	typedef TfrxBand inherited;
	
private:
	bool FPrintOnTop;
	
__published:
	__property bool PrintOnTop = {read=FPrintOnTop, write=FPrintOnTop, default=0};
public:
	/* TfrxBand.Create */ inline __fastcall virtual TfrxOverlay(System::Classes::TComponent* AOwner) : TfrxBand(AOwner) { }
	/* TfrxBand.Destroy */ inline __fastcall virtual ~TfrxOverlay(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxOverlay(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxNullBand : public TfrxBand
{
	typedef TfrxBand inherited;
	
public:
	/* TfrxBand.Create */ inline __fastcall virtual TfrxNullBand(System::Classes::TComponent* AOwner) : TfrxBand(AOwner) { }
	/* TfrxBand.Destroy */ inline __fastcall virtual ~TfrxNullBand(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxNullBand(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxBand(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxPage : public TfrxComponent
{
	typedef TfrxComponent inherited;
	
__published:
	__property Font;
	__property Visible = {default=1};
public:
	/* TfrxComponent.Create */ inline __fastcall virtual TfrxPage(System::Classes::TComponent* AOwner) : TfrxComponent(AOwner) { }
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxPage(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxComponent(AOwner, Flags) { }
	/* TfrxComponent.Destroy */ inline __fastcall virtual ~TfrxPage(void) { }
	
};


class PASCALIMPLEMENTATION TfrxReportPage : public TfrxPage
{
	typedef TfrxPage inherited;
	
private:
	TfrxPictureView* FBackPicture;
	int FBin;
	int FBinOtherPages;
	double FBottomMargin;
	int FColumns;
	double FColumnWidth;
	System::Classes::TStrings* FColumnPositions;
	TfrxDataSet* FDataSet;
	TfrxDuplexMode FDuplex;
	bool FEndlessHeight;
	bool FEndlessWidth;
	System::Classes::TStrings* FHGuides;
	bool FLargeDesignHeight;
	double FLeftMargin;
	bool FMirrorMargins;
	System::Uitypes::TPrinterOrientation FOrientation;
	System::UnicodeString FOutlineText;
	bool FPrintIfEmpty;
	bool FPrintOnPreviousPage;
	bool FResetPageNumbers;
	double FRightMargin;
	TfrxSubreport* FSubReport;
	bool FTitleBeforeHeader;
	double FTopMargin;
	System::Classes::TStrings* FVGuides;
	TfrxNotifyEvent FOnAfterPrint;
	TfrxNotifyEvent FOnBeforePrint;
	TfrxNotifyEvent FOnManualBuild;
	System::UnicodeString FDataSetName;
	bool FBackPictureVisible;
	bool FBackPicturePrintable;
	int FPageCount;
	void __fastcall SetPageCount(const int Value);
	void __fastcall SetColumns(const int Value);
	void __fastcall SetOrientation(System::Uitypes::TPrinterOrientation Value);
	void __fastcall SetHGuides(System::Classes::TStrings* const Value);
	void __fastcall SetVGuides(System::Classes::TStrings* const Value);
	void __fastcall SetColumnPositions(System::Classes::TStrings* const Value);
	void __fastcall SetFrame(TfrxFrame* const Value);
	TfrxFrame* __fastcall GetFrame(void);
	System::Uitypes::TAlphaColor __fastcall GetColor(void);
	void __fastcall SetColor(const System::Uitypes::TAlphaColor Value);
	Fmx::Graphics::TBitmap* __fastcall GetBackPicture(void);
	void __fastcall SetBackPicture(Fmx::Graphics::TBitmap* const Value);
	void __fastcall SetDataSet(TfrxDataSet* const Value);
	void __fastcall SetDataSetName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetDataSetName(void);
	
protected:
	double FPaperHeight;
	int FPaperSize;
	double FPaperWidth;
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetPaperHeight(const double Value);
	virtual void __fastcall SetPaperWidth(const double Value);
	virtual void __fastcall SetPaperSize(const int Value);
	void __fastcall UpdateDimensions(void);
	
public:
	System::Classes::TList* FSubBands;
	System::Classes::TList* FVSubBands;
	__fastcall virtual TfrxReportPage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxReportPage(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	TfrxBand* __fastcall FindBand(TfrxBandClass Band);
	bool __fastcall IsSubReport(void);
	virtual void __fastcall AlignChildren(void);
	void __fastcall ClearGuides(void);
	void __fastcall Draw(Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall SetDefaults(void);
	void __fastcall SetSizeAndDimensions(int ASize, double AWidth, double AHeight);
	__property TfrxSubreport* SubReport = {read=FSubReport};
	
__published:
	__property System::Uitypes::TPrinterOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property double PaperWidth = {read=FPaperWidth, write=SetPaperWidth};
	__property double PaperHeight = {read=FPaperHeight, write=SetPaperHeight};
	__property int PaperSize = {read=FPaperSize, write=SetPaperSize, nodefault};
	__property double LeftMargin = {read=FLeftMargin, write=FLeftMargin};
	__property double RightMargin = {read=FRightMargin, write=FRightMargin};
	__property double TopMargin = {read=FTopMargin, write=FTopMargin};
	__property double BottomMargin = {read=FBottomMargin, write=FBottomMargin};
	__property bool MirrorMargins = {read=FMirrorMargins, write=FMirrorMargins, default=0};
	__property int Columns = {read=FColumns, write=SetColumns, default=0};
	__property double ColumnWidth = {read=FColumnWidth, write=FColumnWidth};
	__property System::Classes::TStrings* ColumnPositions = {read=FColumnPositions, write=SetColumnPositions};
	__property int Bin = {read=FBin, write=FBin, default=7};
	__property int BinOtherPages = {read=FBinOtherPages, write=FBinOtherPages, default=7};
	__property Fmx::Graphics::TBitmap* BackPicture = {read=GetBackPicture, write=SetBackPicture};
	__property bool BackPictureVisible = {read=FBackPictureVisible, write=FBackPictureVisible, default=1};
	__property bool BackPicturePrintable = {read=FBackPicturePrintable, write=FBackPicturePrintable, default=1};
	__property int PageCount = {read=FPageCount, write=SetPageCount, default=1};
	__property System::Uitypes::TAlphaColor Color = {read=GetColor, write=SetColor, default=0};
	__property TfrxDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property System::UnicodeString DataSetName = {read=GetDataSetName, write=SetDataSetName};
	__property TfrxDuplexMode Duplex = {read=FDuplex, write=FDuplex, default=0};
	__property TfrxFrame* Frame = {read=GetFrame, write=SetFrame};
	__property bool EndlessHeight = {read=FEndlessHeight, write=FEndlessHeight, default=0};
	__property bool EndlessWidth = {read=FEndlessWidth, write=FEndlessWidth, default=0};
	__property bool LargeDesignHeight = {read=FLargeDesignHeight, write=FLargeDesignHeight, default=0};
	__property System::UnicodeString OutlineText = {read=FOutlineText, write=FOutlineText};
	__property bool PrintIfEmpty = {read=FPrintIfEmpty, write=FPrintIfEmpty, default=1};
	__property bool PrintOnPreviousPage = {read=FPrintOnPreviousPage, write=FPrintOnPreviousPage, default=0};
	__property bool ResetPageNumbers = {read=FResetPageNumbers, write=FResetPageNumbers, default=0};
	__property bool TitleBeforeHeader = {read=FTitleBeforeHeader, write=FTitleBeforeHeader, default=1};
	__property System::Classes::TStrings* HGuides = {read=FHGuides, write=SetHGuides};
	__property System::Classes::TStrings* VGuides = {read=FVGuides, write=SetVGuides};
	__property TfrxNotifyEvent OnAfterPrint = {read=FOnAfterPrint, write=FOnAfterPrint};
	__property TfrxNotifyEvent OnBeforePrint = {read=FOnBeforePrint, write=FOnBeforePrint};
	__property TfrxNotifyEvent OnManualBuild = {read=FOnManualBuild, write=FOnManualBuild};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxReportPage(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxPage(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDialogPage : public TfrxPage
{
	typedef TfrxPage inherited;
	
private:
	Fmx::Forms::TFmxFormBorderStyle FBorderStyle;
	System::UnicodeString FCaption;
	System::Uitypes::TAlphaColor FColor;
	Fmx::Forms::TForm* FForm;
	TfrxNotifyEvent FOnActivate;
	TfrxNotifyEvent FOnClick;
	TfrxNotifyEvent FOnDeactivate;
	TfrxNotifyEvent FOnHide;
	TfrxKeyEvent FOnKeyDown;
	TfrxKeyPressEvent FOnKeyPress;
	TfrxKeyEvent FOnKeyUp;
	TfrxNotifyEvent FOnResize;
	TfrxNotifyEvent FOnShow;
	TfrxCloseQueryEvent FOnCloseQuery;
	Fmx::Forms::TFormPosition FPosition;
	System::Uitypes::TWindowState FWindowState;
	double FClientWidth;
	double FClientHeight;
	void __fastcall DoInitialize(void);
	void __fastcall DoOnActivate(System::TObject* Sender);
	void __fastcall DoOnCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall DoOnDeactivate(System::TObject* Sender);
	void __fastcall DoOnResize(System::TObject* Sender);
	void __fastcall DoModify(System::TObject* Sender);
	void __fastcall SetBorderStyle(const Fmx::Forms::TFmxFormBorderStyle Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetColor(const System::Uitypes::TAlphaColor Value);
	System::Uitypes::TModalResult __fastcall GetModalResult(void);
	void __fastcall SetModalResult(const System::Uitypes::TModalResult Value);
	void __fastcall SetPosition(const Fmx::Forms::TFormPosition Value);
	
protected:
	virtual void __fastcall SetLeft(double Value);
	virtual void __fastcall SetTop(double Value);
	virtual void __fastcall SetWidth(double Value);
	virtual void __fastcall SetHeight(double Value);
	void __fastcall SetClientWidth(double Value);
	void __fastcall SetClientHeight(double Value);
	double __fastcall GetClientWidth(void);
	double __fastcall GetClientHeight(void);
	virtual void __fastcall FontChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TfrxDialogPage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxDialogPage(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	void __fastcall Initialize(void);
	void __fastcall UpdateClientRect(void);
	System::Uitypes::TModalResult __fastcall ShowModal(void);
	__property Fmx::Forms::TForm* DialogForm = {read=FForm};
	__property System::Uitypes::TModalResult ModalResult = {read=GetModalResult, write=SetModalResult, nodefault};
	
__published:
	__property Fmx::Forms::TFmxFormBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=2};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=SetColor, default=-657931};
	__property Height = {default=0};
	__property double ClientHeight = {read=GetClientHeight, write=SetClientHeight};
	__property Left = {default=0};
	__property Fmx::Forms::TFormPosition Position = {read=FPosition, write=SetPosition, default=4};
	__property Top = {default=0};
	__property Width = {default=0};
	__property double ClientWidth = {read=GetClientWidth, write=SetClientWidth};
	__property System::Uitypes::TWindowState WindowState = {read=FWindowState, write=FWindowState, default=0};
	__property TfrxNotifyEvent OnActivate = {read=FOnActivate, write=FOnActivate};
	__property TfrxNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property TfrxCloseQueryEvent OnCloseQuery = {read=FOnCloseQuery, write=FOnCloseQuery};
	__property TfrxNotifyEvent OnDeactivate = {read=FOnDeactivate, write=FOnDeactivate};
	__property TfrxNotifyEvent OnHide = {read=FOnHide, write=FOnHide};
	__property TfrxKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
	__property TfrxKeyPressEvent OnKeyPress = {read=FOnKeyPress, write=FOnKeyPress};
	__property TfrxKeyEvent OnKeyUp = {read=FOnKeyUp, write=FOnKeyUp};
	__property TfrxNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property TfrxNotifyEvent OnResize = {read=FOnResize, write=FOnResize};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDialogPage(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxPage(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDataPage : public TfrxPage
{
	typedef TfrxPage inherited;
	
public:
	__fastcall virtual TfrxDataPage(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property Height = {default=0};
	__property Left = {default=0};
	__property Top = {default=0};
	__property Width = {default=0};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDataPage(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxPage(AOwner, Flags) { }
	/* TfrxComponent.Destroy */ inline __fastcall virtual ~TfrxDataPage(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxEngineOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FConvertNulls;
	bool FDestroyForms;
	bool FDoublePass;
	int FMaxMemSize;
	bool FPrintIfEmpty;
	System::Classes::TThread* FReportThread;
	bool FEnableThreadSafe;
	TfrxSilentMode FSilentMode;
	System::UnicodeString FTempDir;
	bool FUseFileCache;
	bool FUseGlobalDataSetList;
	bool FIgnoreDevByZero;
	void __fastcall SetSilentMode(bool Mode);
	bool __fastcall GetSilentMode(void);
	
public:
	__fastcall TfrxEngineOptions(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Clear(void);
	__property System::Classes::TThread* ReportThread = {read=FReportThread, write=FReportThread};
	__property bool DestroyForms = {read=FDestroyForms, write=FDestroyForms, nodefault};
	__property bool EnableThreadSafe = {read=FEnableThreadSafe, write=FEnableThreadSafe, nodefault};
	__property bool UseGlobalDataSetList = {read=FUseGlobalDataSetList, write=FUseGlobalDataSetList, nodefault};
	
__published:
	__property bool ConvertNulls = {read=FConvertNulls, write=FConvertNulls, default=1};
	__property bool DoublePass = {read=FDoublePass, write=FDoublePass, default=0};
	__property int MaxMemSize = {read=FMaxMemSize, write=FMaxMemSize, default=10};
	__property bool PrintIfEmpty = {read=FPrintIfEmpty, write=FPrintIfEmpty, default=1};
	__property bool SilentMode = {read=GetSilentMode, write=SetSilentMode, default=0};
	__property TfrxSilentMode NewSilentMode = {read=FSilentMode, write=FSilentMode, default=0};
	__property System::UnicodeString TempDir = {read=FTempDir, write=FTempDir};
	__property bool UseFileCache = {read=FUseFileCache, write=FUseFileCache, default=0};
	__property bool IgnoreDevByZero = {read=FIgnoreDevByZero, write=FIgnoreDevByZero, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxEngineOptions(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPrintOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FCopies;
	bool FCollate;
	System::UnicodeString FPageNumbers;
	int FPagesOnSheet;
	System::UnicodeString FPrinter;
	TfrxPrintMode FPrintMode;
	int FPrintOnSheet;
	TfrxPrintPages FPrintPages;
	bool FReverse;
	bool FShowDialog;
	bool FSwapPageSize;
	System::UnicodeString FPrnOutFileName;
	TfrxDuplexMode FDuplex;
	int FSplicingLine;
	
public:
	__fastcall TfrxPrintOptions(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Clear(void);
	__property System::UnicodeString PrnOutFileName = {read=FPrnOutFileName, write=FPrnOutFileName};
	__property TfrxDuplexMode Duplex = {read=FDuplex, write=FDuplex, nodefault};
	__property int SplicingLine = {read=FSplicingLine, write=FSplicingLine, default=3};
	
__published:
	__property int Copies = {read=FCopies, write=FCopies, default=1};
	__property bool Collate = {read=FCollate, write=FCollate, default=1};
	__property System::UnicodeString PageNumbers = {read=FPageNumbers, write=FPageNumbers};
	__property System::UnicodeString Printer = {read=FPrinter, write=FPrinter};
	__property TfrxPrintMode PrintMode = {read=FPrintMode, write=FPrintMode, default=0};
	__property int PrintOnSheet = {read=FPrintOnSheet, write=FPrintOnSheet, nodefault};
	__property TfrxPrintPages PrintPages = {read=FPrintPages, write=FPrintPages, default=0};
	__property bool Reverse = {read=FReverse, write=FReverse, default=0};
	__property bool ShowDialog = {read=FShowDialog, write=FShowDialog, default=1};
	__property bool SwapPageSize = {read=FSwapPageSize, write=FSwapPageSize, stored=false, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxPrintOptions(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPreviewOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FAllowEdit;
	TfrxPreviewButtons FButtons;
	bool FDoubleBuffered;
	bool FMaximized;
	bool FMDIChild;
	bool FModal;
	bool FOutlineExpand;
	bool FOutlineVisible;
	int FOutlineWidth;
	int FPagesInCache;
	bool FShowCaptions;
	bool FThumbnailVisible;
	double FZoom;
	TfrxZoomMode FZoomMode;
	bool FPictureCacheInFile;
	bool FRTLPreview;
	bool FPagesInPictureCache;
	int FMaxPagePictureWidth;
	int FMaxPagePictureHeight;
	
public:
	__fastcall TfrxPreviewOptions(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Clear(void);
	__property bool RTLPreview = {read=FRTLPreview, write=FRTLPreview, nodefault};
	__property bool PagesInPictureCache = {read=FPagesInPictureCache, write=FPagesInPictureCache, default=0};
	__property int MaxPagePictureWidth = {read=FMaxPagePictureWidth, write=FMaxPagePictureWidth, default=1600};
	__property int MaxPagePictureHeight = {read=FMaxPagePictureHeight, write=FMaxPagePictureHeight, default=1200};
	
__published:
	__property bool AllowEdit = {read=FAllowEdit, write=FAllowEdit, default=1};
	__property TfrxPreviewButtons Buttons = {read=FButtons, write=FButtons, nodefault};
	__property bool DoubleBuffered = {read=FDoubleBuffered, write=FDoubleBuffered, default=1};
	__property bool Maximized = {read=FMaximized, write=FMaximized, default=1};
	__property bool MDIChild = {read=FMDIChild, write=FMDIChild, default=0};
	__property bool Modal = {read=FModal, write=FModal, default=1};
	__property bool OutlineExpand = {read=FOutlineExpand, write=FOutlineExpand, default=1};
	__property bool OutlineVisible = {read=FOutlineVisible, write=FOutlineVisible, default=0};
	__property int OutlineWidth = {read=FOutlineWidth, write=FOutlineWidth, default=120};
	__property int PagesInCache = {read=FPagesInCache, write=FPagesInCache, default=50};
	__property bool ThumbnailVisible = {read=FThumbnailVisible, write=FThumbnailVisible, default=0};
	__property bool ShowCaptions = {read=FShowCaptions, write=FShowCaptions, default=0};
	__property double Zoom = {read=FZoom, write=FZoom};
	__property TfrxZoomMode ZoomMode = {read=FZoomMode, write=FZoomMode, default=0};
	__property bool PictureCacheInFile = {read=FPictureCacheInFile, write=FPictureCacheInFile, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxPreviewOptions(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxReportOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString FAuthor;
	bool FCompressed;
	System::UnicodeString FConnectionName;
	System::TDateTime FCreateDate;
	System::Classes::TStrings* FDescription;
	System::UnicodeString FInitString;
	System::UnicodeString FName;
	System::TDateTime FLastChange;
	System::UnicodeString FPassword;
	Fmx::Graphics::TBitmap* FPicture;
	TfrxReport* FReport;
	System::UnicodeString FVersionBuild;
	System::UnicodeString FVersionMajor;
	System::UnicodeString FVersionMinor;
	System::UnicodeString FVersionRelease;
	System::UnicodeString FPrevPassword;
	System::UnicodeString FHiddenPassword;
	bool FInfo;
	bool FIsFMXReport;
	void __fastcall SetDescription(System::Classes::TStrings* const Value);
	void __fastcall SetPicture(Fmx::Graphics::TBitmap* const Value);
	
public:
	__fastcall TfrxReportOptions(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxReportOptions(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Clear(void);
	bool __fastcall CheckPassword(void);
	__property System::UnicodeString PrevPassword = {write=FPrevPassword};
	__property bool Info = {read=FInfo, write=FInfo, nodefault};
	__property System::UnicodeString HiddenPassword = {read=FHiddenPassword, write=FHiddenPassword};
	
__published:
	__property System::UnicodeString Author = {read=FAuthor, write=FAuthor};
	__property bool Compressed = {read=FCompressed, write=FCompressed, default=0};
	__property System::TDateTime CreateDate = {read=FCreateDate, write=FCreateDate};
	__property System::Classes::TStrings* Description = {read=FDescription, write=SetDescription};
	__property System::UnicodeString InitString = {read=FInitString, write=FInitString};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property System::TDateTime LastChange = {read=FLastChange, write=FLastChange};
	__property System::UnicodeString Password = {read=FPassword, write=FPassword};
	__property Fmx::Graphics::TBitmap* Picture = {read=FPicture, write=SetPicture};
	__property System::UnicodeString VersionBuild = {read=FVersionBuild, write=FVersionBuild};
	__property System::UnicodeString VersionMajor = {read=FVersionMajor, write=FVersionMajor};
	__property System::UnicodeString VersionMinor = {read=FVersionMinor, write=FVersionMinor};
	__property System::UnicodeString VersionRelease = {read=FVersionRelease, write=FVersionRelease};
	__property bool IsFMXReport = {read=FIsFMXReport, write=FIsFMXReport, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxExpressionCache : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStringList* FExpressions;
	Fmx::Fs_iinterpreter::TfsScript* FMainScript;
	Fmx::Fs_iinterpreter::TfsScript* FScript;
	System::UnicodeString FScriptLanguage;
	void __fastcall SetCaseSensitive(const bool Value);
	bool __fastcall GetCaseSensitive(void);
	
public:
	__fastcall TfrxExpressionCache(Fmx::Fs_iinterpreter::TfsScript* AScript);
	__fastcall virtual ~TfrxExpressionCache(void);
	void __fastcall Clear(void);
	System::Variant __fastcall Calc(const System::UnicodeString Expression, System::UnicodeString &ErrorMsg, Fmx::Fs_iinterpreter::TfsScript* AScript);
	__property bool CaseSensitive = {read=GetCaseSensitive, write=SetCaseSensitive, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxDataSetItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TfrxDataSet* FDataSet;
	System::UnicodeString FDataSetName;
	void __fastcall SetDataSet(TfrxDataSet* const Value);
	void __fastcall SetDataSetName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetDataSetName(void);
	
__published:
	__property TfrxDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property System::UnicodeString DataSetName = {read=GetDataSetName, write=SetDataSetName};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxDataSetItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxDataSetItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxReportDataSets : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxDataSetItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TfrxReport* FReport;
	HIDESBASE TfrxDataSetItem* __fastcall GetItem(int Index);
	
public:
	__fastcall TfrxReportDataSets(TfrxReport* AReport);
	void __fastcall Initialize(void);
	void __fastcall Finalize(void);
	HIDESBASE void __fastcall Add(TfrxDataSet* ds);
	TfrxDataSetItem* __fastcall Find(TfrxDataSet* ds)/* overload */;
	TfrxDataSetItem* __fastcall Find(const System::UnicodeString Name)/* overload */;
	HIDESBASE void __fastcall Delete(const System::UnicodeString Name)/* overload */;
	__property TfrxDataSetItem* Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxReportDataSets(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxStyleItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	System::Uitypes::TAlphaColor FColor;
	Fmx::Frxfmx::TfrxFont* FFont;
	TfrxFrame* FFrame;
	void __fastcall SetFont(Fmx::Frxfmx::TfrxFont* const Value);
	void __fastcall SetFrame(TfrxFrame* const Value);
	void __fastcall SetName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TfrxStyleItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TfrxStyleItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall CreateUniqueName(void);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=FColor, nodefault};
	__property Fmx::Frxfmx::TfrxFont* Font = {read=FFont, write=SetFont};
	__property TfrxFrame* Frame = {read=FFrame, write=SetFrame};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxStyles : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxStyleItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::UnicodeString FName;
	TfrxReport* FReport;
	HIDESBASE TfrxStyleItem* __fastcall GetItem(int Index);
	
public:
	__fastcall TfrxStyles(TfrxReport* AReport);
	HIDESBASE TfrxStyleItem* __fastcall Add(void);
	TfrxStyleItem* __fastcall Find(const System::UnicodeString Name);
	void __fastcall Apply(void);
	void __fastcall GetList(System::Classes::TStrings* List);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromXMLItem(Fmx::Frxxml::TfrxXMLItem* Item, bool OldXMLFormat = true);
	void __fastcall SaveToFile(const System::UnicodeString FileName);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall SaveToXMLItem(Fmx::Frxxml::TfrxXMLItem* Item);
	__property TfrxStyleItem* Items[int Index] = {read=GetItem/*, default*/};
	__property System::UnicodeString Name = {read=FName, write=FName};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxStyles(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxStyleSheet : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxStyles* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TList* FItems;
	TfrxStyles* __fastcall GetItems(int Index);
	
public:
	__fastcall TfrxStyleSheet(void);
	__fastcall virtual ~TfrxStyleSheet(void);
	void __fastcall Clear(void);
	void __fastcall Delete(int Index);
	void __fastcall GetList(System::Classes::TStrings* List);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToFile(const System::UnicodeString FileName);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	TfrxStyles* __fastcall Add(void);
	int __fastcall Count(void);
	TfrxStyles* __fastcall Find(const System::UnicodeString Name);
	int __fastcall IndexOf(const System::UnicodeString Name);
	__property TfrxStyles* Items[int Index] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxReport : public TfrxComponent
{
	typedef TfrxComponent inherited;
	
private:
	Fmx::Platform::_di_IFMXApplicationService FRAppService;
	System::UnicodeString FCurObject;
	TfrxDataSet* FDataSet;
	System::UnicodeString FDataSetName;
	TfrxReportDataSets* FDataSets;
	TfrxCustomDesigner* FDesigner;
	bool FDotMatrixReport;
	void *FDrawText;
	System::Classes::TStrings* FDrillState;
	TfrxReportDataSets* FEnabledDataSets;
	TfrxCustomEngine* FEngine;
	TfrxEngineOptions* FEngineOptions;
	System::Classes::TStrings* FErrors;
	TfrxExpressionCache* FExpressionCache;
	System::UnicodeString FFileName;
	System::UnicodeString FIniFile;
	System::Classes::TStream* FLoadStream;
	Fmx::Fs_iinterpreter::TfsCustomVariable* FLocalValue;
	Fmx::Fs_iinterpreter::TfsCustomVariable* FSelfValue;
	bool FModified;
	bool FOldStyleProgress;
	Fmx::Forms::TForm* FParentForm;
	System::UnicodeString FParentReport;
	TfrxReport* FParentReportObject;
	TfrxCustomPreviewPages* FPreviewPages;
	TfrxCustomPreview* FPreview;
	Fmx::Forms::TForm* FPreviewForm;
	TfrxPreviewOptions* FPreviewOptions;
	TfrxPrintOptions* FPrintOptions;
	Fmx::Frxprogress::TfrxProgress* FProgress;
	bool FReloading;
	TfrxReportOptions* FReportOptions;
	Fmx::Fs_iinterpreter::TfsScript* FScript;
	System::UnicodeString FScriptLanguage;
	System::Classes::TStrings* FScriptText;
	System::Classes::TStrings* FFakeScriptText;
	bool FShowProgress;
	bool FStoreInDFM;
	TfrxStyles* FStyles;
	System::Classes::TStrings* FSysVariables;
	bool FTerminated;
	Fmx::Types::TTimer* FTimer;
	Fmx::Frxvariables::TfrxVariables* FVariables;
	System::UnicodeString FVersion;
	System::TObject* FXMLSerializer;
	bool FStreamLoaded;
	Fmx::Graphics::TBitmap* FDrawBitmap;
	TfrxBeforePrintEvent FOnAfterPrint;
	System::Classes::TNotifyEvent FOnAfterPrintReport;
	TfrxBeforeConnectEvent FOnBeforeConnect;
	TfrxAfterDisconnectEvent FOnAfterDisconnect;
	TfrxBeforePrintEvent FOnBeforePrint;
	System::Classes::TNotifyEvent FOnBeginDoc;
	TfrxClickObjectEvent FOnClickObject;
	TfrxClickObjectEvent FOnDblClickObject;
	TfrxEditConnectionEvent FOnEditConnection;
	System::Classes::TNotifyEvent FOnEndDoc;
	TfrxGetValueEvent FOnGetValue;
	TfrxNewGetValueEvent FOnNewGetValue;
	TfrxLoadTemplateEvent FOnLoadTemplate;
	TfrxManualBuildEvent FOnManualBuild;
	TfrxMouseOverObjectEvent FOnMouseOverObject;
	System::Classes::TNotifyEvent FOnPreview;
	TfrxPrintPageEvent FOnPrintPage;
	System::Classes::TNotifyEvent FOnPrintReport;
	TfrxProgressEvent FOnProgressStart;
	TfrxProgressEvent FOnProgress;
	TfrxProgressEvent FOnProgressStop;
	TfrxRunDialogsEvent FOnRunDialogs;
	TfrxSetConnectionEvent FOnSetConnection;
	TfrxNotifyEvent FOnStartReport;
	TfrxNotifyEvent FOnStopReport;
	TfrxUserFunctionEvent FOnUserFunction;
	System::Classes::TNotifyEvent FOnClosePreview;
	TfrxNotifyEvent FOnReportPrint;
	System::Classes::TNotifyEvent FOnAfterScriptCompile;
	System::Variant __fastcall CallMethod(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, System::Variant &Params);
	bool __fastcall DoGetValue(const System::UnicodeString Expr, System::Variant &Value);
	System::Variant __fastcall GetScriptValue(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, System::Variant &Params);
	System::Variant __fastcall SetScriptValue(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, System::Variant &Params);
	System::Variant __fastcall DoUserFunction(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, System::Variant &Params);
	System::UnicodeString __fastcall GetDataSetName(void);
	System::Variant __fastcall GetLocalValue(void);
	TfrxView* __fastcall GetSelfValue(void);
	TfrxPage* __fastcall GetPages(int Index);
	int __fastcall GetPagesCount(void);
	bool __fastcall GetCaseSensitive(void);
	System::Classes::TStrings* __fastcall GetScriptText(void);
	void __fastcall AncestorNotFound(System::Classes::TReader* Reader, const System::UnicodeString ComponentName, System::Classes::TPersistentClass ComponentClass, System::Classes::TComponent* &Component);
	void __fastcall DoClear(void);
	void __fastcall DoGetAncestor(const System::UnicodeString Name, System::Classes::TPersistent* &Ancestor);
	void __fastcall DoLoadFromStream(void);
	void __fastcall OnTimer(System::TObject* Sender);
	void __fastcall ReadDatasets(System::Classes::TReader* Reader);
	void __fastcall ReadStyle(System::Classes::TReader* Reader);
	void __fastcall ReadVariables(System::Classes::TReader* Reader);
	void __fastcall SetDataSet(TfrxDataSet* const Value);
	void __fastcall SetDataSetName(const System::UnicodeString Value);
	void __fastcall SetEngineOptions(TfrxEngineOptions* const Value);
	void __fastcall SetSelfValue(TfrxView* const Value);
	void __fastcall SetLocalValue(const System::Variant &Value);
	void __fastcall SetParentReport(const System::UnicodeString Value);
	void __fastcall SetPreviewOptions(TfrxPreviewOptions* const Value);
	void __fastcall SetPrintOptions(TfrxPrintOptions* const Value);
	void __fastcall SetReportOptions(TfrxReportOptions* const Value);
	void __fastcall SetScriptText(System::Classes::TStrings* const Value);
	void __fastcall SetStyles(TfrxStyles* const Value);
	void __fastcall SetTerminated(const bool Value);
	void __fastcall SetCaseSensitive(const bool Value);
	void __fastcall WriteDatasets(System::Classes::TWriter* Writer);
	void __fastcall WriteStyle(System::Classes::TWriter* Writer);
	void __fastcall WriteVariables(System::Classes::TWriter* Writer);
	void __fastcall SetPreview(TfrxCustomPreview* const Value);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TfrxReport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxReport(void);
	virtual void __fastcall Clear(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	Fmx::Graphics::TBitmap* __fastcall GetDrawBitmap(void);
	System::Variant __fastcall Calc(const System::UnicodeString Expr, Fmx::Fs_iinterpreter::TfsScript* AScript = (Fmx::Fs_iinterpreter::TfsScript*)(0x0));
	bool __fastcall DesignPreviewPage(void);
	System::UnicodeString __fastcall GetAlias(TfrxDataSet* DataSet);
	TfrxDataSet* __fastcall GetDataset(const System::UnicodeString Alias);
	System::Inifiles::TCustomIniFile* __fastcall GetIniFile(void);
	System::UnicodeString __fastcall GetApplicationFolder(void);
	bool __fastcall PrepareScript(void);
	bool __fastcall InheritFromTemplate(const System::UnicodeString templName, TfrxInheriteMode InheriteMode = (TfrxInheriteMode)(0x0));
	void __fastcall DesignReport(System::_di_IInterface IDesigner, System::TObject* Editor)/* overload */;
	void __fastcall DoNotifyEvent(System::TObject* Obj, const System::UnicodeString EventName, bool RunAlways = false);
	void __fastcall DoParamEvent(const System::UnicodeString EventName, System::Variant &Params, bool RunAlways = false);
	void __fastcall DoAfterPrint(TfrxReportComponent* c);
	void __fastcall DoBeforePrint(TfrxReportComponent* c);
	void __fastcall DoPreviewClick(TfrxView* v, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, bool &Modified, bool DblClick = false);
	void __fastcall GetDatasetAndField(const System::UnicodeString ComplexName, TfrxDataSet* &Dataset, System::UnicodeString &Field);
	void __fastcall GetDataSetList(System::Classes::TStrings* List, bool OnlyDB = false);
	void __fastcall GetActiveDataSetList(System::Classes::TStrings* List);
	virtual void __fastcall InternalOnProgressStart(TfrxProgressType ProgressType);
	virtual void __fastcall InternalOnProgress(TfrxProgressType ProgressType, int Progress);
	virtual void __fastcall InternalOnProgressStop(TfrxProgressType ProgressType);
	void __fastcall SelectPrinter(void);
	void __fastcall SetProgressMessage(const System::UnicodeString Value, bool Ishint = false);
	void __fastcall CheckDataPage(void);
	void __fastcall AppHandleMessage(void);
	bool __fastcall LoadFromFile(const System::UnicodeString FileName, bool ExceptionIfNotFound = false);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToFile(const System::UnicodeString FileName);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream, bool SaveChildren = true, bool SaveDefaultValues = false, bool UseGetAncestor = false);
	void __stdcall DesignReport(bool Modal = true, bool MDIChild = false)/* overload */;
	bool __fastcall PrepareReport(bool ClearLastReport = true);
	void __stdcall ShowPreparedReport(void);
	void __stdcall ShowReport(bool ClearLastReport = true);
	void __fastcall AddFunction(const System::UnicodeString FuncName, const System::UnicodeString Category = System::UnicodeString(), const System::UnicodeString Description = System::UnicodeString());
	bool __stdcall Print(void);
	bool __fastcall Export(TfrxCustomExportFilter* Filter);
	__property System::UnicodeString CurObject = {read=FCurObject, write=FCurObject};
	__property System::Classes::TStrings* DrillState = {read=FDrillState};
	__property System::Variant LocalValue = {read=GetLocalValue, write=SetLocalValue};
	__property TfrxView* SelfValue = {read=GetSelfValue, write=SetSelfValue};
	__property Fmx::Forms::TForm* PreviewForm = {read=FPreviewForm};
	__property System::TObject* XMLSerializer = {read=FXMLSerializer};
	__property bool Reloading = {read=FReloading, write=FReloading, nodefault};
	__property TfrxReportDataSets* DataSets = {read=FDataSets};
	__property TfrxCustomDesigner* Designer = {read=FDesigner, write=FDesigner};
	__property TfrxReportDataSets* EnabledDataSets = {read=FEnabledDataSets};
	__property TfrxCustomEngine* Engine = {read=FEngine};
	__property System::Classes::TStrings* Errors = {read=FErrors};
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property bool Modified = {read=FModified, write=FModified, nodefault};
	__property TfrxCustomPreviewPages* PreviewPages = {read=FPreviewPages};
	__property TfrxPage* Pages[int Index] = {read=GetPages};
	__property int PagesCount = {read=GetPagesCount, nodefault};
	__property Fmx::Fs_iinterpreter::TfsScript* Script = {read=FScript};
	__property TfrxStyles* Styles = {read=FStyles, write=SetStyles};
	__property bool Terminated = {read=FTerminated, write=SetTerminated, nodefault};
	__property Fmx::Frxvariables::TfrxVariables* Variables = {read=FVariables};
	__property bool CaseSensitiveExpressions = {read=GetCaseSensitive, write=SetCaseSensitive, nodefault};
	__property TfrxEditConnectionEvent OnEditConnection = {read=FOnEditConnection, write=FOnEditConnection};
	__property TfrxSetConnectionEvent OnSetConnection = {read=FOnSetConnection, write=FOnSetConnection};
	
__published:
	__property System::UnicodeString Version = {read=FVersion, write=SetVersion};
	__property System::UnicodeString ParentReport = {read=FParentReport, write=SetParentReport};
	__property TfrxDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property System::UnicodeString DataSetName = {read=GetDataSetName, write=SetDataSetName};
	__property bool DotMatrixReport = {read=FDotMatrixReport, write=FDotMatrixReport, nodefault};
	__property TfrxEngineOptions* EngineOptions = {read=FEngineOptions, write=SetEngineOptions};
	__property System::UnicodeString IniFile = {read=FIniFile, write=FIniFile};
	__property bool OldStyleProgress = {read=FOldStyleProgress, write=FOldStyleProgress, default=1};
	__property TfrxCustomPreview* Preview = {read=FPreview, write=SetPreview};
	__property TfrxPreviewOptions* PreviewOptions = {read=FPreviewOptions, write=SetPreviewOptions};
	__property TfrxPrintOptions* PrintOptions = {read=FPrintOptions, write=SetPrintOptions};
	__property TfrxReportOptions* ReportOptions = {read=FReportOptions, write=SetReportOptions};
	__property System::UnicodeString ScriptLanguage = {read=FScriptLanguage, write=FScriptLanguage};
	__property System::Classes::TStrings* ScriptText = {read=GetScriptText, write=SetScriptText};
	__property bool ShowProgress = {read=FShowProgress, write=FShowProgress, default=1};
	__property bool StoreInDFM = {read=FStoreInDFM, write=FStoreInDFM, default=1};
	__property TfrxBeforePrintEvent OnAfterPrint = {read=FOnAfterPrint, write=FOnAfterPrint};
	__property TfrxBeforeConnectEvent OnBeforeConnect = {read=FOnBeforeConnect, write=FOnBeforeConnect};
	__property TfrxAfterDisconnectEvent OnAfterDisconnect = {read=FOnAfterDisconnect, write=FOnAfterDisconnect};
	__property TfrxBeforePrintEvent OnBeforePrint = {read=FOnBeforePrint, write=FOnBeforePrint};
	__property System::Classes::TNotifyEvent OnBeginDoc = {read=FOnBeginDoc, write=FOnBeginDoc};
	__property TfrxClickObjectEvent OnClickObject = {read=FOnClickObject, write=FOnClickObject};
	__property TfrxClickObjectEvent OnDblClickObject = {read=FOnDblClickObject, write=FOnDblClickObject};
	__property System::Classes::TNotifyEvent OnEndDoc = {read=FOnEndDoc, write=FOnEndDoc};
	__property TfrxGetValueEvent OnGetValue = {read=FOnGetValue, write=FOnGetValue};
	__property TfrxNewGetValueEvent OnNewGetValue = {read=FOnNewGetValue, write=FOnNewGetValue};
	__property TfrxManualBuildEvent OnManualBuild = {read=FOnManualBuild, write=FOnManualBuild};
	__property TfrxMouseOverObjectEvent OnMouseOverObject = {read=FOnMouseOverObject, write=FOnMouseOverObject};
	__property System::Classes::TNotifyEvent OnPreview = {read=FOnPreview, write=FOnPreview};
	__property TfrxPrintPageEvent OnPrintPage = {read=FOnPrintPage, write=FOnPrintPage};
	__property System::Classes::TNotifyEvent OnPrintReport = {read=FOnPrintReport, write=FOnPrintReport};
	__property System::Classes::TNotifyEvent OnAfterPrintReport = {read=FOnAfterPrintReport, write=FOnAfterPrintReport};
	__property TfrxProgressEvent OnProgressStart = {read=FOnProgressStart, write=FOnProgressStart};
	__property TfrxProgressEvent OnProgress = {read=FOnProgress, write=FOnProgress};
	__property TfrxProgressEvent OnProgressStop = {read=FOnProgressStop, write=FOnProgressStop};
	__property TfrxRunDialogsEvent OnRunDialogs = {read=FOnRunDialogs, write=FOnRunDialogs};
	__property TfrxNotifyEvent OnStartReport = {read=FOnStartReport, write=FOnStartReport};
	__property TfrxNotifyEvent OnStopReport = {read=FOnStopReport, write=FOnStopReport};
	__property TfrxUserFunctionEvent OnUserFunction = {read=FOnUserFunction, write=FOnUserFunction};
	__property TfrxLoadTemplateEvent OnLoadTemplate = {read=FOnLoadTemplate, write=FOnLoadTemplate};
	__property System::Classes::TNotifyEvent OnClosePreview = {read=FOnClosePreview, write=FOnClosePreview};
	__property TfrxNotifyEvent OnReportPrint = {read=FOnReportPrint, write=FOnReportPrint};
	__property System::Classes::TNotifyEvent OnAfterScriptCompile = {read=FOnAfterScriptCompile, write=FOnAfterScriptCompile};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxReport(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxComponent(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxCustomDesigner : public Fmx::Frxbasemodalform::TfrxForm
{
	typedef Fmx::Frxbasemodalform::TfrxForm inherited;
	
private:
	TfrxReport* FReport;
	bool FIsPreviewDesigner;
	System::UnicodeString FMemoFontName;
	int FMemoFontSize;
	bool FUseObjectFont;
	Fmx::Forms::TForm* FParentForm;
	
protected:
	bool FModified;
	System::Classes::TList* FObjects;
	TfrxPage* FPage;
	System::Classes::TList* FSelectedObjects;
	virtual void __fastcall SetModified(const bool Value);
	virtual void __fastcall SetPage(TfrxPage* const Value);
	virtual System::Classes::TStrings* __fastcall GetCode(void) = 0 ;
	
public:
	__fastcall TfrxCustomDesigner(System::Classes::TComponent* AOwner, TfrxReport* AReport, bool APreviewDesigner);
	__fastcall virtual ~TfrxCustomDesigner(void);
	virtual void __fastcall FormShow(System::TObject* Sender) = 0 ;
	virtual System::UnicodeString __fastcall InsertExpression(const System::UnicodeString Expr) = 0 ;
	virtual void __fastcall Lock(void) = 0 ;
	virtual void __fastcall ReloadPages(int Index) = 0 ;
	virtual void __fastcall ReloadReport(void) = 0 ;
	virtual void __fastcall UpdateDataTree(void) = 0 ;
	virtual void __fastcall UpdatePage(void) = 0 ;
	virtual void __fastcall UpdateInspector(void) = 0 ;
	virtual void __fastcall Done(void) = 0 ;
	virtual void __fastcall Init(void) = 0 ;
	__property bool IsPreviewDesigner = {read=FIsPreviewDesigner, nodefault};
	__property bool Modified = {read=FModified, write=SetModified, nodefault};
	__property System::Classes::TList* Objects = {read=FObjects};
	__property TfrxReport* Report = {read=FReport};
	__property System::Classes::TList* SelectedObjects = {read=FSelectedObjects};
	__property TfrxPage* Page = {read=FPage, write=SetPage};
	__property System::Classes::TStrings* Code = {read=GetCode};
	__property bool UseObjectFont = {read=FUseObjectFont, write=FUseObjectFont, nodefault};
	__property System::UnicodeString MemoFontName = {read=FMemoFontName, write=FMemoFontName};
	__property int MemoFontSize = {read=FMemoFontSize, write=FMemoFontSize, nodefault};
	__property Fmx::Forms::TForm* ParentForm = {read=FParentForm, write=FParentForm};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxCustomDesigner(System::Classes::TComponent* AOwner) : Fmx::Frxbasemodalform::TfrxForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxCustomDesigner(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Frxbasemodalform::TfrxForm(AOwner, Dummy) { }
	
};


typedef System::TMetaClass* TfrxDesignerClass;

class PASCALIMPLEMENTATION TfrxCustomExportFilter : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FCurPage;
	bool FExportNotPrintable;
	System::UnicodeString FName;
	bool FNoRegister;
	System::UnicodeString FPageNumbers;
	TfrxReport* FReport;
	bool FShowDialog;
	System::Classes::TStream* FStream;
	bool FUseFileCache;
	System::UnicodeString FDefaultPath;
	bool FSlaveExport;
	bool FShowProgress;
	System::UnicodeString FDefaultExt;
	System::UnicodeString FFilterDesc;
	bool FSuppressPageHeadersFooters;
	System::UnicodeString FTitle;
	bool FOverwritePrompt;
	System::Classes::TStrings* FFIles;
	System::Classes::TNotifyEvent FOnBeginExport;
	System::TDateTime FCreationTime;
	bool FDataOnly;
	
public:
	__fastcall virtual TfrxCustomExportFilter(System::Classes::TComponent* AOwner);
	__fastcall TfrxCustomExportFilter(void);
	__fastcall virtual ~TfrxCustomExportFilter(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall ExportObject(TfrxComponent* Obj) = 0 ;
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(TfrxReportPage* Page, int Index);
	__property bool CurPage = {read=FCurPage, write=FCurPage, nodefault};
	__property System::UnicodeString PageNumbers = {read=FPageNumbers, write=FPageNumbers};
	__property TfrxReport* Report = {read=FReport, write=FReport};
	__property System::Classes::TStream* Stream = {read=FStream, write=FStream};
	__property bool SlaveExport = {read=FSlaveExport, write=FSlaveExport, nodefault};
	__property System::UnicodeString DefaultExt = {read=FDefaultExt, write=FDefaultExt};
	__property System::UnicodeString FilterDesc = {read=FFilterDesc, write=FFilterDesc};
	__property bool SuppressPageHeadersFooters = {read=FSuppressPageHeadersFooters, write=FSuppressPageHeadersFooters, nodefault};
	__property System::UnicodeString ExportTitle = {read=FTitle, write=FTitle};
	__property System::Classes::TStrings* Files = {read=FFIles, write=FFIles};
	
__published:
	__property bool ShowDialog = {read=FShowDialog, write=FShowDialog, default=1};
	__property System::UnicodeString FileName = {read=FName, write=FName};
	__property bool ExportNotPrintable = {read=FExportNotPrintable, write=FExportNotPrintable, default=0};
	__property bool UseFileCache = {read=FUseFileCache, write=FUseFileCache, nodefault};
	__property System::UnicodeString DefaultPath = {read=FDefaultPath, write=FDefaultPath};
	__property bool ShowProgress = {read=FShowProgress, write=FShowProgress, nodefault};
	__property bool OverwritePrompt = {read=FOverwritePrompt, write=FOverwritePrompt, nodefault};
	__property System::TDateTime CreationTime = {read=FCreationTime, write=FCreationTime};
	__property bool DataOnly = {read=FDataOnly, write=FDataOnly, nodefault};
	__property System::Classes::TNotifyEvent OnBeginExport = {read=FOnBeginExport, write=FOnBeginExport};
};


class PASCALIMPLEMENTATION TfrxCustomWizard : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	TfrxCustomDesigner* FDesigner;
	TfrxReport* FReport;
	
public:
	__fastcall virtual TfrxCustomWizard(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual bool __fastcall Execute(void) = 0 ;
	__property TfrxCustomDesigner* Designer = {read=FDesigner};
	__property TfrxReport* Report = {read=FReport};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxCustomWizard(void) { }
	
};


typedef System::TMetaClass* TfrxWizardClass;

class PASCALIMPLEMENTATION TfrxCustomEngine : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FCurColumn;
	int FCurVColumn;
	int FCurLine;
	int FCurLineThrough;
	double FCurX;
	double FCurY;
	bool FFinalPass;
	System::Classes::TList* FNotifyList;
	double FPageHeight;
	double FPageWidth;
	TfrxCustomPreviewPages* FPreviewPages;
	TfrxReport* FReport;
	bool FRunning;
	System::TDateTime FStartDate;
	System::TDateTime FStartTime;
	int FTotalPages;
	TfrxRunDialogEvent FOnRunDialog;
	bool FSecondScriptCall;
	bool __fastcall GetDoublePass(void);
	
protected:
	virtual double __fastcall GetPageHeight(void);
	
public:
	__fastcall virtual TfrxCustomEngine(TfrxReport* AReport);
	__fastcall virtual ~TfrxCustomEngine(void);
	virtual void __fastcall EndPage(void) = 0 ;
	virtual void __fastcall BreakAllKeep(void);
	virtual void __fastcall NewColumn(void) = 0 ;
	virtual void __fastcall NewPage(void) = 0 ;
	virtual void __fastcall ShowBand(TfrxBand* Band) = 0 /* overload */;
	virtual void __fastcall ShowBand(TfrxBandClass Band) = 0 /* overload */;
	void __fastcall ShowBandByName(const System::UnicodeString BandName);
	void __fastcall StopReport(void);
	virtual double __fastcall HeaderHeight(void) = 0 ;
	virtual double __fastcall FooterHeight(void) = 0 ;
	virtual double __fastcall FreeSpace(void) = 0 ;
	virtual System::Variant __fastcall GetAggregateValue(const System::UnicodeString Name, const System::UnicodeString Expression, TfrxBand* Band, int Flags) = 0 ;
	virtual bool __fastcall Run(void) = 0 ;
	__property int CurLine = {read=FCurLine, write=FCurLine, nodefault};
	__property int CurLineThrough = {read=FCurLineThrough, write=FCurLineThrough, nodefault};
	__property System::Classes::TList* NotifyList = {read=FNotifyList};
	__property TfrxCustomPreviewPages* PreviewPages = {read=FPreviewPages};
	__property TfrxReport* Report = {read=FReport};
	__property bool Running = {read=FRunning, write=FRunning, nodefault};
	__property TfrxRunDialogEvent OnRunDialog = {read=FOnRunDialog, write=FOnRunDialog};
	
__published:
	__property int CurColumn = {read=FCurColumn, write=FCurColumn, nodefault};
	__property int CurVColumn = {read=FCurVColumn, write=FCurVColumn, nodefault};
	__property double CurX = {read=FCurX, write=FCurX};
	__property double CurY = {read=FCurY, write=FCurY};
	__property bool DoublePass = {read=GetDoublePass, nodefault};
	__property bool FinalPass = {read=FFinalPass, write=FFinalPass, nodefault};
	__property double PageHeight = {read=GetPageHeight, write=FPageHeight};
	__property double PageWidth = {read=FPageWidth, write=FPageWidth};
	__property System::TDateTime StartDate = {read=FStartDate, write=FStartDate};
	__property System::TDateTime StartTime = {read=FStartTime, write=FStartTime};
	__property int TotalPages = {read=FTotalPages, write=FTotalPages, nodefault};
	__property bool SecondScriptCall = {read=FSecondScriptCall, write=FSecondScriptCall, nodefault};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCustomOutline : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Fmx::Frxxml::TfrxXMLItem* FCurItem;
	TfrxCustomPreviewPages* FPreviewPages;
	
protected:
	virtual int __fastcall GetCount(void) = 0 ;
	
public:
	__fastcall virtual TfrxCustomOutline(TfrxCustomPreviewPages* APreviewPages);
	virtual void __fastcall AddItem(const System::UnicodeString Text, int Top) = 0 ;
	virtual void __fastcall LevelDown(int Index) = 0 ;
	virtual void __fastcall LevelRoot(void) = 0 ;
	virtual void __fastcall LevelUp(void) = 0 ;
	virtual void __fastcall GetItem(int Index, System::UnicodeString &Text, int &Page, int &Top) = 0 ;
	virtual void __fastcall ShiftItems(Fmx::Frxxml::TfrxXMLItem* From, int NewTop) = 0 ;
	TfrxCustomEngine* __fastcall Engine(void);
	virtual Fmx::Frxxml::TfrxXMLItem* __fastcall GetCurPosition(void) = 0 ;
	__property int Count = {read=GetCount, nodefault};
	__property Fmx::Frxxml::TfrxXMLItem* CurItem = {read=FCurItem, write=FCurItem};
	__property TfrxCustomPreviewPages* PreviewPages = {read=FPreviewPages};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxCustomOutline(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCustomPreviewPages : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TfrxAddPageAction FAddPageAction;
	int FCurPage;
	int FCurPreviewPage;
	TfrxCustomEngine* FEngine;
	int FFirstPage;
	TfrxCustomOutline* FOutline;
	TfrxReport* FReport;
	
protected:
	virtual int __fastcall GetCount(void) = 0 ;
	virtual TfrxReportPage* __fastcall GetPage(int Index) = 0 ;
	virtual System::Types::TPoint __fastcall GetPageSize(int Index) = 0 ;
	
public:
	__fastcall virtual TfrxCustomPreviewPages(TfrxReport* AReport);
	__fastcall virtual ~TfrxCustomPreviewPages(void);
	virtual void __fastcall Clear(void) = 0 ;
	virtual void __fastcall Initialize(void) = 0 ;
	virtual void __fastcall AddObject(TfrxComponent* Obj) = 0 ;
	virtual void __fastcall AddPage(TfrxReportPage* Page) = 0 ;
	virtual void __fastcall AddSourcePage(TfrxReportPage* Page) = 0 ;
	virtual void __fastcall AddToSourcePage(TfrxComponent* Obj) = 0 ;
	virtual void __fastcall BeginPass(void) = 0 ;
	virtual void __fastcall ClearFirstPassPages(void) = 0 ;
	virtual void __fastcall CutObjects(int APosition) = 0 ;
	virtual void __fastcall Finish(void) = 0 ;
	virtual void __fastcall IncLogicalPageNumber(void) = 0 ;
	virtual void __fastcall ResetLogicalPageNumber(void) = 0 ;
	virtual void __fastcall PasteObjects(System::Extended X, System::Extended Y) = 0 ;
	virtual void __fastcall ShiftAnchors(int From, int NewTop) = 0 ;
	virtual void __fastcall AddPicture(TfrxPictureView* Picture) = 0 ;
	virtual bool __fastcall BandExists(TfrxBand* Band) = 0 ;
	virtual int __fastcall GetCurPosition(void) = 0 ;
	virtual int __fastcall GetAnchorCurPosition(void) = 0 ;
	virtual System::Extended __fastcall GetLastY(System::Extended ColumnPosition = 0.000000E+00) = 0 ;
	virtual int __fastcall GetLogicalPageNo(void) = 0 ;
	virtual int __fastcall GetLogicalTotalPages(void) = 0 ;
	virtual void __fastcall AddEmptyPage(int Index) = 0 ;
	virtual void __fastcall DeletePage(int Index) = 0 ;
	virtual void __fastcall ModifyPage(int Index, TfrxReportPage* Page) = 0 ;
	virtual void __fastcall DrawPage(int Index, Fmx::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY, const System::Types::TRectF &WorkArea) = 0 ;
	virtual void __fastcall ObjectOver(int Index, int X, int Y, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, System::Extended Scale, System::Extended OffsetX, System::Extended OffsetY, bool Click, System::Uitypes::TCursor &Cursor, bool DBClick = false) = 0 ;
	virtual void __fastcall AddFrom(TfrxReport* Report) = 0 ;
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream, bool AllowPartialLoading = false) = 0 ;
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream) = 0 ;
	virtual bool __fastcall LoadFromFile(const System::UnicodeString FileName, bool ExceptionIfNotFound = false) = 0 ;
	virtual void __fastcall SaveToFile(const System::UnicodeString FileName) = 0 ;
	virtual bool __fastcall Print(void) = 0 ;
	virtual bool __fastcall Export(TfrxCustomExportFilter* Filter) = 0 ;
	__property TfrxAddPageAction AddPageAction = {read=FAddPageAction, write=FAddPageAction, nodefault};
	__property int Count = {read=GetCount, nodefault};
	__property int CurPage = {read=FCurPage, write=FCurPage, nodefault};
	__property int CurPreviewPage = {read=FCurPreviewPage, write=FCurPreviewPage, nodefault};
	__property TfrxCustomEngine* Engine = {read=FEngine};
	__property int FirstPage = {read=FFirstPage, write=FFirstPage, nodefault};
	__property TfrxCustomOutline* Outline = {read=FOutline};
	__property TfrxReportPage* Page[int Index] = {read=GetPage};
	__property System::Types::TPoint PageSize[int Index] = {read=GetPageSize};
	__property TfrxReport* Report = {read=FReport};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxCustomPreview : public Fmx::Controls::TControl
{
	typedef Fmx::Controls::TControl inherited;
	
private:
	TfrxCustomPreviewPages* FPreviewPages;
	TfrxReport* FReport;
	bool FUseReportHints;
	
public:
	HIDESBASE virtual Fmx::Graphics::TCanvas* __fastcall GetCanvas(void) = 0 ;
	virtual void __fastcall Init(void) = 0 ;
	HIDESBASE virtual void __fastcall ShowHint(const System::Types::TRectF &aRect, System::UnicodeString Text) = 0 ;
	virtual void __fastcall HideHint(void) = 0 ;
	virtual void __fastcall ClearBackBuffer(void) = 0 ;
	HIDESBASE virtual void __fastcall Lock(void) = 0 ;
	virtual void __fastcall Unlock(void) = 0 ;
	virtual void __fastcall RefreshReport(void) = 0 ;
	virtual void __fastcall InternalOnProgressStart(TfrxReport* Sender, TfrxProgressType ProgressType, int Progress) = 0 ;
	virtual void __fastcall InternalOnProgress(TfrxReport* Sender, TfrxProgressType ProgressType, int Progress) = 0 ;
	virtual void __fastcall InternalOnProgressStop(TfrxReport* Sender, TfrxProgressType ProgressType, int Progress) = 0 ;
	__property TfrxCustomPreviewPages* PreviewPages = {read=FPreviewPages, write=FPreviewPages};
	__property TfrxReport* Report = {read=FReport, write=FReport};
	__property bool UseReportHints = {read=FUseReportHints, write=FUseReportHints, nodefault};
public:
	/* TControl.Create */ inline __fastcall virtual TfrxCustomPreview(System::Classes::TComponent* AOwner) : Fmx::Controls::TControl(AOwner) { }
	/* TControl.Destroy */ inline __fastcall virtual ~TfrxCustomPreview(void) { }
	
};


typedef System::TMetaClass* TfrxCompressorClass;

class PASCALIMPLEMENTATION TfrxCustomCompressor : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FIsFR3File;
	TfrxCompressorClass FOldCompressor;
	TfrxReport* FReport;
	System::Classes::TStream* FStream;
	System::UnicodeString FTempFile;
	
public:
	__fastcall virtual TfrxCustomCompressor(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxCustomCompressor(void);
	virtual bool __fastcall Decompress(System::Classes::TStream* Source) = 0 ;
	virtual void __fastcall Compress(System::Classes::TStream* Dest) = 0 ;
	void __fastcall CreateStream(void);
	__property bool IsFR3File = {read=FIsFR3File, write=FIsFR3File, nodefault};
	__property TfrxReport* Report = {read=FReport, write=FReport};
	__property System::Classes::TStream* Stream = {read=FStream, write=FStream};
};


typedef System::TMetaClass* TfrxCrypterClass;

class PASCALIMPLEMENTATION TfrxCustomCrypter : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	System::Classes::TStream* FStream;
	
public:
	__fastcall virtual TfrxCustomCrypter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxCustomCrypter(void);
	virtual bool __fastcall Decrypt(System::Classes::TStream* Source, const System::AnsiString Key) = 0 ;
	virtual void __fastcall Crypt(System::Classes::TStream* Dest, const System::AnsiString Key) = 0 ;
	void __fastcall CreateStream(void);
	__property System::Classes::TStream* Stream = {read=FStream, write=FStream};
};


typedef bool __fastcall (__closure *TfrxLoadEvent)(TfrxReport* Sender, System::Classes::TStream* Stream);

typedef void __fastcall (__closure *TfrxAfterLoadEvent)(TfrxReport* Sender);

typedef System::Variant __fastcall (__closure *TfrxGetScriptValueEvent)(System::Variant &Params);

class PASCALIMPLEMENTATION TfrxConverterEvents : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TfrxGetValueEvent FOnGetValue;
	System::Classes::TNotifyEvent FOnPrepareScript;
	TfrxLoadEvent FOnLoad;
	TfrxAfterLoadEvent FOnAfterLoad;
	TfrxGetScriptValueEvent FOnGetScriptValue;
	System::UnicodeString FFilter;
	
public:
	__property TfrxGetValueEvent OnGetValue = {read=FOnGetValue, write=FOnGetValue};
	__property System::Classes::TNotifyEvent OnPrepareScript = {read=FOnPrepareScript, write=FOnPrepareScript};
	__property TfrxLoadEvent OnLoad = {read=FOnLoad, write=FOnLoad};
	__property TfrxAfterLoadEvent OnAfterLoad = {read=FOnAfterLoad, write=FOnAfterLoad};
	__property TfrxGetScriptValueEvent OnGetScriptValue = {read=FOnGetScriptValue, write=FOnGetScriptValue};
	__property System::UnicodeString Filter = {read=FFilter, write=FFilter};
public:
	/* TObject.Create */ inline __fastcall TfrxConverterEvents(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxConverterEvents(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxGlobalDataSetList : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	System::Syncobjs::TCriticalSection* FCriticalSection;
	__fastcall TfrxGlobalDataSetList(void);
	__fastcall virtual ~TfrxGlobalDataSetList(void);
	void __fastcall Lock(void);
	void __fastcall Unlock(void);
};

#pragma pack(pop)

typedef System::TMetaClass* TfrxCanvasClass;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE double fr01cm;
extern DELPHI_PACKAGE double fr1cm;
extern DELPHI_PACKAGE double fr01in;
extern DELPHI_PACKAGE int fr1in;
extern DELPHI_PACKAGE double fr1CharX;
extern DELPHI_PACKAGE int fr1CharY;
extern DELPHI_PACKAGE int frxDefPPI;
extern DELPHI_PACKAGE TfrxDesignerClass frxDesignerClass;
extern DELPHI_PACKAGE TfrxCustomExportFilter* frxDotMatrixExport;
extern DELPHI_PACKAGE TfrxCompressorClass frxCompressorClass;
extern DELPHI_PACKAGE TfrxCrypterClass frxCrypterClass;
extern DELPHI_PACKAGE TfrxConverterEvents* frxConverter;
extern DELPHI_PACKAGE System::Syncobjs::TCriticalSection* frxCS;
extern DELPHI_PACKAGE Fmx::Frxvariables::TfrxVariables* frxGlobalVariables;
extern DELPHI_PACKAGE TfrxCanvasClass frxCanvasClass;
#define FR_VERSION u"2.6.8"
static const System::Int8 BND_COUNT = System::Int8(0x12);
extern DELPHI_PACKAGE System::StaticArray<TfrxComponentClass, 18> frxBands;
extern DELPHI_PACKAGE TfrxDataSet* __fastcall frxFindDataSet(TfrxDataSet* DataSet, const System::UnicodeString Name, System::Classes::TComponent* Owner);
extern DELPHI_PACKAGE void __fastcall frxGetDataSetList(System::Classes::TStrings* List);
}	/* namespace Frxclass */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXCLASS)
using namespace Fmx::Frxclass;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxclassHPP
