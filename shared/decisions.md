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

## 2026-09-13 — Seed data 11 shipment (batch 2), atas permintaan user langsung

Bukan run test-module — pembuatan data nyata (Draft) untuk seed/reuse, mengulang playbook 2026-09-12 dengan
prefix `AUTOTEST-20260913-`. Dikerjakan langsung oleh agent utama (bukan didelegasikan) di satu sesi browser
berkelanjutan; sempat ada percobaan delegasi ke subagent terpisah yang dihentikan sebelum sempat mengisi/submit
data apa pun (0 shipment dibuat oleh subagent tsb, terverifikasi via laporan berhentinya). Tidak ada data
existing yang diubah/dihapus.

| Jenis | Tipe | Rute | Nomor |
|---|---|---|---|
| FTL | Normal | Surabaya (IK - ST. Gubeng) → Medan (IK - Medan) | SHP26090104 |
| FTL | Multipickup | 2 pickup Surabaya (ST. Gubeng, Kenjeran) → Medan (IK - Medan) | SHP26090105 |
| FTL | Multidrop | Surabaya (ST. Gubeng) → 2 drop Medan (IK - Medan, IK - Medan Tempur) | SHP26090106 |
| FTL | Multipoint | 2 pickup Surabaya × 2 drop Medan (4 kombinasi) | SHP26090107 |
| FCL | Normal | Tanjung Perak (Surabaya) → Balikpapan, kontainer 20 Feet | SHP26090108 |
| FCL | Multipickup | 2 pickup Surabaya → Balikpapan (IK - Balikpapan) | SHP26090109 |
| FCL | Multidrop | Surabaya → 2 drop (IK - Balikpapan, IK - Samarinda tes) | SHP26090110 |
| FCL | Multipoint | 2 pickup Surabaya × 2 drop (Balikpapan, Samarinda) | SHP26090111 |
| LTL | Normal | Kota Surabaya (ST. Gubeng) → Kab. Bangkalan (VER - BKL), tarif Flat 500rb | SHP26090112 |
| LCL | Normal | Kota Surabaya (ST. Gubeng) → Kota Balikpapan (IK - Balikpapan), tarif per-kg 500rb/kg | SHP26090113 |
| Air Freight | Normal | Kota Surabaya (Kenjeran) → Kota Samarinda (IK - Samarinda tes), tarif per-kg 560rb/kg | SHP26090114 |

- **TEMUAN PENTING — Drop Point "VER - BKL" BUKAN milik PT. H3 IK.** Saat isi Data Penerima LTL, drop point
  Bangkalan yang muncul untuk customer PT. H3 IK hanya varian "IK - Drop Madura 1-4" dan "IK - Bangkalan
  Intern" — tidak ada "VER - BKL". Dicek langsung ke `/master/drop-point` (cari "VER - BKL"): drop point ini
  milik customer **PT. Verstappen** (alamat Burneh, Kabupaten Bangkalan). Jadi untuk shipment #9, Data Penerima
  memakai company **PT. Verstappen** (bukan PT. H3 IK). Perhatian tambahan: ada DUA customer dengan nama mirip
  di picker — "PT. Verstappen" dan "PT. Verstappen1" — harus pilih yang **tanpa suffix angka** agar cocok
  dengan pemilik drop point tsb (dikonfirmasi lewat exact match master data, bukan tebakan). Update pengetahuan
  dari entri 2026-09-11: TIDAK SEMUA drop point bernama "sesuatu - Kota" otomatis milik PT. H3 IK; drop point
  ber-prefix "IK" (IK - ST. Gubeng/Kenjeran/Medan/Medan Tempur/Balikpapan/Samarinda tes) memang punya PT. H3 IK,
  tapi drop point ber-prefix lain (mis. "VER -") kemungkinan besar milik customer lain — selalu verifikasi
  lewat Master Drop Point kalau recipient company tidak jelas, jangan asumsikan.
- **Perusahaan berfungsi penuh untuk Penerima FTL Normal** — kekhawatiran di brief (kemungkinan perlu fallback
  individu manual untuk penerima FTL Normal, berdasar catatan lama selector-map) TERNYATA TIDAK TERJADI pada
  run ini: tombol "Pilih Penerima" dengan Jenis Penerima "Perusahaan" (default) berhasil memilih PT. H3 IK
  langsung untuk seluruh FTL/FCL (semua varian) dan LCL/Air Freight tanpa hambatan. Fallback individu manual
  tidak diperlukan sama sekali di run ini.
- **PIC/WA/Alamat Pengirim & Penerima auto-terisi dari Drop Point** begitu drop point dipilih (nama PIC =
  nama drop point/pemilik, WA & alamat ikut master) — field tetap editable tapi tidak perlu diisi manual,
  konsisten dengan temuan EDG-006 sebelumnya (auto-derive dari Drop Point).
- **Tombol submit akhir LTL/LCL/Air Freight = "Simpan" saja** (bukan "Simpan Shipment" + "Simpan & Lanjut ke
  Order" seperti FTL/FCL) — hanya satu tombol, tidak ada opsi lanjut ke Order di titik ini untuk ketiga jenis
  tsb.
- **Ongkos Kirim LTL/LCL/Air Freight OTOMATIS terhitung dari tarif master** begitu Data Barang diisi (baris
  tabel Kalkulasi Harga berupa teks, bukan input) — beda dari FTL/FCL yang mewajibkan isi manual field
  "Ongkos Kirim/Harga" per armada/kontainer (placeholder "0", wajib diisi manual, dipakai 3.000.000/5.000.000
  pada run ini untuk FTL/FCL secara berurutan, nilai arbitrer non-nol).
- **LCL Normal menghasilkan harga besar (Rp113.750.000)** karena basis per-kg dikalikan Berat(50kg) ×
  Jumlah/Karton(5) = 250kg tertagih pada tarif Rp500.000/kg — bukan bug, hanya konsekuensi kombinasi
  berat+jumlah yang dipilih; sekadar catatan agar tahap berikutnya tidak bingung melihat total harga tinggi.
- **Master Bandara berisi sangat banyak entri uji/QA/data-quality-test** (XSS payload literal, nama sangat
  panjang, karakter Unicode, banyak varian "Test IATA ...") bercampur dengan bandara asli — dipilih
  "Juanda International" (Surabaya) dan opsi "Samarinda" (exact match tunggal) dengan hati-hati. Juga ada
  drop point mirip-tapi-beda untuk Samarinda: "IK - Samarinda tes" (dipakai, sesuai task) vs "IK - Samrinda"
  (typo, drop point terpisah) — jangan tertukar.
- **Master Kontainer FCL** masih mengandung 1 entri sampah "asda" di antara 20 Feet/40 Feet/40 Feet HC/45 Feet
  HC (konsisten dengan pola data-quality yang sama di area master lain, bukan temuan baru).
- Data dibuat run ini (permanen, tidak dihapus, boleh dipakai reuse di tahap order+penugasan berikutnya):
  shipment SHP26090104–SHP26090114 (11 shipment, semua status Draft). Tidak ada shipment/customer/master baru
  lain yang dibuat di luar 11 ini.

## 2026-09-13 — Buat 1 Order dari masing-masing 11 shipment batch 2, atas permintaan user langsung

Dikerjakan langsung oleh agent utama (browser Playwright MCP, bukan didelegasikan). Seluruh 11 shipment
seed SHP26090104–SHP26090114 berhasil di-order (0 gagal). Semua shipment terverifikasi berubah status ke
"Proses Order" via query tabel Daftar Shipment setelah selesai. Tidak ada shipment/order yang dihapus atau
dibatalkan; Penugasan sama sekali tidak disentuh (sesuai batasan tugas).

- **TEMUAN PENTING — Kebab Aksi shipment LTL/LCL/Air Freight status Draf TIDAK memiliki opsi "Buat Order"
  sama sekali** (terverifikasi 3x: SHP26090112/113/114), berbeda dari asumsi awal (dan berbeda dari FTL/FCL
  yang selalu punya "Buat Order" di kebab). Item aktual di dropdown ketiganya: Detail, Edit, Hapus,
  **Lihat Resi**, Proses Invoice (disabled, title "Shipment belum ditugaskan"), Tambah Biaya, Riwayat
  Perubahan. Alur yang benar untuk LTL/LCL/Air Freight: buka `/order/buat` **kosong** (bukan
  `?shipmentId=...`), klik kartu jenis shipment yang sesuai, isi Detail Rute (LTL/Air Freight: Kota Asal
  & Kota Tujuan via combobox search; LCL: Pelabuhan Asal & Pelabuhan Tujuan) — begitu terisi, section
  "Shipment Muatan *" menampilkan checkbox shipment yang cocok rute (bukan radio seperti FTL/FCL), centang
  checkbox shipment target lalu lengkapi field lain yang muncul. FTL/FCL tetap memakai jalur asli (kebab →
  "Buat Order" → `/order/buat?shipmentId=...` prefilled, radio bukan checkbox) — dua alur ini TIDAK bisa
  disamakan, executor wajib mengecek kebab dulu sebelum asumsi shipmentId-prefill berlaku untuk semua jenis.
- **Field wajib LTL (baru pertama kali dituntaskan)**: hanya **Tanggal Permintaan Muat*** dan
  **Jenis Armada*** (Berat Maksimal/Volume Maksimal tampil sebagai `input[disabled]` auto-terisi dari jenis
  armada, tanpa asterisk — tidak perlu diisi manual). Tidak ada field kapal/pelabuhan/bandara untuk LTL.
  Armada dipakai: "Colt Diesel Engkel CDE Box".
- **Field wajib LCL (baru pertama kali dituntaskan)**: Pelabuhan Asal*, Pelabuhan Tujuan*, Tanggal
  Permintaan Muat*, Jenis Kontainer*, Jenis Jadwal Kapal* (radio native `#jadwal-direct`/`#jadwal-connecting`,
  **sr-only, timeout via `locator.click()` biasa — WAJIB `el.click()` via `browser_evaluate`/JS langsung**,
  konsisten dengan catatan lama selector-map), lalu setelah Direct dipilih muncul **"Detail Kapal Utama"**
  dengan field IDENTIK FCL: Pelayaran*, Nama Kapal*, Voyage*, Closing Time* (datetime), **ETD*/ETA* TANPA
  JAM** (tanggal saja) — dikonfirmasi sesuai catatan SCR-04 lama. Rute dipakai: Tanjung Perak → Balikpapan
  (sama pasangan pelabuhan dengan FCL run ini), Pelayaran "Tanto", Jenis Kontainer "20 Feet".
- **Field wajib Air Freight (baru pertama kali dituntaskan)**: Kota Asal*/Kota Tujuan* (sama pola LTL, via
  combobox search) memicu banner segmen rute + **Bandara Asal*/Bandara Tujuan* auto-fill read-only**
  (disabled, terisi otomatis dari kota — "Juanda International"/"Samarinda" pada rute Surabaya→Samarinda),
  **Drop Point Bandara Asal*/Tujuan*** (combobox terpisah dari Bandara, WAJIB dipilih manual — dipakai
  "IK - Juanda" & "IK - Internal Samarinda Bandara", satu-satunya opsi tersedia untuk tujuan), Maskapai*
  (dipakai "Garuda"), Nomor Penerbangan* (teks bebas), **Berangkat (ETD)*/Tiba (ETA)* memakai jam PENUH**
  (beda dari LCL/FCL yang tanpa jam untuk field sejenis — dikonfirmasi ulang sesuai catatan lama), Tanggal
  Permintaan Muat*, Jenis Armada* (dipakai "Pickup Box"). Tidak ada Closing Time untuk Air Freight (beda
  dari FCL/LCL).
- **FCL (bukan pertama kali, tapi field lengkap baru benar-benar diisi run ini)**: alur `?shipmentId=...`
  prefilled — Direct/Connecting sudah default "Direct" terpilih (`button[aria-pressed]`, BUKAN radio native
  seperti form order-dari-shipment-kosong), lalu isi Tanggal Permintaan Muat*, Pelayaran* ("Tanto"), Nama
  Kapal*, Voyage*, Closing Time* (16/09 08:00), ETD* (17/09, TANPA jam), ETA* (20/09, TANPA jam). Pola
  ETD>Closing Time strict (>) dipatuhi dengan jeda 1 hari — tidak ada penolakan validasi tanggal sama
  sekali di keempat shipment FCL (Normal/Multipickup/Multidrop/Multipoint).
- **Gotcha eksekusi**: satu kali salah klik "Batal" alih-alih "Simpan" pada SHP26090109 (form FCL kedua)
  karena ref stale ter-cache dari step sebelumnya — form batal tanpa efek samping (tidak ada order/data
  tersimpan), diulang dari awal untuk shipment yang sama dan berhasil. Pelajaran: selalu `browser_find`
  ulang teks "Simpan" tepat sebelum klik final, jangan pakai ref lama dari observasi field sebelumnya.
- Datetime custom picker (`div[role="button"]`+grid `button.h-9.w-9` equivalent React) tetap tidak
  auto-close di seluruh 11 shipment — pola tutup via klik ulang trigger (bukan klik luar/Escape) konsisten
  dengan catatan lama, tidak ada regresi.
- Order yang dihasilkan (permanen, tidak dihapus): FTL9257598176 (SHP26090104), FTL9257716586
  (SHP26090105), FTL9257814208 (SHP26090106), FTL9257908572 (SHP26090107), FCL9258124380 (SHP26090108),
  FCL9258568401 (SHP26090109), FCL9258802280 (SHP26090110), FCL9259027250 (SHP26090111), LTL9259386438
  (SHP26090112), LCL9259783505 (SHP26090113), AFR9260203285 (SHP26090114). Semua tetap berstatus Draf →
  Proses Order pada shipment asal; tidak ada Penugasan yang dibuat/diproses.

## 2026-09-13 — Penugasan Tracking untuk 11 order batch 2, mode "Tugaskan ke Sopir" (6 berhasil, 5 blocked oleh desain form)

Dikerjakan langsung oleh agent utama (browser Playwright MCP, bukan didelegasikan) dalam satu sesi
berkelanjutan. Target: buat Penugasan untuk 11 order dari entri 2026-09-13 sebelumnya (FTL9257598176,
FTL9257716586, FTL9257814208, FTL9257908572, FCL9258124380, FCL9258568401, FCL9258802280, FCL9259027250,
LTL9259386438, LCL9259783505, AFR9260203285), sopir dgn WA `6283830011881` ("Muhaimin"), mode "Tugaskan ke
Sopir" untuk semua. Tidak ada order/shipment/penugasan yang dihapus atau dibatalkan.

- **Alur "+ Tambah Penugasan" tanpa query param** (beda dari alur modal langsung-setelah-simpan-order di
  entri 2026-09-12 yang pakai `?orderCode=...`): dari `/penugasan-tracking` klik tombol "+ Tambah Penugasan"
  → `/penugasan-tracking/tambah` **kosong**, heading "Pilih Order *" berisi field `getByPlaceholder('Cari
  order...')` + daftar tombol semua order yang belum ditugaskan (teks gabung `NomorOrder • Customer JenisShipment`
  + baris rute+armada), tanpa perlu mengetik apapun untuk order yang baru dibuat (langsung muncul di
  daftar teratas, urut dari order terbaru). Klik tombol order → form detail termuat di bawahnya (SPA,
  tidak reload halaman).
- **TEMUAN BARU PENTING — struktur form Penugasan berbeda berdasar tipe shipment (Armada vs Kontainer),
  BUKAN berdasar nama jenis (FTL/FCL/LTL/LCL/AFR) secara langsung**:
  - **Pola "Armada"** (heading `Armada 1`, dst mengikuti Jumlah Armada di ringkasan): `Pilih Armada*`
    (`getByPlaceholder('Cari armada...')`), `Pilih Sopir*` (`getByPlaceholder('Cari sopir...')`), **Mode
    Penugasan* dengan KEDUA kartu aktif** ("Tugaskan ke Sopir" dan "Tugaskan ke Pengurus", tidak disabled),
    lalu `Pilih PIC Penugasan*`. Dipakai oleh **FTL** (semua 4 varian — konsisten dgn entri 2026-09-12) DAN
    ternyata juga **LTL** dan **Air Freight** (baru pertama kali dituntaskan lewat Penugasan Tracking run
    ini, terverifikasi sama persis strukturnya dengan FTL, termasuk daftar armada/sopir yang identik/tidak
    difilter by jenis — konsisten H3).
  - **Pola "Kontainer"** (heading `Kontainer 1`): field `No. Kontainer` + `Nomor Segel` (keduanya textbox
    kosong opsional, tidak diisi run ini karena tidak wajib), **Mode Penugasan* HANYA punya SATU kartu
    "Tugaskan ke Pengurus" dan kartu itu ber-atribut `disabled` (sudah default terpilih, tidak bisa
    di-switch)** — **TIDAK ADA kartu "Tugaskan ke Sopir" sama sekali**, dan **TIDAK ADA field Pilih
    Armada/Pilih Sopir di mana pun pada form** (dikonfirmasi via `document.body.textContent` tidak
    mengandung "Pilih Armada"/"Pilih Sopir"/"Cari armada"/"Cari sopir"). Hanya `Pilih PIC Penugasan*` yang
    tersedia. Dipakai oleh **FCL (semua 4 varian: Normal/Multipickup/Multidrop/Multipoint)** dan **LCL**
    (Normal) — masuk akal karena keduanya container-based (LCL = "Less than Container Load", tetap
    dikelola per kontainer meski isi campuran). Diverifikasi individual utk kelima order ini (bukan
    asumsi dari 1 sampel) via cek `button.disabled`/heading `h3` sebelum submit apa pun.
  - Kesimpulan: pembeda flow Penugasan bukan "jenis shipment" (FTL/FCL/dst) melainkan **apakah shipment
    diukur per-armada (truck) atau per-kontainer**. Hipotesis lama (2026-09-12) yang mengasumsikan FCL
    mengikuti pola FTL **BERBEDA/TERBANTAH** — belum sempat dicatat sebagai H baru di CLAUDE.md karena tabel
    hipotesis di sana khusus warisan OMS; catat di sini sebagai temuan asli TMS.
- **5 order GAGAL/BLOCKED karena keterbatasan desain form** (FCL9258124380, FCL9258568401, FCL9258802280,
  FCL9259027250, LCL9259783505) — mode "Tugaskan ke Sopir" yang diminta user **tidak tersedia sama sekali**
  untuk order berbasis Kontainer, sehingga sopir Muhaimin (WA 6283830011881) tidak dapat ditugaskan lewat
  form ini untuk kelima order tsb. **Tidak dipaksakan submit dengan "Tugaskan ke Pengurus"** (mode itu ada
  dan disabled/forced, secara teknis bisa disimpan begitu saja) karena itu akan menyimpang dari mode yang
  eksplisit diminta user tanpa konfirmasi. Order-order ini dibiarkan apa adanya (masih "belum ditugaskan"
  di `/penugasan-tracking`), tidak ada perubahan/percobaan submit yang tersimpan ke backend untuk kelimanya.
- **6 order BERHASIL** dengan Armada **A22S (Colt Diesel Double CDD Box)** + Sopir **Muhaimin
  (6283830011881)** + Mode **Tugaskan ke Sopir** + PIC **basyir**, seluruhnya submit via modal konfirmasi
  kedua "Konfirmasi Penugasan" (tombol Simpan modal di-scope terpisah dari Simpan form utama, konsisten
  gotcha entri 2026-09-12) dan terverifikasi redirect ke `/penugasan-tracking` dengan baris status "Belum
  Berangkat": FTL9257598176, FTL9257716586, FTL9257814208, FTL9257908572, LTL9259386438, AFR9260203285.
  Jumlah Armada/Kontainer untuk seluruh 11 order (termasuk varian Multipickup/Multidrop/Multipoint) ternyata
  tetap **1** (bukan lebih dari 1 seperti diduga brief tugas) — jadi tidak ada kasus multi-slot "Armada 2"
  dst yang perlu diuji run ini.
- **0 `role="dialog"`** pada kedua modal (form utama bukan modal, tapi "Konfirmasi Penugasan" ya) dan
  **0 `data-testid`** — konsisten H5/H6, tidak ada regresi.
- Data dibuat run ini (permanen, tidak dihapus): 6 Penugasan baru (armada A22S, sopir Muhaimin, PIC basyir,
  mode Tugaskan ke Sopir) untuk FTL9257598176/FTL9257716586/FTL9257814208/FTL9257908572/LTL9259386438/
  AFR9260203285. Tidak ada Penugasan yang dibuat untuk 5 order Kontainer (FCL×4 + LCL9259783505) — lihat
  temuan blocked di atas.
- **Dikonfirmasi user (2026-09-13)**: perilaku "FCL & LCL tidak bisa ditugaskan ke sopir" adalah desain
  yang benar/diharapkan, BUKAN bug — jangan dicatat sebagai bug-candidate pada scenario planning/eksekusi
  berikutnya untuk Penugasan Tracking jenis Kontainer.


## 2026-09-16 — rerun blocked Pengaturan Akun batch 1–18

- Run `20260916-073958-blocked-b1-b18`: 160 ID dipilih, 24 dicoba ulang (20 passed, 3 failed terhadap oracle HTTP, 1 blocked TEST ISSUE login); 136 belum dicoba karena guard tiga failed berurutan.
- NEG-039/040/041: dokumen URL langsung HTTP 200 lalu redirect `/akun-saya`, menu disembunyikan, API shipments/orders/penugasan-tracking HTTP 403. Klasifikasi NEED RECHECK oracle REQ-021, bukan bukti kebocoran data. Jangan mengulang keluarga ini tanpa meninjau oracle HTTP dokumen versus API.
- Ukuran halaman API memakai `limit`, bukan `pageSize`; replay `limit=-1` ditolak 400 di `/api/sub-users` dan `/api/permission-templates`. Email, WhatsApp, nama template duplikat ditolak 409.
- Template `31261336-b209-49e4-8db6-a0b20037026d` / `AUTOTEST-20260915-ROLE-1789481591310` sekarang 3 pemakai. Hapus template ditolak 409 dan referensi tetap utuh. Dipulihkan ke semua 20 modul Akses Penuh dan 5 jenis, diverifikasi lewat buka ulang.
- Tambahan fixture Yopmail: R2 `f50db96e-1e2e-4e24-9178-feaaad258998`, R3 `138f86b8-5db8-48cc-bb9b-1578ae1e6cbf`. R2 kembali ACTIVE, login baru berhasil. Tidak menyimpan kredensial di laporan.
- Enam extra permissions ada di respons API tetapi kontrolnya tidak ditemukan pada form Akses Penuh, juga dengan Administrator. Diagnosis ini belum verdict untuk setiap skenario izin.
- Laporan rerun dan rekap unik 265 ID batch 1–18 disimpan terpisah. Rekap tidak berarti seluruh ID dieksekusi pada run ini. Rincian: `results/_triage__pengaturan-akun__20260916-073958-blocked-b1-b18.md`.

## 2026-09-17 — pengaturan-akun batch 19–22 (lanjutan, plan 22 batch TUNTAS)

- Run `20260917-004355-b19-b22`: 51 skenario tersisa dari plan `_plan__pengaturan-akun__20260915-152316.md` dieksekusi (user menyetujui lanjut, >30 gate). Hasil: 25 passed, 7 failed, 19 blocked. Gabungan batch 1–22 kini 316/321 skenario non-stress pernah dieksekusi (5 sisa hanya ada di batch 1–18 rerun-blocked yang belum dicoba karena guard 3-failed, lihat entri 2026-09-16). Rincian per skenario: `results/pengaturan-akun__20260917-004355-b19-b22.json`; triage: `results/_triage__pengaturan-akun__20260917-004355-b19-b22.md`; report: `reports/pengaturan-akun__20260917-004355-b19-b22.xlsx`.
- **6 bug aplikasi asli terkonfirmasi** (bukan selector/timing): FND-B19-094/095/100 — 6 izin tambahan (extras) `invoice.per_shipment`/`per_periode`/`berulang`/`batas_setting` (dan `shipment.harga_pengiriman`/`tracking.nomor_polisi` dari sesi 09-16) **tidak punya kontrol UI sama sekali** di form Hak Akses manapun (0/59+ template tenant pernah true) — tombol "Proses Invoice"/"Buat Invoice"/"Pengaturan Batas Invoice" tetap enabled tanpa gating untuk siapa pun; ini memberi verdict pada diagnosis terbuka 2026-09-16 di atas. FND-B20-107/108 — aksi "Ubah"/"Hapus" pada Shipment untuk aktor Lihat Saja tetap DIRENDER (disabled tanpa title), seharusnya di-hide per REQ-036 (severity rendah, klik tetap tercegah). FND-B21-157 — tombol Simpan/Batal di Preferensi Notifikasi tidak digerbangi sama sekali untuk aktor Lihat Saja (satu-satunya dari 11 modul diuji), tapi backend PUT tetap menolak 403 (severity sedang, bukan celah data).
- NEG-103 (Cetak Resi) failed tapi **bukan bug** — expected value skenario sumber salah tulis (precondition Shipment=Lihat Saja seharusnya CUKUP per REQ-035 "≥ Lihat Saja", bukan "tidak cukup"). Jangan dicatat sebagai bug pada rerun berikutnya.
- Backend permission-gate TERBUKTI solid & konsisten di 11 modul lain diuji lintas REQ-021/024/038 (Order, Penugasan Tracking, Manajemen Invoice, Klaim Asuransi, Tambah Biaya HPP Shipment, Master Wilayah/Operasional/Data Tarif, Sub User & Hak Akses, Pengaturan Notifikasi): create/update/delete semua ditolak 403 INSUFFICIENT_PERMISSION terlepas dari state UI/klaim payload palsu (isAdminOverride, forceAllow dst tidak berpengaruh). Endpoint konvensi: `/api/orders`, `/api/penugasan` (bukan `/api/penugasan-tracking` untuk mutasi), `/api/shipments/{id}/klaim-asuransi`, `/api/shipments/{id}/biaya`, `/api/provinces`, `/api/customers`, `/api/tarif-pengiriman`, `/api/sub-users`, `/api/permission-templates`, `/api/setting/general` (PUT, bukan PATCH), `/api/setting/notification-preference` (PUT).
- Pembatas jenis pengiriman global (REQ-024) TERVERIFIKASI berlaku otomatis lintas Shipment/Order/Penugasan Tracking (1 setting di template, tanpa konfigurasi per modul) — record jenis di luar `shipmentTypes` aktor 403 `SHIPMENT_TYPE_FORBIDDEN` baik di list maupun GET langsung by ID.
- 3 Dashboard (Monitoring/Tracking & Location/Operasional) TIDAK punya widget bersumber Manajemen Invoice sama sekali di implementasi ini (bukan disembunyikan karena permission) — NEG-110/111/112 blocked, bukan gap yang bisa diuji.
- Fixture baru tersedia untuk dipakai ulang run berikutnya (JANGAN diubah levelnya tanpa mengembalikan): sub user `AUTOTEST-20260917-SUBFULL` (Shipment Akses Penuh via template lama 09-15), `AUTOTEST-20260917-VIEWONLY` (Shipment+Klaim Asuransi=Lihat Saja), `AUTOTEST-20260917-B21ALLVIEW` (SEMUA modul Lihat Saja, dipakai 11 skenario backend-mutation), `AUTOTEST-20260917-B21AIRFREIGHT` (semua modul Akses Penuh, Jenis Pengiriman dibatasi Air Freight saja — dipakai EDG-037/038/039 PASSED). Shipment acuan: `SHP26090107` (FTL, terkunci/invoiced), `SHP26090119` (tidak terkunci), `SHP26090113` (LCL), `SHP26090100` (Draft FCL), `SHP26090114`/`AFR9260203285` (Air Freight, fixture A1 utk pembatas jenis).
- **Batch 22 (EDG-040..045, 6 skenario "Pembatas jenis global" pada Dashboard/Invoice/Klaim/HPP) seluruhnya blocked** — bukan temuan aplikasi, murni keterbatasan tooling: password sub user `AUTOTEST-20260917-B21AIRFREIGHT` tidak dicatat (sesuai kebijakan), dan reset password via UI diblokir permission classifier harness eksekusi saat sesi browser kembali ke Admin di antara batch. Rerun disarankan dengan: kredensial sub user disimpan di credential store aman di luar notes/results, atau 1 sesi sub user dipakai tanpa jeda antar-agent.
- Data test baru semua ber-prefix `AUTOTEST-20260917-`; tidak ada data non-AUTOTEST yang dihapus/diubah permanen. Setting tenant (Batas Invoice global) sengaja TIDAK diubah meski relevan untuk NEG-100, sesuai larangan `docs/agent-guide.md`.
