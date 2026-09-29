# Plan Redesign UI/UX Perpustakaan Digital

Tanggal: 26 Agustus 2026  
Status: usulan redesign tanpa mengubah fitur, backend, atau stack existing.

## 1. Diagnosis Singkat

UI sekarang sudah rapi dan fungsional, tetapi masih terasa seperti dashboard CRUD standar. Penyebab utamanya:

- Hampir seluruh halaman memakai pola card putih, border, radius, dan shadow yang sama.
- Warna biru–teal dan gradient digunakan berulang sehingga semua bagian terasa mirip.
- Banyak statistik mempunyai bobot visual yang sama; pengguna tidak tahu mana yang paling penting.
- Landing page, dashboard siswa, dan dashboard admin belum mempunyai karakter visual yang berbeda.
- Cover buku belum menjadi elemen utama meskipun produk ini berpusat pada buku.
- Beberapa daftar masih menggunakan placeholder cover berupa blok gradient.
- Row data digunakan untuk hampir semua jenis konten sehingga tampilan cepat terasa monoton.
- Label uppercase seperti `OVERVIEW`, `TRANSAKSI`, dan `PUSAT NOTIFIKASI` terlalu sering digunakan.
- Sidebar, hero gradient, stat card, dan tabel membentuk ritme yang sama pada setiap halaman.
- Empty state, loading state, serta modal sudah ada, tetapi belum terasa seperti bagian dari identitas produk.

Kesimpulan: UI tidak perlu dibuat lebih ramai. UI perlu mempunyai **hirarki, variasi komposisi, cover buku asli, whitespace, dan karakter visual yang konsisten**.

## 2. Arah Visual

### Konsep: Modern Editorial Library

Nuansanya seperti perpustakaan modern yang tenang, hangat, dan terpercaya—bukan aplikasi fintech atau template SaaS.

Karakter:

- Hangat dan editorial.
- Banyak ruang kosong.
- Tipografi judul berkarakter.
- Cover buku menjadi sumber warna utama.
- Data operasional tetap bersih dan mudah dipindai.
- Dekorasi menggunakan tekstur kertas sangat halus, bukan gradient besar di setiap bagian.

### Palette yang disarankan

| Peran | Warna |
|---|---|
| Latar utama | `#F4F1EA` — warm paper |
| Surface | `#FCFBF7` |
| Teks utama | `#17231E` — deep ink |
| Teks sekunder | `#68736D` |
| Accent utama | `#245D4A` — library green |
| Accent hover | `#194536` |
| Border | `#DDD9CF` |
| Danger | `#A8423A` |
| Warning | `#A96F1F` |
| Success | `#2F735B` |

Gunakan hijau sebagai satu-satunya accent brand. Merah, kuning, dan hijau terang hanya digunakan untuk status, bukan dekorasi.

### Tipografi

- Judul besar/marketing: serif editorial seperti `Fraunces` atau `Lora`.
- UI, form, tabel, dan body: `Geist` atau sans-serif existing yang bersih.
- Angka dashboard: gunakan `font-variant-numeric: tabular-nums`.
- Kurangi uppercase. Gunakan sentence case untuk sebagian besar heading.
- Judul hero maksimal 2–3 baris dan gunakan `text-wrap: balance`.

### Shape dan surface

- Radius besar hanya untuk hero atau panel utama.
- Radius medium untuk card buku.
- Radius kecil untuk input, badge, dan tombol.
- Jangan memberi shadow pada semua elemen.
- Gunakan border atau perbedaan warna surface sebagai pengganti shadow.
- Shadow hanya untuk elemen yang benar-benar mengambang: dropdown, modal, dan sticky action.

## 3. Perubahan Struktur per Area

### 3.1 Landing page

Masalah sekarang: hero masih mengikuti pola teks kiri, gambar kanan, lalu section card yang seragam.

Redesign:

1. Buat hero editorial asimetris.
   - Judul besar di kiri dengan serif.
   - Search menjadi elemen utama, bukan tombol tambahan.
   - Gunakan satu foto/ilustrasi perpustakaan yang kuat di sisi kanan.
   - Tambahkan tumpukan 2–3 cover buku yang sedikit overlap.
2. Ganti statistik menjadi satu strip tipis di bawah hero.
3. Bagian buku terbaru menggunakan rak horizontal dengan cover tinggi, bukan card putih penuh.
4. Tambahkan section “Sedang banyak dibaca” dengan satu buku unggulan besar dan daftar kecil di samping.
5. Kategori ditampilkan sebagai text links atau poster-like tiles, bukan kumpulan pill seragam.
6. CTA terakhir dibuat seperti kartu anggota perpustakaan, bukan gradient banner biasa.
7. Footer dibuat sederhana: identitas, alamat, jam layanan, kontak, dan link penting.

Hasil yang diharapkan: landing page langsung terasa sebagai produk perpustakaan, bukan landing page SaaS.

### 3.2 Login, register, dan reset password

Redesign:

- Gunakan split layout desktop: panel visual perpustakaan dan panel form.
- Mobile hanya menampilkan form agar tetap ringan.
- Tambahkan identitas perpustakaan dan satu kutipan pendek, bukan ilustrasi dekoratif berlebihan.
- Kurangi shadow card dan gunakan layout yang lebih lapang.
- Password strength ditampilkan dengan teks singkat.
- Error ditampilkan dekat field terkait.
- Success reset password memiliki satu CTA yang jelas menuju login.

### 3.3 Area siswa

Area siswa harus terasa seperti ruang baca personal, bukan admin versi berbeda.

#### Navigasi

- Desktop: gunakan top navigation dengan pencarian global, profil, dan notifikasi.
- Mobile: gunakan bottom navigation untuk Beranda, Katalog, Pinjaman, Favorit, dan Profil.
- Menu sekunder seperti bookmark, review, dan reservasi dapat masuk ke halaman profil/menu tambahan.

#### Dashboard siswa

- Fokus utama: “Lanjut membaca” atau “Pinjaman terdekat jatuh tempo”.
- Gunakan satu panel utama besar, bukan hero gradient generik.
- Statistik kecil cukup 3 item: pinjaman aktif, jatuh tempo, dan reservasi.
- Buku rekomendasi menggunakan cover asli dan horizontal scroll.
- Pengumuman tampil seperti notice perpustakaan, bukan stat card.
- Aktivitas terbaru cukup berupa timeline pendek.

#### Katalog

- Search bar dibuat sticky di atas katalog.
- Filter desktop berada pada side panel ringan.
- Filter mobile menggunakan bottom sheet.
- Filter aktif ditampilkan sebagai chips yang dapat dihapus.
- Card buku berisi cover dominan, judul, penulis, rating, dan satu status stok.
- Aksi pinjam/favorit muncul pada hover desktop atau tetap ringkas di mobile.
- Gunakan ukuran card yang sedikit bervariasi untuk buku unggulan, tanpa membuat masonry yang sulit dipindai.

#### Detail buku

- Cover besar di kiri dengan warna latar yang mengambil nuansa cover.
- Judul, penulis, rating, dan status menjadi kelompok utama.
- Tombol `Pinjam`, `Reservasi`, atau `Baca e-book` menjadi sticky action pada mobile.
- Metadata seperti ISBN, penerbit, dan tahun ditempatkan dalam bagian “Detail buku” yang lebih tenang.
- Review ditampilkan sebagai kutipan pembaca, bukan row tabel.
- Status copy hilang/rusak tidak perlu menjadi fokus siswa; tampilkan hanya informasi ketersediaan yang relevan.

#### Peminjaman

- Ringkas proses lima langkah menjadi maksimal tiga bagian visual:
  1. Buku dan ketersediaan.
  2. Durasi serta aturan.
  3. Konfirmasi dan hasil.
- Stepper tetap ada tetapi lebih ringan.
- Preview cover asli selalu terlihat.
- Success state menggunakan receipt/transaksi yang mudah disimpan atau dicetak.

#### E-book reader

- Toolbar dibuat floating dan dapat disembunyikan.
- Navigasi halaman, zoom, bookmark, dan fullscreen dikelompokkan berdasarkan fungsi.
- Progress tampil tipis di bagian atas/bawah reader.
- Gunakan mode fokus dengan background netral gelap atau hangat.

### 3.4 Area admin

Admin tetap memakai sidebar karena jumlah menu cukup banyak, tetapi tampilannya dibuat lebih ringkas dan profesional.

#### Navigasi admin

- Sidebar dapat collapse menjadi icon rail.
- Kelompokkan menu:
  - Ringkasan.
  - Koleksi.
  - Sirkulasi.
  - Komunitas.
  - Laporan dan sistem.
- Tampilkan label aktif yang kuat tanpa gradient.
- Profil admin dan logout ditempatkan di bagian bawah.

#### Dashboard admin

- Hilangkan hero gradient besar; admin membutuhkan informasi, bukan marketing.
- Header berisi tanggal, pencarian cepat, notifikasi, dan action penting.
- Prioritas pertama adalah alert operasional:
  - Buku terlambat.
  - Reservasi menunggu.
  - Denda belum dibayar.
  - Copy hilang/rusak.
- Tampilkan maksimal empat KPI utama pada layar pertama.
- KPI lain masuk ke bagian detail, bukan semua menjadi stat card.
- Gunakan satu chart utama dan satu daftar aktivitas, bukan banyak chart dengan bobot sama.

#### Halaman data

- Gunakan tabel semantik di desktop dan card list di mobile.
- Header tabel sticky.
- Search, filter, sort, dan bulk action berada dalam satu toolbar yang jelas.
- Action sekunder masuk ke menu `•••` agar row tidak penuh tombol.
- Status memiliki warna dan label Indonesia yang konsisten.
- Klik row membuka detail drawer; modal hanya untuk konfirmasi atau form singkat.
- Form tambah/edit kompleks menggunakan side panel agar konteks daftar tetap terlihat.

#### Inventory dan QR

- Copy ID, judul, lokasi, status, dan peminjam mempunyai kolom tetap.
- Scanner menjadi primary action pada halaman inventory.
- QR preview menggunakan layout label cetak yang nyata.
- Status copy menggunakan icon kecil dan teks; jangan mengandalkan warna saja.

#### Reports

- Pisahkan filter laporan dari hasil.
- Tampilkan ringkasan 2–4 metrik sesuai jenis laporan.
- Gunakan visual yang tepat: bar untuk perbandingan, line untuk tren, tabel untuk detail.
- Tombol ekspor ditempatkan dekat judul hasil, bukan bercampur dengan semua filter.

## 4. Motion dan Interaksi

Motion harus membuat UI terasa responsif, bukan menjadi hiasan.

- Hover card: `translateY(-2px)` maksimal, 180–220 ms.
- Button press: `scale(0.98)` selama 100–140 ms.
- Dropdown/modal: opacity dan translate pendek, 180–240 ms.
- Sidebar collapse: 220–280 ms.
- Skeleton mengikuti bentuk card, cover, dan tabel sebenarnya.
- Tambahkan stagger sangat ringan hanya pada kumpulan buku saat pertama dimuat.
- Hormati `prefers-reduced-motion`.
- Hindari parallax, smooth-scroll library, cursor effect, dan animasi terus-menerus.

## 5. Design System Minimum

Buat sistem kecil yang cukup untuk menjaga konsistensi:

### Tokens

- Color.
- Type scale.
- Spacing: `4, 8, 12, 16, 24, 32, 48, 64`.
- Radius: `6, 10, 16, 24`.
- Shadow: `none`, `floating`, dan `modal` saja.
- Motion duration dan easing.

### Komponen utama

- Button: primary, secondary, text, danger.
- Input, select, textarea, search.
- Badge/status.
- Book cover/card.
- Stat/KPI.
- Empty, loading, error, dan success state.
- Modal, drawer, dropdown, toast.
- Desktop table dan mobile data card.

Tidak perlu menambah library UI baru sebelum komponen existing terbukti tidak cukup.

## 6. Fase Implementasi

### Fase 1 — Visual foundation

- [ ] Tetapkan palette, typography, spacing, radius, shadow, dan motion tokens.
- [ ] Ganti font dan perbaiki type scale.
- [ ] Hilangkan gradient, border, dan shadow yang berlebihan.
- [ ] Buat button, input, badge, card, dan focus state konsisten.
- [ ] Buat mapping status backend ke label Indonesia.

Target: perubahan kecil di foundation langsung membuat seluruh aplikasi terasa berbeda.

### Fase 2 — Landing dan authentication

- [ ] Redesign landing hero editorial.
- [ ] Gunakan cover buku asli pada koleksi.
- [ ] Buat section buku terbaru dan populer dengan komposisi berbeda.
- [ ] Redesign login/register menjadi split layout.
- [ ] Rapikan footer dan metadata halaman.

Target: first impression tidak lagi terasa seperti template.

### Fase 3 — Student experience

- [ ] Ubah navigasi siswa menjadi top navigation dan bottom navigation mobile.
- [ ] Redesign dashboard dengan fokus pada lanjut membaca dan jatuh tempo.
- [ ] Redesign katalog, filter, card buku, dan detail buku.
- [ ] Ringkas alur peminjaman.
- [ ] Poles reader, favorite, bookmark, reservasi, dan review.

Target: area siswa terasa personal, visual, dan menyenangkan untuk menjelajah buku.

### Fase 4 — Admin experience

- [ ] Kelompokkan dan rapikan sidebar admin.
- [ ] Redesign dashboard menjadi command center operasional.
- [ ] Standarkan toolbar, tabel, filter, status, dan row actions.
- [ ] Gunakan drawer untuk detail dan form panjang.
- [ ] Poles inventory, scanner, laporan, dan pengaturan.

Target: admin dapat menemukan masalah dan menyelesaikan tugas dengan lebih sedikit klik.

### Fase 5 — States, accessibility, dan QA

- [ ] Buat skeleton spesifik untuk katalog, dashboard, dan tabel.
- [ ] Buat empty state yang relevan dengan action berikutnya.
- [ ] Perbaiki dialog semantics, focus trap, Escape, dan focus restoration.
- [ ] Tambahkan label pada semua icon button.
- [ ] Uji kontras, keyboard, zoom 200%, dan reduced motion.
- [ ] Uji pada lebar 360, 768, 1024, 1440, dan 1920 px.
- [ ] Jalankan lint, type-check, build, serta smoke test semua alur utama.

## 7. Prioritas Berdasarkan Dampak

| Prioritas | Perubahan | Dampak |
|---|---|---|
| P0 | Font, palette, spacing, cover buku asli | Perubahan visual terbesar |
| P0 | Dashboard siswa dan katalog | Area yang paling sering dilihat siswa |
| P1 | Landing dan authentication | First impression |
| P1 | Dashboard dan tabel admin | Efisiensi operasional |
| P1 | Status, loading, empty, dan error state | Rasa produk yang matang |
| P2 | Drawer, sidebar collapse, dan responsive detail | Kenyamanan penggunaan |
| P2 | Motion halus | Polish setelah layout selesai |

## 8. Hal yang Sengaja Tidak Disarankan

- Tidak mengganti Next.js, React, atau CSS existing.
- Tidak menambahkan dark mode sebelum light mode selesai dan teruji.
- Tidak menggunakan banyak gradient atau glassmorphism.
- Tidak menambah animasi berat, parallax, atau smooth-scroll library.
- Tidak membuat semua elemen menjadi card.
- Tidak menambah icon library hanya untuk beberapa icon.
- Tidak mendesain ulang seluruh aplikasi dalam satu perubahan besar.

## 9. Definition of Done

Redesign dianggap selesai apabila:

- Landing, siswa, dan admin mempunyai karakter yang berbeda tetapi tetap satu brand.
- Cover buku asli tampil konsisten.
- Setiap layar mempunyai satu fokus utama yang jelas.
- Tidak semua konten dibungkus card putih dengan shadow.
- Navigasi mobile dapat dipakai nyaman dengan satu tangan.
- Status dapat dipahami tanpa membaca kode bahasa Inggris.
- Semua action utama mempunyai hover, pressed, focus, loading, success, dan error state.
- Modal dan navigasi dapat digunakan dengan keyboard.
- Tidak ada horizontal overflow pada lebar 360 px.
- Lint, type-check, dan production build tetap lulus.

