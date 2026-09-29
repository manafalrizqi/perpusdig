-- Security, verifikasi identitas anggota, dan arsip data.
USE perpustakaan_digital;

CREATE TABLE IF NOT EXISTS password_resets (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  token VARCHAR(64) NOT NULL,
  expires_at DATETIME NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uk_password_reset_token (token),
  KEY idx_password_reset_user (user_id)
) ENGINE=InnoDB;

ALTER TABLE users
  ADD COLUMN IF NOT EXISTS identity_type ENUM('STUDENT_CARD','KTP') NULL AFTER photo,
  ADD COLUMN IF NOT EXISTS identity_file VARCHAR(255) NULL AFTER identity_type,
  ADD COLUMN IF NOT EXISTS identity_status ENUM('PENDING','APPROVED','REJECTED') NOT NULL DEFAULT 'APPROVED' AFTER identity_file,
  ADD COLUMN IF NOT EXISTS identity_rejection_reason VARCHAR(500) NULL AFTER identity_status,
  ADD COLUMN IF NOT EXISTS identity_verified_by INT NULL AFTER identity_rejection_reason,
  ADD COLUMN IF NOT EXISTS identity_verified_at DATETIME NULL AFTER identity_verified_by,
  ADD CONSTRAINT fk_users_identity_verifier FOREIGN KEY (identity_verified_by) REFERENCES users(id) ON DELETE SET NULL,
  ADD INDEX idx_users_identity_status (identity_status);

ALTER TABLE books ADD COLUMN IF NOT EXISTS archived_at DATETIME NULL AFTER status;
ALTER TABLE password_resets MODIFY token VARCHAR(64) NOT NULL;
