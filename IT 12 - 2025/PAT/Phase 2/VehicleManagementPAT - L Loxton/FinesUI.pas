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
    imgBlueMenuBar: TImage;
    spnFine: TSpinEdit;
    cmbType: TComboBox;
    cmbLicenses: TComboBox;
    btnPay: TImage;
    lblNoFines: TLabel;
    RichEdit1: TRichEdit;
    pnlMenu: TPanel;
    lblStationsMenu: TLabel;
    lblMenuLicenses: TLabel;
    lblMainMenu: TLabel;
    imgWhiteMenu: TImage;
    btnProfile: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    grbUser: TGroupBox;
    btnLoad: TImage;
    btnSubmitFine: TImage;
    btnHighestAmnt: TImage;
    grbAdmin: TGroupBox;
    Label1: TLabel;
    Image9: TImage;

    procedure FormShow(Sender: TObject);
    procedure btnLoadFineClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblMainMenuClick(Sender: TObject);

    procedure lblTestsMenuClick(Sender: TObject);

    procedure imgBlueMenuBarClick(Sender: TObject);
    procedure btnPayClick(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
    procedure btnHighestClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnSubmitFineClick(Sender: TObject);
    procedure btnHighestAmntClick(Sender: TObject);
    procedure imgWhiteMenuClick(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure lblStationsMenuClick(Sender: TObject);
    procedure lblMenuLicensesClick(Sender: TObject);
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

procedure TfrmFines.btnHighestAmntClick(Sender: TObject);
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

procedure TfrmFines.btnLoadClick(Sender: TObject);
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

procedure TfrmFines.btnSubmitFineClick(Sender: TObject);
// Allows admin to submit a new fine with details and inserts it into the DB
var
  fineID, sType: string;
begin
  if spnFine.Value = 0 then
  begin
    showmessage('Fine amount cannot be 0');
    exit;
  end;
  if cmbLicenses.ItemIndex = -1 then
  begin
    showmessage('Please select a license');
    exit;
  end;

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
    ADOQuery1.Parameters.ParamByName('FineDate').Value := Date;
    ADOQuery1.Parameters.ParamByName('Created').Value := Date;
    ADOQuery1.Parameters.ParamByName('Update').Value := Date;
    ADOQuery1.Parameters.ParamByName('FineType').Value := sType;
    ADOQuery1.Parameters.ParamByName('License').Value :=
      cmbLicenses.Items[cmbLicenses.ItemIndex];

    ADOQuery1.ExecSQL;
  end; // end with DB module

  showmessage('Fine has been issued to selected license');
end; // procedure btnSubmitClick

// procedure btnSubmitClick

procedure TfrmFines.FormClose(Sender: TObject; var Action: TCloseAction);
// Closes the application
begin
  Application.Terminate;
end; // procedure FormClose

procedure TfrmFines.FormShow(Sender: TObject);
// Sets up UI depending on whether user is admin or not
begin
  pnlMenu.Hide;
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
      grbAdmin.Show;
      grbUser.Hide;
      btnSubmitFine.Show;
      spnFine.show;

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
      grbUser.Show;
      grbAdmin.Hide;
      ListBox1.Show;
      RichEdit1.Hide;
      btnPay.Hide;
      btnLoad.Show;
      ListBox1.Clear;

      ADOQuery1.close;
      ADOQuery1.sql.text :=
        'SELECT * FROM tblFines WHERE LicenseID IN (SELECT LicenseID FROM tblLicenses WHERE OwnerID = "'
        + sID + '" ) AND FineID NOT IN (SELECT FineID FROM tblPayments WHERE Status = "Paid") ORDER BY FineDate ASC';
      ADOQuery1.open;

      ADOQuery1.First;
      if ADOQuery1.RecordCount > 0 then
      begin
        lblNoFines.Hide;
        while not ADOQuery1.Eof do
        begin
          ListBox1.Items.Add(ADOQuery1.fieldByName('FineID').AsString + '#' +
            FloatToStrF(ADOQuery1.fieldByName('FineAmount').AsCurrency,
            ffCurrency, 8, 2) + '#' + ADOQuery1.fieldByName('LicenseID')
            .AsString + '#' + ADOQuery1.fieldByName('FineType').AsString + '#' +
            ADOQuery1.fieldByName('FineDate').AsString);
          ADOQuery1.Next;
        end; // while

        spnFine.Hide;
        btnSubmitFine.Hide;
      end
      else
      begin
        ListBox1.Hide;
        cmbType.Hide;
        cmbLicenses.Hide;
        btnLoad.Hide;
        btnSubmitFine.Hide;
        btnPay.Hide;
        lblNoFines.Show;
      end; // else no fines
    end; // else user
  end; // with
end;

procedure TfrmFines.Image9Click(Sender: TObject);
begin
  if bAdmin then
  begin
    showmessage
      ('Choose license you would like to issue a fine to, enter amount and reason for fine and click submit')
  end
  else
  begin
    showmessage
      ('Please select fine you would like to view and then press load fine, click the pay button to pay off the fine');
  end;
end;

// procedure FormShow

procedure TfrmFines.imgBlueMenuBarClick(Sender: TObject);
// Shows side menu
begin
  pnlMenu.Show;
end;

procedure TfrmFines.imgWhiteMenuClick(Sender: TObject);
begin
  pnlMenu.Hide;
end;

// procedure imgBlueMenuBarClick

procedure TfrmFines.lblStationsMenuClick(Sender: TObject);
begin
  TMenu.RoutingScreen(frmFines);
end;

// procedure lblRoutingMenuClick

procedure TfrmFines.lblMainMenuClick(Sender: TObject);
// Navigates to Main menu
begin
  TMenu.MainScreen(frmFines);
end;

procedure TfrmFines.lblMenuLicensesClick(Sender: TObject);
begin
  TMenu.LicenseScreen(frmFines);
end;

// procedure lblMainMenuClick

procedure TfrmFines.lblTestsMenuClick(Sender: TObject);
// Navigates to Tests menu
begin
  TMenu.TestScreen(frmFines);
end; // procedure lblTestsMenuClick

end. // unit FinesUI
