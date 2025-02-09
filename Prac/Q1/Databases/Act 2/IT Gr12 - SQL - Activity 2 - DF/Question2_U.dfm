object frmQuestion2: TfrmQuestion2
  Left = 0
  Top = 0
  Caption = 'Question 2'
  ClientHeight = 486
  ClientWidth = 986
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmOptions
  OnActivate = FormActivate
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 986
    Height = 486
    ActivePage = tbsQ2_1
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 976
    ExplicitHeight = 454
    object tbsQ2_1: TTabSheet
      Caption = 'Question 2.1 SQL'
      OnShow = tbsQ2_1Show
      object grdQ2: TDBGrid
        Left = 0
        Top = 0
        Width = 970
        Height = 445
        Align = alClient
        DataSource = dmQuestion2.dsrQ2
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object tbsQ2_2: TTabSheet
      Caption = 'Question 2.2 DB'
      ImageIndex = 1
      OnShow = tbsQ2_2Show
      object Label2: TLabel
        Left = 8
        Top = 41
        Width = 124
        Height = 23
        Caption = 'Clients Table'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 8
        Top = 0
        Width = 204
        Height = 29
        Caption = 'Deli Express - DB'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 10
        Top = 242
        Width = 122
        Height = 23
        Caption = 'Orders Table'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbgClients: TDBGrid
        Left = 10
        Top = 70
        Width = 567
        Height = 155
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object dbgOrders: TDBGrid
        Left = 10
        Top = 271
        Width = 567
        Height = 170
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object GroupBox1: TGroupBox
        Left = 592
        Top = 70
        Width = 369
        Height = 371
        TabOrder = 2
        object redDisplay: TRichEdit
          Left = 16
          Top = 240
          Width = 337
          Height = 113
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object btnGender: TButton
          Left = 24
          Top = 24
          Width = 321
          Height = 58
          Caption = 'Question 2.2.1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnGenderClick
        end
        object btnDelete: TButton
          Left = 24
          Top = 96
          Width = 321
          Height = 59
          Caption = 'Question 2.2.2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnDeleteClick
        end
        object btnNewClient: TButton
          Left = 24
          Top = 169
          Width = 321
          Height = 60
          Caption = 'Question 2.2.3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = btnNewClientClick
        end
      end
    end
  end
  object mmOptions: TMainMenu
    Left = 944
    Top = 448
    object OptionA1: TMenuItem
      Caption = 'Option A'
      Visible = False
      OnClick = OptionA1Click
    end
    object OptionB1: TMenuItem
      Caption = 'Option B'
      Visible = False
      OnClick = OptionB1Click
    end
    object OptionC1: TMenuItem
      Caption = 'Option C'
      Visible = False
      OnClick = OptionC1Click
    end
    object OptionD1: TMenuItem
      Caption = 'Option D'
      Visible = False
      OnClick = OptionD1Click
    end
    object OptionE1: TMenuItem
      Caption = 'Option E'
      Visible = False
      OnClick = OptionE1Click
    end
    object RestoreDatabase1: TMenuItem
      Caption = 'Restore Database'
      OnClick = RestoreDatabase1Click
    end
  end
end
