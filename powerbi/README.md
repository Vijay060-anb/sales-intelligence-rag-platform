# Power BI Documentation
## Sales Intelligence RAG Platform

### 1. Overview

Power BI is the business intelligence and visualization layer of the Sales Intelligence RAG Platform.

It connects to Snowflake reporting data to help users understand sales performance through business metrics and visual analysis.

### 2. Data Source

**Data warehouse:** Snowflake

**Database:** `SALES_INTELLIGENCE`

**Schema:** `REPORTING`

Important reporting views include:

- `EXECUTIVE_SALES_KPIS`
- `YEARLY_SALES_KPIS`
- `MONTHLY_SALES_REPORT`

The actual report should be checked to confirm which views are currently connected and used.

### 3. Executive KPIs

The executive reporting layer provides the following metrics:

| KPI | Business meaning |
|---|---|
| Total Records | Number of sales records |
| Unique Orders | Number of distinct orders |
| Total Units Sold | Total quantity sold |
| Total Revenue | Total recorded sales revenue |
| Average Selling Price | Average final selling price |
| Average Discount | Average discount percentage |
| First Sales Date | Earliest transaction date |
| Last Sales Date | Latest transaction date |

### 4. Sales Performance Analysis

The reporting layer supports analysis across several business dimensions.

**Yearly performance**
- Compare revenue across 2023, 2024 and 2025.
- Review annual sales volume.
- Identify the year with the highest recorded revenue.

**Monthly performance**
- Track monthly revenue.
- Compare revenue with the previous month.
- Review month-over-month growth.

**Category performance**
- Compare revenue by product category.
- Review units sold and average discounts.
- Identify high-performing categories.

**Regional performance**
- Compare states and sales zones.
- Review revenue and units sold.
- Evaluate regional contributions.

**Sales event performance**
- Compare revenue across sales events.
- Examine average discounts and selling prices.

### 5. Data Validation

The underlying dataset contains:

| Metric | Validated value |
|---|---:|
| Total records | 30,600 |
| Unique orders | 30,600 |
| Total units sold | 970,188 |
| Total revenue | $2,174,510,366.99 |
| Average selling price | $2,415.02 |
| Average discount | 38.11% |

The dataset covers January 2023 to December 2025.

### 6. Snowflake Connection

Power BI was successfully connected to Snowflake during development.

The connection process involved:

1. Opening Power BI Desktop.
2. Selecting the Snowflake connector.
3. Entering the Snowflake account and warehouse details.
4. Authenticating with the configured account.
5. Selecting the required database, schema and reporting views.
6. Loading the data for analysis.

### 7. Dashboard Design Guidelines

Recommended visualizations for the project include:

| Visual | Purpose |
|---|---|
| KPI Cards | Display total revenue, orders and units sold |
| Bar Chart | Compare category revenue |
| Line Chart | Show monthly revenue trends |
| Column Chart | Compare yearly performance |
| Regional Chart | Compare state-level revenue |
| Table | Display detailed sales metrics |

*These are recommended dashboard components. Only describe them as implemented after confirming they appear in the saved Power BI report.*

### 8. Validation and Troubleshooting

Before publishing a report:

- Compare Power BI totals with Snowflake query results.
- Verify date fields and aggregation logic.
- Check that revenue is not accidentally summed twice.
- Confirm that filters behave correctly.
- Refresh the data and review any connection errors.

### 9. Important Business Limitation

Total revenue is not profit. The dataset does not contain product cost information, so profit and profit margin cannot be calculated reliably.

### 10. Future Improvements

- Add interactive date and category filters.
- Improve dashboard navigation.
- Add drill-through analysis.
- Include regional and event comparisons.
- Configure scheduled refresh where supported.
- Improve report usability and accessibility.

### 11. Conclusion

Power BI provides the visual reporting layer for the Sales Intelligence platform. By using Snowflake reporting views, it supports structured sales analysis and helps translate analytical results into business insights.