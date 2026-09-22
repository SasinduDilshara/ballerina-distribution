# RAG with pgvector vector store

Ballerina provides the `ai:VectorStore` abstraction for persisting and searching vector embeddings, with implementations for external vector databases such as pgvector, Milvus, Pinecone, and Weaviate, in addition to the built-in `ai:InMemoryVectorStore`. Since all implementations share the same type, the vector store can be swapped without changing the rest of the retrieval-augmented generation (RAG) workflow.

This example demonstrates an end-to-end RAG workflow using [pgvector](https://github.com/pgvector/pgvector), a PostgreSQL extension for vector similarity search, via the [ballerinax/ai.pgvector](https://central.ballerina.io/ballerinax/ai.pgvector/latest) module. Documents are ingested into a knowledge base backed by a PostgreSQL table, relevant chunks are retrieved for a query, and the query is augmented with the retrieved context before calling the LLM.

> Note: This example requires a running PostgreSQL instance with the pgvector extension enabled. For example, start one with Docker using `docker run --name pgvector-db -e POSTGRES_PASSWORD=<password> -e POSTGRES_DB=vector_db -p 5432:5432 -d pgvector/pgvector:pg17` and run `CREATE EXTENSION IF NOT EXISTS vector;` in the database. Add the database configuration to the `Config.toml` file (e.g., `pgPassword = "<password>"`). This example also uses the default model and embedding provider implementations. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_with_pgvector_vector_store.bal :::

::: out rag_with_pgvector_vector_store.out :::

## Related links

- [The RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [The RAG ingestion with external vector store example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The `ballerinax/ai.pgvector` module](https://central.ballerina.io/ballerinax/ai.pgvector/latest)
- [The `ballerinax/ai.milvus` module](https://central.ballerina.io/ballerinax/ai.milvus/latest)
- [The `ballerinax/ai.pinecone` module](https://central.ballerina.io/ballerinax/ai.pinecone/latest)
- [The `ballerinax/ai.weaviate` module](https://central.ballerina.io/ballerinax/ai.weaviate/latest)
