program VehicleManagementApp;

uses
  Vcl.Forms,
  LoginScreenUI in 'LoginScreenUI.pas' {frmLogin},
  DBConnection in 'DBConnection.pas' {DataModule1: TDataModule},
  SignUpScreenUI in 'SignUpScreenUI.pas' {frmSignup},
  MainScreenUI in 'MainScreenUI.pas' {frmMain},
  Shared_U in 'Shared_U.pas',
  LicenseGenerationUI in 'LicenseGenerationUI.pas' {frmLicenseGen},
  ProfileUI in 'ProfileUI.pas' {frmProfile},
  RoutingUI in 'RoutingUI.pas' {frmRouting},
  FinesUI in 'FinesUI.pas' {frmFines},
  Fines_U in 'Fines_U.pas',
  TestsUI in 'TestsUI.pas' {frmTests};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmFines, frmFines);
  Application.CreateForm(TfrmRouting, frmRouting);
  Application.CreateForm(TfrmLicenseGen, frmLicenseGen);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmSignup, frmSignup);
  Application.CreateForm(TfrmProfile, frmProfile);
  Application.CreateForm(TfrmTests, frmTests);
  Application.Run;
end.
