/*
=========================================================
Business Question 2: Channel Profitability Analysis

Goal:
Identify the most and least profitable channel
and understand the drivers behind profitability differences.

Analysis sections:
1. Overall Channel Profitability
2. Channel Fee Analysis
3. Profitability by Channel and Category

=========================================================
*/

/*
Business Question 2.1:
What are the most and least profitable channels?
*/
SELECT
    `channel`,
    COUNT(*) AS total_orders,
    ROUND(SUM(net_revenue),2) AS total_revenue,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(profit),2) AS avg_profit_per_order,
    ROUND((SUM(profit)/SUM(net_revenue))*100,2) AS profit_margin_pct,
    ROUND(SUM(platform_fee),2) AS total_platform_fee,
    ROUND(SUM(transaction_fee),2) AS total_transaction_fee
FROM orders_staging
GROUP BY `channel`
ORDER BY profit_margin_pct DESC;

/*
Business Question 2.2:
How much do platform and transaction fees contribute
to the profitability of each sales channel?
*/

SELECT
    `channel`,
    ROUND(AVG(platform_fee),2) AS avg_platform_fee,
    ROUND(AVG(transaction_fee),2) AS avg_transaction_fee,
    ROUND((SUM(platform_fee)+SUM(transaction_fee))/COUNT(*),2) AS total_fees_per_order
FROM orders_staging
GROUP BY `channel`
ORDER BY total_fees_per_order DESC;

/*
Business Question 2.3A:
Compare channel profitability within each product category.
*/


SELECT
	`channel`,
	primary_category,
    COUNT(*) AS total_orders,
    ROUND((SUM(profit)/SUM(net_revenue))*100,2) AS profit_margin_pct
FROM orders_staging
GROUP BY `channel`, primary_category
ORDER BY primary_category ;


/*
Business Question 2.3B:
Identify the most and least profitable categories within each sales channel.
*/

SELECT
	`channel`,
	primary_category,
    COUNT(*) AS total_orders,
    ROUND((SUM(profit)/SUM(net_revenue))*100,2) AS profit_margin_pct
FROM orders_staging
GROUP BY `channel`, primary_category
ORDER BY `channel`, profit_margin_pct DESC;
