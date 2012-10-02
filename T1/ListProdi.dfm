object frmProgramStudi: TfrmProgramStudi
  Left = 299
  Top = 124
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Program Studi'
  ClientHeight = 390
  ClientWidth = 755
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
    Top = 8
    Width = 737
    Height = 337
    DataSource = datasourceProdi
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 16
    Top = 352
    Width = 720
    Height = 33
    DataSource = datasourceProdi
    TabOrder = 1
  end
  object datasourceProdi: TDataSource
    DataSet = datasetProdi
    Left = 520
    Top = 152
  end
  object datasetProdi: TADODataSet
    Active = True
    Connection = FrmMahasiswa.ADOConnection1
    CursorType = ctStatic
    CommandText = 'select * from prodi'
    Parameters = <>
    Left = 96
    Top = 72
  end
end
