CREATE TABLE sales.products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(255) NOT NULL,
  product_description TEXT,
  price DECIMAL(10,2) NOT NULL,
  record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE sales.orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL DEFAULT CURRENT_DATE,
  total_amount DECIMAL(10,2) NOT NULL,
  record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE sales.order_details (
  order_detail_id SERIAL PRIMARY KEY,
  order_id INT NOT NULL REFERENCES sales.orders (order_id),
  product_id INT NOT NULL REFERENCES sales.products (product_id),
  quantity INT NOT NULL CHECK (quantity >= 0),
  unit_price DECIMAL(10,2) NOT NULL,
  record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE sales.orders ADD CONSTRAINT ck_order_date CHECK (order_date > '2000-01-01');
ALTER TABLE sales.order_details ADD CONSTRAINT ck_gender CHECK (gender IN ('Male', 'Female'));
ALTER TABLE sales.order_details ADD CONSTRAINT ck_product_id UNIQUE (product_id);


INSERT INTO sales.products (product_name, product_description, price)
VALUES ('iPhone 14 Pro', 'The latest and greatest iPhone.', 999.99),
       ('Samsung Galaxy S23 Ultra', 'The best Android phone on the market.', 1199.99);

INSERT INTO sales.orders (customer_id, order_date, total_amount)
VALUES (1, '2023-10-29', 1999.98);

INSERT INTO sales.order_details (order_id, product_id, quantity, unit_price)
VALUES (1, 1, 1, 999.99),
       (1, 2, 1, 1199.99);

ALTER TABLE sales.products ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL;
ALTER TABLE sales.orders ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL;
ALTER TABLE sales.order_details ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL;