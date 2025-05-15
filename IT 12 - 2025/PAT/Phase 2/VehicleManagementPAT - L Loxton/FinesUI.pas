unit FinesUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Fines_U, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    imgBG: TImage;
    imgGreyDiv: TImage;
    lblFinesTitle: TLabel;
    btnSearchFines: TButton;
    ListBox1: TListBox;
    cmbSort: TComboBox;
    btnLoadFine: TButton;
    RichEdit1: TRichEdit;
    procedure btnSearchFinesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLoadFineClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ObjFine: TFine;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  DBConnection, LoginScreenUI;

procedure TForm1.btnLoadFineClick(Sender: TObject);
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
    sFineID := copy(sFineSelected, iPos + 1, 1);
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

procedure TForm1.btnSearchFinesClick(Sender: TObject);
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
      while not tblFines.eof do
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

procedure TForm1.FormShow(Sender: TObject);
begin
  Datamodule1.OpenTables;
  if sID = '' then
  begin
    sID := 'FL4802'
  end;

end;

end.
