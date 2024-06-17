// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.fs_iilparser.pas' rev: 30.00 (Windows)

#ifndef Fmx_Fs_iilparserHPP
#define Fmx_Fs_iilparserHPP

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
#include <FMX.fs_iparser.hpp>
#include <FMX.fs_iexpression.hpp>
#include <FMX.fs_xml.hpp>
#include <System.Variants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Fs_iilparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfsILParser;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfsEmitOp : unsigned char { emNone, emCreate, emFree };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfsILParser : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FErrorPos;
	Fmx::Fs_xml::TfsXMLDocument* FGrammar;
	Fmx::Fs_xml::TfsXMLDocument* FILScript;
	System::UnicodeString FLangName;
	bool FNeedDeclareVars;
	Fmx::Fs_iparser::TfsParser* FParser;
	Fmx::Fs_iinterpreter::TfsScript* FProgram;
	Fmx::Fs_xml::TfsXMLItem* FProgRoot;
	Fmx::Fs_xml::TfsXMLItem* FRoot;
	System::UnicodeString FUnitName;
	System::Classes::TStrings* FUsesList;
	System::Classes::TStringList* FWithList;
	System::UnicodeString __fastcall PropPos(Fmx::Fs_xml::TfsXMLItem* xi);
	void __fastcall ErrorPos(Fmx::Fs_xml::TfsXMLItem* xi);
	void __fastcall CheckIdent(Fmx::Fs_iinterpreter::TfsScript* Prog, const System::UnicodeString Name);
	Fmx::Fs_iinterpreter::TfsClassVariable* __fastcall FindClass(const System::UnicodeString TypeName);
	void __fastcall CheckTypeCompatibility(Fmx::Fs_iinterpreter::TfsCustomVariable* Var1, Fmx::Fs_iinterpreter::TfsCustomVariable* Var2);
	Fmx::Fs_iinterpreter::TfsCustomVariable* __fastcall FindVar(Fmx::Fs_iinterpreter::TfsScript* Prog, const System::UnicodeString Name);
	Fmx::Fs_iinterpreter::TfsVarType __fastcall FindType(System::UnicodeString s);
	Fmx::Fs_iinterpreter::TfsCustomVariable* __fastcall CreateVar(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, const System::UnicodeString Name, Fmx::Fs_iinterpreter::TfsStatement* Statement = (Fmx::Fs_iinterpreter::TfsStatement*)(0x0), bool CreateParam = false, bool IsVarParam = false);
	Fmx::Fs_iinterpreter::TfsSetExpression* __fastcall DoSet(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog);
	Fmx::Fs_iexpression::TfsExpression* __fastcall DoExpression(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog);
	void __fastcall DoUses(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog);
	void __fastcall DoVar(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoConst(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog);
	void __fastcall DoParameters(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsProcVariable* v);
	void __fastcall DoProc1(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog);
	void __fastcall DoProc2(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog);
	void __fastcall DoFunc1(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog);
	void __fastcall DoFunc2(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog);
	void __fastcall DoAssign(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoCall(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoIf(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoFor(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoVbFor(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoCppFor(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoWhile(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoRepeat(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoCase(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoTry(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoBreak(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoContinue(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoExit(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoReturn(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoWith(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoDelete(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoCompoundStmt(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoStmt(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, Fmx::Fs_iinterpreter::TfsStatement* Statement);
	void __fastcall DoProgram(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog);
	
public:
	__fastcall TfsILParser(Fmx::Fs_iinterpreter::TfsScript* AProgram);
	__fastcall virtual ~TfsILParser(void);
	void __fastcall SelectLanguage(const System::UnicodeString LangName);
	bool __fastcall MakeILScript(const System::UnicodeString Text);
	void __fastcall ParseILScript(void);
	Fmx::Fs_iinterpreter::TfsDesignator* __fastcall DoDesignator(Fmx::Fs_xml::TfsXMLItem* xi, Fmx::Fs_iinterpreter::TfsScript* Prog, TfsEmitOp EmitOp = (TfsEmitOp)(0x0));
	__property Fmx::Fs_xml::TfsXMLDocument* ILScript = {read=FILScript};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Fs_iilparser */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_FS_IILPARSER)
using namespace Fmx::Fs_iilparser;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_Fs_iilparserHPP
