
--Transaksi Dasar
-- Memulai transaksi
start transaction;
-- Menambahkan data ke tabel bukutamu
insert into bukutamu(email, title, content)
values ('transaction@gmail.com', 'Transaction', 'Transaksi 1');

insert into bukutamu(email, title, content)
values ('transaction@gmail.com', 'Transaction', 'Transaksi 2');

-- Melihat hasilnya di klien lain
select * from bukutamu;

-- Menyimpan perubahan
commit;

Menggunakan Rollback

-- Memulai transaksi
start transaction;

-- Menambahkan data ke tabel bukutamu
insert into bukutamu(email, title, content)
values ('transaction@gmail.com', 'Transaction', 'Rollback 1');

-- Membatalkan transaksi
rollback;

-- Memastikan data tidak tersimpan
select * from bukutamu;

Locking dan Deadlock

-- Mengunci record
start transaction;
select * from products where id = 'P0001' for update;

-- Membatalkan transaksi
rollback;

-- Deadlock
start transaction;
select * from products where id = 'P0001' for update;
select * from products where id = 'P0002' for update;
rollback;

Pengelolaan Schema

-- Membuat schema baru
create schema contoh;

-- Pindah ke schema lain
set search_path to contoh;

-- Membuat tabel di schema contoh
create table contoh.products (
    id serial not null,
    nama varchar(100) not null,
    primary key(id)
);

-- Kembali ke schema public
set search_path to public;

Manajemen Pengguna

-- Membuat pengguna
create role arief;
create role banyu;

-- Mengatur password untuk pengguna
alter role arief login password 'rahasia';
alter role banyu login password 'rahasia';

-- Memberi hak akses
grant insert, update, select on all tables in schema public to arief;
grant insert, update, select on customer to banyu;