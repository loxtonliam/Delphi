unit FinesUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Fines_U, Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.Tabs,
  Vcl.DockTabSet, Vcl.WinXPickers, Vcl.Samples.Spin, Data.DB;

type
  TfrmFines = class(TForm)
    imgBG: TImage;
    imgGreyDiv: TImage;
    lblFinesTitle: TLabel;
    ListBox1: TListBox;
    btnLoadFine: TButton;
    imgBlueMenuBar: TImage;
    pnlMenu: TPanel;
    lblTestsMenu: TLabel;
    lblLicense: TLabel;
    lblMainMenu: TLabel;
    lblRoutingMenu: TLabel;
    imgWhiteMenu: TImage;
    btnProfile: TImage;
    spnFine: TSpinEdit;
    DatePicker1: TDatePicker;
    btnSubmit: TButton;
    cmbType: TComboBox;
    cmbLicenses: TComboBox;
    btnPay: TImage;
    lblNoFines: TLabel;
    RichEdit1: TRichEdit;

    procedure FormShow(Sender: TObject);
    procedure btnLoadFineClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblMainMenuClick(Sender: TObject);
    procedure lblLicenseClick(Sender: TObject);
    procedure lblRoutingMenuClick(Sender: TObject);
    procedure lblTestsMenuClick(Sender: TObject);

    procedure btnSubmitClick(Sender: TObject);
    procedure imgBlueMenuBarClick(Sender: TObject);
    procedure btnPayClick(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ObjFine: TFine;
  end;

var
  frmFines: TfrmFines;
  sFineID: string;

implementation

{$R *.dfm}

uses
  DBConnection, LoginScreenUI, Shared_U, PaymentUI, ProfileUI;

procedure TfrmFines.btnLoadFineClick(Sender: TObject);
{
  - Extract selected fine from listbox
  - Create fine object using sql query (field by name)


}

var
  iPos: integer;
  sFineSelected: string;
begin
  ListBox1.hide;
  RichEdit1.show;
  sFineSelected := ListBox1.items[ListBox1.ItemIndex];
  if ListBox1.ItemIndex > -1 then
  begin
    iPos := pos('#', sFineSelected);
    sFineID := copy(sFineSelected, 1, iPos - 1);
    with Datamodule1 do
    begin
      ADOQuery1.close;
      ADOQuery1.SQL.Text :=
        'SELECT FineDate,LicenseID,FineType,FineAmount FROM tblFines WHERE FineID = "'
        + sFineID + '"';
      ADOQuery1.open;
      ObjFine := TFine.create(sFineID, sID, ADOQuery1.FieldByName('FineDate')
        .AsString, ADOQuery1.FieldByName('LicenseID').AsString,
        ADOQuery1.FieldByName('FineType').AsString,
        ADOQuery1.FieldByName('FineAmount').AsFloat);
    end;
    RichEdit1.clear;
    RichEdit1.lines.add(ObjFine.tostring);
    btnPay.show;
  end // if selected
  else
  begin
    showmessage('Please select a fine');
  end;
end;

procedure TfrmFines.btnPayClick(Sender: TObject);
begin
  TPay.PayFine(ObjFine.getFineID, ObjFine.getAmt);
end;

procedure TfrmFines.btnProfileClick(Sender: TObject);
begin
  frmFines.hide;
  frmProfile.show;
end;

procedure TfrmFines.btnSubmitClick(Sender: TObject);
{
  - allow admin to submit a fine on a specific license plate and give the reason + amount for fine

  - validate inputs
  - generate fineIDs until it is unique by checking with queries
  - update DB with new fine
}
var
  fineID, sType: string;
begin
  if (spnFine.value <> 0) AND (cmbLicenses.ItemIndex > -1) AND
    (DatePicker1.date >= date) then
  begin
    sType := cmbType.items[cmbType.ItemIndex];
    fineID := sType[1] + IntToStr(random(1000 - 100 + 1) + 100);
    with Datamodule1 do
    begin
      // check for ids
      ADOQuery1.close;
      ADOQuery1.SQL.Text := 'SELECT * FROM tblFines WHERE fineID = "' + fineID +
        '"'; // checking if unique
      ADOQuery1.open;
      while ADOQuery1.RecordCount > 0 do
      begin
        fineID := sType[1] + IntToStr(random(10000 - 1000 + 1) + 1000);
        // regenerate if not unique
        ADOQuery1.close;
        ADOQuery1.SQL.Text := 'SELECT * FROM tblFines WHERE fineID = "' +
          fineID + '"';
        ADOQuery1.open;

      end;

      // insert

      ADOQuery1.close;
      ADOQuery1.SQL.Text :=
        'INSERT INTO tblFines (FineID,FineAmount,FineDate,CreatedAt,UpdatedAt,FineType,LicenseID) VALUES (:FineID,:FineAmount,:FineDate,:Created,:Update,:FineType,:License)';
      ADOQuery1.parameters.ParamByName('FineID').value := fineID;

      ADOQuery1.parameters.ParamByName('FineAmount').value := spnFine.value;

      ADOQuery1.parameters.ParamByName('FineDate').DataType := ftDateTime;
      ADOQuery1.parameters.ParamByName('FineDate').value := DatePicker1.date;

      ADOQuery1.parameters.ParamByName('Created').value := date;

      ADOQuery1.parameters.ParamByName('Update').value := date;
      ADOQuery1.parameters.ParamByName('FineType').value := sType;
      ADOQuery1.parameters.ParamByName('License').value :=
        cmbLicenses.items[cmbLicenses.ItemIndex];

      ADOQuery1.ExecSQL;
    end;
    showmessage('added');
  end;

end;

procedure TfrmFines.FormClose(Sender: TObject; var Action: TCloseAction);
// close app if form close
begin
  Application.terminate;
end;

procedure TfrmFines.FormShow(Sender: TObject);
{
  setting UI based on user type
}
begin
  ListBox1.clear;
  lblNoFines.hide;
  pnlMenu.hide;
  btnPay.hide;
  DatePicker1.hide;
  DatePicker1.date := date;
  ListBox1.hide;
  btnSubmit.hide;

  spnFine.hide;

  Datamodule1.OpenTables;
  with Datamodule1 do
  begin

    if sID = '' then
    begin
      sID := 'FL4802'
    end;
    RichEdit1.hide;
    if bAdmin = True then
    begin
      cmbType.show;
      cmbLicenses.show;
      spnFine.show;
      DatePicker1.show;
      btnLoadFine.hide;
      btnSubmit.show;

      ADOQuery1.close;
      ADOQuery1.SQL.Text := 'SELECT LicenseID FROM tblLicenses';
      ADOQuery1.open;
      ADOQuery1.first;
      while not ADOQuery1.Eof do
      begin
        cmbLicenses.items.add(ADOQuery1.FieldByName('LicenseID').AsString);
        ADOQuery1.next;
      end;

    end
    else
    begin

      ListBox1.show;
      btnLoadFine.show;
      ADOQuery1.close;
      ADOQuery1.SQL.Text :=
        'SELECT * FROM tblFines WHERE LicenseID IN (SELECT LicenseID FROM tblLicenses WHERE OwnerID = "'
        + sID + '") AND FineID NOT IN (SELECT FineID FROM tblPayments WHERE Status = "Paid")';
      ADOQuery1.open;
      ADOQuery1.first;
      if ADOQuery1.RecordCount > 0 then
      begin
        while not ADOQuery1.Eof do
        begin
          ListBox1.items.add(ADOQuery1.FieldByName('FineID').AsString + '#' +
            floattostrf(ADOQuery1.FieldByName('FineAmount').AsCurrency,
            ffcurrency, 8, 2) + '#' + ADOQuery1.FieldByName('LicenseID')
            .AsString + '#' + ADOQuery1.FieldByName('FineType').AsString + '#' +
            ADOQuery1.FieldByName('FineDate').AsString);
          ADOQuery1.next;

        end;

        DatePicker1.hide;
        spnFine.hide;
        btnSubmit.hide;
      end
      else
      begin

        cmbType.hide;
        cmbLicenses.hide;
        btnLoadFine.hide;
        btnSubmit.hide;

        lblNoFines.show;
      end;

    end;
  end;

end;

procedure TfrmFines.imgBlueMenuBarClick(Sender: TObject);
// menu
begin
  pnlMenu.show;
end;

procedure TfrmFines.lblRoutingMenuClick(Sender: TObject);
// menu
begin
  TMenu.RoutingScreen(frmFines)
end;

procedure TfrmFines.lblLicenseClick(Sender: TObject);
// menu
begin
  TMenu.LicenseScreen(frmFines)
end;

procedure TfrmFines.lblMainMenuClick(Sender: TObject);
// menu
begin
  TMenu.MainScreen(frmFines)
end;

procedure TfrmFines.lblTestsMenuClick(Sender: TObject);
// menu
begin
  TMenu.TestScreen(frmFines)
end;

end.
