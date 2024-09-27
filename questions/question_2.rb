=begin
! 2. Sistema de Herança com Animais Conceitos explorados: Herança, superclasse, subclasses.
Problema: Crie uma superclasse Animal com atributos como nome e idade, 
e um método emitirson(). Crie subclasses cachorro e Gato que herdam de 
Animal, e sobrescreva o método emitirson() para que cada subclasse faça 
o som específico do animal. No método principal, crie objetos das subclasses 
e faça com que eles emitam o som correspondente.

! Requisitos:
* Superclasse Animal com atributos e métodos.
* Subclasses que herdam de Animal e sobrescrevem métodos.
=end

#Problema: Crie uma superclasse Animal com atributos como nome e idade, e um método emitirson().
class Animal
    attr_accessor :nome, :idade

    def initialize(nome, idade)
        @nome = nome
        @idade = idade
    end

    def emitirSom
    end
end

#Crie subclasses cachorro que herda de Animal
class Cachorro < Animal
    def initialize(nome, idade)
        super(nome, idade)
    end

    # e sobrescreva o método emitirson(), para que cada subclasse faça o som específico do animal.
    def emitirSom
        "auau"
    end
end

#Crie subclasse Gato que herda de Animal
class Gato < Animal
    def initialize(nome, idade)
        super(nome, idade)
    end

    # e sobrescreva o método emitirson() ...
    def emitirSom
        "miau"
    end
end

#No método principal, crie objetos das subclasses e faça com que eles emitam o som correspondente.
robs = Cachorro.new("Pinduca", 9)
puts " • O #{robs.nome} faz #{robs.emitirSom}"

alfredo = Gato.new("Mingau", 3)
puts " • E o #{alfredo.nome} faz #{alfredo.emitirSom}"
