-- TABELA CRIME
-- Essa tabela armazena os diferentes tipos de crimes que podem ser associados a heróis
CREATE TABLE crime (
    id SERIAL PRIMARY KEY,            -- ID único do crime (chave primária)
    nome VARCHAR(100) NOT NULL UNIQUE -- Nome do crime (ex.: "Roubo", "Sequestro") - obrigatório e único
);

-- TABELA OCORRÊNCIAS
-- Essa tabela registra as ocorrências de crimes associadas a heróis
CREATE TABLE ocorrencias (
    id SERIAL PRIMARY KEY,                -- ID único da ocorrência (chave primária)
    descricao TEXT,                       -- Descrição detalhada do crime
    data_crime DATE NOT NULL,             -- Data em que o crime ocorreu (obrigatória)
    severidade SMALLINT NOT NULL CHECK (severidade BETWEEN 1 AND 10), -- Nível de severidade do crime (1 a 10)
    heroi_id INT NOT NULL,                -- ID do herói associado (chave estrangeira)
    crime_id INT NOT NULL,                -- ID do tipo de crime (chave estrangeira)
    CONSTRAINT fk_heroi FOREIGN KEY (heroi_id) REFERENCES heroes(id) ON DELETE SET NULL, -- Se o herói for removido, define NULL
    CONSTRAINT fk_crime FOREIGN KEY (crime_id) REFERENCES crime(id) ON DELETE SET NULL   -- Se o tipo de crime for removido, define NULL
);

-- TABELA MISSÕES
-- Essa tabela armazena as missões realizadas pelos heróis
CREATE TABLE missoes (
    id SERIAL PRIMARY KEY,                 -- ID único da missão (chave primária)
    nome VARCHAR(100) NOT NULL UNIQUE,     -- Nome da missão (ex.: "Missão do Avião") - obrigatório e único
    descricao TEXT,                        -- Descrição detalhada da missão
    dificuldade SMALLINT NOT NULL CHECK (dificuldade BETWEEN 1 AND 10),         -- Nível de dificuldade da missão (1 a 10)
    resultado VARCHAR(10) NOT NULL CHECK (resultado IN ('Sucesso', 'Fracasso')) -- Resultado da missão (Sucesso ou Fracasso)
);

-- TABELA MISSÕES_HERÓIS
-- Essa tabela associa heróis a missões realizadas, permitindo que múltiplos heróis participem de uma missão
CREATE TABLE missoes_herois (
    id SERIAL PRIMARY KEY,                 -- ID único da associação (chave primária)
    missao_id INT NOT NULL,                -- ID da missão (chave estrangeira)
    heroi_id INT NOT NULL,                 -- ID do herói (chave estrangeira)
    CONSTRAINT fk_missao FOREIGN KEY (missao_id) REFERENCES missoes(id) ON DELETE SET NULL, -- Se a missão for removida, define NULL
    CONSTRAINT fk_heroi FOREIGN KEY (heroi_id) REFERENCES heroes(id) ON DELETE SET NULL,    -- Se o herói for removido, define NULL
    CONSTRAINT unique_missao_heroi UNIQUE (missao_id, heroi_id)                             -- Garante que um herói só participe de uma missão uma vez
);