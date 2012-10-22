unit DaftarMahasiswaPerKelas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ADODB, DBCtrls, StdCtrls, RpDefine, RpCon,
  RpConDS, RpRave, RpConBDE;

type
  TFrmDaftarMhsPerKelas = class(TForm)
    Label1: TLabel;
    DBLookupMK: TDBLookupComboBox;
    DataSourceLookupMK: TDataSource;
    ADODataSetLookupMK: TADODataSet;
    DBGridMHS: TDBGrid;
    DataSourceMHS: TDataSource;
    ADODataSetMHS: TADODataSet;
    BtnLookup: TButton;
    BtnCetak: TButton;
    RvDSConnection: TRvDataSetConnection;
    RvProject1: TRvProject;
    ADODataSet1: TADODataSet;
    RvQueryConnection1: TRvQueryConnection;
    procedure BtnLookupClick(Sender: TObject);
    procedure BtnCetakClick(Sender: TObject);
  private
    { Private declarations }
    ADOConnection:TADOConnection;
    current_query : string;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent; DB:TADOConnection);
  end;

var
  FrmDaftarMhsPerKelas: TFrmDaftarMhsPerKelas;

implementation

{$R *.dfm}

{ TFrmDaftarMhsPerKelas }


{ TFrmDaftarMhsPerKelas }

constructor TFrmDaftarMhsPerKelas.Create(AOwner: TComponent;
  DB: TADOConnection);
begin
  inherited Create(AOwner);
  self.ADOConnection := DB;
  // setup DBLookupCombo
  DBLookupMK.ListField := 'nama'; // yang tampil di form
  DBLookupMK.KeyField := 'kode';  // kode yang dijadikan referensi
  ADODataSetLookupMK.Connection := self.ADOConnection;
  ADODataSetLookupMK.CommandText := 'select kode, nama from mata_kuliah';
  ADODataSetLookupMK.Active:=true;

  // setup ADODataSetMHS
  ADODataSetMHS.Connection := self.ADOConnection;
  ADODataSetMHS.Close;
end;

{*
Digunakan untuk menampilkan daftar mahasiswa yang mengambil mata kuliah tertentu
Kuncinya ada di:
1. Kode mata kuliah: diperoleh dari DBLookupMK (lihat inisialisasi DBLookupMK di FormCreate)
2. Query pencarian daftar mata kuliah, jika nama kolom tidak sama dengan struktur table, ubahlah agar sesuai
*}
procedure TFrmDaftarMhsPerKelas.BtnLookupClick(Sender: TObject);
var id:string; // untuk menampung kode mata kuliah
    query:string; // untuk mendefinisikan query string
begin
  if DBLookupMK.KeyValue <> null  then
  begin
    id := DBLookupMK.KeyValue;
    query:='SELECT m.nrp, m.nama AS nama, m.alamat, p.nama AS prodi FROM mhs AS m, mata_kuliah AS k, pengambilan_frs AS f, prodi AS p WHERE f.mhs_id=m.nrp And f.kode_mata_kuliah=k.kode And m.prodi=p.kode_prodi And k.kode Like ''' + id + ''';';
    current_query := query;
    // tutup dulu ADODataSet, kmd set dengan CommandText/query yang baru
    ADODataSetMHS.Close;
    ADODataSetMHS.CommandText := query;
    ADODataSetMHS.Open;
  end;
end;

procedure TFrmDaftarMhsPerKelas.BtnCetakClick(Sender: TObject);
begin
  ADODataSet1.Close;
  ADODataSet1.CommandText:=current_query;
  ADODataSet1.Open;
  RvProject1.Execute;
end;

end.
