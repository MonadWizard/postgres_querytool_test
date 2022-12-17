--bar_b_q_tonight_JAV.sql

CREATE DATABASE BarBQTonight;

/* List all the tables */
select * from information_schema.tables;

/* creating table for storing user information */

CREATE TABLE UserInfo(
user_id bigserial not null Primary key,
user_fullname varchar(50) not null,
username varchar(30) not null unique,
password varchar(30) not null,
phone_number varchar(11) not null,
address varchar(255) not null,
email varchar(30),
user_image varchar(255),
sign_in_permission varchar ARRAY);

drop table userinfo;

select * from userinfo;

/* inserting user info */

insert into Userinfo(user_fullname,username, password, phone_number,address,email)
values('Sar54','Sar@25935om','jATVnvd@59','01812456967','Road-346,House-4,Flat-B2,Gulshan-2','sar@gmail.com');

/* creating menu table */

create table Menu(
    id bigserial not null primary key,
    item_category varchar(30) not null,
	item_name varchar(30) not null,
	Description varchar(255) not null,
	regular_Price Decimal (8,2) not null,
	Rating json,
	Offer_price Decimal (8,2),
	image_list varchar ARRAY
);


insert into menu(item_category,item_name,description,regular_Price,offer_price,image_list)
values('Burger','BACON AND KIMCHI BURGERS','Chef Wesley Genovart
 makes this over-the-top,
 Shake Shack&ndash;inspired
 burger with two thin stacked 
patties, thick-cut bacon, 
kimchi, and a spicy homemade 
sauce.',567,500,'{"htps://www.google.com/search?q=create+array+in+sql+table&oq=declare+an+array+in+sql+table&aqs=chrome.1.69i57j0i22i30j0i390l3.10969j0j4&sourceid=chrome&ie=UTF-8,https://social.msdn.microsoft.com/Forums/en-US/6ccfc983-dd2c-49cf-b095-ce56ffbd4be8/storing-images-in-sql-database-vs-storing-images-in-seperate-folder-and-using-url-image-path?forum=aspgettingstarted"}');

select * from menu;

/* HAS ISSUES */

insert into menu(rating)
values('{"rating1": "10"}');

/* creating ENUM type */

CREATE TYPE RESERVATION_TYPE AS ENUM('Private','Event','Corporate');

/* creating ReservationTable */

create table ReservationTable(
	user_id bigserial not null,   
    Reservation_id bigserial not null primary key,
	Type_of_Reservation RESERVATION_TYPE not null,
	CompnyName varchar (255),
	location varchar(255),
	day_of_reservation TIMESTAMP not null,
	RemarksOrSpecial_requirement varchar(255),
	Preferred_time TIME not null,
	Number_of_guests varchar(20),
	foreign key(user_id) references UserInfo(user_id)
);

drop table ReservationTable;
select * from ReservationTable;

insert into ReservationTable(user_id, Type_of_Reservation,CompnyName,location,day_of_reservation,Preferred_time,Number_of_guests,RemarksOrSpecial_requirement)
values('5','Corporate','Algorithm Generation','Gulshan, Dhaka',DATE '2022/10/22','06:30:00',20,'sfdghjkl;');
/* HAS ISSUES IF I INSERT VALUES IN RemarksOrSpecial_requirement FIELD. CHECK!!!!!!!!!!!!!!!! */             --------------?

/* Creating ReservationDetail table */

create table ReservationDetail(
	id bigserial not null,
	user_id bigserial not null,  --need to remove
    Reservation_id bigserial not null,
	Quantity int not null,
	Total Decimal(10,0) not null primary key,
	Item_name varchar(100) not null,
	price Decimal (8,0),
	foreign key(Reservation_id) references ReservationTable(Reservation_id),
	foreign key(user_id) references UserInfo(user_id),
	foreign key(id) references menu(id)
);

-- alter data type on id column


ALTER TABLE ReservationDetail
  ALTER COLUMN id TYPE bigint;

-- add VAT on Reservation details table
ALTER TABLE ReservationDetail
  ADD vat DECIMAL;
  
-- add product id as forign key
ALTER TABLE ReservationDetail
 ADD product_id bigserial not null,
 ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES Menu (id);

-- alter Total Decimal Quantity
ALTER TABLE ReservationDetail
  ALTER COLUMN Total TYPE Decimal(10,0);
  
-- drop primary key on total
ALTER TABLE ReservationDetail
  DROP CONSTRAINT reservationdetail_pkey;
 
-- drop not null from total

ALTER TABLE ReservationDetail ALTER COLUMN Total DROP NOT NULL;


-- remove column Item_name

ALTER TABLE ReservationDetail
  DROP COLUMN Item_name;

-- remove column user_id

ALTER TABLE ReservationDetail
  DROP COLUMN user_id;

-- drop product id
ALTER TABLE ReservationDetail
  DROP COLUMN product_id;

-- select all from Reservation Table

select * from ReservationDetail;

select * from ReservationTable;

select * from menu;


-- add data to reservation table
INSERT INTO public.reservationdetail(
	id, reservation_id, quantity, price)
	VALUES (1,1,20,300)
	

-- cerate trigger function for calculate vat and total
-- function
create or replace function addVAT()
returns trigger as
'
begin
	update reservationdetail set total= (new.quantity * new.price)
	where id = new.id;
	raise notice ''Total is %'', new.id;
	return new;
end;
'language 'plpgsql';


-- trigger
create trigger total after insert on reservationdetail
for each row execute procedure addVAT();



-- add data to reservation table
INSERT INTO public.reservationdetail(
	id, reservation_id, quantity, price)
	VALUES (1,1,20,300)


-- drop triger function
DROP TRIGGER total ON reservationdetail;



--  -------------------------- trigger function for shaon vai -------------------------------  --
--  1.  when a user create then also create some table .
--  2. when a user delete then related tables are also delete.

-- 1. trigger function

-- function
create or replace function createUserPartialTable()
returns trigger as
$$
declare
	tn TEXT;
begin
	tn := new.username;
	EXECUTE format('
      CREATE TABLE IF NOT EXISTS %I (
       id serial PRIMARY KEY,
       customerid int,
       daterecorded date,
       value double precision
      )', 't1_' || tn);
	  
	  EXECUTE format('
      CREATE TABLE IF NOT EXISTS %I (
       id serial PRIMARY KEY,
       customerid int,
       daterecorded date,
       value double precision
      )', 't2_' || tn);
	  
	  EXECUTE format('
      CREATE TABLE IF NOT EXISTS %I (
       id serial PRIMARY KEY,
       customerid int,
       daterecorded date,
       value double precision
      )', 't3_' || tn);
	  
	  EXECUTE format('
      CREATE TABLE IF NOT EXISTS %I (
       id serial PRIMARY KEY,
       customerid int,
       daterecorded date,
       value double precision
      )', 't4_' || tn);
	  
	  EXECUTE format('
      CREATE TABLE IF NOT EXISTS %I (
       id serial PRIMARY KEY,
       customerid int,
       daterecorded date,
       value double precision
      )', 't5_' || tn);
	  
	  EXECUTE format('
      CREATE TABLE IF NOT EXISTS %I (
       id serial PRIMARY KEY,
       customerid int,
       daterecorded date,
       value double precision
      )', 't6_' || tn);
	  
	  EXECUTE format('
      CREATE TABLE IF NOT EXISTS %I (
       id serial PRIMARY KEY,
       customerid int,
       daterecorded date,
       value double precision
      )', 't7_' || tn);
	  
	  EXECUTE format('
      CREATE TABLE IF NOT EXISTS %I (
       id serial PRIMARY KEY,
       customerid int,
       daterecorded date,
       value double precision
      )', 't8_' || tn);
	  
	  EXECUTE format('
      CREATE TABLE IF NOT EXISTS %I (
       id serial PRIMARY KEY,
       customerid int,
       daterecorded date,
       value double precision
      )', 't10_' || tn);
	  
	  EXECUTE format('
      CREATE TABLE IF NOT EXISTS %I (
       id serial PRIMARY KEY,
       customerid int,
       daterecorded date,
       value double precision
      )', 't11_' || tn);
	  
	  EXECUTE format('
      CREATE TABLE IF NOT EXISTS %I (
       id serial PRIMARY KEY,
       customerid int,
       daterecorded date,
       value double precision
      )', 't12_' || tn);
	
	return new;
end;
$$language plpgsql;


-- trigger
create trigger table_create after insert on UserInfo
for each row execute procedure createUserPartialTable();


-- drop triger function
DROP TRIGGER table_create ON UserInfo;


/* inserting user info */

EXPLAIN ANALYZE 
insert into Userinfo(user_fullname,username, password, phone_number,address,email)
values('Sar2331','Sa2@2453.omb','jATVnvd@59','01812456967','Road-346,House-4,Flat-B2,Gulshan-2','sar@gmail.com');


























































































