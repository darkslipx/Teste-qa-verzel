# language: pt

@cupom
Funcionalidade: Cupom de desconto
  Como cliente da Verzel Store
  Quero aplicar um cupom no carrinho
  Para pagar menos pela compra

  Contexto:
    Dado que estou na Verzel Store
    E tenho 1 unidade de "Camiseta Essencial" (R$ 59,90) no carrinho

  @UI-13 @CA01
  Cenário: Cupom BEMVINDO10 aplica 10% sobre o subtotal
    Quando aplico o cupom "BEMVINDO10"
    Então vejo a mensagem de cupom aplicado
    E o desconto é de R$ 5,99
    E o total é de R$ 73,81

  @UI-14 @UI-15 @CA02
  Esquema do Cenário: Cupom ignora maiúsculas, minúsculas e espaços nas pontas
    Quando aplico o cupom "<cupom digitado>"
    Então o cupom BEMVINDO10 é aplicado
    E o desconto é de R$ 5,99

    Exemplos:
      | caso  | cupom digitado   |
      | UI-14 | bemvindo10       |
      | UI-14 | BemVindo10       |
      | UI-15 |   BEMVINDO10     |

  @UI-16 @CA03
  Cenário: Cupom inexistente não aplica desconto
    Quando aplico o cupom "NAOEXISTE"
    Então vejo a mensagem "Cupom inválido."
    E o desconto é de R$ 0,00

  @UI-17 @UI-18 @CA02 @CA04
  Esquema do Cenário: Cupom expirado não aplica desconto
    Quando aplico o cupom "<cupom digitado>"
    Então vejo a mensagem "Cupom expirado."
    E o desconto é de R$ 0,00

    Exemplos:
      | caso  | cupom digitado |
      | UI-17 | VERAO2026      |
      | UI-18 | verao2026      |

  @UI-19 @A01
  Cenário: Aplicar cupom com o campo vazio não aplica desconto
    # Comportamento não definido na documentação. Interpretação A01.
    Quando clico em "Aplicar cupom" sem preencher o campo
    Então nenhum desconto é aplicado
    E o total continua R$ 79,80

  @UI-20 @CA05
  Cenário: Apenas um cupom por vez
    Dado que apliquei o cupom "BEMVINDO10"
    Quando removo o cupom
    E aplico o cupom "BEMVINDO10" novamente
    Então o desconto é de R$ 5,99, aplicado uma única vez

  @UI-21
  Cenário: Tecla Enter aplica o cupom
    Quando digito "BEMVINDO10" no campo de cupom e pressiono Enter
    Então o cupom BEMVINDO10 é aplicado

  @UI-31 @CA01 @CA10
  Cenário: Desconto acompanha a mudança de quantidade
    Dado que o carrinho tem apenas 3 unidades de "Mochila Urbana 20L" e o cupom "BEMVINDO10" aplicado
    Quando diminuo a quantidade para 2 e depois para 1
    Então o desconto passa de R$ 30,00 para R$ 20,00 e depois para R$ 10,00
    E com 1 unidade o botão "-" fica desabilitado

  @UI-32 @CA04 @CA05
  Cenário: Cupom válido depois de um expirado
    Quando aplico o cupom "VERAO2026"
    E vejo a mensagem "Cupom expirado."
    E aplico o cupom "BEMVINDO10"
    Então o cupom BEMVINDO10 é aplicado
    E o desconto é de R$ 5,99

  @UI-22 @A04
  Cenário: Cupom continua aplicado após recarregar a página
    Dado que apliquei o cupom "BEMVINDO10"
    Quando recarrego a página
    Então o carrinho e o cupom continuam aplicados
