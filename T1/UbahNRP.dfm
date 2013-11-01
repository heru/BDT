object FormUbahNRP: TFormUbahNRP
  Left = 414
  Top = 313
  Width = 444
  Height = 218
  BorderIcons = [biSystemMenu]
  Caption = 'Ubah NRP Mahasiswa'
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
    Left = 16
    Top = 16
    Width = 52
    Height = 13
    Caption = 'NRP Lama'
  end
  object Label2: TLabel
    Left = 16
    Top = 40
    Width = 28
    Height = 13
    Caption = 'Nama'
  end
  object Label3: TLabel
    Left = 16
    Top = 96
    Width = 48
    Height = 13
    Caption = 'NRP Baru'
  end
  object EditNRPLama: TEdit
    Left = 80
    Top = 8
    Width = 153
    Height = 21
    TabOrder = 0
    OnKeyPress = EditNRPLamaKeyPress
  end
  object EditNama: TEdit
    Left = 80
    Top = 40
    Width = 233
    Height = 21
    TabOrder = 1
  end
  object EditNRPBaru: TEdit
    Left = 80
    Top = 88
    Width = 161
    Height = 21
    MaxLength = 12
    TabOrder = 2
    OnKeyPress = EditNRPBaruKeyPress
  end
  object ButtonSave: TButton
    Left = 256
    Top = 152
    Width = 75
    Height = 25
    Caption = '&Simpan'
    ModalResult = 6
    TabOrder = 3
    OnClick = ButtonSaveClick
  end
  object ButtonCancel: TButton
    Left = 344
    Top = 152
    Width = 75
    Height = 25
    Caption = '&Batal'
    ModalResult = 2
    TabOrder = 4
    OnClick = ButtonCancelClick
  end
end
