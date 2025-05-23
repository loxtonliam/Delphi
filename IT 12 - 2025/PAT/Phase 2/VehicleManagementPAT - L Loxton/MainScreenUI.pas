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
    lblActive: TLabel;
    imgGreen: TImage;
    imgRedRec: TImage;
    btnGreenRenew: TImage;
    btnRedRenew: TImage;
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
        lblTitleMain.caption := 'Hi, ' + ADOQuery1.FieldByName('firstName').AsString;
      end;

      // fine number
      ADOQuery1.close;
      ADOQuery1.SQL.Text := 'SELECT * FROM tblFines WHERE ownerID = "' +
        sID + '"';
      ADOQuery1.open;
      lblFines.caption := IntToStr(ADOQuery1.RecordCount) + ' Fines!';

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

end.
