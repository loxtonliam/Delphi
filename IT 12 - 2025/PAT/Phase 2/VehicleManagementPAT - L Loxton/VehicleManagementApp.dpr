program VehicleManagementApp;

uses
  Vcl.Forms,
  LoginScreenUI in 'LoginScreenUI.pas' {frmLogin},
  DBConnection in 'DBConnection.pas' {DataModule1: TDataModule},
  SignUpScreenUI in 'SignUpScreenUI.pas' {frmSignup},
  MainScreenUI in 'MainScreenUI.pas' {frmMain},
  Shared_U in 'Shared_U.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmSignup, frmSignup);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
