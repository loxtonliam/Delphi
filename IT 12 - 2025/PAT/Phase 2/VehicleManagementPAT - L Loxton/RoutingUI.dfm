object frmRouting: TfrmRouting
  Left = 0
  Top = 0
  Caption = 'Routing'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object imgStation: TImage
    Left = 144
    Top = 104
    Width = 353
    Height = 241
    ParentShowHint = False
    Proportional = True
    ShowHint = True
    Stretch = True
  end
  object cmbLocs: TComboBox
    Left = 200
    Top = 48
    Width = 145
    Height = 23
    TabOrder = 0
    Text = 'Licensing Stations'
    OnChange = cmbLocsChange
    Items.Strings = (
      'Atlantis'
      'Brackenfell'
      'Durbanville'
      'Khayelitsha'
      'Milnerton'
      'Parow'
      'Stellenbosch')
  end
  object btnDirections: TButton
    Left = 440
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Directions'
    TabOrder = 1
    OnClick = btnDirectionsClick
  end
end
