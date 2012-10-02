unit ListDosen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, DB, ADODB;

type
  TfrmDosen = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    datasetDosen: TADODataSet;
    dataSourceDosen: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDosen: TfrmDosen;

implementation
uses Main;
{$R *.dfm}

end.
