-- Warehouse Usage Grant
-- Purpose: Allow the read-only RAG role to use the Sales warehouse.

GRANT USAGE ON WAREHOUSE SALES_WH
TO ROLE SALES_RAG_READONLY;
