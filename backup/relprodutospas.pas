unit relProdutospas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, LR_Class,
  LR_View, LR_DBSet;

type

  { TRelProdutosF }

  TRelProdutosF = class(TForm)
    Button1: TButton;
    frDBDataSet1: TfrDBDataSet;
    frReportProdutos: TfrReport;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  RelProdutosF: TRelProdutosF;

implementation

{$R *.lfm}

{ TRelProdutosF }

procedure TRelProdutosF.Button1Click(Sender: TObject);
begin
  frReportProdutos.LoadFromFile('RelProdutosDLL.lrf');
  frReportProdutos.PrepareReport;
  frReportProdutos.ShowReport;
end;

end.

