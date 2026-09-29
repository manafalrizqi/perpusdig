# Laporan Update Perpustakaan Digital Sekolah

Tanggal verifikasi: 12 Agustus 2026

## Ringkasan

Project existing telah di-upgrade tanpa mengganti stack, database, autentikasi JWT, atau arsitektur REST API. CRUD existing dipertahankan. Transaksi sekarang memakai `peminjaman`, `detail_peminjaman`, dan `pengembalian` sebagai satu source of truth; tabel `borrowings` lama tetap disimpan untuk backward compatibility dan tidak dihapus.

## Implementasi Utama

### Transaksi, inventory, overdue, dan denda

- Seluruh dashboard, daftar transaksi, detail anggota, pengembalian, laporan, statistik, notifikasi, dan activity log membaca transaksi canonical yang sama.
- Peminjaman mengalokasikan copy fisik yang tersedia secara atomik.
- Pengembalian memulihkan status copy dan agregat stok buku.
- Setiap copy memiliki `copy_code`, status, lokasi, QR, hubungan transaksi, dan riwayat perubahan.
- Status buku dihitung dari kondisi seluruh copy: `AVAILABLE`, `LIMITED`, `OUT_OF_STOCK`, `PARTIALLY_LOST`, atau `LOST`.
- Proses server berkala mengubah `ACTIVE` menjadi `OVERDUE`, menghitung `late_days` serta `fine_amount`, lalu membuat notifikasi dan activity log.
- Pembayaran denda manual mendukung `UNPAID`, `PAID`, dan `WAIVED` beserta riwayat pembayarannya.

### Reservasi, notifikasi, dan review

- Waiting list reservasi mendukung `WAITING`, `NOTIFIED`, `FULFILLED`, `CANCELLED`, dan `EXPIRED`.
- Ketika copy tersedia, antrean teratas otomatis diberi masa klaim dan notifikasi.
- Notification center menyimpan read/unread di database, menyediakan unread badge, detail/link, mark read, dan mark all read.
- Siswa yang pernah meminjam dapat membuat satu review per buku, mengedit, menghapus, dan melihat review.
- Admin dapat menampilkan atau menyembunyikan review; agregasi rating dan distribusi berasal dari database.

### Katalog, e-book, favorite, dan bookmark

- Search bekerja untuk judul, penulis, ISBN, kategori, dan penerbit.
- Filter API/UI mencakup kategori, penerbit, tahun, availability, e-book, dan rating; sorting mencakup terbaru, populer, rating, dan judul.
- Autocomplete, recent search, clear filter, dan pagination terhubung ke API.
- E-book reader memuat serta menyimpan halaman terakhir, progress, bookmark halaman, navigasi, zoom, dan fullscreen.
- Favorite dan bookmark memiliki aksi tambah, hapus, serta daftar tersimpan.

### Dashboard, analytics, laporan, dan pengumuman

- Dashboard siswa menampilkan statistik nyata, overdue alert, upcoming due date, continue reading, recently borrowed, popular books, rekomendasi rule-based, serta pengumuman.
- Dashboard admin menampilkan statistik copy/transaksi/anggota/denda dan chart berdasarkan query database.
- Riwayat bulanan memiliki ringkasan, chart harian, buku terpopuler, dan anggota teraktif.
- Laporan buku, anggota, peminjaman, pengembalian, keterlambatan, denda, inventory, hilang, rusak, dan reservasi dapat difilter dan diekspor ke CSV.
- Admin dapat membuat serta mengarsipkan pengumuman; pengumuman published membuat notifikasi siswa.
- Activity log mencatat autentikasi, CRUD utama, transaksi, inventory, reservasi, moderasi review, pembayaran denda, dan perubahan settings.

### QR dan UX

- QR dibuat per copy dan dapat dilihat atau dicetak.
- Scanner memakai kamera melalui native `BarcodeDetector` jika browser mendukung, dengan fallback pencarian Copy ID/scanner USB.
- Area admin dan siswa memakai layout responsive, drawer mobile, card/table adaptif, modal, badge, toast/message, empty/error/loading states, dan notification dropdown.
- Landing page, statistik, koleksi pilihan, dashboard, serta chart menggunakan respons API, bukan dummy metrics.

## Database dan Urutan Migrasi

Jalankan migrasi sesuai urutan berikut:

1. `001-unify-transactions.sql`
2. `002-copy-inventory.sql`
3. `003-overdue-fines.sql`
4. `004-reservations-notifications.sql`
5. `005-reviews.sql`
6. `006-fines-announcements.sql`

Detail tabel, foreign key, index, dan strategi kompatibilitas tersedia di `database/MIGRATIONS.md`. Seluruh migration bersifat additive; tabel transaksi legacy belum dihapus.

## Verifikasi

| Pemeriksaan | Hasil |
|---|---|
| Backend TypeScript build | Lulus |
| Frontend ESLint | Lulus tanpa error |
| Frontend TypeScript | Lulus |
| Next.js production build | Lulus |
| Integration test utama | 1 suite lulus, 0 gagal |

Integration test mencakup registrasi/login, CRUD kategori dan buku, pencarian, borrow, visibilitas transaksi di admin, assignment copy, overdue/denda, return, pemulihan stok, lost/found, reservasi, notification, dan dashboard.

## Catatan Operasional

- Scheduler overdue berjalan di proses Express setiap 15 menit. Untuk deployment multi-instance atau kebutuhan SLA ketat, endpoint admin pemrosesan overdue dapat dipanggil oleh cron platform agar hanya satu worker yang bertugas.
- Reset password tetap memakai mekanisme existing. Email delivery tidak dibuat secara palsu karena infrastructure email belum tersedia.
- Export Excel/PDF dan payment gateway tidak ditambahkan karena ecosystem existing belum menyediakannya; CSV dan konfirmasi pembayaran manual tersedia.
- Dukungan scan kamera bergantung pada implementasi `BarcodeDetector` browser. Scanner USB tetap dapat memasukkan Copy ID melalui pencarian inventory.

