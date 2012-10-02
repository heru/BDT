object frmEditMahasiswa: TfrmEditMahasiswa
  Left = 361
  Top = 163
  BorderStyle = bsDialog
  Caption = 'Ubah Data Mahasiswa'
  ClientHeight = 245
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 29
    Height = 16
    Caption = 'NRP'
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 37
    Height = 16
    Caption = 'Nama'
  end
  object Label3: TLabel
    Left = 16
    Top = 88
    Width = 42
    Height = 16
    Caption = 'Alamat'
  end
  object Label4: TLabel
    Left = 16
    Top = 120
    Width = 70
    Height = 16
    Caption = 'Dosen Wali'
  end
  object Label5: TLabel
    Left = 16
    Top = 150
    Width = 85
    Height = 16
    Caption = 'Program Studi'
  end
  object DBEdit1: TDBEdit
    Left = 111
    Top = 16
    Width = 201
    Height = 24
    DataField = 'nrp'
    Enabled = False
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 111
    Top = 48
    Width = 281
    Height = 24
    DataField = 'nama'
    TabOrder = 1
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 112
    Top = 112
    Width = 225
    Height = 24
    DataSource = FrmMahasiswa.mhsDS
    KeyField = 'nip'
    ListField = 'nama'
    ListSource = DataSource1
    TabOrder = 2
  end
  object btnEdit: TButton
    Left = 16
    Top = 192
    Width = 97
    Height = 41
    Caption = '&Simpan'
    TabOrder = 3
    OnClick = btnEditClick
  end
  object DBEdit3: TDBEdit
    Left = 111
    Top = 80
    Width = 313
    Height = 24
    TabOrder = 4
  end
  object DBLookupComboBox2: TDBLookupComboBox
    Left = 112
    Top = 147
    Width = 209
    Height = 24
    DataSource = FrmMahasiswa.mhsDS
    KeyField = 'kode_prodi'
    ListField = 'nama'
    ListSource = DataSource2
    TabOrder = 5
  end
  object btnClose: TButton
    Left = 328
    Top = 192
    Width = 89
    Height = 41
    Caption = '&Batal'
    TabOrder = 6
    OnClick = btnCloseClick
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 336
    Top = 8
  end
  object ADODataSet1: TADODataSet
    Active = True
    Connection = FrmMahasiswa.ADOConnection1
    CursorType = ctStatic
    CommandText = 'select nip,nama from dosen'
    Parameters = <>
    Left = 304
    Top = 8
  end
  object DataSource2: TDataSource
    DataSet = ADODataSet2
    Left = 400
    Top = 8
  end
  object ADODataSet2: TADODataSet
    Active = True
    Connection = FrmMahasiswa.ADOConnection1
    CursorType = ctStatic
    CommandText = 'select * from prodi'
    Parameters = <>
    Left = 368
    Top = 8
  end
end
