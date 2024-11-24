CREATE DATABASE heroes;

CREATE TABLE heroes (
    id SERIAL PRIMARY KEY,                      -- ID único do herói
    real_name VARCHAR(100) NOT NULL,            -- Nome real do herói
    hero_name VARCHAR(100) NOT NULL,            -- Nome de herói (como é conhecido)
    gender VARCHAR(10),                         -- Gênero do herói
    height DECIMAL(5,2),                        -- Altura do herói (em metros)
    weight DECIMAL(5,2),                        -- Peso do herói (em kg)
    birth_date DATE,                            -- Data de nascimento do herói
    birth_place VARCHAR(100),                   -- Local de nascimento
    strength_level INT CHECK (strength_level BETWEEN 0 AND 100),  -- Nível de força (0 a 100)
    popularity INT CHECK (popularity BETWEEN 0 AND 100),          -- Popularidade (0 a 100)
    status VARCHAR(20) DEFAULT 'Ativo'          -- Status do herói (Ativo, Banido, Morto)
);

CREATE TABLE battles (
    id SERIAL PRIMARY KEY,                      
    hero_id INT REFERENCES heroes(id),          
    battle_result VARCHAR(10) CHECK (battle_result IN ('Vitória', 'Derrota')), 
    date DATE NOT NULL                          
);


CREATE TABLE powers (
    id SERIAL PRIMARY KEY,                      
    hero_id INT REFERENCES heroes(id),          
    power_name VARCHAR(100) NOT NULL            
);


-- trigger

-- função que será chamada pela trigger p/ atualizar status
CREATE OR REPLACE FUNCTION update_hero_status() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.popularity < 20 OR (SELECT COUNT(*) FROM battles WHERE hero_id = NEW.id AND battle_result = 'Derrota') > 5 THEN
        NEW.status := 'Banido';
    ELSE
        NEW.status := 'Ativo';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- trigger q chama a função update_hero_status após uma atualização na tabela "heroes"
CREATE TRIGGER hero_status_update
AFTER UPDATE OF popularity, id ON heroes
FOR EACH ROW
EXECUTE FUNCTION update_hero_status();


