// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxDMPClass.pas' rev: 30.00 (MacOS)

#ifndef Fmx_FrxdmpclassHPP
#define Fmx_FrxdmpclassHPP

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
#include <System.Variants.hpp>
#include <FMX.frxClass.hpp>
#include <System.WideStrings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxdmpclass
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxDMPMemoView;
class DELPHICLASS TfrxDMPLineView;
class DELPHICLASS TfrxDMPCommand;
class DELPHICLASS TfrxDMPPage;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxDMPFontStyle : unsigned char { fsxBold, fsxItalic, fsxUnderline, fsxSuperScript, fsxSubScript, fsxCondensed, fsxWide, fsx12cpi, fsx15cpi };

typedef System::Set<TfrxDMPFontStyle, TfrxDMPFontStyle::fsxBold, TfrxDMPFontStyle::fsx15cpi> TfrxDMPFontStyles;

class PASCALIMPLEMENTATION TfrxDMPMemoView : public Fmx::Frxclass::TfrxCustomMemoView
{
	typedef Fmx::Frxclass::TfrxCustomMemoView inherited;
	
private:
	TfrxDMPFontStyles FFontStyle;
	bool FTruncOutboundText;
	void __fastcall SetFontStyle(const TfrxDMPFontStyles Value);
	bool __fastcall IsFontStyleStored(void);
	
protected:
	virtual void __fastcall DrawFrame(void);
	virtual void __fastcall SetLeft(double Value);
	virtual void __fastcall SetTop(double Value);
	virtual void __fastcall SetWidth(double Value);
	virtual void __fastcall SetHeight(double Value);
	virtual void __fastcall SetParentFont(const bool Value);
	
public:
	__fastcall virtual TfrxDMPMemoView(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	void __fastcall ResetFontOptions(void);
	void __fastcall SetBoundsDirect(double ALeft, double ATop, double AWidth, double AHeight);
	virtual double __fastcall CalcHeight(void);
	virtual double __fastcall CalcWidth(void);
	virtual System::UnicodeString __fastcall Diff(Fmx::Frxclass::TfrxComponent* AComponent);
	System::UnicodeString __fastcall GetoutBoundText(void);
	
__published:
	__property AutoWidth = {default=0};
	__property AllowExpressions = {default=1};
	__property DataField = {default=0};
	__property DataSet;
	__property DataSetName = {default=0};
	__property DisplayFormat;
	__property ExpressionDelimiters = {default=0};
	__property FlowTo;
	__property TfrxDMPFontStyles FontStyle = {read=FFontStyle, write=SetFontStyle, stored=IsFontStyleStored, nodefault};
	__property Frame;
	__property HAlign = {default=0};
	__property HideZeros = {default=0};
	__property Memo;
	__property ParentFont = {default=1};
	__property RTLReading = {default=0};
	__property SuppressRepeated = {default=0};
	__property WordWrap = {default=1};
	__property bool TruncOutboundText = {read=FTruncOutboundText, write=FTruncOutboundText, nodefault};
	__property VAlign = {default=0};
public:
	/* TfrxCustomMemoView.Destroy */ inline __fastcall virtual ~TfrxDMPMemoView(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDMPMemoView(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxCustomMemoView(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDMPLineView : public Fmx::Frxclass::TfrxCustomLineView
{
	typedef Fmx::Frxclass::TfrxCustomLineView inherited;
	
private:
	TfrxDMPFontStyles FFontStyle;
	void __fastcall SetFontStyle(const TfrxDMPFontStyles Value);
	bool __fastcall IsFontStyleStored(void);
	
protected:
	virtual void __fastcall SetLeft(double Value);
	virtual void __fastcall SetTop(double Value);
	virtual void __fastcall SetWidth(double Value);
	virtual void __fastcall SetParentFont(const bool Value);
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual System::UnicodeString __fastcall Diff(Fmx::Frxclass::TfrxComponent* AComponent);
	
__published:
	__property TfrxDMPFontStyles FontStyle = {read=FFontStyle, write=SetFontStyle, stored=IsFontStyleStored, nodefault};
	__property ParentFont = {default=1};
public:
	/* TfrxCustomLineView.Create */ inline __fastcall virtual TfrxDMPLineView(System::Classes::TComponent* AOwner) : Fmx::Frxclass::TfrxCustomLineView(AOwner) { }
	/* TfrxCustomLineView.DesignCreate */ inline __fastcall virtual TfrxDMPLineView(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxCustomLineView(AOwner, Flags) { }
	
public:
	/* TfrxView.Destroy */ inline __fastcall virtual ~TfrxDMPLineView(void) { }
	
};


class PASCALIMPLEMENTATION TfrxDMPCommand : public Fmx::Frxclass::TfrxView
{
	typedef Fmx::Frxclass::TfrxView inherited;
	
private:
	System::UnicodeString FCommand;
	
protected:
	virtual void __fastcall SetLeft(double Value);
	virtual void __fastcall SetTop(double Value);
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual System::UnicodeString __fastcall Diff(Fmx::Frxclass::TfrxComponent* AComponent);
	System::UnicodeString __fastcall ToChr(void);
	
__published:
	__property System::UnicodeString Command = {read=FCommand, write=FCommand};
public:
	/* TfrxView.Create */ inline __fastcall virtual TfrxDMPCommand(System::Classes::TComponent* AOwner) : Fmx::Frxclass::TfrxView(AOwner) { }
	/* TfrxView.Destroy */ inline __fastcall virtual ~TfrxDMPCommand(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDMPCommand(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxView(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxDMPPage : public Fmx::Frxclass::TfrxReportPage
{
	typedef Fmx::Frxclass::TfrxReportPage inherited;
	
private:
	TfrxDMPFontStyles FFontStyle;
	void __fastcall SetFontStyle(const TfrxDMPFontStyles Value);
	
protected:
	virtual void __fastcall SetPaperHeight(const double Value);
	virtual void __fastcall SetPaperWidth(const double Value);
	virtual void __fastcall SetPaperSize(const int Value);
	
public:
	__fastcall virtual TfrxDMPPage(System::Classes::TComponent* AOwner);
	virtual void __fastcall SetDefaults(void);
	void __fastcall ResetFontOptions(void);
	
__published:
	__property TfrxDMPFontStyles FontStyle = {read=FFontStyle, write=SetFontStyle, nodefault};
public:
	/* TfrxReportPage.Destroy */ inline __fastcall virtual ~TfrxDMPPage(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDMPPage(System::Classes::TComponent* AOwner, System::Word Flags) : Fmx::Frxclass::TfrxReportPage(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdmpclass */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXDMPCLASS)
using namespace Fmx::Frxdmpclass;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxdmpclassHPP
