-- tabela heroes
INSERT INTO heroes (real_name, hero_name, gender, height, weight, birth_date, birth_place, strength_level, popularity, status)
VALUES
('Billy Butcher', 'Billy Butcher', 'Masculino', 1.85, 90.0, '1982-04-03', 'Londres, Reino Unido', 60, 80, 'Ativo'),
('Hughie Campbell', 'Hughie Campbell', 'Masculino', 1.78, 75.0, '1994-05-15', 'Pittsburgh, EUA', 40, 70, 'Ativo'),
('Starlight', 'Annie January', 'Feminino', 1.68, 58.0, '1996-10-05', 'Davenport, EUA', 85, 95, 'Ativo'),
('Homelander', 'John', 'Masculino', 1.93, 90.0, '1977-07-01', 'Desconhecido', 100, 100, 'Ativo'),
('Queen Maeve', 'Maeve', 'Feminino', 1.75, 70.0, '1985-06-30', 'Missouri, EUA', 90, 85, 'Ativo');

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
