-- Jalankan file ini di phpMyAdmin jika tabel sudah dibuat dari schema.sql.
-- Password admin: admin123 | Password siswa: siswa123
INSERT INTO users (member_id, name, email, password, role, nis, class, status)
VALUES
('ADM-001', 'Ibu Sari Pustakawan', 'admin@perpustakaan.com', '$2a$10$sviG.AlHWab8OVALdRf4PujzX/BLmphTsdda1vZrNGxp3inCng0HW', 'admin', NULL, NULL, 'active'),
('STD-001', 'Ahmad Rizki Pratama', 'siswa@perpustakaan.com', '$2a$10$3h3EYUJ5W46B79DDdtGMHOLbv.ctpAToTrLJ2HN53LRdskDwndI.m', 'student', '2024001', 'XII IPA 1', 'active')
ON DUPLICATE KEY UPDATE
  name = VALUES(name), password = VALUES(password), role = VALUES(role), status = 'active';
