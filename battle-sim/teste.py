import random  # Biblioteca utilizada para selecionar elementos aleatórios

# Dados fictícios para teste
# Cada herói é representado por uma tupla com as seguintes informações:
# (ID, Nome do Herói, Nome Real, Gênero, Altura, Peso, Data de Nascimento, Local de Nascimento, Nível de Força, Popularidade, Status)
herois_ficticios = [
    (1, 'Billy Butcher', 'Billy Butcher', 'Masculino', 1.85, 90.0, '1982-04-03', 'Londres, Reino Unido', 60, 80, 'Ativo'),
    (2, 'Hughie Campbell', 'Hughie Campbell', 'Masculino', 1.78, 75.0, '1994-05-15', 'Pittsburgh, EUA', 40, 70, 'Ativo'),
    (3, 'Starlight', 'Annie January', 'Feminino', 1.68, 58.0, '1996-10-05', 'Davenport, EUA', 85, 95, 'Ativo'),
    (4, 'Homelander', 'John', 'Masculino', 1.93, 90.0, '1977-07-01', 'Desconhecido', 100, 100, 'Ativo'),
    (5, 'Queen Maeve', 'Maeve', 'Feminino', 1.75, 70.0, '1985-06-30', 'Missouri, EUA', 90, 85, 'Ativo')
]

# Função: simular_batalha
# Finalidade: Simular a busca de heróis para uma batalha fictícia
# Funcionamento: Seleciona aleatoriamente dois heróis da lista de heróis fictícios
#                e cria uma batalha fictícia associada a um ID
# Parâmetros:
#   - id_batalha (int): O identificador único da batalha
# Retorno:
#   - batalha (tupla): Tupla representando a batalha fictícia (ID, Nome)
#   - herois (lista): Lista com dois heróis selecionados aleatoriamente para a batalha
def simular_batalha(id_batalha):
    # Seleciona aleatoriamente dois heróis
    herois = random.sample(herois_ficticios, 2)
    batalha = (id_batalha, 'Batalha Fictícia')  # Define a batalha com um nome fictício
    return batalha, herois

# Função: calcular_vencedor
# Finalidade: Determinar o vencedor entre dois heróis com base nos atributos
# Funcionamento: Calcula o "poder" de cada herói (soma de força e popularidade)
#                e retorna o herói com maior poder. Em caso de empate, o vencedor
#                é escolhido aleatoriamente
# Parâmetros:
#   - herois (lista): Lista com dois heróis que participarão da batalha
# Retorno:
#   - vencedor (tupla): Tupla representando o herói vencedor
def calcular_vencedor(herois):
    heroi1, heroi2 = herois
    # Calcula o poder dos heróis
    poder_heroi1 = heroi1[8] + heroi1[9]  # strength_level + popularity
    poder_heroi2 = heroi2[8] + heroi2[9]
    
    # Determina o vencedor
    if poder_heroi1 > poder_heroi2:
        return heroi1
    elif poder_heroi2 > poder_heroi1:
        return heroi2
    else:
        # Em caso de empate, seleciona aleatoriamente o vencedor
        return random.choice([heroi1, heroi2])

# Função: main
# Finalidade: Ponto de entrada principal do programa
# Funcionamento: Simula uma batalha fictícia utilizando os heróis e exibe o resultado,
#                incluindo o número de heróis participantes e o vencedor
def main():
    id_batalha = 1  # ID fictício da batalha
    # Simula a batalha e obtém os heróis participantes
    batalha, herois = simular_batalha(id_batalha)
    if not herois:  # Verifica se os heróis foram encontrados
        print("Nenhum herói encontrado para esta batalha.")
        return
    
    # Calcula o vencedor da batalha
    vencedor = calcular_vencedor(herois)
    print(f"Batalha {batalha[0]}: {len(herois)} heróis participaram.")
    print(f"Vencedor: {vencedor[2]} (Nome de Herói: {vencedor[1]})")

# Ponto de entrada do programa
if __name__ == "__main__":
    main()