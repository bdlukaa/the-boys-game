# Bibliotecas
import psycopg2  # Para conexão com o banco de dados PostgreSQL
import random    # Para gerar valores aleatórios
import time      # Para manipular tempo 

# Função: conectar_bd
# Finalidade: Estabelecer a conexão com o banco de dados PostgreSQL
# Funcionamento: Retorna uma conexão ativa para o banco de dados especificado
def conectar_bd():
    conn = psycopg2.connect(
        host="localhost",        # Endereço do BD
        database="theboys",      # Nome do BD
        user="postgres",         # Usuário
        password="27092005",     # Senha
        port="5432",             # Porta de conexão
        options="-c client_encoding=UTF8"  # Configuração de encoding
    )
    return conn

# Função: simular_batalha
# Finalidade: Recuperar informações de uma batalha e listar heróis ativos para participar
# Funcionamento: Recebe um ID de batalha e, opcionalmente, uma lista de nomes de heróis
#                Valida a existência da batalha e seleciona os heróis ativos. Retorna 
#                informações da batalha e os heróis encontrados
def simular_batalha(id_batalha, nomes_herois=None):
    conn = conectar_bd()  # Estabelece conexão com o banco de dados
    cursor = conn.cursor()
    # Consulta para buscar a batalha pelo ID
    cursor.execute("SELECT * FROM battles WHERE id = %s", (id_batalha,))
    batalha = cursor.fetchone()  # Recupera os dados da batalha
    
    if not batalha:  # Verifica se a batalha existe
        print(f"Nenhuma batalha encontrada com o ID {id_batalha}.")
        cursor.close()
        conn.close()
        return None, None
    
    print(f"Batalha encontrada: {batalha}")
    
    # Seleção de heróis com base no status e, opcionalmente, pelos nomes fornecidos
    if nomes_herois:
        query = "SELECT * FROM heroes WHERE status = 'Ativo' AND hero_name IN %s"
        cursor.execute(query, (tuple(nomes_herois),))
    else:
        cursor.execute("SELECT * FROM heroes WHERE status = 'Ativo'")
    
    herois = cursor.fetchall()  # Recupera os dados dos heróis
    cursor.close()
    conn.close()
    
    # Verifica se há heróis suficientes para a batalha
    if not herois or len(herois) < 2:
        print(f"Nenhum herói encontrado para a batalha com o ID {id_batalha} ou não há heróis suficientes.")
        return batalha, None
    else:
        print(f"Heróis encontrados: {herois}")
    
    return batalha, herois

# Função: calcular_vencedor
# Finalidade: Determinar a equipe vencedora com base nos atributos de força e popularidade
# Funcionamento: Divide os heróis em duas equipes de tamanho definido e calcula o poder
#                total de cada equipe. Retorna a equipe vencedora
def calcular_vencedor(herois, tamanho_equipe):
    if len(herois) < tamanho_equipe * 2:
        raise ValueError("Não há heróis suficientes para a batalha.")
    
    # Seleciona heróis aleatoriamente para formar duas equipes
    equipe1 = random.sample(herois, tamanho_equipe)
    equipe2 = random.sample([h for h in herois if h not in equipe1], tamanho_equipe)
    
    # Calcula o poder de cada equipe (soma de força e popularidade)
    poder_equipe1 = sum(h[8] + h[9] for h in equipe1)  # strength_level + popularity
    poder_equipe2 = sum(h[8] + h[9] for h in equipe2)
    
    # Determina a equipe vencedora
    if poder_equipe1 > poder_equipe2:
        return equipe1
    elif poder_equipe2 > poder_equipe1:
        return equipe2
    else:
        return random.choice([equipe1, equipe2])  # Em caso de empate, escolhe aleatoriamente

# Função: executar_simulacoes
# Finalidade: Executar múltiplas simulações de batalhas com diferentes tamanhos de equipe
# Funcionamento: Chama a função "simular_batalha" para obter dados e heróis. Depois
#                simula batalhas variando os tamanhos das equipes, determina os vencedores 
#                e exibe os resultados
def executar_simulacoes(id_batalha, variacoes, nomes_herois=None):
    batalha, herois = simular_batalha(id_batalha, nomes_herois)
    if not herois:
        print("Nenhum herói encontrado para esta batalha ou não há heróis suficientes.")
        return
    
    # Realiza simulações para cada variação de tamanho de equipe
    for i, tamanho_equipe in enumerate(variacoes, start=1):
        try:
            print(f"\nSimulando batalha {i} ({tamanho_equipe}x{tamanho_equipe})...")
            time.sleep(5)  # Pausa de 5 segundos entre as batalhas
            vencedor = calcular_vencedor(herois, tamanho_equipe)
            print(f"Batalha {batalha[0]} ({tamanho_equipe}x{tamanho_equipe}): {len(herois)} heróis participaram.")
            print(f"Vencedores: {[h[2] for h in vencedor]} (Nomes de Heróis: {[h[1] for h in vencedor]})")
        except ValueError as e:
            print(e)

# Ponto de entrada principal
if __name__ == "__main__":
    variacoes = [1, 2, 3, 4, 5]  # Variações de simulação (1x1, 2x2, 3x3, 4x4, 5x5)
    executar_simulacoes(1, variacoes)
