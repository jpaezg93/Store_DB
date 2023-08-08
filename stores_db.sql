CREATE TABLE category (
	id INTEGER PRIMARY KEY,
	name TEXT);
CREATE TABLE branch (
	id INTEGER PRIMARY KEY,
	name TEXT,
	address TEXT);
CREATE TABLE product (
	id INTEGER PRIMARY KEY,
	name TEXT,
	brand TEXT,
	unit_price INTEGER,
	category_id INTEGER REFERENCES category (id),
	branch_id INTEGER REFERENCES branch (id));
CREATE TABLE stock (
	id INTEGER PRIMARY KEY,
	branch_id INTEGER NOT NULL REFERENCES branch (id),
	product_id INTEGER NOT NULL REFERENCES product (id),
	quantity INTEGER,
	UNIQUE(branch_id, product_id));
CREATE TABLE client (
	id INTEGER PRIMARY KEY,
	name TEXT,
	phone INTEGER);
CREATE TABLE item (
	id INTEGER PRIMARY KEY,
	quantity INTEGER,
	sales_amount INTEGER,
	order_id INTEGER REFERENCES "order" (id),
	product_id INTEGER REFERENCES product (id));
CREATE TABLE "order" (
	id INTEGER PRIMARY KEY,
	"date" DATE,
	total INTEGER,
	client_id INTEGER REFERENCES client (id),
	branch_id INTEGER REFERENCES branch (id));