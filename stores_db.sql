drop table if exists "category" cascade;
drop table if exists "product" cascade;
drop table if exists "branch" cascade;
drop table if exists "stock" cascade;
drop table if exists "client" cascade;
drop table if exists "order" cascade;
drop table if exists "item" cascade;

CREATE TABLE "category" (
  "id" SERIAL,
  "name" varchar(60),
  primary key (id)
);

CREATE TABLE "product" (
  "id" SERIAL,
  "name" varchar(60),
  "brand" varchar(60),
  "id_category" integer,
  "unit_price" integer,
  primary key (id)
);

CREATE TABLE "branch" (
  "id" SERIAL,
  "name" varchar(60),
  "address" varchar(60),
  primary key (id)
);

CREATE TABLE "stock" (
  "id" SERIAL,
  "branch_id" integer,
  "product_id" integer,
  "quantity" integer,
  primary key (id),
  unique (branch_id, product_id)
);

CREATE TABLE "client" (
  "id" SERIAL,
  "name" varchar(60),
  "phone" bigint,
  primary key (id)
);

CREATE TABLE "order" (
  "id" SERIAL,
  "client_id" integer,
  "branch_id" integer,
  "date" date,
  "total" integer,
  primary key (id)
);

CREATE TABLE "item" (
  "id" SERIAL,
  "order_id" integer,
  "product_id" integer,
  "quantity" integer,
  "sales_amount" integer,
  primary key (id)
);

ALTER TABLE "order" ADD FOREIGN KEY ("client_id") REFERENCES "client" ("id");

ALTER TABLE "order" ADD FOREIGN KEY ("branch_id") REFERENCES "branch" ("id");

ALTER TABLE "item" ADD FOREIGN KEY ("order_id") REFERENCES "order" ("id");

ALTER TABLE "item" ADD FOREIGN KEY ("product_id") REFERENCES "product" ("id");

ALTER TABLE "product" ADD FOREIGN KEY ("id_category") REFERENCES "category" ("id");

ALTER TABLE "stock" ADD FOREIGN KEY ("branch_id") REFERENCES "branch" ("id");

ALTER TABLE "stock" ADD FOREIGN KEY ("product_id") REFERENCES "product" ("id");

insert into category ("name") values
('Electronics'),
('Clothes'),
('Home'),
('Sports'),
('Toys');

insert into product ("name", brand, id_category, unit_price) values
('Television', 'Sony', 1, 1000),
('Laptop', 'HP', 1, 800),
('Shirt', 'Zara', 2, 50),
('Pants', 'Levis', 2, 70),
('Frying pan', 'T-fal', 3, 30),
('Towel', 'Cannon', 3, 20),
('Ball', 'Nike', 4, 15),
('Racket', 'Wilson', 4, 50),
('Doll', 'Barbie', 5, 25),
('Car', 'Hot Wheels', 5, 10);

insert into branch ("name", address) values
('Branch A', 'Street 1'),
('Branch B', 'Street 2'),
('Branch C', 'Street 3');

insert into client ("name", phone) values
('Juan', 1234567890),
('Maria', 0987654321),
('Pedro', 5555555555);

insert into "order" (client_id, branch_id, "date", total) values
(1,3,date'2023-06-12',600),
(2,1,date'2023-06-12',705),
(3,3,date'2023-06-12',7000),
(2,3,date'2023-06-12',12200),
(3,3,date'2023-06-12',115),
(1,1,date'2023-06-12',690),
(1,1,date'2023-06-12',950),
(3,3,date'2023-06-12',8050),
(3,2,date'2023-06-12',485),
(2,1,date'2023-06-12',8725),
(2,3,date'2023-06-12',315),
(3,1,date'2023-06-12',16110),
(3,3,date'2023-06-12',975),
(3,3,date'2023-06-12',1490),
(1,1,date'2023-06-12',365);

insert into stock (branch_id, product_id, quantity) values
(1, 1, 65),
(1, 2, 71),
(1, 3, 8),
(1, 4, 42),
(1, 5, 61),
(1, 6, 14),
(1, 7, 70),
(1, 8, 66),
(1, 9, 13),
(1, 10, 68),
(2, 1, 14),
(2, 2, 67),
(2, 3, 74),
(2, 4, 32),
(2, 5, 75),
(2, 6, 37),
(2, 7, 14),
(2, 8, 42),
(2, 9, 51),
(2, 10, 41),
(3, 1, 59),
(3, 2, 98),
(3, 3, 52),
(3, 4, 85),
(3, 5, 31),
(3, 6, 17),
(3, 7, 13),
(3, 8, 18),
(3, 9, 76),
(3, 10, 1);

insert into item (order_id, product_id, quantity, sales_amount) values
(1,9,7,100),
(1,8,8,500),
(2,9,3,225),
(2,5,9,240),
(2,5,10,180),
(2,6,3,60),
(3,1,9,7000),
(4,1,4,5000),
(4,2,8,7200),
(5,6,2,100),
(5,7,3,15),
(6,4,9,140),
(6,9,4,250),
(6,3,2,300),
(7,5,8,300),
(7,9,6,250),
(7,8,2,400),
(8,1,6,2000),
(8,1,10,6000),
(8,3,2,50),
(9,8,9,200),
(9,3,3,150),
(9,7,2,105),
(9,10,5,30),
(10,9,9,225),
(10,1,7,8000),
(10,3,6,500),
(11,7,5,90),
(11,9,8,125),
(11,3,9,100),
(12,2,7,7200),
(12,1,5,8000),
(12,6,9,160),
(12,8,9,350),
(12,8,4,400),
(13,9,4,175),
(13,2,6,800),
(14,1,5,1000),
(14,4,7,490),
(15,9,6,125),
(15,5,9,240);

--the shippest product
select "name" as shippest_product, unit_price as price from product where unit_price=(select min(unit_price) from product);
--the most expensive product
select "name" as most_expensive_product, unit_price as price from product where unit_price=(select max(unit_price) from product);
--the avarage price of all products
select avg(unit_price) as avarage_price_of_products from product;
--total stock of products on each branch
select branch_id as branch, sum(quantity) as stock_of_products from stock group by branch_id;
--total amount of sales per client
select c.name as client_name, count(*) as number_of_orders from "order" o join client c on o.client_id=c.id group by c.id;