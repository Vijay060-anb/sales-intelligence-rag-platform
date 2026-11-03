-- Reporting Schema Access Grant
-- Purpose: Allow the read-only RAG role to access
-- the Reporting schema.

GRANT USAGE ON SCHEMA SALES_INTELLIGENCE.REPORTING
TO ROLE SALES_RAG_READONLY;
