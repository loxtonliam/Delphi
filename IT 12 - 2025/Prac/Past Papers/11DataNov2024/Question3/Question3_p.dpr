program Question3_p;

uses
  Vcl.Forms,
  Question3_u in 'Question3_u.pas' {frmQ3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmQ3, frmQ3);
  Application.Run;
end.
