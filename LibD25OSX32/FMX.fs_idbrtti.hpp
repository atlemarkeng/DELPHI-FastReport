// CodeGear C++Builder
// Copyright (c) 1995, 2017 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.fs_idbrtti.pas' rev: 32.00 (MacOS)

#ifndef Fmx_Fs_idbrttiHPP
#define Fmx_Fs_idbrttiHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.fs_iinterpreter.hpp>
#include <FMX.fs_itools.hpp>
#include <FMX.fs_iclassesrtti.hpp>
#include <FMX.fs_ievents.hpp>
#include <Data.DB.hpp>
#include <FMX.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Fs_idbrtti
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfsDBRTTI;
class DELPHICLASS TfsDatasetNotifyEvent;
class DELPHICLASS TfsFilterRecordEvent;
class DELPHICLASS TfsFieldGetTextEvent;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfsDBRTTI : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfsDBRTTI(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfsDBRTTI(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfsDatasetNotifyEvent : public Fmx::Fs_iinterpreter::TfsCustomEvent
{
	typedef Fmx::Fs_iinterpreter::TfsCustomEvent inherited;
	
public:
	void __fastcall DoEvent(Data::Db::TDataSet* Dataset);
	virtual void * __fastcall GetMethod(void);
public:
	/* TfsCustomEvent.Create */ inline __fastcall virtual TfsDatasetNotifyEvent(System::TObject* AObject, Fmx::Fs_iinterpreter::TfsProcVariable* AHandler) : Fmx::Fs_iinterpreter::TfsCustomEvent(AObject, AHandler) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfsDatasetNotifyEvent(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfsFilterRecordEvent : public Fmx::Fs_iinterpreter::TfsCustomEvent
{
	typedef Fmx::Fs_iinterpreter::TfsCustomEvent inherited;
	
public:
	void __fastcall DoEvent(Data::Db::TDataSet* DataSet, bool &Accept);
	virtual void * __fastcall GetMethod(void);
public:
	/* TfsCustomEvent.Create */ inline __fastcall virtual TfsFilterRecordEvent(System::TObject* AObject, Fmx::Fs_iinterpreter::TfsProcVariable* AHandler) : Fmx::Fs_iinterpreter::TfsCustomEvent(AObject, AHandler) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfsFilterRecordEvent(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfsFieldGetTextEvent : public Fmx::Fs_iinterpreter::TfsCustomEvent
{
	typedef Fmx::Fs_iinterpreter::TfsCustomEvent inherited;
	
public:
	void __fastcall DoEvent(Data::Db::TField* Sender, System::UnicodeString &Text, bool DisplayText);
	virtual void * __fastcall GetMethod(void);
public:
	/* TfsCustomEvent.Create */ inline __fastcall virtual TfsFieldGetTextEvent(System::TObject* AObject, Fmx::Fs_iinterpreter::TfsProcVariable* AHandler) : Fmx::Fs_iinterpreter::TfsCustomEvent(AObject, AHandler) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfsFieldGetTextEvent(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Fs_idbrtti */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FS_IDBRTTI)
using namespace Fmx::Fs_idbrtti;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_Fs_idbrttiHPP
