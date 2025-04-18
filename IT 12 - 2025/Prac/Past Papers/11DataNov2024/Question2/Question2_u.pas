// TYPE YOUR NAME AND SURNAME HERE
unit Question2_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmQuestion2 = class(TForm)
    edtBookName: TEdit;
    edtISBN: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnAddBook: TButton;
    Label3: TLabel;
    edtAuthor: TEdit;
    redOut: TRichEdit;
    procedure btnAddBookClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    // QUESTION 2.1 to QUESTION 2.4 //
    function IsPresent(sInput: string): boolean;
    function CapitaliseNames(sInput: string): string;
    function isValidISBN(ISBN: string): boolean;
    procedure DisplayBook(sBookName, sAuthor, ISBN: string);

  end;

var
  frmQuestion2: TfrmQuestion2;

implementation

{$R *.dfm}
{ TForm1 }


function TfrmQuestion2.IsPresent(sInput: string): boolean;
begin
  // Question 2.1

end;
function TfrmQuestion2.CapitaliseNames(sInput: string): string;
begin
  // Question 2.2
end;

function TfrmQuestion2.isValidISBN(ISBN: string): boolean;
begin
   // Question 2.3

end;
procedure TfrmQuestion2.DisplayBook(sBookName, sAuthor, ISBN: string);
begin
   // Question 2.4

end;

procedure TfrmQuestion2.btnAddBookClick(Sender: TObject);
begin
  // QUESTION 2.5

end;



end.
