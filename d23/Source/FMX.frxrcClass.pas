{******************************************}
{                                          }
{             FastReport v4.0              }
{          Language resource file          }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMX.frxrcClass;

interface

{$I fmx.inc}

implementation

uses FMX.frxRes;

const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1252"><StrRes Name="1" Text="OK"/><StrRes Name="2" Text="Cancel"/><StrRes Name="3" Text="Al' + 
'l"/><StrRes Name="4" Text="Current page"/><StrRes Name="5" Text="Pages:"/><StrRes Name="6" Text="Page breaks"/><StrRes Name="7" Text="Page range"/><St' + 
'rRes Name="8" Text="Export settings"/><StrRes Name="9" Text="Enter page numbers and/or page ranges, separated by commas. For example, 1,3,5-12"/><StrR' + 
'es Name="100" Text="Preview"/><StrRes Name="101" Text="Print"/><StrRes Name="102" Text="Print"/><StrRes Name="103" Text="Open"/><StrRes Name="104" Tex' + 
't="Open"/><StrRes Name="105" Text="Save"/><StrRes Name="106" Text="Save"/><StrRes Name="107" Text="Export"/><StrRes Name="108" Text="Export"/><StrRes ' + 
'Name="109" Text="Find"/><StrRes Name="110" Text="Find"/><StrRes Name="111" Text="Whole Page"/><StrRes Name="112" Text="Whole Page"/><StrRes Name="113"' + 
' Text="Page Width"/><StrRes Name="114" Text="Page Width"/><StrRes Name="115" Text="100%"/><StrRes Name="116" Text="100%"/><StrRes Name="117" Text="Two' + 
' Pages"/><StrRes Name="118" Text="Two Pages"/><StrRes Name="119" Text="Zoom"/><StrRes Name="120" Text="Page Settings"/><StrRes Name="121" Text="Page S' + 
'ettings"/><StrRes Name="122" Text="Outline"/><StrRes Name="123" Text="Outline"/><StrRes Name="124" Text="Zoom In"/><StrRes Name="125" Text="Zoom In"/>' + 
'<StrRes Name="126" Text="Zoom Out"/><StrRes Name="127" Text="Zoom Out"/><StrRes Name="128" Text="Outline"/><StrRes Name="129" Text="Report outline"/><' + 
'StrRes Name="130" Text="Thumbnails"/><StrRes Name="131" Text="Thumbnails"/><StrRes Name="132" Text="Edit"/><StrRes Name="133" Text="Edit Page"/><StrRe' + 
's Name="134" Text="First"/><StrRes Name="135" Text="First Page"/><StrRes Name="136" Text="Prior"/><StrRes Name="137" Text="Prior Page"/><StrRes Name="' + 
'138" Text="Next"/><StrRes Name="139" Text="Next Page"/><StrRes Name="140" Text="Last"/><StrRes Name="141" Text="Last Page"/><StrRes Name="142" Text="P' + 
'age Number"/><StrRes Name="150" Text="Full Screen"/><StrRes Name="151" Text="Export to PDF"/><StrRes Name="152" Text="Send by E-mail"/><StrRes Name="z' + 
'mPageWidth" Text="Page width"/><StrRes Name="zmWholePage" Text="Whole page"/><StrRes Name="200" Text="Print"/><StrRes Name="201" Text="Printer"/><StrR' + 
'es Name="202" Text="Pages"/><StrRes Name="203" Text="Number of copies"/><StrRes Name="204" Text="Collate"/><StrRes Name="205" Text="Copies"/><StrRes N' + 
'ame="206" Text="Print"/><StrRes Name="207" Text="!Other"/><StrRes Name="208" Text="Where:"/><StrRes Name="209" Text="Properties..."/><StrRes Name="210' + 
'" Text="Print to file"/><StrRes Name="211" Text="!Order"/><StrRes Name="212" Text="Name:"/><StrRes Name="213" Text="Print mode"/><StrRes Name="214" Te' + 
'xt="Print on sheet"/><StrRes Name="216" Text="Duplex"/><StrRes Name="ppAll" Text="All pages"/><StrRes Name="ppOdd" Text="Odd pages"/><StrRes Name="ppE' + 
'ven" Text="Even pages"/><StrRes Name="pgDefault" Text="Default"/><StrRes Name="pmDefault" Text="Default"/><StrRes Name="pmSplit" Text="Split big pages' + 
'"/><StrRes Name="pmJoin" Text="Join small pages"/><StrRes Name="pmScale" Text="Scale"/><StrRes Name="poDirect" Text="!Direct (1-9)"/><StrRes Name="poR' + 
'everse" Text="!Reverse (9-1)"/><StrRes Name="300" Text="Find Text"/><StrRes Name="301" Text="Text to find:"/><StrRes Name="302" Text="Search options"/' + 
'><StrRes Name="303" Text="Replace with"/><StrRes Name="304" Text="Search from beginning"/><StrRes Name="305" Text="Case sensitive"/><StrRes Name="400"' + 
' Text="Page Settings"/><StrRes Name="401" Text="Width"/><StrRes Name="402" Text="Height"/><StrRes Name="403" Text="Size"/><StrRes Name="404" Text="Ori' + 
'entation"/><StrRes Name="405" Text="Left"/><StrRes Name="406" Text="Top"/><StrRes Name="407" Text="Right"/><StrRes Name="408" Text="Bottom"/><StrRes N' + 
'ame="409" Text="Margins"/><StrRes Name="410" Text="Portrait"/><StrRes Name="411" Text="Landscape"/><StrRes Name="412" Text="Other"/><StrRes Name="413"' + 
' Text="Apply to the current page"/><StrRes Name="414" Text="Apply to all pages"/><StrRes Name="500" Text="Print"/><StrRes Name="501" Text="Printer"/><' + 
'StrRes Name="502" Text="Pages"/><StrRes Name="503" Text="Copies"/><StrRes Name="504" Text="Number of copies"/><StrRes Name="505" Text="Options"/><StrR' + 
'es Name="506" Text="Escape commands"/><StrRes Name="507" Text="Print to file"/><StrRes Name="508" Text="OEM codepage"/><StrRes Name="509" Text="Pseudo' + 
'graphic"/><StrRes Name="510" Text="Printer file (*.prn)|*.prn"/><StrRes Name="mbConfirm" Text="Confirm"/><StrRes Name="mbError" Text="Error"/><StrRes ' + 
'Name="mbInfo" Text="Information"/><StrRes Name="xrCantFindClass" Text="Cannot find class"/><StrRes Name="prVirtual" Text="Virtual"/><StrRes Name="prDe' + 
'fault" Text="Default"/><StrRes Name="prCustom" Text="Custom"/><StrRes Name="enUnconnHeader" Text="Unconnected header/footer"/><StrRes Name="enUnconnGr' + 
'oup" Text="No data band for the group"/><StrRes Name="enUnconnGFooter" Text="No group header for"/><StrRes Name="enBandPos" Text="Incorrect band posit' + 
'ion:"/><StrRes Name="dbNotConn" Text="DataSet %s is not connected to data"/><StrRes Name="dbFldNotFound" Text="Field not found:"/><StrRes Name="clDSNo' + 
'tIncl" Text="(dataset is not included in Report.DataSets)"/><StrRes Name="clUnknownVar" Text="Unknown variable or datafield:"/><StrRes Name="clScrErro' + 
'r" Text="Script error at %s: %s"/><StrRes Name="clDSNotExist" Text="Dataset &#38;#34;%s&#38;#34; does not exist"/><StrRes Name="clErrors" Text="The fo' + 
'llowing error(s) have occured:"/><StrRes Name="clExprError" Text="Error in expression"/><StrRes Name="clFP3files" Text="Prepared Report"/><StrRes Name' + 
'="clSaving" Text="Saving file..."/><StrRes Name="clCancel" Text="Cancel"/><StrRes Name="clClose" Text="Close"/><StrRes Name="clPrinting" Text="Printin' + 
'g page"/><StrRes Name="clLoading" Text="Loading file..."/><StrRes Name="clPageOf" Text="Page %d of %d"/><StrRes Name="clFirstPass" Text="First pass: p' + 
'age "/><StrRes Name="clNoPrinters" Text="You have no printers installed"/><StrRes Name="clDecompressError" Text="Stream decompress error"/><StrR' + 
'es Name="crFillMx" Text="Filling the cross-tab..."/><StrRes Name="crBuildMx" Text="Building the cross-tab..."/><StrRes Name="prRunningFirst" Text="Fir' + 
'st pass: page %d"/><StrRes Name="prRunning" Text="Preparing page %d"/><StrRes Name="prPrinting" Text="Printing page %d"/><StrRes Name="prExporting" Te' + 
'xt="Exporting page %d"/><StrRes Name="uCm" Text="cm"/><StrRes Name="uInch" Text="in"/><StrRes Name="uPix" Text="px"/><StrRes Name="uChar" Text="chr"/>' + 
'<StrRes Name="dupDefault" Text="Default"/><StrRes Name="dupVert" Text="Vertical"/><StrRes Name="dupHorz" Text="Horizontal"/><StrRes Name="dupSimpl" Te' + 
'xt="Simplex"/><StrRes Name="SLangNotFound" Text="Language ''%s'' not found"/><StrRes Name="SInvalidLanguage" Text="Invalid language definition"/><StrRes' + 
' Name="SIdRedeclared" Text="Identifier redeclared: "/><StrRes Name="SUnknownType" Text="Unknown type: "/><StrRes Name="SIncompatibleTypes" Text="Incom' + 
'patible types"/><StrRes Name="SIdUndeclared" Text="Undeclared identifier: "/><StrRes Name="SClassRequired" Text="Class type required"/><StrRes Name="S' + 
'IndexRequired" Text="Index required"/><StrRes Name="SStringError" Text="Strings do not have properties or methods"/><StrRes Name="SClassError" Text="C' + 
'lass %s does not have a default property"/><StrRes Name="SArrayRequired" Text="Array type required"/><StrRes Name="SVarRequired" Text="Variable requir' + 
'ed"/><StrRes Name="SNotEnoughParams" Text="Not enough actual parameters"/><StrRes Name="STooManyParams" Text="Too many actual parameters"/><StrRes Nam' + 
'e="SLeftCantAssigned" Text="Left side cannot be assigned to"/><StrRes Name="SForError" Text="For loop variable must be numeric variable"/><StrRes Name' + 
'="SEventError" Text="Event handler must be a procedure"/><StrRes Name="600" Text="Expand all"/><StrRes Name="601" Text="Collapse all"/><StrRes Name="c' + 
'lStrNotFound" Text="Text not found"/></Resources>' + 
' ';

initialization
  frxResources.AddXML(resXML);

end.


//56db3b0f55102b9488a240d37950543f