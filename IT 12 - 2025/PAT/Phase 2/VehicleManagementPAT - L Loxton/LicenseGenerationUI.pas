unit LicenseGenerationUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, DateUtils,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmLicenseGen = class(TForm)
    btnGen: TButton;
    RichEdit1: TRichEdit;
    cmbLicenseType: TComboBox;
    cmbProvince: TComboBox;
    imgBG: TImage;
    imgGreyDiv: TImage;
    imgSmallLlogo: TImage;
    imgBlueMenuBar: TImage;
    pnlMenu: TPanel;
    lblTestsMenu: TLabel;
    lblStationsMenu: TLabel;
    lblMainMenu: TLabel;
    lblFinesMenu: TLabel;
    imgWhiteMenu: TImage;
    btnProfile: TImage;
    procedure btnGenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lblMainMenuClick(Sender: TObject);
    procedure lblStationsMenuClick(Sender: TObject);
    procedure lblFinesMenuClick(Sender: TObject);
    procedure lblTestsMenuClick(Sender: TObject);
    procedure imgBlueMenuBarClick(Sender: TObject);
    procedure imgWhiteMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLicenseGen: TfrmLicenseGen;

implementation

{$R *.dfm}

uses
  LoginScreenUI, DBConnection, Shared_U, MainScreenUI;

procedure TfrmLicenseGen.btnGenClick(Sender: TObject);
{
simple license generation based on province and last entry in DB
}
var
  sProv, sType, sLicense, sNewest, sNum: string;
  i: Integer;

begin
  sProv := inttostr(cmbProvince.Itemindex);
  sType := inttostr(cmbLicenseType.Itemindex);
  with DataModule1 do
  begin

    try
      ADOQuery1.close;
      ADOQuery1.SQL.text :=
        'SELECT Top 1 * FROM tblLicenses WHERE provinceID = '+sType+' ORDER BY createdAt DESC';
      ADOQuery1.open;
      if not ADOQuery1.IsEmpty then
      begin
        sNewest := ADOQuery1.FieldByName('licenseID').AsString;
      end
      else
      begin
        sNewest := '';
      end;

    except
      on E: Exception do
        sNewest := '';
    end;

  end;

  if sNewest = '' then
  begin
    sNum := '1';
  end
  else
  begin
    for i := 1 to length(sNewest) do
    begin
      if sNewest[i] in ['0' .. '9'] then
      begin
        sNum := sNum + sNewest[i];
      end;
    end;
    sNum := inttostr(strtoint(sNum) + 1);

  end;

  case cmbProvince.Itemindex of

    0:
      sLicense := 'B ' + sNum + ' GP';
    1:
      sLicense := 'CA ' + sNum;
    2:
      sLicense := 'ND ' + sNum;
    3:
      sLicense := 'EL ' + sNum + ' EC';
    4:
      sLicense := 'L ' + sNum + ' L';
    5:
      sLicense := sNum + ' MP';
    6:
      sLicense := sNum + ' NW';
    7:
      sLicense := sNum + ' NC';
    8:
      sLicense := sNum + ' FS';

  end;

  with DataModule1 do
  begin
    tblLicenses.insert;
    TDB.UpdateField('licenseID', sLicense, tblLicenses);
    TDB.UpdateField('typeID', sType, tblLicenses);
    TDB.UpdateField('ExpirationDate', DateTostr(incYear(Date, 1)), tblLicenses);
    TDB.UpdateField('createdAt', DateTimeTostr(Now), tblLicenses);
    TDB.UpdateField('updatedAt', DateTimeTostr(Now), tblLicenses);
    TDB.UpdateField('ownerID', sID, tblLicenses);
    TDB.UpdateField('provinceID', sProv, tblLicenses);
    tblLicenses.post;
    tblLicenses.Refresh;
  end;
  RichEdit1.clear;
  RichEdit1.lines.add('License added: ' + sLicense);
end;

procedure TfrmLicenseGen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmLicenseGen.FormShow(Sender: TObject);
begin
pnlMenu.hide;
DataModule1.OpenTables;
  if sID = '' then
  begin
    sID := 'FL4802'
  end;
end;

procedure TfrmLicenseGen.imgBlueMenuBarClick(Sender: TObject);
begin
pnlMenu.show;
end;

procedure TfrmLicenseGen.imgWhiteMenuClick(Sender: TObject);
begin
pnlMenu.hide;
end;

procedure TfrmLicenseGen.lblFinesMenuClick(Sender: TObject);
begin
TMenu.FinesScreen(frmLicenseGen)
end;

procedure TfrmLicenseGen.lblMainMenuClick(Sender: TObject);
begin
 TMenu.MainScreen(frmLicenseGen);
end;

procedure TfrmLicenseGen.lblStationsMenuClick(Sender: TObject);
begin
TMenu.RoutingScreen(frmLicenseGen)
end;

procedure TfrmLicenseGen.lblTestsMenuClick(Sender: TObject);
begin
TMenu.TestScreen(frmLicenseGen)
end;

end.
