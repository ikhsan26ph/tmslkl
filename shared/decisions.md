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

## 2026-09-11 — test-module shipment, kategori positive, run 20260911-054225 (resume)

Run dijeda 054225 dilanjutkan via `/test-module shipment positive case`; hasil final 144/144 skenario
positive dieksekusi (116 passed, 16 failed, 12 blocked). Detail per skenario: `results/shipment__20260911-054225.json`.
Triage: `results/_triage__shipment__20260911-054225.md`. Poin di bawah adalah **fakta operasional
terverifikasi** (bukan asumsi fixture) agar run berikutnya (negative/edge/stress, atau re-run positive)
tidak perlu menebak/menemukan ulang — banyak berbeda dari `scenario/shipment/shipment.scenarios.json`
karena dokumen itu ditulis dari spec awal, bukan dari aplikasi nyata.

- **Rute dengan tarif master TERVERIFIKASI tersedia** (pakai ini, jangan pakai kota fixture generik "Jakarta"/"Bandung" — sebagian besar tidak ada tarif atau kotanya sendiri tidak ada di master sebagai satu entri):
  FTL Surabaya–Medan · FCL Surabaya–Balikpapan · LTL Surabaya–Bangkalan (basis **Flat** Rp500.000, requiredness Berat/dimensi TIDAK ditegakkan — lihat bug candidate POS-037/038/039) · LTL Surabaya–Balikpapan (basis **Per-m3** Rp15.000/m3) · LCL Surabaya–Balikpapan (basis **Per-kg** Rp500.000/kg, Berat wajib/dimensi opsional, requiredness bekerja benar) · Air Freight Surabaya–Samarinda (basis **Per-kg** Rp560.000/kg, Berat+Panjang+Lebar+Tinggi SEMUA wajib). Rute LTL Surabaya–Jakarta Pusat sengaja TIDAK ada tarif (pakai utk skenario "tarif belum diatur").
- **Customer & Drop Point yang benar-benar ada** (fixture generik seperti "PT Uji"/"PT Tujuan"/"Budi Existing" tidak ada di master): customer Perusahaan "PT. H3 IK" (satu-satunya match pencarian "PT. H3"), Drop Point-nya: IK - ST. Gubeng & IK - Kenjeran (Surabaya), IK - Medan & IK - Medan Tempur (Medan), IK - Balikpapan, IK - Samarinda tes. Customer Individu run ini: "AUTOTEST-20260911-054225-Budi Baru" dan "...-Budi Manual" — pakai ulang, jangan buat duplikat.
- **Master lain yang tidak match fixture**: armada FTL aktif hanya "Colt Diesel Double CDD Box" (fixture "CDD Aktif"/"Truk CDD" tidak ada; ada 1 entri "Truck Non Aktif" berstatus Tidak Aktif yang memang tidak muncul di dropdown). Kontainer FCL nyata: "20 Feet"/"40 Feet"/"40 Feet HC"/"45 Feet HC" (bukan "20 DRY"). Tipe Pengiriman FTL nyata hanya 4: Normal/Multipickup/Multidrop/**Multipoint** — TIDAK ADA opsi "Multipickup-Multidrop" seperti ditulis di banyak skenario fixture; gunakan "Multipoint" sebagai padanan (menggabungkan N pickup × M dropoff, Data Barang mewajibkan tiap kombinasi diisi).
- **Alur Order dari Shipment**: Simpan Order menampilkan modal pilihan "Daftar Order"/"Penugasan" (bukan auto-redirect). Di halaman `/order/buat?shipmentId=...`, Shipment Muatan FTL pakai radio `name="shipment-picker"`, FCL pakai radio `name="shipmentFCL"` (beda nama grup), sedangkan LTL/LCL/Air Freight pakai **checkbox** (mendukung konsolidasi banyak shipment rute sama dalam satu order — REQ-071 terverifikasi bekerja). Tombol Direct/Connecting di form order-dari-shipment adalah `<button>` teks biasa (beda dari radio native `#fcl-jadwal-direct` yang didokumentasikan untuk form Buat Order kosong). Tombol hapus baris Kapal Connecting = `button[title="Hapus baris"]`.
- **Edit Harga**: gating sebenarnya berbasis **keberadaan invoice**, BUKAN status order — shipment status "Proses Order" (sudah ada order, belum invoice) tetap bisa Edit Harga penuh (field Harga/PPN/PPh/Biaya Tambahan/Alasan Perubahan Data); begitu invoice dibuat, Edit disabled dengan title "Harga tidak dapat diubah karena invoice sudah dibuat". Jangan pakai dugaan lama "order mengunci total" (sudah direklasifikasi TEST ISSUE di triage, lihat rekonsiliasi POS-057 vs POS-056).
- **Tombol konfirmasi**: dialog Batal & Hapus pakai label "Ya"/"Tidak" dan "Batal"/"Hapus" — BUKAN "Konfirmasi Batal"/"Konfirmasi Hapus" seperti banyak `selectorHints` di scenarios.json. Modal tetap tanpa `role="dialog"` (H5 konsisten).
- **Gap UI terkonfirmasi (bukan per-jenis, satu root cause)**: tombol "Cetak Resi" tidak ada di layar Detail Shipment untuk LTL/LCL/Air Freight manapun — fungsi resi konsolidasi hanya bisa diakses dari Daftar Shipment → Aksi → "Lihat Resi" (label aktual, bukan "Cetak Resi"). Field "Premi Asuransi" readonly tidak pernah dirender di Data Barang pada skenario asuransi manapun. Batch Shipment (import Excel) hanya mendukung mode full-reject (1 baris invalid memblokir seluruh upload) — tidak ada mode partial meski Preview mendeteksi valid/invalid per baris dengan benar. Detail lengkap & severity: lihat file triage di atas.
- Data permanen dibuat run ini (tidak dihapus, boleh dipakai ulang sbg data existing di run berikutnya): shipment SHP26090040/046–077 (berbagai jenis/status, termasuk beberapa yang sudah ber-order), customer "AUTOTEST-20260911-054225-Budi Baru"/"...-Budi Manual". SHP26090061 sudah di-soft-delete (ada di Riwayat Penghapusan, jangan dipakai sbg data aktif).
- Belum dieksplorasi: modul Penugasan Tracking (`/penugasan-tracking`) — diperlukan utk membangun precondition status order "Proses Pengiriman"/"Terkirim" (6 skenario blocked krn ini: POS-056/058/100/102/103/144). Selector-nya belum dipetakan; jangan menebak langkah/selector di sana sebelum di-harvest.

## 2026-09-12 — test-module shipment, kategori edge, run 20260912-183355

Filter user "shipment edge case" → 22/22 skenario edge dieksekusi (11 passed, 8 failed, 3 blocked).
Detail: `results/shipment__20260912-183355.json`. Triage: `results/_triage__shipment__20260912-183355.md`.

- **4 BUG (probable) baru**: EDG-003 dialog konfirmasi Batal tetap muncul walau form benar-benar kosong (REQ-007); EDG-007 field Panjang Data Barang menghapus titik desimal ("20.5"→"205" terverifikasi via `inputValue()`, merembet ke Kubikasi/KGV/harga — REQ-029, severity major); EDG-015 PPN/PPh kosong ternyata field required (blocking) dan baris breakdown tetap tampil walau kosong (REQ-045); EDG-020 submit order ditolak saat ETD disamakan Closing Time — sistem pakai pembanding ketat `>` bukan `>=` (REQ-067, severity major).
- **4 DESIGN GAP (pola sistemik, sama root cause)**: EDG-008/009/010 — Panjang/Berat/Jumlah Data Barang semua menolak nilai 0 sebagai "harus diisi" (Kubikasi/Berat tetap tampil 0 dengan benar, bukan NaN, tapi wizard terblokir), bertentangan dengan Assumptions Log #4 `shipment.analysis.md` yang menyatakan 0 seharusnya diterima. EDG-014 — KGV tidak dibulatkan ke atas ke kg bulat (REQ-038/044): volume 12.001 cm3 seharusnya 4kg, aktual berat tertagih kontinu ~2,00017kg; dikuatkan silang dengan EDG-013 (passed) yang membuktikan formula dasar (tanpa pembulatan) sudah benar secara proporsional — sistem nyata memakai berat tertagih kontinu, bukan ceiling. Perlu klarifikasi produk sebelum dianggap bug pasti.
- **3 blocked, semua beralasan valid (bukan bug)**: EDG-001 (butuh 45 data filter LTL, nyata 369 dari 1344 total), EDG-002 (butuh 65 data & customer "PT O'Brian & Anak" yang tidak ada di data nyata), EDG-006 (Kode Pos Pengirim disabled/read-only auto-derive dari Drop Point pada FTL Normal Perusahaan, toggle Individu tidak ada sama sekali di FTL Normal — tidak ada jalur UI manual). Tidak ada data masif dibuat untuk memaksakan precondition ini, sesuai batasan `docs/agent-guide.md`.
- **Rute/master tambahan yang terverifikasi ada** (di luar yang sudah dicatat 2026-09-11): LTL Kota Semarang→Kota Surabaya (tarif Rp42.300/kg, dipakai utk EDG-013/014 karena Surabaya-Jakarta fixture tidak bertarif); FTL/LTL Kota Surabaya (GC - BRT - Royal Plaza)→Kabupaten Bangkalan (VER - BKL) dipakai utk EDG-015/016/017. Kartu jadwal Direct/Connecting di form order-dari-shipment FCL adalah `button[aria-pressed]` (bukan radio native).
- **Concurrency 2 tab (EDG-021)**: multi-page dalam satu browser context TERSEDIA lewat tool `browser_tabs` (new/select) + `page.context().pages()` pada run-code MCP sesi ini — bukan kasus H2 (tidak memindah storageState antar context terpisah), tidak melanggar `workers:1`. Hasil: tab pertama yang submit berhasil buat order, tab kedua ditolak dengan pesan "sudah dipakai pada order"; hanya 1 POST /api/orders (201) tercatat — indikasi guard client-side, bukan race di server.
- Data permanen dibuat run ini (tidak dihapus): shipment SHP26090089 (LTL, 3 item, dipakai verifikasi Lihat Resi), SHP26090090 (FTL, dipakai EDG-018 lalu di-order via EDG-021 jadi FTL9216652623), SHP26090091 (FCL, di-order via EDG-019), SHP26090092 (FCL, gagal diorder di EDG-020 karena validasi tanggal — tetap Draft).
- 4 temuan DESIGN GAP dan 2 BUG baru (EDG-015/EDG-020) belum tercatat sebelum run ini — sudah ditambahkan di atas.

## 2026-09-12 — Seed data 11 shipment (semua jenis & tipe pengiriman), atas permintaan user langsung

Bukan run test-module — pembuatan data nyata (Draft) untuk seed/reuse. Semua field teks bebas prefix `AUTOTEST-20260912-`. Tidak ada data existing yang diubah/dihapus.

| Jenis | Tipe | Rute | Nomor |
|---|---|---|---|
| FTL | Normal | Surabaya (IK - ST. Gubeng) → Medan (IK - Medan) | SHP26090093 |
| FTL | Multipickup | 2 pickup Surabaya (ST. Gubeng, Kenjeran) → Medan (IK - Medan) | SHP26090094 |
| FTL | Multidrop | Surabaya (ST. Gubeng) → 2 drop Medan (IK - Medan, IK - Medan Tempur) | SHP26090095 |
| FTL | Multipoint | 2 pickup Surabaya × 2 drop Medan (4 kombinasi) | SHP26090096 |
| FCL | Normal | Tanjung Perak (Surabaya) → Balikpapan, kontainer 20 Feet | SHP26090097 |
| FCL | Multipickup | 2 pickup Surabaya → Balikpapan (IK - Balikpapan) | SHP26090098 |
| FCL | Multidrop | Surabaya → 2 drop (IK - Balikpapan, IK - Samarinda tes) | SHP26090099 |
| FCL | Multipoint | 2 pickup Surabaya × 2 drop (Balikpapan, Samarinda) | SHP26090100 |
| LTL | Normal | Kota Surabaya (ST. Gubeng) → Kab. Bangkalan (VER - BKL), tarif Flat 500rb | SHP26090101 |
| LCL | Normal | Kota Surabaya (ST. Gubeng) → Kota Balikpapan (IK - Balikpapan), tarif per-kg 500rb/kg | SHP26090102 |
| Air Freight | Normal | Kota Surabaya (Kenjeran) → Kota Samarinda (IK - Samarinda tes), tarif per-kg 560rb/kg | SHP26090103 |

- **Tipe Pengiriman FCL TERVERIFIKASI SAMA dengan FTL**: dropdown "Pilih Tipe Pengiriman" pada FCL juga punya 4 opsi Normal/Multipickup/Multidrop/Multipoint (sebelumnya hanya FTL yang terverifikasi, lihat entri 2026-09-11).
- **Data Barang pada Multipickup/Multidrop**: 1 baris data barang per titik pickup/drop (2 baris). **Multipoint**: 4 baris (kombinasi 2 pickup × 2 drop), sesuai catatan lama "tiap kombinasi wajib diisi".
- Drop Point berbeda kota dari pelabuhan/kota tujuan rute DITERIMA sistem tanpa validasi penolakan (dipakai utk FCL Multidrop/Multipoint: drop point Samarinda dipakai walau rute dasar/tarif basisnya Surabaya–Balikpapan) — Drop Point hanya menentukan alamat detail, bukan basis tarif.
- **LCL ternyata mewajibkan Pelabuhan Asal & Pelabuhan Tujuan** (bukan hanya kota) — field ini tidak tercatat di entri sebelumnya.
- **Air Freight mewajibkan Bandara Asal & Bandara Tujuan**; ongkos kirim rute Surabaya–Samarinda (6kg, tarif 560rb/kg) menghasilkan Rp4.500.000 — lebih tinggi dari perkiraan linear (6×560rb=3.360.000), indikasi ada komponen minimum charge/volumetrik pada rute ini yang belum diaudit (bukan dianggap bug, sekadar catatan untuk investigasi lanjutan bila relevan).
- Drop Point IK - Kenjeran / IK - Samarinda tes sudah punya Catatan bawaan dari master data ("Catatan awas begal motor" dll.) — bukan input dari seed ini, jangan bingung sebagai data buatan run ini saat baca ulang.

## 2026-09-12 — Alur Shipment → Order → Penugasan berhasil dituntaskan (modul Penugasan Tracking kini terpetakan)

Atas permintaan user: buat order dari shipment seed SHP26090093 (FTL Normal, Surabaya→Medan) lalu lanjut penugasan sopir dgn WA `6283830011881`. Berhasil end-to-end, tanpa mentok. Screenshot dokumentasi: `artifacts/screenshots/20260912-order-penugasan/`.

- **Order**: dari Daftar Shipment → Aksi → "Buat Order" → `/order/buat?shipmentId=...`. FTL hanya wajib **Tanggal Permintaan Muat** (datetime custom, sama seperti H4). Simpan → Order **FTL9225168972** dibuat (`POST /api/orders` 201) → modal "Order Berhasil Dibuat" dgn tombol **Daftar Order**/**Penugasan** (konsisten catatan 2026-09-11).
- **Modul Penugasan Tracking (`/penugasan-tracking`) kini terpetakan** — sebelumnya "belum dieksplorasi". Klik "Penugasan" di modal → `/penugasan-tracking/tambah?orderCode=<kode>`, judul "Tambah Penugasan". Struktur form:
  1. **Pilih Order*** — prefilled dari query param, ringkasan read-only (rute/jenis armada/jumlah armada/pengirim).
  2. Per unit armada dibutuhkan ("Armada N"): **Pilih Armada*** (`getByPlaceholder('Cari armada...')` + tombol teks gabung `NOPOL(JenisArmada)`, list tidak otomatis difilter by jenis) & **Pilih Sopir*** (`getByPlaceholder('Cari sopir...')` + tombol teks gabung `NamaSopirNoWA` tanpa pemisah, mis. `"Muhaimin6283830011881"`).
  3. **Mode Penugasan*** — kartu "Tugaskan ke Sopir" (tampil di Driver Hub app) vs "Tugaskan ke Pengurus" (hanya web).
  4. **Pilih PIC Penugasan*** — `getByPlaceholder('Cari PIC...')` + tombol "Pilih Semua" + daftar tombol teks gabung `Nama NoTelp • Role`.
  5. Simpan → memicu **modal konfirmasi kedua "Konfirmasi Penugasan"** (temuan baru, belum tercatat sebelumnya) dgn tombol "Periksa Kembali"/"Simpan" — WAJIB scope tombol Simpan modal ini terpisah dari Simpan form utama (ada 2 tombol "Simpan" di DOM bersamaan, ambigu kalau pakai exact-name tanpa scope). Submit final → `POST /api/penugasan` 201, redirect ke list `/penugasan-tracking` dgn status "Belum Berangkat".
  6. 0 `role="dialog"` pada kedua modal (konsisten H5); 0 `data-testid` di seluruh form (konsisten H6).
- **Sopir WA `6283830011881` = "Muhaimin"**, ditemukan langsung tanpa filter di list Pilih Sopir. Hati-hati nomor mirip tapi BEDA yang juga ada di list: `Ikhsan628383001188132` (ada suffix 32), dan di kolom PIC ada `IK ShopR083830011881222`/`Aamsubuser 083830011881` (tanpa prefix 62 dan/atau suffix beda) — jangan asal cocok substring, harus exact match nomor penuh.
- **Catatan teknis datetime picker**: pada popup jam/menit (scroll list), `element.click()` mentah via `page.evaluate()` TIDAK memicu handler React (nilai tetap 00:00) — harus pakai `locator.click()` Playwright asli. Ini bukan H1 (yang soal `dispatchEvent` vs `click()` standar); nuansa baru khusus komponen scroll-picker jam/menit.
- Data dibuat run ini (permanen, boleh dipakai reuse): Order **FTL9225168972** (dari shipment SHP26090093, kini status shipment "Proses Order"), 1 penugasan sopir Muhaimin + PIC "basyir", armada **A22S (Colt Diesel Double CDD Box)**.
