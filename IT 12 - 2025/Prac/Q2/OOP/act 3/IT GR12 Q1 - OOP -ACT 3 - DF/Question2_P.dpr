program Question2_P;

uses
  Forms,
  Question2_U in 'Question2_U.pas' {frmQuestion2},
  CardHolder_U in 'CardHolder_U.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmQuestion2, frmQuestion2);
  Application.Run;
end.
