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
  objCardHolder: TCardHolder; // provided
  fDatafile: textfile;


implementation

{$R *.dfm}

procedure TfrmQuestion2.btnQuest221Click(Sender: TObject);
var
  sCardNumber, sCellNumber, sLine: string;
  iPoints, iPos, iVisits: integer;
  dPurchases, dHealth: double;
  i: integer;
begin
  // Question 2.2.1
  iVisits := 0;
  dPurchases := 0;
  dHealth := 0;
  sCardNumber := cmbCardNumbers.items[cmbCardNumbers.itemindex];
  sCellNumber := lblCellNumber.Caption;
  iPoints := StrToInt(lblLoyaltyPoints.caption);

  objCardHolder := TCardHolder.create(sCardNumber, sCellNumber, iPoints);

  if objCardHolder.isCorrect(edtCode.text) then
  begin
    if FileExists('DataJanuary2017.txt') then
    begin
      AssignFile(fDatafile, 'DataJanuary2017.txt');
      Reset(fDatafile);
      while not eof(fDatafile) do
      begin
        Readln(fDatafile, sLine);
        if sLine = sCardNumber then
        begin
          inc(iVisits);

          delete(sLine, 1, length(sLine));
          Readln(fDatafile, sLine);
          dPurchases := dPurchases + StrToFloat(sLine);
          delete(sLine, 1, length(sLine));
          Readln(fDatafile, sLine);
          dHealth := dHealth + StrToFloat(sLine);

        end
        else
        begin
          delete(sline,1,length(sline));
          end;
        end;
      end;



     objCardHolder.increaseLoyaltyPoints(dPurchases);
     objCardHolder.setVisits(iVisits);
     objCardHolder.UpdateHealthStatus(dPurchases,dHealth);
     btnQuest222.enabled := true;

    end
    else
    begin
      showmessage('wrong code');
    end;

  end;

  procedure TfrmQuestion2.btnQuest222Click(Sender: TObject);
  begin
    // Question 2.2.2
    redOutput.lines.add(objCardHolder.toString(objCardHolder));
  end;

  // Provided code
  procedure TfrmQuestion2.cmbCardNumbersChange(Sender: TObject);
  begin
    edtCode.Clear;
    redOutput.Clear;
    btnQuest222.Enabled := false;

    case cmbCardNumbers.itemindex of
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
