# Keputusan eksekusi dan triage

## 2026-09-10 — test-module shipment, run 20260910-182207

- User menyetujui 305 nonstress; 14 stress tetap dilewati. Hasil: 10 passed, 4 failed terhadap skenario, 291 blocked karena baseline fixture belum tersedia. Rincian: results/_triage__shipment__20260910-182207.md.
- Sumber shipment memakai ID SHIPMENT-* dan requirement tunggal. Sumber tidak diubah. Salinan normalisasi + id-map disimpan di results/_shipment-run/; hasil mempertahankan ID asli dan memetakan requirement menjadi requirements array untuk laporan.
- Filter shipment awal collapsed (berbeda catatan harvest). Input dapat dianggap visible oleh Playwright meskipun panel tertutup dan klik tombol diintersep tabel/header. Buka Filter dahulu dan tunggu animasi/locator actionable; klik standar berhasil. Bukan alasan memakai dispatchEvent.
- Halaman batch awal hanya berisi pilihan jenis; kontrol impor tidak menjadi prasyarat assertion membuka halaman.
- Draft Buat Shipment bertahan saat navigasi/reload. Untuk menguji form baru, buang draft run melalui Batal → Ya; jangan menganggap page.goto menghasilkan draft kosong. Jangan membuang draft pengguna lain.
- Dialog konfirmasi Batal menggunakan Ya/Tidak; tunggu dialog hidden sesudah Tidak. Modal Tambah Customer tidak memakai role=dialog; scope ke parent heading Tambah Customer. Jenis Customer Individu berupa input disabled, bukan readOnly=true; kode pos juga dapat disabled.
- Fixture belum tersedia: pencarian SHP-UJI menghasilkan 0 data; PT Uji dan PT Tujuan tidak ada dalam pencarian dropdown; armada CDD Aktif dan kontainer 20 DRY tidak ada di opsi. Daftar aktual 1296 data, bukan baseline 65. Jangan memaksakan baseline dengan mengubah data existing atau setting tenant.
- Dua kegagalan pembatalan modal customer merupakan satu dugaan akar bug (REQ-021). Tambah Penerima yang hilang dan konfirmasi Batal pada form kosong perlu validasi sumber requirement; bukan design gap terkonfirmasi. Path spec/extras rujukan tidak tersedia.
- Tidak dibuat shipment/customer/master permanen. Draft lokal run sudah dibuang. Sisa kerja: siapkan dataset/seed terisolasi beserta pemetaan fixture, lalu uji ulang 291 blocked dan recheck temuan dalam run baru.

## 2026-09-11 — Penyelesaian harvest selector shipment

- Bukti browser dikumpulkan 2026-09-10, dokumentasi selesai 2026-09-11. Peta `shared/selector-map-shipment.md` diganti dengan hasil refresh: 14 layar/komponen, 25 state DOM, 182 definisi selector (104 stabil, 78 struktural/tidak stabil). Definisi dihitung per baris tabel, bukan setiap instance data.
- Empat layar dilewati: wizard Data Barang/Kalkulasi Harga/Review yang membutuhkan draft valid, serta konfirmasi Hapus pada data existing. Representasi barang/kalkulasi pada Edit FTL dan LTL dipetakan tersendiri, bukan dianggap identik dengan wizard.
- Selector role untuk Aksi sah karena button memiliki title=Aksi; scope row dengan ID shipment menghasilkan count=1. Dropdown option wajib di-scope ke listbox agar tidak mengenai option native pagination yang hidden.
- Filter tanggal dan combobox ganda memakai parent label sebagai fallback; enam scope filter menghasilkan count=1. Parent accordion Data Pengirim/Data Penerima pada Edit menghasilkan masing-masing satu input PIC. Container struktural tetap ditandai tidak stabil meskipun count cocok.
- Refresh menemukan tombol Edit di Detail FTL Draf; tidak ada Sebelumnya/Selanjutnya pada sampel Edit FTL/LTL. Keterangan lama yang berbeda tidak boleh digunakan sebagai kondisi terkini.
- Awal Air Freight hanya kota asal/tujuan dan catatan; field lanjutan bandara/pihak belum diverifikasi karena memerlukan rute/tarif. Penerima Individu pada FTL Normal adalah input nama manual tanpa Tambah Penerima.
- Modal customer tidak memakai role=dialog. Input Jenis Customer disabled Individu; kode pos juga disabled. Scope melalui parent heading Tambah Customer, bukan input:disabled tanpa pembatas.
- Klaim memiliki ID stabil nominalKompensasi/keterangan dan label terhubung. Riwayat memakai link ← Kembali serta ID tanggal React dinamis dp-_r_0_ yang tidak boleh dijadikan selector tetap.
- Kalender Tanggal Dibuat menggunakan flatpickr dengan class rangeMode animate multiMonth inline dalam panel yang dibuka trigger; tidak memilih tanggal atau menguji auto-close ulang. Hasil H1/H3/H4/H5/H6 dicatat sesuai sampel, H2/H7 tidak diuji ulang.
- Tidak mengisi/menyimpan data bisnis. Pilihan jenis/mode hanya untuk membuka varian tampilan; draft lokal harvest ditutup lewat Batal → Ya. Halaman Edit existing hanya dibuka/dibaca. Tidak membuat fixture atau mengubah verdict test sebelumnya.
- Bukti dan hitungan: `artifacts/harvest/shipment-20260910-refresh/manifest.json`, `selector-summary.json`, JSON per state; arsip peta sebelumnya `selector-map-before.md`. Langkah lanjut: siapkan fixture terisolasi, lalu lengkapi selector wizard melalui eksekusi test yang berwenang.
