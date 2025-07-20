unit SignUpScreenUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, pngimage, Vcl.ComCtrls;

type
  TfrmSignup = class(TForm)
    imgBG: TImage;
    imgGreyDiv: TImage;
    edtUsername: TEdit;
    chbCarOwner: TCheckBox;
    chbAdmin: TCheckBox;
    imgLoginButton: TImage;
    edtPassword: TEdit;
    edtConfirmPassword: TEdit;
    edtFirstName: TEdit;
    edtLastName: TEdit;
    edtEmail: TEdit;
    edtContact: TEdit;
    dtpDOB: TDateTimePicker;
    imgLogoMain: TImage;
    Image1: TImage;
    imgLoginBlock: TImage;
    lblDOB: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chbCarOwnerClick(Sender: TObject);
    procedure chbAdminClick(Sender: TObject);
    procedure imgLoginButtonClick(Sender: TObject);
    procedure edtPassConSignUpChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgLoginBlockClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSignup: TfrmSignup;

implementation

{$R *.dfm}

uses
  LoginSCreenUI, DBConnection, Shared_U;

procedure TfrmSignup.chbAdminClick(Sender: TObject);
// Deselects CarOwner checkbox if Admin is selected
begin
  chbCarOwner.checked := false;
end; // procedure chbAdminClick

procedure TfrmSignup.chbCarOwnerClick(Sender: TObject);
// Deselects Admin checkbox if CarOwner is selected
begin
  chbAdmin.checked := false;
end; // procedure chbCarOwnerClick

procedure TfrmSignup.edtPassConSignUpChange(Sender: TObject);
// Placeholder for live password confirmation image update
begin
  { if edtPassSignup = edtPassConSignup then
    begin
    imgState.Picture.LoadFromFile('Check.png');
    end
    else
    begin
    imgState.picture.LoadFromFile('X.png');
    end; }
end; // procedure edtPassConSignUpChange

procedure TfrmSignup.FormClose(Sender: TObject; var Action: TCloseAction);
// Terminates application on form close
begin
  Application.terminate;
end; // procedure FormClose

procedure TfrmSignup.FormShow(Sender: TObject);
// Opens DB tables and limits DOB picker to today
begin
  Datamodule1.opentables;
  dtpDOB.MaxDate := date;
end; // procedure FormShow

procedure TfrmSignup.imgLoginBlockClick(Sender: TObject);
// Switches to login screen
begin
  frmLogin.show;
  frmSignup.hide;
end; // procedure imgLoginBlockClick

procedure TfrmSignup.imgLoginButtonClick(Sender: TObject);
// Handles user registration and inserts user into tblUsers
var
  sUser, sPass, sPassConfirmed, sFirstName, sLastName, sEmail, sContact,
    sUserID, OwnerID, AdminID, sType: string;
  DOB: tDatetime;
begin
  if TValidation.notEmpty(edtPassword.text, 'Password') AND
     TValidation.notEmpty(edtConfirmPassword.text, 'Confirm Password') then
  begin // password fields not empty
    sPass := edtPassword.text;
    sPassConfirmed := edtConfirmPassword.text;

    if sPass = sPassConfirmed then
    begin // passwords match
      if (tdb.ExistingRecordCheck('tblUsers', 'Username', sUser)) then
      begin // username is unique
        if (TValidation.notEmpty(edtUsername.text, 'Username')) AND
           (TValidation.notEmpty(edtFirstName.text, 'First Name')) AND
           (TValidation.notEmpty(edtLastName.text, 'Last Name')) then
        begin
          sUser := edtUsername.text;
          sFirstName := edtFirstName.text;
          sLastName := edtLastName.text;
        end
        else
        begin
          exit;
        end; // if name fields

        if TValidation.notEmpty(edtEmail.text, 'Email') then
        begin
          sEmail := edtEmail.text;
         
        end; // if email

        if TValidation.notEmpty(edtContact.text, 'Contact') then
        begin
          sContact := edtContact.text;
          if length(sContact) = 10 then
          begin
            sContact := edtContact.text;
          end
          else
          begin
            ShowMessage('Contact number must be ten digits long');
            exit;
          end;
        end; // if contact

        if dtpDOB.date < date then
        begin
          DOB := dtpDOB.date;
        end
        else
        begin
          exit;
        end; // if valid DOB

        if chbAdmin.checked then
        begin
          sType := 'Admin';
        end
        else if chbCarOwner.checked then
        begin
          sType := 'User';
        end
        else
        begin
          ShowMessage('Please select a user type using the checkboxes');
          exit;
        end; // if user type

        with Datamodule1.ADOQuery1 do
        begin
          try
            sUserID := copy(sFirstName, 1, 1) + copy(sLastName, 1, 1) +
              InttoStr(random(10000 - 1 + 1) + 1);
            close;
            sql.text := 'SELECT * FROM tblUsers WHERE UserID = :ID';
            Parameters.ParamByName('ID').value := sUserID;
            open;

            while RecordCount > 0 do
            begin
              sUserID := copy(sFirstName, 1, 1) + copy(sLastName, 1, 1) +
                InttoStr(random(10000 - 1 + 1) + 1);
              close;
              sql.text := 'SELECT * FROM tblUsers WHERE UserID = :ID';
              Parameters.ParamByName('ID').value := sUserID;
              open;
            end; // while duplicate ID

            close;
            sql.text :=
              'INSERT INTO tblUsers VALUES (:ID,:Username,:Pass,:First,:Last,:Email,:Contact,:DOB,:Status,:Role,:Created,:Updated)';
            Parameters.ParamByName('ID').value := sUserID;
            Parameters.ParamByName('Username').value := sUser;
            Parameters.ParamByName('Pass').value := sPass;
            Parameters.ParamByName('Email').value := sEmail;
            Parameters.ParamByName('First').value := sFirstName;
            Parameters.ParamByName('Last').value := sLastName;
            Parameters.ParamByName('Contact').value := sContact;
            Parameters.ParamByName('DOB').value := DOB;
            Parameters.ParamByName('Status').value := 'Active';
            Parameters.ParamByName('Role').value := sType;
            Parameters.ParamByName('Created').value := date;
            Parameters.ParamByName('Updated').value := date;
            ExecSQL;
          except
            on E: Exception do
              ShowMessage('Database Error: ' + E.message);
          end; // try..except
        end; // with adoquery

        ShowMessage('Account successfully added');
        frmLogin.show;
        frmSignup.hide;
      end; // if user doesn't exist
    end
    else
    begin
      ShowMessage('Passwords are not the same');
    end; // if password mismatch
  end
  else
  begin
    exit;
  end; // if password empty
end; // procedure imgLoginButtonClick

end. // unit SignUpScreenUI

