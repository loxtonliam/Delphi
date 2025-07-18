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
    procedure imgLoginButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
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
{
logout user
- check for confirmation
- reset ID and show login screen
}
begin
 if UpperCase(inputbox('','Are you sure you want to logout? Y/N','')) = 'Y' then
 begin
   frmProfile.hide;
   frmLogin.show;
   sID := '';
   bAdmin := false;
 end;

end;

procedure TfrmProfile.FormClose(Sender: TObject; var Action: TCloseAction);
//close app on form close
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
redAccountInfo.lines.add(DataModule1.userToString(sId));
end;

procedure TfrmProfile.imgLoginButtonClick(Sender: TObject);
begin
  if UpperCase(inputbox('Are you sure you want to delete your account? Y/N', '',
    '')) = 'Y' then
  begin
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
  end;

end;

end.
