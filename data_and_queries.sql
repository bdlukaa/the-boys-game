-- tabela heroes
INSERT INTO heroes (real_name, hero_name, gender, height, weight, birth_date, birth_place, strength_level, popularity, status)
VALUES
('Billy Butcher', 'Billy Butcher', 'Masculino', 1.85, 90.0, '1982-04-03', 'Londres, Reino Unido', 60, 80, 'Ativo'),
('Hughie Campbell', 'Hughie Campbell', 'Masculino', 1.78, 75.0, '1994-05-15', 'Pittsburgh, EUA', 40, 70, 'Ativo'),
('Starlight', 'Annie January', 'Feminino', 1.68, 58.0, '1996-10-05', 'Davenport, EUA', 85, 95, 'Ativo'),
('Homelander', 'John', 'Masculino', 1.93, 90.0, '1977-07-01', 'Desconhecido', 100, 100, 'Ativo'),
('Queen Maeve', 'Maeve', 'Feminino', 1.75, 70.0, '1985-06-30', 'Missouri, EUA', 90, 85, 'Ativo');
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

-- tabela battles
INSERT INTO battles (hero_id, battle_result, date)
VALUES
(1, 'Vitória', '2023-11-15'),
(2, 'Derrota', '2023-10-11'),
(3, 'Vitória', '2023-11-12'),
(4, 'Vitória', '2023-11-14'),
(5, 'Vitória', '2023-11-18');

-- tabela powers
INSERT INTO powers (hero_id, power_name)
VALUES
(1, 'Força sobre-humana'),
(2, 'Sem poderes'),
(3, 'Controle da luz'),
(4, 'Voo, visão de calor, força sobre-humana'),
(5, 'Força sobre-humana');
