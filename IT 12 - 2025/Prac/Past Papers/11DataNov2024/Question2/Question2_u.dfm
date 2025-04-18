object frmQuestion2: TfrmQuestion2
  Left = 0
  Top = 0
  Margins.Left = 2
  Margins.Top = 2
  Margins.Right = 2
  Margins.Bottom = 2
  Caption = 'Question 2'
  ClientHeight = 295
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 52
    Height = 15
    Caption = 'Book Title'
  end
  object Label2: TLabel
    Left = 24
    Top = 92
    Width = 25
    Height = 15
    Caption = 'ISBN'
  end
  object Label3: TLabel
    Left = 192
    Top = 16
    Width = 37
    Height = 15
    Caption = 'Author'
  end
  object edtBookName: TEdit
    Left = 24
    Top = 40
    Width = 121
    Height = 23
    TabOrder = 0
    Text = 'lord of the flies'
  end
  object edtISBN: TEdit
    Left = 24
    Top = 115
    Width = 121
    Height = 23
    TabOrder = 2
    Text = '0205080057'
  end
  object btnAddBook: TButton
    Left = 192
    Top = 114
    Width = 121
    Height = 25
    Caption = 'Add Book'
    TabOrder = 3
    OnClick = btnAddBookClick
  end
  object edtAuthor: TEdit
    Left = 192
    Top = 40
    Width = 121
    Height = 23
    TabOrder = 1
    Text = 'william golding'
  end
  object redOut: TRichEdit
    Left = 24
    Top = 176
    Width = 289
    Height = 97
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'redOut')
    ParentFont = False
    TabOrder = 4
    Zoom = 100
  end
end
