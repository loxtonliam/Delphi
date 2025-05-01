unit MainScreenUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    imgBG: TImage;
    imgGreyDiv: TImage;
    Image1: TImage;
    Image2: TImage;
    lblTitleMain: TLabel;
    btnGen: TButton;
    btnProfile: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGenClick(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
uses
DBConnection, LoginScreenUI, LicenseGenerationUI, ProfileUI;

procedure TfrmMain.btnGenClick(Sender: TObject);
begin
frmMain.hide;
frmLicenseGen.show;
end;

procedure TfrmMain.btnProfileClick(Sender: TObject);
begin
 frmMain.hide;
 frmprofile.show;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
application.terminate;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
showmessage(sID);
 with Datamodule1 do
 begin
  ADOQuery1.close;
  ADOQuery1.SQL.Text := 'SELECT * FROM tblUsers WHERE Username = "'+sUsername+'"';
  ADOQuery1.open;
  if ADOQuery1.RecordCount > 0  then
  begin
    lblTitleMain.caption := 'Hi, ' + tblUsers['firstName'];
  end;
 end;
end;

end.
