program T1;

uses
  Forms,
  Main in 'Main.pas' {FrmMahasiswa},
  EditMahasiswa in 'EditMahasiswa.pas' {frmEditMahasiswa},
  AddMahasiswa in 'AddMahasiswa.pas' {FrmTambahMahasiswa},
  ListDosen in 'ListDosen.pas' {frmDosen},
  ListProdi in 'ListProdi.pas' {frmProgramStudi},
  PengambilanFRS in 'PengambilanFRS.pas' {FrmPengambilanFRS},
  MataKuliah in 'MataKuliah.pas' {FormMataKuliah};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMahasiswa, FrmMahasiswa);
  Application.CreateForm(TfrmEditMahasiswa, frmEditMahasiswa);
  Application.CreateForm(TFrmTambahMahasiswa, FrmTambahMahasiswa);
  Application.CreateForm(TfrmDosen, frmDosen);
  Application.CreateForm(TfrmProgramStudi, frmProgramStudi);
  Application.CreateForm(TFrmPengambilanFRS, FrmPengambilanFRS);
  Application.CreateForm(TFormMataKuliah, FormMataKuliah);
  Application.Run;
  end.
