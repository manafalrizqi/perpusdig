import test from 'node:test';
import assert from 'node:assert/strict';
import bcrypt from 'bcryptjs';
import { AddressInfo } from 'node:net';
import { app } from './index';
import { pool, query } from './config/database';
import { ResultSetHeader, RowDataPacket } from 'mysql2';
import { unlink } from 'node:fs/promises';
import path from 'node:path';
import { config } from './config/env';

type ApiResponse<T>={success:boolean;message:string;data:T;pagination?:unknown};

test('flow utama terintegrasi: auth, CRUD, borrow, overdue, return, inventory, reservation, notification',async()=>{
  assert.match(config.db.database,/_test$/,'Integration test hanya boleh berjalan pada database berakhiran _test.');
  const suffix=Date.now();
  const adminEmail=`admin-test-${suffix}@example.test`;
  const studentEmail=`student-test-${suffix}@example.test`;
  const waitingEmail=`waiting-test-${suffix}@example.test`;
  const server=app.listen(0);
  await new Promise<void>(resolve=>server.once('listening',resolve));
  const base=`http://127.0.0.1:${(server.address() as AddressInfo).port}/api`;
  const created={users:[] as number[],books:[] as number[],categories:[] as number[],transactions:[] as string[],identities:[] as string[]};
  let uploadedPhoto='';

  async function request<T>(path:string,init:RequestInit={},token?:string){
    const response=await fetch(base+path,{...init,headers:{'Content-Type':'application/json',...(token?{Authorization:`Bearer ${token}`}:{})}});
    const body=await response.json() as ApiResponse<T>;
    if(!response.ok)throw new Error(`${response.status} ${body.message}`);
    return body;
  }

  try{
    const password=await bcrypt.hash('test12345',10);
    const admin=await query<ResultSetHeader>("INSERT INTO users(member_id,name,email,password,role,status) VALUES(?,?,?,?, 'admin','active')",[`ADM-T-${suffix}`,'Admin Integrasi',adminEmail,password]);
    created.users.push(admin.insertId);
    await query("INSERT INTO settings(setting_key,setting_value,description) VALUES ('late_fine','1000','test'),('borrow_duration','7','test'),('max_borrow','3','test') ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value)");

    const adminLogin=await request<{token:string}>('/auth/login',{method:'POST',body:JSON.stringify({email:adminEmail,password:'test12345'})});
    const adminToken=adminLogin.data.token;
    const missingToken=await fetch(`${base}/admin/dashboard`);assert.equal(missingToken.status,401,'endpoint admin harus menolak request tanpa token');
    const invalidIsbn=await fetch(`${base}/books/lookup?isbn=123`,{headers:{Authorization:`Bearer ${adminToken}`}});
    assert.equal(invalidIsbn.status,400,'lookup harus menolak ISBN yang tidak valid');
    const invalidIdentity=new FormData();invalidIdentity.set('name','Upload Invalid');invalidIdentity.set('email',`invalid-${suffix}@example.test`);invalidIdentity.set('password','test12345');invalidIdentity.set('identity_type','STUDENT_CARD');invalidIdentity.set('identity',new Blob(['not-an-image'],{type:'image/png'}),'identity.png');const invalidUpload=await fetch(`${base}/auth/register`,{method:'POST',body:invalidIdentity});assert.equal(invalidUpload.status,400,'upload identitas palsu harus ditolak');
    async function registerStudent(name:string,email:string,nis:string){const form=new FormData();form.set('name',name);form.set('email',email);form.set('password','test12345');form.set('nis',nis);form.set('identity_type','STUDENT_CARD');form.set('identity',new Blob([Buffer.concat([Buffer.from('89504e470d0a1a0a','hex'),Buffer.alloc(17)])],{type:'image/png'}),'identity.png');const response=await fetch(`${base}/auth/register`,{method:'POST',body:form});assert.equal(response.status,201);const user=(await query<RowDataPacket[]>('SELECT id,identity_file FROM users WHERE email=?',[email]))[0];created.users.push(user.id);created.identities.push(user.identity_file);await request(`/members/${user.id}/identity`,{method:'PUT',body:JSON.stringify({status:'APPROVED'})},adminToken);return request<{token:string;user:{id:number}}>('/auth/login',{method:'POST',body:JSON.stringify({email,password:'test12345'})})}
    const studentRegister=await registerStudent('Siswa Integrasi',studentEmail,`T-${suffix}`);
    const waitingRegister=await registerStudent('Siswa Antrean',waitingEmail,`W-${suffix}`);
    const studentAdminAccess=await fetch(`${base}/admin/dashboard`,{headers:{Authorization:`Bearer ${studentRegister.data.token}`}});assert.equal(studentAdminAccess.status,403,'siswa tidak boleh mengakses dashboard admin');
    const privateIdentity=await fetch(`${base}/members/${studentRegister.data.user.id}/identity`,{headers:{Authorization:`Bearer ${studentRegister.data.token}`}});assert.equal(privateIdentity.status,403,'siswa tidak boleh membuka dokumen identitas anggota');
    const adminIdentity=await fetch(`${base}/members/${studentRegister.data.user.id}/identity`,{headers:{Authorization:`Bearer ${adminToken}`}});assert.equal(adminIdentity.status,200,'admin harus dapat membuka dokumen identitas terautentikasi');
    await request(`/members/${studentRegister.data.user.id}`,{method:'PUT',body:JSON.stringify({status:'inactive'})},adminToken);const inactiveLogin=await fetch(`${base}/auth/login`,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({email:studentEmail,password:'test12345'})});assert.equal(inactiveLogin.status,403,'akun nonaktif harus ditolak');await request(`/members/${studentRegister.data.user.id}`,{method:'PUT',body:JSON.stringify({status:'active'})},adminToken);
    const avatar=new FormData();avatar.append('photo',new Blob([Buffer.concat([Buffer.from('89504e470d0a1a0a','hex'),Buffer.alloc(17)])],{type:'image/png'}),'avatar.png');
    const avatarResponse=await fetch(`${base}/profile/photo`,{method:'POST',body:avatar,headers:{Authorization:`Bearer ${studentRegister.data.token}`}});
    const avatarBody=await avatarResponse.json() as ApiResponse<{photo:string}>;assert.equal(avatarResponse.status,200);uploadedPhoto=avatarBody.data.photo;
    const profile=(await query<RowDataPacket[]>('SELECT photo FROM users WHERE id=?',[studentRegister.data.user.id]))[0];assert.equal(profile.photo,uploadedPhoto);

    const category=await request<{id:number}>('/categories',{method:'POST',body:JSON.stringify({name:`Kategori Test ${suffix}`,description:'Integrasi'})},adminToken);
    created.categories.push(category.data.id);
    await request(`/categories/${category.data.id}`,{method:'PUT',body:JSON.stringify({description:'Integrasi diperbarui'})},adminToken);

    const book=await request<{id:number}>('/books',{method:'POST',body:JSON.stringify({title:`Buku Integrasi ${suffix}`,author_name:'Penulis Test',publisher:'Penerbit Test',isbn:`ISBN-${suffix}`,category_id:category.data.id,year:2026,description:'Buku untuk integration test',stock:1})},adminToken);
    created.books.push(book.data.id);
    await request(`/books/${book.data.id}`,{method:'PUT',body:JSON.stringify({publisher:'Penerbit Diperbarui'})},adminToken);

    const search=await request<Array<{id:number}>>(`/books?search=${suffix}&category=${category.data.id}&availability=available`);
    assert.ok(search.data.some(item=>item.id===book.data.id),'advanced search harus menemukan buku database');

    const borrowing=await request<{id_peminjaman:string}>('/peminjaman',{method:'POST',body:JSON.stringify({items:[{id_buku:book.data.id,jumlah:1}],durasi:7,satuan:'hari'})},studentRegister.data.token);
    created.transactions.push(borrowing.data.id_peminjaman);
    const adminBorrowings=await request<Array<{id_peminjaman:string}>>('/peminjaman',{},adminToken);
    assert.ok(adminBorrowings.data.some(item=>item.id_peminjaman===borrowing.data.id_peminjaman),'transaksi siswa harus terlihat oleh admin');

    let copies=await request<Array<{id:number;status:string}>>(`/inventory?book_id=${book.data.id}`,{},adminToken);
    assert.equal(copies.data[0].status,'BORROWED');

    await query('UPDATE peminjaman SET tanggal_jatuh_tempo=DATE_SUB(NOW(),INTERVAL 2 DAY) WHERE id_peminjaman=?',[borrowing.data.id_peminjaman]);
    await request('/system/process-overdue',{method:'POST'},adminToken);
    const overdue=(await query<RowDataPacket[]>('SELECT status,late_days,fine_amount FROM peminjaman WHERE id_peminjaman=?',[borrowing.data.id_peminjaman]))[0];
    assert.equal(overdue.status,'OVERDUE');
    assert.ok(Number(overdue.late_days)>=2&&Number(overdue.fine_amount)>0);

    await request(`/peminjaman/${borrowing.data.id_peminjaman}/pengembalian`,{method:'POST'},adminToken);
    copies=await request<Array<{id:number;status:string}>>(`/inventory?book_id=${book.data.id}`,{},adminToken);
    assert.equal(copies.data[0].status,'AVAILABLE','return harus memulihkan copy');
    await request('/reviews',{method:'POST',body:JSON.stringify({book_id:book.data.id,rating:4,review_text:'Review pertama'})},studentRegister.data.token);
    await request('/reviews',{method:'POST',body:JSON.stringify({book_id:book.data.id,rating:5,review_text:'Review diperbarui'})},studentRegister.data.token);
    const reviews=await query<RowDataPacket[]>('SELECT rating,review_text FROM book_reviews WHERE user_id=? AND book_id=?',[studentRegister.data.user.id,book.data.id]);
    assert.deepEqual(reviews.map(({rating,review_text})=>({rating,review_text})),[{rating:5,review_text:'Review diperbarui'}]);
    await request(`/inventory/copies/${copies.data[0].id}`,{method:'PUT',body:JSON.stringify({status:'LOST',notes:'Uji hilang'})},adminToken);
    await request(`/inventory/copies/${copies.data[0].id}`,{method:'PUT',body:JSON.stringify({status:'AVAILABLE',notes:'Uji ditemukan'})},adminToken);

    const secondBorrowing=await request<{id_peminjaman:string}>('/peminjaman',{method:'POST',body:JSON.stringify({items:[{id_buku:book.data.id,jumlah:1}],durasi:7,satuan:'hari'})},studentRegister.data.token);
    created.transactions.push(secondBorrowing.data.id_peminjaman);
    const reservation=await request<{id:number;queue_number:number}>('/reservations',{method:'POST',body:JSON.stringify({book_id:book.data.id})},waitingRegister.data.token);
    assert.equal(reservation.data.queue_number,1);
    await request(`/peminjaman/${secondBorrowing.data.id_peminjaman}/pengembalian`,{method:'POST'},adminToken);
    const reservations=await request<Array<{id:number;status:string}>>('/reservations',{},waitingRegister.data.token);
    assert.equal(reservations.data.find(item=>item.id===reservation.data.id)?.status,'NOTIFIED');

    const notifications=await request<{items:Array<{id:number;is_read:number}>;unread_count:number}>('/notifications',{},waitingRegister.data.token);
    assert.ok(notifications.data.unread_count>0);
    await request('/notifications/read-all',{method:'PUT'},waitingRegister.data.token);
    const readNotifications=await request<{unread_count:number}>('/notifications',{},waitingRegister.data.token);
    assert.equal(readNotifications.data.unread_count,0);

    const dashboard=await request<{recent:Array<{id_peminjaman:string}>}>('/admin/dashboard',{},adminToken);
    assert.ok(dashboard.data.recent.some(item=>created.transactions.includes(item.id_peminjaman)));
  }finally{
    if(uploadedPhoto)await unlink(path.resolve('uploads',path.basename(uploadedPhoto))).catch(()=>{});
    for(const identity of created.identities)await unlink(path.resolve(config.privateUploadDir,path.basename(identity))).catch(()=>{});
    for(const bookId of created.books)await query('DELETE FROM book_reviews WHERE book_id=?',[bookId]);
    if(created.users.length){
      const placeholders=created.users.map(()=>'?').join(',');
      await query(`DELETE FROM notifications WHERE user_id IN (${placeholders})`,created.users);
      await query(`DELETE FROM activity_logs WHERE user_id IN (${placeholders})`,created.users);
      await query(`DELETE FROM reservations WHERE user_id IN (${placeholders})`,created.users);
    }
    if(created.transactions.length){
      const placeholders=created.transactions.map(()=>'?').join(',');
      await query(`DELETE fp FROM fine_payments fp JOIN pengembalian k ON k.id_pengembalian=fp.id_pengembalian WHERE k.id_peminjaman IN (${placeholders})`,created.transactions);
      await query(`DELETE FROM pengembalian WHERE id_peminjaman IN (${placeholders})`,created.transactions);
      await query(`DELETE bc FROM borrowing_copies bc JOIN detail_peminjaman d ON d.id_detail=bc.id_detail WHERE d.id_peminjaman IN (${placeholders})`,created.transactions);
      await query(`DELETE FROM book_copy_history WHERE id_peminjaman IN (${placeholders})`,created.transactions);
      await query(`DELETE FROM detail_peminjaman WHERE id_peminjaman IN (${placeholders})`,created.transactions);
      await query(`DELETE FROM peminjaman WHERE id_peminjaman IN (${placeholders})`,created.transactions);
    }
    for(const bookId of created.books){await query('DELETE FROM book_copy_history WHERE copy_id IN (SELECT id FROM book_copies WHERE book_id=?)',[bookId]);await query('DELETE FROM book_copies WHERE book_id=?',[bookId]);await query('DELETE FROM books WHERE id=?',[bookId])}
    for(const categoryId of created.categories)await query('DELETE FROM categories WHERE id=?',[categoryId]);
    for(const userId of created.users)await query('DELETE FROM users WHERE id=?',[userId]);
    await new Promise<void>(resolve=>server.close(()=>resolve()));
    await pool.end();
  }
});
