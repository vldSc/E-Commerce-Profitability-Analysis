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
