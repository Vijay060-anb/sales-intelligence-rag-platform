-- Category Revenue Ranking
-- Purpose: Rank categories by revenue and calculate
-- their contribution to total revenue.
-- Concepts: CTEs, DENSE_RANK(), window functions.

CREATE OR REPLACE VIEW SALES_INTELLIGENCE.ANALYTICS.CATEGORY_REVENUE_RANKING AS
WITH category_sales AS (
    SELECT
        category,
        SUM(units_sold) AS total_units_sold,
        SUM(revenue) AS total_revenue,
        AVG(discount_percent) AS average_discount_percent
    FROM SALES_INTELLIGENCE.RAW.SALES_DATA
    GROUP BY category
)
SELECT
    category,
    total_units_sold,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(average_discount_percent, 2) AS average_discount_percent,
    DENSE_RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank,
    ROUND(
        100.0 * total_revenue
        / NULLIF(SUM(total_revenue) OVER (), 0),
        2
    ) AS revenue_share_percent
FROM category_sales;
