object frmLicenseGen: TfrmLicenseGen
  Left = 0
  Top = 0
  Caption = 'License Generation'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  TextHeight = 15
  object btnGen: TButton
    Left = 40
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Gen License'
    TabOrder = 0
    OnClick = btnGenClick
  end
  object RichEdit1: TRichEdit
    Left = 184
    Top = 240
    Width = 257
    Height = 105
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'RichEdit1')
    ParentFont = False
    TabOrder = 1
  end
  object cmbLicenseType: TComboBox
    Left = 144
    Top = 145
    Width = 145
    Height = 23
    TabOrder = 2
    Text = 'License Type'
    Items.Strings = (
      'A: Motorbike'
      'B: Light Motor Vehicle'
      'C: Med and Heavy Motor Vehicle'
      'EB: Light Motor Vehicle with Trailer'
      'EC: Heavy Motor Vehicle with Trailer')
  end
  object cmbProvince: TComboBox
    Left = 376
    Top = 144
    Width = 145
    Height = 23
    TabOrder = 3
    Text = 'Province'
    Items.Strings = (
      'Gauteng'
      'Western Cape'
      'Eastern Cape'
      'KZN'
      'Limpopo'
      'Mpumalanga'
      'North West'
      'Northern Cape'
      'Free State')
  end
end
