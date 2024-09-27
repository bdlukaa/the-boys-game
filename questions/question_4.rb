=begin
! 4. Interface com Meio de Pagamento
Conceitos explorados: Interfaces, implementação de métodos.

Problema: Crie uma interface Pagamento com o método realizar Pagamento(). 
Crie classes Cartaocredito e Boleto que implementam essa interface e definem 
maneiras diferentes de realizar o pagamento. No método principal, use objetos 
dessas dasses e faça com que eles realizem o pagamento.

! Requisitos:
* Interface com método abstrato.
* Classes que implementam a interface de maneira diferente.
=end

#Problema: Crie uma interface Pagamento com o método realizar Pagamento().
class MeiodePagamento
    def realizarPagamento
        # emite um erro se o método for chamado mas não for implementado
        raise NotImplementedError, 'Implemente o metódo da classe abstrata'
    end
end

#Crie uma classe Boleto que implementa essa interface e define maneiras
#diferentes de realizar o pagamento. 
class Boleto < MeiodePagamento
    def initialize(score)
        @saldo = score * 0.70
    end

    def realizarPagamento(preco)
        puts "Compensando boleto. Aguarde..."
        sleep(6)
        if preco <= @saldo
            return "O boleto foi compensado"
        end
        "Não foi possível confirmar o pagamento do boleto"
    end

    def depositar(valor)
        @saldo += valor
        "Depósito realizado com sucesso. Saldo atual: #{@saldo}"
    end
end

#Crie uma classe Cartão que implementa essa interface e define maneiras
#diferentes de realizar o pagamento.
class Cartaocredito < MeiodePagamento
    def initialize(score)
        @limite = score * 3.5
    end

    def realizarPagamento(preco)
        puts "Processando pagamento com cartão. Aguarde..."
        sleep(6)
        if preco <= @limite
            return "• O pagamento com cartão foi aprovado"
        end
        "• Pagamento negado. Limite insuficiente"
    end

    def aumentar_limite(valor)
        @limite += valor
        "• Limite aumentado com sucesso. Limite atual: #{@limite}"
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