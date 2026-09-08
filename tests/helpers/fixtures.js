// Fixture sesi TMS.
// Strategi sesi diwarisi dari OMS (hipotesis H2 di CLAUDE.md, BELUM diverifikasi di TMS):
// login dilakukan SEKALI per worker dan seluruh test berbagi context hidup yang sama, karena di
// OMS backend menolak sesi yang dipindah antar browser-context (storageState tidak berlaku).
// Konsekuensi: worker harus 1 (lihat playwright.config.js) dan test dalam satu file berjalan serial.
// Jika di TMS storageState terbukti bekerja, fixture ini boleh disederhanakan.
//
// Selector login dan URL sukses TIDAK di-hardcode — dibaca dari config/env.md
// (key loginPath, loginSuccessUrlPattern, loginEmailSelector, loginPasswordSelector,
// loginButtonSelector; format: config/env.example.md).
const fs = require('fs');
const path = require('path');
const base = require('@playwright/test');
const { parseEnv, requireLogin } = require('./env');

// Guard aturan docs/agent-guide.md: login gagal 2x berturut-turut -> BERHENTI (jangan sampai akun terkunci).
// Playwright me-restart worker setelah fixture gagal, yang tanpa guard ini akan mencoba login terus.
const FAIL_FILE = path.join(__dirname, '..', '..', 'artifacts', '.auth', 'login-failures.json');

function readFailures() {
  try {
    return JSON.parse(fs.readFileSync(FAIL_FILE, 'utf8')).count || 0;
  } catch {
    return 0;
  }
}

function writeFailures(count) {
  fs.mkdirSync(path.dirname(FAIL_FILE), { recursive: true });
  fs.writeFileSync(FAIL_FILE, JSON.stringify({ count, at: new Date().toISOString() }));
}

const test = base.test.extend({
  authedContext: [
    async ({ browser }, use) => {
      const env = parseEnv();
      const { baseUrl, main } = env;
      // Key login* masih placeholder = error konfigurasi, bukan percobaan login gagal.
      const login = requireLogin(env);
      if (readFailures() >= 2) {
        throw new Error(
          'Login sudah gagal 2x berturut-turut — eksekusi dihentikan demi keamanan akun. ' +
          'Periksa kredensial di config/env.md, lalu hapus artifacts/.auth/login-failures.json untuk mencoba lagi.'
        );
      }
      const context = await browser.newContext({
        baseURL: baseUrl,
        viewport: { width: 1440, height: 900 },
      });
      const page = await context.newPage();
      try {
        await page.goto(login.loginPath);
        await page.locator(login.loginEmailSelector).fill(main.email);
        await page.locator(login.loginPasswordSelector).fill(main.password);
        await page.locator(login.loginButtonSelector).click();
        await page.waitForURL(new RegExp(login.loginSuccessUrlPattern), { timeout: 30_000 });
        writeFailures(0);
      } catch (err) {
        writeFailures(readFailures() + 1);
        await context.close();
        throw new Error(`Login TMS gagal (percobaan ${readFailures()}/2): ${err.message}`);
      }
      await page.close();
      await use(context);
      await context.close();
    },
    { scope: 'worker' },
  ],

  context: async ({ authedContext }, use) => {
    await use(authedContext);
  },

  page: async ({ authedContext }, use) => {
    const page = await authedContext.newPage();
    await use(page);
    await page.close();
  },

  // Context manual tidak mendapat auto-screenshot dari konfigurasi `screenshot:` —
  // ambil manual saat gagal agar konverter tetap menemukan attachment "screenshot".
  attachScreenshotOnFailure: [
    async ({ page }, use, testInfo) => {
      await use();
      if (testInfo.status !== testInfo.expectedStatus && !page.isClosed()) {
        const shot = testInfo.outputPath('test-failed-1.png');
        try {
          await page.screenshot({ path: shot, fullPage: true });
          testInfo.attachments.push({ name: 'screenshot', path: shot, contentType: 'image/png' });
        } catch {
          /* halaman keburu mati — biarkan tanpa screenshot */
        }
      }
    },
    { auto: true },
  ],
});

module.exports = { test, expect: base.expect };
