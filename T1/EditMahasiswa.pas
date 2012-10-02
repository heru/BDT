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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEditMahasiswa: TfrmEditMahasiswa;

implementation
uses Main;

{$R *.dfm}

{*
  prosedur ini digunakan untuk mengaitkan field-field yang ada di form dengan
  current cursor yang sekarang ditunjukan oleh data source. Atau dengan kata lain
  agar field-field yang ada di form dapat mengenali data baris yang keberapa
  di dalam dataset yang akan di edit.
*}
procedure TfrmEditMahasiswa.FormActivate(Sender: TObject);
begin
  // call close method di AdoDataset
  // untuk refresh content di ADODataSet
  ADODataSet1.Close;
  ADODataSet2.Close;
  DBEdit1.DataSource := FrmMahasiswa.mhsDS;
  DBEdit2.DataSource := FrmMahasiswa.mhsDS;
  DBEdit3.DataField := 'alamat';
  DBEdit3.DataSource := FrmMahasiswa.mhsDS;
  DBLookupComboBox1.DataSource := FrmMahasiswa.mhsDS;
  DBLookupComboBox2.DataSource := FrmMahasiswa.mhsDS;
  // reopen ADODataSet agar content di lookup table bisa di load di dataset
  ADODataSet1.Open;
  ADODataSet2.Open;
end;


procedure TfrmEditMahasiswa.btnEditClick(Sender: TObject);
begin
{*
  update ke database hanya dilakukan ketika dataSource dalam state edit atau insert.
*}
  if FrmMahasiswa.mhsDS.State in [dsEdit, dsInsert] then
    FrmMahasiswa.ADODataSet1.Post;
  Close;
end;

procedure TfrmEditMahasiswa.btnCloseClick(Sender: TObject);
begin
  close;
end;

end.
