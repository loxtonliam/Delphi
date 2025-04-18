object frmQ3: TfrmQ3
  Left = 0
  Top = 0
  Margins.Left = 6
  Margins.Top = 6
  Margins.Right = 6
  Margins.Bottom = 6
  Caption = 'Question 3'
  ClientHeight = 686
  ClientWidth = 1476
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -30
  Font.Name = 'Arial Narrow'
  Font.Style = []
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 180
  TextHeight = 35
  object GroupBox1: TGroupBox
    Left = 15
    Top = 2
    Width = 722
    Height = 677
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Restaurant details'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -28
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 30
      Top = 45
      Width = 237
      Height = 32
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Name of restaurant'
    end
    object Label3: TLabel
      Left = 30
      Top = 199
      Width = 271
      Height = 32
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Number of employees'
    end
    object Label2: TLabel
      Left = 30
      Top = 124
      Width = 155
      Height = 32
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Year opened'
    end
    object edtCompanyName: TEdit
      Left = 315
      Top = 39
      Width = 392
      Height = 40
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 0
      Text = 'Simply Fabulous Food'
    end
    object btnQ3_2_1: TButton
      Left = 101
      Top = 264
      Width = 567
      Height = 77
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '3.2.1 - Instantiate and display object '
      TabOrder = 1
      OnClick = btnQ3_2_1Click
    end
    object edtYearOpened: TEdit
      Left = 315
      Top = 114
      Width = 392
      Height = 40
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 2
      Text = '2018'
    end
    object spnNumEmployees: TSpinEdit
      Left = 315
      Top = 180
      Width = 107
      Height = 43
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      MaxValue = 9999
      MinValue = 0
      TabOrder = 3
      Value = 25
    end
    object redQ3: TRichEdit
      Left = 101
      Top = 347
      Width = 567
      Height = 298
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Lines.Strings = (
        '')
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 748
    Top = 2
    Width = 716
    Height = 317
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Compile identification code'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -28
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label5: TLabel
      Left = 45
      Top = 75
      Width = 235
      Height = 32
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Full name of owner'
    end
    object btnQ3_2_2: TButton
      Left = 56
      Top = 128
      Width = 567
      Height = 76
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '3.2.2 - Identification code'
      TabOrder = 0
      OnClick = btnQ3_2_2Click
    end
    object edtOwnerName: TEdit
      Left = 289
      Top = 69
      Width = 403
      Height = 40
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
    end
    object edtIDCode: TEdit
      Left = 56
      Top = 231
      Width = 567
      Height = 40
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 2
    end
  end
  object GroupBox4: TGroupBox
    Left = 748
    Top = 330
    Width = 716
    Height = 349
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Add employees'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -28
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label6: TLabel
      Left = 28
      Top = 60
      Width = 357
      Height = 32
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Number of employees to add'
    end
    object Label7: TLabel
      Left = 30
      Top = 253
      Width = 381
      Height = 32
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Updated number of employees'
    end
    object edtAdd: TEdit
      Left = 433
      Top = 60
      Width = 259
      Height = 40
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 0
    end
    object btnQ3_2_3: TButton
      Left = 60
      Top = 135
      Width = 557
      Height = 77
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '3.2.3 -  Add employees    '
      TabOrder = 1
      OnClick = btnQ3_2_3Click
    end
    object edtUpdated: TEdit
      Left = 435
      Top = 251
      Width = 257
      Height = 40
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 2
    end
  end
end
