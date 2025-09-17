# ⬜ Silver Layer Setup and Data Loading

## Overview
This SQL script manages the creation and loading of tables in the **`silver`** schema.  
It transforms and cleanses raw data from the `bronze` schema to prepare it for downstream analytics.

---

## Features

### 1. Table Creation (DDL)
- Drops existing tables in the `silver` schema if they exist.
- Creates new tables with refined schemas, including normalization of data formats and default timestamp columns.

### 2. Stored Procedure `silver.load_silver`
- Truncates all `silver` tables before loading fresh data.
- Extracts data from `bronze` tables, applies cleansing and transformations such as:
  - Trimming strings
  - Normalizing gender and marital status codes
  - Calculating missing sales figures
  - Handling invalid or future dates
- Inserts the transformed data into the `silver` tables.
- Logs load duration for each table and the entire batch.
- Implements error handling with informative error messages.

---

## Usage

1. Run the script to create or recreate the `silver` tables.
2. Execute the stored procedure to load and transform data:

```sql
EXEC silver.load_silver;
