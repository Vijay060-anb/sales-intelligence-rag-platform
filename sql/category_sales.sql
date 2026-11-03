-- Category Sales Analysis
-- Purpose: Analyze revenue, units, pricing and discounts by category.

CREATE OR REPLACE VIEW SALES_INTELLIGENCE.ANALYTICS.CATEGORY_SALES AS
SELECT
    category,
    COUNT(*) AS order_count,
    SUM(units_sold) AS total_units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(final_price), 2) AS average_selling_price,
    ROUND(AVG(discount_percent), 2) AS average_discount_percent,
    ROUND(
        SUM(revenue) / NULLIF(SUM(units_sold), 0),
        2
    ) AS revenue_per_unit
FROM SALES_INTELLIGENCE.RAW.SALES_DATA
GROUP BY category;
