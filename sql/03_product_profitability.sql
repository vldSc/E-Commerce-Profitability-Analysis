/*
=========================================================
Business Question 1: Product Profitability Analysis

Goal:
Identify the most and least profitable categories
and understand the drivers behind profitability differences.

Analysis sections:
1. Category profitability overview
2. Cost structure analysis
3. Returns impact analysis
4. Pricing efficiency analysis
=========================================================
*/

/*
Business Question 1.1:
What are the most and least profitable categories?
*/

SELECT
    primary_category,
    COUNT(*) AS total_orders,
    ROUND(SUM(net_revenue),2) AS total_revenue,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(profit),2) AS avg_profit_per_order,
    ROUND((SUM(profit)/SUM(net_revenue))*100.0,2) AS profit_margin_pct
FROM orders_staging
GROUP BY primary_category
ORDER BY profit_margin_pct DESC;

/*
Business Question 1.2:
Are product costs, shipping costs, or discounts
driving profitability differences?

*/

SELECT
    primary_category,
    ROUND(AVG(product_cost),2) AS avg_product_cost,
    ROUND(AVG(shipping_cost),2) AS avg_shipping_cost,
    ROUND(AVG(discount_amount),2) AS avg_discount_amount,
    ROUND(SUM(product_cost)/SUM(net_revenue)*100.0,2) AS product_cost_pct_revenue
FROM orders_staging
GROUP BY primary_category
ORDER BY product_cost_pct_revenue;

/*
Business Question 1.3:
Are returns affecting category profitability?
*/

SELECT
    primary_category,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN returned='Yes' THEN 1 ELSE 0 END) AS total_returns,
    ROUND(
        SUM(CASE WHEN returned='Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100.0,
        2
    ) AS return_rate_pct,
    ROUND(SUM(refund_amount),2) AS total_refund_amount
FROM orders_staging
GROUP BY primary_category
ORDER BY return_rate_pct DESC;

/*
Business Question 1.4:
Which categories generate the strongest profit relative to product costs?
*/

SELECT
    primary_category,
    ROUND(SUM(profit)/SUM(product_cost)*100.0,2) AS profit_markup_pct,
    ROUND(SUM(product_cost)/SUM(net_revenue)*100.0,2) AS product_cost_pct_revenue
FROM orders_staging
GROUP BY primary_category
ORDER BY profit_markup_pct DESC;
