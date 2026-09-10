# Module Map — TMS

Hasil `/explore` pertama kali. Dibuat: 2026-09-08.
Aplikasi: TMS (Transport Management System), tenant **LKL TMS** (PRAHU HUB), baseUrl `https://tms-staging.prahu-hub.com`.

Pembaruan shipment, 2026-09-11: route tetap mengacu tabel eksplorasi awal, tetapi perilaku/selector terkini
ada di `shared/selector-map-shipment.md` (harvest 25 state). Filter awal collapsed, Detail FTL Draf
memiliki Edit, halaman Edit FTL/LTL tidak memiliki tombol navigasi step, dan field awal Air Freight
hanya kota asal/tujuan serta catatan. Catatan historis shipment yang berbeda di bawah digantikan
oleh peta terbaru. Folder `scenario/shipment/` kini berisi 319 skenario; ui-inventory belum tersedia.

## Info Login & Environment

| Key | Nilai |
|---|---|
| baseUrl | https://tms-staging.prahu-hub.com |
| loginPath | /login |
| loginEmailSelector | `[placeholder="Masukkan Email"]` |
| loginPasswordSelector | `[placeholder="Masukkan Password"]` |
| loginButtonSelector | `role=button[name="Login"]` |
| loginSuccessUrlPattern | `/monitoring` |

Catatan kalibrasi: setelah submit, app sempat transit ke `/` lalu client-side redirect ke `/monitoring` (± 1-2 detik) — tunggu `waitForURL`/network idle sebelum assert. Nilai-nilai ini sudah ditulis ke `config/env.md`.

User yang login: **Admin** (finance.roro1@gmail.com), role **Administrator**, tenant **LKL TMS** (terlihat di `<title>` halaman setting, mis. "Pengaturan Notifikasi \| LKL TMS \| PRAHU HUB"). Header banner menampilkan chip "Admin / Administrator" + bel notifikasi (badge "79") + dropdown profil (email + tombol Logout). Sidebar bawah: bar "Kuota Shipment: 12/500" (2,4%) + teks versi "PRAHU HUB - Versi 26.06.08.2" (saat loading awal sempat 0/0). Tidak ada indikasi menu disabled/hidden untuk role Administrator — seluruh 13 grup sidebar terlihat dan bisa dibuka. (Akun #2 "Sub User" tersedia di `config/env.md` untuk perbandingan akses, belum diuji pada sesi ini.)

## Tabel Modul

| # | Modul | Route | Jenis Halaman | Aksi Utama | Ada Dokumen Skenario? | Catatan |
|---|---|---|---|---|---|---|
| 1 | Dashboard \| Monitoring | `/monitoring` | dashboard | filter armada per tahap, filter customer (combobox custom), link "Lacak" per armada; panel "Data Kasus" (badge Tidak Update / Melewati SLA, tombol Lihat); link "Riwayat" → `/monitoring/riwayat` | Tidak | Landing page default setelah login |
| 2 | Dashboard \| Tracking & Location | `/tracking-location` | form + peta | pilih ID Order (combobox custom, disabled sampai order dipilih), tab "Tracking Terkini"/"Riwayat Tracking" | Tidak | — |
| 3 | Dashboard \| Operasional | `/dashboard-operasional` | dashboard | preset periode (Harian/Mingguan/dst), "Pilih Tanggal" (flatpickr inline), filter jenis shipment (native `<select>`), Ekspor PDF | Tidak | Kombinasi grafik + tabel produktivitas armada |
| 4 | Shipment | `/shipment` | list | Buat Shipment, Batch Shipment, Riwayat Penghapusan, Filter (jenis: FTL/FCL/LTL/LCL/Air Freight). Aksi per baris tergantung jenis+status — FTL/FCL Draf: Detail, Buat Order, Edit, Hapus, Proses Invoice [disabled], Tambah Biaya, Riwayat Perubahan; LTL Draf: sama tanpa Buat Order; Terkirim: Detail, Edit [disabled], Hapus [disabled], Klaim Asuransi | Tidak | 1277 data. Resi = aksi "Lihat Resi" (hanya LTL/LCL/Air Freight; tab baru `blob:`). "Proses Invoice" enabled untuk semua status kecuali Draf. Sub-route (harvest 2026-09-08): `/shipment/{id}` (Detail, `?deleted=1` untuk data terhapus), `/shipment/{id}/edit`, `/shipment/{id}/riwayat`, `/shipment/{id}/tambah-biaya`, `/shipment/{id}/klaim-asuransi`, `/shipment/{id}/proses-invoice`, `/shipment/batch` (Batch Shipment = route penuh, bukan modal). Selector: `shared/selector-map-shipment.md` |
| 5 | Shipment \| Buat Shipment | `/shipment/buat` | form (wizard) | Step 1 Data Pengiriman → 2 Data Barang → 3 Kalkulasi Harga → 4 Review; jenis pengiriman FTL (default)/FCL/LTL/LCL/Air Freight; tombol Batal / Selanjutnya | Tidak | Navigasi ke route baru, bukan modal. Tidak diisi — label tombol step 4 belum terlihat |
| 6 | Shipment \| Riwayat Penghapusan | `/shipment/riwayat-penghapusan` | list | — | Tidak | Navigasi ke route baru, bukan modal |
| 7 | Order | `/order` | list | + Buat Order (→ `/order/buat`), Riwayat Pembatalan (→ `/order/riwayat-pembatalan`), Filter. Status: Draf / Ditugaskan / Proses Pengiriman / Selesai / Dibatalkan. Aksi per status — Draf: Detail, Edit, Batalkan Order, Riwayat Perubahan; Ditugaskan: Detail, Batalkan Order, Proses Surat Jalan, Riwayat Perubahan; Proses Pengiriman & Selesai: Detail, Proses Surat Jalan, Riwayat Perubahan; Dibatalkan: Detail, Riwayat Perubahan (tidak ada item disabled) | Tidak | 669 data. Sub-route (harvest 2026-09-09): `/order/{id}`, `/order/{id}/edit`, `/order/{id}/riwayat`, `/order/{id}/proses-surat-jalan`, `/order/{id}/proses-surat-jalan/buat`, `/order/buat?shipmentId={uuid}`. Selector: `shared/selector-map-order.md` |
| 8 | Penugasan Tracking | `/penugasan-tracking` | list | + Tambah Penugasan, Filter, Unduh Apk (link eksternal). Aksi per baris — Belum Berangkat: Detail, Edit Penugasan, Isi Data Tracking, Isi Kendala, Alihkan Armada, Riwayat Perubahan; Selesai: Detail, Edit Armada, Riwayat Perubahan | Tidak | 704 data; tidak ada tombol/tab Surat Jalan di sini (ada di Order) |
| 9 | Otomasi Jalur | `/otomasi-jalur` | tool/wizard | wizard 4 langkah (pilih penugasan → tandai titik peta → buat pratinjau jalur → terapkan jalur) | Tidak | Pola UI unik, bukan list/form biasa |
| 10 | Master Wilayah \| Provinsi | `/master/provinsi` | list (CRUD) | Tambah Provinsi, Filter, Riwayat, Edit Data (modal), Hapus Data | Tidak | 38 data. "Edit Data" membuka modal overlay (bukan navigasi) |
| 11 | Master Wilayah \| Kota | `/master/kota` | list (CRUD) | serupa Provinsi | Tidak | — |
| 12 | Master Wilayah \| Kecamatan | `/master/kecamatan` | list (CRUD) | serupa Provinsi | Tidak | — |
| 13 | Master Wilayah \| Kelurahan | `/master/kelurahan` | list (CRUD) | serupa Provinsi | Tidak | — |
| 14 | Master Operasional \| Customer | `/master/customer` | list (CRUD) | Tambah/Filter/Edit/Hapus | Tidak | — |
| 15 | Master Operasional \| Bandara | `/master/bandara` | list (CRUD) | serupa | Tidak | — |
| 16 | Master Operasional \| Drop Point | `/master/drop-point` | list (CRUD) | serupa | Tidak | — |
| 17 | Master Operasional \| Pelabuhan | `/master/pelabuhan` | list (CRUD) | serupa | Tidak | — |
| 18 | Master Operasional \| Pelayaran | `/master/pelayaran` | list (CRUD) | serupa | Tidak | — |
| 19 | Master Operasional \| Unit & Sopir | `/master/unit` | list (CRUD) | Tab Sopir/Armada/Jenis Armada/Jenis Kontainer | Tidak | 71 data |
| 20 | Master Operasional \| Rekening | `/master/bank` | list (CRUD) | serupa | Tidak | — |
| 21 | Master Operasional \| Kemasan | `/master/kemasan` | list (CRUD) | serupa | Tidak | — |
| 22 | Master Operasional \| Maskapai | `/master/maskapai` | list (CRUD) | serupa | Tidak | — |
| 23 | Master Rute | `/master/tarif` | list dengan tab | Tab Waktu Tempuh / Tarif Pengiriman / Konversi Muatan | Tidak | — |
| 24 | Keuangan \| Manajemen Invoice | `/monitoring-invoice` | list/dashboard hybrid | tab Invoice Per Shipment (default) / Invoice Per Periode; kartu Belum Dibayar / Jatuh Tempo Hari Ini / Total Overdue; + Buat Invoice, Filter, Export, Riwayat Penghapusan, Pengaturan. Aksi per baris: Lihat Invoice, Download Invoice, Hapus | Tidak | Tidak ada "Riwayat" (audit trail) per invoice |
| 25 | Keuangan \| Laporan Keuangan | `/laporan-keuangan` | dashboard/report | kartu Total Bruto / Total Laba Bruto / Total Laba Netto / Persentase Rata-Rata (badge % vs bulan lalu); tab per jenis pengiriman; tabel per shipment (ID Shipment, ID Order, Customer, Jenis, Tgl Muat/Bongkar, Asal, Tujuan, Jenis Armada, …) | Tidak | Laporan laba/margin, bukan laporan invoice. Catatan di halaman: "Isi data harga dasar untuk mengetahui laba dan margin" |
| 26 | Pengaturan Akun | `/pengaturan-akun` | setting | Tab Sub User (+ Tambah Sub User, Riwayat, Filter) / Hak Akses (Riwayat, Filter). Aksi per baris = 3 ikon langsung (lihat/edit/hapus), bukan dropdown. Form Hak Akses: shortcut "Terapkan Cepat ke Semua Modul", checkbox jenis pengiriman, tree modul, 17 toggle notifikasi | Tidak | 19 data sub user. Tab Hak Akses TIDAK punya tombol tambah |
| 27 | Akun Saya | `/akun-saya` | form/profile | Edit Profil, Ubah Password, Riwayat (→ `/akun-saya/riwayat`) | Tidak | — |
| 28 | Pusat Notifikasi \| Pengaturan Notifikasi | `/setting/general` | setting form | toggle switch, Batal/Simpan | Tidak | — |
| 29 | Pusat Notifikasi \| Preferensi Notifikasi | `/setting/preferensi-notifikasi` | setting form | — | Tidak | — |
| 30 | Panduan | `https://guide-tms.prahu-hub.com` | eksternal (dokumentasi) | — | Tidak | Situs terpisah, bukan bagian app TMS; tidak perlu ditest sebagai modul |
| 31 | Dashboard \| Monitoring \| Riwayat Kasus | `/monitoring/riwayat` | list | filter (Nopol, Nama Sopir, rentang tanggal, deskripsi, keterangan, jenis kasus); kolom No, Nopol/No. Kontainer + Nama Sopir, Kasus + Deskripsi, Tanggal Kasus + Selesai, Alasan Selesai | Tidak | 541 data; audit trail kasus monitoring (verifikasi lanjutan 2026-09-08) |
| 32 | Order \| Buat Order | `/order/buat` | form | kartu jenis shipment (FTL/FCL/LTL/LCL/Air Freight, `aria-pressed`), picker shipment draft (`name="shipment-picker"`), Tanggal Permintaan Muat; field per jenis: FCL = radio Direct/Connecting + Detail Kapal Utama (Pelayaran, Nama Kapal, Voyage, Closing Time, ETD, ETA) + blok Kapal Connecting; LCL = jadwal kapal; LTL = kota transit; Air Freight = jadwal penerbangan/drop point bandara | Tidak | Bukan form order independen — order dibangun dari shipment. Varian `?shipmentId={uuid}` = Form Order Lanjutan (LKL056) |
| 33 | Akun Saya \| Riwayat | `/akun-saya/riwayat` | list | tab Edit Akun Saya / Ubah Password; kolom No, Tanggal Perubahan, Diubah Oleh, Total Perubahan | Tidak | Data kosong saat ini |
| 34 | Halaman 404 | URL tidak dikenal (HTTP 404) | halaman statis | tombol "Kembali ke Beranda" (`href="/"` → `/monitoring`) | Tidak | Full-page tanpa sidebar/header; judul "Oops! Halaman Tidak Tersedia" |

Catatan cakupan: 13 grup sidebar, 28 route unik + halaman 404 + 1 link eksternal ditelusuri sampai 2 level (verifikasi lanjutan 2026-09-08 menambah #31–34). Pencocokan dengan spesifikasi: `explore/spec-crosscheck.md`. Folder `scenario/` masih kosong (belum ada dokumen skenario untuk modul manapun) — seluruh modul di atas baru bisa di-smoke-test, belum siap untuk `/test-module` detail sampai dokumen skenario dibuat.

## Temuan Janggal

- Console error berulang di banyak halaman: `401` pada `apitms-staging.prahu-hub.com/api/auth/refresh` dan sesekali `net::ERR_CONNECTION_CLOSED` pada `.../api/notifications/unread-count`. Tidak menghalangi fungsi UI yang diamati, tapi berpotensi flaky untuk fitur notifikasi/token-refresh — perlu diperhatikan saat eksekusi test agar tidak salah tandai sebagai bug UI.
- Pada `/shipment`, tombol "Edit" dan "Hapus" di dropdown Aksi disabled untuk shipment berstatus "Terkirim" — kemungkinan besar business-rule by-status, bukan bug maupun pembatasan role. Perlu verifikasi lanjut saat scenario planning shipment.
- Saat transisi awal load `/shipment`, sempat terlihat "PRAHU HUB - Versi -" dan kuota "0/0 (0%)" di sidebar sebelum data ter-fetch — state loading transien, bukan error permanen.
- Tidak ditemukan halaman blank/menu error/loading tak selesai pada seluruh route yang dikunjungi dengan akun Administrator.
- (2026-09-08, verifikasi lanjutan) Di `/shipment`, `locator.click()` bisa timeout bila elemen berada tepat di bawah header sticky (`z-99999`) yang mengintersep pointer, meski elemen "visible/enabled/stable". Solusi: `scrollIntoViewIfNeeded()` / `evaluate(el => el.scrollIntoView({block:'center'}))` dulu — bukan `dispatchEvent` (bukan bukti H1).
- Dropdown kebab "Aksi" per baris (Shipment, Order, Penugasan Tracking, Manajemen Invoice) tanpa ARIA: tidak ada `aria-haspopup`/`aria-expanded` di trigger, tidak ada `role="menu"`/`role="menuitem"` pada item. Berbeda dari filter combobox. Targetkan item lewat teks.
- Pengaturan Akun (Sub User & Hak Akses) memakai 3 ikon aksi langsung (lihat/edit/hapus), bukan dropdown Aksi — variasi pola UI.
- Tab Hak Akses tidak punya tombol tambah hak akses (spec LKL060 rule 8 menyebut ada). Kemungkinan hanya lewat form Tambah Sub User → konfirmasi ke user.
- Manajemen Invoice tidak punya "Riwayat" (audit trail perubahan status Lunas) per baris maupun level halaman (spec LKL041 rule 0411–0412) → konfirmasi ke user.
- (2026-09-08, harvest shipment) Halaman **Edit Shipment bukan wizard** — single-page accordion tanpa section Review; tombol Selanjutnya/Sebelumnya di dalamnya hanya memicu GET (aman diklik, diverifikasi via network log). Field step 1 form Buat berbeda total per jenis pengiriman.
- Aksi kebab "Tambah Biaya" → halaman penuh "Tambah Biaya (HPP)" hanya aktif pada status Proses Pengiriman; status lain menampilkan overlay blokir "Fitur belum dapat digunakan" (tanpa `role="dialog"`). Ada juga tombol inline "Tambah Biaya" berbeda di section Kalkulasi Harga halaman Edit.
- Datepicker filter `/shipment` (flatpickr popup) tidak auto-close meski sudah pilih 2 tanggal, klik di luar, atau Escape.
- (2026-09-09, harvest order) **Dua implementasi datepicker berbeda dalam satu app**: filter/dashboard = flatpickr; form Buat/Edit Order (Tanggal Permintaan Muat, Closing Time, ETD, ETA) = komponen datetime custom `div[role="button"]` + grid `button.h-9.w-9`, tidak auto-close — persis pola OMS (H4). Executor harus memilih helper per instance.
- Alur "Buat Surat Jalan" (`/order/{id}/proses-surat-jalan/buat`) diawali step "Konfirmasi Profil" (data perusahaan, company-wide) sebelum form surat jalan — tidak ada di spec LKL047.
- Kartu jenis shipment di `/order/buat` memakai `aria-pressed` (ada ARIA), berbeda dari kartu serupa di `/shipment/buat` yang tanpa ARIA — komponen tidak konsisten antar modul.

## Cek Hipotesis OMS

Ringkasan bukti dari sesi eksplorasi ini — perbarui juga tabel checklist di `CLAUDE.md` (kolom Status/Tanggal/Bukti) berdasarkan baris di bawah.

| # | Hipotesis | Status | Bukti |
|---|---|---|---|
| H1 | `locator.click()` biasa tidak memicu handler React, perlu `dispatchEvent('click')` | **BERBEDA** | Di `/monitoring`, `getByRole('button',{name:'Semua Customer'}).click()` standar (bukan dispatchEvent) langsung mengubah `aria-expanded` jadi `"true"` dan memunculkan `[role="listbox"]` berisi 10 `[role="option"]`. Klik biasa Playwright bekerja normal. Catatan `/shipment`: timeout klik terjadi hanya karena header sticky mengintersep pointer — selesai dengan scroll ke tengah viewport, bukan dispatchEvent. |
| H2 | Backend menolak sesi dipindah antar browser-context (`storageState` tidak berfungsi) | TIDAK DIUJI | Sengaja di-skip sesi ini (butuh multi-context, berisiko session/lock) |
| H3 | Dropdown selalu custom `button[aria-haspopup="listbox"]` + `role="option"` | **BERBEDA (campuran)** | (a) Custom combobox: tombol "Semua Customer" (Monitoring) dan filter Shipment ("Semua Jenis", "Semua Status", "Semua Kota", dst) = `button[aria-haspopup="listbox"][aria-expanded]` + `[role="option"]`. (b) Native `<select>`: filter "Semua Jenis Shipment" di Dashboard Operasional dan field Status pada modal Edit Provinsi = elemen `<select>` HTML asli + `<option>`. (c) Kebab "Aksi" per baris (Shipment/Order/Penugasan/Invoice): tanpa ARIA sama sekali. Harus dicek per komponen saat `/harvest-selectors`, tidak bisa diasumsikan satu pola. |
| H4 | Datepicker `div[role="button"]` + grid `button.h-9.w-9`, baris pertama ambigu (`.nth(1)`), default bukan bulan berjalan, tidak auto-close | **BERBEDA** | Datepicker "Pilih Tanggal" di Dashboard Operasional pakai **flatpickr**: sel tanggal `<span class="flatpickr-day">` (bukan `button`), dalam `div.dayContainer` di `div.flatpickr-calendar` (class `rangeMode animate multiMonth inline` — 2 bulan sekaligus, mode inline bukan popup). Default bulan = bulan berjalan (September 2026, sesuai tanggal sistem). Baris pertama memang berisi sisa tanggal bulan lalu (30–31 Agustus) dengan class tambahan `prevMonthDay hidden`. Tidak ada `role="dialog"`. Karena `rangeMode`+`inline`, klik satu tanggal tidak auto-close. Field datepicker single-date/popup lain (bila ada) perlu dicek ulang saat harvest-selectors karena implementasi berpotensi beda per instance. |
| H5 | Modal/dialog tidak memakai `role="dialog"` | **TERVERIFIKASI SAMA** | Modal "Edit Provinsi" (`/master/provinsi` → Aksi → Edit Data) = overlay `div.fixed.inset-0...z-99999` berisi `div.relative.rounded-3xl...max-w-lg`; ditelusuri seluruh rantai parent, tidak ada elemen `role="dialog"`. `document.querySelector('[role="dialog"]')` = `null` di halaman ini maupun Monitoring. |
| H6 | Tidak ada `data-testid` sama sekali | **TERVERIFIKASI SAMA** | `document.querySelectorAll('[data-testid]').length` = 0 di list Monitoring (`/monitoring`), list Master Provinsi (`/master/provinsi`), form Buat Shipment (`/shipment/buat`), dan `/monitoring-invoice` (sampel lanjutan). |
| H7 | Login: placeholder email/password, tombol role=button "Login", redirect dashboard tetap | **TERVERIFIKASI SAMA** (terjawab lewat kalibrasi) | Lihat section Info Login & Environment di atas — `[placeholder="Masukkan Email"]`, `[placeholder="Masukkan Password"]`, `role=button[name="Login"]`, redirect selalu ke `/monitoring`. |

Tindak lanjut yang disarankan: perbarui tabel "Hipotesis dari OMS" di `CLAUDE.md` dengan status/tanggal (2026-09-08)/bukti di atas untuk H1, H3, H4, H5, H6, H7 (H2 tetap "BELUM DICEK"). Karena H1, H3, H4 berstatus BERBEDA, hapus asumsi terkait workaround `dispatchEvent('click')`, `.nth(1)` datepicker, dan pola dropdown tunggal dari `tests/helpers/fixtures.js`, `playwright.config.js`, dan `docs/` sesuai aturan di CLAUDE.md — belum ada implementasi test yang memakainya saat ini (fixtures.js belum dicek isinya).

## Screenshot

Tersimpan di `artifacts/screenshots/explore/`:
- `dashboard-monitoring.png`
- `dashboard-operasional.png`
- `shipment.png`
- `order.png`
- `penugasan-tracking.png`
- `otomasi-jalur.png`
- `master-wilayah-provinsi.png` (mewakili provinsi/kota/kecamatan/kelurahan — pola CRUD identik)
- `master-operasional-customer.png` (mewakili customer/bandara/drop-point/pelabuhan/pelayaran/unit/bank/kemasan/maskapai — pola CRUD identik)
- `master-rute.png`
- `keuangan-manajemen-invoice.png`
- `pengaturan-akun.png`
- `akun-saya.png`
- `pusat-notifikasi-pengaturan.png`

Verifikasi lanjutan (2026-09-08) menambah: `shipment-aksi-dropdown.png`, `not-found.png`, `shipment-buat-wizard.png`, `monitoring-invoice.png`, `monitoring-invoice-per-periode.png`, `laporan-keuangan.png`, `penugasan-tracking-aksi.png`, `penugasan-tracking-aksi-belumberangkat.png`, `order-aksi-selesai2.png` (Proses Surat Jalan), `order-aksi-draft.png`, `order-buat-form.png`, `akun-saya-riwayat.png`, `pengaturan-akun-subuser.png`, `pengaturan-akun-hakakses.png`, `hakakses-edit-form.png`, dan beberapa file debug.

Tidak di-screenshot terpisah: Tracking & Location (`/tracking-location`, dicakup lewat snapshot saat eksplorasi) dan Panduan (link eksternal, di luar scope screenshot app).
