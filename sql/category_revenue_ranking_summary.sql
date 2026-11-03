-- Category Revenue Ranking Summary
-- Purpose: Summarize category count, units sold, revenue
-- and total revenue contribution percentages.

SELECT
    COUNT(*) AS category_count,
    SUM(total_units_sold) AS total_units_sold,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(SUM(revenue_share_percent), 2) AS total_revenue_share_percent
FROM SALES_INTELLIGENCE.ANALYTICS.CATEGORY_REVENUE_RANKING;
