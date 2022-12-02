unit RelOrcamentosfpas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DateTimePicker, DBDateTimePicker, relclientesfpas, dtModulopas;

type

  { TRelOrcamentosF }

  TRelOrcamentosF = class(TRelClientesF)
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker3: TDateTimePicker;
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
var
  AuxWhere: string;
  AuxDateIni: String;
  AuxDateFin: String;
begin

  AuxDateIni:= FormatDateTime('yyyy/mm/dd', DateTimePicker1.Date);
  AuxDateFin:= FormatDateTime('yyyy/mm/dd', DateTimePicker2.Date);
  AuxWhere := 'dt_orcamento >= '+QuotedStr(AuxDateIni);
  AuxWhere:= AuxWhere + ' AND dt_orcamento <= '+ QuotedStr(AuxDateFin);
  DataModule1.qryOrcamento.Close;
  DataModule1.qryOrcamento.SQL.Clear;
  DataModule1.qryOrcamento.SQL.Text :=
    'select   '+
              'orcamentoid,  '+
              'clienteid,  '+
              'dt_orcamento,   '+
              'dt_validade_orcamento,  '+
              'vl_total_orcamento		'+
              'from orcamento '+
              'WHERE '+AuxWhere+' '+
              'ORDER BY orcamentoid';
  DataModule1.qryOrcamento.Open;
  frReport1.LoadFromFile('RelOrcamentosDLL.lrf');
  frReport1.PrepareReport;
  frReport1.ShowReport;
  DateTimePicker3:= DataModule1.qryOrcamentodt_orcamento;
end;

end.

