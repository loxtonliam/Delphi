unit Fines_U;

interface

uses SysUtils, Math;

type
  TFine = class(TObject)
  private
    fFineID: string;
    fUserID: string;
    fAmount: double;
    fDueDate: string;
    fLicense: string;
    fType: string;
  public
    constructor create(sFineId,sUserId, sDueDate, sLicense, sType: string;
      dAmount: double);

    function getDate: string;

    procedure SetAmount(dAmnt: double);

    function toString: string;
    function getFineID: string;
    function getAmt: double;

  end;

implementation

{ TFine }

constructor TFine.create(sFineID,sUserId, sDueDate, sLicense, sType: string;
  dAmount: double);
begin
fFineID := sFineId;
  fUserID := sUserId;
  fDueDate := sDueDate;
  fLicense := sLicense;
  fType := sType;
  fAmount := dAmount;

end;

function TFine.getAmt: double;
begin
result := fAmount;
end;

function TFine.getDate: string;
begin
  result := fDueDate;
end;

function TFine.getFineID: string;
begin
result := fFineID;
end;

procedure TFine.SetAmount(dAmnt: double);
begin
  fAmount := dAmnt;
end;

function TFine.toString;
begin
  result := 'You ( License Number: ' + fLicense + ') owe: ' +
    floattostrf(fAmount, ffcurrency, 8, 2) + ' for "' + fType + '" due by '
    + fDueDate;
end;

end.
