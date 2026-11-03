# Data Dictionary
## Sales Intelligence RAG Platform

### 1. Overview

This document defines the fields used in the Sales Intelligence dataset. It explains each column's business meaning, logical data type and purpose in the analytics platform.

**Dataset:** `sales_data.csv`

| Dataset attribute | Value |
|---|---|
| Total records | 30,600 |
| Total columns | 16 |
| Start date | 31 January 2023 |
| End date | 31 December 2025 |
| Missing values | 0 |
| Duplicate rows | 0 |

*Note: The data types below describe the expected logical types. Confirm the physical Snowflake column types against the source table before treating them as database metadata.*

### 2. Column Definitions

| Column | Logical data type | Description | Business use |
|---|---|---|---|
| `order_id` | Integer / Identifier | Unique identifier for each order | Order counting and uniqueness checks |
| `order_date` | Date | Date when the order was recorded | Monthly and yearly trend analysis |
| `state` | String | State associated with the transaction | Geographic sales analysis |
| `zone` | String | Sales zone associated with the transaction | Regional comparisons |
| `category` | String | Product category | Category performance analysis |
| `brand_type` | String | Brand classification | Brand-level segmentation |
| `customer_gender` | String | Gender category recorded for the customer | Customer segmentation |
| `customer_age` | Integer | Customer age in years | Age-group analysis |
| `base_price` | Decimal | Original price before discount | Pricing analysis |
| `discount_percent` | Decimal | Discount applied as a percentage | Discount analysis |
| `final_price` | Decimal | Selling price after discount | Average selling price analysis |
| `units_sold` | Integer | Number of units sold | Volume analysis |
| `revenue` | Decimal | Recorded revenue for the transaction | Revenue reporting |
| `sales_event` | String | Sales event or promotion classification | Event performance analysis |
| `competition_intensity` | String / Category | Competition intensity classification | Competitive environment analysis |
| `inventory_pressure` | String / Category | Inventory pressure classification | Inventory-related analysis |

### 3. Important Business Metrics

**Revenue**

The total recorded sales revenue.

```sql
SELECT ROUND(SUM(revenue), 2) AS total_revenue
FROM SALES_INTELLIGENCE.RAW.SALES_DATA;
```

**Units Sold**

The total quantity of products sold.

```sql
SELECT SUM(units_sold) AS total_units_sold
FROM SALES_INTELLIGENCE.RAW.SALES_DATA;
```

**Average Selling Price**

The average value of the `final_price` field.

```sql
SELECT ROUND(AVG(final_price), 2) AS average_selling_price
FROM SALES_INTELLIGENCE.RAW.SALES_DATA;
```

**Average Discount**

The average discount percentage across records.

```sql
SELECT ROUND(AVG(discount_percent), 2) AS average_discount_percent
FROM SALES_INTELLIGENCE.RAW.SALES_DATA;
```

### 4. Data Quality Rules

The data preparation process checks the following:

| Validation | Expected result |
|---|---|
| Missing values | 0 |
| Duplicate rows | 0 |
| Duplicate order IDs | 0 |
| Invalid dates | 0 |
| Negative prices | 0 |
| Negative units sold | 0 |
| Discount outside 0–100% | 0 |
| Invalid customer ages | 0 |
| Discount
