# Environment TMS

Salin file ini menjadi `config/env.md` lalu isi nilai `ISI_DISINI`.
Nilai `ISI_SETELAH_EXPLORE` diisi setelah kalibrasi login pada `/explore` pertama.
`config/env.md` masuk `.gitignore` — **jangan pernah di-commit**.

Format tabel di bawah di-parse oleh `tests/helpers/env.js` dan `scripts/playwright_to_results.py` —
jangan mengubah struktur kolomnya. Karakter `|` di dalam nilai harus ditulis `\|`.

## Aplikasi

| Key | Nilai | Keterangan |
|---|---|---|
| baseUrl | ISI_DISINI | contoh: https://tms-staging.example.com |
| loginPath | /login | path halaman login, relatif terhadap baseUrl |
| loginSuccessUrlPattern | ISI_SETELAH_EXPLORE | regex (tanpa `/.../`) yang cocok dengan URL setelah login sukses, mis. `/dashboard` |
| loginEmailSelector | ISI_SETELAH_EXPLORE | selector Playwright untuk `page.locator()`, mis. `[placeholder="Masukkan Email"]` atau `input[name="email"]` |
| loginPasswordSelector | ISI_SETELAH_EXPLORE | mis. `[placeholder="Masukkan Password"]` atau `input[type="password"]` |
| loginButtonSelector | ISI_SETELAH_EXPLORE | mis. `role=button[name="Login"]` atau `button[type="submit"]` |

Selector boleh CSS, `role=...`, `text=...`, atau `xpath=...` — semua sintaks yang diterima `page.locator()`.

## Akun

| No | Email | Password | Role | Keterangan |
|---|---|---|---|---|
| 1 | ISI_DISINI | ISI_DISINI | ISI_DISINI | akun utama (dipakai login test) |
| 2 | ISI_DISINI | ISI_DISINI | ISI_DISINI | opsional — role lain untuk perbandingan akses |
| 3 | ISI_DISINI | ISI_DISINI | ISI_DISINI | opsional |
