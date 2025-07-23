unit DBConnection;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TDataModule1 = class(TDataModule)
    tblUsers: TADOTable;
    tblLicensingStations: TADOTable;
    tblLicenses: TADOTable;
    tblFines: TADOTable;
    dsTblUsers: TDataSource;
    dsLicensingStations: TDataSource;
    dsLicenses: TDataSource;
    dsFines: TDataSource;
    VehicleManagementDB: TADOConnection;
    ADOQuery1: TADOQuery;
    tblPayments: TADOTable;
    dsPayments: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure OpenTables;
    function userToString(id:string): string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
uses
LoginScreenUI;



procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
 VehicleManagementDB.Close;

    //scroll to the right and add in your database name
   VehicleManagementDB.ConnectionString :='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+ExtractFilePath(ParamStr(0))+'VehicleManagementDB1.mdb'+';Persist Security Info=False';

   VehicleManagementDB.LoginPrompt := FALSE;

   VehicleManagementDB.Open;

   //Connection for every table you have
   tblUsers.Connection := VehicleManagementDB;//ADOTable1 must be named ADOtablename(your associated table)


   tblLicensingStations.Connection := VehicleManagementDB;
   tblLicenses.Connection := VehicleManagementDB;
   tblFines.Connection := VehicleManagementDB;
   tblPayments.Connection := VehicleManagementDB;



   //Each ADOTable is associated with each table name in access
   tblUsers.TableName := 'tblUsers';//table name spelled as in in MS access


   tblLicensingStations.TableName := 'tblLicensingStations';
   tblLicenses.TableName := 'tblLicenses';
   tblFines.TableName := 'tblFines';
   tblPayments.TableName := 'tblPayments';



   //a data source is named DSTableName.
   //each data source must be associated with the correct ADOtable
   dsTblUsers.DataSet := tblUsers;


   dsLicensingStations.DataSet := tblLicensingStations;
   dsLicenses.DataSet := tblLicenses;
   dsFines.DataSet := tblFines;
   dsPayments.DataSet := tblPayments;


  //leave this line of code commented
  ADOQuery1.Connection := VehicleManagementDB;
end;

procedure TDataModule1.OpenTables;
begin
 tblUsers.open;

 tblLicensingStations.open;
 tblLicenses.open;
 tblFines.open;
 tblPayments.open;
 
end;

function TDataModule1.userToString(id:string): string;
begin
with DataModule1 do
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Text := 'SELECT * FROM tblUsers WHERE userID = "'+id+'"';
  ADOQuery1.Open;
    result := 'ID: ' + ADOQuery1.FieldByName('userID').AsString + #13 +
      'Username: ' + ADOQuery1.FieldByName('Username').AsString + #13 +
      'First Name: ' + ADOQuery1.FieldByName('firstName').AsString + #13 +
      'lastName: ' + ADOQuery1.FieldByName('lastName').AsString + #13 +
      'Email: ' + ADOQuery1.FieldByName('emailAddress').asstring + #13 + 'Contact: ' +
      ADOQuery1.FieldByName('contactNumber').AsString + #13 + 'DOB: ' +
      ADOQuery1.FieldByName('dateOfBirth').AsString;
  end;

end;

end.
