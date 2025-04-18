unit Example1_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm3 = class(TForm)
    btnPopulate: TButton;
    btnDisplay: TButton;
    btnSum: TButton;
    redDisplay: TRichEdit;
    procedure btnPopulateClick(Sender: TObject);
    procedure btnDisplayClick(Sender: TObject);
    procedure btnSumClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  arrNumbers: array [1 .. 3, 1 .. 5] of integer;
  arrSumRow: array [1 .. 3] of integer;
  arrSumCol: array [1 .. 5] of integer;

implementation

{$R *.dfm}

procedure TForm3.btnDisplayClick(Sender: TObject);
var
  r, c: integer;
begin
  redDisplay.clear;
  for r := 1 to 3 do
  begin
    redDisplay.lines.add('');
    for c := 1 to 5 do
    begin
      redDisplay.SelText := inttostr(arrNumbers[r, c]) + #9;

    end; // c
  end; // r
end;

procedure TForm3.btnPopulateClick(Sender: TObject);
var
  r: integer;
  c: integer;
begin
  for r := 1 to 3 do
  begin
    for c := 1 to 5 do
    begin
      arrNumbers[r, c] := random(51);

    end; // c
  end; // r
  showmessage('populated');

end;

procedure TForm3.btnSumClick(Sender: TObject);
var
  r: integer;
  c: integer;
  i: integer;
begin
 redDisplay.clear;
  redDisplay.lines.add('');
  for r := 1 to 3 do
  begin
    for c := 1 to 5 do
    begin
      arrSumRow[r] := arrSumRow[r] + arrNumbers[r, c];
      arrSumCol[c] := arrSumCol[c] + arrNumbers[r, c];

    end;
  end;
  redDisplay.selText := #9 + #9;
  for i := 1 to 5 do
  begin
    redDisplay.SelText :='Term ' + inttostr(i) + #9;
  end;

  redDisplay.selText := 'Total';

  for r := 1 to 3 do
  begin
    redDisplay.lines.add('');
    redDisplay.SelText := 'Learner ' + inttostr(r) + #9;
    for c := 1 to 5 do
    begin
      redDisplay.SelText := inttostr(arrNumbers[r, c]) + #9;

    end;
    redDisplay.SelText := inttostr(arrSumRow[r]);
  end;

  redDisplay.lines.add('Learner Totals' + #9);
  for c := 1 to 5 do
    begin
     redDisplay.selText := IntToStr(arrSumCol[c]) + #9;
    end;
end;

end.
