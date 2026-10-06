# Sessão exploratória: interface

**Data:** 06/10/2026
**Ambiente:** Google Chrome, Windows, desktop e visualização mobile
**Missão:** explorar o carrinho, o cupom de desconto, a regra de frete grátis e a finalização do pedido, buscando divergências em relação aos critérios de aceite da entrega VZS-142.

## Roteiro seguido

1. Leitura completa da documentação, com atenção à seção "Sobre este ambiente".
2. Navegação pela lista e pelas páginas de produtos.
3. Montagem do carrinho com todos os produtos na quantidade máxima, conferindo o total de cada item e o subtotal.
4. Combinações de produtos em torno do limite de R$ 200,00 (abaixo, exatamente e acima).
5. Remoção de itens um a um até ficar abaixo de R$ 200,00 e nova adição para ultrapassar o limite.
6. Aplicação, remoção e reaplicação de cupons válidos, expirados e inexistentes, com variações de maiúsculas, minúsculas e espaços.
7. Tentativas de ultrapassar o limite de 5 unidades pelo botão +, pelo campo de quantidade e pelo botão Adicionar da página do produto.
8. Recarregamento da página, esvaziamento do carrinho e navegação com o botão Voltar.
9. Preenchimento do formulário de finalização com dados válidos e inválidos, com e sem cupom.
10. Repetição do cenário do limite de frete na visualização mobile.

## Achados

| Achado | Classificação |
|---|---|
| Subtotal de exatamente R$ 200,00 cobra frete de R$ 19,90, exibindo ao mesmo tempo "Faltam R$ 0,00 para o frete grátis" | BUG-01 |
| Teste de isolamento com subtotal R$ 219,80 e cupom confirmou que a falha ocorre apenas no valor limite, e não na regra do CA08 | Diagnóstico do BUG-01 |
| E-mail com domínio contendo símbolos (abnerduartw@!!!!.com) é aceito | BUG-02 |
| Sobrenome composto apenas de símbolos ou números com 2 caracteres é aceito | BUG-03 |
| Qualquer CEP de 8 dígitos é aceito | Comportamento esperado |
| Cupom permanece aplicado após recarregar a página | Comportamento esperado |

## Conclusão

O fluxo principal de carrinho e cupom está estável: cálculos por item, subtotal, desconto, arredondamento, mensagens de cupom e limite de quantidade funcionaram conforme os critérios. As falhas encontradas concentram-se no valor limite do frete grátis e na validação dos dados do cliente.
