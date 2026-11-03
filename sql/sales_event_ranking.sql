-- Sales Event Revenue Ranking
-- Purpose: Compare sales events by total revenue.

SELECT *
FROM SALES_INTELLIGENCE.ANALYTICS.SALES_EVENT_ANALYSIS
ORDER BY total_revenue DESC;
