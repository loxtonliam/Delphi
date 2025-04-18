unit Example1_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vehicle_U;

type
  TForm3 = class(TForm)
    RichEdit1: TRichEdit;
    btnInt: TButton;
    btnDisplay: TButton;
    btnMP: TButton;
    btnColour: TButton;
    procedure btnIntClick(Sender: TObject);
    procedure btnDisplayClick(Sender: TObject);
    procedure btnMPClick(Sender: TObject);
    procedure btnColourClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  objVehicle: Tvehicle;
  car: Tvehicle;
  bicycle: Tvehicle;
  arrVeh: array [1 .. 2] of Tvehicle;

implementation

{$R *.dfm}

procedure TForm3.btnColourClick(Sender: TObject);
var
sColour: string;
begin
sColour := inputbox('','','');
objVehicle.setColour(sColour);
end;

procedure TForm3.btnDisplayClick(Sender: TObject);
var
  sOut: string;
begin
  // sOut := 'Make:' + #9 + objVehicle.getMake + 'Model:' + #9 + objVehicle.getModel + #13 + 'Price:' + #9 + FloatToStrF(objVehicle.getPrice,ffcurrency,8,2) + #13 + 'Wheels:' + #9 + IntToStr(objVehicle.getWheels);
  RichEdit1.lines.add(objVehicle.toString());
  RichEdit1.lines.add(bicycle.toString());
end;

procedure TForm3.btnIntClick(Sender: TObject);
var
  sMake, sModel, sColour: string;
  dPrice: double;
  iNumWheels: integer;
begin
  sMake := 'Ferrari';
  sModel := 'LaFerrari';
  sColour := 'Red';
  dPrice := 10000000;
  iNumWheels := 4;

  objVehicle := Tvehicle.create(sMake, sModel, sColour, dPrice, iNumWheels);
  bicycle := Tvehicle.create('BMX', 'model1', 'red', 10000, 2);
  showmessage('Car object created');

end;

procedure TForm3.btnMPClick(Sender: TObject);
var
  i: integer;
begin
  arrVeh[1] := objVehicle;
  arrVeh[2] := bicycle;
  RichEdit1.clear;
  for i := 1 to 2 do
  begin
    RichEdit1.lines.add('Vehicle Make: ' + arrVeh[i].getMake + #13 + 'Model: '
      + arrVeh[i].getModel);

  end;
end;

end.
