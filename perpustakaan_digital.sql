-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 29 Sep 2026 pada 06.25
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `perpustakaan_digital`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `entity_type` varchar(50) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `entity_type`, `entity_id`, `details`, `ip_address`, `created_at`) VALUES
(1, 2, 'BORROW', 'borrowing', 1, 'Meminjam buku Bumi Manusia', NULL, '2026-09-02 01:19:47'),
(2, 2, 'RETURN', 'borrowing', 2, 'Mengembalikan buku Laskar Pelangi', NULL, '2026-09-02 01:19:47'),
(3, 3, 'BORROW', 'borrowing', 3, 'Meminjam buku Bumi', NULL, '2026-09-02 01:19:47'),
(4, 1, 'CREATE', 'book', 20, 'Menambahkan buku Pendidikan Agama Islam', NULL, '2026-09-02 01:19:47'),
(5, 4, 'BORROW', 'borrowing', 4, 'Meminjam buku Ayat-Ayat Cinta', NULL, '2026-09-02 01:19:47'),
(6, 5, 'BORROW', 'borrowing', 5, 'Meminjam buku Negeri 5 Menara', NULL, '2026-09-02 01:19:47'),
(7, 1, 'LOGIN', 'user', 1, 'Admin login', NULL, '2026-09-02 01:19:47'),
(8, 1, 'LOGIN', 'user', 1, 'Login aplikasi', NULL, '2026-09-02 01:38:45'),
(9, 2, 'OVERDUE', 'peminjaman', 0, 'Peminjaman LEG-1 melewati jatuh tempo', NULL, '2026-09-02 01:38:46'),
(10, 4, 'OVERDUE', 'peminjaman', 0, 'Peminjaman LEG-4 melewati jatuh tempo', NULL, '2026-09-02 01:38:46'),
(11, 5, 'OVERDUE', 'peminjaman', 0, 'Peminjaman LEG-5 melewati jatuh tempo', NULL, '2026-09-02 01:38:46'),
(12, 1, 'LOGOUT', 'user', 1, 'Logout aplikasi', NULL, '2026-09-02 01:39:42'),
(13, 2, 'LOGIN', 'user', 2, 'Login aplikasi', NULL, '2026-09-02 01:40:12'),
(14, 2, 'LOGOUT', 'user', 2, 'Logout aplikasi', NULL, '2026-09-02 01:41:04'),
(15, 1, 'LOGIN', 'user', 1, 'Login aplikasi', NULL, '2026-09-02 01:41:32'),
(16, 1, 'CREATE', 'ebooks', 6, 'Menambah ebooks', NULL, '2026-09-02 01:42:49'),
(17, 1, 'LOGOUT', 'user', 1, 'Logout aplikasi', NULL, '2026-09-02 01:42:53'),
(18, 2, 'LOGIN', 'user', 2, 'Login aplikasi', NULL, '2026-09-02 01:43:04'),
(19, 2, 'LOGOUT', 'user', 2, 'Logout aplikasi', NULL, '2026-09-02 01:49:33'),
(20, 2, 'LOGIN', 'user', 2, 'Login aplikasi', NULL, '2026-09-02 01:49:46'),
(21, 1, 'LOGIN', 'user', 1, 'Login aplikasi', NULL, '2026-09-09 06:33:00'),
(22, 1, 'VIEW_IDENTITY', 'user', 7, 'Melihat foto identitas anggota', NULL, '2026-09-09 06:37:55'),
(23, 1, 'APPROVE_IDENTITY', 'user', 7, 'Identitas disetujui', NULL, '2026-09-09 06:37:58'),
(24, 1, 'LOGOUT', 'user', 1, 'Logout aplikasi', NULL, '2026-09-09 06:38:13'),
(25, 7, 'LOGIN', 'user', 7, 'Login aplikasi', NULL, '2026-09-09 06:39:51'),
(26, 7, 'LOGOUT', 'user', 7, 'Logout aplikasi', NULL, '2026-09-09 06:41:11'),
(27, 7, 'LOGIN', 'user', 7, 'Login aplikasi', NULL, '2026-09-09 06:44:25'),
(28, 7, 'LOGOUT', 'user', 7, 'Logout aplikasi', NULL, '2026-09-09 06:49:23'),
(29, 7, 'LOGIN', 'user', 7, 'Login aplikasi', NULL, '2026-09-09 07:18:01'),
(30, 7, 'LOGOUT', 'user', 7, 'Logout aplikasi', NULL, '2026-09-09 07:18:09'),
(31, 1, 'LOGIN', 'user', 1, 'Login aplikasi', NULL, '2026-09-15 04:30:16'),
(32, 1, 'LOGOUT', 'user', 1, 'Logout aplikasi', NULL, '2026-09-15 04:30:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `announcements`
--

CREATE TABLE `announcements` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` enum('DRAFT','PUBLISHED','ARCHIVED') NOT NULL DEFAULT 'DRAFT',
  `target` enum('ALL_STUDENTS','SPECIFIC_MEMBER') NOT NULL DEFAULT 'ALL_STUDENTS',
  `target_user_id` int(11) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `authors`
--

CREATE TABLE `authors` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `bio` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `authors`
--

INSERT INTO `authors` (`id`, `name`, `bio`, `photo`, `created_at`, `updated_at`) VALUES
(1, 'Pramoedya Ananta Toer', 'Sastrawan Indonesia yang terkenal dengan Tetralogi Buru', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(2, 'Andrea Hirata', 'Penulis novel Laskar Pelangi yang mendunia', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(3, 'Tere Liye', 'Penulis novel populer Indonesia', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(4, 'Habiburrahman El Shirazy', 'Penulis novel islami best seller', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(5, 'Dee Lestari', 'Penulis serial Supernova', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(6, 'Ahmad Fuadi', 'Penulis trilogi Negeri 5 Menara', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(7, 'Sapardi Djoko Damono', 'Penyair dan sastrawan Indonesia', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(8, 'Y.B. Mangunwijaya', 'Sastrawan dan arsitek Indonesia', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47');

-- --------------------------------------------------------

--
-- Struktur dari tabel `bookmarks`
--

CREATE TABLE `bookmarks` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ebook_id` int(11) NOT NULL,
  `page_number` int(11) NOT NULL DEFAULT 1,
  `title` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `bookmarks`
--

INSERT INTO `bookmarks` (`id`, `user_id`, `ebook_id`, `page_number`, `title`, `created_at`) VALUES
(1, 2, 1, 45, 'Bab 3: Pertemuan dengan Annelies', '2026-09-02 01:19:47'),
(3, 3, 3, 30, 'Bab 2: Dunia Paralel', '2026-09-02 01:19:47');

-- --------------------------------------------------------

--
-- Struktur dari tabel `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `author_name` varchar(100) NOT NULL,
  `publisher` varchar(100) DEFAULT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `file_ebook` varchar(255) DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `stok` int(11) NOT NULL DEFAULT 0,
  `available` int(11) NOT NULL DEFAULT 0,
  `status` enum('available','unavailable') NOT NULL DEFAULT 'available',
  `archived_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `books`
--

INSERT INTO `books` (`id`, `title`, `author_id`, `author_name`, `publisher`, `isbn`, `category_id`, `year`, `description`, `cover`, `file_ebook`, `stock`, `stok`, `available`, `status`, `archived_at`, `created_at`, `updated_at`) VALUES
(1, 'Bumi Manusia', 1, 'Pramoedya Ananta Toer', 'Lentera Dipantara', '978-979-799-071-0', 1, 1980, 'Novel pertama dari Tetralogi Buru yang mengisahkan perjuangan Minke, seorang pribumi yang bersekolah di sekolah Belanda pada masa kolonial.', '/covers/bumi-manusia.jpg', NULL, 5, 0, 4, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(2, 'Anak Semua Bangsa', 1, 'Pramoedya Ananta Toer', 'Lentera Dipantara', '978-979-799-072-7', 1, 1981, 'Novel kedua dari Tetralogi Buru yang melanjutkan kisah Minke.', '/covers/anak-semua-bangsa.jpg', NULL, 3, 0, 3, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(3, 'Laskar Pelangi', 2, 'Andrea Hirata', 'Bentang Pustaka', '978-979-1227-01-2', 1, 2005, 'Novel inspiratif tentang 10 anak dari keluarga miskin di Belitung yang berjuang untuk mendapatkan pendidikan.', '/covers/laskar-pelangi.jpg', NULL, 7, 0, 7, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(4, 'Sang Pemimpi', 2, 'Andrea Hirata', 'Bentang Pustaka', '978-979-1227-10-4', 1, 2006, 'Sekuel dari Laskar Pelangi yang mengisahkan mimpi-mimpi besar para tokohnya.', '/covers/sang-pemimpi.jpg', NULL, 4, 0, 4, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(5, 'Bumi', 3, 'Tere Liye', 'Gramedia', '978-602-03-2600-5', 1, 2014, 'Novel fantasi pertama dari serial Bumi yang mengisahkan petualangan Raib.', '/covers/bumi-tere-liye.jpg', NULL, 6, 0, 5, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(6, 'Bulan', 3, 'Tere Liye', 'Gramedia', '978-602-03-3500-7', 1, 2015, 'Kelanjutan serial Bumi yang penuh petualangan dan misteri.', '/covers/bulan.jpg', NULL, 4, 0, 4, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(7, 'Ayat-Ayat Cinta', 4, 'Habiburrahman El Shirazy', 'Republika', '978-979-3210-01-5', 6, 2004, 'Novel islami tentang kisah cinta seorang mahasiswa Indonesia di Mesir.', '/covers/ayat-ayat-cinta.jpg', NULL, 5, 0, 4, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(8, 'Ketika Cinta Bertasbih', 4, 'Habiburrahman El Shirazy', 'Republika', '978-979-3210-05-3', 6, 2007, 'Novel islami inspiratif tentang perjuangan seorang santri.', '/covers/ketika-cinta-bertasbih.jpg', NULL, 3, 0, 3, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(9, 'Supernova: Ksatria Puteri dan Bintang Jatuh', 5, 'Dee Lestari', 'Truedee Books', '978-602-7870-01-2', 1, 2001, 'Novel pertama dari serial Supernova yang memadukan sains dan filsafat.', '/covers/supernova.jpg', NULL, 4, 0, 4, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(10, 'Perahu Kertas', 5, 'Dee Lestari', 'Bentang Pustaka', '978-602-8811-20-3', 1, 2009, 'Novel tentang mimpi dan cinta dua anak muda kreatif.', '/covers/perahu-kertas.jpg', NULL, 5, 0, 5, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(11, 'Negeri 5 Menara', 6, 'Ahmad Fuadi', 'Gramedia', '978-979-22-5764-4', 1, 2009, 'Novel inspiratif tentang kehidupan di pesantren dan kekuatan tekad.', '/covers/negeri-5-menara.jpg', NULL, 6, 0, 5, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(12, 'Ranah 3 Warna', 6, 'Ahmad Fuadi', 'Gramedia', '978-979-22-8384-1', 1, 2011, 'Sekuel Negeri 5 Menara yang mengisahkan petualangan di luar negeri.', '/covers/ranah-3-warna.jpg', NULL, 3, 0, 3, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(13, 'Hujan Bulan Juni', 7, 'Sapardi Djoko Damono', 'Gramedia', '978-979-22-1234-5', 6, 1994, 'Kumpulan puisi terkenal dari sastrawan besar Indonesia.', '/covers/hujan-bulan-juni.jpg', NULL, 4, 0, 4, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(14, 'Fisika Dasar untuk SMA', NULL, 'Tim Penyusun', 'Erlangga', '978-979-099-123-4', 3, 2020, 'Buku pelajaran fisika dasar untuk siswa SMA kelas X-XII.', '/covers/fisika-dasar.jpg', NULL, 10, 0, 10, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(15, 'Matematika SMA Kelas XII', NULL, 'Tim Penyusun', 'Erlangga', '978-979-099-456-3', 3, 2021, 'Buku pelajaran matematika untuk siswa SMA kelas XII.', '/covers/matematika-xii.jpg', NULL, 8, 0, 8, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(16, 'Sejarah Indonesia Modern', NULL, 'M.C. Ricklefs', 'Serambi', '978-979-1600-01-8', 5, 2005, 'Buku sejarah komprehensif tentang Indonesia dari masa kolonial hingga modern.', '/covers/sejarah-indonesia.jpg', NULL, 4, 0, 4, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(17, 'Pemrograman Web dengan JavaScript', NULL, 'Andi Saputra', 'Informatika', '978-602-1514-01-3', 4, 2022, 'Panduan lengkap pemrograman web menggunakan JavaScript modern.', '/covers/javascript.jpg', NULL, 5, 0, 5, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(18, 'Pengantar Ilmu Komputer', NULL, 'Rinaldi Munir', 'Informatika', '978-602-1514-05-1', 4, 2020, 'Buku pengantar ilmu komputer untuk pemula dan mahasiswa.', '/covers/ilmu-komputer.jpg', NULL, 6, 0, 6, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(19, 'Ensiklopedia Indonesia', NULL, 'Tim Editor', 'Gramedia', '978-979-22-9999-9', 8, 2019, 'Ensiklopedia lengkap tentang Indonesia dari A-Z.', '/covers/ensiklopedia.jpg', NULL, 2, 0, 2, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(20, 'Pendidikan Agama Islam', NULL, 'Kementerian Agama', 'Kemenag Press', '978-602-8446-01-0', 7, 2023, 'Buku pendidikan agama Islam untuk siswa SMA.', '/covers/pai.jpg', NULL, 8, 0, 8, 'available', NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47');

-- --------------------------------------------------------

--
-- Struktur dari tabel `book_copies`
--

CREATE TABLE `book_copies` (
  `id` bigint(20) NOT NULL,
  `book_id` int(11) NOT NULL,
  `copy_code` varchar(80) NOT NULL,
  `status` enum('AVAILABLE','BORROWED','LOST','DAMAGED','MAINTENANCE') NOT NULL DEFAULT 'AVAILABLE',
  `location` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `book_copies`
--

INSERT INTO `book_copies` (`id`, `book_id`, `copy_code`, `status`, `location`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'BOOK-001-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(2, 1, 'BOOK-001-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(3, 1, 'BOOK-001-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(4, 1, 'BOOK-001-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(5, 1, 'BOOK-001-COPY-005', 'BORROWED', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(6, 2, 'BOOK-002-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(7, 2, 'BOOK-002-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(8, 2, 'BOOK-002-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(9, 3, 'BOOK-003-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(10, 3, 'BOOK-003-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(11, 3, 'BOOK-003-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(12, 3, 'BOOK-003-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(13, 3, 'BOOK-003-COPY-005', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(14, 3, 'BOOK-003-COPY-006', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(15, 3, 'BOOK-003-COPY-007', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(16, 4, 'BOOK-004-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(17, 4, 'BOOK-004-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(18, 4, 'BOOK-004-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(19, 4, 'BOOK-004-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(20, 5, 'BOOK-005-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(21, 5, 'BOOK-005-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(22, 5, 'BOOK-005-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(23, 5, 'BOOK-005-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(24, 5, 'BOOK-005-COPY-005', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(25, 5, 'BOOK-005-COPY-006', 'BORROWED', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(26, 6, 'BOOK-006-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(27, 6, 'BOOK-006-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(28, 6, 'BOOK-006-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(29, 6, 'BOOK-006-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(30, 7, 'BOOK-007-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(31, 7, 'BOOK-007-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(32, 7, 'BOOK-007-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(33, 7, 'BOOK-007-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(34, 7, 'BOOK-007-COPY-005', 'BORROWED', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(35, 8, 'BOOK-008-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(36, 8, 'BOOK-008-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(37, 8, 'BOOK-008-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(38, 9, 'BOOK-009-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(39, 9, 'BOOK-009-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(40, 9, 'BOOK-009-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(41, 9, 'BOOK-009-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(42, 10, 'BOOK-010-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(43, 10, 'BOOK-010-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(44, 10, 'BOOK-010-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(45, 10, 'BOOK-010-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(46, 10, 'BOOK-010-COPY-005', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(47, 11, 'BOOK-011-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(48, 11, 'BOOK-011-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(49, 11, 'BOOK-011-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(50, 11, 'BOOK-011-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(51, 11, 'BOOK-011-COPY-005', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(52, 11, 'BOOK-011-COPY-006', 'BORROWED', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(53, 12, 'BOOK-012-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(54, 12, 'BOOK-012-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(55, 12, 'BOOK-012-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(56, 13, 'BOOK-013-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(57, 13, 'BOOK-013-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(58, 13, 'BOOK-013-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(59, 13, 'BOOK-013-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(60, 14, 'BOOK-014-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(61, 14, 'BOOK-014-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(62, 14, 'BOOK-014-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(63, 14, 'BOOK-014-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(64, 14, 'BOOK-014-COPY-005', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(65, 14, 'BOOK-014-COPY-006', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(66, 14, 'BOOK-014-COPY-007', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(67, 14, 'BOOK-014-COPY-008', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(68, 14, 'BOOK-014-COPY-009', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(69, 14, 'BOOK-014-COPY-010', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(70, 15, 'BOOK-015-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(71, 15, 'BOOK-015-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(72, 15, 'BOOK-015-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(73, 15, 'BOOK-015-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(74, 15, 'BOOK-015-COPY-005', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(75, 15, 'BOOK-015-COPY-006', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(76, 15, 'BOOK-015-COPY-007', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(77, 15, 'BOOK-015-COPY-008', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(78, 16, 'BOOK-016-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(79, 16, 'BOOK-016-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(80, 16, 'BOOK-016-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(81, 16, 'BOOK-016-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(82, 17, 'BOOK-017-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(83, 17, 'BOOK-017-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(84, 17, 'BOOK-017-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(85, 17, 'BOOK-017-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(86, 17, 'BOOK-017-COPY-005', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(87, 18, 'BOOK-018-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(88, 18, 'BOOK-018-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(89, 18, 'BOOK-018-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(90, 18, 'BOOK-018-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(91, 18, 'BOOK-018-COPY-005', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(92, 18, 'BOOK-018-COPY-006', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(93, 19, 'BOOK-019-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(94, 19, 'BOOK-019-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(95, 20, 'BOOK-020-COPY-001', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(96, 20, 'BOOK-020-COPY-002', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(97, 20, 'BOOK-020-COPY-003', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(98, 20, 'BOOK-020-COPY-004', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(99, 20, 'BOOK-020-COPY-005', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(100, 20, 'BOOK-020-COPY-006', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(101, 20, 'BOOK-020-COPY-007', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(102, 20, 'BOOK-020-COPY-008', 'AVAILABLE', NULL, NULL, '2026-09-02 01:19:47', '2026-09-02 01:19:47');

-- --------------------------------------------------------

--
-- Struktur dari tabel `book_copy_history`
--

CREATE TABLE `book_copy_history` (
  `id` bigint(20) NOT NULL,
  `copy_id` bigint(20) NOT NULL,
  `from_status` enum('AVAILABLE','BORROWED','LOST','DAMAGED','MAINTENANCE') DEFAULT NULL,
  `to_status` enum('AVAILABLE','BORROWED','LOST','DAMAGED','MAINTENANCE') NOT NULL,
  `id_peminjaman` varchar(30) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `book_reviews`
--

CREATE TABLE `book_reviews` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL,
  `review_text` text DEFAULT NULL,
  `status` enum('VISIBLE','HIDDEN','PENDING') NOT NULL DEFAULT 'PENDING',
  `moderated_by` int(11) DEFAULT NULL,
  `moderated_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `borrowings`
--

CREATE TABLE `borrowings` (
  `id` int(11) NOT NULL,
  `transaction_id` varchar(30) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `borrow_date` date NOT NULL,
  `due_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  `status` enum('active','returned','late','lost') NOT NULL DEFAULT 'active',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `borrowings`
--

INSERT INTO `borrowings` (`id`, `transaction_id`, `user_id`, `book_id`, `borrow_date`, `due_date`, `return_date`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'TRX-20260801-001', 2, 1, '2026-08-01', '2026-08-08', NULL, 'active', 'Peminjaman buku Bumi Manusia', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(2, 'TRX-20260725-001', 2, 3, '2026-07-25', '2026-08-01', '2026-07-30', 'returned', 'Dikembalikan tepat waktu', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(3, 'TRX-20260720-001', 3, 5, '2026-07-20', '2026-07-27', NULL, 'late', 'Belum dikembalikan, sudah melewati jatuh tempo', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(4, 'TRX-20260729-001', 4, 7, '2026-07-29', '2026-08-05', NULL, 'active', 'Peminjaman Ayat-Ayat Cinta', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(5, 'TRX-20260730-001', 5, 11, '2026-07-30', '2026-08-06', NULL, 'active', 'Peminjaman Negeri 5 Menara', '2026-09-02 01:19:47', '2026-09-02 01:19:47');

-- --------------------------------------------------------

--
-- Struktur dari tabel `borrowing_copies`
--

CREATE TABLE `borrowing_copies` (
  `id` bigint(20) NOT NULL,
  `id_detail` int(11) NOT NULL,
  `copy_id` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `borrowing_copies`
--

INSERT INTO `borrowing_copies` (`id`, `id_detail`, `copy_id`, `created_at`) VALUES
(1, 1, 5, '2026-09-02 01:19:47'),
(2, 3, 25, '2026-09-02 01:19:47'),
(3, 4, 34, '2026-09-02 01:19:47'),
(4, 5, 52, '2026-09-02 01:19:47');

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Fiksi', 'Buku-buku cerita fiksi, novel, dan karya sastra imajinatif', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(2, 'Non-Fiksi', 'Buku-buku berdasarkan fakta dan pengetahuan nyata', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(3, 'Sains', 'Buku-buku ilmu pengetahuan alam, fisika, kimia, dan biologi', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(4, 'Teknologi', 'Buku-buku tentang teknologi, komputer, dan informatika', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(5, 'Sejarah', 'Buku-buku tentang sejarah Indonesia dan dunia', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(6, 'Sastra', 'Buku-buku sastra Indonesia dan sastra dunia', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(7, 'Agama', 'Buku-buku pendidikan agama dan moral', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(8, 'Ensiklopedia', 'Ensiklopedia dan buku referensi umum', '2026-09-02 01:19:47', '2026-09-02 01:19:47');

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_peminjaman`
--

CREATE TABLE `detail_peminjaman` (
  `id_detail` int(11) NOT NULL,
  `id_peminjaman` varchar(30) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `detail_peminjaman`
--

INSERT INTO `detail_peminjaman` (`id_detail`, `id_peminjaman`, `id_buku`, `jumlah`) VALUES
(1, 'LEG-1', 1, 1),
(2, 'LEG-2', 3, 1),
(3, 'LEG-3', 5, 1),
(4, 'LEG-4', 7, 1),
(5, 'LEG-5', 11, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `ebooks`
--

CREATE TABLE `ebooks` (
  `id` int(11) NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `author_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT 0,
  `total_pages` int(11) DEFAULT 0,
  `year` int(11) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `ebooks`
--

INSERT INTO `ebooks` (`id`, `book_id`, `title`, `author_name`, `description`, `cover`, `file_path`, `file_size`, `total_pages`, `year`, `status`, `upload_date`, `created_at`, `updated_at`) VALUES
(1, 1, 'Bumi Manusia (E-Book)', 'Pramoedya Ananta Toer', 'Versi digital novel Bumi Manusia', '/covers/bumi-manusia.jpg', '/ebooks/bumi-manusia.pdf', 2048000, 350, 1980, 'active', '2026-09-02 01:19:47', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(3, 5, 'Bumi (E-Book)', 'Tere Liye', 'Versi digital novel Bumi', '/covers/bumi-tere-liye.jpg', '/ebooks/bumi.pdf', 1536000, 240, 2014, 'active', '2026-09-02 01:19:47', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(4, 11, 'Negeri 5 Menara (E-Book)', 'Ahmad Fuadi', 'Versi digital novel Negeri 5 Menara', '/covers/negeri-5-menara.jpg', '/ebooks/negeri-5-menara.pdf', 1920000, 300, 2009, 'active', '2026-09-02 01:19:47', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(5, 17, 'Pemrograman Web dengan JavaScript (E-Book)', 'Andi Saputra', 'Versi digital buku pemrograman JavaScript', '/covers/javascript.jpg', '/ebooks/javascript.pdf', 3072000, 420, 2022, 'active', '2026-09-02 01:19:47', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(6, 2, 'Laskar Pelangi', 'Pramoedya Ananta Toer', NULL, '/uploads/1788313369825-1a827aaf0a6f0e0a.jpeg', '/api/files/1788313369836-b3122fadb3c2868f.pdf', 0, 12, 2012, 'active', '2026-09-02 01:42:49', '2026-09-02 01:42:49', '2026-09-02 01:42:49');

-- --------------------------------------------------------

--
-- Struktur dari tabel `favorites`
--

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `book_id`, `created_at`) VALUES
(1, 2, 1, '2026-09-02 01:19:47'),
(2, 2, 3, '2026-09-02 01:19:47'),
(3, 2, 11, '2026-09-02 01:19:47'),
(4, 3, 5, '2026-09-02 01:19:47'),
(5, 3, 7, '2026-09-02 01:19:47');

-- --------------------------------------------------------

--
-- Struktur dari tabel `fine_payments`
--

CREATE TABLE `fine_payments` (
  `id` bigint(20) NOT NULL,
  `id_pengembalian` varchar(30) NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('PAID','WAIVED') NOT NULL,
  `notes` text DEFAULT NULL,
  `recorded_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `laporan`
--

CREATE TABLE `laporan` (
  `id_laporan` varchar(30) NOT NULL,
  `id_admin` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `jenis_laporan` enum('Peminjaman','Pengembalian','Buku','Anggota','Keterlambatan','Bulanan') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` enum('info','warning','success','error','borrow','return','due','late') NOT NULL DEFAULT 'info',
  `category` enum('BORROW','RETURN','OVERDUE','RESERVATION','BOOK_AVAILABLE','ANNOUNCEMENT','SYSTEM') NOT NULL DEFAULT 'SYSTEM',
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `read_at` datetime DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `message`, `type`, `category`, `is_read`, `read_at`, `link`, `created_at`) VALUES
(1, 2, 'Peminjaman Berhasil', 'Anda berhasil meminjam buku \"Bumi Manusia\". Jatuh tempo: 8 Agustus 2026.', 'borrow', 'SYSTEM', 0, NULL, '/student/borrowings/1', '2026-09-02 01:19:47'),
(2, 2, 'Pengembalian Berhasil', 'Buku \"Laskar Pelangi\" telah berhasil dikembalikan. Terima kasih!', 'return', 'SYSTEM', 1, NULL, '/student/history', '2026-09-02 01:19:47'),
(3, 2, 'Buku Baru Tersedia', 'Buku baru \"Pendidikan Agama Islam\" telah ditambahkan ke perpustakaan.', 'info', 'SYSTEM', 0, NULL, '/student/books/20', '2026-09-02 01:19:47'),
(4, 2, 'Jatuh Tempo Mendekat', 'Buku \"Bumi Manusia\" akan jatuh tempo pada 8 Agustus 2026. Harap segera dikembalikan.', 'due', 'SYSTEM', 0, NULL, '/student/borrowings/1', '2026-09-02 01:19:47'),
(5, 3, 'Peminjaman Terlambat', 'Buku \"Bumi\" sudah melewati tanggal jatuh tempo. Harap segera dikembalikan.', 'late', 'SYSTEM', 0, NULL, '/student/borrowings/3', '2026-09-02 01:19:47'),
(6, 1, 'Peminjaman Baru', 'Ahmad Rizki Pratama meminjam buku \"Bumi Manusia\".', 'borrow', 'SYSTEM', 0, NULL, '/admin/borrowings/1', '2026-09-02 01:19:47'),
(7, 1, 'Keterlambatan', 'Siti Nurhaliza terlambat mengembalikan buku \"Bumi\".', 'late', 'SYSTEM', 0, NULL, '/admin/borrowings/3', '2026-09-02 01:19:47'),
(8, 2, 'Peminjaman terlambat', 'Peminjaman LEG-1 telah melewati jatuh tempo.', 'late', 'SYSTEM', 0, NULL, '/student/borrowings/LEG-1', '2026-09-02 01:38:46'),
(9, 4, 'Peminjaman terlambat', 'Peminjaman LEG-4 telah melewati jatuh tempo.', 'late', 'SYSTEM', 0, NULL, '/student/borrowings/LEG-4', '2026-09-02 01:38:46'),
(10, 5, 'Peminjaman terlambat', 'Peminjaman LEG-5 telah melewati jatuh tempo.', 'late', 'SYSTEM', 0, NULL, '/student/borrowings/LEG-5', '2026-09-02 01:38:46'),
(11, 7, 'Identitas disetujui', 'Akun Anda sudah aktif dan dapat digunakan.', 'info', 'SYSTEM', 0, NULL, '/student/profile', '2026-09-09 06:37:58');

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `password_resets`
--

INSERT INTO `password_resets` (`id`, `user_id`, `token`, `expires_at`, `created_at`) VALUES
(1, 7, 'd4ede36b31d773d3d6a1ed41df07aed586d041f34bf9b441e6c30093780f2868', '2026-09-15 12:29:52', '2026-09-15 04:29:52');

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` varchar(30) NOT NULL,
  `legacy_borrowing_id` int(11) DEFAULT NULL,
  `id_anggota` int(11) NOT NULL,
  `tanggal_pinjam` datetime NOT NULL,
  `tanggal_jatuh_tempo` datetime NOT NULL,
  `status` enum('ACTIVE','OVERDUE','RETURNED') NOT NULL DEFAULT 'ACTIVE',
  `late_days` int(11) NOT NULL DEFAULT 0,
  `fine_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `legacy_borrowing_id`, `id_anggota`, `tanggal_pinjam`, `tanggal_jatuh_tempo`, `status`, `late_days`, `fine_amount`, `created_at`) VALUES
('LEG-1', 1, 2, '2026-08-01 00:00:00', '2026-08-08 00:00:00', 'OVERDUE', 39, 1950000.00, '2026-09-02 01:19:47'),
('LEG-2', 2, 2, '2026-07-25 00:00:00', '2026-08-01 00:00:00', 'RETURNED', 0, 0.00, '2026-09-02 01:19:47'),
('LEG-3', 3, 3, '2026-07-20 00:00:00', '2026-07-27 00:00:00', 'OVERDUE', 51, 2550000.00, '2026-09-02 01:19:47'),
('LEG-4', 4, 4, '2026-07-29 00:00:00', '2026-08-05 00:00:00', 'OVERDUE', 42, 2100000.00, '2026-09-02 01:19:47'),
('LEG-5', 5, 5, '2026-07-30 00:00:00', '2026-08-06 00:00:00', 'OVERDUE', 41, 2050000.00, '2026-09-02 01:19:47');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengembalian`
--

CREATE TABLE `pengembalian` (
  `id_pengembalian` varchar(30) NOT NULL,
  `id_peminjaman` varchar(30) NOT NULL,
  `tanggal_kembali` datetime NOT NULL,
  `denda` decimal(12,2) NOT NULL DEFAULT 0.00,
  `late_days` int(11) NOT NULL DEFAULT 0,
  `status` enum('Dikembalikan','Terlambat') NOT NULL,
  `payment_status` enum('UNPAID','PAID','WAIVED') NOT NULL DEFAULT 'UNPAID',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `pengembalian`
--

INSERT INTO `pengembalian` (`id_pengembalian`, `id_peminjaman`, `tanggal_kembali`, `denda`, `late_days`, `status`, `payment_status`, `created_at`) VALUES
('KMB-LEG-2', 'LEG-2', '2026-07-30 00:00:00', 0.00, 0, 'Dikembalikan', 'PAID', '2026-09-02 01:19:47');

-- --------------------------------------------------------

--
-- Struktur dari tabel `reading_progress`
--

CREATE TABLE `reading_progress` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ebook_id` int(11) NOT NULL,
  `current_page` int(11) NOT NULL DEFAULT 1,
  `total_pages` int(11) NOT NULL DEFAULT 1,
  `last_read_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `reading_progress`
--

INSERT INTO `reading_progress` (`id`, `user_id`, `ebook_id`, `current_page`, `total_pages`, `last_read_at`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 150, 350, '2026-09-02 01:19:47', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(3, 3, 3, 85, 240, '2026-09-02 01:19:47', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(23, 7, 6, 3, 12, '2026-09-09 06:44:57', '2026-09-09 06:41:01', '2026-09-09 06:44:57');

-- --------------------------------------------------------

--
-- Struktur dari tabel `reservations`
--

CREATE TABLE `reservations` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `queue_number` int(11) NOT NULL,
  `status` enum('WAITING','NOTIFIED','FULFILLED','CANCELLED','EXPIRED') NOT NULL DEFAULT 'WAITING',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `notified_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `settings`
--

INSERT INTO `settings` (`id`, `setting_key`, `setting_value`, `description`, `updated_at`) VALUES
(1, 'library_name', 'Perpustakaan Digital SMA Negeri 1', 'Nama perpustakaan', '2026-09-02 01:19:47'),
(2, 'borrow_duration', '7', 'Durasi peminjaman dalam hari', '2026-09-02 01:19:47'),
(3, 'max_borrow', '3', 'Maksimal buku yang bisa dipinjam', '2026-09-02 01:19:47'),
(4, 'late_fine', '50000', 'Denda keterlambatan (Rp)', '2026-09-02 01:19:47'),
(5, 'library_address', 'Jl. Pendidikan No. 1, Jakarta', 'Alamat perpustakaan', '2026-09-02 01:19:47'),
(6, 'library_phone', '021-1234567', 'Nomor telepon perpustakaan', '2026-09-02 01:19:47'),
(7, 'library_email', 'perpustakaan@sman1.sch.id', 'Email perpustakaan', '2026-09-02 01:19:47');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `member_id` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','admin') NOT NULL DEFAULT 'student',
  `nis` varchar(20) DEFAULT NULL,
  `class` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `identity_type` enum('STUDENT_CARD','KTP') DEFAULT NULL,
  `identity_file` varchar(255) DEFAULT NULL,
  `identity_status` enum('PENDING','APPROVED','REJECTED') NOT NULL DEFAULT 'APPROVED',
  `identity_rejection_reason` varchar(500) DEFAULT NULL,
  `identity_verified_by` int(11) DEFAULT NULL,
  `identity_verified_at` datetime DEFAULT NULL,
  `status` enum('active','inactive','suspended') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `member_id`, `name`, `email`, `password`, `role`, `nis`, `class`, `phone`, `address`, `photo`, `identity_type`, `identity_file`, `identity_status`, `identity_rejection_reason`, `identity_verified_by`, `identity_verified_at`, `status`, `created_at`, `updated_at`) VALUES
(1, 'ADM-001', 'Ibu Sari Pustakawan', 'admin@perpustakaan.com', '$2a$10$sviG.AlHWab8OVALdRf4PujzX/BLmphTsdda1vZrNGxp3inCng0HW', 'admin', NULL, NULL, '08123456789', 'Jl. Perpustakaan No. 1', NULL, NULL, NULL, 'APPROVED', NULL, NULL, NULL, 'active', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(2, 'STD-001', 'Ahmad Rizki Pratama', 'siswa@perpustakaan.com', '$2a$10$3h3EYUJ5W46B79DDdtGMHOLbv.ctpAToTrLJ2HN53LRdskDwndI.m', 'student', '2024001', 'XII IPA 1', '08234567890', 'Jl. Siswa No. 10', NULL, NULL, NULL, 'APPROVED', NULL, NULL, NULL, 'active', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(3, 'STD-002', 'Siti Nurhaliza', 'siti@perpustakaan.com', '$2a$10$3h3EYUJ5W46B79DDdtGMHOLbv.ctpAToTrLJ2HN53LRdskDwndI.m', 'student', '2024002', 'XII IPA 2', '08345678901', 'Jl. Melati No. 5', NULL, NULL, NULL, 'APPROVED', NULL, NULL, NULL, 'active', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(4, 'STD-003', 'Budi Santoso', 'budi@perpustakaan.com', '$2a$10$3h3EYUJ5W46B79DDdtGMHOLbv.ctpAToTrLJ2HN53LRdskDwndI.m', 'student', '2024003', 'XI IPS 1', '08456789012', 'Jl. Mawar No. 3', NULL, NULL, NULL, 'APPROVED', NULL, NULL, NULL, 'active', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(5, 'STD-004', 'Dewi Anggraini', 'dewi@perpustakaan.com', '$2a$10$3h3EYUJ5W46B79DDdtGMHOLbv.ctpAToTrLJ2HN53LRdskDwndI.m', 'student', '2024004', 'XI IPA 1', '08567890123', 'Jl. Kenanga No. 8', NULL, NULL, NULL, 'APPROVED', NULL, NULL, NULL, 'active', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(6, 'STD-005', 'Reza Mahendra', 'reza@perpustakaan.com', '$2a$10$3h3EYUJ5W46B79DDdtGMHOLbv.ctpAToTrLJ2HN53LRdskDwndI.m', 'student', '2024005', 'X IPA 1', '08678901234', 'Jl. Dahlia No. 12', NULL, NULL, NULL, 'APPROVED', NULL, NULL, NULL, 'active', '2026-09-02 01:19:47', '2026-09-02 01:19:47'),
(7, 'STD-540219', 'abdul manaf', 'abdul@gmail.com', '$2a$12$u1fbeI/ty7fn/Gy0pAg4CO.shhl5EEytBtxcswWW7Xp9mwg.1VAgu', 'student', '00931246', 'xii rpl 3', NULL, NULL, NULL, 'STUDENT_CARD', 'identity-1788935540220-75f06616910548bb9570e273.jpg', 'APPROVED', NULL, 1, '2026-09-09 13:37:58', 'active', '2026-09-09 06:32:20', '2026-09-09 06:37:58'),
(8, 'STD-683867', 'abdul manaf', 'abdul2@gmail.com', '$2a$12$BJ00n7KdB3uqFh1CjRG4QeEt8ZQRIt/dgtuPU/2LwZmdbDVRQ3Suy', 'student', '00931246', 'xii rpl 3', NULL, NULL, NULL, 'STUDENT_CARD', 'identity-1789446683867-5e9e5c33e4b4fc13a0e522a6.jpg', 'PENDING', NULL, NULL, NULL, 'inactive', '2026-09-15 04:31:24', '2026-09-15 04:31:24');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_action` (`action`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indeks untuk tabel `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `target_user_id` (`target_user_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_announcement_active` (`status`,`start_date`,`end_date`),
  ADD KEY `idx_announcement_target` (`target`,`target_user_id`);

--
-- Indeks untuk tabel `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_name` (`name`);

--
-- Indeks untuk tabel `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_ebook_page` (`user_id`,`ebook_id`,`page_number`),
  ADD KEY `ebook_id` (`ebook_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indeks untuk tabel `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_isbn` (`isbn`),
  ADD KEY `idx_title` (`title`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_author` (`author_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indeks untuk tabel `book_copies`
--
ALTER TABLE `book_copies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `copy_code` (`copy_code`),
  ADD KEY `idx_copy_book_status` (`book_id`,`status`),
  ADD KEY `idx_copy_updated` (`updated_at`);

--
-- Indeks untuk tabel `book_copy_history`
--
ALTER TABLE `book_copy_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `changed_by` (`changed_by`),
  ADD KEY `idx_copy_history` (`copy_id`,`created_at`),
  ADD KEY `idx_copy_history_transaction` (`id_peminjaman`);

--
-- Indeks untuk tabel `book_reviews`
--
ALTER TABLE `book_reviews`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_review_user_book` (`user_id`,`book_id`),
  ADD KEY `moderated_by` (`moderated_by`),
  ADD KEY `idx_review_book_status` (`book_id`,`status`);

--
-- Indeks untuk tabel `borrowings`
--
ALTER TABLE `borrowings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaction_id` (`transaction_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_book` (`book_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_borrow_date` (`borrow_date`),
  ADD KEY `idx_due_date` (`due_date`);

--
-- Indeks untuk tabel `borrowing_copies`
--
ALTER TABLE `borrowing_copies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_borrowing_copy` (`id_detail`,`copy_id`),
  ADD KEY `idx_borrowing_copy_id` (`copy_id`);

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_name` (`name`);

--
-- Indeks untuk tabel `detail_peminjaman`
--
ALTER TABLE `detail_peminjaman`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_peminjaman` (`id_peminjaman`),
  ADD KEY `idx_detail_peminjaman_buku` (`id_buku`);

--
-- Indeks untuk tabel `ebooks`
--
ALTER TABLE `ebooks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `idx_title` (`title`),
  ADD KEY `idx_status` (`status`);

--
-- Indeks untuk tabel `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_book` (`user_id`,`book_id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indeks untuk tabel `fine_payments`
--
ALTER TABLE `fine_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recorded_by` (`recorded_by`),
  ADD KEY `idx_fine_payment_return` (`id_pengembalian`,`created_at`);

--
-- Indeks untuk tabel `laporan`
--
ALTER TABLE `laporan`
  ADD PRIMARY KEY (`id_laporan`),
  ADD KEY `id_admin` (`id_admin`);

--
-- Indeks untuk tabel `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_read` (`is_read`),
  ADD KEY `idx_type` (`type`);

--
-- Indeks untuk tabel `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_password_reset_token` (`token`),
  ADD KEY `idx_password_reset_user` (`user_id`);

--
-- Indeks untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`),
  ADD UNIQUE KEY `legacy_borrowing_id` (`legacy_borrowing_id`),
  ADD KEY `idx_peminjaman_anggota_status` (`id_anggota`,`status`),
  ADD KEY `idx_peminjaman_tanggal` (`tanggal_pinjam`,`tanggal_jatuh_tempo`);

--
-- Indeks untuk tabel `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD PRIMARY KEY (`id_pengembalian`),
  ADD UNIQUE KEY `id_peminjaman` (`id_peminjaman`);

--
-- Indeks untuk tabel `reading_progress`
--
ALTER TABLE `reading_progress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_ebook` (`user_id`,`ebook_id`),
  ADD KEY `ebook_id` (`ebook_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indeks untuk tabel `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_reservation_queue` (`book_id`,`status`,`queue_number`),
  ADD KEY `idx_reservation_user` (`user_id`,`status`),
  ADD KEY `idx_reservation_expiry` (`status`,`expires_at`);

--
-- Indeks untuk tabel `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `member_id` (`member_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_role` (`role`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_nis` (`nis`),
  ADD KEY `fk_users_identity_verifier` (`identity_verified_by`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT untuk tabel `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `authors`
--
ALTER TABLE `authors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT untuk tabel `book_copies`
--
ALTER TABLE `book_copies`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT untuk tabel `book_copy_history`
--
ALTER TABLE `book_copy_history`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `book_reviews`
--
ALTER TABLE `book_reviews`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `borrowings`
--
ALTER TABLE `borrowings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `borrowing_copies`
--
ALTER TABLE `borrowing_copies`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `detail_peminjaman`
--
ALTER TABLE `detail_peminjaman`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `ebooks`
--
ALTER TABLE `ebooks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `fine_payments`
--
ALTER TABLE `fine_payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `reading_progress`
--
ALTER TABLE `reading_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT untuk tabel `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `announcements_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `bookmarks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookmarks_ibfk_2` FOREIGN KEY (`ebook_id`) REFERENCES `ebooks` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `books_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `book_copies`
--
ALTER TABLE `book_copies`
  ADD CONSTRAINT `book_copies_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

--
-- Ketidakleluasaan untuk tabel `book_copy_history`
--
ALTER TABLE `book_copy_history`
  ADD CONSTRAINT `book_copy_history_ibfk_1` FOREIGN KEY (`copy_id`) REFERENCES `book_copies` (`id`),
  ADD CONSTRAINT `book_copy_history_ibfk_2` FOREIGN KEY (`id_peminjaman`) REFERENCES `peminjaman` (`id_peminjaman`) ON DELETE SET NULL,
  ADD CONSTRAINT `book_copy_history_ibfk_3` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `book_reviews`
--
ALTER TABLE `book_reviews`
  ADD CONSTRAINT `book_reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `book_reviews_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `book_reviews_ibfk_3` FOREIGN KEY (`moderated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `borrowings`
--
ALTER TABLE `borrowings`
  ADD CONSTRAINT `borrowings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `borrowings_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `borrowing_copies`
--
ALTER TABLE `borrowing_copies`
  ADD CONSTRAINT `borrowing_copies_ibfk_1` FOREIGN KEY (`id_detail`) REFERENCES `detail_peminjaman` (`id_detail`),
  ADD CONSTRAINT `borrowing_copies_ibfk_2` FOREIGN KEY (`copy_id`) REFERENCES `book_copies` (`id`);

--
-- Ketidakleluasaan untuk tabel `detail_peminjaman`
--
ALTER TABLE `detail_peminjaman`
  ADD CONSTRAINT `detail_peminjaman_ibfk_1` FOREIGN KEY (`id_peminjaman`) REFERENCES `peminjaman` (`id_peminjaman`),
  ADD CONSTRAINT `detail_peminjaman_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `books` (`id`);

--
-- Ketidakleluasaan untuk tabel `ebooks`
--
ALTER TABLE `ebooks`
  ADD CONSTRAINT `ebooks_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `fine_payments`
--
ALTER TABLE `fine_payments`
  ADD CONSTRAINT `fine_payments_ibfk_1` FOREIGN KEY (`id_pengembalian`) REFERENCES `pengembalian` (`id_pengembalian`),
  ADD CONSTRAINT `fine_payments_ibfk_2` FOREIGN KEY (`recorded_by`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `laporan`
--
ALTER TABLE `laporan`
  ADD CONSTRAINT `laporan_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `password_resets`
--
ALTER TABLE `password_resets`
  ADD CONSTRAINT `password_resets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`id_anggota`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD CONSTRAINT `pengembalian_ibfk_1` FOREIGN KEY (`id_peminjaman`) REFERENCES `peminjaman` (`id_peminjaman`);

--
-- Ketidakleluasaan untuk tabel `reading_progress`
--
ALTER TABLE `reading_progress`
  ADD CONSTRAINT `reading_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reading_progress_ibfk_2` FOREIGN KEY (`ebook_id`) REFERENCES `ebooks` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_identity_verifier` FOREIGN KEY (`identity_verified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
