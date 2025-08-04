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
    imgBlueMenuBar: TImage;
    Image1: TImage;
    lblNext: TLabel;
    lblLicenses: TLabel;
    btnRenew1: TImage;
    btnRenew2: TImage;
    imgBlock2: TImage;
    imgBlock1: TImage;
    btnTrash1: TImage;
    btnTrash2: TImage;
    lblGen: TLabel;
    Image2: TImage;
    lblID1: TLabel;
    lblID2: TLabel;
    lblExp2: TLabel;
    lblExp1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlMenu: TPanel;
    Label1: TLabel;
    lblMenuMain: TLabel;
    Label2: TLabel;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

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
    procedure btnProfileClick(Sender: TObject);
    procedure btnChange(btn: TImage; b: boolean);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure lblMenuMainClick(Sender: TObject);
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

procedure TfrmLicenseGen.btnProfileClick(Sender: TObject);
begin
  TMenu.Profile(frmLicenseGen);
end;

procedure TfrmLicenseGen.btnRenew1Click(Sender: TObject);
// Handles the click event to renew the first license
var
  sLicense: string;
begin
  if lblID1.caption <> 'N/A' then
  begin
    sLicense := lblID1.caption;
  end; // if
  renewLicense(sLicense);
end; // procedure btnRenew1Click

procedure TfrmLicenseGen.btnRenew2Click(Sender: TObject);
// Handles the click event to renew the second license
var
  sLicense: string;
begin
  sLicense := lblID2.caption;
  renewLicense(sLicense);
end; // procedure btnRenew2Click

procedure TfrmLicenseGen.btnTrash1Click(Sender: TObject);
// Handles the click event to delete the first license
var
  sLicense: string;
begin
  sLicense := lblID1.caption;
  DelLicense(sLicense);
end; // procedure btnTrash1Click

procedure TfrmLicenseGen.btnTrash2Click(Sender: TObject);
// Handles the click event to delete the second license
var
  sLicense: string;
begin
  sLicense := lblID1.caption;
  DelLicense(sLicense);
end; // procedure btnTrash2Click

function TfrmLicenseGen.colourBox(): string;
// Returns 'RedRec' if license is expired, 'GreenRec' otherwise
var
  dExp: TDateTime;
begin
  with DataModule1 do
  begin
    dExp := ADOQuery1.FieldByName('ExpirationDate').AsDateTime;
    if dExp < Date then
    begin
      result := 'RedRec';
    end // if
    else
    begin
      result := 'GreenRec';
    end; // else
  end; // with
end; // function colourBox

procedure TfrmLicenseGen.DelLicense(sLicense: string);
// Deletes the license if no fines exist for it
begin
  with DataModule1 do
  begin
    try
      ADOQuery1.close;
      ADOQuery1.SQL.text :=
        'SELECT * FROM tblFines WHERE LicenseID IN (SELECT LicenseID FROM tblLicenses WHERE OwnerID = "'
        + sID + '" ) AND FineID NOT IN (SELECT FineID FROM tblPayments WHERE Status = "Paid")';
      ADOQuery1.open;
      if ADOQuery1.RecordCount = 0 then
      begin
        if uppercase
          (inputbox(
          'Are you sure you want to delete your registered license from the database? Y/N',
          '', '')) = 'Y' then
        begin
          ADOQuery1.close;
          ADOQuery1.SQL.text :=
            'DELETE FROM tblPayments WHERE FineID IN (SELECT FineID FROM tblFines WHERE LicenseID ="'
            + sLicense + '")';
          ADOQuery1.ExecSQL;

          ADOQuery1.SQL.text := 'DELETE FROM tblFines WHERE LicenseID = "' +
            sLicense + '"';
          ADOQuery1.ExecSQL;

          ADOQuery1.close;
          ADOQuery1.SQL.text := 'DELETE FROM tblLicenses WHERE LicenseID = "' +
            sLicense + '"';
          ADOQuery1.ExecSQL;
          showmessage('Record deleted');
          LoadLicenses;
        end; // if
      end // if
      else
      begin
        showmessage
          ('Please pay off all fines related to the selected license before deleting');
      end; // else
    except
      on E: Exception do
        showmessage('Database Error: ' + E.Message);

    end;

  end; // with
end;

procedure TfrmLicenseGen.btnChange(btn: TImage; b: boolean);
begin
  if b then
  begin
    btn.enabled := true;
    btn.show;
  end
  else
  begin
    btn.enabled := false;
    btn.hide;
  end;

end;

// procedure DelLicense

procedure TfrmLicenseGen.FormClose(Sender: TObject; var Action: TCloseAction);
// Terminates the application when form is closed
begin
  Application.Terminate;
end; // procedure FormClose

procedure TfrmLicenseGen.FormShow(Sender: TObject);
// Initializes data when the form is shown
begin
  pnlMenu.hide;
  DataModule1.OpenTables;
  if sID = '' then
  begin
    sID := 'FL4802'
  end; // if
  LoadLicenses;
end; // procedure FormShow

procedure TfrmLicenseGen.Image2Click(Sender: TObject);
// Generates a new license based on selected type and province
var
  sProv, sType, sLicense, sNewest, sNum: string;
  i: Integer;
begin
  if cmbProvince.itemindex = -1 then
  begin
    showmessage('Please select a province');
    exit;
  end;
  if cmbLicenseType.itemindex = -1 then
  begin
    showmessage('Please select a license type');
    exit;
  end;
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
        end // if
        else
        begin
          sNewest := '';
        end; // else
      except
        on E: Exception do
          sNewest := '';
      end; // try-except

      if sNewest = '' then
      begin
        sNum := '1';
      end // if
      else
      begin
        for i := 1 to length(sNewest) do
        begin
          if sNewest[i] in ['0' .. '9'] then
          begin
            sNum := sNum + sNewest[i];
          end; // if
        end; // for
        sNum := inttostr(strtoint(sNum) + 1);
      end; // else

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
      end; // case

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
      end; // with

      showmessage
        ('Your license has been created, the associated license plate is: ' +
        sLicense + #13 +
        'Please look at the boxes above for information regarding your license, such as plate number and expiry date');
      LoadLicenses;
    end // if
    else
    begin
      showmessage
        ('A maximum of two licenses are allowed, please delete one of your licenses if you wish to generate a new one');
    end; // else
  end; // with
end;

procedure TfrmLicenseGen.Image8Click(Sender: TObject);
begin
  showmessage
    ('Select License Type and your province before clicking generate button to create a new license');
end;

procedure TfrmLicenseGen.Image9Click(Sender: TObject);
begin
  showmessage
    ('Your two licenses are displayed in the red/green blocks. Green means it is an active license and red means it is expired. Your plate number and expiry date is diplayed. You are able to renew your license when there is 3 months left on it.');
end;

// procedure Image2Click

procedure TfrmLicenseGen.imgBlueMenuBarClick(Sender: TObject);
// Shows the menu panel
begin
  pnlMenu.show;
end; // procedure imgBlueMenuBarClick

procedure TfrmLicenseGen.imgWhiteMenuClick(Sender: TObject);
// Hides the menu panel
begin
  pnlMenu.hide;
end; // procedure imgWhiteMenuClick

procedure TfrmLicenseGen.lblFinesMenuClick(Sender: TObject);
// Navigates to the Fines screen
begin
  TMenu.FinesScreen(frmLicenseGen)
end; // procedure lblFinesMenuClick



procedure TfrmLicenseGen.lblMenuMainClick(Sender: TObject);
begin
  TMenu.MainScreen(frmLicenseGen);
end;

// procedure lblMainMenuClick

procedure TfrmLicenseGen.lblStationsMenuClick(Sender: TObject);
// Navigates to the Stations (Routing) screen
begin
  TMenu.RoutingScreen(frmLicenseGen)
end; // procedure lblStationsMenuClick

procedure TfrmLicenseGen.lblTestsMenuClick(Sender: TObject);
// Navigates to the Tests screen
begin
  TMenu.TestScreen(frmLicenseGen)
end; // procedure lblTestsMenuClick

procedure TfrmLicenseGen.LoadLicenses;
// Loads licenses from DB and updates UI blocks and labels
var
  iCount: Integer;
  sLicense: string;
begin
  with DataModule1 do
  begin
    ADOQuery1.SQL.text :=
      'SELECT MIN(ExpirationDate) AS NextExp FROM tblLicenses WHERE ownerID ="'
      + sID + '"';
    ADOQuery1.open;
    if ADOQuery1.RecordCount > 0 then
    begin
      lblNext.caption := 'NEXT RENEWAL: ' + ADOQuery1.FieldByName
        ('NextExp').AsString;
    end
    else
    begin
      lblNext.caption := '';
    end;

    ADOQuery1.close;
    ADOQuery1.SQL.text :=
      'SELECT COUNT(*) AS TotalNumber FROM tblLicenses WHERE ownerID = "' +
      sID + '"';
    ADOQuery1.open;
    iCount := ADOQuery1.FieldByName('TotalNumber').AsInteger;

    ADOQuery1.close;
    ADOQuery1.SQL.text :=
      'SELECT LicenseID, ExpirationDate FROM tblLicenses WHERE ownerID = "' +
      sID + '"';
    ADOQuery1.open;

    if (iCount <= 2) then
    begin
      if iCount >= 1 then
      begin
        ADOQuery1.first;
        sLicense := ADOQuery1.FieldByName('LicenseID').AsString;
        imgBlock1.Picture.LoadFromFile(colourBox + '.png');
        lblID1.caption := sLicense;
        lblExp1.caption := ADOQuery1.FieldByName('ExpirationDate').AsString;
        btnRenew1.enabled := true;
        btnRenew1.show;
        btnRenew2.enabled := true;
        btnRenew2.show;

        if iCount > 1 then
        begin
          ADOQuery1.Next;
          sLicense := ADOQuery1.FieldByName('LicenseID').AsString;
          imgBlock2.Picture.LoadFromFile(colourBox + '.png');
          lblID2.caption := sLicense;
          lblExp2.caption := ADOQuery1.FieldByName('ExpirationDate').AsString;
          btnChange(btnRenew1, true);
          btnChange(btnRenew2, true);
          btnChange(btnTrash1, true);
          btnChange(btnTrash2, true);

        end // if
        else
        begin
          lblID2.caption := 'No license plate registered';
          lblExp2.caption := '';

          btnChange(btnRenew2, false);
          btnChange(btnTrash2, false);

        end; // else
      end // if
      else
      begin
        lblID1.caption := 'No license plate registered';
        lblExp1.caption := '';
        lblID2.caption := 'No license plate registered';
        lblExp2.caption := '';
        btnChange(btnRenew1, false);
        btnChange(btnRenew2, false);
        btnChange(btnTrash1, false);
        btnChange(btnTrash2, false);
      end; // else
    end // if
    else
    begin
      showmessage
        ('too many licenses created for your ID, please contact an admin to manually delete from DB');
    end; // else
  end; // with
end; // procedure LoadLicenses

procedure TfrmLicenseGen.renewLicense(sLicense: string);
// Renews the given license by updating the ExpirationDate to one year later
var
  sRenewDate: string;
begin
  with DataModule1 do
  begin
    ADOQuery1.SQL.text :=
      'SELECT ExpirationDate FROM tblLicenses WHERE LicenseID = "' +
      sLicense + '"';
    ADOQuery1.open;
    if MonthsBetween(Date, ADOQuery1.FieldByName('ExpirationDate')
      .AsDateTime) <= 3 then
    begin

      if uppercase(inputbox('Are you sure you want to renew Y/N', '', '')) = 'Y'
      then
      begin
        sRenewDate := DateTostr(incYear(Date, 1));

        ADOQuery1.close;
        ADOQuery1.SQL.text := 'UPDATE tblLicenses SET ExpirationDate = "' +
          sRenewDate + '" WHERE LicenseID = "' + sLicense + '"';
        ADOQuery1.ExecSQL;
        showmessage
          ('License renewed, expiration date is now one year later from today');
        LoadLicenses;
      end // if
      else
      begin
        exit;
      end;
    end // if
    else
    begin
      showmessage
        ('You can only renew your license when there is three months left to renew');
      exit;
    end;
  end // with
  // else
end; // procedure renewLicense

end. // unit LicenseGenerationUI
