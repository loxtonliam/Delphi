program Example1_P;

uses
  Vcl.Forms,
  Example1_U in 'Example1_U.pas' {Form3},
  Vehicle_U in 'Vehicle_U.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
