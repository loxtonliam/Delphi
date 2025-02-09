//Prelim 2018 - Question 2
//Name and Surname
unit Question2_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DB, ADODB, DBGrids, Menus, dmQuestion2_U, ComCtrls, StdCtrls, math;

type
  TfrmQuestion2 = class(TForm)
    mmOptions: TMainMenu;
    grdQ2: TDBGrid;
    OptionC1: TMenuItem;
    OptionD1: TMenuItem;
    OptionE1: TMenuItem;
    PageControl1: TPageControl;
    tbsQ2_1: TTabSheet;
    tbsQ2_2: TTabSheet;
    OptionA1: TMenuItem;
    OptionB1: TMenuItem;
    dbgClients: TDBGrid;
    dbgOrders: TDBGrid;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    RestoreDatabase1: TMenuItem;
    GroupBox1: TGroupBox;
    redDisplay: TRichEdit;
    btnGender: TButton;
    btnDelete: TButton;
    btnNewClient: TButton;
    procedure OptionA1Click(Sender: TObject);
    procedure OptionB1Click(Sender: TObject);
    procedure OptionC1Click(Sender: TObject);
    procedure OptionD1Click(Sender: TObject);
    procedure OptionE1Click(Sender: TObject);
    procedure tbsQ2_1Show(Sender: TObject);
    procedure tbsQ2_2Show(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RestoreDatabase1Click(Sender: TObject);
    procedure btnGenderClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnNewClientClick(Sender: TObject);
  private
    { Private declarations }
    tblClients : TADOtable;
    tblOrders : TADOtable;
    dsrClients: TDataSource;
    dsrOrders: TDataSource;
  public
    { Public declarations }
  end;

var
  frmQuestion2: TfrmQuestion2;

implementation

{$R *.dfm}

procedure TfrmQuestion2.btnGenderClick(Sender: TObject);
var
  iFemales, iMales  : integer;
begin
  //Question 2.2.1 - Code here

end;

procedure TfrmQuestion2.btnDeleteClick(Sender: TObject);
begin
  //Question 2.2.2 - Code here
end;

procedure TfrmQuestion2.btnNewClientClick(Sender: TObject);
var
  sName, sSurname, sID, sCell, sClientID : string;
  cGender : char;
begin
  //Given Code
  sName := InputBox('Register Client','Enter Name','Jacques');
  sSurname := InputBox('Register Client','Enter Surname','Terblance');
  sID := InputBox('Register Client','Enter ID','0010256007084');
  sCell := InputBox('Register Client','Enter Cellphone Number','0819871564');
  cGender := InputBox('Register Client','Gender <M/F>?','M')[1];
  sClientID := Uppercase(copy(sName,1,2)) +Uppercase(copy(sSurname,1,2)) + inttostr(randomrange(10,100));
  //Question 2.2.3 - Code here

end;

procedure TfrmQuestion2.OptionA1Click(Sender: TObject);
begin
  with dmQuestion2 do
  begin
    qryQ2.SQL.Clear;
    qryQ2.SQL.Add('SELECT * FROM tblClients ORDER BY Surname, Name ');
    qryQ2.Open;
  end;
end;

procedure TfrmQuestion2.OptionB1Click(Sender: TObject);
begin
  with dmQuestion2 do
  begin
    qryQ2.SQL.Clear;
    qryQ2.SQL.Add('SELECT OrderID, OrderDate, ProductDescription FROM tblOrders WHERE ProductDescription = "Milk" AND OrderDate BETWEEN #18/08/2018# AND #25/08/2018#');
    qryQ2.Open;
  end;
end;

procedure TfrmQuestion2.OptionC1Click(Sender: TObject);
begin
  with dmQuestion2 do
  begin
    qryQ2.SQL.Clear;
    qryQ2.SQL.Add('SELECT ClientID, OrderDate, FORMAT(SUM(Number * Price), "CURRENCY") AS [Total Cost] FROM tblOrders GROUP BY ClientID, OrderDate');
    qryQ2.Open;
  end;
end;

procedure TfrmQuestion2.OptionD1Click(Sender: TObject);
begin
  with dmQuestion2 do
  begin
    qryQ2.SQL.Clear;
    qryQ2.SQL.Add('UPDATE tblClients SET PremiumUser = True WHERE Gender = "F" AND CellNumber LIKE "083%"');
    qryQ2.ExecSQL;
    MessageDlg('Records have been updated', mtInformation,[mbok],0);
  end;
end;

procedure TfrmQuestion2.OptionE1Click(Sender: TObject);
begin
 with dmQuestion2 do
  begin
    qryQ2.SQL.Clear;
    qryQ2.SQL.Add('INSERT INTO tblOrders VALUES ("Ham200", Now(), "Hamburger", 3, 15, "YAIS92")');
    qryQ2.ExecSQL;
    MessageDlg('Record have been inserted', mtInformation,[mbok],0);
  end;
end;

procedure TfrmQuestion2.FormActivate(Sender: TObject);
begin
{$region Connect}
  tblClients := TADOtable.Create(frmQuestion2);
  tblClients.Connection := dmQuestion2.connFoodOrders;
  tblClients.TableName := 'tblClients';
  tblClients.Open;

  tblOrders := TADOtable.Create(frmQuestion2);
  tblOrders.Connection := dmQuestion2.connFoodOrders;
  tblOrders.TableName := 'tblOrders';
  tblOrders.Open;

  dsrClients := TdataSource.Create(frmQuestion2);
  dsrClients.DataSet := tblClients;
  dbgClients.DataSource := dsrClients;

  dsrOrders := TdataSource.Create(frmQuestion2);
  dsrOrders.DataSet := tblOrders;
  dbgOrders.DataSource := dsrOrders;

  dbgClients.Columns[1].Width := 100;
  dbgClients.Columns[2].Width := 100;

  dbgOrders.Columns[1].Width := 100;
  dbgOrders.Columns[2].Width := 100;

  {$endregion}
  tbsQ2_1.Show;
end;

{$region Hide}

procedure TfrmQuestion2.RestoreDatabase1Click(Sender: TObject);
var
  bFail : boolean;
begin
  dmQuestion2.connFoodOrders.Close;
  tblClients.Destroy;
  tblOrders.Destroy;

  DeleteFile('Question2DB.mdb');
  CopyFile('Question2DBBACKUP.mdb','Question2DB.mdb',bFail);

  dmQuestion2.connFoodOrders.Open();

  frmQuestion2.Activate;
end;

procedure TfrmQuestion2.tbsQ2_2Show(Sender: TObject);
begin
  mmOptions.Items[0].Visible := false;
  mmOptions.Items[1].Visible := false;
  mmOptions.Items[2].Visible := false;
  mmOptions.Items[3].Visible := false;
  mmOptions.Items[4].Visible := false;

  frmQuestion2.Activate;
end;

procedure TfrmQuestion2.tbsQ2_1Show(Sender: TObject);
begin
  mmOptions.Items[0].Visible := true;
  mmOptions.Items[1].Visible := true;
  mmOptions.Items[2].Visible := true;
  mmOptions.Items[3].Visible := true;
  mmOptions.Items[4].Visible := true;
  dmQuestion2.qryQ2.Close;
end;

{$endregion}

end.
