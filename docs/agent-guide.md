# TMS Automation Testing Machine

Project ini adalah mesin automation testing untuk produk **TMS (Transport Management System)**,
dijalankan lewat Claude Code atau Codex, menggunakan script Playwright dan Playwright MCP.
Mesin ini diduplikasi dari project OMS pada 2026-09-08; pengetahuan aplikasi OMS tidak dibawa,
kecuali checklist "Hipotesis dari OMS" di `CLAUDE.md` yang WAJIB diverifikasi sebelum dipakai.

Semua path dalam panduan ini relatif terhadap root repository. Nama `/workflow`
merujuk prosedur di `docs/workflows/`; cara memanggilnya mengikuti adapter agent.

## Alur Kerja Utama

1. `/explore` — eksplorasi general aplikasi: login (sekaligus kalibrasi selector login → `config/env.md`), petakan SEMUA modul/menu, simpan hasil ke `explore/module-map.md`. Ini WAJIB dijalankan pertama kali (atau saat aplikasi berubah besar).
2. User memerintah modul mana yang mau dites: `/test-module <nama-modul>`.
3. `/task` — perintah bebas, berbasis folder `task/`. **Status: belum diimplementasikan.**

Hasil eksekusi disimpan sebagai JSON di `results/`, lalu `/report` mengubahnya menjadi file Excel di `reports/`.

Catatan: `/harvest-selectors <modul>` disarankan dijalankan sekali sebelum test modul pertama kali, dan diulang bila UI aplikasi berubah — hasilnya (`shared/selector-map-<area>.md`) menjadi sumber selector utama executor.

## Aturan Wajib

- **Jangan pernah menebak URL, selector login, atau kredensial.** Semua ada di `config/env.md`. Jika file itu belum diisi, berhenti dan minta user mengisinya (contoh format: `config/env.example.md`). Key `login*` yang masih `ISI_SETELAH_EXPLORE` diisi lewat kalibrasi login pada `/explore` — bukan ditebak.
- **Environment testing bisa berisi data nyata.** Dilarang keras: menghapus data yang tidak dibuat oleh test run ini, mengubah setting tenant, atau melakukan aksi destruktif (hapus/batalkan data milik orang lain) kecuali skenario secara eksplisit memerintahkannya pada data yang dibuat sendiri oleh run ini.
- **Data test diberi prefix** `AUTOTEST-<tanggal>-` pada field bebas teks (mis. nama/catatan) supaya mudah diidentifikasi dan dibersihkan.
- **Selector priority**: `getByRole(name)` → `getByLabel` → `getByText` → `getByTestId`. `data-testid` di dokumen skenario hanyalah usulan, belum tentu ada di implementasi.
- **Gotcha OMS bukan aturan TMS.** Workaround seperti `dispatchEvent('click')`, `.nth(1)` untuk datepicker, atau asumsi "tidak ada data-testid" hanya boleh dipakai setelah item terkait di checklist `CLAUDE.md` berstatus `TERVERIFIKASI SAMA` (lengkap dengan bukti). Selama masih `BELUM DICEK`, pakai perilaku Playwright standar; jika gagal, verifikasi dulu, lalu catat hasilnya di checklist dan `shared/decisions.md`.
- **Satu skenario = satu verdict**: `passed` / `failed` / `blocked` / `skipped`. Failed harus menyertakan pesan error + screenshot di `artifacts/screenshots/`.
- **Bedakan BUG vs GAP DESAIN.** Dokumen skenario menandai kandidat bug (FND-xx). Jika perilaku aplikasi cocok desain tapi bertentangan REQ, catat sebagai `bug-candidate`, jangan langsung failed tanpa keterangan.
- Bahasa laporan dan komunikasi: **Indonesia**.

## Struktur Project

- `explore/` — output `/explore` (`module-map.md`): peta seluruh modul/route + info login & environment + hasil cek hipotesis.
- `scenario/<modul>/` — dokumen skenario per modul: `*_analysis.md`, `*_ui-inventory.md`, `*.feature`, `*_scenarios.json` (**sumber utama eksekusi**), `*_coverage.md`. Skema wajib: lihat `scenario/README.md`.
- `task/` — fitur perintah bebas `/task` (defaults, intent schema). Belum diimplementasikan.
- `shared/` — hal lintas fitur: `selector-map-<area>.md` (hasil `/harvest-selectors`, **sumber selector utama executor** untuk area route tersebut), `decisions.md` (keputusan triage bertanggal; dibuat saat pertama dibutuhkan).
- `config/` — `env.md` (link, konfigurasi login, kredensial; gitignore) dan `env.example.md` (contoh format).
- `results/`, `reports/`, `artifacts/` — output run (JSON, Excel, screenshot); gitignore, tidak di-commit.

Saat mengeksekusi modul, SELALU baca `scenario/<modul>/*_scenarios.json` sebagai daftar skenario, dan `*_ui-inventory.md` sebagai peta selector. Bila selector-map di `shared/` tersedia, selector dari sana diprioritaskan di atas usulan ui-inventory.

## Skema Hasil Eksekusi (`results/`)

Satu run = satu file `results/<modul>__<YYYYMMDD-HHmmss>.json`:

```json
{
  "module": "tms001-dashboard-operasional",
  "runId": "20260908-140501",
  "startedAt": "...", "finishedAt": "...",
  "environment": {"baseUrl": "...", "user": "...", "role": "..."},
  "scenarios": [
    {
      "id": "SCN-0001",
      "title": "...",
      "category": "positive|negative|edge|stress",
      "priority": "high|medium|low",
      "screen": "...",
      "requirements": ["REQ-001"],
      "status": "passed|failed|blocked|skipped",
      "durationSec": 12.3,
      "error": null,
      "screenshot": null,
      "bugCandidate": null,
      "notes": ""
    }
  ]
}
```

Field `id`, `title`, `category`, `priority`, `requirements` HARUS disalin apa adanya dari `scenarios.json` agar traceability terjaga.

## Report Excel

`python scripts/generate_report.py results/<file>.json` → menghasilkan `reports/<modul>__<runId>.xlsx`
berisi sheet: **Summary**, **Detail**, **Failed & Bug Candidates**. Jangan menulis Excel manual — selalu lewat script ini.

## Mode Eksekusi (urutan prioritas)

1. **Playwright script** — bila `tests/<modul>.spec.js` ada, eksekusi modul WAJIB lewat
   `bash scripts/run-playwright.sh <modul>` (opsi filter: argumen playwright, mis. `--grep SCN-0004`).
   Script otomatis: jalankan test → konversi ke skema `results/` (`scripts/playwright_to_results.py`) → generate Excel.
   Judul test berformat `SCN-xxxx: <judul asli scenarios.json>` — jangan diubah, dipakai untuk traceability.
   Butuh Node ≥ 22, lihat `.nvmrc`; runner mengatur PATH sendiri (via nvm bila tersedia).
2. **Playwright MCP tanpa snapshot** — untuk modul tanpa spec / eksplorasi: gunakan tool eksekusi kode Playwright yang tersedia (lihat pemetaan tool di bawah)
   (satu call = seluruh langkah + assertion satu skenario, selector dari `shared/selector-map-*.md`).
   `browser_snapshot` HANYA untuk explore/harvest/diagnosis kegagalan — dilarang di jalur eksekusi normal (lambat & boros context).

Strategi sesi login ada di `tests/helpers/fixtures.js`: login sekali per worker pada context yang terus
hidup, dengan guard "login gagal 2x → berhenti". Pola ini diwarisi dari OMS (hipotesis H2 di `CLAUDE.md`,
belum diverifikasi di TMS) — bila `storageState` terbukti bekerja di TMS, fixture boleh disederhanakan.
Selector login & URL sukses dibaca dari `config/env.md` (key `login*`), bukan hardcode.

## Batasan Eksekusi Browser

- Selalu tunggu network idle / elemen terlihat sebelum assert; asumsikan drawer/modal render async sampai terbukti sebaliknya.
- Skenario `@stress` dan yang berpotensi membuat data masif hanya dijalankan jika user secara eksplisit memintanya.
- Jika login gagal 2x berturut-turut, BERHENTI (jangan sampai akun terkunci) dan lapor ke user.

## Integrasi Agent dan Browser

- Baca prosedur `docs/workflows/<nama>.md` sebelum menjalankan workflow, serta
  `docs/roles/<peran>.md` untuk setiap peran yang dipakai.
- Peran explorer, planner, executor, dan triager adalah tahapan kerja. Adapter
  boleh menjalankannya berurutan dalam satu agent; subagent tidak wajib.
- Periksa tool MCP yang benar-benar tersedia. Gunakan `browser_run_code` atau
  `browser_run_code_unsafe` jika tersedia dan sesuai izin sesi; jangan mengasumsikan
  nama tool tertentu tersedia atau menurunkan pengamanan agar bisa memakainya.
- Untuk diagnosis, gunakan `browser_find` bila tersedia; jika tidak, gunakan
  locator melalui tool run-code. Snapshot tetap terbatas untuk explore/harvest/diagnosis.
- Jika kemampuan browser yang diperlukan tidak tersedia, laporkan hambatan dan
  tandai skenario terdampak `blocked`; jangan mengarang hasil pengujian.
- Jangan menulis password, token, cookie, atau storage sesi ke dokumentasi/laporan.
  Kredensial yang belum terisi hanya menghalangi pekerjaan yang membutuhkan login.

## Penggunaan Bergantian atau Bersamaan

- Untuk penggunaan bergantian, baca perubahan Git, plan/hasil terakhir yang relevan,
  dan `shared/decisions.md` (bila sudah ada) sebelum melanjutkan. Konteks percakapan agent lain tidak
  otomatis ikut berpindah. Catat pekerjaan selesai dan pekerjaan tersisa saat handoff.
- Jangan menjalankan dua test run dalam working directory yang sama: runner memakai
  `results/_playwright/last-run.json` dan output lain yang dapat tertimpa.
- Untuk kerja simultan, gunakan worktree terpisah, dependency dan `config/env.md`
  masing-masing (file yang diabaikan Git tidak otomatis ikut), serta browser context
  terpisah. Jangan berbagi cookie/storageState.
- Worktree tidak memisahkan backend TMS. Gunakan akun/data uji terpisah yang sudah
  disediakan; tambahkan penanda agent/run setelah prefix `AUTOTEST-<tanggal>-` jika
  skenario mengizinkan. Bila isolasi data/sesi tidak tersedia, jalankan test bergantian.
- Jangan menimpa hasil run lama. Pertahankan format runId yang digunakan runner.
