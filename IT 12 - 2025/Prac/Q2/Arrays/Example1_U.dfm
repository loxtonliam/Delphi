object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 444
  ClientWidth = 874
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object btnPopulate: TButton
    Left = 64
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Populate'
    TabOrder = 0
    OnClick = btnPopulateClick
  end
  object btnDisplay: TButton
    Left = 64
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Display'
    TabOrder = 1
    OnClick = btnDisplayClick
  end
  object btnSum: TButton
    Left = 64
    Top = 127
    Width = 75
    Height = 26
    Caption = 'Sum'
    TabOrder = 2
    OnClick = btnSumClick
  end
  object redDisplay: TRichEdit
    Left = 146
    Top = 58
    Width = 583
    Height = 303
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'redDisplay')
    ParentFont = False
    TabOrder = 3
  end
end
