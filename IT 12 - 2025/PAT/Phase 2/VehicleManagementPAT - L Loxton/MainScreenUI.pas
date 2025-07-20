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
    imgSmallLlogo: TImage;
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
    lblLicense: TLabel;
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
end; // procedure btnStationsClick






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
        ADOQuery1.SQL.Text := 'SELECT * FROM tblUsers WHERE Username = "' + sUsername + '"';
        ADOQuery1.open;
      except
        on E: Exception do
          showmessage('Database Error: ' + E.message);
      end; // try..except

      if ADOQuery1.RecordCount > 0 then
      begin
        lblTitleMain.caption := 'Hi, ' + ADOQuery1.FieldByName('FirstName').AsString;
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
end; // procedure lblTestsMenuClick



end. // unit MainScreenUI

