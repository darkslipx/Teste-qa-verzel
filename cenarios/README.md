# Cenários de teste

Cenários levantados a partir da documentação da entrega VZS-142 (versão 2.3.0), escritos em Gherkin em português (`# language: pt`).

Cada cenário tem tags que ligam ao resto do repositório:

* `@UI-NN` e `@API-NN`: caso executado em [execucao/](../execucao/)
* `@CANN`: critério de aceite da documentação
* `@BUG-NN`: cenário que reprovou, com relatório em [bugs/](../bugs/)
* `@ANN`: interpretação registrada em [AMBIGUIDADES.md](../AMBIGUIDADES.md)

O resultado esperado escrito em cada cenário é o da documentação. Nos cenários com `@BUG`, o sistema hoje faz diferente.

| Arquivo | Funcionalidade | Casos cobertos | Bugs |
|---|---|---|---|
| [01-cupom.feature](01-cupom.feature) | Cupom de desconto na interface | UI-13 a UI-22, UI-31, UI-32 | |
| [02-frete-e-calculo.feature](02-frete-e-calculo.feature) | Frete grátis, desconto, arredondamento e carrinho | UI-01 a UI-09, API-05 a API-12 | BUG-01 |
| [03-quantidade.feature](03-quantidade.feature) | Limite de 5 unidades na interface e na API | UI-10 a UI-12, API-21 a API-27, API-33, API-39, API-63 | BUG-02 |
| [04-finalizacao-do-pedido.feature](04-finalizacao-do-pedido.feature) | Dados do cliente e confirmação | UI-23 a UI-30 | BUG-03, BUG-04 |
| [05-api.feature](05-api.feature) | Produtos, cálculo, cupom, itens, pedidos e protocolo | API-01 a API-66 | BUG-01, BUG-02, BUG-03, BUG-04 |

## Cobertura dos critérios de aceite

| Critério | Cenários |
|---|---|
| CA01 BEMVINDO10 aplica 10% | UI-13, API-04 |
| CA02 Maiúsculas, minúsculas e espaços | UI-14, UI-15, UI-18, API-13, API-14, API-56 |
| CA03 Cupom inexistente | UI-16, API-16, API-36 |
| CA04 Cupom expirado | UI-17, UI-18, UI-32, API-17, API-18, API-38 |
| CA05 Um cupom por vez | UI-20, API-20, API-20b |
| CA06 Frete grátis a partir de R$ 200,00 | UI-03, UI-04, UI-07, API-06, API-07, API-35 |
| CA07 Frete de R$ 19,90 e valor faltante | UI-06, UI-07, API-05, API-11 |
| CA08 Frete considera subtotal antes do desconto | UI-04, UI-05, API-08 |
| CA09 Desconto não incide sobre o frete | UI-05, API-09 |
| CA10 Máximo de 5 unidades | UI-10, UI-11, UI-12, UI-31, API-21, API-22, API-27, API-39, API-63 |
| CA11 Arredondamento em 2 casas | UI-06, API-10, API-11 |

Os cenários marcados na automação estão em [automacao/](../automacao/).
