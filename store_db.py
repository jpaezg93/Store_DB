import sqlite3

conn = sqlite3.connect('store_db.sqlite')
cur = conn.cursor()
cur.execute('DROP TABLE IF EXISTS category')
cur.execute('DROP TABLE IF EXISTS product')
cur.execute('DROP TABLE IF EXISTS branch')
cur.execute('DROP TABLE IF EXISTS stock')
cur.execute('DROP TABLE IF EXISTS client')
cur.execute('DROP TABLE IF EXISTS item')
#cur.execute('DROP TABLE IF EXISTS order') -> table 'order' is not yet created and there is no need to "deleted yet"

# Create the category table
cur.execute('CREATE TABLE category (id INTEGER PRIMARY KEY, name TEXT)')

# Create the product table
cur.execute('CREATE TABLE product (id INTEGER PRIMARY KEY, name TEXT, brand TEXT, category_id INTEGER, unit_price INTEGER)')

# Create the branch table
cur.execute('CREATE TABLE branch (id INTEGER PRIMARY KEY, name TEXT, address TEXT)')

# Create the stock table
cur.execute('CREATE TABLE stock (id INTEGER PRIMARY KEY, branch_id INTEGER NOT NULL, product_id INTEGER NOT NULL, quantity INTEGER, UNIQUE(branch_id, product_id))')

# Create the client table
cur.execute('CREATE TABLE client (id INTEGER PRIMARY KEY, name TEXT, phone INTEGER)')

# Create the item table
cur.execute('CREATE TABLE item (id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, sales_amount INTEGER)')

# Create the order table
cur.execute('CREATE TABLE order (id INTEGER PRIMARY KEY, client_id INTEGER, branch_id INTEGER, date TEXT, total INTEGER)')


# Create foreign keys
cur.execute('ALTER TABLE order ADD FOREIGN KEY (client_id) REFERENCES client (id)')
cur.execute('ALTER TABLE order ADD FOREIGN KEY (branch_id) REFERENCES branch (id)')
cur.execute('ALTER TABLE item ADD FOREIGN KEY (order_id) REFERENCES order (id)')
cur.execute('ALTER TABLE item ADD FOREIGN KEY (product_id) REFERENCES product (id)')
cur.execute('ALTER TABLE product ADD FOREIGN KEY (id_category) REFERENCES category (id)')
cur.execute('ALTER TABLE branch ADD FOREIGN KEY (id) REFERENCES stock (branch_id)')
cur.execute('ALTER TABLE product ADD FOREIGN KEY (id) REFERENCES stock (product_id)')

conn.commit()
cur.close()