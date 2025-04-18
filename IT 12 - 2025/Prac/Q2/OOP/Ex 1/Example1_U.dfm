object Form3: TForm3
  Left = 0
  Top = 0
  Margins.Left = 6
  Margins.Top = 6
  Margins.Right = 6
  Margins.Bottom = 6
  Caption = 'frm'
  ClientHeight = 750
  ClientWidth = 1206
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -23
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 180
  TextHeight = 31
  object RichEdit1: TRichEdit
    Left = 375
    Top = 90
    Width = 525
    Height = 287
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
      'RichEdit1')
    ParentFont = False
    TabOrder = 0
  end
  object btnInt: TButton
    Left = 41
    Top = 120
    Width = 190
    Height = 47
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Instantiate object'
    TabOrder = 1
    OnClick = btnIntClick
  end
  object btnDisplay: TButton
    Left = 41
    Top = 179
    Width = 190
    Height = 47
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Display All'
    TabOrder = 2
    OnClick = btnDisplayClick
  end
  object btnMP: TButton
    Left = 11
    Top = 241
    Width = 245
    Height = 47
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Display Make and Price'
    TabOrder = 3
    OnClick = btnMPClick
  end
  object btnColour: TButton
    Left = 41
    Top = 300
    Width = 190
    Height = 47
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Change Colour'
    TabOrder = 4
    OnClick = btnColourClick
  end
end
