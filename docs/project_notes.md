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

The first business question was analyzed:

**Goal:**
Identify the most and least profitable product categories and understand the factors affecting profitability.

### Key Findings:

- Electronics is the most profitable category with the highest profit margin (31.13%) and highest average profit per order ($52.34).
- Books is the least profitable category with the lowest profit margin (11.94%) and lowest average profit per order ($9.41).

### Profitability Drivers:

- Product costs, shipping costs, discounts, and returns were analyzed to identify the main drivers of profitability differences.
- Shipping costs were relatively similar across categories and do not appear to be a major factor.
- Discount levels and return rates also showed limited impact on profitability differences.
- Pricing efficiency appears to be the main driver, with Electronics achieving the highest profit markup (69.55%) compared with Books (25.12%).

### Analysis Completed:

- Category profitability analysis
- Cost structure analysis
- Returns impact analysis
- Pricing efficiency analysis

### Sales Channel Performance Analysis

The second business question was analyzed:

**Goal:**
Identify the most and least profitable sales channels and understand the factors affecting profitability.

### Key Findings:

- Mobile App is the most profitable sales channel with the highest profit margin (29.76%) and highest average profit per order ($36.32).
- Marketplace is the least profitable sales channel with the lowest profit margin (13.03%) and lowest average profit per order ($15.40).
- Website generated the highest number of orders (795) and the highest total revenue ($92,990.55), while maintaining a strong profit margin (27.01%).

### Profitability Drivers:

- Platform and transaction fees were analyzed to understand their impact on channel profitability.
- Marketplace has the highest average fees per order ($22.94), while Website and Mobile App average approximately $4.00 per order.
- Profitability was also compared across product categories within each sales channel.
- Mobile App consistently achieved higher profit margins across most product categories, while Marketplace and Social Commerce generally reported lower margins.
- Some categories, such as Books, were unprofitable on Marketplace (-6.13%) and Social Commerce (-10.59%).

### Analysis Completed:

- Overall channel profitability analysis
- Channel fee analysis
- Profitability comparison by sales channel and product category

### Returns Analysis

The third business question was analyzed:

**Goal:**
Understand customer return behavior and measure the financial impact of returned orders.

### Key Findings:

- Electronics had the highest return rate (8.61%) and the highest refund amount ($4,078.27), making it the category with the largest financial impact from returns.
- Social Commerce had the highest return rate among sales channels (9.14%), while Website generated the highest total refund amount ($9,383.68) due to its larger order volume.
- Return performance varies by category and sales channel. For example, Clothing showed a high return rate on Social Commerce (13.33%) and Marketplace (11.67%), indicating potential channel-specific issues.

### Analysis Completed:

- Return rate analysis by product category
- Return rate analysis by sales channel
- Refund impact analysis
- Category and sales channel return comparison