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
// Terminates the application when the login form is closed
begin
  Application.Terminate;
end; // procedure FormClose

procedure TfrmLogin.FormShow(Sender: TObject);
// Opens database tables when the form is shown
begin
  Datamodule1.OpenTables;
end; // procedure FormShow

procedure TfrmLogin.Image1Click(Sender: TObject);
// Opens the Sign Up screen and hides the Login screen
begin
  frmSignup.show;
  frmLogin.hide;
end; // procedure Image1Click

procedure TfrmLogin.imgLoginButtonClick(Sender: TObject);
// Handles the login process:
//  - Validates input fields
//  - Checks user credentials against the database
//  - Detects admin role
//  - Writes login trail to file
//  - Navigates to main screen if successful
var
  sLine: string;
begin
  bAdmin := false;
  if TValidation.notEmpty(edtUsernameLogin.text, 'Username') then
  begin // if Username not empty
    if TValidation.notEmpty(edtPasswordLogin.text, 'Password') then
    begin // if Password not empty
      sUsername := edtUsernameLogin.text;
      sPassword := edtPasswordLogin.text;

      with Datamodule1 do
      begin // with DataModule1
        try
          ADOQuery1.Close;
          ADOQuery1.SQL.Text := 'SELECT * FROM tblUsers WHERE Username = "' +
            sUsername + '" AND Password = "' + sPassword + '"';
          ADOQuery1.Open;
        except
          on E: Exception do
            ShowMessage('Database Error: ' + E.Message);
        end;

        if ADOQuery1.RecordCount > 0 then
        begin // if credentials match
          ShowMessage('Successful login');
          sID := ADOQuery1.FieldByName('UserID').AsString;

          if ADOQuery1.FieldByName('UserRoles').AsString = 'Admin' then
          begin
            bAdmin := True;
          end // if Admin
          else
          begin
            bAdmin := false;
          end; // else (not admin)

          if FileExists('LoginTrail.txt') then
          begin // if file exists
            try
              AssignFile(fDatafile, 'LoginTrail.txt');
              Append(fDatafile);
              sLine := sID + '#' + DateToStr(Date) + '#' + TimeToStr(Time) + '#'
                + ADOQuery1.FieldByName('UserRoles').AsString;
              Writeln(fDatafile, sLine);
              CloseFile(fDatafile);
            except
              on E: Exception do
                ShowMessage('Could not write login trail: ' + E.Message);
            end; // try..except for writing file
          end; // if file exists

          frmMain.Show;
          frmLogin.Hide;
        end // if RecordCount > 0
        else
        begin
          ShowMessage('Login failed: invalid username or password.');
        end; // else login failed

      end; // with DataModule1

    end; // if Password not empty
  end
  else
  begin
    ShowMessage('Username cannot be blank');
  end; // else Username is empty

  try
    // Optional: catch any other exceptions
  except
    on E: Exception do
      ShowMessage('Database Error: ' + E.Message);
  end; // try..except

end; // procedure imgLoginButtonClick

end. // unit LoginScreenUI

