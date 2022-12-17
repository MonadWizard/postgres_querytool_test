--product_table.sql

-- product table create
CREATE TABLE  IF NOT EXISTS Products (
    product_id SERIAL PRIMARY KEY,
	productName VARCHAR ( 50 ) UNIQUE NOT NULL,
	productDescriptions VARCHAR ( 50 ),
	created_on TIMESTAMP NOT NULL,
	productTags BIGINT[] ,
	productExtra BIGINT ARRAY
);

-- drop user table
drop table Products;

-- insert into Product Table
EXPLAIN ANALYZE 
insert into Products(productName,productDescriptions, created_on, productTags,productExtra)
values('p1111111111','p1 discription111111111','2016-06-22 19:10:25-07',ARRAY[1,2],ARRAY[1]);

insert into Products(productName,productDescriptions, created_on, productTags,productExtra)
values('p1111111111','p1 discription111111111','2016-06-22 19:10:25-07',ARRAY[1,2],ARRAY[1]);

VALUES($1, $2::text[])`;

insert into Products(productName,productDescriptions, created_on, productTags,productExtra)
values('p2111111111','p1 discription111111111','2016-06-22 19:10:25-07',ARRAY[]::integer[],ARRAY[]::integer[]);

-- see all data 
select * from Products;


-- productExtraField table create

CREATE TABLE  IF NOT EXISTS ProductExtraField (
    id BIGSERIAL PRIMARY KEY,
	product_image text[],
	product_size VARCHAR ( 50 ),
	product_price JSON,
	product_primaryImage VARCHAR ,
	product_sizedescription text,
	product_id BIGINT,
	
	CONSTRAINT FK_ProductExtraField_Products FOREIGN KEY(product_id)
        REFERENCES Products(product_id)
);


ALTER TABLE ProductExtraField 
ALTER COLUMN product_price TYPE JSONB;

drop table ProductExtraField;

insert into ProductExtraField(product_image,product_size, product_price, product_primaryImage,product_sizedescription,product_id)
values(ARRAY['p2111111111','p2111111111'],'XLl','{ "BasePrice": "1200", "OfferPrice": "900", "PromotionalPrice": "600"}','imageWebURL','product dize sort discription','1');

select * from ProductExtraField;

select * from Products;

-- take all data from products table

SELECT
    product_id, productname, productdescriptions, created_on, producttags,
    (SELECT array_to_string( 
	ARRAY(select '["'|| product_size || '",'
		|| '"'|| product_primaryimage || '",' 
		|| '"' || product_sizedescription  || '",' 
		|| '"' || product_price || '"]' 
		from ProductExtraField where product_id = 1
	) , ' , ') )product_extrafield    
FROM Products where product_id = 1 ;
	 
-- select get_product(10);  --- task create function 

	 

-- product pricing Table

CREATE TABLE  IF NOT EXISTS ProductPricing (
    price_id BIGSERIAL PRIMARY KEY,
	product_extrafield_id BIGINT,
	price_amount VARCHAR,
	price_type VARCHAR ( 50 ),
	price_start_datetime TIMESTAMP with time zone NOT NULL,
	price_end_datetime TIMESTAMP with time zone NOT NULL,
	
	
	CONSTRAINT FK_ProductPricing_ProductExtraField FOREIGN KEY(product_extrafield_id)
        REFERENCES ProductExtraField(id)
);


DROP TABLE ProductPricing

-- insert data ProductPricing

insert into ProductPricing(product_extrafield_id,price_amount, price_type, price_start_datetime,price_end_datetime)
values('1', '100', 'Promotional', '2022-12-01 10:27:44.43066+00', '2022-12-01 10:27:44.43066+00');

-- get all data from ProductPricing
select * from ProductPricing ;



CREATE TABLE  IF NOT EXISTS ProductPricingshedule (
    pricing_id BIGINT PRIMARY KEY,
	product_extrafield_id BIGINT,
	price_amount VARCHAR,
	price_type VARCHAR ( 50 ),
	price_start_datetime TIMESTAMP with time zone NOT NULL,
	price_end_datetime TIMESTAMP with time zone NOT NULL,
	
	
	CONSTRAINT FK_ProductPricing_ProductExtraField FOREIGN KEY(product_extrafield_id)
        REFERENCES ProductExtraField(id)
);


DROP TABLE ProductPricingshedule

-- not used
DELETE FROM events WHERE event_time < now() - interval '1 week'

-- DELETE FROM events WHERE event_time < now() - interval '1 week'

select * from ProductPricing ;

-- test
SELECT price_id, product_extrafield_id, price_amount, price_type, price_start_datetime, price_end_datetime
FROM ProductPricing 
WHERE price_start_datetime >= now()
AND price_start_datetime < (now() + INTERVAL '30 minutes');

-- take currect date-time
select Current_timestamp;
select now()
select (now() + INTERVAL '30 minutes')

select * from ProductPricing ;

select * from ProductPricingshedule

-- function for call in sheduler...........

INSERT INTO ProductPricingshedule (pricing_id, product_extrafield_id, price_amount, price_type, price_start_datetime,price_end_datetime)
SELECT price_id, product_extrafield_id, price_amount, price_type, price_start_datetime, price_end_datetime
FROM ProductPricing 
WHERE price_start_datetime >= now()
AND price_start_datetime < (now() + INTERVAL '30 minutes')
ON CONFLICT DO NOTHING;


-- take rows in current date time
select * from ProductPricingshedule where to_char(price_start_datetime,'YYYY-MM-DD HH24:MI') = to_char(now(),'YYYY-MM-DD HH24:MI')

select to_char(now(),'YYYY-MM-DD HH24:MI')
select now()

{ "BasePrice": "1000", "OfferPrice": "800", "PromotionalPrice": "500"}

-- add specific key:value in JSON
UPDATE public.productextrafield
SET product_price = product_price || '{"width":"100cm"}'
WHERE id = 1;

-- check if key exist
SELECT product_price::json->'width'
FROM productextrafield
WHERE id = 1;

-- delete specific key:value in json
UPDATE productextrafield
SET product_price = product_price - 'width'
WHERE id = 1;


select * from ProductExtraField where id = 1;


-- function for take data from ProductPricing table to shedule table (shedule every 5 minute -> take present to 30 minuts all rows ) 
create or replace function shedule_func()
returns void as
$$
	begin
		
		INSERT INTO ProductPricingshedule (pricing_id, product_extrafield_id, price_amount, price_type, price_start_datetime,price_end_datetime)
		SELECT price_id, product_extrafield_id, price_amount, price_type, price_start_datetime, price_end_datetime
		FROM ProductPricing 
		WHERE price_start_datetime >= now()
		AND price_start_datetime < (now() + INTERVAL '30 minutes')
		ON CONFLICT DO NOTHING;
	end;
$$ language plpgsql;


--call function for take rows in sheduler
drop function shedule_func()
select shedule_func()

select now()
select * from ProductPricing ;
select * from ProductPricingshedule


-- function for update JSON on ProductExtraField tables's product_price data from ProductPricingshedule table (shedule every minute)  [not executed]==========================================

create or replace function updateprice_func()
returns void as
$$		
	begin
	
-- 		select * from ProductPricingshedule where to_char(price_start_datetime,'YYYY-MM-DD HH24:MI') = to_char(now(),'YYYY-MM-DD HH24:MI')
		UPDATE ProductExtraField 
			SET product_price = product_price || 
				( pps.pricejson::jsonb )
			FROM ( 
				select product_extrafield_id px_id, 
				json_object_agg(price_type, price_amount) as pricejson 
				from ProductPricingshedule 
				where to_char(price_start_datetime,'YYYY-MM-DD HH24:MI') = to_char(now(),'YYYY-MM-DD HH24:MI')
				group by product_extrafield_id
				) as pps 
			where ProductExtraField.id = "pps".px_id ; 
			
-- remove price from ProductPricingshedule table to ProductExtraField table  [for function]
		UPDATE ProductExtraField 
		SET product_price = product_price - pps.pricejson
			FROM ( 
				select product_extrafield_id px_id,
				array_agg(price_type) pricejson 
				from ProductPricingshedule 
				where to_char(price_end_datetime,'YYYY-MM-DD HH24:MI') = to_char(now(),'YYYY-MM-DD HH24:MI') 
				group by product_extrafield_id
			) as pps 
		where ProductExtraField.id = "pps".px_id ;
	
	end;
$$ language plpgsql;


drop function updateprice_func();


select to_char(now(),'YYYY-MM-DD HH24:MI')


select updateprice_func();
select * from ProductExtraField

select * from ProductPricingshedule





-- demo test for update json			
	select   product_extrafield_id, json_object_agg(price_type, price_amount) as pricejson from ProductPricingshedule where to_char(price_start_datetime,'YYYY-MM-DD HH24:MI') = '2022-12-04 14:49'
			group by product_extrafield_id
			



-- add price from ProductPricingshedule table to ProductExtraField table  [for function]

UPDATE ProductExtraField 
SET product_price = product_price || 
	( pps.pricejson::jsonb )
FROM ( 
	select product_extrafield_id px_id, json_object_agg(price_type, price_amount) as pricejson from ProductPricingshedule where to_char(price_start_datetime,'YYYY-MM-DD HH24:MI') = '2022-12-04 14:49'
			group by product_extrafield_id
			
	) as pps 
where ProductExtraField.id = "pps".px_id  

select * from ProductExtraField
select * from ProductPricingshedule


-- test demo 
		select product_extrafield_id px_id,
		array_agg(price_type) pricejson 
		from ProductPricingshedule 
		where to_char(price_end_datetime,'YYYY-MM-DD HH24:MI') = '2022-12-04 14:49' 
		group by product_extrafield_id

-- remove price from ProductPricingshedule table to ProductExtraField table  [for function]
UPDATE ProductExtraField 
SET product_price = product_price - pps.pricejson

	FROM ( 
		select product_extrafield_id px_id,
		array_agg(price_type) pricejson 
		from ProductPricingshedule 
		where to_char(price_end_datetime,'YYYY-MM-DD HH24:MI') = '2022-12-04 14:49' 
		group by product_extrafield_id
	) as pps 
where ProductExtraField.id = "pps".px_id





-- all execution

select (to_char(now(),'YYYY-MM-DD HH24:MI'))

select now()+  INTERVAL '30 minutes'


select * from ProductExtraField

select * from ProductPricingshedule


-- all work happend in this table
select * from ProductPricing ;

SELECT shedule_func();

SELECT updateprice_func();


insert into ProductPricing(product_extrafield_id,price_amount, price_type, price_start_datetime,price_end_datetime)
values('2', '80', 'Promotional', (now( )+ INTERVAL '10 minutes'),( now( )+ INTERVAL '20 minutes') );

insert into ProductPricing(product_extrafield_id,price_amount, price_type, price_start_datetime,price_end_datetime)
values('2', '50', 'Offer', now( )+ INTERVAL '10 minutes', now( )+ INTERVAL '20 minutes' );































