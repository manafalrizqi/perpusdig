import { createHash } from 'node:crypto';

export const PASSWORD_MESSAGE = 'Kata sandi minimal 8 karakter dan harus memuat huruf serta angka.';
export const passwordIsStrong = (value: string) => value.length >= 8 && /[A-Za-z]/.test(value) && /\d/.test(value);
export const hashToken = (token: string) => createHash('sha256').update(token).digest('hex');

export function fileMatchesContent(file: Buffer, extension: string) {
  const hex = file.subarray(0, 12).toString('hex');
  switch (extension.toLowerCase()) {
    case '.jpg': case '.jpeg': return file.length > 100 && hex.startsWith('ffd8ff');
    case '.png': return file.length > 24 && hex.startsWith('89504e470d0a1a0a');
    case '.gif': return file.length > 13 && (file.subarray(0, 6).toString('ascii') === 'GIF87a' || file.subarray(0, 6).toString('ascii') === 'GIF89a');
    case '.webp': return file.length > 12 && file.subarray(0, 4).toString('ascii') === 'RIFF' && file.subarray(8, 12).toString('ascii') === 'WEBP';
    case '.pdf': return file.subarray(0, 5).toString('ascii') === '%PDF-';
    case '.epub': return hex.startsWith('504b0304') && file.subarray(0, 256).includes(Buffer.from('application/epub+zip'));
    default: return false;
  }
}
