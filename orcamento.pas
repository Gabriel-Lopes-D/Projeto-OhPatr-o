unit orcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, ExtCtrls,
  DBCtrls, StdCtrls, Buttons, MaskEdit, DBExtCtrls, DBDateTimePicker,
  DateTimePicker, LR_Class, LR_DBSet, cadPadrao, DB, dtModulopas, pesqcliente,
  cadItemOrc;

type

  { TcadOrcamentoF }

  TcadOrcamentoF = class(TcadPadraoF)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btnEditar: TBitBtn;
    Button1: TButton;
    ComboBox1: TComboBox;
    DateTimePicker1: TDateTimePicker;
    DBDateTimePicker1: TDBDateTimePicker;
    dsOrcItens: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdtDtOrc: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    dsOrcamento: TDataSource;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure pcMainCadChange(Sender: TObject);
    procedure atribuiNomeCliente(clienteId: String);
  private

  public

  end;

var
  cadOrcamentoF: TcadOrcamentoF;

implementation

{$R *.lfm}

{ TcadOrcamentoF }

procedure TcadOrcamentoF.btnPesquisaClick(Sender: TObject);
var
  AuxWhere: string;
  AuxDate: String;
begin
  //Esta procedure irá executar a pesquisa da Categoria
  if ComboBox1.Text = 'Id'then //Identifica o tipo de pesquisa
    begin
       if edtCampoPesquisa.Text = '' then//verifica se o campo ta vazio
          AuxWhere := '1 = 1'
       else
           AuxWhere := 'orcamentoid = '+edtCampoPesquisa.Text;//atribui o valor se n estiver vazio
    end;
  if ComboBox1.Text = 'Data'then
    begin
           AuxDate:= FormatDateTime('yyyy/mm/dd', DateTimePicker1.Date);
           AuxWhere := 'dt_orcamento = '+QuotedStr(AuxDate);
    end;
  if ComboBox1.Text = 'Id Cliente'then
    begin
       if edtCampoPesquisa.Text = '' then
          AuxWhere := '1 = 1'
       else
           AuxWhere := 'clienteid = '+edtCampoPesquisa.Text;
    end;

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
end;

procedure TcadOrcamentoF.Button1Click(Sender: TObject);
begin
  pesqClienteF := TpesqClienteF.Create(Self);
  pesqClienteF.ShowModal;
end;

procedure TcadOrcamentoF.ComboBox1Change(Sender: TObject);
begin
  if (ComboBox1.Text = 'Data') OR (ComboBox1.Text = 'Id cliente')then
    begin
       edtCampoPesquisa.Visible:= False;
     DateTimePicker1.Visible:= True;
     DateTimePicker1.Date:= Date;
    end;
  if ComboBox1.Text = 'Id'then
    begin
    DateTimePicker1.Visible:= False;
    edtCampoPesquisa.Visible:= True
    end;

end;



procedure TcadOrcamentoF.DBGrid1DblClick(Sender: TObject);
begin
  pcMainCad.ActivePage:= tsCadastro;
  DataModule1.qryOrc_itens.Close;
  DataModule1.qryOrc_itens.Params.ParamByName('orcamentoid').AsInteger:=DataModule1.qryOrcamentoorcamentoid.AsInteger;
  DataModule1.qryOrc_itens.Open;
  atribuiNomeCliente(DBEdit1.Text);
  DataModule1.qryOrc_itens.Edit;
  DataModule1.qryOrcamento.Edit;
end;

procedure TcadOrcamentoF.KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Ord(Key) = 13  then
   btnPesquisaClick(cadOrcamentoF);
end;

procedure TcadOrcamentoF.atribuiNomeCliente(clienteId:String);
begin

  DataModule1.qryGenerica.Close;
  DataModule1.qryGenerica.SQL.Clear;
  DataModule1.qryGenerica.SQL.Text :=

  'select   '+
            'nome_cliente  '+
            'from cliente '+
            'WHERE clienteid = '+clienteId;
  DataModule1.qryGenerica.Open;
  Label5.Caption := DataModule1.qryGenerica.FieldByName('nome_cliente').AsString;
end;

procedure TcadOrcamentoF.FormCreate(Sender: TObject);
begin
  DataModule1.qryOrcamento.Open;
  DataModule1.qryOrc_itens.Open;

  Label5.caption := '';
end;

procedure TcadOrcamentoF.pcMainCadChange(Sender: TObject);
begin
  DataModule1.qryOrc_itens.Close;
  DataModule1.qryOrc_itens.Params.ParamByName('orcamentoid').AsInteger:=DataModule1.qryOrcamentoorcamentoid.AsInteger;
  DataModule1.qryOrc_itens.Open;

end;

procedure TcadOrcamentoF.btnNovoClick(Sender: TObject);
begin
  inherited;
  DataModule1.qryOrcamento.Insert;
  DataModule1.qryOrc_itens.Close;
  DataModule1.qryOrc_itens.Params.ParamByName('orcamentoid').AsInteger:=DataModule1.qryOrcamentoorcamentoid.AsInteger;
  DataModule1.qryOrc_itens.Open;
  Label5.Caption:= '';

end;

procedure TcadOrcamentoF.btnGravarClick(Sender: TObject);
var
  erro: Boolean;
begin
  inherited;
  try
    try
      DataModule1.qryOrcamentovl_total_orcamento.AsFloat:= DataModule1.qryOrc_itensvl_total.AsFloat;
      dsOrcamento.DataSet.Post;
      DataModule1.qryOrcamento.ApplyUpdates;
      DataModule1.qryOrc_itens.ApplyUpdates;
      erro:= False;
    except
      erro:= True;
    end;
  finally
    if erro = True then
     ShowMessage('Ocorreu um erro, alterações não foram gravadas!');
  end;

end;

procedure TcadOrcamentoF.btnExcluirClick(Sender: TObject);
begin

   if  MessageDlg('Você tem certeza que deseja excluir o registro?', mtConfirmation,[mbyes,mbno],0) = mryes then
    begin
    DataModule1.qryOrcamento.Delete;
    DataModule1.qryOrcamento.ApplyUpdates;
    inherited;
  end;
end;

procedure TcadOrcamentoF.btnCancelarClick(Sender: TObject);
begin
  inherited;
  DataModule1.qryOrcamento.Cancel;
end;

procedure TcadOrcamentoF.BitBtn1Click(Sender: TObject);
var
id : String;
begin

    if  DBEdit1.Text = '' then
     begin
     ShowMessage('O campo cliente não pode estar vazio!');

     end else begin
       dsOrcItens.DataSet.Insert;

       //Busca o ultimo código do orçamento atual
       DataModule1.qryGenerica.close;
       DataModule1.qryGenerica.SQL.Clear;
       DataModule1.qryGenerica.SQL.Add('SELECT MAX(orcamentoitemid) + 1 PROXCODIGO '+
                                    ' FROM orcamento_item '+
                                    ' WHERE ORCAMENTOID = ' + IntToStr(DataModule1.qryOrcamentoorcamentoid.AsInteger));
       DataModule1.qryGenerica.Open;

       id := DataModule1.qryGenerica.FieldByName('PROXCODIGO').AsString;

       if id = '' then
          DataModule1.qryOrc_itensorcamentoitemid.AsInteger := 1
       else
           DataModule1.qryOrc_itensorcamentoitemid.AsInteger := StrToInt(id);

       //Passando o código do orçamentoid
       DataModule1.qryOrc_itensorcamentoid.AsInteger := DataModule1.qryOrcamentoorcamentoid.AsInteger;

       //abre a tela de que permita fazer a busca do produto
       cadItemOrcF:= TcadItemOrcF.create(Self);
       cadItemOrcF.ShowModal;
     end;

end;

procedure TcadOrcamentoF.BitBtn2Click(Sender: TObject);
begin

     if not DataModule1.qryOrc_itens.IsEmpty then
        DataModule1.qryOrc_itens.Delete;

end;

procedure TcadOrcamentoF.BitBtn3Click(Sender: TObject);
begin
  frReport1.LoadFromFile('RelOrcItensDLL.lrf');
  frReport1.PrepareReport;
  frReport1.ShowReport;;
end;


end.


