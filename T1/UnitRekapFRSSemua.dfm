object FormRekapFRSSemua: TFormRekapFRSSemua
  Left = 334
  Top = 178
  Width = 786
  Height = 480
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
    Width = 118
    Height = 13
    Caption = 'Total Mahasiswa/SKS = '
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
    Width = 745
    Height = 193
    ColCount = 6
    DefaultColWidth = 100
    FixedCols = 0
    TabOrder = 0
  end
  object StringGrid2: TStringGrid
    Left = 16
    Top = 248
    Width = 745
    Height = 169
    DefaultColWidth = 100
    FixedCols = 0
    TabOrder = 1
  end
end
