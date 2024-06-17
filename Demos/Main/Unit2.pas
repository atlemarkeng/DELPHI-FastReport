unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ExtCtrls, FMX.TreeView, FMX.Edit,
  FMX.frxClass, FMX.frxDesgn, FMX.frxCross, FMX.frxChart, FMX.frxGradient,
  FMX.frxExportText, FMX.frxExportHTML, FMX.frxExportImage, FMX.frxExportXML, FMX.frxExportCSV, FMX.frxExportPDF,
  FMX.frxExportRTF, 
  FMX.ConverterFR3toFRFMX, FMX.frxChBox
{$IFDEF VER250}
  ,FMX.StdCtrls
{$ENDIF}
{$IFDEF VER260}
, FMX.Graphics
,FMX.StdCtrls
{$ENDIF}
{$IFDEF VER270}
, FMX.Graphics
,FMX.StdCtrls
{$ENDIF}
{$IFDEF VER280}
, FMX.Graphics
,FMX.StdCtrls
{$ENDIF}
{$IFDEF VER290}
, FMX.Graphics
,FMX.StdCtrls
{$ENDIF}
{$IFDEF VER300}
, FMX.Graphics
,FMX.StdCtrls
{$ENDIF}
{$IFDEF VER310}
, FMX.Graphics
,FMX.StdCtrls
{$ENDIF}
{$IFDEF VER320}
, FMX.Graphics
,FMX.StdCtrls
{$ENDIF}
 {$IFDEF MSWINDOWS}
 , Winapi.ShellAPI, Winapi.Windows
 {$ENDIF}
 {$IFDEF MACOS}
 , Posix.Stdlib
{$ENDIF};

type

  TForm2 = class(TForm)
    ToolBar1: TToolBar;
    TreeView1: TTreeView;
    UnicodeI: TTreeViewItem;
    TreeViewItem2: TTreeViewItem;
    TreeViewItem3: TTreeViewItem;
    TreeViewItem4: TTreeViewItem;
    TreeViewItem5: TTreeViewItem;
    TreeViewItem6: TTreeViewItem;
    Image1: TImage;
    Lb1: TLabel;
    TreeViewItem1: TTreeViewItem;
    Label2: TLabel;
    btnPreview: TButton;
    TreeViewItem7: TTreeViewItem;
    TreeViewItem8: TTreeViewItem;
    TreeViewItem9: TTreeViewItem;
    TreeViewItem10: TTreeViewItem;
    TreeViewItem11: TTreeViewItem;
    TreeViewItem12: TTreeViewItem;
    TreeViewItem13: TTreeViewItem;
    TreeViewItem14: TTreeViewItem;
    TreeViewItem15: TTreeViewItem;
    TreeViewItem16: TTreeViewItem;
    TreeViewItem17: TTreeViewItem;
    TreeViewItem18: TTreeViewItem;
    TreeViewItem19: TTreeViewItem;
    TreeViewItem20: TTreeViewItem;
    TreeViewItem21: TTreeViewItem;
    TreeViewItem22: TTreeViewItem;
    TreeViewItem24: TTreeViewItem;
    TreeViewItem25: TTreeViewItem;
    TreeViewItem26: TTreeViewItem;
    TreeViewItem27: TTreeViewItem;
    TreeViewItem28: TTreeViewItem;
    Charts: TTreeViewItem;
    TreeViewItem31: TTreeViewItem;
    TreeViewItem32: TTreeViewItem;
    TreeViewItem33: TTreeViewItem;
    TreeViewItem34: TTreeViewItem;
    TreeViewItem47: TTreeViewItem;
    TreeViewItem48: TTreeViewItem;
    TreeViewItem49: TTreeViewItem;
    TreeViewItem50: TTreeViewItem;
    TreeViewItem51: TTreeViewItem;
    Panel3: TPanel;
    TreeViewItem23: TTreeViewItem;
    TreeViewItem30: TTreeViewItem;
    TreeViewItem39: TTreeViewItem;
    TreeViewItem40: TTreeViewItem;
    TreeViewItem41: TTreeViewItem;
    TreeViewItem42: TTreeViewItem;
    TreeViewItem43: TTreeViewItem;
    Label6: TLabel;
    btnDesign: TButton;
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Change(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure btnDesignClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
  private
    FReport: TfrxReport;
    FTXTExport: TfrxSimpleTextExport;
    FHTMLExport: TfrxHTMLExport;
    FJPEGExport: TfrxJPEGExport;
    FTfrxGIFExport: TfrxGIFExport;
    FPNGExport: TfrxPNGExport;
    FTIFFExport: TfrxTIFFExport;
    FBMPExport: TfrxBMPExport;
    FXMLExport: TfrxXMLExport;
    FRTFExport: TfrxRTFExport;
    FPDFExport: TfrxPDFExport;
    FCSVExport: TfrxCSVExport;
    FAppDir: String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.FormCreate(Sender: TObject);
begin
   FAppDir := ExtractFilePath(ParamStr(0));
   FReport := TfrxReport.Create(Self);

   FTXTExport := TfrxSimpleTextExport.Create(Self);
   FHTMLExport := TfrxHTMLExport.Create(Self);
   FJPEGExport := TfrxJPEGExport.Create(Self);
   FTfrxGIFExport := TfrxGIFExport.Create(Self);
   FPNGExport := TfrxPNGExport.Create(Self);
   FTIFFExport := TfrxTIFFExport.Create(Self);
   FBMPExport := TfrxBMPExport.Create(Self);
   FXMLExport := TfrxXMLExport.Create(Self);
   FRTFExport := TfrxRTFExport.Create(Self);
   FPDFExport := TfrxPDFExport.Create(Self);
   FCSVExport := TfrxCSVExport.Create(Self);
   TreeView1.ExpandAll;
   TreeView1.Selected := TreeView1.Items[0].Items[0];
end;

procedure TForm2.btnDesignClick(Sender: TObject);
begin
  FReport.DesignReport;
end;

procedure TForm2.btnPreviewClick(Sender: TObject);
begin
  FReport.ShowReport;
end;

procedure TForm2.TreeView1Change(Sender: TObject);
begin
  FReport.LoadFromFile(FAppDir + PathDelim + IntToStr(TreeView1.Selected.Tag) + '.fr3');
  Label2.Text := FReport.ReportOptions.Description.Text;
  FReport.Script.AddVariable('wPath', 'String',  FAppDir{ + PathDelim});
end;

procedure TForm2.Label6Click(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
  ShellExecute(0, 'open', PChar('http://www.fast-report.com'), '', '', SW_SHOWNORMAL);
{$ENDIF}
{$IFDEF MACOS}
  _system(PAnsiChar('open ' + AnsiString('http://www.fast-report.com')));
{$ENDIF}
end;

end.