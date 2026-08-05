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