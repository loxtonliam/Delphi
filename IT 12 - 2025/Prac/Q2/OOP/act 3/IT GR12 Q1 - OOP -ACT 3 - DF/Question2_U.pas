// Enter your examination number here

unit Question2_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, CardHolder_U;

type
  TfrmQuestion2 = class(TForm)
    Panel1: TPanel;
    gbpQuestion2_1: TGroupBox;
    gpbQuestion2_2: TGroupBox;
    Label1: TLabel;
    lblCardNumber: TLabel;
    cmbCardNumbers: TComboBox;
    Panel2: TPanel;
    Label2: TLabel;
    lblLoyaltyPoints: TLabel;
    lblCellNumber: TLabel;
    Panel3: TPanel;
    Label3: TLabel;
    edtCode: TEdit;
    btnQuest221: TButton;
    redOutput: TRichEdit;
    btnQuest222: TButton;
    procedure cmbCardNumbersChange(Sender: TObject);
    procedure btnQuest221Click(Sender: TObject);
    procedure btnQuest222Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQuestion2: TfrmQuestion2;
  objCardHolder: TCardHolder;     // provided


implementation

{$R *.dfm}

procedure TfrmQuestion2.btnQuest221Click(Sender: TObject);

begin
  // Question 2.2.1
end;

procedure TfrmQuestion2.btnQuest222Click(Sender: TObject);
begin
  // Question 2.2.2
end;

// Provided code
procedure TfrmQuestion2.cmbCardNumbersChange(Sender: TObject);
begin
  edtCode.Clear;
  redOutput.Clear;
  btnQuest222.Enabled := false;

  case cmbCardNumbers.ItemIndex of
    0:
      begin
        lblLoyaltyPoints.caption := '2130';
        lblCellNumber.caption := '0812345678';
      end;

    1:
      begin
        lblLoyaltyPoints.caption := '5723';
        lblCellNumber.caption := '0822001100';
      end;

    2:
      begin
        lblLoyaltyPoints.caption := '12908';
        lblCellNumber.caption := '0740998877';
      end;

    3:
      begin
        lblLoyaltyPoints.caption := '500';
        lblCellNumber.caption := '0720951083';
      end;
  end;

end;

end.
