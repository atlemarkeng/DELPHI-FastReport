unit FMX.frxChartGallery;
{$I frx.inc}
{$I tee.inc}
interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMXTee.Procs, FMXTee.Engine, FMXTee.Chart, FMXTee.Series,
  FMX.frxFMX, FMXTee.Chart.GalleryPanel, FMXTee.Constants, FMX.TabControl
{$IFDEF DELPHI18}
  ,FMX.StdCtrls
{$ENDIF};

type
  TfrxChartGalleryForm = class(TForm)
    ToolBar1: TToolBar;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
  private
    FTeePanel: TChartGalleryPanel;
    FTabs: TTabControl;
    { Private declarations }
  public
    function GetGallery: TChartGalleryPanel;
    { Public declarations }
  end;


implementation

{$R *.fmx}
procedure TfrxChartGalleryForm.FormCreate(Sender: TObject);
var
  tItem: TTabItem;
  I: Integer;
  SCGallary: array[0 .. 6] of String;
begin
  SCGallary[0] := TeeMsg_GalleryStandard;
  SCGallary[1] := TeeMsg_GalleryExtended;
  SCGallary[2] := '3D';
  SCGallary[3] := 'Stats';
  SCGallary[4] := 'Financial';
  SCGallary[5] := 'Gauges';
  SCGallary[6] := 'Other';
  FTabs := TTabControl.Create(self);
  FTabs.Parent := Self;
  FTabs.Visible := True;
  FTabs.Align := TAlignLayout.alClient;
  FTabs.TabHeight := 20;

  for I := 0 to High(SCGallary) do
  begin
    tItem := TTabItem.Create(FTabs);
    tItem.Parent :=  FTabs;
    tItem.Text := SCGallary[i];
    FTabs.AddObject(tItem);
    tItem.Align := TAlignLayout.alClient;

    FTeePanel := TChartGalleryPanel.Create(tItem);
    FTeePanel.Parent := tItem;
    FTeePanel.Visible := True;
    FTeePanel.Align := TAlignLayout.alClient;
    FTeePanel.CreateGalleryPage(SCGallary[i]);
    tItem.Tag := Integer(FTeePanel);
  end;
  FTabs.TabIndex := 0;
end;

function TfrxChartGalleryForm.GetGallery: TChartGalleryPanel;
begin
  Result := TChartGalleryPanel(FTabs.ActiveTab.Tag);
end;

end.
