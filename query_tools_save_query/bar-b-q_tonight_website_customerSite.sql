-- bar-b-q_tonight_website_customerSite.sql

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
values('Sarah Rahman','Sar@249','jATVnvd@59','01812456967','Road-346,House-4,Flat-B2,Gulshan-2','sar@gmail.com');

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

insert into ReservationTable(Type_of_Reservation,CompnyName,location,day_of_reservation,Preferred_time,Number_of_guests)
values('Corporate','Algorithm Generation','Gulshan, Dhaka',DATE '2022/10/20','06:30:00',20);
/* HAS ISSUES IF I INSERT VALUES IN RemarksOrSpecial_requirement FIELD. CHECK!!!!!!!!!!!!!!!! */

/* Creating ReservationDetail table */

create table ReservationDetail(
	id bigserial not null,
	user_id bigserial not null,
    Reservation_id bigserial not null,
	Quantity int not null,
	Item_name varchar(100) not null,
	price Decimal (8,0),
	foreign key(Reservation_id) references ReservationTable(Reservation_id),
	foreign key(user_id) references UserInfo(user_id),
	foreign key(id) references menu(id)
);

/* WORK ON PRODUCT FUNCTION*/
drop table ReservationDetail;


/* HAS ISSUES */
insert into ReservationDetail(Quantity, Item_name,price)
values(3,'BACON AND 
KIMCHI BURGERS',567); /* product function storating is needed for this */

/* CREATE Contact table */

create table Contact(
name varchar(50) not null,
email varchar(60),
phone_number varchar(11) not null,
message text not null);


insert into contact(name,phone_number,message)
values('Sarah','01914728521','Hi, I have placed an order on 21st of
 October and I chose online payment.
 Transaction has happened but I
 didnt recieve my order. I tried to 
reach your team via Whatsapp and 
Hotline number too but unable to get
 any response! Please get back to me.
 I need refund. Thanks.');

select * from contact;

/* creating table About_Us table */

create table About_us(
Facebook varchar(255) not null,
intagram varchar(255),
Youtube varchar(255),
information text not null,
contact_number varchar array not null,
google_map_location varchar(255) not null
);

insert into About_us(facebook,youtube,information,contact_number,google_map_location)
values('https://www.facebook.com/barbqtonight.dhk','https://www.youtube.com/channel/UCr89q0WtngUNr8uiQDtuirg','SA TOWER,
 H 1, R 134, 
GULSHAN 1, 
DHAKA 1212.','{HOTLINE: +8801988300700,
 WHATSAPP: +8801988300700}',
'https://goo.gl/maps/T67TgvZcG73oc9VX8');

select * from about_us;

/* creating delivery as ENUM type */

CREATE TYPE Delivery AS ENUM('Private','Event','Corporate');

/* create cart_info table */

/* HAS ISSUES AS ReservationDetail TABLE hasnt sorted yet */
/* NEED DISCUSSION */
create table cart_info(
delivery_type delivery not null,
foreign key(user_id) references UserInfo(user_id),	
/*foreign key(Reservation_id) references ReservationDetail(Reservation_id),*/
foreign key(Reservation_id) references ReservationTable(Reservation_id))

/* creating TESTIMONIAL table */
CREATE TABLE TESTIMONIAL(
clients_view text not null,
review_link text);

insert into TESTIMONIAL(clients_view,review_link)
values('Cozy and elegant ambience.
 Very good customer service. 
Food was brought hot and fresh.
 The mutton rib was the highlight.
 Absolutely delicious tender and soft. 
Their beef chapli was very good too.
 Palak paneer, khatakhat, ginger chicken were equally tasty.','https://www.tripadvisor.com/Restaurant_Review-g293936-d13126247-Reviews-Bar_B_Q_Tonight-Dhaka_City_Dhaka_Division.html');
 
select * from TESTIMONIAL;

/* creating home table */

create table home(
OurStory text not null,
background_images varchar array);

insert into home(OurStory)
values('Discover
OUR STORY
✻
Inaugurated on the 10th of November in 1988, Bar.B.Q. Tonight started serving authentic Pakistani dishes and its signature Bar.B.Q dishes. The sincere efforts of our visionary founders made Bar.B.Q Tonight a modern symbol of hygiene & quality and within months, their aspirations yielded fruitful results. Today, Bar B. Q. Tonight is credited as one of the pioneers in true Bar.B.Q dining.');

select * from home;

/* creating delivery as ENUM type */

CREATE TYPE Payment AS ENUM('Cash','Card','Bank');

/* creating payment table */

create table payment(
	Payment_type Payment not null,	
	delivery_address text not null,
	email varchar(30),
	phone varchar(11) not null,
	Card_name varchar(30),
	Card_number	decimal(16,0),
	Card_expiry_date date,
	CVV2_Security_code decimal(3,0),
	Bank_account_number int,
foreign key(user_id) references UserInfo(user_id)
/* ReservationDetail_table.SubTotal(FK) */);

