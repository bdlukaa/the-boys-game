CREATE TABLE crime (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE ocorrencias (
    id SERIAL PRIMARY KEY,                
    descricao TEXT,               
    data_crime DATE NOT NULL,              
    severidade SMALLINT NOT NULL CHECK (severidade BETWEEN 1 AND 10),
    heroi_id INT NOT NULL,
    crime_id INT NOT NULL,
    CONSTRAINT fk_heroi FOREIGN KEY (heroi_id) REFERENCES heroes(id) ON DELETE SET NULL,
    CONSTRAINT fk_crime FOREIGN KEY (crime_id) REFERENCES crime(id) ON DELETE SET NULL
);

CREATE TABLE missoes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    dificuldade SMALLINT NOT NULL CHECK (dificuldade BETWEEN 1 AND 10),
    resultado VARCHAR(10) NOT NULL CHECK (resultado IN ('Sucesso', 'Fracasso')),
);
CREATE TABLE missoes_herois (
    id SERIAL PRIMARY KEY,
    missao_id INT NOT NULL,
    heroi_id INT NOT NULL,
    CONSTRAINT fk_missao FOREIGN KEY (missao_id) REFERENCES missoes(id) ON DELETE SET NULL,
    CONSTRAINT fk_heroi FOREIGN KEY (heroi_id) REFERENCES heroes(id) ON DELETE SET NULL,
    CONSTRAINT unique_missao_heroi UNIQUE (missao_id, heroi_id)
);