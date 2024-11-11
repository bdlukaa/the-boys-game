package main

import (
	"fmt"
	"math/rand"
	"time"
)

func simulateBattle(hero1, hero2 Hero) Battle {
	rand.Seed(time.Now().UnixNano())

	hero1PopularityBoost := rand.Intn(hero1.Popularity)
	hero2PopularityBoost := rand.Intn(hero2.Popularity)

	hero1Strength := hero1.Strength + hero1PopularityBoost
	hero2Strength := hero2.Strength + hero2PopularityBoost

	if hero1.InShape {
		hero1Strength += 10
	}
	if hero2.InShape {
		hero2Strength += 10
	}

	if hero1.CriticalHit {
		hero1Strength *= 2
	}
	if hero2.CriticalHit {
		hero2Strength *= 2
	}

	var winner Hero
	if hero1Strength > hero2Strength {
		winner = hero1
	} else {
		winner = hero2
	}

	return Battle{
		Hero1:         hero1,
		Hero2:         hero2,
		Winner:        winner,
		Hero1Strength: hero1Strength,
		Hero2Strength: hero2Strength,
	}
}

func displayBattleReport(battle Battle) {
	fmt.Printf("Batalha entre %s e %s\n", battle.Hero1.Name, battle.Hero2.Name)
	fmt.Printf("Vencedor: %s\n", battle.Winner.Name)
	fmt.Printf("Desempenho de %s: Força = %d, Popularidade = %d\n", battle.Hero1.Name, battle.Hero1Strength, battle.Hero1.Popularity)
	fmt.Printf("Desempenho de %s: Força = %d, Popularidade = %d\n", battle.Hero2.Name, battle.Hero2Strength, battle.Hero2.Popularity)
}
