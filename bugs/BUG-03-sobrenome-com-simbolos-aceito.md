# BUG-03: nome com sobrenome composto só de símbolos é aceito

| Campo | Valor |
|---|---|
| Card | VZS-142 (versão 2.3.0) |
| Regra violada | Cliente: nome e sobrenome |
| Severidade | Baixa |
| Prioridade | Baixa |
| Onde ocorre | Interface (formulário de finalização) e API (`/api/pedidos`) |
| Ambiente | https://verzel-store.qa-test-verzel-store.workers.dev/, Google Chrome, Windows e REST Client |
| Data | 06/10/2026 |
| Casos reprovados | UI-26, API-41, API-65 |
| Interpretação | A05 em [AMBIGUIDADES.md](../AMBIGUIDADES.md) |

## Descrição

A documentação exige nome e sobrenome. O sistema recusa um nome sem sobrenome, mas aceita um segundo termo formado apenas por símbolos, como `Abner @@`. A validação confere só se existem duas palavras, sem olhar o conteúdo.

## Passos para reproduzir (interface)

1. Adicionar qualquer produto ao carrinho e seguir para a finalização.
2. Preencher nome `Abner @@`, e-mail `maria@exemplo.com` e CEP `01310-100`.
3. Clicar em Finalizar compra.

## Passos para reproduzir (API)

```http
POST /api/pedidos
Content-Type: application/json

{
  "cliente": { "nome": "Abner @@", "email": "maria@exemplo.com", "cep": "01310-100" },
  "itens": [ { "produtoId": "P001", "quantidade": 1 } ]
}
```

## Resultado esperado

Pedido recusado. Na API, status 422 `DADOS_INVALIDOS` com `nome` na lista de campos. Na interface, mensagem de erro no campo nome.

## Resultado obtido

Pedido criado. Na API, status **201 Created**, número `VZ-266813`.

O mesmo acontece com um sobrenome só de números: `Maria 12` gera o pedido `VZ-180329` (API-65).

## Observações

* Nome sem sobrenome (API-40) e nome só com espaços (API-42) são recusados corretamente.
* Severidade baixa porque não afeta valores, mas compromete a qualidade dos dados de cadastro e entrega.

## Evidências

* API-41: [BUG-03-api41-pedido-sobrenome-simbolos.png](../evidencias/BUG-03-api41-pedido-sobrenome-simbolos.png)
* API-65: [BUG-03-api65-pedido-sobrenome-numeros.png](../evidencias/BUG-03-api65-pedido-sobrenome-numeros.png)
* UI-26: [BUG-03-ui26-sobrenome-simbolos.png](../evidencias/BUG-03-ui26-sobrenome-simbolos.png) (o campo nome não exibe erro, enquanto o CEP com 7 dígitos exibe)
