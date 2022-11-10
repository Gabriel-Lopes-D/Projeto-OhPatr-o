unit cadCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls, cadPadrao,
  dtModulopas, DBCtrls, ExtCtrls, MaskEdit, DB;

type

  { TcadClienteF }

  TcadClienteF = class(TcadPadraoF)
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    dbEdtNomeCli: TDBEdit;
    dbEdtCpfCnpjCli: TDBEdit;
    dbEdtIdCli: TDBEdit;
    dbEdtTipoCli: TDBEdit;
    DBGrid1: TDBGrid;
    dsCliente: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtCampoPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MaskEdit1EditingDone(Sender: TObject);
    procedure MaskEdit1Exit(Sender: TObject);
    procedure MaskEdit2Click(Sender: TObject);
    procedure MaskEdit2Exit(Sender: TObject);
  private

  public

  end;

var
  cadClienteF: TcadClienteF;

implementation

{$R *.lfm}

{ TcadClienteF }

procedure TcadClienteF.btnPesquisaClick(Sender: TObject);
var
   AuxWhere: string;
begin
  //Esta procedure irá executar a pesquisa
  if ComboBox1.Text = 'Id'then //Identifica o tipo de pesquisa
    begin
       if edtCampoPesquisa.Text = '' then//verifica se o campo ta vazio
          AuxWhere := '1 = 1'
       else
           AuxWhere := 'clienteid = '+edtCampoPesquisa.Text;//atribui o valor se n estiver vazio
    end;
  if ComboBox1.Text = 'Tipo'then
    begin
       if edtCampoPesquisa.Text = '' then
          AuxWhere := '1 = 1'
       else
           AuxWhere := 'tipo_cliente = '+QuotedStr(edtCampoPesquisa.Text);
    end;
  if ComboBox1.Text = 'CPF / CNPJ'then
    begin
       if edtCampoPesquisa.Text = '' then
          AuxWhere := '1 = 1'
       else
           AuxWhere := 'cpf_cnpj_cliente = '+QuotedStr(edtCampoPesquisa.Text);
    end;
  if ComboBox1.Text = 'Nome'then
    begin
       if edtCampoPesquisa.Text = '' then
          AuxWhere := '1 = 1'
       else
           AuxWhere := 'nome_cliente = '+QuotedStr(edtCampoPesquisa.Text);
    end;


  DataModule1.qryCliente.Close;
  DataModule1.qryCliente.SQL.Clear;
  DataModule1.qryCliente.SQL.Text :=
            'select   '+
            'clienteid,  '+
            'tipo_cliente,  '+
            'cpf_cnpj_cliente,   '+
            'nome_cliente  '+
            'from cliente '+
            'WHERE '+AuxWhere+' '+
            'ORDER BY clienteid';
  DataModule1.qryCliente.Open;

end;





procedure TcadClienteF.DBGrid1DblClick(Sender: TObject);
begin
   DataModule1.qryCliente.Edit;
   pcMainCad.ActivePage:= tsCadastro;
   dbEdtCpfCnpjCli.Visible:=True;
   MaskEdit1.Visible:=False;
   MaskEdit2.Visible:=False;
end;

procedure TcadClienteF.edtCampoPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Ord(Key) = 13  then
   btnPesquisaClick(cadClienteF);
end;

procedure TcadClienteF.FormCreate(Sender: TObject);
begin
    DataModule1.qryCliente.Open;
end;

procedure TcadClienteF.FormShow(Sender: TObject);
begin
  pcMainCad.ActivePage:= tsPesquisa;
end;

procedure TcadClienteF.MaskEdit1EditingDone(Sender: TObject);
begin
  if ComboBox2.Text = 'Cpf' then
    begin
    dbEdtCpfCnpjCli.Text:= MaskEdit1.Text;
    end
  else begin
         ShowMessage(MaskEdit2.Text);
    dbEdtCpfCnpjCli.Text:= MaskEdit2.Text;
    ShowMessage(dbEdtCpfCnpjCli.Text);
  end
end;

procedure TcadClienteF.MaskEdit1Exit(Sender: TObject);
begin
  dbEdtTipoCli.Text:= 'F';
end;

procedure TcadClienteF.MaskEdit2Click(Sender: TObject);
begin
  if ComboBox2.Text = 'Cpf' then
    begin
    MaskEdit1.Visible:= True;
    MaskEdit2.Visible:= False;
    end
  else begin
      MaskEdit1.Visible:= False;
      MaskEdit2.Visible:= True;
  end;
end;

procedure TcadClienteF.MaskEdit2Exit(Sender: TObject);
begin
     dbEdtTipoCli.Text:= 'J';
end;

procedure TcadClienteF.btnGravarClick(Sender: TObject);//Grava os dados
var
   erro: Boolean;
begin
   if (dbEdtNomeCli.Text = '') OR (MaskEdit1.Text = '') OR (MaskEdit2.Text = '') then
   begin
        ShowMessage('Erro! Existem campos vazios');
   end
   else begin
        inherited;
        try
           try
              dsCliente.DataSet.Post;
              DataModule1.qryCliente.ApplyUpdates;
              erro:= False;
           except
              erro:= True;
           end;
        finally
           if erro = True then
           ShowMessage('Ocorreu um erro, alterações não foram gravadas!');
        end;

   end;
end;

procedure TcadClienteF.btnNovoClick(Sender: TObject);
begin
  inherited;
  dbEdtCpfCnpjCli.Visible:=False;
  MaskEdit1.Visible:=True;
  DataModule1.qryCliente.Insert;
  dbEdtCpfCnpjCli.Text:='';
  dbEdtNomeCli.Text:='';
end;

procedure TcadClienteF.btnExcluirClick(Sender: TObject);//Exclui os dados
var
   erro: Boolean;
begin

  if  MessageDlg('Você tem certeza que deseja excluir o registro?', mtConfirmation,[mbyes,mbno],0) = mryes then
    begin
       try
          try
             inherited;
             DataModule1.qryCliente.Delete;
             DataModule1.qryCliente.ApplyUpdates;
             erro:= False;
          except on e: Exception do
                 begin
                    erro:= True;
                    ShowMessage('Erro ao realizar operação, tente novamente!' + #13 + #13+'Motivo: '+e.Message);
                    exit;
                 end;
          end;
       finally
          if erro = False then
          ShowMessage('Operação realizada com sucesso');
       end;
    end;
end;

procedure TcadClienteF.btnCancelarClick(Sender: TObject);
begin
  inherited;
  DataModule1.qryCliente.Cancel;
end;

end.

