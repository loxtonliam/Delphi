object frmQuestion2: TfrmQuestion2
  Left = 864
  Top = 251
  ClientHeight = 411
  ClientWidth = 662
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 654
    Height = 57
    Caption = 'Loyalty Reward System'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object gbpQuestion2_1: TGroupBox
    Left = 0
    Top = 63
    Width = 329
    Height = 346
    Caption = 'Question 2_2_1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Panel2: TPanel
      Left = 6
      Top = 24
      Width = 307
      Height = 169
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 24
        Width = 132
        Height = 17
        Caption = 'Loyalty card number'
      end
      object lblCardNumber: TLabel
        Left = 14
        Top = 130
        Width = 121
        Height = 17
        Caption = 'Loyalty card points'
      end
      object Label2: TLabel
        Left = 14
        Top = 99
        Width = 119
        Height = 17
        Caption = 'Cellphone number'
      end
      object lblLoyaltyPoints: TLabel
        Left = 199
        Top = 129
        Width = 32
        Height = 17
        Caption = '2130'
      end
      object lblCellNumber: TLabel
        Left = 199
        Top = 104
        Width = 80
        Height = 17
        Caption = '0812345678'
      end
      object cmbCardNumbers: TComboBox
        Left = 16
        Top = 56
        Width = 145
        Height = 25
        TabOrder = 0
        Text = 'B921-3$-DI'
        OnChange = cmbCardNumbersChange
        Items.Strings = (
          'B921-3$-DI'
          'B870-4%-CH'
          'P730-7*-DI'
          'B810-2#-DI')
      end
    end
    object Panel3: TPanel
      Left = 5
      Top = 199
      Width = 308
      Height = 66
      TabOrder = 1
      object Label3: TLabel
        Left = 53
        Top = 24
        Width = 85
        Height = 17
        Caption = 'Access code'
      end
      object edtCode: TEdit
        Left = 159
        Top = 16
        Width = 121
        Height = 25
        TabOrder = 0
      end
    end
    object btnQuest221: TButton
      Left = 3
      Top = 280
      Width = 310
      Height = 47
      Caption = '2.2.1 - Check access code'
      TabOrder = 2
      OnClick = btnQuest221Click
    end
  end
  object gpbQuestion2_2: TGroupBox
    Left = 335
    Top = 63
    Width = 321
    Height = 346
    Caption = 'Question 2_2_2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object redOutput: TRichEdit
      Left = 8
      Top = 24
      Width = 305
      Height = 241
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object btnQuest222: TButton
      Left = 16
      Top = 280
      Width = 289
      Height = 47
      Caption = '2.2.2 - Display card holder details'
      Enabled = False
      TabOrder = 1
      OnClick = btnQuest222Click
    end
  end
end
