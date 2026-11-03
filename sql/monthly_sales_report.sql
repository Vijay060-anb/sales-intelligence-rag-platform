-- Monthly Sales Reporting View
-- Purpose: Expose monthly sales metrics in the reporting layer.

CREATE OR REPLACE VIEW SALES_INTELLIGENCE.REPORTING.MONTHLY_SALES_REPORT AS
SELECT
    sales_month,
    order_count,
    total_units_sold,
    total_revenue,
    average_selling_price,
    average_discount_percent
FROM SALES_INTELLIGENCE.ANALYTICS.MONTHLY_SALES;
