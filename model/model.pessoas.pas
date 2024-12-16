unit model.pessoas;

interface
   uses
     FireDAC.Comp.DataSet, entidade.log, entidade.Pessoas, FireDAC.Comp.Client, uDataModule, system.SysUtils,
     Data.DB;
   type
   TModelPessoas = class
     private
       FQuery : TFDQuery;
       FEntidade  : TEntidadePessoas;
       FEntidadeL : TEntidadeLogs;
       FData : TDataSource;
     public
     constructor Create;
     destructor  Destroy; override;
     procedure Insert(Entidade : TEntidadePessoas);
     function  log(EntidadeL : TEntidadeLogs; aValue : string): string;
     procedure Update(Entidade : TEntidadePessoas; aValue : string);
     procedure Delete(aValue : String);
     procedure Consulta;
     procedure BuscaNome(aValue : string);
     function ConsultaID(aValue : string) : TEntidadePessoas;
     function ConsultaIDLogs(aValue : string) : TEntidadeLogs;
     function DataSet(DataSet : TDataSource): TModelPessoas;

   end;
implementation

{ TModelUsuarios }

procedure TModelPessoas.BuscaNome(aValue : string);
begin
  with FQuery do
  begin
    Close;
    Sql.clear;
    Sql.add('SELECT CAST(id AS VARCHAR) AS ID, '
          + ' CAST(tipo_pessoa AS VARCHAR) AS Tipo, '
          + ' CAST(nome_completo AS VARCHAR) AS Nome, '
          + ' CAST(data_nascimento AS VARCHAR) AS "Data Nascimento", '
          + ' CAST(cpf AS VARCHAR) AS CPF, '
          + ' CAST(rg AS VARCHAR) AS RG, '
          + ' CAST(email AS VARCHAR) AS Email, '
          + ' CAST(telefone AS VARCHAR) AS Telefone, '
          + ' CAST(cep AS VARCHAR) AS Cep, '
          + ' CAST(logradouro AS VARCHAR) AS Logradouro, '
          + ' CAST(bairro AS VARCHAR) AS Bairro, '
          + ' CAST(cidade AS VARCHAR) AS Cidade, '
          + ' CAST(estado AS VARCHAR) AS Estado'
          + ' FROM pessoas WHERE nome_completo like ''% ' + aValue + ' %'' ');

    try
        Open;
    except
        on E: Exception do
        begin
          raise Exception.Create('Erro ao executar SQL: ' + E.Message + ' SQL: ' + Sql.Text);
        end;
    end;
  end;
end;

procedure TModelPessoas.Consulta;
begin
  with FQuery do
  begin
    Close;
    Sql.clear;
    Sql.add('SELECT CAST(id AS VARCHAR) AS ID, '
          + ' CAST(tipo_pessoa AS VARCHAR) AS Tipo, '
          + ' CAST(nome_completo AS VARCHAR) AS Nome, '
          + ' CAST(data_nascimento AS VARCHAR) AS "Data Nascimento", '
          + ' CAST(cpf AS VARCHAR) AS CPF, '
          + ' CAST(rg AS VARCHAR) AS RG, '
          + ' CAST(email AS VARCHAR) AS Email, '
          + ' CAST(telefone AS VARCHAR) AS Telefone, '
          + ' CAST(cep AS VARCHAR) AS Cep, '
          + ' CAST(logradouro AS VARCHAR) AS Logradouro, '
          + ' CAST(bairro AS VARCHAR) AS Bairro, '
          + ' CAST(cidade AS VARCHAR) AS Cidade, '
          + ' CAST(estado AS VARCHAR) AS Estado'
          + ' FROM pessoas;');

    try
        Open;
    except
        on E: Exception do
        begin
          raise Exception.Create('Erro ao executar SQL: ' + E.Message + ' SQL: ' + Sql.Text);
        end;
    end;
  end;
end;

function TModelPessoas.ConsultaID(aValue: string): TEntidadePessoas;
begin

   with FQuery, FEntidade do
   begin
     close;
     sql.clear;
     Sql.add('select * from pessoas where id = ' + QuotedStr(aValue));
     Open;

     FEntidade.id := FieldByName('id').AsString;
     FEntidade.tipo_pessoa := FieldByName('tipo_pessoa').AsString;
     FEntidade.nome_completo := FieldByName('nome_completo').AsString;
     FEntidade.data_nascimento := FieldByName('data_nascimento').AsString;
     FEntidade.cpf := FieldByName('cpf').AsString;
     FEntidade.rg := FieldByName('rg').AsString;
     FEntidade.email := FieldByName('email').AsString;
     FEntidade.telefone := FieldByName('telefone').AsString;
     FEntidade.cep := FieldByName('cep').AsString;
     FEntidade.logradouro := FieldByName('logradouro').AsString;
     FEntidade.bairro := FieldByName('bairro').AsString;
     FEntidade.cidade := FieldByName('cidade').AsString;
     FEntidade.estado := FieldByName('estado').AsString;

     Result := FEntidade;
   end;

   // FAZER COM TRY EXCEPT
end;

function TModelPessoas.ConsultaIDLogs(aValue: string): TEntidadeLogs;
begin

   with FQuery, FEntidadeL do
   begin
     close;
     sql.clear;
     Sql.add('select * from log where id_pessoa = ' + QuotedStr(aValue));
     Open;

     FEntidadeL.id := FieldByName('id').AsString;
     FEntidadeL.id_pessoa := FieldByName('id_pessoa').AsString;
     FEntidadeL.descricao := FieldByName('descricao').AsString;

     Result := FEntidadeL;
   end;
end;

constructor TModelPessoas.Create;
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := dm.con1;
  FData := TDataSource.Create(nil);
  FEntidade  := TEntidadePessoas.Create;
  FEntidadeL := TEntidadeLogs.Create;
end;

function TModelPessoas.DataSet(DataSet: TDataSource): TModelPessoas;
begin
   result := Self;
   DataSet.DataSet := FQuery;
end;

procedure TModelPessoas.Delete(aValue: String);
begin
 with FQuery do
 begin
    Close;

    Sql.Text := 'DELETE FROM pessoas WHERE id = :id';

    ParamByName('id').AsString := aValue;

    ExecSQL
 end;

end;

destructor TModelPessoas.Destroy;
begin
  FreeAndNil(FData);
  FreeAndNil(FQuery);
  FreeAndNil(FEntidade);
  FreeAndNil(FEntidadeL);
  inherited;
end;

procedure TModelPessoas.Insert(Entidade: TEntidadePessoas);
begin
  with FQuery do
  begin
    close;

    try
      Sql.Text := 'SELECT COUNT(*) FROM pessoas WHERE cpf = :cpf';
      ParamByName('cpf').AsString := Entidade.cpf;
      Open;

      if Fields[0].AsInteger > 0 then
      begin
        raise Exception.Create('Erro: CPF já cadastrado!');
      end;


      Sql.Clear;
      Sql.Text := ' insert into pessoas (tipo_pessoa, nome_completo, data_nascimento, ' + ' cpf, rg, email, telefone, cep, logradouro, bairro, cidade, estado) values ' + ' (:tipo_pessoa, :nome_completo, :data_nascimento, :cpf, :rg, :email, ' + ' :telefone, :cep, :logradouro, :bairro, :cidade, :estado)';

//     ParamByName('id').AsString;
      ParamByName('tipo_pessoa').AsString := Entidade.tipo_pessoa;

      ParamByName('nome_completo').AsString := Entidade.nome_completo;

      ParamByName('data_nascimento').AsString := Entidade.data_nascimento;

      ParamByName('cpf').AsString := Entidade.cpf;

      ParamByName('rg').AsString := Entidade.rg;

      ParamByName('email').AsString := Entidade.email;

      ParamByName('telefone').AsString := Entidade.telefone;

      ParamByName('cep').AsString := Entidade.cep;

      ParamByName('logradouro').AsString := Entidade.logradouro;

      ParamByName('bairro').AsString := Entidade.bairro;

      ParamByName('cidade').AsString := Entidade.cidade;

      ParamByName('estado').AsString := Entidade.estado;

     try
        ExecSQL;
     except
        on E: Exception do
        begin
          raise Exception.Create('Erro ao executar SQL: ' + E.Message + ' SQL: ' + Sql.Text);
        end;
     end;

    except
      on E: Exception do
      begin
        raise Exception.Create('Erro ao inserir no banco de dados: ' + E.Message);
      end;
    end;
  end;

end;

function TModelPessoas.log(EntidadeL: TEntidadeLogs; aValue : string): string;
begin
  with Fquery do
  begin
    Sql.Clear;
    Sql.Text := ' insert into log (id_pessoa, descricao) values '
              + ' (:id_pessoa, :descricao)';

    ParamByName('id_pessoa').AsString := EntidadeL.id_pessoa;
    ParamByName('descricao').AsString := EntidadeL.descricao;


    try
        ExecSQL;
     except
        on E: Exception do
        begin
          raise Exception.Create('Erro ao executar SQL: ' + E.Message + ' SQL: ' + Sql.Text);
        end;
    end;
  end;
end;

procedure TModelPessoas.Update(Entidade: TEntidadePessoas; aValue : string);
begin
  with FQuery do
  begin
    close;

    try
      Sql.Clear;
      Sql.Text := ' update pessoas set tipo_pessoa = :tipo_pessoa, nome_completo = :nome_completo, '
                + ' data_nascimento = :data_nascimento, cpf = :cpf, rg = :rg, email = :email, '
                + ' telefone = :telefone, cep = :cep, logradouro = :logradouro, bairro = :bairro, '
                + ' cidade = :cidade, estado = :estado where  id = ' + aValue;

//     ParamByName('id').AsString;
      ParamByName('tipo_pessoa').AsString := Entidade.tipo_pessoa;

      ParamByName('nome_completo').AsString := Entidade.nome_completo;

      ParamByName('data_nascimento').AsString := Entidade.data_nascimento;

      ParamByName('cpf').AsString := Entidade.cpf;

      ParamByName('rg').AsString := Entidade.rg;

      ParamByName('email').AsString := Entidade.email;

      ParamByName('telefone').AsString := Entidade.telefone;

      ParamByName('cep').AsString := Entidade.cep;

      ParamByName('logradouro').AsString := Entidade.logradouro;

      ParamByName('bairro').AsString := Entidade.bairro;

      ParamByName('cidade').AsString := Entidade.cidade;

      ParamByName('estado').AsString := Entidade.estado;

     try
        ExecSQL;
     except
        on E: Exception do
        begin
          raise Exception.Create('Erro ao executar SQL: ' + E.Message + ' SQL: ' + Sql.Text);
        end;
     end;

    except
      on E: Exception do
      begin
        raise Exception.Create('Erro ao inserir no banco de dados: ' + E.Message);
      end;
    end;
  end;

end;

end.
