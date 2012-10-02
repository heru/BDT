object FrmMahasiswa: TFrmMahasiswa
  Left = 213
  Top = 121
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Data Mahasiswa'
  ClientHeight = 521
  ClientWidth = 946
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 65
    Height = 16
    Caption = 'Cari NRP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 40
    Width = 929
    Height = 417
    DataSource = mhsDS
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 472
    Width = 450
    Height = 33
    DataSource = mhsDS
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
    TabOrder = 1
  end
  object btnEdit: TButton
    Left = 536
    Top = 472
    Width = 75
    Height = 33
    Caption = 'Ubah'
    TabOrder = 2
    OnClick = btnEditClick
  end
  object txtEdit: TEdit
    Left = 77
    Top = 3
    Width = 188
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object btnFilter: TButton
    Left = 270
    Top = 2
    Width = 75
    Height = 31
    Caption = 'Cari'
    TabOrder = 4
    OnClick = btnFilterClick
  end
  object btnAdd: TButton
    Left = 624
    Top = 472
    Width = 65
    Height = 33
    Caption = '+'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btnAddClick
  end
  object btnDelete: TButton
    Left = 696
    Top = 472
    Width = 75
    Height = 33
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btnDeleteClick
  end
  object mhsDS: TDataSource
    DataSet = ADODataSet1
    Left = 376
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Password="";User ID=Admin;Data ' +
      'Source=mhs.mdb;Mode=Share Deny None;Extended Properties="";Persi' +
      'st Security Info=True;Jet OLEDB:System database="";Jet OLEDB:Reg' +
      'istry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Ty' +
      'pe=5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial ' +
      'Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Da' +
      'tabase Password="";Jet OLEDB:Create System Database=False;Jet OL' +
      'EDB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale on Compac' +
      't=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB' +
      ':SFP=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 520
  end
  object ADODataSet1: TADODataSet
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandText = 'select *  from mhs;'
    Parameters = <>
    Left = 408
  end
  object MainMenu1: TMainMenu
    Left = 480
    object mnFile: TMenuItem
      Caption = '&File'
      object mnDosen: TMenuItem
        Caption = 'Dosen'
        OnClick = mnDosenClick
      end
      object mnProgramStudi: TMenuItem
        Caption = 'Program Studi'
        OnClick = mnProgramStudiClick
      end
      object mnMataKuliah: TMenuItem
        Caption = 'Mata Kuliah'
        OnClick = mnMataKuliahClick
      end
    end
    object mnLihat: TMenuItem
      Caption = 'Proses'
      object mnPengambilanFRS: TMenuItem
        Caption = 'Pengambilan FRS'
        OnClick = mnPengambilanFRSClick
      end
    end
    object mnExit: TMenuItem
      Caption = '&Keluar'
      OnClick = mnExitClick
    end
  end
end
