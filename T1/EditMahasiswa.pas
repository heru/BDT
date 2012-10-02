unit EditMahasiswa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, DB, ADODB, Buttons;

type
  TfrmEditMahasiswa = class(TForm)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    btnEdit: TButton;
    DBEdit3: TDBEdit;
    DBLookupComboBox2: TDBLookupComboBox;
    DataSource2: TDataSource;
    ADODataSet2: TADODataSet;
    btnClose: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;

    procedure FormActivate(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    current_nrp: string;
    editMhsDataSource : TDataSource;
    editMhsDataSet : TADODataSet;
    procedure BeforeClose;
  public
    { Public declarations }
    procedure SetCurrentNRP(nrp:string);
  end;

var
  frmEditMahasiswa: TfrmEditMahasiswa;

implementation
uses Main;

{$R *.dfm}
procedure TfrmEditMahasiswa.FormCreate(Sender: TObject);
begin
  // initialize variable
  editMhsDataSet := TADODataSet.Create(self);
  editMhsDataSet.Connection := FrmMahasiswa.ADOConnection1;
  editMhsDataSource := TDataSource.Create(self);
  editMhsDataSource.DataSet := editMhsDataSet;
  editMhsDataSet.Close;
end;

{*
  prosedur ini digunakan untuk mengaitkan field-field yang ada di form dengan
  current cursor yang sekarang ditunjukan oleh data source. Atau dengan kata lain
  agar field-field yang ada di form dapat mengenali data baris yang keberapa
  di dalam dataset yang akan di edit.
*}
procedure TfrmEditMahasiswa.FormActivate(Sender: TObject);
begin
  editMhsDataSet.CommandText :=
    'select * from mhs where nrp like ''' + current_nrp + ''';';
  editMhsDataSet.Open;
  // call close method di AdoDataset
  // untuk refresh content di ADODataSet
  ADODataSet1.Close;
  ADODataSet2.Close;
  DBEdit1.DataSource := editMhsDataSource;
  DBEdit2.DataSource := editMhsDataSource;
  DBEdit3.DataField := 'alamat';
  DBEdit3.DataSource := editMhsDataSource;
  DBLookupComboBox1.DataSource := editMhsDataSource;
  DBLookupComboBox1.DataField := 'dosen_wali';
  DBLookupComboBox2.DataSource := editMhsDataSource;
  DBLookupComboBox2.DataField := 'prodi';
  // reopen ADODataSet agar content di lookup table bisa di load di dataset
  ADODataSet1.Open;
  ADODataSet2.Open;
end;


procedure TfrmEditMahasiswa.btnEditClick(Sender: TObject);
begin
{*
  update ke database hanya dilakukan ketika dataSource dalam state edit atau insert.
*}
  if editMhsDataSource.State in [dsEdit, dsInsert] then
    editMhsDataSet.Post;

  BeforeClose;
  Close;
end;

procedure TfrmEditMahasiswa.btnCloseClick(Sender: TObject);
begin
  BeforeClose;
  close;
end;

procedure TfrmEditMahasiswa.SetCurrentNRP(nrp: string);
begin
  current_nrp := nrp;
end;

{*
sebelum form EditMahasiswa di close, terlebih dahulu
tutup editMahasiswaDataset agar bisa gunakan untuk edit data yang lainnya.
dan reload dataset agar Grid di FrmMahasiswa dapat menampilkan perbaruan data
yang baru saja diubah.
*}
procedure TfrmEditMahasiswa.BeforeClose;
begin
  editMhsDataSet.Close;
  // refresh dataset mahasiswa
  FrmMahasiswa.ReloadDataset;
end;

end.
