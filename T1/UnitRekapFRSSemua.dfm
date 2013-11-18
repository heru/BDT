object FormRekapFRSSemua: TFormRekapFRSSemua
  Left = 515
  Top = 30
  Width = 660
  Height = 650
  Caption = 'Rekap FRS Semua Mahasiswa'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblTotal: TLabel
    Left = 16
    Top = 424
    Width = 70
    Height = 13
    Caption = 'Rangking SKS'
  end
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 72
    Height = 13
    Caption = 'Per Mahasiswa'
  end
  object Label2: TLabel
    Left = 24
    Top = 232
    Width = 75
    Height = 13
    Caption = 'Per Mata Kuliah'
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 32
    Width = 609
    Height = 193
    ColCount = 6
    DefaultColWidth = 100
    FixedCols = 0
    TabOrder = 0
  end
  object StringGrid2: TStringGrid
    Left = 8
    Top = 248
    Width = 617
    Height = 169
    DefaultColWidth = 100
    FixedCols = 0
    TabOrder = 1
  end
  object StringGrid3: TStringGrid
    Left = 8
    Top = 448
    Width = 625
    Height = 161
    DefaultColWidth = 100
    FixedCols = 0
    TabOrder = 2
  end
end
