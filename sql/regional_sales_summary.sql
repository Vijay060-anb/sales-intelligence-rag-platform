-- Regional Sales Summary
-- Purpose: Calculate total rows, units sold and revenue
-- from the regional sales analytics view.

SELECT
    SUM(order_count) AS total_rows,
    SUM(total_units_sold) AS total_units_sold,
    ROUND(SUM(total_revenue), 2) AS total_revenue
FROM SALES_INTELLIGENCE.ANALYTICS.REGIONAL_SALES;
