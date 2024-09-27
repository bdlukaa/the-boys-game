=begin
! 3. Polimorfismo com Formas Geométricas
Conceitos explorados: Polimorfismo, sobrescrita de métodos.
Problema: Crie uma classe abstrata Forma com o método abstrato calcularArea(). 
Crie subclasses Retangulo e Circulo que implementam o método de cálculo de área. 
Na classe principal, crie objetos de diferentes formas e use polimorfismo para calcular e 
exibir suas áreas.

!Requisitos:
* Classe abstrata com método abstrato.
* Subclasses que implementam o método.
* Polimorfismo no uso dos objetos.
=end

class Forma
    def calcular_area
        # emite um erro se o método for chamado mas não for implementado
        raise NotImplementedError, "Este método deve ser implementado por uma subclasse "
    end
end

class Triangulo < Forma
      
end

class Retangulo < Forma 
    def initialize(base, altura)
        @base = base
        @altura = altura
    end

    def calcular_area
        # A = b * h
        @base * @altura
    end
end

class Circulo < Forma
    def initialize(raio)
        @raio = raio
    end

    def calcular_area
        # A = π * r²
        3.1416 * (@raio ** 2)
    end
end

formas = [
    Retangulo.new(4, 8),
    Circulo.new(6)
]

formas.each do |forma|
  puts "• Área da forma: #{forma.calcular_area}"
end
