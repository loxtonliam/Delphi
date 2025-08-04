unit MainScreenUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    imgBG: TImage;
    imgGreyDiv: TImage;
    imgBlueMenuBar: TImage;
    lblTitleMain: TLabel;
    btnSeeMore: TImage;
    btnStations: TImage;
    btnFines: TImage;
    lblStations: TLabel;
    lblFines: TLabel;
    Image10: TImage;
    imgWhiteMenu: TImage;
    lblMenuLicenses: TLabel;
    lblStationsMenu: TLabel;
    lblFinesMenu: TLabel;
    btnProfile: TImage;
    pnlMenu: TPanel;
    Panel1: TPanel;
    imgBlock2: TImage;
    imgBlock1: TImage;
    lblExp1: TLabel;
    lblExp2: TLabel;
    lblID1: TLabel;
    lblID2: TLabel;
    btnTrash2: TImage;
    btnTrash1: TImage;
    btnRenew1: TImage;
    btnRenew2: TImage;
    lblNext: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGenClick(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
    procedure btnStationsClick(Sender: TObject);
    procedure btnFinesClick(Sender: TObject);
    procedure imgBlueMenuBarClick(Sender: TObject);
    procedure imgWhiteMenuClick(Sender: TObject);
    procedure lblMenuLicensesClick(Sender: TObject);
    procedure lblTestsMenuClick(Sender: TObject);

    procedure btnSeeMoreClick(Sender: TObject);
    procedure lblStationsMenuClick(Sender: TObject);
    procedure lblFinesMenuClick(Sender: TObject);
    procedure LoadLicenses;
    procedure btnChange(btn: TImage; b: boolean);
    function colourBox: string;
    procedure pnlMenuClick(Sender: TObject);

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
  DBConnection, LoginScreenUI, LicenseGenerationUI, ProfileUI, RoutingUI,
  FinesUI, TestsUI, Shared_U;

procedure TfrmMain.btnChange(btn: TImage; b: boolean);
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

procedure TfrmMain.btnFinesClick(Sender: TObject);
// Navigates to Fines screen
begin
  frmMain.hide;
  frmFines.show;
end; // procedure btnFinesClick

procedure TfrmMain.btnGenClick(Sender: TObject);
// Navigates to License Generation screen
begin
  frmMain.hide;
  frmLicenseGen.show;
end; // procedure btnGenClick

procedure TfrmMain.btnProfileClick(Sender: TObject);
// Navigates to Profile screen
begin
  TMenu.Profile(frmMain);
end; // procedure btnProfileClick

procedure TfrmMain.btnSeeMoreClick(Sender: TObject);
// Navigates to License Generation screen via See More button
begin
  frmMain.hide;
  frmLicenseGen.show;
end; // procedure btnSeeMoreClick

procedure TfrmMain.btnStationsClick(Sender: TObject);
// Navigates to Routing screen
begin
  frmMain.hide;
  frmRouting.show;
end;

function TfrmMain.colourBox: string;
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

// procedure btnStationsClick

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
// Terminates the application on form close
begin
  application.terminate;
end; // procedure FormClose

procedure TfrmMain.FormShow(Sender: TObject);
// Loads user greeting and license info on form show
begin
  pnlMenu.visible := false;
  if bAdmin then
  begin
    lblTitleMain.caption := 'Hi, Admin';
  end // if admin
  else
  begin
    with DataModule1 do
    begin
      // getting first name for title
      try
        ADOQuery1.close;
        ADOQuery1.SQL.Text := 'SELECT * FROM tblUsers WHERE Username = "' +
          sUsername + '"';
        ADOQuery1.open;
      except
        on E: Exception do
          showmessage('Database Error: ' + E.message);
      end; // try..except

      if ADOQuery1.RecordCount > 0 then
      begin
        lblTitleMain.caption := 'Hi, ' + ADOQuery1.FieldByName
          ('FirstName').AsString;
      end; // if user found

      // fine number
      if bAdmin = false then
      begin
        try
          ADOQuery1.close;
          ADOQuery1.SQL.Text := 'SELECT * FROM tblFines WHERE LicenseID IN ( ' +
            'SELECT LicenseID FROM tblLicenses WHERE OwnerID = "' + sID +
            '") AND FineID NOT IN (SELECT FineID FROM tblPayments WHERE Status ="Paid")';
          ADOQuery1.open;
        except
          on E: Exception do
            showmessage('Database Error: ' + E.message);
        end; // try..except

        lblFines.caption := IntToStr(ADOQuery1.RecordCount) + ' Fines!';
        LoadLicenses;
      end; // if not admin
    end; // with
  end; // else not admin
end; // procedure FormShow

procedure TfrmMain.imgBlueMenuBarClick(Sender: TObject);
// Shows the side menu panel
begin
  pnlMenu.visible := true;
end; // procedure imgBlueMenuBarClick

procedure TfrmMain.imgWhiteMenuClick(Sender: TObject);
// Hides the side menu panel
begin
  pnlMenu.visible := false;
end; // procedure imgWhiteMenuClick

procedure TfrmMain.lblFinesMenuClick(Sender: TObject);
// Menu click to open Fines screen
begin
  TMenu.FinesScreen(frmMain)
end; // procedure lblFinesMenuClick

procedure TfrmMain.lblMenuLicensesClick(Sender: TObject);
// Menu click to open License screen
begin
  TMenu.LicenseScreen(frmMain)
end; // procedure lblMenuLicensesClick

procedure TfrmMain.lblStationsMenuClick(Sender: TObject);
// Menu click to open Routing screen
begin
  TMenu.RoutingScreen(frmMain)
end; // procedure lblStationsMenuClick

procedure TfrmMain.lblTestsMenuClick(Sender: TObject);
// Menu click to open Tests screen
begin
  TMenu.TestScreen(frmMain)
end;

procedure TfrmMain.LoadLicenses;
var
  iCount: Integer;
  sLicense: string;
begin
  with DataModule1 do
  begin
    ADOQuery1.SQL.Text :=
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
    ADOQuery1.SQL.Text :=
      'SELECT COUNT(*) AS TotalNumber FROM tblLicenses WHERE ownerID = "' +
      sID + '"';
    ADOQuery1.open;
    iCount := ADOQuery1.FieldByName('TotalNumber').AsInteger;

    ADOQuery1.close;
    ADOQuery1.SQL.Text :=
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
end; procedure TfrmMain.pnlMenuClick(Sender: TObject);
begin

end;

// procedure LoadLicenses

// procedure lblTestsMenuClick

end. // unit MainScreenUI
