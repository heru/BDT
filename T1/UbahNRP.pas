unit UbahNRP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,DB, ADODB;

type
  TFormUbahNRP = class(TForm)
    EditNRPLama: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditNama: TEdit;
    Label3: TLabel;
    EditNRPBaru: TEdit;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    procedure EditNRPLamaKeyPress(Sender: TObject; var Key: Char);
    procedure EditNRPBaruKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
  private
    { Private declarations }
    DBConnection:TADOConnection;
    CurrentNRP : string;
    Mahasiswa : string;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent; ADOConnection: TADOConnection; NRP:string; Nama:string);
    procedure UpdateNRP;
  end;

var
  FormUbahNRP: TFormUbahNRP;

implementation

{$R *.dfm}

{ TFormUbahNRP }

constructor TFormUbahNRP.Create(AOwner: TComponent;
  ADOConnection: TADOConnection; NRP: string; Nama:string);
begin
  inherited Create(AOwner);
  self.DBConnection := ADOConnection;
  self.CurrentNRP := NRP;
  self.EditNRPLama.Text := self.CurrentNRP;
  self.EditNRPLama.Enabled := false;
  self.Mahasiswa := Nama;
  self.EditNama.Text := self.Mahasiswa;
  self.EditNama.Enabled := false;
end;
// update nrp di table mahasiswa dan pengambilan FRS
procedure TFormUbahNRP.UpdateNRP;
var CmdUpdate : TADOCommand;
    query : string;
    CmdUpdateFRS : TADOCommand;
begin
   // update mahasiswa
   query := 'update mhs set nrp = ''' + EditNRPBaru.Text + ''' where nrp like ''' + EditNRPLama.Text + ''';';
   CmdUpdate := TADOCommand.Create(self);
   CmdUpdate.Connection := self.DBConnection;
   CmdUpdate.CommandText := query;
   CmdUpdate.Execute;

   // update nrp di table pengambilan FRS
   query := 'update pengambilan_frs set mhs_id = ''' + EditNRPBaru.Text + ''' where mhs_id like ''' + EditNRPLama.Text + ''';';
   CmdUpdateFRS := TADOCommand.Create(self);
   CmdUpdateFRS.Connection := self.DBConnection;
   CmdUpdateFRS.CommandText := query;
   CmdUpdateFRS.Execute;
end;

procedure TFormUbahNRP.EditNRPLamaKeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in [#8, '0'..'9', '-', DecimalSeparator]) then
  begin
    Key := #0;
  end
  else if ((Key = DecimalSeparator) or (Key = '-')) and (Pos(Key, (Sender as TEdit).Text) > 0) then
  begin
    Key := #0;
  end
  else if (Key = '-') and ((Sender as TEdit).SelStart <> 0) then
  begin
    Key := #0;
  end;
end;

procedure TFormUbahNRP.EditNRPBaruKeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in [#8, '0'..'9', '-', DecimalSeparator]) then
  begin
    Key := #0;
  end
  else if ((Key = DecimalSeparator) or (Key = '-')) and (Pos(Key, (Sender as TEdit).Text) > 0) then
  begin
    Key := #0;
  end
  else if (Key = '-') and ((Sender as TEdit).SelStart <> 0) then
  begin
    Key := #0;
  end;

end;

procedure TFormUbahNRP.ButtonSaveClick(Sender: TObject);
begin
  if Length( EditNRPBaru.Text ) < 13 then
  begin
    ModalResult := mrOk;
  end
  else
  begin
    MessageDlg('Panjang NRP melebihi 12 ?', mtConfirmation, [mbYes, mbNo],0)
  end;
end;

procedure TFormUbahNRP.ButtonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
