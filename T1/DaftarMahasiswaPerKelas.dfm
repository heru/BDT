object FrmDaftarMhsPerKelas: TFrmDaftarMhsPerKelas
  Left = 254
  Top = 126
  Width = 868
  Height = 509
  BorderIcons = [biSystemMenu]
  Caption = 'Daftar Mahasiswa Per Kelas'
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
    Top = 12
    Width = 56
    Height = 13
    Caption = 'Mata Kuliah'
  end
  object DBLookupMK: TDBLookupComboBox
    Left = 112
    Top = 8
    Width = 241
    Height = 21
    ListSource = DataSourceLookupMK
    TabOrder = 0
  end
  object DBGridMHS: TDBGrid
    Left = 9
    Top = 44
    Width = 817
    Height = 389
    DataSource = DataSourceMHS
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object BtnLookup: TButton
    Left = 360
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Lihat'
    TabOrder = 2
    OnClick = BtnLookupClick
  end
  object BtnCetak: TButton
    Left = 8
    Top = 440
    Width = 75
    Height = 25
    Caption = 'BtnCetak'
    TabOrder = 3
    OnClick = BtnCetakClick
  end
  object DataSourceLookupMK: TDataSource
    DataSet = ADODataSetLookupMK
    Left = 512
  end
  object ADODataSetLookupMK: TADODataSet
    Parameters = <>
    Left = 544
  end
  object DataSourceMHS: TDataSource
    DataSet = ADODataSetMHS
    Left = 408
    Top = 224
  end
  object ADODataSetMHS: TADODataSet
    Parameters = <>
    Left = 472
    Top = 232
  end
  object RvDSConnection: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = ADODataSet1
    Left = 192
    Top = 440
  end
  object RvProject1: TRvProject
    ProjectFile = 'T1.rav'
    Left = 232
    Top = 440
  end
  object ADODataSet1: TADODataSet
    Active = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=mhs.mdb' +
      ';Persist Security Info=True'
    CursorType = ctStatic
    CommandText = 'select * from mhs_yang_ambil_mk;'
    Parameters = <>
    Left = 280
    Top = 440
  end
  object RvQueryConnection1: TRvQueryConnection
    RuntimeVisibility = rtDeveloper
    Left = 352
    Top = 440
  end
end
