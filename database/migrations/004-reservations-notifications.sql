-- Phase 5-6: reservasi dan notification center persisten.
-- Jalankan setelah 003-overdue-fines.sql.

USE perpustakaan_digital;

CREATE TABLE IF NOT EXISTS reservations (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  book_id INT NOT NULL,
  queue_number INT NOT NULL,
  status ENUM('WAITING','NOTIFIED','FULFILLED','CANCELLED','EXPIRED') NOT NULL DEFAULT 'WAITING',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  notified_at DATETIME DEFAULT NULL,
  expires_at DATETIME DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT,
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE RESTRICT,
  INDEX idx_reservation_queue (book_id,status,queue_number),
  INDEX idx_reservation_user (user_id,status),
  INDEX idx_reservation_expiry (status,expires_at)
) ENGINE=InnoDB;

ALTER TABLE notifications
  ADD COLUMN IF NOT EXISTS category ENUM('BORROW','RETURN','OVERDUE','RESERVATION','BOOK_AVAILABLE','ANNOUNCEMENT','SYSTEM') NOT NULL DEFAULT 'SYSTEM' AFTER type,
  ADD COLUMN IF NOT EXISTS read_at DATETIME DEFAULT NULL AFTER is_read;

UPDATE notifications SET category=CASE type
  WHEN 'borrow' THEN 'BORROW'
  WHEN 'return' THEN 'RETURN'
  WHEN 'late' THEN 'OVERDUE'
  WHEN 'due' THEN 'OVERDUE'
  ELSE 'SYSTEM' END;

INSERT INTO settings(setting_key,setting_value,description)
VALUES('reservation_hold_hours','24','Batas waktu pengambilan reservasi setelah tersedia')
ON DUPLICATE KEY UPDATE description=VALUES(description);

