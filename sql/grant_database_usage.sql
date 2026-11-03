-- Database Usage Grant
-- Purpose: Allow the read-only RAG role to access
-- the Sales Intelligence database.

GRANT USAGE ON DATABASE SALES_INTELLIGENCE
TO ROLE SALES_RAG_READONLY;
