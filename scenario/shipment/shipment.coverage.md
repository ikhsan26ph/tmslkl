# Coverage — shipment

Review artefak, bukan hasil eksekusi aplikasi atau Playwright.

## Ringkasan

| Kategori | Jumlah |
|---|---:|
| positive | 144 |
| negative | 139 |
| edge | 22 |
| stress | 14 |
| total | 319 |

74/74 requirement memiliki ≥1 positive dan ≥1 negative. Seluruh 12 layar dan 213/213 elemen penting pada inventaris memiliki interaksi atau assertion eksplisit. Sebanyak 87 PNG dan dua extras tercantum pada source JSON.

## Requirements Traceability Matrix

| REQ | Deskripsi | Scenario IDs |
|---|---|---|
| REQ-001 | Daftar terbaru, ID unik, kolom customer dan nominal Rupiah | SHIPMENT-POS-001, SHIPMENT-NEG-001, SHIPMENT-POS-132 |
| REQ-002 | Pagination default 20 dan limit mempertahankan filter | SHIPMENT-POS-002, SHIPMENT-NEG-002, SHIPMENT-EDG-001, SHIPMENT-POS-075, SHIPMENT-STR-013 |
| REQ-003 | Filter gabungan dan Reset | SHIPMENT-POS-003, SHIPMENT-NEG-003, SHIPMENT-EDG-002 |
| REQ-004 | Batch memvalidasi seluruh data dan membuat ID terpisah | SHIPMENT-POS-004, SHIPMENT-NEG-004, SHIPMENT-POS-133, SHIPMENT-STR-001 |
| REQ-005 | Batch mode full reject dan partial configurable | SHIPMENT-POS-005, SHIPMENT-NEG-005, SHIPMENT-STR-002, SHIPMENT-STR-003 |
| REQ-006 | Stepper empat tahap dan draft antar langkah | SHIPMENT-POS-006, SHIPMENT-NEG-006, SHIPMENT-POS-142, SHIPMENT-POS-143 |
| REQ-007 | Batal pembuatan shipment | SHIPMENT-POS-007, SHIPMENT-NEG-007, SHIPMENT-EDG-003, SHIPMENT-POS-137, SHIPMENT-POS-138, SHIPMENT-POS-139 |
| REQ-008 | Jenis pengiriman wajib dan pergantian mereset data | SHIPMENT-POS-008, SHIPMENT-NEG-008 |
| REQ-009 | Kota dari master wajib dan berbeda | SHIPMENT-POS-009, SHIPMENT-NEG-009 |
| REQ-010 | Pengecekan tarif Step 1 dan loading | SHIPMENT-POS-010, SHIPMENT-NEG-010, SHIPMENT-EDG-004, SHIPMENT-NEG-075, SHIPMENT-STR-011 |
| REQ-011 | Tarif belum diatur membuka Master Rute pada tab baru | SHIPMENT-POS-011, SHIPMENT-NEG-011 |
| REQ-012 | Armada FTL aktif dan tipe pengiriman empat varian | SHIPMENT-POS-012, SHIPMENT-NEG-012, SHIPMENT-POS-110, SHIPMENT-POS-111, SHIPMENT-POS-112, SHIPMENT-POS-113, SHIPMENT-POS-114, SHIPMENT-POS-115, SHIPMENT-POS-116, SHIPMENT-POS-117, SHIPMENT-POS-118, SHIPMENT-POS-119, SHIPMENT-POS-120, SHIPMENT-POS-121, SHIPMENT-POS-122, SHIPMENT-POS-123, SHIPMENT-POS-124, SHIPMENT-POS-125 |
| REQ-013 | Quantity armada dan kontainer default 1 minimum 1 | SHIPMENT-POS-013, SHIPMENT-NEG-013, SHIPMENT-EDG-005, SHIPMENT-NEG-076, SHIPMENT-POS-076, SHIPMENT-NEG-077 |
| REQ-014 | Pengirim perusahaan default, master dan autofill editable lokal | SHIPMENT-POS-014, SHIPMENT-NEG-014 |
| REQ-015 | Pengirim individu dari master atau input manual | SHIPMENT-POS-015, SHIPMENT-NEG-015, SHIPMENT-POS-077 |
| REQ-016 | Penerima perusahaan dan individu serta autofill configurable | SHIPMENT-POS-016, SHIPMENT-NEG-016, SHIPMENT-POS-078, SHIPMENT-NEG-078 |
| REQ-017 | Kontak wajib dan format WhatsApp | SHIPMENT-POS-017, SHIPMENT-NEG-017, SHIPMENT-NEG-130, SHIPMENT-NEG-131, SHIPMENT-NEG-132 |
| REQ-018 | Alamat berjenjang dan kode pos wajib numerik | SHIPMENT-POS-018, SHIPMENT-NEG-018, SHIPMENT-NEG-079, SHIPMENT-EDG-006, SHIPMENT-POS-126, SHIPMENT-POS-127, SHIPMENT-STR-014 |
| REQ-019 | Sales, catatan dan detail lainnya opsional | SHIPMENT-POS-019, SHIPMENT-NEG-019, SHIPMENT-POS-130, SHIPMENT-POS-131 |
| REQ-020 | Popup customer individu menyimpan master tanpa legalitas | SHIPMENT-POS-020, SHIPMENT-NEG-020, SHIPMENT-POS-079, SHIPMENT-POS-080 |
| REQ-021 | Popup customer modal readonly dan pembatalan | SHIPMENT-POS-021, SHIPMENT-NEG-021, SHIPMENT-NEG-080 |
| REQ-022 | Deteksi customer duplikat dan pilih existing | SHIPMENT-POS-022, SHIPMENT-NEG-022, SHIPMENT-NEG-081 |
| REQ-023 | Pickup default dua, autofill hanya pertama dan hapus baris ketiga | SHIPMENT-POS-023, SHIPMENT-NEG-023 |
| REQ-024 | Validasi semua pickup dan isolasi kontak | SHIPMENT-POS-024, SHIPMENT-NEG-024, SHIPMENT-NEG-082, SHIPMENT-POS-128, SHIPMENT-STR-005 |
| REQ-025 | Drop off default dua, tambah, hapus dan urutan | SHIPMENT-POS-025, SHIPMENT-NEG-025 |
| REQ-026 | Validasi seluruh drop off | SHIPMENT-POS-026, SHIPMENT-NEG-026, SHIPMENT-NEG-083, SHIPMENT-POS-129, SHIPMENT-STR-006 |
| REQ-027 | Barang per armada minimal satu dan isolasi data | SHIPMENT-POS-027, SHIPMENT-NEG-027 |
| REQ-028 | Tambah hapus barang mempertahankan minimal satu | SHIPMENT-POS-028, SHIPMENT-NEG-028, SHIPMENT-STR-004 |
| REQ-029 | Kubikasi otomatis memperhitungkan jumlah dan desimal | SHIPMENT-POS-029, SHIPMENT-NEG-029, SHIPMENT-EDG-007, SHIPMENT-EDG-008 |
| REQ-030 | Total berat per satuan dan jumlah untuk LTL LCL Air | SHIPMENT-POS-030, SHIPMENT-NEG-030, SHIPMENT-EDG-009 |
| REQ-031 | Kapasitas armada hanya peringatan nonblocking | SHIPMENT-POS-031, SHIPMENT-NEG-031 |
| REQ-032 | Semua pickup digunakan oleh barang | SHIPMENT-POS-032, SHIPMENT-NEG-032 |
| REQ-033 | Relasi drop off barang eksplisit atau fallback semua | SHIPMENT-POS-033, SHIPMENT-NEG-033 |
| REQ-034 | Asuransi per barang nilai positif dan premi readonly | SHIPMENT-POS-034, SHIPMENT-NEG-034, SHIPMENT-EDG-011 |
| REQ-035 | Menonaktifkan asuransi menghapus kewajiban dan premi | SHIPMENT-POS-035, SHIPMENT-NEG-035, SHIPMENT-EDG-012 |
| REQ-036 | Kemasan jumlah wajib dan ringkasan jumlah kemasan | SHIPMENT-POS-036, SHIPMENT-NEG-036, SHIPMENT-EDG-010 |
| REQ-037 | Rate KG berat wajib dimensi opsional | SHIPMENT-POS-037, SHIPMENT-NEG-037, SHIPMENT-POS-087, SHIPMENT-NEG-095, SHIPMENT-POS-093, SHIPMENT-NEG-101 |
| REQ-038 | Rate KGV berat serta seluruh dimensi wajib | SHIPMENT-POS-038, SHIPMENT-NEG-038, SHIPMENT-EDG-013, SHIPMENT-EDG-014, SHIPMENT-POS-088, SHIPMENT-NEG-096, SHIPMENT-POS-094, SHIPMENT-NEG-102, SHIPMENT-NEG-133, SHIPMENT-NEG-134, SHIPMENT-NEG-135 |
| REQ-039 | Rate m3 dimensi wajib berat opsional | SHIPMENT-POS-039, SHIPMENT-NEG-039, SHIPMENT-POS-089, SHIPMENT-NEG-097, SHIPMENT-POS-095, SHIPMENT-NEG-103, SHIPMENT-NEG-136, SHIPMENT-NEG-137 |
| REQ-040 | Droppoint LTL dan Air autofill alamat | SHIPMENT-POS-040, SHIPMENT-NEG-040, SHIPMENT-POS-081 |
| REQ-041 | LCL pelabuhan dan droppoint tidak tersedia | SHIPMENT-POS-041, SHIPMENT-NEG-041 |
| REQ-042 | Air Freight menampilkan seluruh master bandara | SHIPMENT-POS-042, SHIPMENT-NEG-042, SHIPMENT-POS-082 |
| REQ-043 | Harga FTL manual per armada wajib positif | SHIPMENT-POS-043, SHIPMENT-NEG-043 |
| REQ-044 | Tarif otomatis memilih maksimum KG dan ceil KGV | SHIPMENT-POS-044, SHIPMENT-NEG-044, SHIPMENT-POS-090, SHIPMENT-NEG-098, SHIPMENT-POS-096, SHIPMENT-NEG-104 |
| REQ-045 | PPN PPh opsional dan default nilai terakhir | SHIPMENT-POS-045, SHIPMENT-NEG-045, SHIPMENT-EDG-015 |
| REQ-046 | Biaya tambahan pilihan default tambah hapus sebelum pajak | SHIPMENT-POS-046, SHIPMENT-NEG-046, SHIPMENT-POS-083, SHIPMENT-POS-084, SHIPMENT-STR-007 |
| REQ-047 | Rumus akhir DPP pajak pengurang dan asuransi | SHIPMENT-POS-047, SHIPMENT-NEG-047, SHIPMENT-EDG-016 |
| REQ-048 | Review lengkap field kosong strip dan collapse expand | SHIPMENT-POS-048, SHIPMENT-NEG-048, SHIPMENT-POS-135 |
| REQ-049 | Popup alamat pickup dan drop off serta label relasi | SHIPMENT-POS-049, SHIPMENT-NEG-049 |
| REQ-050 | Estimasi waktu dari master sesuai rute | SHIPMENT-POS-050, SHIPMENT-NEG-050 |
| REQ-051 | Simpan LTL LCL Air aktif dan kembali daftar | SHIPMENT-POS-051, SHIPMENT-NEG-051, SHIPMENT-POS-091, SHIPMENT-NEG-099, SHIPMENT-POS-097, SHIPMENT-NEG-105, SHIPMENT-STR-009 |
| REQ-052 | Edit umum sebelum ongoing jenis dan tipe terkunci | SHIPMENT-POS-052, SHIPMENT-NEG-052, SHIPMENT-NEG-084, SHIPMENT-POS-136 |
| REQ-053 | Edit umum ongoing diblokir selain pengecualian harga | SHIPMENT-POS-053, SHIPMENT-NEG-053, SHIPMENT-NEG-138, SHIPMENT-NEG-139 |
| REQ-054 | Soft delete konfirmasi dan larangan ongoing | SHIPMENT-POS-054, SHIPMENT-NEG-054, SHIPMENT-NEG-085 |
| REQ-055 | Detail dan nomor resi LTL LCL Air | SHIPMENT-POS-055, SHIPMENT-NEG-055, SHIPMENT-POS-134, SHIPMENT-POS-140 |
| REQ-056 | Edit harga FTL FCL semua status tanpa invoice dan HPP | SHIPMENT-POS-056, SHIPMENT-NEG-056, SHIPMENT-POS-099, SHIPMENT-POS-100, SHIPMENT-POS-101, SHIPMENT-POS-102, SHIPMENT-POS-103, SHIPMENT-POS-144 |
| REQ-057 | Invoice atau HPP mengunci edit harga dan penghapusan membuka kembali | SHIPMENT-POS-057, SHIPMENT-NEG-057, SHIPMENT-NEG-086, SHIPMENT-NEG-087, SHIPMENT-NEG-088, SHIPMENT-NEG-107, SHIPMENT-NEG-108, SHIPMENT-NEG-109, SHIPMENT-NEG-110, SHIPMENT-NEG-111 |
| REQ-058 | Alasan perubahan dan audit trail edit harga | SHIPMENT-POS-058, SHIPMENT-NEG-058, SHIPMENT-POS-085 |
| REQ-059 | Cetak satu resi per shipment tanpa Data Barang | SHIPMENT-POS-059, SHIPMENT-NEG-059, SHIPMENT-EDG-017, SHIPMENT-POS-092, SHIPMENT-NEG-100, SHIPMENT-POS-098, SHIPMENT-NEG-106, SHIPMENT-POS-141 |
| REQ-060 | Fungsi mobile setara desktop | SHIPMENT-POS-060, SHIPMENT-NEG-060 |
| REQ-061 | FTL FCL simpan Draft dengan dua pilihan akhir | SHIPMENT-POS-061, SHIPMENT-NEG-061, SHIPMENT-POS-104, SHIPMENT-NEG-112, SHIPMENT-STR-012 |
| REQ-062 | Simpan dan lanjut order membuat shipment terlebih dahulu | SHIPMENT-POS-062, SHIPMENT-NEG-062, SHIPMENT-POS-105, SHIPMENT-NEG-113 |
| REQ-063 | Batal atau meninggalkan form order tidak membuat draft order | SHIPMENT-POS-063, SHIPMENT-NEG-063, SHIPMENT-EDG-018, SHIPMENT-POS-106, SHIPMENT-NEG-114 |
| REQ-064 | Order lanjutan FTL tanggal wajib armada readonly | SHIPMENT-POS-064, SHIPMENT-NEG-064, SHIPMENT-NEG-089 |
| REQ-065 | Order FCL Direct kapal utama wajib tanpa connecting | SHIPMENT-POS-065, SHIPMENT-NEG-065, SHIPMENT-NEG-090, SHIPMENT-NEG-118, SHIPMENT-NEG-119, SHIPMENT-NEG-120, SHIPMENT-NEG-121, SHIPMENT-NEG-122, SHIPMENT-NEG-123 |
| REQ-066 | Order FCL Connecting minimal satu blok lengkap tambah hapus | SHIPMENT-POS-066, SHIPMENT-NEG-066, SHIPMENT-EDG-019, SHIPMENT-NEG-091, SHIPMENT-NEG-124, SHIPMENT-NEG-125, SHIPMENT-NEG-126, SHIPMENT-STR-008 |
| REQ-067 | Urutan tanggal kapal logis | SHIPMENT-POS-067, SHIPMENT-NEG-067, SHIPMENT-EDG-020, SHIPMENT-NEG-092, SHIPMENT-NEG-093 |
| REQ-068 | Buat Order hanya FTL FCL Draft belum diorder | SHIPMENT-POS-068, SHIPMENT-NEG-068, SHIPMENT-POS-107, SHIPMENT-NEG-115, SHIPMENT-NEG-127, SHIPMENT-NEG-128, SHIPMENT-NEG-129 |
| REQ-069 | Relasi order shipment FTL FCL satu banding satu | SHIPMENT-POS-069, SHIPMENT-NEG-069, SHIPMENT-EDG-021, SHIPMENT-POS-108, SHIPMENT-NEG-116, SHIPMENT-STR-010 |
| REQ-070 | Tambah Order menerima Draft mengecualikan Proses Order | SHIPMENT-POS-070, SHIPMENT-NEG-070, SHIPMENT-POS-109, SHIPMENT-NEG-117 |
| REQ-071 | Tambah Order konsolidasi LTL LCL Air tetap tersedia | SHIPMENT-POS-071, SHIPMENT-NEG-071 |
| REQ-072 | Catatan Shipment maksimum 50 karakter termasuk spasi | SHIPMENT-POS-072, SHIPMENT-NEG-072, SHIPMENT-EDG-022 |
| REQ-073 | Muat Ulang mengecek kembali tarif tanpa kehilangan rute | SHIPMENT-POS-073, SHIPMENT-NEG-073, SHIPMENT-NEG-094 |
| REQ-074 | FCL menampilkan pelabuhan, jenis kontainer dan kalkulasi per kontainer | SHIPMENT-POS-074, SHIPMENT-NEG-074, SHIPMENT-POS-086 |

## Cakupan layar

| Layar | Positive | Negative | Edge | Stress |
|---|---:|---:|---:|---:|
| daftar-shipment | 14 | 21 | 2 | 1 |
| data-pengiriman | 54 | 36 | 5 | 4 |
| popup-customer | 3 | 5 | 0 | 0 |
| data-barang | 21 | 24 | 8 | 1 |
| kalkulasi-harga | 12 | 7 | 2 | 1 |
| review | 12 | 10 | 0 | 2 |
| edit-shipment | 2 | 2 | 0 | 0 |
| edit-harga | 8 | 3 | 0 | 0 |
| detail-shipment | 5 | 4 | 1 | 0 |
| form-order-lanjutan | 8 | 22 | 4 | 2 |
| batch-shipment | 2 | 2 | 0 | 3 |
| tambah-order | 3 | 3 | 0 | 0 |

## Traceability elemen UI

ID pertama yang relevan ditampilkan agar tabel ringkas. Kontrol berulang memakai scope nomor baris/armada/titik; radio option dihitung sebagai interaksi pada radiogroup. Toast daftar tercakup oleh edit yang mengalihkan ke daftar. Cakupan adalah pemetaan skenario, bukan bukti kontrol sudah diuji pada aplikasi.

| Layar | Elemen | Scenario ID contoh |
|---|---|---|
| daftar-shipment | Shipment | SHIPMENT-POS-001 |
| daftar-shipment | Buat Shipment | SHIPMENT-POS-132 |
| daftar-shipment | Batch Shipment | SHIPMENT-POS-133 |
| daftar-shipment | Filter | SHIPMENT-POS-003 |
| daftar-shipment | ID Shipment | SHIPMENT-NEG-001 |
| daftar-shipment | Jenis Shipment | SHIPMENT-POS-002 |
| daftar-shipment | Customer | SHIPMENT-POS-003 |
| daftar-shipment | Kota Asal | SHIPMENT-POS-003 |
| daftar-shipment | Kota Tujuan | SHIPMENT-POS-003 |
| daftar-shipment | Droppoint Asal | SHIPMENT-POS-003 |
| daftar-shipment | Droppoint Tujuan | SHIPMENT-POS-003 |
| daftar-shipment | Total Harga | SHIPMENT-POS-003 |
| daftar-shipment | Terapkan | SHIPMENT-NEG-001 |
| daftar-shipment | Reset | SHIPMENT-POS-003 |
| daftar-shipment | Limit | SHIPMENT-POS-002 |
| daftar-shipment | Halaman berikutnya | SHIPMENT-POS-002 |
| daftar-shipment | Halaman sebelumnya | SHIPMENT-POS-002 |
| daftar-shipment | Halaman 2 | SHIPMENT-POS-075 |
| daftar-shipment | Menu Aksi | SHIPMENT-NEG-068 |
| daftar-shipment | Detail | SHIPMENT-POS-140 |
| daftar-shipment | Edit | SHIPMENT-POS-053 |
| daftar-shipment | Hapus | SHIPMENT-POS-054 |
| daftar-shipment | Cetak Resi | SHIPMENT-POS-141 |
| daftar-shipment | Buat Order | SHIPMENT-POS-068 |
| daftar-shipment | Riwayat Perubahan | SHIPMENT-POS-085 |
| daftar-shipment | Daftar Shipment | SHIPMENT-POS-001 |
| daftar-shipment | Shipment berhasil diubah | SHIPMENT-POS-052 |
| data-pengiriman | Jenis Pengiriman | SHIPMENT-POS-008 |
| data-pengiriman | Kota Asal | SHIPMENT-POS-009 |
| data-pengiriman | Kota Tujuan | SHIPMENT-POS-009 |
| data-pengiriman | Catatan Shipment | SHIPMENT-POS-019 |
| data-pengiriman | Atur Tarif | SHIPMENT-POS-011 |
| data-pengiriman | Muat Ulang | SHIPMENT-POS-073 |
| data-pengiriman | Memeriksa tarif pengiriman... | SHIPMENT-POS-010 |
| data-pengiriman | Tarif pengiriman rute ini belum diatur | SHIPMENT-NEG-010 |
| data-pengiriman | Jenis Armada | SHIPMENT-POS-012 |
| data-pengiriman | Jumlah Armada | SHIPMENT-POS-013 |
| data-pengiriman | Jenis Kontainer | SHIPMENT-POS-074 |
| data-pengiriman | Jumlah Kontainer | SHIPMENT-POS-074 |
| data-pengiriman | Tipe Pengiriman | SHIPMENT-POS-012 |
| data-pengiriman | Pelabuhan Asal | SHIPMENT-POS-041 |
| data-pengiriman | Pelabuhan Tujuan | SHIPMENT-POS-041 |
| data-pengiriman | Droppoint Asal | SHIPMENT-POS-040 |
| data-pengiriman | Droppoint Tujuan | SHIPMENT-POS-081 |
| data-pengiriman | Bandara Asal | SHIPMENT-POS-042 |
| data-pengiriman | Bandara Tujuan | SHIPMENT-POS-082 |
| data-pengiriman | Tambah Jumlah | SHIPMENT-POS-013 |
| data-pengiriman | Kurang Jumlah | SHIPMENT-EDG-005 |
| data-pengiriman | Data Pengiriman | SHIPMENT-POS-006 |
| data-pengiriman | Data Barang | SHIPMENT-POS-006 |
| data-pengiriman | Kalkulasi Harga | SHIPMENT-POS-006 |
| data-pengiriman | Review | SHIPMENT-NEG-006 |
| data-pengiriman | Batal | SHIPMENT-POS-007 |
| data-pengiriman | Selanjutnya | SHIPMENT-POS-006 |
| data-pengiriman | Jenis Pengirim | SHIPMENT-POS-015 |
| data-pengiriman | Pengirim | SHIPMENT-POS-014 |
| data-pengiriman | PIC Pengirim | SHIPMENT-POS-014 |
| data-pengiriman | No WA PIC Pengirim | SHIPMENT-POS-017 |
| data-pengiriman | Nama Sales Pengirim | SHIPMENT-POS-019 |
| data-pengiriman | No WA Sales Pengirim | SHIPMENT-POS-019 |
| data-pengiriman | Kode Pos Pengirim | SHIPMENT-POS-018 |
| data-pengiriman | Alamat Pengirim | SHIPMENT-POS-018 |
| data-pengiriman | Detail Lainnya Pengirim | SHIPMENT-POS-019 |
| data-pengiriman | Catatan Pengirim | SHIPMENT-POS-130 |
| data-pengiriman | Tambah Pengirim | SHIPMENT-POS-080 |
| data-pengiriman | Provinsi Pengirim | SHIPMENT-POS-018 |
| data-pengiriman | Kota Pengirim | SHIPMENT-POS-018 |
| data-pengiriman | Kecamatan Pengirim | SHIPMENT-POS-018 |
| data-pengiriman | Desa Pengirim | SHIPMENT-POS-018 |
| data-pengiriman | Jenis Penerima | SHIPMENT-POS-016 |
| data-pengiriman | Penerima | SHIPMENT-POS-016 |
| data-pengiriman | PIC Penerima | SHIPMENT-POS-016 |
| data-pengiriman | No WA PIC Penerima | SHIPMENT-POS-017 |
| data-pengiriman | Nama Sales Penerima | SHIPMENT-POS-131 |
| data-pengiriman | No WA Sales Penerima | SHIPMENT-POS-131 |
| data-pengiriman | Kode Pos Penerima | SHIPMENT-POS-127 |
| data-pengiriman | Alamat Penerima | SHIPMENT-POS-127 |
| data-pengiriman | Detail Lainnya Penerima | SHIPMENT-POS-131 |
| data-pengiriman | Catatan Penerima | SHIPMENT-POS-131 |
| data-pengiriman | Tambah Penerima | SHIPMENT-POS-079 |
| data-pengiriman | Provinsi Penerima | SHIPMENT-POS-127 |
| data-pengiriman | Kota Penerima | SHIPMENT-POS-127 |
| data-pengiriman | Kecamatan Penerima | SHIPMENT-POS-127 |
| data-pengiriman | Desa Penerima | SHIPMENT-POS-127 |
| data-pengiriman | Tambahkan Baris Input Pickup | SHIPMENT-POS-023 |
| data-pengiriman | Hapus Pickup | SHIPMENT-POS-023 |
| data-pengiriman | PIC Pickup | SHIPMENT-POS-024 |
| data-pengiriman | No WA Pickup | SHIPMENT-POS-024 |
| data-pengiriman | Alamat Pickup | SHIPMENT-POS-128 |
| data-pengiriman | Provinsi Pickup | SHIPMENT-POS-128 |
| data-pengiriman | Kota Pickup | SHIPMENT-POS-128 |
| data-pengiriman | Kecamatan Pickup | SHIPMENT-POS-128 |
| data-pengiriman | Desa Pickup | SHIPMENT-POS-128 |
| data-pengiriman | Kode Pos Pickup | SHIPMENT-NEG-082 |
| data-pengiriman | Tambahkan Baris Input Drop Off | SHIPMENT-POS-025 |
| data-pengiriman | Hapus Drop Off | SHIPMENT-POS-025 |
| data-pengiriman | PIC Drop Off | SHIPMENT-POS-026 |
| data-pengiriman | No WA Drop Off | SHIPMENT-POS-026 |
| data-pengiriman | Alamat Drop Off | SHIPMENT-NEG-026 |
| data-pengiriman | Provinsi Drop Off | SHIPMENT-POS-129 |
| data-pengiriman | Kota Drop Off | SHIPMENT-POS-129 |
| data-pengiriman | Kecamatan Drop Off | SHIPMENT-POS-129 |
| data-pengiriman | Desa Drop Off | SHIPMENT-POS-129 |
| data-pengiriman | Kode Pos Drop Off | SHIPMENT-POS-129 |
| popup-customer | Tambah Customer | SHIPMENT-POS-020 |
| popup-customer | Jenis Customer | SHIPMENT-POS-020 |
| popup-customer | Nama | SHIPMENT-POS-020 |
| popup-customer | No WA | SHIPMENT-POS-020 |
| popup-customer | Alamat | SHIPMENT-POS-020 |
| popup-customer | Simpan | SHIPMENT-POS-020 |
| popup-customer | Batal | SHIPMENT-POS-021 |
| popup-customer | Pilih Customer Existing | SHIPMENT-POS-022 |
| data-barang | Jenis Barang | SHIPMENT-POS-028 |
| data-barang | Berat | SHIPMENT-POS-030 |
| data-barang | Kemasan | SHIPMENT-POS-036 |
| data-barang | Jumlah | SHIPMENT-POS-029 |
| data-barang | Panjang | SHIPMENT-POS-029 |
| data-barang | Lebar | SHIPMENT-POS-029 |
| data-barang | Tinggi | SHIPMENT-POS-029 |
| data-barang | Kubikasi | SHIPMENT-POS-029 |
| data-barang | Tambahkan Asuransi | SHIPMENT-POS-034 |
| data-barang | Nilai Barang | SHIPMENT-POS-034 |
| data-barang | Premi Asuransi | SHIPMENT-POS-034 |
| data-barang | Tambah Barang | SHIPMENT-POS-028 |
| data-barang | Hapus Barang | SHIPMENT-POS-028 |
| data-barang | Pickup Barang | SHIPMENT-POS-032 |
| data-barang | Drop Off Barang | SHIPMENT-POS-033 |
| data-barang | Total Kubikasi | SHIPMENT-POS-029 |
| data-barang | Total Berat | SHIPMENT-POS-030 |
| data-barang | Informasi Rate | SHIPMENT-POS-030 |
| data-barang | Sebelumnya | SHIPMENT-POS-142 |
| data-barang | Selanjutnya | SHIPMENT-POS-027 |
| data-barang | Batal | SHIPMENT-POS-137 |
| kalkulasi-harga | Harga Pengiriman | SHIPMENT-POS-044 |
| kalkulasi-harga | Harga Armada | SHIPMENT-POS-043 |
| kalkulasi-harga | Harga Kontainer | SHIPMENT-POS-086 |
| kalkulasi-harga | PPN | SHIPMENT-POS-045 |
| kalkulasi-harga | PPh | SHIPMENT-POS-045 |
| kalkulasi-harga | Persen Asuransi | SHIPMENT-POS-047 |
| kalkulasi-harga | Tambah Biaya | SHIPMENT-POS-046 |
| kalkulasi-harga | Nama Item | SHIPMENT-POS-046 |
| kalkulasi-harga | Harga Biaya | SHIPMENT-POS-046 |
| kalkulasi-harga | Hapus Biaya | SHIPMENT-POS-083 |
| kalkulasi-harga | Harga DPP | SHIPMENT-POS-047 |
| kalkulasi-harga | Total Harga | SHIPMENT-POS-047 |
| kalkulasi-harga | Sebelumnya | SHIPMENT-POS-143 |
| kalkulasi-harga | Selanjutnya | SHIPMENT-NEG-043 |
| kalkulasi-harga | Batal | SHIPMENT-POS-138 |
| review | Jenis Pengiriman dan Rute | SHIPMENT-POS-135 |
| review | Data Pengirim | SHIPMENT-POS-048 |
| review | Data Penerima | SHIPMENT-POS-135 |
| review | Data Barang | SHIPMENT-POS-135 |
| review | Kalkulasi Harga | SHIPMENT-POS-135 |
| review | Lihat Alamat Pickup | SHIPMENT-POS-049 |
| review | Lihat Alamat Drop Off | SHIPMENT-POS-049 |
| review | Alamat Pick Up | SHIPMENT-POS-049 |
| review | Alamat Drop Off | SHIPMENT-POS-049 |
| review | Tutup | SHIPMENT-POS-049 |
| review | Estimasi Pengiriman | SHIPMENT-POS-050 |
| review | Sebelumnya | SHIPMENT-NEG-048 |
| review | Batal | SHIPMENT-POS-139 |
| review | Simpan | SHIPMENT-POS-051 |
| review | Simpan Shipment | SHIPMENT-POS-061 |
| review | Simpan & Lanjut ke Order | SHIPMENT-POS-062 |
| edit-shipment | Jenis Pengiriman dan Rute | SHIPMENT-POS-052 |
| edit-shipment | Data Pengirim | SHIPMENT-POS-136 |
| edit-shipment | Data Penerima | SHIPMENT-POS-136 |
| edit-shipment | Data Barang | SHIPMENT-POS-136 |
| edit-shipment | Kalkulasi Harga | SHIPMENT-POS-136 |
| edit-shipment | Jenis Pengiriman | SHIPMENT-POS-052 |
| edit-shipment | Tipe Pengiriman | SHIPMENT-POS-052 |
| edit-shipment | Catatan | SHIPMENT-POS-052 |
| edit-shipment | Simpan | SHIPMENT-POS-052 |
| edit-shipment | Batal | SHIPMENT-POS-136 |
| edit-harga | Kalkulasi Harga | SHIPMENT-POS-056 |
| edit-harga | Harga Pengiriman | SHIPMENT-POS-056 |
| edit-harga | PPN | SHIPMENT-POS-144 |
| edit-harga | PPh | SHIPMENT-POS-144 |
| edit-harga | Tambah Biaya | SHIPMENT-POS-144 |
| edit-harga | Alasan Perubahan Data | SHIPMENT-POS-056 |
| edit-harga | Data Pengirim | SHIPMENT-NEG-056 |
| edit-harga | Simpan | SHIPMENT-POS-056 |
| detail-shipment | Jenis Pengiriman dan Rute | SHIPMENT-POS-055 |
| detail-shipment | Data Pengirim | SHIPMENT-POS-055 |
| detail-shipment | Data Penerima | SHIPMENT-POS-055 |
| detail-shipment | Data Barang | SHIPMENT-POS-055 |
| detail-shipment | Kalkulasi Harga | SHIPMENT-POS-055 |
| detail-shipment | Kembali | SHIPMENT-POS-134 |
| detail-shipment | Cetak Resi | SHIPMENT-POS-059 |
| form-order-lanjutan | Jenis Shipment | SHIPMENT-POS-064 |
| form-order-lanjutan | Tanggal Permintaan Muat | SHIPMENT-POS-063 |
| form-order-lanjutan | Jenis Armada | SHIPMENT-NEG-089 |
| form-order-lanjutan | Jumlah Armada | SHIPMENT-NEG-089 |
| form-order-lanjutan | Jenis Kontainer | SHIPMENT-NEG-090 |
| form-order-lanjutan | Jumlah Kontainer | SHIPMENT-NEG-090 |
| form-order-lanjutan | Jenis Jadwal Kapal | SHIPMENT-POS-065 |
| form-order-lanjutan | Pelayaran | SHIPMENT-POS-065 |
| form-order-lanjutan | Nama Kapal | SHIPMENT-POS-065 |
| form-order-lanjutan | Voyage | SHIPMENT-POS-065 |
| form-order-lanjutan | Closing Time | SHIPMENT-POS-065 |
| form-order-lanjutan | Berangkat ETD | SHIPMENT-POS-065 |
| form-order-lanjutan | Tiba ETA | SHIPMENT-POS-065 |
| form-order-lanjutan | Pelabuhan Connecting | SHIPMENT-POS-066 |
| form-order-lanjutan | Kapal Connecting | SHIPMENT-POS-066 |
| form-order-lanjutan | Voyage Connecting | SHIPMENT-POS-066 |
| form-order-lanjutan | ETD Connecting | SHIPMENT-POS-066 |
| form-order-lanjutan | Tambah Kapal Connecting | SHIPMENT-POS-066 |
| form-order-lanjutan | Hapus Kapal Connecting | SHIPMENT-POS-066 |
| form-order-lanjutan | Simpan | SHIPMENT-POS-064 |
| form-order-lanjutan | Batal | SHIPMENT-POS-063 |
| batch-shipment | Proses Batch | SHIPMENT-POS-004 |
| tambah-order | Shipment | SHIPMENT-POS-070 |
| tambah-order | Simpan | SHIPMENT-POS-071 |

## Validasi dan deduplikasi

- JSON dapat diparse; seluruh field wajib dan action enum valid; semua target langkah memiliki selectorHints. Locator untuk hasil komposit sengaja null karena membutuhkan assertion field/domain, bukan locator fiktif.
- ID unik; summary sama dengan hitungan aktual; 319 Scenario cocok satu-ke-satu dengan JSON berdasarkan ID, title, category, priority, requirement dan screen.
- Validator struktur Gherkin lokal memeriksa Feature/Scenario, tag, urutan Given/When/Then, pasangan docstring, JSON fixture, dan padanan teks setiap langkah. Parser Cucumber resmi tidak tersedia pada dependensi lokal, sehingga validasi ini terbatas pada subset Gherkin yang dihasilkan; bukan klaim lulus parser resmi.
- Seluruh expected berasal dari langkah expect dan fixture dalam docstring Gherkin identik dengan testData JSON.
- Formula volume, total berat, contoh tarif dan DPP/PPN/PPh/asuransi diverifikasi ulang dengan aritmetika independen.
- Tidak ada duplikat identik (fixture + langkah + expected sama). Duplikat yang dibuang: 0. Kasus per jenis/rate/status/customer dipertahankan karena menguji cabang bisnis yang berbeda; blok Airfreight berulang pada sumber telah digabung pada tahap requirements.
- Review menambahkan validasi wajib FCL, guard status, navigasi detail/cetak, tombol kembali, komponen edit harga dan field kontak. Assertion loading/modal/readonly ditempatkan pada tahap ketika state tersebut tersedia.

## Gap dan batas kesiapan

Tidak ada gap requirement atau elemen UI penting pada lingkup yang didefinisikan dalam analysis. Kelengkapan ini tidak menghapus ketidakjelasan sumber berikut:

1. 28 asumsi tercatat di Assumptions Log: terutama status Draft vs Sudah Diorder, proteksi nol, duplikasi customer, default asuransi, minimum titik, harga ongoing, serta precedence desain/spec/extras.
2. Detail create FCL di luar bukti desain/penyesuaian tidak didefinisikan lengkap. Skenario order FCL memakai fixture shipment existing; bukan rekayasa flow bisnis FCL tambahan.
3. Format batch, template, batas upload, role/permission matrix, endpoint, URL, DOM dan SLA belum tersedia. Fixture sintetis dan target abstrak harus dipetakan saat codegen; tidak membuat acceptance criterion tipe file atau SLA fiktif.
4. Gambar dilihat lewat pratinjau; detail teks kecil yang belum pasti diturunkan dari spec dan ditandai pada inventaris. Tidak ada screenshot mobile, modal customer atau layar batch lengkap; persyaratannya berasal dari teks.
5. Beberapa expected bersifat semantis atau mencakup persistensi/audit, cetak, tab baru, state disabled, dan konkurensi. Codegen perlu assertion spesifik (nilai, count, URL, readonly, query fixture) serta adapter lifecycle; tidak cukup menerjemahkan semua expect menjadi toBeVisible.
6. Kasus stress adalah desain pengujian integritas/pemulihan, belum dijalankan. Payload panjang tanpa batas sumber mengharapkan tidak crash atau terpotong diam-diam, dengan penerimaan/validasi eksplisit sesuai batas implementasi.
7. Menu lintas modul yang hanya terlihat pada desain (Proses Invoice, Klaim Asuransi, Tambah HPP), kuota dan navigasi global tidak dijadikan flow baru. Invoice/HPP hanya sebagai prasyarat edit harga; konsolidasi order hanya batas integrasi yang dijelaskan extras.

Rekomendasi saat codegen: petakan kontrak fixture/selector dan status terlebih dahulu, gunakan parser Cucumber resmi di proyek tes, kemudian jalankan positive/negative prioritas high sebelum edge/stress. Semua keputusan sumber tetap dapat ditinjau di analysis tanpa mengubah inputs.
