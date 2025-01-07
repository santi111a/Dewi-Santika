--cek constraint
--Menambah/menghapus constrint
alter table products
add constraint price_check check (harga > 1000);

select * from products;

alter table products
add constraint jumlah_check check (jumlah >= 0);

--memasukkan data ke fild yang sudah dicek
insert into products(id, nama, harga, jumlah, category)
values ('XXX1', 'Gagal bro', 10, 0, 'Minuman');



--Index
--membuat table penjual
create table penjual
(
	id		serial		not null,
	nama	varchar(100)	not null,
	email	varchar(100)	not null,
	primary key (id),
	constraint email_unique unique (email)
);

--Inser data ke table penjual
insert into penjual(nama, email)
values ('Megawati', 'megawati@yahoo.com'),
		('Jokowi', 'jokowi@google.com'),
		('Prabowo', 'prabowo@gmail.com'),
		('Banyubiru', 'banyu@gmail.com');

select * from penjual;

--menampilkan data dengan dengan index
select * from penjual where id = 1;
select * from penjual where email = 'banyu@gmail.com';

--menampilkan tanpa index
select * from penjual where id = 1 or nama = 'Banyubiru';
select * from penjual where email = 'banyu@gmail.com' or nama = 'Megawati';

--membuat index
create index penjual_id_dan_nama_index on penjual(id, nama);
create index penjual_email_dan_nama_index on penjual(email, nama);

--Full text search menggantikan like
--Mencari tanpa index
select * from products
where to_tsvector(nama) @@ to_tsquery('Ayam');

--Mencari dengan index
--cek bahasa yang digunakan / yang di dukung
select cfgname from pg_ts_config;


CREATE TEXT SEARCH CONFIGURATION indonesia (COPY = pg_catalog.simple);
ALTER TEXT SEARCH CONFIGURATION indonesia
ADD MAPPING FOR asciiword, word, hword WITH simple;

--menampilkan dengan
select * from products where nama @@ to_tsquery('ayam');
--dengan operator
select * from products where nama @@ to_tsquery('!es');

--Table Relationship
--membuat table wishlist
create table wishlist
(
	id		serial	not null,
	id_produk	varchar(10)	not null,
	keterangan	text,
	primary key (id),
	constraint fk_wishlist_produk foreign key (id_produk) references products (id)
);

--jika insert salah
insert into wishlist(id_product, keterangan)
values('coba', 'Ayam bakar-bakarang');





--insert benar
insert into wishlist(id_produk, keterangan)
values	('P0001', 'Ayam Bakar Kalasan'),
		('P0002', 'Ayam Bakar Banyumas'),
		('P0003', 'Ayam Bakar Pesawat Terbang');

select * from wishlist;
--tidak bisa di delete karena digunakan ditabel products/tabel lain
delete from products where id = 'P0003';
--tidak bisa di delete karena digunakan ditabel products/tabel lain
update wishlist
set id_produk = 'coba'
where id = 2;



--merubah behavior foregin key
--hapus dulu constrain di wishlist
alter table wishlist
drop constraint fk_wishlist_produk;

--buat lagi constrain dengan behaviornya
alter table wishlist
add constraint fk_wishlist_produk foreign key (id_produk) references products(id)
on delete cascade on update cascade;

--sekarang bisa dihapus tabel yang berelasi
insert into products(id, nama, harga, jumlah, category)
values ('abab', 'xXx', 10000, 100, 'Minuman');

select * from wishlist;
insert into wishlist(id_produk, keterangan)
values ('wawa', 'Contoh bray');

delete from products where id = 'abab';













		

