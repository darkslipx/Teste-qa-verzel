# language: pt

@frete
Funcionalidade: Frete grátis e cálculo do carrinho
  Como cliente da Verzel Store
  Quero saber quanto vou pagar de frete
  Para decidir se adiciono mais produtos e ganho frete grátis
  Fórmula: total = subtotal menos desconto mais frete, com valores arredondados para 2 casas

  Contexto:
    Dado que estou na Verzel Store com o carrinho vazio

  @UI-03 @API-06 @CA06 @BUG-01
  Cenário: Subtotal exatamente R$ 200,00 tem frete grátis
    Dado que adicionei 2 unidades de "Mochila Urbana 20L" (R$ 100,00)
    Quando abro o carrinho
    Então o subtotal é de R$ 200,00
    E o frete é grátis
    E o total é de R$ 200,00

  @UI-04 @API-07 @CA06 @CA08 @BUG-01
  Cenário: Subtotal exatamente R$ 200,00 com cupom mantém frete grátis
    Dado que adicionei 2 unidades de "Mochila Urbana 20L" (R$ 100,00)
    Quando aplico o cupom "BEMVINDO10"
    Então o desconto é de R$ 20,00
    E o frete é grátis
    E o total é de R$ 180,00

  @UI-05 @API-08 @CA08 @CA09
  Cenário: Frete grátis considera o subtotal antes do desconto
    Dado que adicionei 1 "Tênis Casual Urbano" (R$ 189,90) e 1 "Kit 3 Pares de Meias" (R$ 29,90)
    Quando aplico o cupom "BEMVINDO10"
    Então o subtotal é de R$ 219,80
    E o desconto é de R$ 21,98
    E o frete é grátis, mesmo com o valor após o desconto (R$ 197,82) abaixo de R$ 200,00
    E o total é de R$ 197,82

  @UI-06 @API-05 @CA07 @CA11
  Cenário: Abaixo de R$ 200,00 cobra frete e informa quanto falta
    Dado que adicionei 1 "Camiseta Essencial" (R$ 59,90) e 1 "Calça Jeans Slim" (R$ 139,90)
    Quando abro o carrinho
    Então o subtotal é de R$ 199,80
    E o frete é de R$ 19,90
    E vejo a mensagem "Faltam R$ 0,20 para o frete grátis."
    E o total é de R$ 219,70

  @API-09 @CA09
  Cenário: Desconto não incide sobre o frete
    Dado que adicionei 1 "Mochila Urbana 20L" (R$ 100,00)
    Quando aplico o cupom "BEMVINDO10"
    Então o desconto é de R$ 10,00
    E o frete continua R$ 19,90
    E o total é de R$ 109,90

  @API-10 @CA11
  Cenário: Valores com arredondamento em 2 casas
    Dado que adicionei 3 unidades de "Kit 3 Pares de Meias" (R$ 29,90)
    Quando aplico o cupom "BEMVINDO10"
    Então o subtotal é de R$ 89,70
    E o desconto é de R$ 8,97
    E o total é de R$ 100,63

  @UI-07 @CA06 @CA07
  Cenário: Frete muda ao passar pelo limite nos dois sentidos
    Dado que tenho um carrinho com subtotal acima de R$ 200,00 e frete grátis
    Quando removo itens até o subtotal ficar abaixo de R$ 200,00
    Então o frete de R$ 19,90 passa a ser cobrado
    Quando adiciono itens até o subtotal voltar a R$ 200,00 ou mais
    Então o frete volta a ser grátis

  @UI-01 @UI-02 @API-12 @CA06 @CA10 @CA11
  Cenário: Carrinho com 5 unidades de todos os produtos
    Dado que adicionei 5 unidades de cada um dos 8 produtos
    Quando abro o carrinho
    Então o total de cada item é o preço unitário vezes 5
    E o subtotal é de R$ 4.247,00
    E o frete é grátis

  @UI-08
  Cenário: Esvaziar o carrinho
    Dado que tenho produtos e o cupom "BEMVINDO10" no carrinho
    Quando clico em "Esvaziar carrinho"
    Então o carrinho fica sem itens, sem cupom e com o resumo zerado

  @UI-09
  Cenário: Contador do carrinho mostra o total de unidades
    Dado que adicionei 2 unidades de "Boné Aba Curva" e 3 unidades de "Camiseta Essencial"
    Então o contador do carrinho no topo mostra 5
