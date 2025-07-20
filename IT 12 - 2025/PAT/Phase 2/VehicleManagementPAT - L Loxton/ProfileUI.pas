unit ProfileUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmProfile = class(TForm)
    imgBG: TImage;
    Image2: TImage;
    lblTitle: TLabel;
    imgLoginButton: TImage;
    redAccountInfo: TRichEdit;
    btnLogout: TButton;
    imgBlueMenuBar: TImage;
    pnlMenu: TPanel;
    lblStationsMenu: TLabel;
    lblMenuLicenses: TLabel;
    lblFinesMenu: TLabel;
    imgWhiteMenu: TImage;
    btnProfile: TImage;
    procedure imgLoginButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure imgWhiteMenuClick(Sender: TObject);
    procedure lblMenuLicensesClick(Sender: TObject);
    procedure lblStationsMenuClick(Sender: TObject);
    procedure lblFinesMenuClick(Sender: TObject);
    procedure lblTestsMenuClick(Sender: TObject);
    procedure imgBlueMenuBarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProfile: TfrmProfile;

implementation

{$R *.dfm}

uses
  DBConnection, LoginScreenUI, Shared_U;

procedure TfrmProfile.btnLogoutClick(Sender: TObject);
// Logs out user after confirmation
var
  response: string;
begin
  response := UpperCase(InputBox('', 'Are you sure you want to logout? Y/N', ''));
  if response = 'Y' then
  begin
    frmProfile.Hide;
    frmLogin.Show;
    sID := '';
    bAdmin := false;
  end
  else if response = 'N' then
  begin
    ShowMessage('Logout cancelled');
  end
  else
  begin
    ShowMessage('Invalid answer, please answer with either Y or N');
  end;
end; // procedure btnLogoutClick

procedure TfrmProfile.FormClose(Sender: TObject; var Action: TCloseAction);
// Terminates application on form close
begin
  Application.Terminate;
end; // procedure FormClose

procedure TfrmProfile.FormShow(Sender: TObject);
// Displays user account info in RichEdit when form is shown
begin
  DataModule1.OpenTables;
  redAccountInfo.Clear;
  redAccountInfo.Lines.Add(DataModule1.userToString(sID));
  pnlMenu.Hide;
end; // procedure FormShow

procedure TfrmProfile.imgBlueMenuBarClick(Sender: TObject);
// Shows menu panel
begin
  pnlMenu.Show;
end; // procedure imgBlueMenuBarClick

procedure TfrmProfile.imgLoginButtonClick(Sender: TObject);
// Deletes user account after confirmation
var
  response: string;
begin
  response := UpperCase(InputBox('Are you sure you want to delete your account? Y/N', '', ''));
  if response = 'Y' then
  begin
    if sID = '' then
    begin
      ShowMessage('No user ID found, contact an Admin');
      Exit;
    end;

    with DataModule1 do
    begin
      try
        ADOQuery1.Close;
        ADOQuery1.SQL.Text := 'DELETE FROM tblUsers WHERE userID = "' + sID + '"';
        ADOQuery1.ExecSQL;

        ShowMessage('Account successfully deleted');
        frmProfile.Hide;
        frmLogin.Show;
      except
        on E: Exception do
          ShowMessage('Problem with deletion: ' + E.Message);
      end; // try..except
    end; // with
  end
  else if response = 'N' then
  begin
    ShowMessage('Deletion cancelled');
  end
  else
  begin
    ShowMessage('Invalid answer, please answer with either Y or N');
  end;
end; // procedure imgLoginButtonClick

procedure TfrmProfile.imgWhiteMenuClick(Sender: TObject);
// Hides menu panel
begin
  pnlMenu.Hide;
end; // procedure imgWhiteMenuClick

procedure TfrmProfile.lblFinesMenuClick(Sender: TObject);
// Navigates to Fines screen
begin
  TMenu.FinesScreen(frmProfile);
end; // procedure lblFinesMenuClick

procedure TfrmProfile.lblMenuLicensesClick(Sender: TObject);
// Navigates to Licenses screen
begin
  TMenu.LicenseScreen(frmProfile);
end; // procedure lblMenuLicensesClick

procedure TfrmProfile.lblStationsMenuClick(Sender: TObject);
// Navigates to Stations (Routing) screen
begin
  TMenu.RoutingScreen(frmProfile);
end; // procedure lblStationsMenuClick

procedure TfrmProfile.lblTestsMenuClick(Sender: TObject);
// Navigates to Tests screen
begin
  TMenu.TestScreen(frmProfile);
end; // procedure lblTestsMenuClick

end. // unit ProfileUI

