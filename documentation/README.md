# Project Documentation
## Sales Intelligence RAG Platform

Welcome to the documentation for the Sales Intelligence RAG Platform.

This documentation explains the project architecture, data model, SQL analytics, reporting process and Retrieval-Augmented Generation (RAG) functionality.

## Documentation Library

| Document | Description |
|---|---|
| [Technical Project Documentation](technical-documentation.md) | Overall architecture, technology stack, data pipeline and project implementation |
| [SQL User Guide](sql-user-guide.md) | Snowflake environment, analytical views, SQL techniques and reporting queries |
| [Data Dictionary](data-dictionary.md) | Definitions and business meanings of all 16 dataset columns |
| [End-User Training Guide](end-user-training-guide.md) | How business users can interpret sales KPIs and use the platform |
| [RAG System User Guide](rag-system-user-guide.md) | Document ingestion, embeddings, Qdrant retrieval and AI-powered question answering |

## Project Overview

The platform combines structured sales analytics with contextual business-document search.

**Main technologies:**
- Python and Pandas
- Snowflake SQL
- Power BI
- n8n
- Ollama – Llama 3.2
- Ollama – nomic-embed-text
- Qdrant vector database

## Dataset Summary

| Metric | Value |
|---|---:|
| Records | 30,600 |
| Columns | 16 |
| Reporting period | January 2023 – December 2025 |
| Missing values | 0 |
| Duplicate rows | 0 |
| Total units sold | 970,188 |
| Total recorded revenue | $2,174,510,366.99 |

*Revenue represents recorded sales revenue, not profit.*

## Architecture at a Glance

1. **Data preparation:** Python scripts inspect, clean and validate sales data.
2. **Data warehouse:** Snowflake stores the structured sales dataset.
3. **Analytics:** SQL views calculate business metrics and sales trends.
4. **Visualization:** Power BI presents sales performance.
5. **Document retrieval:** n8n, Ollama and Qdrant support contextual business-document question answering.

## Intended Audience

- Data analysts
- Business intelligence developers
- Data engineers
- Technical reviewers
- Business users interested in sales performance

## Important Notes

- The documentation describes the project developed in its current state.
- Numerical analysis should use validated Snowflake reporting views.
- RAG answers should be checked against source documents when accuracy is important.
- Credentials, private datasets and sensitive configuration files must not be published in this repository.

---

**Project:** Sales Intelligence RAG Platform
**Repository:** [GitHub – sales-intelligence-rag-platform](https://github.com/Vijay060-anb/sales-intelligence-rag-platform)