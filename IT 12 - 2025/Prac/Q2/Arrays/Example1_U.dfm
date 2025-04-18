object Form3: TForm3
  Left = 0
  Top = 0
  Margins.Left = 6
  Margins.Top = 6
  Margins.Right = 6
  Margins.Bottom = 6
  Caption = 'Form3'
  ClientHeight = 832
  ClientWidth = 1174
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -23
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 180
  TextHeight = 31
  object btnPopulate: TButton
    Left = 120
    Top = 105
    Width = 141
    Height = 47
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Populate'
    TabOrder = 0
    OnClick = btnPopulateClick
  end
  object btnDisplay: TButton
    Left = 120
    Top = 180
    Width = 141
    Height = 47
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Display'
    TabOrder = 1
    OnClick = btnDisplayClick
  end
  object btnSum: TButton
    Left = 120
    Top = 239
    Width = 141
    Height = 47
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Sum'
    TabOrder = 2
    OnClick = btnSumClick
  end
  object redDisplay: TRichEdit
    Left = 273
    Top = 109
    Width = 898
    Height = 342
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
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
