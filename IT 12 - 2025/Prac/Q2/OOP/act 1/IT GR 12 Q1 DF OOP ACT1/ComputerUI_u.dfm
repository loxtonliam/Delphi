object Form1: TForm1
  Left = 0
  Top = 0
  Margins.Left = 6
  Margins.Top = 6
  Margins.Right = 6
  Margins.Bottom = 6
  Caption = 'Andromeda Computers'
  ClientHeight = 604
  ClientWidth = 1316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Tahoma'
  Font.Style = []
  PixelsPerInch = 180
  TextHeight = 25
  object pnlInput: TPanel
    Left = 45
    Top = 29
    Width = 572
    Height = 482
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    BorderStyle = bsSingle
    TabOrder = 0
    object Label1: TLabel
      Left = 45
      Top = 60
      Width = 111
      Height = 25
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Description:'
    end
    object Label2: TLabel
      Left = 45
      Top = 135
      Width = 171
      Height = 25
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'CPU Speed (GHz):'
    end
    object Label3: TLabel
      Left = 45
      Top = 210
      Width = 131
      Height = 25
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Memory (GB):'
    end
    object Label4: TLabel
      Left = 45
      Top = 281
      Width = 129
      Height = 25
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Storage (GB):'
    end
    object edtDescrip: TEdit
      Left = 225
      Top = 54
      Width = 317
      Height = 33
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 0
    end
    object cmbSpeed: TComboBox
      Left = 225
      Top = 129
      Width = 272
      Height = 33
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ItemIndex = 0
      TabOrder = 1
      Text = '1.0'
      Items.Strings = (
        '1.0'
        '1.4'
        '1.8'
        '2.0'
        '2.4'
        '2.8'
        '3.0'
        '3.2')
    end
    object sedRAM: TSpinEdit
      Left = 225
      Top = 204
      Width = 182
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      MaxValue = 16
      MinValue = 1
      TabOrder = 2
      Value = 1
    end
    object sedStorage: TSpinEdit
      Left = 225
      Top = 276
      Width = 182
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      MaxValue = 2048
      MinValue = 320
      TabOrder = 3
      Value = 320
    end
    object btnExtract: TButton
      Left = 45
      Top = 375
      Width = 141
      Height = 47
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Extract'
      TabOrder = 4
      OnClick = btnExtractClick
    end
  end
  object redOutput: TRichEdit
    Left = 660
    Top = 30
    Width = 626
    Height = 482
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object btnIncrease: TButton
    Left = 45
    Top = 523
    Width = 141
    Height = 47
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Increase RAM'
    TabOrder = 2
    OnClick = btnIncreaseClick
  end
  object btnSystem: TButton
    Left = 255
    Top = 523
    Width = 141
    Height = 47
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'System Type'
    TabOrder = 3
    OnClick = btnSystemClick
  end
  object btnDisplay: TButton
    Left = 476
    Top = 523
    Width = 141
    Height = 47
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Display All'
    TabOrder = 4
    OnClick = btnDisplayClick
  end
  object btnExit: TButton
    Left = 1146
    Top = 523
    Width = 140
    Height = 47
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Close App'
    TabOrder = 5
    OnClick = btnExitClick
  end
end
