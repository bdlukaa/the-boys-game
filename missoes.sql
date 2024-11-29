-- inserir missoes
    INSERT INTO missoes (nome, descricao, dificuldade, resultado)
    VALUES ('Missão do Avião',
        'Homelander e Queen Maeve falharam em salvar os passageiros de um avião sequestrado. A missão terminou em tragédia, com ambos decidindo abandonar o resgate.',8,'Fracasso');

-- inserir missões e herósi
    INSERT INTO missoes_herois (missao_id, heroi_id)
    VALUES 
    ((SELECT id FROM missoes WHERE nome = 'Missão do Avião'), (SELECT id FROM heroes WHERE hero_name = 'John')),
    ((SELECT id FROM missoes WHERE nome = 'Missão do Avião'), (SELECT id FROM heroes WHERE hero_name = 'Maeve'));


-- selects
    
    -- missões por dificuldade
    SELECT 
        m.*,
        STRING_AGG(h.hero_name, ', ') AS herois_involvidos
    FROM missoes m
    JOIN missoes_herois mh ON m.id = mh.missao_id
    JOIN heroes h ON mh.heroi_id = h.id
    WHERE m.dificuldade = 8
    GROUP BY m.id
    ORDER BY m.id;

    --filtrar por nome da missão, incluindo os heróis envolvidos
    SELECT 
    m.id,m.nome,m.descricao,m.dificuldade,m.resultado,
    STRING_AGG(h.hero_name, ', ') AS herois
    FROM missoes m
    JOIN missoes_herois mh ON m.id = mh.missao_id
    JOIN heroes h ON mh.heroi_id = h.id
    WHERE m.nome = 'Missão do Avião'
    GROUP BY m.id, m.nome, m.descricao, m.dificuldade, m.resultado;


    --filtrar por heróis envolvidos 
    SELECT m.*
    FROM missoes m
    JOIN missoes_herois mh ON m.id = mh.missao_id
    JOIN heroes h ON mh.heroi_id = h.id
    WHERE h.hero_name IN ('Hughie Campbell', 'Maeve', 'John')
    GROUP BY m.id
    HAVING COUNT(DISTINCT h.id) = 3--(x);   -- colocar a quantidade de heróis em que deseja filtrar.
                                            -- caso a quantidade de nomes seja maior que o numero colocado(x),
                                            -- a query retornará todas as missões que possuem exclusivamente 
                                            -- as combinações com o exato número de (x).

    --filtrar por nome do herói(apenas 1, acho que é melhor usar só o de cima, já que já vai ser dinamico de qualquer forma)
    SELECT DISTINCT m.*
    FROM missoes m
    JOIN missoes_herois mh ON m.id = mh.missao_id
    JOIN heroes h ON mh.heroi_id = h.id
    WHERE h.hero_name = 'John';