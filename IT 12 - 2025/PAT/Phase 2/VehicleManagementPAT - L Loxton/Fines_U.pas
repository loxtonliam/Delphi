unit Fines_U;

interface

uses SysUtils, Math;

type
  TFine = class(TObject)
  private
    fUserID: string;
    fName: string;
    fAmount: double;
    fDueDate: string;
    fLicense: string;
    fType: string;
  public
    constructor create(sUserId, sDueDate, sLicense, sType, sName: string;
      dAmount: double);

    function getDate: string;

    procedure SetAmount(dAmnt: double);

    function toString: string;

  end;

implementation

{ TFine }

constructor TFine.create(sUserId, sDueDate, sLicense, sType, sName: string;
  dAmount: double);
begin
  fUserID := sUserId;
  fDueDate := sDueDate;
  fLicense := sLicense;
  fType := sType;
  fAmount := dAmount;
  fName := sName;
end;

function TFine.getDate: string;
begin
  result := fDueDate;
end;

procedure TFine.SetAmount(dAmnt: double);
begin
  fAmount := dAmnt;
end;

function TFine.toString;
begin
  result := 'You (' + fName + ', License Number: ' + fLicense + ') owe: ' +
    floattostrf(fAmount, ffcurrency, 8, 2) + ' for "' + fType + '" due by '
    + fDueDate;
end;

end.
