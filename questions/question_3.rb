=begin
! 3. Polimorfismo com Formas Geométricas
Conceitos explorados: Polimorfismo, sobrescrita de métodos.
Problema: Crie uma classe abstrata Forma com o método abstrato calcularArea(). Crie subclasses Retangulo e Circulo que implementam o método de cálculo de área. Na classe principal, crie objetos de diferentes formas e use polimorfismo para calcular e exibir suas áreas.

!Requisitos:
* Classe abstrata com método abstrato.
* Subclasses que implementam o método.
* Polimorfismo no uso dos objetos.
=end

#classe abstrata
class Forma
    def calcular_area
        #levanta-se uma exceção, qualquer classe que herdar de Forma precisa 
        #sobrescrever esse método
        raise NotImplementedError, "Este método deve ser implementado por uma subclasse "
    end
end

#subclasse Retangulo herda de Forma e implementa o método calcular_area
class Retangulo < Forma 
    def initialize(base, altura)
        @base = base
        @altura = altura
    end

    def calcular_area
        @base * @altura
    end
end

class Circulo < Forma
    def initialize(raio)
        @raio = raio
    end

    def calcular_area
        3.1416 * (@raio ** 2)
    end
end

#criando instancias
formas = [
    Retangulo.new(4, 8),
    Circulo.new(6)
]

#método calcular_area é chamado de forma polimórfica para cada obj em formas
#ruby sabe chamar o método correto
formas.each do |forma|
  puts "Área da forma: #{forma.calcular_area}"
end
