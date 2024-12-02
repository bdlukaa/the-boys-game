import psycopg2
import random

def conectar_bd():
    conn = psycopg2.connect(
        host="localhost",
        database="battle_sim",
        user="postgres",
        password="postgres"
    )
    return conn

def simular_batalha(id_batalha):
    conn = conectar_bd()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM battles WHERE id = %s", (id_batalha,))
    batalha = cursor.fetchone()
    
    cursor.execute("SELECT * FROM heroes WHERE id IN (SELECT hero_id FROM battles WHERE id = %s)", (id_batalha,))
    herois = cursor.fetchall()
    
    cursor.close()
    conn.close()
    
    return batalha, herois

def calcular_vencedor(herois):
    heroi1, heroi2 = random.sample(herois, 2)
    poder_heroi1 = heroi1[8] + heroi1[9]  # strength_level + popularity
    poder_heroi2 = heroi2[8] + heroi2[9]
    
    if poder_heroi1 > poder_heroi2:
        return heroi1
    elif poder_heroi2 > poder_heroi1:
        return heroi2
    else:
        return random.choice([heroi1, heroi2])

def main():
    batalha, herois = simular_batalha(1)
    if not herois:
        print("Nenhum herói encontrado para esta batalha.")
        return
    
    vencedor = calcular_vencedor(herois)
    print(f"Batalha {batalha[0]}: {len(herois)} heróis participaram.")
    print(f"Vencedor: {vencedor[2]} (Nome de Herói: {vencedor[1]})")

if __name__ == "__main__":
    main()