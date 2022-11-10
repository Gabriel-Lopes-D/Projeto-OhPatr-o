unit cadItemOrc;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, DBGrids, Buttons, Spin, dtModulopas;

type

  { TcadItemOrcF }

  TcadItemOrcF = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    dsProdutos: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    SpinEdit1: TSpinEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1DblClick(Sender: TObject);
  private

  public

  end;

var
  cadItemOrcF: TcadItemOrcF;

implementation

uses
  orcamento;

{$R *.lfm}

{ TcadItemOrcF }

procedure TcadItemOrcF.BitBtn1Click(Sender: TObject);
var
  AuxWhere: String;
begin
  if ComboBox1.Text = 'Id'then //Identifica o tipo de pesquisa
    begin
       if Edit1.Text = '' then//verifica se o campo ta vazio
          AuxWhere := '1 = 1'
       else
           AuxWhere := 'produtoid = '+Edit1.Text;//atribui o valor se n estiver vazio
    end;
    if ComboBox1.Text = 'Desc. Produto' then
    begin
       if Edit1.Text = '' then
          AuxWhere:='1 = 1'
       else AuxWhere:= 'ds_produto = '+QuotedStr(Edit1.Text);
    end;
    if ComboBox1.Text = 'Id Categoria' then
    begin
       if Edit1.Text = '' then
          AuxWhere:='1 = 1'
       else AuxWhere:= 'categoriaprodutoid = '+QuotedStr(Edit1.Text);
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

procedure TcadItemOrcF.BitBtn2Click(Sender: TObject);
begin
  DataModule1.qryOrc_itens.Cancel;
  cadItemOrcF.Close;
  DataModule1.qryOrc_itens.Open;
end;

procedure TcadItemOrcF.KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Ord(Key) = 13  then
     BitBtn1Click(cadItemOrcF);
end;

procedure TcadItemOrcF.DBGrid1DblClick(Sender: TObject);
begin
  if StrToInt(SpinEdit1.Text) < 1 then
  begin
     ShowMessage('Valor inválido na quantidade do produto!');
  end else begin
    DataModule1.qryOrc_itensprodutoid.AsInteger:= DataModule1.qryProdutoprodutoid.AsInteger;
    DataModule1.qryOrc_itensprodutodesc.AsString:= DataModule1.qryProdutods_produto.AsString;
    DataModule1.qryOrc_itensqt_produto.AsInteger:= StrToInt(SpinEdit1.Text);
    DataModule1.qryOrc_itensvl_unitario.AsFloat:=DataModule1.qryProdutovl_venda_produto.AsFloat;
    DataModule1.qryOrc_itensvl_total.AsFloat:= DataModule1.qryProdutovl_venda_produto.AsFloat * StrToInt(SpinEdit1.Text);
    DataModule1.qryOrc_itens.Post;
    close;
    end;
end;



end.

