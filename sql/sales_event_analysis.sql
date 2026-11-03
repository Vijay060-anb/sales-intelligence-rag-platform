-- Sales Event Analysis
-- Purpose: Compare revenue, units, discounts and selling prices
-- across sales events.

CREATE OR REPLACE VIEW SALES_INTELLIGENCE.ANALYTICS.SALES_EVENT_ANALYSIS AS
SELECT
    sales_event,
    COUNT(*) AS order_count,
    SUM(units_sold) AS total_units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(discount_percent), 2) AS average_discount_percent,
    ROUND(AVG(final_price), 2) AS average_selling_price
FROM SALES_INTELLIGENCE.RAW.SALES_DATA
GROUP BY sales_event;
