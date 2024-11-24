SELECT * FROM heroes;

-- herois e seus poderes 
SELECT h.hero_name, p.power_name
FROM heroes h
JOIN powers p ON h.id = p.hero_id;

-- herois e suas batalhas
SELECT h.hero_name, b.battle_result, b.date
FROM heroes h
JOIN battles b ON h.id = b.hero_id;

-- heroi especifico com seu respectivo poder e batalha
SELECT h.hero_name, p.power_name, b.battle_result, b.date
FROM heroes h
LEFT JOIN powers p ON h.id = p.hero_id
LEFT JOIN battles b ON h.id = b.hero_id
WHERE h.hero_name = 'Homelander';

-- n de vitorias e derrotas de cada heroi
SELECT h.hero_name, 
       COUNT(CASE WHEN b.battle_result = 'Vitória' THEN 1 END) AS vitórias,
       COUNT(CASE WHEN b.battle_result = 'Derrota' THEN 1 END) AS derrotas
FROM heroes h
LEFT JOIN battles b ON h.id = b.hero_id
GROUP BY h.hero_name;
