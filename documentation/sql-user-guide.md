# SQL User Guide
## Sales Intelligence RAG Platform

### 1. Purpose

This guide explains how SQL is used in the Sales Intelligence RAG Platform to transform raw sales data into business insights.

The SQL layer is built in Snowflake. It supports sales analysis, KPI reporting, regional comparisons, category performance, sales-event analysis and month-over-month trends.

### 2. Snowflake Environment

| Component | Name |
|---|---|
| Database | `SALES_INTELLIGENCE` |
| Raw schema | `RAW` |
| Analytics schema | `ANALYTICS` |
| Reporting schema | `REPORTING` |
| Warehouse | `SALES_WH` |
| Source table | `SALES_INTELLIGENCE.RAW.SALES_DATA` |

### 3. Data Source

The source dataset contains 30,600 sales records covering January 2023 to December 2025.

Important columns include:

- `order_id`: Unique order identifier
- `order_date`: Date of the transaction
- `state`: State associated with the sale
- `zone`: Sales region or zone
- `category`: Product category
- `brand_type`: Brand classification
- `customer_gender`: Customer gender field
- `customer_age`: Customer age
- `base_price`: Original product price
- `discount_percent`: Discount percentage
- `final_price`: Selling price after discount
- `units_sold`: Number of units sold
- `revenue`: Recorded sales revenue
- `sales_event`: Sales event classification
- `competition_intensity`: Competition indicator
- `inventory_pressure`: Inventory indicator

### 4. SQL Analytics Views

The following views organize the sales data for analysis.

#### 4.1 Regional Sales

**View:** `SALES_INTELLIGENCE.ANALYTICS.REGIONAL_SALES`

Purpose:
- Compare sales across states and zones.
- Calculate order counts and units sold.
- Measure total revenue.
- Compare average selling prices and discounts.

#### 4.2 Category Sales

**View:** `SALES_INTELLIGENCE.ANALYTICS.CATEGORY_SALES`

Purpose:
- Evaluate revenue by product category.
- Compare units sold.
- Calculate average selling price.
- Examine average discount levels.
- Calculate revenue per unit.

#### 4.3 Sales Event Analysis

**View:** `SALES_INTELLIGENCE.ANALYTICS.SALES_EVENT_ANALYSIS`

Purpose:
- Compare sales performance across sales events.
- Evaluate revenue and units sold.
- Compare average discounts and selling prices.

#### 4.4 Monthly Revenue Growth

**View:** `SALES_INTELLIGENCE.ANALYTICS.MONTHLY_REVENUE_GROWTH`

Purpose:
- Aggregate sales revenue by month.
- Compare current-month revenue with the previous month.
- Calculate month-over-month revenue growth.

The `LAG()` window function retrieves the previous month's revenue.

#### 4.5 State Revenue Ranking

**View:** `SALES_INTELLIGENCE.ANALYTICS.STATE_REVENUE_RANKING`

Purpose:
- Rank states by total revenue.
- Calculate revenue contribution percentages.
- Compare units sold across states.

The `RANK()` window function assigns revenue rankings.

#### 4.6 Category Revenue Ranking

**View:** `SALES_INTELLIGENCE.ANALYTICS.CATEGORY_REVENUE_RANKING`

Purpose:
- Rank product categories by revenue.
- Calculate revenue share.
- Compare average discount percentages.

The `DENSE_RANK()` window function assigns category rankings.

### 5. Executive Reporting

**View:** `SALES_INTELLIGENCE.REPORTING.EXECUTIVE_SALES_KPIS`

This view provides high-level business metrics:

- Total sales records
- Unique orders
- Total units sold
- Total revenue
- Average selling price
- Average discount percentage
- First sales date
- Last sales date

### 6. Example SQL Queries

**Check the number of source records**

```sql
SELECT COUNT(*) AS total_rows
FROM SALES_INTELLIGENCE.RAW.SALES_DATA;
```

**View category performance**

```sql
SELECT *
FROM SALES_INTELLIGENCE.ANALYTICS.CATEGORY_SALES
ORDER BY total_revenue DESC;
```

**View monthly revenue trends**

```sql
SELECT *
FROM SALES_INTELLIGENCE.ANALYTICS.MONTHLY_REVENUE_GROWTH
ORDER BY sales_month;
```

**View executive KPIs**

```sql
SELECT *
FROM SALES_INTELLIGENCE.REPORTING.EXECUTIVE_SALES_KPIS;
```

### 7. SQL Techniques Used

| SQL technique | Application |
|---|---|
| `SUM()` | Revenue and units aggregation |
| `COUNT()` | Record and order counts |
| `AVG()` | Average selling price and discount |
| `ROUND()` | Consistent numeric presentation |
| `GROUP BY` | Aggregation by category, state and month |
| `DATE_TRUNC()` | Monthly sales aggregation |
| `LAG()` | Previous-month comparison |
| `RANK()` | State revenue ranking |
| `DENSE_RANK()` | Category revenue ranking |
| `NULLIF()` | Avoiding division-by-zero errors |
| Common Table Expressions | Organizing multi-step analytical queries |

### 8. Read-Only Access for RAG

A dedicated Snowflake role named `SALES_RAG_READONLY` was created for controlled reporting access.

The intention is to allow the RAG application to read approved reporting data without granting unnecessary modification privileges.

Access should be validated against the actual grants and user configuration before deployment.

### 9. Important Business Definitions

- **Total revenue:** Sum of the recorded revenue field.
- **Average selling price:** Average of `final_price`.
- **Average discount:** Average of `discount_percent`.
- **Month-over-month growth:** Percentage change in revenue compared with the previous month.
- **Revenue share:** A category or state's percentage contribution to total revenue.

**Important:** Revenue is not profit. The dataset does not contain product cost information, so profit and profit margin cannot be calculated reliably.

### 10. Execution Guidelines

1. Connect to the correct Snowflake account.
2. Select the `SALES_WH` warehouse.
3. Confirm the `SALES_INTELLIGENCE` database.
4. Run schema and source-table inspection queries before analysis.
5. Create or replace analytical views.
6. Run reporting queries to validate the results.
7. Use the reporting views for downstream dashboards and RAG integration.

### 11. Conclusion

The SQL layer provides a structured analytical foundation for the Sales Intelligence RAG Platform. It converts raw transactional data into reusable business views and reporting metrics, supporting data-driven decision-making and integration with Power BI and the RAG application.