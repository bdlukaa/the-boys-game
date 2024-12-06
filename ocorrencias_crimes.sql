-- INSERIR TIPOS DE CRIMES
-- Essa instrução insere os diferentes tipos de crimes na tabela "crime"
INSERT INTO crime (nome)
VALUES 
    ('Homicídio'),               -- Crime de homicídio
    ('Sequestro'),               -- Crime de sequestro
    ('Terrorismo'),              -- Crime de terrorismo
    ('Posse ilegal de armas'),   -- Crime de posse ilegal de armas
    ('Vandalismo'),              -- Crime de vandalismo
    ('Conspiração'),             -- Crime de conspiração
    ('Invasão de propriedade'),  -- Crime de invasão de propriedade
    ('Roubo'),                   -- Crime de roubo
    ('Genocídio'),               -- Crime de genocídio
    ('Estupro'),                 -- Crime de estupro
    ('Extorsão'),                -- Crime de extorsão
    ('Agressão');                -- Crime de agressão

-- INSERIR OCORRÊNCIAS DE CRIMES
-- Esta instrução insere uma ocorrência de crime na tabela "ocorrencias"
INSERT INTO ocorrencias (heroi_id, crime_id, descricao, data_crime, severidade)
VALUES 
(
    (SELECT id FROM heroes WHERE hero_name ='Maeve'),                -- ID do herói associado ao crime
    (SELECT id FROM crime WHERE nome ='Conspiração'),                -- ID do crime (Conspiração)
    'Trabalhou secretamente com Hughie e os Boys contra a Vought.',  -- Descrição da ocorrência
    CURRENT_DATE,                                                    -- Data do crime (data atual)
    5                                                                -- Severidade do crime (em uma escala de 1 a 10)
);

-- SELEÇÕES

-- 1. TODAS AS OCORRÊNCIAS DE CRIMES
-- Essa consulta retorna todos os registros da tabela "ocorrencias"
SELECT * FROM ocorrencias;

-- 2. CRIMES AGRUPADOS POR HERÓI EM ORDEM DE QUANTIDADE
-- Retorna os crimes cometidos por cada herói, agrupados e ordenados pela quantidade total de crimes
SELECT 
    h.hero_name AS heroi_nome,                     -- Nome do herói
    STRING_AGG(c.nome, ', ') AS crimes_cometidos,  -- Lista dos crimes cometidos pelo herói
    COUNT(c.id) AS total_crimes                    -- Total de crimes cometidos
FROM ocorrencias AS o
JOIN heroes AS h ON o.heroi_id = h.id              -- Junta a tabela "ocorrencias" com "heroes"
JOIN crime AS c ON o.crime_id = c.id               -- Junta a tabela "ocorrencias" com "crime"
GROUP BY 
    h.id, h.hero_name                              -- Agrupa os resultados por ID e nome do herói
ORDER BY 
    total_crimes DESC;                             -- Ordena pela quantidade total de crimes em ordem decrescente

-- 3. CRIMES COMETIDOS POR UM HERÓI ESPECÍFICO
-- Retorna os crimes cometidos por um herói específico, detalhando o tipo de crime, descrição, data e severidade
SELECT 
    c.nome AS crime_nome,                      -- Nome do crime
    o.descricao AS crime_descricao,            -- Descrição detalhada do crime
    o.data_crime AS crime_data,                -- Data em que o crime ocorreu
    o.severidade                               -- Nível de severidade do crime
FROM ocorrencias AS o
JOIN heroes AS h ON o.heroi_id = h.id          -- Junta a tabela "ocorrencias" com "heroes"
JOIN crime AS c ON o.crime_id = c.id           -- Junta a tabela "ocorrencias" com "crime"
WHERE 
    h.hero_name = 'Billy Butcher';             -- Filtra os crimes cometidos pelo herói "Billy Butcher"

-- 4. CRIMES POR SEVERIDADE
-- Retorna os crimes classificados por um nível específico de severidade, ordenados pela data em ordem decrescente
SELECT 
    c.nome AS crime_nome,                      -- Nome do crime
    o.descricao AS crime_descricao,            -- Descrição detalhada do crime
    o.data_crime AS crime_data,                -- Data em que o crime ocorreu
    o.severidade                               -- Nível de severidade do crime
FROM ocorrencias AS o
JOIN heroes AS h ON o.heroi_id = h.id          -- Junta a tabela "ocorrencias" com "heroes"
JOIN crime AS c ON o.crime_id = c.id           -- Junta a tabela "ocorrencias" com "crime"
WHERE 
    o.severidade = 3                           -- Filtra por severidade específica (alterar o valor conforme necessário)
ORDER BY 
    o.data_crime DESC;                         -- Ordena os resultados pela data do crime em ordem decrescente