unit pesqcliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  Buttons, DBGrids, StdCtrls, dtModulopas;

type

  { TpesqClienteF }

  TpesqClienteF = class(TForm)
    btnPesquisar: TBitBtn;
    ComboBox1: TComboBox;
    dsPesqCli: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Panel1: TPanel;
    procedure btnPesquisarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private

  public

  end;

var
  pesqClienteF: TpesqClienteF;

implementation

uses
  orcamento;

{$R *.lfm}

{ TpesqClienteF }

procedure TpesqClienteF.DBGrid1DblClick(Sender: TObject);
begin
  DataModule1.qryOrcamentoclienteid.AsInteger:= DataModule1.qryClienteclienteid.AsInteger;
  cadOrcamentoF.Label5.Caption := DataModule1.qryClientenome_cliente.AsString;
  close;
end;

procedure TpesqClienteF.btnPesquisarClick(Sender: TObject);
var
  AuxWhere: String;
begin
  if ComboBox1.Text = 'Id'then //Identifica o tipo de pesquisa
    begin
       if Edit1.Text = '' then//verifica se o campo ta vazio
          AuxWhere := '1 = 1'
       else
           AuxWhere := 'clienteid = '+Edit1.Text;//atribui o valor se n estiver vazio
    end;
  if ComboBox1.Text = 'Nome Cli'then
    begin
       if Edit1.Text = '' then
          AuxWhere := '1 = 1'
       else
           AuxWhere := 'nome_cliente = '+QuotedStr(Edit1.Text);
    end;
  if ComboBox1.Text = ''then
    begin
       if Edit1.Text = '' then
          AuxWhere := '1 = 1'
       else
           AuxWhere := 'nome_cliente = '+QuotedStr(Edit1.Text);
    end;
  DataModule1.qryCliente.Close;
  DataModule1.qryCliente.SQL.Clear;
  DataModule1.qryCliente.SQL.Text :=

  'select   '+
            'clienteid,  '+
            'nome_cliente,   '+
            'tipo_cliente,  '+
            'cpf_cnpj_cliente	'+
            'from cliente '+
            'WHERE '+AuxWhere+
            'ORDER BY clienteid';
  DataModule1.qryCliente.Open;
end;

end.

