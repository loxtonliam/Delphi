unit ComputerUI_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls, ComCtrls, clsComputer;

type
  TForm1 = class(TForm)
    pnlInput: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtDescrip: TEdit;
    cmbSpeed: TComboBox;
    sedRAM: TSpinEdit;
    sedStorage: TSpinEdit;
    btnExtract: TButton;
    redOutput: TRichEdit;
    btnIncrease: TButton;
    btnSystem: TButton;
    btnDisplay: TButton;
    btnExit: TButton;
    procedure btnExitClick(Sender: TObject);
    procedure btnExtractClick(Sender: TObject);
    procedure btnIncreaseClick(Sender: TObject);
    procedure btnSystemClick(Sender: TObject);
    procedure btnDisplayClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  objComputer : TComputer; {Global Object Declared}

implementation

{$R *.dfm}


procedure TForm1.btnExtractClick(Sender: TObject);
var
sDescrip:string;
dSpeed:double;
iRAM,iStorage:integer;
begin
   {2.1}
  sDescrip:=edtDescrip.text;
  dSpeed:=StrToFloat(cmbspeed.items[cmbspeed.itemindex]);
  iRam := sedRAM.value;
  iStorage := sedStorage.value;

  objComputer := TComputer.create(sDescrip,dSpeed,iRam,iStorage);


end;


procedure TForm1.btnIncreaseClick(Sender: TObject);
var
iRam:integer;
begin
   {2.2}
   iRam:=StrToInt(inputbox('enter ram','',''));
   objComputer.setRAM(iRam);


end;


procedure TForm1.btnSystemClick(Sender: TObject);
begin
   {2.3}

end;


procedure TForm1.btnDisplayClick(Sender: TObject);
begin
  {2.4}

end;



procedure TForm1.btnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
