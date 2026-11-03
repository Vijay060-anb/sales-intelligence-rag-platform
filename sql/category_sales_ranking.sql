-- Category Sales Ranking
-- Purpose: Rank sales categories by total revenue.

SELECT *
FROM SALES_INTELLIGENCE.ANALYTICS.CATEGORY_SALES
ORDER BY total_revenue DESC;
