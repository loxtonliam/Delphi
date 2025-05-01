unit Fines_U;

interface
uses SysUtils,Math;

type
TFine = class(TObject)
private
  fUserID : string;
  fAmount : double;
  fDueDate : string;
  fLicense : string;
  fType : string;
public
constructor create(sUserId,sDueDate,sLicense,sType : string; dAmount: double);


end;


implementation

{ TFine }

constructor TFine.create(sUserId, sDueDate, sLicense, sType: string;
  dAmount: double);
begin
 fUserID := sUserId;
 fDueDate := sDueDate;
 fLicense := sLicense;
 fType := sType;
 fAmount := dAmount;
end;

end.
