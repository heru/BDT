object FrmTambahMahasiswa: TFrmTambahMahasiswa
  Left = 386
  Top = 163
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Tambah Data Mahasiswa'
  ClientHeight = 251
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 20
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 33
    Height = 20
    Caption = 'NRP'
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 42
    Height = 20
    Caption = 'Nama'
  end
  object Label3: TLabel
    Left = 16
    Top = 80
    Width = 50
    Height = 20
    Caption = 'Alamat'
  end
  object Label4: TLabel
    Left = 16
    Top = 112
    Width = 81
    Height = 20
    Caption = 'Dosen Wali'
  end
  object Label5: TLabel
    Left = 16
    Top = 144
    Width = 101
    Height = 20
    Caption = 'Program Studi'
  end
  object Edit1: TEdit
    Left = 144
    Top = 16
    Width = 201
    Height = 28
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 144
    Top = 48
    Width = 257
    Height = 28
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 144
    Top = 80
    Width = 369
    Height = 28
    TabOrder = 2
  end
  object dbLookupDosen: TDBLookupComboBox
    Left = 144
    Top = 112
    Width = 225
    Height = 28
    KeyField = 'nip'
    ListField = 'nama'
    ListSource = datasourceDosen
    TabOrder = 3
  end
  object dblookupProdi: TDBLookupComboBox
    Left = 144
    Top = 144
    Width = 225
    Height = 28
    KeyField = 'kode_prodi'
    ListField = 'nama'
    ListSource = dataSourceProdi
    TabOrder = 4
  end
  object btnSimpan: TButton
    Left = 16
    Top = 200
    Width = 75
    Height = 33
    Caption = '&Simpan'
    TabOrder = 5
    OnClick = btnSimpanClick
  end
  object btnCancel: TButton
    Left = 424
    Top = 200
    Width = 75
    Height = 33
    Caption = '&Batal'
    TabOrder = 6
    OnClick = btnCancelClick
  end
  object datasourceDosen: TDataSource
    DataSet = datasetDosen
    Left = 392
    Top = 16
  end
  object datasetDosen: TADODataSet
    Active = True
    Connection = FrmMahasiswa.ADOConnection1
    CursorType = ctStatic
    CommandText = 'select * from dosen'
    Parameters = <>
    Left = 432
    Top = 16
  end
  object datasetProdi: TADODataSet
    Active = True
    Connection = FrmMahasiswa.ADOConnection1
    CursorType = ctStatic
    CommandText = 'select * from prodi'
    Parameters = <>
    Left = 360
    Top = 16
  end
  object dataSourceProdi: TDataSource
    DataSet = datasetProdi
    Left = 456
    Top = 16
  end
end
