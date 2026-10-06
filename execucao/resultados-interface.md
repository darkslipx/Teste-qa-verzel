# Resultados da execução: interface

**Ambiente:** https://verzel-store.qa-test-verzel-store.workers.dev/
**Navegador:** Google Chrome (desktop e visualização mobile via DevTools)
**Sistema:** Windows
**Data da execução:** 06/10/2026
**Tipo de teste:** funcional manual e exploratório

## Resumo

| Total | Aprovados | Reprovados | Não aplicáveis |
|---|---|---|---|
| 30 | 25 | 4 | 1 |

## Carrinho e cálculo

| ID | Cenário | Critério | Resultado | Evidência |
|---|---|---|---|---|
| UI-01 | Carrinho com 5 unidades de todos os produtos calcula subtotal de R$ 4.247,00 e frete grátis | CA06, CA10, CA11 | Aprovado | Sem print |
| UI-02 | Total por item igual a preço unitário vezes quantidade | Regras de cálculo | Aprovado | Sem print |
| UI-03 | Subtotal exatamente R$ 200,00 sem cupom tem frete grátis | CA06 | **Reprovado (BUG-01)** | [BUG-01-ui03-carrinho-200-sem-cupom.png](../evidencias/BUG-01-ui03-carrinho-200-sem-cupom.png), [BUG-01-ui03-mobile-carrinho-200-sem-cupom.png](../evidencias/BUG-01-ui03-mobile-carrinho-200-sem-cupom.png) |
| UI-04 | Subtotal exatamente R$ 200,00 com cupom tem frete grátis e total R$ 180,00 | CA06, CA08 | **Reprovado (BUG-01)** | [BUG-01-ui04-carrinho-200-com-cupom.png](../evidencias/BUG-01-ui04-carrinho-200-com-cupom.png), [BUG-01-ui04-mobile-carrinho-200-com-cupom.png](../evidencias/BUG-01-ui04-mobile-carrinho-200-com-cupom.png) |
| UI-05 | Subtotal R$ 219,80 com cupom mantém frete grátis (total R$ 197,82) | CA08, CA09 | Aprovado | Sem print |
| UI-06 | Subtotal R$ 199,80 cobra frete de R$ 19,90 e informa faltante de R$ 0,20 | CA07, CA11 | Aprovado | Sem print |
| UI-07 | Remover itens até ficar abaixo de R$ 200,00 passa a cobrar frete, e adicionar novamente volta ao frete grátis | CA06, CA07 | Aprovado | Sem print |
| UI-08 | Esvaziar carrinho zera itens, cupom e resumo | Carrinho | Aprovado | Sem print |
| UI-09 | Contador do carrinho no topo reflete o total de unidades | Carrinho | Aprovado | Sem print |

## Quantidade

| ID | Cenário | Critério | Resultado | Evidência |
|---|---|---|---|---|
| UI-10 | Botão + do carrinho não ultrapassa 5 unidades | CA10 | Aprovado | Sem print |
| UI-11 | Campo de quantidade recusa 6, 0 e valor vazio | CA10 | Aprovado | Sem print |
| UI-12 | Botão Adicionar na página do produto exibe limite atingido após 5 unidades | CA10 | Aprovado | Sem print |

## Cupom

| ID | Cenário | Critério | Resultado | Evidência |
|---|---|---|---|---|
| UI-13 | Cupom BEMVINDO10 aplica 10% sobre o subtotal | CA01 | Aprovado | Sem print |
| UI-14 | Cupom em minúsculas (bemvindo10) é aceito | CA02 | Aprovado | Sem print |
| UI-15 | Cupom com espaços no início e no fim é aceito | CA02 | Aprovado | Sem print |
| UI-16 | Cupom inexistente exibe "Cupom inválido." sem desconto | CA03 | Aprovado | Sem print |
| UI-17 | Cupom VERAO2026 exibe "Cupom expirado." sem desconto | CA04 | Aprovado | Sem print |
| UI-18 | Cupom verao2026 em minúsculas exibe "Cupom expirado." | CA02, CA04 | Aprovado | Sem print |
| UI-19 | Aplicar cupom com campo vazio não aplica desconto | CA03 | Aprovado | Sem print |
| UI-20 | Remover cupom e aplicar novamente recalcula corretamente | CA05 | Aprovado | Sem print |
| UI-21 | Tecla Enter no campo aplica o cupom | Usabilidade | Aprovado | Sem print |
| UI-22 | Carrinho e cupom mantidos após recarregar a página (F5) | Ambiente | Aprovado | Sem print |

## Finalização do pedido

| ID | Cenário | Critério | Resultado | Evidência |
|---|---|---|---|---|
| UI-23 | CEP com 8 dígitos é aceito, com ou sem hífen | Regra de CEP | Aprovado | Sem print |
| UI-24 | CEP com letras ou símbolos é recusado | Regra de CEP | Aprovado | Sem print |
| UI-25 | E-mail com domínio inválido (abnerduartw@!!!!.com) é recusado | Regra de e-mail | **Reprovado (BUG-04)** | [BUG-04-ui25-email-dominio-invalido.png](../evidencias/BUG-04-ui25-email-dominio-invalido.png) |
| UI-26 | Nome com sobrenome composto apenas de símbolos (Abner @@) é recusado | Regra de nome | **Reprovado (BUG-03)** | [BUG-03-ui26-sobrenome-simbolos.png](../evidencias/BUG-03-ui26-sobrenome-simbolos.png) |
| UI-27 | Valores da tela de confirmação iguais ao resumo do carrinho, com e sem cupom | Pedido | Aprovado | Sem print |
| UI-28 | Botão Finalizar compra não gera pedido duplicado em clique repetido | Pedido | Aprovado | Sem print |
| UI-29 | Voltar no navegador após confirmar exibe carrinho vazio | Pedido | Aprovado | Sem print |

## Navegação

| ID | Cenário | Critério | Resultado | Evidência |
|---|---|---|---|---|
| UI-30 | URL de produto inexistente exibe mensagem de erro amigável | Navegação | Não aplicável | |

## Observações da execução

* **UI-03, UI-04:** o mesmo comportamento foi reproduzido na visualização mobile (DevTools, 400 px de largura).
* **UI-19:** comportamento não definido na documentação. Interpretação registrada em AMBIGUIDADES.md (A01).
* **UI-22:** a documentação define apenas que o carrinho fica na aba do navegador. A permanência do cupom após recarregar foi considerada correta (A04).
* **UI-23:** qualquer sequência de 8 dígitos é aceita (inclusive 00000000). Considerado comportamento esperado, pois a regra exige apenas o formato e não a existência do CEP (A03).
* **UI-25, UI-26:** as prints mostram que o campo com o dado inválido não exibe mensagem de erro, enquanto o campo CEP, preenchido com 7 dígitos, exibe. Isso mostra que a validação do formulário está ativa e que o nome e o e-mail inválidos passam por ela.
* **UI-30:** a navegação da loja não expõe o id do produto na URL, portanto não é possível acessar um produto inexistente pela interface. O cenário foi coberto pela API (API-03). Interpretação registrada em AMBIGUIDADES.md (A06).
