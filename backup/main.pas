unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls, ActnList, ComCtrls, relProdutospas, cadcategoriaprod, cadProduto,
  cadCliente, orcamento, relclientesfpas, RelOrcamentosfpas, sobre;

type

  { TfMain }

  TfMain = class(TForm)
    Label1: TLabel;
    MainMenu1: TMainMenu;
    PageControl1: TPageControl;
    Sobre: TMenuItem;
    Sair: TMenuItem;
    mnRelatorios: TMenuItem;
    mnRelClientes: TMenuItem;
    mnRelProdutos: TMenuItem;
    mnRelOrcamentos: TMenuItem;
    mnSaidas: TMenuItem;
    mnOrcamento: TMenuItem;
    mnClientes: TMenuItem;
    mnProdutos: TMenuItem;
    mnCadCategoriaProd: TMenuItem;
    mnCadastro: TMenuItem;
    procedure mnOrcamentoClick(Sender: TObject);
    procedure mnCadCategoriaProdClick(Sender: TObject);
    procedure mnClientesClick(Sender: TObject);
    procedure mnProdutosClick(Sender: TObject);
    procedure mnRelClientesClick(Sender: TObject);
    procedure mnRelOrcamentosClick(Sender: TObject);
    procedure mnRelProdutosClick(Sender: TObject);
    procedure SairClick(Sender: TObject);
    procedure SobreClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.mnCadCategoriaProdClick(Sender: TObject);
begin
  cadcategoriaprodF:= TcadcategoriaprodF.Create(Self);
  cadcategoriaprodF.ShowModal;
end;

procedure TfMain.mnOrcamentoClick(Sender: TObject);
begin
   cadOrcamentoF:= TcadOrcamentoF.Create(Self);
   cadOrcamentoF.pcMainCad.ActivePage:= cadOrcamentoF.tsPesquisa;
   cadOrcamentoF.ShowModal;
end;

procedure TfMain.mnClientesClick(Sender: TObject);
begin
   cadClienteF:= TcadClienteF.Create(Self);
   cadClienteF.ShowModal;
end;

procedure TfMain.mnProdutosClick(Sender: TObject);
begin
   cadProdutoF:= TcadProdutoF.Create(Self);
   cadProdutoF.DBComboBox1.Items.Add('ATIVO');
   cadProdutoF.DBComboBox1.Items.Add('INATIVO');

   cadProdutoF.ShowModal;
end;

procedure TfMain.mnRelClientesClick(Sender: TObject);
begin
     relclientesF:= TRelClientesF.Create(Self);
     relclientesF.ShowModal;
end;

procedure TfMain.mnRelOrcamentosClick(Sender: TObject);
begin
     RelOrcamentosF:= TRelOrcamentosF.Create(Self);
     RelOrcamentosF.ShowModal;
end;

procedure TfMain.mnRelProdutosClick(Sender: TObject);
begin
    RelProdutosF:= TRelProdutosF.Create(Self);
    RelProdutosF.ShowModal;
end;

procedure TfMain.SairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfMain.SobreClick(Sender: TObject);
begin
  sobreF.ShowModal;
end;

end.

