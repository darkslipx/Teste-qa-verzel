# Evidências da execução

Prints dos casos reprovados, capturados em 06/10/2026. Os pontos divergentes estão marcados em vermelho.

Padrão de nome: `BUG-XX-casoNN-tela-ou-endpoint-situacao.png`.

## Interface

Capturadas no Google Chrome (Windows). As versões mobile usam o modo responsivo do DevTools com 400 px de largura.

| Print | Bug | Caso | O que mostra |
|---|---|---|---|
| [BUG-01-ui03-carrinho-200-sem-cupom.png](BUG-01-ui03-carrinho-200-sem-cupom.png) | BUG-01 | UI-03 | 2 Mochilas (subtotal R$ 200,00), sem cupom: frete R$ 19,90, total R$ 219,90 e "Faltam R$ 0,00 para o frete grátis" |
| [BUG-01-ui04-carrinho-200-com-cupom.png](BUG-01-ui04-carrinho-200-com-cupom.png) | BUG-01 | UI-04 | Mesmo carrinho com BEMVINDO10: desconto R$ 20,00, frete R$ 19,90, total R$ 199,90 em vez de R$ 180,00 |
| [BUG-01-ui03-mobile-carrinho-200-sem-cupom.png](BUG-01-ui03-mobile-carrinho-200-sem-cupom.png) | BUG-01 | UI-03 | O mesmo da UI-03 na visualização mobile |
| [BUG-01-ui04-mobile-carrinho-200-com-cupom.png](BUG-01-ui04-mobile-carrinho-200-com-cupom.png) | BUG-01 | UI-04 | O mesmo da UI-04 na visualização mobile |
| [BUG-03-ui26-sobrenome-simbolos.png](BUG-03-ui26-sobrenome-simbolos.png) | BUG-03 | UI-26 | Nome "Abner @@" sem mensagem de erro, enquanto o CEP com 7 dígitos exibe erro |
| [BUG-04-ui25-email-dominio-invalido.png](BUG-04-ui25-email-dominio-invalido.png) | BUG-04 | UI-25 | E-mail "abnerduartw@!!!!.com" sem mensagem de erro, enquanto o CEP com 7 dígitos exibe erro |

## API

Capturadas no VS Code com a extensão REST Client. A requisição e o resultado esperado aparecem à esquerda e a resposta da API à direita.

| Print | Bug | Caso | O que mostra |
|---|---|---|---|
| [BUG-01-api06-calcular-200-sem-cupom.png](BUG-01-api06-calcular-200-sem-cupom.png) | BUG-01 | API-06 | 2 Mochilas (subtotal 200), sem cupom: frete 19.9, freteGratis false, valorFaltanteFreteGratis 0, total 219.9 |
| [BUG-01-api07-calcular-200-com-cupom.png](BUG-01-api07-calcular-200-com-cupom.png) | BUG-01 | API-07 | 2 Mochilas com BEMVINDO10: desconto 20, frete 19.9, total 199.9 em vez de 180 |
| [BUG-02-api22-calcular-quantidade-6.png](BUG-02-api22-calcular-quantidade-6.png) | BUG-02 | API-22 | Cálculo com 6 unidades responde 200 em vez de 422 QUANTIDADE_MAXIMA_EXCEDIDA |
| [BUG-02-api39-pedido-quantidade-6.png](BUG-02-api39-pedido-quantidade-6.png) | BUG-02 | API-39 | Pedido com 6 unidades criado (201, VZ-941889) |
| [BUG-03-api41-pedido-sobrenome-simbolos.png](BUG-03-api41-pedido-sobrenome-simbolos.png) | BUG-03 | API-41 | Pedido com nome "Abner @@" criado (201, VZ-266813) |
| [BUG-04-api43-pedido-email-dominio-invalido.png](BUG-04-api43-pedido-email-dominio-invalido.png) | BUG-04 | API-43 | Pedido com e-mail "abnerduartw@!!!!.com" criado (201, VZ-177303) |

## Demais evidências

* **Casos aprovados da API:** conferidos na resposta do REST Client. Podem ser reexecutados pelo arquivo [verzel-store-api.http](../execucao/verzel-store-api.http).
* **Casos aprovados da interface:** registrados em [resultados-interface.md](../execucao/resultados-interface.md) e [sessao-exploratoria.md](../execucao/sessao-exploratoria.md).

## Automação

| Print | O que mostra |
|---|---|
| [automacao-relatorio-playwright.png](automacao-relatorio-playwright.png) | Relatório HTML do Playwright em 06/10/2026: 6 testes, 3 aprovados e 3 reprovados pelos bugs (API-06 e UI-03 pelo BUG-01, API-22 pelo BUG-02) |

Ao rodar a automação, o Playwright gera um novo relatório em `automacao/playwright-report`, com print da tela e trace de cada teste que falhou (instruções no [README principal](../README.md)).
