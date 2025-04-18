program Question3_P;

uses
  Forms,
  Question3_U in 'Question3_U.pas' {frmProperty},
  Property_U in 'Property_U.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmProperty, frmProperty);
  Application.Run;
end.
