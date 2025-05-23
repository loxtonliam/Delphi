unit TestsUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.WinXPickers;

type
  TfrmTests = class(TForm)
    imgBG: TImage;
    imgGreyDiv: TImage;
    imgSmallLlogo: TImage;
    imgBlueMenuBar: TImage;
    lblTestsTitle: TLabel;
    cmbType: TComboBox;
    DatePicker1: TDatePicker;
    lblType: TLabel;
    lblDate: TLabel;
    cmbStation: TComboBox;
    lblStation: TLabel;
    btnApply: TButton;
    pnlMenu: TPanel;
    lblMainMenu: TLabel;
    lblStationsMenu: TLabel;
    lblMenuLicenses: TLabel;
    lblFinesMenu: TLabel;
    imgWhiteMenu: TImage;
    btnProfile: TImage;
    procedure btnApplyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure imgWhiteMenuClick(Sender: TObject);
    procedure imgBlueMenuBarClick(Sender: TObject);
    procedure lblMainMenuClick(Sender: TObject);
    procedure lblMenuLicensesClick(Sender: TObject);
    procedure lblStationsMenuClick(Sender: TObject);
    procedure lblFinesMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTests: TfrmTests;

implementation

{$R *.dfm}

uses
  Shared_U, LoginScreenUI, DBConnection;

procedure TfrmTests.btnApplyClick(Sender: TObject);
var
  sType, sStation, sAppID, sStationID: string;
  dDate: TDateTime;

begin
  if TValidation.isValidIndex(cmbType.ItemIndex, 'Type') then
  begin
    sType := cmbType.items[cmbType.ItemIndex];
  end
  else
  begin
    exit;
  end;
  if TValidation.isValidIndex(cmbStation.ItemIndex, 'Station') then
  begin
    sStation := cmbStation.items[cmbStation.ItemIndex];
  end
  else
  begin
    exit;
  end;
  if DatePicker1.Date > Date then
  begin
    dDate := DatePicker1.Date;
  end
  else
  begin
    showmessage('Date must be later than today');
    exit;
  end;




  with DataModule1 do
  begin
    try
      sAppID := sID[1] + sType[1] + IntToSTr(random(801) + 100);
      ADOQuery1.Close;
      ADOQuery1.SQL.text := 'SELECT applicationID FROM tblTestApplications WHERE applicationID = "'+sAppID+'"';
      ADOQuery1.open;
      while ADOQuery1.RecordCount > 0 do
      begin
       sAppID := sID[1] + sType[1] + IntToSTr(random(801) + 100);
       ADOQuery1.Close;
       ADOQuery1.SQL.text := 'SELECT applicationID FROM tblTestApplications WHERE applicationID = "'+sAppID+'"';
       ADOQuery1.open;
      end;







      ADOQuery1.Close;
    ADOQuery1.SQL.Text :=
      'SELECT stationID FROM tblLicensingStations WHERE stationName = "' +
      sStation + '"';
    ADOQuery1.Open;
    sStationID := ADOQuery1.FieldByName('StationID').AsString;

    ADOQuery1.Close;
    ADOQuery1.SQL.Text := 'INSERT INTO tblTestApplications VALUES ("' + sAppID +
      '","' + DateToStr(dDate) + '","' + sType + '","Pending","' +
      DateToStr(Date) + '","' + DateToStr(Date) + '","' + sID + '","' +
      sStationID + '")';
    ADOQuery1.ExecSQL;
    showmessage('Successfully applied');
    except
      on E: Exception do
      begin
        showmessage('Something went wrong: ' + E.Message);
      end;

    end;

  end;

end;

procedure TfrmTests.FormClose(Sender: TObject; var Action: TCloseAction);
begin
application.Terminate;
end;

procedure TfrmTests.FormShow(Sender: TObject);
begin
pnlMenu.hide;
DataModule1.OpenTables;
end;

procedure TfrmTests.imgBlueMenuBarClick(Sender: TObject);
begin
pnlMenu.show;
end;

procedure TfrmTests.imgWhiteMenuClick(Sender: TObject);
begin
pnlMenu.hide;
end;

procedure TfrmTests.lblFinesMenuClick(Sender: TObject);
begin
TMenu.FinesScreen(frmTests)
end;

procedure TfrmTests.lblMainMenuClick(Sender: TObject);
begin
TMenu.MainScreen(frmTests)
end;

procedure TfrmTests.lblMenuLicensesClick(Sender: TObject);
begin
 TMenu.LicenseScreen(frmTests)
end;

procedure TfrmTests.lblStationsMenuClick(Sender: TObject);
begin
 TMenu.RoutingScreen(frmTests)
end;

end.
