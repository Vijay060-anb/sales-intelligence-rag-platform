-- Monthly Revenue Growth Analysis
-- Purpose: Calculate monthly revenue, previous month revenue
-- and month-over-month revenue growth percentage.
-- Concepts: CTEs, DATE_TRUNC, LAG, window functions.

CREATE OR REPLACE VIEW SALES_INTELLIGENCE.ANALYTICS.MONTHLY_REVENUE_GROWTH AS
WITH monthly AS (
    SELECT
        DATE_TRUNC('MONTH', order_date)::DATE AS sales_month,
        SUM(revenue) AS monthly_revenue,
        SUM(units_sold) AS monthly_units
    FROM SALES_INTELLIGENCE.RAW.SALES_DATA
    GROUP BY DATE_TRUNC('MONTH', order_date)::DATE
),
comparison AS (
    SELECT
        sales_month,
        monthly_revenue,
        monthly_units,
        LAG(monthly_revenue) OVER (
            ORDER BY sales_month
        ) AS previous_month_revenue
    FROM monthly
)
SELECT
    sales_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    monthly_units,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(
        100.0 * (monthly_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS mom_growth_percent
FROM comparison;
