// TYPE YOUR NAME AND SURNAME HERE
unit frmHealthyLiving_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmHealthyLiving = class(TForm)
    pnlHeader: TPanel;
    pnlDisplay: TPanel;
    pnlCntrl: TPanel;
    redOut: TRichEdit;
    btnRead: TButton;
    btnProcess: TButton;
    btnSummary: TButton;
    Label2: TLabel;
    Label1: TLabel;
    Image1: TImage;
    procedure btnReadClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure btnSummaryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHealthyLiving: TfrmHealthyLiving;
  arrClients: array [1 .. 50] of String;
  arrDuration: array [1 .. 50] of integer;
  arrTotalCalories: array [1 .. 50] of double;

  { BACKUP ARRAYS

    arrClientsBack: array [1 .. 50] of String;
    arrDurationBack: array [1 .. 50] of integer;
    arrTotalCaloriesBack: array [1 .. 50] of double;
  }

implementation

{$R *.dfm}

// =============================================================================
// Question 4.1 (15 marks)
// =============================================================================
procedure TfrmHealthyLiving.btnReadClick(Sender: TObject);
begin

  // QUESTION 4.1 //

end;

// =============================================================================
// Question 4.2 (6 marks)
// =============================================================================
procedure TfrmHealthyLiving.btnSortClick(Sender: TObject);
begin

  // QUESTION 4.2 //

end;

// =============================================================================
// Question 4.3 (9 marks)
// =============================================================================
procedure TfrmHealthyLiving.btnSummaryClick(Sender: TObject);
begin

  // QUESTION 4.3 //

end;

procedure TfrmHealthyLiving.FormCreate(Sender: TObject);
begin
  // PROVIDED CODE - DO NOT MODIFY! //
  redOut.Paragraph.TabCount := 5;
  redOut.Paragraph.Tab[0] := 100;
  redOut.Paragraph.Tab[1] := 180;
  redOut.Paragraph.Tab[2] := 240;
  redOut.Paragraph.Tab[3] := 290;
  redOut.Paragraph.Tab[4] := 310;

  { BACKUP ARRAYS

    arrClientsBack[1] := 'Chris Evans';
    arrClientsBack[2] := 'Robert Downey Jr.';
    arrClientsBack[3] := 'Brie Larson';
    arrClientsBack[4] := 'Chris Hemsworth';
    arrClientsBack[5] := 'Scarlett Johansson';
    arrClientsBack[6] := 'Chris Evans';
    arrClientsBack[7] := 'Robert Downey Jr.';
    arrClientsBack[8] := 'Brie Larson';
    arrClientsBack[9] := 'Scarlett Johansson';
    arrClientsBack[10] := 'Tom Holland';
    arrClientsBack[11] := 'Chris Hemsworth';
    arrClientsBack[12] := 'Tom Holland';
    arrClientsBack[13] := 'Chris Hemsworth';
    arrClientsBack[14] := 'Tom Holland';
    arrClientsBack[15] := 'Scarlett Johansson';
    arrClientsBack[16] := 'Brie Larson';
    arrClientsBack[17] := 'Robert Downey Jr.';
    arrClientsBack[18] := 'Chris Evans';
    arrClientsBack[19] := 'Robert Downey Jr.';
    arrClientsBack[20] := 'Brie Larson';
    arrClientsBack[21] := 'Chris Hemsworth';
    arrClientsBack[22] := 'Scarlett Johansson';
    arrClientsBack[23] := 'Chris Evans';
    arrClientsBack[24] := 'Robert Downey Jr.';
    arrClientsBack[25] := 'Brie Larson';
    arrClientsBack[26] := 'Scarlett Johansson';
    arrClientsBack[27] := 'Tom Holland';
    arrClientsBack[28] := 'Chris Hemsworth';
    arrClientsBack[29] := 'Chris Evans';
    arrClientsBack[30] := 'Tom Holland';
    arrClientsBack[31] := 'Scarlett Johansson';
    arrClientsBack[32] := 'Brie Larson';
    arrClientsBack[33] := 'Robert Downey Jr.';
    arrClientsBack[34] := 'Chris Hemsworth';
    arrClientsBack[35] := 'Tom Holland';
    arrClientsBack[36] := 'Scarlett Johansson';
    arrClientsBack[37] := 'Brie Larson';
    arrClientsBack[38] := 'Robert Downey Jr.';
    arrClientsBack[39] := 'Chris Evans';
    arrClientsBack[40] := 'Robert Downey Jr.';
    arrClientsBack[41] := 'Brie Larson';
    arrClientsBack[42] := 'Chris Hemsworth';
    arrClientsBack[43] := 'Scarlett Johansson';
    arrClientsBack[44] := 'Chris Evans';
    arrClientsBack[45] := 'Robert Downey Jr.';
    arrClientsBack[46] := 'Brie Larson';
    arrClientsBack[47] := 'Scarlett Johansson';
    arrClientsBack[48] := 'Tom Holland';

    arrDurationBack[1] := 30;
    arrDurationBack[2] := 45;
    arrDurationBack[3] := 25;
    arrDurationBack[4] := 20;
    arrDurationBack[5] := 30;
    arrDurationBack[6] := 35;
    arrDurationBack[7] := 25;
    arrDurationBack[8] := 40;
    arrDurationBack[9] := 60;
    arrDurationBack[10] := 35;
    arrDurationBack[11] := 50;
    arrDurationBack[12] := 55;
    arrDurationBack[13] := 30;
    arrDurationBack[14] := 20;
    arrDurationBack[15] := 45;
    arrDurationBack[16] := 60;
    arrDurationBack[17] := 30;
    arrDurationBack[18] := 30;
    arrDurationBack[19] := 45;
    arrDurationBack[20] := 25;
    arrDurationBack[21] := 20;
    arrDurationBack[22] := 30;
    arrDurationBack[23] := 35;
    arrDurationBack[24] := 25;
    arrDurationBack[25] := 40;
    arrDurationBack[26] := 60;
    arrDurationBack[27] := 35;
    arrDurationBack[28] := 50;
    arrDurationBack[29] := 25;
    arrDurationBack[30] := 20;
    arrDurationBack[31] := 45;
    arrDurationBack[32] := 60;
    arrDurationBack[33] := 30;
    arrDurationBack[34] := 30;
    arrDurationBack[35] := 55;
    arrDurationBack[36] := 60;
    arrDurationBack[37] := 40;
    arrDurationBack[38] := 25;
    arrDurationBack[39] := 30;
    arrDurationBack[40] := 45;
    arrDurationBack[41] := 25;
    arrDurationBack[42] := 20;
    arrDurationBack[43] := 30;
    arrDurationBack[44] := 35;
    arrDurationBack[45] := 25;
    arrDurationBack[46] := 40;
    arrDurationBack[47] := 60;
    arrDurationBack[48] := 35;

    arrTotalCaloriesBack[1] := 210;
    arrTotalCaloriesBack[2] := 360;
    arrTotalCaloriesBack[3] := 175;
    arrTotalCaloriesBack[4] := 160;
    arrTotalCaloriesBack[5] := 300;
    arrTotalCaloriesBack[6] := 210;
    arrTotalCaloriesBack[7] := 125;
    arrTotalCaloriesBack[8] := 320;
    arrTotalCaloriesBack[9] := 420;
    arrTotalCaloriesBack[10] := 350;
    arrTotalCaloriesBack[11] := 250;
    arrTotalCaloriesBack[12] := 330;
    arrTotalCaloriesBack[13] := 300;
    arrTotalCaloriesBack[14] := 160;
    arrTotalCaloriesBack[15] := 225;
    arrTotalCaloriesBack[16] := 360;
    arrTotalCaloriesBack[17] := 210;
    arrTotalCaloriesBack[18] := 210;
    arrTotalCaloriesBack[19] := 360;
    arrTotalCaloriesBack[20] := 175;
    arrTotalCaloriesBack[21] := 160;
    arrTotalCaloriesBack[22] := 300;
    arrTotalCaloriesBack[23] := 210;
    arrTotalCaloriesBack[24] := 125;
    arrTotalCaloriesBack[25] := 320;
    arrTotalCaloriesBack[26] := 420;
    arrTotalCaloriesBack[27] := 350;
    arrTotalCaloriesBack[28] := 250;
    arrTotalCaloriesBack[29] := 250;
    arrTotalCaloriesBack[30] := 160;
    arrTotalCaloriesBack[31] := 225;
    arrTotalCaloriesBack[32] := 360;
    arrTotalCaloriesBack[33] := 210;
    arrTotalCaloriesBack[34] := 300;
    arrTotalCaloriesBack[35] := 330;
    arrTotalCaloriesBack[36] := 420;
    arrTotalCaloriesBack[37] := 320;
    arrTotalCaloriesBack[38] := 125;
    arrTotalCaloriesBack[39] := 210;
    arrTotalCaloriesBack[40] := 360;
    arrTotalCaloriesBack[41] := 175;
    arrTotalCaloriesBack[42] := 160;
    arrTotalCaloriesBack[43] := 300;
    arrTotalCaloriesBack[44] := 210;
    arrTotalCaloriesBack[45] := 125;
    arrTotalCaloriesBack[46] := 320;
    arrTotalCaloriesBack[47] := 420;
    arrTotalCaloriesBack[48] := 350;
  }

  // END OF PROVIDED CODE //

end;

end.
