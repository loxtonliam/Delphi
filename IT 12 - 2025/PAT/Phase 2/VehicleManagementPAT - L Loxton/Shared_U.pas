unit Shared_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBConnection, Data.Win.ADODB, Vcl.StdCtrls, Vcl.ExtCtrls,
  MainScreenUI, LoginScreenUI, LicenseGenerationUI, FinesUI, SignUpScreenUI,
  TestsUI, RoutingUI, PaymentUI;

type
  TValidation = class(Tobject)

  private
    { private declarations }

  public

    class Function ConfirmPassword(sPassword1, sPassword2: string): boolean;
    class Function IsValidCellNo(sCellNum: string): boolean;
    // function isUniqueID(sID: String): boolean; // uncomment after you change table names in contents of the method
    class function notEmpty(sValue: string; sFieldName: String): boolean;
    class function IsValidPassword(sPassword1: string): boolean;
    class function isValidID(sID: String): boolean;
    class function isValidDate(sDay: String; iMonth: Integer;
      sYear: String): boolean;
    class function isReal(sValue: String; sFieldName: String): boolean;
    class function isValidInteger(sValue: String; sFieldName: String): boolean;
    class function isValidCode(sValue, sFieldName: String;
      iRange: Integer): boolean;
    class function isValidStringAZ(sValue: String): boolean;
    class function isValidIndex(iIndex: Integer; sFor: string): boolean;
  end;

  TDB = class(Tobject)

  public

    class function ExistingRecordCheck(tblName, sFieldName: string;
      varCheck: Variant): boolean;
    class procedure ShowHidePassword(imgName: TImage; edtName: TEdit;
      iState: Integer);
    class procedure UpdateField(field: string; input: Variant;
      Table: TADOTable);
  end;

  TMenu = class(Tobject)
  public
    class procedure MainScreen(Form: TForm);
    class procedure LicenseScreen(Form: TForm);
    class procedure TestScreen(Form: TForm);
    class procedure RoutingScreen(Form: TForm);
    class procedure FinesScreen(Form: TForm);
  end;

  TPay = class(Tobject)
  public
    class procedure PayFine(sFineID: string; dAmt: double);
  end;

var
  bAdmin: boolean;

implementation

class procedure TDB.ShowHidePassword(imgName: TImage; edtName: TEdit;
  iState: Integer);
begin

  // checking if iState is even, if it is even => show password picture is currently shown
  if iState mod 2 = 0 then
  begin
    // changing picture and pass char
    imgName.Picture.LoadFromFile('Hide 90.png');
    edtName.PasswordChar := #0;

  end
  else
  begin
    // changing picture and pass char
    imgName.Picture.LoadFromFile('Show 90 icons.png');
    edtName.PasswordChar := '*';

  end;
end;

class procedure TDB.UpdateField(field: string; input: Variant;
  Table: TADOTable);
begin

  with DataModule1 do
  begin
    Table.Edit;
    if input <> '' then
    begin
      Table[field] := input;
    end
    else
    begin
      showmessage('value cannot be null');
    end;

  end;

end;

{ TValidation }
// to check if both fields are equal
class function TValidation.ConfirmPassword(sPassword1,
  sPassword2: string): boolean;
var
  bFlag: boolean;
begin
  bFlag := true;
  if (sPassword1 <> sPassword2) then
  begin
    bFlag := False;
  end;
  result := bFlag;
end;

// to ensure all required fields have a value
class function TValidation.notEmpty(sValue, sFieldName: String): boolean;
begin
  result := true;
  if (sValue = '') then
  begin
    showmessage('Cannot leave ' + sFieldName + 'Empty');
    result := False;
  end;
end;

{ function TValidation.isUniqueID(sID: String): boolean;// replace tblPlayers with your table name and ID/primary key field
  var
  i: Integer;
  sCode: String;
  bFlag: boolean;
  begin
  bFlag := true;
  with dmLan do
  begin
  tblPlayers.First;
  while not(tblPlayers.Eof) And (bFlag = true) do
  begin
  if sID = tblPlayers['PlayerID'] then
  begin
  bFlag := False;
  end;
  tblPlayers.Next;
  end;
  result := bFlag;
  end;

  end; }

class function TValidation.isReal(sValue, sFieldName: String): boolean;
Var
  bFlag: boolean;
  rNum: real;
begin
  bFlag := False;
  try
    begin
      rNum := StrToFloat(sValue);
      bFlag := true;
    end;
  except
    showmessage('Invalid Number for ' + sFieldName + 'Error');
    bFlag := False;
  end;
  result := bFlag;

end;

class function TValidation.IsValidCellNo(sCellNum: string): boolean;
var
  c: Integer;
  bFlag: boolean;
begin
  bFlag := true;
  c := 1;
  sCellNum := StringReplace(sCellNum, ' ', '', [rfReplaceAll]);
  if (Length(sCellNum) = 10) AND (sCellNum[1] = '0') then
  begin
    while (c <= 10) and (bFlag = true) do
    begin
      if not(sCellNum[c] in ['0' .. '9']) then
      begin
        bFlag := False;
        MessageDlg('Must contain digits only', mtError, [mbOK], 0);
      end;
      inc(c);
    end;
  end
  else
  begin // length not equal to 10
    bFlag := False;
    MessageDlg('Invalid Phone  Number!  Phone Number must be 10 digits Long',
      mtError, [mbOK], 0);
  end;
  result := bFlag;
end;

class function TValidation.isValidCode(sValue, sFieldName: String;
  iRange: Integer): boolean;
var
  bFlag: boolean;
  c: Integer;
begin
  bFlag := true;
  if (Length(sValue) = iRange) then
    while (c <= 10) and (bFlag = true) do
    begin
      if not(sValue[c] in ['0' .. '9']) then
      begin
        bFlag := False;
        showmessage('Must contain digits only');
      end;
      inc(c);
    end
  else
  begin
    bFlag := False;
    showmessage('Please enter a value that has ' + IntToStr(iRange) +
      ' digits for ' + sFieldName + 'Error');
  end;
  result := bFlag;
end;

class function TValidation.isValidDate(sDay: String; iMonth: Integer;
  sYear: String): boolean;
var
  bFlag: boolean;
  mm, yy: Integer;
begin
  mm := iMonth;
  bFlag := true;
  if (mm = 4) OR (mm = 6) OR (mm = 11) then
    if (StrToInt(sDay) > 30) then
    begin
      showmessage('Only 30 days in month ' + IntToStr(mm) + 'Invalid Date');
      bFlag := False;
    end;
  if (mm = 2) then
  begin
    yy := StrToInt(sYear);
    if (yy mod 4 = 0) then
    begin
      if (StrToInt(sDay) > 29) then
        showmessage('Only 30 days in Feb ' + IntToStr(mm) + 'Invalid Date');
      bFlag := False;
    end
    else
    begin
      if not(StrToInt(sDay) = 28) then
      begin
        showmessage('Only 28 days in Feb ' + IntToStr(mm));
        bFlag := False;
      end;
    end;
  end;
  result := bFlag;

end;

class function TValidation.isValidID(sID: String): boolean;
var
  bFlag: boolean;
  i, isum2, iSum1, iSum3, iSum4, iControl, iCheck, iLength: Integer;
  sSum2, sTotalD, sSum3: String;
begin

  if Length(sID) = 13 then
  begin
    i := 1;
    bFlag := true;
    while (i <= 13) and (bFlag = true) do
    begin
      if NOT(sID[i] in ['0' .. '9']) then
      begin
        MessageDlg('Invalid ID Number!  ID Number must contain digits only ',
          mtError, [mbOK], 0);
        bFlag := False;
      end;
      inc(i);
    end;
    if bFlag = true then
    begin
      iSum1 := 0;
      sSum2 := '';
      for i := 1 to 12 do
      begin
        if (i mod 2 = 1) then
        begin
          iSum1 := iSum1 + StrToInt(sID[i]); // sum1  adding numbers

        end
        else
        begin
          sSum2 := sSum2 + sID[i]; // sum2 join string
        end;
      end;

      isum2 := StrToInt(sSum2) * 2;
      // showMessage('Total B ' + intToStr(iSum2));
      iSum3 := 0;
      sTotalD := IntToStr(isum2);
      for i := 1 to Length((sTotalD)) do
      begin
        iSum3 := iSum3 + StrToInt(sTotalD[i]);
      end;

      // showMessage('Total d' + (intToStr(iSum3)));
      iSum4 := iSum3 + iSum1;
      iControl := 10 - (iSum4 mod 10);
      // showMessage('Control ' + (intToStr(iControl)));
      iLength := Length(sID);
      iCheck := StrToInt(sID[Length(sID)]);
      if (iControl > 9) Then
        iControl := 0;
      if iControl = iCheck then
      begin
        bFlag := true;
        // showMessage('Correct')
      end

      else
      begin
        bFlag := False;
        // showMessage('In Correct')
      end;
    end
  end
  else // length is not 13
  begin
    bFlag := False;
    MessageDlg('Invalid ID Number!  ID Number must be 13 digits Long', mtError,
      [mbOK], 0);
  end;
  result := bFlag;
end;

class function TValidation.isValidIndex(iIndex: Integer; sFor: string): boolean;
begin
  if iIndex > -1 then
  begin
    result := true;
  end
  else
  begin
    showmessage('Please select a value for: "' + sFor + '"');
    result := False;
  end;
end;

class function TValidation.isValidInteger(sValue, sFieldName: String): boolean;
Var
  bFlag: boolean;
  rNum: real;
begin
  bFlag := False;
  try
    begin
      rNum := StrToInt(sValue);
      bFlag := true;
    end;
  except
    showmessage('Invalid Number for ' + sFieldName + 'Error');
    bFlag := False;
  end;
  result := bFlag;

end;

class function TValidation.isValidStringAZ(sValue: String): boolean;
Var
  bFlag: boolean;
  i, iLength: Integer;
begin
  if Length(sValue) <> 0 then
  begin
    i := 1;
    bFlag := true;
    while (i <= Length(sValue)) AND (bFlag = true) do
    begin
      if not(upcase(sValue[i]) in ['A' .. 'Z', ' ']) then
      begin
        bFlag := False;
      end;
      inc(i);
    end;
  end
  else
  begin
    bFlag := False;
  end;

  result := bFlag;
end;

class function TValidation.IsValidPassword(sPassword1: string): boolean;
var
  a, counter: Integer;
  bFlag: boolean;
begin
  counter := 1;
  bFlag := true;
  a := 0;
  if (Length(sPassword1) >= 6) then
  begin
    for counter := 1 to Length(sPassword1) do
    begin
      if upcase(sPassword1[counter]) in ['0' .. '9', 'A' .. 'Z', '!', '-', '_',
        '*', '&', '^', '=', '+', '#', '@'] then
      begin
        a := a + 1;
      end;

    end;
    if (a = 0) then
    begin
      bFlag := False;
      showmessage
        ('Password is not Strong!!! Must contain letters characters and numbers');
    end;
  end
  else
  begin
    bFlag := False;
    showmessage('Password needs to be 6 or more  characters long' + #13 +
      'Please try again');
  end;
  result := bFlag;
end;

{ TDB }

class function TDB.ExistingRecordCheck(tblName, sFieldName: string;
  varCheck: Variant): boolean;
var
  bFlag: boolean;
begin
  bFlag := true;
  with DataModule1 do
  begin
    try
      ADoQuery1.close;
      ADoQuery1.sql.text := 'SELECT * FROM ' + tblName + ' WHERE ' + sFieldName
        + ' = "' + varCheck + '"';
      ADoQuery1.open;
    except
      on E: Exception do
        showmessage('Database Error: ' + E.message);
    end;

    if ADoQuery1.RecordCount > 0 then
    begin
      showmessage(sFieldName + ' Taken');
      bFlag := False;
    end; // if
  end; // dm
  result := bFlag;
end; // function

{ TMenu }

class procedure TMenu.FinesScreen(Form: TForm);
begin
  Form.hide;
  frmFines.show;
end;

class procedure TMenu.LicenseScreen(Form: TForm);
begin
  Form.hide;
  frmLicenseGen.show;
end;

class procedure TMenu.MainScreen(Form: TForm);
begin
  Form.hide;
  frmMain.show;
end;

class procedure TMenu.RoutingScreen(Form: TForm);
begin
  Form.hide;
  frmRouting.show;
end;

class procedure TMenu.TestScreen(Form: TForm);
begin
  Form.hide;
  frmTests.show;
end;

{ TPay }

class procedure TPay.PayFine(sFineID: string; dAmt: double);
begin
  frmPayment.redPayDisplay.clear;
  if TValidation.notEmpty(sFineID, 'FineID') then
  begin
    frmPayment.sFineID := sFineID;
  end
  else
  begin
    exit;
  end;
  if dAmt > 0 then
  begin
    frmPayment.dFineAmt := dAmt;
  end;

  frmFines.hide;
  frmPayment.show;

end;

end.
