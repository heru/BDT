object FrmNilaiAkademik: TFrmNilaiAkademik
  Left = 234
  Top = 48
  Width = 907
  Height = 412
  Caption = 'KHS'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 23
    Height = 13
    Caption = 'NRP'
  end
  object Label5: TLabel
    Left = 24
    Top = 75
    Width = 55
    Height = 13
    Caption = 'Dosen Wali'
  end
  object Label2: TLabel
    Left = 24
    Top = 43
    Width = 28
    Height = 13
    Caption = 'Nama'
  end
  object Label6: TLabel
    Left = 24
    Top = 100
    Width = 66
    Height = 13
    Caption = 'Program Studi'
  end
  object LblJumlahSKS: TLabel
    Left = 216
    Top = 335
    Width = 24
    Height = 24
    Caption = 'SKS:'
  end
  object LblJumlahMataKuliah: TLabel
    Left = 8
    Top = 335
    Width = 92
    Height = 24
    Caption = 'Jumlah Mata Kuliah'
  end
  object txtNama: TEdit
    Left = 96
    Top = 38
    Width = 225
    Height = 21
    TabOrder = 0
  end
  object txtSearchMhs: TEdit
    Left = 96
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object btnLookup: TButton
    Left = 224
    Top = 6
    Width = 99
    Height = 25
    Caption = '&Lihat'
    TabOrder = 2
    OnClick = btnLookupClick
  end
  object txtDosenWali: TEdit
    Left = 96
    Top = 67
    Width = 225
    Height = 21
    TabOrder = 3
  end
  object txtProdi: TEdit
    Left = 96
    Top = 96
    Width = 225
    Height = 21
    TabOrder = 4
  end
  object DBGrid1: TDBGrid
    Left = 770
    Top = 8
    Width = 87
    Height = 33
    DataSource = dsQueryFRS
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object StringGrid2: TStringGrid
    Left = 8
    Top = 128
    Width = 865
    Height = 193
    ColCount = 6
    DefaultColWidth = 100
    FixedCols = 0
    TabOrder = 6
  end
  object dsLookupMhs: TDataSource
    DataSet = adoDatasetLookupMhs
    Left = 384
    Top = 16
  end
  object adoDatasetLookupMhs: TADODataSet
    Connection = FrmMahasiswa.ADOConnection1
    CommandText = 'select * from mhs;'
    Parameters = <>
    Left = 424
    Top = 16
  end
  object adoQueryFRS: TADODataSet
    Parameters = <>
    Left = 600
    Top = 56
  end
  object dsQueryFRS: TDataSource
    DataSet = adoQueryFRS
    Left = 544
    Top = 16
  end
end
