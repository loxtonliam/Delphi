unit LoginScreenUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmLogin = class(TForm)
    imgBG: TImage;
    imgGreyDiv: TImage;
    edtUsernameLogin: TEdit;
    edtPasswordLogin: TEdit;
    imgLoginButton: TImage;
    imgPassIcon: TImage;
    DBGrid1: TDBGrid;
    imgLogoMain: TImage;
    Image1: TImage;
    Notebook1: TNotebook;
    Image2: TImage;
    Image3: TImage;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgLoginButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmLogin: TfrmLogin;
  sUsername, sPassword, sID: String;
  fDatafile: textfile;

implementation

uses
  DBConnection, SignUpSCreenUI, Shared_U, MainScreenUI;

{$R *.dfm}

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
// close app on form close
begin
  Application.Terminate;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
// open Db tables
begin
  Datamodule1.OpenTables;
end;

procedure TfrmLogin.Image1Click(Sender: TObject);
{
  button to show sign up screen
}
begin
  frmSignup.show;
  frmLogin.hide;
end;

procedure TfrmLogin.imgLoginButtonClick(Sender: TObject);
var
  sLine: string;
  {
    - validate edit boxes
    - extract username + password from form
    - Check if username and password combo is found in DB using query
    - extract user type from DB
    - Update login trail with details + date/time
  }
begin
  bAdmin := false;
  if TValidation.notEmpty(edtUsernameLogin.text, 'Username') then
  // checking if empty
  begin
    if TValidation.notEmpty(edtPasswordLogin.text, 'Password') then
    // checking if empty
    begin
      sUsername := edtUsernameLogin.text; // extraction
      sPassword := edtPasswordLogin.text;

      with Datamodule1 do
      begin
        try
          ADOQuery1.close;
          ADOQuery1.sql.text := 'SELECT * FROM tblUsers WHERE Username = "' +
            sUsername + '" AND Password = "' + sPassword + '"';
          // checking login for admins
          ADOQuery1.open;
        except
          on E: Exception do
            showmessage('Database Error: ' + E.message);
        end;

        if ADOQuery1.RecordCount > 0 then
        begin
          showmessage('Successful login');
          sID := ADOQuery1.FieldByName('UserID').asstring;
          if ADOQuery1.FieldByName('UserRoles').asstring = 'Admin' then
          begin
            bAdmin := True;

          end
          else
          begin
            bAdmin := false;

          end;
          if FileExists('LoginTrail.txt') then // TO DO: USER TYPES
          begin
            try
              Assignfile(fDatafile, 'LoginTrail.txt');
              Append(fDatafile);
              sLine := sID + '#' + Datetostr(Date) + '#' + timetostr(time) + '#'
                + ADOQuery1.FieldByName('UserRoles').asstring;
              writeln(fDatafile, sLine);
              closefile(fDatafile);
            except
              on E: Exception do
                showmessage('Could not write login trail: ' + E.message);
            end;

          end;



          // Text file login trail

          frmMain.show;
          frmLogin.hide;
        end // record count if
        else
        begin
          showmessage('Login failed: invalid username or password.');
        end // else

      end // dm

    end; // if val

  end
  else
  begin
    showmessage('Username cannot be blank');
  end; // if val

  try

  except
    on E: Exception do
      showmessage('Database Error: ' + E.message);
  end;

end;

end.
