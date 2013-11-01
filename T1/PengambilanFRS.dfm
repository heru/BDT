object FrmPengambilanFRS: TFrmPengambilanFRS
  Left = 231
  Top = 182
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pengambilan FRS'
  ClientHeight = 463
  ClientWidth = 897
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 23
    Height = 13
    Caption = 'NRP'
  end
  object Label2: TLabel
    Left = 24
    Top = 43
    Width = 28
    Height = 13
    Caption = 'Nama'
  end
  object Label3: TLabel
    Left = 16
    Top = 128
    Width = 155
    Height = 13
    Caption = 'Daftar Mata Kuliah Yang di Ambil'
  end
  object Label5: TLabel
    Left = 24
    Top = 75
    Width = 55
    Height = 13
    Caption = 'Dosen Wali'
  end
  object Label6: TLabel
    Left = 24
    Top = 100
    Width = 66
    Height = 13
    Caption = 'Program Studi'
  end
  object LblJumlahMataKuliah: TLabel
    Left = 24
    Top = 328
    Width = 92
    Height = 13
    Caption = 'Jumlah Mata Kuliah'
  end
  object LblJumlahSKS: TLabel
    Left = 232
    Top = 328
    Width = 24
    Height = 13
    Caption = 'SKS:'
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 148
    Width = 873
    Height = 165
    DataSource = dsQueryFRS
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object btnLookup: TButton
    Left = 224
    Top = 6
    Width = 99
    Height = 25
    Caption = '&Lihat'
    TabOrder = 1
    OnClick = btnLookupClick
  end
  object txtSearchMhs: TEdit
    Left = 96
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object txtNama: TEdit
    Left = 96
    Top = 38
    Width = 225
    Height = 21
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 384
    Width = 873
    Height = 65
    Caption = 'Tambah Mata Kuliah'
    TabOrder = 4
    object Label4: TLabel
      Left = 8
      Top = 27
      Width = 56
      Height = 13
      Caption = 'Mata Kuliah'
    end
    object dbLookupComboMataKuliah: TDBLookupComboBox
      Left = 72
      Top = 24
      Width = 705
      Height = 21
      KeyField = 'kode'
      ListField = 'nama'
      ListSource = dsMataKuliah
      TabOrder = 0
    end
    object btnAddMataKuliah: TButton
      Left = 784
      Top = 22
      Width = 75
      Height = 25
      Caption = '&Tambah'
      Enabled = False
      TabOrder = 1
      OnClick = btnAddMataKuliahClick
    end
  end
  object txtDosenWali: TEdit
    Left = 96
    Top = 67
    Width = 225
    Height = 21
    TabOrder = 5
  end
  object txtProdi: TEdit
    Left = 96
    Top = 96
    Width = 225
    Height = 21
    TabOrder = 6
  end
  object dbNavMataKuliah: TDBNavigator
    Left = 16
    Top = 349
    Width = 376
    Height = 33
    DataSource = dsQueryFRS
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
    TabOrder = 7
  end
  object btnHapusMataKuliah: TButton
    Left = 416
    Top = 350
    Width = 233
    Height = 33
    Caption = '&Hapus Mata Kuliah Yang Sudah Di Ambil'
    Enabled = False
    TabOrder = 8
    OnClick = btnHapusMataKuliahClick
  end
  object dsMataKuliah: TDataSource
    DataSet = adoDSMataKuliah
    Left = 736
    Top = 400
  end
  object adoDSMataKuliah: TADODataSet
    Active = True
    Connection = FrmMahasiswa.ADOConnection1
    CursorType = ctStatic
    CommandText = 'select * from mata_kuliah'
    Parameters = <>
    Left = 824
    Top = 392
  end
  object dsQueryFRS: TDataSource
    DataSet = adoQueryFRS
    Left = 568
    Top = 112
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
    AfterOpen = adoQueryFRSAfterOpen
    Parameters = <>
    Left = 608
    Top = 112
  end
end
