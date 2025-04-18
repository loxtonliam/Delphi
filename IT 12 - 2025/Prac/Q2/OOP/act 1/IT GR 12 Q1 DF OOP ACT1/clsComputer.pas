unit clsComputer;

interface

type
  TComputer = class(TObject)

  private
    { 1.1 }
    fDescrip: string;
    fSpeed: double;
    fRAM: integer;
    fStorage: integer;
    fPRO: boolean;

  public

    { 1.2 }
    constructor create(sDescrip: string; dSpeed: double;
      iRam, iStorage: integer);

    { 1.3 }
    procedure setRAM(iRam: integer);

    { 1.4 }
    procedure checkPRO;

    { 1.5 }
    function proStatus: string;

    { 1.6 }
    function toString: string;

  end;

implementation

uses SysUtils, Dialogs;

{ 1.2 }

{ 1.3 }

{ 1.4 }

{ 1.5 }

{ 1.6 }

{ TComputer }

procedure TComputer.checkPRO;
begin
  if (fRAM >= 8) AND (fStorage >= 1024) then
  begin
    fPRO := True;

  end
  else
  begin
    fPRO := false;
  end;

  showmessage('Pro status updated');

end;

constructor TComputer.create(sDescrip: string; dSpeed: double;
  iRam, iStorage: integer);
begin
 fDescrip := sDescrip;
 fSpeed :=dSpeed;
 fRAM:=iRam;
 fStorage:=iStorage;
end;

function TComputer.proStatus: string;
begin
  result := 'Mid-Level';
  if fPRO = True then
  begin
    result := 'High-end'
  end;
end;

procedure TComputer.setRAM(iRam: integer);
begin
  fRAM := iRam;
end;

function TComputer.toString: string;
begin
result := 'Description:' + #9 + fDescrip + #13 + 'Speed:'+#9 + FloatToStrF(fSpeed,ffnumber,8,2) + #13+ 'RAM:'+ #9 + IntToStr(fram) + #13 + 'Storage:' + #9 + IntToStr(fStorage) + #13 + 'Range:' + #9 + proStatus;
end;

end.
