unit cadcategoriaprod;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  DBGrids, DBCtrls, ExtCtrls, cadPadrao, DB, dtModulopas;

type

  { TcadcategoriaProdF }

  TcadcategoriaProdF = class(TcadPadraoF)
    ComboBox1: TComboBox;
    dsCategoria: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtCampoPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private

  public

  end;

var
  cadcategoriaProdF: TcadcategoriaProdF;

implementation

{$R *.lfm}

{ TcadcategoriaProdF }

procedure TcadcategoriaProdF.btnPesquisaClick(Sender: TObject);
var
  AuxWhere : String;
begin
  if ComboBox1.Text = 'Id'then //Identifica o tipo de pesquisa
    begin
       if edtCampoPesquisa.Text = '' then//verifica se o campo ta vazio
          AuxWhere := '1 = 1'
       else
           AuxWhere := 'categoriaprodutoid = '+edtCampoPesquisa.Text;//atribui o valor se n estiver vazio
    end;
  if ComboBox1.Text = 'Categoria'then
    begin
       if edtCampoPesquisa.Text = '' then
          AuxWhere := '1 = 1'
       else
           AuxWhere := 'ds_categoria_produto = '+QuotedStr(edtCampoPesquisa.Text);
    end;


  DataModule1.qryCategoria.Close;
  DataModule1.qryCategoria.SQL.Clear;
  DataModule1.qryCategoria.SQL.Text :=
            'SELECT '+
            'categoriaprodutoid, '+
            'ds_categoria_produto '+
            'FROM categoria_produto '+
            'WHERE '+AuxWhere+' '+
            'ORDER BY categoriaprodutoid';
  DataModule1.qryCategoria.Open;
end;

procedure TcadcategoriaProdF.DBEdit1Exit(Sender: TObject);
begin
    if DBEdit1.Text = '' then
    begin
    ShowMessage('A descrição da catedoria do produto não pode ser vazia!');
    end
end;






procedure TcadcategoriaProdF.btnGravarClick(Sender: TObject);
var
  erro: Boolean;
begin

    if DBEdit1.Text = '' then
    begin
         ShowMessage('A descrição da catedoria do produto não pode ser vazia!');
    end
    else begin
      inherited;
      try
         try
            dsCategoria.DataSet.post;
            DataModule1.qryCategoria.ApplyUpdates;
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

procedure TcadcategoriaProdF.btnExcluirClick(Sender: TObject);
begin
     if DBEdit1.Text = '' then
        begin
        ShowMessage('A descrição da catedoria do produto não pode ser vazia!');
        end
     else begin
         if  MessageDlg('Você tem certeza que deseja excluir o registro?', mtConfirmation,[mbyes,mbno],0) = mryes then
         begin
              inherited;
              DataModule1.qryCategoria.Delete;
              DataModule1.qryCategoria.ApplyUpdates;
         end;
    end;
end;

procedure TcadcategoriaProdF.btnCancelarClick(Sender: TObject);
begin
  inherited;
  DataModule1.qryCategoria.Cancel;
end;

procedure TcadcategoriaProdF.btnNovoClick(Sender: TObject);

begin
  inherited;
   DataModule1.qryCategoria.Insert;
end;


procedure TcadcategoriaProdF.DBGrid1DblClick(Sender: TObject);
begin
   pcMainCad.ActivePage:= tsCadastro;
end;

procedure TcadcategoriaProdF.edtCampoPesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Ord(Key) = 13  then
     btnPesquisaClick(cadcategoriaProdF);

end;

procedure TcadcategoriaProdF.FormCreate(Sender: TObject);
begin
    DataModule1.qryCategoria.Open;
end;


procedure TcadcategoriaProdF.FormShow(Sender: TObject);
begin
   pcMainCad.ActivePage:= tsPesquisa;
end;



end.

