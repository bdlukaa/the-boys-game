package main

import (
	"log"
)

func main() {
	db, err := connectDB()
	if err != nil {
		log.Fatalf("Erro ao conectar ao banco de dados: %v", err)
	}
	defer db.Close()

	heroes, err := getHeroes(db)
	if err != nil {
		log.Fatalf("Erro ao buscar heróis: %v", err)
	}

	if len(heroes) < 2 {
		log.Fatalf("Não há heróis suficientes no banco de dados")
	}

	hero1 := heroes[0]
	hero2 := heroes[1]

	battle := simulateBattle(hero1, hero2)

	displayBattleReport(battle)
}
