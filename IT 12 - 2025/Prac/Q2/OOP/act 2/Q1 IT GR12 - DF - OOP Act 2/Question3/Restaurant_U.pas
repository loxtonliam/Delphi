// Enter your examination number here

unit Restaurant_U;

interface

uses
  SysUtils, DateUtils;

type
  TRestaurant = class(TObject)
  private
    { Private declarations }
    fName: String;
    fYearOpened: String;
    fNumEmployees: integer;

  public
    { Public declarations }
    function toString: String;
    constructor create(sName, sYearOpened: string; iNumEmployees: integer);
    function getEmployees: integer;
    procedure increaseNumEmployees(iNum: integer);
    function compileCode(sName:string): string;

  end;

implementation

{ TRestaurant }

function TRestaurant.compileCode(sName: string): string;
begin
result:= copy(fName,1,1)+copy(sName,length(sName)-1,2)+fYearOpened;
end;

constructor TRestaurant.create(sName, sYearOpened: string;
  iNumEmployees: integer);
begin
  fName := sName;
  fYearOpened := sYearOpened;
  fNumEmployees := iNumEmployees;
end;

function TRestaurant.getEmployees: integer;
begin
  result := fNumEmployees;
end;

procedure TRestaurant.increaseNumEmployees(iNum: integer);
begin
  fNumEmployees := fNumEmployees + iNum;
end;

// ======================================================================
// Provided code  -  toString
// ======================================================================
function TRestaurant.toString: String;
var
  sResult: String;
begin
  sResult := 'Restaurant name: ' + fName + #13 + 'Year opened: ' + fYearOpened +
    #13 + 'Number of employees: ' + intToStr(fNumEmployees);
  result := sResult;
end;

end.
