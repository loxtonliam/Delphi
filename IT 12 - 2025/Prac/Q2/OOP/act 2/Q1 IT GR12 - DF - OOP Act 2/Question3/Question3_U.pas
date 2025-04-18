// Enter your examination number here

unit Question3_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Restaurant_U,
  ComCtrls, ExtCtrls, jpeg, Spin;

type
  TfrmQ3 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    edtCompanyName: TEdit;
    btnQ3_2_1: TButton;
    GroupBox2: TGroupBox;
    btnQ3_2_2: TButton;
    Label5: TLabel;
    edtOwnerName: TEdit;
    edtIDCode: TEdit;
    edtYearOpened: TEdit;
    Label2: TLabel;
    spnNumEmployees: TSpinEdit;
    GroupBox4: TGroupBox;
    edtAdd: TEdit;
    Label6: TLabel;
    btnQ3_2_3: TButton;
    Label7: TLabel;
    edtUpdated: TEdit;
    redQ3: TRichEdit;
    procedure btnQ3_2_1Click(Sender: TObject);
    procedure btnQ3_2_2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnQ3_2_3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQ3: TfrmQ3;
  // Provided code
  objRestaurant: TRestaurant;

implementation

{$R *.dfm}

// ======================================================================
// Question 3.2.1
// ======================================================================
procedure TfrmQ3.btnQ3_2_1Click(Sender: TObject);
begin
//Provided code
  redQ3.Clear;
// Question 3.2.1
objRestaurant := TRestaurant.create(edtCompanyName.text,edtYearOpened.text,spnNumEmployees.value);
redQ3.Lines.Add(objRestaurant.toString())

end;

// ======================================================================
// Question 3.2.2
// ======================================================================
procedure TfrmQ3.btnQ3_2_2Click(Sender: TObject);
var
sName:string;
begin
//Question 3.2.2
sName := edtOwnerName.text;
edtIDCode.text := objRestaurant.compileCode(sName);


end;

// ======================================================================
// Question 3.2.3
// ======================================================================
procedure TfrmQ3.btnQ3_2_3Click(Sender: TObject);
var
iNum:integer;
//Provided declaration
CONST
  iMaxEmployees  = 40;
begin
// Question 3.2.3
iNum := StrTOInt(edtadd.text);

if objRestaurant.getEmployees + iNum > iMaxEmployees then
begin
  edtUpdated.text := 'too many employees';
end
else
begin
objRestaurant.increaseNumEmployees(iNum);
 edtUpdated.text := INtToSTR(objRestaurant.getEmployees);
end;




end;

procedure TfrmQ3.FormShow(Sender: TObject);
begin
  btnQ3_2_1.SetFocus;
end;

end.
