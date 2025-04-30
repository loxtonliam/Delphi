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
    lblLoginTitle: TLabel;
    lblSignUpScreen: TLabel;
    imgLoginLineLbl: TImage;
    lblLoginSignUpScreen: TLabel;
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
    procedure lblLoginSignUpScreenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chbCarOwnerClick(Sender: TObject);
    procedure chbAdminClick(Sender: TObject);
    procedure imgLoginButtonClick(Sender: TObject);
    procedure edtPassConSignUpChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
begin
  chbCarOwner.checked := false;
end;

procedure TfrmSignup.chbCarOwnerClick(Sender: TObject);
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
begin
  Application.terminate;
end;

procedure TfrmSignup.FormShow(Sender: TObject);
begin
  Datamodule1.opentables;
end;

procedure TfrmSignup.imgLoginButtonClick(Sender: TObject);
{
Sign up of user
- extract from edit boxed
- check for unique vals
- update DB
}
var
  sUser, sPass, sPassConfirmed, sFirstName, sLastName, sEmail, sContact,
    sUserID, OwnerID, AdminID, sType: string;

  DOB : tDatetime;

begin

  sPass := edtPassword.text;
  sPassConfirmed := edtConfirmPassword.text;
  if sPass = sPassConfirmed then
  begin
    if (tdb.ExistingRecordCheck('tblUsers', 'Username', sUser))
      {(tdb.ExistingRecordCheck('tblUsers', 'Email', sEmail))} then
    begin
      sUser := edtUsername.text;
      sFirstName := edtFirstName.text;
      sLastName := edtLastName.text;
      sEmail := edtEmail.text;
      sContact := edtContact.text;
      DOB := dtpDOB.Date;
      sUserID := copy(sFirstName, 1, 1) + copy(sLastName, 1, 1) +
        InttoStr(random(10000 - 1 + 1) + 1);

      try
        if chbAdmin.checked then
        begin
          sType := '0';
        end // if
        else
        begin
          sType := '1';


        end; // else

        with Datamodule1 do
        begin
          tblUsers.insert;
          tdb.UpdateField('userID', sUserID, tblUsers);
          tdb.UpdateField('Username', sUser, tblUsers);
          tdb.UpdateField('firstName', sFirstName, tblUsers);
          tdb.UpdateField('lastName', sFirstName, tblUsers);
          tdb.UpdateField('Password', sPass, tblUsers);
          tdb.UpdateField('contactNumber', sContact, tblUsers);
          tdb.UpdateField('dateOfBirth', DateToStr(DOB), tblUsers);
          tdb.UpdateField('accountStatus', 'Active', tblUsers);
          tdb.UpdateField('userRoleID', sType, tblUsers);
          tdb.UpdateField('createdAt', DateToStr(Date), tblUsers);
          tdb.UpdateField('updatedAt', DateToStr(Date), tblUsers);
          tdb.UpdateField('emailAddress', sEmail, tblUsers);


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

procedure TfrmSignup.lblLoginSignUpScreenClick(Sender: TObject);
begin
  frmLogin.show;
  frmSignup.hide;
end;

end.
