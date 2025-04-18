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
    imgLoginLineLbl: TImage;
    edtUsernameLogin: TEdit;
    edtPasswordLogin: TEdit;
    imgLoginButton: TImage;
    LblLogin: TLabel;
    lblSignUp: TLabel;
    imgEmailIcon: TImage;
    imgPassIcon: TImage;
    DBGrid1: TDBGrid;
    imgLogoMain: TImage;
    chbAdmin: TCheckBox;
    procedure lblSignUpClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgLoginButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;
  sUsername, sPassword: String;

implementation

uses
  DBConnection, SignUpSCreenUI,Shared_U, MainScreenUI;

{$R *.dfm}

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  Datamodule1.OpenTables;
end;

procedure TfrmLogin.imgLoginButtonClick(Sender: TObject);
begin

  if TValidation.notEmpty(edtUsernameLogin.text, 'Username') then
  begin
    if TValidation.notEmpty(edtPasswordLogin.text, 'Password') then
    begin
      sUsername := edtUsernameLogin.text;
      sPassword := edtPasswordLogin.text;
      if chbAdmin.checked then
      begin
        with Datamodule1 do
        begin
          ADOQuery1.sql.text := 'SELECT * FROM tblAdmin WHERE Username = "' +
            sUsername + '" AND Password = "' + sPassword + '"';
          ADOQuery1.open;
          if ADOQuery1.RecordCount > 0 then
          begin
            showmessage('Successful login');
            frmMain.show;
            frmLogin.hide;
          end
          else
          begin
            showmessage('unsuccessful');
          end
        end
      end;

      with Datamodule1 do
      begin
        ADOQuery1.sql.text := 'SELECT * FROM tblUsers WHERE Username = "' +
          sUsername + '" AND Password = "' + sPassword + '"';
        ADOQuery1.open;
        if ADOQuery1.RecordCount > 0 then
        begin
          showmessage('Successful login');
          frmMain.show;
          frmLogin.hide;
        end
        else
        begin
          showmessage('unsuccessful');
        end
      end
    end;;

  end
  else
  begin
    showmessage('Email cannot be blank');
  end;

end;

procedure TfrmLogin.lblSignUpClick(Sender: TObject);
begin
  frmSignup.show;
  frmLogin.hide;
end;

end.
