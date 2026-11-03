-- Category Sales Summary
-- Purpose: Calculate overall totals from the category sales view.

SELECT
    SUM(order_count) AS total_rows,
    SUM(total_units_sold) AS total_units_sold,
    ROUND(SUM(total_revenue), 2) AS total_revenue
FROM SALES_INTELLIGENCE.ANALYTICS.CATEGORY_SALES;
