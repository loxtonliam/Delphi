program Question1_P;

uses
  Vcl.Forms,
  Question1_u in 'Question1_u.pas' {frmQuestion1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmQuestion1, frmQuestion1);
  Application.Run;
end.
