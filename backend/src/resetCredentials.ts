import bcrypt from 'bcryptjs';
import { pool } from './config/database';

async function resetCredentials() {
  const adminPassword = await bcrypt.hash('admin123', 12);
  const studentPassword = await bcrypt.hash('siswa123', 12);
  await pool.execute(
    `INSERT INTO users (member_id, name, email, password, role, status)
     VALUES (?, ?, ?, ?, 'admin', 'active')
     ON DUPLICATE KEY UPDATE password = VALUES(password), status = 'active', role = 'admin'`,
    ['ADM-001', 'Ibu Sari Pustakawan', 'admin@perpustakaan.com', adminPassword]
  );
  await pool.execute('UPDATE users SET password = ? WHERE role = ?', [studentPassword, 'student']);
  console.log('Kredensial berhasil direset.');
  await pool.end();
}

resetCredentials().catch((error) => {
  console.error(error.message);
  process.exit(1);
});
