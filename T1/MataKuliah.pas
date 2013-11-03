unit MataKuliah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DBCtrls, DB, ADODB, StdCtrls;

type
  TFormMataKuliah = class(TForm)
    dbgridMataKuliah: TDBGrid;
    dbNavMataKuliah: TDBNavigator;
    adoDSMataKuliah: TADODataSet;
    dsMataKuliah: TDataSource;
    btnAdd: TButton;
    btnDelete: TButton;
    btnChange: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMataKuliah: TFormMataKuliah;

implementation
uses main, TambahMataKuliah;
{$R *.dfm}

procedure TFormMataKuliah.btnAddClick(Sender: TObject);
var tambahMatKul : TFormTambahKuliah;
begin
  tambahMatKul := TFormTambahKuliah.Create(self, adoDSMataKuliah.Connection, True);
  tambahMatKul.ShowModal;
  self.adoDSMataKuliah.Close;
  tambahMatKul.Free;
  self.adoDSMataKuliah.Open;
end;

procedure TFormMataKuliah.btnChangeClick(Sender: TObject);
var kode, nama :string;
  sks : integer;
  editMatKul : TFormTambahKuliah;
begin
  kode := adoDSMataKuliah.FieldValues['kode'];
  nama := adoDSMataKuliah.FieldValues['nama'];
  sks := adoDSMataKuliah.FieldValues['sks'];

  editMatKul := TFormTambahKuliah.Create(self, adoDSMataKuliah.Connection, False);
  editMatKul.setKode(kode);
  editMatKul.setNama(nama);
  editMatKul.setSKS(sks);
  editMatKul.ShowModal;
  adoDSMataKuliah.Close;

  editMatKul.Free;
  adoDSMataKuliah.Open;
end;

procedure TFormMataKuliah.btnDeleteClick(Sender: TObject);
var kode_matkul,query_delete, delete_password, password_input: string;
  deleteCMD : TADOCommand;
  cariFRS : TADODataSet;
begin
   delete_password := 'ok';
   password_input := InputBox('Konfirmasi Password', 'Password untuk menghapus data','');
   if password_input = delete_password then
   begin
    if MessageDlg('Hapus data ini ?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
    begin
      kode_matkul := adoDSMataKuliah.FieldValues['kode'];
      // mata kuliah hanya dapat dihapus jika tidak diambil oleh mahasiswa
      cariFRS := TADODataSet.Create(self);
      cariFRS.Connection := adoDSMataKuliah.Connection;
      cariFRS.CommandText := 'select * from pengambilan_frs where kode_mata_kuliah like ''' + kode_matkul + ''';';
      cariFRS.Open;
      if cariFRS.RecordCount < 1 then
      begin
        query_delete := 'delete from mata_kuliah where kode like ''' + kode_matkul + ''';';
        deleteCMD := TADOCommand.Create(self);
        deleteCMD.CommandType := cmdText;
        deleteCMD.Connection := adoDSMataKuliah.Connection;
        deleteCMD.CommandText := query_delete;
        deleteCMD.Execute;
        adoDSMataKuliah.Close;
        deleteCMD.Free;
        adoDSMataKuliah.Open;
      end
      else begin
        Application.MessageBox('Tidak dapat menghapus mata kuliah karena sedang diambil oleh mahasiswa','Informasi',MB_OK);
      end;
      cariFRS.Close;
      cariFRS.Free;
    end;
   end;
end;



end.
