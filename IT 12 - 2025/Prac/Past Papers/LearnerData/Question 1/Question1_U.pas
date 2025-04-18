// Enter your name here

unit Question1_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Spin, Math, ComCtrls, pngimage;

type
  TfrmQuestion1 = class(TForm)
    GroupBox1: TGroupBox;
    lblQ1_1: TLabel;
    GroupBox2: TGroupBox;
    spnQ1_2: TSpinEdit;
    Label1: TLabel;
    btnQ1_2: TButton;
    Label3: TLabel;
    lblQ1_2: TLabel;
    GroupBox4: TGroupBox;
    btnQ1_5: TButton;
    GroupBox5: TGroupBox;
    redQ1_4: TRichEdit;
    btnQ1_4: TButton;
    imgQ1_1: TImage;
    GroupBox3: TGroupBox;
    btnQ1_3: TButton;
    Label2: TLabel;
    edtQ1_3: TEdit;
    edtQ1_5: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnQ1_2Click(Sender: TObject);
    procedure btnQ1_3Click(Sender: TObject);
    procedure btnQ1_4Click(Sender: TObject);
    procedure btnQ1_5Click(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmQuestion1: TfrmQuestion1;
  arrNumbers: array [1 .. 10] of integer = (
    0,
    -12,
    -6,
    2,
    4,
    0,
    -1,
    5,
    -25,
    -4
  );

implementation

{$R *.dfm}

procedure TfrmQuestion1.FormCreate(Sender: TObject);
begin
  // Question 1.1

end;

procedure TfrmQuestion1.btnQ1_2Click(Sender: TObject);
begin
  // Question 1.2

end;

procedure TfrmQuestion1.btnQ1_3Click(Sender: TObject);
begin
  // Question 1.3

end;

procedure TfrmQuestion1.btnQ1_4Click(Sender: TObject);
begin
  // Question 1.4

end;

procedure TfrmQuestion1.btnQ1_5Click(Sender: TObject);
begin
  // Question 1.5

end;

end.
