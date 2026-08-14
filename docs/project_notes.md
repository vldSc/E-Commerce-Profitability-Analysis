# Project Notes

## Initial Observations

- Dataset contains e-commerce sales, product, and marketing data.
- Analysis focuses on profitability optimization.
- Data cleaning steps will be documented after exploration.

## Dataset Limitations

- The `orders` dataset contains product categories but not individual product IDs.
- As a result, product performance can only be analyzed at the **category level**.
- Individual product or supplier performance cannot be linked to customer orders.

## Data Quality Summary

- No missing values were found in any dataset.
- No duplicate records were identified.
- Financial metrics (profit, total_costs, CPC, CPA, and ROAS) were successfully validated.
- The `order_date` and `month` columns are currently stored as strings and will be converted to the DATE data type during data preparation.
- Product-level analysis is limited because the `orders` dataset contains product categories rather than individual product IDs.

## Data Preparation

- Converted date columns (`order_date` and `month`) from string to datetime format.
- Validated that no missing values or duplicates were introduced.
- Confirmed financial and marketing metrics remained accurate after transformation.
- Exported cleaned datasets for SQL import.

## Database Validation

- Cleaned datasets were imported into MySQL.
- Row counts were verified after import.
- Missing values, duplicates, and data types were checked again inside the database.
- The database is ready for business analysis.

## Business Analysis Progress

### Product Profitability Analysis

The 1st business question was analyzed:

**Goal:**
Identify the most and least profitable product categories and understand the factors affecting profitability.

#### Key Findings:

- Electronics is the most profitable category with the highest profit margin (31.13%) and highest average profit per order ($52.34).
- Books is the least profitable category with the lowest profit margin (11.94%) and lowest average profit per order ($9.41).

#### Profitability Drivers:

- Product costs, shipping costs, discounts, and returns were analyzed to identify the main drivers of profitability differences.
- Shipping costs were relatively similar across categories and do not appear to be a major factor.
- Discount levels and return rates also showed limited impact on profitability differences.
- Pricing efficiency appears to be the main driver, with Electronics achieving the highest profit markup (69.55%) compared with Books (25.12%).

#### Analysis Completed:

- Category profitability analysis
- Cost structure analysis
- Returns impact analysis
- Pricing efficiency analysis

### Sales Channel Performance Analysis

The 2nd business question was analyzed:

**Goal:**
Identify the most and least profitable sales channels and understand the factors affecting profitability.

#### Key Findings:

- Mobile App is the most profitable sales channel with the highest profit margin (29.76%) and highest average profit per order ($36.32).
- Marketplace is the least profitable sales channel with the lowest profit margin (13.03%) and lowest average profit per order ($15.40).
- Website generated the highest number of orders (795) and the highest total revenue ($92,990.55), while maintaining a strong profit margin (27.01%).

#### Profitability Drivers:

- Platform and transaction fees were analyzed to understand their impact on channel profitability.
- Marketplace has the highest average fees per order ($22.94), while Website and Mobile App average approximately $4.00 per order.
- Profitability was also compared across product categories within each sales channel.
- Mobile App consistently achieved higher profit margins across most product categories, while Marketplace and Social Commerce generally reported lower margins.
- Some categories, such as Books, were unprofitable on Marketplace (-6.13%) and Social Commerce (-10.59%).

#### Analysis Completed:

- Overall channel profitability analysis
- Channel fee analysis
- Profitability comparison by sales channel and product category

### Returns Analysis

The 3rd business question was analyzed:

**Goal:**
Understand customer return behavior and measure the financial impact of returned orders.

#### Key Findings:

- Electronics had the highest return rate (8.61%) and the highest refund amount ($4,078.27), making it the category with the largest financial impact from returns.
- Social Commerce had the highest return rate among sales channels (9.14%), while Website generated the highest total refund amount ($9,383.68) due to its larger order volume.
- Return performance varies by category and sales channel. For example, Clothing showed a high return rate on Social Commerce (13.33%) and Marketplace (11.67%), indicating potential channel-specific issues.

#### Analysis Completed:

- Return rate analysis by product category
- Return rate analysis by sales channel
- Refund impact analysis
- Category and sales channel return comparison

### Marketing Performance Analysis

The 4th business question was analyzed:

**Goal:**
Evaluate advertising platform performance using CPC, CPA, and ROAS and identify the most efficient platforms.

#### Key Findings:

- TikTok Ads is the most efficient platform, with the lowest CPC ($0.15), lowest CPA ($3.06), and highest ROAS (24.02).
- Influencer generates the highest total attributed revenue ($2.22M), (22.70) than TikTok Ads.
- Email Marketing has the lowest performance, with the highest CPC ($0.94), highest CPA ($17.86), and lowest ROAS (4.81).
- All advertising platforms have a ROAS above 1, meaning every platform generated more attributed revenue than advertising spend.
- TikTok Ads and Influencer improved their ROAS in 2025 compared with 2024, while the other platforms declined.

#### Analysis Completed:

- Overall platform performance analysis
- CPC and CPA comparison
- ROAS comparison
- Conversion rate and revenue per conversion analysis
- Year-over-year ROAS analysis

### Marketing Budget Optimization

The 5th business question was analyzed:

**Goal:**
Determine how a 20% reduction in the marketing budget could be allocated across advertising platforms and identify the months where budget cuts should be applied.

#### Scenario Assumptions:

- The 2025 total marketing spend was used as the baseline for the 2026 budget scenario.
- A 20% reduction of the 2025 marketing budget was assumed.
- Platform performance was evaluated by comparing ROAS between 2024 and 2025.
- Platforms with stable or improving ROAS were protected from budget cuts.
- Larger cuts were assigned to platforms where ROAS declined more significantly.
- The resulting platform-level cuts were then allocated to the lowest-performing months based on monthly ROAS.
- When the required reduction was reached partway through a month, only the remaining required amount was recommended as the cut rather than removing the entire month's budget.

#### Platform Cut Strategy:

- No cut: ROAS increased or remained stable.
- 10% of the optimization amount: ROAS decline between 0 and -1.
- 20% of the optimization amount: ROAS decline between -1 and -2.
- 50% of the optimization amount: ROAS decline below -2.

#### Analysis Completed:

- 2024 vs. 2025 platform ROAS comparison
- 20% marketing budget reduction scenario
- Platform-level budget allocation
- Monthly ROAS performance analysis
- Monthly budget cut recommendations
- Partial budget cut allocation for the final month when necessary

#### Final Output Tables

Two final analytical tables were created for Tableau:

- scenario_table_platforms — platform-level budget allocation and proposed 2026 spending.
- scenario_table_cut_months — monthly budget cuts prioritized by historical ROAS performance.

## Visualization

The analysis was visualized in Tableau using six dashboards:

1. Executive Summary
2. Product Profitability
3. Channel Profitability
4. Returns Analysis
5. Marketing Performance
6. Marketing Budget Optimization

The dashboards were designed to communicate the main business findings,
profitability drivers, return patterns, marketing performance, and the
20% marketing budget optimization scenario.

The final Tableau workbook is available in the `tableau/` directory.
Dashboard screenshots are available in the `images/` directory.