# Uso de IA

O uso de IA era permitido pelas regras do teste. Usei o **Claude** (Anthropic), pelo chat e pelo Claude Code no VS Code, como apoio. A execução dos testes, a análise dos resultados e as decisões sobre o que é ou não bug foram minhas.

## Onde usei e como

| Etapa | Como a IA ajudou | O que eu fiz |
|---|---|---|
| Leitura da documentação | Organizar os critérios de aceite, as regras do cliente e os códigos de erro em listas para consulta | Li a documentação completa, incluindo "Sobre este ambiente" |
| Oráculo de cálculo | Calcular subtotal, desconto, frete e total esperados para cada combinação de produtos | Escolhi as combinações em torno do limite de R$ 200,00 e conferi cada valor na loja e na API |
| Coleção de requisições da API | Gerar o arquivo `execucao/verzel-store-api.http`, com as requisições numeradas e o resultado esperado de cada uma | Executei todas no REST Client, comparei com o esperado e classifiquei cada resultado |
| Testes de interface e exploratórios | Sugerir variações para explorar (limites, cupons, quantidade, formulário) | Executei todos os cenários manualmente, no desktop e no mobile, e conduzi a sessão exploratória |
| Investigação dos bugs | Discutir hipóteses de causa (por exemplo, `> 200` em vez de `>= 200`) | Fiz os testes de isolamento, como o subtotal de R$ 219,80 com cupom, que mostrou que o CA08 estava correto e o problema era só no valor limite |
| Ambiguidades | Ajudar a redigir as interpretações | Identifiquei os pontos ambíguos e decidi a interpretação adotada em cada um |
| Relatórios e documentação | Redigir e padronizar os relatórios de bug, os resultados da execução, o `AMBIGUIDADES.md`, os índices e este README | Revisei o conteúdo, defini a numeração dos bugs e a severidade |
| Revisão de consistência | Conferir se os documentos estavam coerentes entre si. Nessa revisão a IA apontou que a API-35 estava marcada como aprovada por engano, e eu corrigi para reprovada (BUG-01) | Conferi a resposta da API e atualizei o resultado |
| Cenários em Gherkin | Escrever os arquivos `.feature` a partir dos casos que eu já tinha executado | Revisei os cenários e os dados de cada exemplo |
| Automação com Playwright | Montar o projeto e escrever os 7 testes, explicando cada parte. Configurar a execução em Chrome, Firefox, Safari e mobile | Escolhi quais cenários automatizar, rodei os testes, conferi que as falhas correspondem aos bugs e analisei o relatório |
| Integração contínua | Criar o pipeline do GitHub Actions, separando os testes das regras corretas dos testes dos bugs conhecidos | Acompanhei a execução no GitHub e conferi os relatórios gerados |
| Rodada complementar (API-56 a API-66, UI-31 e UI-32) | Depois da primeira rodada, apontar pontos ainda não cobertos (cupom no pedido, tipos inválidos, preço enviado pelo cliente, recálculo do cupom ao mudar a quantidade) e gerar as requisições | Executei as requisições no REST Client e os cenários na interface, e registrei os resultados |
| Evidências | Sugerir o padrão de nomes dos prints | Capturei todos os prints e marquei os pontos divergentes |

## O que não foi feito pela IA

* A execução dos testes manuais na interface e na API.
* A captura das evidências.
* A decisão final sobre o que é bug, a severidade de cada um e a interpretação das ambiguidades.
