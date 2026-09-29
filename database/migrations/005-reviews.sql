-- Phase 7: rating dan review buku.
USE perpustakaan_digital;

CREATE TABLE IF NOT EXISTS book_reviews (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  book_id INT NOT NULL,
  rating TINYINT NOT NULL,
  review_text TEXT DEFAULT NULL,
  status ENUM('VISIBLE','HIDDEN','PENDING') NOT NULL DEFAULT 'PENDING',
  moderated_by INT DEFAULT NULL,
  moderated_at DATETIME DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT,
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE RESTRICT,
  FOREIGN KEY (moderated_by) REFERENCES users(id) ON DELETE SET NULL,
  UNIQUE KEY uk_review_user_book (user_id,book_id),
  INDEX idx_review_book_status (book_id,status),
  CONSTRAINT chk_review_rating CHECK (rating BETWEEN 1 AND 5)
) ENGINE=InnoDB;

