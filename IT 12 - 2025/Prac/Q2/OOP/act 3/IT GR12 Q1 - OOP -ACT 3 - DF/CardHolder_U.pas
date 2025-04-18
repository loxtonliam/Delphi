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
    function toString: string;
    constructor create(sCardNumber, sCellNumber: string; iPoints: integer);
    procedure setVisits(iNum: integer);
    procedure increaseLoyaltyPoints(iNum: integer);
    procedure UpdateHealthStatus(Tot,health: double);

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

procedure TCardHolder.increaseLoyaltyPoints(iNum: integer);
var
iLoyal : integer;
begin
  iLoyal := iNum div 4;
  fLoyaltyPoints := fLoyaltyPoints + iLoyal;
end;

// Question 2.1.1

// Question 2.1.2

// Question 2.1.3

// Question 2.1.4

// Question 2.1.5

function TCardHolder.isCorrect(sAccessCode: string): boolean;
begin
  // Type code for Question 2.1.5 here
end;

procedure TCardHolder.setVisits(iNum: integer);
begin
  fNumVisits := iNum;
end;

// Question 2.1.6

// Provided code
function TCardHolder.toString: string;
begin
  result := fCardNumber + #13 + 'Contact number: ' + fCellNumber + #13 + #13 +
    'Updated number of loyalty points: ' + IntToStr(fLoyaltyPoints) + #13 +
    'Number of visits: ' + IntToStr(fNumVisits) + #13 +
    'Health evaluation status: ' + fHealthLevel;
end;

procedure TCardHolder.UpdateHealthStatus(Tot, health: double);
var
dper: double;
stat:char;
begin
 dper := health/tot*100;
 if dper<10 then
 begin
   stat:='S';
 end
 else if dper <40 then
 begin
   stat:='G';

 end
 else
 begin
   stat:='P'
 end;

 fHealthLevel:=stat;


end;

end.
