# Selector Map — Area Order

Dibuat: 2026-09-08/09 (sesi eksplorasi read-only, akun tetap login sepanjang sesi).
Area/route yang dicakup: `/order`, `/order/buat` (termasuk varian `?shipmentId={uuid}` dari LKL056),
`/order/{id}` (Detail, dipakai ulang juga untuk order berstatus Dibatalkan lewat Riwayat Pembatalan),
`/order/{id}/edit`, `/order/{id}/riwayat`, `/order/riwayat-pembatalan`,
`/order/{id}/proses-surat-jalan`, `/order/{id}/proses-surat-jalan/buat`.

Login: sesi browser sudah dalam keadaan login (persisten dari eksplorasi sebelumnya) sebagai akun #1
(`finance.roro1@gmail.com`, role **Administrator**) — sesuai `config/env.md`. Tidak ada percobaan
login baru pada sesi ini (tidak relevan untuk dilaporkan, tidak ada password ditulis di sini).

Referensi silang: `explore/module-map.md` baris #7 dan #32, `explore/spec-crosscheck.md` (LKL025–028,
LKL041, LKL047, LKL051, LKL056), `docs/workflows/harvest-selectors.md`, `shared/selector-map-shipment.md`
(pola arsitektur sama, dipakai sebagai baseline perbandingan H1/H3/H4/H5/H6).

> Catatan umum sintaks tabel: TIDAK ADA `data-testid` di seluruh area ini (lihat H6). Kolom "Selector
> terbaik" banyak memakai `getByRole('button', { name: ... })` atau `getByPlaceholder(...)`. Untuk
> field yang teksnya duplikat di halaman yang sama (mis. dua tombol "Semua Kota"), locator WAJIB
> di-scope lewat `label` terdekat — pola sama seperti area shipment. Prioritas dipatuhi: data-testid →
> id stabil → role+name → label/placeholder → TIDAK STABIL.

## SCR-01 — Daftar Order (`/order`)

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-01 | Tombol "Buat Order" | `page.getByRole('button', { name: 'Buat Order' })` | role | Navigasi ke `/order/buat`. **Diverifikasi via klik asli (bukan navigasi URL langsung)**: `browser_network_requests` setelah klik hanya berisi GET (+ `cdn-cgi/rum` beacon & `auth/refresh` rutin) — aman |
| SCR-01 | Tombol "Riwayat Pembatalan" | `page.getByRole('button', { name: 'Riwayat Pembatalan' })` | role | Navigasi ke `/order/riwayat-pembatalan` (route penuh, bukan modal) |
| SCR-01 | Tombol "Filter" | `page.getByRole('button', { name: 'Filter' })` | role | Panel filter (SCR-02) sudah **terlihat inline** secara default; klik tombol ini tidak terbukti menyembunyikan panel dalam percobaan singkat (ambiguitas sama seperti shipment, tidak dikonfirmasi lebih lanjut) |
| SCR-01 | Input pencarian ID Order | `page.getByPlaceholder('Cari ID order...')` | placeholder | Bagian dari panel filter, lihat SCR-02 |
| SCR-01 | Page size ("Tampilkan N data") | `page.getByRole('combobox')` (scope ke area pagination) | role | `<select>` native asli (10/20/50/100) — sama pola dengan shipment |
| SCR-01 | Header kolom tabel | teks: "ID Order", "Rute", "Jenis Armada / Kontainer", "Permintaan Muat", "Status", (kolom aksi tanpa judul) | text | `<th>` biasa, kolom "ID Order" & lainnya punya `cursor-pointer` (kemungkinan sortable, tidak diuji lebih lanjut) |
| SCR-01 | Tombol ID Order per baris (mis. "FTL8849764283") | `page.getByRole('button', { name: 'FTL8849764283' })` | role | **Diverifikasi diklik**: TIDAK memicu navigasi maupun modal/dialog apa pun (`location.href` tidak berubah, `[role="dialog"]` = null) — beda dari dugaan shipment ("diduga membuka Detail"); di Order tombol ini tampaknya tidak beraksi apa-apa saat ini |
| SCR-01 | Tombol "Multipickup"/"Multidrop" pada kolom Rute (untuk order multi-titik) | `page.getByRole('button', { name: 'Multidrop' })` / `{ name: 'Multipickup' }` | role | **Diverifikasi**: membuka **modal overlay penuh** "DETAIL MULTIDROP"/"DETAIL MULTIPICKUP" (`div.fixed.inset-0...z-99999`) berisi daftar drop-off/pickup point; TANPA `role="dialog"` (H5 sama). Modal punya 1 tombol close (ikon, tanpa teks) |
| SCR-01 | Tombol kebab "Aksi" per baris | `row.locator('button[title="Aksi"]')` (mis. `page.locator('tr', { hasText: 'FTL8849764283' }).locator('button[title="Aksi"]')`) | TIDAK STABIL | Sama pola shipment: hanya `title="Aksi"`, tanpa ARIA. Terkadang butuh **2x klik** sebelum dropdown benar-benar muncul di DOM (timing React re-render, bukan bug — lihat "Catatan untuk executor") |
| SCR-01 | Badge status | text (warna badge berbeda per status) | text | **5 nilai status LENGKAP** (dikonfirmasi via opsi filter Status): Draf, Ditugaskan, Proses Pengiriman, Selesai, Dibatalkan. Tidak ada status lain (bukan "Dalam Perjalanan" seperti dugaan) |
| SCR-01 | Pagination (nomor halaman) | `page.getByRole('button', { name: '1' })` dst. | role | 34 halaman saat sesi ini (669 data / 20 per halaman — cocok dengan module-map) |

## SCR-02 — Panel Filter (`/order`, inline — bukan modal)

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-02 | Label "ID Order" + input | `page.getByPlaceholder('Cari ID order...')` | placeholder | Text input biasa |
| SCR-02 | Label "Tanggal Permintaan Muat" + tombol "Pilih Tanggal" | `page.getByRole('button', { name: 'Pilih Tanggal' })` | role | **Hanya 1 instance** di filter Order (beda dari shipment yang punya 2 field tanggal duplikat) — tidak perlu scoping tambahan. Struktur flatpickr sama seperti shipment, lihat "Pola komponen" |
| SCR-02 | Label "Kota Asal" + combobox | scope ke label "Kota Asal", tombol teks "Semua Kota" | TIDAK STABIL (2 instance teks sama dengan Kota Tujuan) | `button[aria-haspopup="listbox"][aria-expanded]` |
| SCR-02 | Label "Kota Tujuan" + combobox | scope ke label "Kota Tujuan", tombol teks "Semua Kota" | TIDAK STABIL (2 instance teks sama) | idem |
| SCR-02 | Label "Jenis Shipment" + combobox | `page.getByRole('button', { name: 'Semua Jenis' })` | role | Opsi (`[role="option"]`): FTL - Full Truck Load, FCL - Full Container Load, LTL - Less Than Truckload, LCL - Less Than Container Load, Air Freight - Pengiriman Udara — identik dengan filter Jenis Layanan shipment |
| SCR-02 | Label "Jenis Armada" + input | `page.getByPlaceholder('Cari jenis armada...')` | placeholder | **Text input biasa, BUKAN dropdown** (beda dari dugaan awal) |
| SCR-02 | Label "Jenis Kontainer" + combobox | `page.getByRole('button', { name: 'Semua Kontainer' })` | role | Opsi observasi: "asda" (data test tidak wajar di master), "20 Feet", "45 Feet HC", "40 Feet HC", "40 Feet" |
| SCR-02 | Label "Status" + combobox | `page.getByRole('button', { name: 'Semua Status' })` | role | Combobox ini render sebagai search-combo saat terbuka: berisi `textbox` "Cari..." + `listbox` beranak `option` — opsi LENGKAP: Draf, Ditugaskan, Proses Pengiriman, Selesai, Dibatalkan |
| SCR-02 | Tombol "Reset" | `page.getByRole('button', { name: 'Reset' })` | role | — |
| SCR-02 | Tombol "Terapkan" | `page.getByRole('button', { name: 'Terapkan' })` | role | Setelah diterapkan, tombol header "Filter" berubah label jadi "Filter (1)" (badge jumlah filter aktif) |

## SCR-03 — Dropdown Aksi per baris (kebab, `div.fixed.z-9999`, tanpa ARIA)

Container dropdown sama persis pola shipment: `div.fixed.z-9999.min-w-[180px].rounded-lg.border...`.
Selector item: `page.locator('div.fixed.z-9999').getByText('Detail', { exact: true })` dsb.
**Temuan penting: berbeda dari shipment, TIDAK ADA item yang disabled pada seluruh kombinasi status
yang diuji** — semua item selalu enabled tanpa `title` alasan bisnis.

| SCR | Varian (status) | Item ditemukan (urutan tampil) | Sumber | Catatan |
|---|---|---|---|---|
| SCR-03a | **Draf** (diverifikasi 2 jenis: FTL FTL8744145034, LCL LCL5293458690) | Detail, Edit, Batalkan Order, Riwayat Perubahan | text | Semua enabled. Item identik di kedua jenis — **jenis TIDAK mempengaruhi isi kebab Order** (beda dari shipment yang bervariasi per jenis) |
| SCR-03b | **Ditugaskan** (diverifikasi Air Freight AFR8232491231) | Detail, Batalkan Order, **Proses Surat Jalan**, Riwayat Perubahan | text | Semua enabled. **Temuan penting**: "Proses Surat Jalan" SUDAH muncul di status Ditugaskan, bukan hanya Selesai seperti asumsi spec-crosscheck LKL047 |
| SCR-03c | **Proses Pengiriman** (diverifikasi FCL FCL8232403083) | Detail, Proses Surat Jalan, Riwayat Perubahan | text | Semua enabled. **Tidak ada** "Batalkan Order" lagi di status ini (order sudah berjalan) |
| SCR-03d | **Selesai** (diverifikasi FTL FTL8849764283) | Detail, Proses Surat Jalan, Riwayat Perubahan | text | Semua enabled. Sama persis dengan Proses Pengiriman |
| SCR-03e | **Dibatalkan** (diverifikasi FTL FTL4624030408, difilter via Status) | Detail, Riwayat Perubahan | text | Semua enabled. Hanya 2 item (paling sedikit) |

## SCR-04 — Buat Order (`/order/buat`) — single page, BUKAN wizard

Tidak ada header step 1-2-3-4 sama sekali (beda dari Buat Shipment). Tombol akhir langsung
**Batal / Simpan** (bukan "Selanjutnya"). Kartu pilihan Jenis Shipment memakai `aria-pressed`
(state terpilih) — **beda dari kartu Buat Shipment yang sama sekali tanpa ARIA** (lihat "Pola komponen").

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-04 | Kartu pilihan jenis shipment (FTL/FCL/LTL/LCL/Air Freight) | `page.getByRole('button', { name: /^FTL/ })` dst. | role | `<button aria-pressed="true/false">` — accessible name gabungan judul+subjudul (mis. "FTL Full Truck Load") |
| SCR-04 | Tombol "Reset" (di baris Jenis Shipment) | `page.getByRole('button', { name: 'Reset' })` | role | Reset seluruh form ke kondisi awal |
| SCR-04 | **[FTL]** Tanggal Permintaan Muat* | trigger `div[role="button"]` berisi teks "DD/MM/YYYY HH:mm" | TIDAK STABIL (tanpa aria-label unik) — scope via `label` "Tanggal Permintaan Muat" | Datetime custom picker (BUKAN flatpickr) — lihat "Pola komponen" untuk detail |
| SCR-04 | **[FTL]** Section "Shipment Muatan *" | heading text + `page.getByPlaceholder('Cari shipment...')` + 2 combobox filter "Semua Kota Asal"/"Semua Kota Tujuan" + list `input[type=radio][name="shipment-picker"]` | placeholder/role/name | **RADIO, bukan checkbox** (koreksi dugaan module-map) — hanya 1 shipment draft FTL bisa dipilih per order. Menampilkan SEMUA draft FTL tanpa perlu filter kota dulu (beda dari LTL/LCL/AF) |
| SCR-04 | **[FTL]** Tidak ada field "Jenis Armada"/"Jumlah Armada" terpisah | — | — | Info armada hanya tampil sebagai teks di label radio shipment (mis. "Fuso × 1"), TIDAK ada field editable terpisah di form kosong ini (beda dari dugaan) |
| SCR-04 | **[FCL]** Section berganti judul jadi "Detail Muatan" | heading text | text | Radio list shipment FCL: `input[type=radio][name="shipment-picker"]`, filter combobox "Semua Pelabuhan Asal"/"Semua Pelabuhan Tujuan" |
| SCR-04 | **[FCL]** Jenis Kontainer / Jumlah Kontainer (muncul setelah pilih 1 shipment) | `page.getByPlaceholder('Auto-fill dari shipment')` (2 instance, disabled) | TIDAK STABIL (placeholder sama 2x) | **Read-only**, terisi otomatis dari shipment terpilih (mis. "20 Feet" / "1") |
| SCR-04 | **[FCL]** Jenis Jadwal Kapal* (Direct/Connecting) | `page.locator('#fcl-jadwal-direct')` / `page.locator('#fcl-jadwal-connecting')` | **id stabil** | `input[type=radio][name="fclJenisJadwal"]`, visually hidden (`class="sr-only"`) tapi id/name TIDAK acak — selector paling stabil di seluruh SCR-04 |
| SCR-04 | **[FCL]** Detail Kapal Utama (muncul setelah pilih Direct/Connecting): Pelayaran*, Nama Kapal*, Voyage*, Closing Time*, ETD*, ETA* | Pelayaran: `page.getByRole('button', { name: 'Pilih pelayaran' })`; Nama Kapal: `page.getByPlaceholder('Contoh: KM Meratus 1')`; Voyage: `page.getByPlaceholder('Contoh: V-2026-06-001')`; Closing Time/ETD/ETA: trigger `div[role="button"]` per label | role/placeholder/TIDAK STABIL | **Closing Time = datetime** (HH:mm ada); **ETD & ETA = tanggal SAJA** (tanpa jam) untuk FCL/LCL — beda dengan Air Freight (lihat di bawah) |
| SCR-04 | **[FCL, Connecting]** Data Kapal Connecting*: Pelabuhan Connecting*, Kapal Connecting*, Voyage*, ETD Connecting* | Kapal Connecting: `page.getByPlaceholder('Masukkan Nama Kapal')`; Voyage: `page.getByPlaceholder('Masukkan Voyage')` | placeholder | Tombol "Tambah Kapal Connecting" untuk menambah leg tambahan (`page.getByRole('button', { name: 'Tambah Kapal Connecting' })`) |
| SCR-04 | **[LTL]** Section "Detail Rute": Kota Asal (Origin)*, Kota Tujuan (Destination)*, "Tambah Kota Transit" | `page.getByRole('button', { name: 'Pilih kota asal' })` / `{ name: 'Pilih kota tujuan' }` / `page.getByRole('button', { name: 'Tambah Kota Transit' })` | role | **WAJIB diisi dulu** sebelum "Shipment Muatan" menampilkan opsi apa pun (placeholder: "Pilih kota asal & kota tujuan terlebih dahulu.") — beda dari FTL yang langsung menampilkan semua draft. "Tambah Kota Transit" menambah field "Transit 1" dengan combobox "Pilih Kota/Kab." — **mengonfirmasi hipotesis LKL025 "kota transit"** |
| SCR-04 | **[LTL]** Jenis Armada*, Berat Maksimal, Volume Maksimal | `page.getByRole('button', { name: 'Pilih jenis armada' })`; `page.getByPlaceholder('kg')`; ada label "Volume Maksimal" dengan unit m³ (placeholder generik) | role/TIDAK STABIL | Field filter tambahan untuk shipment draft yang muncul |
| SCR-04 | **[LCL]** Section "Detail Order LCL": Pelabuhan Asal*, Pelabuhan Tujuan*, Jenis Kontainer*, Jenis Jadwal Kapal* | `page.getByRole('button', { name: 'Pilih pelabuhan asal' })` dst.; radio `#jadwal-direct` / `#jadwal-connecting` (name="jenisJadwal") | role/id stabil | **id BEDA dengan FCL** (`jadwal-direct` vs `fcl-jadwal-direct`) meski pola sama persis (Direct/Connecting + Detail Kapal Utama). Shipment Muatan HANYA muncul setelah Pelabuhan Asal+Tujuan+Jenis Kontainer+Jenis Jadwal Kapal semua terisi; bisa kosong dengan pesan "Tidak ada shipment LCL tersedia untuk pelabuhan ini." |
| SCR-04 | **[Air Freight]** Detail Rute: Kota Asal/Tujuan + Tambah Kota Transit (sama seperti LTL) | sama pola LTL | role | Setelah kota dipilih, muncul banner **"SEGMEN PERJALANAN: KOTA X → KOTA Y"** menampilkan `Bandara Asal (KODE) → Bandara Tujuan (KODE)` + estimasi jam tempuh otomatis |
| SCR-04 | **[Air Freight]** Bandara Asal*/Bandara Tujuan* | `button[disabled][aria-haspopup="listbox"]` berlabel "Bandara Asal"/"Bandara Tujuan" | TIDAK STABIL (disabled combobox, auto-fill) | **Read-only, auto-fill dari segmen rute** (bukan dipilih manual) — sesuai hipotesis |
| SCR-04 | **[Air Freight]** Drop Point Bandara Asal*/Tujuan*, Maskapai*, Nomor Penerbangan* | `page.getByRole('button', { name: 'Pilih Drop Point Bandara Asal' })` dst.; Maskapai: `page.getByRole('button', { name: 'Pilih Maskapai' })`; Nomor Penerbangan: input text tanpa placeholder unik | role/TIDAK STABIL | — |
| SCR-04 | **[Air Freight]** Berangkat (ETD)*, Tiba (ETA)* | trigger `div[role="button"]` per label, format "DD/MM/YYYY HH:mm" | TIDAK STABIL | **BEDA dari FCL/LCL**: ETD & ETA Air Freight PAKAI jam (datetime penuh), bukan tanggal saja — inkonsistensi lintas jenis yang perlu dicatat |
| SCR-04 | **[Air Freight]** Tanggal Permintaan Muat*, Jenis Armada*, Berat Maksimal, Volume Maksimal | sama pola field lain | role/placeholder | Field tambahan di luar jadwal penerbangan |
| SCR-04 | Datetime picker custom (Tanggal Permintaan Muat/Closing Time/ETD/ETA dengan jam) | popup `div.absolute.z-[60]` berisi grid `button.h-9.w-9` (tanggal) + 2 kolom scroll "JAM"(00-23)/"MENIT"(00-59) | TIDAK STABIL (class Tailwind arbitrary `z-[60]`) | **BUKAN flatpickr** — komponen custom terpisah dari datepicker filter. Lihat "Pola komponen" untuk detail perilaku close |
| SCR-04 | Tombol "Batal" | `page.getByRole('button', { name: 'Batal' })` | role | — |
| SCR-04 | Tombol "Simpan" | `page.getByRole('button', { name: 'Simpan' })` | role | **TIDAK DIKLIK** (aturan keras) |

## SCR-05 — Buat Order dari shipment FTL Draf (LKL056, `/order/buat?shipmentId={uuid}`)

Dipicu dari `/shipment` → kebab Aksi baris FTL Draf → "Buat Order". **Diverifikasi network**: hanya
GET yang terpicu (termasuk `GET /api/orders/shipment-prefill/{shipmentId}`), tidak ada POST/PUT/PATCH/DELETE.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-05 | Kartu ringkasan shipment terpilih (ID, customer, rute, total berat/volume) | text | text | Read-only, mis. "SHP26090017 • PT Astra Honda Motor", "Kota Surabaya → Kota Batu", "Total Berat: 1.713,22 kg • Total Volume: 54,00 m³" |
| SCR-05 | Tanggal Permintaan Muat* | trigger `div[role="button"]` | TIDAK STABIL | Datetime custom picker sama seperti SCR-04, **kosong (belum terisi)** — satu-satunya field yang WAJIB diisi manual |
| SCR-05 | Jenis Armada (read-only) | `input[disabled]` dengan value terisi (mis. "Fuso") | TIDAK STABIL (2 instance disabled berurutan) | **Terkonfirmasi read-only/prefilled dari shipment** — sesuai hipotesis SCR-05 di brief |
| SCR-05 | Jumlah Armada (read-only) | `input[disabled]` value "1" | TIDAK STABIL | idem |
| SCR-05 | Tombol "Batal" / "Simpan" | `page.getByRole('button', { name: 'Batal' })` / `{ name: 'Simpan' }` | role | **Simpan tidak diklik**. Form JAUH lebih ringkas dari SCR-04 kosong: TIDAK ada kartu pilihan jenis shipment, TIDAK ada filter kota, TIDAK ada daftar radio shipment lain (shipment sudah given/fixed) |

## SCR-06 — Detail Order (Aksi → Detail, `/order/{id}`)

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-06 | Tombol "← Kembali" | `page.getByRole('button', { name: '← Kembali' })` | role | — |
| SCR-06 | Banner "Order Dibatalkan" (kondisional, hanya order berstatus Dibatalkan) | container `div.rounded-xl.border-error-200...` | TIDAK STABIL (tanpa role=alert) | Menampilkan judul "Order Dibatalkan" + teks alasan pembatalan asli yang diinput user (mis. "...nambah armada") — **temuan baru**, berguna untuk assertion skenario pembatalan |
| SCR-06 | Header info: ID Order, Jenis Shipment, Kota Asal, Kota Tujuan, Tanggal Permintaan Muat | text (label:value) | text | Read-only |
| SCR-06 | Tabel "Shipment Muatan" (No/ID Shipment/Pengirim/Rute/Berat/Volume) | text (header) | text | `<table>` asli, 1 baris = 1 shipment sumber order ini |
| SCR-06 | Tabel "Data Armada" (No/Jenis Armada/Nopol/Nama Sopir/No. Perjalanan) | text (header) | text | — |
| SCR-06 | Section accordion "Riwayat Tracking" | `page.getByRole('button', { name: 'Riwayat Tracking' })` | role | Toggle expand/collapse (chevron icon), berisi sub-accordion PER ARMADA (`button[aria-expanded]` dengan ikon truk + label armada, mis. "Tronton Wing Box") |
| SCR-06 | Sub-accordion per armada dalam Riwayat Tracking | `button[aria-expanded="false"]` berisi teks nama armada | TIDAK STABIL | Expand menampilkan toggle "Per Lokasi"/"Timeline" (plain `<button>`, TANPA `role="tab"`) + detail tahapan per lokasi (Berangkat Muat/Selesai Muat/Berangkat Bongkar/Selesai Bongkar) dengan timestamp, channel ("Web"), PIC, dan tombol "Detail"/"Edit" per tahapan (Edit di sini untuk data tracking, BUKAN edit order) |
| SCR-06 | Tombol toggle "Per Lokasi" / "Timeline" | `page.getByRole('button', { name: 'Per Lokasi' })` / `{ name: 'Timeline' }` | role | Plain button tanpa ARIA tab |
| SCR-06 | Tidak ada tombol Edit order di halaman ini | — | — | Edit hanya dari kebab Aksi di list, sama seperti Detail Shipment |

## SCR-07 — Edit Order (Aksi → Edit, pada order Draf, `/order/{id}/edit`)

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-07 | Header info: ID Order, Jenis Shipment, Status (read-only) | text | text | — |
| SCR-07 | Kota Asal / Kota Tujuan (read-only) | text | text | **Tidak bisa diubah** (terkunci setelah order dibuat) |
| SCR-07 | Tanggal Permintaan Muat* (editable) | trigger `div[role="button"]` menampilkan nilai existing (mis. "08/09/2026 08:00") | TIDAK STABIL | Datetime custom picker sama seperti SCR-04/05, BISA diubah |
| SCR-07 | Shipment Muatan* (editable) | `input[type=radio][name="shipment-picker"]` | **name stabil** | **BISA mengganti shipment sumber** — daftar radio berisi draft shipment lain dengan rute sama (di sampel ini: 3 opsi) |
| SCR-07 | Jenis Armada / Jumlah Armada (read-only) | `input[disabled]` | TIDAK STABIL | Auto-update mengikuti shipment radio yang dipilih (turunan, bukan input manual) |
| SCR-07 | Tombol "Batal" | `page.getByRole('button', { name: 'Batal' })` | role | — |
| SCR-07 | Tombol "Simpan Perubahan" | `page.getByRole('button', { name: 'Simpan Perubahan' })` | role | **Label BEDA dari Buat Order** ("Simpan Perubahan" vs "Simpan") — **TIDAK DIKLIK** (aturan keras) |

## SCR-08 — Riwayat Perubahan per order (Aksi → Riwayat Perubahan, `/order/{id}/riwayat`)

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-08 | Page size ("Tampilkan N data") | `page.getByRole('combobox')` | role | — |
| SCR-08 | Filter: "Tanggal Perubahan", "Diubah Oleh" + Reset/Terapkan | label + date/combobox pola sama SCR-02 | role/TIDAK STABIL | — |
| SCR-08 | Tabel/daftar riwayat (No/Tanggal Perubahan/Diubah Oleh/Total Perubahan) | text (header) | text | **Struktur DIV-based** (bukan `<table>`), konsisten dengan pola accordion Riwayat Perubahan Shipment, tapi TIDAK BISA dipastikan apakah baris expand ke diff karena **seluruh 2 sampel order yang dicek (1 Draf, 1 Proses Pengiriman) kosong**: "Belum ada riwayat perubahan untuk order ini." |

## SCR-09 — Riwayat Pembatalan (`/order/riwayat-pembatalan`)

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-09 | Page size | `page.getByRole('combobox')` | role | — |
| SCR-09 | Filter: ID Order, Tanggal Dibatalkan, Diubah Oleh + Reset/Terapkan | placeholder/pola sama SCR-02 | placeholder/TIDAK STABIL | — |
| SCR-09 | Tabel (No/ID Order/Jenis Layanan/Tanggal Dibatalkan/Dibatalkan Oleh/Aksi) | text (header) | text | `<table>` asli. 17 data saat sesi ini |
| SCR-09 | Tombol "Detail" per baris | `row.getByRole('button', { name: 'Detail' })` | role | Dibuka (sesuai izin) → navigasi ke `/order/{id}` (**reuse komponen Detail Order SCR-06**, menampilkan banner "Order Dibatalkan" + alasan) |

## SCR-10 — Proses Surat Jalan (Aksi pada baris Ditugaskan/Proses Pengiriman/Selesai, `/order/{id}/proses-surat-jalan`)

**Koreksi penting terhadap spec-crosscheck LKL047**: aksi ini TIDAK hanya muncul di status Selesai,
tapi juga di Ditugaskan dan Proses Pengiriman (lihat SCR-03).

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-10 | Header info: ID Order, Jenis Shipment, Kota Asal/Tujuan, Tanggal Permintaan Muat, Jenis Armada | text | text | Read-only |
| SCR-10 | Tombol "Buat Surat Jalan" | `page.getByRole('button', { name: 'Buat Surat Jalan' })` | role | Navigasi ke route baru `/order/{id}/proses-surat-jalan/buat` (bukan modal). **Diverifikasi network hanya GET** setelah klik |
| SCR-10 | Tombol "Upload SJ Kembali" | `page.getByRole('button', { name: 'Upload SJ Kembali' })` | role | **TIDAK DIBUKA** (berisiko memicu alur upload sesuai aturan keras) |
| SCR-10 | Tombol "Cetak Dokumen Dibuat Sistem" | `page.getByRole('button', { name: 'Cetak Dokumen Dibuat Sistem' })` | role | **Disabled** pada sampel ini (belum ada dokumen surat jalan dibuat — tabel kosong "Tidak ada data.") |
| SCR-10 | Catatan "Upload data hanya dapat dilakukan sekali" | text | text | Business rule, berguna untuk assertion negatif |
| SCR-10 | Tabel dokumen surat jalan (No/Sumber Dokumen/No. Surat Jalan/No. Polisi/Tanggal Update) | text (header) | text | Kosong: "Tidak ada data." pada sampel ini |
| SCR-10 | **Halaman "Buat Surat Jalan"** (`/order/{id}/proses-surat-jalan/buat`) — step "Konfirmasi Profil" | judul teks "Konfirmasi Profil"; field: Nama Perusahaan* `input[placeholder="Nama perusahaan"]`, Nomor Telepon* `input[placeholder="08xxxxxxxxxx"]`, Email* `input[placeholder="email@perusahaan.com"]`, Logo Perusahaan* (file upload + tombol "Pilih File") | placeholder | **Bukan form surat jalan itu sendiri** — ini konfirmasi profil perusahaan (data company-wide, TERNYATA SUDAH TERISI dari setup sebelumnya: "PT. Wahana Logistik", dst — bukan data kosong per-order). Field surat jalan sesungguhnya (nomor SJ, armada, dsb.) belum terlihat karena ada di step setelah profil dikonfirmasi |
| SCR-10 | Tombol "Batal" / "Preview" / "Simpan" (di halaman Konfirmasi Profil) | `page.getByRole('button', { name: 'Batal' })` / `{ name: 'Preview' }` / `{ name: 'Simpan' }` | role | **Preview dan Simpan TIDAK DIKLIK** — berpotensi memicu proses pembuatan dokumen (ambigu terhadap larangan "Cetak-yang-memproses"), keluar via "Batal" |

## SCR-11 — Modal Batalkan Order

**SKIPPED** sesuai kebijakan keras — tidak dibuka sama sekali (risiko salah klik pada data nyata,
sama seperti SCR-16 di `selector-map-shipment.md`). Tidak ada eksplorasi DOM/selector untuk modal ini.
Tombol trigger diketahui dari SCR-03 (`page.getByRole/text('Batalkan Order')` di dalam dropdown kebab
untuk status Draf/Ditugaskan), tapi item tersebut TIDAK diklik.

---

## Pola komponen

- **Dropdown/combobox filter & form (H3a):** SAMA dengan shipment — `<button aria-haspopup="listbox"
  aria-expanded="...">` + opsi `[role="option"]`. Ditemukan di seluruh filter list Order (Kota, Jenis
  Shipment, Jenis Kontainer, Status) maupun combobox dalam form Buat/Edit Order (Pelayaran, Pelabuhan,
  Maskapai, Drop Point, dll). Combobox Status di Order tampil sebagai **search-combo** (ada `textbox`
  "Cari..." tersemat di dalam listbox saat terbuka) — variasi baru dibanding shipment yang tidak
  menunjukkan search box di dalam listbox-nya.
- **Radio native untuk pilihan biner Direct/Connecting (H3, pola BARU):** `input[type=radio]`
  visually-hidden (`class="sr-only"`) tapi punya **id dan name STABIL** (`#fcl-jadwal-direct`/
  `#fcl-jadwal-connecting` untuk FCL, `#jadwal-direct`/`#jadwal-connecting` untuk LCL) — selector
  paling andal yang ditemukan di seluruh SCR-04. Playwright `locator.click()` pada elemen `sr-only`
  ini TIMEOUT lewat `getByRole('radio').click()` biasa (dianggap "outside viewport" oleh actionability
  check Playwright meski elemen ada di DOM) — WAJIB pakai `el.click()` via `evaluate` atau
  `locator.check({force: true})`.
- **Kartu pilihan jenis shipment (H3, BEDA dari Buat Shipment):** Buat Order MEMAKAI `aria-pressed`
  pada `<button>` kartu jenis shipment (state terpilih accessible), **berbeda dari Buat Shipment**
  yang kartunya sama sekali tanpa ARIA. Menunjukkan implementasi frontend antara fitur Shipment dan
  Order tidak seragam — jangan asumsikan satu pola berlaku ke semua area, verifikasi per komponen.
- **Kebab "Aksi" per baris (H3c):** Identik pola shipment — `div.fixed.z-9999`, trigger hanya
  `title="Aksi"` tanpa ARIA. **Beda penting**: pada Order, **tidak ditemukan satupun item disabled**
  di 5 kombinasi status yang diuji (Draf, Ditugaskan, Proses Pengiriman, Selesai, Dibatalkan) — semua
  item selalu aktif sesuai daftar per status. Ini kontras dengan shipment yang punya banyak item
  disabled dengan `title` alasan bisnis.
- **Datepicker filter panel (H4a — flatpickr):** SAMA dengan shipment/dashboard — class
  `flatpickr-calendar rangeMode animate multiMonth inline`, `prevMonthDay hidden` di baris pertama
  (benar-benar disembunyikan via CSS), default bulan berjalan, tidak ada `role="dialog"`. Dipakai di
  field "Pilih Tanggal" pada SCR-02.
- **Datepicker form Buat/Edit Order (H4b — komponen CUSTOM, BUKAN flatpickr, TEMUAN BARU):** Field
  bertipe datetime (Tanggal Permintaan Muat, Closing Time, Berangkat/Tiba Air Freight) maupun tanggal
  saja (ETD/ETA FCL/LCL) memakai popup custom `div.absolute.z-[60]` — trigger-nya `div[role="button"]
  tabindex="0"` (justru **MIRIP hipotesis asli OMS H4** `div[role="button"]`!). Grid tanggal memakai
  `button.h-9.w-9` (**JUGA mirip pola OMS H4** `button.h-9.w-9`), tapi sel bulan sebelumnya/berikutnya
  TETAP TERLIHAT dengan class `text-gray-300` (dimuted, bukan disembunyikan/disabled) — beda dari
  ambiguitas OMS yang butuh `.nth(1)`, di sini sel bisa dibedakan lewat class. Varian datetime punya
  2 kolom scroll tambahan "JAM" (00–23) dan "MENIT" (00–59) di sisi kanan kalender. **Perilaku close:
  memilih tanggal TIDAK menutup popup; klik di luar (`document.body.click()`) TIDAK menutup; tombol
  `Escape` JUGA TIDAK menutup** — popup hanya tertutup dengan klik ulang trigger. **Kesimpulan H4:
  BERVARIASI per komponen dalam TMS sendiri** — filter pakai flatpickr (mirip temuan shipment,
  "BERBEDA" dari OMS), form Buat/Edit Order pakai komponen custom yang justru **lebih dekat ke
  hipotesis asli OMS** (div[role=button] + grid button.h-9.w-9) walau tanpa ambiguitas `.nth(1)`.
  Executor WAJIB mengecek komponen spesifik per field, jangan generalisasi satu pola datepicker untuk
  seluruh aplikasi.
- **Modal/overlay (H5):** TERVERIFIKASI SAMA — tidak ada satupun `role="dialog"` ditemukan di seluruh
  ~15 state yang diperiksa (list, filter combobox terbuka, 5 varian kebab, modal "DETAIL MULTIDROP",
  Buat Order 5 jenis + popup datetime + popup jadwal kapal, Buat Order dari shipment (SCR-05), Detail,
  Edit, Riwayat Perubahan, Riwayat Pembatalan, Proses Surat Jalan + form Konfirmasi Profil). Modal
  "DETAIL MULTIDROP" memakai pola sama dengan overlay blocking shipment: `div.fixed.inset-0...z-99999`.
- **`data-testid` (H6):** TERVERIFIKASI SAMA — `document.querySelectorAll('[data-testid]').length` = 0
  di SEMUA layar/state yang diperiksa (list, filter, 5 varian kebab, Buat Order 5 jenis, Buat Order
  dari shipment, Detail, Edit, Riwayat Perubahan, Riwayat Pembatalan, Proses Surat Jalan, Buat Surat
  Jalan/Konfirmasi Profil).
- **Reaksi `click()` (H1):** TERVERIFIKASI SAMA (konsisten dengan shipment) — `locator.click()`/
  `el.click()` standar BEKERJA NORMAL di semua kasus yang diuji (kartu jenis shipment, radio jadwal
  kapal & shipment-picker, combobox, opsi listbox, kebab, tombol navigasi). **TIDAK PERNAH dibutuhkan
  `dispatchEvent`.** Gotcha header sticky (`z-99999`) mengintersep klik **TERKONFIRMASI ULANG** persis
  sama seperti shipment — `page.getByRole('button', {name:'Semua Status'}).click()` biasa TIMEOUT 5
  detik dengan pesan header intercepts pointer events; solusi sama: `el.scrollIntoView({block:'center'})`
  via `evaluate` lalu `el.click()` DOM asli dalam evaluate yang sama. **Temuan baru terkait timing**:
  klik kebab "Aksi" kadang perlu **2x klik terpisah** (dalam 2 `browser_evaluate` call berbeda) sebelum
  dropdown benar-benar muncul di query DOM berikutnya — kemungkinan klik pertama ter-trigger bersamaan
  dengan efek `scrollIntoView` yang memicu handler "close on scroll" pada dropdown yang baru saja
  terbuka. Ini BUKAN bukti H1 gagal (klik tetap "bekerja", hanya butuh 1 klik ekstra karena race
  condition timing), dan tidak selalu terjadi (kadang cukup 1 klik).

## Rekomendasi data-testid untuk developer

| Elemen | Usulan data-testid |
|---|---|
| Tombol kebab "Aksi" per baris order | `order-row-action-{id}` |
| Item dropdown Aksi (Detail/Edit/Batalkan Order/Proses Surat Jalan/Riwayat Perubahan) | `order-action-detail`, `order-action-edit`, `order-action-batalkan`, `order-action-proses-surat-jalan`, `order-action-riwayat` |
| Kartu jenis shipment (Buat Order) | `jenis-shipment-ftl`, `jenis-shipment-fcl`, `jenis-shipment-ltl`, `jenis-shipment-lcl`, `jenis-shipment-air-freight` |
| Filter combobox yang teksnya bisa duplikat (Kota Asal/Tujuan) | `filter-order-kota-asal`, `filter-order-kota-tujuan` |
| Radio shipment-picker per baris (Buat/Edit Order) | `shipment-picker-{shipmentId}` |
| Popup datetime custom (Tanggal Permintaan Muat/Closing Time/ETD/ETA/Berangkat/Tiba) | `datetime-picker-popup`, tiap trigger: `field-tanggal-permintaan-muat`, `field-closing-time`, `field-etd`, `field-eta` |
| Radio Jenis Jadwal Kapal (sudah punya id stabil, tapi tetap disarankan testid untuk konsistensi) | `jadwal-kapal-direct`, `jadwal-kapal-connecting` |
| Banner "Order Dibatalkan" di Detail Order | `order-cancelled-banner` |
| Modal "DETAIL MULTIDROP"/"DETAIL MULTIPICKUP" | `multidrop-detail-modal` |
| Form Konfirmasi Profil (Proses Surat Jalan) | `sj-profil-nama-perusahaan`, `sj-profil-telepon`, `sj-profil-email`, `sj-profil-logo` |

## Catatan untuk executor

1. **Sticky header (`z-99999`) mengintersep klik** di seluruh halaman turunan `/order`, sama seperti
   `/shipment`. Pola aman: `el.scrollIntoView({block:'center'})` lalu `el.click()` dalam SATU
   `browser_evaluate`.
2. **Klik kebab "Aksi" kadang butuh 2x klik terpisah** (lihat catatan H1 di atas) — verifikasi
   `document.querySelector('div.fixed.z-9999')` ada sebelum mengklik item di dalamnya; jika `null`,
   ulangi klik trigger sekali lagi di panggilan terpisah (bukan dalam satu evaluate yang sama).
3. **Kebab Order TIDAK punya item disabled** — berbeda dari shipment. Jika skenario negatif
   membutuhkan item disabled dengan alasan bisnis, itu TIDAK berlaku untuk area Order berdasarkan
   sampel yang diuji (5 status × ≥1 jenis).
4. **"Proses Surat Jalan" muncul di 3 status**: Ditugaskan, Proses Pengiriman, Selesai — BUKAN hanya
   Selesai seperti disebut spec-crosscheck LKL047. Perbarui pemahaman spec saat menulis skenario.
5. **"Batalkan Order" hanya muncul di status Draf dan Ditugaskan** — tidak ada lagi di Proses
   Pengiriman/Selesai/Dibatalkan (order yang sudah berjalan tidak bisa dibatalkan dari kebab).
6. **Field Buat Order (SCR-04) SANGAT BERBEDA per jenis shipment** — jangan pernah pakai satu set
   selector/field yang sama untuk kelima jenis:
   - FTL: paling sederhana, radio shipment langsung tampil tanpa filter kota wajib.
   - FCL & LCL: WAJIB isi field kapal (Pelabuhan, Kontainer, Jenis Jadwal Kapal) sebelum shipment
     muncul; ETD/ETA tanpa jam.
   - LTL & Air Freight: WAJIB isi Kota Asal/Tujuan (+ opsional Kota Transit) sebelum shipment muncul;
     Air Freight tambah field penerbangan lengkap dengan ETD/ETA BERJAM (beda dari FCL/LCL).
7. **SCR-05 (Buat Order dari shipment via kebab shipment) jauh lebih sederhana** dari SCR-04 kosong —
   hanya Tanggal Permintaan Muat yang perlu diisi, Jenis Armada/Jumlah Armada read-only. Jangan
   tertukar antara flow `/order/buat` (kosong) vs `/order/buat?shipmentId=...` (prefill) saat menulis
   skenario "Buat Order".
8. **Riwayat Perubahan Order (SCR-08) kosong di semua sampel yang dicek** (1 Draf, 1 Proses
   Pengiriman) — kemungkinan hanya terisi setelah order benar-benar diedit-dan-disimpan. Skenario
   yang butuh memvalidasi ISI riwayat (bukan cuma struktur kosong) harus memakai data yang sengaja
   diedit lebih dulu (dengan prefix `AUTOTEST-<tanggal>-` bila memungkinkan), bukan lewat harvest
   read-only.
9. **Radio shipment-picker (`name="shipment-picker"`) dipakai identik di Buat Order (SCR-04/05) DAN
   Edit Order (SCR-07)** — selector `input[name="shipment-picker"]` bisa dipakai ulang di kedua
   konteks form.
10. **Halaman "Buat Surat Jalan" (SCR-10) diawali step "Konfirmasi Profil" company-wide** (bukan
    per-order) yang datanya sudah terisi dari setup sebelumnya. Field surat jalan yang sesungguhnya
    (nomor SJ, dsb.) ADA DI STEP SELANJUTNYA yang belum terpetakan pada sesi read-only ini karena
    tombol "Preview"/"Simpan" tidak diklik (ambigu terhadap larangan cetak-memproses). Perlu sesi
    lanjutan dengan data `AUTOTEST-` untuk memetakan step berikutnya bila diperlukan.
11. Data uji yang dipakai untuk eksplorasi ini adalah data produksi/staging existing (FTL8849764283,
    FTL8744145034, dll., serta 669 order total) — BUKAN data buatan sesi ini, tidak perlu dibersihkan.
