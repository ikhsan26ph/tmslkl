# TMS Automation Testing Machine (Claude Code + Codex)

Mesin automation testing **TMS (Transport Management System)** berbasis **Claude Code atau Codex + Playwright**.
Diduplikasi dari mesin OMS (`/home/icun/Project/omstest`) pada 2026-09-08 — hanya mesinnya; peta modul,
selector, dan skenario TMS dibangun dari nol lewat alur di bawah.

## Setup (sekali saja)

1. Buka folder ini di VS Code, pastikan extension/CLI Claude Code terpasang (butuh Node.js ≥ 22, lihat `.nvmrc`).
2. Salin `config/env.example.md` menjadi `config/env.md`, isi link aplikasi + akun (jangan di-commit). Key `login*` (selector field login & URL sukses) diisi setelah kalibrasi login pada `/explore` pertama.
3. Taruh dokumen skenario per modul ke `scenario/<nama-modul>/` (analysis, ui-inventory, .feature, scenarios.json, coverage — skema: `scenario/README.md`). Contoh nama: `scenario/tms001-dashboard-operasional/`.
4. Pilih agent: jalankan `claude` (MCP dari `.mcp.json`) atau `codex` (MCP dari `.codex/config.toml`) di folder ini. Untuk Codex, konfigurasi proyek hanya dimuat setelah proyek dipercaya. Mulai ulang sesi setelah konfigurasi berubah; cek `codex mcp list` dan `/mcp` di Codex untuk memastikan server tersedia.
5. Install dependency Playwright: `npm ci`, lalu `npx playwright install chromium`.
6. Install dependency script report: `pip install openpyxl` (biasanya sudah ada).

## Urutan Kerja Awal (project baru)

1. `/explore` — login, kalibrasi selector login (tulis ke `config/env.md`), petakan semua modul → `explore/module-map.md`.
2. Verifikasi checklist **"Hipotesis dari OMS"** di `CLAUDE.md` pada 1 halaman list + 1 halaman form, perbarui statusnya.
3. Setelah dokumen skenario modul tersedia di `scenario/<modul>/`: `/harvest-selectors <modul>` lalu `/test-module <modul>`.

## Cara Pakai Codex

Codex membaca `AGENTS.md`, lalu mengikuti panduan dan workflow bersama di `docs/`.
Gunakan instruksi biasa, misalnya:

```text
Jalankan workflow explore.
Jalankan workflow test-module untuk tms001 dengan filter smoke.
Jalankan workflow test-module untuk tms001 dengan filter category:negative max:20.
Jalankan workflow report all.
```

Untuk perintah yang eksplisit: `Baca docs/workflows/harvest-selectors.md dan jalankan
untuk modul tms001.` Slash command di tabel berikut khusus Claude Code.
`/task` belum tersedia pada kedua agent.

Konfigurasi Codex mengikuti [dokumentasi MCP resmi](https://learn.chatgpt.com/docs/extend/mcp?surface=cli)
dan [panduan AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md).
Server memakai paket yang sama dengan konfigurasi Claude; pengunduhan awal melalui
`npx` membutuhkan akses jaringan. Ketersediaan tool browser harus dicek dalam sesi.

## Cara Pakai Claude Code

| Perintah | Fungsi |
|---|---|
| `/explore` | Login (+ kalibrasi selector login) + petakan semua modul secara general → `explore/module-map.md` |
| `/smoke` | Cek cepat semua modul (halaman terbuka & render, read-only) |
| `/harvest-selectors <modul>` | Ekstrak selector asli aplikasi live → `shared/selector-map-<area>.md` |
| `/test-module <modul> [filter]` | Eksekusi skenario satu modul dari scenarios.json |
| `/report [modul\|all]` | Generate ulang Excel dari hasil run |
| `/task` | Perintah bebas (**belum tersedia**) |

Contoh:

```
/explore
/test-module tms001 smoke
/test-module dashboard-operasional priority:high
/test-module tms001 category:negative max:20
/report all
```

## Struktur

```
CLAUDE.md                  adapter instruksi Claude Code + checklist "Hipotesis dari OMS"
AGENTS.md                  adapter instruksi Codex
.codex/config.toml         konfigurasi Playwright MCP untuk Codex
docs/agent-guide.md        aturan bersama kedua agent
docs/workflows/            prosedur explore, smoke, harvest, test, report
docs/roles/                prosedur explorer, planner, executor, triager
.claude/commands/          slash command: explore, smoke, harvest-selectors, test-module, report
.claude/agents/            subagent: tms-explorer, test-planner, test-executor, bug-triager
.mcp.json                  browser agent (Playwright MCP)
config/env.md              link, konfigurasi login + akun (gitignore, jangan di-commit)
config/env.example.md      contoh format env.md
explore/                   output /explore (module-map.md) — kosong sampai /explore pertama
scenario/<modul>/          dokumen skenario per modul (skema: scenario/README.md)
task/                      fitur perintah bebas /task (belum diimplementasikan)
shared/                    lintas fitur: selector-map-<area>.md (hasil /harvest-selectors),
                           decisions.md (keputusan triage bertanggal; dibuat saat pertama dibutuhkan)
scripts/                   run-playwright.sh, playwright_to_results.py, merge_batches.py, generate_report.py
tests/                     spec Playwright + helpers (fixtures login, parser env)
results/                   hasil run (JSON) + execution plan — gitignore
reports/                   report Excel — gitignore
artifacts/screenshots/     bukti screenshot — gitignore
```

## Alur Kerja Agent

```
User ── /explore ──────────▶ tms-explorer ──▶ explore/module-map.md (+ kalibrasi login → config/env.md)
User ── /harvest-selectors ▶ (browser) ─────▶ shared/selector-map-<area>.md
User ── /test-module X ────▶ test-planner ──▶ execution plan (batch)
                             test-executor ─▶ results/X__runId.json + screenshot
                             bug-triager ───▶ klasifikasi failed (BUG / GAP / TEST ISSUE)
                             generate_report.py ─▶ reports/X__runId.xlsx
```

## Berpindah Agent dan Kerja Bersamaan

Untuk bergantian, selesaikan run aktif lalu beri agent berikutnya nama modul,
filter, lokasi plan/hasil, dan pekerjaan tersisa. Keduanya memakai skenario, selector,
runner, serta format hasil yang sama. Riwayat percakapan tidak otomatis dibagikan.

Untuk bekerja bersamaan gunakan Git worktree terpisah, siapkan dependency dan
`config/env.md` pada masing-masing worktree, serta pisahkan sesi browser dan data
uji. Runner menulis `results/_playwright/last-run.json`, sehingga dua run tidak boleh
berjalan bersamaan dalam working directory yang sama. Jika backend/akun uji belum
bisa diisolasi, jalankan testing bergantian. Detail: `docs/agent-guide.md`.
