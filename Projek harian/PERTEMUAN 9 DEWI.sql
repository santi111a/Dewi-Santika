--Join
--Menampilkan table wishlist
select * from wishlist;

select * 
from wishlist 
join products on wishlist.id_produk = products.id;

--Menampilkan secara custom
select products.id, products.nama, wishlist.keterangan
from wishlist join products on wishlist.id_produk = products.id;

--menggunakan alias
select p.id, p.nama, w.keterangan
from wishlist as w join products as p on w.id_produk = p.id;

--Melakukan join ke multiple table
--sebelumnya kita akan menambahkan kolom di wishlist
alter table wishlist
add column id_customer int;

--cek table wishlist
select * from customer;

--menambahkan relasi table wishlist ke id_customer terhadap table customer
alter table wishlist
add constraint fk_wishlist_customer 
foreign key (id_customer) 
references customer(id);

--update table wishlist
update wishlist
set id_customer = 1
where id in (2,3);

update wishlist
set id_customer = 4 
where id = 4;

select * from wishlist;

--selanjutnya melakukan join multiple table
select c.email, p.id, p.nama, w.keterangan
from wishlist as w
	join products as p on w.id_produk = p.id
	join customer as c on c.id = w.id_customer;

--relasi antar table
--one to one relationship
--membuat table dompet dengan menggunakan UNIQUE
create table dompet
(
	id		serial not null,
	id_customer	int not null,
	balance		int not null default 0,
	primary key (id),
	constraint dompet_customer_unique unique (id_customer),
	constraint fk_wallet_customer foreign key (id_customer) 
	references customer(id)
);

--cek table customer
select * from customer;

--Input data ke table customer
insert into dompet(id_customer, balance)
values(1, 1000000),
		(4, 5000000),
		(5, 10000000);
INSERT INTO dompet(id_customer, balance)
VALUES (1, 1000000),
       (4, 5000000),
       (5, 10000000);
INSERT INTO customer (id_customer, nama) 
VALUES (4, 'Arief');



--Menampilkan table dompet
select * from dompet;

--lakukan join dengan relasi one to one
select * from customer join dompet on dompet.id_customer = customer.id;

--one to many relationship
--Membuat table categories
create table categories
(
	id	varchar(10) not null,
	nama varchar(100) not null,
	primary key (id)
);

--input data ke categories
insert into categories(id, nama)
values('C0001', 'Makanan'),
		('C0002', 'Minuman');

select * from categories;

--menambahkan column id_category di table products
alter table products
add column id_category varchar(10);

--Menambahkan relasi
alter table products
add constraint fk_product_category 
foreign key (id_category) 
references categories(id);

select * from products;

--update table products
update products
set id_category = 'C0001'
where category = 'Makanan';

update products
set id_category = 'C0002'
where category = 'Minuman';

--menghapus column category
alter table products
drop column category;

--melakukan join
select * from products 
join categories on products.id_category = categories.id;

--many to many relationship
--membuat table order
create table orders
(
	id		serial not null,
	total	int		not null,
	order_date	timestamp not null default current_timestamp,
	primary key (id)
);

--membuat table ditengah
create table orders_detail
(
	id_product varchar(10)	not null,
	id_order	int	not null,
	harga		int	not null,
	jumlah		int not null,
	primary key (id_product, id_order)
);

--menambahkan constraint
alter table orders_detail
add constraint fk_orders_detail_product 
foreign key (id_product) references products(id);

alter table orders_detail
add constraint fk_orders_detail_order 
foreign key (id_order) references orders(id);

--insert data
insert into orders(total)
values (1), (1), (1);

select * from orders;

select * from products order by id;

insert into orders_detail(id_product, id_order, harga, jumlah)
values ('P0001', 1, 5000, 3),
		('P0002', 1, 3000, 2),
		('P0003', 1, 2000, 2);

insert into orders_detail(id_product, id_order, harga, jumlah)
values ('P0004', 2, 5000, 3),
		('P0005', 2, 3000, 2),
		('P0006', 2, 2000, 2);

insert into orders_detail(id_product, id_order, harga, jumlah)
values ('P0001', 3, 5000, 3),
		('P0004', 3, 3000, 2),
		('P0005', 3, 2000, 2);

select * from orders_detail;

--melihat data order, detail sekaligus produknya
select *
from orders
		join orders_detail on orders_detail.id_order = orders.id
		join products on orders_detail.id_product = products.id;

--jika ingin melihat di orders ke berapa
select *
from orders
		join orders_detail on orders_detail.id_order = orders.id
		join products on orders_detail.id_product = products.id
where orders.id = 1;

--Next vJenis-jenis join










