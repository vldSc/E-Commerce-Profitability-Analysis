# E-Commerce-Profitability-Analysis
End-to-end data analysis project focused on identifying key drivers of e-commerce profitability using SQL, Python, and Tableau.

## Overview
The goal of this project is to analyze e-commerce profitability, identify the main drivers affecting profit margins, evaluate sales channel performance, and provide recommendations for optimizing marketing spend.

## Business Objective

Identify opportunities to improve profitability by analyzing:
- product performance
- sales channels
- customer returns
- marketing effectiveness

## Tools Used

|Tool | Purpose| 
|---|---|
|MySQL|Data storage, data cleaning, validation checks, and SQL analysis|
|Python (Pandas)|Data exploration, data cleaning, and exploratory data analysis (EDA)|
|Tableau|Interactive dashboards and data visualization|
|GitHub|Version control and project documentation|

## Project Status

**Completed**

## Key Findings

### Product Profitability

- **Electronics** is the most profitable category, with a **31.13% profit margin** and the highest average profit per order.
- **Books** is the least profitable category, with an **11.94% profit margin** and the lowest average profit per order.
- Product cost, shipping cost, discounts, and returns were analyzed as potential profitability drivers.
- Pricing efficiency appears to be an important factor behind the profitability differences, with Electronics generating substantially stronger profit relative to product cost.

### Sales Channel Performance

- **Mobile App** is the most profitable sales channel, with the highest profit margin and average profit per order.
- **Marketplace** has the weakest profitability and the highest average platform and transaction fees.
- **Website** generates the highest order volume and total revenue while maintaining a strong profit margin.
- Profitability varies significantly by category within each channel.
- Books are particularly problematic on Marketplace and Social Commerce, where negative profit margins were observed.

### Returns

- **Electronics** has the highest return rate among product categories and the largest total refund amount.
- **Social Commerce** has the highest return rate among sales channels.
- Website generates the largest total refund amount due to its significantly higher order volume.
- Return performance varies considerably depending on both category and sales channel.

### Marketing Performance

- **TikTok Ads** has the strongest overall efficiency, with the highest ROAS and the lowest CPC and CPA.
- **Influencer** also performs strongly and has one of the highest ROAS values.
- **Email Marketing** has the weakest performance, with the highest CPC and CPA and the lowest ROAS.
- All analyzed advertising platforms generated a ROAS above 1.
- TikTok Ads and Influencer improved their ROAS in 2025, while the other platforms experienced declines.

### Marketing Budget Optimization

- A **20% reduction of the 2025 marketing budget** was used as the 2026 optimization scenario.
- Platforms with improving or stable ROAS were protected from cuts.
- Larger cuts were assigned to platforms with larger year-over-year ROAS declines.
- The recommended platform-level cuts were allocated to the lowest-performing months based on monthly ROAS.
- Partial cuts were applied when only part of a month's budget was required to reach the target reduction.

## Recommendations

### Product Categories

- Prioritize **Electronics** because of its strong profit margin and pricing efficiency.
- Review the profitability of **Books**, particularly its low markup and weak performance across some sales channels.
- Investigate whether pricing, discounting, or product assortment changes could improve low-margin categories.

### Sales Channels

- Continue investing in the **Mobile App**, which demonstrates strong profitability.
- Review the cost structure of **Marketplace**, particularly its higher platform and transaction fees.
- Investigate low-profit category/channel combinations and consider adjusting pricing, promotions, or product availability.

### Returns

- Investigate the high return rate for **Electronics** to identify potential product, quality, or customer-expectation issues.
- Review high-return category/channel combinations, especially Social Commerce.
- Monitor refund amounts alongside return rates to identify areas with the greatest financial impact.

### Marketing

- Consider increasing or maintaining investment in high-performing platforms such as **TikTok Ads** and **Influencer**.
- Review **Email Marketing** performance and investigate the causes of its high CPC and CPA.
- Reduce spending on platforms experiencing significant ROAS deterioration.
- Use monthly ROAS performance to prioritize future budget reductions rather than applying equal cuts across all months.

## Project Outputs

The project includes:

- Cleaned datasets prepared using Python/Pandas
- SQL staging and analysis tables
- Data validation and quality checks
- Business analysis queries
- Tableau dashboards
- Marketing budget optimization scenario
- Final Tableau workbook
- Project documentation and analysis notes

## Limitations

- The `orders` dataset contains product categories but does not contain individual `product_id` values.
- Therefore, product performance can only be analyzed at the **category level**.
- Individual product or supplier performance cannot be directly linked to customer orders.
- Marketing revenue is attributed revenue from the marketing dataset and should not be interpreted as the same metric as e-commerce order revenue.

## Tableau Dashboards

The Tableau workbook contains dashboards covering:

1. Product Profitability
2. Channel Profitability
3. Returns Analysis
4. Marketing Performance
5. Marketing Budget Optimization
6. Executive Summary

The Tableau workbook is available in the `tableau/` folder.
