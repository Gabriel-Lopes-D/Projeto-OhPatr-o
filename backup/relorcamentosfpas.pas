unit RelOrcamentosfpas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, relclientesfpas;

type

  { TRelOrcamentosF }

  TRelOrcamentosF = class(TRelClientesF)
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  RelOrcamentosF: TRelOrcamentosF;

implementation

{$R *.lfm}

{ TRelOrcamentosF }

procedure TRelOrcamentosF.Button1Click(Sender: TObject);
begin
  inherited;
  frReport1.LoadFromFile('RelOrcamentosDLL.lrf');
  frReport1.PrepareReport;
  frReport1.ShowReport;
end;

end.

