-- Executive KPI View Permission Grant
-- Purpose: Allow the read-only RAG role to query
-- the Executive Sales KPIs reporting view.

GRANT SELECT ON VIEW SALES_INTELLIGENCE.REPORTING.EXECUTIVE_SALES_KPIS
TO ROLE SALES_RAG_READONLY;
