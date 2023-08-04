CREATE TABLE "category" (
  "id" int PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "product" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "brand" varchar,
  "id_category" int,
  "unit_price" int
);

CREATE TABLE "branch" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "address" varchar
);

CREATE TABLE "stock" (
  "id" int PRIMARY KEY,
  "branch_id" int NOT NULL,
  "product_id" int NOT NULL,
  "quantity" int
  UNIQUE("branch_id", "product_id")
);

CREATE TABLE "client" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "phone" int
);

CREATE TABLE "order" (
  "id" int PRIMARY KEY,
  "client_id" int,
  "branch_id" int,
  "date" date,
  "total" int
);

CREATE TABLE "item" (
  "id" int PRIMARY KEY,
  "order_id" int,
  "product_id" int,
  "quantity" int,
  "sales_amount" int
);

ALTER TABLE "order" ADD FOREIGN KEY ("client_id") REFERENCES "client" ("id");

ALTER TABLE "order" ADD FOREIGN KEY ("branch_id") REFERENCES "branch" ("id");

ALTER TABLE "item" ADD FOREIGN KEY ("order_id") REFERENCES "order" ("id");

ALTER TABLE "item" ADD FOREIGN KEY ("product_id") REFERENCES "product" ("id");

ALTER TABLE "product" ADD FOREIGN KEY ("id_category") REFERENCES "category" ("id");

ALTER TABLE "branch" ADD FOREIGN KEY ("id") REFERENCES "stock" ("branch_id");

ALTER TABLE "product" ADD FOREIGN KEY ("id") REFERENCES "stock" ("product_id");
