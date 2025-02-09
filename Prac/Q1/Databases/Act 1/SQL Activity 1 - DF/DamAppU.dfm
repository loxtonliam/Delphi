object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'SQL Activity 1'
  ClientHeight = 521
  ClientWidth = 990
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Arial Narrow'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 20
  object dbgDams: TDBGrid
    Left = 8
    Top = 16
    Width = 969
    Height = 193
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -16
    TitleFont.Name = 'Arial Narrow'
    TitleFont.Style = []
  end
  object dbgTowns: TDBGrid
    Left = 8
    Top = 215
    Width = 969
    Height = 186
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -16
    TitleFont.Name = 'Arial Narrow'
    TitleFont.Style = []
  end
  object rgpSQL: TRadioGroup
    Left = 8
    Top = 407
    Width = 969
    Height = 105
    Caption = 'SQL Control'
    Columns = 11
    ItemIndex = 0
    Items.Strings = (
      'Reset'
      'SQL1'
      'SQL2'
      'SQL3'
      'SQL4'
      'SQL5'
      'SQL6'
      'SQL7'
      'SQL8'
      'SQL9'
      'SQL10')
    TabOrder = 2
    OnClick = rgpSQLClick
  end
  object adoDams: TADOConnection
    Left = 464
    Top = 192
  end
  object tblDams: TADOTable
    Left = 904
    Top = 32
  end
  object tblTowns: TADOTable
    Left = 904
    Top = 232
  end
  object dsDams: TDataSource
    Left = 904
    Top = 96
  end
  object dsTowns: TDataSource
    Left = 904
    Top = 288
  end
  object qryDams: TADOQuery
    Parameters = <>
    Left = 32
    Top = 144
  end
  object qryTowns: TADOQuery
    Parameters = <>
    Left = 32
    Top = 344
  end
end
