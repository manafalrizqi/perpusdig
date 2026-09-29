-- Jalankan sekali setelah database/schema.sql pada database yang sudah ada.
-- Model transaksi baru: satu peminjaman dapat memuat beberapa buku.
ALTER TABLE books ADD COLUMN IF NOT EXISTS stok INT NOT NULL DEFAULT 0 AFTER stock;
ALTER TABLE books ADD COLUMN IF NOT EXISTS file_ebook VARCHAR(255) NULL AFTER cover;
UPDATE books SET stok = available WHERE stok = 0 AND available > 0;

CREATE TABLE IF NOT EXISTS peminjaman (
  id_peminjaman VARCHAR(30) PRIMARY KEY,
  id_anggota INT NOT NULL,
  tanggal_pinjam DATE NOT NULL,
  tanggal_jatuh_tempo DATE NOT NULL,
  status ENUM('Dipinjam','Dikembalikan','Terlambat') NOT NULL DEFAULT 'Dipinjam',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_anggota) REFERENCES users(id) ON DELETE RESTRICT,
  INDEX idx_peminjaman_anggota (id_anggota),
  INDEX idx_peminjaman_status (status)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS detail_peminjaman (
  id_detail INT AUTO_INCREMENT PRIMARY KEY,
  id_peminjaman VARCHAR(30) NOT NULL,
  id_buku INT NOT NULL,
  jumlah INT NOT NULL DEFAULT 1,
  FOREIGN KEY (id_peminjaman) REFERENCES peminjaman(id_peminjaman) ON DELETE RESTRICT,
  FOREIGN KEY (id_buku) REFERENCES books(id) ON DELETE RESTRICT,
  UNIQUE KEY uk_peminjaman_buku (id_peminjaman, id_buku)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS pengembalian (
  id_pengembalian VARCHAR(30) PRIMARY KEY,
  id_peminjaman VARCHAR(30) NOT NULL,
  tanggal_kembali DATE NOT NULL,
  denda DECIMAL(12,2) NOT NULL DEFAULT 0,
  status ENUM('Dikembalikan','Terlambat') NOT NULL DEFAULT 'Dikembalikan',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_peminjaman) REFERENCES peminjaman(id_peminjaman) ON DELETE RESTRICT,
  UNIQUE KEY uk_pengembalian_peminjaman (id_peminjaman)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS laporan (
  id_laporan VARCHAR(30) PRIMARY KEY,
  id_admin INT NOT NULL,
  tanggal DATE NOT NULL,
  jenis_laporan ENUM('Peminjaman','Pengembalian','Buku','Anggota','Keterlambatan','Bulanan') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_admin) REFERENCES users(id) ON DELETE RESTRICT,
  INDEX idx_laporan_admin (id_admin)
) ENGINE=InnoDB;

-- Durasi peminjaman dapat dihitung per jam maupun per hari.
ALTER TABLE peminjaman MODIFY tanggal_pinjam DATETIME NOT NULL;
ALTER TABLE peminjaman MODIFY tanggal_jatuh_tempo DATETIME NOT NULL;
ALTER TABLE pengembalian MODIFY tanggal_kembali DATETIME NOT NULL;
