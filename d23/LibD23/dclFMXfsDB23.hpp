﻿// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dclFMXfsDB23.dpk' rev: 30.00 (Windows)

#ifndef Dclfmxfsdb23HPP
#define Dclfmxfsdb23HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// (rtl)
#include <SysInit.hpp>
#include <FMXfs_idbreg.hpp>
#include <Winapi.Windows.hpp>	// (rtl)
#include <System.Character.hpp>	// (rtl)
#include <System.Internal.ExcUtils.hpp>	// (rtl)
#include <System.SysUtils.hpp>	// (rtl)
#include <System.VarUtils.hpp>	// (rtl)
#include <System.Variants.hpp>	// (rtl)
#include <System.AnsiStrings.hpp>	// (rtl)
#include <System.Math.hpp>	// (rtl)
#include <System.Generics.Defaults.hpp>	// (rtl)
#include <System.Rtti.hpp>	// (rtl)
#include <System.TypInfo.hpp>	// (rtl)
#include <System.Classes.hpp>	// (rtl)
#include <System.TimeSpan.hpp>	// (rtl)
#include <System.DateUtils.hpp>	// (rtl)
#include <System.IOUtils.hpp>	// (rtl)
#include <System.Win.Registry.hpp>	// (rtl)
#include <Vcl.Graphics.hpp>	// (vcl)
#include <System.Actions.hpp>	// (rtl)
#include <Vcl.ActnList.hpp>	// (vcl)
#include <System.HelpIntfs.hpp>	// (rtl)
#include <System.SyncObjs.hpp>	// (rtl)
#include <Winapi.UxTheme.hpp>	// (rtl)
#include <Vcl.GraphUtil.hpp>	// (vcl)
#include <Vcl.StdCtrls.hpp>	// (vcl)
#include <Winapi.ShellAPI.hpp>	// (rtl)
#include <Vcl.Printers.hpp>	// (vcl)
#include <Vcl.Clipbrd.hpp>	// (vcl)
#include <Vcl.ComCtrls.hpp>	// (vcl)
#include <Vcl.Dialogs.hpp>	// (vcl)
#include <Vcl.ExtCtrls.hpp>	// (vcl)
#include <Vcl.Themes.hpp>	// (vcl)
#include <System.Win.ComObj.hpp>	// (rtl)
#include <Winapi.FlatSB.hpp>	// (rtl)
#include <Vcl.Forms.hpp>	// (vcl)
#include <Vcl.Menus.hpp>	// (vcl)
#include <Winapi.MsCTF.hpp>	// (rtl)
#include <Vcl.Controls.hpp>	// (vcl)
#include <System.Messaging.hpp>	// (rtl)
#include <System.Devices.hpp>	// (rtl)
#include <FMX.TextLayout.hpp>	// (fmx)
#include <FMX.Utils.hpp>	// (fmx)
#include <FMX.Graphics.hpp>	// (fmx)
#include <FMX.BehaviorManager.hpp>	// (fmx)
#include <FMX.Styles.hpp>	// (fmx)
#include <FMX.Types3D.hpp>	// (fmx)
#include <FMX.Filter.hpp>	// (fmx)
#include <FMX.Filter.Custom.hpp>	// (fmx)
#include <FMX.Effects.hpp>	// (fmx)
#include <FMX.MultiResBitmap.hpp>	// (fmx)
#include <FMX.Ani.hpp>	// (fmx)
#include <FMX.Objects.hpp>	// (fmx)
#include <FMX.Dialogs.hpp>	// (fmx)
#include <FMX.ImgList.hpp>	// (fmx)
#include <FMX.Menus.hpp>	// (fmx)
#include <FMX.Helpers.Win.hpp>	// (fmx)
#include <Winapi.GDIPOBJ.hpp>	// (rtl)
#include <FMX.Canvas.GDIP.hpp>	// (fmx)
#include <FMX.Printer.hpp>	// (fmx)
#include <FMX.Presentation.Factory.hpp>	// (fmx)
#include <FMX.Controls.Win.hpp>	// (fmx)
#include <FMX.Presentation.Win.hpp>	// (fmx)
#include <FMX.Presentation.Win.Style.hpp>	// (fmx)
#include <FMX.Controls.Presentation.hpp>	// (fmx)
#include <FMX.Styles.Objects.hpp>	// (fmx)
#include <FMX.Styles.Switch.hpp>	// (fmx)
#include <FMX.Switch.Style.hpp>	// (fmx)
#include <FMX.Switch.Win.hpp>	// (fmx)
#include <FMX.StdCtrls.hpp>	// (fmx)
#include <FMX.InertialMovement.hpp>	// (fmx)
#include <FMX.Layouts.hpp>	// (fmx)
#include <FMX.MagnifierGlass.hpp>	// (fmx)
#include <FMX.Edit.Style.hpp>	// (fmx)
#include <FMX.Edit.Win.hpp>	// (fmx)
#include <FMX.Edit.hpp>	// (fmx)
#include <FMX.Dialogs.Win.hpp>	// (fmx)
#include <Winapi.D2D1.hpp>	// (rtl)
#include <FMX.Canvas.D2D.hpp>	// (fmx)
#include <FMX.Canvas.GPU.Helpers.hpp>	// (fmx)
#include <FMX.FontGlyphs.hpp>	// (fmx)
#include <FMX.TextLayout.GPU.hpp>	// (fmx)
#include <FMX.Canvas.GPU.hpp>	// (fmx)
#include <FMX.Context.DX9.hpp>	// (fmx)
#include <FMX.Context.DX11.hpp>	// (fmx)
#include <FMX.ListBox.hpp>	// (fmx)
#include <FMX.DateTimeCtrls.Types.hpp>	// (fmx)
#include <FMX.DateTimeCtrls.hpp>	// (fmx)
#include <FMX.Calendar.Style.hpp>	// (fmx)
#include <FMX.Calendar.hpp>	// (fmx)
#include <FMX.Pickers.hpp>	// (fmx)
#include <FMX.ExtCtrls.hpp>	// (fmx)
#include <System.Win.InternetExplorer.hpp>	// (rtl)
#include <FMX.WebBrowser.hpp>	// (fmx)
#include <FMX.Platform.Win.hpp>	// (fmx)
#include <FMX.Gestures.Win.hpp>	// (fmx)
#include <FMX.Gestures.hpp>	// (fmx)
#include <FMX.Controls.hpp>	// (fmx)
#include <FMX.Header.hpp>	// (fmx)
#include <FMX.Forms.hpp>	// (fmx)
#include <FMX.Platform.hpp>	// (fmx)
#include <FMX.Types.hpp>	// (fmx)
#include <FMX.fs_iconst.hpp>	// (FMXfs23)
#include <FMX.fs_itools.hpp>	// (FMXfs23)
#include <FMX.fs_iinterpreter.hpp>	// (FMXfs23)
#include <FMX.fs_iclassesrtti.hpp>	// (FMXfs23)
#include <Data.SqlTimSt.hpp>	// (dbrtl)
#include <Data.FmtBcd.hpp>	// (dbrtl)
#include <Data.DB.hpp>	// (dbrtl)
#include <FMX.fs_idbrtti.hpp>	// (FMXfsDB23)

//-- user supplied -----------------------------------------------------------

namespace Dclfmxfsdb23
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
}	/* namespace Dclfmxfsdb23 */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_DCLFMXFSDB23)
using namespace Dclfmxfsdb23;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Dclfmxfsdb23HPP
