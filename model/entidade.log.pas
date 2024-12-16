unit entidade.log;

interface

type
  TEntidadeLogs = class
  private

    FDescricao: string;
    Fid: string;
    FId_pessoa: string;
    procedure SetDescricao(const Value: string);
    procedure Setid(const Value: string);
    procedure SetID_pessoa(const Value: string);
  published
    property id: string read Fid write Setid;
    property descricao: string read FDescricao write SetDescricao;
    property id_pessoa: string read FId_pessoa write FId_pessoa;
  end;

implementation

{ TEntidadeLogs }

procedure TEntidadeLogs.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TEntidadeLogs.Setid(const Value: string);
begin
  Fid := Value;
end;

procedure TEntidadeLogs.SetID_pessoa(const Value: string);
begin
  FId_pessoa := Value;
end;

end.

