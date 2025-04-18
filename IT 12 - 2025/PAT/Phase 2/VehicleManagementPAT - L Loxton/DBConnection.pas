unit DBConnection;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TDataModule1 = class(TDataModule)
    tblUsers: TADOTable;
    tblTestApplications: TADOTable;
    tblLicensingStations: TADOTable;
    tblLicenses: TADOTable;
    tblFines: TADOTable;
    tblCarOwners: TADOTable;
    tblAdminAccounts: TADOTable;
    dsTblUsers: TDataSource;
    dsCarOwners: TDataSource;
    dsTestApplications: TDataSource;
    dsAdminAccounts: TDataSource;
    dsLicensingStations: TDataSource;
    dsLicenses: TDataSource;
    dsFines: TDataSource;
    VehicleManagementDB: TADOConnection;
    ADOQuery1: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure OpenTables;
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



procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
 VehicleManagementDB.Close;

    //scroll to the right and add in your database name
   VehicleManagementDB.ConnectionString :='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+ExtractFilePath(ParamStr(0))+'VehicleManagementDB1.mdb'+';Persist Security Info=False';

   VehicleManagementDB.LoginPrompt := FALSE;

   VehicleManagementDB.Open;

   //Connection for every table you have
   tblUsers.Connection := VehicleManagementDB;//ADOTable1 must be named ADOtablename(your associated table)
   tblTestApplications.Connection := VehicleManagementDB;
   tblAdminAccounts.Connection := VehicleManagementDB;
   tblLicensingStations.Connection := VehicleManagementDB;
   tblLicenses.Connection := VehicleManagementDB;
   tblFines.Connection := VehicleManagementDB;
   tblCarOwners.Connection := VehicleManagementDB;


   //Each ADOTable is associated with each table name in access
   tblUsers.TableName := 'tblUsers';//table name spelled as in in MS access
   tblTestApplications.TableName := 'tblTestApplications';//table name spelled as in in MS access
   tblAdminAccounts.TableName := 'tblAdminAccounts';
   tblLicensingStations.TableName := 'tblLicensingStations';
   tblLicenses.TableName := 'tblLicenses';
   tblFines.TableName := 'tblFines';
   tblCarOwners.TableName := 'tblCarOwners';


   //a data source is named DSTableName.
   //each data source must be associated with the correct ADOtable
   dsTblUsers.DataSet := tblUsers;
   dsAdminAccounts.DataSet := tblAdminAccounts;
   dsTestApplications.DataSet := tblTestApplications;
   dsLicensingStations.DataSet := tblLicensingStations;
   dsLicenses.DataSet := tblLicenses;
   dsFines.DataSet := tblFines;
   dsCarOwners.DataSet := tblCarOwners;

  //leave this line of code commented
  ADOQuery1.Connection := VehicleManagementDB;
end;

procedure TDataModule1.OpenTables;
begin
 tblUsers.open;
 tblTestApplications.open;
 tblLicensingStations.open;
 tblLicenses.open;
 tblFines.open;
 tblCarOwners.open;
 tblAdminAccounts.open;
end;

end.
