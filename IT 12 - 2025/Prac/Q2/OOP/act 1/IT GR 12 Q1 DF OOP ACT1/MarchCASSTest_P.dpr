program MarchCASSTest_P;

uses
  Forms,
  ComputerUI_u in 'ComputerUI_u.pas' {Form1},
  clsComputer in 'clsComputer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
