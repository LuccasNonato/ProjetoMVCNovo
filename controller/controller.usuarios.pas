unit controller.usuarios;

interface

uses
  entidade.Pessoas, FireDAC.Comp.DataSet, model.pessoas, Data.DB;
   type
     TControllerPessoas = class
       private
       model : TModelPessoas;
       Data  : TDataSource;
       public
       constructor create;
       destructor  destroy; override;
       procedure Insert(Entidade : TEntidadePessoas);
       procedure Update(Entidade : TEntidadePessoas);
       procedure Delete(aValue : String);
       procedure Consulta;
       function  ConsultaID(aValue : string) : TEntidadePessoas;
       function  DataSet(DataSource : TDataSource) : TControllerPessoas;
     end;

implementation

{ TControllerUsuarios }

procedure TControllerPessoas.Consulta;
begin
  model.DataSet(Data).Consulta;
end;

function TControllerPessoas.ConsultaID(aValue: string): TEntidadePessoas;
begin
  Result := model.ConsultaID(aValue);
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

procedure TControllerPessoas.Update(Entidade: TEntidadePessoas);
begin

end;

end.
