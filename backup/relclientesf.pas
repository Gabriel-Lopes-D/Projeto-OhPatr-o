unit RelClientesF;

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
  private

  public

  end;

var
  RelClientesF: TRelClientesF;

implementation

{$R *.lfm}

end.

