unit relclientesfpas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, LR_Class,
  LR_View, LR_DBSet;

type

  { TRelClientesF }

  TRelClientesF = class(TForm)
    Button1: TButton;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  RelClientesF : TRelClientesF;

implementation

{$R *.lfm}

{ TRelClientesF }

procedure TRelClientesF.Button1Click(Sender: TObject);
begin
  frReport1.LoadFromFile('RelClientesDLL.lrf');
  frReport1.PrepareReport;
  frReport1.ShowReport;
end;

end.

