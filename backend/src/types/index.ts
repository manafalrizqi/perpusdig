export interface User {
  id: number;
  member_id: string;
  name: string;
  email: string;
  password?: string;
  role: 'student' | 'admin';
  nis?: string;
  class?: string;
  phone?: string;
  address?: string;
  photo?: string;
  status: 'active' | 'inactive' | 'suspended';
  created_at: Date;
  updated_at: Date;
}

export interface Book {
  id: number;
  title: string;
  author_id?: number;
  author_name: string;
  publisher?: string;
  isbn?: string;
  category_id?: number;
  category_name?: string;
  year?: number;
  description?: string;
  cover?: string;
  stock: number;
  available: number;
  status: 'available' | 'unavailable';
  created_at: Date;
  updated_at: Date;
}

export interface Category {
  id: number;
  name: string;
  description?: string;
  book_count?: number;
  created_at: Date;
  updated_at: Date;
}

export interface Author {
  id: number;
  name: string;
  bio?: string;
  photo?: string;
  book_count?: number;
  created_at: Date;
  updated_at: Date;
}

export interface Borrowing {
  id: number;
  transaction_id: string;
  user_id: number;
  book_id: number;
  borrow_date: string;
  due_date: string;
  return_date?: string;
  status: 'active' | 'returned' | 'late' | 'lost';
  notes?: string;
  user_name?: string;
  user_member_id?: string;
  book_title?: string;
  book_cover?: string;
  created_at: Date;
  updated_at: Date;
}

export interface Ebook {
  id: number;
  book_id?: number;
  title: string;
  author_name: string;
  description?: string;
  cover?: string;
  file_path?: string;
  file_size: number;
  total_pages: number;
  year?: number;
  status: 'active' | 'inactive';
  upload_date: Date;
  created_at: Date;
  updated_at: Date;
}

export interface Bookmark {
  id: number;
  user_id: number;
  ebook_id: number;
  page_number: number;
  title?: string;
  ebook_title?: string;
  created_at: Date;
}

export interface Favorite {
  id: number;
  user_id: number;
  book_id: number;
  book_title?: string;
  book_cover?: string;
  book_author?: string;
  created_at: Date;
}

export interface Notification {
  id: number;
  user_id: number;
  title: string;
  message: string;
  type: 'info' | 'warning' | 'success' | 'error' | 'borrow' | 'return' | 'due' | 'late';
  is_read: boolean;
  link?: string;
  created_at: Date;
}

export interface ActivityLog {
  id: number;
  user_id?: number;
  action: string;
  entity_type?: string;
  entity_id?: number;
  details?: string;
  ip_address?: string;
  user_name?: string;
  created_at: Date;
}

export interface ReadingProgress {
  id: number;
  user_id: number;
  ebook_id: number;
  current_page: number;
  total_pages: number;
  ebook_title?: string;
  ebook_cover?: string;
  last_read_at: Date;
  created_at: Date;
  updated_at: Date;
}

export interface Settings {
  id: number;
  setting_key: string;
  setting_value?: string;
  description?: string;
  updated_at: Date;
}
