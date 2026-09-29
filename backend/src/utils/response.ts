import { Response } from 'express';

export function sendSuccess(res: Response, data: any = null, message: string = 'Berhasil', statusCode: number = 200) {
  return res.status(statusCode).json({
    success: true,
    message,
    data,
  });
}

export function sendError(res: Response, message: string = 'Terjadi kesalahan', statusCode: number = 500, errors: any[] = []) {
  return res.status(statusCode).json({
    success: false,
    message,
    errors,
  });
}

export function sendPaginated(res: Response, data: any[], total: number, page: number, limit: number, message: string = 'Berhasil') {
  return res.status(200).json({
    success: true,
    message,
    data,
    total,
    page,
    limit,
    totalPages: Math.ceil(total / limit),
    pagination: { total, page, limit, totalPages: Math.ceil(total / limit) },
  });
}
