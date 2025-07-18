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
    lblNext: TLabel;
    lblLicense: TLabel;
    imgBlock1: TImage;
    imgBlock2: TImage;
    btnSeeMore: TImage;
    btnStations: TImage;
    btnFines: TImage;
    btnTests: TImage;
    lblStations: TLabel;
    lblFines: TLabel;
    lblTests: TLabel;
    Image10: TImage;
    imgWhiteMenu: TImage;
    lblMenuLicenses: TLabel;
    lblStationsMenu: TLabel;
    lblFinesMenu: TLabel;
    lblTestsMenu: TLabel;
    btnProfile: TImage;
    pnlMenu: TPanel;
    lblID1: TLabel;
    lblID2: TLabel;
    lblExp1: TLabel;
    lblExp2: TLabel;
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
    procedure btnTestsClick(Sender: TObject);
    procedure btnSeeMoreClick(Sender: TObject);
    procedure lblStationsMenuClick(Sender: TObject);
    procedure lblFinesMenuClick(Sender: TObject);
    procedure LoadLicenses;
    function colourBox(): string;

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
begin
  frmMain.hide;
  frmFines.show;
end;

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

procedure TfrmMain.btnSeeMoreClick(Sender: TObject);
begin
  frmMain.hide;
  frmLicenseGen.show;
end;

procedure TfrmMain.btnStationsClick(Sender: TObject);
begin
  frmMain.hide;
  frmRouting.show;
end;

procedure TfrmMain.btnTestsClick(Sender: TObject);
begin
  frmMain.hide;
  frmTests.show;
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
    end
    else
    begin
      result := 'GreenRec';
    end;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  application.terminate;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  pnlMenu.visible := false;
  if bAdmin then
  begin
    lblTitleMain.caption := 'Hi, Admin';
  end
  else
  begin
    with Datamodule1 do
    begin
      // getting first name for title

      ADOQuery1.close;
      ADOQuery1.SQL.Text := 'SELECT * FROM tblUsers WHERE Username = "' +
        sUsername + '"';
      ADOQuery1.open;
      if ADOQuery1.RecordCount > 0 then
      begin
        lblTitleMain.caption := 'Hi, ' + ADOQuery1.FieldByName
          ('FirstName').AsString;
      end;

      // fine number
      if badmin = false then
      begin
       ADOQuery1.close;
      ADOQuery1.SQL.Text := 'SELECT * FROM tblFines WHERE LicenseID IN ( ' +
        'SELECT LicenseID FROM tblLicenses WHERE OwnerID = "' + sID + '") AND FineID NOT IN (SELECT FineID FROM tblPayments WHERE Status ="Paid")';
      ADOQuery1.open;
      lblFines.caption := IntToStr(ADOQuery1.RecordCount) + ' Fines!';
      LoadLicenses;
      end;



    end;
  end;


end;

procedure TfrmMain.imgBlueMenuBarClick(Sender: TObject);
begin
  pnlMenu.visible := true;
end;

procedure TfrmMain.imgWhiteMenuClick(Sender: TObject);
begin
  pnlMenu.visible := false;
end;

procedure TfrmMain.lblFinesMenuClick(Sender: TObject);
begin
  TMenu.FinesScreen(frmMain)
end;

procedure TfrmMain.lblMenuLicensesClick(Sender: TObject);
begin
  TMenu.LicenseScreen(frmMain)
end;

procedure TfrmMain.lblStationsMenuClick(Sender: TObject);
begin
  TMenu.RoutingScreen(frmMain)
end;

procedure TfrmMain.lblTestsMenuClick(Sender: TObject);
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


end.
