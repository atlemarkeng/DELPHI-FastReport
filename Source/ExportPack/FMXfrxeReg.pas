
{******************************************}
{                                          }
{             FastReport v4.0              }
{         Exports Registration unit        }
{                                          }
{         Copyright (c) 1998-2008          }
{          by Alexander Fediachov,         }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit FMXfrxeReg;

{$I frx.inc}

interface


procedure Register;

implementation

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Forms,
  DesignIntf, DesignEditors,
{$IFNDEF RAD_ED}
  FMX.frxExportXML, FMX.frxExportRTF, //frxExportXLS, frxExportMail,
 // FMX.frxExportODF, // frxExportDBF, frxExportBIFF,
{$ENDIF}
  FMX.frxExportHTML, FMX.frxExportImage,
  FMX.frxExportPDF, FMX.frxExportText, FMX.frxExportCSV;

{-----------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents('FastReport FMX 2.0 Exports',
    [
{$IFNDEF RAD_ED}
      TfrxXMLExport, TfrxRTFExport,
//     TfrxXLSExport, TfrxMailExport,
    //  TfrxODSExport, TfrxODTExport,
//      TfrxDBFExport, TfrxBIFFExport,
{$ENDIF}
      TfrxPDFExport, TfrxHTMLExport, 
      TfrxBMPExport, TfrxJPEGExport, TfrxTIFFExport,
      TfrxGIFExport, TfrxSimpleTextExport, TfrxCSVExport]);
end;

end.
