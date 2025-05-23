unit FinesUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Fines_U, Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.Tabs,
  Vcl.DockTabSet, Vcl.WinXPickers, Vcl.Samples.Spin;

type
  TfrmFines = class(TForm)
    imgBG: TImage;
    imgGreyDiv: TImage;
    lblFinesTitle: TLabel;
    btnSearchFines: TButton;
    ListBox1: TListBox;
    cmbSort: TComboBox;
    btnLoadFine: TButton;
    RichEdit1: TRichEdit;
    imgBlueMenuBar: TImage;
    pnlMenu: TPanel;
    lblTestsMenu: TLabel;
    lblLicense: TLabel;
    lblMainMenu: TLabel;
    lblRoutingMenu: TLabel;
    imgWhiteMenu: TImage;
    btnProfile: TImage;
    edtID: TEdit;
    spnFine: TSpinEdit;
    DatePicker1: TDatePicker;
    btnSubmit: TButton;
    btnSeachLicenses: TButton;
    cmbType: TComboBox;
    procedure btnSearchFinesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLoadFineClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblMainMenuClick(Sender: TObject);
    procedure lblLicenseClick(Sender: TObject);
    procedure lblRoutingMenuClick(Sender: TObject);
    procedure lblTestsMenuClick(Sender: TObject);
    procedure btnSeachLicensesClick(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
    procedure imgBlueMenuBarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ObjFine: TFine;
  end;

var
  frmFines: TfrmFines;

implementation

{$R *.dfm}

uses
  DBConnection, LoginScreenUI, Shared_U;

procedure TfrmFines.btnLoadFineClick(Sender: TObject);
var
  iPos: integer;
  sFineID, sFineSelected: string;
begin
  ListBox1.hide;
  RichEdit1.show;
  sFineSelected := ListBox1.items[ListBox1.ItemIndex];
  if ListBox1.ItemIndex > -1 then
  begin
    iPos := pos('#', sFineSelected);
    sFineID := copy(sFineSelected, iPos + 1, 4);
    with Datamodule1 do
    begin
      ADOQuery1.close;
      ADOQuery1.SQL.Text :=
        'SELECT *, (SELECT firstName &'' ''& lastName FROM tblUsers WHERE tblUsers.userID = tblFines.ownerID) AS fullName, (SELECT typeName FROM tblFineTypes WHERE tblFineTypes.typeID = tblFines.finetypeID) AS typeName   FROM tblFines WHERE fineID = "'
        + sFineID + '"';
      ADOQuery1.open;
      ObjFine := TFine.create(sID, ADOQuery1.FieldByName('fineDate').AsString,
        ADOQuery1.FieldByName('licenseID').AsString,
        ADOQuery1.FieldByName('typeName').AsString,
        ADOQuery1.FieldByName('fullName').AsString,
        ADOQuery1.FieldByName('fineAmount').AsFloat);
    end;
    RichEdit1.clear;
    RichEdit1.lines.add(ObjFine.tostring);
  end // if selected
  else
  begin
    showmessage('Please select a fine');
  end;
end;

procedure TfrmFines.btnSeachLicensesClick(Sender: TObject);
var
  sSearched: string;
begin
  if TValidation.notEmpty(edtID.Text, 'ID') then
  begin
    with Datamodule1 do
    begin
      ADOQuery1.close;
      ADOQuery1.SQL.Text :=
        'SELECT licenseID FROM tblLicenses WHERE ownerID = "' +
        edtID.Text + '"';
      ADOQuery1.open;
      while not ADOQuery1.Eof do
      begin
        ListBox1.items.add(ADOQuery1.FieldByName('licenseID').AsString);
        ADOQuery1.next;
      end;
    end;
  end;

end;

procedure TfrmFines.btnSearchFinesClick(Sender: TObject);
begin
  ListBox1.show;
  RichEdit1.hide;
  ListBox1.clear;
  with Datamodule1 do
  begin
    if cmbSort.ItemIndex > -1 then
    begin

      tblFines.sort := cmbSort.items[cmbSort.ItemIndex];
      tblFines.first;
      while not tblFines.Eof do
      begin
        if tblFines['ownerID'] = sID then
        begin
          ListBox1.items.add(datetostr(tblFines['fineDate']) + ' (' +
            floattostrf(tblFines['fineAmount'], ffcurrency, 8, 2) + ')' + ' #' +
            tblFines['fineID'] + '#');

        end; // if id
        tblFines.next;
      end;
    end // if sort
    else
    begin
      showmessage('select sorting method');
    end;

  end;
end;

procedure TfrmFines.btnSubmitClick(Sender: TObject);
var
  fineID, sType: string;
begin
  if (spnFine.value <> 0) AND (ListBox1.ItemIndex > -1) AND
    (DatePicker1.date >= date) then
  begin
    sType := cmbType.items[cmbType.ItemIndex];
    fineID := sType[1] + IntToStr(random(1000 - 100 + 1) + 100);
    with Datamodule1 do
    begin
      // check for ids
      ADOQuery1.close;
      ADOQuery1.SQL.Text := 'SELECT * FROM tblFines WHERE fineID = "' +
        fineID + '"';
      ADOQuery1.open;
      while ADOQuery1.RecordCount > 0 do
      begin
        fineID := sType[1] + IntToStr(random(1000 - 100 + 1) + 100);
        ADOQuery1.close;
        ADOQuery1.SQL.Text := 'SELECT * FROM tblFines WHERE fineID = "' +
          fineID + '"';
        ADOQuery1.open;

      end;

      // insert
      ADOQuery1.close;
      ADOQuery1.SQL.Text := 'INSERT INTO tblFines VALUES ("' + fineID + '","' +
        IntToStr(spnFine.value) + '","' + datetostr(DatePicker1.date) + '","' +
        datetostr(date) + '","' + datetostr(date) + '","' +
        IntToStr(cmbType.ItemIndex) + '","' + edtID.Text + '","' +
        ListBox1.items[ListBox1.ItemIndex] + '")';
      ADOQuery1.ExecSQL;
    end;
    ShowMessage('added') ;
  end;

end;

procedure TfrmFines.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.terminate;
end;

procedure TfrmFines.FormShow(Sender: TObject);
begin
pnlMenu.hide;
  Datamodule1.OpenTables;
  if sID = '' then
  begin
    sID := 'FL4802'
  end;
  RichEdit1.hide;
  if bAdmin = True then
  begin
    cmbSort.visible := false;
    btnSearchFines.hide;
    btnSearchFines.enabled := false;
    btnLoadFine.hide;

  end
  else
  begin
    edtID.hide;
    btnSeachLicenses.hide;
    DatePicker1.hide;
    spnFine.hide;
    btnSubmit.hide;
  end;

end;

procedure TfrmFines.imgBlueMenuBarClick(Sender: TObject);
begin
pnlMenu.show;
end;

procedure TfrmFines.lblRoutingMenuClick(Sender: TObject);
begin
  TMenu.RoutingScreen(frmFines)
end;

procedure TfrmFines.lblLicenseClick(Sender: TObject);
begin
  TMenu.LicenseScreen(frmFines)
end;

procedure TfrmFines.lblMainMenuClick(Sender: TObject);
begin
  TMenu.MainScreen(frmFines)
end;

procedure TfrmFines.lblTestsMenuClick(Sender: TObject);
begin
  TMenu.TestScreen(frmFines)
end;

end.
