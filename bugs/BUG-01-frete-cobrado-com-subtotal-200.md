# BUG-01: frete cobrado com subtotal exatamente R$ 200,00

| Campo | Valor |
|---|---|
| Card | VZS-142 (versão 2.3.0) |
| Critério violado | CA06 |
| Severidade | Alta |
| Prioridade | Alta |
| Onde ocorre | Interface (desktop e mobile) e API (`/api/carrinho/calcular` e `/api/pedidos`) |
| Ambiente | https://verzel-store.qa-test-verzel-store.workers.dev/, Google Chrome, Windows |
| Data | 06/10/2026 |
| Casos reprovados | UI-03, UI-04, API-06, API-07, API-35 |

## Descrição

O CA06 define frete grátis para subtotal **a partir de** R$ 200,00, inclusive. Com subtotal exatamente R$ 200,00 o sistema cobra frete de R$ 19,90 e, ao mesmo tempo, informa que faltam R$ 0,00 para o frete grátis. A própria resposta fica inconsistente.

## Passos para reproduzir (interface)

1. Acessar a loja.
2. Adicionar 2 unidades de **Mochila Urbana 20L** (P005, R$ 100,00) ao carrinho.
3. Abrir o carrinho e conferir o resumo.
4. Aplicar o cupom `BEMVINDO10` e conferir o resumo novamente.

## Passos para reproduzir (API)

```http
POST /api/carrinho/calcular
Content-Type: application/json

{ "itens": [ { "produtoId": "P005", "quantidade": 2 } ] }
```

Repetir com `"cupom": "BEMVINDO10"` e também em `POST /api/pedidos` com um cliente válido.

## Resultado esperado

| Situação | Subtotal | Desconto | Frete | Total |
|---|---|---|---|---|
| Sem cupom | 200,00 | 0,00 | 0,00 (grátis) | 200,00 |
| Com BEMVINDO10 | 200,00 | 20,00 | 0,00 (grátis) | 180,00 |

Na API: `frete: 0`, `freteGratis: true`, `valorFaltanteFreteGratis: 0`.

## Resultado obtido

| Situação | Subtotal | Desconto | Frete | Total |
|---|---|---|---|---|
| Sem cupom | 200,00 | 0,00 | 19,90 | 219,90 |
| Com BEMVINDO10 | 200,00 | 20,00 | 19,90 | 199,90 |

Na API: `frete: 19.9`, `freteGratis: false`, `valorFaltanteFreteGratis: 0`. O pedido (API-35) é criado com status 201 e total 219.9, então o cliente seria cobrado a mais.

## Isolamento

* Subtotal R$ 199,80 cobra frete e informa faltante de R$ 0,20 (UI-06, API-05): correto.
* Subtotal R$ 219,80 com cupom (R$ 197,82 após o desconto) mantém frete grátis (UI-05, API-08): o CA08 está correto.
* A falha acontece só no valor exato do limite. Causa provável: comparação `subtotal > 200` em vez de `subtotal >= 200`.

## Evidências

* API-06, sem cupom: [BUG-01-api06-calcular-200-sem-cupom.png](../evidencias/BUG-01-api06-calcular-200-sem-cupom.png)
* API-07, com cupom: [BUG-01-api07-calcular-200-com-cupom.png](../evidencias/BUG-01-api07-calcular-200-com-cupom.png)
* UI-03, desktop: [BUG-01-ui03-carrinho-200-sem-cupom.png](../evidencias/BUG-01-ui03-carrinho-200-sem-cupom.png)
* UI-04, desktop: [BUG-01-ui04-carrinho-200-com-cupom.png](../evidencias/BUG-01-ui04-carrinho-200-com-cupom.png)
* UI-03, mobile: [BUG-01-ui03-mobile-carrinho-200-sem-cupom.png](../evidencias/BUG-01-ui03-mobile-carrinho-200-sem-cupom.png)
* UI-04, mobile: [BUG-01-ui04-mobile-carrinho-200-com-cupom.png](../evidencias/BUG-01-ui04-mobile-carrinho-200-com-cupom.png)
* Teste automatizado em `automacao/` (falha de propósito enquanto o bug existir).
