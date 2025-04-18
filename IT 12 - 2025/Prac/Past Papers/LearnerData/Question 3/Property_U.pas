// Enter your name here

unit Property_U;

interface

uses SysUtils;

type

  TProperty = class(TObject)

  private
  var
    // Provided code
    fAddress: String;
    fPrice: Real;
    fBedrooms, fBathRooms: integer;
  public
    constructor create(sAddress: String; rPrice: Real;
      iBedrooms, iBathrooms: integer);

  end;

implementation

{ TProperty }

constructor TProperty.create(sAddress: String; rPrice: Real;
  iBedrooms, iBathrooms: integer);
begin
  // Question 3.1.1

end;

end.
