# RAG System User Guide
## Sales Intelligence RAG Platform

### 1. Purpose

This guide explains how the Retrieval-Augmented Generation (RAG) component works and how users can interact with it.

The RAG assistant is designed to answer questions using indexed business documentation. It combines document retrieval with a language model to provide context-aware responses.

### 2. Technology Stack

| Component | Technology | Purpose |
|---|---|---|
| Workflow automation | n8n | Coordinates document ingestion and question-answering workflows |
| Language model | Ollama – Llama 3.2 | Generates natural-language responses |
| Embedding model | Ollama – nomic-embed-text | Converts document text and questions into embeddings |
| Vector database | Qdrant | Stores and retrieves document embeddings |
| Structured data warehouse | Snowflake | Stores and provides access to sales analytics |

### 3. System Architecture

The RAG component has two main processes:

**A. Document Ingestion**

1. A user or administrator provides a business document.
2. n8n receives the document through the configured ingestion workflow.
3. The document is split into smaller text chunks.
4. `nomic-embed-text` generates an embedding for each chunk.
5. The embeddings and associated text are stored in Qdrant.
6. The indexed content becomes available for retrieval.

**B. Question and Answering**

1. A user submits a natural-language question.
2. The question is converted into an embedding.
3. Qdrant searches for relevant document chunks.
4. The retrieved content is passed to the Llama 3.2 model as context.
5. The model generates a response based on the retrieved information.
6. The response is returned through the configured n8n workflow.

### 4. Document Ingestion Workflow

The document ingestion workflow prepares business documentation for retrieval.

Its main responsibilities are:

- Receive business documents.
- Extract and prepare text.
- Divide text into smaller chunks.
- Generate vector embeddings.
- Store document chunks in Qdrant.

**Qdrant collection:** `sales_business_docs`

The business-document ingestion workflow was tested successfully with three document chunks inserted into the collection.

### 5. RAG Question-Answering Workflow

The question-answering workflow connects user questions with relevant stored information.

Its main responsibilities are:

- Accept user questions.
- Generate question embeddings.
- Retrieve relevant document chunks from Qdrant.
- Pass the retrieved context to Llama 3.2.
- Return a natural-language answer.

The workflow is designed to support business-document questions rather than replace SQL-based numerical analysis.

### 6. Example Questions

Users can ask questions such as:

- What are the sales reporting rules?
- How is average selling price calculated?
- What does the data dictionary say about `discount_percent`?
- Which KPIs are available in the executive reporting view?
- What is the difference between revenue and profit?
- How does the document ingestion process work?

### 7. Role of Snowflake and Qdrant

The platform separates structured analytics from contextual document retrieval.

| Requirement | Recommended component |
|---|---|
| Calculate total revenue | Snowflake |
| Compare monthly sales | Snowflake |
| Rank product categories | Snowflake |
| Retrieve reporting definitions | Qdrant and RAG |
| Find business-document explanations | Qdrant and RAG |

This separation helps avoid relying on document retrieval for exact numerical calculations.

### 8. Configuration and Operations

The local development environment uses:

- n8n at `http://localhost:5678`
- Ollama for local model execution
- Llama 3.2 for response generation
- nomic-embed-text for embeddings
- Qdrant for vector storage

Model names, endpoint configuration, credentials and collection settings should be checked in the actual deployment environment.

Never publish API keys, passwords, tokens or exported credentials in the GitHub repository.

### 9. Troubleshooting

| Problem | Recommended check |
|---|---|
| n8n is unavailable | Check whether the n8n container is running |
| Ollama does not respond | Verify that the Ollama service and selected model are available |
| No relevant document is retrieved | Confirm that the document was ingested into Qdrant |
| RAG answer is irrelevant | Improve the question and review the retrieved context |
| Embedding errors occur | Check the embedding model and vector dimensions |
| Qdrant connection fails | Verify the Qdrant service and connection configuration |

### 10. Current Scope and Limitations

- The RAG system retrieves information from indexed business documentation.
- Retrieval quality depends on document quality, chunking and embedding configuration.
- The language model can generate incorrect information; important answers should be checked against their source.
- The RAG component is not a replacement for Snowflake SQL queries.
- Numerical business reporting should use validated Snowflake views.
- The system should be tested with different documents and questions before production deployment.

### 11. Future Improvements

Potential enhancements include:

- Support for additional document formats.
- Source references in generated answers.
- Improved chunking and retrieval evaluation.
- User authentication and access controls.
- Automated document ingestion.
- Monitoring of workflow execution and retrieval quality.
- Integration with approved Snowflake reporting views.

### 12. Conclusion

The RAG component extends the Sales Intelligence Platform with natural-language access to business documentation. n8n coordinates the workflows, Ollama provides embedding and language models, and Qdrant supports semantic retrieval.

Together with Snowflake and Power BI, the RAG system provides a foundation for combining structured sales analytics with contextual business knowledge.