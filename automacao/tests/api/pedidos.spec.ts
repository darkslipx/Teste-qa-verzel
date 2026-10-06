import { test, expect } from '@playwright/test';

const clienteValido = {
  nome: 'Maria Silva',
  email: 'maria@exemplo.com',
  cep: '01310-100',
};

test.describe('API: POST /api/pedidos', () => {
  test(
    'API-34: pedido válido com cupom é criado com os valores corretos',
    { tag: ['@CA01', '@CA09'] },
    async ({ request }) => {
      const resposta = await request.post('/api/pedidos', {
        data: {
          cliente: clienteValido,
          itens: [{ produtoId: 'P005', quantidade: 1 }],
          cupom: 'BEMVINDO10',
        },
      });

      expect(resposta.status()).toBe(201);
      const pedido = await resposta.json();
      expect(pedido.numero).toMatch(/^VZ-\d{6}$/);
      // O CEP volta sem hífen.
      expect(pedido.cliente.cep).toBe('01310100');
      // 100,00 menos 10% = 90,00. Abaixo de 200, então soma o frete de 19,90.
      expect(pedido).toMatchObject({
        subtotal: 100,
        desconto: 10,
        frete: 19.9,
        freteGratis: false,
        total: 109.9,
      });
    },
  );

  test(
    'API-38: pedido com cupom expirado é recusado',
    { tag: ['@CA04'] },
    async ({ request }) => {
      const resposta = await request.post('/api/pedidos', {
        data: {
          cliente: clienteValido,
          itens: [{ produtoId: 'P001', quantidade: 1 }],
          cupom: 'VERAO2026',
        },
      });

      expect(resposta.status()).toBe(422);
      const corpo = await resposta.json();
      expect(corpo.erro).toMatchObject({
        codigo: 'CUPOM_EXPIRADO',
        mensagem: 'Cupom expirado.',
        campo: 'cupom',
      });
    },
  );
});
