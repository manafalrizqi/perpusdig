# Prompt UI untuk Sidebar Dashboard Perpustakaan (Admin & Siswa)

Gunakan prompt di bawah ini untuk meminta AI (seperti v0.dev, Claude, ChatGPT, atau Bolt.new) membuatkan sidebar yang mendukung dua *role* (Admin dan Siswa). Prompt menggunakan bahasa Inggris agar hasilnya lebih maksimal.

## 🇬🇧 Prompt (Copy teks di bawah ini):

```text
Create a modern, clean sidebar for a library management system using HTML and Tailwind CSS (or standard CSS).

The sidebar must support two view states (expanded and collapsed) and accommodate two different user roles: Admin (Pustakawan) and Student (Siswa). Please provide the code with clear comments on where to toggle or inject the menus based on the user's role.

1.  **User Profile Section (Top):**
    *   Show a circular user avatar, the user's name, and their role.
    *   Admin Example: "Ibu Sari" as "Pustakawan".
    *   Student Example: "Budi" as "Siswa".
    *   In the collapsed state, hide the name and role, showing ONLY the circular avatar centered.

2.  **Navigation Links (Grouped with Icons):**
    Categorize the links using small, muted, uppercase section headers. EVERY single link MUST have a relevant minimal icon (e.g., Lucide, Heroicons, or FontAwesome). Do NOT just use letters.

    *   **MENU VIEW 1 (ADMIN / PUSTAKAWAN):**
        *   MAIN: Dashboard
        *   CATALOG: Buku, Inventory, Kategori, E-Book
        *   CIRCULATION: Peminjaman, Pengembalian, Reservasi, Denda
        *   USERS: Anggota
        *   SYSTEM: Laporan, Riwayat Bulanan, Pengaturan, Activity Log

    *   **MENU VIEW 2 (STUDENT / SISWA):**
        *   MAIN: Dashboard
        *   COLLECTION: Katalog Buku, E-Book, Bookmark
        *   MY ACTIVITY: Peminjaman Saya, Riwayat Baca, Tanggungan Denda
        *   ACCOUNT: Profil Saya

3.  **Styling & Active State:**
    *   Add adequate spacing/gap between groups so it doesn't look cramped.
    *   The active menu item should have a distinct, soft background color (like a soft sage green or light gray) with rounded-md corners, and the icon/text color should be highlighted.

4.  **Collapsed State Behavior (Crucial):**
    *   When the sidebar is collapsed, completely hide all text labels and the uppercase category headers (`display: none` or similar).
    *   Keep only the icons, and align them to the center of the collapsed sidebar.
    *   Add a hover tooltip for each icon in the collapsed state so the user knows what the icon means.
```

## 💡 Info Tambahan buat Lu
*   Gue udah nambahin dua skema menu di dalam prompt-nya: satu buat **Admin**, satu lagi menu yang disederhanakan khusus buat **Siswa**. 
*   Menu siswa fokus ke hal-hal pribadi kayak "Peminjaman Saya", "Tanggungan Denda", dan "Katalog". Jadi AI-nya bakal buatin *layout* yang gampang lu modifikasi (misal pakai `if-else` di PHP atau JS lu untuk nampilin menu sesuai *role* yang lagi login).
