unit cadPadrao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Grids,
  PairSplitter, ComCtrls, StdCtrls, Buttons;

type

  { TcadPadraoF }

  TcadPadraoF = class(TForm)
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnCancelar: TBitBtn;
    btnPesquisa: TBitBtn;
    btnNovo: TBitBtn;
    edtCampoPesquisa: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    pcMainCad: TPageControl;
    tsPesquisa: TTabSheet;
    tsCadastro: TTabSheet;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private

  public

  end;

var
  cadPadraoF: TcadPadraoF;

implementation

{$R *.lfm}

{ TcadPadraoF }

procedure TcadPadraoF.btnNovoClick(Sender: TObject);
begin
   pcMainCad.ActivePage:= tsCadastro;
end;

procedure TcadPadraoF.btnGravarClick(Sender: TObject);
begin
   pcMainCad.ActivePage:= tsPesquisa;
end;

procedure TcadPadraoF.btnExcluirClick(Sender: TObject);
begin
    pcMainCad.ActivePage:= tsPesquisa;
end;

procedure TcadPadraoF.btnCancelarClick(Sender: TObject);
begin
  pcMainCad.ActivePage:= tsPesquisa;
end;

end.

