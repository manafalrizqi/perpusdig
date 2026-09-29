import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { config } from '../config/env';
import { pool } from '../config/database';
import { AppError } from './errorHandler';
import { RowDataPacket } from 'mysql2';

export interface AuthRequest extends Request {
  user?: {
    id: number;
    member_id: string;
    name: string;
    email: string;
    role: string;
    nis?: string | null;
    class?: string | null;
    phone?: string | null;
    address?: string | null;
    photo?: string | null;
    status: string;
  };
}

export function authenticate(req: AuthRequest, res: Response, next: NextFunction) {
  try {
    const authHeader = req.headers.authorization;
    const token = authHeader?.startsWith('Bearer ') ? authHeader.slice(7) : null;

    if (!token) {
      throw new AppError('Akses ditolak. Silakan login terlebih dahulu.', 401);
    }

    const decoded = jwt.verify(token, config.jwt.secret) as any;

    pool.execute<RowDataPacket[]>(
      'SELECT id,member_id,name,email,role,nis,class,phone,address,photo,status FROM users WHERE id = ?',
      [decoded.id]
    ).then(([rows]) => {
      if (rows.length === 0) {
        return next(new AppError('User tidak ditemukan.', 401));
      }
      const row = rows[0];
      if (row.status !== 'active') {
        return next(new AppError('Akun Anda tidak aktif.', 403));
      }
      req.user = {
        id: row.id,
        member_id: row.member_id,
        name: row.name,
        email: row.email,
        role: row.role,
        nis: row.nis,
        class: row.class,
        phone: row.phone,
        address: row.address,
        photo: row.photo,
        status: row.status,
      };
      next();
    }).catch(next);
  } catch (err: any) {
    if (err.name === 'JsonWebTokenError') {
      return next(new AppError('Token tidak valid.', 401));
    }
    if (err.name === 'TokenExpiredError') {
      return next(new AppError('Token telah kedaluwarsa. Silakan login kembali.', 401));
    }
    next(err);
  }
}

export function authorize(...roles: string[]) {
  return (req: AuthRequest, res: Response, next: NextFunction) => {
    if (!req.user) {
      return next(new AppError('Akses ditolak. Silakan login terlebih dahulu.', 401));
    }
    if (!roles.includes(req.user.role)) {
      return next(new AppError('Anda tidak memiliki akses ke resource ini.', 403));
    }
    next();
  };
}
