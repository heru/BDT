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
    procedure btnEditClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure mnExitClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure mnDosenClick(Sender: TObject);
    procedure mnProgramStudiClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure mnPengambilanFRSClick(Sender: TObject);
    procedure mnMataKuliahClick(Sender: TObject);
  private
    { Private  }
  public
    { Public declarations }
    procedure ReloadDataset;
  end;

var
  FrmMahasiswa: TFrmMahasiswa;
 

implementation

uses EditMahasiswa,AddMahasiswa, ListDosen, ListProdi, PengambilanFRS, MataKuliah;

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
begin
    if Self.txtEdit.Text <> '' then
    begin
      query_select := 'select m.nrp as nrp, m.nama as nama, m.alamat as alamat, d.nama as dosen, p.nama as prodi from mhs m, dosen d, prodi p where m.nrp like ''%' + txtEdit.Text + '%'' and m.dosen_wali = d.nip and m.prodi = p.kode_prodi order by m.nrp;';
      ADODataSet1.Close;
      ADODataSet1.CommandText := query_select;
    end
    else
    begin
      ADODataSet1.Close;
      ADODataSet1.CommandText := 'select m.nrp as nrp, m.nama as nama, m.alamat as alamat, d.nama as dosen, p.nama as prodi from mhs m, dosen d, prodi p where m.dosen_wali = d.nip and m.prodi = p.kode_prodi order by m.nrp;';
      //ADODataSet1.CommandText := 'select m.nrp as nrp, m.nama as nama, m.alamat as alamat, m.dosen_wali as dosen_wali, m.prodi as prodi, d.nama as nama_dosen, p.nama as nama_prodi from mhs m, dosen d, prodi p where m.dosen_wali = d.nip and m.prodi = p.kode_prodi;'
    end;
    ADODataSet1.Open;
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
    nrp, query_delete :string;
begin
  if MessageDlg('Hapus data ini ?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    nrp := ADODataSet1.FieldValues['nrp'];
    if nrp <> '' then
    begin
      query_delete := 'delete from mhs where nrp like ''' + nrp + ''';';
      deleteCmd := TADOCommand.Create(self);
      deleteCmd.CommandText := query_delete;
      deleteCmd.Connection := ADOConnection1;
      deleteCmd.Execute;
      ReloadDataset;
      deleteCmd.Free;
    end;
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

end.
