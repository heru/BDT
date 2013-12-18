unit NilaiAkademik;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,DB, ADODB, Grids, DBGrids;
type
  TFrmNilaiAkademik = class(TForm)
    txtNama: TEdit;
    Label1: TLabel;
    txtSearchMhs: TEdit;
    btnLookup: TButton;
    txtDosenWali: TEdit;
    Label5: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    txtProdi: TEdit;
    dsLookupMhs: TDataSource;
    adoDatasetLookupMhs: TADODataSet;
    adoQueryFRS: TADODataSet;
    dsQueryFRS: TDataSource;
    DBGrid1: TDBGrid;
    LblJumlahSKS: TLabel;
    LblJumlahMataKuliah: TLabel;
    StringGrid2: TStringGrid;
    procedure btnLookupClick(Sender: TObject);
  private
    { Private declarations }
    DBConnection : TADOConnection;
    lookup_nrp :string;
    mhs_found : Boolean;
    ips : integer;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent; ADOConnection: TADOConnection);
    procedure FillFRS(nrp : string);
    procedure EmptyField();
  end;

var
  FrmNilaiAkademik: TFrmNilaiAkademik;

implementation

uses Main;

{$R *.dfm}

{ TFrmNilaiAkademik }

constructor TFrmNilaiAkademik.Create(AOwner: TComponent;
  ADOConnection: TADOConnection);
begin
  inherited Create(AOwner);
  self.DBConnection := ADOConnection;
end;

procedure TFrmNilaiAkademik.btnLookupClick(Sender: TObject);
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
        // set class variable dengan nrp yang sekarang
        // set flag data mahasiswa ditemukan
        lookup_nrp := nrp;
        mhs_found := True;
        //btnAddMataKuliah.Enabled :=True;
        FillFRS(nrp);
     end
     else
     begin
        //btnAddMataKuliah.Enabled :=False;
        //btnHapusMataKuliah.Enabled :=False;
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

procedure TFrmNilaiAkademik.FillFRS(nrp: string);
var
  query_string:string;
  jumlahMK :Integer;
  row :Integer;
  jumlah :Integer;

  ips : Double;
  sks : integer;
  nilai_angka : integer;

  rowCount:integer;
begin
  query_string := 'select m.kode as kode, m.nama as nama, m.sks as sks, f.nilai_huruf as huruf,f.nilai_angka as angka, f.nilai_x_sks as nilai from mata_kuliah m, pengambilan_frs f where f.mhs_id like ''' + nrp + ''' and f.kode_mata_kuliah = m.kode;';
  adoQueryFRS.Close;
  adoQueryFRS.CommandText := query_string;
  adoQueryFRS.Connection := FrmMahasiswa.ADOConnection1;
  dsQueryFRS.DataSet := adoQueryFRS;
  adoQueryFRS.Open;
  jumlahMK := adoQueryFRS.RecordCount;
  // looping untuk menghitung jumlah mata kuliah
  if jumlahMK > 0 then
  begin
    row :=0;
    jumlah := 0;
    adoQueryFRS.First;
    ips := 0.0;
    while row <jumlahMK do
    begin
      sks :=  adoQueryFRS.FieldValues['sks'];
      if adoQueryFRS.FieldValues['angka'] <> Null then
      begin
        nilai_angka := adoQueryFRS.FieldValues['angka'];
        nilai_angka := sks * nilai_angka;
        ips := ips + nilai_angka;
      end;
      jumlah := jumlah + sks;
      row := row + 1;
      adoQueryFRS.Next;
    end;
    LblJumlahMataKuliah.Caption := 'Jumlah Mata Kuliah :' + IntToStr(jumlahMK);
    LblJumlahSKS.Caption := 'SKS :' + IntToStr(jumlah) + '  IPS :' + FloatToStrF(ips/jumlah, ffFixed, 8, 2);
    //-- kembalikan posisi cursor adoQueryFRS ke awal
    adoQueryFRS.First;

    StringGrid2.RowCount := jumlahMK + 1;
    StringGrid2.Cells[0,0] := 'Kode';
    StringGrid2.Cells[1,0] := 'Nama';
    StringGrid2.Cells[2,0] := 'SKS';
    StringGrid2.Cells[3,0] := 'Huruf';
    StringGrid2.Cells[4,0] := 'Angka';
    StringGrid2.Cells[5,0] := 'Nilai';

    rowCount := 1;
    adoQueryFRS.First;
    while rowCount <= adoQueryFRS.RecordCount do
    begin
      StringGrid2.Cells[0,rowCount] := adoQueryFRS.FieldValues['kode'];
      StringGrid2.Cells[1,rowCount] := adoQueryFRS.FieldValues['nama'];
      StringGrid2.Cells[2,rowCount] := adoQueryFRS.FieldValues['sks'];
      if adoQueryFRS.FieldValues['huruf'] <> Null then
      begin
        StringGrid2.Cells[3,rowCount] := adoQueryFRS.FieldValues['huruf'];
      end
      else
      begin
        StringGrid2.Cells[3,rowCount] := ' ';
      end;
      if adoQueryFRS.FieldValues['angka'] <> Null then
      begin
        StringGrid2.Cells[4,rowCount] := adoQueryFRS.FieldValues['angka'];
      end
      else
      begin
        StringGrid2.Cells[4,rowCount] := ' ';
      end;

      if adoQueryFRS.FieldValues['angka'] <> Null then
      begin
        StringGrid2.Cells[5,rowCount] := adoQueryFRS.FieldValues['sks'] * adoQueryFRS.FieldValues['angka'];
      end
      else
      begin
        StringGrid2.Cells[5,rowCount] := ' ';
      end;
      rowCount := rowCount + 1;
      adoQueryFRS.Next;
    end;
  end
  else
  begin
    LblJumlahMataKuliah.Caption:='Jumlah Mata Kuliah :0';
    LblJumlahSKS.Caption := 'SKS :0';
  end;
end;

procedure TFrmNilaiAkademik.EmptyField;
begin
  txtSearchMhs.Text := '';
  txtNama.Text := '';
  txtDosenWali.Text := '';
  txtProdi.Text := '';
  mhs_found := False;
  lookup_nrp :='';
  FillFRS(lookup_nrp);
end;

end.
