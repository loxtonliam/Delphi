program Hospital_p;

uses
  Vcl.Forms,
  Question2_u in 'Question2_u.pas' {frmQuestion2},
//  DataModule_u in 'DataModule_u.pas' {dbmBarista: TDataModule},
  TDBConnection_U in 'TDBConnection_U.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmQuestion2, frmQuestion2);
//  Application.CreateForm(TdbmBarista, dbmBarista);
  Application.Run;
end.
