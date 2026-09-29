-- =============================================
-- Perpustakaan Digital - Database Schema
-- =============================================

CREATE DATABASE IF NOT EXISTS perpustakaan_digital
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE perpustakaan_digital;

-- =============================================
-- Users
-- =============================================
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  member_id VARCHAR(20) UNIQUE NOT NULL,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('student', 'admin') NOT NULL DEFAULT 'student',
  nis VARCHAR(20) DEFAULT NULL,
  class VARCHAR(20) DEFAULT NULL,
  phone VARCHAR(20) DEFAULT NULL,
  address TEXT DEFAULT NULL,
  photo VARCHAR(255) DEFAULT NULL,
  identity_type ENUM('STUDENT_CARD', 'KTP') DEFAULT NULL,
  identity_file VARCHAR(255) DEFAULT NULL,
  identity_status ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'APPROVED',
  identity_rejection_reason VARCHAR(500) DEFAULT NULL,
  identity_verified_by INT DEFAULT NULL,
  identity_verified_at DATETIME DEFAULT NULL,
  status ENUM('active', 'inactive', 'suspended') NOT NULL DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_role (role),
  INDEX idx_status (status),
  INDEX idx_nis (nis)
) ENGINE=InnoDB;

ALTER TABLE users ADD CONSTRAINT fk_users_identity_verifier FOREIGN KEY (identity_verified_by) REFERENCES users(id) ON DELETE SET NULL;

CREATE TABLE password_resets (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  token VARCHAR(64) NOT NULL,
  expires_at DATETIME NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uk_password_reset_token (token),
  INDEX idx_password_reset_user (user_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================
-- Categories
-- =============================================
CREATE TABLE categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uk_name (name)
) ENGINE=InnoDB;

-- =============================================
-- Authors
-- =============================================
CREATE TABLE authors (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  bio TEXT DEFAULT NULL,
  photo VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_name (name)
) ENGINE=InnoDB;

-- =============================================
-- Books
-- =============================================
CREATE TABLE books (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  author_id INT DEFAULT NULL,
  author_name VARCHAR(100) NOT NULL,
  publisher VARCHAR(100) DEFAULT NULL,
  isbn VARCHAR(20) DEFAULT NULL,
  category_id INT DEFAULT NULL,
  year INT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  cover VARCHAR(255) DEFAULT NULL,
  file_ebook VARCHAR(255) DEFAULT NULL,
  stock INT NOT NULL DEFAULT 0,
  stok INT NOT NULL DEFAULT 0,
  available INT NOT NULL DEFAULT 0,
  status ENUM('available', 'unavailable') NOT NULL DEFAULT 'available',
  archived_at DATETIME DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
  FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE SET NULL,
  INDEX idx_title (title),
  INDEX idx_category (category_id),
  INDEX idx_author (author_id),
  INDEX idx_status (status),
  UNIQUE KEY uk_isbn (isbn)
) ENGINE=InnoDB;

-- =============================================
-- E-Books
-- =============================================
CREATE TABLE ebooks (
  id INT AUTO_INCREMENT PRIMARY KEY,
  book_id INT DEFAULT NULL,
  title VARCHAR(255) NOT NULL,
  author_name VARCHAR(100) NOT NULL,
  description TEXT DEFAULT NULL,
  cover VARCHAR(255) DEFAULT NULL,
  file_path VARCHAR(255) DEFAULT NULL,
  file_size BIGINT DEFAULT 0,
  total_pages INT DEFAULT 0,
  year INT DEFAULT NULL,
  status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
  upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE SET NULL,
  INDEX idx_title (title),
  INDEX idx_status (status)
) ENGINE=InnoDB;

-- =============================================
-- Borrowings
-- =============================================
CREATE TABLE borrowings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  transaction_id VARCHAR(30) UNIQUE NOT NULL,
  user_id INT NOT NULL,
  book_id INT NOT NULL,
  borrow_date DATE NOT NULL,
  due_date DATE NOT NULL,
  return_date DATE DEFAULT NULL,
  status ENUM('active', 'returned', 'late', 'lost') NOT NULL DEFAULT 'active',
  notes TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
  INDEX idx_user (user_id),
  INDEX idx_book (book_id),
  INDEX idx_status (status),
  INDEX idx_borrow_date (borrow_date),
  INDEX idx_due_date (due_date)
) ENGINE=InnoDB;

-- =============================================
-- Bookmarks
-- =============================================
CREATE TABLE bookmarks (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  ebook_id INT NOT NULL,
  page_number INT NOT NULL DEFAULT 1,
  title VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (ebook_id) REFERENCES ebooks(id) ON DELETE CASCADE,
  INDEX idx_user (user_id),
  UNIQUE KEY uk_user_ebook_page (user_id, ebook_id, page_number)
) ENGINE=InnoDB;

-- =============================================
-- Favorites
-- =============================================
CREATE TABLE favorites (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  book_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
  UNIQUE KEY uk_user_book (user_id, book_id),
  INDEX idx_user (user_id)
) ENGINE=InnoDB;

CREATE TABLE book_reviews (
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

-- =============================================
-- Notifications
-- =============================================
CREATE TABLE notifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  type ENUM('info', 'warning', 'success', 'error', 'borrow', 'return', 'due', 'late') NOT NULL DEFAULT 'info',
  category ENUM('BORROW','RETURN','OVERDUE','RESERVATION','BOOK_AVAILABLE','ANNOUNCEMENT','SYSTEM') NOT NULL DEFAULT 'SYSTEM',
  is_read TINYINT(1) NOT NULL DEFAULT 0,
  read_at DATETIME DEFAULT NULL,
  link VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_user (user_id),
  INDEX idx_read (is_read),
  INDEX idx_type (type)
) ENGINE=InnoDB;

CREATE TABLE reservations (
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

-- =============================================
-- Activity Logs
-- =============================================
CREATE TABLE activity_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT DEFAULT NULL,
  action VARCHAR(100) NOT NULL,
  entity_type VARCHAR(50) DEFAULT NULL,
  entity_id INT DEFAULT NULL,
  details TEXT DEFAULT NULL,
  ip_address VARCHAR(45) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_user (user_id),
  INDEX idx_action (action),
  INDEX idx_created (created_at)
) ENGINE=InnoDB;

-- =============================================
-- Reading Progress
-- =============================================
CREATE TABLE reading_progress (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  ebook_id INT NOT NULL,
  current_page INT NOT NULL DEFAULT 1,
  total_pages INT NOT NULL DEFAULT 1,
  last_read_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (ebook_id) REFERENCES ebooks(id) ON DELETE CASCADE,
  UNIQUE KEY uk_user_ebook (user_id, ebook_id),
  INDEX idx_user (user_id)
) ENGINE=InnoDB;

-- =============================================
-- Settings
-- =============================================
CREATE TABLE settings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  setting_key VARCHAR(100) UNIQUE NOT NULL,
  setting_value TEXT DEFAULT NULL,
  description VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Relasi transaksi modern. `users` berperan sebagai ANGGOTA atau ADMIN melalui kolom role.
CREATE TABLE peminjaman (
  id_peminjaman VARCHAR(30) PRIMARY KEY,
  legacy_borrowing_id INT DEFAULT NULL UNIQUE,
  id_anggota INT NOT NULL,
  tanggal_pinjam DATETIME NOT NULL,
  tanggal_jatuh_tempo DATETIME NOT NULL,
  status ENUM('ACTIVE','OVERDUE','RETURNED') NOT NULL DEFAULT 'ACTIVE',
  late_days INT NOT NULL DEFAULT 0,
  fine_amount DECIMAL(12,2) NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_anggota) REFERENCES users(id) ON DELETE RESTRICT,
  INDEX idx_peminjaman_anggota_status (id_anggota, status),
  INDEX idx_peminjaman_tanggal (tanggal_pinjam, tanggal_jatuh_tempo)
) ENGINE=InnoDB;

CREATE TABLE detail_peminjaman (
  id_detail INT AUTO_INCREMENT PRIMARY KEY,
  id_peminjaman VARCHAR(30) NOT NULL,
  id_buku INT NOT NULL,
  jumlah INT NOT NULL DEFAULT 1,
  FOREIGN KEY (id_peminjaman) REFERENCES peminjaman(id_peminjaman) ON DELETE RESTRICT,
  FOREIGN KEY (id_buku) REFERENCES books(id) ON DELETE RESTRICT,
  INDEX idx_detail_peminjaman_buku (id_buku)
) ENGINE=InnoDB;

CREATE TABLE book_copies (
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

CREATE TABLE borrowing_copies (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  id_detail INT NOT NULL,
  copy_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_detail) REFERENCES detail_peminjaman(id_detail) ON DELETE RESTRICT,
  FOREIGN KEY (copy_id) REFERENCES book_copies(id) ON DELETE RESTRICT,
  UNIQUE KEY uk_borrowing_copy (id_detail, copy_id),
  INDEX idx_borrowing_copy_id (copy_id)
) ENGINE=InnoDB;

CREATE TABLE book_copy_history (
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

CREATE TABLE pengembalian (
  id_pengembalian VARCHAR(30) PRIMARY KEY,
  id_peminjaman VARCHAR(30) NOT NULL UNIQUE,
  tanggal_kembali DATETIME NOT NULL,
  denda DECIMAL(12,2) NOT NULL DEFAULT 0,
  late_days INT NOT NULL DEFAULT 0,
  status ENUM('Dikembalikan','Terlambat') NOT NULL,
  payment_status ENUM('UNPAID','PAID','WAIVED') NOT NULL DEFAULT 'UNPAID',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_peminjaman) REFERENCES peminjaman(id_peminjaman) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE fine_payments (
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

CREATE TABLE announcements (
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

CREATE TABLE laporan (
  id_laporan VARCHAR(30) PRIMARY KEY,
  id_admin INT NOT NULL,
  tanggal DATE NOT NULL,
  jenis_laporan ENUM('Peminjaman','Pengembalian','Buku','Anggota','Keterlambatan','Bulanan') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_admin) REFERENCES users(id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Pada instalasi awal, stok aktif mengikuti kolom `available` milik data katalog.
UPDATE books SET stok = available;
