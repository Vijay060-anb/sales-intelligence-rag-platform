-- State Revenue Ranking
-- Purpose: Rank states by revenue and calculate
-- each state's percentage contribution to total revenue.
-- Concepts: CTEs, RANK(), window functions.

CREATE OR REPLACE VIEW SALES_INTELLIGENCE.ANALYTICS.STATE_REVENUE_RANKING AS
WITH state_sales AS (
    SELECT
        state,
        SUM(units_sold) AS total_units_sold,
        SUM(revenue) AS total_revenue
    FROM SALES_INTELLIGENCE.RAW.SALES_DATA
    GROUP BY state
)
SELECT
    state,
    total_units_sold,
    ROUND(total_revenue, 2) AS total_revenue,
    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank,
    ROUND(
        100.0 * total_revenue
        / NULLIF(SUM(total_revenue) OVER (), 0),
        2
    ) AS revenue_share_percent
FROM state_sales;
