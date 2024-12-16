unit controller.Pessoas;

interface

uses
  entidade.Pessoas, FireDAC.Comp.DataSet, model.pessoas, Data.DB, entidade.log;
   type
     TControllerPessoas = class
       private
       model : TModelPessoas;
       Data  : TDataSource;
       public
       constructor create;
       destructor  destroy; override;
       procedure Insert(Entidade : TEntidadePessoas);
       procedure Update(Entidade : TEntidadePessoas; aValue : string);
       procedure Delete(aValue : String);
       procedure Consulta;
       function  ConsultaID(aValue : string) : TEntidadePessoas;
       function ConsultaIDLogs(aValue : string) : TEntidadeLogs;
       function  DataSet(DataSource : TDataSource) : TControllerPessoas;
       function  Log(Entidade : TEntidadeLogs; aValue: string): string;
       procedure BuscaNome(aValue : string);
     end;

implementation

{ TControllerUsuarios }

procedure TControllerPessoas.BuscaNome(aValue : string);
begin
  model.DataSet(Data).BuscaNome(aValue);
end;

procedure TControllerPessoas.Consulta;
begin
  model.DataSet(Data).Consulta;
end;

function TControllerPessoas.ConsultaID(aValue: string): TEntidadePessoas;
begin
  Result := model.ConsultaID(aValue);
end;

function TControllerPessoas.ConsultaIDLogs(aValue: string): TEntidadeLogs;
begin
  Result := model.ConsultaIDLogs(aValue);
end;

constructor TControllerPessoas.create;
begin
  model := TModelPessoas.Create;
  Data := TDataSource.Create(nil);
end;

function TControllerPessoas.DataSet(
  DataSource: TDataSource): TControllerPessoas;
begin
   Result := Self;
   Data := DataSource;
end;

procedure TControllerPessoas.Delete(aValue: String);
begin
  model.Delete(aValue);
end;

destructor TControllerPessoas.destroy;
begin
  model.Free;
  inherited;

  //PODERIA SER UM FREE AND NIL?
end;

procedure TControllerPessoas.Insert(Entidade: TEntidadePessoas);
begin
  model.Insert(Entidade);
end;

function TControllerPessoas.Log(Entidade: TEntidadeLogs; aValue : string): string;
begin
  model.log(Entidade, aValue);
end;

procedure TControllerPessoas.Update(Entidade: TEntidadePessoas; aValue : string);
begin
  model.Update(Entidade, aValue);
end;

end.
