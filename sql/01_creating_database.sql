-- Create Database 

CREATE DATABASE ecommerce_profitability;
USE ecommerce_profitability;

-- Creat Table orders

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    order_date DATE,
    channel VARCHAR(50),
    payment_method VARCHAR(50),
    region VARCHAR(50),
    items_ordered INT,
    primary_category VARCHAR(50),
    gross_revenue DECIMAL(10,2),
    discount_pct INT,
    discount_amount DECIMAL(10,2),
    shipping_cost DECIMAL(10,2),
    product_cost DECIMAL(10,2),
    platform_fee DECIMAL(10,2),
    transaction_fee DECIMAL(10,2),
    returned VARCHAR(5),
    refund_amount DECIMAL(10,2),
    net_revenue DECIMAL(10,2),
    total_costs DECIMAL(10,2),
    profit DECIMAL(10,2)
);

-- Load Data Into Table orders
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders_clean.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- Creat Table products
CREATE TABLE products (
    product_id VARCHAR(20) PRIMARY KEY,
	product_name  VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
	unit_cost  DECIMAL(10,2), 
    selling_price DECIMAL(10,2),
    shipping_cost_per_unit DECIMAL(10,2),
    weight_lbs DECIMAL(10,2),
    supplier VARCHAR(20)
);

-- Load Data Into Table products
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products_clean.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Creat Table marketing
CREATE TABLE marketing (
    month DATE,
    platform VARCHAR(50),
    spend DECIMAL(10,2),
    impressions INT,
    clicks INT,
    conversions INT,
    revenue_attributed DECIMAL(10,2),
    cpc DECIMAL(10,2),
    cpa DECIMAL(10,2),
    roas DECIMAL(10,2),

    PRIMARY KEY (month, platform)
);

-- Load Data Into Table marketing
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/marketing_spend_clean.csv'
INTO TABLE marketing
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;





