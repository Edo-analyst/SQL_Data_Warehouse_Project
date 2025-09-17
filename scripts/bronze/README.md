# 🟫 Bronze Layer Setup and Data Loading

## Overview
This SQL script handles the creation and loading of tables in the **`bronze`** schema.  
It is designed to be run to define table structures and load data from CSV files.

---

## Features

### 1. Table Creation (DDL)
- Drops existing tables in the `bronze` schema if they exist.
- Creates new tables for CRM and ERP data with defined structure.

### 2. Stored Procedure `bronze.load_bronze`
- Truncates all `bronze` tables to empty them before loading.
- Loads data from CSV files using `BULK INSERT`.
- Measures and prints load time for each table and the overall process.
- Includes error handling with detailed error messages.

---

## Usage

1. Run the script to create or recreate the table structures.
2. Execute the stored procedure to load data:

```sql
EXEC bronze.load_bronze;

