unit ListProdi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ExtCtrls, DBCtrls, Grids, DBGrids;

type
  TfrmProgramStudi = class(TForm)
    datasourceProdi: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    datasetProdi: TADODataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProgramStudi: TfrmProgramStudi;

implementation
uses Main;
{$R *.dfm}

end.
