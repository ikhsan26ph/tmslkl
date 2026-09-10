# Selector Map — Shipment

Refresh browser 2026-09-10; dirapikan 2026-09-11 (WIB). Sumber utama executor untuk area `/shipment`.
Login memakai sesi Administrator yang tersedia, konfigurasi diverifikasi dari `config/env.md`; tidak ada login baru saat harvest.

**Cakupan: 14 layar/komponen, 25 state DOM; 4 layar wizard/konfirmasi dilewati. 182 definisi elemen/selector: 104 stabil, 78 membutuhkan scope struktural atau belum mempunyai selector stabil.**
Angka elemen menghitung baris definisi pada tabel, bukan jumlah duplikat baris shipment, item barang, atau sidebar. Selector parameter seperti nomor shipment/item wajib diikat ke data yang sedang diuji. “Stabil” berarti berbasis ID semantik/role/label/placeholder/text; keberadaan dan keunikan tetap diperiksa saat runtime. Baris bertanda TIDAK STABIL bukan jaminan siap pakai tanpa binding.

Tidak ada ui-inventory dalam scenario/shipment; penomoran SCR-01…16 dipertahankan dari peta route lama, SCR-17/18 ditambahkan untuk modal customer/konfirmasi Batal. Skenario sumber dan hasil test sebelumnya tidak diubah.
Bukti DOM: `artifacts/harvest/shipment-20260910-refresh/manifest.json` dan JSON per state. Peta lama diarsipkan sebagai `selector-map-before.md` dalam folder bukti. Screenshot: `artifacts/screenshots/harvest/shipment-20260910-refresh/shipment-filter.png`.

## Batas cakupan

| SCR | Status refresh | Alasan / batas |
|---|---|---|
| SCR-01/02/03/04/08/09/10/11/12/13/14/15/17/18 | DIPETAKAN | State dan sampel aktual dijelaskan per bagian. Bukan semua kombinasi jenis × status. |
| SCR-05 | SKIPPED | Wizard Data Barang membutuhkan draft valid. Field representasi Edit FTL/LTL tersedia di SCR-09, tidak dianggap identik dengan wizard. |
| SCR-06 | SKIPPED | Wizard Kalkulasi Harga membutuhkan draft valid. Representasi Edit tersedia di SCR-09. |
| SCR-07 | SKIPPED | Review membutuhkan pengisian draft dan perpindahan langkah; tidak dijalankan pada harvest. |
| SCR-16 | SKIPPED | Konfirmasi Hapus pada data existing tidak dibuka; tidak ada data buatan harvest untuk dihapus. |

Form lanjutan invoice, hasil import, diff riwayat tanpa data, varian FTL multi-pickup/drop, serta field LTL/LCL/Air setelah tarif/rute lengkap belum diverifikasi pada refresh ini. Catatan historis tidak boleh dianggap bukti state terbaru tersebut.

## Helper scope dan aturan eksekusi

```js
const row = page.getByRole('row').filter({
  has: page.getByRole('button', { name: shipmentNumber, exact: true })
});
const menu = page.locator('div.fixed.z-9999'); // fallback struktural, tanpa role=menu
const field = (scope, labelPattern) => scope.locator('label')
  .filter({ hasText: labelPattern }).locator('..'); // fallback, label tidak memakai for
const sender = page.getByRole('button', { name: 'Data Pengirim', exact: true }).locator('..');
const recipient = page.getByRole('button', { name: 'Data Penerima', exact: true }).locator('..');
const goods = page.getByRole('button', { name: 'Data Barang', exact: true }).locator('..'); // Edit LTL
const customerModal = page.getByRole('heading', { name: 'Tambah Customer', exact: true }).locator('..');
```

`sender/recipient/goods` berlaku pada Edit, bukan otomatis pada Buat. `item`, `priceRow`, `costRow`, dan `deletedRow` pada tabel adalah scope yang harus dibentuk dari identitas data uji; bukan variabel tersedia otomatis. Jangan menggunakan nth tetap untuk mengatasi ambiguitas. ID `dp-_r_0_` hasil React ditolak sebagai selector stabil.

- Prioritas workflow harvest: testid → ID stabil → role/name → label/placeholder. Tidak ditemukan data-testid pada elemen interaktif yang dikumpulkan dalam 25 state. Pemeriksaan seluruh DOM juga menghasilkan 0 pada sampel list, form, dan modal; jangan mengklaim tidak ada di seluruh aplikasi.
- Buka Filter dan tunggu kontrol actionable, bukan hanya visible. Untuk verifikasi nonmutasi dapat memakai `click({trial:true})`. Klik normal bekerja; tidak perlu dispatchEvent atau force.
- Dropdown custom: tunggu `getByRole('listbox')`, lalu scope option di dalamnya. Pagination memakai select native; opsi native global bisa hidden.
- Heading/route dapat muncul sebelum data selesai render. Tunggu field/accordion yang relevan. Tombol Simpan hanya dipakai sebagai penanda kesiapan pada harvest, tidak diklik.
- Selalu tutup modal yang dibuka. Draft Buat bertahan saat navigasi; jangan menganggap reload mengosongkan draft. Jangan membuang draft yang bukan milik run.
- Hasil ini memetakan selector, tidak membuat fixture, tidak menjalankan ulang 305 skenario, dan tidak mengubah verdict laporan sebelumnya.


## SCR-01 — Daftar Shipment

Route `/shipment`. Sampel terbaru dapat berubah karena tenant digunakan bersama. Buka Filter sebelum berinteraksi dengan isi panel.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-01 | Buat Shipment | `page.getByRole('button', { name: "Buat Shipment", exact: true })` | role | Filter awal collapsed; tombol lain membuka route yang sesuai. |
| SCR-01 | Batch Shipment | `page.getByRole('button', { name: "Batch Shipment", exact: true })` | role | Filter awal collapsed; tombol lain membuka route yang sesuai. |
| SCR-01 | Riwayat Penghapusan | `page.getByRole('button', { name: "Riwayat Penghapusan", exact: true })` | role | Filter awal collapsed; tombol lain membuka route yang sesuai. |
| SCR-01 | Filter | `page.getByRole('button', { name: "Filter", exact: true })` | role | Filter awal collapsed; tombol lain membuka route yang sesuai. |
| SCR-01 | Limit halaman | `page.getByRole('combobox')` | role | Satu select native di daftar: 10/20/50/100. Jangan tertukar dengan dropdown custom berupa button. |
| SCR-01 | ID shipment | `page.getByRole('button', { name: shipmentNumber, exact: true })` | role | Gunakan ID dari baris aktual; sampel SHP26090028. Halaman detail juga dapat dibuka melalui menu Aksi → Detail. |
| SCR-01 | Aksi shipment tertentu | `row.getByRole('button', { name: 'Aksi', exact: true })` | role | Accessible name berasal dari title=Aksi. Scope row wajib; hitungan terverifikasi 1 pada SHP26090028. |
| SCR-01 | Halaman pertama | `page.getByRole('button', { name: "Halaman pertama", exact: true })` | role | Accessible name berasal dari title. Periksa disabled sebelum klik. |
| SCR-01 | Sebelumnya | `page.getByRole('button', { name: "Sebelumnya", exact: true })` | role | Accessible name berasal dari title. Periksa disabled sebelum klik. |
| SCR-01 | Berikutnya | `page.getByRole('button', { name: "Berikutnya", exact: true })` | role | Accessible name berasal dari title. Periksa disabled sebelum klik. |
| SCR-01 | Halaman terakhir | `page.getByRole('button', { name: "Halaman terakhir", exact: true })` | role | Accessible name berasal dari title. Periksa disabled sebelum klik. |
| SCR-01 | Nomor halaman | `page.getByRole('button', { name: String(pageNumber), exact: true })` | role | Nomor dinamis; pastikan unik dan sedang tersedia. |

## SCR-02 — Filter dan tanggal

Panel tetap berada di DOM ketika collapsed: `grid-rows-[0fr] opacity-0`, tinggi 0. Sesudah Filter diklik menjadi `grid-rows-[1fr] opacity-100`. `isVisible()` pada input bukan bukti panel siap diklik. Enam scope label di bawah masing-masing menghasilkan tepat satu button pada harvest.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-02 | Cari ID shipment... | `page.getByPlaceholder("Cari ID shipment...", { exact: true })` | placeholder | — |
| SCR-02 | Cari nama customer... | `page.getByPlaceholder("Cari nama customer...", { exact: true })` | placeholder | — |
| SCR-02 | Semua Jenis | `page.getByRole('button', { name: "Semua Jenis", exact: true })` | role | Terapkan/Reset hanya dipetakan; tidak diperlukan untuk membuka panel. |
| SCR-02 | Semua Status | `page.getByRole('button', { name: "Semua Status", exact: true })` | role | Terapkan/Reset hanya dipetakan; tidak diperlukan untuk membuka panel. |
| SCR-02 | Reset | `page.getByRole('button', { name: "Reset", exact: true })` | role | Terapkan/Reset hanya dipetakan; tidak diperlukan untuk membuka panel. |
| SCR-02 | Terapkan | `page.getByRole('button', { name: "Terapkan", exact: true })` | role | Terapkan/Reset hanya dipetakan; tidak diperlukan untuk membuka panel. |
| SCR-02 | Kota Asal | `field(page, /^Kota Asal$/).getByRole('button')` | TIDAK STABIL | Label tidak terhubung melalui for/id; menggunakan parent langsung. Count=1 terverifikasi; perlu testid/label association. |
| SCR-02 | Kota Tujuan | `field(page, /^Kota Tujuan$/).getByRole('button')` | TIDAK STABIL | Label tidak terhubung melalui for/id; menggunakan parent langsung. Count=1 terverifikasi; perlu testid/label association. |
| SCR-02 | Droppoint Asal | `field(page, /^Droppoint Asal$/).getByRole('button')` | TIDAK STABIL | Label tidak terhubung melalui for/id; menggunakan parent langsung. Count=1 terverifikasi; perlu testid/label association. |
| SCR-02 | Droppoint Tujuan | `field(page, /^Droppoint Tujuan$/).getByRole('button')` | TIDAK STABIL | Label tidak terhubung melalui for/id; menggunakan parent langsung. Count=1 terverifikasi; perlu testid/label association. |
| SCR-02 | Tanggal Dibuat | `field(page, /^Tanggal Dibuat$/).getByRole('button')` | TIDAK STABIL | Label tidak terhubung melalui for/id; menggunakan parent langsung. Count=1 terverifikasi; perlu testid/label association. |
| SCR-02 | Tanggal Permintaan Muat | `field(page, /^Tanggal Permintaan Muat$/).getByRole('button')` | TIDAK STABIL | Label tidak terhubung melalui for/id; menggunakan parent langsung. Count=1 terverifikasi; perlu testid/label association. |
| SCR-02 | Opsi dropdown custom | `page.getByRole('listbox').getByRole('option', { name: optionText, exact: true })` | role | Jangan gunakan getByRole(option).first() global: opsi select pagination dapat terpilih dalam keadaan hidden. |
| SCR-02 | Pencarian opsi | `page.getByPlaceholder('Cari...', { exact: true })` | TIDAK STABIL | Muncul saat dropdown terbuka; gunakan hanya jika count=1 dan satu dropdown aktif. Jangan mengasumsikan input selalu child listbox. |
| SCR-02 | Kalender terbuka | `page.locator('.flatpickr-calendar')` | TIDAK STABIL | Tanggal Dibuat: class rangeMode animate multiMonth inline, sel SPAN.flatpickr-day, September. Inline flatpickr ditampilkan dalam panel tanggal yang dibuka trigger. |
| SCR-02 | Tanggal bulan aktif | `page.locator('.flatpickr-calendar .flatpickr-day:not(.prevMonthDay):not(.nextMonthDay)')` | TIDAK STABIL | Tambahkan tanggal/bulan spesifik sebelum klik; tidak memilih tanggal pada harvest ini. Hindari nth(1) sebagai workaround. |

## SCR-03 — Menu Aksi

Sampel FTL Draf SHP26090028 dan LTL Draf SHP26090019. Portal menu belum memiliki role=menu/menuitem. Aksi berbahaya hanya dicatat, tidak dijalankan.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-03 | Detail | `menu.getByRole('button', { name: "Detail", exact: true })` | TIDAK STABIL | Nama button stabil, tetapi menu menggunakan scope class portal. Item tergantung jenis/status; Hapus dan aksi cetak tidak diklik. |
| SCR-03 | Buat Order | `menu.getByRole('button', { name: "Buat Order", exact: true })` | TIDAK STABIL | Nama button stabil, tetapi menu menggunakan scope class portal. Item tergantung jenis/status; Hapus dan aksi cetak tidak diklik. |
| SCR-03 | Edit | `menu.getByRole('button', { name: "Edit", exact: true })` | TIDAK STABIL | Nama button stabil, tetapi menu menggunakan scope class portal. Item tergantung jenis/status; Hapus dan aksi cetak tidak diklik. |
| SCR-03 | Hapus | `menu.getByRole('button', { name: "Hapus", exact: true })` | TIDAK STABIL | Nama button stabil, tetapi menu menggunakan scope class portal. Item tergantung jenis/status; Hapus dan aksi cetak tidak diklik. |
| SCR-03 | Lihat Resi | `menu.getByRole('button', { name: "Lihat Resi", exact: true })` | TIDAK STABIL | Nama button stabil, tetapi menu menggunakan scope class portal. Item tergantung jenis/status; Hapus dan aksi cetak tidak diklik. |
| SCR-03 | Proses Invoice | `menu.getByRole('button', { name: "Proses Invoice", exact: true })` | TIDAK STABIL | Nama button stabil, tetapi menu menggunakan scope class portal. Item tergantung jenis/status; Hapus dan aksi cetak tidak diklik. |
| SCR-03 | Tambah Biaya | `menu.getByRole('button', { name: "Tambah Biaya", exact: true })` | TIDAK STABIL | Nama button stabil, tetapi menu menggunakan scope class portal. Item tergantung jenis/status; Hapus dan aksi cetak tidak diklik. |
| SCR-03 | Riwayat Perubahan | `menu.getByRole('button', { name: "Riwayat Perubahan", exact: true })` | TIDAK STABIL | Nama button stabil, tetapi menu menggunakan scope class portal. Item tergantung jenis/status; Hapus dan aksi cetak tidak diklik. |
| SCR-03 | Klaim Asuransi | `menu.getByRole('button', { name: "Klaim Asuransi", exact: true })` | TIDAK STABIL | Nama button stabil, tetapi menu menggunakan scope class portal. Item tergantung jenis/status; Hapus dan aksi cetak tidak diklik. |

## SCR-04 — Buat Shipment dan varian awal

Route `/shipment/buat`. Lima kartu jenis dibuka hanya untuk melihat field; tidak diisi data bisnis atau dilanjutkan ke step berikutnya. Normal dan Individu dipilih untuk membuka bagian/modal. Draft lokal tampilan harvest ditutup lewat Batal → Ya. Kartu jenis tidak memiliki aria-pressed; angka step bukan tab.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-04 | Jenis FTL | `page.getByRole('button', { name: /^FTL/ })` | role | Accessible name mencakup nama jenis dan subjudul. |
| SCR-04 | Jenis FCL | `page.getByRole('button', { name: /^FCL/ })` | role | Accessible name mencakup nama jenis dan subjudul. |
| SCR-04 | Jenis LTL | `page.getByRole('button', { name: /^LTL/ })` | role | Accessible name mencakup nama jenis dan subjudul. |
| SCR-04 | Jenis LCL | `page.getByRole('button', { name: /^LCL/ })` | role | Accessible name mencakup nama jenis dan subjudul. |
| SCR-04 | Jenis Air Freight | `page.getByRole('button', { name: /^Air Freight/ })` | role | Accessible name mencakup nama jenis dan subjudul. |
| SCR-04 | Pilih Jenis Armada | `page.getByRole('button', { name: "Pilih Jenis Armada", exact: true })` | role | FTL: armada/jumlah/tipe; FCL: pelabuhan/kontainer/jumlah/tipe. Gunakan scope label setelah nilainya berubah. |
| SCR-04 | Pilih Tipe Pengiriman | `page.getByRole('button', { name: "Pilih Tipe Pengiriman", exact: true })` | role | FTL: armada/jumlah/tipe; FCL: pelabuhan/kontainer/jumlah/tipe. Gunakan scope label setelah nilainya berubah. |
| SCR-04 | Pilih Pelabuhan Asal | `page.getByRole('button', { name: "Pilih Pelabuhan Asal", exact: true })` | role | FTL: armada/jumlah/tipe; FCL: pelabuhan/kontainer/jumlah/tipe. Gunakan scope label setelah nilainya berubah. |
| SCR-04 | Pilih Pelabuhan Tujuan | `page.getByRole('button', { name: "Pilih Pelabuhan Tujuan", exact: true })` | role | FTL: armada/jumlah/tipe; FCL: pelabuhan/kontainer/jumlah/tipe. Gunakan scope label setelah nilainya berubah. |
| SCR-04 | Pilih Jenis Kontainer | `page.getByRole('button', { name: "Pilih Jenis Kontainer", exact: true })` | role | FTL: armada/jumlah/tipe; FCL: pelabuhan/kontainer/jumlah/tipe. Gunakan scope label setelah nilainya berubah. |
| SCR-04 | Masukkan Jumlah Armada | `page.getByPlaceholder("Masukkan Jumlah Armada", { exact: true })` | placeholder | Hanya satu jenis quantity muncul sesuai kartu jenis. |
| SCR-04 | Masukkan Jumlah Kontainer | `page.getByPlaceholder("Masukkan Jumlah Kontainer", { exact: true })` | placeholder | Hanya satu jenis quantity muncul sesuai kartu jenis. |
| SCR-04 | Quantity Kurangi | `page.getByRole('button', { name: "Kurangi", exact: true })` | role | aria-label tersedia; Kurangi disabled pada nilai awal 1. |
| SCR-04 | Quantity Tambah | `page.getByRole('button', { name: "Tambah", exact: true })` | role | aria-label tersedia; Kurangi disabled pada nilai awal 1. |
| SCR-04 | Catatan Shipment | `page.locator('input[placeholder="Masukkan Catatan"]')` | TIDAK STABIL | maxlength=50. getByPlaceholder global juga cocok dengan textarea catatan pengirim/penerima; bedakan tag/scope. |
| SCR-04 | Kota Asal pada LTL/LCL/Air | `field(page, /^Kota Asal\s*\*$/).getByRole('button')` | TIDAK STABIL | Kedua tombol berteks Pilih Kota; wajib scope label. Parent form belum diuji count terpisah seperti filter. |
| SCR-04 | Kota Tujuan pada LTL/LCL/Air | `field(page, /^Kota Tujuan\s*\*$/).getByRole('button')` | TIDAK STABIL | Kedua tombol berteks Pilih Kota; wajib scope label. Parent form belum diuji count terpisah seperti filter. |
| SCR-04 | Batal | `page.getByRole('button', { name: "Batal", exact: true })` | role | Selanjutnya tidak diklik. Pada rute kosong LTL/LCL/Air tombol ini disabled. |
| SCR-04 | Selanjutnya | `page.getByRole('button', { name: "Selanjutnya", exact: true })` | role | Selanjutnya tidak diklik. Pada rute kosong LTL/LCL/Air tombol ini disabled. |
| SCR-04 | Pilih Pengirim | `page.getByRole('button', { name: "Pilih Pengirim", exact: true })` | role | Tambah Pengirim muncul pada pengirim Individu. Penerima Individu memakai input manual; Tambah Penerima tidak tersedia pada sampel FTL Normal. |
| SCR-04 | Pilih Penerima | `page.getByRole('button', { name: "Pilih Penerima", exact: true })` | role | Tambah Pengirim muncul pada pengirim Individu. Penerima Individu memakai input manual; Tambah Penerima tidak tersedia pada sampel FTL Normal. |
| SCR-04 | Tambah Pengirim | `page.getByRole('button', { name: "Tambah Pengirim", exact: true })` | role | Tambah Pengirim muncul pada pengirim Individu. Penerima Individu memakai input manual; Tambah Penerima tidak tersedia pada sampel FTL Normal. |
| SCR-04 | Nama penerima individu | `page.getByPlaceholder("Masukkan Nama Penerima", { exact: true })` | placeholder | Pengirim individu menggunakan picker master + Tambah Pengirim; kedua pihak tidak simetris. |
| SCR-04 | Jenis pengirim/penerima Perusahaan | `page.getByRole('button', { name: "Perusahaan", exact: true })` | TIDAK STABIL | Dapat muncul dua kali; scope ke bagian Pengirim/Penerima, bukan nth tetap. |
| SCR-04 | Jenis pengirim/penerima Individu | `page.getByRole('button', { name: "Individu", exact: true })` | TIDAK STABIL | Dapat muncul dua kali; scope ke bagian Pengirim/Penerima, bukan nth tetap. |
| SCR-04 | Masukkan Nama PIC per pihak | `page.getByPlaceholder("Masukkan Nama PIC", { exact: true })` | TIDAK STABIL | Berulang di kedua pihak dan/atau modal. Harus dibatasi container pihak; nama sales hanya pada mode perusahaan yang diamati. |
| SCR-04 | Masukkan Nomor WhatsApp PIC per pihak | `page.getByPlaceholder("Masukkan Nomor WhatsApp PIC", { exact: true })` | TIDAK STABIL | Berulang di kedua pihak dan/atau modal. Harus dibatasi container pihak; nama sales hanya pada mode perusahaan yang diamati. |
| SCR-04 | Masukkan Nama Sales per pihak | `page.getByPlaceholder("Masukkan Nama Sales", { exact: true })` | TIDAK STABIL | Berulang di kedua pihak dan/atau modal. Harus dibatasi container pihak; nama sales hanya pada mode perusahaan yang diamati. |
| SCR-04 | Masukkan Nomor WhatsApp Sales per pihak | `page.getByPlaceholder("Masukkan Nomor WhatsApp Sales", { exact: true })` | TIDAK STABIL | Berulang di kedua pihak dan/atau modal. Harus dibatasi container pihak; nama sales hanya pada mode perusahaan yang diamati. |
| SCR-04 | Kode Pos per pihak | `page.getByPlaceholder("Kode Pos", { exact: true })` | TIDAK STABIL | Berulang di kedua pihak dan/atau modal. Harus dibatasi container pihak; nama sales hanya pada mode perusahaan yang diamati. |
| SCR-04 | Masukkan Detail Lainnya per pihak | `page.getByPlaceholder("Masukkan Detail Lainnya", { exact: true })` | TIDAK STABIL | Berulang di kedua pihak dan/atau modal. Harus dibatasi container pihak; nama sales hanya pada mode perusahaan yang diamati. |
| SCR-04 | Masukkan Catatan per pihak | `page.getByPlaceholder("Masukkan Catatan", { exact: true })` | TIDAK STABIL | Berulang di kedua pihak dan/atau modal. Harus dibatasi container pihak; nama sales hanya pada mode perusahaan yang diamati. |
| SCR-04 | Masukkan Alamat Asal | `page.getByPlaceholder("Masukkan Alamat Asal", { exact: true })` | placeholder | Pada baseline perusahaan field alamat disabled; pada individu textarea alamat dapat diisi. Tidak diisi saat harvest. |
| SCR-04 | Masukkan Alamat Tujuan | `page.getByPlaceholder("Masukkan Alamat Tujuan", { exact: true })` | placeholder | Pada baseline perusahaan field alamat disabled; pada individu textarea alamat dapat diisi. Tidak diisi saat harvest. |
| SCR-04 | Pilih Provinsi per pihak | `page.getByRole('button', { name: "Pilih Provinsi", exact: true })` | TIDAK STABIL | Berulang; scope label dan pihak. Disabled tergantung mode serta prasyarat data. Jangan menyamakan dengan input readonly di Edit LTL. |
| SCR-04 | Pilih Kota/Kab. per pihak | `page.getByRole('button', { name: "Pilih Kota/Kab.", exact: true })` | TIDAK STABIL | Berulang; scope label dan pihak. Disabled tergantung mode serta prasyarat data. Jangan menyamakan dengan input readonly di Edit LTL. |
| SCR-04 | Pilih Kecamatan per pihak | `page.getByRole('button', { name: "Pilih Kecamatan", exact: true })` | TIDAK STABIL | Berulang; scope label dan pihak. Disabled tergantung mode serta prasyarat data. Jangan menyamakan dengan input readonly di Edit LTL. |
| SCR-04 | Pilih Desa/Kelurahan per pihak | `page.getByRole('button', { name: "Pilih Desa/Kelurahan", exact: true })` | TIDAK STABIL | Berulang; scope label dan pihak. Disabled tergantung mode serta prasyarat data. Jangan menyamakan dengan input readonly di Edit LTL. |
| SCR-04 | Pilih Drop Point per pihak | `page.getByRole('button', { name: "Pilih Drop Point", exact: true })` | TIDAK STABIL | Berulang; scope label dan pihak. Disabled tergantung mode serta prasyarat data. Jangan menyamakan dengan input readonly di Edit LTL. |

## SCR-08 — Detail dan detail terhapus

Sampel FTL Draf dan detail terhapus FCL. Tombol Edit ADA pada detail FTL Draf saat refresh ini, menggantikan catatan lama yang menyatakan tidak ada Edit. Setelah heading muncul, tunggu section detail; heading sendiri dapat muncul sebelum data selesai dimuat.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-08 | ← Kembali | `page.getByRole('button', { name: "← Kembali", exact: true })` | role | Buat Invoice disabled pada sampel Draf. Pada detail ?deleted=1, aksi Edit/Buat Invoice tidak muncul; section readonly tetap tersedia. |
| SCR-08 | Buat Invoice | `page.getByRole('button', { name: "Buat Invoice", exact: true })` | role | Buat Invoice disabled pada sampel Draf. Pada detail ?deleted=1, aksi Edit/Buat Invoice tidak muncul; section readonly tetap tersedia. |
| SCR-08 | Edit | `page.getByRole('button', { name: "Edit", exact: true })` | role | Buat Invoice disabled pada sampel Draf. Pada detail ?deleted=1, aksi Edit/Buat Invoice tidak muncul; section readonly tetap tersedia. |
| SCR-08 | Jenis Pengiriman dan Rute | `page.getByRole('button', { name: "Jenis Pengiriman dan Rute", exact: true })` | role | Buat Invoice disabled pada sampel Draf. Pada detail ?deleted=1, aksi Edit/Buat Invoice tidak muncul; section readonly tetap tersedia. |
| SCR-08 | Data Pengirim | `page.getByRole('button', { name: "Data Pengirim", exact: true })` | role | Buat Invoice disabled pada sampel Draf. Pada detail ?deleted=1, aksi Edit/Buat Invoice tidak muncul; section readonly tetap tersedia. |
| SCR-08 | Data Penerima | `page.getByRole('button', { name: "Data Penerima", exact: true })` | role | Buat Invoice disabled pada sampel Draf. Pada detail ?deleted=1, aksi Edit/Buat Invoice tidak muncul; section readonly tetap tersedia. |
| SCR-08 | Data Barang | `page.getByRole('button', { name: "Data Barang", exact: true })` | role | Buat Invoice disabled pada sampel Draf. Pada detail ?deleted=1, aksi Edit/Buat Invoice tidak muncul; section readonly tetap tersedia. |
| SCR-08 | Kalkulasi Harga | `page.getByRole('button', { name: "Kalkulasi Harga", exact: true })` | role | Buat Invoice disabled pada sampel Draf. Pada detail ?deleted=1, aksi Edit/Buat Invoice tidak muncul; section readonly tetap tersedia. |

## SCR-09 — Edit termasuk representasi Data Barang/Kalkulasi

Dibuka tanpa perubahan pada FTL Draf SHP26090028 dan LTL Draf SHP26090019. Single-page accordion; Sebelumnya/Selanjutnya berjumlah 0 pada sampel terbaru. Ini tidak membuktikan selector yang sama di wizard Buat step 2/3. Tunggu Simpan/field visible; networkidle saja dapat terjadi sebelum render selesai.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-09 | Jenis Pengiriman dan Rute | `page.getByRole('button', { name: "Jenis Pengiriman dan Rute", exact: true })` | role | Simpan tidak diklik. Jenis pengiriman dan tipe tidak dapat diganti pada halaman ini. |
| SCR-09 | Data Pengirim | `page.getByRole('button', { name: "Data Pengirim", exact: true })` | role | Simpan tidak diklik. Jenis pengiriman dan tipe tidak dapat diganti pada halaman ini. |
| SCR-09 | Data Penerima | `page.getByRole('button', { name: "Data Penerima", exact: true })` | role | Simpan tidak diklik. Jenis pengiriman dan tipe tidak dapat diganti pada halaman ini. |
| SCR-09 | Kalkulasi Harga | `page.getByRole('button', { name: "Kalkulasi Harga", exact: true })` | role | Simpan tidak diklik. Jenis pengiriman dan tipe tidak dapat diganti pada halaman ini. |
| SCR-09 | Batal | `page.getByRole('button', { name: "Batal", exact: true })` | role | Simpan tidak diklik. Jenis pengiriman dan tipe tidak dapat diganti pada halaman ini. |
| SCR-09 | Simpan | `page.getByRole('button', { name: "Simpan", exact: true })` | role | Simpan tidak diklik. Jenis pengiriman dan tipe tidak dapat diganti pada halaman ini. |
| SCR-09 | Accordion barang FTL | `page.getByRole('button', { name: /^Data Barang — Armada/ })` | role | Nomor armada dan nama jenis muncul dalam accessible name. |
| SCR-09 | Accordion barang LTL | `page.getByRole('button', { name: "Data Barang", exact: true })` | role | — |
| SCR-09 | sender Masukkan Nama PIC | `sender.getByPlaceholder("Masukkan Nama PIC", { exact: true })` | TIDAK STABIL | Scope parent accordion terverifikasi; PIC count=1 per pihak. Bergantung struktur parent, bukan label terhubung. |
| SCR-09 | sender Masukkan Nomor WhatsApp PIC | `sender.getByPlaceholder("Masukkan Nomor WhatsApp PIC", { exact: true })` | TIDAK STABIL | Scope parent accordion terverifikasi; PIC count=1 per pihak. Bergantung struktur parent, bukan label terhubung. |
| SCR-09 | sender Masukkan Nama Sales | `sender.getByPlaceholder("Masukkan Nama Sales", { exact: true })` | TIDAK STABIL | Scope parent accordion terverifikasi; PIC count=1 per pihak. Bergantung struktur parent, bukan label terhubung. |
| SCR-09 | sender Masukkan Nomor WhatsApp Sales | `sender.getByPlaceholder("Masukkan Nomor WhatsApp Sales", { exact: true })` | TIDAK STABIL | Scope parent accordion terverifikasi; PIC count=1 per pihak. Bergantung struktur parent, bukan label terhubung. |
| SCR-09 | sender Kode Pos | `sender.getByPlaceholder("Kode Pos", { exact: true })` | TIDAK STABIL | Scope parent accordion terverifikasi; PIC count=1 per pihak. Bergantung struktur parent, bukan label terhubung. |
| SCR-09 | recipient Masukkan Nama PIC | `recipient.getByPlaceholder("Masukkan Nama PIC", { exact: true })` | TIDAK STABIL | Scope parent accordion terverifikasi; PIC count=1 per pihak. Bergantung struktur parent, bukan label terhubung. |
| SCR-09 | recipient Masukkan Nomor WhatsApp PIC | `recipient.getByPlaceholder("Masukkan Nomor WhatsApp PIC", { exact: true })` | TIDAK STABIL | Scope parent accordion terverifikasi; PIC count=1 per pihak. Bergantung struktur parent, bukan label terhubung. |
| SCR-09 | recipient Masukkan Nama Sales | `recipient.getByPlaceholder("Masukkan Nama Sales", { exact: true })` | TIDAK STABIL | Scope parent accordion terverifikasi; PIC count=1 per pihak. Bergantung struktur parent, bukan label terhubung. |
| SCR-09 | recipient Masukkan Nomor WhatsApp Sales | `recipient.getByPlaceholder("Masukkan Nomor WhatsApp Sales", { exact: true })` | TIDAK STABIL | Scope parent accordion terverifikasi; PIC count=1 per pihak. Bergantung struktur parent, bukan label terhubung. |
| SCR-09 | recipient Kode Pos | `recipient.getByPlaceholder("Kode Pos", { exact: true })` | TIDAK STABIL | Scope parent accordion terverifikasi; PIC count=1 per pihak. Bergantung struktur parent, bukan label terhubung. |
| SCR-09 | LTL Pilih Provinsi per pihak | `sender.getByPlaceholder("Pilih Provinsi", { exact: true })` | TIDAK STABIL | Edit LTL: input/textarea disabled. Gunakan recipient untuk pihak tujuan. FTL memakai button wilayah, bukan input. |
| SCR-09 | LTL Pilih Kota/Kab. per pihak | `sender.getByPlaceholder("Pilih Kota/Kab.", { exact: true })` | TIDAK STABIL | Edit LTL: input/textarea disabled. Gunakan recipient untuk pihak tujuan. FTL memakai button wilayah, bukan input. |
| SCR-09 | LTL Pilih Kecamatan per pihak | `sender.getByPlaceholder("Pilih Kecamatan", { exact: true })` | TIDAK STABIL | Edit LTL: input/textarea disabled. Gunakan recipient untuk pihak tujuan. FTL memakai button wilayah, bukan input. |
| SCR-09 | LTL Pilih Desa/Kelurahan per pihak | `sender.getByPlaceholder("Pilih Desa/Kelurahan", { exact: true })` | TIDAK STABIL | Edit LTL: input/textarea disabled. Gunakan recipient untuk pihak tujuan. FTL memakai button wilayah, bukan input. |
| SCR-09 | LTL Masukkan Alamat per pihak | `sender.getByPlaceholder("Masukkan Alamat", { exact: true })` | TIDAK STABIL | Edit LTL: input/textarea disabled. Gunakan recipient untuk pihak tujuan. FTL memakai button wilayah, bukan input. |
| SCR-09 | Jenis Barang per item | `goods.getByPlaceholder("Masukkan Jenis Barang", { exact: true })` | TIDAK STABIL | LTL sampel memiliki 2 item. Identifikasi item melalui data run lalu scope item; jangan menggunakan first untuk eksekusi umum. |
| SCR-09 | Jumlah per item | `field(item, /^Jumlah\s*\*?$/).locator('input')` | TIDAK STABIL | Placeholder 0 berulang; field numeric perlu scope item dan label. Panjang/Lebar/Tinggi terlihat pada LTL, tidak pada sampel FTL. |
| SCR-09 | Berat per item | `field(item, /^Berat\s*\*?$/).locator('input')` | TIDAK STABIL | Placeholder 0 berulang; field numeric perlu scope item dan label. Panjang/Lebar/Tinggi terlihat pada LTL, tidak pada sampel FTL. |
| SCR-09 | Kubikasi per item | `field(item, /^Kubikasi\s*\*?$/).locator('input')` | TIDAK STABIL | Placeholder 0 berulang; field numeric perlu scope item dan label. Panjang/Lebar/Tinggi terlihat pada LTL, tidak pada sampel FTL. |
| SCR-09 | Panjang per item | `field(item, /^Panjang\s*\*?$/).locator('input')` | TIDAK STABIL | Placeholder 0 berulang; field numeric perlu scope item dan label. Panjang/Lebar/Tinggi terlihat pada LTL, tidak pada sampel FTL. |
| SCR-09 | Lebar per item | `field(item, /^Lebar\s*\*?$/).locator('input')` | TIDAK STABIL | Placeholder 0 berulang; field numeric perlu scope item dan label. Panjang/Lebar/Tinggi terlihat pada LTL, tidak pada sampel FTL. |
| SCR-09 | Tinggi per item | `field(item, /^Tinggi\s*\*?$/).locator('input')` | TIDAK STABIL | Placeholder 0 berulang; field numeric perlu scope item dan label. Panjang/Lebar/Tinggi terlihat pada LTL, tidak pada sampel FTL. |
| SCR-09 | Kemasan LTL per item | `field(item, /^Kemasan\s*\*$/).getByRole('button')` | TIDAK STABIL | Custom combobox; teks saat ini mengikuti data tersimpan. Tidak diubah. |
| SCR-09 | Asuransi FTL item pertama | `page.locator('#ins-0-0')` | id | Pola ins-{armadaIndex}-{itemIndex}; tidak berlaku untuk LTL. getByLabel juga tersedia jika di-scope ke item. |
| SCR-09 | Asuransi LTL per item | `page.locator('#ltl-ins-' + itemIndex)` | id | ltl-ins-0 dan ltl-ins-1 teramati. Index harus mengikuti item run, bukan diasumsikan tetap. |
| SCR-09 | Tambah Barang FTL | `page.getByRole('button', { name: "Tambah Barang", exact: true })` | role | Tidak diklik karena menambah item draft. |
| SCR-09 | Tambah Barang LTL | `page.getByRole('button', { name: "+ Tambah Barang", exact: true })` | role | Label aktual mencakup tanda plus; berbeda dari FTL. Tidak diklik. |
| SCR-09 | Hapus item barang | `Belum ada selector semantik unik; scope item lalu identifikasi button ikon` | TIDAK STABIL | Button ikon tanpa nama/ID; jangan menebak urutan tombol. |
| SCR-09 | Tambah Biaya kalkulasi | `page.getByRole('button', { name: "Tambah Biaya", exact: true })` | role | Menambah baris lokal kalkulasi, berbeda dari menu HPP. Tidak diklik. |
| SCR-09 | PPN | `field(page, /^PPN\s*\*$/).locator('input')` | TIDAK STABIL | Placeholder 0; parent label digunakan sebagai fallback. |
| SCR-09 | PPh | `field(page, /^PPh\s*\*$/).locator('input')` | TIDAK STABIL | Placeholder 0; parent label digunakan sebagai fallback. |
| SCR-09 | Ongkos kirim/harga per armada | `priceRow.getByPlaceholder('0', { exact: true })` | TIDAK STABIL | Scope row tabel kalkulasi wajib; tidak ada label/ID unik pada input harga. |

## SCR-10 — Riwayat Perubahan

Route `/shipment/{id}/riwayat`. Sampel Draf tidak memiliki baris perubahan saat harvest; detail diff belum dipetakan ulang. Tombol kembali ternyata link. Filter tanggal memakai ID React `dp-_r_0_`, ditolak sebagai ID stabil.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-10 | Kembali | `page.getByRole('link', { name: '← Kembali', exact: true })` | role | — |
| SCR-10 | Filter | `page.getByRole('button', { name: "Filter", exact: true })` | role | — |
| SCR-10 | Reset | `page.getByRole('button', { name: "Reset", exact: true })` | role | — |
| SCR-10 | Terapkan | `page.getByRole('button', { name: "Terapkan", exact: true })` | role | — |
| SCR-10 | Limit | `page.getByRole('combobox')` | role | Select native. |
| SCR-10 | dd/mm/yyyy | `page.getByPlaceholder("dd/mm/yyyy", { exact: true })` | placeholder | Tanggal/input aktor filter. Jangan gunakan dp-_r_0_ sebagai ID tetap. |
| SCR-10 | Nama atau email user | `page.getByPlaceholder("Nama atau email user", { exact: true })` | placeholder | Tanggal/input aktor filter. Jangan gunakan dp-_r_0_ sebagai ID tetap. |

## SCR-11 — Riwayat Penghapusan

Route `/shipment/riwayat-penghapusan`. Hanya membaca record yang sudah terhapus; tidak menghapus/memulihkan record. Detail menuju `/shipment/{id}?deleted=1`.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-11 | Kembali | `page.getByRole('link', { name: '← Kembali', exact: true })` | role | — |
| SCR-11 | Filter | `page.getByRole('button', { name: "Filter", exact: true })` | role | — |
| SCR-11 | Reset | `page.getByRole('button', { name: "Reset", exact: true })` | role | — |
| SCR-11 | Terapkan | `page.getByRole('button', { name: "Terapkan", exact: true })` | role | — |
| SCR-11 | Limit | `page.getByRole('combobox')` | role | — |
| SCR-11 | Masukkan ID Shipment | `page.getByPlaceholder("Masukkan ID Shipment", { exact: true })` | placeholder | — |
| SCR-11 | dd/mm/yyyy | `page.getByPlaceholder("dd/mm/yyyy", { exact: true })` | placeholder | — |
| SCR-11 | Nama atau email user | `page.getByPlaceholder("Nama atau email user", { exact: true })` | placeholder | — |
| SCR-11 | Detail per record | `deletedRow.getByRole('button', { name: "Detail", exact: true })` | role | Pilih baris berdasarkan ID yang dibaca, bukan first dalam executor. |

## SCR-12 — Batch Shipment

Route `/shipment/batch`, heading Batch Upload Shipment. Awal hanya kartu jenis. Varian FTL dibuka untuk melihat kontrol. Import Batch Shipment disabled tanpa file. Tidak download/upload/impor.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-12 | Jenis FTL | `page.getByRole('button', { name: /^FTL/ })` | role | Hanya FTL diperluas hingga kontrol upload pada refresh ini. |
| SCR-12 | Jenis FCL | `page.getByRole('button', { name: /^FCL/ })` | role | Hanya FTL diperluas hingga kontrol upload pada refresh ini. |
| SCR-12 | Jenis LTL | `page.getByRole('button', { name: /^LTL/ })` | role | Hanya FTL diperluas hingga kontrol upload pada refresh ini. |
| SCR-12 | Jenis LCL | `page.getByRole('button', { name: /^LCL/ })` | role | Hanya FTL diperluas hingga kontrol upload pada refresh ini. |
| SCR-12 | Jenis Air Freight | `page.getByRole('button', { name: /^Air Freight/ })` | role | Hanya FTL diperluas hingga kontrol upload pada refresh ini. |
| SCR-12 | Download Template Excel | `page.getByRole('button', { name: "Download Template Excel", exact: true })` | role | Tersedia sesudah jenis dipilih; tombol impor tidak diklik. |
| SCR-12 | Batal | `page.getByRole('button', { name: "Batal", exact: true })` | role | Tersedia sesudah jenis dipilih; tombol impor tidak diklik. |
| SCR-12 | Import Batch Shipment | `page.getByRole('button', { name: "Import Batch Shipment", exact: true })` | role | Tersedia sesudah jenis dipilih; tombol impor tidak diklik. |
| SCR-12 | Upload Excel | `page.locator('input[type="file"]')` | TIDAK STABIL | Input file tanpa label/id/placeholder pada hasil evaluate. Periksa accept dan ukuran melalui UI; jangan mengandalkan batas lama yang belum direvalidasi. |

## SCR-13 — Tambah Biaya HPP dan overlay prasyarat

Halaman dibuka dari FCL Proses Pengiriman SHP26090031. Dari FTL Draf SHP26090028 muncul overlay Fitur belum dapat digunakan. Simpan/tambah item tidak dijalankan.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-13 | Tambah Item Biaya | `page.getByRole('button', { name: "Tambah Item Biaya", exact: true })` | role | — |
| SCR-13 | Batal | `page.getByRole('button', { name: "Batal", exact: true })` | role | — |
| SCR-13 | Simpan | `page.getByRole('button', { name: "Simpan", exact: true })` | role | — |
| SCR-13 | Harga Dasar per baris | `costRow.getByPlaceholder('0', { exact: true })` | TIDAK STABIL | Ada input responsive hidden; batasi row yang benar dan elemen visible. Tidak menyimpulkan count global. |
| SCR-13 | Judul overlay blokir | `page.getByText('Fitur belum dapat digunakan', { exact: true })` | text | Tanpa role=dialog. |
| SCR-13 | Tutup overlay | `page.getByRole('button', { name: "Kembali", exact: true })` | role | — |

## SCR-14 — Klaim Asuransi

Route dari FTL Terkirim SHP26090036. Tambah Klaim Asuransi hanya membuka form kosong. Nominal dan keterangan memiliki ID serta label terhubung; catatan lama “tanpa selector stabil” digantikan.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-14 | ← Kembali | `page.getByRole('button', { name: "← Kembali", exact: true })` | role | Batal/Simpan muncul pada form; tidak menyimpan klaim. |
| SCR-14 | Tambah Klaim Asuransi | `page.getByRole('button', { name: "Tambah Klaim Asuransi", exact: true })` | role | Batal/Simpan muncul pada form; tidak menyimpan klaim. |
| SCR-14 | Pilih pihak penanggung | `page.getByRole('button', { name: "Pilih pihak penanggung", exact: true })` | role | Batal/Simpan muncul pada form; tidak menyimpan klaim. |
| SCR-14 | Batal | `page.getByRole('button', { name: "Batal", exact: true })` | role | Batal/Simpan muncul pada form; tidak menyimpan klaim. |
| SCR-14 | Simpan | `page.getByRole('button', { name: "Simpan", exact: true })` | role | Batal/Simpan muncul pada form; tidak menyimpan klaim. |
| SCR-14 | Nominal Kompensasi | `page.locator('#nominalKompensasi')` | id | Alternatif getByLabel(/Nominal Kompensasi/), placeholder 0. |
| SCR-14 | Keterangan klaim | `page.locator('#keterangan')` | id | Alternatif getByLabel(/Keterangan/), placeholder Masukkan keterangan klaim.... |
| SCR-14 | Tutup form ikon | `Button ikon tanpa accessible name pada form` | TIDAK STABIL | Gunakan Batal yang bernama jelas untuk menutup form. |

## SCR-15 — Proses Invoice

Halaman dibuka dari FTL Ditugaskan SHP26090038. Hanya landing page dipetakan. Tombol pembuatan invoice dan form lanjutan tidak dijalankan/dipetakan karena kemungkinan aksi tulis; ini bukan pengujian enable rule seluruh status.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-15 | Kembali | `page.getByRole('button', { name: "Kembali", exact: true })` | role | Tidak klik kedua tombol pembuatan invoice. |
| SCR-15 | Buat Invoice Jasa Pengiriman | `page.getByRole('button', { name: "Buat Invoice Jasa Pengiriman", exact: true })` | role | Tidak klik kedua tombol pembuatan invoice. |
| SCR-15 | Buat Invoice Tambahan (Tanpa PPN) | `page.getByRole('button', { name: "Buat Invoice Tambahan (Tanpa PPN)", exact: true })` | role | Tidak klik kedua tombol pembuatan invoice. |

## SCR-17 — Modal Tambah Customer

Dibuka dari Tambah Pengirim, FTL Normal/Individu. Modal tanpa role=dialog, parent heading h4 adalah container. Tidak mengisi field atau menyimpan. Jenis Customer berupa input disabled Individu; kode pos juga disabled, sehingga input:disabled global ambigu.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-17 | Modal Tambah Customer | `page.getByRole('heading', { name: 'Tambah Customer', exact: true }).locator('..')` | TIDAK STABIL | Heading terverifikasi H4; parent struktur perlu dijaga. Helper customerModal di bawah. |
| SCR-17 | Jenis Customer Individu | `customerModal.locator('input[value="Individu"]')` | TIDAK STABIL | Count=1, disabled=true; jangan memeriksa readOnly=true. |
| SCR-17 | Masukkan Nama Customer | `customerModal.getByPlaceholder("Masukkan Nama Customer", { exact: true })` | TIDAK STABIL | Placeholder jelas tetapi bergantung scope modal struktural; kode pos 12345 disabled pada baseline kosong. |
| SCR-17 | Masukkan Nomor WhatsApp | `customerModal.getByPlaceholder("Masukkan Nomor WhatsApp", { exact: true })` | TIDAK STABIL | Placeholder jelas tetapi bergantung scope modal struktural; kode pos 12345 disabled pada baseline kosong. |
| SCR-17 | 12345 | `customerModal.getByPlaceholder("12345", { exact: true })` | TIDAK STABIL | Placeholder jelas tetapi bergantung scope modal struktural; kode pos 12345 disabled pada baseline kosong. |
| SCR-17 | Masukkan Alamat Lengkap | `customerModal.getByPlaceholder("Masukkan Alamat Lengkap", { exact: true })` | TIDAK STABIL | Placeholder jelas tetapi bergantung scope modal struktural; kode pos 12345 disabled pada baseline kosong. |
| SCR-17 | Masukkan Detail Lainnya | `customerModal.getByPlaceholder("Masukkan Detail Lainnya", { exact: true })` | TIDAK STABIL | Placeholder jelas tetapi bergantung scope modal struktural; kode pos 12345 disabled pada baseline kosong. |
| SCR-17 | Pilih Provinsi | `customerModal.getByRole('button', { name: "Pilih Provinsi", exact: true })` | TIDAK STABIL | Scope modal menghindari kecocokan form utama; Simpan tidak diklik. Tunggu heading hidden sesudah Batal. |
| SCR-17 | Pilih Kota/Kab. | `customerModal.getByRole('button', { name: "Pilih Kota/Kab.", exact: true })` | TIDAK STABIL | Scope modal menghindari kecocokan form utama; Simpan tidak diklik. Tunggu heading hidden sesudah Batal. |
| SCR-17 | Pilih Kecamatan | `customerModal.getByRole('button', { name: "Pilih Kecamatan", exact: true })` | TIDAK STABIL | Scope modal menghindari kecocokan form utama; Simpan tidak diklik. Tunggu heading hidden sesudah Batal. |
| SCR-17 | Pilih Desa/Kelurahan | `customerModal.getByRole('button', { name: "Pilih Desa/Kelurahan", exact: true })` | TIDAK STABIL | Scope modal menghindari kecocokan form utama; Simpan tidak diklik. Tunggu heading hidden sesudah Batal. |
| SCR-17 | Batal | `customerModal.getByRole('button', { name: "Batal", exact: true })` | TIDAK STABIL | Scope modal menghindari kecocokan form utama; Simpan tidak diklik. Tunggu heading hidden sesudah Batal. |
| SCR-17 | Simpan | `customerModal.getByRole('button', { name: "Simpan", exact: true })` | TIDAK STABIL | Scope modal menghindari kecocokan form utama; Simpan tidak diklik. Tunggu heading hidden sesudah Batal. |

## SCR-18 — Konfirmasi Batal

Dialog konfirmasi draft lokal Buat Shipment; tidak terkait pembatalan record existing. Dibuka setelah mengubah varian tampilan form tanpa mengisi data. Tidak memiliki role=dialog.

| SCR | Elemen | Selector terbaik | Sumber | Catatan |
|---|---|---|---|---|
| SCR-18 | Pesan konfirmasi | `page.getByText('Apakah Anda yakin ingin membatalkan ?', { exact: true })` | text | Teks dan spasi mengikuti UI; bila berubah, diagnosis sebelum memakai selector baru. |
| SCR-18 | Tidak | `page.getByRole('button', { name: "Tidak", exact: true })` | role | Tidak menutup dialog setelah animasi; Ya menutup draft lokal dan kembali daftar. Bukan label Konfirmasi Batal/Lanjutkan Pengisian. |
| SCR-18 | Ya | `page.getByRole('button', { name: "Ya", exact: true })` | role | Tidak menutup dialog setelah animasi; Ya menutup draft lokal dan kembali daftar. Bukan label Konfirmasi Batal/Lanjutkan Pengisian. |

## Perubahan penting terhadap peta lama

- Filter awal collapsed; selector input tetap dapat dianggap visible di panel tinggi 0.
- Tombol Aksi memiliki accessible name dari title, sehingga role button bernama Aksi dapat digunakan di dalam row.
- Detail FTL Draf memiliki Edit; Edit FTL/LTL tidak memiliki navigasi Sebelumnya/Selanjutnya pada sampel terbaru.
- Air Freight awal hanya kota asal/tujuan + catatan, sama seperti awal LTL/LCL. Bandara/pengirim/penerima tidak terlihat sebelum rute dipilih; tidak disimpulkan dihapus dari seluruh flow.
- Field wilayah dan alamat pada baseline perusahaan Buat dapat disabled; jangan menganggap semua aktif.
- Penerima Individu berupa input manual, tidak memiliki Tambah Penerima pada sampel FTL Normal. Ini fakta UI, bukan putusan bug/desain.
- Riwayat memiliki link ← Kembali; tanggal memakai placeholder dd/mm/yyyy dan ID React dinamis.
- Klaim memakai #nominalKompensasi dan #keterangan dengan label terhubung, menggantikan selector generik lama.
- Checkbox asuransi Edit FTL dan LTL memakai pola ID berbeda.

## Checklist hipotesis OMS — bukti refresh

| Item | Hasil | Bukti / batas |
|---|---|---|
| H1 click standar | BERBEDA dari dugaan workaround OMS | Filter, menu Aksi, kartu jenis dan modal terbuka dengan click standar. Kegagalan locator awal karena option native hidden diselesaikan lewat scope listbox. |
| H2 perpindahan storageState | TIDAK DIUJI | Tidak membuka context baru atau menyalin sesi. |
| H3 dropdown tunggal | BERBEDA, campuran | Filter berupa button/listbox/option; pagination select native; menu Aksi button tanpa role=menu. |
| H4 datepicker | BERBEDA, sesuai instance | Tanggal Dibuat: flatpickr-calendar rangeMode animate multiMonth inline, SPAN.flatpickr-day, September. Buka kalender saja; perilaku setelah memilih tanggal tidak diuji ulang. |
| H5 role dialog | SAMA pada modal yang diperiksa | Tambah Customer, konfirmasi Batal, overlay HPP tidak mempunyai role=dialog. |
| H6 testid | SAMA pada sampel yang diperiksa | 0 pada elemen interaktif semua state manifest; query global DOM juga 0 pada sampel list/form/modal. Tidak diperluas ke layar yang dilewati. |
| H7 login | TIDAK DIUJI ULANG | Memakai sesi login yang tersedia; konfigurasi hanya diverifikasi terisi. |

## Rekomendasi data-testid untuk developer

| Area tanpa selector stabil | Usulan |
|---|---|
| Panel dan field filter ganda | shipment-filter-panel, shipment-filter-origin-city, shipment-filter-destination-city, shipment-filter-created-date, shipment-filter-load-date |
| Portal menu Aksi | shipment-action-menu; tambahkan role=menu dan accessible name per aksi |
| Container pihak | shipment-sender, shipment-recipient; kaitkan label for ke ID field unik |
| Catatan shipment vs catatan pihak | shipment-note, shipment-sender-note, shipment-recipient-note |
| Baris barang dan field numeric | shipment-item-{key}, shipment-item-{key}-weight, -length, -width, -height, -quantity, -packaging |
| Harga/pajak/kalkulasi | shipment-price-{key}, shipment-ppn, shipment-pph |
| Hapus item/icon tanpa nama | shipment-item-{key}-delete; aria-label=Hapus barang {nomor} |
| Modal customer | shipment-customer-dialog, shipment-customer-type; gunakan role=dialog + aria-labelledby |
| Upload batch | shipment-batch-file, dengan label Upload Excel |
| HPP | shipment-cost-{key}-base-price |

Usulan di atas belum tersedia di implementasi. Untuk wizard Review dan konfirmasi Hapus yang dilewati, jangan mengarang selector dari desain.

