object frmDosen: TfrmDosen
  Left = 292
  Top = 164
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Daftar Dosen'
  ClientHeight = 436
  ClientWidth = 789
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 16
    Width = 769
    Height = 361
    DataSource = dataSourceDosen
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 392
    Width = 760
    Height = 33
    DataSource = dataSourceDosen
    TabOrder = 1
  end
  object datasetDosen: TADODataSet
    Active = True
    Connection = FrmMahasiswa.ADOConnection1
    CursorType = ctStatic
    CommandText = 'select * from dosen;'
    Parameters = <>
    Left = 408
    Top = 48
  end
  object dataSourceDosen: TDataSource
    DataSet = datasetDosen
    Left = 288
    Top = 72
  end
end
