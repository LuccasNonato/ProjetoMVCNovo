unit view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, controller.Pessoas, FireDAC.Comp.UI, FireDAC.Comp.DataSet, firedac.stan.Error,
  FireDAC.Stan.Param, entidade.Pessoas, Vcl.ComCtrls, uFuncoes, Vcl.DBCGrids,
  entidade.log, Vcl.Mask;

type
  TForm1 = class(TForm)
    dbgrd1: TDBGrid;
    DataSource: TDataSource;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    edtNomeCompleto: TEdit;
    edtCpf: TEdit;
    edtRg: TEdit;
    edtEmail: TEdit;
    dtpNascimento: TDateTimePicker;
    edtTelefone: TEdit;
    edtCep: TEdit;
    edtLogradouro: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtEstado: TEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    edtTipoPessoa: TComboBox;
    mmoLog: TMemo;
    lbl14: TLabel;
    lbl15: TLabel;
    btn4: TButton;
    edtBusca: TMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure edtCepExit(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure dbgrd1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrd1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure edtCpfExit(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
    procedure edtRgExit(Sender: TObject);
    procedure edtTelefoneExit(Sender: TObject);
    procedure edtBuscaExit(Sender: TObject);
  private
    { Private declarations }
    FController  : TControllerPessoas;
    FEntidade    : TEntidadePessoas;
    FEntidadeLog : TEntidadeLogs;
    procedure PegaInformacoes;
    procedure AutoSizeDBGridColumns;


  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  LController:   TControllerPessoas;
begin
  LController := TControllerPessoas.create;


  if not TFunctions.VerificarCamposEmBranco(self) then  exit;

  try

    with FEntidade do
    begin
      tipo_pessoa := edtTipoPessoa.Text;
      nome_completo := edtNomeCompleto.Text;
      data_nascimento := DateToStr(dtpNascimento.Date);
      cpf := edtCpf.Text;
      rg := edtRg.Text;
      email := edtEmail.Text;
      telefone := edtTelefone.Text;
      cep := edtCep.Text;
      logradouro := edtLogradouro.Text;
      bairro := edtBairro.Text;
      cidade := edtCidade.Text;
      estado := edtEstado.Text;

      LController.Insert(FEntidade);

      with FEntidadeLog do
      begin
        id_pessoa := DataSource.DataSet.FieldByName('id').AsString;
        descricao := 'Incluiu :' + DateToStr(Now);
        LController.Log(FEntidadeLog, 'Incluiu :' + DateToStr(Now));
      end;

      datasource.DataSet.Refresh;

      btn4Click(nil);
    end;

  finally
    FreeAndNil(LController);
  end;


end;


procedure TForm1.btn2Click(Sender: TObject);
var
  LController: TControllerPessoas;
begin

  LController := TControllerPessoas.create;

  try
    LController.Delete(DataSource.DataSet.FieldByName('id').AsString);
    datasource.DataSet.Refresh;
  finally
    FreeAndNil(LController);
  end;

end;

procedure TForm1.btn3Click(Sender: TObject);
var
  LController: TControllerPessoas;
begin

  LController := TControllerPessoas.create;

  try

    with FEntidade do
    begin
      tipo_pessoa := edtTipoPessoa.Text;
      nome_completo := edtNomeCompleto.Text;
      data_nascimento := DateToStr(dtpNascimento.Date);
      cpf := edtCpf.Text;
      rg := edtRg.Text;
      email := edtEmail.Text;
      telefone := edtTelefone.Text;
      cep := edtCep.Text;
      logradouro := edtLogradouro.Text;
      bairro := edtBairro.Text;
      cidade := edtCidade.Text;
      estado := edtEstado.Text;

      LController.Update(FEntidade, DataSource.DataSet.FieldByName('id').AsString);
      datasource.DataSet.Refresh;
    end;

    with FEntidadeLog do
    begin
      id_pessoa := DataSource.DataSet.FieldByName('id').AsString;
      descricao := 'Editou:' + DateToStr(Now);
      LController.Log(FEntidadeLog, 'Editou :' + DateToStr(Now));
    end;

  finally
    FreeAndNil(LController);
  end;

end;

procedure TForm1.btn4Click(Sender: TObject);
var
 Limpar : TFunctions;
begin
  Limpar := TFunctions.Create;

  try
    Limpar.LimparTodosEdits(Self);
  finally
   freeandnil(Limpar);
  end;
end;

procedure TForm1.dbgrd1CellClick(Column: TColumn);
begin
  PegaInformacoes;
end;

procedure TForm1.dbgrd1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  PegaInformacoes;
end;

procedure TForm1.dbgrd1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  PegaInformacoes;
end;

procedure TForm1.edtBuscaExit(Sender: TObject);
var
  LController: TControllerPessoas;
begin
  if edtBusca.Text = '' then
  exit;

  LController := TControllerPessoas.create;
  FController := TControllerPessoas.Create;

  try
    LController.BuscaNome(edtBusca.Text);
    FController.DataSet(DataSource).BuscaNome(edtBusca.Text);
    datasource.DataSet.Refresh;
  finally
    FreeAndNil(LController);
  end;

end;

procedure TForm1.edtCepExit(Sender: TObject);
var
  BuscaCep: TFunctions;
begin
  if edtcep.Text = '' then
  exit;

  BuscaCep := TFunctions.Create;
  try

    if not BuscaCep.BuscarCEP(edtCep.Text) then
    begin
      edtCep.SetFocus;
      exit;
    end;

    edtLogradouro.Text := BuscaCep.FLogradouro;
    edtCidade.Text := BuscaCep.FLocalidade;
    edtEstado.Text := BuscaCep.FUF;
    edtBairro.Text := BuscaCep.FBairro;

  finally
    FreeAndNil(BuscaCep);
  end;

end;

procedure TForm1.edtCpfExit(Sender: TObject);
var
  ValidaCPF : TFunctions;
begin
  ValidaCPF := TFunctions.Create;

  try

   if not ValidaCPF.ValidarCPF(edtCpf.Text) then
    if Application.MessageBox('CPF Inválido deseja Continuar?','', MB_YESNO) = IDNO then
     edtcpf.SetFocus;
  finally
    FreeAndNil(ValidaCPF);
  end;
end;

procedure TForm1.edtEmailExit(Sender: TObject);
var
  ValidaEmail : Tfunctions;
begin
  ValidaEmail := Tfunctions.Create;

  try
    if not ValidaEmail.ValidarEmail(edtemail.Text) then
     if Application.MessageBox('Email Inválido deseja Continuar?','', MB_YESNO) = IDNO then
      edtEmail.SetFocus;
  finally
    FreeAndNil(ValidaEmail);
  end;
end;

procedure TForm1.edtRgExit(Sender: TObject);
var
  ValidaRG : Tfunctions;
begin
  ValidaRG := Tfunctions.Create;

  try
    if not ValidaRG.ValidarRG(edtRg.Text) then
     if Application.MessageBox('RG Inválido deseja Continuar?','', MB_YESNO) = IDNO then
      edtRG.SetFocus;
  finally
    FreeAndNil(ValidaRG);
  end;
end;

procedure TForm1.edtTelefoneExit(Sender: TObject);
var
  ValidaTelefone : Tfunctions;
begin
  ValidaTelefone := Tfunctions.Create;

  try
    if not ValidaTelefone.ValidarTelefone(edtTelefone.Text) then
     if Application.MessageBox('Telefone Inválido deseja Continuar?','', MB_YESNO) = IDNO then
      edtTelefone.SetFocus;
  finally
    FreeAndNil(ValidaTelefone);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   FController := TControllerPessoas.Create;
   FEntidade   := TEntidadePessoas.Create;
   FEntidadeLog  := TEntidadeLogs.Create;

   FController
   .DataSet(DataSource)
   .Consulta;
   AutoSizeDBGridColumns;
end;




procedure TForm1.PegaInformacoes;
var
  LController    : TControllerPessoas;
begin

  LController := TControllerPessoas.create;

  try
    with LController.ConsultaID(DataSource.DataSet.FieldByName('id').AsString) do
    begin
      edtTipoPessoa.Text := tipo_pessoa;
      edtNomeCompleto.Text := nome_completo;
      dtpNascimento.Date := StrToDate(data_nascimento);
      edtCpf.Text := cpf;
      edtRg.Text := rg;
      edtEmail.Text := email;
      edtTelefone.Text := telefone;
      edtCep.Text := cep;
      edtLogradouro.Text := logradouro;
      edtBairro.Text := bairro;
      edtCidade.Text := cidade;
      edtEstado.Text := estado;
    end;

    with LController.ConsultaIDLogs(DataSource.DataSet.FieldByName('id').AsString) do
    begin
      mmoLog.Text := descricao;
    end;

  finally
    FreeAndNil(LController);
  end;
end;

procedure TForm1.AutoSizeDBGridColumns;
var
  i: Integer;
  TextWidth: Integer;
  Field: TField;
begin
  for i := 0 to dbgrd1.Columns.Count - 1 do
  begin
    Field := dbgrd1.Columns[i].Field;

    if Assigned(Field) then
    begin
      TextWidth := dbgrd1.Canvas.TextWidth(Field.AsString);
      dbgrd1.Columns[i].Width := TextWidth + 36;
    end;
  end;
end;

end.
