-- Monthly Revenue Growth Report
-- Purpose: Display monthly revenue and month-over-month growth
-- in chronological order.

SELECT *
FROM SALES_INTELLIGENCE.ANALYTICS.MONTHLY_REVENUE_GROWTH
ORDER BY sales_month;
