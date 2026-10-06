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
    // Testes de API não abrem navegador, então rodam uma vez só.
    {
      name: 'api',
      testDir: './tests/api',
    },
    // Testes de interface rodam nos três motores de navegador e na visualização mobile.
    {
      name: 'chrome',
      testDir: './tests/ui',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      testDir: './tests/ui',
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'safari',
      testDir: './tests/ui',
      use: { ...devices['Desktop Safari'] },
    },
    {
      name: 'mobile',
      testDir: './tests/ui',
      use: { ...devices['Pixel 7'] },
    },
  ],
});
