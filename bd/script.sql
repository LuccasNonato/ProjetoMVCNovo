CREATE TABLE Pessoas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo_pessoa TEXT NOT NULL,
    nome_completo TEXT NOT NULL,
    data_nascimento TEXT NOT NULL,
    cpf TEXT NOT NULL UNIQUE,
    rg TEXT,
    email TEXT NOT NULL,
    telefone TEXT NOT NULL,
    cep TEXT NOT NULL,
    logradouro TEXT NOT NULL,
    bairro TEXT NOT NULL,
    cidade TEXT NOT NULL,
    estado TEXT NOT NULL
);

CREATE TABLE LOG (
    ID_PESSOA TEXT (10),
    DESCRICAO TEXT (255),
    id        INTEGER    PRIMARY KEY AUTOINCREMENT
);
