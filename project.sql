PRAGMA foreign_keys = ON;

-- 1. Customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    city TEXT NOT NULL,
    reg_date TEXT NOT NULL
);

-- 2. Products table
CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT NOT NULL,
    price REAL NOT NULL CHECK (price >= 0),
    stock_quantity INTEGER NOT NULL CHECK (stock_quantity >= 0)
);

-- Insert customers
INSERT INTO customers VALUES
(1, 'Anitha', 'anitha12@gmail.com', 'Chennai', '2026-10-20'),
(2, 'Priya Sharma', 'priya@example.com', 'Bengaluru', '2026-01-15'),
(3, 'Karthik Raj', 'karthik@example.com', 'Chennai', '2026-02-01'),
(4, 'Divya S', 'divya@example.com', 'Hyderabad', '2026-02-10'),
(5, 'Manoj Kumar', 'manoj@example.com', 'Bengaluru', '2026-03-05');

-- Insert products
INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 55000, 10),
(2, 'Mouse', 'Accessories', 500, 50),
(3, 'Keyboard', 'Accessories', 1200, 30),
(4, 'Smartphone', 'Electronics', 25000, 15),
(5, 'Headphones', 'Audio', 1800, 20),
(6, 'Monitor', 'Electronics', 12000, 8),
(7, 'USB Cable', 'Accessories', 250, 100),
(8, 'Speaker', 'Audio', 3500, 12);

-- 3. Basic data queries

-- Display all customers
SELECT *
FROM customers
ORDER BY customer_id;

-- Display products from highest to lowest price
SELECT product_id, product_name, category, price, stock_quantity
FROM products
ORDER BY price DESC, product_name;

-- Find products priced at or above 1,000
SELECT product_name, category, price
FROM products
WHERE price >= 1000
ORDER BY price DESC;

-- Find products with low stock (10 units or fewer)
SELECT product_name, stock_quantity
FROM products
WHERE stock_quantity <= 10
ORDER BY stock_quantity, product_name;

-- Find customers registered in Chennai
SELECT customer_id, name, email, reg_date
FROM customers
WHERE city = 'Chennai'
ORDER BY name;

-- 4. Aggregate analysis

-- Summarize products by category
SELECT
    category,
    COUNT(*) AS product_count,
    ROUND(AVG(price), 2) AS average_price,
    SUM(stock_quantity) AS units_in_stock,
    ROUND(SUM(price * stock_quantity), 2) AS inventory_value
FROM products
GROUP BY category
ORDER BY inventory_value DESC;

-- Count customers in each city
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC, city;

-- Show overall inventory statistics
SELECT
    COUNT(*) AS product_count,
    SUM(stock_quantity) AS total_units_in_stock,
    ROUND(AVG(price), 2) AS average_product_price,
    ROUND(SUM(price * stock_quantity), 2) AS total_inventory_value
FROM products;

-- Count registrations by month
SELECT
    strftime('%Y-%m', reg_date) AS registration_month,
    COUNT(*) AS customer_count
FROM customers
GROUP BY registration_month
ORDER BY registration_month;

-- 5. Advanced analysis

-- Rank products by price within each category
SELECT
    product_name,
    category,
    price,
    RANK() OVER (
        PARTITION BY category
        ORDER BY price DESC
    ) AS price_rank_in_category
FROM products
ORDER BY category, price_rank_in_category, product_name;

-- Find products priced above their category's average
SELECT
    p.product_name,
    p.category,
    p.price,
    ROUND(category_average.average_price, 2) AS category_average_price
FROM products AS p
JOIN (
    SELECT category, AVG(price) AS average_price
    FROM products
    GROUP BY category
) AS category_average
    ON category_average.category = p.category
WHERE p.price > category_average.average_price
ORDER BY p.category, p.price DESC;

-- Classify stock levels
SELECT
    product_name,
    stock_quantity,
    CASE
        WHEN stock_quantity = 0 THEN 'Out of stock'
        WHEN stock_quantity <= 10 THEN 'Low stock'
        WHEN stock_quantity <= 30 THEN 'Medium stock'
        ELSE 'Well stocked'
    END AS stock_status
FROM products
ORDER BY stock_quantity, product_name;

-- Find the most expensive product in each category (including ties)
WITH ranked_products AS (
    SELECT
        product_name,
        category,
        price,
        RANK() OVER (
            PARTITION BY category
            ORDER BY price DESC
        ) AS category_price_rank
    FROM products
)
SELECT product_name, category, price
FROM ranked_products
WHERE category_price_rank = 1
ORDER BY category, product_name;

-- 6. Indexes for common filters and joins
CREATE INDEX IF NOT EXISTS idx_customers_city
    ON customers(city);

CREATE INDEX IF NOT EXISTS idx_customers_reg_date
    ON customers(reg_date);

CREATE INDEX IF NOT EXISTS idx_products_category
    ON products(category);