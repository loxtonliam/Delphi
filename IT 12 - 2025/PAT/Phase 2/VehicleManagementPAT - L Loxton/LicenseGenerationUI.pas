unit LicenseGenerationUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, DateUtils,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmLicenseGen = class(TForm)
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
    Image1: TImage;
    lblNext: TLabel;
    lblLicenses: TLabel;
    btnRenew1: TImage;
    btnRenew2: TImage;
    imgBlock1: TImage;
    imgBlock2: TImage;
    btnTrash1: TImage;
    btnTrash2: TImage;
    lblGen: TLabel;
    Image2: TImage;
    lblID1: TLabel;
    lblID2: TLabel;
    lblExp2: TLabel;
    lblExp1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lblMainMenuClick(Sender: TObject);
    procedure lblStationsMenuClick(Sender: TObject);
    procedure lblFinesMenuClick(Sender: TObject);
    procedure lblTestsMenuClick(Sender: TObject);
    procedure imgBlueMenuBarClick(Sender: TObject);
    procedure imgWhiteMenuClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);

    procedure btnRenew1Click(Sender: TObject);
    procedure renewLicense(sLicense: string);
    procedure btnRenew2Click(Sender: TObject);
    procedure btnTrash1Click(Sender: TObject);
    procedure DelLicense(sLicense: string);
    procedure btnTrash2Click(Sender: TObject);
    procedure LoadLicenses;
    function colourBox(): string;
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

procedure TfrmLicenseGen.btnRenew1Click(Sender: TObject);
var
  sLicense: string;
begin
  if lblID1.caption <> 'N/A' then
  begin
    sLicense := lblID1.caption;
  end;

  renewLicense(sLicense);
end;

procedure TfrmLicenseGen.btnRenew2Click(Sender: TObject);
var
  sLicense: string;
begin
  sLicense := lblID2.caption;
  renewLicense(sLicense);
end;

procedure TfrmLicenseGen.btnTrash1Click(Sender: TObject);
var
  sLicense: string;
begin
  sLicense := lblID1.caption;
  DelLicense(sLicense);
end;

procedure TfrmLicenseGen.btnTrash2Click(Sender: TObject);
var
  sLicense: string;
begin
  sLicense := lblID1.caption;
  DelLicense(sLicense);
end;

function TfrmLicenseGen.colourBox(): string;
var
  dExp: TDateTime;
begin
  with DataModule1 do
  begin
    dExp := ADOQuery1.FieldByName('ExpirationDate').AsDateTime;
    if dExp < Date then
    begin
      result := 'RedRec';
    end
    else
    begin
      result := 'GreenRec';
    end;
  end;
end;

procedure TfrmLicenseGen.DelLicense(sLicense: string);
begin
  with DataModule1 do
  begin
    ADOQuery1.close;
    ADOQuery1.SQL.text := ' SELECT * FROM tblFines WHERE LicenseID = "' +
      sLicense + '"';
    ADOQuery1.open;
    if ADOQuery1.RecordCount = 0 then
    begin
     if uppercase(inputbox('Are you sure you want to delete Y/N','','')) = 'Y' then
     begin
       ADOQuery1.Close;
       ADOQuery1.SQL.Text := 'DELETE FROM tblLicenses WHERE LicenseID = "'+sLicense+'"';
       ADOQuery1.ExecSQL;
       showmessage('Record deleted');
       LoadLicenses;
     end;
    end
    else
    begin
      showmessage('Please pay off all fines related to the selected license before deleting');
    end;
  end;
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
  LoadLicenses;
end;

procedure TfrmLicenseGen.Image2Click(Sender: TObject);
var
  sProv, sType, sLicense, sNewest, sNum: string;
  i: Integer;
begin
  sProv := cmbProvince.items[cmbProvince.itemindex];
  sType := cmbLicenseType.items[cmbLicenseType.itemindex];
  with DataModule1 do
  begin

    ADOQuery1.close;
    ADOQuery1.SQL.text := 'SELECT * FROM tblLicenses WHERE OwnerID = "' +
      sID + '"';
    ADOQuery1.open;
    ADOQuery1.first;
    if ADOQuery1.RecordCount < 2 then
    begin
      try
        ADOQuery1.close;
        ADOQuery1.SQL.text :=
          'SELECT Top 1 * FROM tblLicenses WHERE Province = "' + sProv +
          '" ORDER BY createdAt DESC';
        ADOQuery1.open;
        if not ADOQuery1.IsEmpty then
        begin
          sNewest := ADOQuery1.FieldByName('LicenseID').AsString;
        end
        else
        begin
          sNewest := '';
        end;

      except
        on E: Exception do
          sNewest := '';
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

      case cmbProvince.itemindex of

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
      tblLicenses.close;
      tblLicenses.open;
        tblLicenses.insert;
        TDB.UpdateField('LicenseID', sLicense, tblLicenses);
        TDB.UpdateField('LicenseType', sType, tblLicenses);
        TDB.UpdateField('ExpirationDate', DateTostr(incYear(Date, 1)),
          tblLicenses);
        TDB.UpdateField('CreatedAt', DateTimeTostr(Now), tblLicenses);
        TDB.UpdateField('UpdatedAt', DateTimeTostr(Now), tblLicenses);
        TDB.UpdateField('OwnerID', sID, tblLicenses);
        TDB.UpdateField('Province', sProv, tblLicenses);
        tblLicenses.post;
        tblLicenses.Refresh;
      end;
      showmessage('License added: ' + sLicense);
      LoadLicenses;
    end

    else
    begin
      showmessage
        ('A maximum of two licenses are allowed, please delete one of your licenses if you wish to generate a new one');
    end;

  end;
end;

procedure TfrmLicenseGen.imgBlueMenuBarClick(Sender: TObject);
// menu
begin
  pnlMenu.show;
end;

procedure TfrmLicenseGen.imgWhiteMenuClick(Sender: TObject);
// menu
begin
  pnlMenu.hide;
end;

procedure TfrmLicenseGen.lblFinesMenuClick(Sender: TObject);
// menu
begin
  TMenu.FinesScreen(frmLicenseGen)
end;

procedure TfrmLicenseGen.lblMainMenuClick(Sender: TObject);
// menu
begin
  TMenu.MainScreen(frmLicenseGen);
end;

procedure TfrmLicenseGen.lblStationsMenuClick(Sender: TObject);
// menu
begin
  TMenu.RoutingScreen(frmLicenseGen)
end;

procedure TfrmLicenseGen.lblTestsMenuClick(Sender: TObject);
// menu
begin
  TMenu.TestScreen(frmLicenseGen)
end;

procedure TfrmLicenseGen.LoadLicenses;
var
  iCount: Integer;
  sLicense: string;
begin
  with DataModule1 do
  begin
    ADOQuery1.close;
    ADOQuery1.SQL.text :=
      'SELECT LicenseID, ExpirationDate FROM tblLicenses WHERE ownerID = "' +
      sID + '"';
    ADOQuery1.open;
    iCount := ADOQuery1.RecordCount;
    if (ADOQuery1.RecordCount <= 2) then
    begin
      if ADOQuery1.RecordCount >= 1 then
      begin
        ADOQuery1.first;
        sLicense := ADOQuery1.FieldByName('LicenseID').AsString;
        imgBlock1.Picture.LoadFromFile(colourBox + '.png');
        lblID1.caption := sLicense;
        lblExp1.caption := ADOQuery1.FieldByName('ExpirationDate').AsString;

        if ADOQuery1.RecordCount >1 then
        begin
          ADOQuery1.Next;
          sLicense := ADOQuery1.FieldByName('LicenseID').AsString;
          imgBlock2.Picture.LoadFromFile(colourBox + '.png');
          lblID2.caption := sLicense;
          lblExp2.caption := ADOQuery1.FieldByName('ExpirationDate').AsString;
        end
        else
        begin
          lblID2.caption := 'N/A';
          lblExp2.caption := 'N/A';
        end;
      end
      else
      begin
        lblID1.caption := 'N/A';
        lblExp1.caption := 'N/A';
        lblID2.caption := 'N/A';
        lblExp2.caption := 'N/A';
      end;

    end
    else
    begin
      showmessage
        ('too many licenses created for your ID, please contact an admin to manually delete from DB');
    end;
  end;
end;

procedure TfrmLicenseGen.renewLicense(sLicense: string);
var
  sRenewDate: string;
begin
  if Uppercase(inputbox('Are you sure you want to renew Y/N', '', '')) = 'Y'
  then
  begin
    sRenewDate := DateTostr(incYear(Date, 1));
    with DataModule1 do
    begin

      ADOQuery1.close;
      ADOQuery1.SQL.text := 'UPDATE tblLicenses SET ExpirationDate = "' +
        sRenewDate + '" WHERE LicenseID = "' + sLicense + '"';
      ADOQuery1.ExecSQL;
      showmessage
        ('License renewed, expiration date is now one year later from today');
      LoadLicenses;

    end;
  end
  else
  begin
    exit;
  end;

end;

end.
