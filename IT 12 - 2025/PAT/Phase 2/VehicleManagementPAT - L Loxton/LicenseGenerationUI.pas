unit LicenseGenerationUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, DateUtils;

type
  TfrmLicenseGen = class(TForm)
    btnGen: TButton;
    RichEdit1: TRichEdit;
    cmbLicenseType: TComboBox;
    cmbProvince: TComboBox;
    procedure btnGenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLicenseGen: TfrmLicenseGen;

implementation

{$R *.dfm}

uses
  LoginScreenUI, DBConnection, Shared_U;

procedure TfrmLicenseGen.btnGenClick(Sender: TObject);
var
  sProv, sType, sLicense, sNewest, sNum: string;
  i: Integer;

begin
  sProv := cmbProvince.Items[cmbProvince.ItemIndex];
  sType := cmbLicenseType.Items[cmbLicenseType.ItemIndex];
  with DataModule1 do
  begin

    try
      ADOQuery1.close;
      ADOQuery1.SQL.text :=
        'SELECT Top 1 * FROM tblLicenses ORDER BY createdAt DESC';
      ADOQuery1.open;
      if not ADOQuery1.IsEmpty then
      begin
       sNewest := tblLicenses['LicenseID'];
      end
      else
      begin
        sNewest := '';
      end;
      
    except
      on E: Exception do
        sNewest := '';
    end;

  end;

  if sNewest = '' then
  begin
    sNum := '1';
  end
  else
  begin
    for i := 1 to length(sNewest) do
    begin
      if strtoint(sNewest[i]) in [0 .. 9] then
      begin
        sNum := sNum + sNewest[i];
      end;
    end;
    sNum := Inttostr(strtoint(sNum) + 1);

  end;

  case cmbProvince.ItemIndex of

  0: sLicense := 'B ' + sNum + ' GP';
  1: sLicense := 'CA ' + sNum;
  2: sLicense := 'ND ' + sNum;
  3: sLicense := 'EL ' + sNum + ' EC';
  4: sLicense := 'L ' + sNum + ' L';
  5: sLicense := sNum + ' MP';
  6: sLicense := sNum + ' NW';
  7: sLicense := sNum + ' NC';
  8: sLicense := sNum + ' FS';
  

  end;

  with DataModule1 do
  begin
    tblLicenses.insert;
    TDB.UpdateField('licenseID',sLicense,tblLicenses);
    TDB.UpdateField('licenseType',sType,tblLicenses);
    TDB.UpdateField('ExpirationDate',DateTostr(incYear(Date,1)),tblLicenses);
    TDB.UpdateField('createdAt',DateToStr(Date),tblLicenses);
    TDB.UpdateField('updatedAt',datetostr(Date),tblLicenses);
    TDB.UpdateField('ownerID',sID,tblLicenses);
    TDB.UpdateField('province',sProv,tblLicenses);
    tblLicenses.post;
    tblLicenses.Refresh;
  end;

  showmessage('License added: ' + sLicense);
end;

procedure TfrmLicenseGen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

end.
