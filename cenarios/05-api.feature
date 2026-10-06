# language: pt

@api
Funcionalidade: API da Verzel Store
  Como integrador
  Quero consultar produtos, calcular o carrinho e criar pedidos pela API
  Para que as mesmas regras da loja valham fora da interface
  Base: https://verzel-store.qa-test-verzel-store.workers.dev/api

  # Produtos

  @API-01
  Cenário: Listar produtos
    Quando envio GET para "/api/produtos"
    Então a resposta tem status 200
    E a lista tem os 8 produtos da documentação

  @API-02
  Cenário: Consultar um produto
    Quando envio GET para "/api/produtos/P001"
    Então a resposta tem status 200
    E o produto é "Camiseta Essencial" com preço 59.9

  @API-03 @A06
  Cenário: Consultar produto inexistente
    Quando envio GET para "/api/produtos/P999"
    Então a resposta tem status 404
    E o código de erro é "PRODUTO_NAO_ENCONTRADO"

  # Cálculo do carrinho

  @API-04
  Cenário: Exemplo da documentação
    Quando envio para "/api/carrinho/calcular" 1 "P002" e 2 "P004" com o cupom "BEMVINDO10"
    Então a resposta tem status 200
    E subtotal é 239.7, desconto é 23.97, frete é 0 e total é 215.73

  @API-05 @API-06 @API-07 @API-08 @API-09 @API-10 @API-11 @API-12
  Esquema do Cenário: Regras de frete, desconto e arredondamento no cálculo
    Quando envio para "/api/carrinho/calcular" os itens <itens> com o cupom "<cupom>"
    Então a resposta tem status 200
    E subtotal é <subtotal>, desconto é <desconto>, frete é <frete> e total é <total>
    E freteGratis é <freteGratis>

    Exemplos:
      | caso   | itens                | cupom      | subtotal | desconto | frete | total  | freteGratis | observação                |
      | API-05 | P001 x1, P002 x1     |            | 199.8    | 0        | 19.9  | 219.7  | false       | faltam 0.2                |
      | API-06 | P005 x2              |            | 200      | 0        | 0     | 200    | true        | BUG-01                    |
      | API-07 | P005 x2              | BEMVINDO10 | 200      | 20       | 0     | 180    | true        | BUG-01                    |
      | API-08 | P003 x1, P006 x1     | BEMVINDO10 | 219.8    | 21.98    | 0     | 197.82 | true        | CA08                      |
      | API-09 | P005 x1              | BEMVINDO10 | 100      | 10       | 19.9  | 109.9  | false       | CA09                      |
      | API-10 | P006 x3              | BEMVINDO10 | 89.7     | 8.97     | 19.9  | 100.63 | false       | CA11                      |
      | API-11 | P001 x3              |            | 179.7    | 0        | 19.9  | 199.6  | false       | faltam 20.3               |
      | API-12 | P001 a P008, x5 cada |            | 4247     | 0        | 0     | 4247   | true        | carrinho máximo           |

  # Cupom

  @API-13 @API-14 @API-15 @API-16 @API-17 @API-18
  Esquema do Cenário: Tratamento do cupom no cálculo
    Quando envio para "/api/carrinho/calcular" 1 "P001" com o cupom "<cupom>"
    Então a resposta tem status 200
    E cupom.aplicado é <aplicado>
    E cupom.mensagem é "<mensagem>"

    Exemplos:
      | caso   | cupom          | aplicado | mensagem                                      |
      | API-13 | bemvindo10     | true     | Cupom aplicado: 10% de desconto nos produtos. |
      | API-14 |   BEMVINDO10   | true     | Cupom aplicado: 10% de desconto nos produtos. |
      | API-15 | BEM VINDO10    | false    | Cupom inválido.                               |
      | API-16 | XYZ            | false    | Cupom inválido.                               |
      | API-17 | VERAO2026      | false    | Cupom expirado.                               |
      | API-18 | verao2026      | false    | Cupom expirado.                               |

  @API-19 @A01
  Cenário: Cupom vazio é tratado como sem cupom
    Quando envio para "/api/carrinho/calcular" 1 "P001" com o cupom ""
    Então a resposta tem status 200
    E cupom é null e desconto é 0

  @API-20 @API-20b @A02 @CA05
  Cenário: Cupom enviado como lista nunca aplica dois descontos
    Quando envio para "/api/carrinho/calcular" 1 "P001" com o cupom ["BEMVINDO10", "VERAO2026"]
    Então a resposta tem status 200
    E desconto é 0

  # Itens

  @API-28 @API-29 @API-30 @API-31 @API-32
  Esquema do Cenário: Validação da lista de itens
    Quando envio para "/api/carrinho/calcular" o corpo <corpo>
    Então a resposta tem status 422
    E o código de erro é "<codigo>"

    Exemplos:
      | caso   | corpo                                  | codigo                 |
      | API-28 | itens vazio                            | ITENS_OBRIGATORIOS     |
      | API-29 | sem o campo itens                      | ITENS_OBRIGATORIOS     |
      | API-30 | item sem quantidade                    | ITEM_INVALIDO          |
      | API-31 | produto P999                           | PRODUTO_NAO_ENCONTRADO |
      | API-32 | P001 repetido na lista                 | ITEM_DUPLICADO         |

  # Pedidos

  @API-34 @API-37
  Esquema do Cenário: Criar pedido válido
    Quando envio para "/api/pedidos" o cliente "Maria Silva", "maria@exemplo.com", CEP "<cep>" com 1 "<produto>" e o cupom "<cupom>"
    Então a resposta tem status 201
    E o número do pedido segue o formato VZ-000000
    E o CEP retornado é "01310100"
    E o total é <total>

    Exemplos:
      | caso   | cep       | produto | cupom      | total |
      | API-34 | 01310-100 | P005    | BEMVINDO10 | 109.9 |
      | API-37 | 01310100  | P001    |            | 79.8  |

  @API-35 @CA06 @BUG-01
  Cenário: Pedido com subtotal exatamente 200 tem frete grátis
    Quando envio para "/api/pedidos" um cliente válido com 2 "P005"
    Então a resposta tem status 201
    E frete é 0 e total é 200

  @API-36 @API-38 @CA03 @CA04
  Esquema do Cenário: Pedido com cupom inválido ou expirado é recusado
    Quando envio para "/api/pedidos" um cliente válido com 1 "P001" e o cupom "<cupom>"
    Então a resposta tem status 422
    E o código de erro é "<codigo>"

    Exemplos:
      | caso   | cupom     | codigo          |
      | API-36 | XYZ       | CUPOM_INVALIDO  |
      | API-38 | VERAO2026 | CUPOM_EXPIRADO  |

  @API-40 @API-41 @API-42 @API-43 @API-44 @API-45 @API-46 @API-47 @API-48 @API-64 @API-65
  Esquema do Cenário: Validação dos dados do cliente
    Quando envio para "/api/pedidos" o cliente com <campo> igual a "<valor>"
    Então a resposta tem status 422
    E o código de erro é "DADOS_INVALIDOS"
    E a lista de campos inclui "<campo>"

    Exemplos:
      | caso   | campo | valor                | observação  |
      | API-40 | nome  | Maria                |             |
      | API-41 | nome  | Abner @@             | BUG-03, A05 |
      | API-42 | nome  |                      | só espaços  |
      | API-43 | email | abnerduartw@!!!!.com | BUG-04      |
      | API-44 | email | mariaexemplo.com     |             |
      | API-45 | email | maria@exemplo        |             |
      | API-46 | cep   | 0131010              | 7 dígitos   |
      | API-47 | cep   | 013101000            | 9 dígitos   |
      | API-48 | cep   | 0131A100             | com letra   |
      | API-64 | cep   | 01310 100            | com espaço  |
      | API-65 | nome  | Maria 12             | BUG-03, A05 |

  @API-49 @API-50
  Cenário: Vários campos inválidos ou cliente ausente
    Quando envio para "/api/pedidos" um pedido com nome, e-mail e CEP inválidos
    Então a resposta tem status 422 com código "DADOS_INVALIDOS" e os 3 campos listados
    Quando envio para "/api/pedidos" um pedido sem o objeto cliente
    Então a resposta tem status 422 com código "DADOS_INVALIDOS"

  # Rodada complementar

  @API-56 @CA02
  Cenário: Regra do cupom vale também no pedido
    Quando envio para "/api/pedidos" um cliente válido com 1 "P001" e o cupom "  bemvindo10  "
    Então a resposta tem status 201
    E o desconto é 5.99

  @API-57 @API-58 @API-59
  Esquema do Cenário: Validação dos itens também no pedido
    Quando envio para "/api/pedidos" um cliente válido com <itens>
    Então a resposta tem status 422
    E o código de erro é "<codigo>"

    Exemplos:
      | caso   | itens                  | codigo                 |
      | API-57 | produto P999           | PRODUTO_NAO_ENCONTRADO |
      | API-58 | P001 repetido na lista | ITEM_DUPLICADO         |
      | API-59 | lista vazia            | ITENS_OBRIGATORIOS     |

  @API-60
  Cenário: Cupom enviado como número
    Quando envio para "/api/carrinho/calcular" 1 "P001" com o cupom 123
    Então a resposta tem status 200
    E cupom.aplicado é false com a mensagem "Cupom inválido."

  @API-61
  Cenário: Id do produto diferencia maiúsculas
    Quando envio para "/api/carrinho/calcular" 1 "p001"
    Então a resposta tem status 422
    E o código de erro é "PRODUTO_NAO_ENCONTRADO"

  @API-62
  Cenário: Preço enviado pelo cliente é ignorado
    Quando envio para "/api/carrinho/calcular" 1 "P001" com precoUnitario 0.01
    Então a resposta tem status 200
    E o precoUnitario retornado é 59.9

  @API-66
  Cenário: Espaços nas pontas do nome e do e-mail são removidos
    Quando envio para "/api/pedidos" o nome "  Maria Silva  " e o e-mail "  maria@exemplo.com "
    Então a resposta tem status 201
    E o pedido traz o nome "Maria Silva" e o e-mail "maria@exemplo.com"

  # Protocolo

  @API-51 @API-52 @API-53 @API-54 @API-55
  Esquema do Cenário: Erros de protocolo
    Quando envio <metodo> para "<rota>" com o corpo <corpo>
    Então a resposta tem status <status>
    E o código de erro é "<codigo>"

    Exemplos:
      | caso   | metodo | rota                   | corpo           | status | codigo               |
      | API-51 | POST   | /api/carrinho/calcular | JSON malformado | 400    | JSON_INVALIDO        |
      | API-52 | POST   | /api/carrinho/calcular | uma lista       | 400    | JSON_INVALIDO        |
      | API-53 | GET    | /api/carrinho/calcular | vazio           | 405    | METODO_NAO_PERMITIDO |
      | API-54 | DELETE | /api/produtos          | vazio           | 405    | METODO_NAO_PERMITIDO |
      | API-55 | GET    | /api/cupons            | vazio           | 404    | ROTA_NAO_ENCONTRADA  |
