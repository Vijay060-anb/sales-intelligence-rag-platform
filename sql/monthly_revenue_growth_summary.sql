-- Monthly Revenue Growth Summary
-- Purpose: Summarize monthly records, units, revenue
-- and months with available MoM growth calculations.

SELECT
    COUNT(*) AS month_count,
    SUM(monthly_units) AS total_units,
    ROUND(SUM(monthly_revenue), 2) AS total_revenue,
    COUNT(mom_growth_percent) AS months_with_growth
FROM SALES_INTELLIGENCE.ANALYTICS.MONTHLY_REVENUE_GROWTH;
