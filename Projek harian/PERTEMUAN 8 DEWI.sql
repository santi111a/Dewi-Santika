-- Membuat table dengan JSONB
CREATE TABLE produk_laptop (
	id SERIAL PRIMARY KEY,
	nama TEXT NOT NULL,
	details JSONB
);

--insert JSON data ke JSONB
INSERT INTO produk_laptop
	(nama,
	details)
	VALUES (
		'Laptop',
		'{
			"brand" : "Leknopo",
			"model" : "Thinkmat",
			"harga" : "Rp 50.000.0000",
			"specs" : {
				"cpu" : "Core i9",
				"ram" : "32GB",
				"storage" : "126 Gb SSD NVME ",
				"vga" : "Nvida 1Tere"
			}
		}'
	)

	--Query JSONB
	select * from produk_laptop;

	select * from products;

	SELECT nama, details ->> 'brand' AS brand
	FROM produk_laptop;

--extrak nested value dengan jsonb
--menggunakan (-->) dan (->>)
SELECT
	nama, details -> 'specs' ->> 'ram' AS Ram
FROM produk_laptop;

--Menggunakan operator @>
SELECT
    nama,
    details
FROM
    produk_laptop
WHERE
    details @> '{"brand": "Leknopo"}';

--extrak value dengan JSONB path
-- dengan menggunakan #>>
select nama, details#>> '{specs, Storage}' AS Storage
from produk_laptop;

--update jsonB
UPDATE produk_laptop
set details = jsonb_set(details, '{specs, storage}', '" 1T SSD NVME"')
where nama = 'Laptop';

--Pertanyaan, bagaimana mengupdate storage saja pada brand Asus, atau acer

--Query
select nama, details from produk_laptop;

--Menghapus top level field data jsonb
--dengan operator (-)
update produk_laptop
set details = details - 'model'
where nama = 'Laptop';

--query
select nama, details from produk_laptop;

--menghapus nested field
update produk_laptop
set details = details #- '{specs, cpu}'
where nama = 'Laptop';

--query
select nama, details from produk_laptop;

--JSONB query lanjut
--Menggunakan JSONB arrays
INSERT INTO produk_laptop (nama, details) VALUES (
    'Smartphone',
    '{
        "brand": "Sharp",
        "model": "Aquos",
        "tags": ["electronics", "mobile", "new"]
    }'
);

-- Query produk_laptop dengan specific tags
SELECT nama, details
FROM produk_laptop
WHERE details @> '{"tags": ["mobile"]}';

--Menggunakan operator ? untuk query
SELECT  nama, details
FROM produk_laptop
WHERE details->'tags' ? 'mobile';

--Menggabungkan jsonb data (merging)
--dengan oprator ||

UPDATE produk_laptop
SET details = details || '{"warranty": "2 years"}'
WHERE nama = 'Laptop';

-- Query updated data
SELECT
    nama,
    details
FROM
    produk_laptop;

--Agregate jsonb
SELECT
    details->>'brand' AS brand,
    COUNT(*) AS count
FROM
    produk_laptop
GROUP BY
    details->>'brand';

--JSON index dengan gin dan btree index
--gin index
-- Create GIN index
CREATE INDEX idx_produk_details_features ON produk_laptop USING GIN ((details->'tags'));

-- Query produk dengan specific features index
SELECT nama, details
FROM produk_laptop
WHERE details->'tags' ? 'electronics';

--Membuat b-tree index
-- Create B-tree index
CREATE INDEX idx_produk_details_model ON produk_laptop ((details->>'model'));

-- Query dengan index
SELECT
    nama,
    details
FROM
    produk_laptop
WHERE
    details->>'Model' = 'XPS 13';












	