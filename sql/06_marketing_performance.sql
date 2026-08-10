/*
=========================================================
Business Question 4: Marketing Performance Analysis

Goal:
Evaluate advertising platform performance using CPC, CPA,
and ROAS, and identify the most efficient platforms.

Analysis sections:
1. Overall Marketing Performance by Platform
2. ROAS Performance by Year

=========================================================
*/


/*
Business Question 4.1:
Which advertising platforms deliver the best performance
based on CPC, CPA, and ROAS?
*/

WITH cpc_cpa_roas AS(
	SELECT 
		platform,
		ROUND(SUM(spend),2) AS total_spend,
		ROUND(SUM(revenue_attributed),2) AS total_revenue_attributed,
        ROUND(SUM(conversions),2) AS total_conversion,
		ROUND(SUM(conversions)/SUM(clicks)*100.0,2) AS conversions_rate_pct,
        ROUND(SUM(revenue_attributed)/SUM(conversions),2) AS revenue_per_conversion,
		ROUND(SUM(spend)/SUM(clicks),2) AS cpc,
		ROUND(SUM(spend)/SUM(conversions),2) AS cpa,
		ROUND(SUM(revenue_attributed)/SUM(spend),2) AS roas
	FROM marketing_staging
    GROUP BY platform),
    
metrics_labels AS (
    SELECT
        *,
        MIN(cpc) OVER() AS min_cpc,
        MAX(cpc) OVER() AS max_cpc,
		MIN(cpa) OVER() AS min_cpa,
        MAX(cpa) OVER() AS max_cpa,
        MIN(roas) OVER() AS min_roas,
        MAX(roas) OVER() AS max_roas
    FROM cpc_cpa_roas)
    
SELECT 	
	platform,
    total_spend,
    total_revenue_attributed,
    total_conversion,
    conversions_rate_pct,
    revenue_per_conversion,
    cpc,
CASE 
    WHEN cpc = min_cpc THEN 'Best CPC'
    WHEN cpc = max_cpc THEN 'Worst CPC'
    ELSE 'Other'
END AS label_cpc,
	cpa,
CASE 
    WHEN cpa = min_cpa THEN 'Best CPA'
    WHEN cpa = max_cpa THEN 'Worst CPA'
    ELSE 'Other'
END AS label_cpa,
	roas,
CASE 
    WHEN roas = min_roas THEN 'Worst roas'
    WHEN roas = max_roas THEN 'Best roas'
    ELSE 'Other'
END AS label_roas
FROM metrics_labels
ORDER BY roas DESC;


/*
Business Question 4.2:
How did ROAS change between 2024 and 2025
for each advertising platform?
*/
    
WITH initial_data AS(
	SELECT 
		platform,
        YEAR(`month`) AS 'year',
        ROUND(SUM(revenue_attributed)/SUM(spend),2) AS roas
        FROM marketing_staging
        GROUP BY platform,YEAR(`month`)),
platform_years AS (
	SELECT 
		platform,
    ROUND(SUM(CASE WHEN `year` = 2024 THEN roas ELSE 0 END),2) AS roas_2024,
	ROUND(SUM(CASE WHEN `year` = 2025 THEN roas ELSE 0 END),2) AS roas_2025
    FROM initial_data
    GROUP BY  platform),
    
platform_years_label AS (
	SELECT 
		*,
        CASE 
			WHEN roas_2024 > roas_2025 THEN 'down' ELSE 'up' END AS `change`
    FROM platform_years)
    
    SELECT *
    FROM platform_years_label
    ORDER BY roas_2024 DESC;