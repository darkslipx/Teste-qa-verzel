import { test, expect, Page } from '@playwright/test';

// Adiciona um produto ao carrinho pela vitrine, clicando em "Adicionar ao carrinho" a quantidade de vezes pedida.
async function adicionarProduto(page: Page, nome: string, quantidade = 1) {
  const card = page.getByRole('article', { name: nome });
  for (let i = 0; i < quantidade; i++) {
    await card.getByRole('button', { name: 'Adicionar ao carrinho' }).click();
  }
}

async function aplicarCupom(page: Page, cupom: string) {
  await page.getByLabel('Cupom de desconto').fill(cupom);
  await page.getByRole('button', { name: 'Aplicar cupom' }).click();
  await expect(page.getByText(`Cupom ${cupom} aplicado.`)).toBeVisible();
}

// Valores do quadro "Resumo do pedido". Cada linha tem um atributo data-valor na página.
function resumo(page: Page) {
  return {
    subtotal: page.locator('[data-valor="subtotal"]'),
    desconto: page.locator('[data-valor="desconto"]'),
    frete: page.locator('[data-valor="frete"]'),
    total: page.locator('[data-valor="total"]'),
  };
}

test.describe('Frete grátis no carrinho', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
  });

  test(
    'UI-03: subtotal exatamente R$ 200,00 tem frete grátis',
    {
      tag: ['@bug', '@CA06'],
      annotation: { type: 'bug', description: 'BUG-01: frete cobrado com subtotal exatamente R$ 200,00' },
    },
    async ({ page }) => {
      await adicionarProduto(page, 'Mochila Urbana 20L', 2);
      await page.goto('/carrinho');

      const valores = resumo(page);
      await expect(valores.subtotal).toHaveText('R$ 200,00');
      // Esperado pela documentação (CA06). Hoje a loja mostra R$ 19,90, então este teste falha de propósito.
      await expect(valores.frete).toHaveText('Grátis');
      await expect(valores.total).toHaveText('R$ 200,00');
    },
  );

  test(
    'UI-05: frete grátis considera o subtotal antes do desconto',
    { tag: ['@CA08', '@CA09'] },
    async ({ page }) => {
      // 189,90 + 29,90 = 219,80. Com 10% de desconto o valor cai para 197,82, abaixo de 200.
      await adicionarProduto(page, 'Tênis Casual Urbano');
      await adicionarProduto(page, 'Kit 3 Pares de Meias');
      await page.goto('/carrinho');
      await aplicarCupom(page, 'BEMVINDO10');

      const valores = resumo(page);
      await expect(valores.subtotal).toHaveText('R$ 219,80');
      await expect(valores.desconto).toHaveText('- R$ 21,98');
      await expect(valores.frete).toHaveText('Grátis');
      await expect(valores.total).toHaveText('R$ 197,82');
    },
  );
});
