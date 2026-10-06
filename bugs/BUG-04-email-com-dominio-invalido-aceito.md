# BUG-04: e-mail com domínio inválido é aceito

| Campo | Valor |
|---|---|
| Card | VZS-142 (versão 2.3.0) |
| Regra violada | Cliente: e-mail em formato válido |
| Severidade | Média |
| Prioridade | Média |
| Onde ocorre | Interface (formulário de finalização) e API (`/api/pedidos`) |
| Ambiente | https://verzel-store.qa-test-verzel-store.workers.dev/, Google Chrome, Windows e REST Client |
| Data | 06/10/2026 |
| Casos reprovados | UI-25, API-43 |

## Descrição

A documentação exige e-mail em formato válido. O sistema aceita `abnerduartw@!!!!.com`, cujo domínio é formado só por símbolos e não pode existir. A validação confere apenas o padrão geral `texto@texto.texto`.

## Passos para reproduzir (interface)

1. Adicionar qualquer produto ao carrinho e seguir para a finalização.
2. Preencher nome `Maria Silva`, e-mail `abnerduartw@!!!!.com` e CEP `01310-100`.
3. Clicar em Finalizar compra.

## Passos para reproduzir (API)

```http
POST /api/pedidos
Content-Type: application/json

{
  "cliente": { "nome": "Maria Silva", "email": "abnerduartw@!!!!.com", "cep": "01310-100" },
  "itens": [ { "produtoId": "P001", "quantidade": 1 } ]
}
```

## Resultado esperado

Pedido recusado. Na API, status 422 `DADOS_INVALIDOS` com `email` na lista de campos. Na interface, mensagem de erro no campo e-mail.

## Resultado obtido

Pedido criado. Na API, status **201 Created**, número `VZ-177303`.

## Observações

* E-mail sem @ (API-44) e sem extensão de domínio (API-45) são recusados corretamente.
* Severidade média porque o e-mail é o canal de contato com o cliente. Um endereço impossível impede qualquer comunicação sobre o pedido.

## Evidências

* API-43: [BUG-04-api43-pedido-email-dominio-invalido.png](../evidencias/BUG-04-api43-pedido-email-dominio-invalido.png)
* UI-25: [BUG-04-ui25-email-dominio-invalido.png](../evidencias/BUG-04-ui25-email-dominio-invalido.png) (o campo e-mail não exibe erro, enquanto o CEP com 7 dígitos exibe)
