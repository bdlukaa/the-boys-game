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

-- Buscar o ID do herói pelo nome (necessario realizar antes da inserção de um novo crime)
    SELECT id FROM heroes 
    WHERE hero_name ='Starlight';

-- Buscar o ID do crime pelo nome (necessario realizar antes da inserção de um novo crime)
    SELECT id FROM crime 
    WHERE nome ='Conspiração';

-- Inserir o crime na tabela de ocorrências
    INSERT INTO ocorrencias (heroi_id, crime_id, descricao, data_crime, severidade)
    VALUES (heroi_id, crime_id, 'Trabalhou secretamente com Hughie e os Boys contra a Vought.', CURRENT_DATE, 3);



-- insira no sql pra visualizar o comportamento caso precise
DO $$
DECLARE
    heroi_id INT;
    crime_id INT;
BEGIN
    -- Buscar o ID do herói pelo nome
    SELECT id INTO heroi_id 
    FROM heroes
    WHERE hero_name ='John';

    -- Verificar se o herói foi encontrado
    IF heroi_id IS NULL THEN
        RAISE EXCEPTION 'Herói não encontrado';
		RAISE NOTICE 'Heroi ID é %', heroi_id;
    END IF;

    -- Buscar o ID do crime pelo nome
    SELECT id INTO crime_id 
    FROM crime
    WHERE nome ='Sequestro';

    -- Verificar se o crime foi encontrado
    IF crime_id IS NULL THEN
        RAISE EXCEPTION 'Crime não encontrado';
		RAISE NOTICE 'Crime ID é %', crime_id;
    END IF;

    -- Inserir o crime na tabela de ocorrências
    INSERT INTO ocorrencias (heroi_id, crime_id, descricao, data_crime, severidade)
    VALUES (heroi_id, crime_id, 'iriri', CURRENT_DATE, 3);

END $$;

SELECT * FROM ocorrencias ;


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
    o.severidade = 3
ORDER BY 
    o.data_crime DESC;