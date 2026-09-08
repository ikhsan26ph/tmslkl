# TMS — Claude Code

Baca dan ikuti `docs/agent-guide.md` sebagai sumber utama aturan proyek.
Semua path relatif terhadap root repository.

Slash command di `.claude/commands/` meneruskan tugas dan argumen ke
`docs/workflows/`. Definisi `.claude/agents/` merujuk `docs/roles/`.
Gunakan peran secara berurutan; delegasi opsional mengikuti izin dan kemampuan sesi.
Konfigurasi browser MCP Claude ada di `.mcp.json`.
Perbarui prosedur bersama di `docs/`, bukan menyalinnya ke adapter ini.

Mesin ini diduplikasi dari project OMS (`/home/icun/Project/omstest`) pada 2026-09-08.
Pengetahuan spesifik aplikasi OMS (module-map, selector-map, recipe, decisions) sengaja
TIDAK dibawa. Satu-satunya warisan adalah checklist hipotesis di bawah.

## Hipotesis dari OMS — BELUM diverifikasi di TMS

Gotcha teknis yang ditemukan saat mengotomasi OMS. Di TMS semuanya berstatus **hipotesis**:
verifikasi saat `/explore` dan `/harvest-selectors`, **jangan dipakai sebagai aturan otomatis**.
Setelah dicek, ubah kolom Status menjadi `TERVERIFIKASI SAMA` / `BERBEDA` / `BELUM DICEK`
beserta tanggal dan bukti (halaman + selector/DOM yang diperiksa). Bila `BERBEDA`, hapus
sisa asumsi terkait di `tests/helpers/fixtures.js`, `playwright.config.js`, dan `docs/`.

| # | Hipotesis (perilaku di OMS) | Cara verifikasi di TMS (read-only) | Status | Tanggal | Bukti / Catatan |
|---|---|---|---|---|---|
| H1 | `locator.click()` tidak memicu handler React pada sesi Playwright MCP — perlu `locator.dispatchEvent('click')` | Pada 1 halaman list + 1 form: klik tombol yang membuka filter/modal dengan `click()` biasa, cek DOM/network berubah; ulangi dengan `dispatchEvent('click')` | BELUM DICEK | — | — |
| H2 | Backend menolak sesi yang dipindah antar browser-context (`storageState` tidak berfungsi) → login 1x per worker, context dibiarkan hidup, `workers: 1` | Login, `context.storageState()`, buka context baru dengan state itu, akses halaman ber-auth — di-redirect ke login atau tidak | BELUM DICEK | — | — |
| H3 | Dropdown = custom combobox `button[aria-haspopup="listbox"]` + item `role="option"` (bukan `<select>` native) | Inspeksi 1 dropdown filter (list) dan 1 dropdown form: tag, `aria-haspopup`, role item | BELUM DICEK | — | — |
| H4 | Datepicker = `div[role="button"]` + grid `button.h-9.w-9`; baris pertama berisi sisa tanggal bulan lalu (tanggal 26–31 ambigu → `.nth(1)`); sebagian instance default bukan bulan berjalan; tidak auto-close pada field tanggal+jam | Buka datepicker di form: struktur sel, header bulan default, isi baris pertama, perilaku close | BELUM DICEK | — | — |
| H5 | Modal/dialog tidak memakai `role="dialog"` | Buka 1 modal lalu `document.querySelector('[role="dialog"]')` | BELUM DICEK | — | — |
| H6 | Tidak ada `data-testid` sama sekali di implementasi | `document.querySelectorAll('[data-testid]').length` pada list + form | BELUM DICEK | — | — |
| H7 | Login: field via placeholder `Masukkan Email` / `Masukkan Password`, tombol `role=button name="Login"`, redirect ke satu halaman dashboard tetap | Kalibrasi login → isi key `login*` di `config/env.md` (format: `config/env.example.md`) | BELUM DICEK | — | — |
