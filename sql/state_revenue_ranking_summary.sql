-- State Revenue Ranking Summary
-- Purpose: Summarize state count, units sold, revenue
-- and revenue contribution percentages.

SELECT
    COUNT(*) AS state_count,
    SUM(total_units_sold) AS total_units_sold,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(SUM(revenue_share_percent), 2) AS total_revenue_share_percent
FROM SALES_INTELLIGENCE.ANALYTICS.STATE_REVENUE_RANKING;
