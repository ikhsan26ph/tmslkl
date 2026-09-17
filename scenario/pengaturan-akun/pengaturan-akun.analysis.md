# Analysis — pengaturan-akun

## Requirements

Sumber: `inputs/pengaturan-akun/spec.txt`. REQ berikut mengelompokkan seluruh aturan menjadi perilaku yang dapat diuji.

| ID | Area | Aturan / acceptance criteria |
|---|---|---|
| REQ-001 | Navigasi dan otorisasi | Dua tab Sub User (default) dan Hak Akses; Admin Utama maupun sub user Pengaturan Akun Akses Penuh dapat mengelola keduanya. |
| REQ-002 | Template bersama | Template hak akses bernama dapat digunakan banyak sub user; daftar Sub User menampilkan nama template. |
| REQ-003 | Daftar Sub User | Aksi Lihat Detail, Edit, Hapus dan + Tambah Sub User; Terapkan memfilter, Reset memulihkan default. |
| REQ-004 | Paginasi Sub User | Default 20 data; ukuran halaman dapat diubah; perpindahan halaman/ukuran tanpa loading state. |
| REQ-005 | Informasi Umum Sub User | Nama Sub User, Email, Nomor WhatsApp, Bagian Staff, Password, Konfirmasi Password wajib; email valid dan WhatsApp angka; status tambah otomatis Aktif. |
| REQ-006 | Keunikan Sub User | Email dan Nomor WhatsApp tidak duplikat; edit tanpa mengubah nilai milik sendiri tetap valid. |
| REQ-007 | Password Sub User | Password dan Konfirmasi Password wajib; toggle show/hide; edit password default tersembunyi. |
| REQ-008 | Pilih template | Dropdown Pilih Hak Akses memuat template tersedia; preview seluruh hak akses read-only. |
| REQ-009 | Template dari Sub User | Buat Hak Akses dari form Sub User mengikuti seluruh aturan template. |
| REQ-010 | Konfirmasi Sub User | Batal dan Simpan pada form Sub User disertai konfirmasi. |
| REQ-011 | Edit Sub User | Data terakhir tersimpan terisi; dropdown Status Aktif/Tidak Aktif; perubahan akses berlaku pada login berikutnya. |
| REQ-012 | Batas delegasi | Sub user tidak boleh mengubah hak akses sendiri atau memberikan level/izin yang tidak dimilikinya. |
| REQ-013 | Detail Sub User | Seluruh Informasi Umum dan Hak Akses read-only; tree dapat di-minimize per kategori. |
| REQ-014 | Daftar Hak Akses | Tambah, Lihat Detail, Edit, Hapus; filter Nama Hak Akses dan Status; Terapkan dan Reset. |
| REQ-015 | Paginasi Hak Akses | Default 20 data; ukuran dapat diubah; ganti halaman/ukuran tanpa loading state. |
| REQ-016 | Identitas Hak Akses | Nama Hak Akses wajib text dan unik; Deskripsi opsional textarea; aturan edit sama dengan tambah. |
| REQ-017 | Ringkasan Hak Akses | Daftar dan detail memuat jumlah modul setiap level, notifikasi aktif, izin tambahan aktif, dan sub user pemakai. |
| REQ-018 | Detail Hak Akses | Informasi Umum, Tanggal Buat, Tanggal Diperbarui, Total Sub User dan ringkasan; tree read-only dapat di-minimize. |
| REQ-019 | Edit template bersama | Perubahan berlaku bagi seluruh pengguna template; konfirmasi simpan menyebut jumlah terdampak. |
| REQ-020 | Shortcut level | Terapkan Cepat ke Semua Modul: Akses Penuh/Lihat Saja/Tidak Ada Akses; bisa diubah manual; modul dua level disesuaikan; tidak menyalakan izin tambahan. |
| REQ-021 | Semantik level | Akses Penuh CRUD tunduk batas edit; Lihat Saja hanya lihat/cari/filter/export; Tidak Ada Akses menyembunyikan menu/data dashboard/pencarian/notifikasi serta URL 403. |
| REQ-022 | Struktur tree | Shipment dan Order langsung; 6 kategori dan 16 modul sesuai spec; Dashboard (3) dan Otomasi Jalur hanya dua level; tidak ada Cakupan Data/kepemilikan. |
| REQ-023 | Jenis Pengiriman | FTL/LTL/FCL/LCL/Airfreight multi-select independen di atas form; minimal satu; berlaku Shipment, Order, Penugasan Tracking, Dashboard dan Finance. |
| REQ-024 | Isolasi Jenis Pengiriman | Jenis tak dipilih tidak tampil di daftar, dashboard, pencarian, export, notifikasi; bukan dibatasi pemilik data. |
| REQ-025 | Prasyarat Shipment | Invoice, Klaim Asuransi, Tambah Biaya HPP Shipment, Penugasan Tracking minimal Lihat Saja memerlukan Shipment minimal Lihat Saja. |
| REQ-026 | Prasyarat Otomasi | Otomasi Jalur Akses Penuh memerlukan Penugasan Tracking minimal Lihat Saja; berlaku juga prasyarat transitif Shipment. |
| REQ-027 | Penanganan prasyarat | Pelanggaran memblokir simpan; peringatan inline menyebut prasyarat dan minimum; Sesuaikan Otomatis menaikkan prasyarat ke Lihat Saja; kartu izin ditahan. |
| REQ-028 | Siklus izin tambahan | Izin terpisah dari level, tampil hanya Akses Penuh; default mati; turun level mengosongkan dan menyimpan mati; naik lagi tetap mati termasuk shortcut. |
| REQ-029 | Override Shipment dan Tracking | Harga Pengiriman dan Nomor Polisi mengizinkan perubahan di luar batas edit pada field tersebut saja; field lain tetap tunduk batas termasuk Admin Utama. |
| REQ-030 | Invoice per Shipment | Buat Invoice per Shipment mengontrol tombol Buat Invoice dan aksi Proses Invoice di Shipment. |
| REQ-031 | Invoice per Periode | Izin per Periode membuat invoice gabungan satu customer dalam rentang tanggal; kombinasi izin menentukan jalur pembuatan. |
| REQ-032 | Invoice berulang | Pembuatan Invoice Berulang perlu minimal satu izin pembuatan; hanya tipe diizinkan dan tunduk batas maksimal invoice. |
| REQ-033 | Pengaturan batas invoice | Izin terpisah Akses Pengaturan Batas Invoice menentukan tombol Pengaturan dan akses ubah batas global; Akses Penuh saja tidak cukup. |
| REQ-034 | Alasan dan audit override | Perubahan menggunakan izin tambahan wajib alasan dan tercatat dalam riwayat data terkait. |
| REQ-035 | Aksi lintas modul | Di Shipment: Cetak Resi mengikuti Shipment >= Lihat Saja; Klaim mengikuti Klaim Akses Penuh; Proses Invoice mengikuti Invoice Akses Penuh + per Shipment; HPP mengikuti HPP Akses Penuh; Ubah/Hapus mengikuti Shipment Akses Penuh. |
| REQ-036 | State pembatasan edit | Aksi tanpa hak disembunyikan; aksi dengan hak tetapi terkunci aturan data disabled dengan alasan; field terkunci read-only dan alasan, tetap terlihat. |
| REQ-037 | Dashboard | Tidak ada hak per widget; widget mengikuti akses modul sumber dan Jenis Pengiriman; sumber Tidak Ada Akses tidak dirender. |
| REQ-038 | Penegakan backend | Backend memeriksa semua aturan kembali saat request dieksekusi, termasuk request dari form yang sudah dibuka. |
| REQ-039 | Daftar notifikasi | Lupa Password/Ubah Password tidak ada; Kapal Sandar/Berlayar hanya bila FCL atau LCL dipilih. |
| REQ-040 | Prasyarat notifikasi | Shipment perlu Shipment >= Lihat Saja; tahap pengiriman perlu Penugasan Tracking >= Lihat Saja; tiga kendala armada perlu Dashboard Monitoring Akses Penuh; invoice perlu Manajemen Invoice >= Lihat Saja. |
| REQ-041 | Pengiriman notifikasi | Notifikasi hanya dikirim untuk modul minimal Lihat Saja dan Jenis Pengiriman diizinkan. |
| REQ-042 | Default template | Lima jenis dicentang, seluruh modul Akses Penuh, seluruh notifikasi tersedia aktif, seluruh izin tambahan mati. |
| REQ-043 | Hapus template | Template yang masih dipakai minimal satu Sub User tidak dapat dihapus. |
| REQ-044 | Konfirmasi izin tambahan | Simpan hak akses yang memberikan izin tambahan menampilkan konfirmasi daftar izin yang diberikan. |
| REQ-045 | Audit hak akses | Perubahan hak akses merekam pelaku, waktu, nilai sebelum dan sesudah. |

### Aktor dan alur

Admin Utama dan sub user dengan Pengaturan Akun Akses Penuh mengelola daftar → tambah/edit → konfirmasi → simpan → detail. Sub user Lihat Saja hanya membaca; Tidak Ada Akses ditolak. Template dapat dipilih atau dibuat inline, lalu digunakan ulang. Akses individu berubah pada login berikutnya.

### Validasi

Mandatory: enam field informasi umum, nama hak akses, minimal satu jenis pengiriman. Email berformat email, WhatsApp hanya angka; email, WhatsApp dan nama template unik. Seluruh kombinasi level, prasyarat, izin tambahan dan batas delegasi diverifikasi pada simpan. Tidak ada min/max panjang yang ditetapkan spec.

## UI Inventory

Seluruh enam PNG telah dibuka dan diperiksa. Semuanya adalah **Detail Hak Akses**, bukan form tambah/edit. Kontrol form dan daftar berikut diturunkan dari spec; placeholder, DOM dan state error/loading tidak terlihat pada PNG. Badge detail bukan input interaktif. Selector harus di-scope ke baris modul/kategori atau baris record agar nama berulang tidak ambigu.

### Detail Hak Akses — bukti enam PNG

| File (di inputs/pengaturan-akun/designs/) | Profil | Sub user | Badge Penuh / Lihat / Tidak / Notifikasi |
|---|---|---:|---|
| case-live-full-akses.png | Direksi | 2 | 20 / 0 / 0 / 17 |
| case-live-accounting-pt-lintas-karya-logistik.png | Accounting | 1 | 7 / 12 / 1 / 2 |
| case-live-admin-keuangan-pt-lintas-karya-logistik.png | Admin Keuangan | 3 | 7 / 12 / 1 / 2 |
| case-live-admin-operasional-pt-lintas-karya-logistik.png | Admin Operasional | 1 | 11 / 6 / 3 / 0 |
| case-live-fleet-operasional-pt-lintas-karya-logistik.png | Fleet Operasional | 1 | 3 / 2 / 15 / 0 |
| case-live-monitoring-operasional-pt-lintas-karya-logistik.png | Monitoring Operasional | 3 | 15 / 0 / 5 / 17 |

Terlihat: breadcrumb Beranda → Pengaturan Akun → Detail Hak Akses; tombol Kembali; panel Informasi Umum (Nama Hak Akses, Deskripsi, Tanggal Buat, Tanggal Diperbarui, Total Sub User, Total Akses); chip lima jenis pengiriman; badge level; kategori terbuka dengan chevron; Notifikasi berstatus On/Off. Tidak tampak error, empty, loading, dialog, kartu izin tambahan atau ringkasan jumlah izin tambahan.

| Elemen | role + name usulan | testid usulan | Label / state |
|---|---|---|---|
| Judul | heading, Detail Hak Akses | detail-hak-akses-title | Terlihat |
| Kembali | button, Kembali | kembali | Navigasi daftar |
| Informasi umum | region, Informasi Umum | informasi-umum | Read-only; label sesuai panel |
| Total Akses | status, Total Akses | total-akses | Hitungan seluruh level, notifikasi, izin tambahan |
| Total Sub User | status, Total Sub User | total-sub-user | Jumlah pemakai |
| Tree | tree, Hak Akses | hak-akses-tree | Read-only |
| Header kategori | button, nama kategori | kategori-{slug} | aria-expanded usulan |
| Baris modul | row, nama modul | modul-{slug} | Badge level, scope selector |
| Jenis Pengiriman | group, Jenis Pengiriman | jenis-pengiriman | Chip read-only di detail |
| Baris notifikasi | row, nama notifikasi | notifikasi-{slug} | Badge On/Off |

### Sub User dan Hak Akses — daftar (diturunkan dari spec)

| Elemen | role + name usulan | testid usulan | Label / tipe |
|---|---|---|---|
| Menu | link, Pengaturan Akun | menu-pengaturan-akun | Aktif pada PNG |
| Tab | tab, Sub User / Hak Akses | tab-sub-user / tab-hak-akses | Sub User default |
| Tambah | button, + Tambah Sub User / Tambah Hak Akses | tambah-sub-user / tambah-hak-akses | Tombol |
| Filter nama | textbox, Nama Sub User / Nama Hak Akses | filter-nama | Text; nama filter Sub User asumsi |
| Filter Status | combobox, Status | filter-status | Hak Akses: domain belum ditetapkan |
| Terapkan / Reset | button, Terapkan / Reset | terapkan / reset | Tombol filter |
| Tabel | table, Sub User / Hak Akses | tabel-sub-user / tabel-hak-akses | Scope ke record fixture |
| Aksi baris | button, Lihat Detail / Edit / Hapus | lihat-detail / edit / hapus | Scope record wajib |
| Ukuran halaman | combobox, Data per halaman | page-size | Default 20 |
| Paginasi | button, Halaman berikutnya / Halaman sebelumnya | next-page / previous-page | Tanpa loading saat perubahan |

### Tambah / Edit Sub User (diturunkan dari spec)

| Elemen | role + name usulan | testid usulan | Label / tipe |
|---|---|---|---|
| Nama Sub User | textbox, Nama Sub User | nama-sub-user | Wajib, text |
| Email | textbox, Email | email | Wajib, email |
| Nomor WhatsApp | textbox, Nomor WhatsApp | nomor-whatsapp | Wajib, angka; pertahankan nol depan |
| Bagian Staff | combobox, Bagian Staff | bagian-staff | Wajib; jenis kontrol asumsi |
| Password / Konfirmasi Password | getByLabel untuk masing-masing | password / konfirmasi-password | Wajib, type=password; role textbox tidak andal untuk password |
| Ikon mata | button, Tampilkan Password / Tampilkan Konfirmasi Password | toggle-password / toggle-konfirmasi-password | Show/hide, nama aksesibel usulan |
| Status (edit) | combobox, Status | status | Aktif / Tidak Aktif |
| Pilih Hak Akses / Buat Hak Akses | radio, label terkait | pilih-hak-akses / buat-hak-akses | Pilihan mode; click jika radio |
| Template | combobox, Hak Akses | template-hak-akses | Preview read-only |
| Batal / Simpan | button, Batal / Simpan | batal / simpan | Memunculkan konfirmasi |
| Dialog konfirmasi | dialog, Konfirmasi | konfirmasi | Tombol Konfirmasi / Kembali ke Form diasumsikan |

### Detail Sub User (diturunkan dari spec)

Informasi Umum dan tree mengikuti detail template; seluruh nilai read-only, enam kategori dapat collapse/expand, tombol Kembali diasumsikan. Password tidak diuji sebagai plaintext tersimpan (AS-10).

### Tambah / Edit Hak Akses dan form inline (diturunkan dari spec)

| Elemen | role + name usulan | testid usulan | Label / tipe |
|---|---|---|---|
| Nama Hak Akses | textbox, Nama Hak Akses | nama-hak-akses | Wajib text unik |
| Deskripsi | textbox, Deskripsi | deskripsi | Textarea opsional |
| Jenis | checkbox, FTL / LTL / FCL / LCL / Airfreight | jenis-{slug} | Lima pilihan independen |
| Shortcut | combobox, Terapkan Cepat ke Semua Modul | terapkan-cepat | Tiga level; tipe kontrol asumsi |
| Level modul | combobox, nama modul | level-{slug} | 3 pilihan; Dashboard dan Otomasi 2 |
| Prasyarat inline | alert, Prasyarat {modul} | prasyarat-{slug} | Sebut modul dan minimum |
| Perbaikan | button, Sesuaikan Otomatis | sesuaikan-{slug} | Scope ke modul bermasalah |
| Izin tambahan | checkbox, nama izin | izin-{slug} | Toggle diasumsikan checkbox; gunakan switch+click bila DOM switch |
| Alasan | textbox, Alasan | alasan | Pada aksi override modul tujuan |
| Simpan | button, Simpan | simpan | Konfirmasi jumlah terdampak dan daftar izin |

Tree spec: Shipment; Order; **Tracking & Monitoring** (Penugasan Tracking, Otomasi Jalur); **Dashboard** (Dashboard Monitoring, Dashboard Tracking & Location, Dashboard Operasional); **Finance** (Manajemen Invoice, Klaim Asuransi, Tambah Biaya HPP Shipment); **Master Data** (Master Wilayah, Master Operasional, Master Data Tarif); **Pengaturan Akun** (Sub User & Hak Akses); **Pusat Notifikasi** (Pengaturan Notifikasi, Preferensi Notifikasi).

Enam izin: Harga Pengiriman; Nomor Polisi; Pembuatan Invoice Berulang; Buat Invoice per Shipment; Buat Invoice per Periode; Akses Pengaturan Batas Invoice (section terpisah).

17 label notifikasi terlihat: Shipment Terkirim; Order Selesai; Order Dibatalkan; Order Telah Ditugaskan; Tahap Pengiriman - Berangkat Muat; Tahap Pengiriman - Selesai Muat; Tahap Pengiriman - Kapal Sandar; Tahap Pengiriman - Kapal Berlayar; Tahap Pengiriman - Dooring; Tahap Pengiriman - Berangkat Bongkar; Tahap Pengiriman - Selesai Bongkar; Tahap Pengiriman - Alihkan Armada/Petugas; Terjadi Kendala Armada; Armada Tidak Update; Armada Melewati Estimasi Waktu; Invoice Telah Dibuat; Reminder Invoice Jatuh Tempo.

### Layar integrasi (diturunkan dari spec)

Daftar Shipment: Cetak Resi, Ajukan Klaim Asuransi, Proses Invoice, Tambah Biaya HPP, Ubah, Hapus (button, scope record). Manajemen Invoice: Buat Invoice, Pengaturan; form tipe Shipment/Periode. Penugasan Tracking: Nomor Polisi; Shipment: Harga Pengiriman; keduanya Alasan dan Riwayat. Dashboard: widget per sumber; Pusat Notifikasi: daftar/event. Hak pada layar ini diuji menggunakan fixture status dan batas edit dari modul terkait; spec ini tidak menentukan status mana yang terkunci.

## Assumptions Log

- AS-01 — PNG adalah referensi visual; spesifikasi teks menjadi acuan jika berbeda. Tautan artefak Claude pada spec tidak digunakan karena enam PNG lokal tersedia.
- AS-02 — Tidak ada extras. URL aplikasi, kontrak API, locator DOM, kredensial dan fixture belum diberikan; route/selector data-testid merupakan usulan yang perlu dipetakan saat codegen.
- AS-03 — Shortcut Lihat Saja dipetakan menjadi Akses Penuh pada Dashboard (baca saja) dan Tidak Ada Akses pada Otomasi Jalur (aksi konfigurasi); perlu konfirmasi produk.
- AS-04 — Tracking & Monitoring pada prasyarat notifikasi tahap pengiriman ditafsirkan sebagai Penugasan Tracking. Dashboard Monitoring memakai Akses Penuh karena tidak menyediakan Lihat Saja.
- AS-05 — Konfirmasi Password harus cocok. Panjang/kompleksitas password, panjang field, format internasional WhatsApp, sensitivitas huruf pada duplikasi belum ditentukan; tidak mengarang batas numerik produk.
- AS-06 — Pesan error diuji secara makna, bukan teks persis. Filter Sub User, pilihan ukuran halaman, status template dan perilaku hapus Sub User belum dirinci; fixture memakai filter Nama Sub User dan ukuran 10, status template dipersiapkan dari fixture.
- AS-07 — Perubahan template bersama juga efektif pada login berikutnya. Backend mengevaluasi hak efektif sesi saat eksekusi; pergantian hak database tidak diasumsikan langsung mencabut sesi lama.
- AS-08 — Saat prasyarat notifikasi atau jenis laut dicabut, pengiriman terkait berhenti; cara UI membersihkan/menyimpan toggle tersembunyi belum ditentukan. Invoice Berulang tanpa kedua izin pembuatan harus nonaktif atau simpan ditolak.
- AS-09 — Status Tidak Aktif diasumsikan menolak login berikutnya; pembatalan konfirmasi mempertahankan form; template dari tambah sub user diasumsikan tersimpan bersama sub user hanya setelah konfirmasi.
- AS-10 — Detail read-only tidak mengungkap plaintext password. Toggle password edit diuji dengan nilai yang baru diketik; kewajiban dapat melihat password lama perlu keputusan keamanan/produk tanpa mengasumsikan backend menyimpan plaintext.
- AS-11 — Stress memakai beban fixture eksplisit sebagai profil uji, bukan SLA: 1000 baris, 20 sesi atau pengulangan terukur. Timeout/5xx tidak ditentukan durasinya; oracle integritas, otorisasi dan tidak ada simpan parsial.
- AS-12 — Penolakan request ilegal diperiksa melalui status respons dan data tersimpan tanpa perubahan; 403 diwajibkan untuk URL modul Tidak Ada Akses saja, kode validasi lainnya mengikuti kontrak implementasi.
- AS-13 — Desain mempunyai 20 modul, termasuk Proses Surat Jalan, Laporan Keuangan, Audit Trail dan Batch Shipment serta kategori System yang tidak ada dalam spec. Empat modul tersebut tidak dijadikan requirement; hitungan skenario mengikuti 16 modul spec. Sidebar PNG adalah milik Admin yang memeriksa template, bukan bukti menu efektif pemegang template.
- AS-14 — Desain Monitoring menampilkan notifikasi invoice On walau Invoice Tidak Ada Akses, dan tidak menampilkan ringkasan izin tambahan. Skenario mengikuti prasyarat notifikasi dan ringkasan pada spec, bukan menyalin inkonsistensi PNG.
- AS-15 — Tiga notifikasi Order yang terlihat diasumsikan mengikuti Order minimal Lihat Saja berdasarkan aturan umum modul sumber. Label notifikasi berasal PNG; tipe kontrol, ARIA, placeholder dan nama tombol konfirmasi belum tersedia.
