# Resultados da execução: API

**Base:** https://verzel-store.qa-test-verzel-store.workers.dev/api
**Ferramenta:** REST Client (extensão do VS Code, Huachao Mao), arquivo execucao/verzel-store-api.http
**Data da execução:** 06/10/2026

## Resumo

| Total | Aprovados | Reprovados |
|---|---|---|
| 56 | 48 | 8 |

| Bug | Requisições reprovadas |
|---|---|
| BUG-01 | API-06, API-07, API-35 |
| BUG-02 | API-22, API-27, API-39 |
| BUG-03 | API-41 |
| BUG-04 | API-43 |

## Produtos

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-01 | GET lista de produtos | GET /api/produtos | 200 com 8 produtos | Aprovado | Resposta no REST Client |
| API-02 | GET produto P001 | GET /api/produtos/P001 | 200 com Camiseta Essencial, preco 59.9 | Aprovado | Resposta no REST Client |
| API-03 | GET produto inexistente P999 | GET /api/produtos/P999 | 404 PRODUTO_NAO_ENCONTRADO | Aprovado | Resposta no REST Client |

## Cálculo

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-04 | Exemplo da documentacao | POST /api/carrinho/calcular | 200; subtotal 239.7, desconto 23.97, frete 0, total 215.73 | Aprovado | Resposta no REST Client |
| API-05 | Subtotal 199.80 sem cupom | POST /api/carrinho/calcular | 200; frete 19.9, freteGratis false, valorFaltanteFreteGratis 0.2, total 219.7 | Aprovado | Resposta no REST Client |
| API-06 | Subtotal 200.00 sem cupom (BUG-01) | POST /api/carrinho/calcular | 200; frete 0, freteGratis true, valorFaltanteFreteGratis 0, total 200 (CA06) | **Reprovado (BUG-01)** | [BUG-01-api06-calcular-200-sem-cupom.png](../evidencias/BUG-01-api06-calcular-200-sem-cupom.png) |
| API-07 | Subtotal 200.00 com cupom (BUG-01) | POST /api/carrinho/calcular | 200; desconto 20, frete 0, total 180 | **Reprovado (BUG-01)** | [BUG-01-api07-calcular-200-com-cupom.png](../evidencias/BUG-01-api07-calcular-200-com-cupom.png) |
| API-08 | Subtotal 219.80 com cupom (CA08) | POST /api/carrinho/calcular | 200; desconto 21.98, frete 0, total 197.82 | Aprovado | Resposta no REST Client |
| API-09 | Abaixo de 200 com cupom (CA09) | POST /api/carrinho/calcular | 200; desconto 10, frete 19.9, total 109.9 | Aprovado | Resposta no REST Client |
| API-10 | Arredondamento P006 x3 com cupom (CA11) | POST /api/carrinho/calcular | 200; subtotal 89.7, desconto 8.97, frete 19.9, total 100.63, todos com 2 casas | Aprovado | Resposta no REST Client |
| API-11 | Arredondamento P001 x3 (CA11) | POST /api/carrinho/calcular | 200; subtotal 179.7, valorFaltanteFreteGratis 20.3, total 199.6 | Aprovado | Resposta no REST Client |
| API-12 | Carrinho maximo todos produtos | POST /api/carrinho/calcular | 200; subtotal 4247, frete 0, total 4247 | Aprovado | Resposta no REST Client |

## Cupom

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-13 | Cupom minusculo (CA02) | POST /api/carrinho/calcular | 200; cupom.aplicado true, desconto 5.99 | Aprovado | Resposta no REST Client |
| API-14 | Cupom com espacos (CA02) | POST /api/carrinho/calcular | 200; cupom.aplicado true, desconto 5.99 | Aprovado | Resposta no REST Client |
| API-15 | Cupom com espaco interno | POST /api/carrinho/calcular | 200; aplicado false, mensagem Cupom inválido. | Aprovado | Resposta no REST Client |
| API-16 | Cupom inexistente (CA03) | POST /api/carrinho/calcular | 200; aplicado false, desconto 0, mensagem Cupom inválido. | Aprovado | Resposta no REST Client |
| API-17 | Cupom expirado (CA04) | POST /api/carrinho/calcular | 200; aplicado false, desconto 0, mensagem Cupom expirado. | Aprovado | Resposta no REST Client |
| API-18 | Cupom expirado minusculo | POST /api/carrinho/calcular | 200; mensagem Cupom expirado. | Aprovado | Resposta no REST Client |
| API-19 | Cupom vazio | POST /api/carrinho/calcular | Indefinido na doc; registrar comportamento (ambiguidade) | Aprovado (ver observação) | Resposta no REST Client |
| API-20 | Cupom como lista (CA05) | POST /api/carrinho/calcular | Indefinido; nao deve aplicar dois cupons | Aprovado (ver A02) | Resposta no REST Client |
| API-20b | Cupom como lista de um item | POST /api/carrinho/calcular | Indefinido; nao deve aplicar desconto | Aprovado (ver A02) | Resposta no REST Client |

## Quantidade

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-21 | Quantidade 5 (limite) | POST /api/carrinho/calcular | 200; subtotal 299.5 | Aprovado | Resposta no REST Client |
| API-22 | Quantidade 6 (CA10) | POST /api/carrinho/calcular | 422 QUANTIDADE_MAXIMA_EXCEDIDA, campo itens[0].quantidade | **Reprovado (BUG-02)** | [BUG-02-api22-calcular-quantidade-6.png](../evidencias/BUG-02-api22-calcular-quantidade-6.png) |
| API-23 | Quantidade 0 | POST /api/carrinho/calcular | 422 QUANTIDADE_INVALIDA | Aprovado | Resposta no REST Client |
| API-24 | Quantidade negativa | POST /api/carrinho/calcular | 422 QUANTIDADE_INVALIDA | Aprovado | Resposta no REST Client |
| API-25 | Quantidade decimal | POST /api/carrinho/calcular | 422 QUANTIDADE_INVALIDA | Aprovado | Resposta no REST Client |
| API-26 | Quantidade como texto | POST /api/carrinho/calcular | 422 QUANTIDADE_INVALIDA | Aprovado | Resposta no REST Client |
| API-27 | Quantidade 6 no segundo item | POST /api/carrinho/calcular | 422 QUANTIDADE_MAXIMA_EXCEDIDA, campo itens[1].quantidade | **Reprovado (BUG-02)** | Resposta no REST Client |

## Itens

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-28 | Lista vazia | POST /api/carrinho/calcular | 422 ITENS_OBRIGATORIOS | Aprovado | Resposta no REST Client |
| API-29 | Sem campo itens | POST /api/carrinho/calcular | 422 ITENS_OBRIGATORIOS | Aprovado | Resposta no REST Client |
| API-30 | Item sem quantidade | POST /api/carrinho/calcular | 422 ITEM_INVALIDO | Aprovado | Resposta no REST Client |
| API-31 | Produto inexistente | POST /api/carrinho/calcular | 422 PRODUTO_NAO_ENCONTRADO | Aprovado | Resposta no REST Client |
| API-32 | Item duplicado | POST /api/carrinho/calcular | 422 ITEM_DUPLICADO | Aprovado | Resposta no REST Client |
| API-33 | Duplicado somando 6 (burla do limite) | POST /api/carrinho/calcular | 422 ITEM_DUPLICADO; nunca calcular 6 unidades | Aprovado | Resposta no REST Client |

## Pedido

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-34 | Pedido valido com cupom | POST /api/pedidos | 201; numero VZ-000000, cep 01310100, total 109.9 | Aprovado | Resposta no REST Client |
| API-35 | Pedido 200.00 (BUG-01) | POST /api/pedidos | 201; frete 0, total 200 | **Reprovado (BUG-01)** | Resposta no REST Client |
| API-36 | Pedido cupom inexistente | POST /api/pedidos | 422 CUPOM_INVALIDO | Aprovado | Resposta no REST Client |
| API-37 | Pedido CEP sem hifen | POST /api/pedidos | 201; cep 01310100 | Aprovado | Resposta no REST Client |
| API-38 | Pedido cupom expirado | POST /api/pedidos | 422 CUPOM_EXPIRADO | Aprovado | Resposta no REST Client |
| API-39 | Pedido quantidade 6 | POST /api/pedidos | 422 QUANTIDADE_MAXIMA_EXCEDIDA | **Reprovado (BUG-02)** | [BUG-02-api39-pedido-quantidade-6.png](../evidencias/BUG-02-api39-pedido-quantidade-6.png) |

## Cliente

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-40 | Nome sem sobrenome | POST /api/pedidos | 422 DADOS_INVALIDOS, campos com nome | Aprovado | Resposta no REST Client |
| API-41 | Nome com simbolos (BUG-03) | POST /api/pedidos | 422 DADOS_INVALIDOS (interpretacao) | **Reprovado (BUG-03)** | [BUG-03-api41-pedido-sobrenome-simbolos.png](../evidencias/BUG-03-api41-pedido-sobrenome-simbolos.png) |
| API-42 | Nome so espacos | POST /api/pedidos | 422 DADOS_INVALIDOS | Aprovado | Resposta no REST Client |
| API-43 | Email dominio invalido (BUG-04) | POST /api/pedidos | 422 DADOS_INVALIDOS | **Reprovado (BUG-04)** | [BUG-04-api43-pedido-email-dominio-invalido.png](../evidencias/BUG-04-api43-pedido-email-dominio-invalido.png) |
| API-44 | Email sem arroba | POST /api/pedidos | 422 DADOS_INVALIDOS | Aprovado | Resposta no REST Client |
| API-45 | Email sem extensao | POST /api/pedidos | 422 DADOS_INVALIDOS | Aprovado | Resposta no REST Client |
| API-46 | CEP 7 digitos | POST /api/pedidos | 422 DADOS_INVALIDOS | Aprovado | Resposta no REST Client |
| API-47 | CEP 9 digitos | POST /api/pedidos | 422 DADOS_INVALIDOS | Aprovado | Resposta no REST Client |
| API-48 | CEP com letras | POST /api/pedidos | 422 DADOS_INVALIDOS | Aprovado | Resposta no REST Client |
| API-49 | Varios campos invalidos | POST /api/pedidos | 422 DADOS_INVALIDOS com os 3 campos em campos | Aprovado | Resposta no REST Client |
| API-50 | Sem objeto cliente | POST /api/pedidos | 422 DADOS_INVALIDOS | Aprovado | Resposta no REST Client |

## Protocolo

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-51 | JSON malformado | POST /api/carrinho/calcular | 400 JSON_INVALIDO | Aprovado | Resposta no REST Client |
| API-52 | Corpo e uma lista | POST /api/carrinho/calcular | 400 JSON_INVALIDO (nao e objeto) | Aprovado | Resposta no REST Client |
| API-53 | GET no calcular | GET /api/carrinho/calcular | 405 METODO_NAO_PERMITIDO | Aprovado | Resposta no REST Client |
| API-54 | DELETE em produtos | DELETE /api/produtos | 405 METODO_NAO_PERMITIDO | Aprovado | Resposta no REST Client |
| API-55 | Rota inexistente | GET /api/cupons | 404 ROTA_NAO_ENCONTRADA | Aprovado | Resposta no REST Client |

## Observações da execução

* **BUG-01 (API-06, API-07, API-35):** a API retorna frete 19.9 e freteGratis false com subtotal exatamente 200, enquanto valorFaltanteFreteGratis retorna 0, tornando a própria resposta inconsistente. O endpoint de pedidos (API-35) também cobra o frete e gera o pedido com total 219.9. Como os cálculos são feitos pela API, a falha está na regra do servidor.
* **BUG-02 (API-22, API-27, API-39):** a API não valida o limite de 5 unidades em nenhuma posição da lista. No endpoint de pedidos, retorna 201 Created e gera pedido com 6 unidades.
* **BUG-03 (API-41):** nome sem sobrenome (API-40) é recusado corretamente, mas um segundo termo composto apenas de símbolos é aceito. A validação verifica apenas a existência de duas palavras, sem validar seu conteúdo.
* **BUG-04 (API-43):** e-mails sem @ (API-44) e sem extensão de domínio (API-45) são recusados corretamente, mas um domínio composto por caracteres inválidos é aceito. A validação verifica apenas o padrão geral texto@texto.texto, sem validar os caracteres do domínio.
* **API-19:** comportamento com cupom vazio não definido na documentação. Interpretação registrada em AMBIGUIDADES.md (A01).
* **API-20 e API-20b:** cupom enviado como lista não gera desconto. Detalhes em AMBIGUIDADES.md (A02).
* As validações de quantidade inteira (0, negativa, decimal e texto), itens obrigatórios, item inválido, produto inexistente, item duplicado, dados do cliente e erros de protocolo (400, 404 e 405) funcionaram conforme a tabela de códigos de erro da documentação.
* **Evidências:** as requisições reprovadas têm print em evidencias/. As demais foram conferidas na resposta do REST Client e podem ser reexecutadas pelo arquivo execucao/verzel-store-api.http.
