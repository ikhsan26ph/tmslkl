# Analysis — shipment

## Requirements

Sumber: `inputs/shipment/spec.txt`, `extras/dokumen-tambahan.txt`, `extras/dokumen-tambahan2.txt`. Penyesuaian dan extras kedua menentukan flow terbaru.

| REQ | Requirement / acceptance criterion | Layar | Sumber |
|---|---|---|---|
| REQ-001 | Daftar terbaru, ID unik, kolom customer dan nominal Rupiah | daftar-shipment | spec.txt + extras/dokumen-tambahan.txt |
| REQ-002 | Pagination default 20 dan limit mempertahankan filter | daftar-shipment | spec.txt + extras/dokumen-tambahan.txt |
| REQ-003 | Filter gabungan dan Reset | daftar-shipment | spec.txt + extras/dokumen-tambahan.txt |
| REQ-004 | Batch memvalidasi seluruh data dan membuat ID terpisah | batch-shipment | spec.txt + extras/dokumen-tambahan.txt |
| REQ-005 | Batch mode full reject dan partial configurable | batch-shipment | spec.txt + extras/dokumen-tambahan.txt |
| REQ-006 | Stepper empat tahap dan draft antar langkah | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-007 | Batal pembuatan shipment | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-008 | Jenis pengiriman wajib dan pergantian mereset data | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-009 | Kota dari master wajib dan berbeda | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-010 | Pengecekan tarif Step 1 dan loading | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-011 | Tarif belum diatur membuka Master Rute pada tab baru | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-012 | Armada FTL aktif dan tipe pengiriman empat varian | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-013 | Quantity armada dan kontainer default 1 minimum 1 | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-014 | Pengirim perusahaan default, master dan autofill editable lokal | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-015 | Pengirim individu dari master atau input manual | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-016 | Penerima perusahaan dan individu serta autofill configurable | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-017 | Kontak wajib dan format WhatsApp | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-018 | Alamat berjenjang dan kode pos wajib numerik | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-019 | Sales, catatan dan detail lainnya opsional | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-020 | Popup customer individu menyimpan master tanpa legalitas | popup-customer | spec.txt + extras/dokumen-tambahan.txt |
| REQ-021 | Popup customer modal readonly dan pembatalan | popup-customer | spec.txt + extras/dokumen-tambahan.txt |
| REQ-022 | Deteksi customer duplikat dan pilih existing | popup-customer | spec.txt + extras/dokumen-tambahan.txt |
| REQ-023 | Pickup default dua, autofill hanya pertama dan hapus baris ketiga | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-024 | Validasi semua pickup dan isolasi kontak | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-025 | Drop off default dua, tambah, hapus dan urutan | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-026 | Validasi seluruh drop off | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-027 | Barang per armada minimal satu dan isolasi data | data-barang | spec.txt + extras/dokumen-tambahan.txt |
| REQ-028 | Tambah hapus barang mempertahankan minimal satu | data-barang | spec.txt + extras/dokumen-tambahan.txt |
| REQ-029 | Kubikasi otomatis memperhitungkan jumlah dan desimal | data-barang | spec.txt + extras/dokumen-tambahan.txt |
| REQ-030 | Total berat per satuan dan jumlah untuk LTL LCL Air | data-barang | spec.txt + extras/dokumen-tambahan.txt |
| REQ-031 | Kapasitas armada hanya peringatan nonblocking | data-barang | spec.txt + extras/dokumen-tambahan.txt |
| REQ-032 | Semua pickup digunakan oleh barang | data-barang | spec.txt + extras/dokumen-tambahan.txt |
| REQ-033 | Relasi drop off barang eksplisit atau fallback semua | data-barang | spec.txt + extras/dokumen-tambahan.txt |
| REQ-034 | Asuransi per barang nilai positif dan premi readonly | data-barang | spec.txt + extras/dokumen-tambahan.txt |
| REQ-035 | Menonaktifkan asuransi menghapus kewajiban dan premi | data-barang | spec.txt + extras/dokumen-tambahan.txt |
| REQ-036 | Kemasan jumlah wajib dan ringkasan jumlah kemasan | data-barang | spec.txt + extras/dokumen-tambahan.txt |
| REQ-037 | Rate KG berat wajib dimensi opsional | data-barang | spec.txt + extras/dokumen-tambahan.txt |
| REQ-038 | Rate KGV berat serta seluruh dimensi wajib | data-barang | spec.txt + extras/dokumen-tambahan.txt |
| REQ-039 | Rate m3 dimensi wajib berat opsional | data-barang | spec.txt + extras/dokumen-tambahan.txt |
| REQ-040 | Droppoint LTL dan Air autofill alamat | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-041 | LCL pelabuhan dan droppoint tidak tersedia | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-042 | Air Freight menampilkan seluruh master bandara | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-043 | Harga FTL manual per armada wajib positif | kalkulasi-harga | spec.txt + extras/dokumen-tambahan.txt |
| REQ-044 | Tarif otomatis memilih maksimum KG dan ceil KGV | kalkulasi-harga | spec.txt + extras/dokumen-tambahan.txt |
| REQ-045 | PPN PPh opsional dan default nilai terakhir | kalkulasi-harga | spec.txt + extras/dokumen-tambahan.txt |
| REQ-046 | Biaya tambahan pilihan default tambah hapus sebelum pajak | kalkulasi-harga | spec.txt + extras/dokumen-tambahan.txt |
| REQ-047 | Rumus akhir DPP pajak pengurang dan asuransi | kalkulasi-harga | spec.txt + extras/dokumen-tambahan.txt |
| REQ-048 | Review lengkap field kosong strip dan collapse expand | review | spec.txt + extras/dokumen-tambahan.txt |
| REQ-049 | Popup alamat pickup dan drop off serta label relasi | review | spec.txt + extras/dokumen-tambahan.txt |
| REQ-050 | Estimasi waktu dari master sesuai rute | review | spec.txt + extras/dokumen-tambahan.txt |
| REQ-051 | Simpan LTL LCL Air aktif dan kembali daftar | review | spec.txt + extras/dokumen-tambahan.txt |
| REQ-052 | Edit umum sebelum ongoing jenis dan tipe terkunci | edit-shipment | spec.txt + extras/dokumen-tambahan.txt |
| REQ-053 | Edit umum ongoing diblokir selain pengecualian harga | daftar-shipment | spec.txt + extras/dokumen-tambahan.txt |
| REQ-054 | Soft delete konfirmasi dan larangan ongoing | daftar-shipment | spec.txt + extras/dokumen-tambahan.txt |
| REQ-055 | Detail dan nomor resi LTL LCL Air | detail-shipment | spec.txt + extras/dokumen-tambahan.txt |
| REQ-056 | Edit harga FTL FCL semua status tanpa invoice dan HPP | edit-harga | spec.txt + extras/dokumen-tambahan.txt |
| REQ-057 | Invoice atau HPP mengunci edit harga dan penghapusan membuka kembali | daftar-shipment | spec.txt + extras/dokumen-tambahan.txt |
| REQ-058 | Alasan perubahan dan audit trail edit harga | edit-harga | spec.txt + extras/dokumen-tambahan.txt |
| REQ-059 | Cetak satu resi per shipment tanpa Data Barang | detail-shipment | spec.txt + extras/dokumen-tambahan.txt |
| REQ-060 | Fungsi mobile setara desktop | data-pengiriman | spec.txt + extras/dokumen-tambahan.txt |
| REQ-061 | FTL FCL simpan Draft dengan dua pilihan akhir | review | extras/dokumen-tambahan2.txt |
| REQ-062 | Simpan dan lanjut order membuat shipment terlebih dahulu | review | extras/dokumen-tambahan2.txt |
| REQ-063 | Batal atau meninggalkan form order tidak membuat draft order | form-order-lanjutan | extras/dokumen-tambahan2.txt |
| REQ-064 | Order lanjutan FTL tanggal wajib armada readonly | form-order-lanjutan | extras/dokumen-tambahan2.txt |
| REQ-065 | Order FCL Direct kapal utama wajib tanpa connecting | form-order-lanjutan | extras/dokumen-tambahan2.txt |
| REQ-066 | Order FCL Connecting minimal satu blok lengkap tambah hapus | form-order-lanjutan | extras/dokumen-tambahan2.txt |
| REQ-067 | Urutan tanggal kapal logis | form-order-lanjutan | extras/dokumen-tambahan2.txt |
| REQ-068 | Buat Order hanya FTL FCL Draft belum diorder | daftar-shipment | extras/dokumen-tambahan2.txt |
| REQ-069 | Relasi order shipment FTL FCL satu banding satu | form-order-lanjutan | extras/dokumen-tambahan2.txt |
| REQ-070 | Tambah Order menerima Draft mengecualikan Proses Order | tambah-order | extras/dokumen-tambahan2.txt |
| REQ-071 | Tambah Order konsolidasi LTL LCL Air tetap tersedia | tambah-order | extras/dokumen-tambahan2.txt |

| REQ-072 | Catatan Shipment maksimum 50 karakter termasuk spasi | data-pengiriman | desain buat-shipment-ltl-default/tarif-tidak-ada.png |
| REQ-073 | Muat Ulang mengecek kembali tarif tanpa kehilangan rute | data-pengiriman | desain buat-shipment-ltl-default/tarif-tidak-ada.png |
| REQ-074 | FCL menampilkan pelabuhan, jenis kontainer dan kalkulasi per kontainer | data-pengiriman | desain 0458 + 0464 FCL.png |

### Aktor, alur dan validasi

Admin berizin mengakses daftar → empat step → Review → simpan. Cabang FTL/FCL dapat menuju Form Order Lanjutan; order adalah entitas terpisah. Batch memakai validasi sebelum pemrosesan. Edit umum hanya sebelum ongoing; pengecualian harga FTL/FCL memerlukan belum ada invoice dan HPP.

Validasi saat Selanjutnya/Simpan menampilkan helper per field. Kontak PIC, WA, alamat berjenjang dan kode pos wajib; sales/catatan/detail opsional. Armada aktif, rute berbeda, barang minimal satu per armada; Kemasan/Jumlah wajib. Rate KG membutuhkan Berat; KGV Berat/P/L/T; m³ P/L/T. Nilai asuransi dan harga armada >0. Quantity armada/kontainer integer ≥1. Form Order Lanjutan mengunci atribut armada/kontainer; semua detail kapal utama wajib, Connecting minimal satu blok lengkap; Closing≤ETD≤ETA, ETD Connecting≥ETD utama. Simpan order disabled bila invalid. Batas panjang/range persentase dan SLA tidak tersedia.

## UI Inventory

87/87 PNG dibuka melalui 15 lembar pratinjau lokal. view_image gagal akibat bwrap; gambar dimuat melalui bytes lokal tanpa mengubah inputs. Struktur seluruh gambar terbaca; teks kecil pada form panjang tidak dapat dipastikan seluruhnya. Label yang tidak jelas dilengkapi dari spec dan ditandai sebagai usulan. Tidak ada DOM: semua ARIA role dan data-testid berikut adalah saran, bukan atribut terverifikasi.

### daftar-shipment

| Elemen / label text | Role usulan | Name usulan | data-testid usulan | Tipe / placeholder / state / sumber |
|---|---|---|---|---|
| Shipment | link | Shipment | shipment-daftar-shipment-shipment | Navigasi sidebar |
| Buat Shipment | button | Buat Shipment | shipment-daftar-shipment-buat-shipment | Membuka wizard |
| Batch Shipment | button | Batch Shipment | shipment-daftar-shipment-batch-shipment | Masuk batch; detail form tidak ada PNG |
| Filter | button | Filter | shipment-daftar-shipment-filter | Collapsed/expanded |
| ID Shipment | textbox | ID Shipment | shipment-daftar-shipment-id-shipment | Placeholder Masukkan ID Shipment |
| Jenis Shipment | combobox | Jenis Shipment | shipment-daftar-shipment-jenis-shipment | Pilih Jenis Shipment |
| Customer | textbox | Customer | shipment-daftar-shipment-customer | Masukkan Customer |
| Kota Asal | combobox | Kota Asal | shipment-daftar-shipment-kota-asal | Pilih Kota Asal |
| Kota Tujuan | combobox | Kota Tujuan | shipment-daftar-shipment-kota-tujuan | Pilih Kota Tujuan |
| Droppoint Asal | combobox | Droppoint Asal | shipment-daftar-shipment-droppoint-asal | Label desain Drop Point Asal |
| Droppoint Tujuan | combobox | Droppoint Tujuan | shipment-daftar-shipment-droppoint-tujuan | Label desain Drop Point Tujuan |
| Total Harga | textbox | Total Harga | shipment-daftar-shipment-total-harga | Masukkan Total Harga |
| Terapkan | button | Terapkan | shipment-daftar-shipment-terapkan | Apply filter |
| Reset | button | Reset | shipment-daftar-shipment-reset | Clear filter |
| Limit | combobox | Limit | shipment-daftar-shipment-limit | Label Tampilkan; default 20 |
| Halaman berikutnya | button | Halaman berikutnya | shipment-daftar-shipment-halaman-berikutnya | Ikon panah; nama aksesibel usulan |
| Halaman sebelumnya | button | Halaman sebelumnya | shipment-daftar-shipment-halaman-sebelumnya | Ikon panah |
| Halaman 2 | button | Halaman 2 | shipment-daftar-shipment-halaman-2 | Nomor pagination |
| Menu Aksi | button | Menu Aksi | shipment-daftar-shipment-menu-aksi | Ikon elipsis scoped ID shipment |
| Detail | menuitem | Detail | shipment-daftar-shipment-detail | Menu aksi |
| Edit | menuitem | Edit | shipment-daftar-shipment-edit | Menu aksi |
| Hapus | menuitem | Hapus | shipment-daftar-shipment-hapus | Menu aksi |
| Cetak Resi | menuitem | Cetak Resi | shipment-daftar-shipment-cetak-resi | Menu aksi |
| Buat Order | menuitem | Buat Order | shipment-daftar-shipment-buat-order | Terlihat pada 0518; eligibility dari extras |
| Riwayat Perubahan | menuitem | Riwayat Perubahan | shipment-daftar-shipment-riwayat-perubahan | Terlihat pada 0518; audit edit harga |
| Daftar Shipment | table | Daftar Shipment | shipment-daftar-shipment-daftar-shipment | ID/customer; kota/droppoint; total harga/status |
| Shipment berhasil diubah | status | Shipment berhasil diubah | shipment-daftar-shipment-shipment-berhasil-diubah | Toast hijau terlihat; Data shipment telah tersimpan dalam sistem |

### data-pengiriman

| Elemen / label text | Role usulan | Name usulan | data-testid usulan | Tipe / placeholder / state / sumber |
|---|---|---|---|---|
| Jenis Pengiriman | radiogroup | Jenis Pengiriman | shipment-data-pengiriman-jenis-pengiriman | Kartu radio FTL/FCL/LTL/LCL/Air Freight; default belum dipilih dari spec |
| Kota Asal | combobox | Kota Asal | shipment-data-pengiriman-kota-asal | Pilih Kota Asal |
| Kota Tujuan | combobox | Kota Tujuan | shipment-data-pengiriman-kota-tujuan | Pilih Kota Tujuan |
| Catatan Shipment | textbox | Catatan Shipment | shipment-data-pengiriman-catatan-shipment | Masukkan Catatan Shipment; Maksimal 50 karakter (termasuk spasi) |
| Atur Tarif | button | Atur Tarif | shipment-data-pengiriman-atur-tarif | Alert kuning tarif belum diatur |
| Muat Ulang | button | Muat Ulang | shipment-data-pengiriman-muat-ulang | Cek kembali tarif |
| Memeriksa tarif pengiriman... | status | Memeriksa tarif pengiriman... | shipment-data-pengiriman-memeriksa-tarif-pengiriman | Loading terlihat |
| Tarif pengiriman rute ini belum diatur | alert | Tarif pengiriman rute ini belum diatur | shipment-data-pengiriman-tarif-pengiriman-rute-ini-belum-diatur | Pesan kuning terlihat |
| Jenis Armada | combobox | Jenis Armada | shipment-data-pengiriman-jenis-armada | Pilih Jenis Armada |
| Jumlah Armada | spinbutton | Jumlah Armada | shipment-data-pengiriman-jumlah-armada | Quantity dari penyesuaian; form lama input angka |
| Jenis Kontainer | combobox | Jenis Kontainer | shipment-data-pengiriman-jenis-kontainer | Pilih Jenis Kontainer; FCL |
| Jumlah Kontainer | spinbutton | Jumlah Kontainer | shipment-data-pengiriman-jumlah-kontainer | Quantity FCL |
| Tipe Pengiriman | combobox | Tipe Pengiriman | shipment-data-pengiriman-tipe-pengiriman | Pilih Tipe Pengiriman |
| Pelabuhan Asal | combobox | Pelabuhan Asal | shipment-data-pengiriman-pelabuhan-asal | Pilih Pelabuhan Asal |
| Pelabuhan Tujuan | combobox | Pelabuhan Tujuan | shipment-data-pengiriman-pelabuhan-tujuan | Pilih Pelabuhan Tujuan |
| Droppoint Asal | combobox | Droppoint Asal | shipment-data-pengiriman-droppoint-asal | Drop Point Asal |
| Droppoint Tujuan | combobox | Droppoint Tujuan | shipment-data-pengiriman-droppoint-tujuan | Drop Point Tujuan |
| Bandara Asal | combobox | Bandara Asal | shipment-data-pengiriman-bandara-asal | Pilih Bandara Asal |
| Bandara Tujuan | combobox | Bandara Tujuan | shipment-data-pengiriman-bandara-tujuan | Pilih Bandara Tujuan |
| Tambah Jumlah | button | Tambah Jumlah | shipment-data-pengiriman-tambah-jumlah | + dari penyesuaian |
| Kurang Jumlah | button | Kurang Jumlah | shipment-data-pengiriman-kurang-jumlah | − disabled saat 1 |
| Data Pengiriman | tab | Data Pengiriman | shipment-data-pengiriman-data-pengiriman | Stepper aktif pertama; role usulan |
| Data Barang | tab | Data Barang | shipment-data-pengiriman-data-barang | Step masa depan disabled |
| Kalkulasi Harga | tab | Kalkulasi Harga | shipment-data-pengiriman-kalkulasi-harga | Step masa depan disabled |
| Review | tab | Review | shipment-data-pengiriman-review | Step masa depan disabled |
| Batal | button | Batal | shipment-data-pengiriman-batal | Footer |
| Selanjutnya | button | Selanjutnya | shipment-data-pengiriman-selanjutnya | Footer disabled pada loading/tarif kosong |
| Jenis Pengirim | combobox | Jenis Pengirim | shipment-data-pengiriman-jenis-pengirim | Perusahaan default / Individu |
| Pengirim | combobox | Pengirim | shipment-data-pengiriman-pengirim | Master atau editable individual |
| PIC Pengirim | textbox | PIC Pengirim | shipment-data-pengiriman-pic-pengirim | Wajib |
| No WA PIC Pengirim | textbox | No WA PIC Pengirim | shipment-data-pengiriman-no-wa-pic-pengirim | Label Nomor WhatsApp PIC; wajib |
| Nama Sales Pengirim | textbox | Nama Sales Pengirim | shipment-data-pengiriman-nama-sales-pengirim | Opsional |
| No WA Sales Pengirim | textbox | No WA Sales Pengirim | shipment-data-pengiriman-no-wa-sales-pengirim | Label Nomor WhatsApp Sales; opsional |
| Kode Pos Pengirim | textbox | Kode Pos Pengirim | shipment-data-pengiriman-kode-pos-pengirim | Wajib numerik |
| Alamat Pengirim | textbox | Alamat Pengirim | shipment-data-pengiriman-alamat-pengirim | Textarea alamat lengkap |
| Detail Lainnya Pengirim | textbox | Detail Lainnya Pengirim | shipment-data-pengiriman-detail-lainnya-pengirim | Opsional |
| Catatan Pengirim | textbox | Catatan Pengirim | shipment-data-pengiriman-catatan-pengirim | Opsional |
| Tambah Pengirim | button | Tambah Pengirim | shipment-data-pengiriman-tambah-pengirim | Mode Individu terlihat; Perusahaan dari extras |
| Provinsi Pengirim | combobox | Provinsi Pengirim | shipment-data-pengiriman-provinsi-pengirim | Dropdown berjenjang; label lokasi asal/tujuan bervariasi |
| Kota Pengirim | combobox | Kota Pengirim | shipment-data-pengiriman-kota-pengirim | Dropdown berjenjang; label lokasi asal/tujuan bervariasi |
| Kecamatan Pengirim | combobox | Kecamatan Pengirim | shipment-data-pengiriman-kecamatan-pengirim | Dropdown berjenjang; label lokasi asal/tujuan bervariasi |
| Desa Pengirim | combobox | Desa Pengirim | shipment-data-pengiriman-desa-pengirim | Dropdown berjenjang; label lokasi asal/tujuan bervariasi |
| Jenis Penerima | combobox | Jenis Penerima | shipment-data-pengiriman-jenis-penerima | Perusahaan default / Individu |
| Penerima | combobox | Penerima | shipment-data-pengiriman-penerima | Master atau editable individual |
| PIC Penerima | textbox | PIC Penerima | shipment-data-pengiriman-pic-penerima | Wajib |
| No WA PIC Penerima | textbox | No WA PIC Penerima | shipment-data-pengiriman-no-wa-pic-penerima | Label Nomor WhatsApp PIC; wajib |
| Nama Sales Penerima | textbox | Nama Sales Penerima | shipment-data-pengiriman-nama-sales-penerima | Opsional |
| No WA Sales Penerima | textbox | No WA Sales Penerima | shipment-data-pengiriman-no-wa-sales-penerima | Label Nomor WhatsApp Sales; opsional |
| Kode Pos Penerima | textbox | Kode Pos Penerima | shipment-data-pengiriman-kode-pos-penerima | Wajib numerik |
| Alamat Penerima | textbox | Alamat Penerima | shipment-data-pengiriman-alamat-penerima | Textarea alamat lengkap |
| Detail Lainnya Penerima | textbox | Detail Lainnya Penerima | shipment-data-pengiriman-detail-lainnya-penerima | Opsional |
| Catatan Penerima | textbox | Catatan Penerima | shipment-data-pengiriman-catatan-penerima | Opsional |
| Tambah Penerima | button | Tambah Penerima | shipment-data-pengiriman-tambah-penerima | Mode Individu terlihat; Perusahaan dari extras |
| Provinsi Penerima | combobox | Provinsi Penerima | shipment-data-pengiriman-provinsi-penerima | Dropdown berjenjang; label lokasi asal/tujuan bervariasi |
| Kota Penerima | combobox | Kota Penerima | shipment-data-pengiriman-kota-penerima | Dropdown berjenjang; label lokasi asal/tujuan bervariasi |
| Kecamatan Penerima | combobox | Kecamatan Penerima | shipment-data-pengiriman-kecamatan-penerima | Dropdown berjenjang; label lokasi asal/tujuan bervariasi |
| Desa Penerima | combobox | Desa Penerima | shipment-data-pengiriman-desa-penerima | Dropdown berjenjang; label lokasi asal/tujuan bervariasi |
| Tambahkan Baris Input Pickup | button | Tambahkan Baris Input Pickup | shipment-data-pengiriman-tambahkan-baris-input-pickup | Textlink + Tambah baris input |
| Hapus Pickup | button | Hapus Pickup | shipment-data-pengiriman-hapus-pickup | Ikon hapus: desain sebagian baris kedua terlihat; spec minimum dua diprioritaskan |
| PIC Pickup | textbox | PIC Pickup | shipment-data-pengiriman-pic-pickup | Scoped per titik |
| No WA Pickup | textbox | No WA Pickup | shipment-data-pengiriman-no-wa-pickup | Scoped per titik |
| Alamat Pickup | textbox | Alamat Pickup | shipment-data-pengiriman-alamat-pickup | Scoped per titik |
| Provinsi Pickup | combobox | Provinsi Pickup | shipment-data-pengiriman-provinsi-pickup | Scoped per titik |
| Kota Pickup | combobox | Kota Pickup | shipment-data-pengiriman-kota-pickup | Scoped per titik |
| Kecamatan Pickup | combobox | Kecamatan Pickup | shipment-data-pengiriman-kecamatan-pickup | Scoped per titik |
| Desa Pickup | combobox | Desa Pickup | shipment-data-pengiriman-desa-pickup | Scoped per titik |
| Kode Pos Pickup | textbox | Kode Pos Pickup | shipment-data-pengiriman-kode-pos-pickup | Scoped per titik |
| Tambahkan Baris Input Drop Off | button | Tambahkan Baris Input Drop Off | shipment-data-pengiriman-tambahkan-baris-input-drop-off | Textlink + Tambah baris input |
| Hapus Drop Off | button | Hapus Drop Off | shipment-data-pengiriman-hapus-drop-off | Ikon hapus: desain sebagian baris kedua terlihat; spec minimum dua diprioritaskan |
| PIC Drop Off | textbox | PIC Drop Off | shipment-data-pengiriman-pic-drop-off | Scoped per titik |
| No WA Drop Off | textbox | No WA Drop Off | shipment-data-pengiriman-no-wa-drop-off | Scoped per titik |
| Alamat Drop Off | textbox | Alamat Drop Off | shipment-data-pengiriman-alamat-drop-off | Scoped per titik |
| Provinsi Drop Off | combobox | Provinsi Drop Off | shipment-data-pengiriman-provinsi-drop-off | Scoped per titik |
| Kota Drop Off | combobox | Kota Drop Off | shipment-data-pengiriman-kota-drop-off | Scoped per titik |
| Kecamatan Drop Off | combobox | Kecamatan Drop Off | shipment-data-pengiriman-kecamatan-drop-off | Scoped per titik |
| Desa Drop Off | combobox | Desa Drop Off | shipment-data-pengiriman-desa-drop-off | Scoped per titik |
| Kode Pos Drop Off | textbox | Kode Pos Drop Off | shipment-data-pengiriman-kode-pos-drop-off | Scoped per titik |

### popup-customer

| Elemen / label text | Role usulan | Name usulan | data-testid usulan | Tipe / placeholder / state / sumber |
|---|---|---|---|---|
| Tambah Customer | dialog | Tambah Customer | shipment-popup-customer-tambah-customer | Diturunkan spec; PNG khusus modal customer tidak tersedia |
| Jenis Customer | textbox | Jenis Customer | shipment-popup-customer-jenis-customer | Readonly Individu |
| Nama | textbox | Nama | shipment-popup-customer-nama | Wajib |
| No WA | textbox | No WA | shipment-popup-customer-no-wa | Numerik valid |
| Alamat | textbox | Alamat | shipment-popup-customer-alamat | Wajib; alamat lengkap |
| Simpan | button | Simpan | shipment-popup-customer-simpan | Validasi dan simpan master |
| Batal | button | Batal | shipment-popup-customer-batal | Konfirmasi jika dirty |
| Pilih Customer Existing | button | Pilih Customer Existing | shipment-popup-customer-pilih-customer-existing | Resolusi duplikat dari spec |

### data-barang

| Elemen / label text | Role usulan | Name usulan | data-testid usulan | Tipe / placeholder / state / sumber |
|---|---|---|---|---|
| Jenis Barang | textbox | Jenis Barang | shipment-data-barang-jenis-barang | Masukkan Jenis Barang |
| Berat | spinbutton | Berat | shipment-data-barang-berat | kg; wajib sesuai rate |
| Kemasan | combobox | Kemasan | shipment-data-barang-kemasan | Pilih Kemasan |
| Jumlah | spinbutton | Jumlah | shipment-data-barang-jumlah | qty |
| Panjang | spinbutton | Panjang | shipment-data-barang-panjang | cm |
| Lebar | spinbutton | Lebar | shipment-data-barang-lebar | cm |
| Tinggi | spinbutton | Tinggi | shipment-data-barang-tinggi | cm |
| Kubikasi | textbox | Kubikasi | shipment-data-barang-kubikasi | Readonly m³ |
| Tambahkan Asuransi | checkbox | Tambahkan Asuransi | shipment-data-barang-tambahkan-asuransi | Unchecked/checked; Nilai Barang muncul |
| Nilai Barang | spinbutton | Nilai Barang | shipment-data-barang-nilai-barang | Rp |
| Premi Asuransi | textbox | Premi Asuransi | shipment-data-barang-premi-asuransi | Readonly; spec, tidak jelas di PNG barang terbaru |
| Tambah Barang | button | Tambah Barang | shipment-data-barang-tambah-barang | Textlink + Tambah Barang |
| Hapus Barang | button | Hapus Barang | shipment-data-barang-hapus-barang | Ikon sampah scoped baris |
| Pickup Barang | combobox | Pickup Barang | shipment-data-barang-pickup-barang | Mapping dari spec; desain menggunakan section alamat |
| Drop Off Barang | combobox | Drop Off Barang | shipment-data-barang-drop-off-barang | Mapping advanced dari spec |
| Total Kubikasi | status | Total Kubikasi | shipment-data-barang-total-kubikasi | Ringkasan bawah |
| Total Berat | status | Total Berat | shipment-data-barang-total-berat | Ringkasan bawah |
| Informasi Rate | note | Informasi Rate | shipment-data-barang-informasi-rate | Panel biru helper data satuan dan mandatory rate |
| Sebelumnya | button | Sebelumnya | shipment-data-barang-sebelumnya | Footer |
| Selanjutnya | button | Selanjutnya | shipment-data-barang-selanjutnya | Footer |
| Batal | button | Batal | shipment-data-barang-batal | Footer |

### kalkulasi-harga

| Elemen / label text | Role usulan | Name usulan | data-testid usulan | Tipe / placeholder / state / sumber |
|---|---|---|---|---|
| Harga Pengiriman | table | Harga Pengiriman | shipment-kalkulasi-harga-harga-pengiriman | Per armada/kontainer atau per barang |
| Harga Armada | spinbutton | Harga Armada | shipment-kalkulasi-harga-harga-armada | Harga manual Rp |
| Harga Kontainer | spinbutton | Harga Kontainer | shipment-kalkulasi-harga-harga-kontainer | Harga manual pada desain FCL |
| PPN | spinbutton | PPN | shipment-kalkulasi-harga-ppn | % |
| PPh | spinbutton | PPh | shipment-kalkulasi-harga-pph | % |
| Persen Asuransi | spinbutton | Persen Asuransi | shipment-kalkulasi-harga-persen-asuransi | Label Asuransi; conditional |
| Tambah Biaya | button | Tambah Biaya | shipment-kalkulasi-harga-tambah-biaya | Textlink + Tambah Biaya / Tambah Item Biaya |
| Nama Item | combobox | Nama Item | shipment-kalkulasi-harga-nama-item | Pilih Jenis Biaya |
| Harga Biaya | spinbutton | Harga Biaya | shipment-kalkulasi-harga-harga-biaya | Rp; default 0 |
| Hapus Biaya | button | Hapus Biaya | shipment-kalkulasi-harga-hapus-biaya | Ikon sampah scoped baris |
| Harga DPP | status | Harga DPP | shipment-kalkulasi-harga-harga-dpp | Breakdown |
| Total Harga | status | Total Harga | shipment-kalkulasi-harga-total-harga | Breakdown |
| Sebelumnya | button | Sebelumnya | shipment-kalkulasi-harga-sebelumnya | Footer |
| Selanjutnya | button | Selanjutnya | shipment-kalkulasi-harga-selanjutnya | Footer |
| Batal | button | Batal | shipment-kalkulasi-harga-batal | Footer |

### review

| Elemen / label text | Role usulan | Name usulan | data-testid usulan | Tipe / placeholder / state / sumber |
|---|---|---|---|---|
| Jenis Pengiriman dan Rute | button | Jenis Pengiriman dan Rute | shipment-review-jenis-pengiriman-dan-rute | Header accordion |
| Data Pengirim | button | Data Pengirim | shipment-review-data-pengirim | Header accordion |
| Data Penerima | button | Data Penerima | shipment-review-data-penerima | Header accordion |
| Data Barang | button | Data Barang | shipment-review-data-barang | Header accordion |
| Kalkulasi Harga | button | Kalkulasi Harga | shipment-review-kalkulasi-harga | Header accordion |
| Lihat Alamat Pickup | link | Lihat Alamat Pickup | shipment-review-lihat-alamat-pickup | Label gambar Lihat Alamat Pick Up |
| Lihat Alamat Drop Off | link | Lihat Alamat Drop Off | shipment-review-lihat-alamat-drop-off | Scoped baris barang |
| Alamat Pick Up | dialog | Alamat Pick Up | shipment-review-alamat-pick-up | Overlay abu; daftar wilayah, kode pos, alamat |
| Alamat Drop Off | dialog | Alamat Drop Off | shipment-review-alamat-drop-off | Overlay abu; daftar wilayah, kode pos, alamat |
| Tutup | button | Tutup | shipment-review-tutup | Modal alamat |
| Estimasi Pengiriman | status | Estimasi Pengiriman | shipment-review-estimasi-pengiriman | Nilai per rute |
| Sebelumnya | button | Sebelumnya | shipment-review-sebelumnya | Footer |
| Batal | button | Batal | shipment-review-batal | Footer |
| Simpan | button | Simpan | shipment-review-simpan | LTL/LCL/Air |
| Simpan Shipment | button | Simpan Shipment | shipment-review-simpan-shipment | FTL/FCL terbaru 0515 |
| Simpan & Lanjut ke Order | button | Simpan & Lanjut ke Order | shipment-review-simpan-lanjut-ke-order | FTL/FCL terbaru 0515 |

### edit-shipment

| Elemen / label text | Role usulan | Name usulan | data-testid usulan | Tipe / placeholder / state / sumber |
|---|---|---|---|---|
| Jenis Pengiriman dan Rute | button | Jenis Pengiriman dan Rute | shipment-edit-shipment-jenis-pengiriman-dan-rute | Default terbuka menurut spec; beberapa mockup seluruhnya terbuka |
| Data Pengirim | button | Data Pengirim | shipment-edit-shipment-data-pengirim | Accordion |
| Data Penerima | button | Data Penerima | shipment-edit-shipment-data-penerima | Accordion |
| Data Barang | button | Data Barang | shipment-edit-shipment-data-barang | Helper data satuan juga wajib di edit |
| Kalkulasi Harga | button | Kalkulasi Harga | shipment-edit-shipment-kalkulasi-harga | Accordion |
| Jenis Pengiriman | radiogroup | Jenis Pengiriman | shipment-edit-shipment-jenis-pengiriman | Readonly |
| Tipe Pengiriman | combobox | Tipe Pengiriman | shipment-edit-shipment-tipe-pengiriman | Readonly FTL |
| Catatan | textbox | Catatan | shipment-edit-shipment-catatan | Editable |
| Simpan | button | Simpan | shipment-edit-shipment-simpan | Label sebagian gambar Simpan |
| Batal | button | Batal | shipment-edit-shipment-batal | Footer |

### edit-harga

| Elemen / label text | Role usulan | Name usulan | data-testid usulan | Tipe / placeholder / state / sumber |
|---|---|---|---|---|
| Kalkulasi Harga | button | Kalkulasi Harga | shipment-edit-harga-kalkulasi-harga | Terbuka editable menurut penyesuaian; PNG khusus tidak ada |
| Harga Pengiriman | spinbutton | Harga Pengiriman | shipment-edit-harga-harga-pengiriman | Editable |
| PPN | spinbutton | PPN | shipment-edit-harga-ppn | Editable |
| PPh | spinbutton | PPh | shipment-edit-harga-pph | Editable |
| Tambah Biaya | button | Tambah Biaya | shipment-edit-harga-tambah-biaya | Editable |
| Alasan Perubahan Data | textbox | Alasan Perubahan Data | shipment-edit-harga-alasan-perubahan-data | Card baru menurut spec |
| Data Pengirim | button | Data Pengirim | shipment-edit-harga-data-pengirim | Disabled dan tertutup |
| Simpan | button | Simpan | shipment-edit-harga-simpan | Simpan perubahan |

### detail-shipment

| Elemen / label text | Role usulan | Name usulan | data-testid usulan | Tipe / placeholder / state / sumber |
|---|---|---|---|---|
| Jenis Pengiriman dan Rute | button | Jenis Pengiriman dan Rute | shipment-detail-shipment-jenis-pengiriman-dan-rute | Accordion |
| Data Pengirim | button | Data Pengirim | shipment-detail-shipment-data-pengirim | Accordion |
| Data Penerima | button | Data Penerima | shipment-detail-shipment-data-penerima | Accordion |
| Data Barang | table | Data Barang | shipment-detail-shipment-data-barang | Nomor resi di bawah nama dari spec |
| Kalkulasi Harga | table | Kalkulasi Harga | shipment-detail-shipment-kalkulasi-harga | Harga, biaya tambahan dan breakdown |
| Kembali | button | Kembali | shipment-detail-shipment-kembali | Kanan atas |
| Cetak Resi | button | Cetak Resi | shipment-detail-shipment-cetak-resi | Dari menu aksi spec |

### form-order-lanjutan

| Elemen / label text | Role usulan | Name usulan | data-testid usulan | Tipe / placeholder / state / sumber |
|---|---|---|---|---|
| Jenis Shipment | region | Jenis Shipment | shipment-form-order-lanjutan-jenis-shipment | FTL/FCL summary dan ID shipment/customer/rute/total |
| Tanggal Permintaan Muat | textbox | Tanggal Permintaan Muat | shipment-form-order-lanjutan-tanggal-permintaan-muat | Wajib; tanggal terlihat DD/MM/YYYY |
| Jenis Armada | textbox | Jenis Armada | shipment-form-order-lanjutan-jenis-armada | Readonly FTL |
| Jumlah Armada | textbox | Jumlah Armada | shipment-form-order-lanjutan-jumlah-armada | Readonly FTL |
| Jenis Kontainer | textbox | Jenis Kontainer | shipment-form-order-lanjutan-jenis-kontainer | Readonly FCL |
| Jumlah Kontainer | textbox | Jumlah Kontainer | shipment-form-order-lanjutan-jumlah-kontainer | Readonly FCL |
| Jenis Jadwal Kapal | radiogroup | Jenis Jadwal Kapal | shipment-form-order-lanjutan-jenis-jadwal-kapal | Kartu radio Direct dan Connecting |
| Pelayaran | combobox | Pelayaran | shipment-form-order-lanjutan-pelayaran | Pilih Pelayaran |
| Nama Kapal | textbox | Nama Kapal | shipment-form-order-lanjutan-nama-kapal | Masukkan Nama Kapal |
| Voyage | textbox | Voyage | shipment-form-order-lanjutan-voyage | Masukkan Voyage |
| Closing Time | textbox | Closing Time | shipment-form-order-lanjutan-closing-time | DD/MM/YYYY; detail waktu tidak pasti |
| Berangkat ETD | textbox | Berangkat ETD | shipment-form-order-lanjutan-berangkat-etd | Label Berangkat (ETD) |
| Tiba ETA | textbox | Tiba ETA | shipment-form-order-lanjutan-tiba-eta | Label Tiba (ETA) |
| Pelabuhan Connecting | combobox | Pelabuhan Connecting | shipment-form-order-lanjutan-pelabuhan-connecting | Pilih Pelabuhan |
| Kapal Connecting | textbox | Kapal Connecting | shipment-form-order-lanjutan-kapal-connecting | Masukkan Nama Kapal |
| Voyage Connecting | textbox | Voyage Connecting | shipment-form-order-lanjutan-voyage-connecting | Label Voyage; scope connecting |
| ETD Connecting | textbox | ETD Connecting | shipment-form-order-lanjutan-etd-connecting | DD/MM/YYYY |
| Tambah Kapal Connecting | button | Tambah Kapal Connecting | shipment-form-order-lanjutan-tambah-kapal-connecting | Textlink + |
| Hapus Kapal Connecting | button | Hapus Kapal Connecting | shipment-form-order-lanjutan-hapus-kapal-connecting | Aturan dari extras; ikon tidak jelas pada satu blok default |
| Simpan | button | Simpan | shipment-form-order-lanjutan-simpan | Disabled/error state dari extras |
| Batal | button | Batal | shipment-form-order-lanjutan-batal | Kembali ke daftar shipment |

### batch-shipment

| Elemen / label text | Role usulan | Name usulan | data-testid usulan | Tipe / placeholder / state / sumber |
|---|---|---|---|---|
| Proses Batch | button | Proses Batch | shipment-batch-shipment-proses-batch | Target abstrak dari spec; detail form dan format input tidak tersedia |

### tambah-order

| Elemen / label text | Role usulan | Name usulan | data-testid usulan | Tipe / placeholder / state / sumber |
|---|---|---|---|---|
| Shipment | combobox | Shipment | shipment-tambah-order-shipment | Dari extras; form Tambah Order via menu tidak ada PNG |
| Simpan | button | Simpan | shipment-tambah-order-simpan | Flow existing dari extras |

### Bukti pembacaan desain

| PNG | Observasi visual |
|---|---|
| 0192-admin-shipment-list.png | Tabel daftar dengan limit/pagination; menu aksi dan kolom customer/rute/harga; filter expanded khusus 0193. |
| 0193-admin-shipment-list-dan-filter.png | Tabel daftar dengan limit/pagination; menu aksi dan kolom customer/rute/harga; filter expanded khusus 0193. |
| 0208-admin-tambah-shipment-ltl-kalkulasi-harga-tanpa-asuransi.png | Tabel harga per barang; PPN/PPh, asuransi sesuai state, breakdown; sebagian gambar tabel biaya tambahan. |
| 0209-admin-tambah-shipment-ltl-kalkulasi-harga-ada-asuransi-field-asuransi-default.png | Tabel harga per barang; PPN/PPh, asuransi sesuai state, breakdown; sebagian gambar tabel biaya tambahan. |
| 0210-admin-tambah-shipment-ltl-kalkulasi-harga-ada-asuransi-field-asuransi-contoh-data.png | Tabel harga per barang; PPN/PPh, asuransi sesuai state, breakdown; sebagian gambar tabel biaya tambahan. |
| 0211-admin-tambah-shipment-ltl-review-data-tanpa-asuransi.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0212-admin-tambah-shipment-ltl-review-data-ada-asuransi.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0213-admin-edit-shipment-ltl-normal.png | Edit form memuat card customer, barang dan kalkulasi; navigasi Batal/Simpan. |
| 0214-admin-edit-shipment-ltl-alert-berhasil-normal.png | Tabel daftar dengan limit/pagination; toast hijau Shipment berhasil diubah. |
| 0214a-admin-detail-shipment-ltl-normal.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0215-admin-shipment-list.png | Tabel daftar dengan limit/pagination; menu aksi dan kolom customer/rute/harga; filter expanded khusus 0193. |
| 0230-admin-tambah-shipment-lcl-kalkulasi-harga-tanpa-asuransi.png | Tabel harga per barang; PPN/PPh, asuransi sesuai state, breakdown; sebagian gambar tabel biaya tambahan. |
| 0231-admin-tambah-shipment-lcl-kalkulasi-harga-ada-asuransi.png | Tabel harga per barang; PPN/PPh, asuransi sesuai state, breakdown; sebagian gambar tabel biaya tambahan. |
| 0232-admin-tambah-shipment-lcl-review-data-tanpa-asuransi.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0233-admin-tambah-shipment-lcl-review-data-ada-asuransi.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0234-admin-edit-shipment-lcl.png | Edit form memuat card customer, barang dan kalkulasi; navigasi Batal/Simpan. |
| 0235-admin-edit-shipment-lcl-alert-berhasil-edit-data.png | Tabel daftar dengan limit/pagination; toast hijau Shipment berhasil diubah. |
| 0236-admin-shipment-tambah-shipment-ltl-form-default.png | Konten Detail Shipment LCL, berbeda dengan nama file yang menyebut form LTL; klasifikasi berdasarkan konten. |
| 0237-admin-shipment-list.png | Tabel daftar dengan limit/pagination; menu aksi dan kolom customer/rute/harga; filter expanded khusus 0193. |
| 0244-admin-shipment-tambah-shipment-air-freight-form-pengirim-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| 0248-admin-shipment-tambah-shipment-air-freight-form-pengirim-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| 0252-admin-shipment-tambah-shipment-air-freight-kalkulasi-harga-tanpa-asuransi.png | Tabel harga per barang; PPN/PPh, asuransi sesuai state, breakdown; sebagian gambar tabel biaya tambahan. |
| 0253-admin-shipment-tambah-shipment-air-freight-kalkulasi-harga-ada-asuransi.png | Tabel harga per barang; PPN/PPh, asuransi sesuai state, breakdown; sebagian gambar tabel biaya tambahan. |
| 0254-admin-shipment-tambah-shipment-air-freight-review-data-tanpa-asuransi.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0255-admin-shipment-tambah-shipment-air-freight-review-data-ada-asuransi.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0256-admin-shipment-edit-shipment-air-freight.png | Edit form memuat card customer, barang dan kalkulasi; navigasi Batal/Simpan. |
| 0257-admin-shipment-list-alert-berhasil-ubah-data.png | Tabel daftar dengan limit/pagination; toast hijau Shipment berhasil diubah. |
| 0258-admin-shipment-detail-shipment-air-freight.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0457-admin-shipment-list.png | Tabel daftar dengan limit/pagination; menu aksi dan kolom customer/rute/harga; filter expanded khusus 0193. |
| 0458-admin-tambah-shipment-fcl-form-default.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| 0464-admin-tambah-shipment-fcl-contoh-data-form-kalkulasi-harga-normal-ada-asuransi.png | Tabel harga per kontainer; PPN/PPh, asuransi sesuai state, breakdown; sebagian gambar tabel biaya tambahan. |
| 0465-admin-tambah-shipment-fcl-contoh-data-form-kalkulasi-harga-normal-ada-asuransi.png | Tabel harga per kontainer; PPN/PPh, asuransi sesuai state, breakdown; sebagian gambar tabel biaya tambahan. |
| 0466-admin-tambah-shipment-fcl-review-data-ada-asuransi-normal.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0467-admin-detail-shipment-fcl-normal.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0469-admin-shipment-list.png | Tabel daftar dengan limit/pagination; menu aksi dan kolom customer/rute/harga; filter expanded khusus 0193. |
| 0470-admin-tambah-shipment-fcl-form-default.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| 0476-admin-tambah-shipment-fcl-contoh-data-form-kalkulasi-harga-normal-ada-asuransi.png | Tabel harga per kontainer; PPN/PPh, asuransi sesuai state, breakdown; sebagian gambar tabel biaya tambahan. |
| 0477-admin-tambah-shipment-fcl-review-data-ada-asuransi-normal.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0478-admin-detail-shipment-fcl-normal.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0479-admin-tambah-shipment-fcl-review-data-pop-up-alamat-pick-up.png | Modal alamat di atas overlay gelap; judul Alamat Pick Up; tombol Tutup. Nama file 0491 menyebut pickup tetapi konten drop off. |
| 0481-admin-shipment-list.png | Tabel daftar dengan limit/pagination; menu aksi dan kolom customer/rute/harga; filter expanded khusus 0193. |
| 0482-admin-tambah-shipment-fcl-form-default.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| 0488-admin-tambah-shipment-fcl-contoh-data-form-kalkulasi-harga-normal-ada-asuransi.png | Tabel harga per kontainer; PPN/PPh, asuransi sesuai state, breakdown; sebagian gambar tabel biaya tambahan. |
| 0489-admin-tambah-shipment-fcl-review-data-ada-asuransi-normal.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0490-admin-detail-shipment-fcl-normal.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0491-admin-tambah-shipment-fcl-review-data-pop-up-alamat-pick-up.png | Modal alamat di atas overlay gelap; judul Alamat Drop Off; tombol Tutup. Nama file 0491 menyebut pickup tetapi konten drop off. |
| 0493-admin-shipment-list.png | Tabel daftar dengan limit/pagination; menu aksi dan kolom customer/rute/harga; filter expanded khusus 0193. |
| 0494-admin-tambah-shipment-fcl-form-default.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| 0499-admin-tambah-shipment-fcl-form-contoh-data-barang-muatan-melebihi-kapasitas.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| 0500-admin-tambah-shipment-fcl-contoh-data-form-kalkulasi-harga-multipoint-ada-asuransi.png | Tabel harga per kontainer; PPN/PPh, asuransi sesuai state, breakdown; sebagian gambar tabel biaya tambahan. |
| 0501-admin-tambah-shipment-fcl-review-data-ada-asuransi-multipoint.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0502-admin-detail-shipment-fcl-multipoint.png | Ringkasan card rute/pengirim/penerima/barang/harga; bagian multi lebih panjang dengan relasi alamat. |
| 0515-shipment-step-4.png | Review empat step dengan dua pilihan simpan shipment/lanjut order. |
| 0516-form-order-lanjutan-ftl.png | Buat Order FTL: ringkasan shipment, tanggal permintaan muat, jenis/jumlah armada abu-abu, Batal/Simpan. |
| 0517-form-order-lanjutan-fcl.png | Buat Order FCL: ringkasan, kontainer readonly, kartu Direct/Connecting, detail kapal dan connecting, tambah baris. |
| 0518-action-menu-buat-order.png | Daftar Shipment; menu Detail, Buat Order, Edit, Hapus, Tambah Biaya, Riwayat Perubahan. |
| admin-shipment-tambah-shipment-air-freight-form-default-pengirim-perusahaan-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-shipment-tambah-shipment-air-freight-form-default.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-multidrop-pengirim-individu-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-multidrop-pengirim-individu-penerima-perusahaan.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-multidrop-pengirim-penerima-perusahaan.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-multidrop-pengirim-perusahaan-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-multipickup-multidrop-pengirim-individu-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-multipickup-multidrop-pengirim-individu-penerima-perusahaan.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-multipickup-multidrop-pengirim-penerima-perusahaan.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-multipickup-multidrop-pengirim-perusahaan-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-multipickup-pengirim-individu-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-multipickup-pengirim-individu-penerima-perusahaan.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-multipickup-pengirim-penerima-perusahaan.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-multipickup-pengirim-perusahaan-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-normal-pengirim-individu-penerima-perusahaan.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-normal-pengirim-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-normal-pengirim-penerima-perusahaan.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ftl-form-default-normal-pengirim-perusahaan-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-lcl-form-default-pengirim-individu-penerima-perusahaan.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-lcl-form-default-pengirim-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-lcl-form-default-pengirim-penerima-perusahaan.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-lcl-form-default-pengirim-perusahaan-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ltl-form-default-pengirim-individu-penerima-perusahaan.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ltl-form-default-pengirim-perusahaan-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ltl-form-default-pengirim-perusahaan.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| admin-tambah-shipment-ltl-form-pengirim-penerima-individu.png | Form Data Pengiriman: pilihan jenis, rute, customer dan alamat; variasi perusahaan/individu serta pickup/drop sesuai konten. Teks kecil dilengkapi dari spec. |
| buat-shipment-ltl-default.png | Default LTL: rute, Catatan Shipment maksimum 50 karakter; card customer belum muncul. |
| buat-shipment-ltl-loading.png | Loading Memeriksa tarif pengiriman...; Selanjutnya disabled. |
| buat-shipment-ltl-tarif-ada.png | Tarif ada: card pengirim dan penerima tampil. |
| buat-shipment-ltl-tarif-tidak-ada.png | Alert tarif belum diatur; Atur Tarif dan Muat Ulang; Selanjutnya disabled. |
| buat-shipment-step-2-info.png | Data Barang: helper data satuan/rate, asuransi conditional, baris tambah/hapus dan total bawah. |

### Batas scope UI

Menu Proses Invoice, Klaim Asuransi dan Tambah HPP terlihat pada desain lama, tetapi workflow-nya tidak dijelaskan. Hanya dampak keberadaan invoice/HPP pada edit harga dicakup. Navigasi aplikasi global (notifikasi, akun, kuota) bukan requirement shipment. UI batch, modal customer, edit harga khusus dan Tambah Order via menu diturunkan dari teks.

## Assumptions Log

1. Prioritas sumber: penyesuaian terbaru dan dokumen-tambahan2.txt mengungguli aturan umum yang bertentangan; desain dipakai untuk UI, bukan mengganti aturan terbaru.
2. FTL/FCL memiliki empat step, Simpan Shipment dan Simpan & Lanjut ke Order menyimpan Draft. LTL/LCL/Air memakai Simpan dan status aktif sesuai aturan umum.
3. Dokumen order menyebut shipment tetap Draft setelah order sukses tetapi juga Sudah Diorder. Status Draft dipertahankan literal; keberadaan relasi order menjadi pengaman aksi Buat Order dan relasi 1:1. Perlu pemetaan status implementasi sebelum codegen.
4. Nilai nol Berat/Dimensi/Jumlah barang diterima sesuai aturan TIDAK ADA PROTEKSI NILAI 0; angka negatif/nonnumerik ditolak. Jumlah Armada/Kontainer minimum 1, Nilai Barang diasuransikan dan Harga Armada tetap >0. Jumlah barang diasumsikan bilangan bulat.
5. Berat/P/L/T wajib mengikuti master rate untuk LTL/LCL/Air; nilai opsional kosong tidak dianggap data invalid. FTL memakai data valid positif pada baseline; tidak mengasumsikan rate otomatis FTL.
6. Kubikasi selalu P×L×T×Qty/1000000; total berat LTL/LCL/Air = berat satuan×Qty. KGV dibulatkan ke atas per satuan lalu dikali Qty; pembagi 4000 hanya fixture tarif, bukan konstanta universal.
7. Komponen asuransi mengikuti konfigurasi fixture; 0,2% digunakan untuk contoh FTL dan pengujian hitung, bukan persentase universal. PPN/PPh 11%/2% hanya data uji matematis, bukan ketentuan perpajakan.
8. Duplikasi customer memakai WA yang dinormalisasi untuk kedua pihak; pilih existing tanpa record duplikat. Opsi lanjut simpan duplikat tidak diasumsikan tersedia.
9. Tambah Pengirim/Penerima diasumsikan tersedia pada kedua mode mengikuti extras; modal individu terkunci Individu. Field wajib perusahaan tambahan tidak didefinisikan sehingga hanya alur minimal tanpa legalitas yang diuji.
10. Pickup/Drop Off 1 dan 2 dipertahankan sebagai minimum dua pada mode multi; hanya baris ketiga dan seterusnya dapat dihapus. Reorder tidak wajib dan tidak dijadikan acceptance criterion.
11. Kode Pos tetap wajib numerik walaupun autofill. Tidak menetapkan panjang min/maks WA, alamat, kode pos karena tidak ada di sumber; nomor fixture domestik 12 digit digunakan sebagai contoh valid.
12. Autofill penerima editable diuji dengan konfigurasi enabled; konfigurasi disabled diuji terpisah. Perubahan lokal tidak mengubah master.
13. Alert PHP pada Batal ditafsirkan konfirmasi buang isian lalu kembali daftar. Label konfirmasi yang tidak terbaca adalah usulan selector dan pesan validasi nonliteral diperiksa semantis.
14. Pengecekan tarif Step 1 diterapkan pada LTL/LCL/Air yang memakai master tarif. FTL/FCL harga manual tidak diwajibkan memiliki tarif rute tanpa dukungan tambahan.
15. FCL dicakup sesuai penyesuaian, gambar dan form order extras; detail rule create FCL yang tidak didefinisikan tidak disamakan seluruhnya dengan FTL. Fixture shipment FCL valid dipersiapkan untuk Review, quantity dan order.
16. Batch diuji dengan fixture tiga record dan mode partial/full reject eksplisit; format upload, batas maksimum dan API tidak tersedia. Proses Batch adalah target abstrak yang perlu dipetakan sebelum eksekusi.
17. Aktor adalah admin berizin shipment/order/master. Matriks role dan akses lintas tenant tidak dijelaskan; tidak membuat role atau hak akses baru.
18. Alasan Perubahan Data diasumsikan wajib untuk edit harga; audit menyimpan aktor/waktu/nilai lama-baru/alasan. Soft delete dibuktikan lewat fixture read-only backend pada codegen.
19. Kewajiban droppoint, pelabuhan dan bandara diambil dari kebutuhan rute masing-masing; master yang hilang menghambat simpan. Estimasi waktu kosong ditampilkan - sebagai fallback.
20. Data fixture, pesan error semantis, URL, locator, pengaturan jaringan, tab baru, cetak dan query persistensi perlu binding pada aplikasi saat codegen; file ini bukan hasil menjalankan Playwright. Semua testid adalah usulan.
21. Stress memakai beban sintetis 100 baris atau 20 sesi tanpa SLA waktu yang tidak disebut sumber; oracle adalah integritas data, isolasi dan pemulihan. Pengujian kegagalan memakai injeksi respons terkontrol.
22. Close tab direpresentasikan action navigate dengan target abstrak lifecycle; klik target disabled adalah verifikasi tidak dapat diaktifkan, bukan click Playwright yang menunggu sampai timeout. Ekspektasi terstruktur action expect perlu diterjemahkan ke assertion sesuai teks.
23. Airfreight yang tertulis LTL dan duplikasi blok dianggap salah salin; hanya satu set requirement Air Freight. LCL tidak diasumsikan mendukung multipickup.
24. Desain terbaru Catatan Shipment menunjukkan maksimum 50 karakter termasuk spasi; batas ini hanya berlaku untuk Catatan Shipment, bukan seluruh alamat atau catatan per pihak.
25. Desain menunjukkan Jenis Pengiriman dan Jenis Jadwal Kapal sebagai kartu radio: codegen memakai check/getByRole(radio), bukan selectOption. Aksi select pada dropdown custom juga perlu adapter sesuai DOM.
26. Desain 0491 berisi Alamat Drop Off meski nama file pickup; 0236 berisi Detail Shipment LCL meski nama file form LTL. Isi visual diutamakan untuk klasifikasi. Ikon hapus baris kedua pada desain lama tidak mengganti minimum dua dari spec.
27. Mockup angka kubikasi/harga tidak dijadikan oracle hitung bila bertentangan dengan formula spec. Detail jam pada date control perlu adapter; fixture ISO memuat waktu untuk menguji urutan tanggal secara konsisten.
28. Kasus timeout setelah commit dan retry mengharapkan tidak ada duplikasi untuk satu intent sebagai asumsi integritas. Kontrak idempotency aktual belum disediakan; adapter harus menggunakan mekanisme implementasi yang tersedia.
