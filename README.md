# 🛒E-commerce

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-4169E1?style=flat&logo=postgresql&logoColor=white)
![Tables](https://img.shields.io/badge/8-Tables-3B6D11?style=flat)
![Rows](https://img.shields.io/badge/21%2c264-Rows-7C3AED?style=flat)

End-to-end SQL portfolio project on a European e-commerce dataset


## Table of Contents
-  [Project Overview](#-project-overview)
-  [Schema & ERD](#%EF%B8%8F-schema--erd)
-  [Dataset Overview](#-dataset-overview)
-  [Analysis & SQL Techniques](#-analysis--sql-techniques)
-  [Key Findings](#-key-findings)
-  [Skills & Tools](#%EF%B8%8F-skills--tools)



# 📍 Project Overview

This project demonstrates end-to-end SQL analytics on a synthetic European e-commerce platform.
The dataset spans 2021–2024, it covers 8 countries, 12 product categories, 52 suppliers and 1 000 customers.
Analysis range from revenue time-series and customer segmentation to retention and scoring, all written in plain PostgreSQL.


# 🗺️ Schema & ERD


The schema follows a star/snowflake hybrid. `orders` is the central fact
table, joined to `customers`, `order_items`, and ultimately `products` → `categories` + `suppliers`.





# 📊 Dataset Overview

| Table | Role | Rows | Primary Key | Notes |
|-------|------|------|-------------|-------|
| `categories` | Dimension | 12 | `category_id` | Static lookup table |
| `suppliers` | Dimension | 52 | `supplier_id` | Companies delivering the products |
| `products` | Dimension | 500 | `product_id` | Online catalogue |
| `customers` | Dimension | 1,000 | `customer_id` | Registered to the system |
| `orders` | Fact | 7,000 | `order_id` | Central fact table |
| `order_items` | Fact | 7,500 | `order_item_id` | Bridge: orders × products |
| `reviews` | Fact | 4,000 | `review_id` | Product ratings by customers |
| `returns` | Fact | 1,200 | `return_id` | Return requests on line items |



# 📈 Analysis & SQL Techniques

<details>
<summary>Module A — Revenue & Sales Performance</summary>

| # | Analysis | SQL Concepts |
|---|----------|--------------|
| A1 | Monthly revenue & order volume trend | `EXTRACT` · `GROUP BY` · `AVG` |
| A2 | Revenue by country and loyalty tier | multi-table JOIN · segmentation |
| A3 | 3-month rolling revenue average | `AVG() OVER` · `ROWS BETWEEN` |
| A4 | Discount impact on revenue | `CASE WHEN` · `COALESCE` |
| A5 | Pareto revenue by category | `SUM() OVER` · `RANK()` · running % |

</details>

<details>
<summary>Module B — Customer Behaviour & Retention</summary>

| # | Analysis | SQL Concepts |
|---|----------|--------------|
| B1 | Customer lifetime value ranking | `INNER JOIN` · `SUM` · `ORDER BY` |
| B2 | Top spenders per country | `RANK() OVER (PARTITION BY)` |
| B3 | Repeat vs one-time purchasers | `CASE WHEN` · CTE · segment % |
| B4 | Days between consecutive orders | `LAG()` · date subtraction |
| B5 | Monthly cohort retention | CTE chaining · cohort logic |
| B6 | RFM customer segmentation | `NTILE(4)` · multi-CTE · `CASE` |

</details>

<details>
<summary>Module C — Product, Supplier & Operations</summary>

| # | Analysis | SQL Concepts |
|---|----------|--------------|
| C1 | Top products by revenue & margin | 3-table JOIN · derived columns |
| C2 | Products never reviewed | `LEFT JOIN IS NULL` · anti-join |
| C3 | Return rate by category & reason | `NULLIF` · `HAVING` · `GROUP BY` |
| C4 | Supplier performance scorecard | multi-CTE · `DENSE_RANK()` |
| C5 | Shipping method efficiency | date diff · conditional aggregation |
| C6 | Product rating drift over time | `ROWS BETWEEN` · `PARTITION BY` |
| C7 | Inventory risk — slow movers | `PERCENTILE_CONT` · `NTILE` |
| C8 | Full data quality audit | `UNION ALL` · anti-join · logic checks |
| C9 | Refund value at risk by supplier | multi-CTE · rolling `SUM` · rank |

</details>

# 🎯 Key Findings

### Revenue & Sales Performance
-  Over a 4-year operating period, the business achieved: 6 555 orders, €3.6M in gross revenues and 595 orders/month on average.
-  The 3-month rolling average analysis reveals a concerning insight: revenues tend to drop between October and November by ~14%. To address the problem, right after adjusting the Q4 forecasting model, suppose a customer-segmentation: could a targeted marketing campaign for Halloween products be a reasonable option for young buyers? If older, what about seasonal discounts for more suitable categories (Health & Wellness, Home & Kitchen, Books...)?
-  Beauty & Personal Care, Home & Kitchen and Electronics are the 3 top categories generating 34% of total revenues (€1.2M). Strategic partnerships with suppliers for exclusive products? Introduction of private labels to boost brand-loyalty? Introduction of 'Gift with Purchase'?



### Customer Behaviour & Retention




### Product & Operations





# 🛠️ Skills & Tools

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-4169E1?style=flat&logo=postgresql&logoColor=white)
![Window Functions](https://img.shields.io/badge/Window_Functions-SQL-854F0B?style=flat)
![CTEs](https://img.shields.io/badge/CTEs-SQL-993C1D?style=flat)
![Data Analysis](https://img.shields.io/badge/Data_Analysis-SQL-185FA5?style=flat)
![Customer Segmentation](https://img.shields.io/badge/Customer_Segmentation-SQL-533AB7?style=flat)
![Indexing](https://img.shields.io/badge/Indexing-SQL-0F6E56?style=flat)
![Data Quality](https://img.shields.io/badge/Data_Quality_Auditing-SQL-5F5E5A?style=flat)
![Subqueries](https://img.shields.io/badge/Subqueries-SQL-993C1D?style=flat)



