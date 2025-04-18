unit TDBConnection_U;

interface

uses
  DB, ADODB, Classes;

type
  TDBConnection = class(TObject)
    public
      class procedure DBConnect(var connection: TADOConnection; owner: TComponent);
    end;

implementation

{ TDBConnection }

class procedure TDBConnection.DBConnect(var connection: TADOConnection; owner: TComponent);
begin
  connection.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=HospitalDB.mdb;' +
                                 'Mode=ReadWrite;Persist Security Info=False;Jet OLEDB:Database Password=""';
  connection.LoginPrompt := False;
  connection.Connected := True;
end;

end.
