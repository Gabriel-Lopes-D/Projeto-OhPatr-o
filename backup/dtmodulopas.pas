unit dtModulopas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset, ZSqlUpdate,IniFiles,Forms, Dialogs;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    qryClienteclienteid: TLongintField;
    qryClientecpf_cnpj_cliente: TStringField;
    qryClientenome_cliente: TStringField;
    qryClientetipo_cliente: TStringField;
    qryOrcamentoclienteid: TLongintField;
    qryOrcamentodt_orcamento: TDateTimeField;
    qryOrcamentodt_validade_orcamento: TDateTimeField;
    qryOrcamentoorcamentoid: TLongintField;
    qryOrcamentovl_total_orcamento: TFloatField;
    qryOrc_itensorcamentoid: TLongintField;
    qryOrc_itensorcamentoid1: TLongintField;
    qryOrc_itensorcamentoitemid: TLongintField;
    qryOrc_itensorcamentoitemid1: TLongintField;
    qryOrc_itensprodutodesc: TStringField;
    qryOrc_itensprodutodesc1: TStringField;
    qryOrc_itensprodutoid: TLongintField;
    qryOrc_itensprodutoid1: TLongintField;
    qryOrc_itensqt_produto: TFloatField;
    qryOrc_itensqt_produto1: TFloatField;
    qryOrc_itensvl_total: TFloatField;
    qryOrc_itensvl_total1: TFloatField;
    qryOrc_itensvl_Total_orc: TLongintField;
    qryOrc_itensvl_Total_orc1: TLongintField;
    qryOrc_itensvl_total_temp: TCurrencyField;
    qryOrc_itensvl_unitario: TFloatField;
    qryOrc_itensvl_unitario1: TFloatField;
    qryProdutocategoriaprodutoid: TLongintField;
    qryProdutods_produto: TStringField;
    qryProdutodt_cadastro_produto: TDateTimeField;
    qryProdutoobs_produto: TStringField;
    qryProdutoprodutoid: TLongintField;
    qryProdutostatus_produto: TStringField;
    qryProdutovl_venda_produto: TFloatField;
    ZConnection1: TZConnection;
    qryGenerica: TZQuery;
    qryProduto: TZQuery;
    qryCategoria: TZQuery;
    qryCategoriacategoriaprodutoid: TLongintField;
    qryCategoriads_categoria_produto: TStringField;
    qryCliente: TZQuery;
    qryOrcamento: TZQuery;
    qryOrc_itens: TZQuery;
    ZUpdtOrc_itens: TZUpdateSQL;
    ZUpdtOrcamento: TZUpdateSQL;
    ZUpdtCliente: TZUpdateSQL;
    ZUpdtProduto: TZUpdateSQL;
    ZUpdtCategoria: TZUpdateSQL;
    procedure qryClienteAfterInsert(DataSet: TDataSet);
    procedure qryOrcamentoAfterInsert(DataSet: TDataSet);
    procedure qryOrcamentoNewRecord(DataSet: TDataSet);
    procedure qryOrc_itensAfterDelete(DataSet: TDataSet);
    procedure qryOrc_itensAfterPost(DataSet: TDataSet);
    procedure qryProdutoAfterInsert(DataSet: TDataSet);
    procedure qryCategoriaAfterInsert(DataSet: TDataSet);
    procedure qryProdutoNewRecord(DataSet: TDataSet);
    procedure ZConnection1BeforeConnect(Sender: TObject);
    procedure ZUpdtOrcamentoAfterInsertSQL(Sender: TObject);
    procedure SomaItens;
  private

  public

    function getSequence(const pNomeSequence: String): String;

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }

procedure TDataModule1.qryCategoriaAfterInsert(DataSet: TDataSet);
begin
  qryCategoriacategoriaprodutoid.AsInteger:= StrToInt(getSequence('categoria_produto_categoriaprodutoid_seq'));
end;

procedure TDataModule1.qryProdutoNewRecord(DataSet: TDataSet);
begin
  qryProdutodt_cadastro_produto.AsDateTime:= now;
  qryProdutostatus_produto.AsString:= 'ATIVO';
end;

procedure TDataModule1.ZConnection1BeforeConnect(Sender: TObject);
var
  Ini: TIniFile;
begin
     ZConnection1.LibraryLocation:=Application.Location+'libpq.dll';
     ZConnection1.LibraryLocation:=Application.Location+'libpq74.dll';
     ZConnection1.LibraryLocation:=Application.Location+'libpq73.dll';
     ZConnection1.LibraryLocation:=Application.Location+'libpq80.dll';
     ZConnection1.LibraryLocation:=Application.Location+'libpq81.dll';
     Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, 'SERVER.INI' ) );
     Ini.WriteString('ZConnection1', 'Hostname', 'ohpatrao.chuot5bcwxis.us-east-1.rds.amazonaws.com');
     Ini.WriteString('ZConnection1', 'Port', '5432');
     Ini.WriteString('ZConnection1', 'Protocol', 'postgresql-7');
     Ini.WriteString('ZConnection1', 'User', 'postgres');
     Ini.WriteString('ZConnection1', 'Password', 'aw2000()');
     Ini.WriteString('ZConnection1', 'Database', 'postgres');
    try
        ZConnection1.Connected       := False;
        ZConnection1.HostName        := Ini.ReadString('ZConnection1', 'Hostname','');
        ZConnection1.Port            := Ini.ReadInteger('ZConnection1', 'Port',5432);
        ZConnection1.Protocol        := Ini.ReadString('ZConnection1', 'Protocol', '');
        ZConnection1.User            := Ini.ReadString('ZConnection1', 'User', '');
        ZConnection1.Password        := Ini.ReadString('ZConnection1', 'Password', '');
        ZConnection1.Database        := Ini.ReadString('ZConnection1', 'Database', '');
    except on E:Exception do
         begin
           ShowMessage('Erro ao se conectar ao banco de dados' + #13 + #13+'Motivo: '+e.Message);
           exit;
         end;
    end;
end;


procedure TDataModule1.ZUpdtOrcamentoAfterInsertSQL(Sender: TObject);
begin

end;

procedure TDataModule1.qryProdutoAfterInsert(DataSet: TDataSet);
begin
  qryProdutoprodutoid.AsInteger:= StrToInt(getSequence('produto_produtoid'));
end;



procedure TDataModule1.qryClienteAfterInsert(DataSet: TDataSet);
begin
  qryClienteclienteid.AsInteger:= StrToInt(getSequence('cliente_clienteid'));
end;



procedure TDataModule1.qryOrcamentoAfterInsert(DataSet: TDataSet);
begin
  qryOrcamentoorcamentoid.AsInteger:= StrToInt(getSequence('orcamento_orcamentoid_seq'));
end;

procedure TDataModule1.qryOrcamentoNewRecord(DataSet: TDataSet);
begin
  qryOrcamentodt_orcamento.AsDateTime:=StrToDate(FormatDateTime('DD/MM/YYYY',now));
  qryOrcamentodt_validade_orcamento.AsDateTime:=now+15;
end;

procedure TDataModule1.qryOrc_itensAfterDelete(DataSet: TDataSet);
begin
  SomaItens;
end;

procedure TDataModule1.qryOrc_itensAfterPost(DataSet: TDataSet);
begin
  SomaItens;
end;

function TDataModule1.getSequence(const pNomeSequence: String): String;
begin
    Result := '';
 try
     qryGenerica.close;
     qryGenerica.SQL.Clear;
     qryGenerica.SQL.Add('SELECT NEXTVAL(' + QuotedStr(pNomeSequence) + ') AS CODIGO');
     qryGenerica.Open;
     Result := qryGenerica.FieldByName('CODIGO').AsString;
 finally
   qryGenerica.Close;
 end;
end;



procedure TDataModule1.SomaItens;
begin

  if not (DataModule1.qryOrcamento.State in [dsEdit, dsInsert]) then
     DataModule1.qryOrcamento.Edit;

  if not (DataModule1.qryOrc_itens.State in [dsEdit, dsInsert]) then
     DataModule1.qryOrc_itens.Edit;

  //Vai pro Primeiro
  DataModule1.qryOrc_itens.First;
  DataModule1.qryOrcamentovl_total_orcamento.AsFloat := 0;
  while not DataModule1.qryOrc_itens.Eof do
  begin
    DataModule1.qryOrcamentovl_total_orcamento.AsFloat := DataModule1.qryOrcamentovl_total_orcamento.AsFloat + DataModule1.qryOrc_itensvl_total.AsFloat;
    DataModule1.qryOrc_itens.next;
  end;
end;

end.

