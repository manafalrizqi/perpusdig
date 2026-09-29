# Analisis Fitur Proyek Perpustakaan Digital

Tanggal analisis: 12 Agustus 2026  
Metode: pemeriksaan statis terhadap source code frontend, backend, skema database, seed data, route API, dan pemeriksaan build/lint.

## 1. Ringkasan Proyek

Proyek ini adalah aplikasi perpustakaan digital berbasis web untuk sekolah. Sistem membagi pengguna menjadi dua peran:

- **Siswa/anggota**, untuk mencari koleksi, meminjam buku, membaca e-book, melihat riwayat, dan mengelola profil.
- **Admin/pustakawan**, untuk mengelola koleksi, anggota, transaksi, laporan, dan pengaturan perpustakaan.

Arsitektur yang digunakan:

| Bagian | Teknologi |
|---|---|
| Frontend | Next.js 16, React 19, TypeScript, Tailwind CSS 4/CSS |
| Backend | Express 4, TypeScript, REST API |
| Database | MySQL |
| Autentikasi | JWT dan bcrypt |
| Validasi | Zod |
| Upload | Multer, maksimum 20 MB |

## 2. Status Implementasi Secara Umum

| Area | Status | Catatan |
|---|---|---|
| Halaman publik | Sudah ada | Landing page, katalog ringkas, pencarian, dan navigasi publik |
| Autentikasi | Sudah ada | Registrasi, login, JWT, pemulihan password, dan pembatasan role |
| Area siswa | Sebagian besar sudah ada | Katalog, peminjaman, e-book, riwayat, profil, favorit, bookmark, notifikasi |
| Area admin | Sebagian besar sudah ada | Dashboard dan CRUD data utama tersedia |
| API backend | Luas dan dapat dikompilasi | `npm run build` backend berhasil |
| Database | Sudah tersedia | Skema, relasi, data awal, dan pengaturan tersedia |
| Kualitas frontend | Perlu dirapikan | Lint menghasilkan 76 error dan 11 warning |
| Integrasi transaksi | Belum konsisten | Ada dua model transaksi yang digunakan bersamaan |

## 3. Fitur Publik

Fitur yang dapat diakses tanpa login:

- Landing page perpustakaan.
- Menampilkan delapan buku terbaru dari API.
- Form pencarian koleksi.
- Tautan eksplorasi berdasarkan topik/kategori populer.
- Bagian buku pilihan, manfaat aplikasi, dan profil singkat perpustakaan.
- Akses menuju katalog, e-book, login, dan registrasi.
- Detail buku dapat diambil dari API tanpa autentikasi.
- Endpoint pemeriksaan kesehatan API (`/api/health`).

Catatan: katalog dan e-book diarahkan ke area siswa sehingga pengguna akhirnya tetap diminta login.

## 4. Fitur Autentikasi dan Akun

### Sudah tersedia

- Registrasi akun siswa dengan nama, email, password, NIS, dan kelas.
- Pembuatan ID anggota otomatis dengan format `STD-xxxxxx`.
- Login menggunakan email dan password.
- Password disimpan dalam bentuk hash bcrypt.
- Token akses JWT dengan masa berlaku dari konfigurasi environment.
- Pemeriksaan status akun; akun nonaktif atau ditangguhkan ditolak.
- Otorisasi berdasarkan role `student` dan `admin`.
- Endpoint untuk mengambil data pengguna yang sedang login.
- Lupa password dan reset password menggunakan token yang berlaku selama satu jam.
- Perubahan password dari halaman profil siswa.
- Logout pada antarmuka dengan menghapus sesi dari `localStorage`.

### Catatan implementasi

- Opsi **Ingat saya** tampil pada halaman login, tetapi nilainya belum digunakan.
- Alur lupa password belum mengirim email sungguhan. Token dan link reset dikembalikan langsung oleh API lalu ditampilkan di browser.
- Frontend tidak memanggil endpoint logout, sehingga activity log `LOGOUT` tidak tercatat saat tombol keluar digunakan.
- Token disimpan di `localStorage`, bukan cookie `HttpOnly`.

## 5. Fitur Siswa/Anggota

### 5.1 Dashboard siswa

- Menampilkan sapaan dan area baca pribadi.
- Menampilkan jumlah koleksi yang dimuat.
- Menampilkan empat koleksi terbaru.
- Tombol cepat menuju katalog.
- Sidebar responsif dengan menu siswa.

### 5.2 Katalog dan pencarian buku

- Daftar buku dengan pagination 12 item per halaman.
- Pencarian berdasarkan judul atau nama penulis.
- API mendukung filter kategori, penulis, dan ketersediaan.
- Detail buku berisi judul, penulis, penerbit, deskripsi, ISBN, tahun, kategori, dan stok.
- Status ketersediaan menentukan apakah tombol peminjaman aktif.
- Buku yang terhubung ke e-book memiliki tombol baca digital.

Catatan: placeholder pencarian menyebut ISBN dan kategori, tetapi query backend saat ini hanya mencari judul dan nama penulis. Filter kategori, penulis, serta ketersediaan sudah ada di API, tetapi belum memiliki kontrol lengkap di UI siswa.

### 5.3 Peminjaman buku

- Alur peminjaman lima tahap:
  1. verifikasi buku;
  2. pemeriksaan stok;
  3. pemeriksaan data peminjam;
  4. pilihan durasi dan konfirmasi aturan;
  5. halaman transaksi berhasil.
- Durasi dapat dipilih dalam satuan jam atau hari.
- Batas durasi pada API adalah 1 sampai 720 unit.
- Satu transaksi API dapat memuat maksimal tiga jenis item buku.
- Sistem menggabungkan item buku yang sama dalam satu transaksi.
- Sistem mencegah peminjaman buku yang sedang dipinjam pengguna tersebut.
- Sistem memeriksa stok secara transaksional dengan database lock.
- Sistem membatasi jumlah peminjaman aktif berdasarkan pengaturan `max_borrow`.
- Stok dan status buku otomatis dikurangi ketika transaksi berhasil.
- ID transaksi dibuat otomatis dengan awalan `PJM`.
- Notifikasi dan activity log dibuat setelah peminjaman berhasil.
- Siswa dapat melihat daftar serta detail peminjaman.

Catatan: UI utama meminjam satu buku per transaksi walaupun API sudah mendukung beberapa item.

### 5.4 Pengembalian dan riwayat

- Siswa dapat membuka detail transaksi dan memproses pengembalian.
- Stok buku dikembalikan otomatis.
- ID pengembalian dibuat dengan awalan `KMB`.
- Denda dihitung dari jumlah hari keterlambatan dikalikan nilai `late_fine`.
- Notifikasi pengembalian dibuat otomatis.
- Tersedia pemisahan tampilan peminjaman aktif, riwayat, dan keterlambatan.

### 5.5 E-book

- Daftar koleksi e-book aktif.
- Detail e-book dapat diambil setelah login.
- Pembaca PDF menggunakan `iframe` dari file yang disimpan backend.
- Pesan kosong ditampilkan jika file belum tersedia.

### 5.6 Favorit, bookmark, dan progres membaca

Backend sudah menyediakan:

- melihat, menambah, dan menghapus buku favorit;
- melihat, menambah, dan menghapus bookmark halaman e-book;
- melihat dan memperbarui progres membaca per e-book.

UI siswa saat ini baru menyediakan daftar favorit dan daftar bookmark. Tombol tambah/hapus favorit, pembuatan bookmark dari reader, serta sinkronisasi progres membaca belum terhubung ke antarmuka.

### 5.7 Notifikasi

- Menampilkan daftar notifikasi milik pengguna.
- Notifikasi otomatis dibuat untuk peminjaman, pengembalian, dan keterlambatan pada beberapa alur backend.
- Database menyimpan status `is_read` dan link tujuan.

Belum ada endpoint/UI untuk menandai notifikasi sebagai sudah dibaca.

### 5.8 Profil

- Melihat nama, ID anggota, email, NIS, kelas, telepon, alamat, dan status akun.
- Mengubah nama, NIS, kelas, telepon, dan alamat.
- Mengubah password dengan verifikasi password lama.

## 6. Fitur Admin/Pustakawan

### 6.1 Dashboard

- Statistik total buku.
- Jumlah stok tersedia.
- Jumlah anggota.
- Jumlah buku sedang dipinjam.
- Jumlah keterlambatan.
- Jumlah e-book aktif.
- Delapan transaksi terbaru.

### 6.2 Manajemen buku

- Melihat daftar buku dengan pagination.
- Pencarian lokal pada data yang sedang dimuat.
- Menambah, mengubah, dan menghapus buku.
- Mengelola judul, penulis, penerbit, ISBN, kategori, tahun, stok, deskripsi, dan cover.
- Upload cover gambar.
- Penghapusan ditolak jika buku masih memiliki transaksi aktif pada model transaksi baru.
- Perubahan data dicatat pada activity log untuk beberapa operasi.

### 6.3 Manajemen kategori

- Melihat daftar kategori.
- Menambah, mengubah, dan menghapus kategori.
- Melihat detail kategori dan jumlah buku melalui API.

### 6.4 Manajemen anggota

- Melihat seluruh anggota siswa.
- Menambah anggota dan membuat password awal.
- Mengubah biodata, status akun, dan password.
- Menghapus anggota.
- Melihat detail anggota beserta riwayat peminjaman.
- Status yang tersedia: aktif, tidak aktif, dan ditangguhkan.

### 6.5 Manajemen e-book

- Melihat daftar e-book.
- Menambah, mengubah, dan menghapus e-book.
- Menghubungkan e-book dengan buku fisik.
- Mengatur metadata, jumlah halaman, tahun, dan status aktif/nonaktif.
- Upload cover serta file PDF/EPUB.

### 6.6 Peminjaman dan pengembalian

- Melihat daftar peminjaman.
- Memproses pengembalian pada model transaksi lama.
- Mengembalikan stok dan mengirim notifikasi kepada siswa.
- Mendata pengembalian pada model transaksi baru melalui API.

Area ini belum konsisten karena UI admin masih memakai endpoint transaksi lama, sedangkan UI siswa membuat transaksi melalui model baru. Rinciannya terdapat pada bagian temuan penting.

### 6.7 Laporan dan riwayat

- Laporan peminjaman bulanan beserta statistik.
- API laporan buku berdasarkan frekuensi peminjaman.
- API laporan anggota berdasarkan jumlah peminjaman.
- API laporan pengembalian.
- API riwayat bulanan untuk model transaksi baru, termasuk total denda.
- Pencatatan metadata laporan dengan jenis laporan tertentu.
- Ekspor data laporan dari frontend ke CSV.

Catatan: halaman **Riwayat Bulanan** dan **Laporan** saat ini sama-sama mengambil endpoint laporan bulanan model lama.

### 6.8 Pengaturan perpustakaan

- Melihat dan memperbarui pengaturan secara massal.
- Pengaturan awal mencakup nama perpustakaan, alamat, telepon, email, durasi pinjam, batas jumlah pinjaman, dan denda keterlambatan.
- Perubahan pengaturan dicatat di activity log.

### 6.9 Activity log dan notifikasi admin

- Menampilkan maksimal 200 activity log terbaru.
- Log mencakup login serta beberapa operasi create/update/delete.
- Admin memiliki halaman notifikasi yang menampilkan notifikasi untuk akun admin yang sedang login.

## 7. Fitur Backend dan Infrastruktur

- REST API dengan format respons sukses, error, dan pagination yang konsisten.
- Middleware autentikasi JWT.
- Middleware otorisasi role.
- Validasi body request menggunakan Zod.
- Error handler terpusat.
- CORS dengan origin dari environment.
- JSON request dibatasi sampai 2 MB.
- Upload file dibatasi sampai 20 MB.
- Jenis upload yang diterima: JPG, JPEG, PNG, GIF, WebP, PDF, dan EPUB.
- File upload disajikan secara statis melalui `/uploads`.
- Operasi peminjaman dan pengembalian penting menggunakan transaksi MySQL.
- Seed data berisi akun contoh, kategori, penulis, buku, e-book, transaksi, favorit, bookmark, progres membaca, notifikasi, dan activity log.
- Script reset kredensial dan penerapan pengaturan perpustakaan tersedia.

## 8. Struktur Data Utama

| Tabel | Fungsi |
|---|---|
| `users` | Akun admin dan siswa |
| `categories` | Kategori buku |
| `authors` | Data penulis |
| `books` | Koleksi buku fisik dan stok |
| `ebooks` | Koleksi digital dan lokasi file |
| `favorites` | Buku favorit pengguna |
| `bookmarks` | Bookmark halaman e-book |
| `reading_progress` | Posisi baca terakhir |
| `notifications` | Notifikasi pengguna |
| `activity_logs` | Audit aktivitas |
| `settings` | Konfigurasi perpustakaan |
| `borrowings` | Model transaksi lama, satu buku per transaksi |
| `peminjaman` | Header model transaksi baru |
| `detail_peminjaman` | Item buku dalam transaksi baru |
| `pengembalian` | Pengembalian dan denda model baru |
| `laporan` | Metadata laporan yang dibuat admin |

## 9. Temuan Penting dan Fitur yang Belum Utuh

### Prioritas tinggi

1. **Dua model transaksi belum disatukan.**
   - Siswa membuat dan membaca transaksi melalui `peminjaman`, `detail_peminjaman`, dan `pengembalian`.
   - Dashboard admin, daftar admin, detail anggota, proses kembali admin, dan beberapa laporan masih menggunakan `borrowings`.
   - Akibatnya, transaksi baru siswa dapat tidak terlihat pada dashboard atau halaman transaksi admin.

2. **Status keterlambatan model baru tidak diperbarui otomatis.**
   - Otomatisasi `markLateBorrowings` hanya bekerja pada tabel `borrowings`.
   - Tampilan siswa memfilter status `Terlambat` dari tabel `peminjaman`, tetapi tidak ada proses berkala yang mengubah transaksi baru menjadi `Terlambat`.

3. **Stok memiliki tiga kolom yang berpotensi berbeda.**
   - Tabel buku memakai `stock`, `stok`, dan `available`.
   - Model lama terutama memakai `available`; model baru memakai `stok` dan `available`.
   - Edit stok dari admin memperbarui `stock`, tetapi tidak selalu menyelaraskan `stok` dan `available`.

4. **Frontend belum lolos lint.**
   - Hasil pemeriksaan: 76 error dan 11 warning.
   - Masalah dominan adalah tipe `any`, aturan React effect, dependency hook, penggunaan elemen gambar biasa, dan beberapa aturan TypeScript/ESLint.

### Prioritas menengah

- Favorit, bookmark, dan reading progress sudah ada di API, tetapi belum terhubung penuh di UI.
- Notifikasi belum dapat ditandai sebagai telah dibaca.
- Pemulihan password belum mengirim email.
- Filter lanjutan katalog tersedia di API tetapi belum lengkap di UI.
- Pencarian tidak mencakup ISBN dan kategori seperti yang dijanjikan placeholder.
- Tampilan tanggal pada tahap peminjaman selalu menghitung tujuh hari, walaupun pengguna dapat memilih durasi lain.
- Link kategori pada landing page menggunakan pencarian teks, bukan filter `category`.
- Fungsi peminjaman langsung di halaman siswa mengirim body tanpa `durasi` dan `satuan`; jika dipanggil, request akan gagal validasi. Alur lima tahap yang dipakai pengguna mengirim data lengkap.
- Pembuatan laporan (`POST /api/laporan`) tersedia di API, tetapi belum ada form frontend untuk memilih dan membuat jenis laporan.
- Endpoint progres membaca dan beberapa endpoint laporan tersedia, tetapi belum digunakan oleh halaman frontend.

## 10. Verifikasi Teknis

| Pemeriksaan | Hasil |
|---|---|
| Build TypeScript backend (`npm run build`) | Berhasil |
| Lint frontend (`npm run lint`) | Gagal: 76 error, 11 warning |
| Test otomatis | Tidak ditemukan script atau folder test |
| Git repository | Metadata `.git` tidak tersedia dari root proyek saat pemeriksaan |

Analisis ini menunjukkan fitur berdasarkan implementasi source code, bukan hasil uji end-to-end dengan server dan database aktif. Karena itu, status **sudah ada** berarti route, UI, atau skema pendukung telah diimplementasikan; status tersebut tidak selalu berarti seluruh alurnya telah diuji pada runtime.

## 11. File Utama yang Dianalisis

- `frontend/src/app/page.tsx`
- `frontend/src/app/login/page.tsx`
- `frontend/src/app/register/page.tsx`
- `frontend/src/app/forgot-password/page.tsx`
- `frontend/src/app/reset-password/page.tsx`
- `frontend/src/app/student/[[...slug]]/page.tsx`
- `frontend/src/app/student/books/[id]/borrow/[[...step]]/page.tsx`
- `frontend/src/app/admin/[[...slug]]/page.tsx`
- `frontend/src/lib/api.ts`
- `backend/src/index.ts`
- `backend/src/middleware/auth.ts`
- `backend/src/middleware/validate.ts`
- `database/schema.sql`
- `database/transaction-relations.sql`
- `database/seeds/seed.sql`

