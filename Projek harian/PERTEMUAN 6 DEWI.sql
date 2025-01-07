--PERTEMUAN 6
--menambah kolom timestamp
select * from products;
select id, extract(year from created_at), extract(month from created_at) from products;
--flow control function
select id,
case category
when 'Makanan' then 'enak'
when 'Minuman' then 'Sueger'
else 'Apa an tuh!!'
end as category
from products;

select id, category,
case category
when 'Makanan' then 'enak'
when 'Minuman' then 'Sueger'
else 'Apa an tuh!!'
end as category_case
from products;

--flow control chek null
select id,
nama,
case
when keterangan is null then 'kosong'
else keterangan
end as keterangan
from products;

--agragate function
--menghitung kolom id
select count(id) from products;
==menghitung rata-rata
select avg(harga) from products;
--mencari yang paling mahal
select max(harga) from products;
--mencari yang paling murah
select min(harga) from products;
--group by dengan aggregate fungsi
select category, count(id)from products group by category;
select category, count(id) as "Total Product" from products group by category;
select category,
avg(harga) as "Rata-rata harga",
min(harga) as "Harga termurah",
max(harga) as "Harga termahal"
from products
group by category;
--having clause
select category,
count(id)as "Total Product"
from products
group by category;

select category,
count(id)as "Total Product"
from products
group by category;
having count(id) > 1;

--constraint
--unique constrant
--membuat tabel customer
create table customer(
id serial not null,
email varchar(100) not null,
nama_depan varchar(200) not null,
nama_akhir varchar(200) not null,
primary key (id),
constraint unique_email unique (email)
);

insert into customer(email,nama_depan,nama_akhir)
values ('banyu@gmail.com','arief','budiarto');

select * from customer;
--menambah/menghapus unique constraint

alter  table customer
drop constraint unique_email;
--menambah constraint
alter table customer
add constraint unique(email);