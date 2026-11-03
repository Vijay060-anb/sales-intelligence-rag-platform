-- Executive Sales KPIs
-- Purpose: Provide an executive-level overview of sales performance.
-- Metrics: Records, unique orders, units, revenue, pricing,
-- discounts and sales date range.

CREATE OR REPLACE VIEW SALES_INTELLIGENCE.REPORTING.EXECUTIVE_SALES_KPIS AS
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT order_id) AS unique_orders,
    SUM(units_sold) AS total_units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(final_price), 2) AS average_selling_price,
    ROUND(AVG(discount_percent), 2) AS average_discount_percent,
    MIN(order_date) AS first_sales_date,
    MAX(order_date) AS last_sales_date
FROM SALES_INTELLIGENCE.RAW.SALES_DATA;
