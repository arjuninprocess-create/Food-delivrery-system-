CREATE DATABASE food_delivery;
USE food_delivery;

CREATE TABLE restaurant(restaurant_id INT PRIMARY KEY, name VARCHAR(75), address VARCHAR(150), phone_no VARCHAR(25));

CREATE TABLE driver(driver_id INT PRIMARY KEY, name VARCHAR(75), phone_no VARCHAR(25), vehicle_no VARCHAR(25));

CREATE TABLE customer(customer_id INT PRIMARY KEY, first_name VARCHAR(50), last_name VARCHAR(50), email VARCHAR(75), phone_no VARCHAR(25), address VARCHAR(150));

CREATE TABLE orders(order_id INT PRIMARY KEY, customer_id INT, restaurant_id INT, driver_id INT, order_date DATE, status VARCHAR(30), total_amount DECIMAL(10,2) NOT NULL,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id),
FOREIGN KEY (driver_id) REFERENCES driver(driver_id));

CREATE TABLE menu_item(menu_item_id INT PRIMARY KEY, restaurant_id INT, item_name VARCHAR(100), price DECIMAL(10,2), category VARCHAR(40),
FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id));

CREATE TABLE order_item(order_item INT PRIMARY KEY, order_id INT, menu_item_id INT, quantity INT NOT NULL, unit_price DECIMAL(10,2), 
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (menu_item_id) REFERENCES menu_item(menu_item_id));

CREATE TABLE payment(payment_id INT PRIMARY KEY, order_id INT, amount DECIMAL(10,2), payment_method VARCHAR(50), payment_status VARCHAR(50), payment_date DATE, 
FOREIGN KEY (order_id) REFERENCES orders(order_id));




ALTER TABLE customer
ADD CONSTRAINT customer_email UNIQUE(email);

ALTER TABLE menu_item
ADD CONSTRAINT check_menu_price CHECK (price >= 0);

ALTER TABLE order_item
ADD CONSTRAINT check_order_item CHECK (quantity > 0);

ALTER TABLE orders
ADD CONSTRAINT check_total_amount CHECK (total_amount > 0);

ALTER TABLE payment
ADD CONSTRAINT check_amount CHECK (amount > 0);



CREATE INDEX idx_order_date
ON orders(order_date);



USE food_delivery;

INSERT INTO restaurant VALUES(1, "Pizza House", "12, Alexanderplatz Berlin", "09898923"),
(2, "Burger King", "47, Neukoln Berlin", "676767"),
(3, "Pujnabi hotel", "30 hermenstarsse Berlin", "2222-222"),
(4, "Nila kitchen", "90 spandau Berlin", "22 55");

INSERT INTO driver VALUES(1, "thomas m.", "90456222", "100"),
(2, "shasi t.", "567567-000", "101"),
(3, "shreya b.", "1111-1111", "102"),
(4, " bonny b.", "69696900", "103"),
(5, "holland h.", "43232545", "104"),
(6, "tom h.", "897640", "105");

INSERT INTO customer VALUES(1, "arjun", "sunil", "arjun@gmail.com", "111-111", "84 shonholtz Berlin"),
(2, "rishan", "mohammed", "rishan34@gmail.com", "2323-45", "98 spandau Berlin"),
(3, "janvi", "jain", "janvi123@gmai.com", "8907-234", "77 junferhelde Berlin"),
(4, "dhanash", "hari", "hari567@gmail.com","90909", "45 gessenbrunnen Berlin"),
(5, "abhai", "job", "job45@gmail.com", "34321-33", "322 hermanplatz Berlin");


INSERT INTO orders VALUES (1, 2, 3 , 4, "2026-09-23", "pending", 23.09),
(2, 3, 4, 1, "2026-07-22", "delivered", 17.66),
(3, 4, 1, 5, "2026-06-06", "delivered", 45.55),
(4, 1, 3, 6, "2026-08-20", "delivered", 39.09),
(5, 2, 2, 2, "2026-09-23", "pending", 20.08);

INSERT INTO menu_item VALUES (1, 1, "chicken-pizza", 14.99, "pizza"),
(2, 1, "alfredo burger", 13.22, "burger"),
(3, 2, "beef putha", 13.44, "burger"),
(4, 2, "patty 2x bruda", 21.99, "burger"),
(5, 2, "coka kooma", 4.50, "drink"),
(6, 3, "butter chicken", 14.50, "meal"),
(7, 3, "chicken thika", 12.42, "meal"),
(8, 3, "samoosa", 5.99, "snack"),
(9, 4, "porotta", 3.99, "meal"),
(10, 4, "beef roast", 9.99, "curry"),
(11, 4, "cuppa curry", 7.99, "curry"),
(12, 4, "kuzhi mandi", 14.59, "meal");

INSERT INTO order_item VALUES (1, 1, 4, 1, 14.99),
(2, 2, 12, 1, 14.59),
(3, 3, 10, 2, 20.00),
(4, 4, 8, 3, 17.89),
(5, 5, 6, 1, 14.50);

INSERT INTO payment VALUES(1, 1, 14.99, "card", "paid", "2026-09-03"),
(2, 2, 14.59, "paypal", "paid", "2026-07-22"),
(3, 3, 20.00, "card", "paid", "2026-06-06"),
(4, 4, 17.89, "paypal", "pending", "2026-08-20"),
(5, 5, 14.50, "paypal", "pending", "2026-09-23");

SELECT * FROM customer;

SELECT * FROM orders
WHERE order_id = 2;

SELECT * FROM customer
ORDER BY first_name;

UPDATE customer
SET phone_no = "121212"
WHERE customer_id = 1;

DELETE FROM customer
WHERE customer_id = 5;

SELECT * FROM customer;

INSERT INTO customer VALUES(5, "abhai", "job", "job67@gmail.com", "323332", "666 shionefelde Berlin");

SELECT * FROM customer;



SELECT orders.order_id, customer.first_name, customer.last_name, orders.total_amount
FROM orders
JOIN customer
ON orders.customer_id = customer.customer_id;

SELECT SUM(amount) AS total_revenue
FROM payment;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT AVG(total_amount) AS avg_order_value
FROM orders;
