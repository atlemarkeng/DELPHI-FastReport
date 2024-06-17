program Project1;
uses
  FMX.Forms,
  FMX.Types,
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {DataModule3: TDataModule};

{$R *.res}

begin

  GlobalUseDirect2D := False;
  Application.Initialize;
  Application.CreateForm(TDataModule3, DataModule3);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
