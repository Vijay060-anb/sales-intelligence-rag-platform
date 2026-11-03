-- Sales Event Summary
-- Purpose: Calculate overall sales totals from the sales event view.

SELECT
    SUM(order_count) AS total_rows,
    SUM(total_units_sold) AS total_units_sold,
    ROUND(SUM(total_revenue), 2) AS total_revenue
FROM SALES_INTELLIGENCE.ANALYTICS.SALES_EVENT_ANALYSIS;
