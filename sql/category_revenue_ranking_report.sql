-- Category Revenue Ranking Report
-- Purpose: Display category rankings by revenue.

SELECT *
FROM SALES_INTELLIGENCE.ANALYTICS.CATEGORY_REVENUE_RANKING
ORDER BY revenue_rank, category;
