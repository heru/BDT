unit AddMahasiswa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Main, DB, ADODB, DBCtrls;

type
  TFrmTambahMahasiswa = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    dbLookupDosen: TDBLookupComboBox;
    dblookupProdi: TDBLookupComboBox;
    datasourceDosen: TDataSource;
    datasetDosen: TADODataSet;
    datasetProdi: TADODataSet;
    dataSourceProdi: TDataSource;
    btnSimpan: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnCancel: TButton;
    procedure btnSimpanClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTambahMahasiswa: TFrmTambahMahasiswa;

implementation

{$R *.dfm}

procedure TFrmTambahMahasiswa.btnSimpanClick(Sender: TObject);
begin
  if Edit1.Text <> '' then
  begin
        FrmMahasiswa.ADODataSet1.Append;
        FrmMahasiswa.ADODataSet1.FieldValues['nrp'] := Edit1.Text;
        FrmMahasiswa.ADODataSet1.FieldValues['nama'] := Edit2.Text;
        FrmMahasiswa.ADODataSet1.FieldValues['alamat'] := Edit3.Text;
        FrmMahasiswa.ADODataSet1.FieldValues['dosen_wali'] := dbLookupDosen.KeyValue;
        FrmMahasiswa.ADODataSet1.FieldValues['prodi'] := dblookupProdi.KeyValue;
        FrmMahasiswa.ADODataSet1.Post;
        close ;
  end
  else
  begin
    Application.MessageBox('NRP mahasiswa harus di isi','Konfirmasi',MB_OK);
    Edit1.SetFocus;
  end;
end;

procedure TFrmTambahMahasiswa.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmTambahMahasiswa.FormActivate(Sender: TObject);
begin
  datasetDosen.Close;
  datasetProdi.Close;

  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  datasetDosen.Open;
  datasetProdi.Open;
end;

end.
