-- Phase 3-4: status transaksi konsisten dan kalkulasi keterlambatan tersimpan.
-- Jalankan setelah 002-copy-inventory.sql.

USE perpustakaan_digital;

ALTER TABLE peminjaman MODIFY status VARCHAR(20) NOT NULL;
UPDATE peminjaman SET status=CASE status
  WHEN 'Dipinjam' THEN 'ACTIVE'
  WHEN 'Terlambat' THEN 'OVERDUE'
  WHEN 'Dikembalikan' THEN 'RETURNED'
  ELSE status END;
ALTER TABLE peminjaman
  MODIFY status ENUM('ACTIVE','OVERDUE','RETURNED') NOT NULL DEFAULT 'ACTIVE',
  ADD COLUMN IF NOT EXISTS late_days INT NOT NULL DEFAULT 0 AFTER status,
  ADD COLUMN IF NOT EXISTS fine_amount DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER late_days;

ALTER TABLE pengembalian
  ADD COLUMN IF NOT EXISTS late_days INT NOT NULL DEFAULT 0 AFTER denda;

UPDATE peminjaman p
LEFT JOIN settings s ON s.setting_key='late_fine'
SET p.status='OVERDUE',
    p.late_days=GREATEST(1,CEIL(TIMESTAMPDIFF(SECOND,p.tanggal_jatuh_tempo,NOW())/86400)),
    p.fine_amount=GREATEST(1,CEIL(TIMESTAMPDIFF(SECOND,p.tanggal_jatuh_tempo,NOW())/86400))*CAST(COALESCE(s.setting_value,'0') AS DECIMAL(12,2))
WHERE p.status IN ('ACTIVE','OVERDUE') AND p.tanggal_jatuh_tempo<NOW();

UPDATE peminjaman p
JOIN pengembalian k ON k.id_peminjaman=p.id_peminjaman
SET p.status='RETURNED',p.late_days=k.late_days,p.fine_amount=k.denda;
