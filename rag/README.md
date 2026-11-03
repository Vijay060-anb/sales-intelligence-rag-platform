# RAG Architecture Documentation
## Sales Intelligence RAG Platform

### 1. Overview

The Retrieval-Augmented Generation (RAG) component enables users to ask questions about business documentation using natural language.

Instead of relying only on the language model's internal knowledge, the system retrieves relevant information from indexed documents and provides that context to the model before generating an answer.

### 2. Architecture Components

| Component | Technology | Responsibility |
|---|---|---|
| Workflow orchestration | n8n | Coordinates ingestion and question-answering |
| Language model | Ollama – Llama 3.2 | Generates contextual answers |
| Embedding model | Ollama – nomic-embed-text | Converts text into vector embeddings |
| Vector database | Qdrant | Stores and searches document embeddings |
| Analytics database | Snowflake | Provides structured sales data |

### 3. High-Level Architecture

```text
             BUSINESS DOCUMENTS
                     |
                     v
              n8n INGESTION
                     |
                     v
              TEXT EXTRACTION
                     |
                     v
               TEXT CHUNKING
                     |
                     v
             nomic-embed-text
                     |
                     v
                EMBEDDINGS
                     |
                     v
              QDRANT STORAGE
                     |
                     |
USER QUESTION
      |
      v
n8n QUESTION WORKFLOW
      |
      v
QUESTION EMBEDDING
      |
      v
QDRANT RETRIEVAL
      |
      v
RELEVANT DOCUMENT CONTEXT
      |
      v
OLLAMA LLAMA 3.2
      |
      v
GENERATED ANSWER
```

### 4. Document Ingestion Process

The ingestion pipeline prepares business documentation for semantic search.

1. Receive a document through the configured n8n workflow.
2. Extract its text content.
3. Divide the content into smaller chunks.
4. Generate embeddings using `nomic-embed-text`.
5. Store the vectors and associated document text in Qdrant.
6. Make the indexed information available for retrieval.

**Qdrant collection:** `sales_business_docs`

### 5. Retrieval and Answer Generation

When a user submits a question:

1. The question enters the n8n RAG workflow.
2. The embedding model converts the question into a vector.
3. Qdrant searches for relevant document chunks.
4. Retrieved text is supplied as context to Llama 3.2.
5. The model generates a natural-language answer.
6. The workflow returns the answer to the user.

### 6. Separation of Structured and Unstructured Data

The platform uses two complementary information systems.

| Information type | Technology | Example |
|---|---|---|
| Structured sales data | Snowflake | Total revenue, monthly growth and category rankings |
| Business documentation | Qdrant and RAG | Reporting definitions and business rules |

This separation is important because exact numerical analysis should be performed using validated SQL queries rather than approximate semantic document retrieval.

### 7. Development Environment

The local development setup includes:

- Docker for container management.
- n8n for workflow automation.
- Ollama for local language and embedding models.
- Qdrant for vector storage.
- Snowflake for structured sales analytics.

### 8. Reliability and Security Considerations

- Keep credentials in protected configuration or credential stores.
- Never commit API keys, passwords or exported credentials.
- Validate document content before ingestion.
- Review retrieved context when evaluating answer quality.
- Avoid treating generated answers as authoritative without checking their sources.
- Apply suitable access controls before exposing the system to other users.

### 9. Current Implementation and Testing

The project includes a working document-ingestion workflow and a RAG question-answering workflow.

The business-document ingestion workflow was tested with three chunks successfully inserted into the `sales_business_docs` collection.

Further evaluation should measure:
- Retrieval relevance.
- Answer accuracy.
- Response time.
- Handling of missing information.
- Consistency across repeated questions.

### 10. Future Improvements

- Add document source references to answers.
- Support additional file formats.
- Improve chunking and retrieval strategies.
- Introduce automated document updates.
- Add retrieval evaluation metrics.
- Implement authentication and role-based access.
- Integrate approved Snowflake reporting queries into a controlled analytical assistant.

### 11. Conclusion

The RAG architecture combines document processing, semantic retrieval and language generation to provide contextual access to business knowledge.

By integrating n8n, Ollama and Qdrant with Snowflake and Power BI, the Sales Intelligence platform brings together structured business analytics and unstructured document understanding.