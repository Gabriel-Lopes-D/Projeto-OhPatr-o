program pgrMain;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, zcomponent, Main, dtModulopas, cadPadrao,
  cadcategoriaprod, cadProduto, pesqCategoria, cadCliente, orcamento,
  pesqcliente, cadItemOrc, relProdutospas, relclientesfpas, RelOrcamentosfpas,
  login, sobre;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='Oh patrão';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TLoginF, LoginF);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TcadcategoriaProdF, cadcategoriaProdF);
  Application.CreateForm(TcadProdutoF, cadProdutoF);
  Application.CreateForm(TpesqCategoriaF, pesqCategoriaF);
  Application.CreateForm(TcadClienteF, cadClienteF);
  Application.CreateForm(TcadOrcamentoF, cadOrcamentoF);
  Application.CreateForm(TpesqClienteF, pesqClienteF);
  Application.CreateForm(TcadItemOrcF, cadItemOrcF);
  Application.CreateForm(TRelProdutosF, RelProdutosF);
  Application.CreateForm(TRelClientesF, RelClientesF);
  Application.CreateForm(TRelOrcamentosF, RelOrcamentosF);
  Application.CreateForm(TsobreF, sobreF);
  Application.Run;
end.

