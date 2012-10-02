unit MataKuliah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DBCtrls, DB, ADODB;

type
  TFormMataKuliah = class(TForm)
    dbgridMataKuliah: TDBGrid;
    dbNavMataKuliah: TDBNavigator;
    adoDSMataKuliah: TADODataSet;
    dsMataKuliah: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMataKuliah: TFormMataKuliah;

implementation
uses main;
{$R *.dfm}

end.
