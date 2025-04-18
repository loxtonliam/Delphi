unit Vehicle_U;

interface

uses
  SysUtils, dialogs, Messages;

type
  Tvehicle = class(TObject)

  private
    fMake: string;
    fModel: string;
    fColour: string;
    fNumWheels: integer;
    fPrice: double;
  public
    // constructor init priv attributes
    Constructor create(sMake, sModel, sColour: string;
      dPrice: double; iNumWheels: integer);
    //Accessor
    function getMake: string;
    function getModel: string;
    function getPrice: double;
    function getWheels: integer;
    //Mutator
    procedure setPrice(dPrice:double);
    procedure setColour(sColour: string);
    //aux
    function toString: string;


  end;


implementation

{ Tvehicle }

constructor Tvehicle.create(sMake, sModel, sColour: string; dPrice: double; iNumWheels: integer);
begin
 fMake := sMake;
 fModel := sModel;
 fColour := sColour;
 fPrice := dPrice;
 fNumWheels := iNumWheels;
end;

function Tvehicle.getMake: string;
begin
result := fMake;
end;

function Tvehicle.getModel: string;
begin
 result := fModel;
end;

function Tvehicle.getPrice: double;
begin
 result := fPrice;
end;

function Tvehicle.getWheels: integer;
begin
result := fNumWheels;
end;

procedure Tvehicle.setColour(sColour: string);
begin
fColour := sColour;
end;

procedure Tvehicle.setPrice(dPrice: double);
begin
fPrice := fPrice + dPrice;
end;



function Tvehicle.toString: string;
begin
result := 'Make:' + #9 + fMake + #13 + 'Model:' + #9 + fModel + #13 + 'Colour:' + #9 + fColour + #13 + 'Price:' + #9 + FloatToStrF(fPrice,ffcurrency,8,2);
end;

end.
