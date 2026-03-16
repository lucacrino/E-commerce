# 🛒E-commerce

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-4169E1?style=flat&logo=postgresql&logoColor=white)
![Tables](https://img.shields.io/badge/8-Tables-3B6D11?style=flat)
![Rows](https://img.shields.io/badge/21%2c264-Rows-7C3AED?style=flat)

End-to-end SQL portfolio project on a European e-commerce dataset


## Table of Contents
-  [Project Overview](#-project-overview)
-  [Dataset Overview](#-dataset-overview)
-  [Analyses & SQL Techniques](#-analyses--sql-techniques)
-  [Key Findings](#-key-findings)
-  [Skills & Tools](#-skills--tools)



# 📍 Project Overview

This project demonstrates end-to-end SQL analytics on a synthetic European e-commerce platform.
The dataset spans 2021–2024, it covers 8 countries, 12 product categories, 52 suppliers and 1,000 customers.
Analyses range from revenue time-series and customer segmentation to retention and scoring, all written in plain PostgreSQL.




## 📊 Dataset Overview

| Table | Role | Rows | Primary Key | Notes |
|-------|------|------|-------------|-------|
| `categories` | Dimension | 12 | `category_id` | Static lookup table |
| `suppliers` | Dimension | 52 | `supplier_id` | Companies providing the products |
| `products` | Dimension | 500 | `product_id` | Online catalogue |
| `customers` | Dimension | 1,000 | `customer_id` | Central lookup table |
| `orders` | Fact | 7,000 | `order_id` | Central fact table |
| `order_items` | Fact | 7,500 | `order_item_id` | Bridge: orders × products |
| `reviews` | Fact | 4,000 | `review_id` | Product ratings by customers |
| `returns` | Fact | 1,200 | `return_id` | Return requests on line items |


