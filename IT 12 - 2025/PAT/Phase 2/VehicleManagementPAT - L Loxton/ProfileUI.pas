unit ProfileUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TfrmProfile = class(TForm)
    imgBG: TImage;
    Image2: TImage;
    lblTitle: TLabel;
    imgLoginButton: TImage;
    procedure imgLoginButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  DBConnection, LoginScreenUI;

procedure TfrmProfile.FormClose(Sender: TObject; var Action: TCloseAction);
begin
application.terminate;
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
