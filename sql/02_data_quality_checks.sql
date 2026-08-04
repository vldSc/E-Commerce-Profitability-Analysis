 -- Create orders_staging tables for validation
CREATE TABLE orders_staging
LIKE orders;

INSERT orders_staging
SELECT *
FROM orders;

SELECT *
FROM orders;

-- Create products_staging tables for validation
CREATE TABLE products_staging
LIKE products;

INSERT products_staging
SELECT *
FROM products;

SELECT *
FROM products_staging;

-- Create marketing_staging tables for validation
CREATE TABLE marketing_staging
LIKE marketing;

INSERT marketing_staging
SELECT *
FROM marketing;

SELECT *
FROM marketing_staging;

-- Data Type Check

DESCRIBE orders_staging;
DESCRIBE products_staging;
DESCRIBE marketing_staging;

-- Check the rows count 

SELECT COUNT(*) AS total_orders
FROM orders_staging;

SELECT COUNT(*) AS total_products
FROM products_staging;

SELECT COUNT(*) AS total_marketing
FROM marketing_staging;

-- Checking the Primary Keys for duplicates

-- Orders should have unique order_id
SELECT 
    order_id,
    COUNT(*) AS duplicate_count
FROM orders_staging
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Products should have unique product_id
SELECT 
    product_id,
    COUNT(*) AS duplicate_count
FROM products_staging
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Marketing should have unique month-platform combinations
SELECT 
    month,
    platform,
    COUNT(*) AS duplicate_count
FROM marketing_staging
GROUP BY month, platform
HAVING COUNT(*) > 1;

-- Check missing values in important columns

SELECT 
    COUNT(*) AS missing_orders
FROM orders_staging
WHERE 
    order_id IS NULL
    OR order_date IS NULL
    OR profit IS NULL;
    
SELECT 
    COUNT(*) AS missing_products
FROM products_staging
WHERE 
    product_id IS NULL
    OR category IS NULL;
    
SELECT 
    COUNT(*) AS missing_marketing
FROM marketing_staging
WHERE
    month IS NULL
    OR platform IS NULL;

-- Validate profit and total_cost calculation

SELECT 
    SUM(net_revenue - total_costs - profit) AS profit_difference,
	SUM(
        product_cost 
        + shipping_cost 
        + platform_fee 
        + transaction_fee 
        - total_costs
    ) AS cost_difference
FROM orders_staging;

-- Validate marketing metrics

SELECT 
    MAX(ABS((spend / NULLIF(clicks,0)) - cpc)) AS max_cpc_error,
    MAX(ABS((spend / NULLIF(conversions,0)) - cpa)) AS max_cpa_error,
    MAX(ABS((revenue_attributed /  NULLIF(spend,0)) - roas)) AS max_roas_error
FROM marketing_staging;
