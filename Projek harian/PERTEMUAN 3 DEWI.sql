

create table products(
	id	varchar(10) not null,
	nama	varchar(100) not null,
	keterangan	text,
	harga	int	not null,
	jumlah	int	not null default 0,
	created_at	timestamp not null default current_timestamp

);

select*from products

insert into products(id,nama, keterangan, harga, jumlah)
values('P0001', 'Ayam Geprek original','Ayam Geprek + sambal ijo', 25000,100);

insert into products(id, nama, harga, jumlah)
values ('P0002', 'Ayam Bakar Bumbu seafood', 35000,100),
		('P0003', 'Ayam Goreng Upin-Ipin', 30000,100),
		('P0004', 'Ayam Bakar Bumbu seadanya', 35000,100);


update products
set nama = 'Ayam pop'
where id = 'P0001';

--Menambahkan column category
alter table products
add column category PRODUCT_CATEGORY;

ALTER TABLE products
ADD COLUMN category VARCHAR(50);
--Mengupdate table pada column category
update products
set category = 'Makanan'
where id = 'P0001';

select * from products;

update products
set category = 'Makanan'
where id = 'P0002';

update products
set category = 'Makanan'
where id = 'P0003';

update products
set category = 'Makanan'
where id = 'P0004';

update products
set category = 'Makanan'
where id = 'P0005';

--mengubah value di colomn
update products
set harga = harga + 10000
where id = 'P0004';

select * from products;

--Delete Data
--insert data untuk contoh dihapus
insert into products(id, nama, harga, jumlah, category)
values ('P0010', 'Produk Gagal', 50000, 100,'Minuman');

select * from products;

--Menghapus id P0010
delete from products
where id = 'P0010';

