=begin
! Sistema de Funcionários
Conceitos explorados: Encapsulamento, construtores, getters e setters.

Problema: Crie uma classe Funcionario que contenha os atributos nome, cargo,
e salario. Utilize encapsulamento para proteger os dados e forneça métodos
para obter e alterar esses atributos (getters e setters). Crie um método que
exiba as informações completas do funcionário. Na classe principal, instancie
três objetos da classe Funcionario e exiba suas informações.

! Requisitos:
* Atributos privados: nome, cargo, salario.
* Construtor para inicializar os valores.
* Métodos getters e setters.
* Método para exibir informações.
=end

#definição da classe

class Funcionario
    #método initialize é o construtor
    
    def initialize(nome, cargo, salario)
        #atributos privados e encapsulamento
        @nome = nome
        @cargo = cargo
        @salario = salario
    end

    #getters permitem o acesso aos atributos fora da classe
    #ex: funcionario1.nome
    def nome
        @nome
    end

    def cargo
        @cargo
    end

    def salario
        @salario
    end
    

    #setters permitem a modificação dos atributos fora da classe
    #ex: funcionario1.nome = "Novo Nome".

    def nome=(nome)
        @nome = nome
    end

    def cargo=(cargo)
        @cargo = cargo
    end

    def salario=(salario)
        @salario = salario
    end

    #metodo que exibe infos do funcionario

    def exibir_infos
        #acessa os atributos privados
        #puts imprime cada linha de info na tela
        
        puts "Nome: #{@nome}"
        puts "Cargo: #{@cargo}"
        puts "Salario: #{@salario}"
        puts "-----------------------"
    end
end

#criação de 3 obj da classe
#new cria uma nova instancia

funcionario1 = Funcionario.new("Clara Costa", "Gerente", 7000.00)
funcionario2 = Funcionario.new("Gabriel Mendes", "Desenvolvedor", 5000.00)
funcionario3 = Funcionario.new("Marina Carvalho", "Analista", 4500.00)

# exibe as infos dos funcionários
funcionario1.exibir_infos
funcionario2.exibir_infos
funcionario3.exibir_infos
