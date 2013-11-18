unit UnitRekapFRSSemua;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,DB, ADODB, Grids;

type
  TFormRekapFRSSemua = class(TForm)
    StringGrid1: TStringGrid;
    lblTotal: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    StringGrid2: TStringGrid;
  private
    { Private declarations }
    DBConnection:TADOConnection;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent; ADOConnection: TADOConnection);
    procedure rekap;
    procedure RekapMataKuliah;
    procedure hitung_sks(nrp:string; row :Integer; adoFRS:TADODataSet);
    procedure hitung_mhs(kodemk:string; row:Integer; sks:Integer; adoFRS:TADODataSet);
  end;

  RekapFRS = class(TObject)
  private
    total_mk : integer;
    total_sks : integer;
    nrp : string;
  public
    constructor Create(nrp:string);
    procedure Hitung(adoConnection:TADOConnection);
    procedure HitungRataRata();
    procedure HandleException;
  end;

var
  FormRekapFRSSemua: TFormRekapFRSSemua;

implementation

{$R *.dfm}

{ TFormRekapFRSSemua }

constructor TFormRekapFRSSemua.Create(AOwner: TComponent;
  ADOConnection: TADOConnection);
begin
  inherited Create(AOwner);
  self.DBConnection := ADOConnection;
  StringGrid1.RowCount := 20;
  self.rekap;
  self.RekapMataKuliah;
end;

procedure RekapFRS.HitungRataRata;
begin

end;

procedure TFormRekapFRSSemua.rekap;
var
  adodsMhs : TADODataSet;
  adoFRS : TADODataSet;
  queryString : string;
  total_mhs : Integer;
  row : Integer;
  rekapPerMhs : RekapFRS;
  current_nrp : string;
  ratarata :Extended;
  totalmatakuliah, totalsks : Integer;
begin
  adodsMhs := TADODataSet.Create(self);
  adodsMhs.Connection := self.DBConnection;
  adodsMhs.CommandText := 'select nrp, nama from mhs order by nrp';
  adodsMhs.Open;

  adoFRS := TADODataSet.Create(self);
  adoFRS.Connection := self.DBConnection;
 
  row := 1;
  total_mhs := adodsMhs.RecordCount;
  StringGrid1.RowCount := total_mhs + 1;
  StringGrid1.Cells[0,0] := 'No';
  StringGrid1.Cells[1,0] := 'NRP';
  StringGrid1.Cells[2,0] := 'Nama';
  StringGrid1.Cells[3,0] := 'Total MK';
  StringGrid1.Cells[4,0] := 'Total SKS';
  StringGrid1.Cells[5,0] := '(Total MK/SKS)';


  adodsMhs.First;

  while row <= total_mhs do
  begin
    StringGrid1.Cells[0,row] := IntToStr(row);
    current_nrp :=adodsMhs.FieldValues['nrp'];
    StringGrid1.Cells[1,row] := current_nrp;
    StringGrid1.Cells[2,row] := adodsMhs.FieldValues['nama'];

    self.hitung_sks(current_nrp, row, adoFRS);
    try
      totalmatakuliah := StrToInt(StringGrid1.Cells[3,row]);
      totalsks := StrToInt(StringGrid1.Cells[4,row]);
      if totalsks = 0 then
      begin
          StringGrid1.Cells[5, row]:= '0' ;
      end
      else
      begin
          ratarata := totalmatakuliah/totalsks;
          StringGrid1.Cells[5, row] :=  FloatToStr(ratarata);
      end;
    except
      on E: Exception do
      self.HandleCreateException;
    end;

    adodsMhs.Next;
    row := row +1;
  end;
  adodsMhs.Close;
  adodsMhs.Free;
  // Hitung rata-rata
  
end;



procedure TFormRekapFRSSemua.hitung_sks(nrp: string; row :Integer; adoFRS:TADODataSet);
var querystring :string;
    total_mk, total_sks, current_row : Integer;
begin
  querystring := 'select m.kode as kode, m.nama as nama, m.sks as sks from mata_kuliah m, pengambilan_frs f where f.mhs_id like ''' + nrp + ''' and f.kode_mata_kuliah = m.kode;';
  adoFRS.Close;
  adoFRS.CommandText := querystring;
  adoFRS.Open;
  total_mk := adoFRS.RecordCount;

  total_sks := 0;
  current_row := 0;
  adoFRS.First;
  while current_row < total_mk do
  begin
    total_sks := total_sks + adoFRS.FieldValues['sks'];

    current_row := current_row + 1;
    adoFRS.Next;
  end;
  adoFRS.Close;

  StringGrid1.Cells[3, row] := IntToStr(total_mk);
  StringGrid1.Cells[4,row] := IntToStr( total_sks);
end;
procedure TFormRekapFRSSemua.RekapMataKuliah;
var querystring:string;
  adoMK, adoFRS : TADODataSet;
  row : integer;
begin
   
   adoMK := TADODataSet.Create(self);
   adoMK.Connection := self.DBConnection;
   adoMK.CommandText :='select kode, nama, sks from mata_kuliah';
   adoMK.Open;

   adoFRS := TADODataSet.Create(self);
    adoFRS.Connection := self.DBConnection;

    row := 1;
    StringGrid2.RowCount := adoMK.RecordCount + 1;
    StringGrid2.ColCount := 6;
    StringGrid2.Cells[0,0] := 'No';
  StringGrid2.Cells[1,0] := 'Kode';
  StringGrid2.Cells[2,0] := 'Nama';
  StringGrid2.Cells[3,0] := 'SKS';
  StringGrid2.Cells[4,0] := 'Total Mahasiswa';
  StringGrid2.Cells[5,0] := '(MHS/SKS)';
  


  adoMK.First;
  while row < adoMK.RecordCount do
  begin
       StringGrid2.Cells[0, row] := IntToStr(row);
       StringGrid2.Cells[1, row] := adoMK.FieldValues['kode'];
       StringGrid2.Cells[2,row] := adoMK.FieldValues['nama'];
       StringGrid2.Cells[3, row] := adoMK.FieldValues['sks'];
       self.hitung_mhs(adoMK.FieldValues['kode'], row, adoMK.FieldValues['sks'], adoFRS);
       row := row + 1;
       adoMK.Next;
  end;
end;

procedure TFormRekapFRSSemua.hitung_mhs(kodemk: string; row: Integer; sks:Integer ;
  adoFRS: TADODataSet);
var
  querystring:string;
  total_mhs : integer;
begin
  adoFRS.Close;
  querystring := 'select id, mhs_id  from pengambilan_frs where  kode_mata_kuliah = ''' + kodemk + ''';';
  adoFRS.CommandText := querystring;
  adoFRS.Open;

  total_mhs := adoFRS.RecordCount;
  StringGrid2.Cells[4,row]:=IntToStr(total_mhs);
  StringGrid2.Cells[5,row]:= FloatToStr(total_mhs/sks);
end;

{ RekapFRS }

constructor RekapFRS.Create(nrp: string);
begin
  self.nrp := nrp;
end;

procedure RekapFRS.Hitung(adoConnection:TADOConnection);
var queryFRS : TADODataSet;
begin
  //queryFRS := TADODataSet.Create(self);
end;


procedure RekapFRS.HandleException;
begin

end;

end.
