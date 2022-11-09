unit sobre;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TsobreF }

  TsobreF = class(TForm)
    BitBtn1: TBitBtn;
    Image1: TImage;
    Memo1: TMemo;
    Panel1: TPanel;
    procedure BitBtn1Click(Sender: TObject);
  private

  public

  end;

var
  sobreF: TsobreF;

implementation

{$R *.lfm}

{ TsobreF }

procedure TsobreF.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.

