unit TambahMataKuliah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DBCtrls, DB, ADODB, StdCtrls;

type
  TFormTambahKuliah = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    txtKode: TEdit;
    txtNama: TEdit;
    txtSKS: TEdit;
    btnCancel: TButton;
    btnOk: TButton;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    dbconnection :TADOConnection;
    AddMode : Boolean;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent; connection:TADOConnection; AddMode:Boolean);
    procedure setKode(kode :string);
    procedure setNama(nama :string);
    procedure setSKS(sks :Integer);
  end;

var
  FormTambahKuliah: TFormTambahKuliah;

implementation

{$R *.dfm}

{ TFormTambahKuliah }

constructor TFormTambahKuliah.Create(AOwner:TComponent; connection: TADOConnection; AddMode:Boolean);
begin
   inherited Create(AOwner);
   self.dbconnection := connection;
   Self.AddMode := AddMode                                 ;
end;

procedure TFormTambahKuliah.btnOkClick(Sender: TObject);
var cmd: TADOCommand;
    kode, nama, sks, query :string;
begin
  if (txtKode.Text <> '') AND (txtNama.Text <> '') AND (txtSKS.Text <> '') then
  begin

    kode := txtKode.Text;
    nama := txtNama.Text;
    sks := txtSKS.Text;
    if self.AddMode then
    begin
      query := 'insert into mata_kuliah(kode, nama, sks) values (''' +  kode + ''', ''' + nama + ''', ' + sks + ');';
    end
    else begin
      query := 'update mata_kuliah set nama = ''' + nama + ''', sks = ' + sks + ' where kode like ''' + kode + ''';';
    end;
    cmd := TADOCommand.Create(self);
    cmd.Connection := self.dbconnection;
    cmd.CommandType:=cmdText;
    cmd.CommandText:= query;
    cmd.Execute;
    cmd.Free;
  end
  else begin
    Application.MessageBox('Semua field masukan harus di isi', 'Pesan Error', MB_OK)
  end;
end;

procedure TFormTambahKuliah.setKode(kode: string);
begin
  txtKode.Text := kode;
  if not AddMode then
     txtKode.Enabled := False;
end;

procedure TFormTambahKuliah.setNama(nama: string);
begin
   txtNama.Text := nama;
end;

procedure TFormTambahKuliah.setSKS(sks: Integer);
begin
  txtSKS.Text := IntToStr(sks);
end;

end.
