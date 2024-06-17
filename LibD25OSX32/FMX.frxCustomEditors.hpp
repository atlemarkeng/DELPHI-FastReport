// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.frxCustomEditors.pas' rev: 32.00 (MacOS)

#ifndef Fmx_FrxcustomeditorsHPP
#define Fmx_FrxcustomeditorsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Menus.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.frxClass.hpp>
#include <FMX.frxDMPClass.hpp>
#include <FMX.frxDsgnIntf.hpp>
#include <System.Variants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Frxcustomeditors
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxViewEditor;
class DELPHICLASS TfrxCustomMemoEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxViewEditor : public Fmx::Frxdsgnintf::TfrxComponentEditor
{
	typedef Fmx::Frxdsgnintf::TfrxComponentEditor inherited;
	
public:
	virtual void __fastcall GetMenuItems(System::Classes::TNotifyEvent OnClickEvent);
	virtual bool __fastcall Execute(int Tag, bool Checked);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall TfrxViewEditor(Fmx::Frxclass::TfrxComponent* Component, Fmx::Frxclass::TfrxCustomDesigner* Designer, Fmx::Menus::TPopupMenu* Menu) : Fmx::Frxdsgnintf::TfrxComponentEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxViewEditor(void) { }
	
};


class PASCALIMPLEMENTATION TfrxCustomMemoEditor : public TfrxViewEditor
{
	typedef TfrxViewEditor inherited;
	
public:
	virtual void __fastcall GetMenuItems(System::Classes::TNotifyEvent OnClickEvent);
	virtual bool __fastcall Execute(int Tag, bool Checked);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall TfrxCustomMemoEditor(Fmx::Frxclass::TfrxComponent* Component, Fmx::Frxclass::TfrxCustomDesigner* Designer, Fmx::Menus::TPopupMenu* Menu) : TfrxViewEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxCustomMemoEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxcustomeditors */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FRXCUSTOMEDITORS)
using namespace Fmx::Frxcustomeditors;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_FrxcustomeditorsHPP
