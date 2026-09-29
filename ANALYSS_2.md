# Analisis dan Plan Pengembangan Web Perpustakaan Digital

Tanggal analisis: 26 Agustus 2026  
Metode: pemeriksaan statis source code frontend, backend, database, konfigurasi, dokumentasi, serta verifikasi lint, type-check, dan production build.

## 1. Ringkasan

Web Perpustakaan Digital sudah memiliki fondasi dan cakupan fitur yang kuat untuk demo atau tugas akhir. Fitur utama siswa dan admin telah tersedia, transaksi penting menggunakan database transaction, dan source code berhasil melewati pemeriksaan build.

Namun, aplikasi belum disarankan untuk langsung dibuka ke internet. Kekurangan utama berada pada keamanan autentikasi, perlindungan file upload dan e-book, keamanan penghapusan data, cakupan pengujian, skalabilitas beberapa endpoint, serta maintainability source code.

Kesimpulan singkat:

- **Layak untuk demo/local:** ya.
- **Fitur utama sudah lengkap:** ya.
- **Siap production publik:** belum.
- **Prioritas berikutnya:** security, data safety, reliability, lalu UX dan refactor.

## 2. Bagian yang Sudah Baik

- Fitur siswa mencakup katalog, pencarian, peminjaman, pengembalian, reservasi, notifikasi, favorit, bookmark, progres membaca, review, profil, dan e-book.
- Fitur admin mencakup dashboard, buku, kategori, anggota, inventory per-copy, transaksi, denda, reservasi, review, pengumuman, laporan, pengaturan, dan activity log.
- Transaksi peminjaman dan pengembalian penting menggunakan MySQL transaction dan row locking.
- Autentikasi menggunakan JWT dan bcrypt.
- Pembatasan akses berdasarkan role `student` dan `admin` tersedia di backend.
- Validasi request menggunakan Zod.
- Database mempunyai foreign key, unique constraint, migration, dan seed data.
- Inventory per-copy, QR, overdue, denda, reservasi, serta notifikasi sudah saling terhubung.

## 3. Hasil Verifikasi Teknis

| Pemeriksaan | Hasil |
|---|---|
| Backend TypeScript build | Lulus |
| Frontend TypeScript check | Lulus |
| Frontend production build | Lulus |
| Frontend ESLint | Lulus, 0 error dan 2 warning gambar |
| Integration test runtime | Tidak dijalankan karena test memodifikasi database aktif |
| Frontend/E2E test | Belum tersedia |

Integration test backend sudah tersedia, tetapi menggunakan database berdasarkan environment aktif. Audit ini tidak menjalankannya agar tidak membuat atau menghapus data pada database yang mungkin sedang dipakai.

## 4. Temuan dan Kekurangan

### 4.1 Keamanan autentikasi — kritis

1. Konfigurasi JWT mempunyai fallback secret `default-secret-change-me`. Jika environment production gagal terbaca, server tetap berjalan menggunakan secret yang mudah ditebak.
2. Belum ada rate limiting pada login, registrasi, dan lupa password.
3. Minimal password hanya enam karakter.
4. Token autentikasi disimpan di `localStorage` atau `sessionStorage`. Token dapat diambil apabila aplikasi terkena XSS.
5. Endpoint lupa password mengembalikan token reset langsung dalam respons API dan menampilkannya di browser.
6. Token reset disimpan langsung di database, belum dalam bentuk hash.

### 4.2 Upload dan akses e-book — kritis

1. Upload umum terutama memeriksa ekstensi nama file, belum memastikan isi file sesuai dengan jenis yang diizinkan.
2. Seluruh folder `uploads` disajikan sebagai file statis publik.
3. File PDF/e-book yang URL-nya diketahui dapat diakses tanpa melewati pemeriksaan autentikasi endpoint e-book.
4. Belum terlihat proses konsisten untuk menghapus file lama ketika cover, avatar, atau e-book diganti.
5. Upload perlu mencegah file berbahaya, nama file bermasalah, dan file yatim yang tidak lagi dipakai database.

### 4.3 Registrasi dengan foto identitas

Form registrasi perlu meminta **satu foto identitas**, bukan dua dokumen sekaligus. Pengguna dapat memilih:

- Kartu pelajar, sebagai pilihan utama untuk siswa.
- KTP, jika kartu pelajar tidak tersedia.

Requirement minimum:

1. Tambahkan pilihan `Jenis identitas`: `Kartu Pelajar` atau `KTP`.
2. Tambahkan field wajib `Foto identitas` dengan dukungan JPG, PNG, atau WebP maksimal 5 MB.
3. Tampilkan preview, nama file, ukuran file, serta tombol ganti/hapus sebelum form dikirim.
4. Tolak file kosong, rusak, terlalu besar, atau bukan gambar pada frontend dan backend.
5. Jangan meminta nomor KTP/NIK atau menjalankan OCR jika belum benar-benar dibutuhkan.
6. Simpan foto identitas sebagai file privat; file tidak boleh tersedia melalui folder `/uploads` publik.
7. Admin dapat melihat dokumen hanya dari halaman verifikasi anggota yang terautentikasi.
8. Akun baru mempunyai status verifikasi `PENDING`, `APPROVED`, atau `REJECTED`.
9. Admin dapat menyetujui atau menolak dokumen dengan alasan yang ditampilkan kepada siswa.
10. Siswa yang ditolak dapat mengunggah ulang dokumen tanpa membuat akun baru.
11. Catat admin pemeriksa dan waktu verifikasi pada activity log.
12. Hapus atau anonimisasi dokumen sesuai kebijakan retensi setelah tidak lagi diperlukan.

Data minimum yang disarankan:

| Field | Fungsi |
|---|---|
| `identity_type` | `STUDENT_CARD` atau `KTP` |
| `identity_file` | Lokasi file privat |
| `identity_status` | `PENDING`, `APPROVED`, atau `REJECTED` |
| `identity_rejection_reason` | Alasan penolakan |
| `identity_verified_by` | Admin yang memeriksa |
| `identity_verified_at` | Waktu pemeriksaan |

Alur yang disarankan:

1. Siswa mengisi biodata, password, foto profil opsional, dan satu foto identitas wajib.
2. Backend membuat akun dengan status verifikasi `PENDING`.
3. Jika upload identitas gagal, akun tetap pending dan siswa dapat mencoba upload ulang.
4. Admin memeriksa dokumen dari antrean verifikasi anggota.
5. Setelah disetujui, akun menjadi aktif dan siswa menerima notifikasi.
6. Jika ditolak, siswa menerima alasan dan tombol untuk mengunggah ulang dokumen.

Karena KTP mengandung data pribadi sensitif, akses file harus dibatasi, dicatat, dan tidak boleh menggunakan URL publik yang dapat ditebak.

### 4.4 Keamanan dan konsistensi data

1. Admin dapat melakukan hard delete anggota. Riwayat anggota dan transaksi seharusnya dipertahankan untuk kebutuhan laporan dan audit.
2. Penghapusan data yang masih mempunyai relasi dapat gagal karena constraint database tanpa pesan bisnis yang cukup jelas.
3. Buku dan anggota lebih aman diarsipkan atau dinonaktifkan daripada dihapus permanen.
4. Belum tersedia prosedur backup dan restore yang terdokumentasi serta teruji.

### 4.5 Pengujian belum mencukupi

Integration test yang tersedia sudah memeriksa alur utama, tetapi masih terdapat gap:

- Test memakai konfigurasi database aktif dan belum mempunyai guard database khusus test.
- Belum ada test frontend.
- Belum ada end-to-end test browser.
- Belum ada test brute-force/rate limit autentikasi.
- Belum ada test file upload berbahaya.
- Belum ada test lengkap untuk izin setiap role.
- Belum ada test race condition peminjaman dan reservasi secara paralel.
- Belum ada test kegagalan transaksi dan rollback.

### 4.6 Struktur kode dan maintainability

Beberapa file menampung terlalu banyak tanggung jawab:

| File | Ukuran perkiraan |
|---|---:|
| `backend/src/index.ts` | 80 KB |
| `frontend/src/app/admin/[[...slug]]/page.tsx` | 45 KB |
| `frontend/src/app/student/[[...slug]]/page.tsx` | 29 KB |
| `frontend/src/app/globals.css` | 34 KB |

Dampaknya:

- Perubahan kecil berisiko memengaruhi fitur lain.
- Review dan debugging menjadi lebih sulit.
- Banyak tipe `any` mengurangi perlindungan TypeScript.
- Pengujian unit per domain sulit dilakukan.

Refactor sebaiknya dilakukan berdasarkan domain nyata seperti auth, books, members, borrowings, inventory, notifications, dan reports. Hindari abstraction atau dependency baru yang belum benar-benar dibutuhkan.

### 4.7 Skalabilitas endpoint

Beberapa endpoint mengambil seluruh data tanpa pagination, terutama anggota, inventory, notifikasi, dan sebagian riwayat. Hal ini masih aman untuk data kecil, tetapi dapat memperlambat API dan browser ketika data sudah mencapai ribuan baris.

Yang perlu dilakukan:

- Pagination server-side.
- Search dan filter server-side.
- Batas maksimum `limit` dari query pengguna.
- Index database untuk kolom pencarian dan filter yang sering dipakai.
- Pemeriksaan query lambat setelah data realistis tersedia.

### 4.8 UX dan aksesibilitas

1. Modal belum mempunyai `role="dialog"`, `aria-modal`, focus trap, dan dukungan tombol Escape.
2. Tombol menu berbentuk ikon belum mempunyai label aksesibilitas.
3. Bahasa status bercampur antara Indonesia dan Inggris, misalnya `ACTIVE`, `OVERDUE`, dan `AVAILABLE`.
4. Cover buku belum digunakan secara konsisten pada seluruh daftar dan detail.
5. Dua gambar masih memakai elemen `<img>` biasa dan menghasilkan warning optimasi Next.js.
6. API client belum mempunyai penanganan global ketika token kedaluwarsa atau menerima status `401`.
7. Loading, empty state, dan error state sudah tersedia, tetapi perlu diuji melalui keyboard dan perangkat mobile nyata.

### 4.9 Operasional dan dokumentasi

1. README frontend masih berupa README bawaan Next.js.
2. Belum ada README root yang menjelaskan instalasi seluruh sistem.
3. Belum tersedia panduan deployment backend, frontend, dan MySQL.
4. Belum tersedia panduan HTTPS, reverse proxy, backup, dan restore.
5. Health check hanya memastikan proses API hidup, belum memastikan database dapat diakses.
6. Belum terlihat pipeline CI untuk lint, type-check, build, dan test.
7. Scheduler overdue berjalan di dalam proses Express. Pada deployment multi-instance, beberapa worker dapat menjalankan pekerjaan yang sama.

## 5. Plan Implementasi

### Fase 1 — Security dan data safety

Tujuan: menutup risiko yang dapat membocorkan akun, file, atau data.

- [x] Hapus fallback JWT secret dan hentikan startup jika `JWT_SECRET` tidak valid.
- [x] Tambahkan rate limiting untuk login, register, forgot password, dan reset password.
- [x] Naikkan aturan password dan samakan validasinya di frontend serta backend.
- [x] Jangan kembalikan token reset melalui API pada production.
- [ ] Kirim link reset melalui email ketika SMTP tersedia.
- [x] Simpan hash token reset, bukan token mentah.
- [x] Tambahkan pilihan Kartu Pelajar atau KTP dan upload satu foto identitas wajib pada registrasi.
- [x] Simpan foto identitas di storage privat dan layani hanya melalui endpoint admin terautentikasi.
- [x] Tambahkan status verifikasi identitas `PENDING`, `APPROVED`, dan `REJECTED`.
- [x] Tambahkan antrean pemeriksaan identitas, alasan penolakan, dan upload ulang.
- [x] Catat aktivitas verifikasi.
- [ ] Tentukan dan terapkan kebijakan retensi dokumen identitas.
- [ ] Terapkan penghapusan/anonimisasi dokumen sesuai kebijakan retensi.
- [x] Validasi upload berdasarkan ekstensi, MIME, dan isi file.
- [x] Pisahkan avatar/cover publik dari e-book privat.
- [x] Sajikan file e-book melalui endpoint yang memeriksa autentikasi dan izin.
- [x] Bersihkan file lama atau file yatim ketika data diubah/dihapus.
- [x] Ubah hard delete anggota dan buku menjadi archive/nonaktif.
- [ ] Buat backup database dan lakukan simulasi restore.

Kriteria selesai:

- Server production tidak dapat hidup tanpa secret yang aman.
- Percobaan login berulang dibatasi.
- Token reset tidak muncul dalam response production.
- Foto identitas tidak dapat dibuka menggunakan URL publik.
- Akun belum aktif sebelum identitas disetujui admin.
- Siswa dapat memperbaiki dokumen yang ditolak tanpa mendaftar ulang.
- E-book tidak dapat dibuka tanpa autentikasi.
- Penghapusan anggota tidak menghilangkan riwayat transaksi.

### Fase 2 — Reliability dan test

Tujuan: memastikan fitur utama tidak mudah rusak dan test tidak menyentuh data asli.

- [x] Buat database khusus test.
- [x] Tambahkan guard agar test menolak nama database yang tidak berakhiran `_test`.
- [x] Tambahkan test izin siswa, admin, dan request tanpa token.
- [ ] Tambahkan test pengguna nonaktif.
- [ ] Tambahkan test rollback ketika stok atau proses transaksi gagal.
- [ ] Tambahkan test peminjaman dan reservasi paralel.
- [x] Tambahkan test upload tidak valid.
- [ ] Tambahkan test upload identitas, akses file privat, approval, rejection, dan upload ulang.
- [x] Pastikan siswa tidak dapat melihat dokumen identitas pengguna lain.
- [ ] Tambahkan E2E smoke test untuk login, pinjam, kembali, CRUD buku, dan reservasi.
- [x] Tambahkan readiness check yang menjalankan query ringan ke MySQL.
- [ ] Pindahkan scheduler overdue ke satu cron/worker ketika deployment memakai lebih dari satu instance.

Kriteria selesai:

- Test tidak dapat dijalankan pada database production/development.
- Alur utama siswa dan admin dapat diuji otomatis.
- Kegagalan transaksi tidak meninggalkan stok atau status yang tidak konsisten.
- Readiness check gagal apabila MySQL tidak tersedia.

### Fase 3 — Skalabilitas dan maintainability

Tujuan: menjaga performa dan membuat perubahan berikutnya lebih aman.

- [x] Tambahkan pagination untuk anggota, inventory, notifikasi, dan transaksi besar.
- [ ] Pindahkan search/filter endpoint tersebut ke server-side.
- [ ] Batasi nilai `limit` maksimum.
- [ ] Periksa dan tambahkan index database berdasarkan query nyata.
- [ ] Pecah backend menjadi router per domain tanpa mengubah kontrak API.
- [ ] Pecah halaman admin dan siswa menjadi komponen per fitur.
- [ ] Buat tipe response utama dan kurangi penggunaan `any` secara bertahap.
- [x] Tambahkan handler global `401` untuk membersihkan sesi dan kembali ke login.
- [ ] Pertahankan helper yang sudah ada dan hindari dependency baru yang tidak diperlukan.

Kriteria selesai:

- Endpoint daftar tidak mengirim seluruh database dalam satu respons.
- File utama tidak lagi menjadi pusat seluruh fitur.
- Perubahan satu domain dapat diuji tanpa memengaruhi domain lain.

### Fase 4 — UX, aksesibilitas, dan dokumentasi

Tujuan: meningkatkan kualitas penggunaan dan mempermudah instalasi/deployment.

- [x] Tambahkan semantics, focus management, Escape, dan focus trap pada modal.
- [x] Tambahkan label aksesibilitas untuk tombol ikon dan menu.
- [ ] Gunakan label status Indonesia secara konsisten.
- [ ] Tampilkan cover buku secara konsisten.
- [ ] Tambahkan preview, progress upload, status verifikasi, dan alasan penolakan identitas pada UI registrasi/profil.
- [ ] Tambahkan halaman antrean verifikasi identitas yang jelas untuk admin.
- [x] Selesaikan dua warning gambar Next.js.
- [ ] Uji tampilan mobile, keyboard navigation, dan screen reader dasar.
- [x] Buat README root untuk instalasi frontend, backend, database, migration, dan seed.
- [x] Dokumentasikan seluruh environment variable wajib.
- [ ] Dokumentasikan deployment HTTPS, backup, restore, dan troubleshooting.
- [x] Tambahkan CI: lint, type-check, build, dan unit test.
- [ ] Lakukan user acceptance test dengan admin perpustakaan dan beberapa siswa.

Kriteria selesai:

- Alur utama dapat digunakan dengan keyboard.
- Instalasi baru dapat dilakukan hanya dengan mengikuti README.
- Setiap perubahan diperiksa otomatis oleh CI.

## 6. Urutan Prioritas

| Prioritas | Pekerjaan |
|---|---|
| P0 | JWT, rate limit, reset password, identitas privat, verifikasi anggota, e-book privat, backup |
| P1 | Soft delete/archive, database test, authorization test, rollback dan race-condition test |
| P2 | Pagination, readiness check, scheduler production, handler `401` |
| P3 | Pemecahan mega-file, type safety, aksesibilitas, cover dan optimasi gambar |
| P4 | README, CI, deployment guide, UAT |

## 7. Rekomendasi Akhir

Jangan menambah fitur besar baru terlebih dahulu. Cakupan fitur saat ini sudah lebih dari cukup. Fokus terbaik adalah membuat fitur yang ada aman, stabil, dapat diuji, dan mudah dirawat.

Urutan pengerjaan yang direkomendasikan:

1. Security.
2. Data safety dan backup.
3. Test dan reliability.
4. Pagination dan operasional production.
5. UX dan aksesibilitas.
6. Refactor bertahap serta dokumentasi.
