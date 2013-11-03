object FormTambahKuliah: TFormTambahKuliah
  Left = 800
  Top = 234
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Tambah Mata Kuliah'
  ClientHeight = 143
  ClientWidth = 333
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
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 25
    Height = 13
    Caption = 'Kode'
  end
  object Label2: TLabel
    Left = 24
    Top = 56
    Width = 28
    Height = 13
    Caption = 'Nama'
  end
  object Label3: TLabel
    Left = 24
    Top = 80
    Width = 21
    Height = 13
    Caption = 'SKS'
  end
  object txtKode: TEdit
    Left = 64
    Top = 20
    Width = 73
    Height = 21
    TabOrder = 0
  end
  object txtNama: TEdit
    Left = 64
    Top = 49
    Width = 249
    Height = 21
    TabOrder = 1
  end
  object txtSKS: TEdit
    Left = 63
    Top = 75
    Width = 66
    Height = 21
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 160
    Top = 112
    Width = 75
    Height = 25
    Caption = '&Batal'
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TButton
    Left = 240
    Top = 112
    Width = 75
    Height = 25
    Caption = '&Simpan'
    ModalResult = 1
    TabOrder = 4
    OnClick = btnOkClick
  end
end
