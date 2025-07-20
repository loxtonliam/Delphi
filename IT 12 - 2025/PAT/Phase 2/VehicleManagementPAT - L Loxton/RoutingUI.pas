unit RoutingUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.net.HttpClient, Vcl.ExtCtrls,
  Vcl.imaging.jpeg, System.types, Vcl.StdCtrls, ShellAPI, Vcl.imaging.pngimage;

type
  TfrmRouting = class(TForm)
    imgBG: TImage;
    imgGreyDiv: TImage;
    lblRoutingTitle: TLabel;
    pnlMenu: TPanel;
    lblLicense: TLabel;
    lblMainMenu: TLabel;
    lblFinesMenu: TLabel;
    imgWhiteMenu: TImage;
    btnProfile: TImage;
    imgBlueMenuBar: TImage;
    Image1: TImage;
    Image2: TImage;
    lblName: TLabel;
    imgStation: TImage;
    btnLArrow: TImage;
    btnRArrow: TImage;
    btnGo: TImage;
    imgLocStell: TImage;
    imgLocKhay: TImage;
    imgLocKuils: TImage;
    imgLocParow: TImage;
    imgLocAtlantis: TImage;
    imgLocMiln: TImage;
    imgLocDurb: TImage;
    imgLocBrack: TImage;
    imgSmallLlogo: TImage;
    procedure FormShow(Sender: TObject);
    procedure lblMainMenuClick(Sender: TObject);
    procedure lblFinesMenuClick(Sender: TObject);
    procedure lblTestsMenuClick(Sender: TObject);
    procedure lblLicenseClick(Sender: TObject);
    procedure imgBlueMenuBarClick(Sender: TObject);
    procedure imgWhiteMenuClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure locChange(arrow: string);
    procedure btnRArrowClick(Sender: TObject);
    procedure btnLArrowClick(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure openMap(coords: string);
  end;

var
  frmRouting: TfrmRouting;
  arrLocs: array [0 .. 7] of string = (
    'Atlantis',
    'Brackenfell',
    'Durbanville',
    'Khayelitsha',
    'Kuils Rivier',
    'Milnerton',
    'Parow',
    'Stellenbosch'
  );
  index: integer;
  arrLocImgs: array [0 .. 7] of TImage;

implementation

{$R *.dfm}

uses DBConnection, Shared_U;

procedure TfrmRouting.locChange(arrow: string);
// Changes current location and updates UI indicator
var
  ResetIndex: integer;
begin
  imgStation.Picture.LoadFromFile(arrLocs[index] + '.jpg');
  lblName.caption := arrLocs[index];

  arrLocImgs[index].Picture.LoadFromFile('whiteloc.png');

  if arrow = 'R' then
  begin
    if index > 0 then
    begin
      ResetIndex := index - 1
    end
    else
    begin
      ResetIndex := 7;
    end;
  end
  else
  begin
    if index < 7 then
    begin
      ResetIndex := index + 1
    end
    else
    begin
      ResetIndex := 0;
    end;
  end;

  arrLocImgs[ResetIndex].Picture.LoadFromFile('redloc.png');
end; // procedure locChange

procedure TfrmRouting.FormClose(Sender: TObject; var Action: TCloseAction);
// Terminates application on form close
begin
  application.Terminate;
end; // procedure FormClose

procedure TfrmRouting.FormShow(Sender: TObject);
// Initializes map pins and sets default location
var
  i: integer;
begin
  pnlMenu.Hide;
  index := 0;

  // assigning locations pins
  arrLocImgs[0] := imgLocAtlantis;
  arrLocImgs[1] := imgLocBrack;
  arrLocImgs[2] := imgLocDurb;
  arrLocImgs[3] := imgLocKhay;
  arrLocImgs[4] := imgLocKuils;
  arrLocImgs[5] := imgLocMiln;
  arrLocImgs[6] := imgLocParow;
  arrLocImgs[7] := imgLocStell;

  for i := 0 to 7 do
  begin
    arrLocImgs[i].Picture.LoadFromFile('redloc.png');
  end;

  locChange('R');
end; // procedure FormShow

procedure TfrmRouting.btnGoClick(Sender: TObject);
// Loads coordinates for selected location and opens Google Maps
begin
  with DataModule1 do
  begin
    try
      ADOQuery1.close;
      ADOQuery1.SQL.Text :=
        'SELECT * FROM tblLicensingStations WHERE stationID = ' +
        inttostr(index) + '';
      ADOQuery1.open;
    except
      on E: Exception do
        showmessage('Database Error: ' + E.message);
    end;

    openMap(ADOQuery1.FieldByName('coordinates').AsString);
  end;
end; // procedure btnGoClick

procedure TfrmRouting.btnLArrowClick(Sender: TObject);
// Moves location index left and updates UI
begin
  if index > 0 then
  begin
    dec(index);
  end
  else
  begin
    index := 7;
  end;

  locChange('L');
end;
procedure TfrmRouting.btnProfileClick(Sender: TObject);
begin
TMenu.Profile(frmRouting);
end;



procedure TfrmRouting.btnRArrowClick(Sender: TObject);
// Moves location index right and updates UI
begin
  if index < 7 then
  begin
    inc(index);
  end
  else
  begin
    index := 0;
  end;

  locChange('R');
end; // procedure btnRArrowClick

procedure TfrmRouting.imgBlueMenuBarClick(Sender: TObject);
// Shows menu panel
begin
  pnlMenu.show;
end; // procedure imgBlueMenuBarClick

procedure TfrmRouting.imgWhiteMenuClick(Sender: TObject);
// Hides menu panel
begin
  pnlMenu.Hide;
end; // procedure imgWhiteMenuClick

procedure TfrmRouting.lblFinesMenuClick(Sender: TObject);
// Navigates to Fines screen
begin
  TMenu.FinesScreen(frmRouting);
end; // procedure lblFinesMenuClick

procedure TfrmRouting.lblLicenseClick(Sender: TObject);
// Navigates to License screen
begin
  TMenu.LicenseScreen(frmRouting);
end; // procedure lblLicenseClick

procedure TfrmRouting.lblMainMenuClick(Sender: TObject);
// Navigates to Main screen
begin
  TMenu.MainScreen(frmRouting);
end; // procedure lblMainMenuClick

procedure TfrmRouting.lblTestsMenuClick(Sender: TObject);
// Navigates to Tests screen
begin
  TMenu.TestScreen(frmRouting);
end; // procedure lblTestsMenuClick

procedure TfrmRouting.openMap(coords: string);
// Opens Google Maps with the given coordinates using the default browser
begin
  ShellExecute(0, 'open', PChar('https://www.google.com/maps?q=' + coords), nil, nil, SW_SHOWNORMAL);
end; // procedure openMap

end. // unit RoutingUI

