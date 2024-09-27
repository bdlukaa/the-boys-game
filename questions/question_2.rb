=begin
! 2. Sistema de Herança com Animais Conceitos explorados: Herança, superclasse, subclasses.
! Requisitos:
* Superclasse Animal com atributos e métodos.
* Subclasses que herdam de Animal e sobrescrevem métodos.
=end

class Animal
    attr_accessor :nome, :idade

    def initialize(nome, idade)
        @nome = nome
        @idade = idade
    end

    def emitirSom
    end
end

class Cachorro < Animal
    def initialize(nome, idade)
        super(nome, idade)
    end

    def emitirSom
        "auau"
    end
end

class Gato < Animal
    def initialize(nome, idade)
        super(nome, idade)
    end

    def emitirSom
        "miau"
    end
end

robs = Cachorro.new("Pinduca", 9)
puts " • O #{robs.nome} faz #{robs.emitirSom}"

alfredo = Gato.new("Mingau", 3)
puts " • E o #{alfredo.nome} faz #{alfredo.emitirSom}"
