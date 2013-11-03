object FormMataKuliah: TFormMataKuliah
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Daftar Mata Kuliah'
  ClientHeight = 351
  ClientWidth = 783
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
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
    Left = 12
    Top = 315
    Width = 465
    Height = 30
    DataSource = dsMataKuliah
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
    TabOrder = 1
  end
  object btnAdd: TButton
    Left = 492
    Top = 315
    Width = 75
    Height = 30
    Caption = '+'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnAddClick
  end
  object btnDelete: TButton
    Left = 576
    Top = 315
    Width = 75
    Height = 30
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnDeleteClick
  end
  object btnChange: TButton
    Left = 656
    Top = 312
    Width = 75
    Height = 33
    Caption = 'Ubah'
    TabOrder = 4
    OnClick = btnChangeClick
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
