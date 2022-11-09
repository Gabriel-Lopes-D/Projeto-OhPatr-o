unit login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, Main, dtModulopas;

type

  { TLoginF }

  TLoginF = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
  private

  public

  end;

var
  LoginF: TLoginF;

implementation

{$R *.lfm}

{ TLoginF }

procedure TLoginF.BitBtn1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TLoginF.BitBtn2Click(Sender: TObject);
var
  usuario,senha: String;
begin

    DataModule1.qryGenerica.close;
    DataModule1.qryGenerica.SQL.Clear;
    DataModule1.qryGenerica.SQL.Add('SELECT USUARIO, SENHA FROM USUARIOS'+
                                    ' WHERE '+ QuotedStr(Edit1.Text)+ ' = USUARIO AND '+ QuotedStr(Edit2.Text) + ' = senha');
    DataModule1.qryGenerica.Open;
    usuario := DataModule1.qryGenerica.FieldByName('USUARIO').AsString;
    senha:=DataModule1.qryGenerica.FieldByName('senha').AsString;



    if(Edit1.Text = '') or (Edit2.Text = '')then
    begin
        ShowMessage('Usuário ou senha incorretos');
        Edit1.Text := '';
        Edit2.Text := '';
    end
    else
    begin
        if(Edit1.Text = usuario) and (Edit2.Text = senha) then
        begin
             main.fMain.ShowModal;
             Close;
        end
        else
        begin
             ShowMessage('Usuário ou senha incorretos');
             Edit1.Text := '';
             Edit2.Text := '';
        end
    end;
end;




procedure TLoginF.Edit2Exit(Sender: TObject);
begin
     Application.Terminate;

end;

procedure TLoginF.KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Ord(Key) = 13  then
    BitBtn2Click(LoginF);
end;





end.

