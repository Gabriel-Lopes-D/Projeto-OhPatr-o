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
  ShowMessage('primeira linha OK');
  Application.Scaled:=True;
  ShowMessage('segunda linha OK');
  Application.Initialize;
  ShowMessage(' 3 linha OK');
  Application.CreateForm(TLoginF, LoginF);
  ShowMessage('4 linha OK');
  Application.CreateForm(TDataModule1, DataModule1);
  ShowMessage(' 5linha OK');
  Application.CreateForm(TfMain, fMain);
  ShowMessage('6linha OK');
  Application.CreateForm(TcadcategoriaProdF, cadcategoriaProdF);
  ShowMessage('7linha OK');
  Application.CreateForm(TcadProdutoF, cadProdutoF);
  ShowMessage('8linha OK');
  Application.CreateForm(TpesqCategoriaF, pesqCategoriaF);
  ShowMessage('9linha OK');
  Application.CreateForm(TcadClienteF, cadClienteF);
  ShowMessage('10linha OK');
  Application.CreateForm(TcadOrcamentoF, cadOrcamentoF);
  ShowMessage('11linha OK');
  Application.CreateForm(TpesqClienteF, pesqClienteF);
  ShowMessage('12linha OK');
  Application.CreateForm(TcadItemOrcF, cadItemOrcF);
  ShowMessage('13linha OK');
  Application.CreateForm(TRelProdutosF, RelProdutosF);
  ShowMessage('14linha OK');
  Application.CreateForm(TRelClientesF, RelClientesF);
  ShowMessage('15linha OK');
  Application.CreateForm(TRelOrcamentosF, RelOrcamentosF);
  ShowMessage('16linha OK');
  Application.CreateForm(TsobreF, sobreF);
  ShowMessage('17linha OK');
  Application.Run;
  ShowMessage('18linha OK');
end.

