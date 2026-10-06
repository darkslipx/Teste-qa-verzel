import { test, expect } from '@playwright/test';

test.describe('API: POST /api/carrinho/calcular', () => {
  test(
    'API-06: subtotal exatamente 200 tem frete grátis',
    {
      tag: ['@bug', '@CA06'],
      annotation: { type: 'bug', description: 'BUG-01: frete cobrado com subtotal exatamente R$ 200,00' },
    },
    async ({ request }) => {
      const resposta = await request.post('/api/carrinho/calcular', {
        data: { itens: [{ produtoId: 'P005', quantidade: 2 }] },
      });

      expect(resposta.status()).toBe(200);
      const corpo = await resposta.json();
      expect(corpo.subtotal).toBe(200);
      // Esperado pela documentação (CA06). Hoje a API retorna frete 19.9, então este teste falha de propósito.
      expect(corpo).toMatchObject({
        frete: 0,
        freteGratis: true,
        valorFaltanteFreteGratis: 0,
        total: 200,
      });
    },
  );

  test(
    'API-22: quantidade acima de 5 é recusada',
    {
      tag: ['@bug', '@CA10'],
      annotation: { type: 'bug', description: 'BUG-02: API aceita quantidade acima de 5' },
    },
    async ({ request }) => {
      const resposta = await request.post('/api/carrinho/calcular', {
        data: { itens: [{ produtoId: 'P001', quantidade: 6 }] },
      });

      // Esperado pela documentação (CA10). Hoje a API responde 200, então este teste falha de propósito.
      expect(resposta.status()).toBe(422);
      const corpo = await resposta.json();
      expect(corpo.erro).toMatchObject({
        codigo: 'QUANTIDADE_MAXIMA_EXCEDIDA',
        campo: 'itens[0].quantidade',
      });
    },
  );
});
