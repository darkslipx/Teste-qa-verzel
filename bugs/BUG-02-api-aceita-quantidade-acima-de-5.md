# BUG-02: API aceita quantidade acima de 5 unidades por produto

| Campo | Valor |
|---|---|
| Card | VZS-142 (versão 2.3.0) |
| Critério violado | CA10 |
| Severidade | Alta |
| Prioridade | Alta |
| Onde ocorre | API (`/api/carrinho/calcular` e `/api/pedidos`). A interface bloqueia corretamente |
| Ambiente | https://verzel-store.qa-test-verzel-store.workers.dev/api, REST Client (VS Code) |
| Data | 06/10/2026 |
| Casos reprovados | API-22, API-27, API-39, API-63 |

## Descrição

O CA10 define no máximo 5 unidades por produto, **na interface e na API**. A interface respeita o limite (UI-10, UI-11, UI-12), mas a API calcula o carrinho e cria pedidos com 6 unidades. Qualquer cliente que chame a API diretamente consegue contornar a regra.

## Passos para reproduzir

```http
POST /api/carrinho/calcular
Content-Type: application/json

{ "itens": [ { "produtoId": "P001", "quantidade": 6 } ] }
```

Repetir com a quantidade 6 no segundo item da lista (API-27) e em `POST /api/pedidos` com um cliente válido (API-39).

## Resultado esperado

Status 422 com código `QUANTIDADE_MAXIMA_EXCEDIDA`, indicando o campo `itens[0].quantidade` (ou `itens[1].quantidade` no API-27). Nenhum pedido deve ser criado.

## Resultado obtido

* `/api/carrinho/calcular`: status 200, item com `quantidade: 6` e `total: 359.4`.
* `/api/pedidos`: status **201 Created**, pedido `VZ-941889` gerado com 6 unidades.
* Não existe teto: com `quantidade: 1000000` (API-63) a API responde 200 com subtotal de 59.900.000.

## Observações

* O código `QUANTIDADE_MAXIMA_EXCEDIDA` existe na tabela de erros da documentação, mas nunca é retornado.
* As demais validações de quantidade funcionam: 0, negativa, decimal e texto retornam 422 `QUANTIDADE_INVALIDA` (API-23 a API-26).
* Item duplicado somando 6 unidades é barrado por `ITEM_DUPLICADO` (API-33).

## Evidências

* API-22: [BUG-02-api22-calcular-quantidade-6.png](../evidencias/BUG-02-api22-calcular-quantidade-6.png)
* API-39: [BUG-02-api39-pedido-quantidade-6.png](../evidencias/BUG-02-api39-pedido-quantidade-6.png)
* API-63: [BUG-02-api63-calcular-quantidade-1000000.png](../evidencias/BUG-02-api63-calcular-quantidade-1000000.png)
* Teste automatizado em `automacao/` (falha de propósito enquanto o bug existir).
