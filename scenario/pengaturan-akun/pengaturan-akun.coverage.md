# Coverage — pengaturan-akun

## Ringkasan

| Kategori | Jumlah |
|---|---:|
| total | 336 |
| positive | 120 |
| negative | 157 |
| edge | 44 |
| stress | 15 |

**45/45 requirement** memiliki minimal satu positive dan satu negative. Semua 16 modul, 6 kategori tree, 5 jenis, 6 izin tambahan dan 17 label notifikasi tercakup.

## Requirements Traceability Matrix

| REQ | Deskripsi | Scenario IDs |
|---|---|---|
| REQ-001 | Navigasi dan otorisasi | PENGATURAN-AKUN-POS-001, PENGATURAN-AKUN-POS-002, PENGATURAN-AKUN-NEG-001 |
| REQ-002 | Template bersama | PENGATURAN-AKUN-POS-003, PENGATURAN-AKUN-NEG-002 |
| REQ-003 | Daftar Sub User | PENGATURAN-AKUN-POS-004, PENGATURAN-AKUN-NEG-003, PENGATURAN-AKUN-POS-005, PENGATURAN-AKUN-POS-006, PENGATURAN-AKUN-POS-010 |
| REQ-004 | Paginasi Sub User | PENGATURAN-AKUN-POS-011, PENGATURAN-AKUN-NEG-005, PENGATURAN-AKUN-EDG-001, PENGATURAN-AKUN-EDG-002, PENGATURAN-AKUN-EDG-003, PENGATURAN-AKUN-STR-001 |
| REQ-005 | Informasi Umum Sub User | PENGATURAN-AKUN-POS-013, PENGATURAN-AKUN-NEG-007, PENGATURAN-AKUN-NEG-008, PENGATURAN-AKUN-NEG-009, PENGATURAN-AKUN-NEG-010, PENGATURAN-AKUN-NEG-011, PENGATURAN-AKUN-NEG-012, PENGATURAN-AKUN-NEG-013, PENGATURAN-AKUN-NEG-014, PENGATURAN-AKUN-EDG-029, PENGATURAN-AKUN-NEG-143, PENGATURAN-AKUN-NEG-144, PENGATURAN-AKUN-NEG-145, PENGATURAN-AKUN-NEG-146 |
| REQ-006 | Keunikan Sub User | PENGATURAN-AKUN-POS-014, PENGATURAN-AKUN-NEG-015, PENGATURAN-AKUN-NEG-016, PENGATURAN-AKUN-NEG-017, PENGATURAN-AKUN-NEG-018, PENGATURAN-AKUN-STR-003, PENGATURAN-AKUN-STR-004 |
| REQ-007 | Password Sub User | PENGATURAN-AKUN-POS-015, PENGATURAN-AKUN-POS-016, PENGATURAN-AKUN-NEG-019, PENGATURAN-AKUN-POS-120 |
| REQ-008 | Pilih template | PENGATURAN-AKUN-POS-017, PENGATURAN-AKUN-NEG-020, PENGATURAN-AKUN-EDG-032 |
| REQ-009 | Template dari Sub User | PENGATURAN-AKUN-POS-018, PENGATURAN-AKUN-NEG-021, PENGATURAN-AKUN-EDG-033, PENGATURAN-AKUN-STR-013 |
| REQ-010 | Konfirmasi Sub User | PENGATURAN-AKUN-POS-019, PENGATURAN-AKUN-NEG-022, PENGATURAN-AKUN-POS-020, PENGATURAN-AKUN-NEG-023, PENGATURAN-AKUN-EDG-035, PENGATURAN-AKUN-EDG-036 |
| REQ-011 | Edit Sub User | PENGATURAN-AKUN-POS-021, PENGATURAN-AKUN-NEG-024, PENGATURAN-AKUN-POS-119 |
| REQ-012 | Batas delegasi | PENGATURAN-AKUN-POS-022, PENGATURAN-AKUN-NEG-025, PENGATURAN-AKUN-NEG-026, PENGATURAN-AKUN-NEG-027, PENGATURAN-AKUN-NEG-028, PENGATURAN-AKUN-NEG-029 |
| REQ-013 | Detail Sub User | PENGATURAN-AKUN-POS-023, PENGATURAN-AKUN-NEG-030, PENGATURAN-AKUN-EDG-007, PENGATURAN-AKUN-EDG-008, PENGATURAN-AKUN-EDG-009, PENGATURAN-AKUN-EDG-010, PENGATURAN-AKUN-EDG-011, PENGATURAN-AKUN-EDG-012 |
| REQ-014 | Daftar Hak Akses | PENGATURAN-AKUN-POS-007, PENGATURAN-AKUN-NEG-004, PENGATURAN-AKUN-POS-008, PENGATURAN-AKUN-POS-009 |
| REQ-015 | Paginasi Hak Akses | PENGATURAN-AKUN-POS-012, PENGATURAN-AKUN-NEG-006, PENGATURAN-AKUN-EDG-004, PENGATURAN-AKUN-EDG-005, PENGATURAN-AKUN-EDG-006, PENGATURAN-AKUN-STR-002 |
| REQ-016 | Identitas Hak Akses | PENGATURAN-AKUN-POS-025, PENGATURAN-AKUN-NEG-032, PENGATURAN-AKUN-NEG-033, PENGATURAN-AKUN-NEG-034, PENGATURAN-AKUN-NEG-035, PENGATURAN-AKUN-EDG-019, PENGATURAN-AKUN-EDG-030, PENGATURAN-AKUN-STR-005, PENGATURAN-AKUN-STR-014 |
| REQ-017 | Ringkasan Hak Akses | PENGATURAN-AKUN-POS-026, PENGATURAN-AKUN-NEG-036 |
| REQ-018 | Detail Hak Akses | PENGATURAN-AKUN-POS-024, PENGATURAN-AKUN-NEG-031, PENGATURAN-AKUN-EDG-013, PENGATURAN-AKUN-EDG-014, PENGATURAN-AKUN-EDG-015, PENGATURAN-AKUN-EDG-016, PENGATURAN-AKUN-EDG-017, PENGATURAN-AKUN-EDG-018 |
| REQ-019 | Edit template bersama | PENGATURAN-AKUN-POS-027, PENGATURAN-AKUN-NEG-037, PENGATURAN-AKUN-EDG-031, PENGATURAN-AKUN-STR-007 |
| REQ-020 | Shortcut level | PENGATURAN-AKUN-POS-028, PENGATURAN-AKUN-POS-029, PENGATURAN-AKUN-POS-030, PENGATURAN-AKUN-NEG-038, PENGATURAN-AKUN-STR-008 |
| REQ-021 | Semantik level | PENGATURAN-AKUN-POS-031, PENGATURAN-AKUN-NEG-039, PENGATURAN-AKUN-POS-032, PENGATURAN-AKUN-NEG-040, PENGATURAN-AKUN-POS-033, PENGATURAN-AKUN-NEG-041, PENGATURAN-AKUN-POS-034, PENGATURAN-AKUN-NEG-042, PENGATURAN-AKUN-POS-035, PENGATURAN-AKUN-NEG-043, PENGATURAN-AKUN-POS-036, PENGATURAN-AKUN-NEG-044, PENGATURAN-AKUN-POS-037, PENGATURAN-AKUN-NEG-045, PENGATURAN-AKUN-POS-038, PENGATURAN-AKUN-NEG-046, PENGATURAN-AKUN-POS-039, PENGATURAN-AKUN-NEG-047, PENGATURAN-AKUN-POS-040, PENGATURAN-AKUN-NEG-048, PENGATURAN-AKUN-POS-041, PENGATURAN-AKUN-NEG-049, PENGATURAN-AKUN-POS-042, PENGATURAN-AKUN-NEG-050, PENGATURAN-AKUN-POS-043, PENGATURAN-AKUN-NEG-051, PENGATURAN-AKUN-POS-044, PENGATURAN-AKUN-NEG-052, PENGATURAN-AKUN-POS-045, PENGATURAN-AKUN-NEG-053, PENGATURAN-AKUN-POS-046, PENGATURAN-AKUN-NEG-054, PENGATURAN-AKUN-POS-047, PENGATURAN-AKUN-NEG-055, PENGATURAN-AKUN-NEG-056, PENGATURAN-AKUN-NEG-057, PENGATURAN-AKUN-NEG-147, PENGATURAN-AKUN-NEG-148, PENGATURAN-AKUN-NEG-149, PENGATURAN-AKUN-NEG-150, PENGATURAN-AKUN-NEG-151, PENGATURAN-AKUN-NEG-152, PENGATURAN-AKUN-NEG-153, PENGATURAN-AKUN-NEG-154, PENGATURAN-AKUN-NEG-155, PENGATURAN-AKUN-NEG-156, PENGATURAN-AKUN-NEG-157 |
| REQ-022 | Struktur tree | PENGATURAN-AKUN-POS-048, PENGATURAN-AKUN-NEG-058, PENGATURAN-AKUN-NEG-059, PENGATURAN-AKUN-NEG-060, PENGATURAN-AKUN-NEG-061 |
| REQ-023 | Jenis Pengiriman | PENGATURAN-AKUN-POS-049, PENGATURAN-AKUN-POS-050, PENGATURAN-AKUN-POS-051, PENGATURAN-AKUN-POS-052, PENGATURAN-AKUN-POS-053, PENGATURAN-AKUN-NEG-062, PENGATURAN-AKUN-EDG-020, PENGATURAN-AKUN-EDG-021, PENGATURAN-AKUN-EDG-022, PENGATURAN-AKUN-EDG-023 |
| REQ-024 | Isolasi Jenis Pengiriman | PENGATURAN-AKUN-POS-054, PENGATURAN-AKUN-NEG-063, PENGATURAN-AKUN-POS-055, PENGATURAN-AKUN-NEG-064, PENGATURAN-AKUN-POS-056, PENGATURAN-AKUN-NEG-065, PENGATURAN-AKUN-POS-057, PENGATURAN-AKUN-NEG-066, PENGATURAN-AKUN-POS-058, PENGATURAN-AKUN-NEG-067, PENGATURAN-AKUN-STR-009, PENGATURAN-AKUN-EDG-037, PENGATURAN-AKUN-EDG-038, PENGATURAN-AKUN-EDG-039, PENGATURAN-AKUN-EDG-040, PENGATURAN-AKUN-EDG-041, PENGATURAN-AKUN-EDG-042, PENGATURAN-AKUN-EDG-043, PENGATURAN-AKUN-EDG-044, PENGATURAN-AKUN-EDG-045 |
| REQ-025 | Prasyarat Shipment | PENGATURAN-AKUN-POS-059, PENGATURAN-AKUN-NEG-068, PENGATURAN-AKUN-POS-060, PENGATURAN-AKUN-NEG-069, PENGATURAN-AKUN-POS-061, PENGATURAN-AKUN-NEG-070, PENGATURAN-AKUN-POS-062, PENGATURAN-AKUN-NEG-071, PENGATURAN-AKUN-POS-063, PENGATURAN-AKUN-NEG-072, PENGATURAN-AKUN-POS-064, PENGATURAN-AKUN-NEG-073, PENGATURAN-AKUN-POS-065, PENGATURAN-AKUN-NEG-074, PENGATURAN-AKUN-POS-066, PENGATURAN-AKUN-NEG-075 |
| REQ-026 | Prasyarat Otomasi | PENGATURAN-AKUN-POS-067, PENGATURAN-AKUN-NEG-076, PENGATURAN-AKUN-EDG-024 |
| REQ-027 | Penanganan prasyarat | PENGATURAN-AKUN-POS-068, PENGATURAN-AKUN-NEG-077 |
| REQ-028 | Siklus izin tambahan | PENGATURAN-AKUN-POS-069, PENGATURAN-AKUN-NEG-078, PENGATURAN-AKUN-NEG-079, PENGATURAN-AKUN-POS-070, PENGATURAN-AKUN-NEG-080, PENGATURAN-AKUN-NEG-081, PENGATURAN-AKUN-POS-071, PENGATURAN-AKUN-NEG-082, PENGATURAN-AKUN-NEG-083, PENGATURAN-AKUN-POS-072, PENGATURAN-AKUN-NEG-084, PENGATURAN-AKUN-NEG-085, PENGATURAN-AKUN-POS-073, PENGATURAN-AKUN-NEG-086, PENGATURAN-AKUN-NEG-087, PENGATURAN-AKUN-POS-074, PENGATURAN-AKUN-NEG-088, PENGATURAN-AKUN-NEG-089 |
| REQ-029 | Override Shipment dan Tracking | PENGATURAN-AKUN-POS-075, PENGATURAN-AKUN-NEG-090, PENGATURAN-AKUN-POS-076, PENGATURAN-AKUN-NEG-091, PENGATURAN-AKUN-NEG-092, PENGATURAN-AKUN-NEG-093 |
| REQ-030 | Invoice per Shipment | PENGATURAN-AKUN-POS-077, PENGATURAN-AKUN-NEG-094 |
| REQ-031 | Invoice per Periode | PENGATURAN-AKUN-POS-078, PENGATURAN-AKUN-NEG-095, PENGATURAN-AKUN-EDG-025 |
| REQ-032 | Invoice berulang | PENGATURAN-AKUN-POS-079, PENGATURAN-AKUN-NEG-096, PENGATURAN-AKUN-POS-080, PENGATURAN-AKUN-NEG-097, PENGATURAN-AKUN-NEG-098, PENGATURAN-AKUN-NEG-099, PENGATURAN-AKUN-EDG-026, PENGATURAN-AKUN-STR-011 |
| REQ-033 | Pengaturan batas invoice | PENGATURAN-AKUN-POS-081, PENGATURAN-AKUN-NEG-100, PENGATURAN-AKUN-EDG-027 |
| REQ-034 | Alasan dan audit override | PENGATURAN-AKUN-POS-082, PENGATURAN-AKUN-NEG-101, PENGATURAN-AKUN-POS-083, PENGATURAN-AKUN-NEG-102 |
| REQ-035 | Aksi lintas modul | PENGATURAN-AKUN-POS-084, PENGATURAN-AKUN-NEG-103, PENGATURAN-AKUN-POS-085, PENGATURAN-AKUN-NEG-104, PENGATURAN-AKUN-POS-086, PENGATURAN-AKUN-NEG-105, PENGATURAN-AKUN-POS-087, PENGATURAN-AKUN-NEG-106, PENGATURAN-AKUN-POS-088, PENGATURAN-AKUN-NEG-107, PENGATURAN-AKUN-POS-089, PENGATURAN-AKUN-NEG-108 |
| REQ-036 | State pembatasan edit | PENGATURAN-AKUN-POS-090, PENGATURAN-AKUN-NEG-109 |
| REQ-037 | Dashboard | PENGATURAN-AKUN-POS-091, PENGATURAN-AKUN-NEG-110, PENGATURAN-AKUN-POS-092, PENGATURAN-AKUN-NEG-111, PENGATURAN-AKUN-POS-093, PENGATURAN-AKUN-NEG-112 |
| REQ-038 | Penegakan backend | PENGATURAN-AKUN-POS-094, PENGATURAN-AKUN-NEG-113, PENGATURAN-AKUN-NEG-114, PENGATURAN-AKUN-NEG-115, PENGATURAN-AKUN-NEG-116, PENGATURAN-AKUN-STR-010 |
| REQ-039 | Daftar notifikasi | PENGATURAN-AKUN-POS-095, PENGATURAN-AKUN-POS-096, PENGATURAN-AKUN-NEG-117, PENGATURAN-AKUN-EDG-028 |
| REQ-040 | Prasyarat notifikasi | PENGATURAN-AKUN-POS-097, PENGATURAN-AKUN-NEG-118, PENGATURAN-AKUN-POS-098, PENGATURAN-AKUN-NEG-119, PENGATURAN-AKUN-POS-099, PENGATURAN-AKUN-NEG-120, PENGATURAN-AKUN-POS-100, PENGATURAN-AKUN-NEG-121, PENGATURAN-AKUN-POS-101, PENGATURAN-AKUN-NEG-122, PENGATURAN-AKUN-POS-102, PENGATURAN-AKUN-NEG-123, PENGATURAN-AKUN-POS-103, PENGATURAN-AKUN-NEG-124, PENGATURAN-AKUN-POS-104, PENGATURAN-AKUN-NEG-125, PENGATURAN-AKUN-POS-105, PENGATURAN-AKUN-NEG-126, PENGATURAN-AKUN-POS-106, PENGATURAN-AKUN-NEG-127, PENGATURAN-AKUN-POS-107, PENGATURAN-AKUN-NEG-128, PENGATURAN-AKUN-POS-108, PENGATURAN-AKUN-NEG-129, PENGATURAN-AKUN-POS-109, PENGATURAN-AKUN-NEG-130, PENGATURAN-AKUN-POS-110, PENGATURAN-AKUN-NEG-131, PENGATURAN-AKUN-POS-111, PENGATURAN-AKUN-NEG-132, PENGATURAN-AKUN-POS-112, PENGATURAN-AKUN-NEG-133, PENGATURAN-AKUN-POS-113, PENGATURAN-AKUN-NEG-134 |
| REQ-041 | Pengiriman notifikasi | PENGATURAN-AKUN-POS-114, PENGATURAN-AKUN-NEG-135, PENGATURAN-AKUN-NEG-136, PENGATURAN-AKUN-NEG-137, PENGATURAN-AKUN-STR-012 |
| REQ-042 | Default template | PENGATURAN-AKUN-POS-115, PENGATURAN-AKUN-NEG-138 |
| REQ-043 | Hapus template | PENGATURAN-AKUN-POS-116, PENGATURAN-AKUN-NEG-139, PENGATURAN-AKUN-NEG-140, PENGATURAN-AKUN-STR-006 |
| REQ-044 | Konfirmasi izin tambahan | PENGATURAN-AKUN-POS-117, PENGATURAN-AKUN-NEG-141 |
| REQ-045 | Audit hak akses | PENGATURAN-AKUN-POS-118, PENGATURAN-AKUN-NEG-142, PENGATURAN-AKUN-STR-015 |

## Coverage layar

Nama layar memakai slug JSON; route aplikasi belum diberikan. Layar lintas modul adalah uji integrasi izin.

| Layar | Jumlah |
|---|---:|
| daftar | 2 |
| dashboard | 2 |
| dashboard-monitoring | 5 |
| dashboard-operasional | 5 |
| dashboard-tracking-location | 5 |
| detail-hak-akses | 9 |
| detail-sub-user | 8 |
| edit-hak-akses | 69 |
| edit-sub-user | 20 |
| export | 3 |
| hak-akses | 15 |
| klaim-asuransi | 4 |
| manajemen-invoice | 16 |
| master-data-tarif | 3 |
| master-operasional | 3 |
| master-wilayah | 3 |
| notifikasi | 2 |
| order | 4 |
| otomasi-jalur | 2 |
| pencarian | 2 |
| pengaturan-notifikasi | 3 |
| penugasan-tracking | 8 |
| preferensi-notifikasi | 3 |
| pusat-notifikasi | 5 |
| shipment | 34 |
| sub-user | 14 |
| sub-user-hak-akses | 3 |
| tambah-biaya-hpp-shipment | 4 |
| tambah-hak-akses | 51 |
| tambah-sub-user | 29 |

## Coverage elemen UI penting

| Elemen / kelompok | Requirement | Bukti contoh |
|---|---|---|
| Menu dan dua tab | REQ-001 | PENGATURAN-AKUN-POS-001 |
| Daftar, aksi detail/edit/hapus, filter Terapkan/Reset | REQ-003, REQ-014, REQ-043 | PENGATURAN-AKUN-POS-004, PENGATURAN-AKUN-POS-007, PENGATURAN-AKUN-POS-116 |
| Ukuran halaman, berikutnya/sebelumnya, empty dan tanpa loading | REQ-004, REQ-015 | PENGATURAN-AKUN-POS-011, PENGATURAN-AKUN-POS-012 |
| Enam field umum, format, duplikasi, Status | REQ-005, REQ-006, REQ-011 | PENGATURAN-AKUN-POS-013, PENGATURAN-AKUN-POS-014, PENGATURAN-AKUN-POS-021 |
| Dua password dan dua toggle mata | REQ-007 | PENGATURAN-AKUN-POS-015 |
| Radio Pilih/Buat, dropdown template dan preview | REQ-008, REQ-009 | PENGATURAN-AKUN-POS-017, PENGATURAN-AKUN-POS-018 |
| Batal/Simpan/dialog dan penolakan konfirmasi | REQ-010, REQ-019, REQ-044 | PENGATURAN-AKUN-POS-019, PENGATURAN-AKUN-POS-027, PENGATURAN-AKUN-POS-117 |
| Nama Hak Akses dan Deskripsi | REQ-016 | PENGATURAN-AKUN-POS-025 |
| Ringkasan, informasi umum, tanggal, Total Sub User, Kembali | REQ-017, REQ-018 | PENGATURAN-AKUN-POS-026, PENGATURAN-AKUN-POS-024 |
| Tree detail Sub User dan template, enam kategori collapse/expand | REQ-013, REQ-018, REQ-022 | PENGATURAN-AKUN-POS-023, PENGATURAN-AKUN-POS-024, PENGATURAN-AKUN-POS-048 |
| 16 modul, 3/2 level, tanpa Cakupan Data | REQ-021, REQ-022 | PENGATURAN-AKUN-POS-031, PENGATURAN-AKUN-POS-048 |
| Shortcut dan perubahan manual | REQ-020, REQ-028 | PENGATURAN-AKUN-POS-028, PENGATURAN-AKUN-POS-069 |
| Lima checkbox jenis dan isolasi global | REQ-023, REQ-024 | PENGATURAN-AKUN-POS-049, PENGATURAN-AKUN-POS-054 |
| Inline warning, Sesuaikan Otomatis dan kartu ditahan | REQ-025, REQ-026, REQ-027 | PENGATURAN-AKUN-POS-059, PENGATURAN-AKUN-POS-067, PENGATURAN-AKUN-POS-068 |
| Enam toggle izin dan section pengaturan terpisah | REQ-028, REQ-029, REQ-030, REQ-031, REQ-032, REQ-033 | PENGATURAN-AKUN-POS-069, PENGATURAN-AKUN-POS-075, PENGATURAN-AKUN-POS-077, PENGATURAN-AKUN-POS-078, PENGATURAN-AKUN-POS-079, PENGATURAN-AKUN-POS-081 |
| Alasan, Riwayat dan audit hak akses | REQ-034, REQ-045 | PENGATURAN-AKUN-POS-082, PENGATURAN-AKUN-POS-118 |
| Enam aksi Shipment, field read-only dan alasan disabled | REQ-035, REQ-036 | PENGATURAN-AKUN-POS-084, PENGATURAN-AKUN-POS-090 |
| Tiga Dashboard dan widget sumber | REQ-037 | PENGATURAN-AKUN-POS-091 |
| 17 notifikasi termasuk kapal dan filter sumber | REQ-039, REQ-040, REQ-041 | PENGATURAN-AKUN-POS-095, PENGATURAN-AKUN-POS-097, PENGATURAN-AKUN-POS-114 |
| Default lima jenis/semua level/notifikasi/enam izin | REQ-042 | PENGATURAN-AKUN-POS-115 |

## Hasil validasi

- JSON berhasil dibaca; field wajib, enum action/priority/category, ID unik, title unik dan selectorHints setiap target lolos pemeriksaan.
- summary sesuai hitungan aktual: 336 = 120 positive + 157 negative + 44 edge + 15 stress.
- Parser resmi `@cucumber/gherkin` berhasil mengurai 336 Scenario dan mengompilasi 336 pickle; tidak ada error sintaks.
- Seluruh ID, judul, empat tag, jumlah langkah, target serta nilai langkah Gherkin cocok dengan JSON. Given dan Then tersedia; skenario inspeksi menggunakan navigasi awal sebagai stimulus, sehingga tidak selalu mempunyai When tambahan.
- Exact dedup memakai fingerprint preconditions + steps + expected + testData; tidak ada duplikat identik tersisa.
- Enam file PNG sumber tersedia dan dibaca; input tidak diubah. Validator dan dependency parser hanya disimpan di /tmp, tidak mengubah dependency proyek.

## Duplikat / overlap yang dibuang

- PENGATURAN-AKUN-EDG-034 — Shortcut Lihat Saja lalu Penuh mengosongkan seluruh izin: Overlap siklus turun/naik shortcut; digabung ke negative REQ-020 yang memeriksa semua enam izin dan persistensi.
- ID tidak dinomori ulang sesudah dedup; celah EDG-034 disengaja. Skenario per modul, per field, dan per notifikasi dipertahankan karena memeriksa aturan pada target berbeda.

## Gap dan batas validasi

Tidak ada gap pemetaan REQ atau kelompok elemen penting terhadap skenario. Coverage ini mengukur rancangan pengujian, **bukan keberhasilan aplikasi**. Skenario belum dijalankan terhadap TMS atau Playwright.

Hal yang belum dapat divalidasi dari input:

- Empat modul tambahan desain (Proses Surat Jalan, Laporan Keuangan, Audit Trail, Batch Shipment), kategori System dan angka badge 20 tidak disamakan dengan 16 modul spec. Butuh spec tambahan sebelum membuat oracle operasionalnya.
- Kemampuan menampilkan password lama pada edit belum mempunyai oracle implementasi yang aman; skenario hanya memverifikasi toggle nilai baru. Ini gap acceptance terkait AS-10, bukan klaim fitur lama teruji.
- Pemetaan shortcut dua level, status template, normalisasi duplikasi, kebijakan password/panjang field dan penghapusan Sub User masih asumsi.
- Batas edit data modul Shipment/Tracking/Invoice tidak diberikan; fixture eligible/locked harus memakai aturan modul tujuan saat implementasi pengujian.
- Default notifikasi dan gambar Monitoring bertentangan pada prasyarat Invoice; spec diprioritaskan. Tidak ada screenshot form/error untuk memvalidasi teks error atau selector aktual.
- Gherkin dan JSON siap menjadi sumber codegen, tetapi routeMap, fixture auth, kontrak API, sink event, assertion response/download/audit dan stress harness harus dipetakan terlebih dahulu. `testData.execution` menjelaskan kontrak ini; `expect.value` adalah oracle, bukan semuanya pencarian teks terlihat.
- Profil stress merupakan volume uji, bukan SLA; hasil throughput/latensi belum diukur.

## Rekomendasi saat implementasi

1. Terapkan AS-01 sampai AS-15 dari analysis.md; pastikan keputusan produk sebelum menjadikan kasus berbasis asumsi sebagai acceptance gate.
2. Hubungkan locator dan fixture nyata, khususnya kontrol password getByLabel, toggle switch/checkbox, dropdown custom, dan scope baris.
3. Setelah spesifikasi modul terkait tersedia, lengkapi status konkret penguncian, batas invoice, aturan password lama dan empat modul tambahan desain. Jalankan kasus prioritas high sebelum stress.
