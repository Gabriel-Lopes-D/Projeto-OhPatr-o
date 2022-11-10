unit cadProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, ExtCtrls, Menus, cadPadrao, DB, dtModulopas, pesqCategoria;

type

  { TcadProdutoF }

  TcadProdutoF = class(TcadPadraoF)
    btnPesqCategoria: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    DBComboBox1: TDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit5: TDBEdit;
    dbEditCategoria: TDBEdit;
    DBEdit7: TDBEdit;
    dsProduto: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Categoria: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnPesqCategoriaClick(Sender: TObject);
    procedure DBComboBox1Change(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtCampoPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);


  private

  public

  end;

var
  cadProdutoF: TcadProdutoF;

implementation

{$R *.lfm}

{ TcadProdutoF }



procedure TcadProdutoF.btnPesquisaClick(Sender: TObject);
var
  AuxWhere: string;
begin
  //Esta procedure irá executar a pesquisa
    if ComboBox1.Text = 'Id'then //Identifica o tipo de pesquisa
    begin
       if edtCampoPesquisa.Text = '' then//verifica se o campo ta vazio
          AuxWhere := '1 = 1'
       else
           AuxWhere := 'produtoid = '+edtCampoPesquisa.Text;//atribui o valor se n estiver vazio
    end;
    if (ComboBox1.Text = 'Status') AND (ComboBox1.IsVisible = True) then
    begin
       AuxWhere := 'status_produto = ';
       if ComboBox2.Text = 'ATIVO' then

       AuxWhere := AuxWhere+QuotedStr('ATIVO')
       Else AuxWhere := AuxWhere+QuotedStr('INATIVO');

    end;
    if ComboBox1.Text = 'Desc. Produto' then
    begin
       if edtCampoPesquisa.Text = '' then
          AuxWhere:='1 = 1'
       else AuxWhere:= 'ds_produto = '+QuotedStr(edtCampoPesquisa.Text);
    end;
    if ComboBox1.Text = 'Id Categoria' then
    begin
       if edtCampoPesquisa.Text = '' then
          AuxWhere:='1 = 1'
       else AuxWhere:= 'categoriaprodutoid = '+QuotedStr(edtCampoPesquisa.Text);
    end;




  DataModule1.qryProduto.Close;
  DataModule1.qryProduto.SQL.Clear;
  DataModule1.qryProduto.SQL.Text :=
            'select   '+
            'produtoid,  '+
            'categoriaprodutoid,  '+
            'ds_produto,   '+
            'obs_produto,  '+
            'vl_venda_produto,  '+
            'dt_cadastro_produto, '+
            'status_produto '+
            'from produto '+
            'WHERE '+AuxWhere+' '+
            'ORDER BY produtoid';
  DataModule1.qryProduto.Open;
end;



procedure TcadProdutoF.btnPesqCategoriaClick(Sender: TObject);
begin
  pesqCategoria.pesqCategoriaF.ShowModal;
end;


procedure TcadProdutoF.DBComboBox1Change(Sender: TObject);
begin

end;

procedure TcadProdutoF.DBGrid1DblClick(Sender: TObject);
begin
  pcMainCad.ActivePage:= tsCadastro;
  DataModule1.qryProduto.Edit;
end;

procedure TcadProdutoF.edtCampoPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Ord(Key) = 13  then
   btnPesquisaClick(cadProdutoF);
end;

procedure TcadProdutoF.FormCreate(Sender: TObject);
begin
    DataModule1.qryProduto.Open;
end;

procedure TcadProdutoF.FormShow(Sender: TObject);
begin
  Label4.Caption:='';
  pcMainCad.ActivePage:= tsPesquisa;
end;


procedure TcadProdutoF.btnNovoClick(Sender: TObject);
begin
  inherited;
   DataModule1.qryProduto.Insert;
end;

procedure TcadProdutoF.btnGravarClick(Sender: TObject);
var
  erro: Boolean;
begin

   if (DBEdit1.Text = '') OR (dbEditCategoria.Text = '') OR (DBEdit5.Text = '') then
   begin
      ShowMessage('Erro! Existem campos vazios');
   end
   else begin
     inherited;
     try
        try
           dsProduto.DataSet.post;
           DataModule1.qryProduto.ApplyUpdates;
           erro:= False;
        except
           erro:= True;
        end;
     finally
        if erro = True then
           ShowMessage('Ocorreu um erro, alterações não foram gravadas!');
     end;

   end;

end;

procedure TcadProdutoF.btnExcluirClick(Sender: TObject);
begin

  if (DBEdit1.Text = '') OR (dbEditCategoria.Text = '') OR (DBEdit5.Text = '') then
        begin
        ShowMessage('Erro! Existem campos vazios');
        end
  else begin
       if  MessageDlg('Você tem certeza que deseja excluir o registro?', mtConfirmation,[mbyes,mbno],0) = mryes then
           begin
           inherited;
           DataModule1.qryProduto.Delete;
           DataModule1.qryProduto.ApplyUpdates;
           end;
  end;
end;

procedure TcadProdutoF.btnCancelarClick(Sender: TObject);
begin
  inherited;
  DataModule1.qryProduto.Cancel;
end;

end.

