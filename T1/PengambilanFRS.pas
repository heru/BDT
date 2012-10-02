unit PengambilanFRS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DBCtrls, DB, ADODB, ExtCtrls;

type
  TFrmPengambilanFRS = class(TForm)
    DBGrid1: TDBGrid;
    btnLookup: TButton;
    txtSearchMhs: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    txtNama: TEdit;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    dbLookupComboMataKuliah: TDBLookupComboBox;
    btnAddMataKuliah: TButton;
    dsMataKuliah: TDataSource;
    adoDSMataKuliah: TADODataSet;
    dsPengambilanFRS: TDataSource;
    dsLookupMhs: TDataSource;
    adoDatasetLookupMhs: TADODataSet;
    Label5: TLabel;
    txtDosenWali: TEdit;
    adoQueryFRS: TADODataSet;
    Label6: TLabel;
    txtProdi: TEdit;
    dbNavMataKuliah: TDBNavigator;
    btnHapusMataKuliah: TButton;
    procedure btnLookupClick(Sender: TObject);
    procedure btnAddMataKuliahClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure adoQueryFRSAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    lookup_nrp :string;
    mhs_found : Boolean;
  public
    { Public declarations }
    procedure FillFRS(nrp : string);
    function IsMataKuliahExist(nrp:string; mata_kuliah:string):Boolean;
    procedure EmptyField();
  end;

var
  FrmPengambilanFRS: TFrmPengambilanFRS;

implementation
uses main;
{$R *.dfm}

procedure TFrmPengambilanFRS.btnLookupClick(Sender: TObject);
var
  nrp : string;
  query_string:string;
  nama_mhs :string;
begin
  // TODO:
  // 1. mencari data mahasiswa dulu
  // query: 'select nrp from mhs where nrp like 'xx'
  // 2. menampilkan daftar mata kuliah yang diambil oleh Mhs tersebut

  nrp:=txtSearchMhs.Text;
  EmptyField;
  txtSearchMhs.Text := nrp;
  if nrp <> '' then
  begin
     nrp := txtSearchMhs.Text;
     query_string:='select m.nama as nama_mhs, d.nama as nama_dosen,p.nama as nama_prodi from mhs m, dosen d, prodi p where m.nrp like ''' + nrp + ''' and m.dosen_wali = d.nip and m.prodi = p.kode_prodi ;';
     adoDatasetLookupMhs.Close;
     adoDatasetLookupMhs.CommandText := query_string;
     adoDatasetLookupMhs.Open;
     if adoDatasetLookupMhs.RecordCount > 0 then
     begin
        adoDatasetLookupMhs.First;
        nama_mhs := adoDatasetLookupMhs.FieldValues['nama_mhs'];
        txtNama.Text := nama_mhs;
        txtDosenWali.Text := adoDatasetLookupMhs.FieldValues['nama_dosen'];
        txtProdi.Text := adoDatasetLookupMhs.FieldValues['nama_prodi'];
        lookup_nrp := nrp;
        mhs_found := True;
        btnAddMataKuliah.Enabled :=True;
        FillFRS(nrp);
     end
     else
     begin
        btnAddMataKuliah.Enabled :=False;
        btnHapusMataKuliah.Enabled :=False;
        Application.MessageBox('data mahasiswa dengan NRP tersebut tidak ditemukan','Konfirmasi',MB_OK);
        txtSearchMhs.SetFocus;
     end;
  end
  else
  begin
    Application.MessageBox('NRP mahasiswa harus di isi','Konfirmasi',MB_OK);
    txtSearchMhs.SetFocus;
  end;
end;

procedure TFrmPengambilanFRS.FillFRS(nrp: string);
var
  query_string:string;
begin
  query_string := 'select m.kode as kode, m.nama as nama, m.sks as sks from mata_kuliah m, pengambilan_frs f where f.mhs_id like ''' + nrp + ''' and f.kode_mata_kuliah = m.kode;';
  adoQueryFRS.Close;
  adoQueryFRS.CommandText := query_string;
  adoQueryFRS.Connection := FrmMahasiswa.ADOConnection1;
  dsMataKuliah.DataSet := adoQueryFRS;
  adoQueryFRS.Open;
end;

procedure TFrmPengambilanFRS.btnAddMataKuliahClick(Sender: TObject);
var
  kode_mata_kuliah : string;
  nama_mata_kuliah :string;
  query_insert:string;
  adoInsert : TADOCommand;
  found:Boolean;
  msg:string;
begin

  if dbLookupComboMataKuliah.KeyValue <> Null then
  begin
    kode_mata_kuliah := dbLookupComboMataKuliah.KeyValue;
    nama_mata_kuliah := dbLookupComboMataKuliah.Text;
    // check apakah mata kuliah yang akan diambil sudah ada atau belum
    found := IsMataKuliahExist(lookup_nrp,kode_mata_kuliah);
    // jika belum diambil maka mata kuliah tersebut bisa di ambil
    if mhs_found and found = False then
    begin
      query_insert := 'insert into pengambilan_frs(mhs_id, kode_mata_kuliah) values (''' + lookup_nrp + ''', ''' + kode_mata_kuliah + ''')';
      adoInsert := TADOCommand.Create(self);
      adoInsert.CommandText := query_insert;
      adoInsert.Connection := FrmMahasiswa.ADOConnection1;
      adoInsert.CommandType := cmdText;
      adoInsert.Execute;
      adoInsert.Free;
      FillFRS(lookup_nrp);
    end
    else
    begin
      msg := 'Mata Kuliah ' + nama_mata_kuliah + ' sudah diambil';
      dbLookupComboMataKuliah.SetFocus;
      MessageDlg(msg, mtInformation, [mbOK],0)
    end;
  end
  else
  begin
      msg := 'Pilih Mata Kuliah dari daftar yang tersedia ';
      MessageDlg(msg, mtInformation, [mbOK],0)
  end;
end;

function TFrmPengambilanFRS.IsMataKuliahExist(nrp,
  mata_kuliah: string): Boolean;
var
  query_search:string;
  found : Integer;
  dataset : TADODataSet;
begin   
  query_search := 'select * from pengambilan_frs where mhs_id like ''' + nrp + ''' and kode_mata_kuliah like ''' + mata_kuliah + ''';';
  dataset := TADODataSet.Create(self);
  dataset.Close;
  dataset.Connection := FrmMahasiswa.ADOConnection1;
  dataset.CommandText := query_search;
  dataset.CommandType := cmdText;
  //dataset.Active:=true;
  dataset.Open;
  dataset.First;
  found := dataset.RecordCount;
  dataset.Close;
  dataset.Free;
  if found > 0 then
    Result := True
  else
    Result := False
  
end;

procedure TFrmPengambilanFRS.FormActivate(Sender: TObject);
begin
  EmptyField();
  txtSearchMhs.SetFocus;
end;

procedure TFrmPengambilanFRS.EmptyField;
begin
  txtSearchMhs.Text := '';
  txtNama.Text := '';
  txtDosenWali.Text := '';
  txtProdi.Text := '';
  mhs_found := False;
  lookup_nrp :='';
  FillFRS(lookup_nrp);
end;


procedure TFrmPengambilanFRS.adoQueryFRSAfterOpen(DataSet: TDataSet);
begin
  if adoQueryFRS.RecordCount > 0 then
    btnHapusMataKuliah.Enabled := True
  else
    btnHapusMataKuliah.Enabled := False
end;

end.
