unit PaymentUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Imaging.pngimage;

type
  TfrmPayment = class(TForm)
    imgGreyDiv: TImage;
    imgBG: TImage;
    lblPaymentsTitle: TLabel;
    redPayDisplay: TRichEdit;
    cmbPayType: TComboBox;
    btnSimPay: TImage;
    procedure btnSimPayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sFineID: string;
    dFineAmt: double;
  end;

var
  frmPayment: TfrmPayment;

implementation

{$R *.dfm}

uses
  DBConnection, FinesUI, Fines_U;

procedure TfrmPayment.btnSimPayClick(Sender: TObject);
var
  sPayID, sType: string;
begin
  if cmbPayType.ItemIndex > -1 then
  begin
    sType := cmbPayType.items[cmbPayType.ItemIndex];

    with DataModule1 do
    begin
      // gen unique id

      try
        sPayID := 'P' + inttostr(random(1000 - 100 + 1) + 100);
        ADOQuery1.close;
        ADOQuery1.SQL.text := 'SELECT * FROM tblPayments WHERE PaymentID = "' +
          sPayID + '"';
        ADOQuery1.Open;
        while ADOQuery1.RecordCount > 0 do
        begin
          sPayID := 'P' + inttostr(random(1000 - 100 + 1) + 100);
          ADOQuery1.close;
          ADOQuery1.SQL.text := 'SELECT * FROM tblPayments WHERE PaymentID = "'
            + sPayID + '"';
          ADOQuery1.Open;
        end;

        ADOQuery1.close;
        ADOQuery1.SQL.text :=
          'INSERT INTO tblPayments VALUES(:ID,:Amt,:Date,:Method,:Status,:FineID)';
        ADOQuery1.Parameters.ParamByName('ID').Value := sPayID;
        ADOQuery1.Parameters.ParamByName('Amt').Value := dFineAmt;
        ADOQuery1.Parameters.ParamByName('Date').Value := Date;
        ADOQuery1.Parameters.ParamByName('Method').Value := sType;
        ADOQuery1.Parameters.ParamByName('Status').Value := 'Paid';
        ADOQuery1.Parameters.ParamByName('FineID').Value := sFineID;
        ADOQuery1.ExecSQL;

        showmessage('Fine succesfully paid, now returning to fines screen');
        frmPayment.hide;
        frmFines.show;
      except
        on E: Exception do
          Showmessage('Database error: ' + E.Message);

      end;

    end;
  end
  else
  begin
    Showmessage('Please select payment type before proceeding');
  end;
end;

procedure TfrmPayment.FormClose(Sender: TObject; var Action: TCloseAction);
begin
application.Terminate;
end;

procedure TfrmPayment.FormShow(Sender: TObject);
var
sOut :string;
begin
DataModule1.OpenTables;
sOUt := frmFines.ObjFine.toString;
redPayDisplay.clear;
redPayDisplay.lines.add(sOut);
end;

end.
