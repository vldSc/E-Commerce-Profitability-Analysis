/*
=========================================================
Create Analysis Tables

Purpose:
Create the final analytical tables used for visualization
and reporting in Tableau.

Tables created:
1. scenario_table_platforms
   - Platform-level marketing budget optimization scenario.

2. scenario_table_cut_months
   - Monthly budget cut allocation for platforms selected
     for budget reduction.

=========================================================
*/



CREATE TEMPORARY TABLE historical_tabel_2025 AS ( 
	SELECT 
		platform,
        ROUND(SUM(spend),2) AS spend_2025,
		ROUND(SUM(revenue_attributed),2) AS revenue_2025,
		ROUND(SUM(revenue_attributed)/SUM(spend),2) AS roas_2025
    FROM marketing_staging
	WHERE YEAR(`month`) = 2025
    GROUP BY  platform
   
);

/*
=========================================================
Table 1: scenario_table_platforms

Purpose:
Store the final platform-level budget optimization
scenario for Tableau.

Includes:
- 2025 spend and revenue
- 2024 and 2025 ROAS
- ROAS change
- Total 20% optimization amount
- Platform cut weight
- Recommended cut amount
- Proposed 2026 spend
=========================================================
*/

CREATE TABLE scenario_table_platforms AS ( 
	SELECT 
		platform,
        ROUND(SUM(spend),2) AS spend_2025,
		ROUND(SUM(revenue_attributed),2) AS revenue_2025,
		ROUND(SUM(revenue_attributed)/SUM(spend),2) AS roas_2025
    FROM marketing_staging
	WHERE YEAR(`month`) = 2025
    GROUP BY  platform
   
);

ALTER TABLE scenario_table_platforms
ADD COLUMN roas_2024 DECIMAL(10,2),
ADD COLUMN difference DECIMAL(10,2),
ADD COLUMN cut_optimization DECIMAL(10,2),
ADD COLUMN cut_weight INT,
ADD COLUMN cut_amount DECIMAL(10,2),
ADD COLUMN proposed_2026_spend DECIMAL(10,2);
    
UPDATE scenario_table_platforms t1
JOIN (
    SELECT
        platform,
        ROUND(SUM(revenue_attributed) / SUM(spend), 2) AS roas_2024
    FROM marketing_staging
    WHERE YEAR(`month`) = 2024
    GROUP BY platform
) t2
    ON t1.platform = t2.platform
SET t1.roas_2024 = t2.roas_2024;


UPDATE scenario_table_platforms
SET difference = ROUND(roas_2025 - roas_2024, 2);

UPDATE scenario_table_platforms
SET cut_optimization =  (  
	SELECT ROUND(SUM(spend_2025) * 0.20, 2)
    FROM historical_tabel_2025
);


UPDATE scenario_table_platforms
SET cut_weight =
    CASE
        WHEN difference >= 0 THEN 0
        WHEN difference >= -1 THEN 10
        WHEN difference >= -2 THEN 20
        ELSE 50
    END;

UPDATE scenario_table_platforms
SET cut_amount = ROUND(
    cut_optimization * cut_weight / 100,
    2
);
    
UPDATE scenario_table_platforms
SET proposed_2026_spend = ROUND(
    spend_2025 - cut_amount,
    2
);


SELECT
    platform,
    ROUND(SUM(recommended_cut), 2) AS monthly_cut,
    MAX(cut_amount) AS platform_cut
FROM scenario_table_cut_months
GROUP BY platform;


SELECT *
FROM scenario_table_platforms;

/*
=========================================================
Table 2: scenario_table_cut_months

Purpose:
Store the monthly budget cut allocation for platforms
selected for budget reduction.

Months are prioritized by ROAS, with lower-performing
months receiving budget cuts first.

Includes:
- Platform
- Month
- Monthly spend
- Monthly ROAS
- Cumulative spend
- Platform cut amount
- Recommended monthly cut
=========================================================
*/

CREATE TABLE scenario_table_cut_months AS ( 
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
        ) AS cumulative_spend

    FROM marketing_staging
    WHERE platform IN (
        'Instagram Ads',
        'Google Ads',
        'Facebook Ads',
        'Email Marketing'
    )
    AND YEAR(`month`) = 2025
);

ALTER TABLE scenario_table_cut_months
ADD COLUMN cut_amount DECIMAL(10,2),
ADD COLUMN recommended_cut DECIMAL(10,2);

UPDATE scenario_table_cut_months t1
JOIN (
    SELECT
        platform,
        cut_amount
	FROM scenario_table_platforms
) t2
    ON t1.platform = t2.platform
SET t1.cut_amount = t2.cut_amount;

UPDATE scenario_table_cut_months
SET recommended_cut =
    CASE
        -- The required cut has already been reached
        WHEN cumulative_spend - spend >= cut_amount
            THEN 0

        -- This entire month spend is needed for the cut
        WHEN cumulative_spend <= cut_amount
            THEN spend

        -- Only part of this month's spend is needed
        ELSE cut_amount - (cumulative_spend - spend)
    END;


SELECT
    ROUND(SUM(cut_amount), 2) AS total_cut,
    MAX(cut_optimization) AS required_cut
FROM scenario_table_platforms;

SELECT *
FROM scenario_table_cut_months;





