# Perpustakaan Digital

Sistem terdiri dari API Express/MySQL di `backend` dan aplikasi Next.js di `frontend`.

## Menjalankan lokal

1. Instalasi baru: impor `database/schema.sql`, lalu `database/seeds/seed.sql`. Migration di `database/migrations` hanya untuk database lama yang belum memakai schema terbaru.
2. Salin `backend/.env.example` menjadi `backend/.env`, isi `JWT_SECRET` acak minimal 32 karakter, dan sesuaikan koneksi MySQL.
3. Jalankan `npm install` di `backend` dan `frontend`.
4. Jalankan API dengan `npm run dev` dari `backend`.
5. Jalankan Next.js dengan `npm run dev` dari `frontend`.

API menyediakan `/api/health` untuk liveness dan `/api/ready` untuk memastikan MySQL dapat diakses.

Environment backend yang tersedia: `PORT`, `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`, `JWT_SECRET`, `JWT_EXPIRES_IN`, `CORS_ORIGIN`, `UPLOAD_DIR`, dan `PRIVATE_UPLOAD_DIR`. Frontend memakai `NEXT_PUBLIC_API_URL`.

## Pemeriksaan

- Backend: `npm run build` dan `npm test`.
- Frontend: `npm run lint`, `npx tsc --noEmit`, dan `npm run build`.
- Integration test wajib memakai database yang namanya berakhiran `_test`; jalankan dengan `npm run test:integration` setelah database test disiapkan.

Jangan menaruh file identitas atau kredensial production ke repository. Folder `private_uploads` hanya dilayani lewat endpoint terautentikasi.
