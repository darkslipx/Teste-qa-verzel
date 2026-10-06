# Ambiguidades e interpretações adotadas

Pontos em que a documentação da entrega VZS-142 (versão 2.3.0) não define o comportamento esperado. Para cada um, registro o que foi observado e a interpretação usada para classificar o resultado.

| ID | Ponto ambíguo | Comportamento observado | Interpretação adotada | Onde aparece |
|---|---|---|---|---|
| A01 | Aplicar cupom com o campo vazio | Interface não aplica desconto. API com `"cupom": ""` responde 200 com `cupom: null`, como se nenhum cupom tivesse sido enviado | Cupom vazio equivale a pedido sem cupom. Não é bug | UI-19, API-19 |
| A02 | Cupom enviado como lista no corpo da API | `["BEMVINDO10","VERAO2026"]` é convertido no texto `"BEMVINDO10,VERAO2026"` e retorna "Cupom inválido." `["BEMVINDO10"]` vira `"BEMVINDO10"`, mas também retorna `aplicado: false` com "Cupom inválido." | CA05 é respeitado, pois nunca há dois descontos. A resposta é ambígua (um código válido aparece como inválido, e o tipo errado não gera 422), mas a documentação não define o tipo do campo para esse caso. Registrado como observação, não como bug | API-20, API-20b |
| A03 | Existência do CEP | Qualquer sequência de 8 dígitos é aceita, inclusive `00000000` | A regra pede apenas 8 dígitos, com ou sem hífen. Validar se o CEP existe não faz parte do escopo. Não é bug | UI-23, sessão exploratória |
| A04 | Cupom após recarregar a página (F5) | Carrinho e cupom continuam aplicados | A documentação diz que o carrinho fica na aba do navegador. Manter o cupom junto com o carrinho foi considerado correto | UI-22 |
| A05 | Conteúdo do sobrenome | Nome sem sobrenome é recusado, mas `Abner @@` é aceito | "Nome e sobrenome" foi interpretado como duas palavras contendo letras. Um sobrenome só de símbolos não é um sobrenome. Com essa interpretação, o comportamento é o BUG-03 | UI-26, API-40, API-41 |
| A06 | Produto inexistente pela interface | A URL da página de produto não expõe o id, então não há como abrir um produto inexistente pela navegação | Cenário marcado como não aplicável na interface e coberto pela API (`GET /api/produtos/P999` retorna 404) | UI-30, API-03 |
