# Sales Intelligence RAG Platform
## Technical Project Documentation

**Project:** Sales Intelligence & Business Analytics Platform
**Technologies:** Python, Snowflake SQL, Power BI, n8n, Ollama, Qdrant
**Repository:** [GitHub – Sales Intelligence RAG Platform](https://github.com/Vijay060-anb/sales-intelligence-rag-platform)

---

## 1. Project Overview

The Sales Intelligence RAG Platform is an end-to-end data analytics and business intelligence project designed to transform raw sales data into meaningful business insights.

The platform combines Python-based data preparation, Snowflake SQL analytics, Power BI reporting and Retrieval-Augmented Generation (RAG) to support both numerical business analysis and contextual information retrieval.

The primary objective is to help business users understand sales performance, monitor key performance indicators (KPIs), analyze trends and retrieve relevant business information through a question-answering workflow.

## 2. Business Objectives

The project addresses the following business requirements:

- Analyze sales performance across regions, states and product categories.
- Monitor revenue, units sold, average selling price and discount percentages.
- Identify monthly and yearly sales trends.
- Evaluate promotional sales event performance.
- Improve data quality through automated validation.
- Provide accessible business reporting through Power BI.
- Enable contextual business question answering using RAG.

## 3. Technology Stack

| Technology | Purpose |
|---|---|
| Python | Data inspection, cleaning and validation |
| Pandas | Data manipulation and transformation |
| Snowflake | Cloud data storage and SQL analytics |
| SQL | Business logic, KPI calculations and reporting views |
| Power BI | Interactive business dashboards |
| n8n | Workflow automation and orchestration |
| Ollama – Llama 3.2 | Language model for question answering |
| Ollama – nomic-embed-text | Text embedding generation |
| Qdrant | Vector storage and document retrieval |

## 4. System Architecture

The platform consists of five major stages.

### Stage 1: Data Preparation

Raw sales data is processed using Python.

Key activities:
- Inspect dataset structure and data types.
- Identify missing values and duplicate records.
- Validate sales dates and numerical fields.
- Check discount calculations.
- Generate cleaned datasets and data-quality reports.

### Stage 2: Snowflake Data Warehouse

The cleaned sales dataset is loaded into Snowflake.

The database follows a three-layer organization:

**RAW Layer**
- Stores the source sales dataset.
- Provides the foundation for downstream analytics.

**ANALYTICS Layer**
- Contains transformed sales information.
- Includes regional, category, event and monthly sales analysis.
- Uses SQL views, aggregations, CTEs and window functions.

**REPORTING Layer**
- Exposes business-ready reporting views.
- Provides executive KPIs and reporting datasets for dashboards.

### Stage 3: SQL Analytics

Snowflake SQL is used to create reusable analytical views and business metrics.

Key analytical areas include:

- Executive sales KPIs.
- Regional sales performance.
- Category revenue analysis.
- Sales event performance.
- Monthly revenue growth.
- State-level revenue ranking.
- Yearly sales performance.

Advanced SQL techniques include:
- Common Table Expressions (CTEs).
- Window functions such as LAG(), RANK() and DENSE_RANK().
- Aggregations using SUM(), AVG() and COUNT().
- Date transformations using DATE_TRUNC().
- NULL handling using NULLIF().

### Stage 4: Power BI Reporting

Power BI connects to Snowflake to present analytical results in an interactive reporting environment.

The reporting objectives include:
- Executive revenue overview.
- Category sales performance.
- Monthly sales trends.
- Regional performance comparisons.
- Sales KPI monitoring.

The dashboards are intended to help business users interpret performance without needing to write SQL queries.

### Stage 5: RAG and Workflow Automation

The project includes a Retrieval-Augmented Generation workflow using n8n.

The main components are:

- n8n for workflow orchestration.
- Ollama Llama 3.2 for language generation.
- nomic-embed-text for generating embeddings.
- Qdrant for storing and retrieving business document embeddings.

Business reporting rules and supporting documentation are ingested into Qdrant.

The RAG workflow retrieves relevant business context to support natural-language question answering.

**Architecture principle:** Snowflake is the source for exact numerical sales analytics, while Qdrant supports contextual retrieval from business documentation.

## 5. Dataset Description

The project uses a sales dataset containing 30,600 records and 16 columns.

**Dataset period:** January 2023 – December 2025.

Key attributes include:

| Column | Description |
|---|---|
| order_id | Unique order identifier |
| order_date | Date of transaction |
| state | Customer or sales state |
| zone | Sales region or zone |
| category | Product category |
| brand_type | Brand classification |
| customer_gender | Customer gender field |
| customer_age | Customer age |
| base_price | Original product price |
| discount_percent | Applied discount |
| final_price | Selling price after discount |
| units_sold | Number of units sold |
| revenue | Recorded sales revenue |
| sales_event | Promotional event |
| competition_intensity | Competition indicator |
| inventory_pressure | Inventory indicator |

## 6. Data Quality Results

The Python validation pipeline produced the following results:

| Validation metric | Result |
|---|---:|
| Total records | 30,600 |
| Missing values | 0 |
| Duplicate rows | 0 |
| Duplicate order IDs | 0 |
| Invalid dates | 0 |
| Negative prices | 0 |
| Negative units sold | 0 |
| Invalid discount percentages | 0 |
| Discount calculation mismatches | 0 |

These results demonstrate that the final cleaned dataset passed the implemented validation checks.

## 7. Business Performance Results

The Snowflake reporting views produced the following executive metrics:

| KPI | Result |
|---|---:|
| Total records | 30,600 |
| Unique orders | 30,600 |
| Total units sold | 970,188 |
| Total revenue | $2,174,510,366.99 |
| Average selling price | $2,415.02 |
| Average discount | 38.11% |
| First sales date | 31 January 2023 |
| Last sales date | 31 December 2025 |

### Yearly Revenue Analysis

| Year | Revenue |
|---|---:|
| 2023 | $719,580,147.02 |
| 2024 | $721,002,284.45 |
| 2025 | $733,927,935.52 |

**Key finding:** 2025 recorded the highest annual revenue among the three years analyzed.

*Note: Revenue represents recorded sales value, not profit. The dataset does not provide sufficient cost information to calculate profit or profit margins.*

## 8. Database Security

The project includes a dedicated Snowflake read-only role:

`SALES_RAG_READONLY`

Security configuration includes:
- Role creation.
- Warehouse usage permissions.
- Database usage permissions.
- Reporting schema access.
- SELECT permission on the executive KPI view.

This follows the principle of limiting data access to the permissions required by the workflow.

## 9. Workflow Automation

The project uses n8n to coordinate document ingestion and question-answering workflows.

Implemented workflows include:

1. Sales Intelligence – RAG Q&A.
2. Sales Intelligence – Business Docs Ingestion.

Business documents are converted into embeddings and stored in Qdrant for contextual retrieval.

The question-answering workflow uses the language model and retrieved business context to generate responses.

## 10. Key Challenges and Solutions

| Challenge | Approach |
|---|---|
| Inconsistent raw data | Developed Python validation scripts |
| SQL calculation accuracy | Validated discount calculations and aggregation logic |
| Reporting organization | Separated RAW, ANALYTICS and REPORTING schemas |
| Complex business analysis | Used CTEs and window functions |
| Connecting BI to Snowflake | Configured Snowflake connectivity in Power BI |
| Workflow orchestration | Implemented n8n workflows |
| Contextual information retrieval | Integrated embeddings and Qdrant |

## 11. Project Limitations and Future Improvements

Potential improvements include:

- Automate scheduled data ingestion.
- Implement incremental data processing.
- Add SQL query performance benchmarking.
- Expand automated testing and monitoring.
- Improve RAG response evaluation.
- Add source citations to generated business answers.
- Implement production-grade authentication and access monitoring.
- Extend dashboard functionality with additional business metrics.

## 12. Conclusion

The Sales Intelligence RAG Platform demonstrates how data engineering, SQL analytics, business intelligence and generative AI can work together in a single analytical solution.

The project provides practical experience in data quality management, Snowflake data warehousing, advanced SQL, dashboard development and document-based question answering.

It also emphasizes the importance of clear technical documentation, reusable analytical logic and accessible business reporting.

---

**Project Owner:** Vijay Anbarasu
**Repository:** https://github.com/Vijay060-anb/sales-intelligence-rag-platform