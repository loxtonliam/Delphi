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
    lblTestsMenu: TLabel;
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
var
ResetIndex : integer;
begin
  imgStation.Picture.LoadFromFile(arrLocs[index] + '.jpg');
  lblName.caption := arrLocs[index];



  arrLocImgs[index].Picture.LoadFromFile('whiteloc.png');
  if arrow = 'R' then
  begin
    if index > 0 then
    begin
      ResetIndex := index-1
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
      ResetIndex := index+1
    end
    else
    begin
      ResetIndex := 0;
    end;

  end;
  arrLocImgs[ResetIndex].Picture.LoadFromFile('redloc.png')

end;

procedure TfrmRouting.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  application.Terminate;
end;

procedure TfrmRouting.FormShow(Sender: TObject);
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

  // init image
  for i := 0 to 7 do
  begin
    arrLocImgs[i].Picture.LoadFromFile('redloc.png')
  end;

  locChange('R')
end;

procedure TfrmRouting.btnGoClick(Sender: TObject);
{
  extracting coordinates by using DB and location selected
  - use openMap method to direct user to google maps
}
begin
  with DataModule1 do
  begin
    ADOQuery1.close;
    ADOQuery1.SQL.Text :=
      'SELECT * FROM tblLicensingStations WHERE stationID = ' +
      inttostr(index) + '';
    ADOQuery1.open;

    openMap(ADOQuery1.FieldByName('coordinates').AsString);
  end;
end;

procedure TfrmRouting.btnLArrowClick(Sender: TObject);
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

procedure TfrmRouting.btnRArrowClick(Sender: TObject);
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
end;

procedure TfrmRouting.imgBlueMenuBarClick(Sender: TObject);
begin
  pnlMenu.show;
end;

procedure TfrmRouting.imgWhiteMenuClick(Sender: TObject);
begin
  pnlMenu.Hide;
end;

procedure TfrmRouting.lblFinesMenuClick(Sender: TObject);
begin
  TMenu.FinesScreen(frmRouting)
end;

procedure TfrmRouting.lblLicenseClick(Sender: TObject);
begin
  TMenu.LicenseScreen(frmRouting)
end;

procedure TfrmRouting.lblMainMenuClick(Sender: TObject);
begin
  TMenu.MainScreen(frmRouting);
end;

procedure TfrmRouting.lblTestsMenuClick(Sender: TObject);
begin
  TMenu.TestScreen(frmRouting)
end;

procedure TfrmRouting.openMap(coords: string);
{
  uses shellexecute method
  - 0 indicates default browser
  - uses google maps url + selected coords

}

begin
  ShellExecute(0, 'open', PChar('https://www.google.com/maps?q=' + coords), nil,
    nil, SW_SHOWNORMAL);
end;

end.
