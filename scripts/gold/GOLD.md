# 🟨 Gold Layer Views Setup

## Overview
This SQL script creates views for the **Gold** layer in the data warehouse.  
The Gold layer represents the final dimension and fact tables in a star schema design.

---

## Features

### 1. Gold Views Creation
- Views are built by transforming and joining data from the Silver layer.
- The following business-ready views are created:
  - **gold.dim_customers**: customer dimension with surrogate keys, demographic data, and combined CRM & ERP sources.
  - **gold.dim_products**: product dimension with category details, costs, and active status.
  - **gold.fact_sales**: sales fact table containing order details, quantities, prices, and linked customer & product keys.

### 2. Technical Highlights
- Filters out historical (inactive) products.
- Uses joins to enrich data from multiple Silver tables.
- Generates surrogate keys using `ROW_NUMBER()` to ensure referential integrity.

---

## Usage

1. Run the script to create or refresh the Gold layer views.
2. Query the views directly for analytics and reporting.

```sql
SELECT * FROM gold.dim_customers;
SELECT * FROM gold.dim_products;
SELECT * FROM gold.fact_sales;
