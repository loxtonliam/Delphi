unit dmQuestion2_U;

interface

uses
  SysUtils, Classes, DB, ADODB, Forms;

type
  TdmQuestion2 = class(TDataModule)
    connFoodOrders: TADOConnection;
    qryQ2: TADOQuery;
    dsrQ2: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmQuestion2: TdmQuestion2;

implementation

{$R *.dfm}

procedure TdmQuestion2.DataModuleCreate(Sender: TObject);
begin

  connFoodOrders.ConnectionString :=
  'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+ExtractFilePath(Application.ExeName)+'\Question2DB.mdb;Mode=ReadWrite;Persist Security Info=False';
end;

end.
