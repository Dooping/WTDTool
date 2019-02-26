program WTD;

uses
  Vcl.Forms,
  Dashboard in 'Dashboard.pas' {Form1},
  Clock in 'Clock.pas' {Form2},
  Registry in 'Registry.pas' {Form3},
  SnapshotArea in 'SnapshotArea.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
