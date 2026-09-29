-- Phase 1: menjadikan peminjaman + detail_peminjaman + pengembalian
-- sebagai satu-satunya sumber data transaksi.
--
-- Aman dijalankan berulang kali. Tabel `borrowings` sengaja dipertahankan
-- sebagai arsip kompatibilitas sampai seluruh deployment tervalidasi.

USE perpustakaan_digital;

ALTER TABLE peminjaman
  ADD COLUMN IF NOT EXISTS legacy_borrowing_id INT NULL AFTER id_peminjaman;

CREATE UNIQUE INDEX IF NOT EXISTS uk_peminjaman_legacy
  ON peminjaman (legacy_borrowing_id);

CREATE INDEX IF NOT EXISTS idx_peminjaman_anggota_status
  ON peminjaman (id_anggota, status);

CREATE INDEX IF NOT EXISTS idx_peminjaman_tanggal
  ON peminjaman (tanggal_pinjam, tanggal_jatuh_tempo);

CREATE INDEX IF NOT EXISTS idx_detail_peminjaman_buku
  ON detail_peminjaman (id_buku);

-- Salin header transaksi lama tanpa mengubah atau menghapus sumber lama.
INSERT INTO peminjaman (
  id_peminjaman,
  legacy_borrowing_id,
  id_anggota,
  tanggal_pinjam,
  tanggal_jatuh_tempo,
  status,
  created_at
)
SELECT
  CONCAT('LEG-', br.id),
  br.id,
  br.user_id,
  br.borrow_date,
  br.due_date,
  CASE
    WHEN br.return_date IS NOT NULL THEN 'Dikembalikan'
    WHEN br.status = 'late' THEN 'Terlambat'
    ELSE 'Dipinjam'
  END,
  br.created_at
FROM borrowings br
WHERE NOT EXISTS (
  SELECT 1
  FROM peminjaman p
  WHERE p.legacy_borrowing_id = br.id
);

-- Model lama selalu memiliki satu buku per transaksi.
INSERT INTO detail_peminjaman (id_peminjaman, id_buku, jumlah)
SELECT CONCAT('LEG-', br.id), br.book_id, 1
FROM borrowings br
WHERE NOT EXISTS (
  SELECT 1
  FROM detail_peminjaman d
  WHERE d.id_peminjaman = CONCAT('LEG-', br.id)
    AND d.id_buku = br.book_id
);

-- Pertahankan riwayat pengembalian lama. Denda lama tidak tersimpan sehingga
-- dimigrasikan sebagai 0 dan dapat dikoreksi admin bila diperlukan.
INSERT INTO pengembalian (
  id_pengembalian,
  id_peminjaman,
  tanggal_kembali,
  denda,
  status,
  created_at
)
SELECT
  CONCAT('KMB-LEG-', br.id),
  CONCAT('LEG-', br.id),
  br.return_date,
  0,
  CASE WHEN br.status = 'late' THEN 'Terlambat' ELSE 'Dikembalikan' END,
  br.updated_at
FROM borrowings br
WHERE br.return_date IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM pengembalian k
    WHERE k.id_peminjaman = CONCAT('LEG-', br.id)
  );

