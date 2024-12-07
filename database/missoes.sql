-- INSERIR MISSÕES
-- Essa instrução adiciona uma nova missão na tabela `missoes`
INSERT INTO missoes (nome, descricao, dificuldade, resultado)
VALUES 
(
    'Missão do Avião',  -- Nome da missão
    'Homelander e Queen Maeve falharam em salvar os passageiros de um avião sequestrado. A missão terminou em tragédia, com ambos decidindo abandonar o resgate.', -- Descrição da missão
    8,                  -- Dificuldade da missão (em uma escala de 1 a 10, por exemplo)
    'Fracasso'          -- Resultado da missão (ex: Sucesso, Fracasso)
);

-- INSERIR ASSOCIAÇÕES ENTRE MISSÕES E HERÓIS
-- Essa instrução associa heróis específicos à missão "Missão do Avião" com base no ID da missão e do herói
INSERT INTO missoes_herois (missao_id, heroi_id)
VALUES 
(
    (SELECT id FROM missoes WHERE nome = 'Missão do Avião'),  -- ID da missão "Missão do Avião"
    (SELECT id FROM heroes WHERE hero_name = 'John')          -- ID do herói "John" (Homelander)
),
(
    (SELECT id FROM missoes WHERE nome = 'Missão do Avião'),  -- ID da missão "Missão do Avião"
    (SELECT id FROM heroes WHERE hero_name = 'Maeve')         -- ID do herói "Maeve" (Queen Maeve)
);

-- CONSULTAS

-- 1. MISSÕES POR DIFICULDADE
-- Retorna todas as missões com uma dificuldade específica, incluindo os nomes dos heróis
SELECT 
    m.*,                                                -- Todas as colunas da tabela "missoes"
    STRING_AGG(h.hero_name, ', ') AS herois_involvidos  -- Nomes dos heróis envolvidos, separados por vírgula
FROM missoes m
JOIN missoes_herois mh ON m.id = mh.missao_id  -- Junta com a tabela de associações (missões-heróis)
JOIN heroes h ON mh.heroi_id = h.id            -- Junta com a tabela "heroes" para obter os nomes dos heróis
WHERE m.dificuldade = 8                        -- Filtra missões com dificuldade igual a 8
GROUP BY m.id                                  -- Agrupa os resultados por missão
ORDER BY m.id;                                 -- Ordena os resultados pelo ID da missão

-- 2. FILTRAR POR NOME DA MISSÃO
-- Retorna uma missão específica com detalhes, incluindo os heróis envolvidos
SELECT 
    m.id,                                      -- ID da missão
    m.nome,                                    -- Nome da missão
    m.descricao,                               -- Descrição da missão
    m.dificuldade,                             -- Dificuldade da missão
    m.resultado,                               -- Resultado da missão
    STRING_AGG(h.hero_name, ', ') AS herois    -- Lista de heróis envolvidos
FROM missoes m
JOIN missoes_herois mh ON m.id = mh.missao_id                   -- Junta com a tabela de associações (missões-heróis)
JOIN heroes h ON mh.heroi_id = h.id                             -- Junta com a tabela "heroes" para obter os nomes dos heróis
WHERE m.nome = 'Missão do Avião'                                -- Filtra a missão pelo nome
GROUP BY m.id, m.nome, m.descricao, m.dificuldade, m.resultado; -- Agrupa por todas as colunas selecionadas da missão

-- 3. FILTRAR POR HERÓIS ENVOLVIDOS
-- Retorna missões que envolvem exatamente um conjunto específico de heróis
SELECT 
    m.*                                                     -- Todas as colunas da tabela "missoes"
FROM missoes m
JOIN missoes_herois mh ON m.id = mh.missao_id               -- Junta com a tabela de associações (missões-heróis)
JOIN heroes h ON mh.heroi_id = h.id                         -- Junta com a tabela "heroes" para obter os nomes dos heróis
WHERE h.hero_name IN ('Hughie Campbell', 'Maeve', 'John')   -- Filtra missões que envolvem esses heróis
GROUP BY m.id                                               -- Agrupa os resultados por missão
HAVING COUNT(DISTINCT h.id) = 3;                            -- Garante que a missão envolva exatamente 3 heróis (especificados no filtro)

-- 4. FILTRAR POR NOME DO HERÓI (APENAS UM HERÓI)
-- Retorna missões em que um herói específico esteve envolvido.
SELECT DISTINCT 
    m.*                                        -- Todas as colunas da tabela "missoes"
FROM missoes m
JOIN missoes_herois mh ON m.id = mh.missao_id  -- Junta com a tabela de associações (missões-heróis)
JOIN heroes h ON mh.heroi_id = h.id            -- Junta com a tabela "heroes" para obter os nomes dos heróis
WHERE h.hero_name = 'John';                    -- Filtra por um herói específico (ex.: "John" - Homelander)