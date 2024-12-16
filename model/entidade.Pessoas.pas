unit entidade.Pessoas;

interface

type
  TEntidadePessoas = class
  private
    Flogradouro: string;
    Frg: string;
    Fbairro: string;
    Femail: string;
    Fcpf: string;
    Fnome_completo: string;
    Fcep: string;
    Fid: string;
    Ftipo_pessoa: string;
    Fdata_nascimento: string;
    Fcidade: string;
    Festado: string;
    Ftelefone: string;
    procedure Setbairro(const Value: string);
    procedure Setcep(const Value: string);
    procedure Setcidade(const Value: string);
    procedure Setcpf(const Value: string);
    procedure Setdata_nascimento(const Value: string);
    procedure Setemail(const Value: string);
    procedure Setestado(const Value: string);
    procedure Setid(const Value: string);
    procedure Setlogradouro(const Value: string);
    procedure Setnome_completo(const Value: string);
    procedure Setrg(const Value: string);
    procedure Settelefone(const Value: string);
    procedure Settipo_pessoa(const Value: string);
  published
    property id: string read Fid write Setid;
    property tipo_pessoa: string read Ftipo_pessoa write Settipo_pessoa;
    property nome_completo: string read Fnome_completo write Setnome_completo;
    property data_nascimento: string read Fdata_nascimento write Setdata_nascimento;
    property cpf: string read Fcpf write Setcpf;
    property rg: string read Frg write Setrg;
    property email: string read Femail write Setemail;
    property telefone: string read Ftelefone write Settelefone;
    property cep: string read Fcep write Setcep;
    property logradouro: string read Flogradouro write Setlogradouro;
    property bairro: string read Fbairro write Setbairro;
    property cidade: string read Fcidade write Setcidade;
    property estado: string read Festado write Setestado;
  end;

implementation

{ TEntidadeUsuario }

procedure TEntidadePessoas.Setbairro(const Value: string);
begin
  Fbairro := Value;
end;

procedure TEntidadePessoas.Setcep(const Value: string);
begin
  Fcep := Value;
end;

procedure TEntidadePessoas.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure TEntidadePessoas.Setcpf(const Value: string);
begin
  Fcpf := Value;
end;

procedure TEntidadePessoas.Setdata_nascimento(const Value: string);
begin
  Fdata_nascimento := Value;
end;

procedure TEntidadePessoas.Setemail(const Value: string);
begin
  Femail := Value;
end;

procedure TEntidadePessoas.Setestado(const Value: string);
begin
  Festado := Value;
end;

procedure TEntidadePessoas.Setid(const Value: string);
begin
  Fid := Value;
end;

procedure TEntidadePessoas.Setlogradouro(const Value: string);
begin
  Flogradouro := Value;
end;

procedure TEntidadePessoas.Setnome_completo(const Value: string);
begin
  Fnome_completo := Value;
end;

procedure TEntidadePessoas.Setrg(const Value: string);
begin
  Frg := Value;
end;

procedure TEntidadePessoas.Settelefone(const Value: string);
begin
  Ftelefone := Value;
end;

procedure TEntidadePessoas.Settipo_pessoa(const Value: string);
begin
  Ftipo_pessoa := Value;
end;

end.

