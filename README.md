# Teste técnico de QA: Verzel Store

Teste da entrega **"Cupom de desconto e frete grátis"** (card VZS-142, versão 2.3.0) da Verzel Store, feito por **Abner Duarte** para a vaga de QA Júnior da Verzel.

* Loja: https://verzel-store.qa-test-verzel-store.workers.dev/
* Documentação: https://verzel-store.qa-test-verzel-store.workers.dev/documentacao
* API: https://verzel-store.qa-test-verzel-store.workers.dev/api
* Execução: 06/10/2026, Google Chrome no Windows (desktop e mobile pelo DevTools)

## Resumo

| | Total | Aprovados | Reprovados | Não aplicáveis |
|---|---|---|---|---|
| Interface | 30 | 25 | 4 | 1 |
| API | 56 | 48 | 8 | 0 |
| Automação | 6 | 3 | 3 | 0 |

**4 bugs encontrados:**

| Bug | Resumo | Severidade | Onde |
|---|---|---|---|
| [BUG-01](bugs/BUG-01-frete-cobrado-com-subtotal-200.md) | Frete cobrado com subtotal exatamente R$ 200,00 (CA06) | Alta | Interface e API |
| [BUG-02](bugs/BUG-02-api-aceita-quantidade-acima-de-5.md) | API aceita mais de 5 unidades por produto (CA10) | Alta | API |
| [BUG-03](bugs/BUG-03-sobrenome-com-simbolos-aceito.md) | Nome com sobrenome só de símbolos é aceito | Baixa | Interface e API |
| [BUG-04](bugs/BUG-04-email-com-dominio-invalido-aceito.md) | E-mail com domínio inválido é aceito | Média | Interface e API |

## Onde está cada entrega

| Entrega pedida | Onde encontrar |
|---|---|
| 1. Cenários de teste (Gherkin) | [cenarios/](cenarios/): 5 arquivos `.feature` e um [índice](cenarios/README.md) com a cobertura de cada critério de aceite |
| 2. Execução dos testes manuais e exploratórios | [execucao/resultados-interface.md](execucao/resultados-interface.md), [execucao/resultados-api.md](execucao/resultados-api.md) e [execucao/sessao-exploratoria.md](execucao/sessao-exploratoria.md) |
| 3. Report dos bugs | [bugs/](bugs/): um relatório por bug |
| 4. Evidências da execução | [evidencias/](evidencias/): prints da interface, da API e da automação, com [índice](evidencias/README.md) |
| 5. Automação com Playwright | [automacao/](automacao/): 2 testes de interface e 4 de API |
| 6. Como rodar a automação | Seção [Como rodar a automação](#como-rodar-a-automação) abaixo |
| Ambiguidades e interpretações | [AMBIGUIDADES.md](AMBIGUIDADES.md) |
| Uso de IA | [USO-DE-IA.md](USO-DE-IA.md) |

## Estrutura do repositório

```
├── AMBIGUIDADES.md         Pontos não definidos na documentação e a interpretação adotada
├── USO-DE-IA.md            Onde e como a IA foi usada
├── cenarios/               Cenários em Gherkin (.feature)
├── execucao/               Resultados da execução manual e coleção de requisições da API (.http)
├── bugs/                   Relatórios de bug
├── evidencias/             Prints da execução
└── automacao/              Projeto Playwright
    ├── playwright.config.ts
    └── tests/
        ├── ui/frete.spec.ts
        └── api/
            ├── carrinho.spec.ts
            └── pedidos.spec.ts
```

Os IDs são os mesmos em todo o repositório. Um caso como `UI-03` aparece com esse nome nos cenários (como tag), na execução, no relatório do BUG-01, na evidência e no teste automatizado.

## Como rodar a automação

### Requisitos

* [Node.js](https://nodejs.org/) 20 ou superior
* Git

### Passo a passo

```bash
git clone https://github.com/darkslipx/Teste-qa-verzel.git
cd Teste-qa-verzel/automacao
npm install
npx playwright install chromium
npm test
```

### Comandos disponíveis

Rode estes comandos dentro da pasta `automacao`:

| Comando | O que faz |
|---|---|
| `npm test` | Roda os 6 testes |
| `npm run test:ui` | Roda só os testes de interface |
| `npm run test:api` | Roda só os testes de API |
| `npm run test:sem-bugs` | Roda só os testes que não cobrem bugs (todos devem passar) |
| `npm run test:headed` | Roda os testes de interface com o navegador visível |
| `npm run report` | Abre o relatório HTML da última execução |

### Testes automatizados

| Teste | Tipo | Regra | Resultado atual |
|---|---|---|---|
| UI-03: subtotal exatamente R$ 200,00 tem frete grátis | Interface | CA06 | Falha (BUG-01) |
| UI-05: frete grátis considera o subtotal antes do desconto | Interface | CA08, CA09 | Passa |
| API-06: subtotal exatamente 200 tem frete grátis | API | CA06 | Falha (BUG-01) |
| API-22: quantidade acima de 5 é recusada | API | CA10 | Falha (BUG-02) |
| API-34: pedido válido com cupom é criado com os valores corretos | API | CA01, CA09 | Passa |
| API-38: pedido com cupom expirado é recusado | API | CA04 | Passa |

### Por que 3 testes falham

Os testes verificam o comportamento **definido na documentação**. Os testes UI-03, API-06 e API-22 cobrem bugs reais e por isso falham hoje, de propósito. Quando os bugs forem corrigidos, eles passam sem nenhuma alteração e servem como teste de regressão.

Esses testes têm a tag `@bug` e uma anotação com o número do bug, que aparece no relatório HTML. Para rodar só os testes que devem passar, use `npm run test:sem-bugs`.

Quando um teste falha, o Playwright salva um print da tela e um trace da execução, que podem ser vistos no relatório (`npm run report`).

## Fora do escopo

Seguindo as regras do teste, não foram feitos testes de carga, estresse ou segurança. Também não foram considerados bugs os comportamentos descritos em "Sobre este ambiente" na documentação: carrinho só na aba do navegador, pedidos não armazenados, nenhum e-mail ou cobrança, produtos e cupons fixos, sem estoque e API sem estado.
