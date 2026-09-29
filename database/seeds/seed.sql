-- =============================================
-- Perpustakaan Digital - Seed Data
-- =============================================

USE perpustakaan_digital;

-- Settings
INSERT INTO settings (setting_key, setting_value, description) VALUES
('library_name', 'Perpustakaan Digital SMA Negeri 1', 'Nama perpustakaan'),
('borrow_duration', '7', 'Durasi peminjaman dalam hari'),
('max_borrow', '3', 'Maksimal buku yang bisa dipinjam'),
('late_fine', '50000', 'Denda keterlambatan (Rp)'),
('library_address', 'Jl. Pendidikan No. 1, Jakarta', 'Alamat perpustakaan'),
('library_phone', '021-1234567', 'Nomor telepon perpustakaan'),
('library_email', 'perpustakaan@sman1.sch.id', 'Email perpustakaan');

-- Users (password: admin123 and siswa123 - bcrypt hashed)
INSERT INTO users (member_id, name, email, password, role, nis, class, phone, address, status) VALUES
('ADM-001', 'Ibu Sari Pustakawan', 'admin@perpustakaan.com', '$2a$10$sviG.AlHWab8OVALdRf4PujzX/BLmphTsdda1vZrNGxp3inCng0HW', 'admin', NULL, NULL, '08123456789', 'Jl. Perpustakaan No. 1', 'active'),
('STD-001', 'Ahmad Rizki Pratama', 'siswa@perpustakaan.com', '$2a$10$3h3EYUJ5W46B79DDdtGMHOLbv.ctpAToTrLJ2HN53LRdskDwndI.m', 'student', '2024001', 'XII IPA 1', '08234567890', 'Jl. Siswa No. 10', 'active'),
('STD-002', 'Siti Nurhaliza', 'siti@perpustakaan.com', '$2a$10$3h3EYUJ5W46B79DDdtGMHOLbv.ctpAToTrLJ2HN53LRdskDwndI.m', 'student', '2024002', 'XII IPA 2', '08345678901', 'Jl. Melati No. 5', 'active'),
('STD-003', 'Budi Santoso', 'budi@perpustakaan.com', '$2a$10$3h3EYUJ5W46B79DDdtGMHOLbv.ctpAToTrLJ2HN53LRdskDwndI.m', 'student', '2024003', 'XI IPS 1', '08456789012', 'Jl. Mawar No. 3', 'active'),
('STD-004', 'Dewi Anggraini', 'dewi@perpustakaan.com', '$2a$10$3h3EYUJ5W46B79DDdtGMHOLbv.ctpAToTrLJ2HN53LRdskDwndI.m', 'student', '2024004', 'XI IPA 1', '08567890123', 'Jl. Kenanga No. 8', 'active'),
('STD-005', 'Reza Mahendra', 'reza@perpustakaan.com', '$2a$10$3h3EYUJ5W46B79DDdtGMHOLbv.ctpAToTrLJ2HN53LRdskDwndI.m', 'student', '2024005', 'X IPA 1', '08678901234', 'Jl. Dahlia No. 12', 'active');

-- Categories
INSERT INTO categories (name, description) VALUES
('Fiksi', 'Buku-buku cerita fiksi, novel, dan karya sastra imajinatif'),
('Non-Fiksi', 'Buku-buku berdasarkan fakta dan pengetahuan nyata'),
('Sains', 'Buku-buku ilmu pengetahuan alam, fisika, kimia, dan biologi'),
('Teknologi', 'Buku-buku tentang teknologi, komputer, dan informatika'),
('Sejarah', 'Buku-buku tentang sejarah Indonesia dan dunia'),
('Sastra', 'Buku-buku sastra Indonesia dan sastra dunia'),
('Agama', 'Buku-buku pendidikan agama dan moral'),
('Ensiklopedia', 'Ensiklopedia dan buku referensi umum');

-- Authors
INSERT INTO authors (name, bio) VALUES
('Pramoedya Ananta Toer', 'Sastrawan Indonesia yang terkenal dengan Tetralogi Buru'),
('Andrea Hirata', 'Penulis novel Laskar Pelangi yang mendunia'),
('Tere Liye', 'Penulis novel populer Indonesia'),
('Habiburrahman El Shirazy', 'Penulis novel islami best seller'),
('Dee Lestari', 'Penulis serial Supernova'),
('Ahmad Fuadi', 'Penulis trilogi Negeri 5 Menara'),
('Sapardi Djoko Damono', 'Penyair dan sastrawan Indonesia'),
('Y.B. Mangunwijaya', 'Sastrawan dan arsitek Indonesia');

-- Books
INSERT INTO books (title, author_id, author_name, publisher, isbn, category_id, year, description, cover, stock, available, status) VALUES
('Bumi Manusia', 1, 'Pramoedya Ananta Toer', 'Lentera Dipantara', '978-979-799-071-0', 1, 1980, 'Novel pertama dari Tetralogi Buru yang mengisahkan perjuangan Minke, seorang pribumi yang bersekolah di sekolah Belanda pada masa kolonial.', '/covers/bumi-manusia.jpg', 5, 5, 'available'),
('Anak Semua Bangsa', 1, 'Pramoedya Ananta Toer', 'Lentera Dipantara', '978-979-799-072-7', 1, 1981, 'Novel kedua dari Tetralogi Buru yang melanjutkan kisah Minke.', '/covers/anak-semua-bangsa.jpg', 3, 3, 'available'),
('Laskar Pelangi', 2, 'Andrea Hirata', 'Bentang Pustaka', '978-979-1227-01-2', 1, 2005, 'Novel inspiratif tentang 10 anak dari keluarga miskin di Belitung yang berjuang untuk mendapatkan pendidikan.', '/covers/laskar-pelangi.jpg', 7, 7, 'available'),
('Sang Pemimpi', 2, 'Andrea Hirata', 'Bentang Pustaka', '978-979-1227-10-4', 1, 2006, 'Sekuel dari Laskar Pelangi yang mengisahkan mimpi-mimpi besar para tokohnya.', '/covers/sang-pemimpi.jpg', 4, 4, 'available'),
('Bumi', 3, 'Tere Liye', 'Gramedia', '978-602-03-2600-5', 1, 2014, 'Novel fantasi pertama dari serial Bumi yang mengisahkan petualangan Raib.', '/covers/bumi-tere-liye.jpg', 6, 6, 'available'),
('Bulan', 3, 'Tere Liye', 'Gramedia', '978-602-03-3500-7', 1, 2015, 'Kelanjutan serial Bumi yang penuh petualangan dan misteri.', '/covers/bulan.jpg', 4, 4, 'available'),
('Ayat-Ayat Cinta', 4, 'Habiburrahman El Shirazy', 'Republika', '978-979-3210-01-5', 6, 2004, 'Novel islami tentang kisah cinta seorang mahasiswa Indonesia di Mesir.', '/covers/ayat-ayat-cinta.jpg', 5, 5, 'available'),
('Ketika Cinta Bertasbih', 4, 'Habiburrahman El Shirazy', 'Republika', '978-979-3210-05-3', 6, 2007, 'Novel islami inspiratif tentang perjuangan seorang santri.', '/covers/ketika-cinta-bertasbih.jpg', 3, 3, 'available'),
('Supernova: Ksatria Puteri dan Bintang Jatuh', 5, 'Dee Lestari', 'Truedee Books', '978-602-7870-01-2', 1, 2001, 'Novel pertama dari serial Supernova yang memadukan sains dan filsafat.', '/covers/supernova.jpg', 4, 4, 'available'),
('Perahu Kertas', 5, 'Dee Lestari', 'Bentang Pustaka', '978-602-8811-20-3', 1, 2009, 'Novel tentang mimpi dan cinta dua anak muda kreatif.', '/covers/perahu-kertas.jpg', 5, 5, 'available'),
('Negeri 5 Menara', 6, 'Ahmad Fuadi', 'Gramedia', '978-979-22-5764-4', 1, 2009, 'Novel inspiratif tentang kehidupan di pesantren dan kekuatan tekad.', '/covers/negeri-5-menara.jpg', 6, 6, 'available'),
('Ranah 3 Warna', 6, 'Ahmad Fuadi', 'Gramedia', '978-979-22-8384-1', 1, 2011, 'Sekuel Negeri 5 Menara yang mengisahkan petualangan di luar negeri.', '/covers/ranah-3-warna.jpg', 3, 3, 'available'),
('Hujan Bulan Juni', 7, 'Sapardi Djoko Damono', 'Gramedia', '978-979-22-1234-5', 6, 1994, 'Kumpulan puisi terkenal dari sastrawan besar Indonesia.', '/covers/hujan-bulan-juni.jpg', 4, 4, 'available'),
('Fisika Dasar untuk SMA', NULL, 'Tim Penyusun', 'Erlangga', '978-979-099-123-4', 3, 2020, 'Buku pelajaran fisika dasar untuk siswa SMA kelas X-XII.', '/covers/fisika-dasar.jpg', 10, 10, 'available'),
('Matematika SMA Kelas XII', NULL, 'Tim Penyusun', 'Erlangga', '978-979-099-456-3', 3, 2021, 'Buku pelajaran matematika untuk siswa SMA kelas XII.', '/covers/matematika-xii.jpg', 8, 8, 'available'),
('Sejarah Indonesia Modern', NULL, 'M.C. Ricklefs', 'Serambi', '978-979-1600-01-8', 5, 2005, 'Buku sejarah komprehensif tentang Indonesia dari masa kolonial hingga modern.', '/covers/sejarah-indonesia.jpg', 4, 4, 'available'),
('Pemrograman Web dengan JavaScript', NULL, 'Andi Saputra', 'Informatika', '978-602-1514-01-3', 4, 2022, 'Panduan lengkap pemrograman web menggunakan JavaScript modern.', '/covers/javascript.jpg', 5, 5, 'available'),
('Pengantar Ilmu Komputer', NULL, 'Rinaldi Munir', 'Informatika', '978-602-1514-05-1', 4, 2020, 'Buku pengantar ilmu komputer untuk pemula dan mahasiswa.', '/covers/ilmu-komputer.jpg', 6, 6, 'available'),
('Ensiklopedia Indonesia', NULL, 'Tim Editor', 'Gramedia', '978-979-22-9999-9', 8, 2019, 'Ensiklopedia lengkap tentang Indonesia dari A-Z.', '/covers/ensiklopedia.jpg', 2, 2, 'available'),
('Pendidikan Agama Islam', NULL, 'Kementerian Agama', 'Kemenag Press', '978-602-8446-01-0', 7, 2023, 'Buku pendidikan agama Islam untuk siswa SMA.', '/covers/pai.jpg', 8, 8, 'available');

-- E-Books
INSERT INTO ebooks (book_id, title, author_name, description, cover, file_path, file_size, total_pages, year, status) VALUES
(1, 'Bumi Manusia (E-Book)', 'Pramoedya Ananta Toer', 'Versi digital novel Bumi Manusia', '/covers/bumi-manusia.jpg', '/ebooks/bumi-manusia.pdf', 2048000, 350, 1980, 'active'),
(3, 'Laskar Pelangi (E-Book)', 'Andrea Hirata', 'Versi digital novel Laskar Pelangi', '/covers/laskar-pelangi.jpg', '/ebooks/laskar-pelangi.pdf', 1856000, 280, 2005, 'active'),
(5, 'Bumi (E-Book)', 'Tere Liye', 'Versi digital novel Bumi', '/covers/bumi-tere-liye.jpg', '/ebooks/bumi.pdf', 1536000, 240, 2014, 'active'),
(11, 'Negeri 5 Menara (E-Book)', 'Ahmad Fuadi', 'Versi digital novel Negeri 5 Menara', '/covers/negeri-5-menara.jpg', '/ebooks/negeri-5-menara.pdf', 1920000, 300, 2009, 'active'),
(17, 'Pemrograman Web dengan JavaScript (E-Book)', 'Andi Saputra', 'Versi digital buku pemrograman JavaScript', '/covers/javascript.jpg', '/ebooks/javascript.pdf', 3072000, 420, 2022, 'active');

-- Borrowings
INSERT INTO borrowings (transaction_id, user_id, book_id, borrow_date, due_date, return_date, status, notes) VALUES
('TRX-20260801-001', 2, 1, '2026-08-01', '2026-08-08', NULL, 'active', 'Peminjaman buku Bumi Manusia'),
('TRX-20260725-001', 2, 3, '2026-07-25', '2026-08-01', '2026-07-30', 'returned', 'Dikembalikan tepat waktu'),
('TRX-20260720-001', 3, 5, '2026-07-20', '2026-07-27', NULL, 'late', 'Belum dikembalikan, sudah melewati jatuh tempo'),
('TRX-20260729-001', 4, 7, '2026-07-29', '2026-08-05', NULL, 'active', 'Peminjaman Ayat-Ayat Cinta'),
('TRX-20260730-001', 5, 11, '2026-07-30', '2026-08-06', NULL, 'active', 'Peminjaman Negeri 5 Menara');

-- Update book stock for active borrowings
UPDATE books SET available = available - 1 WHERE id IN (1, 5, 7, 11);
UPDATE books SET available = available - 1, status = 'unavailable' WHERE id = 5 AND available <= 0;

-- Inventaris dan transaksi aktif memakai tabel modern yang dibaca API.
INSERT INTO book_copies (book_id, copy_code, status)
SELECT b.id,
       CONCAT('BOOK-', LPAD(b.id, 3, '0'), '-COPY-', LPAD(n.number, 3, '0')),
       IF(n.number <= b.available, 'AVAILABLE', 'BORROWED')
FROM books b
JOIN (
  SELECT 1 number UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
  UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
) n ON n.number <= b.stock;

INSERT INTO peminjaman (id_peminjaman, legacy_borrowing_id, id_anggota, tanggal_pinjam, tanggal_jatuh_tempo, status, late_days, fine_amount)
SELECT CONCAT('LEG-', id), id, user_id, borrow_date, due_date,
       CASE WHEN return_date IS NOT NULL THEN 'RETURNED' WHEN status = 'late' THEN 'OVERDUE' ELSE 'ACTIVE' END,
       CASE WHEN return_date IS NULL AND due_date < CURDATE() THEN DATEDIFF(CURDATE(), due_date) ELSE 0 END,
       0
FROM borrowings;

INSERT INTO detail_peminjaman (id_peminjaman, id_buku, jumlah)
SELECT CONCAT('LEG-', id), book_id, 1 FROM borrowings;

INSERT INTO pengembalian (id_pengembalian, id_peminjaman, tanggal_kembali, denda, late_days, status, payment_status)
SELECT CONCAT('KMB-LEG-', id), CONCAT('LEG-', id), return_date, 0, 0,
       IF(status = 'late', 'Terlambat', 'Dikembalikan'), 'PAID'
FROM borrowings WHERE return_date IS NOT NULL;

INSERT INTO borrowing_copies (id_detail, copy_id)
SELECT d.id_detail, (
  SELECT MIN(c.id) FROM book_copies c WHERE c.book_id = d.id_buku AND c.status = 'BORROWED'
)
FROM detail_peminjaman d
JOIN peminjaman p ON p.id_peminjaman = d.id_peminjaman
WHERE p.status IN ('ACTIVE', 'OVERDUE');

-- Favorites
INSERT INTO favorites (user_id, book_id) VALUES
(2, 1),
(2, 3),
(2, 11),
(3, 5),
(3, 7);

-- Bookmarks
INSERT INTO bookmarks (user_id, ebook_id, page_number, title) VALUES
(2, 1, 45, 'Bab 3: Pertemuan dengan Annelies'),
(2, 2, 120, 'Bab 8: Ujian Akhir'),
(3, 3, 30, 'Bab 2: Dunia Paralel');

-- Reading Progress
INSERT INTO reading_progress (user_id, ebook_id, current_page, total_pages) VALUES
(2, 1, 150, 350),
(2, 2, 120, 280),
(3, 3, 85, 240);

-- Notifications
INSERT INTO notifications (user_id, title, message, type, is_read, link) VALUES
(2, 'Peminjaman Berhasil', 'Anda berhasil meminjam buku "Bumi Manusia". Jatuh tempo: 8 Agustus 2026.', 'borrow', 0, '/student/borrowings/1'),
(2, 'Pengembalian Berhasil', 'Buku "Laskar Pelangi" telah berhasil dikembalikan. Terima kasih!', 'return', 1, '/student/history'),
(2, 'Buku Baru Tersedia', 'Buku baru "Pendidikan Agama Islam" telah ditambahkan ke perpustakaan.', 'info', 0, '/student/books/20'),
(2, 'Jatuh Tempo Mendekat', 'Buku "Bumi Manusia" akan jatuh tempo pada 8 Agustus 2026. Harap segera dikembalikan.', 'due', 0, '/student/borrowings/1'),
(3, 'Peminjaman Terlambat', 'Buku "Bumi" sudah melewati tanggal jatuh tempo. Harap segera dikembalikan.', 'late', 0, '/student/borrowings/3'),
(1, 'Peminjaman Baru', 'Ahmad Rizki Pratama meminjam buku "Bumi Manusia".', 'borrow', 0, '/admin/borrowings/1'),
(1, 'Keterlambatan', 'Siti Nurhaliza terlambat mengembalikan buku "Bumi".', 'late', 0, '/admin/borrowings/3');

-- Activity Logs
INSERT INTO activity_logs (user_id, action, entity_type, entity_id, details) VALUES
(2, 'BORROW', 'borrowing', 1, 'Meminjam buku Bumi Manusia'),
(2, 'RETURN', 'borrowing', 2, 'Mengembalikan buku Laskar Pelangi'),
(3, 'BORROW', 'borrowing', 3, 'Meminjam buku Bumi'),
(1, 'CREATE', 'book', 20, 'Menambahkan buku Pendidikan Agama Islam'),
(4, 'BORROW', 'borrowing', 4, 'Meminjam buku Ayat-Ayat Cinta'),
(5, 'BORROW', 'borrowing', 5, 'Meminjam buku Negeri 5 Menara'),
(1, 'LOGIN', 'user', 1, 'Admin login');
