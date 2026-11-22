# 🛒 E-Commerce Analytics

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-4169E1?style=flat&logo=postgresql&logoColor=white)
![Tables](https://img.shields.io/badge/8-Tables-3B6D11?style=flat)
![Rows](https://img.shields.io/badge/21264-Rows-7C3AED?style=flat)
![Python](https://img.shields.io/badge/Python-Jupyter-3776AB?style=flat&logo=python&logoColor=white)

End-to-end SQL portfolio project on a European e-commerce dataset

---

## Table of Contents
- [Project Overview](#project-overview)
- [Schema & ERD](#schema-erd)
- [Dataset Overview](#dataset-overview)
- [Analyses & SQL Techniques](#analyses-sql-techniques)
- [Python Pipeline & Visualisations](#python-pipeline)
- [Key Findings](#key-findings)
- [Repository Structure](#repository-structure)
- [How to Run](#how-to-run)
- [Skills & Tools](#skills-tools)

---

<a id="project-overview"></a>
## 🔎 Project Overview

End-to-end SQL analytics on a synthetic European e-commerce platform.
The dataset spans 2021–2024, covers 8 countries, 12 product categories,
52 suppliers and 1000 customers. Analyses range from revenue time-series
and customer segmentation to cohort retention and RFM scoring — all written
in plain PostgreSQL.

---

<a id="schema-erd"></a>
## 🗺️ Schema & ERD

The schema follows a star/snowflake hybrid. `orders` is the central fact
table, joined to `customers`, `order_items`, and ultimately `products` →
`categories` + `suppliers`.


---

<a id="dataset-overview"></a>
## 📊 Dataset Overview

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

---

<a id="analyses-sql-techniques"></a>
## 📈 Analyses & SQL Techniques

<details>
<summary>Module A — Revenue & Sales Performance</summary>

| # | Analysis | SQL Concepts |
|---|----------|--------------|
| A1 | Monthly revenue & order volume trend | `EXTRACT` · `GROUP BY` · `AVG` |
| A2 | Revenue by country and loyalty tier | multi-table JOIN · `ARRAY_POSITION` |
| A3 | 3-month rolling revenue average | `AVG() OVER` · `ROWS BETWEEN` |
| A4 | Discount impact on revenue | `CASE WHEN` · `COALESCE` |
| A5 | Pareto revenue by category | `SUM() OVER` · `DENSE_RANK()` |

</details>

<details>
<summary>Module B — Customer Behaviour & Retention</summary>

| # | Analysis | SQL Concepts |
|---|----------|--------------|
| B1 | Customer lifetime value ranking | `INNER JOIN` · `ORDER BY` · `LIMIT` |
| B2 | Top spenders per country | `DENSE_RANK() OVER (PARTITION BY)` |
| B3 | Repeat vs one-time purchasers | `CASE WHEN` · CTE · `ARRAY_POSITION` |
| B4 | Days between consecutive orders | `LAG() OVER()` · `PERCENTILE_CONT()` |
| B5 | RFM customer segmentation | `NTILE(4)` · multi-CTE · `CASE WHEN` |

</details>

<details>
<summary>Module C — Product, Supplier & Operations</summary>

| # | Analysis | SQL Concepts |
|---|----------|--------------|
| C1 | Top products by revenue & margin | CTE · `LIMIT` |
| C2 | Products never reviewed | `LEFT JOIN IS NULL` · `INNER JOIN ` |
| C3 | Return rate by category & reason | multi-CTE · `RANK() OVER()` · `GROUP BY` |
| C4 | Supplier performance | multi-CTE · `DENSE_RANK()` |
| C5 | Shipping method efficiency | `COUNT(DISTINCT)` · CTE |
| C6 | Product rating | `DATE_TRUNC()` · `AVG() OVER(PARTITION BY)` |
| C7 | Inventory risk | `PERCENTILE_CONT()` · `DENSE_RANK() OVER(ORDER BY)` |
| C8 | Data quality audit | `UNION ALL` · `ABS()` |
| C9 | Refund value at risk by supplier | `SUM() OVER()` · `DENSE_RANK()` · multi-CTE |

</details>

---

<a id="python-pipeline"></a>
## 🐍 Python Pipeline & Visualisations

The SQL files in `sql/` remain the **single source of truth**. The notebook `sql_ecommerce_analysis.ipynb` connects to the PostgreSQL database, runs those files and turns each result into a DataFrame and a chart. No query logic is duplicated in Python.

**How it works**

1. **Secure connection** — credentials are stored in a local `credentials.env` file (never committed) and read with `python-dotenv`. A SQLAlchemy engine is built once and reused.
2. **Automatic loading** — the `.sql` file in `sql/queries/` is discovered with `pathlib` and loaded into a dictionary of DataFrames, keyed by file name (`dfs["c3_return_by_category"]`).
3. **Chart per analysis** — each analysis uses the chart type that fits its data (line, bar, Pareto), styled with Seaborn and Matplotlib.
4. **Export** — every chart is saved as a PNG in `outputs/`.

**Selected charts**

| Analysis | Chart type | Output |
|----------|-----------|--------|
| A3 · Rolling revenue | Line | `outputs/monthly_revenue.png` |
| A5 · Pareto by category | Bar + cumulative line | `outputs/pareto_analysis.png` |
| B6 · RFM segments | Bar | `outputs/customer_rfm_segmentation.png` |
| C1 · Top Products | Bar + line | `outputs/top_products.png` |
| C3 · Return rate by category | Horizontal bar | `outputs/return_rate.png` |


---

<a id="key-findings"></a>
## 💡 Key Findings

### Revenue & Sales Performance
- ...

### Customer Behaviour & Retention
- ...

### Product & Operations
- ...

---

<a id="repository-structure"></a>
## 📁 Repository Structure

```
E-commerce/
├── README.md
├── sql_ecommerce_analysis.ipynb              # Python pipeline: SQL → DataFrames → charts
├── credentials_example.env                   # Template for database credentials
│   
├── csv/
│   └── *.csv
├── sql/
│   ├── ddl.sql
│   │   
│   ├── Module A - Revenue & Sales Performance/
|   |   └── A*_query_name.sql
|   |
|   ├── Module B - Customer Behaviour & Retention
|   |   └── B*_query_name.sql
|   |
│   └── Module C - Production & Operations
|       └── C*_query_name.sql   
└── outputs/                                  # Exported charts (.png)
 
```
---

<a id="how-to-run"></a>
## ⚙️ How to Run

Prerequisites: PostgreSQL 18, psql CLI or pgAdmin / DBeaver. For the Python layer: Jupyter (e.g. via Anaconda).

### 1. SQL layer

```bash
# 1. Clone the repo
git clone https://github.com/lucacrino/ecommerce-sql-analytics

# 2. Create the database
createdb ecommerce_portfolio

# 3. Run DDL + load data (FK-safe order)
psql -d ecommerce_portfolio -f sql/ddl/create_tables.sql
psql -d ecommerce_portfolio -f sql/ddl/load_data.sql

# 4. Create indexes
psql -d ecommerce_portfolio -f sql/ddl/create_indexes.sql

# 5. Run any analysis
psql -d ecommerce_portfolio -f sql/queries/b5_cohort_retention.sql
```

### 2. Python layer

**Step 1 — Install the dependencies** (first cell of the notebook):

```python
%pip install pandas sqlalchemy psycopg2-binary python-dotenv matplotlib seaborn
```

**Step 2 — Create your credentials file.** Copy `credentials_example.env`, rename the copy to `credentials.env`, and fill in your own values:

```
DB_HOST=host
DB_PORT=port_number
DB_NAME=database_name
DB_USER=your_user
DB_PASSWORD=your_password
```

> ⚠️ Never upload `credentials.env` to GitHub. Only `credentials_example.env` (with fake values) belongs in the repository.

**Step 3 — Run the notebook.** Open `sql_ecommerce_analysis.ipynb`, make sure it sits in the repository's main folder (so the `sql/` path resolves), and use **Kernel → Restart & Run All**. The charts are saved in `outputs/`.

---

<a id="skills-tools"></a>
## 🛠️ Skills & Tools

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-4169E1?style=flat&logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=flat&logo=pandas&logoColor=white)
![SQLAlchemy](https://img.shields.io/badge/SQLAlchemy-D71F00?style=flat)
![Seaborn](https://img.shields.io/badge/Seaborn-4C8CBF?style=flat)
![Matplotlib](https://img.shields.io/badge/Matplotlib-11557C?style=flat)
![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=flat&logo=jupyter&logoColor=white)
![Window Functions](https://img.shields.io/badge/Window_Functions-SQL-854F0B?style=flat)
![CTEs](https://img.shields.io/badge/CTEs-SQL-993C1D?style=flat)
![Cohort Analysis](https://img.shields.io/badge/Cohort_Analysis-SQL-185FA5?style=flat)
![RFM Segmentation](https://img.shields.io/badge/RFM_Segmentation-SQL-533AB7?style=flat)
![Indexing](https://img.shields.io/badge/Indexing-SQL-0F6E56?style=flat)
![Data Quality](https://img.shields.io/badge/Data_Quality_Auditing-SQL-5F5E5A?style=flat)
![Star Schema](https://img.shields.io/badge/Star_Schema_Design-SQL-3B6D11?style=flat)
![Subqueries](https://img.shields.io/badge/Subqueries-SQL-993C1D?style=flat)
![Anti-Join](https://img.shields.io/badge/Anti--Join_Pattern-SQL-854F0B?style=flat)

---

*Data is synthetic and generated for analytical purposes*
