import random

# Dados fictícios para teste
herois_ficticios = [
    (1, 'Billy Butcher', 'Billy Butcher', 'Masculino', 1.85, 90.0, '1982-04-03', 'Londres, Reino Unido', 60, 80, 'Ativo'),
    (2, 'Hughie Campbell', 'Hughie Campbell', 'Masculino', 1.78, 75.0, '1994-05-15', 'Pittsburgh, EUA', 40, 70, 'Ativo'),
    (3, 'Starlight', 'Annie January', 'Feminino', 1.68, 58.0, '1996-10-05', 'Davenport, EUA', 85, 95, 'Ativo'),
    (4, 'Homelander', 'John', 'Masculino', 1.93, 90.0, '1977-07-01', 'Desconhecido', 100, 100, 'Ativo'),
    (5, 'Queen Maeve', 'Maeve', 'Feminino', 1.75, 70.0, '1985-06-30', 'Missouri, EUA', 90, 85, 'Ativo')
    
]

def simular_batalha(id_batalha):
    # Simular a busca de heróis para a batalha fictícia
    herois = random.sample(herois_ficticios, 2)
    batalha = (id_batalha, 'Batalha Fictícia')
    return batalha, herois

def calcular_vencedor(herois):
    heroi1, heroi2 = herois
    poder_heroi1 = heroi1[8] + heroi1[9]  # strength_level + popularity
    poder_heroi2 = heroi2[8] + heroi2[9]
    
    if poder_heroi1 > poder_heroi2:
        return heroi1
    elif poder_heroi2 > poder_heroi1:
        return heroi2
    else:
        return random.choice([heroi1, heroi2])

def main():
    id_batalha = 1  # ID fictício da batalha
    batalha, herois = simular_batalha(id_batalha)
    if not herois:
        print("Nenhum herói encontrado para esta batalha.")
        return
    
    vencedor = calcular_vencedor(herois)
    print(f"Batalha {batalha[0]}: {len(herois)} heróis participaram.")
    print(f"Vencedor: {vencedor[2]} (Nome de Herói: {vencedor[1]})")

if __name__ == "__main__":
    main()