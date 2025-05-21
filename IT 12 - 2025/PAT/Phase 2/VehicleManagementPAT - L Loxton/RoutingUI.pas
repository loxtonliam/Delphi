unit RoutingUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.net.HttpClient, Vcl.ExtCtrls,
  Vcl.imaging.jpeg, System.types, Vcl.StdCtrls, ShellAPI, Vcl.Imaging.pngimage;

type
  TfrmRouting = class(TForm)
    cmbLocs: TComboBox;
    imgStation: TImage;
    btnDirections: TButton;
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
    procedure FormShow(Sender: TObject);
    procedure cmbLocsChange(Sender: TObject);
    procedure btnDirectionsClick(Sender: TObject);
    procedure lblMainMenuClick(Sender: TObject);

    procedure lblFinesMenuClick(Sender: TObject);
    procedure lblTestsMenuClick(Sender: TObject);
    procedure lblLicenseClick(Sender: TObject);
    procedure imgBlueMenuBarClick(Sender: TObject);
    procedure imgWhiteMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function buildMap(const arrLocations: array of tPointf): string;
    procedure openMap(coords: string);
  end;

var
  frmRouting: TfrmRouting;
  arrLocations: array [0 .. 7] of tPointf;

implementation

{$R *.dfm}

uses
  DBConnection, Shared_U;

procedure TfrmRouting.btnDirectionsClick(Sender: TObject);
begin
  with DataModule1 do
  begin
    ADOQuery1.close;
    ADOQuery1.SQL.Text :=
      'SELECT * FROM tblLicensingStations WHERE stationID = ' +
      inttostr(cmbLocs.itemindex) + '';
    ADOQuery1.open;

    openMap(ADOQuery1.FieldByName('coordinates').AsString);
  end;
end;

function TfrmRouting.buildMap(const arrLocations: array of tPointf): string;
begin

end;

procedure TfrmRouting.cmbLocsChange(Sender: TObject);
begin
  imgStation.Picture.LoadFromFile(cmbLocs.Items[cmbLocs.itemindex] + '.jpg')
end;

procedure TfrmRouting.FormShow(Sender: TObject);
var
  sLat, sLong, sLine: string;
  iPos, icount: integer;
begin
  pnlMenu.Hide;


  icount := 0;
  with DataModule1 do
  begin
    OpenTables;
    try
      tblLicensingStations.First;
      while not tblLicensingStations.eof do
      begin
        sLine := tblLicensingStations['coordinates'];
        iPos := pos(',', sLine);
        sLat := copy(sLine, 1, iPos - 1);
        delete(sLine, 1, iPos);
        sLong := sLine;
        arrLocations[icount] := tPointf.Create(StrToFloat(sLat),
          StrToFloat(sLong));

        inc(icount);
        tblLicensingStations.next;
      end;
    except
      on E: exception do

    end;
  end;
end;

procedure TfrmRouting.imgBlueMenuBarClick(Sender: TObject);
begin
pnlMenu.show;
end;

procedure TfrmRouting.imgWhiteMenuClick(Sender: TObject);
begin
pnlMenu.hide;
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
begin
  ShellExecute(0, 'open', PChar('https://www.google.com/maps?q=' + coords), nil,
    nil, SW_SHOWNORMAL);
end;

end.
