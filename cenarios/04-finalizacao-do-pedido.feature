# language: pt

@pedido
Funcionalidade: Finalização do pedido
  Como cliente da Verzel Store
  Quero informar meus dados e confirmar a compra
  Para receber os produtos em casa
  Regras do cliente: nome e sobrenome, e-mail em formato válido, CEP com 8 dígitos com ou sem hífen

  Contexto:
    Dado que tenho 1 unidade de "Mochila Urbana 20L" no carrinho
    E estou na tela "Finalizar compra"

  @UI-23
  Esquema do Cenário: CEP com 8 dígitos é aceito com ou sem hífen
    Quando preencho nome "Maria Silva", e-mail "maria@exemplo.com" e CEP "<cep>"
    E confirmo o pedido
    Então o pedido é criado

    Exemplos:
      | cep       |
      | 01310-100 |
      | 01310100  |

  @UI-24
  Esquema do Cenário: CEP inválido é recusado
    Quando preencho o CEP "<cep>"
    Então vejo uma mensagem de erro no campo CEP
    E não consigo confirmar o pedido

    Exemplos:
      | cep       |
      | 0131A100  |
      | 01310@100 |
      | 1505708   |

  @UI-25 @API-43 @BUG-04
  Cenário: E-mail com domínio inválido é recusado
    Quando preencho nome "Maria Silva", e-mail "abnerduartw@!!!!.com" e CEP "01310-100"
    E confirmo o pedido
    Então vejo uma mensagem de erro no campo e-mail
    E o pedido não é criado

  @UI-26 @API-41 @BUG-03 @A05
  Cenário: Sobrenome composto só de símbolos é recusado
    # Interpretação A05: o sobrenome precisa conter letras.
    Quando preencho nome "Abner @@", e-mail "maria@exemplo.com" e CEP "01310-100"
    E confirmo o pedido
    Então vejo uma mensagem de erro no campo nome
    E o pedido não é criado

  @UI-27
  Esquema do Cenário: Confirmação mostra os mesmos valores do carrinho
    Dado que o cupom aplicado é "<cupom>"
    Quando preencho dados válidos e confirmo o pedido
    Então vejo o número do pedido no formato VZ-000000
    E subtotal, desconto, frete e total são iguais aos do resumo do carrinho

    Exemplos:
      | cupom      |
      | nenhum     |
      | BEMVINDO10 |

  @UI-28
  Cenário: Clique repetido não gera pedido duplicado
    Quando preencho dados válidos e clico duas vezes seguidas em "Confirmar pedido"
    Então apenas um pedido é criado

  @UI-29
  Cenário: Voltar no navegador após confirmar
    Dado que confirmei um pedido
    Quando clico em Voltar no navegador
    Então o carrinho aparece vazio

  @UI-30 @A06
  Cenário: Produto inexistente pela URL
    # Não aplicável na interface: a URL não expõe o id do produto (A06). Coberto por API-03.
    Quando tento abrir um produto que não existe
    Então vejo uma mensagem de produto não encontrado
