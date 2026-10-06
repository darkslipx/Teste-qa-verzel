# Resultados da execução: API

**Base:** https://verzel-store.qa-test-verzel-store.workers.dev/api
**Ferramenta:** Thunder Client (VS Code), coleção execucao/verzel-store-api.postman_collection.json
**Data da execução:** 06/10/2026

Preencher a coluna Resultado com Aprovado ou Reprovado (BUG-XX) após executar cada requisição.

## Produtos

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-01 | GET lista de produtos | GET /api/produtos | 200 com 8 produtos | Pendente | api01.png |
| API-02 | GET produto P001 | GET /api/produtos/P001 | 200 com Camiseta Essencial, preco 59.9 | Pendente | api02.png |
| API-03 | GET produto inexistente P999 | GET /api/produtos/P999 | 404 PRODUTO_NAO_ENCONTRADO | Pendente | api03.png |

## Calculo

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-04 | Exemplo da documentacao | POST /api/carrinho/calcular | 200; subtotal 239.7, desconto 23.97, frete 0, total 215.73 | Pendente | api04.png |
| API-05 | Subtotal 199.80 sem cupom | POST /api/carrinho/calcular | 200; frete 19.9, freteGratis false, valorFaltanteFreteGratis 0.2, total 219.7 | Pendente | api05.png |
| API-06 | Subtotal 200.00 sem cupom (BUG-01) | POST /api/carrinho/calcular | 200; frete 0, freteGratis true, valorFaltanteFreteGratis 0, total 200 (CA06) | Pendente | api06.png |
| API-07 | Subtotal 200.00 com cupom (BUG-01) | POST /api/carrinho/calcular | 200; desconto 20, frete 0, total 180 | Pendente | api07.png |
| API-08 | Subtotal 219.80 com cupom (CA08) | POST /api/carrinho/calcular | 200; desconto 21.98, frete 0, total 197.82 | Pendente | api08.png |
| API-09 | Abaixo de 200 com cupom (CA09) | POST /api/carrinho/calcular | 200; desconto 10, frete 19.9, total 109.9 | Pendente | api09.png |
| API-10 | Arredondamento P006 x3 com cupom (CA11) | POST /api/carrinho/calcular | 200; subtotal 89.7, desconto 8.97, frete 19.9, total 100.63, todos com 2 casas | Pendente | api10.png |
| API-11 | Arredondamento P001 x3 (CA11) | POST /api/carrinho/calcular | 200; subtotal 179.7, valorFaltanteFreteGratis 20.3, total 199.6 | Pendente | api11.png |
| API-12 | Carrinho maximo todos produtos | POST /api/carrinho/calcular | 200; subtotal 4247, frete 0, total 4247 | Pendente | api12.png |

## Cupom

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-13 | Cupom minusculo (CA02) | POST /api/carrinho/calcular | 200; cupom.aplicado true, desconto 5.99 | Pendente | api13.png |
| API-14 | Cupom com espacos (CA02) | POST /api/carrinho/calcular | 200; cupom.aplicado true, desconto 5.99 | Pendente | api14.png |
| API-15 | Cupom com espaco interno | POST /api/carrinho/calcular | 200; aplicado false, mensagem Cupom inválido. | Pendente | api15.png |
| API-16 | Cupom inexistente (CA03) | POST /api/carrinho/calcular | 200; aplicado false, desconto 0, mensagem Cupom inválido. | Pendente | api16.png |
| API-17 | Cupom expirado (CA04) | POST /api/carrinho/calcular | 200; aplicado false, desconto 0, mensagem Cupom expirado. | Pendente | api17.png |
| API-18 | Cupom expirado minusculo | POST /api/carrinho/calcular | 200; mensagem Cupom expirado. | Pendente | api18.png |
| API-19 | Cupom vazio | POST /api/carrinho/calcular | Indefinido na doc; registrar comportamento (ambiguidade) | Pendente | api19.png |
| API-20 | Cupom como lista (CA05) | POST /api/carrinho/calcular | Indefinido; nao deve aplicar dois cupons | Pendente | api20.png |

## Quantidade

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-21 | Quantidade 5 (limite) | POST /api/carrinho/calcular | 200; subtotal 299.5 | Pendente | api21.png |
| API-22 | Quantidade 6 (CA10) | POST /api/carrinho/calcular | 422 QUANTIDADE_MAXIMA_EXCEDIDA, campo itens[0].quantidade | Pendente | api22.png |
| API-23 | Quantidade 0 | POST /api/carrinho/calcular | 422 QUANTIDADE_INVALIDA | Pendente | api23.png |
| API-24 | Quantidade negativa | POST /api/carrinho/calcular | 422 QUANTIDADE_INVALIDA | Pendente | api24.png |
| API-25 | Quantidade decimal | POST /api/carrinho/calcular | 422 QUANTIDADE_INVALIDA | Pendente | api25.png |
| API-26 | Quantidade como texto | POST /api/carrinho/calcular | 422 QUANTIDADE_INVALIDA | Pendente | api26.png |
| API-27 | Quantidade 6 no segundo item | POST /api/carrinho/calcular | 422 QUANTIDADE_MAXIMA_EXCEDIDA, campo itens[1].quantidade | Pendente | api27.png |

## Itens

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-28 | Lista vazia | POST /api/carrinho/calcular | 422 ITENS_OBRIGATORIOS | Pendente | api28.png |
| API-29 | Sem campo itens | POST /api/carrinho/calcular | 422 ITENS_OBRIGATORIOS | Pendente | api29.png |
| API-30 | Item sem quantidade | POST /api/carrinho/calcular | 422 ITEM_INVALIDO | Pendente | api30.png |
| API-31 | Produto inexistente | POST /api/carrinho/calcular | 422 PRODUTO_NAO_ENCONTRADO | Pendente | api31.png |
| API-32 | Item duplicado | POST /api/carrinho/calcular | 422 ITEM_DUPLICADO | Pendente | api32.png |
| API-33 | Duplicado somando 6 (burla do limite) | POST /api/carrinho/calcular | 422 ITEM_DUPLICADO; nunca calcular 6 unidades | Pendente | api33.png |

## Pedido

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-34 | Pedido valido com cupom | POST /api/pedidos | 201; numero VZ-000000, cep 01310100, total 109.9 | Pendente | api34.png |
| API-35 | Pedido 200.00 (BUG-01) | POST /api/pedidos | 201; frete 0, total 200 | Pendente | api35.png |
| API-36 | Pedido cupom inexistente | POST /api/pedidos | 422 CUPOM_INVALIDO | Pendente | api36.png |
| API-37 | Pedido CEP sem hifen | POST /api/pedidos | 201; cep 01310100 | Pendente | api37.png |
| API-38 | Pedido cupom expirado | POST /api/pedidos | 422 CUPOM_EXPIRADO | Pendente | api38.png |
| API-39 | Pedido quantidade 6 | POST /api/pedidos | 422 QUANTIDADE_MAXIMA_EXCEDIDA | Pendente | api39.png |

## Cliente

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-40 | Nome sem sobrenome | POST /api/pedidos | 422 DADOS_INVALIDOS, campos com nome | Pendente | api40.png |
| API-41 | Nome com simbolos (BUG-03) | POST /api/pedidos | 422 DADOS_INVALIDOS (interpretacao) | Pendente | api41.png |
| API-42 | Nome so espacos | POST /api/pedidos | 422 DADOS_INVALIDOS | Pendente | api42.png |
| API-43 | Email dominio invalido (BUG-02) | POST /api/pedidos | 422 DADOS_INVALIDOS | Pendente | api43.png |
| API-44 | Email sem arroba | POST /api/pedidos | 422 DADOS_INVALIDOS | Pendente | api44.png |
| API-45 | Email sem extensao | POST /api/pedidos | 422 DADOS_INVALIDOS | Pendente | api45.png |
| API-46 | CEP 7 digitos | POST /api/pedidos | 422 DADOS_INVALIDOS | Pendente | api46.png |
| API-47 | CEP 9 digitos | POST /api/pedidos | 422 DADOS_INVALIDOS | Pendente | api47.png |
| API-48 | CEP com letras | POST /api/pedidos | 422 DADOS_INVALIDOS | Pendente | api48.png |
| API-49 | Varios campos invalidos | POST /api/pedidos | 422 DADOS_INVALIDOS com os 3 campos em campos | Pendente | api49.png |
| API-50 | Sem objeto cliente | POST /api/pedidos | 422 DADOS_INVALIDOS | Pendente | api50.png |

## Protocolo

| ID | Requisição | Método | Esperado | Resultado | Evidência |
|---|---|---|---|---|---|
| API-51 | JSON malformado | POST /api/carrinho/calcular | 400 JSON_INVALIDO | Pendente | api51.png |
| API-52 | Corpo e uma lista | POST /api/carrinho/calcular | 400 JSON_INVALIDO (nao e objeto) | Pendente | api52.png |
| API-53 | GET no calcular | GET /api/carrinho/calcular | 405 METODO_NAO_PERMITIDO | Pendente | api53.png |
| API-54 | DELETE em produtos | DELETE /api/produtos | 405 METODO_NAO_PERMITIDO | Pendente | api54.png |
| API-55 | Rota inexistente | GET /api/cupons | 404 ROTA_NAO_ENCONTRADA | Pendente | api55.png |
