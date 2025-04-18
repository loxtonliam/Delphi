// TYPE YOUR NAME AND SURNAME HERE
unit Question1_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TfrmQuestion1 = class(TForm)
    pnlHeading: TPanel;
    imgShoe: TImage;
    GroupBox1: TGroupBox;
    btnTypeSize: TButton;
    cbxType: TComboBox;
    lblType: TLabel;
    lblPopularity: TLabel;
    GroupBox2: TGroupBox;
    spnSize: TSpinEdit;
    edtCost: TEdit;
    lblCost: TLabel;
    btnCalcCost: TButton;
    GroupBox3: TGroupBox;
    spnLearners: TSpinEdit;
    spnShoes: TSpinEdit;
    memOut: TMemo;
    btnShare: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox4: TGroupBox;
    rgpSole: TRadioGroup;
    btnShoeUsage: TButton;
    procedure btnTypeSizeClick(Sender: TObject);
    procedure btnShareClick(Sender: TObject);
    procedure btnCalcCostClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnShoeUsageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQuestion1: TfrmQuestion1;

implementation

{$R *.dfm}

procedure TfrmQuestion1.FormShow(Sender: TObject);
begin

  // QUESTION 1.1 //

end;

procedure TfrmQuestion1.btnTypeSizeClick(Sender: TObject);
begin

  // QUESTION 1.2 //

end;

procedure TfrmQuestion1.btnCalcCostClick(Sender: TObject);
begin

  // QUESTION 1.3 //

end;

procedure TfrmQuestion1.btnShareClick(Sender: TObject);
begin

  // QUESTION 1.4 //

end;

procedure TfrmQuestion1.btnShoeUsageClick(Sender: TObject);
begin

  // QUESTION 1.5 //



end;

end.
