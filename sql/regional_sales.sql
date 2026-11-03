-- Regional Sales Analysis
-- Purpose: Analyze sales performance by state and zone.

CREATE OR REPLACE VIEW SALES_INTELLIGENCE.ANALYTICS.REGIONAL_SALES AS
SELECT
    state,
    zone,
    COUNT(*) AS order_count,
    SUM(units_sold) AS total_units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(final_price), 2) AS average_selling_price,
    ROUND(AVG(discount_percent), 2) AS average_discount_percent
FROM SALES_INTELLIGENCE.RAW.SALES_DATA
GROUP BY
    state,
    zone;
