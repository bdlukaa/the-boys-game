-- TABELA HEROES
-- Essa tabela armazena informações sobre os heróis. Incluindo nome real, nome de herói, características físicas,
-- data e local de nascimento, nível de força, popularidade e status
INSERT INTO heroes (
    real_name,       -- Nome real do herói (ex.: "Billy Butcher")
    hero_name,       -- Nome de herói (ex.: "Homelander")
    gender,          -- Gênero do herói (ex.: "Masculino", "Feminino")
    height,          -- Altura do herói em metros (ex.: 1.85)
    weight,          -- Peso do herói em kg (ex.: 90.0)
    birth_date,      -- Data de nascimento do herói (ex.: "1982-04-03")
    birth_place,     -- Local de nascimento do herói (ex.: "Londres, Reino Unido")
    strength_level,  -- Nível de força do herói (0-100, ex.: 60)
    popularity,      -- Popularidade do herói (0-100, ex.: 80)
    status           -- Status do herói (ex.: "Ativo")
)
VALUES
-- Dados dos heróis principais da série
('Billy Butcher', 'Billy Butcher', 'Masculino', 1.85, 90.0, '1982-04-03', 'Londres, Reino Unido', 60, 80, 'Ativo'),
('Hughie Campbell', 'Hughie Campbell', 'Masculino', 1.78, 75.0, '1994-05-15', 'Pittsburgh, EUA', 40, 70, 'Ativo'),
('Starlight', 'Annie January', 'Feminino', 1.68, 58.0, '1996-10-05', 'Davenport, EUA', 85, 95, 'Ativo'),
('Homelander', 'John', 'Masculino', 1.93, 90.0, '1977-07-01', 'Desconhecido', 100, 100, 'Ativo'),
('Queen Maeve', 'Maeve', 'Feminino', 1.75, 70.0, '1985-06-30', 'Missouri, EUA', 90, 85, 'Ativo'),
('A-Train', 'A-Train', 'Masculino', 1.75, 70.0, '1990-03-29', 'Chicago, EUA', 85, 90, 'Ativo'),
('Black Noir', 'Black Noir', 'Masculino', 1.88, 95.0, '1980-01-01', 'Desconhecido', 90, 85, 'Ativo'),
('The Deep', 'The Deep', 'Masculino', 1.83, 85.0, '1985-07-15', 'Desconhecido', 70, 75, 'Ativo'),
('Stormfront', 'Stormfront', 'Feminino', 1.70, 60.0, '1919-04-20', 'Berlim, Alemanha', 95, 80, 'Ativo'),
('Lamplighter', 'Lamplighter', 'Masculino', 1.80, 80.0, '1988-11-11', 'Desconhecido', 75, 70, 'Ativo'),
('Translucent', 'Translucent', 'Masculino', 1.85, 80.0, '1982-05-05', 'Desconhecido', 80, 75, 'Ativo'),
('Eagle the Archer', 'Eagle the Archer', 'Masculino', 1.90, 85.0, '1987-08-08', 'Desconhecido', 65, 60, 'Ativo'),
('Shockwave', 'Shockwave', 'Masculino', 1.78, 75.0, '1992-09-09', 'Desconhecido', 80, 70, 'Ativo'),
('Cindy', 'Cindy', 'Feminino', 1.65, 55.0, '2000-01-01', 'Desconhecido', 90, 65, 'Ativo'),
('Becca Butcher', 'Becca Butcher', 'Feminino', 1.70, 60.0, '1985-12-12', 'Londres, Reino Unido', 50, 55, 'Ativo'),
('Victoria Neuman', 'Victoria Neuman', 'Feminino', 1.68, 58.0, '1990-10-10', 'Desconhecido', 85, 80, 'Ativo'),
('Gecko', 'Gecko', 'Masculino', 1.75, 70.0, '1989-06-06', 'Desconhecido', 60, 50, 'Ativo'),
('Blindspot', 'Blindspot', 'Masculino', 1.80, 75.0, '1995-03-03', 'Desconhecido', 70, 60, 'Ativo'),
('Mesmer', 'Mesmer', 'Masculino', 1.78, 72.0, '1980-02-02', 'Desconhecido', 65, 55, 'Ativo'),
('Popclaw', 'Popclaw', 'Feminino', 1.70, 60.0, '1987-07-07', 'Desconhecido', 75, 70, 'Ativo'),
('Love Sausage', 'Love Sausage', 'Masculino', 1.95, 100.0, '1970-01-01', 'Rússia', 85, 60, 'Ativo'),
('Soldier Boy', 'Soldier Boy', 'Masculino', 1.85, 90.0, '1920-01-01', 'Desconhecido', 90, 85, 'Ativo'),
('Gunpowder', 'Gunpowder', 'Masculino', 1.80, 80.0, '1985-05-05', 'Desconhecido', 70, 65, 'Ativo'),
('Swatto', 'Swatto', 'Masculino', 1.75, 70.0, '1990-04-04', 'Desconhecido', 60, 55, 'Ativo'),
('Tek Knight', 'Tek Knight', 'Masculino', 1.88, 90.0, '1980-08-08', 'Desconhecido', 85, 75, 'Ativo');

-- TABELA BATTLES
-- Esta tabela armazena o histórico de batalhas, associando cada batalha a um herói
-- com o resultado (Vitória ou Derrota) e a data em que aconteceu
INSERT INTO battles (
    hero_id,        -- ID do herói que participou da batalha (chave estrangeira para heroes)
    battle_result,  -- Resultado da batalha (ex.: "Vitória" ou "Derrota")
    date            -- Data em que a batalha aconteceu
)
VALUES
(1, 'Vitória', '2023-11-15'),  -- Billy Butcher venceu
(2, 'Derrota', '2023-10-11'),  -- Hughie Campbell perdeu
(3, 'Vitória', '2023-11-12'),  -- Starlight venceu
(4, 'Vitória', '2023-11-14'),  -- Homelander venceu
(5, 'Vitória', '2023-11-18');  -- Queen Maeve venceu

-- TABELA POWERS
-- Esta tabela associa os poderes dos heróis, permitindo que cada herói tenha múltiplos poderes
INSERT INTO powers (
    hero_id,       -- ID do herói (chave estrangeira para heroes)
    power_name     -- Nome do poder atribuído ao herói
)
VALUES
(1, 'Força sobre-humana'),                          -- Billy Butcher
(2, 'Sem poderes'),                                 -- Hughie Campbell
(3, 'Controle da luz'),                             -- Starlight
(4, 'Voo, visão de calor, força sobre-humana'),     -- Homelander
(5, 'Força sobre-humana');                          -- Queen Maeve