## Description of SQL Scripts
  
| Script                          | Purpose                                                                                      |
| ------------------------------- | -------------------------------------------------------------------------------------------- |
| `0_init_database.sql`            | Initialize and prepare the database schema with sample sales data.                          |
| `1_database_exploration.sql`     | Basic exploration of database tables and metadata.                                         |
| `2_dimensions_exploration.sql`   | Analyze categorical dimensions such as customers, products, and regions.                   |
| `3_date_range_exploration.sql`   | Explore time ranges to filter and structure sales data.                                    |
| `4_measures_exploration.sql`     | Identify and analyze key measures (sales, revenue, quantities).                            |
| `5_magnitude_analysis.sql`       | Evaluate the magnitude of measures across entities.                                        |
| `6_ranking_analysis.sql`          | Rank customers and products by sales and revenue.                                          |
| `7_change_over_time_analysis.sql` | Perform time series analysis of sales and performance trends.                              |
| `8_cumulative_analysis.sql`       | Calculate running totals and cumulative sales over time.                                  |
| `9_performance_analysis.sql`      | Evaluate performance of products, categories, and customer groups.                         |
| `10_data_segmentation.sql`        | Segment customers and products into meaningful groups.                                    |
| `11_part_to_whole_analysis.sql`   | Conduct market share and contribution analysis (part-to-whole).                           |
| `12_report_customers.sql`         | Generate a final customer-focused report covering sales, rankings, and performance.        |
| `13_report_products.sql`          | Generate a final product-focused report covering sales, top products, and market shares.   |

---

## Getting Started

1. **Set up your database** by running `0_init_database.sql` to create the schema and load sample data.
2. Explore and analyze the data using the scripts in numerical order.
3. Use the final reporting scripts (`12_report_customers.sql` and `13_report_products.sql`) to generate comprehensive sales reports.



