=begin
! 6. Gerenciamento de Biblioteca
Conceitos explorados: Composição, herança, encapsulamento.
Problema: Crie um sistema de gerenciamento de uma biblioteca. O sistema deve ter uma classe Livro, que contém os atributos titulo, autor, e anoDePublicacao. Crie também uma classe Biblioteca que contenha uma lista de livros e métodos para adicionar um livro, remover um livro, e listar todos os livros disponíveis.

! Requisitos:
* Classe Livro com atributos e métodos.
* Classe Biblioteca com uma lista de livros e métodos para gerenciar os livros.
* Composição (a Biblioteca contém uma lista de objetos Livro).
* Métodos para adicionar, remover e listar livros.
=end

class Livro 
    #o método é usado para criar getters automáticos
    
    attr_reader :titulo, :autor, :anoDePublicacao
    
    def initialize(titulo, autor, anoDePublicacao)
        @titulo = titulo
        @autor = autor
        @anoDePublicacao = anoDePublicacao
    end

    def exibir_infos
        puts "Título: #{@titulo}, Autor: #{@autor}, Ano de Publicação: #{@anoDePublicacao}"
    end
end
    
class Biblioteca 
    def initialize
        @livros = []
    end

    def adicionar_livro(livro)
        # << adiciona um elemento ao final de um array ( o obj livro é
        #adicionado à lista de livros)
        
        @livros << livro 

        # livro.titulo é usado para acessar o atributo titlo do obj livro
        # por meio do getter
        puts "Livro '#{livro.titulo}' adicionado à biblioteca."
    end 

    def remover_livro(titulo)
  livro_removido = @livros.find { |livro| livro.titulo == titulo }

  if livro_removido
    @livros.delete(livro_removido)
    puts "Livro '#{titulo}' removido da biblioteca."
  else
    puts "O livro '#{titulo}' não foi encontrado na biblioteca."
  end
end

    # n recebe nenhum parametro

    def listar_livros
        # método q retorna true se a lista tiver vazia
  if @livros.empty?
    puts "A biblioteca não possui livros no momento."
  else
    puts "Livros disponíveis na biblioteca:"
      # percorre o array 
      # p cada livro, o método exibir_infos é chamado e imprime as infos do livro 
    @livros.each { |livro| livro.exibir_infos }
  end
end
end

#criando a biblio
biblioteca = Biblioteca.new

#criando livros
biblioteca = Biblioteca.new

livro1 = Livro.new("A Hora da Estrela", "Clarice Lispector", 1977)
livro2 = Livro.new("Os sertões", "Euclides da Cunha", 1902)
livro3 = Livro.new("Dom Quixote", "Miguel de Cervantes", 1605)

biblioteca.adicionar_livro(livro1)
biblioteca.adicionar_livro(livro2)
biblioteca.adicionar_livro(livro3)

biblioteca.listar_livros

biblioteca.remover_livro("Os sertões")

biblioteca.listar_livros
