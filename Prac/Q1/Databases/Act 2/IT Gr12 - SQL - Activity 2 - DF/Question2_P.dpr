program Question2_P;

uses
  Forms,
  Question2_U in 'Question2_U.pas' {frmQuestion2},
  dmQuestion2_U in 'dmQuestion2_U.pas' {dmQuestion2: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmQuestion2, frmQuestion2);
  Application.CreateForm(TdmQuestion2, dmQuestion2);
  Application.Run;
end.
