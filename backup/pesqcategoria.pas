unit pesqCategoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ComCtrls, DBCtrls,
  StdCtrls, ExtCtrls, DBGrids, Buttons, dtModulopas;

type

  { TpesqCategoriaF }

  TpesqCategoriaF = class(TForm)
    btnPesquisar: TBitBtn;
    dsPesqCategoria: TDataSource;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    procedure DBGrid1DblClick(Sender: TObject);
  private

  public

  end;


var
  pesqCategoriaF: TpesqCategoriaF;


implementation

uses
cadproduto;
{$R *.lfm}

{ TpesqCategoriaF }

procedure TpesqCategoriaF.DBGrid1DblClick(Sender: TObject);
begin
     DataModule1.qryProdutocategoriaprodutoid.AsInteger:= DataModule1.qryCategoriacategoriaprodutoid.AsInteger;
     cadProdutoF.Label4.Caption:= DataModule1.qryCategoriads_categoria_produto.AsString;
     close;
end;

end.

