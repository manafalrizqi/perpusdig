import dotenv from 'dotenv';
dotenv.config();

const jwtSecret = process.env.JWT_SECRET;
if (!jwtSecret || jwtSecret.length < 32 || jwtSecret === 'default-secret-change-me') {
  throw new Error('JWT_SECRET wajib diisi dengan nilai acak minimal 32 karakter.');
}

export const config = {
  port: parseInt(process.env.PORT || '5000'),
  db: {
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '3306'),
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'perpustakaan_digital',
  },
  jwt: {
    secret: jwtSecret,
    expiresIn: process.env.JWT_EXPIRES_IN || '7d',
  },
  cors: {
    origin: process.env.CORS_ORIGIN || 'http://localhost:3000',
  },
  uploadDir: process.env.UPLOAD_DIR || 'uploads',
  privateUploadDir: process.env.PRIVATE_UPLOAD_DIR || 'private_uploads',
};
