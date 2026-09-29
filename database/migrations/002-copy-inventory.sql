-- Phase 2: inventory per copy.
-- Jalankan setelah 001-unify-transactions.sql.

USE perpustakaan_digital;

CREATE TABLE IF NOT EXISTS book_copies (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  book_id INT NOT NULL,
  copy_code VARCHAR(80) NOT NULL UNIQUE,
  status ENUM('AVAILABLE','BORROWED','LOST','DAMAGED','MAINTENANCE') NOT NULL DEFAULT 'AVAILABLE',
  location VARCHAR(100) DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE RESTRICT,
  INDEX idx_copy_book_status (book_id, status),
  INDEX idx_copy_updated (updated_at)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS borrowing_copies (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  id_detail INT NOT NULL,
  copy_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_detail) REFERENCES detail_peminjaman(id_detail) ON DELETE RESTRICT,
  FOREIGN KEY (copy_id) REFERENCES book_copies(id) ON DELETE RESTRICT,
  UNIQUE KEY uk_borrowing_copy (id_detail, copy_id),
  INDEX idx_borrowing_copy_id (copy_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS book_copy_history (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  copy_id BIGINT NOT NULL,
  from_status ENUM('AVAILABLE','BORROWED','LOST','DAMAGED','MAINTENANCE') DEFAULT NULL,
  to_status ENUM('AVAILABLE','BORROWED','LOST','DAMAGED','MAINTENANCE') NOT NULL,
  id_peminjaman VARCHAR(30) DEFAULT NULL,
  changed_by INT DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (copy_id) REFERENCES book_copies(id) ON DELETE RESTRICT,
  FOREIGN KEY (id_peminjaman) REFERENCES peminjaman(id_peminjaman) ON DELETE SET NULL,
  FOREIGN KEY (changed_by) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_copy_history (copy_id, created_at),
  INDEX idx_copy_history_transaction (id_peminjaman)
) ENGINE=InnoDB;

-- Buat copy dari total stock lama. Status awal menjaga nilai `available`
-- yang sudah ada sehingga migrasi tidak mengubah jumlah inventaris.
DELIMITER $$
CREATE PROCEDURE migrate_book_copies()
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE current_book INT;
  DECLARE total_stock INT;
  DECLARE available_stock INT;
  DECLARE copy_number INT;
  DECLARE books_cursor CURSOR FOR SELECT id, stock, available FROM books;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN books_cursor;
  books_loop: LOOP
    FETCH books_cursor INTO current_book, total_stock, available_stock;
    IF done = 1 THEN LEAVE books_loop; END IF;
    SET copy_number = 1;
    WHILE copy_number <= total_stock DO
      INSERT IGNORE INTO book_copies (book_id, copy_code, status)
      VALUES (
        current_book,
        CONCAT('BOOK-',LPAD(current_book,3,'0'),'-COPY-',LPAD(copy_number,3,'0')),
        IF(copy_number <= available_stock,'AVAILABLE','BORROWED')
      );
      SET copy_number = copy_number + 1;
    END WHILE;
  END LOOP;
  CLOSE books_cursor;
END$$
DELIMITER ;

CALL migrate_book_copies();
DROP PROCEDURE migrate_book_copies;

-- Hubungkan copy berstatus BORROWED ke transaksi aktif hasil migrasi.
DELIMITER $$
CREATE PROCEDURE link_active_borrowing_copies()
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE detail_id INT;
  DECLARE target_book INT;
  DECLARE quantity INT;
  DECLARE linked INT;
  DECLARE selected_copy BIGINT;
  DECLARE transaction_code VARCHAR(30);
  DECLARE details_cursor CURSOR FOR
    SELECT d.id_detail,d.id_buku,d.jumlah,d.id_peminjaman
    FROM detail_peminjaman d
    JOIN peminjaman p ON p.id_peminjaman=d.id_peminjaman
    WHERE p.status IN ('Dipinjam','Terlambat');
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN details_cursor;
  details_loop: LOOP
    FETCH details_cursor INTO detail_id,target_book,quantity,transaction_code;
    IF done = 1 THEN LEAVE details_loop; END IF;
    SET linked = (SELECT COUNT(*) FROM borrowing_copies WHERE id_detail=detail_id);
    WHILE linked < quantity DO
      SET selected_copy = (
        SELECT MIN(c.id)
        FROM book_copies c
        WHERE c.book_id=target_book AND c.status='BORROWED'
          AND NOT EXISTS (SELECT 1 FROM borrowing_copies bc WHERE bc.copy_id=c.id)
      );
      IF selected_copy IS NULL THEN
        SET selected_copy = (
          SELECT MIN(c.id) FROM book_copies c
          WHERE c.book_id=target_book AND c.status='AVAILABLE'
        );
        IF selected_copy IS NOT NULL THEN
          UPDATE book_copies SET status='BORROWED' WHERE id=selected_copy;
        END IF;
      END IF;
      IF selected_copy IS NULL THEN
        SET linked = quantity;
      ELSE
        INSERT IGNORE INTO borrowing_copies(id_detail,copy_id) VALUES(detail_id,selected_copy);
        INSERT INTO book_copy_history(copy_id,from_status,to_status,id_peminjaman,notes)
        VALUES(selected_copy,'AVAILABLE','BORROWED',transaction_code,'Migrasi transaksi aktif');
        SET linked = linked + 1;
      END IF;
    END WHILE;
  END LOOP;
  CLOSE details_cursor;
END$$
DELIMITER ;

CALL link_active_borrowing_copies();
DROP PROCEDURE link_active_borrowing_copies;

-- Sinkronkan kolom agregat lama untuk endpoint yang masih membacanya.
UPDATE books b
JOIN (
  SELECT book_id,COUNT(*) total,SUM(status='AVAILABLE') available
  FROM book_copies GROUP BY book_id
) inventory ON inventory.book_id=b.id
SET b.stock=inventory.total,
    b.stok=inventory.available,
    b.available=inventory.available,
    b.status=IF(inventory.available>0,'available','unavailable');

