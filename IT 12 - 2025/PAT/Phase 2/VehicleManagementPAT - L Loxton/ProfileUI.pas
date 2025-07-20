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
var
response: string;
{
  logout user
  - check for confirmation
  - reset ID and show login screen
}
begin
response :=UpperCase(inputbox('', 'Are you sure you want to logout? Y/N', ''))
  if response = 'Y'
  then
  begin
    frmProfile.hide;
    frmLogin.show;
    sID := '';
    bAdmin := false;
  end
  else if response := 'N' then
  begin
    showmessage('Deletion cancelled');
  end
  else
  begin
    showmessage('Invalid answer, please answer with either Y or N end');

  end;

end;

procedure TfrmProfile.FormClose(Sender: TObject; var Action: TCloseAction);
// close app on form close
begin
  application.terminate;
end;

procedure TfrmProfile.FormShow(Sender: TObject);
{
  - open DB tables
  - clear rich edits and then display to string method
  - display user info
}
begin
  DataModule1.OpenTables;
  redAccountInfo.clear;
  redAccountInfo.lines.add(DataModule1.userToString(sID));
  pnlMenu.hide;
end;

procedure TfrmProfile.imgBlueMenuBarClick(Sender: TObject);
begin
  pnlMenu.show;
end;

procedure TfrmProfile.imgLoginButtonClick(Sender: TObject);
var
  response: string;
begin
  response := UpperCase
    (inputbox('Are you sure you want to delete your account? Y/N', '', ''));
  if response = 'Y' then
  begin
    if sID = '' then
    begin
      showmessage('No user ID found, contact an Admin');
      exit;
    end;
    with DataModule1 do
    begin
      try
        ADOQuery1.Close;
        ADOQuery1.SQL.text := 'DELETE  FROM tblUsers WHERE userID = "' +
          sID + '"';
        ADOQuery1.ExecSQL;

        showmessage('Account successfully deleted');
        frmProfile.hide;
        frmLogin.show;
      except
        on E: Exception do
          showmessage('Problem with deletion: ' + E.Message);

      end;

    end;
  end
  else if response := 'N' then
  begin
    showmessage('Deletion cancelled');
  end
  else
  begin
    showmessage('Invalid answer, please answer with either Y or N end');

  end;

  procedure TfrmProfile.imgWhiteMenuClick(Sender: TObject);
  begin
    pnlMenu.hide;
  end;

  procedure TfrmProfile.lblFinesMenuClick(Sender: TObject);
  begin
    TMenu.FinesScreen(frmProfile);
  end;

  procedure TfrmProfile.lblMenuLicensesClick(Sender: TObject);
  begin
    TMenu.LicenseScreen(frmProfile);
  end;

  procedure TfrmProfile.lblStationsMenuClick(Sender: TObject);
  begin
    TMenu.RoutingScreen(frmProfile);
  end;

end.
