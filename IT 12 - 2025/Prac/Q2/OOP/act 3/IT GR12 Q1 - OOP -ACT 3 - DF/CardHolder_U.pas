// Enter your examination number here

unit CardHolder_U;

interface

uses SysUtils, Math;

type
  TCardHolder = class(TObject)
  private
    fCardNumber: string;
    fCellNumber: string;
    fNumVisits: integer;
    fLoyaltyPoints: integer;
    fHealthLevel: char;

  public
    function isCorrect(sAccessCode: string): boolean;
    function toString(obj:TCardHolder): string;
    constructor create(sCardNumber, sCellNumber: string; iPoints: integer);
    procedure setVisits(iNum: integer);
    procedure increaseLoyaltyPoints(dNum: double);
    procedure UpdateHealthStatus(Tot, health: double);
    function identifyStarShopper: string;

  end;

implementation

{ TCardHolder }

constructor TCardHolder.create(sCardNumber, sCellNumber: string;
  iPoints: integer);
begin
  fCardNumber := sCardNumber;
  fCellNumber := sCellNumber;
  fLoyaltyPoints := iPoints;
  fHealthLevel := 'S';
  fNumVisits := 0;
end;

function TCardHolder.identifyStarShopper: string;
begin
result := '';
 if (fLoyaltyPoints>2000) AND (fNumVisits>10) OR (fHealthLevel = 'P') then
 begin
   result := 'STAR shopper';
 end;

end;

procedure TCardHolder.increaseLoyaltyPoints(dNum: double);
var
  iLoyal: integer;
begin
  iLoyal := Floor(dNum/4);
  fLoyaltyPoints := fLoyaltyPoints + iLoyal;

end;

// Question 2.1.1

// Question 2.1.2

// Question 2.1.3

// Question 2.1.4

// Question 2.1.5

function TCardHolder.isCorrect(sAccessCode: string): boolean;
var
  sNumber: string;
  iPos, iSum: integer;
  i: integer;
begin
  // Type code for Question 2.1.5 here
  result := False;
  iSum := 0;
  sNumber := fCellNumber;

  iPos := Pos('0', sNumber);

  while iPos <> 0 do
  begin
    delete(sNumber, iPos, 1);
    iPos := Pos('0', sNumber);
  end;
  if length(sNumber) mod 2 = 0 then
  begin
    i := 0;
    while i < length(sNumber) do
    begin
      inc(i, 2);
      iSum := iSum + StrToInt(sNumber[i - 1] + sNumber[i]);
    end;

  end
  else
  begin
    iSum := StrToInt(sNumber[1]);
    i := 1;
    while i < length(sNumber) do
    begin
      inc(i, 2);
      iSum := iSum + StrToInt(sNumber[i - 1] + sNumber[i]);
    end;

  end; // odd
  if StrToInt(sAccessCode) = iSum then
  begin
    result:=True;
  end;

end;

procedure TCardHolder.setVisits(iNum: integer);
begin
  fNumVisits := iNum;
end;

// Question 2.1.6

// Provided code
function TCardHolder.toString(obj:TCardHolder): string;
begin
  result := fCardNumber + #13 + 'Contact number: ' + fCellNumber + #13 + #13 +
    'Updated number of loyalty points: ' + IntToStr(fLoyaltyPoints) + #13 +
    'Number of visits: ' + IntToStr(fNumVisits) + #13 +
    'Health evaluation status: ' + fHealthLevel +#13 + obj.identifyStarShopper ;
end;

procedure TCardHolder.UpdateHealthStatus(Tot, health: double);
var
  dper: double;
  stat: char;
begin
  dper := health / Tot * 100;
  if dper < 10 then
  begin
    stat := 'S';
  end
  else if dper < 40 then
  begin
    stat := 'G';

  end
  else
  begin
    stat := 'P'
  end;

  fHealthLevel := stat;

end;

end.
