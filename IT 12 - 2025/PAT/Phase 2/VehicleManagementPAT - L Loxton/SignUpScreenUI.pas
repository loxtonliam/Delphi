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
//setting user type to admin
begin
  chbCarOwner.checked := false;
end;

procedure TfrmSignup.chbCarOwnerClick(Sender: TObject);
// setting user type to car owner
begin
  chbAdmin.checked := false;
end;

procedure TfrmSignup.edtPassConSignUpChange(Sender: TObject);
begin
  { if edtPassSignup = edtPassConSignup then
    begin
    imgState.Picture.LoadFromFile('Check.png');
    end
    else
    begin
    imgState.picture.LoadFromFile('X.png');
    end; }
end;

procedure TfrmSignup.FormClose(Sender: TObject; var Action: TCloseAction);
//close app on form close
begin
  Application.terminate;
end;

procedure TfrmSignup.FormShow(Sender: TObject);
//open DB tables and setting max date of date picker
begin
  Datamodule1.opentables;
  dtpDOB.MaxDate := date;
end;

procedure TfrmSignup.imgLoginBlockClick(Sender: TObject);
//showing login screen
begin
    frmLogin.show;
  frmSignup.hide;
end;

procedure TfrmSignup.imgLoginButtonClick(Sender: TObject);
{
  Sign up of user
  - extract from edit boxes
  - check for unique vals
  - update DB
}
var
  sUser, sPass, sPassConfirmed, sFirstName, sLastName, sEmail, sContact,
    sUserID, OwnerID, AdminID, sType: string;

  DOB: tDatetime;

begin

  sPass := edtPassword.text;
  sPassConfirmed := edtConfirmPassword.text;
  if sPass = sPassConfirmed then
  begin
    if (tdb.ExistingRecordCheck('tblUsers', 'Username', sUser))
    { (tdb.ExistingRecordCheck('tblUsers', 'Email', sEmail)) } then
    begin
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
      end;

      sEmail := edtEmail.text;
      if TValidation.notEmpty(edtContact.text, 'Contact') then
      begin
        sContact := edtContact.Text;
        if length(sContact) = 10 then
        begin
          sContact := edtContact.text;
        end
        else
        begin
          showmessage('Contact number must be ten digits long');
          exit;
        end;
      end;

      if dtpDOB.Date < Date then
      begin
        DOB := dtpDOB.Date;
      end
      else
      begin
        exit;
      end;

      sUserID := copy(sFirstName, 1, 1) + copy(sLastName, 1, 1) +
        InttoStr(random(10000 - 1 + 1) + 1);

      try
        if chbAdmin.checked then
        begin
          sType := 'Admin';
        end // if
        else
        begin
          sType := 'User';

        end; // else

        with Datamodule1 do
        begin
          tblUsers.insert;
          tdb.UpdateField('UserID', sUserID, tblUsers);
          tdb.UpdateField('Username', sUser, tblUsers);
          tdb.UpdateField('FirstName', sFirstName, tblUsers);
          tdb.UpdateField('LastName', sFirstName, tblUsers);
          tdb.UpdateField('Password', sPass, tblUsers);
          tdb.UpdateField('ContactNumber', sContact, tblUsers);
          tdb.UpdateField('DateOfBirth', DateToStr(DOB), tblUsers);
          tdb.UpdateField('AccountStatus', 'Active', tblUsers);
          tdb.UpdateField('UserRoles', sType, tblUsers);
          tdb.UpdateField('CreatedAt', DateToStr(Date), tblUsers);
          tdb.UpdateField('UpdatedAt', DateToStr(Date), tblUsers);
          tdb.UpdateField('EmailAddress', sEmail, tblUsers);

          tblUsers.post;
          tblUsers.refresh;
        end; // if DM

        showmessage('Account successfully added');
        frmLogin.show;
        frmSignup.hide;
      except
        on E: Exception do
          showmessage('Problem with adding data to DB');
      end;

    end; // if exist

  end // if passconfirm
  else
  begin
    showmessage('Passwords are not the same');
  end;

end;

end.
