program Question4_p;

uses
  Vcl.Forms,
  frmHealthyLiving_u in 'frmHealthyLiving_u.pas' {frmHealthyLiving};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHealthyLiving, frmHealthyLiving);
  Application.Run;
end.
