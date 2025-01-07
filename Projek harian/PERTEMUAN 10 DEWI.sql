--Jenis-jenis JOIN
--1.INNER JOINselect 

--input ke table categories 
insert into categories(id, nama)
values ('C0003', 'Snack Basah'),
		('C0004', 'Snack Kering');

--melihat table categoreis
select * from categories;

--melihat table products;
select * from products;
--input ke table products
--insert into products(id, nama, harga,jumlah)
--values('X001', 'Coba 1', 1000, 100),
		--('X002', 'Test 2', 2000, 100);

--insert join
select * from categories
inner join products on products.id_category = categories.id;

--left join
select * from categories
left join products on products.id_category = categories.id;

--right join
select * from categories
right join products on products.id_category = categories.id;

--full join
select * from categories
full join products on products.id_category = categories.id;

--subquery di where
--melihat rata-rata / avg di table products
select avg(harga) from products;
--subgquery di where
select * from products
where harga > (select avg(harga) from products);
--subquery di from
select * from products;


select products.harga as harga
from categories join products on products.id_category = categories.id;

--subquery max
select max (harga) from (select products.harga as harga
from categories join products on products.id_category = categories.id) as contoh;

--set operator
--membuat telebih dahulu table buku_tamu
create table bukutamu
(
	id	serial	not null,
	email	varchar(100) not null,
	title	varchar(100) not null,
	content text,
	primary key (id)
);

--input data dari table customer
select * from customer;

insert into bukutamu(email, title, content)
values ('banyu.q@gmail.com', 'Banyu biru', 'Ini adalah banyu'),
		('rab.q@gmail.com', 'rabs biru', 'Ini adalah rab'),
		('rabs.q@gmail.com', 'rab saja', 'Ini saingain saya'),
		('arief@gmail.com', 'rabu', 'Ini adalah rabu'),
		('prabowo@gmail.com', 'kamis biru', 'Ini adalah kamis');

select * from bukutamu;

--set UNION
select distinct email from customer
union
select distinct email from bukutamu;

--set union All
select distinct email from customer
union all
select distinct email from bukutamu;
--dapat digunakan berapa kali email muncul
select email, count(email)
from (select email
	from customer
	union all
	select email
	from bukutamu) as contoh
group by email;

--intersect
select distinct email from customer
intersect
select distinct email from bukutamu;

--except
select distinct email from customer
except
select distinct email from bukutamu;
--next trasaction


