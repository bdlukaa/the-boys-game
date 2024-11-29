-- Inserir tipos de crimes
    INSERT INTO crime (nome)
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

-- Inserir o crime na tabela de ocorrências
    INSERT INTO ocorrencias (heroi_id, crime_id, descricao, data_crime, severidade)
    VALUES 
    ((SELECT id FROM heroes WHERE hero_name ='Maeve'), 
        (SELECT id FROM crime WHERE nome ='Conspiração'), 
        'Trabalhou secretamente com Hughie e os Boys contra a Vought.',
         CURRENT_DATE, 5);


-- selects

SELECT * FROM ocorrencias;

-- crimes cometidos agrupados por heroi em ordem da quantidade de crimes
SELECT 
    h.hero_name AS heroi_nome,
    STRING_AGG(c.nome, ', ') AS crimes_cometidos,
    COUNT(c.id) AS total_crimes
FROM ocorrencias AS o 
JOIN heroes AS h ON o.heroi_id = h.id
JOIN crime AS c ON o.crime_id = c.id
GROUP BY 
    h.id, h.hero_name
ORDER BY 
    total_crimes DESC;

-- crimes cometidos por heroi
SELECT 
    c.nome AS crime_nome,
    o.descricao AS crime_descricao,
    o.data_crime AS crime_data,
    o.severidade
FROM ocorrencias AS o
JOIN heroes AS h ON o.heroi_id = h.id
JOIN crime AS c ON o.crime_id = c.id
WHERE 
    h.hero_name = 'Billy Butcher'

-- crimes por severidade
SELECT 
    c.nome AS crime_nome,
    o.descricao AS crime_descricao,
    o.data_crime AS crime_data,
    o.severidade
FROM ocorrencias AS o
JOIN heroes AS h ON o.heroi_id = h.id
JOIN crime AS c ON o.crime_id = c.id
WHERE 
    o.severidade = 3 -- alterar para a severidade que quiser
ORDER BY 
    o.data_crime DESC;