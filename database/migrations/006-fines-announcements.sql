-- Phase 14 dan 18: pencatatan denda manual serta pengumuman.
USE perpustakaan_digital;

ALTER TABLE pengembalian
  ADD COLUMN IF NOT EXISTS payment_status ENUM('UNPAID','PAID','WAIVED') NOT NULL DEFAULT 'UNPAID' AFTER status;

UPDATE pengembalian SET payment_status='PAID' WHERE denda=0;

CREATE TABLE IF NOT EXISTS fine_payments (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  id_pengembalian VARCHAR(30) NOT NULL,
  amount DECIMAL(12,2) NOT NULL DEFAULT 0,
  status ENUM('PAID','WAIVED') NOT NULL,
  notes TEXT DEFAULT NULL,
  recorded_by INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_pengembalian) REFERENCES pengembalian(id_pengembalian) ON DELETE RESTRICT,
  FOREIGN KEY (recorded_by) REFERENCES users(id) ON DELETE RESTRICT,
  INDEX idx_fine_payment_return (id_pengembalian,created_at)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS announcements (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  image VARCHAR(255) DEFAULT NULL,
  status ENUM('DRAFT','PUBLISHED','ARCHIVED') NOT NULL DEFAULT 'DRAFT',
  target ENUM('ALL_STUDENTS','SPECIFIC_MEMBER') NOT NULL DEFAULT 'ALL_STUDENTS',
  target_user_id INT DEFAULT NULL,
  start_date DATETIME NOT NULL,
  end_date DATETIME DEFAULT NULL,
  created_by INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (target_user_id) REFERENCES users(id) ON DELETE SET NULL,
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT,
  INDEX idx_announcement_active (status,start_date,end_date),
  INDEX idx_announcement_target (target,target_user_id)
) ENGINE=InnoDB;

