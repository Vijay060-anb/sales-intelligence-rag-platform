# n8n Workflow Documentation
## Sales Intelligence RAG Platform

### 1. Overview

n8n is used to orchestrate workflow automation for the Sales Intelligence RAG Platform.

It connects document ingestion, embedding generation, vector storage and AI-powered question answering.

### 2. Technology Integration

| Component | Technology | Responsibility |
|---|---|---|
| Workflow automation | n8n | Coordinates workflow execution |
| Language model | Ollama – Llama 3.2 | Generates answers |
| Embedding model | Ollama – nomic-embed-text | Converts text into embeddings |
| Vector database | Qdrant | Stores and retrieves document chunks |
| Structured analytics | Snowflake | Provides sales reporting data |

### 3. Implemented Workflows

#### Workflow 1: Sales Intelligence – RAG Q&A

**Purpose:** Answer natural-language questions using indexed business documentation.

Main process:
1. Receive a user question.
2. Generate an embedding for the question.
3. Retrieve relevant document chunks from Qdrant.
4. Pass the retrieved context to Llama 3.2.
5. Generate and return a contextual answer.

#### Workflow 2: Sales Intelligence – Business Docs Ingestion

**Purpose:** Ingest business documents into the vector database.

Main process:
1. Start the ingestion workflow manually.
2. Read and prepare business-document text.
3. Split the content into smaller chunks.
4. Generate embeddings using nomic-embed-text.
5. Insert the chunks and associated vectors into Qdrant.

**Qdrant collection:** `sales_business_docs`

The workflow was tested successfully with three business-document chunks inserted into the collection.

### 4. Development Environment

The local development environment uses:

- n8n: `http://localhost:5678`
- Ollama for local model execution
- Qdrant for vector storage
- Docker for local service management

### 5. Workflow Testing

Testing should cover:

- Successful workflow execution.
- Document ingestion into Qdrant.
- Embedding generation.
- Retrieval of relevant document chunks.
- Answer generation using retrieved context.
- Handling of missing or irrelevant information.

### 6. Operational Notes

- Confirm that Docker services are running before executing workflows.
- Confirm that the required Ollama models are available.
- Check the Qdrant collection before testing retrieval.
- Review n8n execution logs when a workflow fails.
- Keep credentials in protected n8n credentials, not inside exported workflow files or GitHub.

### 7. Future Improvements

- Automated document ingestion.
- Support for PDF and additional document formats.
- Workflow error handling and retry mechanisms.
- Source references in RAG responses.
- Monitoring and logging.
- Scheduled ingestion of updated business documentation.

### 8. Conclusion

n8n acts as the workflow orchestration layer of the platform. It connects local language models, embedding generation and vector retrieval to provide an automated document question-answering process.