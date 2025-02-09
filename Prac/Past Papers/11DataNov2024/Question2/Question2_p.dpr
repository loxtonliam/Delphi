program Question2_p;

uses
  Vcl.Forms,
  Question2_u in 'Question2_u.pas' {frmQuestion2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmQuestion2, frmQuestion2);
  Application.Run;
end.
