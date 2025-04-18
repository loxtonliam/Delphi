// Enter your name here

unit Question3_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, Property_U, StdCtrls, ComCtrls, Spin, ExtCtrls;

type
  TfrmProperty = class(TForm)
    Panel1: TPanel;
    redQ3: TRichEdit;
    Label2: TLabel;
    btnQ3_2_2: TButton;
    Panel3: TPanel;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    edtQ3_2_1_Price: TEdit;
    spnQ3_2_1_Bedrooms: TSpinEdit;
    spnQ3_2_1_Bathrooms: TSpinEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnQ3_2_1: TButton;
    edtQ3_2_2: TEdit;
    Label7: TLabel;
    spnQ3_2_2: TSpinEdit;
    GroupBox1: TGroupBox;
    btnQ3_2_3: TButton;
    lblQ3_2_3: TLabel;
    lbl: TLabel;
    spnQ3_2_3: TSpinEdit;
    edtQ3_2_3_: TEdit;
    GroupBox2: TGroupBox;
    btnQ3_2_4: TButton;
    edtQ3_2_1_Address: TEdit;
    Image1: TImage;
    procedure btnQ3_2_2Click(Sender: TObject);
    procedure btnQ3_2_1Click(Sender: TObject);
    procedure btnQ3_2_3Click(Sender: TObject);
    procedure btnQ3_2_4Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProperty: TfrmProperty;
  objProperty: TProperty;

implementation

{$R *.dfm}

procedure TfrmProperty.btnQ3_2_1Click(Sender: TObject);
begin
  // Question 3.2.1

end;

procedure TfrmProperty.btnQ3_2_2Click(Sender: TObject);
begin
  // Provided code
  redQ3.Clear;

  // Question 3.2.2

end;

procedure TfrmProperty.btnQ3_2_3Click(Sender: TObject);
begin
  // Provided code
  redQ3.Clear;

  // Question 3.2.3

end;

procedure TfrmProperty.btnQ3_2_4Click(Sender: TObject);
var
  //Provided code
  tFile: textFile;
  //End of provided code

begin
  //Provided code
  AssignFile(tFile, 'properties.txt');
  Reset(tFile);
  //End of provided code

  // Question 3.2.4

end;

end.
