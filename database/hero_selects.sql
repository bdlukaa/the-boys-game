-- Consulta 1: Seleção de todos os heróis
-- Essa consulta retorna todas as colunas e registros da tabela "heroes"
SELECT * FROM heroes;

-- Consulta 2: Heróis e seus poderes
-- Combina as tabelas "heroes" e "powers" para listar os nomes dos heróis e seus respectivos poderes
SELECT 
    h.hero_name,  -- Nome do herói
    p.power_name  -- Nome do poder atribuído ao herói
FROM heroes h
JOIN powers p ON h.id = p.hero_id;  -- Junta as tabelas com base no ID do herói

-- Consulta 3: Heróis e suas batalhas
-- Combina as tabelas "heroes" e "battles" para listar os heróis, os resultados de suas batalhas e as datas em que ocorreram
SELECT 
    h.hero_name,       -- Nome do herói
    b.battle_result,   -- Resultado da batalha (Vitória ou Derrota)
    b.date             -- Data da batalha
FROM heroes h
JOIN battles b ON h.id = b.hero_id;  -- Junta as tabelas com base no ID do herói

-- Consulta 4: Herói específico com seu respectivo poder e batalhas
-- Retorna informações detalhadas de um herói específico (ex.: Homelander),
-- incluindo seus poderes, resultados de batalhas e datas
SELECT 
    h.hero_name,       -- Nome do herói
    p.power_name,      -- Nome do poder
    b.battle_result,   -- Resultado da batalha
    b.date             -- Data da batalha
FROM heroes h
LEFT JOIN powers p ON h.id = p.hero_id   -- Junta com a tabela de poderes (se disponível)
LEFT JOIN battles b ON h.id = b.hero_id -- Junta com a tabela de batalhas (se disponível)
WHERE h.hero_name = 'Homelander';       -- Filtra pelo nome específico do herói

-- Consulta 5: Número de vitórias e derrotas de cada herói
-- Agrupa as batalhas de cada herói para contar o total de vitórias e derrotas
SELECT 
    h.hero_name,  -- Nome do herói
    COUNT(CASE WHEN b.battle_result = 'Vitória' THEN 1 END) AS vitórias,  -- Conta as vitórias
    COUNT(CASE WHEN b.battle_result = 'Derrota' THEN 1 END) AS derrotas   -- Conta as derrotas
FROM heroes h
LEFT JOIN battles b ON h.id = b.hero_id  -- Junta as tabelas com base no ID do herói
GROUP BY h.hero_name;                    -- Agrupa os resultados por herói