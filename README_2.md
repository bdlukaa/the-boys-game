
# **Simulador de Batalhas**

O **Simulador de Batalhas** é um sistema desenvolvido em Python utilizando o framework **Flet** para criar uma interface gráfica (GUI). O aplicativo é uma plataforma para gerenciar heróis, crimes, batalhas e missões, permitindo a interação com dados fictícios de forma visual e intuitiva.

## **Funcionalidades**

O sistema está dividido em cinco seções principais:

1. **Home**
   - Tela inicial que dá as boas-vindas ao usuário e permite iniciar o simulador.

2. **Heróis**
   - Gerencie os heróis cadastrados.
   - Visualize atributos como força, popularidade e status.
   - Adicione, atualize ou edite heróis diretamente pela interface.

3. **Crimes**
   - Exiba os crimes registrados, com detalhes como severidade, descrição e heróis envolvidos.
   - Crie e atualize crimes na plataforma.

4. **Batalhas**
   - Simule batalhas entre heróis.
   - Gere resultados e visualize heróis vencedores.

5. **Missões**
   - Gerencie missões associadas a heróis.
   - Visualize detalhes como dificuldade, resultado e recompensas.
   - Crie, atualize e edite missões diretamente.

---

## **Tecnologias Utilizadas**

- **Python**: Linguagem de programação principal.
- **Flet**: Framework para construção da interface gráfica (GUI).
- **PostgreSQL**: Banco de dados relacional usado para gerenciar heróis, crimes, missões e batalhas.
- **Plpgsql**: Funções e triggers no banco de dados para atualizações dinâmicas.

---

## **Pré-requisitos**

Antes de executar o projeto, você precisa ter instalados:

1. **Python 3.10+**
   - [Download e instalação do Python](https://www.python.org/downloads/)

2. **Flet**
   - Instale o Flet utilizando o comando:
     ```bash
     pip install flet
     ```

3. **PostgreSQL**
   - [Download e instalação do PostgreSQL](https://www.postgresql.org/download/)

---

## **Configuração do Banco de Dados**

1. Crie o banco de dados:
   ```sql
   CREATE DATABASE heroes;
   ```

2. Configure as tabelas executando os scripts SQL:

   - **Tabela de Heróis**
     ```sql
     CREATE TABLE heroes (
         id SERIAL PRIMARY KEY,
         real_name VARCHAR(100) NOT NULL,
         hero_name VARCHAR(100) NOT NULL,
         gender VARCHAR(10),
         height DECIMAL(5,2),
         weight DECIMAL(5,2),
         birth_date DATE,
         birth_place VARCHAR(100),
         strength_level INT CHECK (strength_level BETWEEN 0 AND 100),
         popularity INT CHECK (popularity BETWEEN 0 AND 100),
         status VARCHAR(20) DEFAULT 'Ativo'
     );
     ```

   - **Outras tabelas**:
     Inclua as tabelas de `battles`, `powers`, `crime`, `ocorrencias`, `missoes`, e `missoes_herois` utilizando os scripts fornecidos ao longo do projeto.

3. Insira dados fictícios no banco de dados para testes iniciais:
   ```sql
   INSERT INTO heroes (real_name, hero_name, gender, height, weight, birth_date, birth_place, strength_level, popularity, status)
   VALUES
   ('Bruce Wayne', 'Batman', 'Masculino', 1.88, 95.0, '1939-05-19', 'Gotham City', 85, 90, 'Ativo');
   ```

---

## **Configuração do Sistema**

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/simulador-de-batalhas.git
   cd simulador-de-batalhas
   ```

2. Crie um arquivo `.env` para armazenar as credenciais do banco de dados:
   ```env
   DB_HOST=localhost
   DB_PORT=5432
   DB_USER=postgres
   DB_PASS=sua_senha
   DB_NAME=heroes
   ```

3. Instale as dependências do projeto:
   ```bash
   pip install -r requirements.txt
   ```

---

## **Como Executar o Sistema**

1. Execute o aplicativo:
   ```bash
   python main.py
   ```

2. Navegue pelas seções utilizando o menu lateral.

---

## **Como o Sistema Funciona**

### **Estrutura**

- **Interface gráfica (Flet)**:
  - O sistema utiliza componentes do Flet como `NavigationRail`, `DataTable`, e `Snackbar` para criar uma interface interativa e responsiva.

- **Banco de dados (PostgreSQL)**:
  - Todas as informações sobre heróis, crimes, batalhas e missões são armazenadas no banco de dados. Consultas e atualizações são feitas por meio de queries SQL.

- **Organização das seções**:
  - Cada seção é implementada como uma função que retorna um layout específico. Por exemplo, a função `herois_view` retorna o layout para a seção de gerenciamento de heróis.

---

## **Principais Funcionalidades**

### **Heróis**
- **Visualizar**: Exibe heróis com atributos como força, popularidade e status.
- **Adicionar**: Permite cadastrar novos heróis.
- **Editar**: Atualiza atributos de heróis existentes.

### **Crimes**
- **Gerenciar Crimes**: Permite cadastrar crimes, associá-los a heróis e editar dados.

### **Batalhas**
- **Simular**: Gera resultados de batalhas fictícias entre heróis, considerando força e popularidade.

### **Missões**
- **Gerenciar Missões**: Cadastrar e visualizar missões associadas a heróis, exibindo dificuldades e recompensas.

---

## **Contribuições**

Sinta-se à vontade para contribuir com melhorias ao sistema. Para isso:

1. Faça um fork do projeto.
2. Crie uma branch para sua modificação:
   ```bash
   git checkout -b minha-modificacao
   ```
3. Faça o commit das suas alterações:
   ```bash
   git commit -m "Adiciona funcionalidade X"
   ```
4. Envie para o repositório remoto:
   ```bash
   git push origin minha-modificacao
   ```
5. Abra um Pull Request.

---

## **Licença**

Este projeto está licenciado sob a [Licença MIT](LICENSE).

