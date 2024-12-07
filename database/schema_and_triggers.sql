-- CRIAÇÃO DO BANCO DE DADOS
-- Cria o banco de dados chamado "heroes"
CREATE DATABASE heroes;

-- TABELA HEROES
-- Tabela principal que armazena informações sobre os heróis
CREATE TABLE heroes (
    id SERIAL PRIMARY KEY,                                        -- ID único do herói (chave primária)
    real_name VARCHAR(100) NOT NULL,                              -- Nome real do herói (obrigatório)
    hero_name VARCHAR(100) NOT NULL,                              -- Nome do herói (como é conhecido) - obrigatório
    gender VARCHAR(10),                                           -- Gênero do herói (ex.: Masculino, Feminino)
    height DECIMAL(5,2),                                          -- Altura do herói em metros (ex.: 1.85)
    weight DECIMAL(5,2),                                          -- Peso do herói em quilogramas (ex.: 90.0)
    birth_date DATE,                                              -- Data de nascimento do herói
    birth_place VARCHAR(100),                                     -- Local de nascimento do herói
    strength_level INT CHECK (strength_level BETWEEN 0 AND 100),  -- Nível de força (0 a 100)
    popularity INT CHECK (popularity BETWEEN 0 AND 100),          -- Popularidade (0 a 100)
    status VARCHAR(20) DEFAULT 'Ativo'                            -- Status do herói (Ativo, Banido, Morto) - padrão: "Ativo"
);

-- TABELA BATTLES
-- Tabela que registra batalhas associadas a cada herói
CREATE TABLE battles (
    id SERIAL PRIMARY KEY,                                                      -- ID único da batalha (chave primária)
    hero_id INT REFERENCES heroes(id),                                          -- ID do herói (chave estrangeira para heroes)
    battle_result VARCHAR(10) CHECK (battle_result IN ('Vitória', 'Derrota')),  -- Resultado da batalha
    date DATE NOT NULL                                                          -- Data da batalha (obrigatória)
);

-- TABELA POWERS
-- Tabela que associa heróis a seus poderes
CREATE TABLE powers (
    id SERIAL PRIMARY KEY,                       -- ID único do poder (chave primária)
    hero_id INT REFERENCES heroes(id),           -- ID do herói (chave estrangeira para heroes)
    power_name VARCHAR(100) NOT NULL             -- Nome do poder (ex.: "Voo", "Força sobre-humana")
);

-- TRIGGER PARA ATUALIZAR O STATUS DO HERÓI

-- Função associada à trigger
-- Esta função será chamada sempre que ocorrer uma atualização em certas colunas da tabela `heroes`
-- Se a popularidade do herói for menor que 20 ou se ele tiver mais de 5 derrotas, seu status será alterado para "Banido"
CREATE OR REPLACE FUNCTION update_hero_status() RETURNS TRIGGER AS $$
BEGIN
    -- Verifica as condições para alterar o status do herói
    IF NEW.popularity < 20 OR (SELECT COUNT(*) FROM battles WHERE hero_id = NEW.id AND battle_result = 'Derrota') > 5 THEN
        NEW.status := 'Banido';  -- Altera o status para "Banido"
    ELSE
        NEW.status := 'Ativo';   -- Mantém o status como "Ativo"
    END IF;
    RETURN NEW;                  -- Retorna o registro atualizado
END;
$$ LANGUAGE plpgsql;

-- Trigger associada à tabela "heroes"
-- Esta trigger chama a função `update_hero_status` após atualizações na popularidade ou ID do herói
CREATE TRIGGER hero_status_update
AFTER UPDATE OF popularity, id ON heroes    -- A trigger será acionada após atualizações na popularidade ou no ID
FOR EACH ROW                                -- A trigger é executada para cada linha alterada
EXECUTE FUNCTION update_hero_status();      -- Chama a função `update_hero_status`