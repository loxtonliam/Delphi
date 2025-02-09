object frmQuestion1: TfrmQuestion1
  Left = 0
  Top = 0
  Margins.Left = 2
  Margins.Top = 2
  Margins.Right = 2
  Margins.Bottom = 2
  Caption = 'Question 1'
  ClientHeight = 428
  ClientWidth = 607
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object imgShoe: TImage
    Left = 496
    Top = 7
    Width = 105
    Height = 105
  end
  object pnlHeading: TPanel
    Left = 11
    Top = 8
    Width = 478
    Height = 105
    Caption = 'pnlHeading'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 11
    Top = 120
    Width = 350
    Height = 137
    Caption = 'Question 1.2'
    TabOrder = 1
    object lblType: TLabel
      Left = 231
      Top = 32
      Width = 37
      Height = 15
      Caption = 'lblType'
    end
    object lblPopularity: TLabel
      Left = 159
      Top = 69
      Width = 67
      Height = 15
      Caption = 'lblPopularity'
    end
    object Label1: TLabel
      Left = 12
      Top = 16
      Width = 55
      Height = 15
      Caption = 'Shoe type:'
    end
    object Label2: TLabel
      Left = 12
      Top = 52
      Width = 51
      Height = 15
      Caption = 'Shoe size:'
    end
    object Label5: TLabel
      Left = 159
      Top = 32
      Width = 55
      Height = 15
      Caption = 'Shoe type:'
    end
    object btnTypeSize: TButton
      Left = 17
      Top = 99
      Width = 323
      Height = 25
      Caption = 'Get type and size'
      TabOrder = 0
      OnClick = btnTypeSizeClick
    end
    object cbxType: TComboBox
      Left = 12
      Top = 30
      Width = 105
      Height = 23
      TabOrder = 1
      Items.Strings = (
        'High heel'
        'Sneaker'
        'Boot'
        'Croc')
    end
    object spnSize: TSpinEdit
      Left = 16
      Top = 69
      Width = 101
      Height = 24
      MaxValue = 15
      MinValue = 0
      TabOrder = 2
      Value = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 367
    Top = 118
    Width = 234
    Height = 139
    Caption = 'Question 1.3'
    TabOrder = 2
    object lblCost: TLabel
      Left = 104
      Top = 69
      Width = 37
      Height = 15
      Caption = 'lblCost'
    end
    object Label3: TLabel
      Left = 10
      Top = 69
      Width = 75
      Height = 15
      Caption = 'Cost with VAT:'
    end
    object Label4: TLabel
      Left = 10
      Top = 37
      Width = 56
      Height = 15
      Caption = 'Cost price:'
    end
    object edtCost: TEdit
      Left = 104
      Top = 26
      Width = 121
      Height = 23
      TabOrder = 0
    end
    object btnCalcCost: TButton
      Left = 10
      Top = 101
      Width = 215
      Height = 25
      Caption = 'Calculate'
      TabOrder = 1
      OnClick = btnCalcCostClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 10
    Top = 263
    Width = 351
    Height = 170
    Caption = 'Question 1.4'
    TabOrder = 3
    object Label7: TLabel
      Left = 13
      Top = 20
      Width = 105
      Height = 15
      Caption = 'Number of learners:'
    end
    object Label8: TLabel
      Left = 13
      Top = 71
      Width = 94
      Height = 15
      Caption = 'Number of shoes:'
    end
    object spnLearners: TSpinEdit
      Left = 13
      Top = 41
      Width = 105
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object spnShoes: TSpinEdit
      Left = 13
      Top = 92
      Width = 105
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object memOut: TMemo
      Left = 124
      Top = 24
      Width = 217
      Height = 89
      Lines.Strings = (
        'memOut')
      TabOrder = 2
    end
    object btnShare: TButton
      Left = 13
      Top = 130
      Width = 328
      Height = 25
      Caption = 'Share'
      TabOrder = 3
      OnClick = btnShareClick
    end
  end
  object GroupBox4: TGroupBox
    Left = 367
    Top = 263
    Width = 234
    Height = 170
    Caption = 'Question 1.5'
    TabOrder = 4
    object rgpSole: TRadioGroup
      Left = 49
      Top = 19
      Width = 112
      Height = 97
      Caption = 'Soles of shoes'
      Items.Strings = (
        'Rubber'
        'Leather'
        'PVC')
      TabOrder = 0
    end
    object btnShoeUsage: TButton
      Left = 10
      Top = 130
      Width = 215
      Height = 25
      Caption = 'Shoe Usage'
      TabOrder = 1
      OnClick = btnShoeUsageClick
    end
  end
end
