# language: pt

@quantidade
Funcionalidade: Limite de quantidade por produto
  Como loja
  Quero limitar cada produto a 5 unidades por pedido
  Para cumprir a regra CA10 na interface e na API

  Contexto:
    Dado que estou na Verzel Store

  @UI-10 @CA10
  Cenário: Botão + do carrinho não passa de 5 unidades
    Dado que tenho 5 unidades de "Camiseta Essencial" no carrinho
    Quando clico no botão +
    Então a quantidade continua 5

  @UI-11 @CA10
  Esquema do Cenário: Campo de quantidade recusa valores fora do limite
    Dado que tenho 1 unidade de "Camiseta Essencial" no carrinho
    Quando digito "<valor>" no campo de quantidade
    Então o valor é recusado e a quantidade não passa a "<valor>"

    Exemplos:
      | valor |
      | 6     |
      | 0     |
      |       |

  @UI-12 @CA10
  Cenário: Botão Adicionar da página do produto bloqueia após 5 unidades
    Dado que adicionei 5 unidades de "Camiseta Essencial" pela página do produto
    Quando tento adicionar mais uma unidade
    Então vejo a indicação de limite atingido
    E o carrinho continua com 5 unidades

  @API-21 @CA10
  Cenário: API aceita exatamente 5 unidades
    Quando envio para o cálculo do carrinho 5 unidades de "P001"
    Então a resposta tem status 200
    E o subtotal é 299.5

  @API-22 @API-27 @API-39 @CA10 @BUG-02
  Esquema do Cenário: API recusa mais de 5 unidades
    Quando envio para "<endpoint>" 6 unidades de "P001" na posição <posicao> da lista de itens
    Então a resposta tem status 422
    E o código de erro é "QUANTIDADE_MAXIMA_EXCEDIDA"
    E o campo indicado é "itens[<posicao>].quantidade"

    Exemplos:
      | caso   | endpoint                | posicao |
      | API-22 | /api/carrinho/calcular  | 0       |
      | API-27 | /api/carrinho/calcular  | 1       |
      | API-39 | /api/pedidos            | 0       |

  @API-63 @CA10 @BUG-02
  Cenário: API recusa quantidade muito acima do limite
    Quando envio para o cálculo do carrinho 1000000 unidades de "P001"
    Então a resposta tem status 422
    E o código de erro é "QUANTIDADE_MAXIMA_EXCEDIDA"

  @API-23 @API-24 @API-25 @API-26
  Esquema do Cenário: API recusa quantidade que não é inteiro positivo
    Quando envio para o cálculo do carrinho a quantidade <quantidade> de "P001"
    Então a resposta tem status 422
    E o código de erro é "QUANTIDADE_INVALIDA"

    Exemplos:
      | caso   | quantidade |
      | API-23 | 0          |
      | API-24 | -1         |
      | API-25 | 1.5        |
      | API-26 | "dois"     |

  @API-33
  Cenário: Produto repetido não burla o limite
    Quando envio "P001" duas vezes na lista, com 3 unidades cada
    Então a resposta tem status 422
    E o código de erro é "ITEM_DUPLICADO"
