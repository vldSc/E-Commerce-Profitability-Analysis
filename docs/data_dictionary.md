# Data Dictionary

This document describes the datasets used in the project.

## Dataset Overview

| Dataset | Rows | Primary Key | Important Columns | Description |
|---|---:|---|---|---|
| orders | 2,000 | order_id | order_date, channel, category, gross_revenue, discount, shipping_cost, product_cost, platform_fee, returned, refund_amount, profit | Contains transaction-level order data |
| products | 207 | product_id | product_id, category, sub_category, unit_cost, selling_price, shipping_cost_per_unit | Contains product information, pricing, and cost details |
| marketing_spend | 144 | month + platform | spend, impressions, clicks, conversions, revenue_attributed, roas | Contains monthly advertising performance data |
