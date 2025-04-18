unit Question4_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    redQ4: TRichEdit;
    GroupBox1: TGroupBox;
    btnQ4_2: TButton;
    btnQ4_3: TButton;
    btnQ4_4: TButton;
    procedure btnQ4_2Click(Sender: TObject);
    procedure display;
    procedure btnQ4_3Click(Sender: TObject);
    procedure btnQ4_4Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  arrEmployees: array [1 .. 30] of string;
  arrPasswords: array [1 .. 30] of string;
  arrPWStrength: array [1 .. 30] of integer;

  arrTempEmployees: array [1 .. 30] of String = (
    'Williams Wade',
    'Harris Dave',
    'Thomas Seth',
    'Robinson Ivan',
    'Walker Riley',
    'Scott Gilbert',
    'Nelson Jorge',
    'Mitchell Dan',
    'Morgan Brian',
    'Cooper Roberto',
    'Howard Ramon',
    'Davis Miles',
    'Miller Liam',
    'Martin Nathaniel',
    'Smith Ethan',
    'Anderson Daisy',
    'White Deborah',
    'Perry Isabel',
    'Clark Stella',
    'Richards Debra',
    'Wheeler Beverly',
    'Potter Vera',
    'Stanley Angela',
    'Holland Lucy',
    'Terry Lauren',
    'Shelton Janet',
    'Miles Loretta',
    'Lucas Tracey',
    'Fletcher Beatrice',
    'Parks Sabrina'
  );
  arrTempPasswords: array [1 .. 30] of String = (

    '1155rs',
    '1311x@',
    '1750pqrst^%',
    '994pq',
    '1542opq(',
    '1611z',
    '1839nopqr#$',
    '200jkl@!&',
    '1557rs@!&',
    '1366abc',
    '1626uvwxy&*',
    '1464pqrs%(',
    '576u&*',
    '1885z^%(',
    '1002klm)',
    '891klmn%',
    '1649z^',
    '1869lmnop@!',
    '1648z*',
    '241gh^%(',
    '1211ef',
    '889mnop!&*',
    '454vw&*',
    '1582jklmn',
    '1019uvwx%',
    '1419jklmn%(',
    '958j%()',
    '1901m$@!',
    '546s',
    '500vwx$'
  );
  fDatafile: textfile;


    implementation

{$R *.dfm}
    procedure TForm1.display;

var
  sLine: string;
  iPos: integer;
  i: integer;
begin

  // provided code
  redQ4.Clear;
  redQ4.Paragraph.TabCount := 2;
  redQ4.Paragraph.Tab[0] := 130;
  redQ4.Paragraph.Tab[1] := 240;

  // Question 4.1
  redQ4.lines.add('Employee' + #9 + 'Password' + #9 + #9 + 'Password Strength');
  for i := 1 to 30 do
  begin
    redQ4.lines.add(arrEmployees[i] + #9 + arrPasswords[i] + #9 + #9 +
      IntToStr(arrPWStrength[i]));
  end;

end;

procedure TForm1.btnQ4_2Click(Sender: TObject);

var
  sLine: string;
  iPos, icount: integer;
begin
  // Question 4.2
  if Fileexists('Data.txt') then
  begin
    AssignFile(fDatafile, 'Data.txt');
    Reset(fDatafile);
    icount := 0;
    while not eof(fDatafile) do
    begin
      inc(icount);
      Readln(fDatafile, sLine);
      iPos := pos(';', sLine);
      arrEmployees[icount] := copy(sLine, 1, iPos - 1);
      delete(sLine, 1, iPos);

      arrPasswords[icount] := sLine;

      delete(sLine, 1, length(sLine));

    end;

    display;

  end
  else
  begin
    showmessage('file not found');
    exit;
  end;

end;

procedure TForm1.btnQ4_3Click(Sender: TObject);

var
  i, strength: integer;
  pass: string;
  j: integer;
begin
  // Question 4.3
  for i := 1 to 30 do
  begin
    strength := 0;
    pass := arrPasswords[i];
    if length(pass) >= 8 then
    begin
      inc(strength, 5);
    end;
    for j := 1 to length(pass) do
    begin
      case pass[j] of
        '!', '@', '#', '$', '%', '^', '&', '(', ')':
          inc(strength, 2);
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
          inc(strength);
      end;
    end;

    arrPWStrength[i] := strength;
  end;
  display;

end;

procedure TForm1.btnQ4_4Click(Sender: TObject);
var
  i: Integer;
  sStrong, sMedium, sWeak : string;
begin
  // Provided code
  redQ4.Clear;
  sStrong := '';
  sMedium := '';
  sWeak := '';
  for i := 1 to 30 do
  begin
    if arrPWStrength[i] <5 then
    begin
      sWeak := sWeak + arrEmployees[i] + #13
    end
    else if (arrPwStrength[i] >5) AND (arrPwStrength[i]<10) then
    begin
      sMedium := sMedium + arrEmployees[i] + #13
    end
    else
    begin
      sStrong := sStrong + arrEmployees[i] + #13
    end;

  end;


  redQ4.lines.add('Very low security' + #13 + sWeak + #13 + 'Medium Security' + #13 + sMedium + #13 + 'Very secure passwords' + #13 + sStrong);



  // Question 4.4
end;

end.
