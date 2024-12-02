import psycopg2
import random
import time

def conectar_bd():
    conn = psycopg2.connect(
        host="localhost",
        database="theboys",
        user="postgres",
        password="27092005",
        port="5432",
        options="-c client_encoding=UTF8"
    )
    return conn

def simular_batalha(id_batalha, nomes_herois=None):
    conn = conectar_bd()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM battles WHERE id = %s", (id_batalha,))
    batalha = cursor.fetchone()
    
    if not batalha:
        print(f"Nenhuma batalha encontrada com o ID {id_batalha}.")
        cursor.close()
        conn.close()
        return None, None
    
    print(f"Batalha encontrada: {batalha}")
    
    if nomes_herois:
        query = "SELECT * FROM heroes WHERE status = 'Ativo' AND hero_name IN %s"
        cursor.execute(query, (tuple(nomes_herois),))
    else:
        cursor.execute("SELECT * FROM heroes WHERE status = 'Ativo'")
    
    herois = cursor.fetchall()
    
    cursor.close()
    conn.close()
    
    if not herois or len(herois) < 2:
        print(f"Nenhum herói encontrado para a batalha com o ID {id_batalha} ou não há heróis suficientes.")
        return batalha, None
    else:
        print(f"Heróis encontrados: {herois}")
    
    return batalha, herois

def calcular_vencedor(herois, tamanho_equipe):
    if len(herois) < tamanho_equipe * 2:
        raise ValueError("Não há heróis suficientes para a batalha.")
    
    equipe1 = random.sample(herois, tamanho_equipe)
    equipe2 = random.sample([h for h in herois if h not in equipe1], tamanho_equipe)
    
    poder_equipe1 = sum(h[8] + h[9] for h in equipe1)  # strength_level + popularity
    poder_equipe2 = sum(h[8] + h[9] for h in equipe2)
    
    if poder_equipe1 > poder_equipe2:
        return equipe1
    elif poder_equipe2 > poder_equipe1:
        return equipe2
    else:
        return random.choice([equipe1, equipe2])

def executar_simulacoes(id_batalha, variacoes, nomes_herois=None):
    batalha, herois = simular_batalha(id_batalha, nomes_herois)
    if not herois:
        print("Nenhum herói encontrado para esta batalha ou não há heróis suficientes.")
        return
    
    for i, tamanho_equipe in enumerate(variacoes, start=1):
        try:
            print(f"\nSimulando batalha {i} ({tamanho_equipe}x{tamanho_equipe})...")
            time.sleep(5)  # Pausa de 5 segundos entre as batalhas
            vencedor = calcular_vencedor(herois, tamanho_equipe)
            print(f"Batalha {batalha[0]} ({tamanho_equipe}x{tamanho_equipe}): {len(herois)} heróis participaram.")
            print(f"Vencedores: {[h[2] for h in vencedor]} (Nomes de Heróis: {[h[1] for h in vencedor]})")
        except ValueError as e:
            print(e)

if __name__ == "__main__":
    variacoes = [1, 2, 3, 4, 5]  # Variações de simulação (1x1, 2x2, 3x3, 4x4, 5x5)
    executar_simulacoes(1, variacoes)