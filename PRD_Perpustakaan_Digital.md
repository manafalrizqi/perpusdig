# PRODUCT REQUIREMENTS DOCUMENT

# Aplikasi Perpustakaan Digital

## Project Overview

Aplikasi Perpustakaan Digital merupakan sistem berbasis web untuk meningkatkan layanan perpustakaan kepada siswa dan anggota perpustakaan. Sistem menyediakan katalog buku, pencarian, peminjaman online, pembacaan e-book, riwayat peminjaman, serta dashboard admin untuk pengelolaan buku, anggota, transaksi, pengembalian, e-book, dan laporan.

Teknologi yang digunakan:

- Next.js
- Express.js
- Node.js
- TypeScript
- SQL Database
- Authentication
- CRUD
- Transaction System

## Target User

### Pemustaka / Siswa

- Mencari buku
- Melihat detail buku
- Meminjam buku
- Melihat status dan riwayat peminjaman
- Membaca e-book
- Menyimpan favorit
- Membuat bookmark
- Melihat notifikasi
- Mengelola profil

### Admin / Pustakawan

- Mengelola buku
- Mengelola kategori
- Mengelola anggota
- Mengelola peminjaman dan pengembalian
- Mengelola e-book
- Melihat riwayat peminjaman
- Melihat riwayat peminjaman dalam satu bulan
- Membuat, mencetak, dan mengekspor laporan
- Mengelola notifikasi dan pengaturan

## Product Goals

- Meningkatkan kualitas layanan perpustakaan.
- Mempermudah pencarian dan peminjaman buku.
- Menyediakan akses membaca e-book.
- Mengurangi pencatatan manual.
- Mempermudah pengelolaan data perpustakaan.
- Menyediakan informasi sirkulasi buku yang terorganisir.

## MVP Features

### Authentication

- Login
- Register
- Logout
- Forgot Password
- Reset Password
- Role siswa dan admin

### Katalog

- Daftar buku
- Pencarian
- Filter kategori, penulis, dan ketersediaan
- Sorting
- Detail buku
- Kategori
- Daftar penulis

### Peminjaman dan Pengembalian

- Peminjaman online
- Konfirmasi peminjaman
- Detail transaksi
- Status peminjaman
- Riwayat peminjaman
- Peminjaman terlambat
- Pengembalian buku

### E-Book

- E-Book Library
- Detail e-book
- E-Reader
- Reading progress
- Bookmark
- Pengaturan membaca
- Mode terang, sepia, dan gelap

### User

- Profil
- Edit profil
- Ubah password
- Favorit
- Bookmark
- Notifikasi
- Riwayat aktivitas

### Admin Dashboard

- Total buku
- Total anggota
- Buku tersedia
- Buku dipinjam
- Buku terlambat
- Total e-book
- Grafik peminjaman
- Grafik pengembalian
- Buku paling banyak dipinjam
- Anggota paling aktif
- Transaksi terbaru

### CRUD

Admin dapat melakukan Create, Read, Update, Delete pada:

- Buku
- Anggota
- Kategori
- E-book

### Monthly Borrowing History

Admin dapat melihat riwayat peminjaman dalam satu bulan, meliputi:

- Total peminjaman
- Total pengembalian
- Peminjaman aktif
- Peminjaman terlambat
- Statistik peminjaman harian
- Statistik pengembalian harian
- Buku paling banyak dipinjam
- Anggota paling aktif
- Detail transaksi
- Search
- Filter
- Print
- Export

## User Flow

### Student

Landing Page → Login → Beranda Siswa

Beranda Siswa → Katalog → Detail Buku → Pinjam Buku → Konfirmasi → Peminjaman Berhasil → Peminjaman

Beranda Siswa → Search → Search Results → Detail Buku

E-Book Library → E-Book Detail → E-Reader

Profil → Edit Profil → Simpan → Profil

Profil → Favorit / Bookmark / Notifikasi

### Admin

Login → Admin Dashboard

Admin Dashboard → Manajemen Buku → Tambah/Edit/Detail/Hapus Buku

Admin Dashboard → Manajemen Anggota → Tambah/Edit/Detail/Hapus Anggota

Admin Dashboard → Manajemen Peminjaman → Detail Peminjaman → Pengembalian

Admin Dashboard → Riwayat Peminjaman Bulanan → Filter/Search → Detail Transaksi → Laporan

Admin Dashboard → Laporan → Generate → Print/Export

## Screen List

### Public

- Landing Page
- Login
- Register
- Forgot Password
- Reset Password

### Student

- Beranda Siswa
- Katalog Buku
- Search Results
- Category Books
- Author Books
- Detail Buku
- Borrow Confirmation
- Borrow Success
- Peminjaman
- Detail Peminjaman
- Riwayat Peminjaman
- Peminjaman Terlambat
- E-Book Library
- E-Book Detail
- E-Reader
- Bookmark
- Favorit
- Profil Saya
- Edit Profil
- Ubah Password
- Notifikasi
- Riwayat Aktivitas
- Help / FAQ
- Library Rules

### Admin

- Admin Dashboard
- Manajemen Buku
- Tambah Buku
- Edit Buku
- Detail Buku Admin
- Manajemen Kategori
- Tambah Kategori
- Edit Kategori
- Manajemen Anggota
- Tambah Anggota
- Edit Anggota
- Detail Anggota
- Manajemen Peminjaman
- Detail Peminjaman
- Manajemen Pengembalian
- Konfirmasi Pengembalian
- E-Book Management
- Upload E-Book
- Riwayat Peminjaman Bulanan
- Laporan
- Laporan Buku
- Laporan Anggota
- Laporan Peminjaman
- Laporan Pengembalian
- Laporan Keterlambatan
- Admin Notifications
- Admin Profile
- Admin Settings
- Activity Log

### System

- 404
- 403
- 500
- Empty State
- Loading State
- Error State

## Screen Specification

### Landing Page

Menampilkan informasi perpustakaan dan akses menuju katalog atau autentikasi.

Komponen:

- Navbar
- Hero
- Search CTA
- Featured books
- Popular categories
- Recently added books
- Library statistics
- Benefits
- CTA
- Footer

### Katalog Buku

Menampilkan daftar buku yang dapat dicari dan difilter.

Komponen:

- Search
- Filter
- Sorting
- Book cards
- Grid/list
- Pagination

### Detail Buku

Menampilkan informasi lengkap buku dan aksi peminjaman.

Komponen:

- Cover
- Judul
- Penulis
- Penerbit
- ISBN
- Kategori
- Tahun terbit
- Deskripsi
- Ketersediaan
- Pinjam Buku
- Baca E-Book
- Favorit
- Buku terkait

### Peminjaman

Menampilkan buku yang sedang dipinjam, riwayat, dan keterlambatan.

### E-Reader

Menyediakan interface membaca e-book dengan:

- Judul
- Penulis
- Nomor halaman
- Progress
- Navigasi halaman
- Bookmark
- Daftar isi
- Reading settings

### Admin Dashboard

Menampilkan statistik dan aktivitas perpustakaan.

Komponen:

- Statistic cards
- Grafik peminjaman
- Grafik pengembalian
- Buku populer
- Anggota aktif
- Transaksi terbaru
- Sidebar

### Manajemen Buku

Menampilkan data buku dalam tabel dengan:

- Search
- Filter
- Tambah
- Detail
- Edit
- Delete
- Pagination

### Manajemen Anggota

Menampilkan data anggota dengan:

- Search
- Filter
- Tambah
- Detail
- Edit
- Delete

### Manajemen Peminjaman

Mengelola transaksi:

- Search
- Filter
- Status
- Detail transaksi
- Pengembalian

### Riwayat Peminjaman Bulanan

Admin memilih periode satu bulan dan melihat:

- Statistik
- Grafik peminjaman
- Grafik pengembalian
- Buku paling banyak dipinjam
- Anggota paling aktif
- Tabel transaksi
- Search
- Filter
- Print
- Export

## UI Guidelines

- Modern
- Clean
- Minimal
- Profesional
- Ramah untuk siswa
- Nyaman untuk membaca
- Tidak menggunakan dekorasi berlebihan
- Konsisten antar halaman

Komponen harus konsisten:

- Button
- Input
- Select
- Search
- Card
- Table
- Modal
- Badge
- Alert
- Pagination
- Tabs
- Dropdown
- Toast
- Empty state
- Loading state

Status:

- Tersedia
- Sedang Dipinjam
- Dikembalikan
- Terlambat
- Aktif
- Tidak Aktif

## Responsive Requirement

### Desktop

- Full navbar
- Admin sidebar
- Multi-column layout
- Data table
- Dashboard charts

### Tablet

- Compact navigation
- Adaptive grid
- Responsive table
- Responsive forms

### Mobile

- Hamburger menu
- Bottom navigation jika diperlukan
- Single-column layout
- Responsive cards
- Scrollable tables
- Touch-friendly controls
- Tidak ada horizontal overflow

## Functional Requirements

### Authentication

Sistem harus menyediakan login, register, logout, reset password, role siswa/admin, serta pembatasan akses berdasarkan role.

### CRUD

Admin harus dapat menambah, melihat, mengubah, dan menghapus data buku, anggota, kategori, dan e-book.

### Transaction

Sistem harus dapat membuat transaksi peminjaman, menyimpan transaksi, menampilkan status, mencatat pengembalian, menentukan keterlambatan, dan menampilkan riwayat.

## Non-Functional Requirements

### Performance

- Halaman responsif.
- Pencarian dan navigasi berjalan baik.
- Gunakan pagination untuk data besar.

### Security

- Password diproses secara aman.
- Akses admin dibatasi.
- Endpoint menggunakan autentikasi dan otorisasi.
- Data transaksi hanya dapat diubah pihak yang berwenang.

### Usability

- Navigasi konsisten.
- Informasi status jelas.
- Form memiliki validasi.
- Pesan error mudah dipahami.

### Compatibility

Aplikasi dapat digunakan pada desktop, laptop, tablet, dan smartphone.

## Data Requirements

### Users

- ID
- Nama
- Email
- Password
- Role
- Status
- Created date

### Books

- ID
- Judul
- Penulis
- Penerbit
- ISBN
- Kategori
- Tahun terbit
- Deskripsi
- Cover
- Stok
- Status
- E-book

### Categories

- ID
- Nama kategori
- Created date

### Borrowings

- ID transaksi
- User ID
- Book ID
- Tanggal pinjam
- Tanggal jatuh tempo
- Tanggal kembali
- Status

### E-Books

- ID
- Book ID
- File
- File size
- Status
- Upload date

### Notifications

- ID
- User ID
- Type
- Message
- Read status
- Created date

## Business Rules

- Pengguna harus login untuk fitur yang membutuhkan autentikasi.
- Pemustaka dapat melihat katalog.
- Pemustaka dapat melakukan peminjaman online.
- Setiap peminjaman memiliki transaksi.
- Setiap transaksi memiliki status.
- Pengembalian harus tercatat.
- Buku yang tidak tersedia tidak dapat dipinjam.
- Admin dapat mengelola data perpustakaan.
- Admin dapat melihat riwayat peminjaman.
- Admin dapat melihat riwayat peminjaman dalam satu bulan.
- Laporan dapat difilter berdasarkan periode.

## Acceptance Criteria

### Student

- Login berhasil.
- Katalog dapat diakses.
- Buku dapat dicari.
- Detail buku dapat dibuka.
- Buku dapat dipinjam.
- Peminjaman dapat dilihat.
- Riwayat dapat dilihat.
- E-book dapat dibaca.
- Favorit dapat dikelola.
- Bookmark dapat dikelola.
- Notifikasi dapat dilihat.
- Profil dapat dikelola.

### Admin

- Admin dapat login.
- Dashboard dapat diakses.
- CRUD buku berjalan.
- CRUD anggota berjalan.
- Kategori dapat dikelola.
- E-book dapat dikelola.
- Peminjaman dapat dikelola.
- Pengembalian dapat diproses.
- Riwayat peminjaman satu bulan dapat dilihat.
- Laporan dapat dibuat.
- Laporan dapat dicetak dan diekspor.
- Pengaturan dapat dikelola.

## Project Constraints

- Durasi proyek 3 bulan.
- Total anggaran Rp0.
- Perubahan kebutuhan dapat memengaruhi timeline.
- Revisi UI/UX dapat memengaruhi waktu pengembangan.
- Data katalog dan lisensi e-book bergantung pada pihak perpustakaan.

## Project Timeline

| Kegiatan | Durasi | Waktu |
|---|---|---|
| Project Charter dan pembagian tugas | 1 minggu | 21–28 Juli 2026 |
| Analisis kebutuhan, pengumpulan data, dan database | 2 minggu | 29 Juli–11 Agustus 2026 |
| Mockup, UI/UX, dan prototype | 2 minggu | 12–25 Agustus 2026 |
| Pengembangan aplikasi | 6 minggu | 26 Agustus–6 Oktober 2026 |
| Testing, bug fixing, dan optimasi | 2 minggu | 7–20 Oktober 2026 |
| Dokumentasi, pelatihan, presentasi, dan serah terima | 1 minggu | 21–28 Oktober 2026 |

## Deliverables

- Dokumen analisis kebutuhan
- UI/UX Design
- Mockup
- Prototype
- Website Perpustakaan Digital
- SQL Database
- Authentication
- CRUD
- Transaction System
- Dashboard Admin
- E-Reader
- Testing
- Dokumentasi
- Pelatihan
- Presentasi
- Serah terima proyek
