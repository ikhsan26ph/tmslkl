const { defineConfig, devices } = require('@playwright/test');
const { parseEnv } = require('./tests/helpers/env');

const env = parseEnv();

module.exports = defineConfig({
  testDir: './tests',
  outputDir: 'artifacts/test-results',
  timeout: 90_000,
  expect: { timeout: 10_000 },
  // 1 worker: strategi sesi diwarisi dari OMS (hipotesis H2 di CLAUDE.md — backend menolak
  // sesi lintas context, jadi seluruh test berbagi satu context login via tests/helpers/fixtures.js)
  // dan staging berisi data nyata, jangan paralel. Tinjau ulang bila H2 terbukti BERBEDA di TMS.
  fullyParallel: false,
  workers: 1,
  // Login gagal tidak boleh di-retry otomatis (aturan docs/agent-guide.md: 2x gagal = berhenti;
  // guard tambahan ada di fixtures.js).
  retries: 0,
  reporter: [
    ['line'],
    ['json', { outputFile: 'results/_playwright/last-run.json' }],
  ],
  use: {
    baseURL: env.baseUrl,
    actionTimeout: 10_000,
    navigationTimeout: 30_000,
    trace: 'retain-on-failure',
  },
  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
  ],
});
