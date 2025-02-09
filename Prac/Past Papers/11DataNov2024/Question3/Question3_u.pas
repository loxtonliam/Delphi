// TYPE YOUR NAME AND SURNAME HERE
unit Question3_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.Buttons, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmQ3 = class(TForm)
    lblHeading: TLabel;
    pgcMain: TPageControl;
    tabQ3_1: TTabSheet;
    tabQ3_2: TTabSheet;
    tabQ3_3: TTabSheet;
    dbgVolunteer: TDBGrid;
    dbgLog: TDBGrid;
    redOutput: TRichEdit;
    btnReset: TBitBtn;
    btnQ3_1_2: TButton;
    btnQ3_1_1: TButton;
    btnQ3_2_1: TButton;
    btnQ3_2_2: TButton;
    btnQ3_3: TButton;
    btnQ3_2_3: TButton;
    imgWeather: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnQ3_1_1Click(Sender: TObject);
    procedure btnQ3_1_2Click(Sender: TObject);
    procedure btnQ3_2_1Click(Sender: TObject);
    procedure btnQ3_2_2Click(Sender: TObject);
    procedure btnQ3_3Click(Sender: TObject);
    procedure btnQ3_2_3Click(Sender: TObject);
  private
    { Private declarations }
    procedure dbConnect;
  public
    { Public declarations }
  end;

var
  frmQ3: TfrmQ3;

  // PROVIDED CODE - DO NOT MODIFY! //
  conWeatherDB: TADOConnection;
  tblVolunteer, tblLog: TADOTable;
  dbsVolunteer, dbsLog: TDataSource;
  // END OF PROVIDED CODE //

implementation

{$R *.dfm}
{ TfrmQ3 }

// =============================================================================
// Question 3.1.1 (3 marks)
// =============================================================================
procedure TfrmQ3.btnQ3_1_1Click(Sender: TObject);
begin

  // QUESTION 3.1.1 //
  tblVolunteer.insert;
  tblVolunteer['VolunteerID'] := 'V026';
  tblVolunteer['FirstName'] := 'Johan';
  tblVolunteer['Surname'] := 'Van Den Berg';
  tblVolunteer['Contact'] := '0729486116';

  tblVolunteer.post;
  tblVolunteer.refresh;

end;

// =============================================================================
// Question 3.1.2 (6 marks)
// =============================================================================
procedure TfrmQ3.btnQ3_1_2Click(Sender: TObject);
var
  sVID: string;
begin

  // QUESTION 3.1.2 //
  sVID := UpperCase(inputbox('Input Required',
    'Please enter the Volunteer ID', ''));
  tblVolunteer.first;
  while not tblVolunteer.eof do
  begin

    if UpperCase(tblVolunteer['VolunteerID']) = sVID then
    begin
      showmessage('Their contact number is ' + tblVolunteer['Contact']);
    end;

    tblVolunteer.next;

  end;

end;

// =============================================================================
// Question 3.2.1 (5 marks)
// =============================================================================
procedure TfrmQ3.btnQ3_2_1Click(Sender: TObject);
var
  dSum: double;
begin

  // QUESTION 3.2.1 //
  dSum := 0;
  while not tblLog.eof do
  begin
    dSum := dSum + tblLog['Precipitation'];
    tblLog.next;

  end;
  showmessage('Total Precipitation to Date:' + FloatToStr(dSum) + 'mm');

end;

// =============================================================================
// Question 3.2.2 (8 marks)
// =============================================================================
procedure TfrmQ3.btnQ3_2_2Click(Sender: TObject);
var
  dMax: double;
  sHighDay: string;
begin

  // QUESTION 3.2.2 //
  dMax := 0;
  tblLog.first;
  while not tblLog.eof do
  begin
    if tblLog['Temperature'] > dMax then
    begin
      dMax := tblLog['Temperature'];
      sHighDay := tblLog['RecordDate'];
    end;
    tblLog.next;
  end;
  showmessage('The hottest day was on ' + sHighDay);

end;

// =============================================================================
// Question 3.2.3 (6 marks)
// =============================================================================
procedure TfrmQ3.btnQ3_2_3Click(Sender: TObject);
begin

  // QUESTION 3.2.3 //
  tblLog.first;
  while not tblLog.eof do
  begin
    if tblLog['VolunteerID'] = 'V016' then
    begin
      tblLog.edit;
      tblLog['Pressure'] := tblLog['Pressure'] + 1;
    end;
    tblLog.next;

  end;

end;

// =============================================================================
// Question 3.3.1 (12 marks)
// =============================================================================
procedure TfrmQ3.btnQ3_3Click(Sender: TObject);
var
  sCurrentID: string;
begin

  // PROVIDED CODE - DO NOT MODIFY! //
  tblLog.Sort := 'VolunteerID ASC';
  // END OF PROVIDED CODE //

  // QUESTION 3.3.1 //
  redOutput.clear;
  tblLog.first;
  sCurrentID := tblLog['VolunteerID'];
  redOutput.lines.add(sCurrentID);
  // redoutput.lines.add('');
  redOutput.lines.add('----------------------------------');
  // redOutput.lines.add('');
  while not tblLog.eof do
  begin
    if tblLog['VolunteerID'] = sCurrentID then
    begin
      redOutput.lines.add(tblLog['RecordDate']);
    end
    else
    begin
      sCurrentID := tblLog['VolunteerID'];
      redOutput.lines.add('');
      redOutput.lines.add(sCurrentID);

      redOutput.lines.add('----------------------------------');

      redOutput.lines.add(tblLog['RecordDate']);
    end;
    tblLog.next;
  end

end;

procedure TfrmQ3.btnResetClick(Sender: TObject);
begin

  // PROVIDED CODE - DO NOT MODIFY! //
  // RESET DATABASE //

  conWeatherDB.Destroy;

  tblVolunteer.Destroy;
  dbsVolunteer.Destroy;

  tblLog.Destroy;
  dbsLog.Destroy;

  CopyFile('WeatherDB - Backup.mdb', 'WeatherDB.mdb', false);

  dbConnect;

  dbgVolunteer.refresh;
  dbgLog.refresh;

  // END OF PROVIDED CODE //

end;

procedure TfrmQ3.dbConnect;
var
  sCurrentDir, sConnection: String;
begin

  // PROVIDED CODE - DO NOT MODIFY!  //

  // INITIALISE CONNECTION   //

  sCurrentDir := GetCurrentDir;

  sConnection := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=';
  sConnection := sConnection + sCurrentDir;
  sConnection := sConnection + '\WeatherDB.mdb;Persist Security Info=False';

  try
    conWeatherDB := TADOConnection.Create(Self);
    conWeatherDB.ConnectionString := sConnection;
    conWeatherDB.LoginPrompt := false;
    conWeatherDB.Connected := True;
  except
    showmessage('Error connecting to DB');
    exit;
  end;

  // INSTANTIATE COMPONENTS //

  // TABLE VOLUNTEER

  tblVolunteer := TADOTable.Create(Self);
  tblVolunteer.Connection := conWeatherDB;;
  tblVolunteer.TableName := 'Volunteer';
  tblVolunteer.Active := True;

  dbsVolunteer := TDataSource.Create(Self);
  dbsVolunteer.DataSet := tblVolunteer;

  dbgVolunteer.DataSource := dbsVolunteer;

  // TABLE LOG

  tblLog := TADOTable.Create(Self);
  tblLog.Connection := conWeatherDB;;
  tblLog.TableName := 'Log';
  tblLog.Active := True;

  dbsLog := TDataSource.Create(Self);
  dbsLog.DataSet := tblLog;

  dbgLog.DataSource := dbsLog;

  // FORMATTING

  tblLog.FieldByName('RecordDate').DisplayWidth := 10;

  // END OF PROVIDED CODE //

end;

procedure TfrmQ3.FormCreate(Sender: TObject);
begin

  // PROVIDED CODE - DO NOT MODIFY  ////
  dbConnect;
  pgcMain.ActivePageIndex := 0;
  // END OF PROVIDED CODE //
end;

end.
