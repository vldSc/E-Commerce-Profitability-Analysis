/* =========================================================
 Business Question 5: Marketing Budget Optimization 
 
 Goal: Determine how a 20% reduction in the marketing budget 
 could be allocated across advertising platforms and identify 
 the months where budget cuts should be applied. 
 
 Analysis sections: 
 1. Historical Platform Performance 
 2. Platform Budget Reduction Scenario 
 3. Monthly Budget Cut Allocation 
========================================================= */

/* 
Business Question 5.1: 
How did advertising platform performance 
change between 2024 and 2025?
*/

WITH initial_data AS(
	SELECT 
		platform,
        YEAR(`month`) AS 'year',
        ROUND(SUM(spend),2) AS spend,
        ROUND(SUM(revenue_attributed),2) AS revenue
        FROM marketing_staging
        GROUP BY platform,YEAR(`month`)),
platform_years AS (
	SELECT 
		platform,
        ROUND(SUM(CASE WHEN `year` = 2024 THEN spend ELSE 0 END),2) AS spend_2024,
        ROUND(SUM(CASE WHEN `year` = 2025 THEN spend ELSE 0 END),2) AS spend_2025,
		ROUND(SUM(CASE WHEN `year` = 2024 THEN revenue ELSE 0 END),2) AS revenue_2024,
		ROUND(SUM(CASE WHEN `year` = 2025 THEN revenue ELSE 0 END),2) AS revenue_2025,
		ROUND(
			SUM(CASE WHEN `year` = 2024 THEN revenue ELSE 0 END) /
			SUM(CASE WHEN `year` = 2024 THEN spend ELSE 0 END),
			2
		) AS roas_2024,
		ROUND(
			SUM(CASE WHEN `year` = 2025 THEN revenue ELSE 0 END) /
			SUM(CASE WHEN `year` = 2025 THEN spend ELSE 0 END),
			2
		) AS roas_2025
    FROM initial_data
    GROUP BY  platform),
    
platform_years_label AS (
	SELECT 
		*,
        ROUND(roas_2025 - roas_2024,2) AS difference,
        CASE 
			WHEN roas_2024 > roas_2025 THEN 'down' ELSE 'up' END AS `change`
    FROM platform_years)
    
    SELECT *
    FROM platform_years_label
    ORDER BY roas_2024 DESC;
    
/* Business Question 5.2: 
How should a 20% reduction in the 2025 marketing
budget be allocated across advertising platforms? */

WITH initial_data AS(
	SELECT 
		platform,
        YEAR(`month`) AS 'year',
        ROUND(SUM(spend),2) AS spend,
        ROUND(SUM(revenue_attributed),2) AS revenue
        FROM marketing_staging
        GROUP BY platform,YEAR(`month`)),
roas_2024_2025 AS(
	SELECT
		platform,
		ROUND(SUM(CASE WHEN `year` = 2025 THEN spend ELSE 0 END),2) AS spend_2025,
        ROUND(
			SUM(CASE WHEN `year` = 2024 THEN revenue ELSE 0 END) /
			SUM(CASE WHEN `year` = 2024 THEN spend ELSE 0 END),
			2
		) AS roas_2024,
		ROUND(
			SUM(CASE WHEN `year` = 2025 THEN revenue ELSE 0 END) /
			SUM(CASE WHEN `year` = 2025 THEN spend ELSE 0 END),
			2
		) AS roas_2025
	FROM initial_data
    GROUP BY platform),
    
roas_diffrence AS(
	SELECT 
		*,
        ROUND(roas_2025 - roas_2024,2) AS difference,
        ROUND(SUM(spend_2025) OVER() * 0.2, 2) AS cut_optimization
	FROM roas_2024_2025),

cut_levels AS(
	SELECT 
		*,
		CASE 
			WHEN difference >= 0 THEN 0
			WHEN difference < 0 AND difference >= -1 THEN 10
			WHEN difference < -1 AND difference >= -2 THEN 20
			ELSE 50
		END AS cut_weight
	FROM roas_diffrence),
scenario_assumptions AS (
	SELECT 
		*,
		CASE 
			WHEN cut_weight = 0 THEN 0
			ELSE ROUND(cut_optimization*cut_weight/100,2)
		END AS cut_amount
	FROM cut_levels)
SELECT 
	*,
    ROUND(spend_2025 - cut_amount ,2) AS proposed_2026_spend
FROM scenario_assumptions	
ORDER BY roas_2025 DESC;

/* Business Question 5.3:
 Which months should receive budget cuts within 
 the selected advertising platforms? 
 
 Months are ranked by ROAS, starting with the 
 lowest-performing months. Cuts are allocated until 
 the required platform-level reduction is reached. 
 If the final month exceeds the remaining reduction,
 only the required portion of that month's spend
 is recommended for removal. 
*/

WITH initial_data AS (
    SELECT
        platform,
        `month`,
        spend,
        roas,

        ROUND(
            SUM(spend) OVER (
                PARTITION BY platform
                ORDER BY roas
            ), 2
        ) AS cumulative_spend,

        CASE
            WHEN platform = 'Google Ads' THEN 25192.49
            WHEN platform = 'Facebook Ads' THEN 5038.50
            WHEN platform = 'Instagram Ads' THEN 10077.00
            WHEN platform = 'Email Marketing' THEN 10077.00
        END AS cut_amount

    FROM marketing_staging
    WHERE platform IN (
        'Instagram Ads',
        'Google Ads',
        'Facebook Ads',
        'Email Marketing'
    )
    AND YEAR(`month`) = 2025
),

monthly_data AS (
    SELECT
        *,
        LAG(cumulative_spend, 1, 0) OVER (
            PARTITION BY platform
            ORDER BY roas
        ) AS previous_cumulative_spend
    FROM initial_data
)

SELECT
    platform,
    `month`,
    spend,
    roas,
    cut_amount,
    cumulative_spend,
    CASE
        WHEN previous_cumulative_spend >= cut_amount THEN 0
        WHEN cumulative_spend <= cut_amount THEN spend
        ELSE cut_amount - previous_cumulative_spend
    END AS recommended_cut

FROM monthly_data
ORDER BY platform, roas;


