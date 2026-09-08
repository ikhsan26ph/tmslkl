# explore

Semua path relatif terhadap root repository. Baca `docs/agent-guide.md` terlebih dahulu.

Parameter: `$1` adalah nama modul; `$ARGUMENTS` adalah argumen pengguna untuk workflow ini. Adapter meneruskannya dari slash command atau instruksi biasa. Baca dokumen `docs/roles/<peran>.md` untuk setiap peran yang disebut.

Lakukan eksplorasi general aplikasi TMS. Gunakan peran **tms-explorer** (`docs/roles/tms-explorer.md`).

Langkah:
1. Baca `config/env.md`. Jika `baseUrl` / kredensial kosong → berhenti, minta user mengisi.
2. **Kalibrasi login** (jika key `login*` masih `ISI_SETELAH_EXPLORE`): buka `baseUrl + loginPath`, identifikasi selector asli field email, password, tombol login, lakukan login, catat URL tujuan sukses. Tulis nilainya ke tabel Aplikasi `config/env.md` (key `loginSuccessUrlPattern`, `loginEmailSelector`, `loginPasswordSelector`, `loginButtonSelector`; sintaks: `config/env.example.md`). Guard: login gagal 2x → berhenti, lapor.
3. Jalankan peran `tms-explorer` dengan instruksi:
   - Login ke aplikasi memakai kredensial di `config/env.md`.
   - Petakan SELURUH struktur navigasi: sidebar, menu, submenu, tab, sampai 2 level dalam.
   - Untuk setiap modul catat: nama menu, URL/route, deskripsi singkat isi halaman (list? form? dashboard?), tombol aksi utama, dan apakah aksesnya dibatasi role.
   - JANGAN melakukan aksi tulis apa pun (tidak submit form, tidak klik hapus). Read-only.
   - Ambil screenshot 1x per modul utama ke `artifacts/screenshots/explore/`.
   - Kumpulkan bukti read-only untuk checklist "Hipotesis dari OMS" di `CLAUDE.md` bila memungkinkan.
4. Simpan hasil ke `explore/module-map.md`:
   - tabel `| # | Modul | Route | Jenis Halaman | Aksi Utama | Ada Dokumen Skenario? | Catatan |`
     — kolom "Ada Dokumen Skenario?" diisi dengan mencocokkan nama modul ke folder yang ada di `scenario/`;
   - section "Info Login & Environment": selector login, URL sukses, user & role (tanpa password);
   - section "Temuan Janggal";
   - section "Cek Hipotesis OMS": bukti per item H1–H7 yang sempat dicek, untuk memperbarui tabel di `CLAUDE.md`.
5. Tampilkan ringkasan ke user: daftar modul yang ditemukan, mana yang sudah punya dokumen skenario (siap dites detail), mana yang belum (baru bisa smoke test), dan status hipotesis yang berubah.

Argumen opsional: $ARGUMENTS (jika user menyebut area tertentu, fokuskan eksplorasi ke sana).
