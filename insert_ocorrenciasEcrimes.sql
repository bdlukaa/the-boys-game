-- Inserir tipos de crimes
    INSERT INTO tipos_crimes (nome)
    VALUES 
        ('Homicídio'),
        ('Sequestro'),
        ('Terrorismo'),
        ('Posse ilegal de armas'),
        ('Vandalismo'),
        ('Conspiração'),
        ('Invasão de propriedade'),
        ('Roubo'),
        ('Genocídio'),
        ('Estupro'),
        ('Extorsão'),
        ('Agressão');



-- inserir ocorrencias

-- Buscar o ID do herói pelo nome (necessario realizar antes da inserção de um novo crime)
    SELECT id FROM heroes 
    WHERE hero_name ='Starlight';

-- Buscar o ID do crime pelo nome (necessario realizar antes da inserção de um novo crime)
    SELECT id FROM tipos_crimes 
    WHERE nome ='Conspiração';

-- Inserir o crime na tabela de ocorrências
    INSERT INTO ocorrencias (heroi_id, crime_id, descricao, data_crime, severidade)
    VALUES (heroi_id, crime_id, 'Trabalhou secretamente com Hughie e os Boys contra a Vought.', CURRENT_DATE, 3);


