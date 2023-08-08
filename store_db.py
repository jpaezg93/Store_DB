import sqlite3

conn = sqlite3.connect('store_db.sqlite')
cur = conn.cursor()
cur.execute('DROP TABLE IF EXISTS "category"')
cur.execute('DROP TABLE IF EXISTS "product"')
cur.execute('DROP TABLE IF EXISTS "branch"')
cur.execute('DROP TABLE IF EXISTS "stock"')
cur.execute('DROP TABLE IF EXISTS "client"')
cur.execute('DROP TABLE IF EXISTS "item"')
cur.execute('DROP TABLE IF EXISTS "order"')

# Create the category table
cur.execute('''CREATE TABLE "category" (
    id INTEGER PRIMARY KEY,
    name TEXT)''')

# Create the branch table
cur.execute('''CREATE TABLE "branch" (
	id INTEGER PRIMARY KEY,
	name TEXT,
	address TEXT)''')

# Create the product table
cur.execute('''CREATE TABLE "product" (
	id INTEGER PRIMARY KEY,
	name TEXT,
	brand TEXT,
	unit_price INTEGER,
	category_id INTEGER REFERENCES category (id),
	branch_id INTEGER REFERENCES branch (id))''')

# Create the stock table
cur.execute('''CREATE TABLE "stock" (
	id INTEGER PRIMARY KEY,
	branch_id INTEGER NOT NULL REFERENCES branch (id),
	product_id INTEGER NOT NULL REFERENCES product (id),
	quantity INTEGER,
	UNIQUE(branch_id, product_id))''')

# Create the client table
cur.execute('''CREATE TABLE "client" (
	id INTEGER PRIMARY KEY,
	name TEXT,
	phone INTEGER)''')

# Create the order table
cur.execute('''CREATE TABLE "order" (
	id INTEGER PRIMARY KEY,
	"date" DATE,
	total INTEGER,
	client_id INTEGER REFERENCES client (id),
	branch_id INTEGER REFERENCES branch (id))''')

# Create the item table
cur.execute('''CREATE TABLE item (
	id INTEGER PRIMARY KEY,
	quantity INTEGER,
	sales_amount INTEGER,
	order_id INTEGER REFERENCES "order" (id),
	product_id INTEGER REFERENCES product (id))''')

conn.commit()
cur.close()