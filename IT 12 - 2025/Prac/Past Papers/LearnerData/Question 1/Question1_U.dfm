object frmQuestion1: TfrmQuestion1
  Left = 0
  Top = 0
  Caption = 'General programming skills'
  ClientHeight = 671
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 397
    Height = 121
    Caption = 'Question 1.1'
    TabOrder = 0
    object lblQ1_1: TLabel
      Left = 43
      Top = 48
      Width = 43
      Height = 16
      Caption = 'lblQ1_1'
    end
    object imgQ1_1: TImage
      Left = 190
      Top = 24
      Width = 129
      Height = 76
      Stretch = True
      Transparent = True
    end
  end
  object GroupBox2: TGroupBox
    Left = 2
    Top = 143
    Width = 403
    Height = 225
    Caption = 'Question 1.2'
    TabOrder = 1
    object Label1: TLabel
      Left = 42
      Top = 54
      Width = 101
      Height = 16
      Caption = 'Number of hours:'
    end
    object Label3: TLabel
      Left = 42
      Top = 102
      Width = 160
      Height = 16
      Caption = 'Number of days and hours: '
    end
    object lblQ1_2: TLabel
      Left = 232
      Top = 102
      Width = 43
      Height = 16
      Caption = 'lblQ1_2'
    end
    object spnQ1_2: TSpinEdit
      Left = 232
      Top = 51
      Width = 81
      Height = 26
      AutoSelect = False
      MaxValue = 100
      MinValue = 1
      TabOrder = 0
      Value = 78
    end
    object btnQ1_2: TButton
      Left = 80
      Top = 146
      Width = 265
      Height = 35
      Caption = '1.2 - Days'
      TabOrder = 1
      OnClick = btnQ1_2Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 411
    Top = 374
    Width = 334
    Height = 230
    Caption = 'Question 1.5'
    TabOrder = 2
    object btnQ1_5: TButton
      Left = 48
      Top = 95
      Width = 257
      Height = 41
      Caption = '1.5 - Characters'
      TabOrder = 0
      OnClick = btnQ1_5Click
    end
    object edtQ1_5: TEdit
      Left = 16
      Top = 40
      Width = 297
      Height = 24
      TabOrder = 1
      Text = 'The Quick brOwn foX jUmps ovEr tHe lAzy DOG'
    end
  end
  object GroupBox5: TGroupBox
    Left = 411
    Top = 8
    Width = 334
    Height = 360
    Caption = 'Question 1.4'
    TabOrder = 3
    object redQ1_4: TRichEdit
      Left = 48
      Top = 24
      Width = 257
      Height = 221
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object btnQ1_4: TButton
      Left = 48
      Top = 281
      Width = 257
      Height = 35
      Caption = '1.4 - Sort'
      TabOrder = 1
      OnClick = btnQ1_4Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 2
    Top = 374
    Width = 403
    Height = 230
    Caption = 'Question 1.3'
    TabOrder = 4
    object Label2: TLabel
      Left = 89
      Top = 43
      Width = 54
      Height = 16
      Caption = 'Number: '
    end
    object btnQ1_3: TButton
      Left = 80
      Top = 96
      Width = 265
      Height = 38
      Caption = '1.3 - Guess '
      TabOrder = 0
      OnClick = btnQ1_3Click
    end
    object edtQ1_3: TEdit
      Left = 184
      Top = 40
      Width = 121
      Height = 24
      TabOrder = 1
      Text = '33214'
    end
  end
end
