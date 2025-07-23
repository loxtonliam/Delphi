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
    btnHighest: TButton;

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
    procedure btnHighestClick(Sender: TObject);
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

procedure TfrmFines.btnHighestClick(Sender: TObject);
begin
  // displays the highest fine amount using max function in query
  with DataModule1.ADOQuery1 do
  begin

    try
      close;
      sql.text :=
        'SELECT * FROM tblFines WHERE FineAmount = (SELECT MAX(FineAmount) FROM tblFines)';
      open;
    except
      on E: exception do
        showmessage('Database error: ' + E.message);
    end;
    showmessage('The highest fine to date was for an amount of ' +
      fieldByName('FineAmount').AsString + ', incurred by license plate: ' +
      fieldByName('LicenseID').AsString);
  end;
end;

procedure TfrmFines.btnLoadFineClick(Sender: TObject);
// Loads selected fine from list and displays details using TFine object
var
  iPos: integer;
  sFineSelected: string;
begin
  ListBox1.Hide;
  RichEdit1.Show;
  sFineSelected := ListBox1.Items[ListBox1.ItemIndex];

  if ListBox1.ItemIndex > -1 then
  begin // if fine selected
    iPos := Pos('#', sFineSelected);
    sFineID := Copy(sFineSelected, 1, iPos - 1);

    with DataModule1 do
    begin // with DB module
      ADOQuery1.close;
      ADOQuery1.sql.text :=
        'SELECT FineDate,LicenseID,FineType,FineAmount FROM tblFines WHERE FineID = "'
        + sFineID + '"';
      ADOQuery1.open;

      ObjFine := TFine.Create(sFineID, sID, ADOQuery1.fieldByName('FineDate')
        .AsString, ADOQuery1.fieldByName('LicenseID').AsString,
        ADOQuery1.fieldByName('FineType').AsString,
        ADOQuery1.fieldByName('FineAmount').AsFloat);
    end; // end with DB module

    RichEdit1.Clear;
    RichEdit1.Lines.Add(ObjFine.ToString);
    btnPay.Show;
  end // end if selected
  else
  begin
    showmessage('Please select a fine');
  end; // else
end; // procedure btnLoadFineClick

procedure TfrmFines.btnPayClick(Sender: TObject);
// Initiates payment process for selected fine
begin
  TPay.PayFine(ObjFine.getFineID, ObjFine.getAmt);
end; // procedure btnPayClick

procedure TfrmFines.btnProfileClick(Sender: TObject);
// Opens profile screen
begin
  TMenu.Profile(frmFines);
end; // procedure btnProfileClick

procedure TfrmFines.btnSubmitClick(Sender: TObject);
// Allows admin to submit a new fine with details and inserts it into the DB
var
  fineID, sType: string;
begin
  if (spnFine.Value <> 0) AND (cmbLicenses.ItemIndex > -1) AND
    (DatePicker1.Date >= Date) then
  begin // validation
    sType := cmbType.Items[cmbType.ItemIndex];
    fineID := sType[1] + IntToStr(Random(901) + 100); // 100–1000

    with DataModule1 do
    begin // with DB module
      ADOQuery1.close;
      ADOQuery1.sql.text := 'SELECT * FROM tblFines WHERE FineID = "' +
        fineID + '"';
      ADOQuery1.open;

      while ADOQuery1.RecordCount > 0 do
      begin // generate new ID if duplicate
        fineID := sType[1] + IntToStr(Random(9001) + 1000); // 1000–10000
        ADOQuery1.close;
        ADOQuery1.sql.text := 'SELECT * FROM tblFines WHERE FineID = "' +
          fineID + '"';
        ADOQuery1.open;
      end; // while

      ADOQuery1.close;
      ADOQuery1.sql.text :=
        'INSERT INTO tblFines (FineID,FineAmount,FineDate,CreatedAt,UpdatedAt,FineType,LicenseID) '
        + 'VALUES (:FineID,:FineAmount,:FineDate,:Created,:Update,:FineType,:License)';

      ADOQuery1.Parameters.ParamByName('FineID').Value := fineID;
      ADOQuery1.Parameters.ParamByName('FineAmount').Value := spnFine.Value;
      ADOQuery1.Parameters.ParamByName('FineDate').DataType := ftDateTime;
      ADOQuery1.Parameters.ParamByName('FineDate').Value := DatePicker1.Date;
      ADOQuery1.Parameters.ParamByName('Created').Value := Date;
      ADOQuery1.Parameters.ParamByName('Update').Value := Date;
      ADOQuery1.Parameters.ParamByName('FineType').Value := sType;
      ADOQuery1.Parameters.ParamByName('License').Value :=
        cmbLicenses.Items[cmbLicenses.ItemIndex];

      ADOQuery1.ExecSQL;
    end; // end with DB module

    showmessage('Added');
  end; // if validation
end; // procedure btnSubmitClick

procedure TfrmFines.FormClose(Sender: TObject; var Action: TCloseAction);
// Closes the application
begin
  Application.Terminate;
end; // procedure FormClose

procedure TfrmFines.FormShow(Sender: TObject);
// Sets up UI depending on whether user is admin or not
begin
  ListBox1.Clear;
  lblNoFines.Hide;
  pnlMenu.Hide;
  btnPay.Hide;
  DatePicker1.Hide;
  DatePicker1.Date := Date;
  ListBox1.Hide;
  btnSubmit.Hide;
  spnFine.Hide;
  btnHighest.Hide;
  cmbLicenses.Hide;
  cmbType.Hide;

  DataModule1.OpenTables;

  with DataModule1 do
  begin
    if sID = '' then
    begin
      sID := 'FL4802';
    end; // if sID empty

    RichEdit1.Hide;

    if bAdmin = True then
    begin // admin UI
      cmbType.Show;
      cmbLicenses.Show;
      spnFine.Show;
      DatePicker1.Show;
      btnLoadFine.Hide;
      btnSubmit.Show;
      btnHighest.Show;

      ADOQuery1.close;
      ADOQuery1.sql.text := 'SELECT LicenseID FROM tblLicenses';
      ADOQuery1.open;

      ADOQuery1.First;
      while not ADOQuery1.Eof do
      begin
        cmbLicenses.Items.Add(ADOQuery1.fieldByName('LicenseID').AsString);
        ADOQuery1.Next;
      end; // while
    end
    else
    begin // normal user UI
      ListBox1.Show;
      RichEdit1.Hide;
      btnLoadFine.Show;

      ADOQuery1.close;
      ADOQuery1.sql.text :=
        'SELECT * FROM tblFines WHERE LicenseID IN (SELECT LicenseID FROM tblLicenses WHERE OwnerID = "'
        + sID + '" ) AND FineID NOT IN (SELECT FineID FROM tblPayments WHERE Status = "Paid")';
      ADOQuery1.open;

      ADOQuery1.First;
      if ADOQuery1.RecordCount > 0 then
      begin
        while not ADOQuery1.Eof do
        begin
          ListBox1.Items.Add(ADOQuery1.fieldByName('FineID').AsString + '#' +
            FloatToStrF(ADOQuery1.fieldByName('FineAmount').AsCurrency,
            ffCurrency, 8, 2) + '#' + ADOQuery1.fieldByName('LicenseID')
            .AsString + '#' + ADOQuery1.fieldByName('FineType').AsString + '#' +
            ADOQuery1.fieldByName('FineDate').AsString);
          ADOQuery1.Next;
        end; // while

        DatePicker1.Hide;
        spnFine.Hide;
        btnSubmit.Hide;
      end
      else
      begin
        ListBox1.Hide;
        cmbType.Hide;
        cmbLicenses.Hide;
        btnLoadFine.Hide;
        btnSubmit.Hide;
        lblNoFines.Show;
      end; // else no fines
    end; // else user
  end; // with
end; // procedure FormShow

procedure TfrmFines.imgBlueMenuBarClick(Sender: TObject);
// Shows side menu
begin
  pnlMenu.Show;
end; // procedure imgBlueMenuBarClick

procedure TfrmFines.lblRoutingMenuClick(Sender: TObject);
// Navigates to Routing menu
begin
  TMenu.RoutingScreen(frmFines);
end; // procedure lblRoutingMenuClick

procedure TfrmFines.lblLicenseClick(Sender: TObject);
// Navigates to License menu
begin
  TMenu.LicenseScreen(frmFines);
end; // procedure lblLicenseClick

procedure TfrmFines.lblMainMenuClick(Sender: TObject);
// Navigates to Main menu
begin
  TMenu.MainScreen(frmFines);
end; // procedure lblMainMenuClick

procedure TfrmFines.lblTestsMenuClick(Sender: TObject);
// Navigates to Tests menu
begin
  TMenu.TestScreen(frmFines);
end; // procedure lblTestsMenuClick

end. // unit FinesUI
