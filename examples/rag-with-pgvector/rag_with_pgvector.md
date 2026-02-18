# RAG with pgvector (PostgreSQL)

The [`ballerinax/ai.pgvector`](https://central.ballerina.io/ballerinax/ai.pgvector/latest) module provides a `pgvector:VectorStore` that implements the `ai:VectorStore` interface, enabling PostgreSQL with the pgvector extension to serve as the vector database backend for Ballerina RAG workflows. pgvector adds native vector similarity search to PostgreSQL, making it possible to store embeddings alongside structured data in an existing PostgreSQL database — without introducing a separate vector database service.

This approach is especially practical for teams that already operate PostgreSQL in production: vector search, transactional data, and metadata can coexist in the same database, simplifying infrastructure. The `pgvector:VectorStore` accepts standard PostgreSQL connection parameters (`host`, `user`, `password`, `database`) and a table name; the table is created automatically on first use.

This example demonstrates a complete RAG workflow using pgvector: ingesting a Markdown leave policy document into a PostgreSQL table and answering a question about year-end leave encashment from the indexed content.

> Note: This example uses the default embedding provider and model provider. Set `dbHost`, `dbUser`, `dbPassword`, and `dbName` in the `Config.toml` file with your PostgreSQL connection details. Ensure the pgvector extension is installed (`CREATE EXTENSION IF NOT EXISTS vector;`). To configure the WSO2 default provider, open the VS Code command palette and run the `Configure default WSO2 Model Provider` command.

For more information on the underlying module, see the [`ballerinax/ai.pgvector` module](https://central.ballerina.io/ballerinax/ai.pgvector/latest).

::: code rag_with_pgvector.bal :::

::: out rag_with_pgvector.out :::

## Related links
- [Sample policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-with-pgvector/leave_policy.md)
- [RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [RAG with Weaviate example](/learn/by-example/rag-with-weaviate/)
- [RAG with Milvus example](/learn/by-example/rag-with-milvus/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [pgvector documentation](https://github.com/pgvector/pgvector)
