import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  // A API não guarda estado, então os testes podem rodar em paralelo sem interferir um no outro.
  fullyParallel: true,
  retries: 0,
  reporter: [['list'], ['html', { open: 'never' }]],

  use: {
    baseURL: 'https://verzel-store.qa-test-verzel-store.workers.dev',
    locale: 'pt-BR',
    // Evidência automática: print e trace só quando o teste falha.
    screenshot: 'only-on-failure',
    trace: 'retain-on-failure',
  },

  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
});
