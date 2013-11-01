unit UnitRekapFRSSemua;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,DB, ADODB, Grids;

type
  TFormRekapFRSSemua = class(TForm)
    StringGrid1: TStringGrid;
  private
    { Private declarations }
    DBConnection:TADOConnection;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent; ADOConnection: TADOConnection);
    procedure rekap;
    procedure hitung_sks(nrp:string; row :Integer; adoFRS:TADODataSet);
  end;

  RekapFRS = class(TObject)
  private
    total_mk : integer;
    total_sks : integer;
    nrp : string;
  public
    constructor Create(nrp:string);
    procedure Hitung(adoConnection:TADOConnection);
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

  adodsMhs.First;

  while row <= total_mhs do
  begin
    StringGrid1.Cells[0,row] := IntToStr(row);
    current_nrp :=adodsMhs.FieldValues['nrp'];
    StringGrid1.Cells[1,row] := current_nrp;
    StringGrid1.Cells[2,row] := adodsMhs.FieldValues['nama'];

    self.hitung_sks(current_nrp, row, adoFRS);

    adodsMhs.Next;
    row := row +1;
  end;
  adodsMhs.Close;
  adodsMhs.Free;
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

end.
