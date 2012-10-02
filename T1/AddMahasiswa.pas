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
var adoCmd : TADOCommand;
    query_insert : string;
begin
  if Edit1.Text <> '' then
  begin
    query_insert := 'insert into mhs(nrp, nama, alamat, dosen_wali, prodi) values(''' + Edit1.Text + ''', ''' + Edit2.Text + ''', ''' + Edit3.Text + ''', ''' + dbLookupDosen.KeyValue + ''', ''' + dblookupProdi.KeyValue + ''');';

    adoCmd := TADOCommand.Create(self);
    adoCmd.Connection := FrmMahasiswa.ADOConnection1;
    adoCmd.CommandType := cmdText;
    adoCmd.CommandText := query_insert;
    adoCmd.Execute;
    // refresh grid di FrmMahasiswa
    FrmMahasiswa.ReloadDataset;
    adoCmd.Free;
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

  dbLookupDosen.DataField := 'dosen_wali';

  datasetDosen.Open;

  dblookupProdi.DataField := 'prodi';
  datasetProdi.Open;
end;

end.
