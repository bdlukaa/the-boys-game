package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
)

func init() {
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("Erro ao carregar o arquivo .env: %v", err)
	}
}

func connectDB() (*sql.DB, error) {
	host := os.Getenv("DB_HOST")
	port := os.Getenv("DB_PORT")
	user := os.Getenv("DB_USER")
	password := os.Getenv("DB_PASS")
	dbname := os.Getenv("DB_NAME")

	psqlInfo := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		host, port, user, password, dbname)
	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		return nil, err
	}
	err = db.Ping()
	if err != nil {
		return nil, err
	}
	return db, nil
}

func getHeroes(db *sql.DB) ([]Hero, error) {
	rows, err := db.Query("SELECT name, strength, popularity, in_shape, critical_hit FROM heroes")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var heroes []Hero
	for rows.Next() {
		var hero Hero
		err := rows.Scan(&hero.Name, &hero.Strength, &hero.Popularity, &hero.InShape, &hero.CriticalHit)
		if err != nil {
			return nil, err
		}
		heroes = append(heroes, hero)
	}
	return heroes, nil
}
