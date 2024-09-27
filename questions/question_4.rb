=begin
! 4. Interface com Meio de Pagamento
Conceitos explorados: Interfaces, implementação de métodos.
! Requisitos:
* Interface com método abstrato.
* Classes que implementam a interface de maneira diferente.
=end

class MeiodePagamento
    def realizarPagamento
        # emite um erro se o método for chamado mas não for implementado
        raise NotImplementedError, 'Implemente o metódo da classe abstrata'
    end
end

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

# Crie uma classe Cartão que implementa essa interface e define maneiras diferentes de realizar o pagamento.
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

cartao = Cartaocredito.new(0)
boleto = Boleto.new(0)

puts "\nDeseja aumentar o limite do cartão ou depositar no boleto? (cartao/boleto)"
escolha = gets.chomp

if escolha == 'cartao'
    puts "Digite o valor para aumentar o limite do cartão:"
    valor = gets.chomp.to_f
    puts cartao.aumentar_limite(valor)
elsif escolha == 'boleto'
    puts "Digite o valor para depositar no boleto:"
    valor = gets.chomp.to_f
    puts boleto.depositar(valor)
else
    puts "Opção inválida."
end

puts "\nDeseja realizar um pagamento? (sim/não)"
resposta = gets.chomp

if resposta == 'sim'
    puts "Escolha o meio de pagamento (cartao/boleto):"
    meio_pagamento = gets.chomp

    puts "Digite o valor do pagamento:"
    valor_pagamento = gets.chomp.to_f

    if meio_pagamento == 'cartao'
        puts cartao.realizarPagamento(valor_pagamento)
    elsif meio_pagamento == 'boleto'
        puts boleto.realizarPagamento(valor_pagamento)
    else
        puts "Meio de pagamento inválido."
    end
else
    puts "Operação finalizada."
end
