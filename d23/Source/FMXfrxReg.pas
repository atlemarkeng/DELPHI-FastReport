
{******************************************}
{                                          }
{             FastReport v4.0              }
{            Registration unit             }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit FMXfrxReg;

{$I frx.inc}
//{$I frxReg.inc}

interface


procedure Register;

implementation

uses
  System.SysUtils, System.Classes, System.Types, System.UITypes,  FMX.Types, FMX.Controls, FMX.Forms,
  DesignIntf, DesignEditors,
  FMX.Dialogs, FMX.frxClass,
  FMX.frxCtrls, FMX.frxDesgnCtrls,
  FMX.frxDesgn, FMX.frxPreview, FMX.frxRes, FMX.frxFMX, FMX.frxEditAliases,
{$IFNDEF RAD_ED}
{$IFNDEF FR_VER_BASIC}
  FMX.frxDCtrl,
{$ENDIF}
  FMX.frxCross, FMX.frxBarcode2DView, FMX.frxBarcode, FMX.frxChBox,
{$ENDIF}
FMX.frxGradient;

{-----------------------------------------------------------------------}
type
  TfrxReportEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): String; override;
    function GetVerbCount: Integer; override;
  end;

  TfrxDataSetEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): String; override;
    function GetVerbCount: Integer; override;
  end;


{ TfrxReportEditor }

procedure TfrxReportEditor.ExecuteVerb(Index: Integer);
var
  Report: TfrxReport;
begin
  Report := TfrxReport(Component);
  if Report.Designer <> nil then
    Report.Designer.BringToFront
  else
  begin
    Report.DesignReport(Designer, Self);
    if Report.StoreInDFM then
      Designer.Modified;
  end;
end;

function TfrxReportEditor.GetVerb(Index: Integer): String;
begin
  Result := 'Edit report';//frxResources.Get('rpEditRep');
end;

function TfrxReportEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;


{ TfrxDataSetEditor }

procedure TfrxDataSetEditor.ExecuteVerb(Index: Integer);
begin
  with TfrxAliasesEditorForm.Create(Application) do
  begin
    DataSet := TfrxCustomDBDataSet(Component);
    FormShow(Self);
    if ShowModal = mrOk then
      Self.Designer.Modified;
    Free;
  end;
end;

function TfrxDataSetEditor.GetVerb(Index: Integer): String;
begin
  Result := frxResources.Get('rpEditAlias');
end;

function TfrxDataSetEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;


{-----------------------------------------------------------------------}
procedure Register;
begin
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  RegisterComponents('FastReport 2.0 FMX',
    [TfrxReport, TfrxUserDataset,
{$IFNDEF RAD_ED}
{$IFNDEF FR_VER_BASIC}
     TfrxDesigner,
{$ENDIF}
{$ENDIF}
     TfrxPreview
{$IFNDEF RAD_ED}
     , TfrxCrossObject,
     TfrxGradientObject
     , Tfrx2DBarCodeObject
     , TfrxBarCodeObject
	 , TfrxCheckBoxObject
{$IFNDEF FR_VER_BASIC}
     , TfrxDialogControls
{$ENDIF}
{$ENDIF}
     ]);
  //GroupDescendentsWith(TfrxReport, TControl);
  //GroupDescendentsWith(TfrxUserDataSet, TControl);
  //GroupDescendentsWith(TfrxCrypt, TControl);
  //GroupDescendentsWith(TfrxCheckBoxObject, TControl);
  //GroupDescendentsWith(TfrxGradientObject, TControl);
  //GroupDescendentsWith(TfrxGZipCompressor, TControl);
  //GroupDescendentsWith(TfrxDotMatrixExport, TControl);
  //GroupDescendentsWith(TfrxBarCodeObject, TControl);
  RegisterComponents('FR FMX tools',
    [TfrxToolButton]);
      RegisterComponents('FR FMX tools',
    [TfrxRuler, TfrxScrollBox, TfrxTreeView, TfrxListBox]);

  RegisterComponentEditor(TfrxReport, TfrxReportEditor);
  RegisterComponentEditor(TfrxCustomDBDataSet, TfrxDataSetEditor);
end;

end.


//56db3b0f55102b9488a240d37950543f