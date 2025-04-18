unit Question2_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TDBConnection_U, DB, ADODB,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TfrmQuestion2 = class(TForm)
    pgcQuestions: TPageControl;
    tbsQ2_1: TTabSheet;
    tbsQ2_2: TTabSheet;
    btnDBRestore: TButton;
    btn2_2_2: TButton;
    dbgSQL: TDBGrid;
    btn2_1_1: TButton;
    btn2_1_2: TButton;
    btn2_1_3: TButton;
    btn2_1_4: TButton;
    btn2_1_5: TButton;
    dbgPatients: TDBGrid;
    dbgTreatments: TDBGrid;
    redOutput: TRichEdit;
    btnClose: TBitBtn;
    btn2_2_1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btnDBRestoreClick(Sender: TObject);
    procedure btn2_2_1Click(Sender: TObject);
    procedure btn2_2_2Click(Sender: TObject);
    procedure btn2_1_1Click(Sender: TObject);
    procedure btn2_1_2Click(Sender: TObject);
    procedure btn2_1_3Click(Sender: TObject);
    procedure btn2_1_4Click(Sender: TObject);
    procedure btn2_1_5Click(Sender: TObject);
  private
    { Private declarations }
  var
    con: TADOConnection;
    tblTreatments: TADOTable;
    dbsTreatments: TDataSource;
    tblPatients: TADOTable;
    dbsPatients: TDataSource;
    qry: TADOQuery;
    dbsSQL: TDataSource;
    sSQL: string;
    procedure DBSetup();
  public
    { Public declarations }
  end;

var
  frmQuestion2: TfrmQuestion2;

implementation

{$R *.dfm}

procedure TfrmQuestion2.FormCreate(Sender: TObject);
begin
  // Provided code DO NOT MODIFY
  DBSetup();
  pgcQuestions.ActivePageIndex := 0;
end;

procedure TfrmQuestion2.btn2_1_1Click(Sender: TObject);
begin
  // Question 2.1.1

  sSQL := '';

  // Provided code DO NOT MODIFY
  qry.SQL.Clear;
  qry.SQL.ADD(sSQL);
  qry.Open;
  dbgSQL.Columns[0].Width := 80;
  dbgSQL.Columns[1].Width := 130;
  dbgSQL.Columns[2].Width := 140;
  dbgSQL.Columns[3].Width := 160;
  dbgSQL.Columns[4].Width := 410;

end;

procedure TfrmQuestion2.btn2_1_2Click(Sender: TObject);
Var
  sIDNumber: String;
begin
  //Provided code
  sIDNumber := InputBox('ID Number', 'Enter patient''s ID number:', '');

  // Question 2.1.2
  sSQL := '';

  // Provided code DO NOT MODIFY
  qry.SQL.Clear;
  qry.SQL.ADD(sSQL);
  qry.Open;
  dbgSQL.Columns[0].Width := 180;
  dbgSQL.Columns[1].Width := 140;
end;

procedure TfrmQuestion2.btn2_1_3Click(Sender: TObject);
begin
  // Question 2.1.3

  sSQL := '';

  // Provided code DO NOT MODIFY
  qry.SQL.Clear;
  qry.SQL.ADD(sSQL);
  qry.Open;
  dbgSQL.Columns[0].Width := 180;
  dbgSQL.Columns[1].Width := 140;
end;

procedure TfrmQuestion2.btn2_1_4Click(Sender: TObject);
begin
  // Question 2.1.4
  sSQL := '';

  // Provided code DO NOT MODIFY
  qry.SQL.Clear;
  qry.SQL.ADD(sSQL);
  qry.Open;
  dbgSQL.Columns[0].Width := 180;
  dbgSQL.Columns[1].Width := 140;
end;

procedure TfrmQuestion2.btn2_1_5Click(Sender: TObject);
begin
  //Question 2.1.5
  sSQL := '';

  // Provided code DO NOT MODIFY
  qry.SQL.Clear;
  qry.SQL.ADD(sSQL);
  qry.ExecSQL;
  showMessage('Records updated!');
end;

procedure TfrmQuestion2.btn2_2_1Click(Sender: TObject);
begin

  // Provided code DO NOT MODIFY
  redOutput.Clear;
  redOutput.Paragraph.TabCount := 3;
  redOutput.Paragraph.Tab[0] := 70;
  redOutput.Paragraph.Tab[1] := 70;
  redOutput.Paragraph.Tab[2] := 40;

  // Question 2.2.1



end;

procedure TfrmQuestion2.btn2_2_2Click(Sender: TObject);
begin
  // Question 2.2.2


end;

{$REGION}

procedure TfrmQuestion2.btnDBRestoreClick(Sender: TObject);
begin
  // Provided code DO NOT MODIFY
  con.Close();

  tblPatients.Close();
  tblTreatments.Close();

  DeleteFile('HospitalDB.mdb');
  CopyFile('BackupDB.mdb', 'HospitalDB.mdb', False);

  TDBConnection.DBConnect(con, Self);
  tblPatients.Open();

  dbgPatients.Columns[0].Width := 70;
  dbgPatients.Columns[1].Width := 100;
  dbgPatients.Columns[2].Width := 100;
  dbgPatients.Columns[3].Width := 100;
  dbgPatients.Columns[4].Width := 120;

  tblTreatments.Open();

  dbgTreatments.Columns[0].Width := 70;
  dbgTreatments.Columns[1].Width := 150;
  dbgTreatments.Columns[2].Width := 140;
  dbgTreatments.Columns[3].Width := 90;
  dbgTreatments.Columns[4].Width := 100;
  dbgTreatments.Columns[5].Width := 90;
  TFloatField(tblTreatments.FieldByName('Cost')).Currency := true;
  showMessage('Database restored!');
end;

procedure TfrmQuestion2.DBSetup;
begin
  // Provided code DO NOT MODIFY
  con := TADOConnection.Create(Self);
  TDBConnection.DBConnect(con, Self);

  tblPatients := TADOTable.Create(Self);
  tblPatients.Connection := con;
  tblPatients.TableName := 'tblPatients';
  tblPatients.Open();

  dbsPatients := TDataSource.Create(Self);
  dbsPatients.DataSet := tblPatients;

  dbgPatients.DataSource := dbsPatients;

  dbgPatients.Columns[0].Width := 70;
  dbgPatients.Columns[1].Width := 100;
  dbgPatients.Columns[2].Width := 120;
  dbgPatients.Columns[3].Width := 140;
  dbgPatients.Columns[4].Width := 130;

  tblTreatments := TADOTable.Create(Self);
  tblTreatments.Connection := con;
  tblTreatments.TableName := 'tblTreatments';
  tblTreatments.Open();

  dbsTreatments := TDataSource.Create(Self);
  dbsTreatments.DataSet := tblTreatments;

  dbgTreatments.DataSource := dbsTreatments;

  dbgTreatments.Columns[0].Width := 90;
  dbgTreatments.Columns[1].Width := 115;
  dbgTreatments.Columns[2].Width := 85;
  dbgTreatments.Columns[3].Width := 120;
  dbgTreatments.Columns[4].Width := 100;
  dbgTreatments.Columns[5].Width := 490;
  TFloatField(tblTreatments.FieldByName('Cost')).Currency := true;
  qry := TADOQuery.Create(Self);
  qry.Connection := con;

  dbsSQL := TDataSource.Create(Self);
  dbsSQL.DataSet := qry;

  dbgSQL.DataSource := dbsSQL;
end;

{$ENDREGION}

end.
