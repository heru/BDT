object FormMataKuliah: TFormMataKuliah
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Daftar Mata Kuliah'
  ClientHeight = 351
  ClientWidth = 801
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object dbgridMataKuliah: TDBGrid
    Left = 8
    Top = 16
    Width = 769
    Height = 289
    DataSource = dsMataKuliah
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object dbNavMataKuliah: TDBNavigator
    Left = 24
    Top = 312
    Width = 480
    Height = 25
    DataSource = dsMataKuliah
    TabOrder = 1
  end
  object adoDSMataKuliah: TADODataSet
    Active = True
    Connection = FrmMahasiswa.ADOConnection1
    CursorType = ctStatic
    CommandText = 'select * from mata_kuliah;'
    Parameters = <>
    Left = 288
    Top = 24
  end
  object dsMataKuliah: TDataSource
    DataSet = adoDSMataKuliah
    Left = 144
    Top = 64
  end
end
