# Urutan Migration Database

Jalankan migration setelah `database/schema.sql` untuk database lama:

1. `001-unify-transactions.sql` — backfill `borrowings` ke transaksi utama tanpa menghapus tabel lama.
2. `002-copy-inventory.sql` — membuat inventory per-copy, assignment copy, dan riwayat status.
3. `003-overdue-fines.sql` — menormalisasi status menjadi `ACTIVE/OVERDUE/RETURNED` serta menyimpan hari dan nominal keterlambatan.
4. `004-reservations-notifications.sql` — menambah waiting list dan metadata notification center.
5. `005-reviews.sql` — menambah rating/review dengan constraint satu review per pengguna dan buku.
6. `006-fines-announcements.sql` — menambah pembayaran denda manual dan pengumuman.
7. `007-security-and-identity.sql` — menambah verifikasi identitas privat, hash token reset, dan arsip buku.

Contoh XAMPP/PowerShell:

```powershell
& 'C:\xampp\mysql\bin\mysql.exe' -u root --execute="SOURCE database/migrations/001-unify-transactions.sql"
```

Ulangi sesuai urutan file. Migration bersifat additive dan mempertahankan tabel `borrowings` sebagai arsip kompatibilitas. Backup database tetap disarankan sebelum deployment.

## Relationship utama

```text
users ──< peminjaman ──< detail_peminjaman >── books ──< book_copies
              │                    │                    │
              │                    └──< borrowing_copies >──┘
              └── pengembalian ──< fine_payments

users ──< reservations >── books
users ──< book_reviews >── books
users ──< notifications
book_copies ──< book_copy_history
```

Kolom `books.stock`, `books.stok`, dan `books.available` dipertahankan untuk kompatibilitas, tetapi disinkronkan dari `book_copies` setelah operasi inventory dan transaksi.
