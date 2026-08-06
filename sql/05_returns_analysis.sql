/*
=========================================================
Business Question 3: Returns Analysis

Goal:
Analyze product returns and estimate their financial impact.

Analysis sections:
1. Return Rate and Revenue Lost by Category
2. Return Rate by and Revenue Lost Sales Channel
3. Return Rate by and Revenue Lost Category and Channel

=========================================================
*/

/*
Business Question 3.1:
What is the return rate by product category
and how much revenue was lost?
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
	ROUND(SUM(CASE WHEN returned='Yes' THEN refund_amount ELSE 0 END),2) AS total_refund_amount
FROM orders_staging
GROUP BY primary_category
ORDER BY return_rate_pct DESC;

/*
Business Question 3.2:
What is the return rate by sales channel
and how much revenue was lost?
*/

SELECT
    `channel`,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN returned='Yes' THEN 1 ELSE 0 END) AS total_returns,
    ROUND(
        SUM(CASE WHEN returned='Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100.0,
        2
    ) AS return_rate_pct,
	ROUND(SUM(CASE WHEN returned='Yes' THEN refund_amount ELSE 0 END),2) AS total_refund_amount
FROM orders_staging
GROUP BY `channel`
ORDER BY return_rate_pct DESC;


/*
Business Question 3.3:
What is the return rate and financial impact
of each category within each sales channel?
*/

SELECT
	`channel`,
	primary_category,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN returned='Yes' THEN 1 ELSE 0 END) AS total_returns,
        ROUND(
        SUM(CASE WHEN returned='Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100.0,
        2
    ) AS return_rate_pct,
	ROUND(SUM(CASE WHEN returned='Yes' THEN refund_amount ELSE 0 END),2) AS total_refund_amount
FROM orders_staging
GROUP BY `channel`, primary_category
ORDER BY `channel`, total_refund_amount DESC;