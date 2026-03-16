# 🛒E-commerce

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-4169E1?style=flat&logo=postgresql&logoColor=white)
![Tables](https://img.shields.io/badge/8-Tables-3B6D11?style=flat)
![Rows](https://img.shields.io/badge/21%2c264-Rows-7C3AED?style=flat)

End-to-end SQL portfolio project on a European e-commerce dataset


## Table of Contents
-  [Project Overview](#-project-overview)
-  [Dataset Overview](#-dataset-overview)
-  [Analysis & SQL Techniques](#-analysis--sql-techniques)
-  [Key Findings](#-key-findings)
-  [Skills & Tools](#%EF%B8%8F-skills--tools)



# 📍 Project Overview

This project demonstrates end-to-end SQL analytics on a synthetic European e-commerce platform.
The dataset spans 2021–2024, it covers 8 countries, 12 product categories, 52 suppliers and 1 000 customers.
Analysis range from revenue time-series and customer segmentation to retention and scoring, all written in plain PostgreSQL.




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



# 🎯 Key Findings



# 🛠️ Skills & Tools

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-4169E1?style=flat&logo=postgresql&logoColor=white)
![Window Functions](https://img.shields.io/badge/Window_Functions-SQL-854F0B?style=flat)
![CTEs](https://img.shields.io/badge/CTEs-SQL-993C1D?style=flat)
![Data Analysis](https://img.shields.io/badge/Data_Analysis-SQL-185FA5?style=flat)
![Customer Segmentation](https://img.shields.io/badge/Customer_Segmentation-SQL-533AB7?style=flat)
![Indexing](https://img.shields.io/badge/Indexing-SQL-0F6E56?style=flat)
![Data Quality](https://img.shields.io/badge/Data_Quality_Auditing-SQL-5F5E5A?style=flat)
![Subqueries](https://img.shields.io/badge/Subqueries-SQL-993C1D?style=flat)



