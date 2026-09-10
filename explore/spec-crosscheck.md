# Cross-check Spesifikasi ↔ Aplikasi — TMS LKL

Dibuat: 2026-09-08 dari `/explore` (`explore/module-map.md`) + verifikasi read-only lanjutan (2026-09-08, 11 item) dan file spesifikasi
`/home/icun/Produk/LKL/LIST ID PENGERJAAN VERSI 2.0.xlsx` → sheet **`Spek TMS-LKL`** (56 ID, kolom:
ID · Detail Fitur · PIC · No · Jenis Fitur (nomor desain) · Detail Fitur (Pendahuluan/Rule/Visual) · Spesifikasi Selesai · Versi).

**Peringatan dari pemilik spec (user, 2026-09-08):** ini spesifikasi AWAL; banyak yang sudah tidak sesuai karena ada
improvement saat development. Aturan pakai:
- Spec = sumber **REQ** saat menulis `scenario/<modul>/*_analysis.md`, tetapi **aplikasi = sumber kebenaran** untuk struktur menu/route/selector.
- Bila aplikasi berbeda dari spec: catat sebagai **gap desain** (bukan bug) di `*_analysis.md` + `shared/decisions.md`, kecuali user menyatakan perilaku spec-lah yang benar.
- Kolom `Versi` tidak bisa dipakai sebagai urutan waktu (TM 2.0.0 tertanggal Juni, TM 1.0.3/1.0.5 tertanggal Jul–Agu). Pakai kolom `Spesifikasi Selesai`.
- Sheet lain (`Spek TMS-S`, `Spek OMS`, `Spek Darat/Laut/RORO/DK`, `Spek Driver Hub`, `Spek PH-App`) = produk lain, bukan TMS LKL.
- Sheet `Timeline` hanya memuat LKL001–028 (status "DEV PGR" untuk 001–015, sisanya kosong); `Progress BUG` tidak punya baris LKL.

Status kecocokan: **SESUAI** = route/fitur ditemukan seperti spec · **BERBEDA** = ditemukan tapi struktur/nama beda ·
**TIDAK DITEMUKAN** = dicari di app, tidak ada · **BELUM DICEK** = belum diverifikasi (explore read-only tidak sampai ke sana) · **DI LUAR SCOPE** = bukan web TMS.

## Tabel per ID Spec

| ID | Fitur (spec) | Selesai / Versi | Route / lokasi di app | Status | Catatan |
|---|---|---|---|---|---|
| LKL001 | Login | 2026-04-15 / 1.0.0 | `/login` → redirect `/monitoring` | SESUAI | Selector terkalibrasi di `config/env.md` (H7) |
| LKL002 | Lupa Password (OTP email/WA) | 2026-04-15 / 1.0.0 | link di `/login` | BELUM DICEK | `/login` redirect ke `/monitoring` selama sesi aktif — cek di sesi tanpa login. Butuh OTP nyata — hanya bisa test sampai form kirim OTP, jangan spam |
| LKL003 | Master Provinsi | 2026-04-15 / 1.0.0 | `/master/provinsi` | SESUAI | Tambah/Filter/Riwayat/Edit(modal)/Hapus terlihat |
| LKL004 | Master Kota | 2026-04-15 / 1.0.0 | `/master/kota` | SESUAI | — |
| LKL005 | Master Kecamatan | 2026-04-16 / 1.0.0 | `/master/kecamatan` | SESUAI | — |
| LKL006 | Master Kelurahan (Kode Pos) | 2026-04-15 / 1.0.0 | `/master/kelurahan` | SESUAI | — |
| LKL007 | Master Customer | 2026-04-18 / 1.0.0 | `/master/customer` | SESUAI | — |
| LKL008 | Master Bandara | 2026-04-18 / 1.0.0 | `/master/bandara` | SESUAI | — |
| LKL009 | Master Drop Point | 2026-04-20 / 1.0.0 | `/master/drop-point` | SESUAI | — |
| LKL010 | Master Jenis Armada | — / — | tab "Jenis Armada" di `/master/unit` | BERBEDA | Spec = menu Master sendiri; app = tab dalam Unit & Sopir. Spec belum ditandai selesai |
| LKL011 | Shipment FTL normal | — / — | `/shipment`, `/shipment/buat` | SESUAI (route) | Buat = wizard 4 step (Data Pengiriman → Data Barang → Kalkulasi Harga → Review), FTL default; field step 1 berbeda total per jenis pengiriman. Edit = single-page accordion (bukan wizard). 64 rule, spec belum ditandai selesai. Selector: `shared/selector-map-shipment.md` |
| LKL012 | Shipment FTL multipickup | 2026-04-20 / 1.0.0 | `/shipment/buat` | BELUM DICEK | Varian form |
| LKL013 | Shipment FTL multidrop | 2026-04-22 / 1.0.0 | `/shipment/buat` | BELUM DICEK | Varian form |
| LKL014 | Shipment FTL multipickup+multidrop | — / — | `/shipment/buat` | BELUM DICEK | 84 rule, spec belum ditandai selesai |
| LKL015 | Detail & Edit Shipment FTL | 2026-04-22 / 1.0.0 | aksi Detail/Edit di `/shipment` | SESUAI (aksi) | Edit/Hapus disabled untuk status "Terkirim" (business rule, cek di spec LKL015/060) |
| LKL016 | Master Estimasi Waktu | "ada perubahan" / 1.0.0 | tab "Waktu Tempuh" di `/master/tarif` (Master Rute) | BERBEDA | Spec: menu "Master Estimasi Waktu" di Master; app: tab di Master Rute, nama beda. Spec sendiri menandai "ada perubahan" |
| LKL017 | Master Pelabuhan | — / — | `/master/pelabuhan` | SESUAI | Spec belum ditandai selesai |
| LKL018 | Master Pelayaran | — / — | `/master/pelayaran` | SESUAI | Spec belum ditandai selesai |
| LKL019 | Shipment LTL | 04-27, 05-18 / 1.0.0 | `/shipment` (jenis LTL) | SESUAI (route) | Direvisi 2x. Aksi baris LTL Draf: Detail/Edit/Hapus/Proses Invoice[disabled]/Tambah Biaya/Riwayat Perubahan (tanpa Buat Order) |
| LKL020 | Shipment LCL | 2026-04-28 / 1.0.0 | `/shipment` (jenis LCL) | SESUAI (route) | Opsi LCL ada di filter jenis; form belum dicek |
| LKL021 | Shipment Air Freight | 2026-04-29 / 1.0.0 | `/shipment` (jenis Air Freight) | SESUAI (route) | Opsi ada di filter jenis; form belum dicek |
| LKL022 | Batch Shipment (import template) | 2026-05-13 / 1.0.0 | tombol "Batch Shipment" → `/shipment/batch` (route penuh, bukan modal): download template, area upload, tombol | SESUAI | Dipetakan SCR-12 di selector-map-shipment (tanpa upload). Di hak akses (LKL060) masuk grup "System" |
| LKL023 | Master Tarif – Konversi Muatan | 2026-05-04 / 1.0.0 | tab "Konversi Muatan" di `/master/tarif` | SESUAI | — |
| LKL024 | Master Tarif – Tarif Pengiriman | 2026-05-05 / 1.0.0 | tab "Tarif Pengiriman" di `/master/tarif` | SESUAI | — |
| LKL025 | Order LTL | 2026-05-06 / 1.0.0 | `/order`, `/order/buat` (jenis LTL) | SESUAI | `/order/buat` = pilih shipment draft existing (`name="shipment-picker"`) + field per jenis; LTL punya field kota transit. Selector: `shared/selector-map-order.md` SCR-04 |
| LKL026 | Order LCL | — / — | `/order/buat` (jenis LCL) | SESUAI (form) | Field jadwal kapal lengkap (direct/connecting) terkonfirmasi di form; spec belum ditandai selesai. SCR-04 selector-map-order |
| LKL027 | Order Air Freight | — / — | `/order/buat` (jenis Air Freight) | SESUAI (form) | Field jadwal penerbangan/drop point bandara terkonfirmasi di form; spec belum ditandai selesai. SCR-04 selector-map-order |
| LKL028 | Order FTL | — / — | `/order/buat` (jenis FTL) atau `/order/buat?shipmentId={uuid}` dari kebab shipment | BERBEDA (flow) | Flow diganti LKL056: order FTL dibuat dari shipment (Tanggal Permintaan Muat wajib; Jenis/Jumlah Armada diturunkan dari shipment), bukan form order independen. Status order: Draf → Ditugaskan → Proses Pengiriman → Selesai / Dibatalkan |
| LKL029 | Penugasan Tracking | 2026-05-06 / 1.0.0 | `/penugasan-tracking` | SESUAI | Aksi baris Belum Berangkat: Detail/Edit Penugasan/Isi Data Tracking/Isi Kendala/Alihkan Armada/Riwayat Perubahan; Selesai: Detail/Edit Armada/Riwayat Perubahan |
| LKL030 | Master Unit (armada + jenis kontainer) | 2026-05-04 / 1.0.0 | tab Armada & Jenis Kontainer di `/master/unit` | SESUAI | — |
| LKL031 | Master Sopir | 2026-05-05 / 1.0.0 | tab "Sopir" di `/master/unit` | BERBEDA (struktur) | Digabung ke satu menu "Unit & Sopir" |
| LKL032 | Public tracking (user umum, tanpa login) | 2026-05-05 / 1.0.0 | tidak ada di sidebar | BELUM DICEK | Butuh URL publik — tanya user (jangan tebak URL) |
| LKL033 | Monitoring & Tracking Location | 2026-05-07 / 1.0.0 | `/monitoring`, `/tracking-location`, `/monitoring/riwayat` | SESUAI | Panel "Data Kasus" (badge Tidak Update / Melewati SLA, tombol Lihat/Lacak) = list critical issue. Link "Riwayat" → Riwayat Kasus (541 data) |
| LKL034 | Master Bank | 2026-05-07 / 1.0.0 | `/master/bank` (label menu "Rekening") | BERBEDA (nama) | Digantikan LKL059 |
| LKL035 | Master Maskapai | 2026-05-07 / 1.0.0 | `/master/maskapai` | SESUAI | — |
| LKL036 | Buat Invoice (jasa pengiriman + tambahan) | 2026-05-07 / 1.0.0 | aksi "Proses Invoice" per baris `/shipment` → landing page Proses Invoice dengan 2 tombol "Buat Invoice …"; tombol "+ Buat Invoice" di `/monitoring-invoice` | SESUAI | Enabled untuk semua status kecuali Draf (tooltip: "Shipment belum di tugaskan"). Form di balik tombol "Buat Invoice …" belum dibuka (submit-like). SCR-15 di selector-map-shipment |
| LKL037 | Klaim Asuransi | 2026-05-07 / 1.0.0 | aksi "Klaim Asuransi" di `/shipment` (terlihat pada baris Terkirim saat explore pertama; tidak ada pada Draf) | SESUAI (aksi) | "History data asuransi" belum dicek |
| LKL038 | Manajemen Invoice (Monitoring + Laporan Invoice) | 05-08, 05-19 / 1.0.0 | `/monitoring-invoice` | BERBEDA | Submenu "Laporan Invoice" TIDAK ada; `/laporan-keuangan` adalah laporan laba/margin per shipment (fitur lain, tanpa ID spec). Riwayat (audit trail) di Monitoring Invoice TIDAK DITEMUKAN — lihat LKL041 |
| LKL039 | Pengaturan Akun | 2026-05-08 / 1.0.0 | `/pengaturan-akun` | SESUAI | Digantikan LKL060 |
| LKL040 | Cetak Resi (list resi; cetak semua/multiple/satuan) | 2026-05-07 / 1.0.0 | aksi "Lihat Resi" di kebab `/shipment` — hanya jenis LTL/LCL/Air Freight (tidak ada di FTL/FCL), membuka tab baru `blob:` | BERBEDA (nama & bentuk) | Tidak ada halaman list resi / cetak massal; hanya per shipment. Konfirmasi ke user apakah cetak massal memang dihapus |
| LKL041 | Audit Trail (riwayat perubahan/penghapusan/pembatalan) | 2026-05-11 / 1.0.0 | Master: tombol "Riwayat"; Shipment: aksi "Riwayat Perubahan" + `/shipment/riwayat-penghapusan`; Order: aksi "Riwayat Perubahan" + "Riwayat Pembatalan"; Penugasan: aksi "Riwayat Perubahan"; Akun Saya: `/akun-saya/riwayat` (tab Edit Akun Saya / Ubah Password); Sub User & Hak Akses: tombol "Riwayat"; Monitoring: `/monitoring/riwayat` (Riwayat Kasus) | SESUAI (hampir semua) | **Kecuali Monitoring Invoice**: tidak ada "Riwayat" di aksi baris (Lihat/Download/Hapus) maupun level halaman (hanya "Riwayat Penghapusan") → rule 0411–0412 TIDAK DITEMUKAN. Di hak akses, Audit Trail masuk grup "System" |
| LKL042 | Profil akun sendiri (edit profil, ubah password) | 2026-05-08 / — | `/akun-saya` (tombol Edit Profil, Ubah Password, Riwayat) | SESUAI | — |
| LKL043 | Penyesuaian APK Tracking | 2026-05-12 / 1.0.0 | link "Unduh Apk" di `/penugasan-tracking` | DI LUAR SCOPE | Aplikasi mobile sopir |
| LKL044 | Notifikasi Center (global, preferensi, push, email) | 2026-05-13 / 1.0.0 | `/setting/general`, `/setting/preferensi-notifikasi`, bel notifikasi (badge 79) | SESUAI | Push/email tidak bisa diverifikasi otomatis. Form hak akses punya 17 toggle notifikasi |
| LKL045 | Halaman tambahan: maintenance, 404, error, error load data, subscription kadaluwarsa | 2026-05-13 / 1.0.0 | 404: URL acak → HTTP 404, full-page tanpa sidebar/header, judul "Oops! Halaman Tidak Tersedia", tombol "Kembali ke Beranda" (`href="/"` → `/monitoring`) | SESUAI (404) | Maintenance/error/error-load/subscription tidak bisa dipicu dari sisi test |
| LKL046 | Master Kemasan | 2026-05-19 / 1.0.0 | `/master/kemasan` | SESUAI | — |
| LKL047 | Proses Surat Jalan (buat, upload, preview, cetak) | 2026-05-20 / 1.0.0 | aksi "Proses Surat Jalan" pada baris `/order` status Ditugaskan / Proses Pengiriman / Selesai → `/order/{id}/proses-surat-jalan`, tombol buat → `/order/{id}/proses-surat-jalan/buat` | SESUAI (dengan tambahan) | Bukan di Penugasan Tracking. Alur "Buat Surat Jalan" diawali step **Konfirmasi Profil** (data perusahaan) yang tidak ada di spec. Di hak akses masuk grup Tracking & Monitoring. SCR-10 selector-map-order |
| LKL048 | Dashboard Operasional | 2026-06-04 / 1.0.0 | `/dashboard-operasional` | SESUAI | Ada skill `/qa-dashboard` untuk modul ini |
| LKL049 | Buat Invoice Tiap Periode (tab Per Shipment / Per Periode, TOP customer) | 2026-06-15 / 2.0.0 | `/monitoring-invoice`: tab "Invoice Per Shipment" (default) & "Invoice Per Periode"; tombol + Buat Invoice, Filter, Export, Riwayat Penghapusan, Pengaturan | SESUAI | Aksi baris: Lihat Invoice / Download Invoice / Hapus |
| LKL050 | Shipment FCL (normal/multipickup/multidrop/multipoint) | 2026-06-17 / 2.0.0 | `/shipment` filter jenis: "FCL - Full Container Load" | SESUAI (opsi) | Form FCL belum dicek |
| LKL051 | Order FCL (kapal direct/connecting) | 2026-06-17 / 2.0.0 | `/order/buat` (jenis FCL): radio Direct/Connecting (`#fcl-jadwal-direct` / `#fcl-jadwal-connecting`), Detail Kapal Utama (Pelayaran, Nama Kapal, Voyage, Closing Time, ETD, ETA), blok Kapal Connecting | SESUAI | Field tanggal+jam memakai datetime picker custom (bukan flatpickr) yang tidak auto-close. SCR-04 selector-map-order |
| LKL052 | Penugasan FCL | 2026-06-17 / 2.0.0 | `/penugasan-tracking` | BELUM DICEK | — |
| LKL054 | Penggunaan Kuota Berlangganan (bar di sidebar bawah) | — / — | sidebar bawah: "Kuota Shipment: 12/500" + "2,4%", di atas teks versi "PRAHU HUB - Versi 26.06.08.2" | SESUAI | Saat loading awal sempat tampil 0/0 (0%) — transien |
| LKL056 | Penggabungan form Shipment + Order (FTL/FCL) | 2026-07-16 / 1.0.3 | aksi "Buat Order" hanya pada baris shipment FTL/FCL Draf (tidak ada di LTL) → `/order/buat?shipmentId={uuid}` (Form Order Lanjutan, shipment prefilled; klik hanya GET, terverifikasi network log); `/order/buat` = pilih shipment existing | SESUAI (sebagian) | Label tombol step 4 ("Simpan & Lanjut ke Order" / "Simpan Shipment") belum bisa dilihat tanpa mengisi form Buat; halaman Edit bukan wizard (tidak ada section Review) sehingga tidak bisa dipakai untuk mengintip. Shipment & order tetap entitas terpisah (sesuai spec) |
| LKL059 | Master Rekening (tab rekening; tambah/edit/hapus) | 2026-08-14 / 1.0.5 | `/master/bank` label "Rekening" | SESUAI | Menggantikan LKL034 |
| LKL060 | Update Pengaturan Akun (hak akses = template bernama, level Akses Penuh/Lihat Saja/Tidak Ada, jenis pengiriman, prasyarat antar modul) | 2026-08-20 / 1.0.5 | `/pengaturan-akun` tab Sub User (+ Tambah Sub User, Riwayat, Filter) / Hak Akses (Riwayat, Filter). Form Edit Hak Akses: shortcut "Terapkan Cepat ke Semua Modul", checkbox jenis pengiriman FTL/LTL/FCL/LCL/Air Freight, tree modul | SESUAI (struktur) | **BERBEDA/TIDAK DITEMUKAN**: tab Hak Akses tidak punya tombol tambah hak akses (spec rule 8: "terdapat tombol tambah hak akses langsung dari tab ini"). Aksi baris = 3 ikon (lihat/edit/hapus), bukan dropdown Aksi |

Nomor yang tidak ada di sheet: LKL053, LKL055, LKL057, LKL058 (kemungkinan dihapus/dipindah — tanyakan ke user bila perlu).

## Fitur di aplikasi yang TIDAK punya ID spec sendiri

| Fitur di app | Route / lokasi | Sumber terdekat di spec | Implikasi |
|---|---|---|---|
| Otomasi Jalur (wizard 4 langkah) | `/otomasi-jalur` | Hanya disebut di LKL060 (grup Tracking & Monitoring; prasyarat: Penugasan Tracking ≥ Lihat Saja) | Tidak ada REQ — dokumen skenario harus disusun dari inventaris UI |
| Laporan Keuangan (laba/margin per shipment) | `/laporan-keuangan` — kartu Total Bruto / Laba Bruto / Laba Netto / Persentase Rata-rata; tab per jenis pengiriman; tabel per shipment; catatan "Isi data harga dasar untuk mengetahui laba dan margin" | Hanya disebut di LKL060 (grup Finance). BUKAN "Laporan Invoice" LKL038 | Tidak ada REQ |
| Tambah Biaya (HPP) | Dua fitur bernama sama: (a) tombol inline "Tambah Biaya" di section Kalkulasi Harga halaman Edit; (b) aksi kebab "Tambah Biaya" → halaman penuh "Tambah Biaya (HPP)", hanya aktif pada status Proses Pengiriman — status lain menampilkan overlay "Fitur belum dapat digunakan" | Hanya disebut di LKL060 (grup Finance "Tambah Biaya HPP Shipment" + izin tambahan) | Tidak ada REQ |
| Riwayat Kasus | `/monitoring/riwayat` | LKL041 rule 0412a–b | Ada REQ (audit trail) |
| Riwayat Penghapusan Invoice | tombol "Riwayat Penghapusan" di `/monitoring-invoice` | Tidak ada di LKL041 (spec hanya menyebut riwayat status Lunas) | Tanpa REQ |
| Riwayat Penghapusan Shipment sebagai route sendiri | `/shipment/riwayat-penghapusan` | LKL041 | Sesuai spec (tombol sejajar filter) |
| Panduan (link eksternal) | guide-tms.prahu-hub.com | — | Di luar scope |

## Peta modul resmi menurut form Hak Akses di app (LKL060, diverifikasi 2026-09-08)

Berguna sebagai pengelompokan modul untuk `scenario/<modul>/`:
- Item langsung: **Shipment**, **Order**
- Tracking & Monitoring: **Penugasan Tracking**, **Otomasi Jalur**, **Proses Surat Jalan**
- Dashboard: **Dashboard Monitoring**, **Dashboard Tracking & Location**, **Dashboard Operasional**
- Finance: **Manajemen Invoice**, **Klaim Asuransi**, **Tambah Biaya HPP Shipment**, **Laporan Keuangan**
- Master Data: **Master Wilayah**, **Master Operasional**, **Master Data Tarif**
- Pengaturan Akun: **Sub User**, **Hak Akses**
- Pusat Notifikasi: 2 item (Pengaturan Notifikasi, Preferensi Notifikasi)
- System: **Audit Trail**, **Batch Shipment**
- Jenis pengiriman (checkbox multi-select, berlaku lintas modul): FTL, LTL, FCL, LCL, Air Freight
- Notifikasi: 17 toggle

(Perbedaan vs teks spec LKL060: app menambah "Proses Surat Jalan" di Tracking & Monitoring, "Laporan Keuangan" di Finance, dan grup "Pusat Notifikasi" + "System".)

## Sisa yang belum bisa dicek (butuh input user / aksi tulis)

1. **URL public tracking** (LKL032) — minta ke user; jangan tebak.
2. **Lupa Password** (LKL002) — cek link di `/login` pada sesi tanpa login (mis. context Playwright baru, sekaligus kesempatan verifikasi H2).
3. **Label tombol step 4 Buat Shipment** (LKL056) — hanya terlihat setelah mengisi step 1–3 form Buat (Edit bukan wizard); cek saat menulis skenario Shipment dengan data `AUTOTEST-` (tanpa menyimpan).
4. **Form di balik "Buat Invoice …"** pada landing Proses Invoice (LKL036) — submit-like, belum dibuka.
5. **Cetak Resi massal** (LKL040) — app hanya punya "Lihat Resi" per shipment (LTL/LCL/AF); konfirmasi ke user apakah list/cetak massal memang dihapus.
6. **Riwayat di Monitoring Invoice** (LKL041 rule 0411–0412) — tidak ditemukan; konfirmasi ke user apakah memang belum diimplementasi (gap) atau dipindah.
7. **Tombol tambah Hak Akses** (LKL060 rule 8) — tidak ditemukan di tab Hak Akses; konfirmasi ke user (mungkin hanya lewat form Tambah Sub User → "buat hak akses baru").

Selector yang sudah dipanen: area shipment (SCR-01..16) → `shared/selector-map-shipment.md` (2026-09-08); area order (SCR-01..11) → `shared/selector-map-order.md` (2026-09-09).
