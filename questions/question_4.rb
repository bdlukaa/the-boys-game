=begin
! 4. Interface com Meio de Pagamento
Conceitos explorados: Interfaces, implementação de métodos.


! Requisitos:
* Interface com método abstrato.
* Classes que implementam a interface de maneira diferente.
=end

#Problema: Crie uma interface Pagamento com o método realizar Pagamento().
class MeiodePagamento
    def realizarPagamento()
      raise NotImplementedError, 'Implemente o metódo da classe abstrata'
    end
end


#contexto





#Crie uma classe Boleto que implementa essa interface e define maneiras diferentes de realizar o pagamento. 
class Boleto < MeiodePagamento

    def initialize(score)
        @saldo = score * 0.70
    end

    def realizarPagamento(preco)
        sleep(10)
        if preco <= @saldo
            return "O boleto foi compensado"
        end
        return "Não foi possível confirmar o pagamento do boleto"
    end
end

#Crie uma classe Cartão que implementa essa interface e define maneiras diferentes de realizar o pagamento. 
class Cartaocredito < MeiodePagamento

    def initialize(score)
        @limite = score * 3.5
    end

    def realizarPagamento(preco)
        if preco <= @limite
            return "O pagamento com cartão foi aprovado"
        end
        return "Pagamento negado. Limite insuficiente"
    end
end



#No método principal, use objetos dessas dasses e faça com que eles realizem o pagamento.

#cartão
cartao = Cartaocredito.new 345
puts "\nCartão:"
puts cartao.realizarPagamento(5332)
puts cartao.realizarPagamento(533)

#boleto
boleto = Boleto.new 765
puts "\nBoleto:"
puts boleto.realizarPagamento(999.99)
puts boleto.realizarPagamento(534)