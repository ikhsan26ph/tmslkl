Feature: Pengaturan Akun — Sub User dan template Hak Akses
  Skenario berbasis spesifikasi teks; detail fixture dan oracle tersedia dalam JSON.
  Label, route, request mutation, serta stress harness mengikuti Assumptions Log.

  @positive @priority-high @REQ-001 @screen-sub-user
  Scenario: PENGATURAN-AKUN-POS-001 — Admin Utama membuka dua tab pengelolaan
    Given user berada di halaman "Sub User"
    And prasyarat "Login sebagai Admin Utama"
    When user mengklik elemen "Pengaturan Akun"
    Then sistem memverifikasi "Sub User" dengan hasil "Tab aktif default"
    When user mengklik elemen "Hak Akses"
    Then sistem memverifikasi "Tambah Hak Akses" dengan hasil "Terlihat"
    When user mengklik elemen "Sub User"
    And user mengklik elemen "+ Tambah Sub User"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Form Tambah Sub User dapat dibuka"

  @positive @priority-high @REQ-001 @screen-sub-user
  Scenario: PENGATURAN-AKUN-POS-002 — Sub user Pengaturan Akun Akses Penuh membuka dua tab pengelolaan
    Given user berada di halaman "Sub User"
    And prasyarat "Login sebagai Sub user Pengaturan Akun Akses Penuh"
    When user mengklik elemen "Pengaturan Akun"
    Then sistem memverifikasi "Sub User" dengan hasil "Tab aktif default"
    When user mengklik elemen "Hak Akses"
    Then sistem memverifikasi "Tambah Hak Akses" dengan hasil "Terlihat"
    When user mengklik elemen "Sub User"
    And user mengklik elemen "+ Tambah Sub User"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Form Tambah Sub User dapat dibuka"

  @negative @priority-high @REQ-001 @screen-sub-user
  Scenario: PENGATURAN-AKUN-NEG-001 — Pengaturan Akun tanpa akses menolak URL kedua tab
    Given user berada di halaman "Sub User"
    And prasyarat "Login sub user Pengaturan Akun Tidak Ada Akses"
    Then sistem memverifikasi "Pengaturan Akun" dengan hasil "Menu tidak terlihat"
    When user membuka halaman "URL Hak Akses" dengan konteks "route fixture tab Hak Akses"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "URL langsung Sub User dan Hak Akses merespons 403; tidak ada data akun"

  @positive @priority-high @REQ-002 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-POS-003 — Dua sub user menggunakan satu template tanpa salinan
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "Sub user U1 sudah memakai template QA Valid"
    When user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Sub User" dengan konteks "Sub User"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Sub user baru dan U1 menampilkan QA Valid; keduanya merujuk ID template sama; jumlah template tidak bertambah"

  @negative @priority-high @REQ-002 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-002 — Template tidak tersedia tidak boleh direferensikan
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "Template T-QA sudah dihapus sebelum simpan"
    When user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Penyimpanan ditolak; tidak tercipta sub user dengan referensi template putus"

  @positive @priority-medium @REQ-003 @screen-sub-user
  Scenario: PENGATURAN-AKUN-POS-004 — Terapkan dan Reset filter Sub User
    Given user berada di halaman "Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Ada record bernama Rina dan Budi dengan status berbeda"
    When user mengisi field "Nama Sub User" dengan "Rina"
    And user mengklik elemen "Terapkan"
    Then sistem memverifikasi "Tabel" dengan hasil "Hanya Rina sesuai filter"
    When user mengklik elemen "Reset"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Semua filter kosong dan tabel kembali ke kondisi default"

  @negative @priority-medium @REQ-003 @screen-sub-user
  Scenario: PENGATURAN-AKUN-NEG-003 — Filter Sub User tanpa kecocokan tidak menampilkan data lama
    Given user berada di halaman "Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengisi field "Nama Sub User" dengan "TIDAK-ADA-9f82"
    And user mengklik elemen "Terapkan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tabel berisi nol hasil; record sebelum filter tidak tersisa"

  @positive @priority-medium @REQ-003 @screen-sub-user
  Scenario: PENGATURAN-AKUN-POS-005 — Lihat Detail dari baris Sub User yang dipilih
    Given user berada di halaman "Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Dua record fixture memiliki ID berbeda"
    When user mengklik elemen "Lihat Detail"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Halaman Detail Sub User menampilkan data record U1 atau T1 yang dipilih, bukan baris tetangga"

  @positive @priority-medium @REQ-003 @screen-sub-user
  Scenario: PENGATURAN-AKUN-POS-006 — Edit dari baris Sub User yang dipilih
    Given user berada di halaman "Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Dua record fixture memiliki ID berbeda"
    When user mengklik elemen "Edit"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Halaman Edit Sub User menampilkan data record U1 atau T1 yang dipilih, bukan baris tetangga"

  @positive @priority-medium @REQ-014 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-POS-007 — Terapkan dan Reset filter Hak Akses
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Ada record bernama Rina dan Budi dengan status berbeda"
    When user mengisi field "Nama Hak Akses" dengan "Rina"
    And user memilih opsi "Aktif" pada "Status"
    And user mengklik elemen "Terapkan"
    Then sistem memverifikasi "Tabel" dengan hasil "Hanya Rina sesuai filter"
    When user mengklik elemen "Reset"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Semua filter kosong dan tabel kembali ke kondisi default"

  @negative @priority-medium @REQ-014 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-004 — Filter Hak Akses tanpa kecocokan tidak menampilkan data lama
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengisi field "Nama Hak Akses" dengan "TIDAK-ADA-9f82"
    And user mengklik elemen "Terapkan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tabel berisi nol hasil; record sebelum filter tidak tersisa"

  @positive @priority-medium @REQ-014 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-POS-008 — Lihat Detail dari baris Hak Akses yang dipilih
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Dua record fixture memiliki ID berbeda"
    When user mengklik elemen "Lihat Detail"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Halaman Detail Hak Akses menampilkan data record U1 atau T1 yang dipilih, bukan baris tetangga"

  @positive @priority-medium @REQ-014 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-POS-009 — Edit dari baris Hak Akses yang dipilih
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Dua record fixture memiliki ID berbeda"
    When user mengklik elemen "Edit"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Halaman Edit Hak Akses menampilkan data record U1 atau T1 yang dipilih, bukan baris tetangga"

  @positive @priority-high @REQ-003 @screen-sub-user
  Scenario: PENGATURAN-AKUN-POS-010 — Hapus Sub User memperbarui daftar dan jumlah pemakai
    Given user berada di halaman "Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "U1 memakai T1 dan tidak punya referensi penghalang penghapusan"
    When user mengklik elemen "Hapus"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "U1 tidak ada setelah muat ulang; jumlah pemakai T1 berkurang satu"

  @positive @priority-medium @REQ-004 @screen-sub-user
  Scenario: PENGATURAN-AKUN-POS-011 — Paginasi Sub User default 20 dan ubah ukuran tanpa loading
    Given user berada di halaman "Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Ada 41 record, urutan fixture stabil; observer loading dipasang sebelum interaksi"
    Then sistem memverifikasi "Tabel" dengan hasil "20 record awal"
    When user mengklik elemen "Halaman berikutnya"
    Then sistem memverifikasi "Tabel" dengan hasil "Record 21–40"
    When user memilih opsi "10" pada "Data per halaman"
    And user mengklik elemen "Halaman sebelumnya"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Ukuran halaman 10 diterapkan; tidak ada loading state sepanjang transisi; tidak ada ID duplikat antar halaman pada urutan tetap"

  @negative @priority-medium @REQ-004 @screen-sub-user
  Scenario: PENGATURAN-AKUN-NEG-005 — Ukuran halaman ilegal Sub User ditolak
    Given user berada di halaman "Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Harness memanipulasi nilai ukuran halaman menjadi -1"
    Then sistem memverifikasi "Data per halaman" dengan hasil "Opsi -1 tidak tersedia; harness replay request pageSize=-1"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Pilihan ilegal tidak tersedia; request hasil manipulasi ditolak atau dinormalisasi ke ukuran valid; tidak menampilkan jumlah negatif"

  @edge @priority-medium @REQ-004 @screen-sub-user
  Scenario: PENGATURAN-AKUN-EDG-001 — Sub User dengan tepat 0 record
    Given user berada di halaman "Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Fixture tepat 0 record"
    Then sistem memverifikasi "Tabel" dengan hasil "Menampilkan 0 record"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tidak ada halaman hantu; tombol berikutnya hanya aktif jika ada sisa record; halaman kosong ditangani"

  @edge @priority-medium @REQ-004 @screen-sub-user
  Scenario: PENGATURAN-AKUN-EDG-002 — Sub User dengan tepat 20 record
    Given user berada di halaman "Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Fixture tepat 20 record"
    Then sistem memverifikasi "Tabel" dengan hasil "Menampilkan 20 record"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tidak ada halaman hantu; tombol berikutnya hanya aktif jika ada sisa record; halaman kosong ditangani"

  @edge @priority-medium @REQ-004 @screen-sub-user
  Scenario: PENGATURAN-AKUN-EDG-003 — Sub User dengan tepat 21 record
    Given user berada di halaman "Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Fixture tepat 21 record"
    Then sistem memverifikasi "Tabel" dengan hasil "Menampilkan 20 record"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tidak ada halaman hantu; tombol berikutnya hanya aktif jika ada sisa record; halaman kosong ditangani"

  @positive @priority-medium @REQ-015 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-POS-012 — Paginasi Hak Akses default 20 dan ubah ukuran tanpa loading
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Ada 41 record, urutan fixture stabil; observer loading dipasang sebelum interaksi"
    Then sistem memverifikasi "Tabel" dengan hasil "20 record awal"
    When user mengklik elemen "Halaman berikutnya"
    Then sistem memverifikasi "Tabel" dengan hasil "Record 21–40"
    When user memilih opsi "10" pada "Data per halaman"
    And user mengklik elemen "Halaman sebelumnya"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Ukuran halaman 10 diterapkan; tidak ada loading state sepanjang transisi; tidak ada ID duplikat antar halaman pada urutan tetap"

  @negative @priority-medium @REQ-015 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-006 — Ukuran halaman ilegal Hak Akses ditolak
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Harness memanipulasi nilai ukuran halaman menjadi -1"
    Then sistem memverifikasi "Data per halaman" dengan hasil "Opsi -1 tidak tersedia; harness replay request pageSize=-1"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Pilihan ilegal tidak tersedia; request hasil manipulasi ditolak atau dinormalisasi ke ukuran valid; tidak menampilkan jumlah negatif"

  @edge @priority-medium @REQ-015 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-004 — Hak Akses dengan tepat 0 record
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Fixture tepat 0 record"
    Then sistem memverifikasi "Tabel" dengan hasil "Menampilkan 0 record"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tidak ada halaman hantu; tombol berikutnya hanya aktif jika ada sisa record; halaman kosong ditangani"

  @edge @priority-medium @REQ-015 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-005 — Hak Akses dengan tepat 20 record
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Fixture tepat 20 record"
    Then sistem memverifikasi "Tabel" dengan hasil "Menampilkan 20 record"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tidak ada halaman hantu; tombol berikutnya hanya aktif jika ada sisa record; halaman kosong ditangani"

  @edge @priority-medium @REQ-015 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-006 — Hak Akses dengan tepat 21 record
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Fixture tepat 21 record"
    Then sistem memverifikasi "Tabel" dengan hasil "Menampilkan 20 record"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tidak ada halaman hantu; tombol berikutnya hanya aktif jika ada sisa record; halaman kosong ditangani"

  @positive @priority-high @REQ-005 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-POS-013 — Tambah Sub User dengan semua field valid menghasilkan status Aktif
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengisi field "Nama Sub User" dengan "Rina QA"
    And user mengisi field "Email" dengan "rina.qa@example.test"
    And user mengisi field "Nomor WhatsApp" dengan "081234567890"
    And user memilih opsi "Operasional" pada "Bagian Staff"
    And user mengisi field "Password" dengan "UjiAkun!2026"
    And user mengisi field "Konfirmasi Password" dengan "UjiAkun!2026"
    And user mengklik elemen "Pilih Hak Akses"
    And user memilih opsi "QA Valid" pada "Hak Akses"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Sub user tersimpan tepat satu kali dengan status Aktif dan nilai form yang sama"

  @negative @priority-high @REQ-005 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-007 — Field wajib Nama Sub User kosong memblokir tambah
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Nama Sub User" dengan ""
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error wajib pada Nama Sub User; tidak ada sub user baru"

  @negative @priority-high @REQ-005 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-008 — Field wajib Email kosong memblokir tambah
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Email" dengan ""
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error wajib pada Email; tidak ada sub user baru"

  @negative @priority-high @REQ-005 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-009 — Field wajib Nomor WhatsApp kosong memblokir tambah
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Nomor WhatsApp" dengan ""
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error wajib pada Nomor WhatsApp; tidak ada sub user baru"

  @negative @priority-high @REQ-005 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-010 — Field wajib Bagian Staff kosong memblokir tambah
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user memilih opsi "" pada "Bagian Staff"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error wajib pada Bagian Staff; tidak ada sub user baru"

  @negative @priority-high @REQ-005 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-011 — Field wajib Password kosong memblokir tambah
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Password" dengan ""
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error wajib pada Password; tidak ada sub user baru"

  @negative @priority-high @REQ-005 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-012 — Field wajib Konfirmasi Password kosong memblokir tambah
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Konfirmasi Password" dengan ""
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error wajib pada Konfirmasi Password; tidak ada sub user baru"

  @negative @priority-high @REQ-005 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-013 — Format Email invalid
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Email" dengan "rina@@example"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Nilai Email tidak diterima; penyimpanan invalid tidak terjadi"

  @negative @priority-high @REQ-005 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-014 — Format Nomor WhatsApp invalid
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Nomor WhatsApp" dengan "08abc123"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Nilai Nomor WhatsApp tidak diterima; penyimpanan invalid tidak terjadi"

  @positive @priority-high @REQ-006 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-POS-014 — Edit tanpa perubahan email dan WhatsApp tetap valid
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "Form edit U1 memuat email dan WhatsApp milik U1"
    When user mengisi field "Nama Sub User" dengan "Rina Revisi"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Nama berubah; email dan WhatsApp tetap; tidak dianggap duplikat diri sendiri"

  @negative @priority-high @REQ-006 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-015 — Tambah Sub User menolak Email milik akun lain
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "U2 telah memakai Email=existing@example.test"
    When user mengisi field "Email" dengan "existing@example.test"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error duplikat; U2 tidak berubah; tidak ada sub user baru atau perubahan U1"

  @negative @priority-high @REQ-006 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-NEG-016 — Edit Sub User menolak Email milik akun lain
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "U2 telah memakai Email=existing@example.test"
    When user mengisi field "Email" dengan "existing@example.test"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error duplikat; U2 tidak berubah; tidak ada sub user baru atau perubahan U1"

  @negative @priority-high @REQ-006 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-017 — Tambah Sub User menolak Nomor WhatsApp milik akun lain
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "U2 telah memakai Nomor WhatsApp=081299999999"
    When user mengisi field "Nomor WhatsApp" dengan "081299999999"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error duplikat; U2 tidak berubah; tidak ada sub user baru atau perubahan U1"

  @negative @priority-high @REQ-006 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-NEG-018 — Edit Sub User menolak Nomor WhatsApp milik akun lain
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "U2 telah memakai Nomor WhatsApp=081299999999"
    When user mengisi field "Nomor WhatsApp" dengan "081299999999"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error duplikat; U2 tidak berubah; tidak ada sub user baru atau perubahan U1"

  @positive @priority-medium @REQ-007 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-POS-015 — Toggle show dan hide Password pada edit
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Password" dengan "UjiAkun!2026"
    Then sistem memverifikasi "Password" dengan hasil "type=password"
    When user mengklik elemen "Tampilkan Password"
    Then sistem memverifikasi "Password" dengan hasil "type=text; nilai UjiAkun!2026"
    When user mengklik elemen "Sembunyikan Password"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Field kembali type=password; nilai tidak berubah; field password lainnya tidak ikut berubah"

  @positive @priority-medium @REQ-007 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-POS-016 — Toggle show dan hide Konfirmasi Password pada edit
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Konfirmasi Password" dengan "UjiAkun!2026"
    Then sistem memverifikasi "Konfirmasi Password" dengan hasil "type=password"
    When user mengklik elemen "Tampilkan Konfirmasi Password"
    Then sistem memverifikasi "Konfirmasi Password" dengan hasil "type=text; nilai UjiAkun!2026"
    When user mengklik elemen "Sembunyikan Konfirmasi Password"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Field kembali type=password; nilai tidak berubah; field password lainnya tidak ikut berubah"

  @negative @priority-high @REQ-007 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-019 — Konfirmasi Password berbeda menolak penyimpanan
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Konfirmasi Password" dengan "Beda!2026"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error password tidak cocok; sub user tidak dibuat"

  @positive @priority-high @REQ-008 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-POS-017 — Preview template menampilkan semua akses tersimpan
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengklik elemen "Pilih Hak Akses"
    And user memilih opsi "QA Campuran" pada "Hak Akses"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Preview jenis, 16 modul, notifikasi dan enam izin cocok fixture; tidak ada kontrol edit aktif"

  @negative @priority-high @REQ-008 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-020 — Preview template tidak dapat mengubah template bersama
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user memilih opsi "QA Campuran" pada "Hak Akses"
    Then sistem memverifikasi "Preview Hak Akses" dengan hasil "Seluruh kontrol read-only"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Interaksi edit tidak tersedia; template sumber dan pengguna lain tidak berubah"

  @positive @priority-high @REQ-009 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-POS-018 — Buat template valid dari form tambah Sub User
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengklik elemen "Buat Hak Akses"
    And user mengisi field "Nama Hak Akses" dengan "QA Inline"
    And user mengisi field "Deskripsi" dengan "Tim pengiriman FTL"
    And user mencentang "FTL"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template QA Inline tercipta dan dipakai sub user baru; muncul di tab Hak Akses"

  @negative @priority-high @REQ-009 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-021 — Template inline tidak dapat melewati prasyarat Shipment
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengklik elemen "Buat Hak Akses"
    And user mengisi field "Nama Hak Akses" dengan "QA Inline"
    And user memilih opsi "Tidak Ada Akses" pada "Shipment"
    And user memilih opsi "Lihat Saja" pada "Manajemen Invoice"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Peringatan prasyarat Shipment; template dan sub user tidak tersimpan"

  @positive @priority-high @REQ-010 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-POS-019 — Konfirmasi Batal pada form Sub User
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengklik elemen "Batal"
    Then sistem memverifikasi "Konfirmasi" dengan hasil "Dialog terlihat"
    When user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Form ditutup tanpa data baru"

  @negative @priority-high @REQ-010 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-022 — Menolak konfirmasi Batal tidak mengeksekusi aksi
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengklik elemen "Batal"
    And user mengklik elemen "Kembali ke Form"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Form dan input tetap; belum ada data baru di penyimpanan"

  @positive @priority-high @REQ-010 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-POS-020 — Konfirmasi Simpan pada form Sub User
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Konfirmasi" dengan hasil "Dialog terlihat"
    When user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data sub user tersimpan satu kali setelah konfirmasi"

  @negative @priority-high @REQ-010 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-NEG-023 — Menolak konfirmasi Simpan tidak mengeksekusi aksi
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengklik elemen "Simpan"
    And user mengklik elemen "Kembali ke Form"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Form dan input tetap; belum ada data baru di penyimpanan"

  @positive @priority-high @REQ-011 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-POS-021 — Edit memuat data terakhir dan menerapkan akses pada login berikutnya
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "U1 aktif dengan template Lama; sesi U1 sudah login"
    Then sistem memverifikasi "Informasi Umum" dengan hasil "Sesuai fixture terakhir"
    When user memilih opsi "QA Baru" pada "Hak Akses"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Login U1" dengan konteks "Login ulang sebagai U1"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Login baru U1 menggunakan QA Baru; status Aktif tetap; pemeriksaan sesi lama dicatat terpisah"

  @negative @priority-high @REQ-011 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-NEG-024 — Status Tidak Aktif memblokir login berikutnya
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user memilih opsi "Tidak Aktif" pada "Status"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Login U1" dengan konteks "Login ulang sebagai U1"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Status tersimpan Tidak Aktif; login berikutnya tidak menghasilkan sesi operasional"

  @positive @priority-high @REQ-012 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-POS-022 — Sub user mendelegasikan izin dalam batas miliknya
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "Aktor bukan target; aktor memiliki Shipment Akses Penuh dan Harga Pengiriman"
    When user memilih opsi "QA Setara" pada "Hak Akses"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Target menerima level dan izin yang merupakan subset hak aktor"

  @negative @priority-high @REQ-012 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-NEG-025 — Cegah delegasi: mengubah hak akses dirinya sendiri
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor sub user Pengaturan Akun Akses Penuh mencoba mengubah hak akses dirinya sendiri; harness memodifikasi request bila UI memblokir"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "UI mencegah eskalasi; backend menolak payload yang dipaksakan; hak aktor dan target tidak naik"

  @negative @priority-high @REQ-012 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-NEG-026 — Cegah delegasi: memberikan Shipment Akses Penuh ketika hanya Lihat Saja
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor sub user Pengaturan Akun Akses Penuh mencoba memberikan Shipment Akses Penuh ketika hanya Lihat Saja; harness memodifikasi request bila UI memblokir"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "UI mencegah eskalasi; backend menolak payload yang dipaksakan; hak aktor dan target tidak naik"

  @negative @priority-high @REQ-012 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-NEG-027 — Cegah delegasi: memberikan Harga Pengiriman ketika aktor tidak memilikinya
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor sub user Pengaturan Akun Akses Penuh mencoba memberikan Harga Pengiriman ketika aktor tidak memilikinya; harness memodifikasi request bila UI memblokir"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "UI mencegah eskalasi; backend menolak payload yang dipaksakan; hak aktor dan target tidak naik"

  @negative @priority-high @REQ-012 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-NEG-028 — Cegah delegasi: memilih template existing yang lebih tinggi
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor sub user Pengaturan Akun Akses Penuh mencoba memilih template existing yang lebih tinggi; harness memodifikasi request bila UI memblokir"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "UI mencegah eskalasi; backend menolak payload yang dipaksakan; hak aktor dan target tidak naik"

  @negative @priority-high @REQ-012 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-NEG-029 — Cegah delegasi: mengubah template bersama yang dipakai dirinya sendiri
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor sub user Pengaturan Akun Akses Penuh mencoba mengubah template bersama yang dipakai dirinya sendiri; harness memodifikasi request bila UI memblokir"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "UI mencegah eskalasi; backend menolak payload yang dipaksakan; hak aktor dan target tidak naik"

  @positive @priority-medium @REQ-013 @screen-detail-sub-user
  Scenario: PENGATURAN-AKUN-POS-023 — Detail Sub User memuat seluruh informasi read-only
    Given user berada di halaman "Detail Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Record fixture sudah tersimpan dengan metadata diketahui"
    Then sistem memverifikasi "Informasi Umum" dengan hasil "Nilai sama dengan fixture"
    And sistem memverifikasi "Hak Akses" dengan hasil "Tree sama dengan fixture"
    When user mengklik elemen "Kembali"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Kembali ke daftar Sub User; detail tidak memodifikasi data"

  @negative @priority-medium @REQ-013 @screen-detail-sub-user
  Scenario: PENGATURAN-AKUN-NEG-030 — Detail Sub User tidak menyediakan penyimpanan atau edit nilai
    Given user berada di halaman "Detail Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    Then sistem memverifikasi "Informasi Umum" dengan hasil "Tidak ada input editable"
    And sistem memverifikasi "Simpan" dengan hasil "Tidak terlihat"
    And sistem memverifikasi "Hak Akses" dengan hasil "Tidak ada kontrol izin editable"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Informasi dan izin tetap read-only; data tersimpan tidak berubah"

  @edge @priority-low @REQ-013 @screen-detail-sub-user
  Scenario: PENGATURAN-AKUN-EDG-007 — Collapse dan expand Tracking & Monitoring pada Detail Sub User
    Given user berada di halaman "Detail Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengklik elemen "Tracking & Monitoring"
    Then sistem memverifikasi "Tracking & Monitoring" dengan hasil "aria-expanded=false; hanya anak kategori ini tersembunyi"
    When user mengklik elemen "Tracking & Monitoring"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Anak kategori kembali terlihat dengan level dan nilai yang sama; kategori lain tidak berubah"

  @edge @priority-low @REQ-013 @screen-detail-sub-user
  Scenario: PENGATURAN-AKUN-EDG-008 — Collapse dan expand Dashboard pada Detail Sub User
    Given user berada di halaman "Detail Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengklik elemen "Dashboard"
    Then sistem memverifikasi "Dashboard" dengan hasil "aria-expanded=false; hanya anak kategori ini tersembunyi"
    When user mengklik elemen "Dashboard"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Anak kategori kembali terlihat dengan level dan nilai yang sama; kategori lain tidak berubah"

  @edge @priority-low @REQ-013 @screen-detail-sub-user
  Scenario: PENGATURAN-AKUN-EDG-009 — Collapse dan expand Finance pada Detail Sub User
    Given user berada di halaman "Detail Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengklik elemen "Finance"
    Then sistem memverifikasi "Finance" dengan hasil "aria-expanded=false; hanya anak kategori ini tersembunyi"
    When user mengklik elemen "Finance"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Anak kategori kembali terlihat dengan level dan nilai yang sama; kategori lain tidak berubah"

  @edge @priority-low @REQ-013 @screen-detail-sub-user
  Scenario: PENGATURAN-AKUN-EDG-010 — Collapse dan expand Master Data pada Detail Sub User
    Given user berada di halaman "Detail Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengklik elemen "Master Data"
    Then sistem memverifikasi "Master Data" dengan hasil "aria-expanded=false; hanya anak kategori ini tersembunyi"
    When user mengklik elemen "Master Data"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Anak kategori kembali terlihat dengan level dan nilai yang sama; kategori lain tidak berubah"

  @edge @priority-low @REQ-013 @screen-detail-sub-user
  Scenario: PENGATURAN-AKUN-EDG-011 — Collapse dan expand Pengaturan Akun pada Detail Sub User
    Given user berada di halaman "Detail Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengklik elemen "Pengaturan Akun"
    Then sistem memverifikasi "Pengaturan Akun" dengan hasil "aria-expanded=false; hanya anak kategori ini tersembunyi"
    When user mengklik elemen "Pengaturan Akun"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Anak kategori kembali terlihat dengan level dan nilai yang sama; kategori lain tidak berubah"

  @edge @priority-low @REQ-013 @screen-detail-sub-user
  Scenario: PENGATURAN-AKUN-EDG-012 — Collapse dan expand Pusat Notifikasi pada Detail Sub User
    Given user berada di halaman "Detail Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengklik elemen "Pusat Notifikasi"
    Then sistem memverifikasi "Pusat Notifikasi" dengan hasil "aria-expanded=false; hanya anak kategori ini tersembunyi"
    When user mengklik elemen "Pusat Notifikasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Anak kategori kembali terlihat dengan level dan nilai yang sama; kategori lain tidak berubah"

  @positive @priority-medium @REQ-018 @screen-detail-hak-akses
  Scenario: PENGATURAN-AKUN-POS-024 — Detail Hak Akses memuat seluruh informasi read-only
    Given user berada di halaman "Detail Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Record fixture sudah tersimpan dengan metadata diketahui"
    Then sistem memverifikasi "Informasi Umum" dengan hasil "Nilai sama dengan fixture"
    And sistem memverifikasi "Hak Akses" dengan hasil "Tree sama dengan fixture"
    When user mengklik elemen "Kembali"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Kembali ke daftar Hak Akses; detail tidak memodifikasi data"

  @negative @priority-medium @REQ-018 @screen-detail-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-031 — Detail Hak Akses tidak menyediakan penyimpanan atau edit nilai
    Given user berada di halaman "Detail Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    Then sistem memverifikasi "Informasi Umum" dengan hasil "Tidak ada input editable"
    And sistem memverifikasi "Simpan" dengan hasil "Tidak terlihat"
    And sistem memverifikasi "Hak Akses" dengan hasil "Tidak ada kontrol izin editable"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Informasi dan izin tetap read-only; data tersimpan tidak berubah"

  @edge @priority-low @REQ-018 @screen-detail-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-013 — Collapse dan expand Tracking & Monitoring pada Detail Hak Akses
    Given user berada di halaman "Detail Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengklik elemen "Tracking & Monitoring"
    Then sistem memverifikasi "Tracking & Monitoring" dengan hasil "aria-expanded=false; hanya anak kategori ini tersembunyi"
    When user mengklik elemen "Tracking & Monitoring"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Anak kategori kembali terlihat dengan level dan nilai yang sama; kategori lain tidak berubah"

  @edge @priority-low @REQ-018 @screen-detail-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-014 — Collapse dan expand Dashboard pada Detail Hak Akses
    Given user berada di halaman "Detail Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengklik elemen "Dashboard"
    Then sistem memverifikasi "Dashboard" dengan hasil "aria-expanded=false; hanya anak kategori ini tersembunyi"
    When user mengklik elemen "Dashboard"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Anak kategori kembali terlihat dengan level dan nilai yang sama; kategori lain tidak berubah"

  @edge @priority-low @REQ-018 @screen-detail-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-015 — Collapse dan expand Finance pada Detail Hak Akses
    Given user berada di halaman "Detail Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengklik elemen "Finance"
    Then sistem memverifikasi "Finance" dengan hasil "aria-expanded=false; hanya anak kategori ini tersembunyi"
    When user mengklik elemen "Finance"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Anak kategori kembali terlihat dengan level dan nilai yang sama; kategori lain tidak berubah"

  @edge @priority-low @REQ-018 @screen-detail-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-016 — Collapse dan expand Master Data pada Detail Hak Akses
    Given user berada di halaman "Detail Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengklik elemen "Master Data"
    Then sistem memverifikasi "Master Data" dengan hasil "aria-expanded=false; hanya anak kategori ini tersembunyi"
    When user mengklik elemen "Master Data"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Anak kategori kembali terlihat dengan level dan nilai yang sama; kategori lain tidak berubah"

  @edge @priority-low @REQ-018 @screen-detail-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-017 — Collapse dan expand Pengaturan Akun pada Detail Hak Akses
    Given user berada di halaman "Detail Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengklik elemen "Pengaturan Akun"
    Then sistem memverifikasi "Pengaturan Akun" dengan hasil "aria-expanded=false; hanya anak kategori ini tersembunyi"
    When user mengklik elemen "Pengaturan Akun"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Anak kategori kembali terlihat dengan level dan nilai yang sama; kategori lain tidak berubah"

  @edge @priority-low @REQ-018 @screen-detail-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-018 — Collapse dan expand Pusat Notifikasi pada Detail Hak Akses
    Given user berada di halaman "Detail Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    When user mengklik elemen "Pusat Notifikasi"
    Then sistem memverifikasi "Pusat Notifikasi" dengan hasil "aria-expanded=false; hanya anak kategori ini tersembunyi"
    When user mengklik elemen "Pusat Notifikasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Anak kategori kembali terlihat dengan level dan nilai yang sama; kategori lain tidak berubah"

  @positive @priority-high @REQ-016 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-025 — Nama unik dan Deskripsi kosong boleh disimpan
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mengisi field "Nama Hak Akses" dengan "QA Unik"
    And user mengisi field "Deskripsi" dengan ""
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template QA Unik tersimpan; deskripsi kosong diterima"

  @negative @priority-high @REQ-016 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-032 — Tambah Hak Akses menolak nama kosong
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Template lain QA Existing sudah ada"
    When user mengisi field "Nama Hak Akses" dengan ""
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error nama; tidak ada perubahan template"

  @negative @priority-high @REQ-016 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-033 — Tambah Hak Akses menolak nama duplikat
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Template lain QA Existing sudah ada"
    When user mengisi field "Nama Hak Akses" dengan "QA Existing"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error nama; tidak ada perubahan template"

  @negative @priority-high @REQ-016 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-034 — Edit Hak Akses menolak nama kosong
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Template lain QA Existing sudah ada"
    When user mengisi field "Nama Hak Akses" dengan ""
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error nama; tidak ada perubahan template"

  @negative @priority-high @REQ-016 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-035 — Edit Hak Akses menolak nama duplikat
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Template lain QA Existing sudah ada"
    When user mengisi field "Nama Hak Akses" dengan "QA Existing"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error nama; tidak ada perubahan template"

  @edge @priority-medium @REQ-016 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-019 — Nama dan deskripsi Unicode tersimpan sebagai teks
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mengisi field "Nama Hak Akses" dengan "Operasional É-北"
    And user mengisi field "Deskripsi" dengan "Baris satu\nBaris dua & <b>catatan</b>"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Unicode dan baris baru terjaga; markup dirender sebagai teks, tidak dieksekusi"

  @positive @priority-high @REQ-017 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-POS-026 — Ringkasan daftar dan detail sama dengan hitungan fixture
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Fixture 16 modul: 10 Penuh, 5 Lihat Saja, 1 Tidak Ada; 2 notifikasi aktif, 2 izin aktif; 3 sub user"
    Then sistem memverifikasi "Total Akses" dengan hasil "10 Penuh / 5 Lihat Saja / 1 Tidak Ada / 2 notifikasi / 2 izin"
    When user mengklik elemen "Lihat Detail"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Ringkasan detail sama dengan daftar; Total Sub User 3; jumlah tiga level tepat 16"

  @negative @priority-high @REQ-017 @screen-detail-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-036 — Ringkasan tidak menghitung izin tersembunyi sebagai aktif
    Given user berada di halaman "Detail Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Template diturunkan dari Penuh ke Lihat Saja sehingga izin modul tersimpan mati"
    Then sistem memverifikasi "Total Akses" dengan hasil "Jumlah izin hanya menghitung nilai aktif tersimpan"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tidak ada izin mati/tersembunyi dihitung; total modul tidak termasuk header kategori"

  @positive @priority-high @REQ-019 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-027 — Edit template berdampak pada seluruh tiga pengguna
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "T1 digunakan U1,U2,U3; T2 digunakan U4"
    When user memilih opsi "Lihat Saja" pada "Order"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Konfirmasi" dengan hasil "Menyebut 3 sub user terdampak"
    When user mengklik elemen "Konfirmasi"
    And user membuka halaman "Login ulang pengguna" dengan konteks "U1,U2,U3,U4 login baru"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "U1,U2,U3 mendapat Order Lihat Saja; U4 tetap pada T2"

  @negative @priority-high @REQ-019 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-037 — Membatalkan edit template tidak mengubah pengguna
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "T1 digunakan 3 sub user"
    When user memilih opsi "Lihat Saja" pada "Order"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Kembali ke Form"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tetap nilai sebelumnya; ketiga sub user tetap akses sebelumnya"

  @positive @priority-high @REQ-020 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-028 — Shortcut Akses Penuh lalu perubahan manual
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Akses Penuh" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Level modul" dengan hasil "Seluruh modul mengikuti shortcut dengan pemetaan AS-03"
    When user memilih opsi "Akses Penuh" pada "Order"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Order mempertahankan override manual; modul lainnya tetap hasil shortcut; izin tambahan tetap mati"

  @positive @priority-high @REQ-020 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-029 — Shortcut Lihat Saja lalu perubahan manual
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Lihat Saja" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Level modul" dengan hasil "Seluruh modul mengikuti shortcut dengan pemetaan AS-03"
    When user memilih opsi "Akses Penuh" pada "Order"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Order mempertahankan override manual; modul lainnya tetap hasil shortcut; izin tambahan tetap mati"

  @positive @priority-high @REQ-020 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-030 — Shortcut Tidak Ada Akses lalu perubahan manual
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Level modul" dengan hasil "Seluruh modul mengikuti shortcut dengan pemetaan AS-03"
    When user memilih opsi "Akses Penuh" pada "Order"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Order mempertahankan override manual; modul lainnya tetap hasil shortcut; izin tambahan tetap mati"

  @negative @priority-high @REQ-020 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-038 — Shortcut tidak boleh mengaktifkan izin tambahan
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Akses Penuh" pada "Terapkan Cepat ke Semua Modul"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Semua enam izin tambahan tetap mati pada form dan setelah dibuka ulang"

  @positive @priority-high @REQ-021 @screen-shipment
  Scenario: PENGATURAN-AKUN-POS-031 — Akses Penuh membuka Shipment
    Given user berada di halaman "Shipment"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Shipment Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Shipment" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-039 — Tidak Ada Akses menolak URL dan menu Shipment
    Given user berada di halaman "Shipment"
    And prasyarat "Aktor login baru dengan Shipment Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Shipment" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Shipment" dengan konteks "route fixture Shipment"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-order
  Scenario: PENGATURAN-AKUN-POS-032 — Akses Penuh membuka Order
    Given user berada di halaman "Order"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Order Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Order" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-order
  Scenario: PENGATURAN-AKUN-NEG-040 — Tidak Ada Akses menolak URL dan menu Order
    Given user berada di halaman "Order"
    And prasyarat "Aktor login baru dengan Order Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Order" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Order" dengan konteks "route fixture Order"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-penugasan-tracking
  Scenario: PENGATURAN-AKUN-POS-033 — Akses Penuh membuka Penugasan Tracking
    Given user berada di halaman "Penugasan Tracking"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Penugasan Tracking Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Penugasan Tracking" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-penugasan-tracking
  Scenario: PENGATURAN-AKUN-NEG-041 — Tidak Ada Akses menolak URL dan menu Penugasan Tracking
    Given user berada di halaman "Penugasan Tracking"
    And prasyarat "Aktor login baru dengan Penugasan Tracking Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Penugasan Tracking" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Penugasan Tracking" dengan konteks "route fixture Penugasan Tracking"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-otomasi-jalur
  Scenario: PENGATURAN-AKUN-POS-034 — Akses Penuh membuka Otomasi Jalur
    Given user berada di halaman "Otomasi Jalur"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Otomasi Jalur Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Otomasi Jalur" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-otomasi-jalur
  Scenario: PENGATURAN-AKUN-NEG-042 — Tidak Ada Akses menolak URL dan menu Otomasi Jalur
    Given user berada di halaman "Otomasi Jalur"
    And prasyarat "Aktor login baru dengan Otomasi Jalur Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Otomasi Jalur" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Otomasi Jalur" dengan konteks "route fixture Otomasi Jalur"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-dashboard-monitoring
  Scenario: PENGATURAN-AKUN-POS-035 — Akses Penuh membuka Dashboard Monitoring
    Given user berada di halaman "Dashboard Monitoring"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Dashboard Monitoring Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Dashboard Monitoring" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-dashboard-monitoring
  Scenario: PENGATURAN-AKUN-NEG-043 — Tidak Ada Akses menolak URL dan menu Dashboard Monitoring
    Given user berada di halaman "Dashboard Monitoring"
    And prasyarat "Aktor login baru dengan Dashboard Monitoring Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Dashboard Monitoring" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Dashboard Monitoring" dengan konteks "route fixture Dashboard Monitoring"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-dashboard-tracking-location
  Scenario: PENGATURAN-AKUN-POS-036 — Akses Penuh membuka Dashboard Tracking & Location
    Given user berada di halaman "Dashboard Tracking & Location"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Dashboard Tracking & Location Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Dashboard Tracking & Location" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-dashboard-tracking-location
  Scenario: PENGATURAN-AKUN-NEG-044 — Tidak Ada Akses menolak URL dan menu Dashboard Tracking & Location
    Given user berada di halaman "Dashboard Tracking & Location"
    And prasyarat "Aktor login baru dengan Dashboard Tracking & Location Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Dashboard Tracking & Location" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Dashboard Tracking & Location" dengan konteks "route fixture Dashboard Tracking & Location"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-dashboard-operasional
  Scenario: PENGATURAN-AKUN-POS-037 — Akses Penuh membuka Dashboard Operasional
    Given user berada di halaman "Dashboard Operasional"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Dashboard Operasional Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Dashboard Operasional" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-dashboard-operasional
  Scenario: PENGATURAN-AKUN-NEG-045 — Tidak Ada Akses menolak URL dan menu Dashboard Operasional
    Given user berada di halaman "Dashboard Operasional"
    And prasyarat "Aktor login baru dengan Dashboard Operasional Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Dashboard Operasional" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Dashboard Operasional" dengan konteks "route fixture Dashboard Operasional"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-POS-038 — Akses Penuh membuka Manajemen Invoice
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Manajemen Invoice Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Manajemen Invoice" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-NEG-046 — Tidak Ada Akses menolak URL dan menu Manajemen Invoice
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Aktor login baru dengan Manajemen Invoice Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Manajemen Invoice" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Manajemen Invoice" dengan konteks "route fixture Manajemen Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-klaim-asuransi
  Scenario: PENGATURAN-AKUN-POS-039 — Akses Penuh membuka Klaim Asuransi
    Given user berada di halaman "Klaim Asuransi"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Klaim Asuransi Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Klaim Asuransi" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-klaim-asuransi
  Scenario: PENGATURAN-AKUN-NEG-047 — Tidak Ada Akses menolak URL dan menu Klaim Asuransi
    Given user berada di halaman "Klaim Asuransi"
    And prasyarat "Aktor login baru dengan Klaim Asuransi Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Klaim Asuransi" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Klaim Asuransi" dengan konteks "route fixture Klaim Asuransi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-tambah-biaya-hpp-shipment
  Scenario: PENGATURAN-AKUN-POS-040 — Akses Penuh membuka Tambah Biaya HPP Shipment
    Given user berada di halaman "Tambah Biaya HPP Shipment"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Tambah Biaya HPP Shipment Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Tambah Biaya HPP Shipment" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-tambah-biaya-hpp-shipment
  Scenario: PENGATURAN-AKUN-NEG-048 — Tidak Ada Akses menolak URL dan menu Tambah Biaya HPP Shipment
    Given user berada di halaman "Tambah Biaya HPP Shipment"
    And prasyarat "Aktor login baru dengan Tambah Biaya HPP Shipment Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Tambah Biaya HPP Shipment" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Tambah Biaya HPP Shipment" dengan konteks "route fixture Tambah Biaya HPP Shipment"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-master-wilayah
  Scenario: PENGATURAN-AKUN-POS-041 — Akses Penuh membuka Master Wilayah
    Given user berada di halaman "Master Wilayah"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Master Wilayah Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Master Wilayah" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-master-wilayah
  Scenario: PENGATURAN-AKUN-NEG-049 — Tidak Ada Akses menolak URL dan menu Master Wilayah
    Given user berada di halaman "Master Wilayah"
    And prasyarat "Aktor login baru dengan Master Wilayah Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Master Wilayah" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Master Wilayah" dengan konteks "route fixture Master Wilayah"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-master-operasional
  Scenario: PENGATURAN-AKUN-POS-042 — Akses Penuh membuka Master Operasional
    Given user berada di halaman "Master Operasional"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Master Operasional Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Master Operasional" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-master-operasional
  Scenario: PENGATURAN-AKUN-NEG-050 — Tidak Ada Akses menolak URL dan menu Master Operasional
    Given user berada di halaman "Master Operasional"
    And prasyarat "Aktor login baru dengan Master Operasional Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Master Operasional" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Master Operasional" dengan konteks "route fixture Master Operasional"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-master-data-tarif
  Scenario: PENGATURAN-AKUN-POS-043 — Akses Penuh membuka Master Data Tarif
    Given user berada di halaman "Master Data Tarif"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Master Data Tarif Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Master Data Tarif" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-master-data-tarif
  Scenario: PENGATURAN-AKUN-NEG-051 — Tidak Ada Akses menolak URL dan menu Master Data Tarif
    Given user berada di halaman "Master Data Tarif"
    And prasyarat "Aktor login baru dengan Master Data Tarif Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Master Data Tarif" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Master Data Tarif" dengan konteks "route fixture Master Data Tarif"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-sub-user-hak-akses
  Scenario: PENGATURAN-AKUN-POS-044 — Akses Penuh membuka Sub User & Hak Akses
    Given user berada di halaman "Sub User & Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Sub User & Hak Akses Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Sub User & Hak Akses" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-sub-user-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-052 — Tidak Ada Akses menolak URL dan menu Sub User & Hak Akses
    Given user berada di halaman "Sub User & Hak Akses"
    And prasyarat "Aktor login baru dengan Sub User & Hak Akses Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Sub User & Hak Akses" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Sub User & Hak Akses" dengan konteks "route fixture Sub User & Hak Akses"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-pengaturan-notifikasi
  Scenario: PENGATURAN-AKUN-POS-045 — Akses Penuh membuka Pengaturan Notifikasi
    Given user berada di halaman "Pengaturan Notifikasi"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Pengaturan Notifikasi Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Pengaturan Notifikasi" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-pengaturan-notifikasi
  Scenario: PENGATURAN-AKUN-NEG-053 — Tidak Ada Akses menolak URL dan menu Pengaturan Notifikasi
    Given user berada di halaman "Pengaturan Notifikasi"
    And prasyarat "Aktor login baru dengan Pengaturan Notifikasi Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Pengaturan Notifikasi" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Pengaturan Notifikasi" dengan konteks "route fixture Pengaturan Notifikasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-preferensi-notifikasi
  Scenario: PENGATURAN-AKUN-POS-046 — Akses Penuh membuka Preferensi Notifikasi
    Given user berada di halaman "Preferensi Notifikasi"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Aktor punya Preferensi Notifikasi Akses Penuh, prasyarat valid, jenis FTL; fixture data FTL"
    Then sistem memverifikasi "Preferensi Notifikasi" dengan hasil "Fitur dapat dibuka"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Data berjenis FTL sesuai hak terlihat; operasi bawaan yang tersedia mengikuti level dan batas data"

  @negative @priority-high @REQ-021 @screen-preferensi-notifikasi
  Scenario: PENGATURAN-AKUN-NEG-054 — Tidak Ada Akses menolak URL dan menu Preferensi Notifikasi
    Given user berada di halaman "Preferensi Notifikasi"
    And prasyarat "Aktor login baru dengan Preferensi Notifikasi Tidak Ada Akses; fixture data tersedia"
    Then sistem memverifikasi "Menu Preferensi Notifikasi" dengan hasil "Tidak terlihat"
    When user membuka halaman "URL langsung Preferensi Notifikasi" dengan konteks "route fixture Preferensi Notifikasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Respons URL langsung 403; data modul tidak bocor pada respons"

  @positive @priority-high @REQ-021 @screen-shipment
  Scenario: PENGATURAN-AKUN-POS-047 — Lihat Saja mengizinkan pencarian filter dan export Shipment
    Given user berada di halaman "Shipment"
    And prasyarat "Aktor Shipment Lihat Saja; FTL diizinkan; data FTL tersedia"
    When user mengisi field "Pencarian" dengan "S-FTL"
    And user mengklik elemen "Terapkan"
    And user mengklik elemen "Export"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Record cocok terlihat; file export memuat hanya data yang diizinkan"

  @negative @priority-high @REQ-021 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-055 — Lihat Saja Shipment menolak Tambah
    Given user berada di halaman "Shipment"
    And prasyarat "Aktor Shipment Lihat Saja; harness dapat mengirim request aksi langsung"
    Then sistem memverifikasi "Tambah" dengan hasil "Tidak tersedia untuk mutasi"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request mutasi dipaksakan ditolak; shipment tidak berubah"

  @negative @priority-high @REQ-021 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-056 — Lihat Saja Shipment menolak Ubah
    Given user berada di halaman "Shipment"
    And prasyarat "Aktor Shipment Lihat Saja; harness dapat mengirim request aksi langsung"
    Then sistem memverifikasi "Ubah" dengan hasil "Tidak tersedia untuk mutasi"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request mutasi dipaksakan ditolak; shipment tidak berubah"

  @negative @priority-high @REQ-021 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-057 — Lihat Saja Shipment menolak Hapus
    Given user berada di halaman "Shipment"
    And prasyarat "Aktor Shipment Lihat Saja; harness dapat mengirim request aksi langsung"
    Then sistem memverifikasi "Hapus" dengan hasil "Tidak tersedia untuk mutasi"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request mutasi dipaksakan ditolak; shipment tidak berubah"

  @positive @priority-medium @REQ-022 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-048 — Tree memuat struktur 16 modul tanpa Cakupan Data
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    Then sistem memverifikasi "Hak Akses" dengan hasil "Shipment dan Order langsung; enam kategori sesuai spec"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "16 modul tepat; semua kategori dan submodul sesuai daftar; tidak ada kontrol Cakupan Data, Pemilik Data atau widget individual"

  @negative @priority-high @REQ-022 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-058 — Otomasi Jalur tidak menerima Lihat Saja
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    Then sistem memverifikasi "Otomasi Jalur" dengan hasil "Hanya Akses Penuh dan Tidak Ada Akses"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Opsi Lihat Saja tidak tersedia; payload Lihat Saja dipaksakan ditolak"

  @negative @priority-high @REQ-022 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-059 — Dashboard Monitoring tidak menerima Lihat Saja
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    Then sistem memverifikasi "Dashboard Monitoring" dengan hasil "Hanya Akses Penuh dan Tidak Ada Akses"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Opsi Lihat Saja tidak tersedia; payload Lihat Saja dipaksakan ditolak"

  @negative @priority-high @REQ-022 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-060 — Dashboard Tracking & Location tidak menerima Lihat Saja
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    Then sistem memverifikasi "Dashboard Tracking & Location" dengan hasil "Hanya Akses Penuh dan Tidak Ada Akses"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Opsi Lihat Saja tidak tersedia; payload Lihat Saja dipaksakan ditolak"

  @negative @priority-high @REQ-022 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-061 — Dashboard Operasional tidak menerima Lihat Saja
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    Then sistem memverifikasi "Dashboard Operasional" dengan hasil "Hanya Akses Penuh dan Tidak Ada Akses"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Opsi Lihat Saja tidak tersedia; payload Lihat Saja dipaksakan ditolak"

  @positive @priority-high @REQ-023 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-049 — Hanya FTL memenuhi minimum satu jenis
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mencentang "FTL"
    And user menghapus centang "LTL"
    And user menghapus centang "FCL"
    And user menghapus centang "LCL"
    And user menghapus centang "Airfreight"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan dengan tepat satu jenis; pilihan tidak mengubah jenis lain secara otomatis"

  @positive @priority-high @REQ-023 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-050 — Hanya LTL memenuhi minimum satu jenis
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mencentang "LTL"
    And user menghapus centang "FTL"
    And user menghapus centang "FCL"
    And user menghapus centang "LCL"
    And user menghapus centang "Airfreight"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan dengan tepat satu jenis; pilihan tidak mengubah jenis lain secara otomatis"

  @positive @priority-high @REQ-023 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-051 — Hanya FCL memenuhi minimum satu jenis
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mencentang "FCL"
    And user menghapus centang "FTL"
    And user menghapus centang "LTL"
    And user menghapus centang "LCL"
    And user menghapus centang "Airfreight"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan dengan tepat satu jenis; pilihan tidak mengubah jenis lain secara otomatis"

  @positive @priority-high @REQ-023 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-052 — Hanya LCL memenuhi minimum satu jenis
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mencentang "LCL"
    And user menghapus centang "FTL"
    And user menghapus centang "LTL"
    And user menghapus centang "FCL"
    And user menghapus centang "Airfreight"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan dengan tepat satu jenis; pilihan tidak mengubah jenis lain secara otomatis"

  @positive @priority-high @REQ-023 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-053 — Hanya Airfreight memenuhi minimum satu jenis
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mencentang "Airfreight"
    And user menghapus centang "FTL"
    And user menghapus centang "LTL"
    And user menghapus centang "FCL"
    And user menghapus centang "LCL"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan dengan tepat satu jenis; pilihan tidak mengubah jenis lain secara otomatis"

  @negative @priority-high @REQ-023 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-062 — Nol jenis memblokir template meskipun semua modul Penuh
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user menghapus centang "FTL"
    And user menghapus centang "LTL"
    And user menghapus centang "FCL"
    And user menghapus centang "LCL"
    And user menghapus centang "Airfreight"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error minimal satu jenis; template tidak tersimpan"

  @edge @priority-medium @REQ-023 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-020 — Kombinasi 2 jenis independen tersimpan
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mencentang "FTL"
    And user mencentang "LTL"
    And user menghapus centang "FCL"
    And user menghapus centang "LCL"
    And user menghapus centang "Airfreight"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Jenis tersimpan persis sama dengan pilihan, tanpa jenis tambahan"

  @edge @priority-medium @REQ-023 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-021 — Kombinasi 3 jenis independen tersimpan
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mencentang "FTL"
    And user mencentang "LTL"
    And user mencentang "FCL"
    And user menghapus centang "LCL"
    And user menghapus centang "Airfreight"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Jenis tersimpan persis sama dengan pilihan, tanpa jenis tambahan"

  @edge @priority-medium @REQ-023 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-022 — Kombinasi 4 jenis independen tersimpan
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mencentang "FTL"
    And user mencentang "LTL"
    And user mencentang "FCL"
    And user mencentang "LCL"
    And user menghapus centang "Airfreight"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Jenis tersimpan persis sama dengan pilihan, tanpa jenis tambahan"

  @edge @priority-medium @REQ-023 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-023 — Kombinasi 5 jenis independen tersimpan
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mencentang "FTL"
    And user mencentang "LTL"
    And user mencentang "FCL"
    And user mencentang "LCL"
    And user mencentang "Airfreight"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Jenis tersimpan persis sama dengan pilihan, tanpa jenis tambahan"

  @positive @priority-high @REQ-024 @screen-daftar
  Scenario: PENGATURAN-AKUN-POS-054 — Daftar menampilkan jenis diizinkan lintas pemilik
    Given user berada di halaman "Daftar"
    And prasyarat "Aktor hanya FTL; modul sumber Akses Penuh; S1 FTL milik A, S2 FTL milik B, S3 LCL milik A"
    Then sistem memverifikasi "Daftar" dengan hasil "Muat data fixture S1,S2,S3"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "S1 dan S2 terlihat pada hasil; kepemilikan tidak membatasi"

  @negative @priority-high @REQ-024 @screen-daftar
  Scenario: PENGATURAN-AKUN-NEG-063 — Daftar tidak membocorkan LCL yang tidak dipilih
    Given user berada di halaman "Daftar"
    And prasyarat "Aktor hanya FTL; S3 LCL ada di modul sumber yang boleh diakses"
    Then sistem memverifikasi "Daftar" dengan hasil "Periksa seluruh hasil termasuk response"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "S3 tidak ada pada hasil UI, payload data, file atau pengiriman notifikasi sesuai surface"

  @positive @priority-high @REQ-024 @screen-dashboard
  Scenario: PENGATURAN-AKUN-POS-055 — Dashboard menampilkan jenis diizinkan lintas pemilik
    Given user berada di halaman "Dashboard"
    And prasyarat "Aktor hanya FTL; modul sumber Akses Penuh; S1 FTL milik A, S2 FTL milik B, S3 LCL milik A"
    Then sistem memverifikasi "Dashboard" dengan hasil "Muat data fixture S1,S2,S3"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "S1 dan S2 terlihat pada hasil; kepemilikan tidak membatasi"

  @negative @priority-high @REQ-024 @screen-dashboard
  Scenario: PENGATURAN-AKUN-NEG-064 — Dashboard tidak membocorkan LCL yang tidak dipilih
    Given user berada di halaman "Dashboard"
    And prasyarat "Aktor hanya FTL; S3 LCL ada di modul sumber yang boleh diakses"
    Then sistem memverifikasi "Dashboard" dengan hasil "Periksa seluruh hasil termasuk response"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "S3 tidak ada pada hasil UI, payload data, file atau pengiriman notifikasi sesuai surface"

  @positive @priority-high @REQ-024 @screen-pencarian
  Scenario: PENGATURAN-AKUN-POS-056 — Pencarian menampilkan jenis diizinkan lintas pemilik
    Given user berada di halaman "Pencarian"
    And prasyarat "Aktor hanya FTL; modul sumber Akses Penuh; S1 FTL milik A, S2 FTL milik B, S3 LCL milik A"
    Then sistem memverifikasi "Pencarian" dengan hasil "Muat data fixture S1,S2,S3"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "S1 dan S2 terlihat pada hasil; kepemilikan tidak membatasi"

  @negative @priority-high @REQ-024 @screen-pencarian
  Scenario: PENGATURAN-AKUN-NEG-065 — Pencarian tidak membocorkan LCL yang tidak dipilih
    Given user berada di halaman "Pencarian"
    And prasyarat "Aktor hanya FTL; S3 LCL ada di modul sumber yang boleh diakses"
    Then sistem memverifikasi "Pencarian" dengan hasil "Periksa seluruh hasil termasuk response"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "S3 tidak ada pada hasil UI, payload data, file atau pengiriman notifikasi sesuai surface"

  @positive @priority-high @REQ-024 @screen-export
  Scenario: PENGATURAN-AKUN-POS-057 — Export menampilkan jenis diizinkan lintas pemilik
    Given user berada di halaman "Export"
    And prasyarat "Aktor hanya FTL; modul sumber Akses Penuh; S1 FTL milik A, S2 FTL milik B, S3 LCL milik A"
    When user mengklik elemen "Export"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "S1 dan S2 terlihat pada hasil; kepemilikan tidak membatasi"

  @negative @priority-high @REQ-024 @screen-export
  Scenario: PENGATURAN-AKUN-NEG-066 — Export tidak membocorkan LCL yang tidak dipilih
    Given user berada di halaman "Export"
    And prasyarat "Aktor hanya FTL; S3 LCL ada di modul sumber yang boleh diakses"
    When user mengklik elemen "Export"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "S3 tidak ada pada hasil UI, payload data, file atau pengiriman notifikasi sesuai surface"

  @positive @priority-high @REQ-024 @screen-notifikasi
  Scenario: PENGATURAN-AKUN-POS-058 — Notifikasi menampilkan jenis diizinkan lintas pemilik
    Given user berada di halaman "Notifikasi"
    And prasyarat "Aktor hanya FTL; modul sumber Akses Penuh; S1 FTL milik A, S2 FTL milik B, S3 LCL milik A"
    Then sistem memverifikasi "Notifikasi" dengan hasil "Muat data fixture S1,S2,S3"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "S1 dan S2 terlihat pada hasil; kepemilikan tidak membatasi"

  @negative @priority-high @REQ-024 @screen-notifikasi
  Scenario: PENGATURAN-AKUN-NEG-067 — Notifikasi tidak membocorkan LCL yang tidak dipilih
    Given user berada di halaman "Notifikasi"
    And prasyarat "Aktor hanya FTL; S3 LCL ada di modul sumber yang boleh diakses"
    Then sistem memverifikasi "Notifikasi" dengan hasil "Periksa seluruh hasil termasuk response"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "S3 tidak ada pada hasil UI, payload data, file atau pengiriman notifikasi sesuai surface"

  @positive @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-059 — Manajemen Invoice Lihat Saja valid dengan Shipment Lihat Saja
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Lihat Saja" pada "Shipment"
    And user memilih opsi "Lihat Saja" pada "Manajemen Invoice"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan tanpa peringatan prasyarat"

  @negative @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-068 — Manajemen Invoice Lihat Saja ditolak tanpa Shipment
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Lihat Saja" pada "Manajemen Invoice"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Peringatan inline menyebut Shipment minimal Lihat Saja; simpan diblokir"

  @positive @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-060 — Manajemen Invoice Akses Penuh valid dengan Shipment Lihat Saja
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Lihat Saja" pada "Shipment"
    And user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan tanpa peringatan prasyarat"

  @negative @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-069 — Manajemen Invoice Akses Penuh ditolak tanpa Shipment
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Peringatan inline menyebut Shipment minimal Lihat Saja; simpan diblokir"

  @positive @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-061 — Klaim Asuransi Lihat Saja valid dengan Shipment Lihat Saja
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Lihat Saja" pada "Shipment"
    And user memilih opsi "Lihat Saja" pada "Klaim Asuransi"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan tanpa peringatan prasyarat"

  @negative @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-070 — Klaim Asuransi Lihat Saja ditolak tanpa Shipment
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Lihat Saja" pada "Klaim Asuransi"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Peringatan inline menyebut Shipment minimal Lihat Saja; simpan diblokir"

  @positive @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-062 — Klaim Asuransi Akses Penuh valid dengan Shipment Lihat Saja
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Lihat Saja" pada "Shipment"
    And user memilih opsi "Akses Penuh" pada "Klaim Asuransi"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan tanpa peringatan prasyarat"

  @negative @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-071 — Klaim Asuransi Akses Penuh ditolak tanpa Shipment
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Akses Penuh" pada "Klaim Asuransi"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Peringatan inline menyebut Shipment minimal Lihat Saja; simpan diblokir"

  @positive @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-063 — Tambah Biaya HPP Shipment Lihat Saja valid dengan Shipment Lihat Saja
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Lihat Saja" pada "Shipment"
    And user memilih opsi "Lihat Saja" pada "Tambah Biaya HPP Shipment"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan tanpa peringatan prasyarat"

  @negative @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-072 — Tambah Biaya HPP Shipment Lihat Saja ditolak tanpa Shipment
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Lihat Saja" pada "Tambah Biaya HPP Shipment"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Peringatan inline menyebut Shipment minimal Lihat Saja; simpan diblokir"

  @positive @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-064 — Tambah Biaya HPP Shipment Akses Penuh valid dengan Shipment Lihat Saja
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Lihat Saja" pada "Shipment"
    And user memilih opsi "Akses Penuh" pada "Tambah Biaya HPP Shipment"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan tanpa peringatan prasyarat"

  @negative @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-073 — Tambah Biaya HPP Shipment Akses Penuh ditolak tanpa Shipment
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Akses Penuh" pada "Tambah Biaya HPP Shipment"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Peringatan inline menyebut Shipment minimal Lihat Saja; simpan diblokir"

  @positive @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-065 — Penugasan Tracking Lihat Saja valid dengan Shipment Lihat Saja
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Lihat Saja" pada "Shipment"
    And user memilih opsi "Lihat Saja" pada "Penugasan Tracking"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan tanpa peringatan prasyarat"

  @negative @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-074 — Penugasan Tracking Lihat Saja ditolak tanpa Shipment
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Lihat Saja" pada "Penugasan Tracking"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Peringatan inline menyebut Shipment minimal Lihat Saja; simpan diblokir"

  @positive @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-066 — Penugasan Tracking Akses Penuh valid dengan Shipment Lihat Saja
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Lihat Saja" pada "Shipment"
    And user memilih opsi "Akses Penuh" pada "Penugasan Tracking"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan tanpa peringatan prasyarat"

  @negative @priority-high @REQ-025 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-075 — Penugasan Tracking Akses Penuh ditolak tanpa Shipment
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Akses Penuh" pada "Penugasan Tracking"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Peringatan inline menyebut Shipment minimal Lihat Saja; simpan diblokir"

  @positive @priority-high @REQ-026 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-067 — Otomasi Penuh dengan Tracking dan Shipment Lihat Saja
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Lihat Saja" pada "Shipment"
    And user memilih opsi "Lihat Saja" pada "Penugasan Tracking"
    And user memilih opsi "Akses Penuh" pada "Otomasi Jalur"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template tersimpan; rantai prasyarat terpenuhi"

  @negative @priority-high @REQ-026 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-076 — Otomasi Penuh ditolak jika Tracking tidak memiliki akses
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Penugasan Tracking"
    And user memilih opsi "Akses Penuh" pada "Otomasi Jalur"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Peringatan inline Otomasi menyebut Penugasan Tracking minimal Lihat Saja; simpan diblokir"

  @edge @priority-high @REQ-026 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-024 — Prasyarat transitif Otomasi diperbaiki sampai Shipment
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user memilih opsi "Akses Penuh" pada "Otomasi Jalur"
    And user mengklik elemen "Sesuaikan Otomatis pada Otomasi Jalur"
    Then sistem memverifikasi "Penugasan Tracking" dengan hasil "Lihat Saja; peringatan Shipment masih memblokir"
    When user mengklik elemen "Sesuaikan Otomatis pada Penugasan Tracking"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tracking dan Shipment Lihat Saja; Otomasi Penuh; template baru bisa tersimpan"

  @positive @priority-high @REQ-027 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-068 — Sesuaikan Otomatis menaikkan Shipment tepat ke minimum
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Shipment"
    And user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    And user mengklik elemen "Sesuaikan Otomatis pada Manajemen Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Shipment menjadi Lihat Saja; peringatan hilang; kartu izin invoice tersedia dengan default mati"

  @negative @priority-high @REQ-027 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-077 — Izin tambahan ditahan selama prasyarat belum valid
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Shipment"
    And user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    Then sistem memverifikasi "Izin Manajemen Invoice" dengan hasil "Kartu tidak ditampilkan"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tidak dapat memberi izin invoice melalui kartu atau payload paksa; penyimpanan diblokir"

  @positive @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-069 — Harga Pengiriman opt-in hanya saat Shipment Penuh
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Akses Penuh" pada "Shipment"
    Then sistem memverifikasi "Harga Pengiriman" dengan hasil "Terlihat dan mati"
    When user mencentang "Harga Pengiriman"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin yang dipilih aktif tersimpan; izin lain tidak otomatis aktif"

  @negative @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-078 — Harga Pengiriman dibersihkan saat turun ke Lihat Saja
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Harga Pengiriman aktif; kombinasi prasyarat awal valid"
    When user memilih opsi "Lihat Saja" pada "Shipment"
    Then sistem memverifikasi "Harga Pengiriman" dengan hasil "Tidak terlihat"
    When user memilih opsi "Lihat Saja" pada "Terapkan Cepat ke Semua Modul"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Edit Hak Akses" dengan konteks "Edit Hak Akses"
    And user memilih opsi "Akses Penuh" pada "Shipment"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin tersimpan mati dan tetap mati saat naik kembali; tidak diwarisi dari nilai lama"

  @negative @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-079 — Harga Pengiriman dibersihkan saat turun ke Tidak Ada Akses
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Harga Pengiriman aktif; kombinasi prasyarat awal valid"
    When user memilih opsi "Tidak Ada Akses" pada "Shipment"
    Then sistem memverifikasi "Harga Pengiriman" dengan hasil "Tidak terlihat"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Edit Hak Akses" dengan konteks "Edit Hak Akses"
    And user memilih opsi "Akses Penuh" pada "Shipment"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin tersimpan mati dan tetap mati saat naik kembali; tidak diwarisi dari nilai lama"

  @positive @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-070 — Nomor Polisi opt-in hanya saat Penugasan Tracking Penuh
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Akses Penuh" pada "Penugasan Tracking"
    Then sistem memverifikasi "Nomor Polisi" dengan hasil "Terlihat dan mati"
    When user mencentang "Nomor Polisi"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin yang dipilih aktif tersimpan; izin lain tidak otomatis aktif"

  @negative @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-080 — Nomor Polisi dibersihkan saat turun ke Lihat Saja
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Nomor Polisi aktif; kombinasi prasyarat awal valid"
    When user memilih opsi "Lihat Saja" pada "Penugasan Tracking"
    Then sistem memverifikasi "Nomor Polisi" dengan hasil "Tidak terlihat"
    When user memilih opsi "Lihat Saja" pada "Terapkan Cepat ke Semua Modul"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Edit Hak Akses" dengan konteks "Edit Hak Akses"
    And user memilih opsi "Akses Penuh" pada "Penugasan Tracking"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin tersimpan mati dan tetap mati saat naik kembali; tidak diwarisi dari nilai lama"

  @negative @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-081 — Nomor Polisi dibersihkan saat turun ke Tidak Ada Akses
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Nomor Polisi aktif; kombinasi prasyarat awal valid"
    When user memilih opsi "Tidak Ada Akses" pada "Penugasan Tracking"
    Then sistem memverifikasi "Nomor Polisi" dengan hasil "Tidak terlihat"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Edit Hak Akses" dengan konteks "Edit Hak Akses"
    And user memilih opsi "Akses Penuh" pada "Penugasan Tracking"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin tersimpan mati dan tetap mati saat naik kembali; tidak diwarisi dari nilai lama"

  @positive @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-071 — Pembuatan Invoice Berulang opt-in hanya saat Manajemen Invoice Penuh
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    Then sistem memverifikasi "Pembuatan Invoice Berulang" dengan hasil "Terlihat dan mati"
    When user mencentang "Buat Invoice per Shipment"
    And user mencentang "Pembuatan Invoice Berulang"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin yang dipilih aktif tersimpan; izin lain tidak otomatis aktif"

  @negative @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-082 — Pembuatan Invoice Berulang dibersihkan saat turun ke Lihat Saja
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Pembuatan Invoice Berulang aktif; kombinasi prasyarat awal valid"
    When user memilih opsi "Lihat Saja" pada "Manajemen Invoice"
    Then sistem memverifikasi "Pembuatan Invoice Berulang" dengan hasil "Tidak terlihat"
    When user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Edit Hak Akses" dengan konteks "Edit Hak Akses"
    And user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin tersimpan mati dan tetap mati saat naik kembali; tidak diwarisi dari nilai lama"

  @negative @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-083 — Pembuatan Invoice Berulang dibersihkan saat turun ke Tidak Ada Akses
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Pembuatan Invoice Berulang aktif; kombinasi prasyarat awal valid"
    When user memilih opsi "Tidak Ada Akses" pada "Manajemen Invoice"
    Then sistem memverifikasi "Pembuatan Invoice Berulang" dengan hasil "Tidak terlihat"
    When user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Edit Hak Akses" dengan konteks "Edit Hak Akses"
    And user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin tersimpan mati dan tetap mati saat naik kembali; tidak diwarisi dari nilai lama"

  @positive @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-072 — Buat Invoice per Shipment opt-in hanya saat Manajemen Invoice Penuh
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    Then sistem memverifikasi "Buat Invoice per Shipment" dengan hasil "Terlihat dan mati"
    When user mencentang "Buat Invoice per Shipment"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin yang dipilih aktif tersimpan; izin lain tidak otomatis aktif"

  @negative @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-084 — Buat Invoice per Shipment dibersihkan saat turun ke Lihat Saja
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Buat Invoice per Shipment aktif; kombinasi prasyarat awal valid"
    When user memilih opsi "Lihat Saja" pada "Manajemen Invoice"
    Then sistem memverifikasi "Buat Invoice per Shipment" dengan hasil "Tidak terlihat"
    When user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Edit Hak Akses" dengan konteks "Edit Hak Akses"
    And user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin tersimpan mati dan tetap mati saat naik kembali; tidak diwarisi dari nilai lama"

  @negative @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-085 — Buat Invoice per Shipment dibersihkan saat turun ke Tidak Ada Akses
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Buat Invoice per Shipment aktif; kombinasi prasyarat awal valid"
    When user memilih opsi "Tidak Ada Akses" pada "Manajemen Invoice"
    Then sistem memverifikasi "Buat Invoice per Shipment" dengan hasil "Tidak terlihat"
    When user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Edit Hak Akses" dengan konteks "Edit Hak Akses"
    And user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin tersimpan mati dan tetap mati saat naik kembali; tidak diwarisi dari nilai lama"

  @positive @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-073 — Buat Invoice per Periode opt-in hanya saat Manajemen Invoice Penuh
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    Then sistem memverifikasi "Buat Invoice per Periode" dengan hasil "Terlihat dan mati"
    When user mencentang "Buat Invoice per Periode"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin yang dipilih aktif tersimpan; izin lain tidak otomatis aktif"

  @negative @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-086 — Buat Invoice per Periode dibersihkan saat turun ke Lihat Saja
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Buat Invoice per Periode aktif; kombinasi prasyarat awal valid"
    When user memilih opsi "Lihat Saja" pada "Manajemen Invoice"
    Then sistem memverifikasi "Buat Invoice per Periode" dengan hasil "Tidak terlihat"
    When user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Edit Hak Akses" dengan konteks "Edit Hak Akses"
    And user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin tersimpan mati dan tetap mati saat naik kembali; tidak diwarisi dari nilai lama"

  @negative @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-087 — Buat Invoice per Periode dibersihkan saat turun ke Tidak Ada Akses
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Buat Invoice per Periode aktif; kombinasi prasyarat awal valid"
    When user memilih opsi "Tidak Ada Akses" pada "Manajemen Invoice"
    Then sistem memverifikasi "Buat Invoice per Periode" dengan hasil "Tidak terlihat"
    When user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Edit Hak Akses" dengan konteks "Edit Hak Akses"
    And user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin tersimpan mati dan tetap mati saat naik kembali; tidak diwarisi dari nilai lama"

  @positive @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-074 — Akses Pengaturan Batas Invoice opt-in hanya saat Manajemen Invoice Penuh
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    Then sistem memverifikasi "Akses Pengaturan Batas Invoice" dengan hasil "Terlihat dan mati"
    When user mencentang "Akses Pengaturan Batas Invoice"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin yang dipilih aktif tersimpan; izin lain tidak otomatis aktif"

  @negative @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-088 — Akses Pengaturan Batas Invoice dibersihkan saat turun ke Lihat Saja
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Akses Pengaturan Batas Invoice aktif; kombinasi prasyarat awal valid"
    When user memilih opsi "Lihat Saja" pada "Manajemen Invoice"
    Then sistem memverifikasi "Akses Pengaturan Batas Invoice" dengan hasil "Tidak terlihat"
    When user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Edit Hak Akses" dengan konteks "Edit Hak Akses"
    And user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin tersimpan mati dan tetap mati saat naik kembali; tidak diwarisi dari nilai lama"

  @negative @priority-high @REQ-028 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-089 — Akses Pengaturan Batas Invoice dibersihkan saat turun ke Tidak Ada Akses
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Akses Pengaturan Batas Invoice aktif; kombinasi prasyarat awal valid"
    When user memilih opsi "Tidak Ada Akses" pada "Manajemen Invoice"
    Then sistem memverifikasi "Akses Pengaturan Batas Invoice" dengan hasil "Tidak terlihat"
    When user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Edit Hak Akses" dengan konteks "Edit Hak Akses"
    And user memilih opsi "Akses Penuh" pada "Manajemen Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin tersimpan mati dan tetap mati saat naik kembali; tidak diwarisi dari nilai lama"

  @positive @priority-high @REQ-029 @screen-shipment
  Scenario: PENGATURAN-AKUN-POS-075 — Override Harga Pengiriman pada data terkunci dengan izin
    Given user berada di halaman "Shipment"
    And prasyarat "Aktor Shipment Akses Penuh dengan izin Harga Pengiriman; fixture terkunci aturan edit modul"
    When user mengisi field "Harga Pengiriman" dengan "1500000"
    And user mengisi field "Alasan" dengan "Koreksi disetujui operasional"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Harga Pengiriman berubah sesuai nilai; batas field lain tetap berlaku"

  @negative @priority-high @REQ-029 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-090 — Tanpa izin Harga Pengiriman field terkunci tidak dapat diubah
    Given user berada di halaman "Shipment"
    And prasyarat "Aktor Shipment Akses Penuh tanpa izin Harga Pengiriman; fixture terkunci aturan edit"
    Then sistem memverifikasi "Harga Pengiriman" dengan hasil "Read-only dengan alasan"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload perubahan dipaksakan ditolak; nilai lama tetap"

  @positive @priority-high @REQ-029 @screen-penugasan-tracking
  Scenario: PENGATURAN-AKUN-POS-076 — Override Nomor Polisi pada data terkunci dengan izin
    Given user berada di halaman "Penugasan Tracking"
    And prasyarat "Aktor Penugasan Tracking Akses Penuh dengan izin Nomor Polisi; fixture terkunci aturan edit modul"
    When user mengisi field "Nomor Polisi" dengan "B 1234 QA"
    And user mengisi field "Alasan" dengan "Koreksi disetujui operasional"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Nomor Polisi berubah sesuai nilai; batas field lain tetap berlaku"

  @negative @priority-high @REQ-029 @screen-penugasan-tracking
  Scenario: PENGATURAN-AKUN-NEG-091 — Tanpa izin Nomor Polisi field terkunci tidak dapat diubah
    Given user berada di halaman "Penugasan Tracking"
    And prasyarat "Aktor Penugasan Tracking Akses Penuh tanpa izin Nomor Polisi; fixture terkunci aturan edit"
    Then sistem memverifikasi "Nomor Polisi" dengan hasil "Read-only dengan alasan"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload perubahan dipaksakan ditolak; nilai lama tetap"

  @negative @priority-high @REQ-029 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-092 — Admin Utama tidak dapat override field di luar daftar
    Given user berada di halaman "Shipment"
    And prasyarat "Admin Utama memiliki Harga Pengiriman; fixture field Customer terkunci aturan modul"
    Then sistem memverifikasi "Customer" dengan hasil "Read-only dengan keterangan"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request paksa mengubah Customer ditolak; izin Harga Pengiriman tidak memperluas ke field lain"

  @negative @priority-high @REQ-029 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-093 — Sub user Akses Penuh tidak dapat override field di luar daftar
    Given user berada di halaman "Shipment"
    And prasyarat "Sub user Akses Penuh memiliki Harga Pengiriman; fixture field Customer terkunci aturan modul"
    Then sistem memverifikasi "Customer" dengan hasil "Read-only dengan keterangan"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request paksa mengubah Customer ditolak; izin Harga Pengiriman tidak memperluas ke field lain"

  @positive @priority-high @REQ-030 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-POS-077 — Izin per Shipment membuka kedua pintu masuk invoice
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Invoice Akses Penuh; Shipment Lihat Saja; per Shipment aktif; per Periode mati; shipment eligible FTL"
    When user mengklik elemen "Buat Invoice"
    Then sistem memverifikasi "Form Invoice" dengan hasil "Langsung tipe Shipment tanpa pilihan tipe"
    When user membuka halaman "Shipment" dengan konteks "Shipment"
    And user mengklik elemen "Proses Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Kedua pintu masuk membuka pembuatan invoice per Shipment"

  @negative @priority-high @REQ-030 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-094 — Tanpa izin per Shipment aksi Proses Invoice tersembunyi
    Given user berada di halaman "Shipment"
    And prasyarat "Invoice Akses Penuh; per Shipment mati; per Periode aktif; Shipment Akses Penuh"
    Then sistem memverifikasi "Proses Invoice" dengan hasil "Tidak terlihat"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request invoice per Shipment dipaksakan ditolak; tidak ada invoice baru"

  @positive @priority-high @REQ-031 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-POS-078 — Hanya per Periode masuk langsung ke form gabungan
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Invoice Penuh; per Periode aktif; per Shipment mati; dua shipment eligible customer C1 di tanggal fixture"
    When user mengklik elemen "Buat Invoice"
    Then sistem memverifikasi "Form Invoice" dengan hasil "Tipe Periode tanpa pilihan"
    When user memilih opsi "C1" pada "Customer"
    And user mengisi field "Tanggal Mulai" dengan "2026-09-01"
    And user mengisi field "Tanggal Akhir" dengan "2026-09-14"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Invoice gabungan customer C1 rentang 1–14 September tersimpan; Proses Invoice Shipment tetap tersembunyi"

  @negative @priority-high @REQ-031 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-NEG-095 — Kedua izin pembuatan mati tetap boleh kelola invoice lama
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Invoice Akses Penuh; kedua izin pembuatan mati; invoice lama I1 dapat diedit menurut aturan modul"
    Then sistem memverifikasi "Buat Invoice" dengan hasil "Tidak terlihat"
    When user mengklik elemen "Edit Invoice I1"
    And user mengisi field "Catatan" dengan "Revisi catatan"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Invoice lama boleh diubah sesuai batas modul; request buat invoice baru ditolak"

  @edge @priority-high @REQ-031 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-EDG-025 — Kedua tipe invoice aktif tersedia untuk dipilih
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Invoice Akses Penuh; per Shipment dan per Periode aktif"
    When user mengklik elemen "Buat Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Kedua jalur tipe Shipment dan Periode tersedia; tidak dibatasi salah satu"

  @positive @priority-high @REQ-032 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-POS-079 — Invoice berulang tipe Shipment di bawah batas
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Invoice Penuh; izin per Shipment dan Berulang aktif; tipe lain mati; batas fixture 2 dan baru ada 1 invoice pada target"
    When user mengklik elemen "Buat Invoice"
    And user memilih opsi "TARGET-1" pada "Target invoice"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Invoice kedua tipe diizinkan tersimpan; jumlah menjadi 2"

  @negative @priority-high @REQ-032 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-NEG-096 — Invoice berulang tipe Shipment tidak melewati batas
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Invoice Penuh; per Shipment dan Berulang aktif; batas fixture 2 sudah tercapai"
    When user mengklik elemen "Buat Invoice"
    And user memilih opsi "TARGET-1" pada "Target invoice"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Penyimpanan invoice ketiga ditolak; jumlah tetap 2"

  @positive @priority-high @REQ-032 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-POS-080 — Invoice berulang tipe Periode di bawah batas
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Invoice Penuh; izin per Periode dan Berulang aktif; tipe lain mati; batas fixture 2 dan baru ada 1 invoice pada target"
    When user mengklik elemen "Buat Invoice"
    And user memilih opsi "TARGET-1" pada "Target invoice"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Invoice kedua tipe diizinkan tersimpan; jumlah menjadi 2"

  @negative @priority-high @REQ-032 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-NEG-097 — Invoice berulang tipe Periode tidak melewati batas
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Invoice Penuh; per Periode dan Berulang aktif; batas fixture 2 sudah tercapai"
    When user mengklik elemen "Buat Invoice"
    And user memilih opsi "TARGET-1" pada "Target invoice"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Penyimpanan invoice ketiga ditolak; jumlah tetap 2"

  @negative @priority-high @REQ-032 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-098 — Berulang tidak boleh aktif tanpa izin pembuatan
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user menghapus centang "Buat Invoice per Shipment"
    And user menghapus centang "Buat Invoice per Periode"
    Then sistem memverifikasi "Pembuatan Invoice Berulang" dengan hasil "Tidak dapat diaktifkan atau simpan kombinasi ditolak"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tidak ada template tersimpan dengan Berulang aktif tanpa tipe pembuatan"

  @negative @priority-high @REQ-032 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-NEG-099 — Berulang per Periode tidak mengizinkan tipe Shipment
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Per Periode dan Berulang aktif; per Shipment mati; batas belum tercapai"
    Then sistem memverifikasi "Proses Invoice" dengan hasil "Tidak tersedia untuk Shipment"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request ulang tipe Shipment ditolak meskipun Berulang aktif"

  @edge @priority-high @REQ-032 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-026 — Mematikan izin pembuatan terakhir menangani Berulang
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Per Shipment dan Berulang aktif; Per Periode mati"
    When user menghapus centang "Buat Invoice per Shipment"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Berulang otomatis mati atau penyimpanan diblokir; tidak tersimpan kombinasi tanpa tipe"

  @positive @priority-high @REQ-033 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-POS-081 — Izin pengaturan membuka dan mengubah batas global
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Invoice Penuh; Akses Pengaturan Batas Invoice aktif"
    When user mengklik elemen "Pengaturan"
    And user mengisi field "Batas Invoice" dengan "3"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Batas 3 tersimpan dan terlihat oleh pengguna lain yang berwenang"

  @negative @priority-high @REQ-033 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-NEG-100 — Invoice Penuh tanpa izin pengaturan tidak boleh mengubah batas
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Invoice Penuh; Akses Pengaturan Batas Invoice mati"
    Then sistem memverifikasi "Pengaturan" dengan hasil "Tidak terlihat"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request baca/ubah pengaturan dipaksakan ditolak; batas global tidak berubah"

  @edge @priority-medium @REQ-033 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-027 — Pengaturan Batas Invoice terpisah dari kelompok izin pembuatan
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    Then sistem memverifikasi "Akses Pengaturan Batas Invoice" dengan hasil "Berada pada section terpisah"
    When user mencentang "Akses Pengaturan Batas Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin dapat dipilih tanpa menyalakan izin pembuatan atau Berulang"

  @positive @priority-high @REQ-034 @screen-shipment
  Scenario: PENGATURAN-AKUN-POS-082 — Override Harga Pengiriman merekam alasan di riwayat data
    Given user berada di halaman "Shipment"
    And prasyarat "Aktor berizin Harga Pengiriman; data terkunci; nilai awal diketahui"
    When user mengisi field "Harga Pengiriman" dengan "1750000"
    And user mengisi field "Alasan" dengan "Koreksi dokumen nomor QA-42"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user mengklik elemen "Riwayat"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Perubahan dan alasan QA-42 tercatat pada record yang diubah; nilai akhir benar"

  @negative @priority-high @REQ-034 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-101 — Override Harga Pengiriman tanpa alasan ditolak
    Given user berada di halaman "Shipment"
    And prasyarat "Aktor berizin Harga Pengiriman; data terkunci"
    When user mengisi field "Harga Pengiriman" dengan "1750000"
    And user mengisi field "Alasan" dengan ""
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error alasan wajib; nilai data tidak berubah; tidak ada audit perubahan sukses palsu"

  @positive @priority-high @REQ-034 @screen-penugasan-tracking
  Scenario: PENGATURAN-AKUN-POS-083 — Override Nomor Polisi merekam alasan di riwayat data
    Given user berada di halaman "Penugasan Tracking"
    And prasyarat "Aktor berizin Nomor Polisi; data terkunci; nilai awal diketahui"
    When user mengisi field "Nomor Polisi" dengan "B 5678 QA"
    And user mengisi field "Alasan" dengan "Koreksi dokumen nomor QA-42"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user mengklik elemen "Riwayat"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Perubahan dan alasan QA-42 tercatat pada record yang diubah; nilai akhir benar"

  @negative @priority-high @REQ-034 @screen-penugasan-tracking
  Scenario: PENGATURAN-AKUN-NEG-102 — Override Nomor Polisi tanpa alasan ditolak
    Given user berada di halaman "Penugasan Tracking"
    And prasyarat "Aktor berizin Nomor Polisi; data terkunci"
    When user mengisi field "Nomor Polisi" dengan "B 5678 QA"
    And user mengisi field "Alasan" dengan ""
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error alasan wajib; nilai data tidak berubah; tidak ada audit perubahan sukses palsu"

  @positive @priority-high @REQ-035 @screen-shipment
  Scenario: PENGATURAN-AKUN-POS-084 — Cetak Resi di Shipment mengikuti hak modul tujuan
    Given user berada di halaman "Shipment"
    And prasyarat "Shipment minimal Lihat Saja; Shipment Lihat Saja; record FTL eligible aksi"
    When user mengklik elemen "Cetak Resi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Aksi Cetak Resi dapat dijalankan atau membuka form tujuan sesuai hak Shipment; tidak menuntut hak lebih pada halaman asal"

  @negative @priority-high @REQ-035 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-103 — Cetak Resi disembunyikan tanpa hak tujuan
    Given user berada di halaman "Shipment"
    And prasyarat "Hak tujuan Shipment tidak cukup untuk Cetak Resi; Shipment Lihat Saja agar daftar terlihat; Cetak Resi diuji dengan Shipment Tidak Ada Akses jika terkait"
    Then sistem memverifikasi "Cetak Resi" dengan hasil "Tidak terlihat"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request langsung Cetak Resi ditolak; tidak ada perubahan data/output terlarang"

  @positive @priority-high @REQ-035 @screen-shipment
  Scenario: PENGATURAN-AKUN-POS-085 — Ajukan Klaim Asuransi di Shipment mengikuti hak modul tujuan
    Given user berada di halaman "Shipment"
    And prasyarat "Shipment minimal Lihat Saja; Klaim Asuransi Akses Penuh; record FTL eligible aksi"
    When user mengklik elemen "Ajukan Klaim Asuransi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Aksi Ajukan Klaim Asuransi dapat dijalankan atau membuka form tujuan sesuai hak Klaim Asuransi; tidak menuntut hak lebih pada halaman asal"

  @negative @priority-high @REQ-035 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-104 — Ajukan Klaim Asuransi disembunyikan tanpa hak tujuan
    Given user berada di halaman "Shipment"
    And prasyarat "Hak tujuan Klaim Asuransi tidak cukup untuk Ajukan Klaim Asuransi; Shipment Lihat Saja agar daftar terlihat; Cetak Resi diuji dengan Shipment Tidak Ada Akses jika terkait"
    Then sistem memverifikasi "Ajukan Klaim Asuransi" dengan hasil "Tidak terlihat"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request langsung Ajukan Klaim Asuransi ditolak; tidak ada perubahan data/output terlarang"

  @positive @priority-high @REQ-035 @screen-shipment
  Scenario: PENGATURAN-AKUN-POS-086 — Proses Invoice di Shipment mengikuti hak modul tujuan
    Given user berada di halaman "Shipment"
    And prasyarat "Shipment minimal Lihat Saja; Manajemen Invoice Akses Penuh + Buat Invoice per Shipment; record FTL eligible aksi"
    When user mengklik elemen "Proses Invoice"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Aksi Proses Invoice dapat dijalankan atau membuka form tujuan sesuai hak Manajemen Invoice; tidak menuntut hak lebih pada halaman asal"

  @negative @priority-high @REQ-035 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-105 — Proses Invoice disembunyikan tanpa hak tujuan
    Given user berada di halaman "Shipment"
    And prasyarat "Hak tujuan Manajemen Invoice tidak cukup untuk Proses Invoice; Shipment Lihat Saja agar daftar terlihat; Cetak Resi diuji dengan Shipment Tidak Ada Akses jika terkait"
    Then sistem memverifikasi "Proses Invoice" dengan hasil "Tidak terlihat"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request langsung Proses Invoice ditolak; tidak ada perubahan data/output terlarang"

  @positive @priority-high @REQ-035 @screen-shipment
  Scenario: PENGATURAN-AKUN-POS-087 — Tambah Biaya HPP di Shipment mengikuti hak modul tujuan
    Given user berada di halaman "Shipment"
    And prasyarat "Shipment minimal Lihat Saja; Tambah Biaya HPP Shipment Akses Penuh; record FTL eligible aksi"
    When user mengklik elemen "Tambah Biaya HPP"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Aksi Tambah Biaya HPP dapat dijalankan atau membuka form tujuan sesuai hak Tambah Biaya HPP Shipment; tidak menuntut hak lebih pada halaman asal"

  @negative @priority-high @REQ-035 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-106 — Tambah Biaya HPP disembunyikan tanpa hak tujuan
    Given user berada di halaman "Shipment"
    And prasyarat "Hak tujuan Tambah Biaya HPP Shipment tidak cukup untuk Tambah Biaya HPP; Shipment Lihat Saja agar daftar terlihat; Cetak Resi diuji dengan Shipment Tidak Ada Akses jika terkait"
    Then sistem memverifikasi "Tambah Biaya HPP" dengan hasil "Tidak terlihat"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request langsung Tambah Biaya HPP ditolak; tidak ada perubahan data/output terlarang"

  @positive @priority-high @REQ-035 @screen-shipment
  Scenario: PENGATURAN-AKUN-POS-088 — Ubah di Shipment mengikuti hak modul tujuan
    Given user berada di halaman "Shipment"
    And prasyarat "Shipment minimal Lihat Saja; Shipment Akses Penuh; record FTL eligible aksi"
    When user mengklik elemen "Ubah"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Aksi Ubah dapat dijalankan atau membuka form tujuan sesuai hak Shipment; tidak menuntut hak lebih pada halaman asal"

  @negative @priority-high @REQ-035 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-107 — Ubah disembunyikan tanpa hak tujuan
    Given user berada di halaman "Shipment"
    And prasyarat "Hak tujuan Shipment tidak cukup untuk Ubah; Shipment Lihat Saja agar daftar terlihat; Cetak Resi diuji dengan Shipment Tidak Ada Akses jika terkait"
    Then sistem memverifikasi "Ubah" dengan hasil "Tidak terlihat"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request langsung Ubah ditolak; tidak ada perubahan data/output terlarang"

  @positive @priority-high @REQ-035 @screen-shipment
  Scenario: PENGATURAN-AKUN-POS-089 — Hapus di Shipment mengikuti hak modul tujuan
    Given user berada di halaman "Shipment"
    And prasyarat "Shipment minimal Lihat Saja; Shipment Akses Penuh; record FTL eligible aksi"
    When user mengklik elemen "Hapus"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Aksi Hapus dapat dijalankan atau membuka form tujuan sesuai hak Shipment; tidak menuntut hak lebih pada halaman asal"

  @negative @priority-high @REQ-035 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-108 — Hapus disembunyikan tanpa hak tujuan
    Given user berada di halaman "Shipment"
    And prasyarat "Hak tujuan Shipment tidak cukup untuk Hapus; Shipment Lihat Saja agar daftar terlihat; Cetak Resi diuji dengan Shipment Tidak Ada Akses jika terkait"
    Then sistem memverifikasi "Hapus" dengan hasil "Tidak terlihat"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request langsung Hapus ditolak; tidak ada perubahan data/output terlarang"

  @positive @priority-high @REQ-036 @screen-shipment
  Scenario: PENGATURAN-AKUN-POS-090 — Aksi terkunci disabled dan field read-only tetap terlihat
    Given user berada di halaman "Shipment"
    And prasyarat "Shipment Penuh; record S1 terkunci menurut fixture aturan modul; tidak ada izin override"
    Then sistem memverifikasi "Ubah" dengan hasil "Terlihat, disabled, alasan terlihat"
    And sistem memverifikasi "Harga Pengiriman" dengan hasil "Terlihat, read-only, alasan terlihat"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Pengguna dapat mengetahui pembatasan; nilai field tetap terbaca"

  @negative @priority-high @REQ-036 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-109 — Memanipulasi disabled dan read-only tidak melewati batas data
    Given user berada di halaman "Shipment"
    And prasyarat "Aktor Penuh tanpa override; S1 terkunci; harness menghapus atribut readonly/disabled pada DOM"
    When user mengisi field "Harga Pengiriman" dengan "999999"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Backend menolak; harga S1 dan riwayat perubahan sukses tidak bertambah"

  @positive @priority-high @REQ-037 @screen-dashboard-monitoring
  Scenario: PENGATURAN-AKUN-POS-091 — Dashboard Monitoring menyaring widget sesuai sumber dan jenis
    Given user berada di halaman "Dashboard Monitoring"
    And prasyarat "Dashboard Monitoring Penuh; Shipment Lihat Saja; FTL diizinkan; data sumber FTL dan LCL tersedia"
    Then sistem memverifikasi "Widget Shipment" dengan hasil "Hanya data FTL"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Widget sumber diizinkan dirender dengan hitungan berdasarkan FTL saja; tidak ada konfigurasi hak per widget"

  @negative @priority-high @REQ-037 @screen-dashboard-monitoring
  Scenario: PENGATURAN-AKUN-NEG-110 — Dashboard Monitoring tidak merender widget sumber tanpa akses
    Given user berada di halaman "Dashboard Monitoring"
    And prasyarat "Dashboard Monitoring Penuh; Invoice Tidak Ada Akses; data invoice ada"
    Then sistem memverifikasi "Widget Invoice" dengan hasil "Tidak dirender"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload dashboard tidak memuat data Invoice; widget tidak sekadar disembunyikan CSS"

  @positive @priority-high @REQ-037 @screen-dashboard-tracking-location
  Scenario: PENGATURAN-AKUN-POS-092 — Dashboard Tracking & Location menyaring widget sesuai sumber dan jenis
    Given user berada di halaman "Dashboard Tracking & Location"
    And prasyarat "Dashboard Tracking & Location Penuh; Shipment Lihat Saja; FTL diizinkan; data sumber FTL dan LCL tersedia"
    Then sistem memverifikasi "Widget Shipment" dengan hasil "Hanya data FTL"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Widget sumber diizinkan dirender dengan hitungan berdasarkan FTL saja; tidak ada konfigurasi hak per widget"

  @negative @priority-high @REQ-037 @screen-dashboard-tracking-location
  Scenario: PENGATURAN-AKUN-NEG-111 — Dashboard Tracking & Location tidak merender widget sumber tanpa akses
    Given user berada di halaman "Dashboard Tracking & Location"
    And prasyarat "Dashboard Tracking & Location Penuh; Invoice Tidak Ada Akses; data invoice ada"
    Then sistem memverifikasi "Widget Invoice" dengan hasil "Tidak dirender"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload dashboard tidak memuat data Invoice; widget tidak sekadar disembunyikan CSS"

  @positive @priority-high @REQ-037 @screen-dashboard-operasional
  Scenario: PENGATURAN-AKUN-POS-093 — Dashboard Operasional menyaring widget sesuai sumber dan jenis
    Given user berada di halaman "Dashboard Operasional"
    And prasyarat "Dashboard Operasional Penuh; Shipment Lihat Saja; FTL diizinkan; data sumber FTL dan LCL tersedia"
    Then sistem memverifikasi "Widget Shipment" dengan hasil "Hanya data FTL"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Widget sumber diizinkan dirender dengan hitungan berdasarkan FTL saja; tidak ada konfigurasi hak per widget"

  @negative @priority-high @REQ-037 @screen-dashboard-operasional
  Scenario: PENGATURAN-AKUN-NEG-112 — Dashboard Operasional tidak merender widget sumber tanpa akses
    Given user berada di halaman "Dashboard Operasional"
    And prasyarat "Dashboard Operasional Penuh; Invoice Tidak Ada Akses; data invoice ada"
    Then sistem memverifikasi "Widget Invoice" dengan hasil "Tidak dirender"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload dashboard tidak memuat data Invoice; widget tidak sekadar disembunyikan CSS"

  @positive @priority-high @REQ-038 @screen-shipment
  Scenario: PENGATURAN-AKUN-POS-094 — Backend menerima request yang masih valid saat eksekusi
    Given user berada di halaman "Shipment"
    And prasyarat "Shipment Penuh; S1 eligible ketika form dibuka dan saat disimpan"
    When user mengisi field "Harga Pengiriman" dengan "2000000"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request diterima; data berubah sesuai payload; tidak ada false denial"

  @negative @priority-high @REQ-038 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-113 — Validasi backend: Status data berubah menjadi terkunci setelah form dibuka
    Given user berada di halaman "Shipment"
    And prasyarat "Form dibuka saat hak dan data valid"
    And prasyarat "Status data berubah menjadi terkunci setelah form dibuka"
    And prasyarat "Harness mereplay request simpan dengan kondisi eksekusi terbaru"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request ditolak berdasarkan keadaan saat eksekusi; tidak ada perubahan tidak sah"

  @negative @priority-high @REQ-038 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-114 — Validasi backend: Sesi baru mempunyai level Lihat Saja ketika request dikirim
    Given user berada di halaman "Shipment"
    And prasyarat "Form dibuka saat hak dan data valid"
    And prasyarat "Sesi baru mempunyai level Lihat Saja ketika request dikirim"
    And prasyarat "Harness mereplay request simpan dengan kondisi eksekusi terbaru"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request ditolak berdasarkan keadaan saat eksekusi; tidak ada perubahan tidak sah"

  @negative @priority-high @REQ-038 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-115 — Validasi backend: Payload menambahkan jenis pengiriman yang tidak diizinkan
    Given user berada di halaman "Shipment"
    And prasyarat "Form dibuka saat hak dan data valid"
    And prasyarat "Payload menambahkan jenis pengiriman yang tidak diizinkan"
    And prasyarat "Harness mereplay request simpan dengan kondisi eksekusi terbaru"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request ditolak berdasarkan keadaan saat eksekusi; tidak ada perubahan tidak sah"

  @negative @priority-high @REQ-038 @screen-shipment
  Scenario: PENGATURAN-AKUN-NEG-116 — Validasi backend: Payload menyisipkan izin tambahan di luar kewenangan
    Given user berada di halaman "Shipment"
    And prasyarat "Form dibuka saat hak dan data valid"
    And prasyarat "Payload menyisipkan izin tambahan di luar kewenangan"
    And prasyarat "Harness mereplay request simpan dengan kondisi eksekusi terbaru"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Request ditolak berdasarkan keadaan saat eksekusi; tidak ada perubahan tidak sah"

  @positive @priority-high @REQ-039 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-095 — Notifikasi kapal tersedia dengan hanya FCL
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mencentang "FCL"
    And user menghapus centang "FTL"
    And user menghapus centang "LTL"
    And user menghapus centang "LCL"
    And user menghapus centang "Airfreight"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Kapal Sandar dan Kapal Berlayar terlihat; Lupa Password dan Ubah Password tidak ada"

  @positive @priority-high @REQ-039 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-096 — Notifikasi kapal tersedia dengan hanya LCL
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mencentang "LCL"
    And user menghapus centang "FTL"
    And user menghapus centang "LTL"
    And user menghapus centang "FCL"
    And user menghapus centang "Airfreight"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Kapal Sandar dan Kapal Berlayar terlihat; Lupa Password dan Ubah Password tidak ada"

  @negative @priority-high @REQ-039 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-117 — Tanpa jenis laut kedua notifikasi kapal tidak tampil
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user menghapus centang "FCL"
    And user menghapus centang "LCL"
    And user mencentang "FTL"
    And user mencentang "LTL"
    And user mencentang "Airfreight"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Kapal Sandar dan Kapal Berlayar tidak ada; notifikasi nonlaut yang memenuhi prasyarat tetap tersedia"

  @edge @priority-high @REQ-039 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-028 — Menghapus jenis laut terakhir menyembunyikan notifikasi kapal
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Awalnya hanya FCL dan FTL dipilih; kedua notifikasi kapal aktif"
    When user menghapus centang "FCL"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Kedua notifikasi kapal hilang dan tidak dikirim; FTL tetap dipilih"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-097 — Shipment Terkirim dapat aktif dengan prasyarat Shipment
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Shipment"
    And user mencentang "Shipment Terkirim"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-118 — Shipment Terkirim tidak boleh aktif tanpa akses Shipment
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Shipment Terkirim" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-098 — Order Selesai dapat aktif dengan prasyarat Order
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Order"
    And user mencentang "Order Selesai"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-119 — Order Selesai tidak boleh aktif tanpa akses Order
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Order Selesai" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-099 — Order Dibatalkan dapat aktif dengan prasyarat Order
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Order"
    And user mencentang "Order Dibatalkan"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-120 — Order Dibatalkan tidak boleh aktif tanpa akses Order
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Order Dibatalkan" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-100 — Order Telah Ditugaskan dapat aktif dengan prasyarat Order
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Order"
    And user mencentang "Order Telah Ditugaskan"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-121 — Order Telah Ditugaskan tidak boleh aktif tanpa akses Order
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Order Telah Ditugaskan" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-101 — Tahap Pengiriman - Berangkat Muat dapat aktif dengan prasyarat Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Penugasan Tracking"
    And user mencentang "Tahap Pengiriman - Berangkat Muat"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-122 — Tahap Pengiriman - Berangkat Muat tidak boleh aktif tanpa akses Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Tahap Pengiriman - Berangkat Muat" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-102 — Tahap Pengiriman - Selesai Muat dapat aktif dengan prasyarat Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Penugasan Tracking"
    And user mencentang "Tahap Pengiriman - Selesai Muat"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-123 — Tahap Pengiriman - Selesai Muat tidak boleh aktif tanpa akses Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Tahap Pengiriman - Selesai Muat" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-103 — Tahap Pengiriman - Kapal Sandar dapat aktif dengan prasyarat Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Penugasan Tracking"
    And user mencentang "Tahap Pengiriman - Kapal Sandar"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-124 — Tahap Pengiriman - Kapal Sandar tidak boleh aktif tanpa akses Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Tahap Pengiriman - Kapal Sandar" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-104 — Tahap Pengiriman - Kapal Berlayar dapat aktif dengan prasyarat Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Penugasan Tracking"
    And user mencentang "Tahap Pengiriman - Kapal Berlayar"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-125 — Tahap Pengiriman - Kapal Berlayar tidak boleh aktif tanpa akses Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Tahap Pengiriman - Kapal Berlayar" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-105 — Tahap Pengiriman - Dooring dapat aktif dengan prasyarat Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Penugasan Tracking"
    And user mencentang "Tahap Pengiriman - Dooring"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-126 — Tahap Pengiriman - Dooring tidak boleh aktif tanpa akses Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Tahap Pengiriman - Dooring" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-106 — Tahap Pengiriman - Berangkat Bongkar dapat aktif dengan prasyarat Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Penugasan Tracking"
    And user mencentang "Tahap Pengiriman - Berangkat Bongkar"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-127 — Tahap Pengiriman - Berangkat Bongkar tidak boleh aktif tanpa akses Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Tahap Pengiriman - Berangkat Bongkar" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-107 — Tahap Pengiriman - Selesai Bongkar dapat aktif dengan prasyarat Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Penugasan Tracking"
    And user mencentang "Tahap Pengiriman - Selesai Bongkar"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-128 — Tahap Pengiriman - Selesai Bongkar tidak boleh aktif tanpa akses Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Tahap Pengiriman - Selesai Bongkar" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-108 — Tahap Pengiriman - Alihkan Armada/Petugas dapat aktif dengan prasyarat Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Penugasan Tracking"
    And user mencentang "Tahap Pengiriman - Alihkan Armada/Petugas"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-129 — Tahap Pengiriman - Alihkan Armada/Petugas tidak boleh aktif tanpa akses Penugasan Tracking
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Tahap Pengiriman - Alihkan Armada/Petugas" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-109 — Terjadi Kendala Armada dapat aktif dengan prasyarat Dashboard Monitoring
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Akses Penuh" pada "Dashboard Monitoring"
    And user mencentang "Terjadi Kendala Armada"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-130 — Terjadi Kendala Armada tidak boleh aktif tanpa akses Dashboard Monitoring
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Terjadi Kendala Armada" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-110 — Armada Tidak Update dapat aktif dengan prasyarat Dashboard Monitoring
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Akses Penuh" pada "Dashboard Monitoring"
    And user mencentang "Armada Tidak Update"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-131 — Armada Tidak Update tidak boleh aktif tanpa akses Dashboard Monitoring
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Armada Tidak Update" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-111 — Armada Melewati Estimasi Waktu dapat aktif dengan prasyarat Dashboard Monitoring
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Akses Penuh" pada "Dashboard Monitoring"
    And user mencentang "Armada Melewati Estimasi Waktu"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-132 — Armada Melewati Estimasi Waktu tidak boleh aktif tanpa akses Dashboard Monitoring
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Armada Melewati Estimasi Waktu" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-112 — Invoice Telah Dibuat dapat aktif dengan prasyarat Manajemen Invoice
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Manajemen Invoice"
    And user mencentang "Invoice Telah Dibuat"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-133 — Invoice Telah Dibuat tidak boleh aktif tanpa akses Manajemen Invoice
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Invoice Telah Dibuat" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-113 — Reminder Invoice Jatuh Tempo dapat aktif dengan prasyarat Manajemen Invoice
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "FCL dipilih sehingga notifikasi kapal tersedia"
    When user memilih opsi "Lihat Saja" pada "Manajemen Invoice"
    And user mencentang "Reminder Invoice Jatuh Tempo"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Notifikasi aktif tersimpan ketika akses modul sumber dan jenis memenuhi"

  @negative @priority-high @REQ-040 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-134 — Reminder Invoice Jatuh Tempo tidak boleh aktif tanpa akses Manajemen Invoice
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    Then sistem memverifikasi "Reminder Invoice Jatuh Tempo" dengan hasil "Tidak dapat menghasilkan notifikasi aktif yang dapat dikirim"
    When user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Payload notifikasi aktif tidak menghasilkan pengiriman dari sumber tanpa akses; nilai invalid dinonaktifkan atau penyimpanan ditolak"

  @positive @priority-high @REQ-041 @screen-pusat-notifikasi
  Scenario: PENGATURAN-AKUN-POS-114 — Notifikasi terkirim saat toggle akses dan jenis sesuai
    Given user berada di halaman "Pusat Notifikasi"
    And prasyarat "U1 Shipment Lihat Saja, FTL; Shipment Terkirim aktif; harness menerbitkan event E1 untuk S-FTL"
    Then sistem memverifikasi "Notifikasi" dengan hasil "Tunggu event E1 sesuai timeout harness"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "E1 diterima U1 dan merujuk S-FTL"

  @negative @priority-high @REQ-041 @screen-pusat-notifikasi
  Scenario: PENGATURAN-AKUN-NEG-135 — Pengiriman notifikasi diblokir karena jenis LCL tidak dipilih
    Given user berada di halaman "Pusat Notifikasi"
    And prasyarat "U1 mengalami jenis LCL tidak dipilih; kondisi lainnya valid; harness menerbitkan E2 dan drain antrean"
    Then sistem memverifikasi "Notifikasi" dengan hasil "Periksa UI dan sink pengiriman setelah antrean selesai"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "E2 tidak diterima U1; tidak bocor melalui isi/payload notifikasi"

  @negative @priority-high @REQ-041 @screen-pusat-notifikasi
  Scenario: PENGATURAN-AKUN-NEG-136 — Pengiriman notifikasi diblokir karena Shipment Tidak Ada Akses
    Given user berada di halaman "Pusat Notifikasi"
    And prasyarat "U1 mengalami Shipment Tidak Ada Akses; kondisi lainnya valid; harness menerbitkan E2 dan drain antrean"
    Then sistem memverifikasi "Notifikasi" dengan hasil "Periksa UI dan sink pengiriman setelah antrean selesai"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "E2 tidak diterima U1; tidak bocor melalui isi/payload notifikasi"

  @negative @priority-high @REQ-041 @screen-pusat-notifikasi
  Scenario: PENGATURAN-AKUN-NEG-137 — Pengiriman notifikasi diblokir karena toggle Shipment Terkirim mati
    Given user berada di halaman "Pusat Notifikasi"
    And prasyarat "U1 mengalami toggle Shipment Terkirim mati; kondisi lainnya valid; harness menerbitkan E2 dan drain antrean"
    Then sistem memverifikasi "Notifikasi" dengan hasil "Periksa UI dan sink pengiriman setelah antrean selesai"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "E2 tidak diterima U1; tidak bocor melalui isi/payload notifikasi"

  @positive @priority-high @REQ-042 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-POS-115 — Default template baru sama pada tab Hak Akses dan inline
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    Then sistem memverifikasi "Default template" dengan hasil "5 jenis aktif, 16 modul Penuh, 17 notifikasi tersedia aktif, 6 izin mati"
    When user membuka halaman "Tambah Sub User" dengan konteks "Tambah Sub User"
    And user mengklik elemen "Buat Hak Akses"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Default inline identik dengan form mandiri"

  @negative @priority-high @REQ-042 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-138 — Form template baru tidak mewarisi izin sesi edit sebelumnya
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Sebelumnya membuka template yang mempunyai enam izin aktif; sudah kembali daftar"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Semua izin template baru mati; tidak ada state izin template sebelumnya terbawa"

  @positive @priority-high @REQ-043 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-POS-116 — Template tanpa pemakai dapat dihapus
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "T-EMPTY memiliki 0 pemakai"
    When user mengklik elemen "Hapus"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "T-EMPTY hilang dari daftar dan dropdown setelah muat ulang"

  @negative @priority-high @REQ-043 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-139 — Template dengan 1 pemakai tidak dapat dihapus
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "T1 digunakan 1 sub user"
    When user mengklik elemen "Hapus"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Penolakan penghapusan; T1 dan semua referensi pengguna tetap utuh"

  @negative @priority-high @REQ-043 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-140 — Template dengan 3 pemakai tidak dapat dihapus
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "T1 digunakan 3 sub user"
    When user mengklik elemen "Hapus"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Penolakan penghapusan; T1 dan semua referensi pengguna tetap utuh"

  @positive @priority-high @REQ-044 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-117 — Konfirmasi menampilkan daftar persis izin yang diberikan
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mencentang "Harga Pengiriman"
    And user mencentang "Buat Invoice per Periode"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Konfirmasi" dengan hasil "Daftar tepat Harga Pengiriman dan Buat Invoice per Periode"
    When user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Hanya dua izin tersebut aktif tersimpan"

  @negative @priority-high @REQ-044 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-141 — Menolak konfirmasi pemberian izin tidak menyimpan izin
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mencentang "Harga Pengiriman"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Kembali ke Form"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Izin tersimpan tetap mati; perubahan hanya berada di form"

  @positive @priority-high @REQ-045 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-POS-118 — Audit edit template mencatat pelaku waktu sebelum sesudah
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "T1 Order awal Penuh; aktor A1; waktu server dalam rentang awal-akhir pengujian"
    When user memilih opsi "Lihat Saja" pada "Order"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user mengklik elemen "Riwayat"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Audit T1 memuat A1, waktu dalam rentang uji, Order Penuh → Lihat Saja; nilai cocok data tersimpan"

  @negative @priority-high @REQ-045 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-142 — Edit template gagal tidak dicatat sebagai perubahan sukses
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mengisi field "Nama Hak Akses" dengan ""
    And user mengklik elemen "Simpan"
    And user membuka halaman "Riwayat Hak Akses" dengan konteks "Riwayat Hak Akses"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tidak ada audit perubahan sukses dengan nama kosong; nilai sebelum/sesudah tidak dipalsukan"

  @edge @priority-medium @REQ-005 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-EDG-029 — WhatsApp mempertahankan nol di awal
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Nomor WhatsApp" dengan "081234567891"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Nilai tersimpan dan detail tetap 081234567891, tidak berubah menjadi angka tanpa nol"

  @edge @priority-high @REQ-016 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-030 — Edit nama template tetap sama tidak dianggap duplikat
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Nama saat ini QA Sendiri"
    When user mengisi field "Nama Hak Akses" dengan "QA Sendiri"
    And user mengisi field "Deskripsi" dengan "Catatan baru"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Deskripsi berubah; nama milik record sendiri diterima"

  @edge @priority-medium @REQ-019 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-EDG-031 — Template nol pemakai menyebut nol terdampak
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Template memiliki nol pemakai"
    When user memilih opsi "Lihat Saja" pada "Order"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Konfirmasi" dengan hasil "Jumlah sub user terdampak 0"
    When user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Template dapat diperbarui walaupun belum dipakai"

  @edge @priority-medium @REQ-008 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-EDG-032 — Pergantian template mengganti seluruh preview
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "T1 hanya FTL, Order Penuh; T2 hanya LCL, Order Tidak Ada Akses"
    When user memilih opsi "T1" pada "Hak Akses"
    And user memilih opsi "T2" pada "Hak Akses"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Preview tepat T2, tidak menggabungkan jenis atau izin T1"

  @edge @priority-high @REQ-009 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-EDG-033 — Beralih dari Buat ke Pilih tidak menyimpan draft template
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengklik elemen "Buat Hak Akses"
    And user mengisi field "Nama Hak Akses" dengan "Draft Batal"
    And user mengklik elemen "Pilih Hak Akses"
    And user memilih opsi "QA Valid" pada "Hak Akses"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Sub user memakai QA Valid; Draft Batal tidak menjadi template orphan"

  @stress @priority-medium @REQ-004 @screen-sub-user
  Scenario: PENGATURAN-AKUN-STR-001 — 1000 record dan 50 perpindahan halaman Sub User
    Given user berada di halaman "Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Fixture 1000 record; observer loading aktif; harness mengulang siklus halaman 50 kali"
    When user memilih opsi "20" pada "Data per halaman"
    And user mengklik elemen "Halaman berikutnya"
    And user mengklik elemen "Halaman sebelumnya"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tidak ada loading state sepanjang transisi; tiap halaman tepat record fixture; tidak ada duplikasi, hilang data atau UI macet"

  @stress @priority-medium @REQ-015 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-STR-002 — 1000 record dan 50 perpindahan halaman Hak Akses
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Fixture 1000 record; observer loading aktif; harness mengulang siklus halaman 50 kali"
    When user memilih opsi "20" pada "Data per halaman"
    And user mengklik elemen "Halaman berikutnya"
    And user mengklik elemen "Halaman sebelumnya"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tidak ada loading state sepanjang transisi; tiap halaman tepat record fixture; tidak ada duplikasi, hilang data atau UI macet"

  @stress @priority-high @REQ-006 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-STR-003 — 20 simpan paralel dengan Email sama
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "20 konteks browser; semua field unik selain field yang diuji; barrier sebelum Simpan"
    When user mengisi field "Email" dengan "race@example.test"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tepat satu sub user dibuat; 19 penolakan duplikat; tidak ada duplikat backend"

  @stress @priority-high @REQ-006 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-STR-004 — 20 simpan paralel dengan Nomor WhatsApp sama
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "20 konteks browser; semua field unik selain field yang diuji; barrier sebelum Simpan"
    When user mengisi field "Nomor WhatsApp" dengan "081277777777"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tepat satu sub user dibuat; 19 penolakan duplikat; tidak ada duplikat backend"

  @stress @priority-high @REQ-016 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-STR-005 — 20 template paralel dengan nama sama
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "20 sesi dengan nama sama, barrier sebelum Simpan"
    When user mengisi field "Nama Hak Akses" dengan "QA Race Nama"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Tepat satu template tercipta; lainnya ditolak duplikat"

  @stress @priority-high @REQ-043 @screen-hak-akses
  Scenario: PENGATURAN-AKUN-STR-006 — Race pemasangan template versus hapus menjaga referensi
    Given user berada di halaman "Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "T-RACE awal nol pemakai; sesi A hapus, sesi B pasang ke sub user, barrier transaksi bersamaan"
    When user mengklik elemen "Hapus"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Salah satu operasi ditolak sesuai urutan commit; tidak ada sub user menunjuk template terhapus"

  @stress @priority-high @REQ-019 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-STR-007 — Perubahan template untuk 1000 sub user tetap konsisten
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "T-BULK digunakan 1000 sub user; T-OTHER untuk kontrol"
    When user memilih opsi "Lihat Saja" pada "Order"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Konfirmasi" dengan hasil "Jumlah terdampak 1000"
    When user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Seluruh 1000 login baru menggunakan Order Lihat Saja; pengguna T-OTHER tetap; tidak ada update parsial"

  @stress @priority-high @REQ-020 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-STR-008 — 100 pergantian shortcut dan izin tidak menyisakan state lama
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Harness mengulang tiga langkah shortcut 100 kali"
    When user memilih opsi "Akses Penuh" pada "Terapkan Cepat ke Semua Modul"
    And user mencentang "Harga Pengiriman"
    And user memilih opsi "Tidak Ada Akses" pada "Terapkan Cepat ke Semua Modul"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Hasil akhir 16 modul Tidak Ada Akses, enam izin mati, tidak ada nilai aktif lama tersimpan"

  @stress @priority-high @REQ-024 @screen-export
  Scenario: PENGATURAN-AKUN-STR-009 — 20 sesi export menjaga isolasi jenis pengiriman
    Given user berada di halaman "Export"
    And prasyarat "20 pengguna terbagi 5 jenis; 1000 record tersebar merata; semua modul sumber berizin"
    When user mengklik elemen "Export"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Setiap file hanya memuat 200 record jenis pengguna bersangkutan; tidak ada kebocoran antar sesi"

  @stress @priority-high @REQ-038 @screen-shipment
  Scenario: PENGATURAN-AKUN-STR-010 — 20 request ilegal paralel tetap ditolak backend
    Given user berada di halaman "Shipment"
    And prasyarat "20 sesi Lihat Saja; harness mengirim mutasi harga simultan"
    Then sistem memverifikasi "Respons request ilegal" dengan hasil "Harness mengirim 20 request paralel sesuai testData"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Seluruh request ditolak; nilai harga dan jumlah record tidak berubah"

  @stress @priority-high @REQ-032 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-STR-011 — Race invoice berulang tidak melampaui batas
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "20 sesi berizin per Shipment dan Berulang; target sama; batas 2; sudah ada 1 invoice"
    When user mengklik elemen "Buat Invoice"
    And user memilih opsi "TARGET-RACE" pada "Target invoice"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Maksimal satu invoice baru; total tidak melewati 2 walau request bersamaan"

  @stress @priority-high @REQ-041 @screen-pusat-notifikasi
  Scenario: PENGATURAN-AKUN-STR-012 — 1000 event notifikasi tersaring saat antrean padat
    Given user berada di halaman "Pusat Notifikasi"
    And prasyarat "1000 event unik: 500 FTL dan 500 LCL; U1 hanya FTL; Shipment Lihat Saja; toggle aktif; sink tersedia"
    Then sistem memverifikasi "Notifikasi" dengan hasil "Harness drain antrean hingga seluruh event diproses"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Hanya 500 event FTL boleh diterima; tidak ada LCL; seluruh event FTL valid tercakup menurut kontrak delivery"

  @stress @priority-high @REQ-009 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-STR-013 — Gangguan respons simpan inline tidak menciptakan data parsial
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "Form membuat template QA Timeout; harness menunda lalu memutus respons setelah request dikirim"
    When user mengklik elemen "Buat Hak Akses"
    And user mengisi field "Nama Hak Akses" dengan "QA Timeout"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Sub User" dengan konteks "Sub User"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "UI tidak mengklaim sukses tanpa konfirmasi; pemeriksaan backend menunjukkan pasangan template-user lengkap atau keduanya tidak ada; retry setelah rekonsiliasi tidak menggandakan data"

  @stress @priority-medium @REQ-016 @screen-tambah-hak-akses
  Scenario: PENGATURAN-AKUN-STR-014 — Payload Deskripsi 10000 karakter ditangani aman
    Given user berada di halaman "Tambah Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "Seluruh enam izin awal aktif dengan prasyarat valid; uji ulang shortcut turun untuk Lihat Saja dan Tidak Ada Akses"
    When user mengisi field "Deskripsi" dengan "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Diterima utuh atau ditolak dengan validasi eksplisit sesuai batas implementasi; tidak crash, tidak silent truncation, tidak simpan parsial"

  @stress @priority-high @REQ-045 @screen-edit-hak-akses
  Scenario: PENGATURAN-AKUN-STR-015 — 20 edit paralel memiliki audit sesuai commit
    Given user berada di halaman "Edit Hak Akses"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Nama template QA Baru unik; jenis FTL aktif; semua modul Akses Penuh, notifikasi valid, izin tambahan mati kecuali disebutkan"
    And prasyarat "20 sesi mengubah Deskripsi T1 ke nilai unik; snapshot awal dan waktu dicatat"
    When user mengisi field "Deskripsi" dengan "Catatan sesi ${sessionIndex}"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Setiap commit sukses tercatat pelaku/waktu/before/after; nilai akhir cocok commit terakhir; request gagal tidak dicatat sukses"

  @positive @priority-high @REQ-011 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-POS-119 — Mengaktifkan kembali Sub User melalui dropdown Status
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    And prasyarat "U1 sebelumnya Tidak Aktif"
    When user memilih opsi "Aktif" pada "Status"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Konfirmasi"
    And user membuka halaman "Login U1" dengan konteks "Login ulang U1 dengan kredensial valid"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Status Aktif tersimpan dan login berikutnya berhasil"

  @negative @priority-high @REQ-005 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-NEG-143 — Edit Sub User menolak pengosongan Nama Sub User
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Nama Sub User" dengan ""
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error mandatory; data terakhir tersimpan tidak berubah"

  @negative @priority-high @REQ-005 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-NEG-144 — Edit Sub User menolak pengosongan Email
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Email" dengan ""
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error mandatory; data terakhir tersimpan tidak berubah"

  @negative @priority-high @REQ-005 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-NEG-145 — Edit Sub User menolak pengosongan Nomor WhatsApp
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Nomor WhatsApp" dengan ""
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error mandatory; data terakhir tersimpan tidak berubah"

  @negative @priority-high @REQ-005 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-NEG-146 — Edit Sub User menolak pengosongan Bagian Staff
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user memilih opsi "" pada "Bagian Staff"
    And user mengklik elemen "Simpan"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Error mandatory; data terakhir tersimpan tidak berubah"

  @positive @priority-medium @REQ-007 @screen-tambah-sub-user
  Scenario: PENGATURAN-AKUN-POS-120 — Toggle kedua password pada form tambah independen
    Given user berada di halaman "Tambah Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengklik elemen "Tampilkan Password"
    Then sistem memverifikasi "Password" dengan hasil "type=text"
    And sistem memverifikasi "Konfirmasi Password" dengan hasil "type=password"
    When user mengklik elemen "Tampilkan Konfirmasi Password"
    Then sistem memverifikasi "Konfirmasi Password" dengan hasil "type=text"
    When user mengklik elemen "Sembunyikan Password"
    And user mengklik elemen "Sembunyikan Konfirmasi Password"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Kedua field kembali tersembunyi tanpa mengubah nilai"

  @edge @priority-medium @REQ-010 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-EDG-035 — Menolak konfirmasi Batal di form edit mempertahankan data lama
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Nama Sub User" dengan "Belum Disimpan"
    And user mengklik elemen "Batal"
    And user mengklik elemen "Kembali ke Form"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Form masih berisi Belum Disimpan; backend masih nama semula"

  @edge @priority-medium @REQ-010 @screen-edit-sub-user
  Scenario: PENGATURAN-AKUN-EDG-036 — Menolak konfirmasi Simpan di form edit mempertahankan data lama
    Given user berada di halaman "Edit Sub User"
    And prasyarat "Aktor telah login dengan kewenangan memadai; fixture terisolasi tersedia"
    And prasyarat "Form Sub User berisi nama Rina QA, email rina.qa@example.test, WhatsApp 081234567890, staff Operasional, password dan konfirmasi UjiAkun!2026; template QA Valid dipilih"
    When user mengisi field "Nama Sub User" dengan "Belum Disimpan"
    And user mengklik elemen "Simpan"
    And user mengklik elemen "Kembali ke Form"
    Then sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Form masih berisi Belum Disimpan; backend masih nama semula"

  @negative @priority-high @REQ-021 @screen-order
  Scenario: PENGATURAN-AKUN-NEG-147 — Backend Order Lihat Saja menolak seluruh mutasi
    Given user berada di halaman "Order"
    And prasyarat "Aktor Order Lihat Saja; prasyarat valid; fixture data editable tersedia; harness replay create/update/delete pada endpoint modul"
    Then sistem memverifikasi "Kontrol mutasi" dengan hasil "Tidak tersedia untuk aktor Lihat Saja"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Seluruh request create/update/delete ditolak; pembacaan tetap berhasil; tidak ada perubahan data"

  @negative @priority-high @REQ-021 @screen-penugasan-tracking
  Scenario: PENGATURAN-AKUN-NEG-148 — Backend Penugasan Tracking Lihat Saja menolak seluruh mutasi
    Given user berada di halaman "Penugasan Tracking"
    And prasyarat "Aktor Penugasan Tracking Lihat Saja; prasyarat valid; fixture data editable tersedia; harness replay create/update/delete pada endpoint modul"
    Then sistem memverifikasi "Kontrol mutasi" dengan hasil "Tidak tersedia untuk aktor Lihat Saja"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Seluruh request create/update/delete ditolak; pembacaan tetap berhasil; tidak ada perubahan data"

  @negative @priority-high @REQ-021 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-NEG-149 — Backend Manajemen Invoice Lihat Saja menolak seluruh mutasi
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Aktor Manajemen Invoice Lihat Saja; prasyarat valid; fixture data editable tersedia; harness replay create/update/delete pada endpoint modul"
    Then sistem memverifikasi "Kontrol mutasi" dengan hasil "Tidak tersedia untuk aktor Lihat Saja"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Seluruh request create/update/delete ditolak; pembacaan tetap berhasil; tidak ada perubahan data"

  @negative @priority-high @REQ-021 @screen-klaim-asuransi
  Scenario: PENGATURAN-AKUN-NEG-150 — Backend Klaim Asuransi Lihat Saja menolak seluruh mutasi
    Given user berada di halaman "Klaim Asuransi"
    And prasyarat "Aktor Klaim Asuransi Lihat Saja; prasyarat valid; fixture data editable tersedia; harness replay create/update/delete pada endpoint modul"
    Then sistem memverifikasi "Kontrol mutasi" dengan hasil "Tidak tersedia untuk aktor Lihat Saja"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Seluruh request create/update/delete ditolak; pembacaan tetap berhasil; tidak ada perubahan data"

  @negative @priority-high @REQ-021 @screen-tambah-biaya-hpp-shipment
  Scenario: PENGATURAN-AKUN-NEG-151 — Backend Tambah Biaya HPP Shipment Lihat Saja menolak seluruh mutasi
    Given user berada di halaman "Tambah Biaya HPP Shipment"
    And prasyarat "Aktor Tambah Biaya HPP Shipment Lihat Saja; prasyarat valid; fixture data editable tersedia; harness replay create/update/delete pada endpoint modul"
    Then sistem memverifikasi "Kontrol mutasi" dengan hasil "Tidak tersedia untuk aktor Lihat Saja"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Seluruh request create/update/delete ditolak; pembacaan tetap berhasil; tidak ada perubahan data"

  @negative @priority-high @REQ-021 @screen-master-wilayah
  Scenario: PENGATURAN-AKUN-NEG-152 — Backend Master Wilayah Lihat Saja menolak seluruh mutasi
    Given user berada di halaman "Master Wilayah"
    And prasyarat "Aktor Master Wilayah Lihat Saja; prasyarat valid; fixture data editable tersedia; harness replay create/update/delete pada endpoint modul"
    Then sistem memverifikasi "Kontrol mutasi" dengan hasil "Tidak tersedia untuk aktor Lihat Saja"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Seluruh request create/update/delete ditolak; pembacaan tetap berhasil; tidak ada perubahan data"

  @negative @priority-high @REQ-021 @screen-master-operasional
  Scenario: PENGATURAN-AKUN-NEG-153 — Backend Master Operasional Lihat Saja menolak seluruh mutasi
    Given user berada di halaman "Master Operasional"
    And prasyarat "Aktor Master Operasional Lihat Saja; prasyarat valid; fixture data editable tersedia; harness replay create/update/delete pada endpoint modul"
    Then sistem memverifikasi "Kontrol mutasi" dengan hasil "Tidak tersedia untuk aktor Lihat Saja"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Seluruh request create/update/delete ditolak; pembacaan tetap berhasil; tidak ada perubahan data"

  @negative @priority-high @REQ-021 @screen-master-data-tarif
  Scenario: PENGATURAN-AKUN-NEG-154 — Backend Master Data Tarif Lihat Saja menolak seluruh mutasi
    Given user berada di halaman "Master Data Tarif"
    And prasyarat "Aktor Master Data Tarif Lihat Saja; prasyarat valid; fixture data editable tersedia; harness replay create/update/delete pada endpoint modul"
    Then sistem memverifikasi "Kontrol mutasi" dengan hasil "Tidak tersedia untuk aktor Lihat Saja"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Seluruh request create/update/delete ditolak; pembacaan tetap berhasil; tidak ada perubahan data"

  @negative @priority-high @REQ-021 @screen-sub-user-hak-akses
  Scenario: PENGATURAN-AKUN-NEG-155 — Backend Sub User & Hak Akses Lihat Saja menolak seluruh mutasi
    Given user berada di halaman "Sub User & Hak Akses"
    And prasyarat "Aktor Sub User & Hak Akses Lihat Saja; prasyarat valid; fixture data editable tersedia; harness replay create/update/delete pada endpoint modul"
    Then sistem memverifikasi "Kontrol mutasi" dengan hasil "Tidak tersedia untuk aktor Lihat Saja"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Seluruh request create/update/delete ditolak; pembacaan tetap berhasil; tidak ada perubahan data"

  @negative @priority-high @REQ-021 @screen-pengaturan-notifikasi
  Scenario: PENGATURAN-AKUN-NEG-156 — Backend Pengaturan Notifikasi Lihat Saja menolak seluruh mutasi
    Given user berada di halaman "Pengaturan Notifikasi"
    And prasyarat "Aktor Pengaturan Notifikasi Lihat Saja; prasyarat valid; fixture data editable tersedia; harness replay create/update/delete pada endpoint modul"
    Then sistem memverifikasi "Kontrol mutasi" dengan hasil "Tidak tersedia untuk aktor Lihat Saja"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Seluruh request create/update/delete ditolak; pembacaan tetap berhasil; tidak ada perubahan data"

  @negative @priority-high @REQ-021 @screen-preferensi-notifikasi
  Scenario: PENGATURAN-AKUN-NEG-157 — Backend Preferensi Notifikasi Lihat Saja menolak seluruh mutasi
    Given user berada di halaman "Preferensi Notifikasi"
    And prasyarat "Aktor Preferensi Notifikasi Lihat Saja; prasyarat valid; fixture data editable tersedia; harness replay create/update/delete pada endpoint modul"
    Then sistem memverifikasi "Kontrol mutasi" dengan hasil "Tidak tersedia untuk aktor Lihat Saja"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "Seluruh request create/update/delete ditolak; pembacaan tetap berhasil; tidak ada perubahan data"

  @edge @priority-high @REQ-024 @screen-shipment
  Scenario: PENGATURAN-AKUN-EDG-037 — Pembatas jenis global berlaku pada Shipment
    Given user berada di halaman "Shipment"
    And prasyarat "Aktor Shipment Akses Penuh dengan hanya Airfreight; fixture A1 Airfreight dan F1 FTL dari pemilik berbeda"
    Then sistem memverifikasi "Data Shipment" dengan hasil "Periksa hasil daftar atau widget sesuai modul"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "A1 terlihat; F1 tidak ada; tidak perlu konfigurasi jenis per modul"

  @edge @priority-high @REQ-024 @screen-order
  Scenario: PENGATURAN-AKUN-EDG-038 — Pembatas jenis global berlaku pada Order
    Given user berada di halaman "Order"
    And prasyarat "Aktor Order Akses Penuh dengan hanya Airfreight; fixture A1 Airfreight dan F1 FTL dari pemilik berbeda"
    Then sistem memverifikasi "Data Order" dengan hasil "Periksa hasil daftar atau widget sesuai modul"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "A1 terlihat; F1 tidak ada; tidak perlu konfigurasi jenis per modul"

  @edge @priority-high @REQ-024 @screen-penugasan-tracking
  Scenario: PENGATURAN-AKUN-EDG-039 — Pembatas jenis global berlaku pada Penugasan Tracking
    Given user berada di halaman "Penugasan Tracking"
    And prasyarat "Aktor Penugasan Tracking Akses Penuh dengan hanya Airfreight; fixture A1 Airfreight dan F1 FTL dari pemilik berbeda"
    Then sistem memverifikasi "Data Penugasan Tracking" dengan hasil "Periksa hasil daftar atau widget sesuai modul"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "A1 terlihat; F1 tidak ada; tidak perlu konfigurasi jenis per modul"

  @edge @priority-high @REQ-024 @screen-dashboard-monitoring
  Scenario: PENGATURAN-AKUN-EDG-040 — Pembatas jenis global berlaku pada Dashboard Monitoring
    Given user berada di halaman "Dashboard Monitoring"
    And prasyarat "Aktor Dashboard Monitoring Akses Penuh dengan hanya Airfreight; fixture A1 Airfreight dan F1 FTL dari pemilik berbeda"
    Then sistem memverifikasi "Data Dashboard Monitoring" dengan hasil "Periksa hasil daftar atau widget sesuai modul"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "A1 terlihat; F1 tidak ada; tidak perlu konfigurasi jenis per modul"

  @edge @priority-high @REQ-024 @screen-dashboard-tracking-location
  Scenario: PENGATURAN-AKUN-EDG-041 — Pembatas jenis global berlaku pada Dashboard Tracking & Location
    Given user berada di halaman "Dashboard Tracking & Location"
    And prasyarat "Aktor Dashboard Tracking & Location Akses Penuh dengan hanya Airfreight; fixture A1 Airfreight dan F1 FTL dari pemilik berbeda"
    Then sistem memverifikasi "Data Dashboard Tracking & Location" dengan hasil "Periksa hasil daftar atau widget sesuai modul"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "A1 terlihat; F1 tidak ada; tidak perlu konfigurasi jenis per modul"

  @edge @priority-high @REQ-024 @screen-dashboard-operasional
  Scenario: PENGATURAN-AKUN-EDG-042 — Pembatas jenis global berlaku pada Dashboard Operasional
    Given user berada di halaman "Dashboard Operasional"
    And prasyarat "Aktor Dashboard Operasional Akses Penuh dengan hanya Airfreight; fixture A1 Airfreight dan F1 FTL dari pemilik berbeda"
    Then sistem memverifikasi "Data Dashboard Operasional" dengan hasil "Periksa hasil daftar atau widget sesuai modul"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "A1 terlihat; F1 tidak ada; tidak perlu konfigurasi jenis per modul"

  @edge @priority-high @REQ-024 @screen-manajemen-invoice
  Scenario: PENGATURAN-AKUN-EDG-043 — Pembatas jenis global berlaku pada Manajemen Invoice
    Given user berada di halaman "Manajemen Invoice"
    And prasyarat "Aktor Manajemen Invoice Akses Penuh dengan hanya Airfreight; fixture A1 Airfreight dan F1 FTL dari pemilik berbeda"
    Then sistem memverifikasi "Data Manajemen Invoice" dengan hasil "Periksa hasil daftar atau widget sesuai modul"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "A1 terlihat; F1 tidak ada; tidak perlu konfigurasi jenis per modul"

  @edge @priority-high @REQ-024 @screen-klaim-asuransi
  Scenario: PENGATURAN-AKUN-EDG-044 — Pembatas jenis global berlaku pada Klaim Asuransi
    Given user berada di halaman "Klaim Asuransi"
    And prasyarat "Aktor Klaim Asuransi Akses Penuh dengan hanya Airfreight; fixture A1 Airfreight dan F1 FTL dari pemilik berbeda"
    Then sistem memverifikasi "Data Klaim Asuransi" dengan hasil "Periksa hasil daftar atau widget sesuai modul"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "A1 terlihat; F1 tidak ada; tidak perlu konfigurasi jenis per modul"

  @edge @priority-high @REQ-024 @screen-tambah-biaya-hpp-shipment
  Scenario: PENGATURAN-AKUN-EDG-045 — Pembatas jenis global berlaku pada Tambah Biaya HPP Shipment
    Given user berada di halaman "Tambah Biaya HPP Shipment"
    And prasyarat "Aktor Tambah Biaya HPP Shipment Akses Penuh dengan hanya Airfreight; fixture A1 Airfreight dan F1 FTL dari pemilik berbeda"
    Then sistem memverifikasi "Data Tambah Biaya HPP Shipment" dengan hasil "Periksa hasil daftar atau widget sesuai modul"
    And sistem memverifikasi "Hasil pemeriksaan" dengan hasil "A1 terlihat; F1 tidak ada; tidak perlu konfigurasi jenis per modul"

