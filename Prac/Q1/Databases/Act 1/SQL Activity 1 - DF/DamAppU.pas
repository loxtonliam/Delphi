unit DamAppU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, ADODB, DB;

type
  TForm1 = class(TForm)
    dbgDams: TDBGrid;
    dbgTowns: TDBGrid;
    rgpSQL: TRadioGroup;
    adoDams: TADOConnection;
    tblDams: TADOTable;
    tblTowns: TADOTable;
    dsDams: TDataSource;
    dsTowns: TDataSource;
    qryDams: TADOQuery;
    qryTowns: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure rgpSQLClick(Sender: TObject);
    procedure DamSQL(sSQL: String);
    procedure TownSQL(sSQL: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.rgpSQLClick(Sender: TObject);
var
  sName: string;
  ID : integer;
begin
  case rgpSQL.ItemIndex of

    0:
      begin
        dsDams.DataSet := tblDams;
        dsTowns.DataSet := tblTowns;
      end;

    1:
      begin
        DamSQL('SELECT DamName, YearCompleted, DamLevel FROM tblDams');
      end;

    2:
      begin
        DamSQL('');
      end;

    3:
      begin
        DamSQL('SELECT DamName, TownName, WaterRestrictions FROM tblDams, tblTowns WHERE tblDams.DamID = tblTowns.DamID AND WaterRestrictions = True');
      end;

    4:
      begin
        TownSQL('SELECT DamName, TownName, Province FROM tblDams, tblTowns WHERE tblDams.DamID = tblTowns.DamID AND Province IN ("KwaZulu-Natal", "Western Cape", "Gauteng")');
      end;

    5:
      begin
        DamSQL('SELECT DamName, TownName, Province FROM tblDams, tblTowns where tblDams.DamID = tblTowns.DamID AND Province NOT IN ("KwaZulu-Natal","Western Cape","Gauteng")');
      end;

    6:
      begin
        DamSQL('SELECT DamName, ROUND((DamLevel/Capacity*100),1) AS PercFull FROM tblDams WHERE ROUND((DamLevel/Capacity*100),1) < 50');
      end;

    7:
      begin
        TownSQL('SELECT Province, SUM(Population) AS TotalPop  FROM tblTowns GROUP BY Province HAVING SUM(Population) >= 1000000');
      end;

    8:
      begin
        sName := inputbox('', '', '');

        DamSQL('SELECT DamName, TownName, Province FROM tblDams, tblTowns WHERE tblDams.DamID = tblTowns.DamID AND Province LIKE "%'
          + sName + '%"');
      end;

    9:
      begin
        try
         DamSQL('INSERT INTO tblDams ( DamID, DamName, River, YearCompleted, DamLevel, Capacity, HeightOfWall) VALUES ( (SELECT MAX(DamID) + 1) "Kangaroo Dam", "Green River", "2019", "15000", "20000", "50") FROM tblDams');
        except
          on E:Exception do
            showmessage(E.Message);

        end;
        //DamSQL('SELECT MAX(DamID) +1 FROM tblDams');
      end;

    10:
      begin
        DamSQL('UPDATE tblTowns SET Population = Population + 100 WHERE Province = "Eastern Cape"');
        DamSQL ('SELECT SUM(Population) AS TotalPop, Province FROM tblTowns GROUP BY Province ')
      end;

  end;
end;

procedure TForm1.DamSQL(sSQL: String);
begin
  qryDams.Close;
  qryDams.SQL.Clear;
  qryDams.SQL.Add(sSQL);

  if UpperCase(copy(sSQL, 1, 6)) = 'SELECT' then
  begin
    qryDams.Open;
    dsDams.DataSet := qryDams;
  end
  else
  begin
    qryDams.ExecSQL;
  end;
end;

procedure TForm1.TownSQL(sSQL: String);
begin
  qryTowns.Close;
  qryTowns.SQL.Clear;
  qryTowns.SQL.Add(sSQL);

  if UpperCase(copy(sSQL, 1, 6)) = 'SELECT' then
  begin
    qryTowns.Open;
    dsTowns.DataSet := qryTowns;
  end
  else
  begin
    qryTowns.ExecSQL;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  // Setup DB
  adoDams.Close;
  adoDams.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' +
    ExtractFilePath(ParamStr(0)) + 'DamsDB.mdb' +
    ';Persist Security Info=False';
  adoDams.LoginPrompt := FALSE;
  adoDams.Open;

  tblDams.Connection := adoDams; // Repeat this for each table.
  qryDams.Connection := adoDams;

  tblTowns.Connection := adoDams;
  qryTowns.Connection := adoDams;

  tblDams.TableName := 'tblDams'; // Repeat this for each table
  tblTowns.TableName := 'tblTowns';

  dsDams.DataSet := tblDams; // Repeat this for each table
  dsTowns.DataSet := tblTowns;

  dbgDams.DataSource := dsDams;
  dbgTowns.DataSource := dsTowns;

  tblDams.Open;
  tblTowns.Open;

end;

end.
