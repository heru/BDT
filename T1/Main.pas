unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Menus;

type
  TFrmMahasiswa = class(TForm)
    mhsDS: TDataSource;
    DBGrid1: TDBGrid;
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    DBNavigator1: TDBNavigator;
    btnEdit: TButton;
    txtEdit: TEdit;
    btnFilter: TButton;
    MainMenu1: TMainMenu;
    mnLihat: TMenuItem;
    mnDosen: TMenuItem;
    mnProgramStudi: TMenuItem;
    mnFile: TMenuItem;
    mnExit: TMenuItem;
    Label1: TLabel;
    btnAdd: TButton;
    btnDelete: TButton;
    mnPengambilanFRS: TMenuItem;
    mnMataKuliah: TMenuItem;
    MnDaftarKelas: TMenuItem;
    ButtonUbahNRP: TButton;
    RekapFRSSemua: TMenuItem;
    procedure btnEditClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure mnExitClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure mnDosenClick(Sender: TObject);
    procedure mnProgramStudiClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure mnPengambilanFRSClick(Sender: TObject);
    procedure mnMataKuliahClick(Sender: TObject);
    procedure MnDaftarKelasClick(Sender: TObject);
    procedure ButtonUbahNRPClick(Sender: TObject);
    procedure RekapFRSSemuaClick(Sender: TObject);
  private
    { Private  }
  public
    { Public declarations }
    procedure ReloadDataset;
    procedure CariNRPTerdekat(nrp:string);
    procedure MoveCursor(nrp_found:string);
  end;

var
  FrmMahasiswa: TFrmMahasiswa;


implementation

uses EditMahasiswa,AddMahasiswa, ListDosen, ListProdi, PengambilanFRS,
     MataKuliah, DaftarMahasiswaPerKelas, UbahNRP, UnitRekapFRSSemua;

{$R *.dfm}

procedure TFrmMahasiswa.btnEditClick(Sender: TObject);
var nrp:string;
begin
  nrp := ADODataSet1.FieldValues['nrp'];
  //MessageDlg(nrp, mtConfirmation, [mbYes, mbNo],0)
  frmEditMahasiswa.SetCurrentNRP(nrp);
  frmEditMahasiswa.ShowModal;
end;

{*
    jika filtering data, tutup AdoDataset kemudian spesifikasikan command teks
    yang digunakan oleh Adodataset untuk mengambil data dari table.

    setelah itu re-open kembali AdoDatasetnya
*}
procedure TFrmMahasiswa.btnFilterClick(Sender: TObject);
var query_select :string;
    adodsSearch: TADODataSet;
    upper : Integer;
    lower : integer;
begin
    if Self.txtEdit.Text <> '' then
    begin
      query_select := 'select m.nrp as nrp, m.nama as nama, m.alamat as alamat, d.nama as dosen, p.nama as prodi from mhs m, dosen d, prodi p where m.nrp like ''%' + txtEdit.Text + '%'' and m.dosen_wali = d.nip and m.prodi = p.kode_prodi order by m.nrp;';
      //adodsSearch := TADODataSet;
      adodsSearch := TADODataSet.Create(Self);

      adodsSearch.Connection := ADODataSet1.Connection;
      //adodsSearch.Connection.ConnectionString := ADODataSet1.ConnectionString;
      //adodsSearch.Connection.LoginPrompt := False;
      adodsSearch.CommandText:= query_select;
      adodsSearch.Open;
      if adodsSearch.RecordCount > 0 then
      begin
        ADODataSet1.Close;
        ADODataSet1.CommandText := query_select;

      end
      else
      begin
         CariNRPTerdekat(txtEdit.Text);
      end;
      adodsSearch.Close;
    end
    else
    begin

      ADODataSet1.Close;
      ADODataSet1.CommandText := 'select m.nrp as nrp, m.nama as nama, m.alamat as alamat, d.nama as dosen, p.nama as prodi from mhs m, dosen d, prodi p where m.dosen_wali = d.nip and m.prodi = p.kode_prodi order by m.nrp;';
      //ADODataSet1.CommandText := 'select m.nrp as nrp, m.nama as nama, m.alamat as alamat, m.dosen_wali as dosen_wali, m.prodi as prodi, d.nama as nama_dosen, p.nama as nama_prodi from mhs m, dosen d, prodi p where m.dosen_wali = d.nip and m.prodi = p.kode_prodi;'
    end;
    ADODataSet1.Open;
end;

procedure TFrmMahasiswa.CariNRPTerdekat(nrp:string);
var moveup, movedown : Integer;
    search_key:Integer;
    found : Boolean;
    adodsSearchNRP : TADODataSet;
    query_search : string;
    found_nrp :string;
begin
    search_key := StrToInt(nrp);
    moveup := search_key;
    movedown := search_key;
    found := False;
    adodsSearchNRP := TADODataSet.Create(self);
    adodsSearchNRP.Connection := ADODataSet1.Connection;
    while not found
    do begin
        moveup := moveup+1;
        query_search := 'select m.nrp as nrp, m.nama as nama, m.alamat as alamat, d.nama as dosen, p.nama as prodi from mhs m, dosen d, prodi p where m.nrp like ''%' + IntToStr( moveup) + '%'' and m.dosen_wali = d.nip and m.prodi = p.kode_prodi order by m.nrp;';
        adodsSearchNRP.CommandText := query_search;
        adodsSearchNRP.Open;
        if adodsSearchNRP.RecordCount > 0 then
        begin
           found:=True;
           adodsSearchNRP.First;
           found_nrp := adodsSearchNRP.FieldValues['nrp'];
           MoveCursor(found_nrp);

        end
        else begin
            adodsSearchNRP.Close;
            movedown := movedown -1;
            query_search := 'select m.nrp as nrp, m.nama as nama, m.alamat as alamat, d.nama as dosen, p.nama as prodi from mhs m, dosen d, prodi p where m.nrp like ''%' + IntToStr( movedown) + '%'' and m.dosen_wali = d.nip and m.prodi = p.kode_prodi order by m.nrp;';
            adodsSearchNRP.CommandText := query_search;
            adodsSearchNRP.Open;
            if adodsSearchNRP.RecordCount > 0 then
            begin
              found:=True;
              adodsSearchNRP.First;
              found_nrp := adodsSearchNRP.FieldValues['nrp'];
              MoveCursor(found_nrp);
            end
        end;
        adodsSearchNRP.Close;
    end
end;
procedure TFrmMahasiswa.MoveCursor(nrp_found: string);
var found:Boolean;
    current_nrp :string;
begin
  ADODataSet1.First;
  found := False;
  while not found do
  begin
      current_nrp := ADODataSet1.FieldValues['nrp'];
      if current_nrp <> nrp_found then
      begin
         ADODataSet1.Next; 
      end
      else begin
         found := True;
      end
  end
end;

procedure TFrmMahasiswa.mnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMahasiswa.btnAddClick(Sender: TObject);
begin
  FrmTambahMahasiswa.ShowModal;
end;

procedure TFrmMahasiswa.mnDosenClick(Sender: TObject);
begin
  frmDosen.ShowModal;
end;

procedure TFrmMahasiswa.mnProgramStudiClick(Sender: TObject);
begin
  frmProgramStudi.ShowModal;
end;

procedure TFrmMahasiswa.btnDeleteClick(Sender: TObject);
var deleteCmd : TADOCommand;
    adoCariFRS : TADODataSet;
    nrp, query_delete :string;
    password_input:string;
    password : string;
begin
  password := 'ok';
  password_input := InputBox('Konfirmasi Password','Konfirmasi Password dibutuhkan untuk menghapus data','');
  if password_input = password then
  begin
    if MessageDlg('Hapus data ini ?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
    begin
      nrp := ADODataSet1.FieldValues['nrp'];
      if nrp <> '' then
      begin
        // cari apakah mahasiswa sedang mengambil frs
        adoCariFRS := TADODataSet.Create(self);
        adoCariFRS.Connection := ADOConnection1;
        adoCariFRS.CommandText := 'select * from pengambilan_frs where mhs_id like ''' + nrp + ''';';
        adoCariFRS.Open;
        // jika mahasiswa tidak sedang mengambil frs maka data mahasiswa dapat dihapus
        if adoCariFRS.RecordCount < 1 then
        begin
          query_delete := 'delete from mhs where nrp like ''' + nrp + ''';';
          deleteCmd := TADOCommand.Create(self);
          deleteCmd.CommandText := query_delete;
          deleteCmd.Connection := ADOConnection1;
          deleteCmd.Execute;
          ReloadDataset;
          deleteCmd.Free;
        end
        else begin
           MessageDlg('Tidak dapat menghapus data. Mahasiswa yang bersangkutan masih mengikuti kuliah',mtConfirmation,[mbOK],0);
        end;
        adoCariFRS.Close;
        adoCariFRS.Free;
      end;
    end;
  end
  else begin
      MessageDlg('Password Tidak Sama',mtConfirmation,[mbOK],0);
  end;
end;

procedure TFrmMahasiswa.mnPengambilanFRSClick(Sender: TObject);
begin
  FrmPengambilanFRS.ShowModal;
end;

procedure TFrmMahasiswa.mnMataKuliahClick(Sender: TObject);
begin
  FormMataKuliah.ShowModal;
end;

procedure TFrmMahasiswa.ReloadDataset;
begin
  ADODataSet1.Close;
  ADODataSet1.CommandText := 'select m.nrp as nrp, m.nama as nama, m.alamat as alamat, d.nama as dosen, p.nama as prodi from mhs m, dosen d, prodi p where m.dosen_wali = d.nip and m.prodi = p.kode_prodi order by m.nrp;';
  ADODataSet1.Open;
end;

procedure TFrmMahasiswa.MnDaftarKelasClick(Sender: TObject);
var
  daftarMhs : TFrmDaftarMhsPerKelas;
begin
  daftarMhs := TFrmDaftarMhsPerKelas.Create(self, self.ADOConnection1);
  daftarMhs.Position := poOwnerFormCenter;
  daftarMhs.ShowModal;
  daftarMhs.Free;
end;

procedure TFrmMahasiswa.ButtonUbahNRPClick(Sender: TObject);
var
  formUbahNRP : TFormUbahNRP;
  nrp : string;
  nama :string;
begin
  nrp := ADODataSet1.FieldValues['nrp'];
  nama := ADODataSet1.FieldValues['nama'];
  try
    formUbahNRP := TFormUbahNRP.Create(self, self.ADOConnection1, nrp, nama );
    if formUbahNRP.ShowModal = mrOk then
    begin
       formUbahNRP.UpdateNRP;
       self.ReloadDataset;
    end;
  finally
    formUbahNRP.Free;
  end;
end;





procedure TFrmMahasiswa.RekapFRSSemuaClick(Sender: TObject);
var
  formRekapFRS : TFormRekapFRSSemua;
begin
  try
    formRekapFRS := TFormRekapFRSSemua.Create(self, self.ADOConnection1);
    formRekapFRS.ShowModal;
  finally
    formRekapFRS.Free
  end;
end;
end.
