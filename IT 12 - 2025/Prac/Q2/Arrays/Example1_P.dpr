program Example1_P;

uses
  Vcl.Forms,
  Example1_U in '\\Mac\Home\Documents\Embarcadero\Studio\Projects\Example1_U.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
